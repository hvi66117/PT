//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
// 
// File:	KLuaScript.cpp
// Date:	2001-9-13 10:33:29
// Code:	Romandou
// Desc:	
//---------------------------------------------------------------------------
#include "KWin32.h"
#include "KDebug.h"
#include "KPakFile.h"
#include "KLuaScript.h"
#include "LuaLib.h"
#include "KMemClass.h"
#include <map>
#include <set>
#include <string>
#include <vector>

// VNG's later Phong Than scripts use Lua 5-style require/module helpers, but
// this engine embeds Lua 4. Every gameplay script owns a separate Lua state,
// so required modules must execute inside that same state.
struct KVngRequireFrame
{
	int m_nCallerGlobalsRef;
	int m_nModuleRef;

	KVngRequireFrame()
	{
		m_nCallerGlobalsRef = -1;
		m_nModuleRef = -1;
	}
};

struct KVngRequireState
{
	std::map<std::string, int> m_LoadedModules;
	std::set<std::string> m_LoadingModules;
	std::vector<KVngRequireFrame> m_Frames;
};

static std::map<Lua_State *, KVngRequireState> g_VngRequireStates;

static void VngCopyLuaTable(Lua_State * L, int nSource, int nDestination)
{
	int nOldTop = lua_gettop(L);
	lua_pushnil(L);
	while (lua_next(L, nSource))
	{
		// lua_next leaves key/value on the stack. Copy both because rawset
		// consumes its key/value, then retain the original key for lua_next.
		lua_pushvalue(L, -2);
		lua_pushvalue(L, -2);
		lua_rawset(L, nDestination);
		lua_pop(L, 1);
	}
	lua_settop(L, nOldTop);
}

static void VngSetTableString(Lua_State * L, int nTable, const char * pszKey,
	const char * pszValue)
{
	lua_pushstring(L, pszKey);
	lua_pushstring(L, pszValue ? pszValue : "");
	lua_rawset(L, nTable);
}

static void VngSetTableValue(Lua_State * L, int nTable, const char * pszKey,
	int nValue)
{
	lua_pushstring(L, pszKey);
	lua_pushvalue(L, nValue);
	lua_rawset(L, nTable);
}

static void VngRestoreGlobals(Lua_State * L, int nGlobalsRef)
{
	if (nGlobalsRef >= 0 && lua_getref(L, nGlobalsRef))
		lua_setglobals(L);
}

static void VngResetRequireState(Lua_State * L)
{
	std::map<Lua_State *, KVngRequireState>::iterator it =
		g_VngRequireStates.find(L);
	if (it == g_VngRequireStates.end())
		return;
	for (std::map<std::string, int>::iterator module =
		it->second.m_LoadedModules.begin();
		module != it->second.m_LoadedModules.end(); ++module)
	{
		if (module->second >= 0)
			lua_unref(L, module->second);
	}
	g_VngRequireStates.erase(it);
}

static BOOL VngNormalizeModuleName(const char * pszInput, std::string & ModuleName,
	std::string & CacheKey)
{
	if (!pszInput || !pszInput[0])
		return FALSE;
	ModuleName = pszInput;
	if (ModuleName.length() > MAX_PATH - 24 || ModuleName[0] == '\\' ||
		ModuleName[0] == '/' || ModuleName.find(':') != std::string::npos)
		return FALSE;
	for (std::string::size_type i = 0; i < ModuleName.length(); ++i)
	{
		if (ModuleName[i] == '/')
			ModuleName[i] = '\\';
	}
	if (ModuleName.find("\\\\") != std::string::npos ||
		ModuleName.find(".\\") == 0 ||
		ModuleName.find("\\.\\") != std::string::npos ||
		ModuleName.find("\\..\\") != std::string::npos ||
		ModuleName.find("..\\") == 0)
		return FALSE;
	if (ModuleName.length() < 5 ||
		_stricmp(ModuleName.c_str() + ModuleName.length() - 5, ".luax") != 0)
		return FALSE;
	CacheKey = ModuleName;
	for (std::string::size_type j = 0; j < CacheKey.length(); ++j)
	{
		if (CacheKey[j] >= 'A' && CacheKey[j] <= 'Z')
			CacheKey[j] = (char)(CacheKey[j] + ('a' - 'A'));
	}
	return TRUE;
}

static BOOL VngLuaIdentifierStart(unsigned char c)
{
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '_';
}

static BOOL VngLuaIdentifierPart(unsigned char c)
{
	return VngLuaIdentifierStart(c) || (c >= '0' && c <= '9');
}

