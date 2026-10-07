#include "KCore.h"
#include "KPlayerProfession.h"

KPlayerProfession::KPlayerProfession()
{
	Release();
}

void KPlayerProfession::Release()
{
	m_nProfession = PHONGTHAN_PROFESSION_INVALID;
}

BOOL KPlayerProfession::SetProfession(int nProfession)
{
	if (!g_Profession.IsValid(nProfession))
		return FALSE;
	m_nProfession = nProfession;
	return TRUE;
}

int KPlayerProfession::GetProfession() const
{
	return m_nProfession;
}

int KPlayerProfession::GetCamp() const
{
	return g_Profession.GetCamp(m_nProfession);
}

void KPlayerProfession::GetKey(char *pszKey) const
{
	if (pszKey)
		strcpy(pszKey, g_Profession.GetKey(m_nProfession));
}

void KPlayerProfession::GetName(char *pszName) const
{
	if (pszName)
		strcpy(pszName, g_Profession.GetName(m_nProfession));
}
