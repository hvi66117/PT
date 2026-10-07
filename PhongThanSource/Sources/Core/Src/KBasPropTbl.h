//---------------------------------------------------------------------------
// Sword3 Core (c) 2002 by Kingsoft
//
// File:	KBasPropTbl.h
// Date:	2002.08.14
// Code:	DongBo
// Desc:    header file. ���ļ�����������ڴ�tab file�ж������ߵĳ�ʼ����,
//			�����ɶ�Ӧ�����Ա�
//---------------------------------------------------------------------------

#ifndef	KBasPropTblH
#define	KBasPropTblH

#define		SZBUFLEN_0	80		// ���͵��ַ�������������
#define		SZBUFLEN_1	1024		// ���͵��ַ�������������

#define		MAX_MAGIC_PREFIX	20
#define		MAX_MAGIC_SUFFIX	20

// Resolve every basic item table through the single registry selected by
// settings\item\itemversion.ini.  The helper returns FALSE when the registry
// is missing, selects a version other than ITEM_VERSION, or the output buffer
// is too small.
int GetActiveItemTableVersion();
BOOL BuildActiveItemTablePath(const char* pszFile, char* pszPath, int nPathSize);
// ���½ṹ����������ʯ�Ļ�������. ��������������ļ�(tab file)�ṩ
typedef struct
{
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nItemGenre;				// ��������
	int			m_nDetailType;				// �������
	char		m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int			m_nObjIdx;					// ��Ӧ�������
	int			m_nWidth;					// ����������ռ����
	int			m_nHeight;					// ����������ռ�߶�
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	char		m_szScript[SZBUFLEN_1];		// ˵������
	int			m_nPrice;					// �۸�
	BOOL		m_bShortKey;
	int			m_nMaxStack;
} KBASICPROP_EVENTITEM;

// ���½ṹ��������ҩƷ���Ե����ԣ���ֵ��ʱ��
typedef struct
{
	int			nAttrib;
	int			nValue;
	int			nTime;
} KMEDATTRIB;

// ���½ṹ��������ҩƷ�Ļ�������. ��������������ļ�(tab file)�ṩ
// ����������ҩƷ: ����������,����������,����������,��ҩ��,�ⶾ��,
//					��ȼ����,�������
typedef struct
{
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nItemGenre;				// ��������
	int			m_nDetailType;				// �������
	int			m_nParticularType;			// ��ϸ���
	char		m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int			m_nObjIdx;					// ��Ӧ�������
	int			m_nWidth;					// ����������ռ����
	int			m_nHeight;					// ����������ռ�߶�
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	int			m_nSeries;					// ��������
	int			m_nPrice;					// �۸�
	int			m_nLevel;					// �ȼ�
	int			m_nMaxStack;
	KMEDATTRIB	m_aryAttrib[2];				// ҩƷ������
} KBASICPROP_MEDICINE;

// ���½ṹ��������һ�����,��Сֵ
typedef struct
{
	int			nMin;
	int			nMax;
} KMINMAXPAIR;

// ���½ṹ���ڸ���װ���ĺ��Ĳ���: ��������
typedef struct
{
	int			nType;						// ��������
	KMINMAXPAIR	sRange;						// ȡֵ��Χ
} KEQCP_BASIC;	// Equipment_CorePara_Basic

// Phong Than VNG stores the hidden equipment attributes as one type plus
// three fixed parameters. AttrValue_n_0..2 are parameters, not a min/max
// range; copying them verbatim is required for deterministic set effects.
#define		MAX_VNG_SET_ATTRIB	10
#define		MAX_VNG_SET_ATTRIB_RECORDS	4096
typedef struct
{
	int			nType;
	int			nValue[3];
} KEQCP_VNG_FIXED;

typedef struct
{
	int			m_nGroupId;
	KEQCP_VNG_FIXED m_aryAttrib[MAX_VNG_SET_ATTRIB];
} KBASICPROP_VNG_SETATTRIB;

// ���½ṹ���ڸ���װ���ĺ��Ĳ���: ��������
typedef struct
{
	int			nType;						// ��������
	int			nPara;						// ��ֵ
} KEQCP_REQ;	// Equipment_CorePara_Requirment

