//---------------------------------------------------------------------------
// Sword3 Core (c) 2002 by Kingsoft
//
// File:	KItemGenerator.CPP
// Date:	2002.08.26
// Code:	DongBo
// Desc:    CPP file. 本文件实现的类用于生成道具
//---------------------------------------------------------------------------
#include "KEngine.h"
#include "KCore.h"
#include "MyAssert.H"
#include "KItem.h"
#include "KSubWorldSet.h"
#include "KItemGenerator.h"
#include "PhongThanStarterBag.h"
#include "PhongThanStarterBagProperty.h"
#include "../../../Headers/PhongThanItemSeries.h"
#include "../../../Headers/PhongThanEquipmentProjection.h"

KItemGenerator	ItemGen;			//	装备生成器


BOOL KItemGenerator::ApplyPhongThanSetAttrib(
	IN KItem* pItem, IN const KBASICPROP_EQUIPMENT* pEqu) const
{
	if (!pItem || !pEqu)
		return FALSE;

	// VNG component tables reserve basic slots 1..5 for white properties and
	// slots 6..10 for the item's fixed blue property types. SetAttrib_Base has
	// already rolled each value once inside its source min/max range. Move that
	// result without changing its type or rolling a SwordOnline prefix/suffix.
	ZeroMemory(pItem->m_aryMagicAttrib, sizeof(pItem->m_aryMagicAttrib));
	PhongThanProjectEquipmentModifiers(pItem->m_aryBaseAttrib, MAX_ITEM_BASEATTRIB,
		pItem->m_aryMagicAttrib, MAX_ITEM_NORMAL_MAGICATTRIB, magic_normal_begin, magic_normal_end);
	// SetID identifies equipment membership, not a crafting GroupID.
	// zhuang_bei_dian_lan_fu_jia_shu_xing_biao is selected by crafting
	// rules; attaching its same-numbered row here invents set bonuses.
	// Read the actual VNG set-ID table, not the crafting GroupID table.
	KEQCP_VNG_FIXED effects[MAX_VNG_SET_ATTRIB];
	if (pItem->GetSetID() <= 0)
		return TRUE;
	int count = m_BPTLib.GetVngSetAttrib(pItem->GetSetID(), effects, MAX_VNG_SET_ATTRIB);
	for (int i = 0; i < count && MAX_ITEM_NORMAL_MAGICATTRIB + i < MAX_ITEM_MAGICATTRIB; ++i)
	{
		KItemNormalAttrib& target = pItem->m_aryMagicAttrib[MAX_ITEM_NORMAL_MAGICATTRIB + i];
		target.nAttribType = effects[i].nType;
		memcpy(target.nValue, effects[i].nValue, sizeof(target.nValue));
	}
	return TRUE;
}

KItemGenerator::KItemGenerator()
{
}

KItemGenerator::~KItemGenerator()
{
}

/******************************************************************************
	功能：	数据初始化. 从tab file中读取数据
******************************************************************************/
BOOL KItemGenerator::Init()
{
	if (!m_BPTLib.Init())		// 此调用从若干的tab file中载入所有的初始属性
		return FALSE;

	for (int i = equip_meleeweapon; i < equip_detailnum - equip_meleeweapon; i++)
	{
		switch(i)
		{
		case equip_meleeweapon:
			m_EquipNumOfEntries[i] = m_BPTLib.GetMeleeWeaponRecordNumber();
			break;
		case equip_rangeweapon:
			m_EquipNumOfEntries[i] = m_BPTLib.GetRangeWeaponRecordNumber();
			break;
		case equip_armor:
			m_EquipNumOfEntries[i] = m_BPTLib.GetArmorRecordNumber();
			break;
		case equip_helm:
			m_EquipNumOfEntries[i] = m_BPTLib.GetHelmRecordNumber();
			break;
		case equip_boots:
			m_EquipNumOfEntries[i] = m_BPTLib.GetBootRecordNumber();
			break;
		case equip_belt:
			m_EquipNumOfEntries[i] = m_BPTLib.GetBeltRecordNumber();
			break;
		case equip_cuff:
			m_EquipNumOfEntries[i] = m_BPTLib.GetCuffRecordNumber();
			break;
		case equip_amulet:
			m_EquipNumOfEntries[i] = m_BPTLib.GetAmuletRecordNumber();
			break;
		case equip_ring:
			m_EquipNumOfEntries[i] = m_BPTLib.GetRingRecordNumber();
			break;
		case equip_pendant:
			m_EquipNumOfEntries[i] = m_BPTLib.GetPendantRecordNumber();
			break;
		case equip_horse:
			m_EquipNumOfEntries[i] = m_BPTLib.GetHorseRecordNumber();
			break;
		case equip_signet:
			m_EquipNumOfEntries[i] = m_BPTLib.GetSignetRecordNumber();
			break;
		case equip_shipin:
			m_EquipNumOfEntries[i] = m_BPTLib.GetShipinRecordNumber();
			break;
		}
	}
	m_MedNumOfEntries = m_BPTLib.GetMedicineRecordNumber();
	return TRUE;
}

