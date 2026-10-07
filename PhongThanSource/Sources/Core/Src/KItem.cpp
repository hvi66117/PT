#include "KCore.h"
#include "MyAssert.H"
#include "KTabFile.h"
#include "KNpc.h"
#include "KItem.h"
#include "KItemSet.h"
#include "KItemGenerator.h"
#include "KPhongThanAppearance.h"
#include "KTaskFuns.h"
#include "KSortScript.h"
#include "KBuySell.h"
#include	<time.h>
#ifndef _SERVER
#include "ImgRef.h"
#include "KPlayer.h"
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "KMagicDesc.h"
#endif
KItem	Item[MAX_ITEM];
#include "PhongThanItemUpgrade.inl"
int GetRandomNumber(int nMin, int nMax);

KItem::KItem()
{
	::memset(&m_CommonAttrib,    0, sizeof(m_CommonAttrib));
	::memset(m_aryBaseAttrib,    0, sizeof(m_aryBaseAttrib));
	::memset(m_aryRequireAttrib, 0, sizeof(m_aryRequireAttrib));
	::memset(m_aryMagicAttrib,   0, sizeof(m_aryMagicAttrib));
	::memset(&m_GeneratorParam,	 0, sizeof(m_GeneratorParam));
	m_nCurrentDur = -1;
#ifndef _SERVER
	::memset(&m_Image,   0, sizeof(KRUImage));
#endif
	m_nIndex = 0;
}

KItem::~KItem()
{
}

void* KItem::GetRequirement(IN int nReq)
{
	int i = sizeof(m_aryRequireAttrib)/sizeof(m_aryRequireAttrib[0]);
	if (nReq >= i)
		return NULL;

	return &m_aryRequireAttrib[nReq];
}
/******************************************************************************
功能:	将item上的魔法应用到NPC身上
入口：	pNPC: 指向NPC的指针，nMagicAcive：打开的隐藏属性数目
出口:	魔法被应用。
		具体工作由KNpc的成员函数完成。
		KItem 对象本身没有成员变量被修改
******************************************************************************/
void KItem::ApplyMagicAttribToNPC(IN KNpc* pNPC, IN int nMagicActive, IN int nSetActiveLines) const
{
	_ASSERT(this != NULL);
	if (!pNPC)
		return;
	(void)nMagicActive;

	int i;
	for (i = 0; i < MAX_ITEM_BASEATTRIB; ++i)
	{
		const KItemNormalAttrib* pAttrib = &m_aryBaseAttrib[i];
		if (pAttrib->nAttribType > 0)
			pNPC->ModifyAttrib(pNPC->m_Index, (void *)pAttrib);
	}

	int nRemainingSetLines = nSetActiveLines;
	const BOOL bSetEquipment = m_CommonAttrib.nSetID > 0;
	for (i = 0; i < MAX_ITEM_MAGICATTRIB; ++i)
	{
		const KItemNormalAttrib* pAttrib = &m_aryMagicAttrib[i];
		if (pAttrib->nAttribType <= 0)
			continue;
		if (bSetEquipment && i >= MAX_ITEM_NORMAL_MAGICATTRIB)
		{
			if (nRemainingSetLines <= 0)
				continue;
			--nRemainingSetLines;
		}
		pNPC->ModifyAttrib(pNPC->m_Index, (void *)pAttrib);
	}
}

void KItem::RemoveMagicAttribFromNPC(IN KNpc* pNPC, IN int nMagicActive, IN int nSetActiveLines) const
{
	_ASSERT(this != NULL);
	if (!pNPC)
		return;
	(void)nMagicActive;

	int i;
	for (i = 0; i < MAX_ITEM_BASEATTRIB; ++i)
	{
		const KItemNormalAttrib* pAttrib = &m_aryBaseAttrib[i];
		if (pAttrib->nAttribType <= 0)
			continue;
		KItemNormalAttrib removeAttrib = *pAttrib;
		removeAttrib.nValue[0] = -removeAttrib.nValue[0];
		removeAttrib.nValue[1] = -removeAttrib.nValue[1];
		removeAttrib.nValue[2] = -removeAttrib.nValue[2];
		pNPC->ModifyAttrib(pNPC->m_Index, &removeAttrib);
	}

	int nRemainingSetLines = nSetActiveLines;
	const BOOL bSetEquipment = m_CommonAttrib.nSetID > 0;
	for (i = 0; i < MAX_ITEM_MAGICATTRIB; ++i)
	{
		const KItemNormalAttrib* pAttrib = &m_aryMagicAttrib[i];
		if (pAttrib->nAttribType <= 0)
			continue;
		if (bSetEquipment && i >= MAX_ITEM_NORMAL_MAGICATTRIB)
		{
			if (nRemainingSetLines <= 0)
				continue;
			--nRemainingSetLines;
		}
		KItemNormalAttrib removeAttrib = *pAttrib;
		removeAttrib.nValue[0] = -removeAttrib.nValue[0];
		removeAttrib.nValue[1] = -removeAttrib.nValue[1];
		removeAttrib.nValue[2] = -removeAttrib.nValue[2];
		pNPC->ModifyAttrib(pNPC->m_Index, &removeAttrib);
	}
}

#include "../../../Headers/PhongThanUpgradePower.h"
BOOL KItem::GetUpgradePower(int& nPower) const
{
	nPower = 0;
	if (GetGenre() != item_equip) return FALSE;
	if (m_CommonAttrib.nUpgradeLvl == 0) return TRUE;
	static KTabFile table;
	static BOOL loaded = FALSE;
	if (!loaded)
		loaded = table.Load("\\settings\\powervalue\\\xD7\xB0\xB1\xB8\xC9\xFD\xBC\xB6\xB9\xA6\xC1\xA6\xB1\xED.txt");
	if (!loaded || table.GetWidth() < 2) return FALSE;
	const int level = m_CommonAttrib.nUpgradeLvl;
	if (level < 0 || level > 32 || level >= table.GetWidth()) return FALSE;
	for (int row = 2; row <= table.GetHeight(); ++row)
	{
		int equipId = 0;
		table.GetInteger(row, 1, 0, &equipId);
		if (equipId != GetEquipId()) continue;
		int steps[32];
		for (int n = 0; n < level; ++n)
			if (!table.GetInteger(row, n + 2, -1, &steps[n]) || steps[n] < 0) return FALSE;
		return PhongThanSumUpgradePower(steps, level, level, nPower) ? TRUE : FALSE;
	}
	return FALSE;
}

