#include "stdafx.h"
#include "PhongThanCharacterStore.h"

#include <stdio.h>
#include <string.h>

#ifndef INVALID_FILE_ATTRIBUTES
#define INVALID_FILE_ATTRIBUTES ((DWORD)-1)
#endif

#pragma pack(push, 1)
struct PHONGTHAN_CHARACTER_FILE_HEADER
{
	DWORD Magic;
	WORD FormatVersion;
	WORD HeaderSize;
	DWORD StateSize;
	DWORD Checksum;
};
#pragma pack(pop)

enum
{
	PHONGTHAN_CHARACTER_FILE_MAGIC = 0x43544850, // PHTC
	PHONGTHAN_CHARACTER_FILE_VERSION = 1
};

CPhongThanCharacterStore g_PhongThanCharacterStore;

static DWORD PhongThanCharacterChecksum(const BYTE* pData, DWORD nSize)
{
	DWORD nHash = 2166136261u;
	for (DWORD i = 0; i < nSize; ++i)
	{
		nHash ^= pData[i];
		nHash *= 16777619u;
	}
	return nHash;
}

static bool PhongThanReadAll(HANDLE hFile, void* pData, DWORD nSize)
{
	BYTE* pCurrent = (BYTE*)pData;
	while (nSize)
	{
		DWORD nRead = 0;
		if (!ReadFile(hFile, pCurrent, nSize, &nRead, NULL) || !nRead)
			return false;
		pCurrent += nRead;
		nSize -= nRead;
	}
	return true;
}

static bool PhongThanWriteAll(HANDLE hFile, const void* pData, DWORD nSize)
{
	const BYTE* pCurrent = (const BYTE*)pData;
	while (nSize)
	{
		DWORD nWritten = 0;
		if (!WriteFile(hFile, pCurrent, nSize, &nWritten, NULL) || !nWritten)
			return false;
		pCurrent += nWritten;
		nSize -= nWritten;
	}
	return true;
}

CPhongThanCharacterStore::CPhongThanCharacterStore()
{
	ZeroMemory(m_szRoot, sizeof(m_szRoot));
	InitializeCriticalSection(&m_Lock);
}

CPhongThanCharacterStore::~CPhongThanCharacterStore()
{
	DeleteCriticalSection(&m_Lock);
}

bool CPhongThanCharacterStore::Open(const char* pRootDirectory)
{
	EnterCriticalSection(&m_Lock);
	const char* pRoot = pRootDirectory && pRootDirectory[0] ?
		pRootDirectory : "CharacterStore";
	const size_t nLength = strlen(pRoot);
	bool bResult = nLength < sizeof(m_szRoot);
	if (bResult)
	{
		strcpy(m_szRoot, pRoot);
		bResult = EnsureRoot();
	}
	LeaveCriticalSection(&m_Lock);
	return bResult;
}

