//---------------------------------------------------------------------------
// Sword3 Core (c) 2002 by Kingsoft
//
// File:	KItem.h
// Date:	2002.08
// Code:	LiXueWu, DongBo
// Desc:	Header File
//---------------------------------------------------------------------------

#ifndef	KItemH
#define	KItemH

#include	"KBasPropTbl.h"
#include	"KMagicAttrib.h"
#include	"GameDataDef.h"
#ifndef _SERVER
#include	 "../../Represent/iRepresent/KRepresentUnit.h"
#endif
#include	"KTabFile.h"
#include	"KSG_StringProcess.h"
#include "../../../Headers/PhongThanUpgradeState.h"

class KPlayer;
class KIniFile;

#define		IN
#define		OUT

#define		KItemNormalAttrib KMagicAttrib

typedef struct
{
	BOOL	bTemp;
	int		nTradePrice;
	int		nItemGenre;				// ???????? (????? ????? ?????)
	int		nDetailType;			// ????????????????????
	int		nParticularType;		// ????????
	int		nObjIdx;				// ??????????????????????????????
	int		nWidth;					// ????????????????
	int		nHeight;				// ????????????????
	int		nPrice;					// ????
	int		nNewPrice;
	BOOL	bNewArrival;
	int		nLevel;					// ????
	int		nSeries;				// ????????
	char	szItemName[80];			// ????
#ifndef _SERVER
	char	szImageName[80];		// ??????????????????
	char	szIntro[SZBUFLEN_1];			// ????????
#endif
	char	szScript[128];		// ??????????????????
	int		nExpirePoint;
	BOOL	bShortKey;
	int		nStackNum;
	int		nMaxStack;
	int		nExpireTime;
	KLockItem		LockItem;
	BOOL	bLockSell;
	BOOL	bLockTrade;
	BOOL	bLockDrop;
	int		nParam;
	int		nRow;
	int		nGroup;					// ????
	int		nSetID;					// ????Id
	int		nNeedToActive1;				// ????????
	int		nNeedToActive2;				// ????????
	PlayerItem	BackLocal;
	int		nFortune;
	int		nUpgradeLvl;
	int		nUpgradeRule; // Explicit VNG upgrade-table rule, persisted with upgrade state.
	unsigned int nUpgradeAddedBaseMask,nUpgradeAddedRequireMask;
	int		nPhysicVal;
	int		nMagicVal;
	int		nWeight;			// VNG item weight
	int		nEquipId;			// VNG visual equipment id
	int		nLine; // TamLTM Kham nam xanh
	unsigned uFlash;
} KItemCommonAttrib;

typedef struct
{
	UINT	uRandomSeed;
	int		nGeneratorLevel[MAX_ITEM_MAGICLEVEL];
	int		nVersion;
	int		nLuck;
} KItemGeneratorParam;

class KNpc;

class KItem
{
public:
	KItem();
	~KItem();

// ??????????????????
private:
	
