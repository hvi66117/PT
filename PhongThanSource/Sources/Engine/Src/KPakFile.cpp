//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KPakFile.cpp
// Date:	2000.08.08
// Code:	WangWei(Daphnis)
// Desc:	File In Dat Class
//---------------------------------------------------------------------------
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KSpriteValidation.h"
#include "KPakList.h"

//---------------------------------------------------------------------------
// 文件读取模式 0 = 优先从磁盘读取 1 = 优先从文件包读取
static int m_nPakFileMode = 0;

//---------------------------------------------------------------------------
// 函数:	SetFileMode
// 功能:	设置文件读取模式
// 参数:	int
// 返回:	void
//---------------------------------------------------------------------------
void g_SetPakFileMode(int nFileMode)
{
	m_nPakFileMode = nFileMode;
}

#define	PAK_INDEX_STORE_IN_RESERVED	0

#ifndef _SERVER

static const unsigned long SPR_FRAME_HEADER_SIZE = KSPR_FRAME_HEADER_SIZE;
static const unsigned long SPR_MAX_DIMENSION = KSPR_MAX_DIMENSION;
static int s_nSeaweedConvertError = 0;

static bool IsValidSprHeader(const SPRHEAD& Header, unsigned long uFileSize)
{
	return KSprIsValidHeader(Header, uFileSize);
}

static bool IsValidSprFrameRange(unsigned long uFileSize, unsigned long uDataStart,
	unsigned long uOffset, unsigned long uLength)
{
	return KSprIsValidFrameRange(uFileSize, uDataStart, uOffset, uLength);
}

static bool IsValidIndexedRle(const unsigned char* pData, unsigned long uSize,
	unsigned int uWidth, unsigned int uHeight)
{
	return KSprIsValidIndexedRle(pData, uSize, uWidth, uHeight, 256);
}

static bool IsValidTrueColorRle(const unsigned char* pData, unsigned long uSize,
	unsigned int uWidth, unsigned int uHeight)
{
	return KSprIsValidTrueColorRle(pData, uSize, uWidth, uHeight);
}

static bool IsLegacyIndexedSpr(const unsigned char* pFile, unsigned long uFileSize,
	const SPRHEAD& Header)
{
	return KSprIsLegacyIndexedBlob(pFile, uFileSize, Header);
}

static bool IsSeaweedTrueColorSpr(const unsigned char* pFile, unsigned long uFileSize,
	const SPRHEAD& Header)
{
	return KSprIsSeaweedTrueColorBlob(pFile, uFileSize, Header);
}

static unsigned short GetSprRgb565(const unsigned char* pColor)
{
	return (unsigned short)(((pColor[0] >> 3) << 11) |
		((pColor[1] >> 2) << 5) | (pColor[2] >> 3));
}

struct SPR_COLOR_ENTRY
{
	unsigned short uColor;
	unsigned long uCount;
};

static int __cdecl CompareSprColorFrequency(const void* pLeft, const void* pRight)
{
	const SPR_COLOR_ENTRY* pL = (const SPR_COLOR_ENTRY*)pLeft;
	const SPR_COLOR_ENTRY* pR = (const SPR_COLOR_ENTRY*)pRight;
	if (pL->uCount < pR->uCount) return 1;
	if (pL->uCount > pR->uCount) return -1;
	return (int)pL->uColor - (int)pR->uColor;
}