/******************************************************************************
	功能：	生成药品
	入口:	nDetailType: 药品类型
			nLevel: 等级
			nVersion: 版本号
	出口:	成功时返回非零, 相关数据在 pItem 所指对象中给出
			失败时返回零
******************************************************************************/
BOOL KItemGenerator::Gen_Medicine(IN int nDetailType,
								  IN int nLevel,
								  IN int nVersion,
								  IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);

	BOOL bEC = FALSE;
	
#ifdef _SERVER	// 服务器版本
	pItem->m_GeneratorParam.uRandomSeed = g_GetRandomSeed();
	pItem->m_GeneratorParam.nVersion = g_SubWorldSet.GetGameVersion();
	pItem->m_GeneratorParam.nLuck = 0;
#else
	g_RandomSeed(pItem->m_GeneratorParam.uRandomSeed);
	int nGameVersion = pItem->m_GeneratorParam.nVersion;
#endif

	// VNG potion.txt gives every potion its own DetailType. There is no
	// SwordOnline five-level block per detail; creation and reload must use
	// the same verified identity lookup.
	const KBASICPROP_MEDICINE* pMed = m_BPTLib.FindMedicine(nDetailType, nLevel);
	if (NULL == pMed)
	{
		_ASSERT(FALSE);
		return bEC;
	}
	*pItem = *pMed;
	return TRUE;
}
/******************************************************************************
	功能：	生成随机装备
	入口:	nDetailType: 具体类别, 如近程武器、暗器、......
			nParticularType: 详细类别
			nSeriesReq: 五行属性
			nLevel: 等级
			pnaryMALevel: 魔法属性等级数组[6]
			nLucky: 运气值
	出口:	成功时返回非零, 相关数据在 pItem 所指对象中给出
			失败时返回零
******************************************************************************/
const KBASICPROP_EQUIPMENT* KItemGenerator::GetEquipmentTemplate(
	IN int nDetailType, IN int nTemplateRow) const
{
	if (nTemplateRow < 0)
		return NULL;
	switch (nDetailType)
	{
	case equip_meleeweapon: return m_BPTLib.GetMeleeWeaponRecord(nTemplateRow);
	case equip_rangeweapon: return m_BPTLib.GetRangeWeaponRecord(nTemplateRow);
	case equip_armor: return m_BPTLib.GetArmorRecord(nTemplateRow);
	case equip_helm: return m_BPTLib.GetHelmRecord(nTemplateRow);
	case equip_boots: return m_BPTLib.GetBootRecord(nTemplateRow);
	case equip_belt: return m_BPTLib.GetBeltRecord(nTemplateRow);
	case equip_amulet: return m_BPTLib.GetAmuletRecord(nTemplateRow);
	case equip_ring: return m_BPTLib.GetRingRecord(nTemplateRow);
	case equip_cuff: return m_BPTLib.GetCuffRecord(nTemplateRow);
	case equip_pendant: return m_BPTLib.GetPendantRecord(nTemplateRow);
	case equip_horse: return m_BPTLib.GetHorseRecord(nTemplateRow);
	case equip_signet: return m_BPTLib.GetSignetRecord(nTemplateRow);
	case equip_shipin: return m_BPTLib.GetShipinRecord(nTemplateRow);
	default: return NULL;
	}
}

