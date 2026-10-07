#ifndef KPHONGTHANAPPEARANCE_H
#define KPHONGTHANAPPEARANCE_H

#include "KTabFile.h"
#include "GameDataDef.h"

class KPhongThanAppearance
{
private:
	KTabFile m_MeleeWeapon;
	KTabFile m_RangeWeapon;
	KTabFile m_Armor;
	KTabFile m_Helm;
	KTabFile m_Horse;
	KTabFile m_HorseVerified;
	BOOL m_bWeaponLoaded;
	BOOL m_bArmorLoaded;
	BOOL m_bHorseLoaded;

	BOOL ResolveTablePart(KTabFile& Table, int nEquipId, int nResourceOffset,
		PHONGTHAN_VISUAL_PART* pVisual);

public:
	BOOL Init();
	BOOL ResolveWeapon(int nDetail, int nEquipId, PHONGTHAN_VISUAL_PART* pVisual);
	BOOL ResolveArmor(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual);
	BOOL ResolveHelm(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual);
	BOOL ResolveHorse(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual);
	BOOL ResolvePhiPhong(int nEquipId, PHONGTHAN_VISUAL_PART* pVisual);
	void SetDefault(PHONGTHAN_APPEARANCE* pAppearance);
};

extern KPhongThanAppearance g_PhongThanAppearance;

#endif