static int VngReplaceLuaSource(std::string & Source, const char * pszNeedle,
	const char * pszReplacement)
{
	if (!pszNeedle || !pszNeedle[0] || !pszReplacement)
		return 0;
	int nReplacements = 0;
	std::string::size_type nPosition = 0;
	const std::string::size_type nNeedleLength = strlen(pszNeedle);
	const std::string::size_type nReplacementLength = strlen(pszReplacement);
	while ((nPosition = Source.find(pszNeedle, nPosition)) !=
		std::string::npos)
	{
		Source.replace(nPosition, nNeedleLength, pszReplacement);
		nPosition += nReplacementLength;
		++nReplacements;
	}
	return nReplacements;
}

static size_t VngScanLuaQuoted(const char * pszSource, size_t nSize, size_t nStart,
	char cQuote)
{
	size_t i = nStart + 1;
	while (i < nSize)
	{
		unsigned char c = (unsigned char)pszSource[i];
		if (c == '\\' && i + 1 < nSize)
		{
			i += 2;
			continue;
		}
		++i;
		if (c == (unsigned char)cQuote)
			break;
	}
	return i;
}

static size_t VngScanLuaBracket(const char * pszSource, size_t nSize, size_t nStart)
{
	int nDepth = 1;
	size_t i = nStart + 1;
	while (i < nSize && nDepth > 0)
	{
		unsigned char c = (unsigned char)pszSource[i];
		if (c == '\'' || c == '"')
		{
			i = VngScanLuaQuoted(pszSource, nSize, i, (char)c);
			continue;
		}
		if (c == '[')
			++nDepth;
		else if (c == ']')
			--nDepth;
		++i;
	}
	return nDepth == 0 ? i : nStart;
}

static int VngConvertLua5LengthOperators(const char * pszSource, size_t nSize,
	std::string & Converted)
{
	Converted.erase();
	Converted.reserve(nSize + 64);
	int nConversions = 0;
	size_t i = 0;
	while (i < nSize)
	{
		unsigned char c = (unsigned char)pszSource[i];
		if (c == '\'' || c == '"')
		{
			size_t nEnd = VngScanLuaQuoted(pszSource, nSize, i, (char)c);
			Converted.append(pszSource + i, nEnd - i);
			i = nEnd;
			continue;
		}
		if (c == '-' && i + 1 < nSize && pszSource[i + 1] == '-')
		{
			size_t nEnd = i + 2;
			if (nEnd + 1 < nSize && pszSource[nEnd] == '[' &&
				pszSource[nEnd + 1] == '[')
			{
				nEnd += 2;
				while (nEnd + 1 < nSize &&
					!(pszSource[nEnd] == ']' && pszSource[nEnd + 1] == ']'))
					++nEnd;
				if (nEnd + 1 < nSize)
					nEnd += 2;
			}
			else
			{
				while (nEnd < nSize && pszSource[nEnd] != '\r' &&
					pszSource[nEnd] != '\n')
					++nEnd;
			}
			Converted.append(pszSource + i, nEnd - i);
			i = nEnd;
			continue;
		}
		if (c == '[' && i + 1 < nSize && pszSource[i + 1] == '[')
		{
			size_t nEnd = i + 2;
			while (nEnd + 1 < nSize &&
				!(pszSource[nEnd] == ']' && pszSource[nEnd + 1] == ']'))
				++nEnd;
			if (nEnd + 1 < nSize)
				nEnd += 2;
			Converted.append(pszSource + i, nEnd - i);
			i = nEnd;
			continue;
		}
		if (c == '#')
		{
			size_t nExpression = i + 1;
			while (nExpression < nSize &&
				(pszSource[nExpression] == ' ' || pszSource[nExpression] == '\t'))
				++nExpression;
			if (nExpression < nSize &&
				VngLuaIdentifierStart((unsigned char)pszSource[nExpression]))
			{
				size_t nEnd = nExpression + 1;
				while (nEnd < nSize &&
					VngLuaIdentifierPart((unsigned char)pszSource[nEnd]))
					++nEnd;
				while (nEnd < nSize)
				{
					if (pszSource[nEnd] == '.' && nEnd + 1 < nSize &&
						VngLuaIdentifierStart((unsigned char)pszSource[nEnd + 1]))
					{
						nEnd += 2;
						while (nEnd < nSize &&
							VngLuaIdentifierPart((unsigned char)pszSource[nEnd]))
							++nEnd;
						continue;
					}
					if (pszSource[nEnd] == '[')
					{
						size_t nBracketEnd = VngScanLuaBracket(pszSource, nSize, nEnd);
						if (nBracketEnd == nEnd)
							break;
						nEnd = nBracketEnd;
						continue;
					}
					break;
				}
				Converted.append("getn(");
				Converted.append(pszSource + nExpression, nEnd - nExpression);
				Converted += ')';
				i = nEnd;
				++nConversions;
				continue;
			}
		}
		Converted += (char)c;
		++i;
	}

	// Lua 4 supports nested functions but not lexical upvalues. VNG's common
	// module has one synchronous punctuation helper that captures two locals.
	// Keep the PAK payload immutable and adapt that exact construct in memory.
	nConversions += VngReplaceLuaSource(Converted,
		"    local msg = \"\"\r\n"
		"    local flag = 0\r\n"
		"    local Punc = function()",
		"    msg = \"\"\r\n"
		"    flag = 0\r\n"
		"    function Punc()");
	// Lua 4 separates the positional and record portions of a constructor
	// with a semicolon. This is the only such transition in the 41-module
	// VNG dependency closure; record-to-record commas remain untouched.
	nConversions += VngReplaceLuaSource(Converted, "}, mapid =", "}; mapid =");
	return nConversions;
}

