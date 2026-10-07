#ifndef KPHONGTHAN_PLAYER_PROFESSION_H
#define KPHONGTHAN_PLAYER_PROFESSION_H

#include "KProfession.h"

class KPlayerProfession
{
public:
	int m_nProfession;

	KPlayerProfession();
	void Release();
	BOOL SetProfession(int nProfession);
	int GetProfession() const;
	int GetCamp() const;
	void GetKey(char *pszKey) const;
	void GetName(char *pszName) const;
};

#endif