	KItemNormalAttrib	m_aryBaseAttrib[MAX_ITEM_BASEATTRIB];	// VNG basic properties (up to 20)
	KItemNormalAttrib	m_aryRequireAttrib[6];	// ??????????????
	

// ??????????????????????
public:
	KItemGeneratorParam	m_GeneratorParam;		// ??????????????
	KItemCommonAttrib	m_CommonAttrib;			// ??????????????????
	KItemNormalAttrib	m_aryMagicAttrib[MAX_ITEM_MAGICATTRIB];	// ??????????????
private:
	int		m_nIndex;							// ??????????????????????
	DWORD	m_dwOwner;
	DWORD	m_dwID;								// ??????ID????????????????????????????
	int		m_nCurrentDur;						// ??????????
#ifndef _SERVER
	KRUImage	m_Image;
#endif
// ??????????????
public:
	void	ApplyMagicAttribToNPC(IN KNpc*, IN int = 0, IN int = 0) const;
	void	RemoveMagicAttribFromNPC(IN KNpc*, IN int = 0, IN int = 0) const;
	int		GetLine() const { return m_CommonAttrib.nLine; }; // TamLTM Kham nam xanh
	KItemGeneratorParam * GetItemParam(){return &m_GeneratorParam;};
	void	SetTemp(BOOL bFlag) { m_CommonAttrib.bTemp = bFlag; };
	BOOL	IsTemp() const { return m_CommonAttrib.bTemp; };
	void	SetOwner(DWORD dwID) { m_dwOwner = dwID; };
	DWORD	GetOwner() const { return m_dwOwner; };	
	void	SetTradePrice(int nPrice) { m_CommonAttrib.nTradePrice = nPrice; };
	int		GetTradePrice() const { return m_CommonAttrib.nTradePrice; };	
	void	SetID(DWORD dwID) { m_dwID = dwID; };
	DWORD	GetID() const { return m_dwID; };
	int		GetDetailType() const { return m_CommonAttrib.nDetailType; };
	int		GetGenre() const { return m_CommonAttrib.nItemGenre; };
	int		GetSeries() const { return m_CommonAttrib.nSeries; };
	int		GetParticular() { return m_CommonAttrib.nParticularType; };
	int		GetParticularMelee();
	int		GetQuality();
	int		GetLevel() { return m_CommonAttrib.nLevel; };
	void	SetSeries(int nSeries) { m_CommonAttrib.nSeries = nSeries; };
	void	SetWidth(int nWidth) { m_CommonAttrib.nWidth = nWidth; };
	void	SetHeight(int nHeight) { m_CommonAttrib.nHeight = nHeight; };
	int		GetWidth() const { return m_CommonAttrib.nWidth; };
	int		GetHeight() const { return m_CommonAttrib.nHeight; };
//	int		GetPrice() const { return m_CommonAttrib.nPrice; }; // TamLTM Bang hoi chiem linh
	int		GetOrgPrice() const {return m_CommonAttrib.nPrice; };
	int		GetCurPrice() const 
	{
		if (m_CommonAttrib.nNewPrice > 0)
			return m_CommonAttrib.nNewPrice;
		else
			return m_CommonAttrib.nPrice; 
	};
	int		GetSalePrice();
	void	SetExpirePoint(int nPoint) { m_CommonAttrib.nExpirePoint = nPoint; };
	int		GetExpirePoint() const { return m_CommonAttrib.nExpirePoint; };
	char*	GetName() const { return (char *)m_CommonAttrib.szItemName; };
	char*	GetScript() const { return (char *)m_CommonAttrib.szScript; };
	int		GetObjIdx() { return m_CommonAttrib.nObjIdx;};
	void*	GetRequirement(IN int);
	int		GetMaxDurability();
	int		GetTotalMagicLevel();
	BOOL	IsReduce();
	int		GetRepairPrice();
	void	Remove();
	BOOL	SetBaseAttrib(IN const KItemNormalAttrib*);
	BOOL	SetRequireAttrib(IN const KItemNormalAttrib*);
	BOOL	SetMagicAttrib(IN const KItemNormalAttrib*);
	void	SetDurability(IN const int nDur);
	int		GetDurability() { return m_nCurrentDur; };
	KItemGeneratorParam*	GetGeneratorParam() { return &m_GeneratorParam; }
	int		Abrade(IN const int nAbradeP, IN const int nRange);
	BOOL	CanBeRepaired();

	void	SetExpireTime(int nSec) {m_CommonAttrib.nExpireTime = nSec;};
	int		GetExpireTime() { 
		if (m_CommonAttrib.nExpireTime > KSG_GetCurSec())
			return m_CommonAttrib.nExpireTime;
		else
			return 0;
	}; 

