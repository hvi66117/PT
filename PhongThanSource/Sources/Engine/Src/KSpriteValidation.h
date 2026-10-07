#ifndef KSpriteValidation_H
#define KSpriteValidation_H

#include "KSprite.h"

// The limits are shared by loose files and PAK entries.  Keeping validation
// here prevents the two loaders from accepting different SPR layouts.
#define KSPR_FRAME_HEADER_SIZE 8UL
#define KSPR_MAX_FRAME_COUNT 4096UL
#define KSPR_MAX_DIMENSION 8192UL
#define KSPR_MAX_FRAME_BYTES (256UL * 1024UL * 1024UL)

inline bool KSprIsValidHeader(const SPRHEAD& Header, unsigned long uFileSize)
{
	return uFileSize >= sizeof(SPRHEAD) &&
		Header.Comment[0] == 'S' && Header.Comment[1] == 'P' &&
		Header.Comment[2] == 'R' &&
		Header.Width > 0 && Header.Height > 0 &&
		Header.Width <= KSPR_MAX_DIMENSION && Header.Height <= KSPR_MAX_DIMENSION &&
		Header.Frames > 0 && Header.Frames <= KSPR_MAX_FRAME_COUNT &&
		Header.Colors > 0 && Header.Colors <= 256;
}

inline bool KSprIsValidFrameRange(unsigned long uFileSize, unsigned long uDataStart,
	unsigned long uOffset, unsigned long uLength)
{
	if (uDataStart > uFileSize || uOffset > uFileSize - uDataStart)
		return false;
	return uLength >= KSPR_FRAME_HEADER_SIZE &&
		uLength <= uFileSize - uDataStart - uOffset;
}

inline bool KSprIsValidIndexedRle(const unsigned char* pData, unsigned long uSize,
	unsigned int uWidth, unsigned int uHeight, unsigned int uColors)
{
	if (pData == NULL || uWidth == 0 || uHeight == 0 || uColors == 0 || uColors > 256)
		return false;
	unsigned long uPixels = uWidth * uHeight;
	unsigned long uDone = 0;
	unsigned int uLine = 0;
	const unsigned char* p = pData;
	const unsigned char* pEnd = pData + uSize;
	while (uDone < uPixels)
	{
		if (pEnd - p < 2)
			return false;
		unsigned int uRun = p[0];
		unsigned int uAlpha = p[1];
		p += 2;
		if (uRun == 0 || uRun > uPixels - uDone || uRun > uWidth - uLine)
			return false;
		if (uAlpha != 0)
		{
			if ((unsigned long)(pEnd - p) < uRun)
				return false;
			for (unsigned int i = 0; i < uRun; i++)
				if (p[i] >= uColors)
					return false;
			p += uRun;
		}
		uDone += uRun;
		uLine += uRun;
		if (uLine == uWidth)
			uLine = 0;
	}
	return uLine == 0;
}

inline bool KSprIsValidTrueColorRle(const unsigned char* pData, unsigned long uSize,
	unsigned int uWidth, unsigned int uHeight)
{
	if (pData == NULL || uWidth == 0 || uHeight == 0)
		return false;
	unsigned long uPixels = uWidth * uHeight;
	unsigned long uDone = 0;
	const unsigned char* p = pData;
	const unsigned char* pEnd = pData + uSize;
	while (uDone < uPixels)
	{
		if (pEnd - p < 2)
			return false;
		unsigned int uRun = p[0];
		unsigned int uAlpha = p[1];
		p += 2;
		if (uRun == 0 || uRun > uPixels - uDone)
			return false;
		if (uAlpha != 0)
		{
			unsigned long uColorBytes = uRun * 3;
			if ((unsigned long)(pEnd - p) < uColorBytes)
				return false;
			p += uColorBytes;
		}
		uDone += uRun;
	}
	return true;
}

inline bool KSprIsLegacyIndexedBlob(const unsigned char* pFile, unsigned long uFileSize,
	const SPRHEAD& Header)
{
	if (!KSprIsValidHeader(Header, uFileSize))
		return false;
	unsigned long uTablePos = sizeof(SPRHEAD) + Header.Colors * sizeof(KPAL24);
	unsigned long uTableSize = Header.Frames * sizeof(SPROFFS);
	if (uTablePos > uFileSize || uTableSize > uFileSize - uTablePos)
		return false;
	const SPROFFS* pTable = (const SPROFFS*)(pFile + uTablePos);
	unsigned long uDataStart = uTablePos + uTableSize;
	for (unsigned int i = 0; i < Header.Frames; i++)
	{
		if (!KSprIsValidFrameRange(uFileSize, uDataStart, pTable[i].Offset, pTable[i].Length))
			return false;
		const SPRFRAME* pFrame = (const SPRFRAME*)(pFile + uDataStart + pTable[i].Offset);
		if (pFrame->Width == 0 || pFrame->Height == 0 ||
			pFrame->Width > KSPR_MAX_DIMENSION || pFrame->Height > KSPR_MAX_DIMENSION ||
			!KSprIsValidIndexedRle(pFrame->Sprite,
				pTable[i].Length - KSPR_FRAME_HEADER_SIZE,
				pFrame->Width, pFrame->Height, Header.Colors))
			return false;
	}
	return true;
}

inline bool KSprIsSeaweedTrueColorBlob(const unsigned char* pFile, unsigned long uFileSize,
	const SPRHEAD& Header)
{
	if (!KSprIsValidHeader(Header, uFileSize))
		return false;
	unsigned long uTablePos = sizeof(SPRHEAD);
	unsigned long uTableSize = Header.Frames * sizeof(SPROFFS);
	if (uTablePos > uFileSize || uTableSize > uFileSize - uTablePos)
		return false;
	const SPROFFS* pTable = (const SPROFFS*)(pFile + uTablePos);
	unsigned long uDataStart = uTablePos + uTableSize;
	for (unsigned int i = 0; i < Header.Frames; i++)
	{
		if (!KSprIsValidFrameRange(uFileSize, uDataStart, pTable[i].Offset, pTable[i].Length))
			return false;
		const SPRFRAME* pFrame = (const SPRFRAME*)(pFile + uDataStart + pTable[i].Offset);
		if (pFrame->Width == 0 || pFrame->Height == 0 ||
			pFrame->Width > KSPR_MAX_DIMENSION || pFrame->Height > KSPR_MAX_DIMENSION ||
			!KSprIsValidTrueColorRle(pFrame->Sprite,
				pTable[i].Length - KSPR_FRAME_HEADER_SIZE,
				pFrame->Width, pFrame->Height))
			return false;
	}
	return true;
}

#endif
