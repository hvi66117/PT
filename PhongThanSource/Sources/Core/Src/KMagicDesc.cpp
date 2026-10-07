#include "KCore.h"

#include "KEngine.h"
#include "KMagicAttrib.h"
#include "KMagicDesc.h"
#include "GameDataDef.h"
#include "KProfession.h"
#include "KPakFile.h"

#define MAGICDESC_FILE "\\settings\\MagicDesc.Ini"

const char MAGIC_ATTRIB_STRING[magic_normal_end + 1][100] =
{
#define MAGIC_ATTRIB_ENTRY(id, symbol, key) key,
#include "KMagicAttribRegistry.inc"
#undef MAGIC_ATTRIB_ENTRY
	""
};

typedef char KMagicAttribRegistrySizeCheck[
	(sizeof(MAGIC_ATTRIB_STRING) / sizeof(MAGIC_ATTRIB_STRING[0]) ==
	 magic_normal_end + 1) ? 1 : -1];

static void AppendDescText(char* pszDest, int nCapacity, int* pnLength,
	const char* pszText)
{
	if (!pszDest || !pnLength || !pszText || nCapacity <= 0)
		return;

	while (*pszText && *pnLength < nCapacity - 1)
	{
		pszDest[*pnLength] = *pszText;
		++(*pnLength);
		++pszText;
	}
	pszDest[*pnLength] = 0;
}

static void AppendDescNumber(char* pszDest, int nCapacity, int* pnLength,
	int nValue, char cSignMode)
{
	char szNumber[32];
	long nDisplayValue = nValue;

	if (cSignMode == '+')
	{
		if (nDisplayValue >= 0)
			AppendDescText(pszDest, nCapacity, pnLength, "+");
		else
		{
			AppendDescText(pszDest, nCapacity, pnLength, "-");
			nDisplayValue = -nDisplayValue;
		}
	}
	else if (cSignMode == '~')
	{
		if (nDisplayValue > 0)
			AppendDescText(pszDest, nCapacity, pnLength, "-");
		else if (nDisplayValue < 0)
		{
			AppendDescText(pszDest, nCapacity, pnLength, "+");
			nDisplayValue = -nDisplayValue;
		}
	}

	sprintf(szNumber, "%ld", nDisplayValue);
	AppendDescText(pszDest, nCapacity, pnLength, szNumber);
}

static int GetDescValue(const KMagicAttrib* pAttrib, char cSelector)
{
	switch (cSelector)
	{
	case 'A':
		return pAttrib->nValue[0] / 256;
	case '1':
		return pAttrib->nValue[0];
	case '2':
		return pAttrib->nValue[1];
	case '3':
		return pAttrib->nValue[2];
	case '6':
		return pAttrib->nValue[2] / 256;
	case '7':
		return pAttrib->nValue[0] % 256;
	case '9':
		return pAttrib->nValue[2] % 256;
	default:
		return pAttrib->nValue[0];
	}
}

static const char* GetSeriesDesc(int nSeries)
{
	switch (nSeries)
	{
	case series_metal:
		return "Giap si";
	case series_wood:
		return "Dao si";
	case series_water:
		return "Di nhan";
	case series_fire:
		return "He Hoa";
	case series_earth:
		return "He Tho";
	default:
		return "Vo he";
	}
}

static const char* GetCostTypeDesc(int nType)
{
	switch (nType)
	{
	case 0:
		return "Noi luc";
	case 1:
		return "Sinh luc";
	case 2:
		return "The luc";
	case 3:
		return "Tien";
	default:
		return "Noi luc";
	}
}