	void	SetLevel(int i) { m_CommonAttrib.nLevel = i;};
	void	SetDetailType(int nState) {m_CommonAttrib.nDetailType = nState;};
	void	SetGenre(int nState) {m_CommonAttrib.nItemGenre = nState;};
	void	SetParticular(int nState) {m_CommonAttrib.nParticularType = nState;};

	void	SetBackLocal(PlayerItem* pLocal) {m_CommonAttrib.BackLocal = *pLocal;};
	void	SetBackLocal(int nPlace, int nX, int nY) 
	{
		m_CommonAttrib.BackLocal.nPlace = nPlace;
		m_CommonAttrib.BackLocal.nX = nX;
		m_CommonAttrib.BackLocal.nY = nY;
	};
	PlayerItem*		GetBackLocal() {return &m_CommonAttrib.BackLocal;};	

	void	LockItem(int nLock) {
		if (nLock > LOCK_STATE_NORMAL)
		{
			m_CommonAttrib.LockItem.nState = LOCK_STATE_UNLOCK;
			m_CommonAttrib.LockItem.dwLockTime = KSG_GetCurSec() + nLock;
		}
		else
		{
			m_CommonAttrib.LockItem.nState = nLock;
			m_CommonAttrib.LockItem.dwLockTime = 0;
		}
	};
	void	SetLock(KLockItem* sLockItem) {
		if (sLockItem)
			m_CommonAttrib.LockItem = *sLockItem;
		else
		{
			m_CommonAttrib.LockItem.nState = LOCK_STATE_NORMAL;
			m_CommonAttrib.LockItem.dwLockTime = 0;
		}
	};
	KLockItem*	GetLock() {return &m_CommonAttrib.LockItem;};

	BOOL	LockPick() {
		if (m_CommonAttrib.bLockTrade || 
			m_CommonAttrib.LockItem.IsLock())
			return FALSE;
		return TRUE;
	};

	void	SetLockSell(BOOL bFlag) { m_CommonAttrib.bLockSell = bFlag;};
	BOOL	GetLockSell() {
		if (m_CommonAttrib.nItemGenre == item_task)
			return TRUE;
		return m_CommonAttrib.bLockSell;
	};
	void	SetLockTrade(BOOL bFlag) { m_CommonAttrib.bLockTrade = bFlag;};
	BOOL	GetLockTrade() {return m_CommonAttrib.bLockTrade;};
	void	SetLockDrop(BOOL bFlag) { m_CommonAttrib.bLockDrop = bFlag;};
	BOOL	GetLockDrop() {
		if (m_CommonAttrib.nItemGenre == item_task)
			return TRUE;
		return m_CommonAttrib.bLockDrop;
	};
	BOOL	CanShortKey();
	int		GetShortKey() const { return m_CommonAttrib.bShortKey; };

	void	SetRow(int n) {m_CommonAttrib.nRow = n;};
	int		GetRow() const { return m_CommonAttrib.nRow; };
	int		GetGroup() const { return m_CommonAttrib.nGroup; };
	int		GetSetID() const { return m_CommonAttrib.nSetID; };
	int		GetNeedToActive1() const { return m_CommonAttrib.nNeedToActive1; };
	int		GetNeedToActive2() const { return m_CommonAttrib.nNeedToActive2; };

	BOOL	IsStack() const {
		if (m_CommonAttrib.nMaxStack <= 1)
			return FALSE;
		else
			return TRUE;
	};

	int		GetStackNum() const {
		if (IsStack())
			return m_CommonAttrib.nStackNum; 
		else
			return 1;
	};
	int		AddStackNum(int nNum) {
		int nResult = 0;
		if (IsStack())
		{
			if (nNum < 0)
				nNum = 0;
			else if ((m_CommonAttrib.nStackNum + nNum) > m_CommonAttrib.nMaxStack)
			{
				nResult = (m_CommonAttrib.nStackNum + nNum) - m_CommonAttrib.nMaxStack;
				nNum = m_CommonAttrib.nMaxStack - m_CommonAttrib.nStackNum;
			}
		}
		else
			nNum = 0;

		m_CommonAttrib.nStackNum += nNum;
		return nResult;
	};
	int		SetStackNum(int nNum) {
		int nResult = 0;
		if (IsStack())
		{
			if (nNum < 1)
				nNum = 1;
			else if (nNum > m_CommonAttrib.nMaxStack)
			{
				nResult = nNum - m_CommonAttrib.nMaxStack;
				nNum = m_CommonAttrib.nMaxStack;
			}
		}
		else
			nNum = 1;
		m_CommonAttrib.nStackNum = nNum;
		return nResult;
	};

