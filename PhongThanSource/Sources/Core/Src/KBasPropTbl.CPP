//---------------------------------------------------------------------------
// Sword3 Core (c) 2002 by Kingsoft
//
// File:	KBasPropTbl.CPP
// Date:	2002.08.14
// Code:	DongBo
// Desc:    cpp file. ���ļ�ʵ�ֵ������ڴ�tab file�ж������ߵĳ�ʼ����,
//			�����ɶ�Ӧ�����Ա�
//---------------------------------------------------------------------------

#include "KCore.h"
#include "KTabFile.h"
#include "MyAssert.H"
#include "KBasPropTbl.h"
#include "KMagicAttrib.h"
#include "PhongThanEquipmentColumns.h"
#include "KPakList.h"
#include "../../../Headers/PhongThanSetTable.h"

#define		TABFILE_PATH				"\\settings\\item"
#define		TABFILE_EVENTITEM			"eventitem.txt"
#define		TABFILE_MATERIAL			"material.txt"
#define		TABFILE_TASK				"questkey.txt"
#define		TABFILE_MEDICINE			"potion.txt"
#define		TABFILE_SKILLBOOK			"skillbook.txt"
#define		TABFILE_MELEEWEAPON			"MeleeWeapon.txt"
#define		TABFILE_RANGEWEAPON			"RangeWeapon.txt"
#define		TABFILE_ARMOR				"Armor.txt"
#define		TABFILE_HELM				"Helm.txt"
#define		TABFILE_BOOT				"Boot.txt"
#define		TABFILE_BELT				"Belt.txt"
#define		TABFILE_AMULET				"Amulet.txt"
#define		TABFILE_RING				"Ring.txt"
#define		TABFILE_CUFF				"Cuff.txt"
#define		TABFILE_PENDANT				"Pendant.txt"
#define		TABFILE_HORSE				"Horse.txt"
#define		TABFILE_TOWNPORTAL			"TownPortal.txt"
#define		TABFILE_MAGICSCRIPT			"magicscript.txt"
#define		TABFILE_IBITEM				"ibitem.txt"
#define		TABFILE_SIGNET				"Signet.txt"
#define		TABFILE_SHIPIN				"Shipin.txt"
#define		TABFILE_VNG_SETATTRIB		"zhuang_bei_dian_lan_fu_jia_shu_xing_biao.txt"

#define		TABFILE_ITEM_VERSION		"\\settings\\item\\itemversion.ini"

// Phong Than stores the active item data set in settings\item\NNN. Cache the
// selected version once per Core process and reject every version that does
// not match the protocol/runtime ITEM_VERSION.
int GetActiveItemTableVersion()
{
	static int s_nVersion = -2;
	if (s_nVersion != -2)
		return s_nVersion;

	s_nVersion = -1;
	KIniFile VersionFile;
	if (VersionFile.Load(TABFILE_ITEM_VERSION))
	{
		int nVersion = -1;
		VersionFile.GetInteger("ItemVersion", "Version", -1, &nVersion);
		if (nVersion == ITEM_VERSION)
			s_nVersion = nVersion;
	}
	if (s_nVersion != ITEM_VERSION)
		printf("[ITEM][FATAL] itemversion.ini must select version %03d\n", ITEM_VERSION);
	return s_nVersion;
}

BOOL BuildActiveItemTablePath(const char* pszFile, char* pszPath, int nPathSize)
{
	if (!pszFile || !pszFile[0] || !pszPath || nPathSize <= 0)
		return FALSE;
	const int nVersion = GetActiveItemTableVersion();
	if (nVersion != ITEM_VERSION)
		return FALSE;
	const int nRequired = strlen(TABFILE_PATH) + 1 + 3 + 1 + strlen(pszFile) + 1;
	if (nRequired > nPathSize)
		return FALSE;
	sprintf(pszPath, "%s\\%03d\\%s", TABFILE_PATH, nVersion, pszFile);
	return TRUE;
}

static int GetRequiredMinimumColumns(const char* pszFile)
{
	if (!_stricmp(pszFile, TABFILE_MELEEWEAPON) ||
		!_stricmp(pszFile, TABFILE_ARMOR) ||
		!_stricmp(pszFile, TABFILE_HELM) ||
		!_stricmp(pszFile, TABFILE_BOOT) ||
		!_stricmp(pszFile, TABFILE_BELT) ||
		!_stricmp(pszFile, TABFILE_AMULET) ||
		!_stricmp(pszFile, TABFILE_PENDANT) ||
		!_stricmp(pszFile, TABFILE_HORSE))
		return 70;
	if (!_stricmp(pszFile, TABFILE_RANGEWEAPON))
		return 55;
	if (!_stricmp(pszFile, TABFILE_RING))
		return 55;
	if (!_stricmp(pszFile, TABFILE_CUFF))
		return 46;
	if (!_stricmp(pszFile, TABFILE_MAGICSCRIPT))
		return 34;
	if (!_stricmp(pszFile, TABFILE_IBITEM))
		return 30;
	if (!_stricmp(pszFile, TABFILE_MATERIAL))
		return 23;
	if (!_stricmp(pszFile, TABFILE_TASK))
		return 19;
	if (!_stricmp(pszFile, TABFILE_MEDICINE))
		return 20;
	if (!_stricmp(pszFile, TABFILE_SKILLBOOK))
		return 22;
	return 0;
}

// ���¶���Ľṹ���ڸ�����tabfile�ж������Եĳ�ʼֵ
typedef struct tagPROPINFO
{
	int		m_nType;		// ���Ե�����. ��� PI_VARTYPE_...ϵ�ж���
	union
	{
	char*	m_pszBuf;		// ָ���ַ�����������ָ��
	int*	m_pnData;		// ָ��int������ָ��
	}m_pData;
	int		m_nBufSize;		// �������ĳ���
} PROPINFO;
#define		PI_VARTYPE_CHAR		0
#define		PI_VARTYPE_INT		1

char*	TABFILE_EQUIPMENT[] = 
{
	TABFILE_MELEEWEAPON,	//"MeleeWeapon.txt",
	TABFILE_RANGEWEAPON,	//"RangeWeapon.txt",
	TABFILE_ARMOR,			//"Armor.txt",
	TABFILE_HELM,			//"Helm.txt",
	TABFILE_BOOT,			//"Boot.txt",
	TABFILE_BELT,			//"Belt.txt",
	TABFILE_AMULET,			//"Amulet.txt",
	TABFILE_RING,			//"Ring.txt",
	TABFILE_CUFF,			//"Cuff.txt",
	TABFILE_PENDANT,		//"Pendant.txt",
	TABFILE_HORSE,			//"Horse.txt",
	TABFILE_SIGNET,			//"Signet.txt"
	TABFILE_SHIPIN,			//"Shipin.txt"
};

//int GetRandomNumber(int nMin, int nMax);

//=============================================================================