// ���½ṹ���ڸ���ħ���ĺ��Ĳ���
typedef struct
{
	int			nPropKind;					// �޸ĵ��������ͣ���ͬһ����ֵ�ӰٷֱȺͼӵ�������Ϊ���������ԣ�
	KMINMAXPAIR	aryRange[3];				// �޸���������ļ�������
} KMACP;	// MagicAttrib_CorePara

// ���½ṹ�������������ļ��и�����ħ������. ��������������ļ�(tab file)�ṩ
// Add by Freeway Chen in 2003.5.30
// ���½ṹ��������ħ������. ��������������ļ�(tab file)�ṩ
/*
typedef struct
{
	int			m_nPos;						// ǰ׺���Ǻ�׺
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nClass;					// ����Ҫ��
	int			m_nLevel;					// �ȼ�Ҫ��
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	KMACP		m_MagicAttrib;				// ���Ĳ���
	int			m_DropRate;					// ���ָ���
} KMAGICATTRIB;
*/
// ���½ṹ��������װ���ĳ�ʼ����. ��������������ļ�(tab file)�ṩ
typedef struct
{
	char			m_szName[SZBUFLEN_0];		// ����
	int				m_nItemGenre;				// �������� (����? ҩƷ? ��ʯ?)
	int				m_nDetailType;				// �������
	int				m_nParticularType;			// ��ϸ���
	char			m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int				m_nObjIdx;					// ��Ӧ�������
	int				m_nWidth;					// ����������ռ����
	int				m_nHeight;					// ����������ռ�߶�
	char			m_szIntro[SZBUFLEN_1];		// ˵������
	int				m_nSeries;					// ��������
	int				m_nPrice;					// �۸�
	int				m_nLevel;					// �ȼ�
	KEQCP_BASIC		m_aryPropBasic[MAX_ITEM_BASEATTRIB];	// VNG basic properties (up to 20)
	KEQCP_REQ		m_aryPropReq[6];			// ��������
	// Phong Than item\NNN tables append these fields around/after the
	// legacy equipment schema.  Keeping them in the base record lets both
	// server and client consume the same VNG table without shifting the
	// property and requirement columns.
	int				m_nStackable;
	int				m_nWeight;
	int				m_nCopperPrice;
	int				m_nHasSpecialImage;
	int				m_nSpecialSex;
	int				m_nCanDrop;
	int				m_nCanTrade;
	int				m_nCanGamble;
	int				m_nCanStall;
	int				m_nPkDropFlag;
	int				m_nExistTime;
	int				m_nCanSell;
	int				m_nEquipId;
	// Preserve source expression until the power evaluator consumes it.
	int				m_nBasePowerKind;
	int				m_nBasePowerFirst;
	int				m_nBasePowerSecond;
	int				m_nBasePower;
	int				m_nMagicPower;
	int				m_nSetId;
} KBASICPROP_EQUIPMENT;


// ���½ṹ��������Ψһװ���ĳ�ʼ����. ��������������ļ�(tab file)�ṩ
typedef struct
{
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nItemGenre;				// ��������
	int			m_nDetailType;				// �������
	char		m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int			m_nObjIdx;					// ��Ӧ�������
	int			m_nWidth;					// ����������ռ����
	int			m_nHeight;					// ����������ռ�߶�
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	int			m_nPrice;
	BOOL		m_bShortKey;
	int			m_nMaxStack;					// �Ƿ�ɵ���
} KBASICPROP_QUEST;

// Original VNG item/001/skillbook.txt. ParticularType is the skill ID;
// DetailType is the book identity. There is no level/series column.
typedef struct
{
	char m_szName[SZBUFLEN_0];
	int m_nItemGenre;
	int m_nDetailType;
	int m_nParticularType;
	char m_szImageName[SZBUFLEN_0];
	int m_nObjIdx;
	int m_nWidth;
	int m_nHeight;
	char m_szIntro[SZBUFLEN_1];
	int m_nPrice;
	int m_nMaxStack;
	int m_nWeight;
	BOOL m_bCanDrop;
	BOOL m_bCanTrade;
	BOOL m_bCanGamble;
	BOOL m_bCanStall;
	BOOL m_bCanSell;
} KBASICPROP_SKILLBOOK;