int KItemGenerator::FindEquipmentTemplateRow(IN int nDetailType,
	IN int nParticularType, IN int nLevel, IN int nSeries) const
{
	int nCount = 0;
	switch (nDetailType)
	{
	case equip_meleeweapon: nCount = m_BPTLib.GetMeleeWeaponRecordNumber(); break;
	case equip_rangeweapon: nCount = m_BPTLib.GetRangeWeaponRecordNumber(); break;
	case equip_armor: nCount = m_BPTLib.GetArmorRecordNumber(); break;
	case equip_helm: nCount = m_BPTLib.GetHelmRecordNumber(); break;
	case equip_boots: nCount = m_BPTLib.GetBootRecordNumber(); break;
	case equip_belt: nCount = m_BPTLib.GetBeltRecordNumber(); break;
	case equip_amulet: nCount = m_BPTLib.GetAmuletRecordNumber(); break;
	case equip_ring: nCount = m_BPTLib.GetRingRecordNumber(); break;
	case equip_cuff: nCount = m_BPTLib.GetCuffRecordNumber(); break;
	case equip_pendant: nCount = m_BPTLib.GetPendantRecordNumber(); break;
	case equip_horse: nCount = m_BPTLib.GetHorseRecordNumber(); break;
	case equip_signet: nCount = m_BPTLib.GetSignetRecordNumber(); break;
	case equip_shipin: nCount = m_BPTLib.GetShipinRecordNumber(); break;
	default: return -1;
	}

	for (int i = 0; i < nCount; ++i)
	{
		const KBASICPROP_EQUIPMENT* pEqu = GetEquipmentTemplate(nDetailType, i);
		if (pEqu && pEqu->m_nParticularType == nParticularType &&
			pEqu->m_nLevel == nLevel &&
			(nSeries < series_metal || nSeries > series_earth ||
			 pEqu->m_nSeries == nSeries))
			return i;
	}
	return -1;
}