/******************************************************************************
	����:	��tab file�ж����ض������ݼ�¼
	���:	pTF: ������ָ��, �ô˹������ȡtab file
			nRow: ����nRow���¼
			pPI[i].m_nType: ���������ļ�¼�е�i���������, ���������ͻ��ַ���
			pPI[i].m_pData: �����ݶ����˻�������
			cbFields: ÿ���¼������ô�����
	����:	�ɹ�ʱ���ط���, m_pBuf ָ�������ڴ�
			ʧ��ʱ������
******************************************************************************/
BOOL LoadRecord(IN KTabFile* pTF, IN int nRow,
				IN OUT const PROPINFO* pPI, IN int cbFields)
{
	BOOL bEC = TRUE;

	nRow += 2;	// ��1: ����tabfile�ĵ�һ��. ���и������Ǹ��е�����
				// �ټ�1: KTabFile::GetInteger()����Ҫ��nRow��1��ʼ����

	// ��������������
	for (int n = 0; n < cbFields; n++)
	{
		if (PI_VARTYPE_INT == (pPI+n)->m_nType)
		{	// ���� int ������
			if (FALSE == pTF->GetInteger(nRow, n+1, -1, (pPI+n)->m_pData.m_pnData))
				{ _ASSERT(FALSE); bEC = FALSE; break; }
		}
		else
		{	// �����ַ���������
			_ASSERT(PI_VARTYPE_CHAR == (pPI+n)->m_nType);

			if (FALSE == pTF->GetString(nRow, n+1, "", (pPI+n)->m_pData.m_pszBuf,
										(pPI+n)->m_nBufSize))
				{ _ASSERT(FALSE); bEC = FALSE; break; }
		}
	}
	return bEC;
}

//=============================================================================

KLibOfBPT::KLibOfBPT()
{
	m_nVngSetAttribCount = 0;
	memset(m_VngSetAttrib, 0, sizeof(m_VngSetAttrib));
}

KLibOfBPT::~KLibOfBPT()
{
}

/******************************************************************************
	���ܣ�	�ܿأ���tab file�ж������,ħ����ԭʼ����
	����:	������ݴ���m_BPTWeapon,m_BPTWeaponDirty�ȳ�Ա������
******************************************************************************/
BOOL KLibOfBPT::Init()
{
	// ��ʼ��
	KBasicPropertyTable*	paryBPT[] = {	
											&m_BPTMeleeWeapon,
											&m_BPTRangeWeapon,
											&m_BPTArmor,
											&m_BPTHelm,
											&m_BPTBoot,
											&m_BPTBelt,
											&m_BPTAmulet,
											&m_BPTRing,
											&m_BPTCuff,
											&m_BPTPendant,
											&m_BPTHorse,
											&m_BPTMaterial,
											&m_BPTQuest,
											&m_BPTMagicScript,
											&m_BPTIBItem,
											&m_BPTTownPortal,
											&m_BPTMedicine,
											&m_BPTSkillBook,
										};
	// ��tab file�������
	const int cbNumOfTables = sizeof(paryBPT)/sizeof(paryBPT[0]);
	int nLoadedTables = 0;
	int nRequiredTables = 0;
	int nRequiredLoaded = 0;
	for (int i = 0; i < cbNumOfTables; i++)
	{
		const BOOL bRequired = TRUE;
		if (bRequired)
			++nRequiredTables;
		if (i < 11)
		{
			KBPT_Equipment* pTemp = (KBPT_Equipment *)paryBPT[i];
			pTemp->Init(i);
		}
		if (FALSE == paryBPT[i]->Load())
		{
			printf("[ITEM][%s] unable to load table index %d\n",
				bRequired ? "FATAL" : "OPTIONAL", i);
			continue;
		}
		++nLoadedTables;
		if (bRequired)
			++nRequiredLoaded;
	}
	if (nRequiredLoaded != nRequiredTables)
	{
		printf("[ITEM][FATAL] required tables loaded %d/%d\n",
			nRequiredLoaded, nRequiredTables);
		return FALSE;
	}

	if (!InitVngSetAttrib())
		return FALSE;

	printf("[ITEM] registry version %03d loaded: required=%d/%d total=%d/%d\n",
		GetActiveItemTableVersion(), nRequiredLoaded, nRequiredTables,
		nLoadedTables, cbNumOfTables);
	return TRUE;
}

BOOL KLibOfBPT::InitVngSetAttrib()
{
	m_nVngSetAttribCount = 0;
	memset(m_VngSetAttrib, 0, sizeof(m_VngSetAttrib));

	// Verified VNG set-table entry for the active extended item registry.
	// The older 884177972 entry lacks SetIDs 30/36 used by current items.
	if (!g_pPakList) return FALSE;
	XPackElemFileRef ref;
	ZeroMemory(&ref, sizeof(ref));
	if (!g_pPakList->FindElemFile((unsigned long)771097478, ref)) return FALSE;
	char* bytes = new char[1024 * 1024];
	PhongThanSetRow* rows = new PhongThanSetRow[MAX_VNG_SET_ATTRIB_RECORDS];
	if (!bytes || !rows) { delete [] bytes; delete [] rows; return FALSE; }
	int size = g_pPakList->ElemFileRead(ref, bytes, 1024 * 1024);
	int count = PhongThanParseSetTable(bytes, size, rows, MAX_VNG_SET_ATTRIB_RECORDS);
	delete [] bytes;
	if (count <= 0) { delete [] rows; return FALSE; }
	for (int i = 0; i < count; ++i)
	{
		m_VngSetAttrib[i].m_nGroupId = rows[i].id;
		for (int slot = 0; slot < MAX_VNG_SET_ATTRIB; ++slot)
		{
			if (rows[i].type[slot] < 0 || rows[i].type[slot] >= magic_normal_end)
				{ delete [] rows; return FALSE; }
			m_VngSetAttrib[i].m_aryAttrib[slot].nType = rows[i].type[slot];
			m_VngSetAttrib[i].m_aryAttrib[slot].nValue[0] = rows[i].value[slot];
		}
	}
	delete [] rows;
	m_nVngSetAttribCount = count;
	printf("[ITEM] original VNG set table: entry=771097478 sets=%d\n", count);
	return TRUE;
}

/******************************************************************************
	���ܣ�	����һ����ά�����飬����(ǰ��׺����Ʒ���͡����С�����)
            ȷ��һ��ħ�����Ե�����ֵ�б�
	���:	m_BPTMagicAttrib: �ں���tab file�����ȫ��ħ������
	����:	��ά���� m_CMAIT �ֱ������Ӧ������ֵ�б�
******************************************************************************/
// Add by Freeway Chen in 2003.5.30
const KBASICPROP_EQUIPMENT* KLibOfBPT::GetMeleeWeaponRecord(IN int i) const
{
	return m_BPTMeleeWeapon.GetRecord(i);
}

