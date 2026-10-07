#ifndef KPHONGTHAN_PROFESSION_SKILLS_H
#define KPHONGTHAN_PROFESSION_SKILLS_H

#include "KProfession.h"

// Canonical player-skill ownership from the VNG Skills.txt registry.
enum KPHONGTHAN_PROFESSION_SKILL_CONSTANT
{
	PHONGTHAN_COMMON_SKILL_FIRST = 1,
	PHONGTHAN_COMMON_SKILL_LAST = 2,
	PHONGTHAN_DAOSHI_SKILL_FIRST = 3,
	PHONGTHAN_DAOSHI_SKILL_LAST = 26,
	PHONGTHAN_JIASHI_SKILL_FIRST = 27,
	PHONGTHAN_JIASHI_SKILL_LAST = 42,
	PHONGTHAN_YIREN_SKILL_FIRST = 43,
	PHONGTHAN_YIREN_SKILL_LAST = 51,
	PHONGTHAN_PROFESSION_SKILL_LEVEL = 1
};

inline BOOL PhongThanGetProfessionSkillRange(int nProfession,
	int* pnFirst, int* pnLast)
{
	if (!pnFirst || !pnLast)
		return FALSE;
	switch (nProfession)
	{
	case 0: // Giap Si
		*pnFirst = PHONGTHAN_JIASHI_SKILL_FIRST;
		*pnLast = PHONGTHAN_JIASHI_SKILL_LAST;
		return TRUE;
	case 1: // Dao Si
		*pnFirst = PHONGTHAN_DAOSHI_SKILL_FIRST;
		*pnLast = PHONGTHAN_DAOSHI_SKILL_LAST;
		return TRUE;
	case 2: // Di Nhan
		*pnFirst = PHONGTHAN_YIREN_SKILL_FIRST;
		*pnLast = PHONGTHAN_YIREN_SKILL_LAST;
		return TRUE;
	}
	return FALSE;
}

inline BOOL PhongThanIsProfessionSkill(int nSkillId)
{
	return nSkillId >= PHONGTHAN_DAOSHI_SKILL_FIRST &&
		nSkillId <= PHONGTHAN_YIREN_SKILL_LAST;
}

inline BOOL PhongThanProfessionOwnsSkill(int nProfession, int nSkillId)
{
	int nFirst = 0;
	int nLast = 0;
	return PhongThanGetProfessionSkillRange(nProfession, &nFirst, &nLast) &&
		nSkillId >= nFirst && nSkillId <= nLast;
}

#endif