BOOL KItemGenerator::Gen_Equipment(IN int nDetailType,
								   IN int nParticularType,
								   IN int nSeriesReq,
								   IN int nLevel,
								   IN const int* pnaryMALevel,
								   IN int nLucky,
								   IN int nVersion,
								   IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);
	BOOL bEC = FALSE;
	#ifdef _SERVER	// 服务器版本
		pItem->m_GeneratorParam.uRandomSeed = g_GetRandomSeed();
		if (pnaryMALevel)
			memcpy(pItem->m_GeneratorParam.nGeneratorLevel, pnaryMALevel, sizeof(int) * MAX_ITEM_MAGICLEVEL);
		else
			ZeroMemory(pItem->m_GeneratorParam.nGeneratorLevel, sizeof(int) * MAX_ITEM_MAGICLEVEL);
		pItem->m_GeneratorParam.nVersion = g_SubWorldSet.GetGameVersion();
	#else
		g_RandomSeed(pItem->m_GeneratorParam.uRandomSeed);
		if (pnaryMALevel)
			memcpy(pItem->m_GeneratorParam.nGeneratorLevel, pnaryMALevel, sizeof(int) * MAX_ITEM_MAGICLEVEL);
	#endif
		pItem->m_GeneratorParam.nLuck = nLucky;
		int nGameVersion = pItem->m_GeneratorParam.nVersion;

		// 根据入口参数, 确定装备的基本数据
		const int i = FindEquipmentTemplateRow(
			nDetailType, nParticularType, nLevel, nSeriesReq);
		if (i < 0)
			return FALSE;
		const KBASICPROP_EQUIPMENT* pEqu = NULL;
		switch(nDetailType)
		{
		case equip_meleeweapon:
			pEqu = m_BPTLib.GetMeleeWeaponRecord(i);
			break;
		case equip_rangeweapon:
			pEqu = m_BPTLib.GetRangeWeaponRecord(i);
			break;
		case equip_armor:
			pEqu = m_BPTLib.GetArmorRecord(i);
			break;
		case equip_helm:
			pEqu = m_BPTLib.GetHelmRecord(i);
			break;
		case equip_boots:
			pEqu = m_BPTLib.GetBootRecord(i);
			break;
		case equip_belt:
			pEqu = m_BPTLib.GetBeltRecord(i);
			break;
		case equip_amulet:
			pEqu = m_BPTLib.GetAmuletRecord(i);
			break;
		case equip_ring:
			pEqu = m_BPTLib.GetRingRecord(i);
			break;
		case equip_cuff:
			pEqu = m_BPTLib.GetCuffRecord(i);
			break;
		case equip_pendant:
			pEqu = m_BPTLib.GetPendantRecord(i);
			break;
		case equip_horse:
			pEqu = m_BPTLib.GetHorseRecord(i);
			break;
		case equip_signet:
			pEqu = m_BPTLib.GetSignetRecord(i);
			break;
		case equip_shipin:
			pEqu = m_BPTLib.GetShipinRecord(i);
			break;
		default:
			break;
		}
		if (NULL == pEqu)
			{ _ASSERT(FALSE); return bEC; }
			// 运行至此的直接原因: 只有n种装备, 而上面 i 的值在[0,n-1]之外
			// 检查3点: nParticularType 有误?
			//			nLevel 有误?
			//			原始的tab file有误导致 m_BPTLib.m_BPTEquipment 所
			//			管理的数据有问题?
		pItem->SetAttrib_CBR(pEqu);
		pItem->SetSeries(PhongThanResolveItemSeries(pItem->GetSeries(), nSeriesReq, series_num, series_nil));
		pItem->SetRow(i);

		// A SetID in the active VNG component table identifies Phong Than gold
		// equipment. Its property types are fixed in armor/helm/belt/...txt;
		// only their source min/max values may vary. Never feed these records to
		// the inherited SwordOnline prefix/suffix generator.
		if (pEqu)
		{
			ApplyPhongThanSetAttrib(pItem, pEqu);
			return TRUE;
		}

		// Attribute types come only from the VNG row. SetAttrib_CBR rolls each
		// value only inside the min/max interval declared by that same row.
		return TRUE;
}

BOOL KItemGenerator::Gen_EquipmentByTemplateRow(IN int nDetailType,
	IN int nTemplateRow, IN int nSeriesReq, IN const int* pnaryMALevel,
	IN int nLucky, IN int nVersion, IN OUT KItem* pItem)
{
	_ASSERT(pItem != NULL);
	if (!pItem)
		return FALSE;
	const KBASICPROP_EQUIPMENT* pEqu = GetEquipmentTemplate(
		nDetailType, nTemplateRow);
	if (!pEqu || pEqu->m_nDetailType != nDetailType)
		return FALSE;

#ifdef _SERVER
	pItem->m_GeneratorParam.uRandomSeed = g_GetRandomSeed();
	pItem->m_GeneratorParam.nVersion = g_SubWorldSet.GetGameVersion();
#else
	g_RandomSeed(pItem->m_GeneratorParam.uRandomSeed);
	pItem->m_GeneratorParam.nVersion = nVersion;
#endif
	if (pnaryMALevel)
		memcpy(pItem->m_GeneratorParam.nGeneratorLevel, pnaryMALevel,
			sizeof(int) * MAX_ITEM_MAGICLEVEL);
	else
		ZeroMemory(pItem->m_GeneratorParam.nGeneratorLevel,
			sizeof(int) * MAX_ITEM_MAGICLEVEL);
	pItem->m_GeneratorParam.nLuck = nLucky;

	if (!pItem->SetAttrib_CBR(pEqu))
		return FALSE;
	// VNG 1000 is an unrestricted template marker, not a wire profession.
	pItem->SetSeries(PhongThanResolveItemSeries(pItem->GetSeries(), nSeriesReq, series_num, series_nil));
	pItem->SetRow(nTemplateRow);
	ApplyPhongThanSetAttrib(pItem, pEqu);
	return TRUE;
}

