#ifndef KPHONGTHAN_PROFESSION_H
#define KPHONGTHAN_PROFESSION_H

#include "GameDataDef.h"

// The profession registry is code-owned.  The three records come directly
// from the Phong Than character model and do not depend on faction.ini.
class KProfession
{
public:
	struct SProfession
	{
		int  m_nId;
		int  m_nCamp;
		char m_szKey[32];
		char m_szName[64];
	};

	SProfession m_Profession[PHONGTHAN_PROFESSION_COUNT];

	BOOL Init();
	BOOL IsValid(int nProfession) const;
	int GetID(const char *pszName) const;
	int GetCamp(int nProfession) const;
	const char *GetKey(int nProfession) const;
	const char *GetName(int nProfession) const;
};

extern KProfession g_Profession;

#endif
