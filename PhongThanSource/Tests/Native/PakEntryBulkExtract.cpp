#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"

static bool EnsureParentDirectories(const char* pszPath)
{
	char szPath[MAX_PATH];
	if (!pszPath || strlen(pszPath) >= sizeof(szPath))
		return false;
	strcpy(szPath, pszPath);
	for (char* p = szPath + 3; *p; ++p)
	{
		if (*p != '\\' && *p != '/')
			continue;
		char ch = *p;
		*p = 0;
		if (!CreateDirectoryA(szPath, NULL) && GetLastError() != ERROR_ALREADY_EXISTS)
			return false;
		*p = ch;
	}
	return true;
}

static bool IsSafeVirtualPath(const char* pszPath)
{
	if (!pszPath || !pszPath[0] || strchr(pszPath, ':') || strstr(pszPath, ".."))
		return false;
	return true;
}

int main(int argc, char** argv)
{
	if (argc != 6)
	{
		fprintf(stderr, "usage: PakEntryBulkExtract <package.ini> <virtual-path-list.txt> <output-root> <resolved-list.txt> <missing-list.txt>\n");
		return 2;
	}

	g_SetRootPath(NULL);
	KPakList PakList;
	if (!PakList.Open(argv[1]))
	{
		fprintf(stderr, "cannot open package list: %s\n", argv[1]);
		return 3;
	}
	g_pPakList = &PakList;
	g_SetPakFileMode(1);

	FILE* pList = fopen(argv[2], "rb");
	FILE* pResolved = fopen(argv[4], "wb");
	FILE* pMissing = fopen(argv[5], "wb");
	if (!pList || !pResolved || !pMissing)
	{
		fprintf(stderr, "cannot open list/output catalog\n");
		if (pList) fclose(pList);
		if (pResolved) fclose(pResolved);
		if (pMissing) fclose(pMissing);
		g_pPakList = NULL;
		PakList.Close();
		return 4;
	}

	unsigned long uFiles = 0, uExtracted = 0, uMissing = 0, uBytes = 0;
	char szVirtual[MAX_PATH];
	while (fgets(szVirtual, sizeof(szVirtual), pList))
	{
		size_t nLength = strlen(szVirtual);
		while (nLength && (szVirtual[nLength - 1] == '\r' || szVirtual[nLength - 1] == '\n'))
			szVirtual[--nLength] = 0;
		if (!nLength)
			continue;
		++uFiles;

		if (!IsSafeVirtualPath(szVirtual))
		{
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}

		XPackElemFileRef ElemRef;
		memset(&ElemRef, 0, sizeof(ElemRef));
		KPakFile File;
		if (!PakList.FindElemFile(szVirtual, ElemRef) || !File.Open(szVirtual) || !File.IsFileInPak())
		{
			File.Close();
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}

		DWORD dwSize = File.Size();
		if (!dwSize || dwSize > 0x04000000)
		{
			File.Close();
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}
		unsigned char* pData = (unsigned char*)malloc(dwSize);
		if (!pData || File.Read(pData, dwSize) != dwSize)
		{
			if (pData) free(pData);
			File.Close();
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}
		File.Close();

		const char* pszRelative = szVirtual;
		while (*pszRelative == '\\' || *pszRelative == '/') ++pszRelative;
		char szOutput[MAX_PATH];
		if (strlen(argv[3]) + strlen(pszRelative) + 2 >= sizeof(szOutput))
		{
			free(pData);
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}
		sprintf(szOutput, "%s\\%s", argv[3], pszRelative);
		for (char* p = szOutput; *p; ++p) if (*p == '/') *p = '\\';
		if (!EnsureParentDirectories(szOutput))
		{
			free(pData);
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}
		FILE* pOutput = fopen(szOutput, "wb");
		bool bWritten = pOutput && fwrite(pData, 1, dwSize, pOutput) == dwSize;
		if (pOutput) fclose(pOutput);
		free(pData);
		if (!bWritten)
		{
			fprintf(pMissing, "%s\r\n", szVirtual);
			++uMissing;
			continue;
		}
		fprintf(pResolved, "%s\r\n", szVirtual);
		++uExtracted;
		uBytes += dwSize;
	}

	fclose(pList);
	fclose(pResolved);
	fclose(pMissing);
	g_pPakList = NULL;
	PakList.Close();
	printf("ENTRY_FILES=%lu\nENTRY_EXTRACTED=%lu\nENTRY_MISSING=%lu\nENTRY_BYTES=%lu\n",
		uFiles, uExtracted, uMissing, uBytes);
	return uMissing ? 1 : 0;
}