BOOL KItem::SetAttrib_CBR(IN const KBASICPROP_EQUIPMENT* pData)
{
	_ASSERT(pData != NULL);

	BOOL bEC = FALSE;
	if (pData)
	{
		// This object may previously have represented another equipment item.
		// Rebuild only from the new template; later explicit layers reapply their
		// own effects. Non-set templates must not inherit old set/magic slots.
		ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
		//SetAttrib_Common(pData);
		*this = *pData;		// 运算符重载
		SetAttrib_Base(pData->m_aryPropBasic);
		SetAttrib_Req(pData->m_aryPropReq);
		bEC = TRUE;
	}
	return bEC;
}

BOOL KItem::SetAttrib_Base(const KEQCP_BASIC* pBasic)
{
	for (int i = 0;
		 i < sizeof(m_aryBaseAttrib)/sizeof(m_aryBaseAttrib[0]); i++)
	{
		KItemNormalAttrib* pDst;
		const KEQCP_BASIC* pSrc;
		pDst = &(m_aryBaseAttrib[i]);
		pSrc = &(pBasic[i]);
		pDst->nAttribType = pSrc->nType;
		pDst->nValue[0] = ::GetRandomNumber(pSrc->sRange.nMin, pSrc->sRange.nMax);
		pDst->nValue[1] = 0;	// RESERVED
		pDst->nValue[2] = 0;	// RESERVED
		if (pDst->nAttribType == magic_durability_v)
			SetDurability(pDst->nValue[0]);
	}
	//if (m_nCurrentDur == 0)	// 说明没有耐久度属性
	//	m_nCurrentDur = -1;
	return TRUE;
}

BOOL KItem::SetAttrib_Req(const KEQCP_REQ* pReq)
{
	for (int i = 0;
		 i < sizeof(m_aryRequireAttrib)/sizeof(m_aryRequireAttrib[0]); i++)
	{
		KItemNormalAttrib* pDst;
		pDst = &(m_aryRequireAttrib[i]);
		pDst->nAttribType = pReq[i].nType;
		pDst->nValue[0] = pReq[i].nPara;
		pDst->nValue[1] = 0;	// RESERVED
		pDst->nValue[2] = 0;	// RESERVED
	}
	return TRUE;
}

/******************************************************************************
功能:	根据传入的数据, 为item的魔法属性赋初值
入口：	pMA: 给出数据
出口:	成功时返回非零, 以下成员变量被值:
			m_aryMagicAttrib
		失败时返回零
******************************************************************************/
BOOL KItem::SetAttrib_MA(IN const KItemNormalAttrib* pMA)
{
	if (NULL == pMA)
		{ _ASSERT(FALSE); return FALSE; }
	for (int i = 0; i < sizeof(m_aryMagicAttrib) / sizeof(m_aryMagicAttrib[0]); i++)
	{
		m_aryMagicAttrib[i] = pMA[i];
		if (m_aryMagicAttrib[i].nAttribType == magic_indestructible_b)
		{
			SetDurability(-1);
		}
	}
	return TRUE;
}

/******************************************************************************
功能:	根据传入的数据, 为item的魔法属性赋初值
入口：	pMA: 给出数据
出口:	成功时返回非零, 以下成员变量被值:
			m_aryMagicAttrib
		失败时返回零
******************************************************************************/
BOOL KItem::SetAttrib_MA(IN const KMACP* pMA)
{
	if (NULL == pMA)
		{ _ASSERT(FALSE); return FALSE; }

	for (int i = 0; i < sizeof(m_aryMagicAttrib) / sizeof(m_aryMagicAttrib[0]); i++)
	{
		const KMACP* pSrc;
		KItemNormalAttrib* pDst;
		pSrc = &(pMA[i]);
		pDst = &(m_aryMagicAttrib[i]);

		pDst->nAttribType = pSrc->nPropKind;
		pDst->nValue[0] =  ::GetRandomNumber(pSrc->aryRange[0].nMin, pSrc->aryRange[0].nMax);
		pDst->nValue[1] =  ::GetRandomNumber(pSrc->aryRange[1].nMin, pSrc->aryRange[1].nMax);
		pDst->nValue[2] =  ::GetRandomNumber(pSrc->aryRange[2].nMin, pSrc->aryRange[2].nMax);
	}
	return TRUE;
}