BOOL KItemGenerator::Gen_ExistEquipmentByTemplateRow(IN int nDetailType,
	IN int nTemplateRow, IN int nSeriesReq, IN const int* pnaryMALevel,
	IN int nLucky, IN int nVersion, IN OUT KItem* pItem)
{
	_ASSERT(pItem != NULL);
	if (!pItem)
		return FALSE;
	const KBASICPROP_EQUIPMENT* pEqu = GetEquipmentTemplate(
		nDetailType, nTemplateRow);
	if (!pEqu || pEqu->m_nDetailType != nDetailType)
		return FALSE;

	g_RandomSeed(pItem->m_GeneratorParam.uRandomSeed);
	if (pnaryMALevel)
		memcpy(pItem->m_GeneratorParam.nGeneratorLevel, pnaryMALevel,
			sizeof(int) * MAX_ITEM_MAGICLEVEL);
	pItem->m_GeneratorParam.nLuck = nLucky;
	pItem->m_GeneratorParam.nVersion = nVersion;

	if (!pItem->SetAttrib_CBR(pEqu))
		return FALSE;
	pItem->SetSeries(PhongThanResolveItemSeries(pItem->GetSeries(), nSeriesReq, series_num, series_nil));
	pItem->SetRow(nTemplateRow);
	ApplyPhongThanSetAttrib(pItem, pEqu);
	return TRUE;
}

BOOL KItemGenerator::GetMedicineCommonAttrib(IN int nDetailType, IN int nLevel, IN OUT KItem* pItem)
{
	if (NULL == pItem)
	{
		KASSERT(FALSE);
		return FALSE;
	}

	const KBASICPROP_MEDICINE* pMed = m_BPTLib.FindMedicine(nDetailType, nLevel);
	if (NULL == pMed)
	{
		_ASSERT(FALSE);
		return FALSE;
	}
	*pItem = *pMed;
	return TRUE;
}
/******************************************************************************
	功能：	生成指定黄金装备装备
	入口:	nCondition: 前提条件，(Emf+Pmf)*Level的运算结果
			pItem: 装备项目指针。
	出口:	成功时返回真, 相关数据在 pItem 所指对象中给出
			失败时返回假
******************************************************************************/
BOOL KItemGenerator::GetEquipmentCommonAttrib(IN int nDetailType, IN int nParticularType, IN int nLevel, IN int nSeries, IN OUT KItem* pItem)
{
	if (NULL == pItem)
	{
		KASSERT(FALSE);
		return FALSE;
	}

	const int i = FindEquipmentTemplateRow(
		nDetailType, nParticularType, nLevel, nSeries);
	if (i < 0)
		return FALSE;
	const KBASICPROP_EQUIPMENT* pEqu = NULL;
	switch(nDetailType)
	{
	case equip_meleeweapon:
		pEqu = m_BPTLib.GetMeleeWeaponRecord(i);
		break;
	case equip_rangeweapon:
		pEqu = m_BPTLib.GetRangeWeaponRecord(i);
		break;
	case equip_armor:
		pEqu = m_BPTLib.GetArmorRecord(i);
		break;
	case equip_helm:
		pEqu = m_BPTLib.GetHelmRecord(i);
		break;
	case equip_boots:
		pEqu = m_BPTLib.GetBootRecord(i);
		break;
	case equip_belt:
		pEqu = m_BPTLib.GetBeltRecord(i);
		break;
	case equip_amulet:
		pEqu = m_BPTLib.GetAmuletRecord(i);
		break;
	case equip_ring:
		pEqu = m_BPTLib.GetRingRecord(i);
		break;
	case equip_cuff:
		pEqu = m_BPTLib.GetCuffRecord(i);
		break;
	case equip_pendant:
		pEqu = m_BPTLib.GetPendantRecord(i);
		break;
	case equip_horse:
		pEqu = m_BPTLib.GetHorseRecord(i);
		break;
	case equip_signet:
		pEqu = m_BPTLib.GetSignetRecord(i);
		break;
	case equip_shipin:
		pEqu = m_BPTLib.GetShipinRecord(i);
		break;
	default:
		break;
	}
	if (NULL == pEqu)
		{ _ASSERT(FALSE); return FALSE; }
		// 运行至此的直接原因: 只有n种装备, 而上面 i 的值在[0,n-1]之外
		// 检查3点: nParticularType 有误?
		//			nLevel 有误?
		//			原始的tab file有误导致 m_BPTLib.m_BPTEquipment 所
		//			管理的数据有问题?
	pItem->SetAttrib_CBR(pEqu);
	pItem->SetRow(i);
	if (nSeries < series_metal)
		pItem->SetSeries(::GetRandomNumber(series_metal, series_earth));
	else
		pItem->SetSeries(nSeries);
	return TRUE;
}