static void AppendDescToken(char* pszDest, int nCapacity, int* pnLength,
	const KMagicAttrib* pAttrib, char cTokenType, char cSelector,
	char cSignMode)
{
	int nValue = GetDescValue(pAttrib, cSelector);
	char szText[128];

	switch (cTokenType)
	{
	case 'm':
		if (g_Profession.IsValid(nValue))
		{
			AppendDescText(pszDest, nCapacity, pnLength,
				g_Profession.GetName(nValue));
		}
		else
		{
			AppendDescNumber(pszDest, nCapacity, pnLength, nValue, cSignMode);
		}
		break;
	case 's':
		AppendDescText(pszDest, nCapacity, pnLength, GetSeriesDesc(nValue));
		break;
	case 'k':
		AppendDescText(pszDest, nCapacity, pnLength, GetCostTypeDesc(nValue));
		break;
	case 'l':
		{
			KSkill* pSkill = NULL;
			if (nValue > 0)
				pSkill = (KSkill*)g_SkillManager.GetSkill(nValue, 1);
			if (pSkill && pSkill->GetSkillName() && pSkill->GetSkillName()[0])
				sprintf(szText, "[ %s ]", pSkill->GetSkillName());
			else
				sprintf(szText, "%d", nValue);
			AppendDescText(pszDest, nCapacity, pnLength, szText);
		}
		break;
	case 'f':
		AppendDescNumber(pszDest, nCapacity, pnLength, nValue / 18,
			cSignMode);
		break;
	case 'x':
		AppendDescText(pszDest, nCapacity, pnLength,
			nValue ? "Nu" : "Nam");
		break;
	case 'w':
		AppendDescText(pszDest, nCapacity, pnLength,
			nValue == 9 ? "tan anh keo dai" : "tan anh");
		break;
	case 'd':
	case 'b':
	case 'g':
	case 'h':
	case 'j':
	case 'o':
	default:
		// Phong Than adds b/g/h/j/o tokens. Until their enum labels are
		// available in data, retaining the numeric value is lossless and
		// avoids the blank fields produced by the inherited formatter.
		AppendDescNumber(pszDest, nCapacity, pnLength, nValue, cSignMode);
		break;
	}
}

KMagicDesc g_MagicDesc;

KMagicDesc::KMagicDesc()
{
	ZeroMemory(m_aryTemplate, sizeof(m_aryTemplate));
	m_nTemplateCount = 0;
	m_szDesc[0] = 0;
}

KMagicDesc::~KMagicDesc()
{
}

BOOL KMagicDesc::Init()
{
	ZeroMemory(m_aryTemplate, sizeof(m_aryTemplate));
	m_nTemplateCount = 0;

	KPakFile File;
	if (!File.Open(MAGICDESC_FILE))
		return FALSE;

	const DWORD dwSize = File.Size();
	if (!dwSize || dwSize > 1024 * 1024)
	{
		File.Close();
		return FALSE;
	}

	char* pData = new char[dwSize + 1];
	if (!pData)
	{
		File.Close();
		return FALSE;
	}
	const DWORD dwRead = File.Read(pData, dwSize);
	File.Close();
	if (dwRead != dwSize)
	{
		delete [] pData;
		return FALSE;
	}
	pData[dwSize] = 0;

	BOOL bInDescript = FALSE;
	BOOL bValid = TRUE;
	char* pCursor = pData;
	while (*pCursor)
	{
		char* pLine = pCursor;
		while (*pCursor && *pCursor != '\r' && *pCursor != '\n')
			++pCursor;
		if (*pCursor)
		{
			*pCursor++ = 0;
			while (*pCursor == '\r' || *pCursor == '\n')
				++pCursor;
		}

		while (*pLine == ' ' || *pLine == '\t')
			++pLine;
		char* pTail = pLine + strlen(pLine);
		while (pTail > pLine && (pTail[-1] == ' ' || pTail[-1] == '\t'))
			*--pTail = 0;
		if (!pLine[0] || pLine[0] == ';' ||
			(pLine[0] == '/' && pLine[1] == '/'))
			continue;

		if (pLine[0] == '[')
		{
			if (!_stricmp(pLine, "[Descript]"))
				bInDescript = TRUE;
			else if (bInDescript)
				break;
			continue;
		}
		if (!bInDescript)
			continue;

		char* pValue = strchr(pLine, '=');
		if (!pValue)
			continue;
		*pValue++ = 0;
		char* pKeyTail = pLine + strlen(pLine);
		while (pKeyTail > pLine &&
			(pKeyTail[-1] == ' ' || pKeyTail[-1] == '\t'))
			*--pKeyTail = 0;

		int nTemplateId = INVALID_ATTRIB;
		for (int nExisting = 0; nExisting < m_nTemplateCount; ++nExisting)
		{
			if (!strcmp(pLine, MAGIC_ATTRIB_STRING[nExisting]))
			{
				nTemplateId = nExisting;
				break;
			}
		}

		if (nTemplateId == INVALID_ATTRIB)
		{
			if (m_nTemplateCount >= MAGIC_DESC_COUNT ||
				strcmp(pLine, MAGIC_ATTRIB_STRING[m_nTemplateCount]))
			{
				bValid = FALSE;
				break;
			}
			nTemplateId = m_nTemplateCount++;
		}

		if (nTemplateId < 0 || nTemplateId >= MAGIC_DESC_COUNT)
		{
			bValid = FALSE;
			break;
		}
		strncpy(m_aryTemplate[nTemplateId], pValue,
			MAGIC_DESC_LENGTH - 1);
		m_aryTemplate[nTemplateId][MAGIC_DESC_LENGTH - 1] = 0;
	}

	delete [] pData;
	if (!bValid || m_nTemplateCount != magic_normal_end)
	{
		ZeroMemory(m_aryTemplate, sizeof(m_aryTemplate));
		m_nTemplateCount = 0;
		return FALSE;
	}
	return TRUE;
}