void KItem::operator = (const KBASICPROP_EQUIPMENT& sData)
{
	m_CommonAttrib.nUpgradeRule=0;
	m_CommonAttrib.nUpgradeAddedBaseMask=m_CommonAttrib.nUpgradeAddedRequireMask=0;
	KItemCommonAttrib* pCA	= &m_CommonAttrib;
	//TamLTM Code kham nam xanh
	//End code
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= sData.m_nParticularType;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nNewPrice			= sData.m_nPrice;
	pCA->bNewArrival		= FALSE;
	pCA->nLevel				= sData.m_nLevel;
	pCA->nSeries			= sData.m_nSeries;
	pCA->bShortKey			= FALSE;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= 1;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= sData.m_nSetId;
	pCA->nSetID				= sData.m_nSetId;
	pCA->nNeedToActive1		= sData.m_nSetId ? 3 : 0;
	pCA->nNeedToActive2		= sData.m_nSetId ? 5 : 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= sData.m_nBasePower;
	pCA->nMagicVal			= sData.m_nMagicPower;
	pCA->nWeight			= sData.m_nWeight;
	pCA->nEquipId			= sData.m_nEquipId;
	pCA->bLockSell			= !sData.m_nCanSell;
	pCA->bLockTrade			= !sData.m_nCanTrade;
	pCA->bLockDrop			= !sData.m_nCanDrop;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strcpy(pCA->szItemName,  sData.m_szName);
	::memset(pCA->szScript, 0, sizeof(pCA->szScript));
#ifndef _SERVER
	::strcpy(pCA->szImageName, sData.m_szImageName);
	::strcpy(pCA->szIntro,	   sData.m_szIntro);
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strcpy(m_Image.szImage, pCA->szImageName);
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_EVENTITEM& sData)
{
	KItemCommonAttrib* pCA  = &m_CommonAttrib;
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= 0;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nNewPrice			= sData.m_nPrice;
	pCA->bNewArrival		= FALSE;
	pCA->nLevel				= 0;
	pCA->nSeries			= series_num;
	pCA->bShortKey			= sData.m_bShortKey;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= sData.m_nMaxStack;
	pCA->bShortKey			= FALSE;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= 0;
	pCA->nSetID				= 0;
	pCA->nNeedToActive1		= 0;
	pCA->nNeedToActive2		= 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= 0;
	pCA->nMagicVal			= 0;
	pCA->nWeight			= 0;
	pCA->nEquipId			= 0;
	pCA->bLockSell			= FALSE;
	pCA->bLockTrade			= FALSE;
	pCA->bLockDrop			= FALSE;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strcpy(pCA->szItemName,  sData.m_szName);
	::strcpy(pCA->szScript,  sData.m_szScript);
#ifndef _SERVER
	::strcpy(pCA->szImageName, sData.m_szImageName);
	::strcpy(pCA->szIntro,	   sData.m_szIntro);
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryRequireAttrib));
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strcpy(m_Image.szImage, pCA->szImageName);
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_QUEST& sData)
{
	// 赋值: 共同属性部分
	KItemCommonAttrib* pCA = &m_CommonAttrib;
	//TamLTM Code kham nam xanh
	//End code
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= 0;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nNewPrice			= sData.m_nPrice;
	pCA->bNewArrival		= FALSE;
	pCA->nLevel				= 0;
	pCA->nSeries			= series_num;
	pCA->bShortKey			= sData.m_bShortKey;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= sData.m_nMaxStack;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= 0;
	pCA->nSetID				= 0;
	pCA->nNeedToActive1		= 0;
	pCA->nNeedToActive2		= 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= 0;
	pCA->nMagicVal			= 0;
	pCA->nWeight			= 0;
	pCA->nEquipId			= 0;
	pCA->bLockSell			= FALSE;
	pCA->bLockTrade			= FALSE;
	pCA->bLockDrop			= FALSE;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strcpy(pCA->szItemName,  sData.m_szName);
	::memset(pCA->szScript, 0, sizeof(pCA->szScript));
#ifndef _SERVER
	::strcpy(pCA->szImageName, sData.m_szImageName);
	::strcpy(pCA->szIntro,	   sData.m_szIntro);
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	// 赋值: 需求属性部分: 无
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryBaseAttrib));
	// 赋值: 魔法属性部分: 无
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryBaseAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strcpy(m_Image.szImage, pCA->szImageName);
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_TOWNPORTAL& sData)
{
	// 赋值: 共同属性部分
	KItemCommonAttrib* pCA = &m_CommonAttrib;
	//TamLTM Code kham nam xanh
	//End code
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= 0;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nLevel				= 0;
	pCA->nSeries			= series_num;
	pCA->bShortKey			= sData.m_bShortKey;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= sData.m_nMaxStack;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= 0;
	pCA->nSetID				= 0;
	pCA->nNeedToActive1		= 0;
	pCA->nNeedToActive2		= 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= 0;
	pCA->nMagicVal			= 0;
	pCA->nWeight			= 0;
	pCA->nEquipId			= 0;
	pCA->bLockSell			= FALSE;
	pCA->bLockTrade			= FALSE;
	pCA->bLockDrop			= FALSE;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strcpy(pCA->szItemName,  sData.m_szName);
	::strcpy(pCA->szScript,  sData.m_szScript);
#ifndef _SERVER
	::strcpy(pCA->szImageName, sData.m_szImageName);
	::strcpy(pCA->szIntro,	   sData.m_szIntro);
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	// 赋值: 需求属性部分: 无
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryBaseAttrib));
	// 赋值: 魔法属性部分: 无
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryBaseAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strcpy(m_Image.szImage, pCA->szImageName);
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_MAGICSCRIPT& sData)
{
	// 赋值: 共同属性部分
	KItemCommonAttrib* pCA	= &(m_CommonAttrib);
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= 0;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nNewPrice			= sData.m_nPrice;
	pCA->bNewArrival		= FALSE;
	pCA->nLevel				= 0;
	pCA->nSeries			= series_num;
	pCA->bShortKey			= sData.m_bShortKey;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= sData.m_nMaxStack;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= 0;
	pCA->nSetID				= 0;
	pCA->nNeedToActive1		= 0;
	pCA->nNeedToActive2		= 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= 0;
	pCA->nMagicVal			= 0;
	pCA->nWeight			= 0;
	pCA->nEquipId			= 0;
	pCA->bLockSell			= FALSE;
	pCA->bLockTrade			= FALSE;
	pCA->bLockDrop			= FALSE;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strncpy(pCA->szItemName, sData.m_szName, sizeof(pCA->szItemName) - 1);
	pCA->szItemName[sizeof(pCA->szItemName) - 1] = 0;
	::strncpy(pCA->szScript, sData.m_szScript, sizeof(pCA->szScript) - 1);
	pCA->szScript[sizeof(pCA->szScript) - 1] = 0;
#ifndef _SERVER
	::strncpy(pCA->szImageName, sData.m_szImageName, sizeof(pCA->szImageName) - 1);
	pCA->szImageName[sizeof(pCA->szImageName) - 1] = 0;
	::strncpy(pCA->szIntro, sData.m_szIntro, sizeof(pCA->szIntro) - 1);
	pCA->szIntro[sizeof(pCA->szIntro) - 1] = 0;
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryRequireAttrib));
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strncpy(m_Image.szImage, pCA->szImageName, sizeof(m_Image.szImage) - 1);
	m_Image.szImage[sizeof(m_Image.szImage) - 1] = 0;
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_SKILLBOOK& sData)
{
	KItemCommonAttrib* pCA = &m_CommonAttrib;
	pCA->bTemp = FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre = sData.m_nItemGenre;
	pCA->nDetailType = sData.m_nDetailType;
	pCA->nParticularType = sData.m_nParticularType;
	pCA->nObjIdx = sData.m_nObjIdx;
	pCA->nWidth = sData.m_nWidth;
	pCA->nHeight = sData.m_nHeight;
	pCA->nPrice = sData.m_nPrice;
	pCA->nNewPrice = sData.m_nPrice;
	pCA->bNewArrival = FALSE;
	pCA->nLevel = 0;
	pCA->nSeries = series_num;
	pCA->bShortKey = FALSE;
	pCA->nStackNum = 1;
	pCA->nMaxStack = sData.m_nMaxStack;
	pCA->nExpirePoint = 0;
	pCA->nRow = -1;
	pCA->nGroup = 0;
	pCA->nSetID = 0;
	pCA->nNeedToActive1 = 0;
	pCA->nNeedToActive2 = 0;
	pCA->uFlash = 0;
	pCA->nUpgradeLvl = 0;
	pCA->nPhysicVal = 0;
	pCA->nMagicVal = 0;
	pCA->nWeight = sData.m_nWeight;
	pCA->nEquipId = 0;
	pCA->bLockSell = !sData.m_bCanSell;
	pCA->bLockTrade = !sData.m_bCanTrade;
	pCA->bLockDrop = !sData.m_bCanDrop;
	pCA->nParam = -1;
	pCA->nFortune = 0;
	pCA->nExpireTime = 0;
	pCA->LockItem.Clear();
	::strncpy(pCA->szItemName, sData.m_szName, sizeof(pCA->szItemName) - 1);
	pCA->szItemName[sizeof(pCA->szItemName) - 1] = 0;
	::memset(pCA->szScript, 0, sizeof(pCA->szScript));
#ifndef _SERVER
	::strncpy(pCA->szImageName, sData.m_szImageName, sizeof(pCA->szImageName) - 1);
	pCA->szImageName[sizeof(pCA->szImageName) - 1] = 0;
	::strncpy(pCA->szIntro, sData.m_szIntro, sizeof(pCA->szIntro) - 1);
	pCA->szIntro[sizeof(pCA->szIntro) - 1] = 0;
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryRequireAttrib));
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strncpy(m_Image.szImage, pCA->szImageName, sizeof(m_Image.szImage) - 1);
	m_Image.szImage[sizeof(m_Image.szImage) - 1] = 0;
	m_Image.uImage = 0;