static bool BuildSeaweedFramePalette(const unsigned char* pData, unsigned long uSize,
	unsigned int uWidth, unsigned int uHeight, unsigned char* pPalette,
	int nCapacity, int& nColors)
{
	unsigned long* pCounts = (unsigned long*)calloc(65536, sizeof(unsigned long));
	SPR_COLOR_ENTRY* pEntries = (SPR_COLOR_ENTRY*)malloc(65536 * sizeof(SPR_COLOR_ENTRY));
	if (pCounts == NULL || pEntries == NULL)
	{
		if (pCounts) free(pCounts);
		if (pEntries) free(pEntries);
		return false;
	}

	const unsigned char* p = pData;
	const unsigned char* pEnd = pData + uSize;
	unsigned long uPixels = uWidth * uHeight;
	unsigned long uDone = 0;
	bool bOk = true;
	while (uDone < uPixels)
	{
		if (pEnd - p < 2)
		{
			bOk = false;
			break;
		}
		unsigned int uRun = p[0];
		unsigned int uAlpha = p[1];
		p += 2;
		if (uRun == 0 || uRun > uPixels - uDone ||
			(uAlpha != 0 && (unsigned long)(pEnd - p) < uRun * 3))
		{
			bOk = false;
			break;
		}
		if (uAlpha != 0)
		{
			for (unsigned int iPixel = 0; iPixel < uRun; iPixel++)
			{
				pCounts[GetSprRgb565(p)]++;
				p += 3;
			}
		}
		uDone += uRun;
	}

	nColors = 0;
	if (bOk)
	{
		int nEntries = 0;
		for (unsigned int uColor = 0; uColor < 65536; uColor++)
		{
			if (pCounts[uColor])
			{
				pEntries[nEntries].uColor = (unsigned short)uColor;
				pEntries[nEntries].uCount = pCounts[uColor];
				nEntries++;
			}
		}
		qsort(pEntries, nEntries, sizeof(SPR_COLOR_ENTRY), CompareSprColorFrequency);
		nColors = nEntries < nCapacity ? nEntries : nCapacity;
		for (int iPalette = 0; iPalette < nColors; iPalette++)
		{
			unsigned short uColor = pEntries[iPalette].uColor;
			pPalette[iPalette * 3] = (unsigned char)(((uColor >> 11) & 0x1f) << 3);
			pPalette[iPalette * 3 + 1] = (unsigned char)(((uColor >> 5) & 0x3f) << 2);
			pPalette[iPalette * 3 + 2] = (unsigned char)((uColor & 0x1f) << 3);
		}
		bOk = nColors > 0;
	}

	free(pCounts);
	free(pEntries);
	return bOk;
}

static int FindSeaweedPaletteColor(const unsigned char* pPalette, int nColors,
	const unsigned char* pColor)
{
	unsigned short uColor = GetSprRgb565(pColor);
	int nRed = (uColor >> 11) & 0x1f;
	int nGreen = (uColor >> 5) & 0x3f;
	int nBlue = uColor & 0x1f;
	int nNearest = 0;
	unsigned long uNearestDistance = 0xffffffff;
	for (int i = 0; i < nColors; i++)
	{
		unsigned short uExisting = GetSprRgb565(pPalette + i * 3);
		if (uExisting == uColor)
			return i;
		int nDR = nRed - ((uExisting >> 11) & 0x1f);
		int nDG = nGreen - ((uExisting >> 5) & 0x3f);
		int nDB = nBlue - (uExisting & 0x1f);
		unsigned long uDistance = (unsigned long)(nDR * nDR * 4 + nDG * nDG + nDB * nDB * 4);
		if (uDistance < uNearestDistance)
		{
			uNearestDistance = uDistance;
			nNearest = i;
		}
	}
	return nNearest;
}