/******************************************************************************
	功能：	生成随机装备
	入口:	nDetailType: 具体类别, 如近程武器、暗器、......
			nParticularType: 详细类别
			nSeriesReq: 五行属性
			nLevel: 等级
			pnaryMALevel: 魔法属性等级数组[6]
			nLucky: 运气值
	出口:	成功时返回非零, 相关数据在 pItem 所指对象中给出
			失败时返回零
******************************************************************************/
BOOL KItemGenerator::Gen_ExistEquipment(IN int nDetailType,
									    IN int nParticularType,
									    IN int nSeriesReq,
									    IN int nLevel,
									    IN const int* pnaryMALevel,
									    IN int nLucky,
									    IN int nVersion,
									    IN OUT KItem* pItem
									   )
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);
	BOOL bEC = FALSE;

		g_RandomSeed(pItem->m_GeneratorParam.uRandomSeed);
		if (pnaryMALevel)
			memcpy(pItem->m_GeneratorParam.nGeneratorLevel, pnaryMALevel, sizeof(int) * MAX_ITEM_MAGICLEVEL);
		int nGameVersion = pItem->m_GeneratorParam.nVersion;

		// 根据入口参数, 确定装备的基本数据
		const int i = pItem->GetRow();
		if (i < 0)
			return FALSE;
		const KBASICPROP_EQUIPMENT* pEqu = NULL;
		switch(nDetailType)
		{
		case equip_meleeweapon:
			pEqu = m_BPTLib.GetMeleeWeaponRecord(i);
			break;
		case equip_rangeweapon:
			pEqu = m_BPTLib.GetRangeWeaponRecord(i);
			break;
		case equip_armor:
			pEqu = m_BPTLib.GetArmorRecord(i);
			break;
		case equip_helm:
			pEqu = m_BPTLib.GetHelmRecord(i);
			break;
		case equip_boots:
			pEqu = m_BPTLib.GetBootRecord(i);
			break;
		case equip_belt:
			pEqu = m_BPTLib.GetBeltRecord(i);
			break;
		case equip_amulet:
			pEqu = m_BPTLib.GetAmuletRecord(i);
			break;
		case equip_ring:
			pEqu = m_BPTLib.GetRingRecord(i);
			break;
		case equip_cuff:
			pEqu = m_BPTLib.GetCuffRecord(i);
			break;
		case equip_pendant:
			pEqu = m_BPTLib.GetPendantRecord(i);
			break;
		case equip_horse:
			pEqu = m_BPTLib.GetHorseRecord(i);
			break;
		default:
			break;
		}
		if (NULL == pEqu)
			{ _ASSERT(FALSE); return bEC; }
			// 运行至此的直接原因: 只有n种装备, 而上面 i 的值在[0,n-1]之外
			// 检查3点: nParticularType 有误?
			//			nLevel 有误?
			//			原始的tab file有误导致 m_BPTLib.m_BPTEquipment 所
			//			管理的数据有问题?
		pItem->SetAttrib_CBR(pEqu);
		pItem->SetSeries(PhongThanResolveItemSeries(pItem->GetSeries(), nSeriesReq, series_num, series_nil));
		pItem->SetRow(i);

		// Reconstruct VNG gold equipment with the same deterministic property
		// layout as newly generated items. The saved random seed is used only by
		// SetAttrib_Base for each allowed min/max value.
		if (pEqu)
		{
			ApplyPhongThanSetAttrib(pItem, pEqu);
			return TRUE;
		}

		if (NULL == pnaryMALevel)
		{
			return TRUE;
		}
		KItemNormalAttrib	sMA[MAX_ITEM_MAGICATTRIB];	// 道具的魔法属性
		return TRUE;
}