#endif
}

void KItem::operator = (const KBASICPROP_IBITEM& sData)
{
	KItemCommonAttrib* pCA = &m_CommonAttrib;
	pCA->bTemp = FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre = item_ibitem;
	pCA->nDetailType = sData.m_nDetailType;
	pCA->nParticularType = sData.m_nParticularType;
	pCA->nObjIdx = sData.m_nObjIdx;
	pCA->nWidth = sData.m_nWidth;
	pCA->nHeight = sData.m_nHeight;
	pCA->nPrice = sData.m_nPrice;
	pCA->nNewPrice = sData.m_nPrice;
	pCA->bNewArrival = FALSE;
	pCA->nLevel = 0;
	pCA->nSeries = series_num;
	pCA->bShortKey = FALSE;
	pCA->nStackNum = sData.m_nUseCount;
	pCA->nMaxStack = sData.m_nUseCount > 1 ? sData.m_nUseCount : 1;
	// stackgem 2026-10-03: ibitem.txt column 11 (VNG "is stackable", loaded as m_bCanStack) > 1 is
	// the stack limit of a new item that starts at UseCount (ptfix extra_stackgem.py sets it per row).
	if (sData.m_bCanStack > pCA->nMaxStack)
		pCA->nMaxStack = sData.m_bCanStack;
	pCA->nExpirePoint = 0;
	pCA->nRow = -1;
	pCA->nGroup = 0;
	pCA->nSetID = 0;
	pCA->nNeedToActive1 = 0;
	pCA->nNeedToActive2 = 0;
	pCA->uFlash = 0;
	pCA->nUpgradeLvl = 0;
	pCA->nPhysicVal = 0;
	pCA->nMagicVal = 0;
	pCA->nEquipId = 0;
	pCA->bLockSell = !sData.m_bCanSell;
	pCA->bLockTrade = !sData.m_bCanTrade;
	pCA->bLockDrop = !sData.m_bCanDrop;
	pCA->nParam = -1;
	pCA->nFortune = 0;
	pCA->nExpireTime = 0;
	pCA->LockItem.Clear();
	::strncpy(pCA->szItemName, sData.m_szName, sizeof(pCA->szItemName) - 1);
	pCA->szItemName[sizeof(pCA->szItemName) - 1] = 0;
	::strncpy(pCA->szScript, sData.m_szScript, sizeof(pCA->szScript) - 1);
	pCA->szScript[sizeof(pCA->szScript) - 1] = 0;
#ifndef _SERVER
	::strncpy(pCA->szImageName, sData.m_szImageName, sizeof(pCA->szImageName) - 1);
	pCA->szImageName[sizeof(pCA->szImageName) - 1] = 0;
	::strncpy(pCA->szIntro, sData.m_szIntro, sizeof(pCA->szIntro) - 1);
	pCA->szIntro[sizeof(pCA->szIntro) - 1] = 0;
#endif
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryRequireAttrib));
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strncpy(m_Image.szImage, pCA->szImageName, sizeof(m_Image.szImage) - 1);
	m_Image.szImage[sizeof(m_Image.szImage) - 1] = 0;
	m_Image.uImage = 0;
#endif
}
void KItem::operator = (const KBASICPROP_MEDICINE& sData)
{
	// 赋值: 共同属性部分
	KItemCommonAttrib* pCA	= &m_CommonAttrib;
	//TamLTM Code kham nam xanh
	//End code
	pCA->bTemp				= FALSE;
	pCA->BackLocal.Release();
	pCA->nItemGenre			= sData.m_nItemGenre;
	pCA->nDetailType		= sData.m_nDetailType;
	pCA->nParticularType	= sData.m_nParticularType;
	pCA->nObjIdx			= sData.m_nObjIdx;
	pCA->nWidth				= sData.m_nWidth;
	pCA->nHeight			= sData.m_nHeight;
	pCA->nPrice				= sData.m_nPrice;
	pCA->nNewPrice			= sData.m_nPrice;
	pCA->bNewArrival		= FALSE;
	pCA->nLevel				= sData.m_nLevel;
	pCA->nSeries			= sData.m_nSeries;
	pCA->bShortKey			= TRUE;
	pCA->nStackNum			= 1;
	pCA->nMaxStack			= sData.m_nMaxStack;
	pCA->nExpirePoint		= 0;
	pCA->nRow				= -1;
	pCA->nGroup				= 0;
	pCA->nSetID				= 0;
	pCA->nNeedToActive1		= 0;
	pCA->nNeedToActive2		= 0;
	pCA->uFlash				= 0;
	pCA->nUpgradeLvl		= 0;
	pCA->nPhysicVal			= 0;
	pCA->nMagicVal			= 0;
	pCA->nWeight			= 0;
	pCA->nEquipId			= 0;
	pCA->bLockSell			= FALSE;
	pCA->bLockTrade			= FALSE;
	pCA->bLockDrop			= FALSE;
	pCA->nParam				= -1;
	pCA->nFortune			= 0;
	pCA->nExpireTime		= 0;
	pCA->LockItem.Clear();
	::strcpy(pCA->szItemName,  sData.m_szName);
	::memset(pCA->szScript, 0, sizeof(pCA->szScript));
#ifndef _SERVER
	::strcpy(pCA->szImageName, sData.m_szImageName);
	::strcpy(pCA->szIntro,	   sData.m_szIntro);
#endif
	// 赋值: 基本属性部分
	ZeroMemory(m_aryBaseAttrib, sizeof(m_aryBaseAttrib));
	KItemNormalAttrib* pBA = m_aryBaseAttrib;
	pBA[0].nAttribType = sData.m_aryAttrib[0].nAttrib;
	pBA[0].nValue[0]   = sData.m_aryAttrib[0].nValue;
	pBA[0].nValue[1]   = sData.m_aryAttrib[0].nTime;
	pBA[1].nAttribType = sData.m_aryAttrib[1].nAttrib;
	pBA[1].nValue[0]   = sData.m_aryAttrib[1].nValue;
	pBA[1].nValue[1]   = sData.m_aryAttrib[1].nTime;

	ZeroMemory(m_aryRequireAttrib, sizeof(m_aryRequireAttrib));
	ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib));