static bool ConvertSeaweedFrame(const unsigned char* pSource, unsigned long uSourceLength,
	int nPaletteCapacity, unsigned char*& pPalette, unsigned char*& pFrameData,
	unsigned long& uFrameLength)
{
	s_nSeaweedConvertError = 0;
	pPalette = NULL;
	pFrameData = NULL;
	uFrameLength = 0;
	if (pSource == NULL || uSourceLength < SPR_FRAME_HEADER_SIZE)
	{
		s_nSeaweedConvertError = 1;
		return false;
	}

	const SPRFRAME* pSourceFrame = (const SPRFRAME*)pSource;
	unsigned int uWidth = pSourceFrame->Width;
	unsigned int uHeight = pSourceFrame->Height;
	if (uWidth == 0 || uHeight == 0 ||
		uWidth > SPR_MAX_DIMENSION || uHeight > SPR_MAX_DIMENSION)
	{
		s_nSeaweedConvertError = 2;
		return false;
	}

	unsigned long uPixels = uWidth * uHeight;
	unsigned long uMaxFrameLength = SPR_FRAME_HEADER_SIZE +
		(uSourceLength - SPR_FRAME_HEADER_SIZE) + uHeight * 2 + 2;
	pPalette = (unsigned char*)calloc(nPaletteCapacity, 3);
	pFrameData = (unsigned char*)malloc(uMaxFrameLength);
	if (pPalette == NULL || pFrameData == NULL)
	{
		s_nSeaweedConvertError = 3;
		if (pPalette) free(pPalette);
		if (pFrameData) free(pFrameData);
		pPalette = NULL;
		pFrameData = NULL;
		return false;
	}
	int nColors = 0;
	if (!BuildSeaweedFramePalette(pSourceFrame->Sprite,
		uSourceLength - SPR_FRAME_HEADER_SIZE, uWidth, uHeight,
		pPalette, nPaletteCapacity, nColors))
	{
		s_nSeaweedConvertError = 8;
		free(pPalette);
		free(pFrameData);
		pPalette = NULL;
		pFrameData = NULL;
		return false;
	}

	memcpy(pFrameData, pSource, SPR_FRAME_HEADER_SIZE);
	const unsigned char* pSrc = pSource + SPR_FRAME_HEADER_SIZE;
	const unsigned char* pSrcEnd = pSource + uSourceLength;
	unsigned char* pDst = pFrameData + SPR_FRAME_HEADER_SIZE;
	unsigned char* pDstEnd = pFrameData + uMaxFrameLength;
	unsigned long uDone = 0;
	unsigned int uLine = 0;
	bool bOk = true;

	while (uDone < uPixels && bOk)
	{
		if (pSrcEnd - pSrc < 2)
		{
			s_nSeaweedConvertError = 4;
			break;
		}
		unsigned int uRun = pSrc[0];
		unsigned int uAlpha = pSrc[1];
		pSrc += 2;
		if (uRun == 0 || uRun > uPixels - uDone)
		{
			s_nSeaweedConvertError = 5;
			break;
		}
		if (uAlpha != 0 && (unsigned long)(pSrcEnd - pSrc) < uRun * 3)
		{
			s_nSeaweedConvertError = 6;
			break;
		}

		unsigned int uRemaining = uRun;
		while (uRemaining > 0)
		{
			unsigned int uChunk = uWidth - uLine;
			if (uChunk > uRemaining)
				uChunk = uRemaining;
			if (pDstEnd - pDst < 2 + (uAlpha ? (int)uChunk : 0))
			{
				s_nSeaweedConvertError = 7;
				bOk = false;
				break;
			}
			*pDst++ = (unsigned char)uChunk;
			*pDst++ = (unsigned char)uAlpha;
			if (uAlpha != 0)
			{
				for (unsigned int i = 0; i < uChunk; i++)
				{
					int nColor = FindSeaweedPaletteColor(pPalette, nColors, pSrc);
					*pDst++ = (unsigned char)nColor;
					pSrc += 3;
				}
				if (!bOk)
					break;
			}
			uRemaining -= uChunk;
			uDone += uChunk;
			uLine += uChunk;
			if (uLine == uWidth)
				uLine = 0;
		}
	}

	if (!bOk || uDone != uPixels || uLine != 0)
	{
		if (s_nSeaweedConvertError == 0)
			s_nSeaweedConvertError = 9;
		free(pPalette);
		free(pFrameData);
		pPalette = NULL;
		pFrameData = NULL;
		return false;
	}
	uFrameLength = pDst - pFrameData;
	return true;
}