typedef struct
{
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nItemGenre;				// ��������
	int			m_nDetailType;				// �������
	char		m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int			m_nObjIdx;					// ��Ӧ�������
	int			m_nWidth;					// ����������ռ����
	int			m_nHeight;					// ����������ռ�߶�
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	char		m_szScript[SZBUFLEN_1];		// ˵������
	int			m_nPrice;
	BOOL		m_bShortKey;
	int			m_nMaxStack;					// �Ƿ�ɵ���
} KBASICPROP_TOWNPORTAL;

typedef struct
{
	char		m_szName[SZBUFLEN_0];		// ����
	int			m_nItemGenre;				// ��������
	int			m_nDetailType;				// �������
	char		m_szImageName[SZBUFLEN_0];	// �����еĶ����ļ���
	int			m_nObjIdx;					// ��Ӧ�������
	int			m_nWidth;					// ����������ռ����
	int			m_nHeight;					// ����������ռ�߶�
	char		m_szIntro[SZBUFLEN_1];		// ˵������
	char		m_szScript[SZBUFLEN_1];		// ˵������s
	int			m_nPrice;					// �۸�
	BOOL		m_bShortKey;
	int			m_nMaxStack;
} KBASICPROP_MAGICSCRIPT;

#define PT_IBITEM_BUFF_ATTRIBS	6	// engine2:D1 attribute pairs of an ibitem row (columns 31..42)
// Phong Than VNG Internet-billing item (settings\item\NNN\ibitem.txt).
typedef struct
{
	char		m_szName[SZBUFLEN_0];
	int			m_nItemGenre;
	int			m_nDetailType;
	int			m_nParticularType;
	char		m_szImageName[SZBUFLEN_0];
	int			m_nObjIdx;
	int			m_nWidth;
	int			m_nHeight;
	char		m_szIntro[SZBUFLEN_1];
	int			m_nUseCount;
	BOOL		m_bCanStack;
	int			m_nPrice;
	char		m_szScript[SZBUFLEN_1];
	BOOL		m_bCanPick;
	BOOL		m_bCanDrop;
	BOOL		m_bCanTrade;
	BOOL		m_bCanSell;
	// engine2:D1 2026-10-04 VNG buff columns: AddIBBuff(id) applies the effect of ibitem 8/id (ScriptFuns.cpp)
	int			m_nBuffSeconds;									// column 15, seconds
	int			m_nBuffAttrib[PT_IBITEM_BUFF_ATTRIBS];			// columns 31, 33 .. 41: magic attribute id
	int			m_nBuffValue[PT_IBITEM_BUFF_ATTRIBS];			// columns 32, 34 .. 42: value
} KBASICPROP_IBITEM;
//=============================================================================

class KBasicPropertyTable			// ��д: BPT,����������
{
public:
	KBasicPropertyTable();
	~KBasicPropertyTable();

// �����Ǻ��ĳ�Ա����
protected:
	void*		m_pBuf;						// ָ�����Ա���������ָ��
											// ���Ա���һ���ṹ����,
											// ��������������������
	int			m_nNumOfEntries;			// ���Ա����ж���������
	BOOL		m_bVersionedItemTable;		// loaded from settings\item\NNN
	int			m_nItemTableVersion;

// �����Ǹ����Եĳ�Ա����
    int         m_nSizeOfEntry;				// ÿ�����ݵĴ�С(���ṹ�Ĵ�С)
	char		m_szTabFile[MAX_PATH];		// tabfile���ļ���

// �����Ƕ���ӿ�
public:
	virtual BOOL Load();					// ��tabfile�ж�����ʼ����ֵ, �������Ա�
	int NumOfEntries() const { return m_nNumOfEntries; }

// �����Ǹ�������
protected:
	BOOL GetMemory();
	void ReleaseMemory();
	void SetCount(int);
	virtual BOOL LoadRecord(int i, KTabFile* pTF) = 0;
};