#ifndef _SERVER
	m_Image.Color.Color_b.a = 255;
	m_Image.nFrame = 0;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	::strcpy(m_Image.szImage, pCA->szImageName);
	m_Image.uImage = 0;
#endif

}

void KItem::Remove()
{
	m_nIndex = 0;
}

BOOL KItem::SetBaseAttrib(IN const KItemNormalAttrib* pAttrib)
{
	if (!pAttrib)
		return FALSE;

	for (int i = 0; i < sizeof(m_aryBaseAttrib) / sizeof(m_aryBaseAttrib[0]); i++)
	{
		m_aryBaseAttrib[i] = pAttrib[i];
	}
	return TRUE;
}

BOOL KItem::SetRequireAttrib(IN const KItemNormalAttrib* pAttrib)
{
	if (!pAttrib)
		return FALSE;

	for (int i = 0; i < sizeof(m_aryRequireAttrib) / sizeof(m_aryRequireAttrib[0]); i++)
	{
		m_aryRequireAttrib[i] = pAttrib[i];
	}
	return TRUE;
}

BOOL KItem::SetMagicAttrib(IN const KItemNormalAttrib* pAttrib)
{
	return SetAttrib_MA(pAttrib);
}
//------------------------------------------------------------------
//	磨损，返回值表示剩余耐久度 Quai danh tinh hu do ben
//------------------------------------------------------------------
int KItem::Abrade(IN const int nAbradeP, IN const int nRange)
{
//	g_DebugLog("Abrade(IN const int nAbradeP, IN const int nRange)");

	if (m_nCurrentDur == -1 || nRange == 0)	// 永不磨损
		return -1;

	if(nAbradeP > 0)
		m_nCurrentDur -= GetMaxDurability() * nAbradeP / MAX_PERCENT;


//	g_DebugLog("m_nCurrentDur %d", m_nCurrentDur);

	if(m_nCurrentDur > 0)
	{
//		g_DebugLog("m_nCurrentDur g_Random %d", g_Random(nRange));
		// nRandRange分之一的概率
		if (g_Random(nRange) == 0)
		{
			m_nCurrentDur--;
			//TamLTM fix hu hong do ben
			if (m_nCurrentDur == 0)
			{
				return 0;
			}
			//End code
		}
	}

	if (m_nCurrentDur <= 0)
		m_nCurrentDur = 0;

	return m_nCurrentDur;
}

#ifndef _SERVER
static void AppendItemDescription(char* pszDestination, size_t nCapacity, const char* pszSource)
{
	if (!pszDestination || !pszSource || nCapacity == 0)
		return;
	size_t nUsed = strlen(pszDestination);
	if (nUsed >= nCapacity - 1)
	{
		pszDestination[nCapacity - 1] = 0;
		return;
	}
	strncat(pszDestination, pszSource, nCapacity - nUsed - 1);
	pszDestination[nCapacity - 1] = 0;
}

static const char* SkipVngDisplayPrefix(const char* pszText)
{
	if (!pszText)
		return "";
	while (*pszText == '#' || *pszText == '$')
		++pszText;
	return pszText;
}

#include "PhongThanEquipmentArt.inl"
#include "PhongThanEquipmentTooltip.inl"
void KItem::PaintEquipmentSlot(int nX, int nY, int nWidth, int nHeight)
{
	if (!g_pRepresent || nWidth <= 4 || nHeight <= 4) return;
	KRUImage Icon = m_Image;
	PhongThanEquipLargeImage(*this,Icon);
	PhongThanPaintUpgradeAura(*this,nX,nY,nWidth,nHeight);
	PhongThanDrawSlotImage(Icon,nX,nY,nWidth,nHeight,false);
}

void KItem::PaintInventorySlot(int nX, int nY, int nWidth, int nHeight)
{
	// Inventory keeps the small icon and never inherits equipped aura/art.
	PhongThanDrawSlotImage(m_Image,nX+2,nY+2,nWidth-4,nHeight-4,true);
	if (IsStack() && nWidth >= NORMAL_FONTSIZE && nHeight >= NORMAL_FONTSIZE + 1)
	{
		char number[16];
		int length = sprintf(number, "%d", GetStackNum());
		int x = nX + nWidth - length * NORMAL_FONTSIZE / 2;
		if (x < nX) x = nX;
		g_pRepresent->OutputText(NORMAL_FONTSIZE, number, KRF_ZERO_END,
			x, nY + nHeight - NORMAL_FONTSIZE - 1, 0xFFFFCC);
	}
}

void KItem::Paint(int nX, int nY, bool bResize/* = false*/, bool bPaintStack/* = false*/)
{
	if (bResize && (m_CommonAttrib.nWidth*m_CommonAttrib.nHeight > 1))
		strcpy(m_Image.szImage, RESIZEITEM_SPR);

	m_Image.oPosition.nX = nX;
	m_Image.oPosition.nY = nY;
	m_Image.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, TRUE);

	if (IsStack() && bPaintStack)
	{
		char szNum[16];
		int nLen = sprintf(szNum, "%d", GetStackNum());
		g_pRepresent->OutputText(NORMAL_FONTSIZE, szNum, KRF_ZERO_END,
			nX + (GetWidth() * 27) - nLen * (NORMAL_FONTSIZE ) / 2,
			nY + (GetHeight() * 26) - (NORMAL_FONTSIZE + 1), 0xFFFFCC);

	}
}