const int KLibOfBPT::GetMeleeWeaponRecordNumber() const
{
	return m_BPTMeleeWeapon.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetRangeWeaponRecord(IN int i) const
{
	return m_BPTRangeWeapon.GetRecord(i);
}

const int KLibOfBPT::GetRangeWeaponRecordNumber() const
{
	return m_BPTRangeWeapon.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetArmorRecord(IN int i) const
{
	return m_BPTArmor.GetRecord(i);
}

const int KLibOfBPT::GetArmorRecordNumber() const
{
	return m_BPTArmor.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetHelmRecord(IN int i) const
{
	return m_BPTHelm.GetRecord(i);
}

const int KLibOfBPT::GetHelmRecordNumber() const
{
	return m_BPTHelm.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetBootRecord(IN int i) const
{
	return m_BPTBoot.GetRecord(i);
}

const int KLibOfBPT::GetBootRecordNumber() const
{
	return m_BPTBoot.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetBeltRecord(IN int i) const
{
	return m_BPTBelt.GetRecord(i);
}

const int KLibOfBPT::GetBeltRecordNumber() const
{
	return m_BPTBelt.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetAmuletRecord(IN int i) const
{
	return m_BPTAmulet.GetRecord(i);
}

const int KLibOfBPT::GetAmuletRecordNumber() const
{
	return m_BPTAmulet.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetRingRecord(IN int i) const
{
	return m_BPTRing.GetRecord(i);
}

const int KLibOfBPT::GetRingRecordNumber() const
{
	return m_BPTRing.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetCuffRecord(IN int i) const
{
	return m_BPTCuff.GetRecord(i);
}

const int KLibOfBPT::GetCuffRecordNumber() const
{
	return m_BPTCuff.NumOfEntries();
}

const KBASICPROP_EQUIPMENT*	KLibOfBPT::GetPendantRecord(IN int i) const
{
	return m_BPTPendant.GetRecord(i);
}

const int KLibOfBPT::GetPendantRecordNumber() const
{
	return m_BPTPendant.NumOfEntries();
}

const KBASICPROP_EQUIPMENT* KLibOfBPT::GetHorseRecord(IN int i) const
{
	return m_BPTHorse.GetRecord(i);
}

const int KLibOfBPT::GetHorseRecordNumber() const
{
	return m_BPTHorse.NumOfEntries();
}

const KBASICPROP_MEDICINE* KLibOfBPT::GetMedicineRecord(IN int i) const
{
	return m_BPTMedicine.GetRecord(i);
}

const int KLibOfBPT::GetMedicineRecordNumber() const
{
	return m_BPTMedicine.NumOfEntries();
}

const KBASICPROP_QUEST* KLibOfBPT::GetQuestRecord(IN int i) const
{
	// VNG questkey.txt uses a sparse DetailType key.  A row-number lookup
	// silently starts returning the wrong quest item after the first gap.
	return m_BPTQuest.FindRecord(i);
}

const int KLibOfBPT::GetQuestRecordNumber() const
{
	return m_BPTQuest.NumOfEntries();
}

const KBASICPROP_SKILLBOOK* KLibOfBPT::GetSkillBook(int detail, int skill) const
{
	return m_BPTSkillBook.FindRecord(detail, skill);
}

int KLibOfBPT::GetSkillBookRecordNumber() const
{
	return m_BPTSkillBook.NumOfEntries();
}

const KBASICPROP_TOWNPORTAL* KLibOfBPT::GetTownPortalRecord(IN int i) const
{
	return m_BPTTownPortal.GetRecord(i);
}

const int KLibOfBPT::GetTownPortalRecordNumber() const
{
	return m_BPTTownPortal.NumOfEntries();
}

const KBASICPROP_MAGICSCRIPT* KLibOfBPT::GetMagicScript(IN int i) const
{
	// The legacy table happened to use the record number as its item key.
	// Phong Than item\NNN tables use the value in the "detailed category"
	// column instead, so looking up by row silently binds the wrong item.
	return m_BPTMagicScript.FindRecord(i);
}

const int KLibOfBPT::GetMagicScriptRecordNumber() const
{
	return m_BPTMagicScript.NumOfEntries();
}

const KBASICPROP_IBITEM* KLibOfBPT::GetIBItem(IN int nDetail, IN int nParticular) const
{
	return m_BPTIBItem.FindRecord(nDetail, nParticular);
}

const int KLibOfBPT::GetIBItemRecordNumber() const
{
	return m_BPTIBItem.NumOfEntries();
}



const KBASICPROP_EQUIPMENT* KLibOfBPT::GetSignetRecord(IN int i) const
{
	return m_BPTSignet.GetRecord(i);
}

const int KLibOfBPT::GetSignetRecordNumber() const
{
	return m_BPTSignet.NumOfEntries();
}

const KBASICPROP_EQUIPMENT* KLibOfBPT::GetShipinRecord(IN int i) const
{
	return m_BPTShipin.GetRecord(i);
}

const int KLibOfBPT::GetShipinRecordNumber() const
{
	return m_BPTShipin.NumOfEntries();
}


//
/*
const KBASICPROP_EQUIPMENT* KLibOfBPT::FindEquipment(IN int a, IN int b, IN int c) const
{
	return m_BPTEquipment.FindRecord(a, b, c);
}
*/

/******************************************************************************
	����:	��ȡָ����ҩƷ�����Լ�¼
	���:	nType: ҩƷ������
			nLevel: ҩƷ�ļ���
	����:	�ɹ�ʱ����ָ��ü�¼��ָ��
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_MEDICINE* KLibOfBPT::FindMedicine(IN int nType, IN int nLevel) const
{
	return m_BPTMedicine.FindRecord(nType, nLevel);
}

/******************************************************************************
	����:	��ȡָ���Ŀ�ʯ�����Լ�¼
	���:	i: ָ����ʯ
	����:	�ɹ�ʱ����ָ��ü�¼��ָ��
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_EVENTITEM* KLibOfBPT::GetEvent(IN int i) const
{
	return m_BPTEvent.GetRecord(i);
}

const int KLibOfBPT::GetEventRecordNumber() const
{
	return m_BPTEvent.NumOfEntries();
}

const KBASICPROP_EVENTITEM* KLibOfBPT::GetMaterial(IN int i) const
{
	const KBASICPROP_EVENTITEM* pData = m_BPTMaterial.GetRecord(i);
	if (pData && pData->m_nDetailType == i)
		return pData;
	return m_BPTMaterial.FindRecord(i);
}

const int KLibOfBPT::GetMaterialRecordNumber() const
{
	return m_BPTMaterial.NumOfEntries();
}

int KLibOfBPT::GetVngSetAttrib(IN int nGroupId,
								OUT KEQCP_VNG_FIXED* pOut,
								IN int nMax) const
{
	if (nGroupId <= 0 || !pOut || nMax <= 0)
		return 0;

	for (int nRecord = 0; nRecord < m_nVngSetAttribCount; ++nRecord)
	{
		const KBASICPROP_VNG_SETATTRIB* pSource = &m_VngSetAttrib[nRecord];
		if (pSource->m_nGroupId != nGroupId)
			continue;

		int nCopied = 0;
		for (int nAttrib = 0;
			nAttrib < MAX_VNG_SET_ATTRIB && nCopied < nMax;
			++nAttrib)
		{
			if (pSource->m_aryAttrib[nAttrib].nType <= 0)
				continue;
			pOut[nCopied++] = pSource->m_aryAttrib[nAttrib];
		}
		return nCopied;
	}
	return 0;
}
//=============================================================================

KBasicPropertyTable::KBasicPropertyTable()
{
	m_pBuf = NULL;
	m_nNumOfEntries = 0;
	m_nSizeOfEntry = 0;
	m_szTabFile[0] = 0;
	m_bVersionedItemTable = FALSE;
	m_nItemTableVersion = -1;
}

KBasicPropertyTable::~KBasicPropertyTable()
{
	ReleaseMemory();
}

/******************************************************************************
	����:	��¼tab file�й��ж��������ݼ�¼
******************************************************************************/
void KBasicPropertyTable::SetCount(int cbCount)
{
	_ASSERT(cbCount>0);
	_ASSERT(0==m_nNumOfEntries);	// this function is supposed to be called only once
	m_nNumOfEntries = cbCount;
}

/******************************************************************************
	����:	�����ڴ�,���ڱ����tab file�ж��������
	���:	m_nNumOfEntries: ������ô�������ݼ�¼
			m_nSizeOfEntry: ÿ�����ݼ�¼�Ĵ�С(�ֽ�)
	����:	�ɹ�ʱ���ط���, m_pBuf ָ�������ڴ�
			ʧ��ʱ������
******************************************************************************/
BOOL KBasicPropertyTable::GetMemory()
{
	_ASSERT(NULL == m_pBuf);
	_ASSERT(m_nNumOfEntries > 0 && m_nSizeOfEntry > 0);

	BOOL bEC = FALSE;
	const int nMemSize = m_nSizeOfEntry * m_nNumOfEntries;
	void* pBuf = new BYTE[nMemSize];
	_ASSERT(pBuf != NULL);
	if (pBuf != NULL)
	{
		m_pBuf = pBuf;
		bEC = TRUE;
	}
	return bEC;
}

/******************************************************************************
	����:	�ͷ��ڴ�
******************************************************************************/
void KBasicPropertyTable::ReleaseMemory()
{
	if (m_pBuf)
	{
		delete []m_pBuf;
		m_pBuf = NULL;
		m_nNumOfEntries = 0;
	}
}

/******************************************************************************
	����:	����tab file�е�ȫ������
	���:	m_szTabFile: �ļ���
	����:	�ɹ�ʱ���ط���, ȫ�����ݶ���m_pBuf��ָ��������.
				m_nNumOfEntries �������������������
			ʧ��ʱ������
******************************************************************************/
BOOL KBasicPropertyTable::Load()
{
	BOOL bEC = FALSE;
	KTabFile	theLoader;

	// ����tab file
	g_SetRootPath(NULL);

//	::g_SetFilePath(TABFILE_PATH);
	char	szFileName[FILE_NAME_LENGTH];
	BOOL bLoaded = FALSE;
	m_bVersionedItemTable = TRUE;
	m_nItemTableVersion = GetActiveItemTableVersion();
	if (m_nItemTableVersion == ITEM_VERSION &&
		BuildActiveItemTablePath(m_szTabFile, szFileName, sizeof(szFileName)))
	{
		bLoaded = theLoader.Load(szFileName);
	}
	if (!bLoaded)
	{
		printf("[ITEM] unable to load %s from active version %03d\n",
			m_szTabFile, m_nItemTableVersion);
		_ASSERT(FALSE);
		return bEC;
	}

	const int nMinimumColumns = GetRequiredMinimumColumns(m_szTabFile);
	if (nMinimumColumns > 0 && theLoader.GetWidth() < nMinimumColumns)
	{
		printf("[ITEM][FATAL] schema %s has %d columns, requires at least %d\n",
			szFileName, theLoader.GetWidth(), nMinimumColumns);
		_ASSERT(FALSE);
		return bEC;
	}

	printf("[ITEM] %s <- %s (registry=%03d)\n", m_szTabFile, szFileName,
		m_nItemTableVersion);

	// ȷ��file�ڸ����˶������¼
	const int cbItems = theLoader.GetHeight() - 1;	// ��һ�и�����������,
	if (cbItems <= 0)							// ʵ�����ݴӵ�2�п�ʼ����.
		{ _ASSERT(FALSE); return bEC; }
	SetCount(cbItems);

	// �����ڴ棬�������Ա�
	if (FALSE == GetMemory())
		{ _ASSERT(FALSE); return bEC; }

	// �����Լ�¼��������
	int i;
	for (i = 0; i < cbItems; i++)
	{
		if (FALSE == LoadRecord(i, &theLoader))
			{ _ASSERT(FALSE); return bEC; }
	}

	bEC = TRUE;
	return bEC;
}

//============================================================================
KBPT_Event::KBPT_Event()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_EVENTITEM);
	::strcpy(m_szTabFile, TABFILE_EVENTITEM);
}

KBPT_Event::~KBPT_Event()
{
}

BOOL KBPT_Event::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	KBASICPROP_EVENTITEM* pBuf = (KBASICPROP_EVENTITEM*)m_pBuf;
	pBuf = pBuf + i;
	const PROPINFO	aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_CHAR,			pBuf->m_szScript, sizeof(pBuf->m_szScript)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_bShortKey), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nMaxStack), 0},
	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));
}