SPRHEAD* NormalizeSeaweedSpr(const unsigned char* pFile, unsigned long uFileSize,
	const SPRHEAD& Header, SPROFFS*& pOffsetTable)
{
	unsigned int nFrames = Header.Frames;
	unsigned long uPaletteSize = Header.Colors * sizeof(KPAL24);
	unsigned long uTableSize = nFrames * sizeof(SPROFFS);
	unsigned long uSourceDataStart = sizeof(SPRHEAD) + uTableSize;
	const SPROFFS* pSourceTable = (const SPROFFS*)(pFile + sizeof(SPRHEAD));

	unsigned char** ppPalettes = (unsigned char**)calloc(nFrames, sizeof(unsigned char*));
	unsigned char** ppFrames = (unsigned char**)calloc(nFrames, sizeof(unsigned char*));
	unsigned long* pFrameLengths = (unsigned long*)calloc(nFrames, sizeof(unsigned long));
	if (ppPalettes == NULL || ppFrames == NULL || pFrameLengths == NULL)
	{
		if (ppPalettes) free(ppPalettes);
		if (ppFrames) free(ppFrames);
		if (pFrameLengths) free(pFrameLengths);
		return NULL;
	}

	unsigned long uBlocksSize = 0;
	bool bOk = true;
	for (unsigned int iBuild = 0; iBuild < nFrames; iBuild++)
	{
		const unsigned char* pSourceFrame = pFile + uSourceDataStart + pSourceTable[iBuild].Offset;
		if (!ConvertSeaweedFrame(pSourceFrame, pSourceTable[iBuild].Length, Header.Colors,
			ppPalettes[iBuild], ppFrames[iBuild], pFrameLengths[iBuild]))
		{
			static int s_nSeaweedLogCount = 0;
			if (s_nSeaweedLogCount < 64)
			{
				s_nSeaweedLogCount++;
				FILE* pLog = fopen("spr_loader_errors.log", "a+t");
				if (pLog)
				{
					fprintf(pLog, "convert error=%d frame=%u sourceLength=%lu canvas=%ux%u\n",
						s_nSeaweedConvertError, iBuild, pSourceTable[iBuild].Length,
						Header.Width, Header.Height);
					fclose(pLog);
				}
			}
			bOk = false;
			break;
		}
		if (uBlocksSize > 0xffffffff - uPaletteSize - pFrameLengths[iBuild])
		{
			bOk = false;
			break;
		}
		uBlocksSize += uPaletteSize + pFrameLengths[iBuild];
	}

	SPRHEAD* pResult = NULL;
	unsigned long uPrefixSize = sizeof(SPRHEAD) + uPaletteSize + uTableSize;
	if (bOk && uBlocksSize <= 0xffffffff - uPrefixSize)
	{
		pResult = (SPRHEAD*)malloc(uPrefixSize + uBlocksSize);
		if (pResult)
		{
			memcpy(pResult, &Header, sizeof(SPRHEAD));
			pResult->Reserved[PAK_INDEX_STORE_IN_RESERVED] = (WORD)(-1);
			pResult->Reserved[SPR_FRAME_PALETTE_RESERVED_INDEX] = SPR_FRAME_PALETTE_MARK;
			unsigned char* pGlobalPalette = (unsigned char*)pResult + sizeof(SPRHEAD);
			memcpy(pGlobalPalette, ppPalettes[0], uPaletteSize);
			pOffsetTable = (SPROFFS*)(pGlobalPalette + uPaletteSize);
			unsigned char* pDataStart = (unsigned char*)pOffsetTable + uTableSize;
			unsigned long uBlockOffset = 0;
			for (unsigned int iCopy = 0; iCopy < nFrames; iCopy++)
			{
				memcpy(pDataStart + uBlockOffset, ppPalettes[iCopy], uPaletteSize);
				memcpy(pDataStart + uBlockOffset + uPaletteSize, ppFrames[iCopy], pFrameLengths[iCopy]);
				pOffsetTable[iCopy].Offset = uBlockOffset + uPaletteSize;
				pOffsetTable[iCopy].Length = pFrameLengths[iCopy];
				uBlockOffset += uPaletteSize + pFrameLengths[iCopy];
			}
		}
	}

	for (unsigned int iFree = 0; iFree < nFrames; iFree++)
	{
		if (ppPalettes[iFree]) free(ppPalettes[iFree]);
		if (ppFrames[iFree]) free(ppFrames[iFree]);
	}
	free(ppPalettes);
	free(ppFrames);
	free(pFrameLengths);
	return pResult;
}

//----modify by Wooy to add Adjust color palette and to get rid of #@$%^& ----2003.8.19
SPRHEAD* SprGetHeader(const char* pszFileName, SPROFFS*& pOffsetTable)
{
	pOffsetTable = NULL;

	if(pszFileName == NULL || pszFileName[0] == 0)
		return NULL;

	KPakFile	File;
	if (!File.Open(pszFileName))
		return NULL;

	SPRHEAD*		pSpr = NULL;
	if (File.IsFileInPak())
	{
		//====到文件包内寻找读取图文件=====
		XPackElemFileRef	PakRef;
		//_ASSERT(g_pPakList);
		if (g_pPakList->FindElemFile(pszFileName, PakRef))
		{
			pSpr = g_pPakList->GetSprHeader(PakRef, pOffsetTable);
			if (pSpr)
				pSpr->Reserved[PAK_INDEX_STORE_IN_RESERVED] = (WORD)(short)PakRef.nPackIndex;
		}
	}
	// Normal PAK entries can contain a complete Seaweed/VNG sprite blob,
	// not the specialized streaming SPR layout. Decode the same bytes with
	// the bounded whole-file loader when the streaming header is unavailable.
	if (!pSpr)
	{
		File.Seek(0, FILE_BEGIN);
		bool			bOk = false;
		SPRHEAD			Header;
		//---读文件头，并判断是否为合法的spr图文件---
		while(File.Read(&Header, sizeof(SPRHEAD)) == sizeof(SPRHEAD))
		{
			unsigned long uEntireSize = File.Size();
			if (!IsValidSprHeader(Header, uEntireSize))
				break;

			unsigned char* pFileData = (unsigned char*)malloc(uEntireSize);
			if (pFileData == NULL)
				break;
			memcpy(pFileData, &Header, sizeof(SPRHEAD));
			unsigned long uRemainSize = uEntireSize - sizeof(SPRHEAD);
			//---读取spr剩下的数据---
			if (File.Read(pFileData + sizeof(SPRHEAD), uRemainSize) == uRemainSize)
			{
				if (IsSeaweedTrueColorSpr(pFileData, uEntireSize, Header))
				{
					pSpr = NormalizeSeaweedSpr(pFileData, uEntireSize, Header, pOffsetTable);
					bOk = (pSpr != NULL);
				}
				else if (IsLegacyIndexedSpr(pFileData, uEntireSize, Header))
				{
					pSpr = (SPRHEAD*)pFileData;
					pFileData = NULL;
					pOffsetTable = (SPROFFS*)(((char*)pSpr) + sizeof(SPRHEAD) + Header.Colors * 3);
					pSpr->Reserved[PAK_INDEX_STORE_IN_RESERVED] = (WORD)(-1);
					bOk = true;
				}
			}
			if (pFileData)
				free(pFileData);
			break;
		};

		if (bOk == false && pSpr)
		{
			free (pSpr);
			pSpr = NULL;
		}
	}
	File.Close();
	return pSpr;
}