void KItem::GetDesc(char* pszMsg, bool bShowPrice, bool bPriceScale, int nActiveAttrib, int nGoldActiveAttrib)
{
    if (!pszMsg)
        return;

    // Build in a private buffer; UI consumers expose a 2048-byte title buffer.
    // This prevents legacy unbounded strcat calls from corrupting the UI heap.
    char* pszOutput = pszMsg;
    char szSafeDesc[16384];
    szSafeDesc[0] = 0;
    pszMsg = szSafeDesc;
    // Keep every legacy append inside the private tooltip buffer. A broken
    // Lua GetDesc result can now truncate this tooltip, never the UI heap.
#define strcat(pszDestination, pszSource) AppendItemDescription((pszDestination), sizeof(szSafeDesc), (pszSource))
	char pszKeyName[6];
	char pszTemp[128];
	char pszTemp2[128];

	memset(pszKeyName, 0, sizeof(pszKeyName));
	memset(pszTemp, 0, sizeof(pszTemp));
	memset(pszTemp2, 0, sizeof(pszTemp2));

	switch(this->GetQuality())
	{
	case equip_normal:
		strcat(pszMsg, "<color=255,255,255>");
		break;
	case equip_magic:
		strcat(pszMsg, "<color=0,255,0>");
		break;
	case equip_damage:
		strcat(pszMsg, "<color=255,0,66>");
		break;
	case equip_set:
		strcat(pszMsg, "<color=0,255,0>");
		break;
	}
	strcat(pszMsg, SkipVngDisplayPrefix(m_CommonAttrib.szItemName));

	strcat(pszMsg, "<bclr=0,0,0><color>");
	if(GetGenre()==item_equip && m_CommonAttrib.nUpgradeLvl>0 && m_CommonAttrib.nUpgradeLvl<=12)
	{
		char stars[32];sprintf(stars,"\n<pic=%d>",PT_UPGRADE_PIC_BASE+m_CommonAttrib.nUpgradeLvl);
		strcat(pszMsg,stars);
	}

	char szPriceColor[moneyunit_num][32] =
	{
		"<color=255,255,255>",
		"<color=255,90,0>",
		"<color=255,219,74>",
		"<color=255,219,74>",
		"<color=0,255,0>",
		"<color=0,255,0>",
		"<color=255,90,0>",
	};
	if (bShowPrice)
	{
		int nPrice = 0;
		if (bPriceScale)
		{
			nPrice = GetSalePrice();
			strcat(pszMsg, szPriceColor[moneyunit_money]);
			sprintf(pszTemp2, "%d", moneyunit_money);
		}
		else
		{
			nPrice = GetCurPrice();
			strcat(pszMsg, szPriceColor[Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nMoneyUnit]);
			sprintf(pszTemp2, "%d", Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nMoneyUnit);
		}
		strcat(pszMsg, "\n");
		strcpy(pszTemp, "Gi?c? ");
		strcat(pszMsg, pszTemp);

		g_GameSetting.GetString("MoneyUnit", pszTemp2, "", pszTemp, sizeof(pszTemp));
		sprintf(pszTemp2, "%d %s<color=255,255,255>", nPrice, pszTemp);
		strcat(pszMsg, pszTemp2);
	}

	pszTemp2[0] = 0;
	switch (m_CommonAttrib.LockItem.nState)
	{
		case LOCK_STATE_CHARACTER:
			sprintf(pszTemp2, "<color=0,255,0>V藅 ph萴 nh k蘭 theo nh﹏ v藅<color>");
			break;
		case LOCK_STATE_FOREVER:
			sprintf(pszTemp2, "<color=0,255,0>V藅 ph萴 n祔  kh鉧 b秓 hi觤 v躰h vi詎<color>");
			break;
		case LOCK_STATE_LOCK:
			sprintf(pszTemp2, "<color=0,255,0>V藅 ph萴 n祔  kh鉧 b秓 hi觤<color>");
			break;
		case LOCK_STATE_UNLOCK:
			if (m_CommonAttrib.LockItem.dwLockTime > KSG_GetCurSec())
			{
				time_t nowtime=m_CommonAttrib.LockItem.dwLockTime+1451581200;
				struct tm * timeinfo = localtime(&nowtime);
				strcpy(pszTemp, "<color=0,255,0>Th阨 gian m?kh鉧: %H:%M:%S %d-%m-%Y<color>");
				strftime(pszTemp2, sizeof(pszTemp2), pszTemp, timeinfo);
			}
			break;
	}
	if (pszTemp2[0])
	{
		strcat(pszMsg, "\n");
		strcat(pszMsg, pszTemp2);
	}

	sprintf(pszKeyName, "%d", m_CommonAttrib.nSeries);
	g_GameSetting.GetString("Elements", pszKeyName, "", pszTemp, sizeof(pszTemp));
	if (pszTemp[0])
	{
		strcat(pszMsg, "\n");
		strcat(pszMsg, pszTemp);
	}

	if (m_CommonAttrib.szIntro[0])
	{
		char szIntro[SZBUFLEN_1];
		const char* pszIntro = SkipVngDisplayPrefix(m_CommonAttrib.szIntro);
		int nSrc = 0;
		int nDst = 0;
		int nVisible = 0;

		// Copy and wrap without growing the source buffer in place.
		while (pszIntro[nSrc] && nDst < SZBUFLEN_1 - 1)
		{
			if (pszIntro[nSrc] == '<')
			{
				int nTagEnd = nSrc;
				while (pszIntro[nTagEnd] && pszIntro[nTagEnd] != '>' && nTagEnd - nSrc < 31)
					nTagEnd++;
				if (pszIntro[nTagEnd] == '>')
				{
					int nTagLen = nTagEnd - nSrc + 1;
					if (nDst + nTagLen >= SZBUFLEN_1)
						break;
					memcpy(szIntro + nDst, pszIntro + nSrc, nTagLen);
					if (nTagLen == 7 && strncmp(pszIntro + nSrc, "<enter>", 7) == 0)
						nVisible = 0;
					nDst += nTagLen;
					nSrc += nTagLen;
					continue;
				}
			}

			if (nVisible >= 32)
			{
				if (nDst + 7 >= SZBUFLEN_1)
					break;
				memcpy(szIntro + nDst, "<enter>", 7);
				nDst += 7;
				nVisible = 0;
			}

			int nCharBytes = ((unsigned char)pszIntro[nSrc] >= 0x80 && pszIntro[nSrc + 1]) ? 2 : 1;
			if (nDst + nCharBytes >= SZBUFLEN_1)
				break;
			memcpy(szIntro + nDst, pszIntro + nSrc, nCharBytes);
			nDst += nCharBytes;
			nSrc += nCharBytes;
			nVisible++;
		}
		szIntro[nDst] = 0;

		strcat(pszMsg, "\n");
		strcat(pszMsg, szIntro);
	}
	if (m_CommonAttrib.nItemGenre == item_equip)
	{
		/*if (m_aryBaseAttrib[0].nAttribType > 0 ||
			m_aryRequireAttrib[0].nAttribType > 0 ||
			m_aryMagicAttrib[0].nAttribType > 0)*/
			strcat(pszMsg, "\n\n");
	}
	else
		strcat(pszMsg, "\n");

	if (m_CommonAttrib.nItemGenre == item_magicscript)
	{
		if (m_GeneratorParam.nLuck)
		{
			KTabFile MagicTab;

			MagicTab.Load(MAGICATTRIB_LVINDEX_FILE);

			sprintf(pszKeyName,"%d", m_GeneratorParam.nLuck);

			MagicTab.GetString(pszKeyName,"DESC","",pszTemp,sizeof(pszTemp));
			strcat(pszMsg, "<color=100,100,255>Thu閏 t輓h: ");
			strcat(pszMsg, pszTemp);
			strcat(pszMsg, "\n");
			MagicTab.GetString(pszKeyName,"FIT_EQUIP","",pszTemp,sizeof(pszTemp));
			strcat(pszMsg, "<color=255,219,74>Lo筰 trang b?c?th?kh秏 n筸: ");
			strcat(pszMsg, pszTemp);
			strcat(pszMsg, "<color=255,255,255>");
			strcat(pszMsg, "\n");
		}

		if(m_CommonAttrib.nLevel)
		{
			sprintf(pszTemp, "<color=100,100,255>Ph萴 ch蕋 thu閏 t輓h: <color=255,255,0>%d<color=255,255,255>", m_CommonAttrib.nLevel);
			strcat(pszMsg, pszTemp);
		}
	}

	(void)nActiveAttrib;
	const BOOL bSetEquipment = m_CommonAttrib.nSetID > 0;
	int i = 0;
	for (i = 0; i < MAX_ITEM_BASEATTRIB; ++i)
	{
		if (m_aryBaseAttrib[i].nAttribType <= 0)
			continue;
		if (m_aryBaseAttrib[i].nAttribType == magic_durability_v)
		{
			if (GetDurability() == -1)
				sprintf(pszTemp, "<color=255,255,0>Khong the pha huy<color=255,255,255>");
			else
				sprintf(pszTemp, "Do ben: %3d / %3d", GetDurability(), GetMaxDurability());
			strcat(pszMsg, pszTemp);
		}
		else
		{
			const char* pszAttrib = g_MagicDesc.GetDesc(&m_aryBaseAttrib[i]);
			if (!pszAttrib || !pszAttrib[0])
				continue;
			strcat(pszMsg, pszAttrib);
		}
		strcat(pszMsg, "\n");
	}

	for (i = 0; i < 6; ++i)
	{
		if (m_aryRequireAttrib[i].nAttribType <= 0)
			continue;
		const char* pszRequirement = g_MagicDesc.GetDesc(&m_aryRequireAttrib[i]);
		if (!pszRequirement || !pszRequirement[0])
			continue;
		strcat(pszMsg, Player[CLIENT_PLAYER_INDEX].m_ItemList.EnoughAttrib(&m_aryRequireAttrib[i]) ?
			"<color=255,255,255>" : "<color=255,0,0>");
		strcat(pszMsg, pszRequirement);
		strcat(pszMsg, "\n");
	}

	int nRemainingSetLines = nGoldActiveAttrib;
	for (i = 0; i < MAX_ITEM_MAGICATTRIB; ++i)
	{
		if(bSetEquipment && i==MAX_ITEM_NORMAL_MAGICATTRIB)
		{
			char upgradeLine[256];PhongThanUpgradeDescription(*this,upgradeLine);
			strcat(pszMsg,upgradeLine);
		}
		if (m_aryMagicAttrib[i].nAttribType <= 0)
			continue;
		const char* pszAttrib = g_MagicDesc.GetDesc(&m_aryMagicAttrib[i]);
		if (!pszAttrib || !pszAttrib[0])
			continue;

		if (bSetEquipment && i >= MAX_ITEM_NORMAL_MAGICATTRIB)
		{
			if (nRemainingSetLines > 0)
			{
				strcat(pszMsg, "<color=99,101,255>");
				--nRemainingSetLines;
			}
			else
			{
				strcat(pszMsg, "<color=120,120,120>");
			}
		}
		else
		{
			strcat(pszMsg, "<color=99,101,255>");
		}
		strcat(pszMsg, pszAttrib);
		strcat(pszMsg, "\n<color=255,255,255>");
	}

	if(!bSetEquipment)
	{
		char upgradeLine[256];PhongThanUpgradeDescription(*this,upgradeLine);
		strcat(pszMsg,upgradeLine);
	}

		if (m_CommonAttrib.nExpireTime > KSG_GetCurSec())
	{
		time_t nowtime= m_CommonAttrib.nExpireTime+1451581200;
		struct tm * timeinfo = localtime(&nowtime);
		strcpy(pszTemp, "<color=255,90,0>Th阨 h筺 s?d鬾g: %H:%M:%S %d-%m-%Y<color>");
		strftime(pszTemp2, sizeof(pszTemp2), pszTemp, timeinfo);
		strcat(pszMsg, "\n");
		strcat(pszMsg,pszTemp2);
		strcat(pszMsg, "\n");
	}

	if (m_CommonAttrib.nExpirePoint)
	{
		time_t nowtime = m_CommonAttrib.nExpirePoint+(KSG_GetCurSec()+1451581200);
		struct tm * timeinfo = localtime(&nowtime);
		strcpy(pszTemp, "<color=255,90,0>Th阨 h筺 s?d鬾g: %H:%M:%S %d-%m-%Y<color>");
		strftime(pszTemp2, sizeof(pszTemp2), pszTemp, timeinfo);
		strcat(pszMsg, "\n");
		strcat(pszMsg,pszTemp2);
		strcat(pszMsg, "\n");
	}
	if(GetGenre()==item_equip)
	{
		int total=0;char line[256];
		strcat(pszMsg,"<color=255,255,0>");
		if(PhongThanKnownTooltipPower(*this,total))sprintf(line,PT_TEXT_POWER,total);
		else strcpy(line,PT_TEXT_UNKNOWN_POWER);
		strcat(pszMsg,line);strcat(pszMsg,"<color=255,255,255>\n\n");
		sprintf(line,PT_TEXT_WEIGHT,m_CommonAttrib.nWeight);strcat(pszMsg,line);
		strcat(pszMsg,"\n\n");strcat(pszMsg,PT_TEXT_CHAT_HINT);strcat(pszMsg,"\n");
	}
	PlayerItem m_pItems;
	memset(&m_pItems, 0, sizeof(m_pItems));
	int nItemListIdx = Player[CLIENT_PLAYER_INDEX].m_ItemList.FindSame(m_dwID);
	if (nItemListIdx > 0 && nItemListIdx < MAX_PLAYER_ITEM)
		 m_pItems = Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Items[nItemListIdx];
	// Set lines above come directly from the VNG additional-attribute table
	// through m_aryMagicAttrib[6..]. The inherited GoldEquip.txt tooltip path
	// is intentionally removed to prevent Vo Lam rows and duplicate lines.
	// Hover is a read-only table description, not a gameplay Lua execution.
	// Scripts remain on the explicit use/action path.
	if (m_CommonAttrib.nFortune)
	{
		sprintf(pszTemp2, "<color=255,255,0>Tr?s?t礽 ph?binh gi竝:<color> <color=0,255,0>%d<color>", m_CommonAttrib.nFortune);

		strcat(pszMsg, "\n");
		strcat(pszMsg, pszTemp2);
		strcat(pszMsg, "\n<color=255,255,255>");
	}

	if ((Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_PTrade.nTrade || bShowPrice) &&
		m_CommonAttrib.nTradePrice)
	{
		strcat(pszMsg,"\n");
		strcat(pszMsg, "<color=255,255,255>Gi?ni猰 y誸: <color=255,255,0>");
		if (m_CommonAttrib.nTradePrice < MONEY_FLOOR)
			sprintf(pszTemp,"%d lng",m_CommonAttrib.nTradePrice);
		else if ((m_CommonAttrib.nTradePrice % MONEY_FLOOR) == 0)
			sprintf(pszTemp,"%d v筺 lng",m_CommonAttrib.nTradePrice / MONEY_FLOOR);
		else
			sprintf(pszTemp,"%d v筺 %d lng",m_CommonAttrib.nTradePrice / MONEY_FLOOR, m_CommonAttrib.nTradePrice % MONEY_FLOOR);
		strcat(pszMsg, pszTemp);
	}

//Debug
#ifdef SWORDONLINE_SHOW_DBUG_INFO
	if(Player[CLIENT_PLAYER_INDEX].m_bDebugMode)
	{
		char szTemp[64];
		sprintf(szTemp, "<color=green>ItemID: [%d]<color>", m_dwID);
		strcat(pszMsg, "\n");
		strcat(pszMsg, szTemp);
		strcat(pszMsg, "\n");
	}
#endif
//end code
	::strncpy(pszOutput, szSafeDesc, GOD_MAX_OBJ_TITLE_LEN - 1);
	pszOutput[GOD_MAX_OBJ_TITLE_LEN - 1] = 0;
#undef strcat
}
#endif

