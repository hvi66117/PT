#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"

int main(int argc, char** argv)
{
	if (argc != 3)
	{
		fprintf(stderr, "usage: SprLoaderAudit <package.ini> <spr-list.txt>\n");
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
		fprintf(stderr, "cannot open SPR list: %s\n", argv[2]);
		g_pPakList = NULL;
		return 4;
	}

	char szPath[1024];
	unsigned long uFiles = 0;
	unsigned long uFrames = 0;
	unsigned long uFailures = 0;
	while (fgets(szPath, sizeof(szPath), pList))
	{
		size_t nLength = strlen(szPath);
		while (nLength && (szPath[nLength - 1] == '\r' || szPath[nLength - 1] == '\n'))
			szPath[--nLength] = 0;
		if (!nLength)
			continue;

		uFiles++;
		SPROFFS* pOffsets = NULL;
		SPRHEAD* pHeader = SprGetHeader(szPath, pOffsets);
		if (!pHeader)
		{
			fprintf(stderr, "HEADER_FAIL\t%s\n", szPath);
			uFailures++;
			continue;
		}
		if (pOffsets == NULL)
		{
			for (int nFrame = 0; nFrame < pHeader->Frames; nFrame++)
			{
				SPRFRAME* pFrame = SprGetFrame(pHeader, nFrame);
				if (!pFrame)
				{
					fprintf(stderr, "FRAME_FAIL\t%d\t%s\n", nFrame, szPath);
					uFailures++;
					break;
				}
				if (nFrame <= 1 || (pHeader->Frames == 40 && (nFrame % 5) == 0))
				{
					printf("SPR\t%s\tcanvas=%u,%u\tcenter=%u,%u\tframes=%u\tdirs=%u\tframe%d=%u,%u,%u,%u\n",
						szPath, pHeader->Width, pHeader->Height,
						pHeader->CenterX, pHeader->CenterY,
						pHeader->Frames, pHeader->Directions,
						nFrame,
						pFrame->Width, pFrame->Height, pFrame->OffsetX, pFrame->OffsetY);
				}
				uFrames++;
				SprReleaseFrame(pFrame);
			}
		}
		else
		{
			SPRFRAME* pFrame = (SPRFRAME*)((char*)pOffsets +
				pHeader->Frames * sizeof(SPROFFS) + pOffsets[0].Offset);
			SPRFRAME* pFrame1 = pHeader->Frames > 1 ?
				(SPRFRAME*)((char*)pOffsets + pHeader->Frames * sizeof(SPROFFS) + pOffsets[1].Offset) : pFrame;
			printf("SPR\t%s\tcanvas=%u,%u\tcenter=%u,%u\tframes=%u\tdirs=%u\tframe0=%u,%u,%u,%u\tframe1=%u,%u,%u,%u\n",
				szPath, pHeader->Width, pHeader->Height,
				pHeader->CenterX, pHeader->CenterY,
				pHeader->Frames, pHeader->Directions,
				pFrame->Width, pFrame->Height, pFrame->OffsetX, pFrame->OffsetY,
				pFrame1->Width, pFrame1->Height, pFrame1->OffsetX, pFrame1->OffsetY);
			uFrames += pHeader->Frames;
		}
		SprReleaseHeader(pHeader);
	}
	fclose(pList);
	g_pPakList = NULL;
	PakList.Close();
	printf("SPR_FILES=%lu\nSPR_FRAMES=%lu\nSPR_FAILURES=%lu\n", uFiles, uFrames, uFailures);
	return uFailures ? 1 : 0;
}