void SprReleaseHeader(SPRHEAD* pSprHeader)
{
    if (pSprHeader)
		free(pSprHeader);
}

SPRFRAME* SprGetFrame(SPRHEAD* pSprHeader, int nFrame)
{
	SPRFRAME*	pFrame = NULL;
	if (pSprHeader && g_pPakList)
	{
		int nPakIndex = (short)pSprHeader->Reserved[PAK_INDEX_STORE_IN_RESERVED];
		if (nPakIndex >= 0)
			pFrame = g_pPakList->GetSprFrame(nPakIndex, pSprHeader, nFrame);
	}
	return pFrame;
}

void SprReleaseFrame(SPRFRAME* pFrame)
{
    if (pFrame)
		free(pFrame);
}

#include "JpgLib.h"
#include "KDDraw.h"

KSGImageContent*	get_jpg_image(const char cszName[], unsigned uRGBMask16)
{
	KPakFile	File;
	unsigned char *pbyFileData = NULL;

	if (File.Open(cszName))
	{
		unsigned int uSize = File.Size();
		pbyFileData = (unsigned char *)malloc(uSize);
		if (pbyFileData)
		{
			if (File.Read(pbyFileData, uSize) != uSize)
			{
				free (pbyFileData);
				pbyFileData = NULL;
			}
		}
	}

	if (!pbyFileData)
        return NULL;

	int nResult = false;
    int nRetCode = false;
    KSGImageContent *pImageResult = NULL;

	BOOL		bRGB555;
	JPEG_INFO	JpegInfo;

    if (uRGBMask16 == ((unsigned)-1))
    {
    	bRGB555 = (g_pDirectDraw->GetRGBBitMask16() == RGB_555) ? TRUE : FALSE;
    }
    else
    {
        bRGB555 = (uRGBMask16 == RGB_555) ? TRUE : FALSE;
    }

    nRetCode = jpeg_decode_init(bRGB555, TRUE);
	if(!nRetCode)
        goto Exit0;
         
	nRetCode = jpeg_decode_info(pbyFileData, &JpegInfo);
    if (!nRetCode)
        goto Exit0;

	pImageResult = (KSGImageContent *)malloc(KSG_IMAGE_CONTENT_SIZE(JpegInfo.width, JpegInfo.height));
    if (!pImageResult)
        goto Exit0;

    pImageResult->nWidth = JpegInfo.width;
    pImageResult->nHeight = JpegInfo.height;

	nRetCode = jpeg_decode_data(pImageResult->Data, &JpegInfo);
    if (!nRetCode)
        goto Exit0;

    nResult = true;

Exit0:
	free (pbyFileData);
    if (!nResult && pImageResult)
	{
		free (pImageResult);
		pImageResult = NULL;
    }

	return pImageResult;
}


void release_image(KSGImageContent *pImage)
{
    if (pImage)
        free (pImage);
}

#endif

//---------------------------------------------------------------------------
// 功能:	购造函数
//---------------------------------------------------------------------------
KPakFile::KPakFile()
{
	m_PackRef.nPackIndex = -1;
	m_PackRef.uId = 0;
}

//---------------------------------------------------------------------------
// 功能:	析造函数
//---------------------------------------------------------------------------
KPakFile::~KPakFile()
{
	Close();
}

//---------------------------------------------------------------------------
// 功能:	判断此文件是否从包中打开的
//---------------------------------------------------------------------------
bool KPakFile::IsFileInPak()
{
	return (m_PackRef.nPackIndex >= 0 && m_PackRef.uId);
}