static int LuaVngPackageSeeAll(Lua_State * L)
{
	// module() performs the Lua 4-compatible environment copy itself.
	return 0;
}

static int LuaVngTableIterator(Lua_State * L)
{
	if (lua_gettop(L) < 1 || !lua_istable(L, 1))
	{
		lua_error(L, "pairs/ipairs expects a table");
		return 0;
	}
	// Lua 4's `for key,value in expression do` iterates a table directly.
	// Therefore the Lua 5 pairs/ipairs compatibility result is the table,
	// rather than the iterator/state/control triple introduced by Lua 5.
	lua_pushvalue(L, 1);
	return 1;
}

static int LuaVngModule(Lua_State * L)
{
	if (lua_gettop(L) < 1 || !lua_isstring(L, 1))
	{
		lua_error(L, "module expects a module name");
		return 0;
	}
	std::map<Lua_State *, KVngRequireState>::iterator stateIt =
		g_VngRequireStates.find(L);
	if (stateIt == g_VngRequireStates.end() ||
		stateIt->second.m_Frames.empty())
	{
		lua_error(L, "module may only be used by require");
		return 0;
	}

	KVngRequireFrame & Frame = stateIt->second.m_Frames.back();
	if (Frame.m_nModuleRef >= 0)
	{
		lua_error(L, "a required file may declare only one module");
		return 0;
	}
	const char * pszName = lua_tostring(L, 1);
	int nOldTop = lua_gettop(L);
	if (!lua_getref(L, Frame.m_nCallerGlobalsRef))
	{
		lua_error(L, "require caller environment is unavailable");
		return 0;
	}
	int nCaller = lua_gettop(L);
	lua_newtable(L);
	int nModule = lua_gettop(L);

	// Lua 4 has one global table per state rather than one environment per
	// function. Seed the module table with the caller environment while the
	// unmodified VNG module is evaluated.
	VngCopyLuaTable(L, nCaller, nModule);
	VngSetTableString(L, nModule, "_NAME", pszName);
	VngSetTableValue(L, nModule, "_M", nModule);
	const char * pszDot = strrchr(pszName, '.');
	std::string PackageName;
	if (pszDot)
		PackageName.assign(pszName, pszDot - pszName + 1);
	VngSetTableString(L, nModule, "_PACKAGE", PackageName.c_str());
	VngSetTableValue(L, nCaller, pszName, nModule);
	lua_pushvalue(L, nModule);
	Frame.m_nModuleRef = lua_ref(L, 1);
	lua_pushvalue(L, nModule);
	lua_setglobals(L);
	lua_settop(L, nOldTop);
	return 0;
}