const char* KMagicDesc::GetDesc(void* pData)
{
	char szTemplate[256];
	const char* pszSource;
	int nLength = 0;

	ZeroMemory(m_szDesc, sizeof(m_szDesc));
	ZeroMemory(szTemplate, sizeof(szTemplate));
	if (!pData)
		return NULL;

	KMagicAttrib* pAttrib = (KMagicAttrib*)pData;
	const char* pszKeyName = g_MagicID2String(pAttrib->nAttribType);
	if (!pszKeyName || !pszKeyName[0])
		return m_szDesc;

	if (pAttrib->nAttribType < 0 ||
		pAttrib->nAttribType >= m_nTemplateCount)
		return m_szDesc;
	strncpy(szTemplate, m_aryTemplate[pAttrib->nAttribType],
		sizeof(szTemplate) - 1);
	szTemplate[sizeof(szTemplate) - 1] = 0;
	pszSource = szTemplate;
	while (*pszSource == '$')
		++pszSource;

	while (*pszSource && nLength < sizeof(m_szDesc) - 1)
	{
		if (*pszSource == '#' && pszSource[1] && pszSource[2] &&
			((pszSource[1] >= 'A' && pszSource[1] <= 'Z') ||
			 (pszSource[1] >= 'a' && pszSource[1] <= 'z')) &&
			((pszSource[2] >= '0' && pszSource[2] <= '9') ||
			 pszSource[2] == 'A'))
		{
			char cSignMode = 0;
			int nTokenLength = 3;
			if (pszSource[3] == '+' || pszSource[3] == '-' ||
				pszSource[3] == '~')
			{
				cSignMode = pszSource[3];
				nTokenLength = 4;
			}
			AppendDescToken(m_szDesc, sizeof(m_szDesc), &nLength,
				pAttrib, pszSource[1], pszSource[2], cSignMode);
			pszSource += nTokenLength;
			continue;
		}

		m_szDesc[nLength++] = *pszSource++;
		m_szDesc[nLength] = 0;
	}
	return m_szDesc;
}

const char* g_MagicID2String(int nAttrib)
{
	if (nAttrib < 0 || nAttrib >= magic_normal_end)
		return MAGIC_ATTRIB_STRING[magic_normal_end];
	return MAGIC_ATTRIB_STRING[nAttrib];
}

int g_String2MagicID(char* szMagicAttribName)
{
	if (!szMagicAttribName || !szMagicAttribName[0])
		return INVALID_ATTRIB;

	for (int i = 0; i < magic_normal_end; ++i)
	{
		if (!strcmp(szMagicAttribName, MAGIC_ATTRIB_STRING[i]))
			return i;
	}
	return INVALID_ATTRIB;
}

int KMagicDesc::String2MagicID(char* szMagicAttribName)
{
	return g_String2MagicID(szMagicAttribName);
}