//---------------------------------------------------------------------------
// 功能:	打开一个文件, 先寻找当前目录下是否有同名的单独文件,
// 参数:	FileName	文件名
// 返回:	TRUE		成功
//			FALSE		失败
//---------------------------------------------------------------------------
BOOL KPakFile::Open(const char* pszFileName)
{
	if (pszFileName == NULL || pszFileName[0] == 0)
		return false;

	bool bOk = false;
	Close();

	if (m_nPakFileMode == 0)	//0=优先从磁盘读取
	{
		bOk = (m_File.Open((char*)pszFileName) != FALSE);
		if (bOk == false && g_pPakList)
		{
			bOk = g_pPakList->FindElemFile(pszFileName, m_PackRef);
		}
	}
	else	//1=优先从文件包读取
	{
		if (g_pPakList)
			bOk = g_pPakList->FindElemFile(pszFileName, m_PackRef);
		if (bOk == false)
			bOk = (m_File.Open((char*)pszFileName) != FALSE);
	}
	return bOk;
}

//---------------------------------------------------------------------------
// 功能:	从文件中读取数据
// 参数:	pBuffer		缓冲区指针
//			dwSize		要读取的长度
// 返回:	读到的字节长度
//---------------------------------------------------------------------------
DWORD KPakFile::Read(void* pBuffer, unsigned int uSize)
{
	if (m_PackRef.nPackIndex >= 0)
	{
		if (g_pPakList->ElemFileRead(m_PackRef, pBuffer, uSize) == false)
			uSize = 0;
	}
	else
	{
		uSize = m_File.Read(pBuffer, uSize);
	}
	return uSize;
}

//---------------------------------------------------------------------------
// 功能:	文件读指针定位
// 参数:	lOffset			偏移量
//			dwMethod		定位方法
// 返回:	文件的指针
//---------------------------------------------------------------------------
DWORD KPakFile::Seek(int nOffset, unsigned int uMethod)
{
	if (m_PackRef.nPackIndex >= 0)
	{
		if (uMethod == FILE_BEGIN)
			m_PackRef.nOffset = nOffset;
		else if (uMethod == FILE_END)
			m_PackRef.nOffset = m_PackRef.nSize + nOffset;
		else
			m_PackRef.nOffset += nOffset;
		if (m_PackRef.nOffset > m_PackRef.nSize)
			m_PackRef.nOffset =  m_PackRef.nSize;
		else if (m_PackRef.nOffset < 0)
			m_PackRef.nOffset = 0;
		nOffset = m_PackRef.nOffset;
	}
	else
	{
		nOffset = m_File.Seek(nOffset, uMethod);
	}
	return nOffset;
}

//---------------------------------------------------------------------------
// 功能:	返回文件的指针
// 返回:	文件的指针
//---------------------------------------------------------------------------
DWORD KPakFile::Tell()
{
	int nOffset;
	if (m_PackRef.nPackIndex >= 0)
		nOffset = m_PackRef.nOffset;
	else
		nOffset = m_File.Tell();
	return nOffset;
}

//---------------------------------------------------------------------------
// 功能:	返回文件大小
// 返回:	文件的大小 in bytes
//---------------------------------------------------------------------------
DWORD KPakFile::Size()
{
	unsigned int uSize;
	if (m_PackRef.nPackIndex >= 0)
		uSize = m_PackRef.nSize;
	else
		uSize = m_File.Size();
	return uSize;
}
//---------------------------------------------------------------------------
// 功能:	关闭一个文件
//---------------------------------------------------------------------------
void KPakFile::Close()
{
	if (m_PackRef.nPackIndex >= 0)
	{
		m_PackRef.nPackIndex = -1;
		m_PackRef.uId = 0;
	}
	else
	{
		m_File.Close();
	}
}


//---------------------------------------------------------------------------
// 每次读取数据块的大小
#define BLOCK_SIZE	(0x10000L)