class KBPT_Event : public KBasicPropertyTable
{
public:
	KBPT_Event();
	~KBPT_Event();

public:
	const KBASICPROP_EVENTITEM* GetRecord(IN int) const;
	const KBASICPROP_EVENTITEM* FindRecord(IN int) const;
protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KBPT_Material : public KBasicPropertyTable
{
public:
	KBPT_Material();
	~KBPT_Material();

public:
	const KBASICPROP_EVENTITEM* GetRecord(IN int) const;
	const KBASICPROP_EVENTITEM* FindRecord(IN int) const;
protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KBPT_TownPortal : public KBasicPropertyTable
{
public:
	KBPT_TownPortal();
	~KBPT_TownPortal();

// �����Ƕ���ӿ�
public:
	const KBASICPROP_TOWNPORTAL* GetRecord(IN int) const;

protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

// =====>ҩ��<=====
// =====>ҩƷ<=====
class KBPT_Medicine : public KBasicPropertyTable
{
public:
	KBPT_Medicine();
	~KBPT_Medicine();

// �����Ƕ���ӿ�
public:
	const KBASICPROP_MEDICINE* GetRecord(IN int) const;
	const KBASICPROP_MEDICINE* FindRecord(IN int, IN int) const;

// �����Ǹ�������
protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

// =====>������Ʒ<=====
class KBPT_Quest : public KBasicPropertyTable
{
public:
	KBPT_Quest();
	~KBPT_Quest();

// �����Ƕ���ӿ�
public:
	const KBASICPROP_QUEST* GetRecord(IN int) const;
	const KBASICPROP_QUEST* FindRecord(IN int) const;

protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KBPT_MagicScript : public KBasicPropertyTable
{
public:
	KBPT_MagicScript();
	~KBPT_MagicScript();

// �����Ƕ���ӿ�
public:
	const KBASICPROP_MAGICSCRIPT* GetRecord(IN int) const;
	const KBASICPROP_MAGICSCRIPT* FindRecord(IN int) const;

protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KBPT_IBItem : public KBasicPropertyTable
{
public:
	KBPT_IBItem();
	~KBPT_IBItem();
	const KBASICPROP_IBITEM* GetRecord(IN int) const;
	const KBASICPROP_IBITEM* FindRecord(IN int, IN int) const;
protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KBPT_SkillBook : public KBasicPropertyTable
{
public:
	KBPT_SkillBook();
	const KBASICPROP_SKILLBOOK* GetRecord(int row) const;
	const KBASICPROP_SKILLBOOK* FindRecord(int detail, int skill) const;
protected:
	virtual BOOL LoadRecord(int row, KTabFile* table);
};

class KBPT_Equipment : public KBasicPropertyTable
{
public:
	KBPT_Equipment();
	~KBPT_Equipment();

// �����Ƕ���ӿ�
public:
	const KBASICPROP_EQUIPMENT* GetRecord(IN int) const;
	const KBASICPROP_EQUIPMENT* FindRecord(IN int, IN int, IN int) const;
	void Init(IN int);
// �����Ǹ�������
protected:
	virtual BOOL LoadRecord(int i, KTabFile* pTF);
};

class KLibOfBPT
{
public:
	const KBASICPROP_MAGICSCRIPT* MagicScriptAt(int row) const { return m_BPTMagicScript.GetRecord(row); }
	const KBASICPROP_IBITEM* IBItemAt(int row) const { return m_BPTIBItem.GetRecord(row); }
	const KBASICPROP_EVENTITEM* MaterialAt(int row) const { return m_BPTMaterial.GetRecord(row); }
	const KBASICPROP_QUEST* QuestAt(int row) const { return m_BPTQuest.GetRecord(row); }
	const KBASICPROP_SKILLBOOK* SkillBookAt(int row) const { return m_BPTSkillBook.GetRecord(row); }
	KLibOfBPT();
	~KLibOfBPT();

// �����Ǻ��ĳ�Ա����
protected:
	KBPT_Medicine			m_BPTMedicine;
	KBPT_MagicScript		m_BPTMagicScript;
	KBPT_IBItem				m_BPTIBItem;
	KBPT_Event				m_BPTEvent;
	KBPT_Material			m_BPTMaterial;
	KBPT_Quest				m_BPTQuest;
	KBPT_SkillBook			m_BPTSkillBook;
	KBPT_TownPortal			m_BPTTownPortal;
	KBPT_Equipment			m_BPTHorse;
	KBPT_Equipment			m_BPTMeleeWeapon;
	KBPT_Equipment			m_BPTRangeWeapon;
	KBPT_Equipment			m_BPTArmor;
	KBPT_Equipment			m_BPTHelm;
	KBPT_Equipment			m_BPTBoot;
	KBPT_Equipment			m_BPTBelt;
	KBPT_Equipment			m_BPTAmulet;
	KBPT_Equipment			m_BPTRing;
	KBPT_Equipment			m_BPTCuff;
	KBPT_Equipment			m_BPTPendant;
	KBPT_Equipment			m_BPTSignet;
	KBPT_Equipment			m_BPTShipin;
	// Add By Minh Kiem
    // Add by Freeway Chen in 2003.5.30
	// ��ά�ֱ�Ϊǰ��׺����Ʒ���͡����С�����
	KBASICPROP_VNG_SETATTRIB	m_VngSetAttrib[MAX_VNG_SET_ATTRIB_RECORDS];
	int						m_nVngSetAttribCount;

// �����Ƕ���ӿ�
public:
	BOOL Init();
    
    // Add by Freeway Chen in 2003.5.30
	// Add By Minh Kiem

	const KBASICPROP_EQUIPMENT*	GetMeleeWeaponRecord(IN int) const;
	const int					GetMeleeWeaponRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetRangeWeaponRecord(IN int) const;
	const int					GetRangeWeaponRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetArmorRecord(IN int) const;
	const int					GetArmorRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetHelmRecord(IN int) const;
	const int					GetHelmRecordNumber() const;
	const KBASICPROP_EQUIPMENT* GetBootRecord(IN int) const;
	const int					GetBootRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetBeltRecord(IN int) const;
	const int					GetBeltRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetAmuletRecord(IN int) const;
	const int					GetAmuletRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetRingRecord(IN int) const;
	const int					GetRingRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetCuffRecord(IN int) const;
	const int					GetCuffRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetPendantRecord(IN int) const;
	const int					GetPendantRecordNumber() const;
	const KBASICPROP_EQUIPMENT* GetHorseRecord(IN int) const;
	const int					GetHorseRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetSignetRecord(IN int) const;
	const int					GetSignetRecordNumber() const;
	const KBASICPROP_EQUIPMENT*	GetShipinRecord(IN int) const;
	const int					GetShipinRecordNumber() const;
	const KBASICPROP_MEDICINE*	GetMedicineRecord(IN int) const;
	const int					GetMedicineRecordNumber() const;
	const KBASICPROP_MEDICINE*	FindMedicine(IN int, IN int) const;
	const KBASICPROP_QUEST*		GetQuestRecord(IN int) const;
	const int					GetQuestRecordNumber() const;
	const KBASICPROP_SKILLBOOK* GetSkillBook(int detail, int skill) const;
	int GetSkillBookRecordNumber() const;
	const KBASICPROP_TOWNPORTAL*	GetTownPortalRecord(IN int) const;
	const int					GetTownPortalRecordNumber() const;
	const KBASICPROP_MAGICSCRIPT*	GetMagicScript(IN int) const;
	const int					GetMagicScriptRecordNumber() const;
	const KBASICPROP_IBITEM*	GetIBItem(IN int, IN int) const;
	const int					GetIBItemRecordNumber() const;
	const KBASICPROP_EVENTITEM*	GetEvent(IN int) const;
	const int					GetEventRecordNumber() const;
	const KBASICPROP_EVENTITEM*	GetMaterial(IN int) const;
	const int					GetMaterialRecordNumber() const;
	// Copy the ordered, non-empty fixed VNG set attributes for a group id.
	int						GetVngSetAttrib(IN int nGroupId,
											OUT KEQCP_VNG_FIXED* pOut,
											IN int nMax) const;
// �����Ǹ�������
protected:
	BOOL InitVngSetAttrib();
    
    // Add by Freeway Chen in 2003.5.30
};
#endif		// #ifndef KBasPropTblH