void KItem::SetDurability(IN const int nDur)
{
	m_nCurrentDur = nDur;
};

int KItem::GetMaxDurability()
{
	for (int i = 0; i < MAX_ITEM_BASEATTRIB; i++)
	{
		if (m_aryBaseAttrib[i].nAttribType == magic_durability_v)
		{
			return m_aryBaseAttrib[i].nValue[0];
		}
	}
	return -1;
}

int KItem::GetTotalMagicLevel()
{
	int nRet = 0;
	for (int i = 0; i < MAX_ITEM_MAGICATTRIB; i++)
	{
		nRet += m_GeneratorParam.nGeneratorLevel[i];
	}
	return nRet;
}

BOOL KItem::IsReduce()
{
	for (int i = 0; i < MAX_ITEM_MAGICATTRIB; i++)
	{
		if (m_GeneratorParam.nGeneratorLevel[i] > MAX_ITEM_GENERATORLEVEL)
			return TRUE;
	}
	return FALSE;
}

int KItem::GetRepairPrice()
{
	if (!ItemSet.m_sRepairParam.nMagicScale)
		return 0;

	if (m_CommonAttrib.nItemGenre != item_equip)
		return 0;

	if (m_nCurrentDur == -1)
		return 0;

	int nMaxDur = GetMaxDurability();
	if (nMaxDur <= 0)
		return 0;
	int nSumMagic = GetTotalMagicLevel();
	if (IsReduce())
		nSumMagic = MAX_ITEM_MAGICATTRIB * MAX_ITEM_GENERATORLEVEL;
	return m_CommonAttrib.nPrice * ItemSet.m_sRepairParam.nPriceScale / 100 *
		(nMaxDur - m_nCurrentDur) / nMaxDur *
		(ItemSet.m_sRepairParam.nMagicScale + nSumMagic) /
		ItemSet.m_sRepairParam.nMagicScale;
}