//---------------------------------------------------------------------------
// 功能:	打开一个包中的文件
// 参数:	FileName	文件名
// 返回:	TRUE		成功
//			FALSE		失败
//---------------------------------------------------------------------------
/*BOOL KPakFile::OpenPak(LPSTR FileName)
{
	if (g_pPakList == NULL)
		return FALSE;

	KAutoMutex	AutoMutex(g_pPakList->GetMutexPtr());

	// 在所有文件包中查找要打开的文件是否存在
	m_nPackage = g_pPakList->Search(FileName, &m_dwFileOfs, &m_dwFileLen);
	if (m_nPackage < 0)
		return FALSE;
	
	// m_nBlocks 即块的个数, 源文件每64K打为一个包
	// m_nBlocks * 2 为块长度表的大小(每块的大小用一个WORD记录)
	m_nBlocks = (m_dwFileLen + 0xffff) >> 16;
	
	// 给 block buffer 分配内存
	if (!m_MemBlock.Alloc(m_nBlocks * 2))
		return FALSE;
	
	// 给 file buffer 分配内存64K, 为解压做准备
	if (!m_MemFile.Alloc(BLOCK_SIZE))
		return FALSE;
	
	// 给 read buffer 分配内存64K, 为解压做准备
	if (!m_MemRead.Alloc(BLOCK_SIZE))
		return FALSE;
	
	// 文件缓冲区指针
	m_pBuffer = (PBYTE)m_MemFile.GetMemPtr();
	
	// 每块的长度表
	m_pBlocks = (PWORD)m_MemBlock.GetMemPtr();
	
	// 移动到文件开始
	g_pPakList->Seek(m_dwFileOfs, FILE_BEGIN);
	
	// 读入每块的大小
	g_pPakList->Read(m_pBlocks, m_nBlocks * 2);
	
	// 第一块压缩数据的偏移量
	m_dwFileOfs = m_dwFileOfs + m_nBlocks * 2;
	
	// 读取压缩数据起始位置
	m_dwDataPtr = m_dwFileOfs;
	
	// 读指针的位置(解码后的位置) = 0;
	m_dwFilePtr = 0;
	
	// 成功打开文件
	return TRUE;
}
//---------------------------------------------------------------------------
// 函数:	ReadPak
// 功能:	从文件中读取数据
// 参数:	pBuffer		缓冲区指针
//			dwSize		要读取的长度
// 返回:	读到的字节长度
//---------------------------------------------------------------------------
DWORD KPakFile::ReadPak(PVOID pBuffer, DWORD dwSize)
{
	KAutoMutex AutoMutex(g_pPakList->GetMutexPtr());

	// 如果是包中文件就从包中读
	UINT	nBlock = 0;
	DWORD	dwReadSize = 0;
	DWORD	dwBlockPos = 0;
	PBYTE	pOutBuf = (PBYTE)pBuffer;
	
	// 如果读取长度大于剩余文件长度
	if (m_dwFilePtr + dwSize > m_dwFileLen)
	{
		dwSize =  m_dwFileLen - m_dwFilePtr;
		dwReadSize = dwSize;
	}
	else
	{
		dwReadSize = dwSize;
	}

	// 已经读入的块数
	nBlock = m_dwFilePtr >> 16;

	// 已经读入小于64K块的长度
	dwBlockPos = m_dwFilePtr & 0xffff;

	// 以前读过小于64K的数据
	if (dwBlockPos)
	{
		// 要读的数据长度小于64K
		if (dwBlockPos + dwSize <= BLOCK_SIZE)
		{
			// m_pBuffer为64K大小, 上次已读入了
			g_MemCopyMmx(pOutBuf, m_pBuffer + dwBlockPos, dwSize);
			m_dwFilePtr += dwSize;

			// 如果此时 m_dwFilePtr 为64K 的倍数
			if ((m_dwFilePtr & 0xffff) == 0)
				m_dwDataPtr += (m_pBlocks[nBlock] == 0)? BLOCK_SIZE : m_pBlocks[nBlock];

			return dwSize;
		}
		
		// 要读的数据长度大于64K
		g_MemCopyMmx(pOutBuf, m_pBuffer + dwBlockPos, BLOCK_SIZE - dwBlockPos);
		pOutBuf += BLOCK_SIZE - dwBlockPos;
		m_dwDataPtr += (m_pBlocks[nBlock] == 0)? BLOCK_SIZE : m_pBlocks[nBlock];
		m_dwFilePtr = (++nBlock) << 16;
		dwSize -= (BLOCK_SIZE - dwBlockPos);
	}

	// 读入其余部分
	while (dwSize > 0xffff) // 大于64K
	{
		ReadBlock(pOutBuf, nBlock);
		pOutBuf += BLOCK_SIZE;
		m_dwDataPtr += (m_pBlocks[nBlock] == 0)? BLOCK_SIZE : m_pBlocks[nBlock];
		m_dwFilePtr = (++nBlock) << 16;
		dwSize -= BLOCK_SIZE;
	}

	// 刚好读完则返回
	if (dwSize == 0)
	{
		return dwReadSize;
	}

	// 读一个64K数据块到缓冲区
	ReadBlock(m_pBuffer, nBlock);

	// 拷贝缓冲区数据到目标地址
	g_MemCopyMmx(pOutBuf, m_pBuffer, dwSize);

	// 调整文件指针
	m_dwFilePtr += dwSize;

	// 返回读取的字节长度
	return dwReadSize;
}
//---------------------------------------------------------------------------
// 函数:	Seek
// 功能:	文件读指针定位
// 参数:	lOffset			偏移量
//			dwMethod		定位方法
// 返回:	文件的指针
//---------------------------------------------------------------------------
DWORD KPakFile::SeekPak(long lOffset, DWORD dwMethod)
{
	KAutoMutex AutoMutex(g_pPakList->GetMutexPtr());

	if (m_nPackage < 0)
	{
		return m_File.Seek(lOffset, dwMethod);
	}

	int	nFilePtr = m_dwFilePtr;

	switch (dwMethod)
	{
	case FILE_BEGIN:
		nFilePtr = lOffset;
		break;

	case FILE_END:
		nFilePtr = m_dwFileLen + lOffset;
		break;

	case FILE_CURRENT:
		nFilePtr = m_dwFilePtr + lOffset;
		break;
	}

	if (nFilePtr < 0)
	{
		nFilePtr = 0;
	}
	else if (nFilePtr > (int)m_dwFileLen)
	{
		nFilePtr = m_dwFileLen;
	}

	m_dwFilePtr = nFilePtr;
	m_dwDataPtr = m_dwFileOfs;

	int nBlocks = nFilePtr >> 16;
	for (int i = 0; i < nBlocks; i++)
	{
		m_dwDataPtr += (m_pBlocks[i] == 0)? BLOCK_SIZE : m_pBlocks[i];
	}
	if (nFilePtr & 0xffff)
	{
		ReadBlock(m_pBuffer, nBlocks);
	}

	return m_dwFilePtr;
}

//---------------------------------------------------------------------------
// 函数:	Save
// 功能:	保存文件
// 参数:	FileName	文件名
// 返回:	TRUE		成功
//			FALSE		失败
//---------------------------------------------------------------------------
*/
BOOL KPakFile::Save(const char* pszFileName)
{
/*	if (m_nPackage < 0)
		return TRUE;

	if (!m_File.Create(pszFileName))
		return FALSE;

	DWORD dwSize = m_dwFileLen;
	int nBlock = 0;

	// set data ptr
	m_dwDataPtr = m_dwFileOfs;

	// read blocks and write to file
	while (dwSize > BLOCK_SIZE)
	{
		ReadBlock(m_pBuffer, nBlock);
		dwSize -= BLOCK_SIZE;
		m_File.Write(m_pBuffer, BLOCK_SIZE);
		m_dwDataPtr += (m_pBlocks[nBlock] == 0)? BLOCK_SIZE : m_pBlocks[nBlock];
		nBlock++;
	}

	// read last block and write to file
	ReadBlock(m_pBuffer, nBlock);
	m_File.Write(m_pBuffer, dwSize);*/

	return FALSE;
}

