#ifndef PHONGTHAN_CHARACTER_STORE_H
#define PHONGTHAN_CHARACTER_STORE_H

#include <windows.h>
#include "../../../Headers/PhongThanCharacter.h"

class CPhongThanCharacterStore
{
public:
	CPhongThanCharacterStore();
	~CPhongThanCharacterStore();

	bool Open(const char* pRootDirectory);
	int List(const char* pAccountName, PHONGTHAN_CHARACTER_SUMMARY* pOutput,
		int nCapacity);
	bool Load(const char* pRoleName, BYTE* pOutput,
		PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize);
	bool Create(const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
		PHONGTHAN_U32 nStateSize);
	bool Save(const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
		PHONGTHAN_U32 nStateSize);
	bool Delete(const char* pAccountName, const char* pRoleName);

private:
	CPhongThanCharacterStore(const CPhongThanCharacterStore&);
	CPhongThanCharacterStore& operator=(const CPhongThanCharacterStore&);

	bool EnsureRoot();
	bool BuildRolePath(const char* pRoleName, char* pOutput,
		size_t nCapacity) const;
	bool LoadUnlocked(const char* pRoleName, BYTE* pOutput,
		PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize);
	bool LoadPathUnlocked(const char* pPath, BYTE* pOutput,
		PHONGTHAN_U32 nCapacity, PHONGTHAN_U32* pStateSize);
	bool WriteUnlocked(const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
		PHONGTHAN_U32 nStateSize, bool bReplaceExisting);
	int ListUnlocked(const char* pAccountName,
		PHONGTHAN_CHARACTER_SUMMARY* pOutput, int nCapacity);

	char m_szRoot[MAX_PATH];
	CRITICAL_SECTION m_Lock;
};

extern CPhongThanCharacterStore g_PhongThanCharacterStore;

#endif