/******************************************************************************
	����:	��ȡָ���Ŀ�ʯ������
	���:	i: Ҫ���ȡ��i���ʯ������. ��Ϊ-1��ʾ���ȡһ��
	����:	�ɹ�ʱ����ָ��ÿ�ʯ���Ե�ָ��(һ��KBASICPROP_EVENT�ṹ)
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_EVENTITEM* KBPT_Event::GetRecord(int i) const
{
	_ASSERT(this != NULL);

	if (-1 == i)
		i = ::GetRandomNumber(0, m_nNumOfEntries-1);

	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_EVENTITEM*)m_pBuf) + i) : NULL;
}


const KBASICPROP_EVENTITEM* KBPT_Event::FindRecord(IN int nDetailType) const
{
	const KBASICPROP_EVENTITEM* pData = NULL;
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_EVENTITEM* pMed;
		pMed = GetRecord(i);
		_ASSERT(NULL != pMed);
		if (nDetailType == pMed->m_nDetailType)
		{
			pData = pMed;
			break;
		}
	}
	return pData;
}

//============================================================================
KBPT_Material::KBPT_Material()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_EVENTITEM);
	::strcpy(m_szTabFile, TABFILE_MATERIAL);
}

KBPT_Material::~KBPT_Material()
{
}

BOOL KBPT_Material::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	KBASICPROP_EVENTITEM* pBuf = (KBASICPROP_EVENTITEM*)m_pBuf;
	pBuf = pBuf + i;
	memset(pBuf, 0, sizeof(KBASICPROP_EVENTITEM));

	const int nRow = i + 2;
	int nGenreCol = 0;
	for (int nCol = 2; nCol <= 8; nCol++)
	{
		int nGenre = -1, nDetail = -1, nObjIdx = -1;
		char szImage[SZBUFLEN_0];
		pTF->GetInteger(nRow, nCol, -1, &nGenre);
		pTF->GetInteger(nRow, nCol + 1, -1, &nDetail);
		pTF->GetString(nRow, nCol + 2, "", szImage, sizeof(szImage));
		pTF->GetInteger(nRow, nCol + 3, -1, &nObjIdx);
		// Three official VNG rows have an empty image path or omit the .spr
		// suffix.  Genre/detail plus the numeric object anchor remains stable,
		// so do not reject those valid material records solely for their image.
		if (nGenre == item_materials && nDetail >= 0 && nObjIdx >= 0)
		{
			nGenreCol = nCol;
			break;
		}
	}
	if (!nGenreCol)
		return FALSE;

	pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
	pTF->GetInteger(nRow, nGenreCol, item_materials, &pBuf->m_nItemGenre);
	pTF->GetInteger(nRow, nGenreCol + 1, 0, &pBuf->m_nDetailType);
	pTF->GetString(nRow, nGenreCol + 2, "", pBuf->m_szImageName,
								sizeof(pBuf->m_szImageName));
	pTF->GetInteger(nRow, nGenreCol + 3, 0, &pBuf->m_nObjIdx);
	pTF->GetInteger(nRow, nGenreCol + 4, 1, &pBuf->m_nWidth);
	pTF->GetInteger(nRow, nGenreCol + 5, 1, &pBuf->m_nHeight);
	pTF->GetString(nRow, nGenreCol + 6, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
	pTF->GetInteger(nRow, nGenreCol + 7, 0, &pBuf->m_nPrice);
	pTF->GetInteger(nRow, nGenreCol + 8, 1, &pBuf->m_nMaxStack);
	if (pBuf->m_nMaxStack <= 0)
		pBuf->m_nMaxStack = 1;
	pBuf->m_bShortKey = FALSE;
	pBuf->m_szScript[0] = 0;
	return TRUE;
}

const KBASICPROP_EVENTITEM* KBPT_Material::GetRecord(int i) const
{
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_EVENTITEM*)m_pBuf) + i) : NULL;
}

const KBASICPROP_EVENTITEM* KBPT_Material::FindRecord(IN int nDetailType) const
{
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_EVENTITEM* pData = GetRecord(i);
		if (pData && pData->m_nDetailType == nDetailType)
			return pData;
	}
	return NULL;
}
//============================================================================
KBPT_MagicScript::KBPT_MagicScript()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_MAGICSCRIPT);
	::strcpy(m_szTabFile, TABFILE_MAGICSCRIPT);
}

KBPT_MagicScript::~KBPT_MagicScript()
{
}

BOOL KBPT_MagicScript::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	KBASICPROP_MAGICSCRIPT* pBuf = (KBASICPROP_MAGICSCRIPT*)m_pBuf;
	pBuf = pBuf + i;			// ��������Լ��� pBuf ��ָ�ṹ��
	memset(pBuf, 0, sizeof(KBASICPROP_MAGICSCRIPT));
	if (m_bVersionedItemTable)
	{
		const int nRow = i + 2;
		if (pTF->GetWidth() < 20)
			return FALSE;

		// VNG's MagicScript is a 34-column table. In some historic TCVN3 rows
		// the separator between the item name and genre 6 was lost, leaving the
		// genre digit attached to the name. Locate the stable category,
		// particular and SPR anchor, then infer the known MagicScript genre when
		// that separator is absent.
		int nImageCol = 0;
		int nItemGenre = item_magicscript;
		BOOL bInferredGenre = FALSE;
		char szCell[SZBUFLEN_1];
		const int nMaxCol = pTF->GetWidth();
		for (int nCol = 3; nCol <= nMaxCol && nCol <= 12; nCol++)
		{
			int nDetail = -1, nParticular = -1;
			char szImage[SZBUFLEN_0];
			pTF->GetInteger(nRow, nCol - 2, -1, &nDetail);
			pTF->GetInteger(nRow, nCol - 1, -1, &nParticular);
			pTF->GetString(nRow, nCol, "", szImage, sizeof(szImage));
			if (nDetail >= 0 && nParticular >= 0 &&
				(strstr(szImage, ".spr") || strstr(szImage, ".SPR")))
			{
				int nParsedGenre = -1;
				if (nCol >= 4 &&
					pTF->GetInteger(nRow, nCol - 3, -1, &nParsedGenre) &&
					nParsedGenre >= 0 && nParsedGenre <= 16)
					nItemGenre = nParsedGenre;
				else
					bInferredGenre = TRUE;
				nImageCol = nCol;
				break;
			}
		}
		if (!nImageCol)
			return FALSE;

		pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
		pBuf->m_nItemGenre = nItemGenre;
		if (bInferredGenre)
		{
			const int nNameLength = strlen(pBuf->m_szName);
			if (item_magicscript >= 0 && item_magicscript <= 9 && nNameLength > 0 &&
				pBuf->m_szName[nNameLength - 1] == '0' + item_magicscript)
				pBuf->m_szName[nNameLength - 1] = 0;
		}
		// The column immediately before the SPR path is the unique VNG item key
		// used by AddItem/GetItemPartByID.
		pTF->GetInteger(nRow, nImageCol - 1, 0, &pBuf->m_nDetailType);
		pTF->GetString(nRow, nImageCol, "", pBuf->m_szImageName,
									sizeof(pBuf->m_szImageName));
		pTF->GetInteger(nRow, nImageCol + 1, 0, &pBuf->m_nObjIdx);
		pTF->GetInteger(nRow, nImageCol + 2, 1, &pBuf->m_nWidth);
		pTF->GetInteger(nRow, nImageCol + 3, 1, &pBuf->m_nHeight);
		pTF->GetString(nRow, nImageCol + 4, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));

		int nScriptCol = 0;
		for (int nScanCol = nImageCol + 10; nScanCol <= nMaxCol; nScanCol++)
		{
			pTF->GetString(nRow, nScanCol, "", szCell, sizeof(szCell));
			if (strstr(szCell, ".lua"))
			{
				nScriptCol = nScanCol;
				strncpy(pBuf->m_szScript, szCell, sizeof(pBuf->m_szScript) - 1);
				pBuf->m_szScript[sizeof(pBuf->m_szScript) - 1] = 0;
				break;
			}
		}
		pBuf->m_nPrice = 0;
		pBuf->m_bShortKey = FALSE;
		pBuf->m_nMaxStack = 1;
		if (nScriptCol > 4)
		{
			int nCanStack = 0;
			pTF->GetInteger(nRow, nScriptCol - 4, 0, &pBuf->m_nPrice);
			// VNG column 13 is a boolean "can stack" flag, not the old
			// runtime's numeric MaxStack field. Treating value 1 as MaxStack=1
			// made every VNG stackable MagicScript item non-stackable and broke
			// fixed-count Lua rewards such as 20/30 Thien Linh Thach.
			pTF->GetInteger(nRow, nScriptCol - 2, 0, &nCanStack);
			pBuf->m_nMaxStack = nCanStack ? 250 : 1;
			pTF->GetInteger(nRow, nScriptCol + 5, 0, &pBuf->m_bShortKey);
		}
		return TRUE;
	}
	const PROPINFO aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_CHAR,			pBuf->m_szScript, sizeof(pBuf->m_szScript)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_bShortKey), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nMaxStack), 0},
	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));
}

const KBASICPROP_MAGICSCRIPT* KBPT_MagicScript::GetRecord(IN int i) const
{
	_ASSERT(this != NULL);

	if (-1 == i)
		i = ::GetRandomNumber(0, m_nNumOfEntries-1);

	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_MAGICSCRIPT*)m_pBuf) + i) : NULL;
}


const KBASICPROP_MAGICSCRIPT* KBPT_MagicScript::FindRecord(IN int nType) const
{
	const KBASICPROP_MAGICSCRIPT* pData = NULL;
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_MAGICSCRIPT* pMed;
		pMed = GetRecord(i);
		_ASSERT(NULL != pMed);
		if (nType == pMed->m_nDetailType)
		{
			pData = pMed;
			break;
		}
	}
	return pData;
}
//============================================================================
KBPT_IBItem::KBPT_IBItem()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_IBITEM);
	::strcpy(m_szTabFile, TABFILE_IBITEM);
}

KBPT_IBItem::~KBPT_IBItem()
{
}

BOOL KBPT_IBItem::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	if (!pTF || pTF->GetWidth() < 30)
		return FALSE;

	KBASICPROP_IBITEM* pBuf = ((KBASICPROP_IBITEM*)m_pBuf) + i;
	memset(pBuf, 0, sizeof(*pBuf));
	const int nRow = i + 2;
	int nVngGenre = -1;
	int nImageCol = 0;
	char szImage[SZBUFLEN_0];
	for (int nCol = 4; nCol <= pTF->GetWidth() && nCol <= 10; nCol++)
	{
		pTF->GetString(nRow, nCol, "", szImage, sizeof(szImage));
		if (strstr(szImage, ".spr") || strstr(szImage, ".SPR"))
		{
			nImageCol = nCol;
			break;
		}
	}
	// The complete VNG table also contains server-side buff markers and a few
	// historical rows whose image field is blank or ends in .lua.  Their schema
	// is still the regular VNG IB-item schema (image is column 5); rejecting one
	// such internal row used to abort the whole Core registry at CoreGetShell.
	if (!nImageCol)
		nImageCol = 5;

	pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
	pTF->GetInteger(nRow, nImageCol - 3, -1, &nVngGenre);
	if (nVngGenre != 8)
	{
		// Some original TCVN3 rows lost the tab before genre 8.
		nVngGenre = 8;
		int nNameLength = strlen(pBuf->m_szName);
		if (nNameLength > 0 && pBuf->m_szName[nNameLength - 1] == '8')
			pBuf->m_szName[nNameLength - 1] = 0;
	}
	pTF->GetInteger(nRow, nImageCol - 2, -1, &pBuf->m_nDetailType);
	pTF->GetInteger(nRow, nImageCol - 1, -1, &pBuf->m_nParticularType);
	pTF->GetString(nRow, nImageCol, "", pBuf->m_szImageName, sizeof(pBuf->m_szImageName));
	pTF->GetInteger(nRow, nImageCol + 1, 0, &pBuf->m_nObjIdx);
	pTF->GetInteger(nRow, nImageCol + 2, 1, &pBuf->m_nWidth);
	pTF->GetInteger(nRow, nImageCol + 3, 1, &pBuf->m_nHeight);
	pTF->GetString(nRow, nImageCol + 4, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
	pTF->GetInteger(nRow, nImageCol + 5, 1, &pBuf->m_nUseCount);
	pTF->GetInteger(nRow, nImageCol + 6, 0, &pBuf->m_bCanStack);
	pTF->GetInteger(nRow, nImageCol + 7, 0, &pBuf->m_nPrice);
	pTF->GetString(nRow, nImageCol + 8, "", pBuf->m_szScript, sizeof(pBuf->m_szScript));
	pTF->GetInteger(nRow, nImageCol + 16, 0, &pBuf->m_bCanPick);
	pTF->GetInteger(nRow, nImageCol + 20, 0, &pBuf->m_bCanDrop);
	pTF->GetInteger(nRow, nImageCol + 22, 0, &pBuf->m_bCanTrade);
	pBuf->m_bCanSell = pBuf->m_bCanTrade;
	// engine2:D1 buff columns (seconds, 6 attribute pairs) for AddIBBuff; offsets from the image column like the
	// rest (column 5 in the regular rows: seconds = column 15, attributes = columns 31..42)
	pTF->GetInteger(nRow, nImageCol + 10, 0, &pBuf->m_nBuffSeconds);
	for (int nPtA = 0; nPtA < PT_IBITEM_BUFF_ATTRIBS; nPtA++)
	{
		pTF->GetInteger(nRow, nImageCol + 26 + nPtA * 2, 0, &pBuf->m_nBuffAttrib[nPtA]);
		pTF->GetInteger(nRow, nImageCol + 27 + nPtA * 2, 0, &pBuf->m_nBuffValue[nPtA]);
	}
	// One official transformation item leaves its inventory height empty. VNG
	// treats an omitted item footprint as one cell; normalize it before the
	// structural validation instead of rejecting the complete registry.
	if (pBuf->m_nWidth <= 0)
		pBuf->m_nWidth = 1;
	if (pBuf->m_nHeight <= 0)
		pBuf->m_nHeight = 1;

	if (nVngGenre != 8 || pBuf->m_nDetailType < 0 ||
		pBuf->m_nParticularType < 0 || pBuf->m_nWidth <= 0 ||
		pBuf->m_nHeight <= 0)
		return FALSE;
	pBuf->m_nItemGenre = item_ibitem;
	if (pBuf->m_nUseCount <= 0)
		pBuf->m_nUseCount = 1;
	return TRUE;
}

const KBASICPROP_IBITEM* KBPT_IBItem::GetRecord(IN int i) const
{
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_IBITEM*)m_pBuf) + i) : NULL;
}

const KBASICPROP_IBITEM* KBPT_IBItem::FindRecord(IN int nDetail, IN int nParticular) const
{
	const KBASICPROP_IBITEM* pUniqueDetail = NULL;
	int nDetailMatches = 0;
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_IBITEM* pData = GetRecord(i);
		if (pData && pData->m_nDetailType == nDetail &&
			pData->m_nParticularType == nParticular)
			return pData;
		if (pData && pData->m_nDetailType == nDetail)
		{
			pUniqueDetail = pData;
			++nDetailMatches;
		}
	}
	// The official VNG IB shop contains a few stale ParticularType values.
	// Resolve them only when the detail id identifies exactly one VNG record.
	return nDetailMatches == 1 ? pUniqueDetail : NULL;
}
//============================================================================
KBPT_TownPortal::KBPT_TownPortal()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_TOWNPORTAL);
	::strcpy(m_szTabFile, TABFILE_TOWNPORTAL);
}

KBPT_TownPortal::~KBPT_TownPortal()
{
}

BOOL KBPT_TownPortal::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	KBASICPROP_TOWNPORTAL* pBuf = (KBASICPROP_TOWNPORTAL*)m_pBuf;
	pBuf = pBuf + i;			// ��������Լ��� pBuf ��ָ�ṹ��
	memset(pBuf, 0, sizeof(KBASICPROP_TOWNPORTAL));
	if (m_bVersionedItemTable)
	{
		const int nRow = i + 2;
		if (pTF->GetWidth() < 12)
			return FALSE;
		int nImageCol = 3;
		char szProbe[SZBUFLEN_0];
		pTF->GetString(nRow, 2, "", szProbe, sizeof(szProbe));
		if (strstr(szProbe, ".spr") || strstr(szProbe, ".SPR"))
			nImageCol = 2;
		pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
		pBuf->m_nItemGenre = item_townportal;
		if (nImageCol == 2)
		{
			int nNameLength = strlen(pBuf->m_szName);
			if (nNameLength > 0 && pBuf->m_szName[nNameLength - 1] == '5')
				pBuf->m_szName[nNameLength - 1] = 0;
		}
		pBuf->m_nDetailType = 0;
		pTF->GetString(nRow, nImageCol, "", pBuf->m_szImageName,
									sizeof(pBuf->m_szImageName));
		pTF->GetInteger(nRow, nImageCol + 1, 0, &pBuf->m_nObjIdx);
		pTF->GetInteger(nRow, nImageCol + 2, 1, &pBuf->m_nWidth);
		pTF->GetInteger(nRow, nImageCol + 3, 1, &pBuf->m_nHeight);
		pTF->GetInteger(nRow, nImageCol + 4, 0, &pBuf->m_nPrice);
		pTF->GetString(nRow, nImageCol + 5, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
		pBuf->m_szScript[0] = 0;
		pBuf->m_bShortKey = FALSE;
		pTF->GetInteger(nRow, nImageCol + 6, 1, &pBuf->m_nMaxStack);
		return TRUE;
	}
	const PROPINFO aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_CHAR,			pBuf->m_szScript, sizeof(pBuf->m_szScript)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_bShortKey), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nMaxStack), 0},
	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));
}

const KBASICPROP_TOWNPORTAL* KBPT_TownPortal::GetRecord(IN int i) const
{
	_ASSERT(this != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_TOWNPORTAL*)m_pBuf) + i) : NULL;
}

//============================================================================
KBPT_Quest::KBPT_Quest()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_QUEST);
	::strcpy(m_szTabFile, TABFILE_TASK);
}

KBPT_Quest::~KBPT_Quest()
{
}

BOOL KBPT_Quest::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	KBASICPROP_QUEST* pBuf = (KBASICPROP_QUEST*)m_pBuf;
	pBuf = pBuf + i;			// ��������Լ��� pBuf ��ָ�ṹ��
	memset(pBuf, 0, sizeof(KBASICPROP_QUEST));
	if (m_bVersionedItemTable)
	{
		const int nRow = i + 2;
		if (pTF->GetWidth() < 10)
			return FALSE;
		pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
		pTF->GetInteger(nRow, 2, 0, &pBuf->m_nItemGenre);
		pTF->GetInteger(nRow, 3, 0, &pBuf->m_nDetailType);
		pTF->GetString(nRow, 4, "", pBuf->m_szImageName,
									sizeof(pBuf->m_szImageName));
		pTF->GetInteger(nRow, 5, 0, &pBuf->m_nObjIdx);
		pTF->GetInteger(nRow, 6, 1, &pBuf->m_nWidth);
		pTF->GetInteger(nRow, 7, 1, &pBuf->m_nHeight);
		pTF->GetString(nRow, 8, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
		pBuf->m_nPrice = 0;
		pBuf->m_bShortKey = FALSE;
		pTF->GetInteger(nRow, 10, 1, &pBuf->m_nMaxStack);
		return TRUE;
	}
	const PROPINFO aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_bShortKey), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nMaxStack), 0},
	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));

}

const KBASICPROP_QUEST* KBPT_Quest::GetRecord(IN int i) const
{
	_ASSERT(this != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_QUEST*)m_pBuf) + i) : NULL;

}

const KBASICPROP_QUEST* KBPT_Quest::FindRecord(IN int nDetailType) const
{
	const KBASICPROP_QUEST* pData = NULL;
	// ����ʹ��˳����ҵ��㷨. ��ԭʼ�����ǰ�m_nDetailType�����,
	// ��ɽ����㷨�Ż�
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_QUEST* pQst;
		pQst = GetRecord(i);
		_ASSERT(NULL != pQst);
		if (nDetailType == pQst->m_nDetailType)
		{
			// ���ݲ߻������, ����1���� == �������. ������֤
//			_ASSERT(nType == pMed->m_nAttrib1_Type);
			pData = pQst;
			break;
		}
	}
	return pData;
}

//============================================================================

KBPT_Medicine::KBPT_Medicine()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_MEDICINE);
	::strcpy(m_szTabFile, TABFILE_MEDICINE);
}

KBPT_Medicine::~KBPT_Medicine()
{
}

BOOL KBPT_Medicine::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	// ��ʼ��
	KBASICPROP_MEDICINE* pBuf = (KBASICPROP_MEDICINE*)m_pBuf;
	pBuf = pBuf + i;	// ��������Լ��� pBuf ��ָ�ṹ��
	memset(pBuf, 0, sizeof(KBASICPROP_MEDICINE));
	if (m_bVersionedItemTable)
	{
		const int nRow = i + 2;
		if (pTF->GetWidth() < 20)
			return FALSE;
		pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
		pTF->GetInteger(nRow, 2, 0, &pBuf->m_nItemGenre);
		pTF->GetInteger(nRow, 3, 0, &pBuf->m_nDetailType);
		pTF->GetInteger(nRow, 4, 0, &pBuf->m_nParticularType);
		pTF->GetString(nRow, 5, "", pBuf->m_szImageName,
									sizeof(pBuf->m_szImageName));
		pTF->GetInteger(nRow, 6, 0, &pBuf->m_nObjIdx);
		pTF->GetInteger(nRow, 7, 1, &pBuf->m_nWidth);
		pTF->GetInteger(nRow, 8, 1, &pBuf->m_nHeight);
		pTF->GetString(nRow, 9, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
		pTF->GetInteger(nRow, 10, 0, &pBuf->m_nSeries);
		pTF->GetInteger(nRow, 11, 0, &pBuf->m_nPrice);
		pTF->GetInteger(nRow, 12, 0, &pBuf->m_nLevel);
		pTF->GetInteger(nRow, 13, 1, &pBuf->m_nMaxStack);
		for (int n = 0; n < 2; ++n)
		{
			const int nCol = 15 + n * 3;
			pTF->GetInteger(nRow, nCol, 0, &pBuf->m_aryAttrib[n].nAttrib);
			pTF->GetInteger(nRow, nCol + 1, 0, &pBuf->m_aryAttrib[n].nValue);
			pTF->GetInteger(nRow, nCol + 2, 0, &pBuf->m_aryAttrib[n].nTime);
		}
		return TRUE;
	}
	const PROPINFO	aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nParticularType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nSeries), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nLevel), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nMaxStack), 0},

		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[0].nAttrib), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[0].nValue), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[0].nTime), 0},

		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[1].nAttrib), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[1].nValue), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryAttrib[1].nTime), 0},
	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));
}

/******************************************************************************
	����:	��ȡָ����ҩƷ������
	���:	i: Ҫ���ȡ��i��ҩƷ������
	����:	�ɹ�ʱ����ָ���ҩ�����Ե�ָ��(һ��KBASICPROP_MEDICINE�ṹ)
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_MEDICINE* KBPT_Medicine::GetRecord(int i) const
{
	_ASSERT(this != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_MEDICINE*)m_pBuf) + i) : NULL;
}

const KBASICPROP_MEDICINE* KBPT_Medicine::FindRecord(IN int nType,
													 IN int nLevel) const
{
	if (nType < 0 || nLevel < 1)
		return NULL;
	const KBASICPROP_MEDICINE* pData = NULL;
	// ����ʹ��˳����ҵ��㷨. ��ԭʼ�����ǰ�m_nDetailType��m_nLevel�����,
	// ��ɽ����㷨�Ż�
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_MEDICINE* pMed;
		pMed = GetRecord(i);
		_ASSERT(NULL != pMed);
		if (nType == pMed->m_nDetailType && nLevel == pMed->m_nLevel)
		{
			// ���ݲ߻������, ����1���� == �������. ������֤
//			_ASSERT(nType == pMed->m_nAttrib1_Type);
			// Current VNG potion.txt is keyed by DetailType/Level, not five
			// positional levels per category. The generator has no particular
			// argument: reject ambiguous or unsupported variants, never guess.
			if (pData || pMed->m_nItemGenre != item_medicine ||
				pMed->m_nParticularType != 0 || !pMed->m_szName[0] ||
				pMed->m_nWidth <= 0 || pMed->m_nHeight <= 0)
				return NULL;
			pData = pMed;
		}
	}
	return pData;
}
//======================================================

KBPT_SkillBook::KBPT_SkillBook()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_SKILLBOOK);
	strcpy(m_szTabFile, TABFILE_SKILLBOOK);
}

BOOL KBPT_SkillBook::LoadRecord(int row, KTabFile* table)
{
	if (!table || !m_bVersionedItemTable || table->GetWidth() < 22 ||
		row < 0 || row >= m_nNumOfEntries)
		return FALSE;
	KBASICPROP_SKILLBOOK* item = ((KBASICPROP_SKILLBOOK*)m_pBuf) + row;
	memset(item, 0, sizeof(*item));
	const int line = row + 2;
	table->GetString(line, 1, "", item->m_szName, sizeof(item->m_szName));
	table->GetInteger(line, 2, -1, &item->m_nItemGenre);
	table->GetInteger(line, 3, -1, &item->m_nDetailType);
	table->GetInteger(line, 4, -1, &item->m_nParticularType);
	table->GetString(line, 5, "", item->m_szImageName, sizeof(item->m_szImageName));
	table->GetInteger(line, 6, 0, &item->m_nObjIdx);
	table->GetInteger(line, 7, 0, &item->m_nWidth);
	table->GetInteger(line, 8, 0, &item->m_nHeight);
	table->GetString(line, 9, "", item->m_szIntro, sizeof(item->m_szIntro));
	table->GetInteger(line, 10, 0, &item->m_nPrice);
	table->GetInteger(line, 11, 0, &item->m_nMaxStack);
	table->GetInteger(line, 12, 0, &item->m_nWeight);
	table->GetInteger(line, 16, 0, &item->m_bCanDrop);
	table->GetInteger(line, 17, 0, &item->m_bCanTrade);
	table->GetInteger(line, 18, 0, &item->m_bCanGamble);
	table->GetInteger(line, 19, 0, &item->m_bCanStall);
	table->GetInteger(line, 22, 0, &item->m_bCanSell);
	if (item->m_nMaxStack < 1)
		item->m_nMaxStack = 1;
	return item->m_nItemGenre == item_skillbook && item->m_nDetailType >= 0 &&
		item->m_nParticularType > 0 && item->m_szName[0] &&
		item->m_nWidth > 0 && item->m_nHeight > 0;
}

const KBASICPROP_SKILLBOOK* KBPT_SkillBook::GetRecord(int row) const
{
	return row >= 0 && row < m_nNumOfEntries ?
		((KBASICPROP_SKILLBOOK*)m_pBuf) + row : NULL;
}

const KBASICPROP_SKILLBOOK* KBPT_SkillBook::FindRecord(int detail, int skill) const
{
	if (detail < 0 || skill <= 0)
		return NULL;
	const KBASICPROP_SKILLBOOK* found = NULL;
	for (int row = 0; row < m_nNumOfEntries; ++row)
	{
		const KBASICPROP_SKILLBOOK* item = GetRecord(row);
		if (item && item->m_nDetailType == detail && item->m_nParticularType == skill)
		{
			if (found)
				return NULL;
			found = item;
		}
	}
	return found;
}

KBPT_Equipment::KBPT_Equipment()
{
	m_nSizeOfEntry = sizeof(KBASICPROP_EQUIPMENT);
}

KBPT_Equipment::~KBPT_Equipment()
{
}

void KBPT_Equipment::Init(IN int i)
{
	::strcpy(m_szTabFile, TABFILE_EQUIPMENT[i]);
}

BOOL KBPT_Equipment::LoadRecord(int i, KTabFile* pTF)
{
	_ASSERT(pTF != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);

	// ��ʼ��
	KBASICPROP_EQUIPMENT* pBuf = (KBASICPROP_EQUIPMENT*)m_pBuf;
	pBuf = pBuf + i;	// ��������Լ��� pBuf ��ָ�ṹ��
	memset(pBuf, 0, sizeof(KBASICPROP_EQUIPMENT));
	pBuf->m_nCanDrop = 1;
	pBuf->m_nCanTrade = 1;
	pBuf->m_nCanGamble = 1;
	pBuf->m_nCanStall = 1;
	pBuf->m_nCanSell = 1;

	if (m_bVersionedItemTable)
	{
		const int nRow = i + 2;
		const int nWidth = pTF->GetWidth();
		if (nWidth < 13)
			return FALSE;
		int nColumnShift = 0;
		char szColumn4[SZBUFLEN_0];
		szColumn4[0] = 0;
		pTF->GetString(nRow, 4, "", szColumn4, sizeof(szColumn4));
		// The original VNG melee table contains 117 records where the fixed
		// detail-type zero is omitted and the SPR path starts at column 4.
		// Keep the payload byte-exact and adapt the reader for those rows.
		const BOOL bVngMeleeShortRow =
			!_stricmp(m_szTabFile, TABFILE_MELEEWEAPON) &&
			(szColumn4[0] == '\\' || szColumn4[0] == '/');
		if (bVngMeleeShortRow)
			nColumnShift = -1;

		// Columns 1..12 are common to the legacy and Phong Than schemas.
		pTF->GetString(nRow, 1, "", pBuf->m_szName, sizeof(pBuf->m_szName));
		pTF->GetInteger(nRow, 2, 0, &pBuf->m_nItemGenre);
		if (bVngMeleeShortRow)
		{
			pBuf->m_nDetailType = equip_meleeweapon;
			pTF->GetInteger(nRow, 3, 0, &pBuf->m_nParticularType);
		}
		else
		{
			pTF->GetInteger(nRow, 3, 0, &pBuf->m_nDetailType);
			pTF->GetInteger(nRow, 4, 0, &pBuf->m_nParticularType);
		}
		pTF->GetString(nRow, 5 + nColumnShift, "", pBuf->m_szImageName,
										sizeof(pBuf->m_szImageName));
		pTF->GetInteger(nRow, 6 + nColumnShift, 0, &pBuf->m_nObjIdx);
		pTF->GetInteger(nRow, 7 + nColumnShift, 1, &pBuf->m_nWidth);
		pTF->GetInteger(nRow, 8 + nColumnShift, 1, &pBuf->m_nHeight);
		pTF->GetString(nRow, 9 + nColumnShift, "", pBuf->m_szIntro, sizeof(pBuf->m_szIntro));
		pTF->GetInteger(nRow, 10 + nColumnShift, 0, &pBuf->m_nSeries);
		pTF->GetInteger(nRow, 11 + nColumnShift, 0, &pBuf->m_nPrice);
		pTF->GetInteger(nRow, 12 + nColumnShift, 0, &pBuf->m_nLevel);

		pTF->GetInteger(nRow, 13 + nColumnShift, 0, &pBuf->m_nStackable);
		PhongThanReadEquipmentColumns(pTF, nRow, nColumnShift, pBuf);
		return TRUE;
	}

	const PROPINFO	aryPI[] =
	{
		{ PI_VARTYPE_CHAR,			pBuf->m_szName, sizeof(pBuf->m_szName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nItemGenre), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nDetailType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nParticularType), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szImageName, sizeof(pBuf->m_szImageName)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nObjIdx), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nWidth), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nHeight), 0},
		{ PI_VARTYPE_CHAR,			pBuf->m_szIntro, sizeof(pBuf->m_szIntro)},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nSeries), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nPrice), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_nLevel), 0},

		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[0].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[0].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[0].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[1].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[1].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[1].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[2].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[2].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[2].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[3].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[3].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[3].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[4].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[4].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[4].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[5].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[5].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[5].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[6].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[6].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[6].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[7].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[7].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[7].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[8].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[8].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[8].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[9].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[9].sRange.nMin), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropBasic[9].sRange.nMax), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[0].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[0].nPara), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[1].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[1].nPara), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[2].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[2].nPara), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[3].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[3].nPara), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[4].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[4].nPara), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[5].nType), 0},
		{ PI_VARTYPE_INT,  (char*)&(pBuf->m_aryPropReq[5].nPara), 0},

	};

	// ��������������
	return ::LoadRecord(pTF, i, aryPI, sizeof(aryPI)/ sizeof(aryPI[0]));
}

/******************************************************************************
	����:	��ȡָ����װ��������
	���:	i: Ҫ���ȡ��i��װ��������
	����:	�ɹ�ʱ����ָ���װ�����Ե�ָ��(һ��KBASICPROP_EQUIPMENT�ṹ)
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_EQUIPMENT* KBPT_Equipment::GetRecord(int i) const
{
	_ASSERT(this != NULL);
	_ASSERT(i >= 0 && i < m_nNumOfEntries);
	return (i >= 0 && i < m_nNumOfEntries) ?
		(((KBASICPROP_EQUIPMENT*)m_pBuf) + i) : NULL;
}

/******************************************************************************
	����:	��ȡָ����װ�����Լ�¼
	���:	nDetailType: �������
			nParticularType: ��ϸ���
			nLevel: �ȼ�
	����:	�ɹ�ʱ����ָ��ü�¼��ָ��
			ʧ��ʱ����NULL
******************************************************************************/
const KBASICPROP_EQUIPMENT* KBPT_Equipment::FindRecord( IN int nDetailType,
														IN int nParticularType,
														IN int nLevel) const
{
	_ASSERT(this != NULL);
	
	const KBASICPROP_EQUIPMENT* pData = NULL;
	// ����ʹ��˳����ҵ��㷨. ��ԭʼ�����ǰ�m_nDetailType��m_nLevel�����,
	// ��ɽ����㷨�Ż�
	for (int i = 0; i < m_nNumOfEntries; i++)
	{
		const KBASICPROP_EQUIPMENT* pEqu;
		pEqu = GetRecord(i);
		_ASSERT(NULL != pEqu);
		if (nDetailType == pEqu->m_nDetailType &&
			nParticularType == pEqu->m_nParticularType &&
			nLevel == pEqu->m_nLevel)
		{
			pData = pEqu;
			break;
		}
	}
	return pData;
}