/*
//---------------------------------------------------------------------------
// 函数:	ReadBlock
// 功能:	读一个压缩数据块
// 参数:	pBuffer		缓冲区指针
//			nBlock		块索引
// 返回:	void
//---------------------------------------------------------------------------
void KPakFile::ReadBlock(PBYTE pBuffer, int nBlock)
{
	TCodeInfo	CodeInfo;
	
	// 设置当前使用的文件包
	g_pPakList->SetActivePak(m_nPackage);
	
	// 填充解压缩接口结构
	CodeInfo.lpPack = (PBYTE)m_MemRead.GetMemPtr();
	CodeInfo.dwPackLen = m_pBlocks[nBlock];
	CodeInfo.lpData = pBuffer;
	CodeInfo.dwDataLen = BLOCK_SIZE;
	
	// 检查是否压缩过
	if (CodeInfo.dwPackLen == 0) // 没有压缩
	{
		g_pPakList->Seek(m_dwDataPtr, FILE_BEGIN);
		g_pPakList->Read(CodeInfo.lpData, CodeInfo.dwDataLen);
		return;
	}
	
	// 最后一块的实际长度（只有LHA用）
	if (nBlock == (m_nBlocks - 1))
	{
		CodeInfo.dwDataLen = m_dwFileLen - nBlock * BLOCK_SIZE;
	}
	
	// 移动指针，读取压缩数据，再解压缩
	g_pPakList->Seek(m_dwDataPtr, FILE_BEGIN);
	g_pPakList->Read(CodeInfo.lpPack, CodeInfo.dwPackLen);
	g_pPakList->Decode(&CodeInfo);
}
//---------------------------------------------------------------------------
*/