bool CPhongThanCharacterStore::EnsureRoot()
{
	if (!m_szRoot[0])
		strcpy(m_szRoot, "CharacterStore");
	const DWORD nAttributes = GetFileAttributesA(m_szRoot);
	if (nAttributes != INVALID_FILE_ATTRIBUTES)
		return (nAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0;
	return CreateDirectoryA(m_szRoot, NULL) != FALSE ||
		GetLastError() == ERROR_ALREADY_EXISTS;
}

bool CPhongThanCharacterStore::BuildRolePath(const char* pRoleName,
	char* pOutput, size_t nCapacity) const
{
	if (!pRoleName || !pRoleName[0] || !pOutput || !nCapacity)
		return false;
	const size_t nNameLength = strlen(pRoleName);
	if (nNameLength >= 32)
		return false;
	char szHex[32 * 2 + 1];
	for (size_t i = 0; i < nNameLength; ++i)
	{
		unsigned char c = (unsigned char)pRoleName[i];
		if (c >= 'A' && c <= 'Z')
			c = (unsigned char)(c - 'A' + 'a');
		sprintf(szHex + i * 2, "%02x", (unsigned int)c);
	}
	szHex[nNameLength * 2] = 0;
	const int nWritten = _snprintf(pOutput, nCapacity,
		"%s\\role_%s.pthc", m_szRoot, szHex);
	if (nWritten < 0 || (size_t)nWritten >= nCapacity)
	{
		pOutput[0] = 0;
		return false;
	}
	return true;
}

bool CPhongThanCharacterStore::LoadPathUnlocked(const char* pPath,
	BYTE* pOutput, PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize)
{
	if (pStateSize)
		*pStateSize = 0;
	if (!pPath || !pOutput || !pStateSize || !EnsureRoot())
		return false;
	HANDLE hFile = CreateFileA(pPath, GENERIC_READ, FILE_SHARE_READ,
		NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
		return false;

	PHONGTHAN_CHARACTER_FILE_HEADER Header;
	ZeroMemory(&Header, sizeof(Header));
	const DWORD nFileSize = GetFileSize(hFile, NULL);
	bool bResult = nFileSize != INVALID_FILE_SIZE &&
		nFileSize >= sizeof(Header) &&
		PhongThanReadAll(hFile, &Header, sizeof(Header)) &&
		Header.Magic == PHONGTHAN_CHARACTER_FILE_MAGIC &&
		Header.FormatVersion == PHONGTHAN_CHARACTER_FILE_VERSION &&
		Header.HeaderSize == sizeof(Header) &&
		Header.StateSize <= nCapacity &&
		Header.StateSize <= PHONGTHAN_CHARACTER_MAX_STATE_SIZE &&
		nFileSize == sizeof(Header) + Header.StateSize &&
		PhongThanReadAll(hFile, pOutput, Header.StateSize);
	CloseHandle(hFile);
	if (!bResult ||
		PhongThanCharacterChecksum(pOutput, Header.StateSize) != Header.Checksum ||
		!PhongThanValidateCharacterState(
			(const PHONGTHAN_CHARACTER_STATE_HEADER*)pOutput,
			Header.StateSize))
	{
		return false;
	}
	*pStateSize = Header.StateSize;
	return true;
}

bool CPhongThanCharacterStore::LoadUnlocked(const char* pRoleName,
	BYTE* pOutput, PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize)
{
	char szPath[MAX_PATH];
	if (!BuildRolePath(pRoleName, szPath, sizeof(szPath)) ||
		!LoadPathUnlocked(szPath, pOutput, nCapacity, pStateSize))
		return false;
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)pOutput;
	return stricmp((const char*)pState->RoleName, pRoleName) == 0;
}

bool CPhongThanCharacterStore::Load(const char* pRoleName, BYTE* pOutput,
	PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize)
{
	EnterCriticalSection(&m_Lock);
	const bool bResult = LoadUnlocked(pRoleName, pOutput, nCapacity, pStateSize);
	LeaveCriticalSection(&m_Lock);
	return bResult;
}

int CPhongThanCharacterStore::ListUnlocked(const char* pAccountName,
	PHONGTHAN_CHARACTER_SUMMARY* pOutput, int nCapacity)
{
	if (!pAccountName || !pAccountName[0] || nCapacity < 0 || !EnsureRoot())
		return -1;
	char szPattern[MAX_PATH];
	if (_snprintf(szPattern, sizeof(szPattern), "%s\\*.pthc", m_szRoot) < 0)
		return -1;

	WIN32_FIND_DATAA FindData;
	HANDLE hFind = FindFirstFileA(szPattern, &FindData);
	if (hFind == INVALID_HANDLE_VALUE)
		return GetLastError() == ERROR_FILE_NOT_FOUND ? 0 : -1;
	int nCount = 0;
	do
	{
		if (FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
			continue;
		char szPath[MAX_PATH];
		if (_snprintf(szPath, sizeof(szPath), "%s\\%s",
				m_szRoot, FindData.cFileName) < 0)
			continue;
		BYTE* pStateBuffer = new BYTE[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
		PHONGTHAN_U32 nStateSize = 0;
		if (LoadPathUnlocked(szPath, pStateBuffer,
				PHONGTHAN_CHARACTER_MAX_STATE_SIZE, &nStateSize))
		{
			const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
				(const PHONGTHAN_CHARACTER_STATE_HEADER*)pStateBuffer;
			if (stricmp((const char*)pState->AccountName, pAccountName) == 0)
			{
				if (pOutput && nCount < nCapacity)
				{
					ZeroMemory(&pOutput[nCount], sizeof(pOutput[nCount]));
					strncpy((char*)pOutput[nCount].Name,
						(const char*)pState->RoleName,
						sizeof(pOutput[nCount].Name) - 1);
					pOutput[nCount].Gender = pState->Gender;
					pOutput[nCount].Profession = pState->Profession;
					pOutput[nCount].Level = (PHONGTHAN_U16)pState->FightLevel;
				}
				++nCount;
			}
		}
		delete [] pStateBuffer;
	} while (FindNextFileA(hFind, &FindData));
	FindClose(hFind);
	return nCount;
}

int CPhongThanCharacterStore::List(const char* pAccountName,
	PHONGTHAN_CHARACTER_SUMMARY* pOutput, int nCapacity)
{
	EnterCriticalSection(&m_Lock);
	const int nResult = ListUnlocked(pAccountName, pOutput, nCapacity);
	LeaveCriticalSection(&m_Lock);
	return nResult;
}

bool CPhongThanCharacterStore::WriteUnlocked(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	PHONGTHAN_U32 nStateSize, bool bReplaceExisting)
{
	if (!PhongThanValidateCharacterState(pState, nStateSize) || !EnsureRoot())
		return false;
	char szPath[MAX_PATH];
	if (!BuildRolePath((const char*)pState->RoleName,
			szPath, sizeof(szPath)))
		return false;
	if (!bReplaceExisting &&
		GetFileAttributesA(szPath) != INVALID_FILE_ATTRIBUTES)
		return false;

	char szTemporary[MAX_PATH];
	const int nWritten = _snprintf(szTemporary, sizeof(szTemporary),
		"%s.tmp.%08lx.%08lx", szPath,
		(unsigned long)GetCurrentProcessId(),
		(unsigned long)GetCurrentThreadId());
	if (nWritten < 0 || (size_t)nWritten >= sizeof(szTemporary))
		return false;
	HANDLE hFile = CreateFileA(szTemporary, GENERIC_WRITE, 0, NULL,
		CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
		return false;

	PHONGTHAN_CHARACTER_FILE_HEADER Header;
	Header.Magic = PHONGTHAN_CHARACTER_FILE_MAGIC;
	Header.FormatVersion = PHONGTHAN_CHARACTER_FILE_VERSION;
	Header.HeaderSize = sizeof(Header);
	Header.StateSize = nStateSize;
	Header.Checksum = PhongThanCharacterChecksum((const BYTE*)pState, nStateSize);
	bool bResult = PhongThanWriteAll(hFile, &Header, sizeof(Header)) &&
		PhongThanWriteAll(hFile, pState, nStateSize) &&
		FlushFileBuffers(hFile) != FALSE;
	CloseHandle(hFile);
	if (bResult)
	{
		DWORD nFlags = MOVEFILE_WRITE_THROUGH;
		if (bReplaceExisting)
			nFlags |= MOVEFILE_REPLACE_EXISTING;
		bResult = MoveFileExA(szTemporary, szPath, nFlags) != FALSE;
	}
	if (!bResult)
		DeleteFileA(szTemporary);
	return bResult;
}

bool CPhongThanCharacterStore::Create(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	PHONGTHAN_U32 nStateSize)
{
	if (!PhongThanValidateCharacterState(pState, nStateSize))
		return false;
	EnterCriticalSection(&m_Lock);
	const int nAccountCharacters = ListUnlocked(
		(const char*)pState->AccountName, NULL, 0);
	const bool bResult = nAccountCharacters >= 0 &&
		nAccountCharacters < PHONGTHAN_CHARACTER_LIMIT &&
		WriteUnlocked(pState, nStateSize, false);
	LeaveCriticalSection(&m_Lock);
	return bResult;
}

bool CPhongThanCharacterStore::Save(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	PHONGTHAN_U32 nStateSize)
{
	if (!PhongThanValidateCharacterState(pState, nStateSize))
		return false;
	EnterCriticalSection(&m_Lock);
	BYTE* pExisting = new BYTE[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
	PHONGTHAN_U32 nExistingSize = 0;
	const bool bOwned = LoadUnlocked((const char*)pState->RoleName,
		pExisting, PHONGTHAN_CHARACTER_MAX_STATE_SIZE, &nExistingSize) &&
		stricmp((const char*)((PHONGTHAN_CHARACTER_STATE_HEADER*)pExisting)->AccountName,
			(const char*)pState->AccountName) == 0;
	delete [] pExisting;
	const bool bResult = bOwned && WriteUnlocked(pState, nStateSize, true);
	LeaveCriticalSection(&m_Lock);
	return bResult;
}

bool CPhongThanCharacterStore::Delete(const char* pAccountName,
	const char* pRoleName)
{
	if (!pAccountName || !pAccountName[0] || !pRoleName || !pRoleName[0])
		return false;
	EnterCriticalSection(&m_Lock);
	BYTE* pExisting = new BYTE[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
	PHONGTHAN_U32 nExistingSize = 0;
	char szPath[MAX_PATH];
	const bool bOwned = LoadUnlocked(pRoleName, pExisting,
		PHONGTHAN_CHARACTER_MAX_STATE_SIZE, &nExistingSize) &&
		stricmp((const char*)((PHONGTHAN_CHARACTER_STATE_HEADER*)pExisting)->AccountName,
			pAccountName) == 0 &&
		BuildRolePath(pRoleName, szPath, sizeof(szPath));
	delete [] pExisting;
	const bool bResult = bOwned && DeleteFileA(szPath) != FALSE;
	LeaveCriticalSection(&m_Lock);
	return bResult;
}
