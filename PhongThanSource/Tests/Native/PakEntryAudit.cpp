#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"

int main(int argc, char** argv)
{
	if (argc != 3 && argc != 4)
	{
		fprintf(stderr, "usage: PakEntryAudit <package.ini> <virtual-path-list.txt> [failure-list.txt]\n");
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
	if (!pList)
	{
		fprintf(stderr, "cannot open path list: %s\n", argv[2]);
		g_pPakList = NULL;
		PakList.Close();
		return 4;
	}
	FILE* pFailures = NULL;
	if (argc == 4)
	{
		pFailures = fopen(argv[3], "wb");
		if (!pFailures)
		{
			fprintf(stderr, "cannot create failure list: %s\n", argv[3]);
			fclose(pList);
			g_pPakList = NULL;
			PakList.Close();
			return 5;
		}
	}

	char szPath[2048];
	unsigned long uFiles = 0;
	unsigned long uPak = 0;
	unsigned long uLoose = 0;
	unsigned long uFailures = 0;
	while (fgets(szPath, sizeof(szPath), pList))
	{
		size_t nLength = strlen(szPath);
		while (nLength && (szPath[nLength - 1] == '\r' || szPath[nLength - 1] == '\n'))
			szPath[--nLength] = 0;
		if (!nLength)
			continue;
		++uFiles;
		KPakFile File;
		if (!File.Open(szPath))
		{
			fprintf(stderr, "ENTRY_FAIL\t%s\n", szPath);
			if (pFailures)
				fprintf(pFailures, "%s\r\n", szPath);
			++uFailures;
			continue;
		}
		if (File.IsFileInPak())
			++uPak;
		else
			++uLoose;
		if (!File.Size())
		{
			fprintf(stderr, "EMPTY_FAIL\t%s\n", szPath);
			if (pFailures)
				fprintf(pFailures, "%s\r\n", szPath);
			++uFailures;
		}
		File.Close();
	}
	fclose(pList);
	if (pFailures)
		fclose(pFailures);
	g_pPakList = NULL;
	PakList.Close();
	printf("ENTRY_FILES=%lu\nENTRY_PAK=%lu\nENTRY_LOOSE=%lu\nENTRY_FAILURES=%lu\n",
		uFiles, uPak, uLoose, uFailures);
	return uFailures ? 1 : 0;
}