static int LuaVngRequire(Lua_State * L)
{
	if (lua_gettop(L) < 1 || !lua_isstring(L, 1))
	{
		lua_error(L, "require expects a .luax module name");
		return 0;
	}
	std::string ModuleName;
	std::string CacheKey;
	if (!VngNormalizeModuleName(lua_tostring(L, 1), ModuleName, CacheKey))
	{
		lua_error(L, "require rejected an unsafe module path");
		return 0;
	}

	KVngRequireState & State = g_VngRequireStates[L];
	std::map<std::string, int>::iterator loaded =
		State.m_LoadedModules.find(CacheKey);
	if (loaded != State.m_LoadedModules.end())
	{
		if (loaded->second >= 0 && lua_getref(L, loaded->second))
			return 1;
		lua_pushnumber(L, 1);
		return 1;
	}
	if (State.m_LoadingModules.find(CacheKey) != State.m_LoadingModules.end())
	{
		lua_error(L, "circular .luax dependency detected");
		return 0;
	}

	int nInitialTop = lua_gettop(L);
	lua_getglobals(L);
	KVngRequireFrame Frame;
	Frame.m_nCallerGlobalsRef = lua_ref(L, 1);
	State.m_Frames.push_back(Frame);
	State.m_LoadingModules.insert(CacheKey);

	char szModulePath[MAX_PATH];
	sprintf(szModulePath, "\\script\\common\\%s", ModuleName.c_str());
	KPakFile File;
	DWORD dwSize = 0;
	KMemClass Memory;
	std::string CompatibleSource;
	int nStatus = -1;
	if (File.Open(szModulePath))
	{
		dwSize = File.Size();
		if (dwSize > 0 && Memory.Alloc(dwSize + 1) &&
			File.Read(Memory.GetMemPtr(), dwSize) == dwSize)
		{
			const char * pszSource = (char *)Memory.GetMemPtr();
			int nLengthConversions = VngConvertLua5LengthOperators(
				pszSource, dwSize, CompatibleSource);
			if (nLengthConversions > 0)
				nStatus = Lua_ExecuteBuffer(L, CompatibleSource.data(),
					CompatibleSource.length(), szModulePath);
			else
				nStatus = Lua_ExecuteBuffer(L, pszSource, dwSize, szModulePath);
		}
		File.Close();
	}

	int nModuleRef = State.m_Frames.back().m_nModuleRef;
	int nCallerRef = State.m_Frames.back().m_nCallerGlobalsRef;
	if (nStatus == 0 && nModuleRef >= 0)
	{
		int nCopyTop = lua_gettop(L);
		if (lua_getref(L, nModuleRef))
		{
			int nModule = lua_gettop(L);
			if (lua_getref(L, nCallerRef))
			{
				int nCaller = lua_gettop(L);
				// Export module members before restoring the caller's single Lua 4
				// global table. Each gameplay script has an isolated state.
				VngCopyLuaTable(L, nModule, nCaller);
			}
		}
		lua_settop(L, nCopyTop);
	}
	VngRestoreGlobals(L, nCallerRef);
	State.m_Frames.pop_back();
	State.m_LoadingModules.erase(CacheKey);
	lua_unref(L, nCallerRef);
	lua_settop(L, nInitialTop);

	if (nStatus != 0)
	{
		if (nModuleRef >= 0)
			lua_unref(L, nModuleRef);
		char szError[320];
		sprintf(szError, "require failed for %s (status=%d)", szModulePath,
			nStatus);
		g_DebugLog("[LuaRequire] %s", szError);
		lua_error(L, szError);
		return 0;
	}

	State.m_LoadedModules[CacheKey] = nModuleRef;
	if (nModuleRef >= 0 && lua_getref(L, nModuleRef))
		return 1;
	lua_pushnumber(L, 1);
	return 1;
}
//---------------------------------------------------------------------------
// ����:	KLuaScript::KLuaScript
// ����:	
// ����:	void
// ����:	
//---------------------------------------------------------------------------
KLuaScript::KLuaScript(void)
{
	m_LuaState					= lua_open(100);

	if (m_LuaState == NULL)
	{
		ScriptError(LUA_CREATE_ERROR);
		m_IsRuning			= FALSE;
		return ;
	}

	m_IsRuning				= TRUE;
	m_szScriptName[0]		= '\0';
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::KLuaScript
// ����:	
// ����:	int StackSize
// ����:	
//---------------------------------------------------------------------------
KLuaScript::KLuaScript(int StackSize)
{
	m_LuaState				= Lua_Create(StackSize);

	if (m_LuaState == NULL )
	{
		ScriptError(LUA_CREATE_ERROR);
		m_IsRuning = FALSE;
		return ;
	}
	m_IsRuning				= TRUE;
	m_szScriptName[0]		= '\0';
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::~KLuaScript
// ����:	
// ����:	void
// ����:	
//---------------------------------------------------------------------------
KLuaScript::~KLuaScript(void)
{
	Exit();
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::LoadBuffer()
// ����:	
// ����:	PBYTE pBuffer
// ����:	DWORD dwLen
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::LoadBuffer(PBYTE pBuffer, DWORD dwLen )
{
	if (dwLen < 0)	
	{
		ScriptError(LUA_SCRIPT_LEN_ERROR);
		return FALSE;
	}
	
	if (Lua_CompileBuffer(m_LuaState, (char *) pBuffer, dwLen, NULL) != 0)
	{
		ScriptError(LUA_SCRIPT_COMPILE_ERROR);
		return FALSE;
	}
	return TRUE;
}
//---------------------------------------------------------------------------
// ����:	KLuaScript::Load
// ����:	
// ����:	LPSTR Filename
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Load(char * Filename)
{
	KPakFile	File;
	DWORD		Size;

	
	// open file
	if (!File.Open(Filename))
	{
	printf("Can't open scriptfile %s", Filename);
	return FALSE;
	}
	
	// get file size
	Size = File.Size();
	
	KMemClass Memory;
	// alloc memory
	if (! Memory.Alloc(Size + 4))
	{
	printf("Can't alloc scriptsize %s[%lu]", Filename, Size);
	return FALSE;
	}
	
	// read file
	if (File.Read(Memory.GetMemPtr(), Size) != Size)
	{
	printf("Can't read scriptfile %s", Filename);
	return FALSE;
	}
	char * pszMem = (char *)Memory.GetMemPtr();
	pszMem[Size + 1] = 0;
	
	File.Close();
	try
	{
		if (!LoadBuffer((PBYTE)Memory.GetMemPtr(), Size ))
		{
			ScriptError(LUA_SCRIPT_COMPILE_ERROR);
			printf("Can't loadbuffer scriptfile %s", Filename);
			return FALSE;
		}
	}
	catch(...)
	{
		printf("Load script %s loi khong xac dinh\n", Filename);
		return FALSE;
	}
		
	if (!ExecuteCode())
	{
		printf("Can't executecode %s\n", Filename);
		return FALSE;
	}
	
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::Execute
// ����:	
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Execute()
{
	if (m_IsRuning && m_LuaState)
	return CallFunction(MAINFUNCTIONNAME,0,"");
	
	return FALSE;
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::ExecuteCode
// ����:	
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::ExecuteCode()
{
	if (!(m_IsRuning && m_LuaState))
	{
		ScriptError(LUA_SCRIPT_EXECUTE_ERROR);
		//if (!ExecuteCode()) return FALSE; ZHANGPENG ������������д�
		return FALSE;
	}
	
	int state;
	if (state = Lua_Execute(m_LuaState) != 0)
	{
		ScriptError(LUA_SCRIPT_EXECUTE_ERROR, state);
		return FALSE;
	}
	//Lua_Execute(m_LuaState);

	return	TRUE;
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::CallFunction
// ����:	����Lua�ű��ڵĺ���
// ����:	LPSTR cFuncName
// ����:	int nResults
// ����:	LPSTR cFormat  ����ʱ�������������� 
//			n:������(double) d:����(int) s:�ַ����� f:C������  n:Nil v:Value p:Point
//        v��ΪLua֧�ֵģ�����Ϊ���ε���index��ָ����index��ָ��ջ�ı�����Ϊ
//			 �ú����ĵ��ò�����
//	ע�⣺���ڸú����в���������,�������֣�ϵͳ����ȷ��������double������int
//  ���ڣ����ֱ�����ʽ�ǲ�ͬ�ġ������Ҫע�⵱�������������ʱ����ʽ��Ӧ��d
//  ��������n,����ǿ�иı�Ϊdouble�Ρ��������ּ���Ĵ���
//   
// ����:	...
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::CallFunction(LPSTR cFuncName, int nResults, LPSTR cFormat, va_list vlist)
{
	
	double nNumber;
	char * cString	= NULL;
	void * pPoint	= NULL;
	Lua_CFunction CFunc;
	int i=0;
	int nArgnum = 0;
	int nIndex = 0;
	int nRetcode;		//���ýű�������ķ�����

	if (! (m_IsRuning && m_LuaState))
	{
		ScriptError(LUA_SCRIPT_STATES_IS_NULL);
		return FALSE;
	}
	
	{
		Lua_GetGlobal(m_LuaState, cFuncName); //�ڶ�ջ�м�����Ҫ���õĺ�����

		while (cFormat[i] != '\0')
		{
			switch(cFormat[i])
			{
			case 'n'://�����������double�� NUMBER��Lua��˵��Double��
				{ 
					nNumber = va_arg(vlist, double );
					Lua_PushNumber(m_LuaState, nNumber);
					nArgnum ++;							

				}
				break;
			
			case 'd'://���������Ϊ����
				{
					nNumber = (double)(va_arg(vlist, int));
					Lua_PushNumber(m_LuaState, (double) nNumber);
					nArgnum ++;
				}
				break;
				
			case 's'://�ַ�����
				{
					cString = va_arg(vlist, char *);
					Lua_PushString(m_LuaState, cString);
					nArgnum ++;							
				}
				break;
			case 'N'://NULL
				{
					Lua_PushNil(m_LuaState);
					nArgnum ++;
				}
				break;
			
			case 'f'://�������CFun�Σ����ڲ�������
				{
					CFunc = va_arg(vlist, Lua_CFunction);
					Lua_PushCFunction(m_LuaState, CFunc) ;
					nArgnum ++;
				}
				break;
			
			case 'v'://������Ƕ�ջ��IndexΪnIndex����������
				{
					nNumber = va_arg(vlist, int);
					int nIndex1 = (int) nNumber;
					Lua_PushValue(m_LuaState, nIndex1);
					nArgnum ++;
				}
				break;
			case 't'://����ΪһTable����
				{
					
					

				}
				break;
			
			case 'p':
				{
					pPoint = va_arg(vlist, void *);

					Lua_PushUserTag(m_LuaState, pPoint,m_UserTag);
					nArgnum ++;
				}
				break;
			}
				
			i++;	
		}
		
	}  
    		
	nRetcode = Lua_Call(m_LuaState, nArgnum, nResults);
	
	if (nRetcode != 0)
	{
		ScriptError(LUA_SCRIPT_EXECUTE_ERROR, nRetcode);
		return FALSE;
	}
	

	return	TRUE;
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::CallFunction
// ����:	
// ����:	LPSTR cFuncName
// ����:	int nResults
// ����:	LPSTR cFormat
// ����:	...
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::CallFunction(LPSTR cFuncName, int nResults, LPSTR cFormat, ...)
{
	BOOL bResult  = FALSE;
	va_list vlist;
	va_start(vlist, cFormat);
	bResult = CallFunction(cFuncName, nResults, cFormat, vlist);
	va_end(vlist);
	return bResult;
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::GetValuesFromStack
// ����:	�Ӷ�ջ�л�ñ���
// ����:	char * cFormat
// ����:	...
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::GetValuesFromStack(char * cFormat, ...)	
{
	va_list vlist;
	double* pNumber = NULL;
	const char **   pString ;
	int * pInt = NULL;
	int i = 0;
	int nTopIndex = 0;
	int nIndex = 0;
	int nValueNum = 0;//cFormat���ַ����ȣ���ʾ��Ҫȡ�Ĳ�������

	if (! m_LuaState)
		return FALSE;

	nTopIndex = Lua_GetTopIndex(m_LuaState);	
	nValueNum = strlen(cFormat);
	
	if (nTopIndex == 0 || nValueNum == 0)//����ջ�������ݻ�ȡ�����Ƿ���FALSE
		return FALSE;

	if (nTopIndex < nValueNum)
		return FALSE;

	nIndex = nTopIndex - nValueNum +1;
	
	{
		va_start(vlist, cFormat);     
		
		while (cFormat[i] != '\0')
		{
			
			switch(cFormat[i])
			{
			case 'n'://����ֵΪ��ֵ��,Number,��ʱLuaֻ����double�ε�ֵ
				{
					pNumber = va_arg(vlist, double *);
					
					if (pNumber == NULL)
						return FALSE;

					if (Lua_IsNumber(m_LuaState, nIndex ))
					{
						* pNumber = Lua_ValueToNumber(m_LuaState, nIndex ++ );
												
					}
					else
					{
						ScriptError(LUA_SCRIPT_NOT_NUMBER_ERROR);
						return FALSE;
					}
					
					
				}
				break;
			case 'd':
				{
					pInt = va_arg(vlist, int *);
					if (pInt == NULL)
						return FALSE;
					if ( Lua_IsNumber(m_LuaState, nIndex))
					{
						* pInt = (int ) Lua_ValueToNumber(m_LuaState, nIndex ++);
					}
					else
					{
						ScriptError(LUA_SCRIPT_NOT_NUMBER_ERROR);
						return FALSE;
					}

				}
				break;
			case 's'://�ַ�����
				{
					pString = va_arg(vlist, const char **);
					
					if (pString == NULL)
						return FALSE;
					
					if (Lua_IsString(m_LuaState, nIndex))
					{
						(*pString) = (const char *)Lua_ValueToString(m_LuaState, nIndex++);
						
					}
					else
					{
						ScriptError(LUA_SCRIPT_NOT_STRING_ERROR);
						return FALSE;
					}
				}
				break;
			
			}
			
			
		i ++;	
		}
		va_end(vlist);     		/* Reset variable arguments.      */
		
	}
	return	TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::Init
// ����:	��ʼ���ű�����ע��ϵͳ��׼������
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Init()
{
	VngResetRequireState(m_LuaState);
	if (! m_LuaState)
	{
		m_LuaState				= Lua_Create(0);
		
		if (m_LuaState == NULL)
		{
			ScriptError(LUA_CREATE_ERROR);
			m_IsRuning			= FALSE;
			return FALSE;
		}
		
		m_IsRuning				= TRUE;
		m_szScriptName[0]		= '\0';
		m_UserTag = lua_newtag(m_LuaState)	;
	}
	
	RegisterStandardFunctions();
	return	TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::RegisterFunction
// ����:	ע��ĳ�ڲ�C�������ű���
// ����:	LPSTR FuncName  �ڽű���ʹ�õĺ�����
// ����:	void* Func    ʵ����Ӧ��C����ָ��
// ����:	int Args = 0 //��KScript�ӿ����ݣ�����
// ����:	int Flag = 0 //��KScript�ӿ�����, ����
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::RegisterFunction(LPSTR FuncName , void* Func)
{
	if (! m_LuaState)
		return FALSE;
	Lua_Register(m_LuaState, FuncName, (Lua_CFunction)Func);
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::Compile
// ����:	
// ����:	char *
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Compile(char *)
{
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::RegisterFunctions
// ����:	����ע��Lua���ڲ�C������������������Ϣ������TLua_Funcs��������
// ����:	TLua_Funcs *Funcs �����ָ��
// ����:	int n ��������������Ϊ�㣬��ϵͳ����õ���
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::RegisterFunctions(TLua_Funcs Funcs[], int n)
{
	if (! m_LuaState)	return FALSE;
	if (n == 0)	n = sizeof(Funcs) / sizeof(Funcs[0]);
	for (int i = 0; i < n; i ++)	Lua_Register(m_LuaState, Funcs[i].name, Funcs[i].func);
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::RegisterStandardFunctions
// ����:	ע��Luaϵͳ��׼�ĺ�����
// ����:	void 
//---------------------------------------------------------------------------
void KLuaScript::RegisterStandardFunctions()
{
	if (! m_LuaState)		return ;
	Lua_OpenBaseLib(m_LuaState);//Lua������
	Lua_OpenIOLib(m_LuaState);//���������
	Lua_OpenStrLib(m_LuaState);//�ַ���������
	Lua_OpenMathLib(m_LuaState);//��ֵ�����
	Lua_Register(m_LuaState, "require", LuaVngRequire);
	Lua_Register(m_LuaState, "module", LuaVngModule);
	Lua_Register(m_LuaState, "pairs", LuaVngTableIterator);
	Lua_Register(m_LuaState, "ipairs", LuaVngTableIterator);
	Lua_NewTable(m_LuaState);
	int nPackage = Lua_GetTopIndex(m_LuaState);
	Lua_PushString(m_LuaState, "seeall");
	Lua_PushCFunction(m_LuaState, LuaVngPackageSeeAll);
	Lua_RawSet(m_LuaState, nPackage);
	Lua_SetGlobal(m_LuaState, "package");
	Lua_GetGlobals(m_LuaState);
	Lua_SetGlobal(m_LuaState, "_G");
	// Lua 4.0 exposes these functions as globals, while the VNG scripts in
	// MagicScript use the later table/string/math namespaces.  Create only
	// aliases that are byte-for-byte equivalent to the Lua 4.0 functions;
	// do not emulate missing gameplay APIs here.
	static const char * s_szVngLibraryCompat =
		"if table == nil then table = {} end\n"
		"table.getn = getn\n"
		"table.insert = tinsert\n"
		"table.remove = tremove\n"
		"table.sort = sort\n"
		"if string == nil then string = {} end\n"
		"string.len = strlen\n"
		"string.format = format\n"
		"string.find = strfind\n"
		"string.sub = strsub\n"
		"if math == nil then math = {} end\n"
		"math.random = random\n"
		"math.randomseed = randomseed\n"
		"math.floor = floor\n"
		"math.mod = mod\n"
		"math.abs = abs\n"
		"math.min = min\n"
		"math.max = max\n"
		"math.sqrt = sqrt\n";
	if (Lua_ExecuteString(m_LuaState, s_szVngLibraryCompat) != 0)
	{
		ScriptError(LUA_SCRIPT_EXECUTE_ERROR);
	}
	//Lua_OpenDBLib(m_LuaState);//���Կ�
	return;	
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::ReleaseScript
// ����:	�ͷŸýű���Դ��
// ����:	BOOL 
//---------------------------------------------------------------------------
void KLuaScript::Exit()
{
	
	if (! m_LuaState)		return ;
	VngResetRequireState(m_LuaState);
	Lua_Release(m_LuaState);
	m_LuaState = NULL;
	m_IsRuning = FALSE;
	
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::ScriptError
// ����:	
// ����:	int Error
// ����:	void 
//---------------------------------------------------------------------------
void KLuaScript::ScriptError(int Error)
{
	char lszErrMsg[200];
	sprintf(lszErrMsg, "ScriptError %d. (%s) \n", Error, m_szScriptName);
	lua_outerrmsg(lszErrMsg);
	return;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::ScriptError
// ����:	
// ����:	int Error1
// ����:	int Error2
// ����:	void 
//---------------------------------------------------------------------------
void KLuaScript::ScriptError(int Error1 ,int Error2)
{
	char lszErrMsg[200];
	sprintf(lszErrMsg, "ScriptError %d:[%d] (%s) \n", Error1, Error2, m_szScriptName);
	lua_outerrmsg(lszErrMsg);
	return;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::SafeCallBegin
// ����:	
// ����:	int * pIndex
// ����:	void 
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// SafeCallBegin��SafeCallEnd������Ӧ����ʹ�ã��Է�ֹ�ڵ���Lua���ⲿ����֮��
//�ж��������ڶ�ջ��δ��������ﵽ����ǰ����ú��ջ��ռ�ô�С���䡣
//�������ֻ�����ڵ����ⲿ����ʱ���ڲ�����������˴�����
//																	Romandou
//---------------------------------------------------------------------------
void KLuaScript::SafeCallBegin(int * pIndex)
{
	if (! m_LuaState)		return ;
	Lua_SafeBegin(m_LuaState, pIndex);
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::SafeCallEnd
// ����:	
// ����:	int nIndex
// ����:	void 
//---------------------------------------------------------------------------
void KLuaScript::SafeCallEnd(int nIndex)
{
	if (! m_LuaState)	return;
	Lua_SafeEnd(m_LuaState, nIndex);
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::StopScript
// ����:	��ֹ�ű�
// ����:	void
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Stop(void)
{
	if (! m_IsRuning)		return TRUE;
	if (! m_LuaState)		return FALSE;
	m_IsRuning =  FALSE;
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::ResumeScript
// ����:	�ָ�����ֹ�Ľű�
// ����:	void
// ����:	BOOL 
//---------------------------------------------------------------------------
BOOL KLuaScript::Resume(void)
{
	if ((! m_IsRuning) && (m_LuaState))
	{
		m_IsRuning = TRUE;
		return TRUE;
	}
	return FALSE;
}


//---------------------------------------------------------------------------
// ����:	KLuaScript::CreateTable
// ����:	����һ��Lua��Table���ڵ��øú���������Table������Ա֮�󣬱������
//			SetGlobalName()�������Tableָ��һ�����֡�
// ����:	DWORD 
//---------------------------------------------------------------------------
DWORD KLuaScript::CreateTable()
{
	 int nIndex = 0;
	
	nIndex = Lua_GetTopIndex(m_LuaState) ;
	Lua_NewTable(m_LuaState);
	if (Lua_GetTopIndex(m_LuaState) != ++nIndex ) 
		return -1;

	return nIndex;
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::SetGlobalName
// ����:	����Lua��ջ����������һ������
// ����:	LPSTR szName
// ����:	void 
//---------------------------------------------------------------------------
void KLuaScript::SetGlobalName(LPSTR szName)
{
	if (!szName) return ;
	Lua_SetGlobal(m_LuaState, szName);
}

//---------------------------------------------------------------------------
// ����:	KLuaScript::ModifyTable
// ����:	��ָ�����Ƶ�LuaTable�ö�ջ���ˣ������ض���Index
// ����:	LPSTR szTableName
// ����:	DWORD ��Lua�в����ڸ�Table�򷵻�-1
//---------------------------------------------------------------------------
DWORD KLuaScript::ModifyTable(LPSTR szTableName) 
{
	if (! szTableName[0])		return -1;
	
	int nIndex = Lua_GetTopIndex(m_LuaState);
	
	Lua_GetGlobal(m_LuaState, szTableName);

	if (Lua_GetTopIndex(m_LuaState) != ++nIndex)		return -1;
	
	return nIndex;
}
