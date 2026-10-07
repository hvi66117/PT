#include "KCore.h"
#include "KEngine.h"
#include "KPhongThanAppearance.h"
#include "KItem.h"
#include "CoreUseNameDef.h"

KPhongThanAppearance g_PhongThanAppearance;

BOOL KPhongThanAppearance::ResolveTablePart(KTabFile& Table, int nEquipId,
	int nResourceOffset, PHONGTHAN_VISUAL_PART* pVisual)
{
	if (!pVisual)
		return FALSE;
	ZeroMemory(pVisual, sizeof(*pVisual));
	if (nEquipId <= 0)
		return FALSE;

	const int nHeight = Table.GetHeight();
	for (int nRow = 2; nRow <= nHeight; ++nRow)
	{
		int nTableEquipId = 0;
		if (!Table.GetInteger(nRow, 1, 0, &nTableEquipId) ||
			nTableEquipId != nEquipId)
			continue;

		int nResourceId = -1;
		int nPaletteId = 0;
		if (!Table.GetInteger(nRow, 2, -1, &nResourceId))
			return FALSE;
		Table.GetInteger(nRow, 3, 0, &nPaletteId);
		nResourceId -= nResourceOffset;
		if (nResourceId < 0 || nPaletteId < 0)
			return FALSE;

		pVisual->nResourceId = nResourceId;
		pVisual->nPaletteId = nPaletteId;
		pVisual->bVisible = TRUE;
		return TRUE;
	}
	return FALSE;
}

void KPhongThanAppearance::SetDefault(PHONGTHAN_APPEARANCE* pAppearance)
{
	if (!pAppearance)
		return;
	ZeroMemory(pAppearance, sizeof(*pAppearance));
	pAppearance->Helm.bVisible = TRUE;
	pAppearance->Armor.bVisible = TRUE;
	pAppearance->Weapon.bVisible = TRUE;
}

BOOL KPhongThanAppearance::Init()
{
	m_bWeaponLoaded = m_MeleeWeapon.Load(PHONGTHAN_APPEARANCE_MELEE_FILE);
	m_bWeaponLoaded = m_bWeaponLoaded && m_RangeWeapon.Load(PHONGTHAN_APPEARANCE_RANGE_FILE);
	m_bArmorLoaded = m_Armor.Load(PHONGTHAN_APPEARANCE_ARMOR_FILE);
	m_bArmorLoaded = m_bArmorLoaded && m_Helm.Load(PHONGTHAN_APPEARANCE_HELM_FILE);
	m_bHorseLoaded = m_Horse.Load(PHONGTHAN_APPEARANCE_HORSE_FILE);
	m_HorseVerified.Load("\\settings\\item\\PhongThanHorseVisual.txt");
	if (!m_bWeaponLoaded || !m_bArmorLoaded || !m_bHorseLoaded)
	{
		printf("[PhongThan] appearance tables missing (weapon=%d armor=%d horse=%d)\n",
			m_bWeaponLoaded, m_bArmorLoaded, m_bHorseLoaded);
		return FALSE;
	}
	printf("[PhongThan] appearance tables loaded with resource and palette columns\n");
	return TRUE;
}

BOOL KPhongThanAppearance::ResolveWeapon(int nDetail, int nEquipId,
	PHONGTHAN_VISUAL_PART* pVisual)
{
	if (nDetail == equip_rangeweapon)
		return ResolveTablePart(m_RangeWeapon, nEquipId, 1, pVisual);
	if (nDetail == equip_meleeweapon)
		return ResolveTablePart(m_MeleeWeapon, nEquipId, 1, pVisual);
	return FALSE;
}

BOOL KPhongThanAppearance::ResolveArmor(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual)
{
	// Part numbers are one-based; zero is the unequipped resource row.
	return ResolveTablePart(m_Armor, nEquipId, 1, pVisual);
}

BOOL KPhongThanAppearance::ResolveHelm(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual)
{
	return ResolveTablePart(m_Helm, nEquipId, 1, pVisual);
}

BOOL KPhongThanAppearance::ResolveHorse(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual)
{
	// Reviewed whole-item overrides use the same one-based record key and
	// explicit SPR group (jsx01 => CRESINFO slot 0). Unreviewed profession
	// families retain their original table rather than borrowing a jsx mount.
	if (ResolveTablePart(m_HorseVerified, nEquipId, 1, pVisual))
		return TRUE;
	return ResolveTablePart(m_Horse, nEquipId, 1, pVisual);
}

BOOL KPhongThanAppearance::ResolvePhiPhong(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual)
{
	if (!pVisual)
		return FALSE;
	ZeroMemory(pVisual, sizeof(*pVisual));
	if (nEquipId <= 0)
		return FALSE;
	pVisual->nResourceId = nEquipId - 1;
	pVisual->nPaletteId = 0;
	pVisual->bVisible = TRUE;
	return TRUE;
}
