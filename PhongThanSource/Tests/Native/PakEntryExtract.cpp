#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"

int main(int argc, char** argv)
{
	if (argc != 4)
	{
		fprintf(stderr, "usage: PakEntryExtract <package.ini> <virtual-path> <output-file>\n");
		return 2;
	}

	char szVirtualPath[1024];
	const char* pszVirtualPath = argv[2];
	if (argv[2][0] == '@')
	{
		FILE* pPathFile = fopen(argv[2] + 1, "rb");
		if (!pPathFile)
		{
			fprintf(stderr, "cannot open raw path file: %s\n", argv[2] + 1);
			return 2;
		}
		size_t uLength = fread(szVirtualPath, 1, sizeof(szVirtualPath) - 1, pPathFile);
		fclose(pPathFile);
		while (uLength && (szVirtualPath[uLength - 1] == '\r' || szVirtualPath[uLength - 1] == '\n'))
			--uLength;
		szVirtualPath[uLength] = 0;
		pszVirtualPath = szVirtualPath;
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
	XPackElemFileRef ElemRef;
	memset(&ElemRef, 0, sizeof(ElemRef));
	bool bById = strncmp(pszVirtualPath, "id:", 3) == 0;
	bool bFound = bById ? PakList.FindElemFile(strtoul(pszVirtualPath + 3, NULL, 16), ElemRef) :
		PakList.FindElemFile(pszVirtualPath, ElemRef);
	if (!bFound)
	{
		fprintf(stderr, "cannot find PAK entry: %s\n", pszVirtualPath);
		g_pPakList = NULL;
		PakList.Close();
		return 4;
	}

	KPakFile File;
	if (!bById && (!File.Open(pszVirtualPath) || !File.IsFileInPak()))
	{
		fprintf(stderr, "cannot open PAK entry: %s\n", pszVirtualPath);
		g_pPakList = NULL;
		PakList.Close();
		return 4;
	}
	DWORD dwSize = bById ? (DWORD)ElemRef.nSize : File.Size();
	if (!dwSize || dwSize > 0x40000000)
	{
		fprintf(stderr, "invalid PAK entry size: %lu\n", dwSize);
		File.Close();
		g_pPakList = NULL;
		PakList.Close();
		return 5;
	}

	unsigned char* pData = (unsigned char*)malloc(dwSize);
	if (!pData)
	{
		fprintf(stderr, "out of memory: %lu\n", dwSize);
		File.Close();
		g_pPakList = NULL;
		PakList.Close();
		return 6;
	}
	DWORD dwRead = bById ? PakList.ElemFileRead(ElemRef, pData, dwSize) : File.Read(pData, dwSize);
	File.Close();
	if (dwRead != dwSize)
	{
		fprintf(stderr, "short PAK read: %lu/%lu\n", dwRead, dwSize);
		free(pData);
		g_pPakList = NULL;
		PakList.Close();
		return 7;
	}

	FILE* pOutput = fopen(argv[3], "wb");
	if (!pOutput)
	{
		fprintf(stderr, "cannot create output: %s\n", argv[3]);
		free(pData);
		g_pPakList = NULL;
		PakList.Close();
		return 8;
	}
	size_t uWritten = fwrite(pData, 1, dwSize, pOutput);
	int nCloseResult = fclose(pOutput);
	free(pData);
	g_pPakList = NULL;
	PakList.Close();
	if (uWritten != dwSize || nCloseResult != 0)
	{
		fprintf(stderr, "short output write: %lu/%lu\n", (unsigned long)uWritten, dwSize);
		return 9;
	}
	printf("PAK_ENTRY=%s\nPAK_INDEX=%d\nBYTES=%lu\n", pszVirtualPath, ElemRef.nPackIndex, dwSize);
	return 0;
}