BOOL KItemGenerator::Gen_Quest(IN int nDetailType, IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);

	BOOL bEC = FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	
	const KBASICPROP_QUEST* pQuest = NULL;
	pQuest = m_BPTLib.GetQuestRecord(nDetailType);
	if (NULL == pQuest)
	{
		_ASSERT(FALSE);
		return bEC;
	}
	*pItem = *pQuest;
	return TRUE;
}


BOOL KItemGenerator::Gen_SkillBook(IN int nDetail, IN int nSkill, IN int nLevel,
	IN OUT KItem* pItem)
{
	if (!pItem || nLevel < 0)
		return FALSE;
	const KBASICPROP_SKILLBOOK* book = m_BPTLib.GetSkillBook(nDetail, nSkill);
	if (!book)
		return FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	*pItem = *book;
	// Both 0 and 1 occur in original VNG AddNormalItem book calls. Preserve
	// the item's stored level; the book's skill identity is always column 4.
	pItem->SetLevel(nLevel);
	return TRUE;
}

BOOL KItemGenerator::Gen_TownPortal(IN int nDetailType, IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);

	BOOL bEC = FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	
	const KBASICPROP_TOWNPORTAL* pPortal = NULL;
	pPortal = m_BPTLib.GetTownPortalRecord(nDetailType);
	if (NULL == pPortal)
	{
		_ASSERT(FALSE);
		return bEC;
	}
	*pItem = *pPortal;
	return TRUE;
}

BOOL KItemGenerator::Gen_MagicScript(IN int nDetailType, IN OUT KItem* pItem, IN int nLevel, IN int nSeries, IN int nLuck)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);
	
	BOOL bEC = FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	
	const KBASICPROP_MAGICSCRIPT* pMagicScript = NULL;
	pMagicScript = m_BPTLib.GetMagicScript(nDetailType);
	if (!pMagicScript && nDetailType == PHONGTHAN_STARTER_BAG_ID)
		pMagicScript = PhongThanStarterBagProperty(m_BPTLib);
	if (NULL == pMagicScript)
	{
		_ASSERT(FALSE);
		return bEC;
	}
	*pItem = *pMagicScript;
	if (nDetailType == PHONGTHAN_STARTER_BAG_ID) {
		pItem->SetLockSell(TRUE); pItem->SetLockTrade(TRUE); pItem->SetLockDrop(TRUE);
	}
	if (nSeries < series_metal)
		pItem->SetSeries(::GetRandomNumber(series_metal, series_earth));
	else
		pItem->SetSeries(nSeries);
	pItem->SetLevel(nLevel);
	pItem->m_GeneratorParam.nLuck = nLuck;
	return TRUE;
}

BOOL KItemGenerator::Gen_IBItem(IN int nDetailType, IN int nParticularType, IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);
	if (!pItem)
		return FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	const KBASICPROP_IBITEM* pIBItem = m_BPTLib.GetIBItem(nDetailType, nParticularType);
	if (!pIBItem)
		return FALSE;
	*pItem = *pIBItem;
	return TRUE;
}

BOOL KItemGenerator::Gen_Event(IN int nDetailType, IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);
	
	BOOL bEC = FALSE;
	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	
	const KBASICPROP_EVENTITEM* pEvent = NULL;
	pEvent = m_BPTLib.GetEvent(nDetailType);
	if (NULL == pEvent)
	{
		_ASSERT(FALSE);
		return bEC;
	}
	*pItem = *pEvent;
	return TRUE;
}

BOOL KItemGenerator::Gen_Material(IN int nDetailType, IN OUT KItem* pItem)
{
	_ASSERT(this != NULL);
	_ASSERT(pItem != NULL);

	ZeroMemory(&pItem->m_GeneratorParam, sizeof(pItem->m_GeneratorParam));
	const KBASICPROP_EVENTITEM* pMaterial = m_BPTLib.GetMaterial(nDetailType);
	if (NULL == pMaterial)
	{
		_ASSERT(FALSE);
		return FALSE;
	}
	*pItem = *pMaterial;
	return TRUE;
}