	int		GetMaxStackNum() const {return m_CommonAttrib.nMaxStack; };

	void	SetParam(int i) { m_CommonAttrib.nParam = i;};
	int		GetParam() {return m_CommonAttrib.nParam;};

	unsigned int	GetFlash(){ return m_CommonAttrib.uFlash; };
	void	SetFlash(unsigned int uFlash){m_CommonAttrib.uFlash = uFlash;};

	void	SetNewPrice(int uPrice) {m_CommonAttrib.nNewPrice = uPrice;};
	int		GetNewPrice(){ return m_CommonAttrib.nNewPrice; };
	void	SetNewArrival(BOOL bNewArrival) {m_CommonAttrib.bNewArrival = bNewArrival;};
	int		GetNewArrival(){ return m_CommonAttrib.bNewArrival; };

	void	SetFortune(int i) { m_CommonAttrib.nFortune = i;};
	int		GetFortune() {return m_CommonAttrib.nFortune;};
	int		GetWeight() const { return m_CommonAttrib.nWeight; };
	int		GetBasePower() const { return m_CommonAttrib.nPhysicVal; };
	int		GetMagicPower() const { return m_CommonAttrib.nMagicVal; };
	BOOL	GetUpgradePower(int& nPower) const;
	BOOL ApplyUpgradeState(int state);
	int GetUpgradeState() const { return PhongThanEncodeUpgradeState(m_CommonAttrib.nUpgradeLvl,
		GetGenre()==item_equip?m_CommonAttrib.nUpgradeRule:0); }
	int		GetEquipId() const { return m_CommonAttrib.nEquipId; };
	int		GetColorItem(); // TamLTM Kham nam xanh
#ifndef _SERVER
	void	Paint(int nX, int nY, bool bResize = false, bool bPaintStack = true);
	void	PaintEquipmentSlot(int nX, int nY, int nWidth, int nHeight);
	void	PaintInventorySlot(int nX, int nY, int nWidth, int nHeight);
	void	GetDesc(char* pszMsg, bool bShowPrice = false, bool bPriceScale = false, int nActiveAttrib = 0, int nGoldActiveAttrib = 0);
	char*	GetImageName() {return (char *)m_CommonAttrib.szImageName; };
#endif

// ??????????????
friend class	KItemGenerator;
friend class	KPlayer;
friend class	KItemList;
private:
	BOOL SetAttrib_CBR(IN const KBASICPROP_EQUIPMENT*);
	BOOL SetAttrib_MA(IN const KItemNormalAttrib*);
	BOOL SetAttrib_MA(IN const KMACP*);
	void operator = (const KBASICPROP_EQUIPMENT&);
	void operator = (const KBASICPROP_EVENTITEM&);
	void operator = (const KBASICPROP_MEDICINE&);
	void operator = (const KBASICPROP_QUEST&);
	void operator = (const KBASICPROP_TOWNPORTAL&);
	void operator = (const KBASICPROP_MAGICSCRIPT&);
	void operator = (const KBASICPROP_SKILLBOOK&);
	void operator = (const KBASICPROP_IBITEM&);

private:
	BOOL SetAttrib_Base(const KEQCP_BASIC*);
	BOOL SetAttrib_Req(const KEQCP_REQ*);
};

extern KItem Item[MAX_ITEM];

#endif