BOOL KItem::CanBeRepaired()
{
	if (GetGenre() != item_equip)
		return FALSE;

	if (m_nCurrentDur == -1)
		return FALSE;

	int nMaxDur = GetMaxDurability();
	if (m_nCurrentDur == nMaxDur)
		return FALSE;

	return TRUE;
}

BOOL KItem::CanShortKey()
{
	if (m_CommonAttrib.nWidth != 1 || m_CommonAttrib.nHeight != 1)
		return FALSE;

	return m_CommonAttrib.bShortKey;
}

int KItem::GetParticularMelee()
{	int nParticularTypeMellee = m_CommonAttrib.nParticularType;
	if (m_CommonAttrib.nObjIdx == 9)
		nParticularTypeMellee = 0;
	else if (m_CommonAttrib.nObjIdx == 10)
		nParticularTypeMellee = 1;
	else if (m_CommonAttrib.nObjIdx == 11)
		nParticularTypeMellee = 2;
	else if (m_CommonAttrib.nObjIdx == 12)
		nParticularTypeMellee = 3;
	else if (m_CommonAttrib.nObjIdx == 13)
		nParticularTypeMellee = 4;
	else if (m_CommonAttrib.nObjIdx == 14)
		nParticularTypeMellee = 5;
	else if (m_CommonAttrib.nDetailType == 1)
	{
		if (nParticularTypeMellee == 3)
			nParticularTypeMellee = 0;
		else if (nParticularTypeMellee == 4)
			nParticularTypeMellee = 1;
		else if (nParticularTypeMellee == 5)
			nParticularTypeMellee = 2;
	}
	return nParticularTypeMellee;
}

int KItem::GetQuality()
{
	if (GetGenre() == item_equip)
	{
		if(m_nCurrentDur == 0)
			return equip_damage;
		if (m_CommonAttrib.nSetID > 0)
			return equip_set;
		// VNG set/additional attributes live after the six ordinary slots. They
		// still make a normal item green even when slot zero is intentionally
		// empty, so inspect the complete attribute payload.
		for (int nAttrib = 0; nAttrib < MAX_ITEM_MAGICATTRIB; ++nAttrib)
		{
			if (m_aryMagicAttrib[nAttrib].nAttribType > 0)
				return equip_magic;
		}
	}
	return equip_normal;
}

int KItem::GetSalePrice()
{
	if(m_CommonAttrib.bLockTrade)
		return 0;

	return (m_CommonAttrib.nPrice/BUY_SELL_SCALE)*m_CommonAttrib.nStackNum;
}

//TamLTM kham nam
int KItem::GetColorItem()
{
	if (GetGenre() == item_equip)
	{
		if(m_nCurrentDur == 0)
			return 5;
		if (m_CommonAttrib.nSetID > 0)
			return 3;
		for (int nAttrib = 0; nAttrib < MAX_ITEM_MAGICATTRIB; ++nAttrib)
		{
			if (m_aryMagicAttrib[nAttrib].nAttribType > 0)
				return 1;
		}
	}
	return 0;
}
//End code
