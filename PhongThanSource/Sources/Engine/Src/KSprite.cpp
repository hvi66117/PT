//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KSprite.cpp
// Date:	2000.09.18
// Code:	WangWei(Daphnis),Wooy
// Desc:	Sprite Class
//---------------------------------------------------------------------------
#include "KWin32.h"
#include "KDebug.h"
#include "KMemBase.h"
#include "KPakFile.h"
#include "KCanvas.h"
#include "KDrawSprite.h"
#include "KDrawSpriteAlpha.h"
#include "KSprite.h"
#include "KSpriteValidation.h"
//---------------------------------------------------------------------------
// ����:	KSprite
// ����:	���캯��
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
KSprite::KSprite()
{
	m_nWidth		= 0;
	m_nHeight		= 0;
	m_nCenterX		= 0;
	m_nCenterY		= 0;
	m_nFrames		= 0;
	m_nColors		= 0;
	m_nDirections	= 1;
	m_nInterval		= 1;
	m_pPal24		= NULL;
	m_pPal16		= NULL;
	m_pOffset		= NULL;
	m_pSprite		= NULL;
}
//---------------------------------------------------------------------------
// ����:	Load
// ����:	����
// ����:	FileName �ļ���
// ����:	TRUE���ɹ�
//			FALSE��ʧ��
//---------------------------------------------------------------------------
BOOL KSprite::Load(LPSTR FileName)
{
	KPakFile	File;
	SPRHEAD*	pHeader;
	PBYTE		pTemp;
	
	// open the file
	if (!File.Open(FileName))
		return FALSE;

	unsigned long uFileSize = File.Size();
	if (uFileSize < sizeof(SPRHEAD))
		return FALSE;
	// alloc memory
	if (!m_Buffer.Alloc(uFileSize))
		return FALSE;
	pTemp = (PBYTE)m_Buffer.GetMemPtr();

	// read data from file
	if (File.Read(pTemp, uFileSize) != uFileSize)
		return FALSE;

	// check file header setup sprite member
	pHeader = (SPRHEAD*)pTemp;
	if (!KSprIsLegacyIndexedBlob(pTemp, uFileSize, *pHeader))
		return FALSE;

	// get sprite info
	m_nWidth      = pHeader->Width;
	m_nHeight     = pHeader->Height;
	m_nCenterX    = pHeader->CenterX;
	m_nCenterY    = pHeader->CenterY;
	m_nFrames     = pHeader->Frames;
	m_nColors     = pHeader->Colors;
	m_nDirections = pHeader->Directions;
	m_nInterval   = pHeader->Interval;

	// setup palette pointer
	pTemp += sizeof(SPRHEAD);
	m_pPal24 = (KPAL24*)pTemp;

	// setup offset pointer
	pTemp += m_nColors * sizeof(KPAL24);
	m_pOffset = (SPROFFS*)pTemp;

	// setup sprite pointer
	pTemp += m_nFrames * sizeof(SPROFFS);
	m_pSprite = (LPBYTE)pTemp; // ���ƫ��

	// make color table
	MakePalette();

	return TRUE;
}


//---------------------------------------------------------------------------
// ����:	LoadFor3D
// ����:	����  Ϊ��άģʽ����4444�ĵ�ɫ�����ά��ɫ�治ͬ
// ����:	FileName �ļ���
// ����:	TRUE���ɹ�
//			FALSE��ʧ��
//---------------------------------------------------------------------------
BOOL KSprite::LoadFor3D(LPSTR FileName)
{
	KPakFile	File;
	SPRHEAD*	pHeader;
	PBYTE		pTemp;

	// open the file
	if (!File.Open(FileName))
		return FALSE;

	unsigned long uFileSize = File.Size();
	if (uFileSize < sizeof(SPRHEAD))
		return FALSE;
	// alloc memory
	if (!m_Buffer.Alloc(uFileSize))
		return FALSE;
	pTemp = (PBYTE)m_Buffer.GetMemPtr();

	// read data from file
	if (File.Read(pTemp, uFileSize) != uFileSize)
		return FALSE;

	// check file header setup sprite member
	pHeader = (SPRHEAD*)pTemp;
	if (!KSprIsLegacyIndexedBlob(pTemp, uFileSize, *pHeader))
		return FALSE;

	// get sprite info
	m_nWidth      = pHeader->Width;
	m_nHeight     = pHeader->Height;
	m_nCenterX    = pHeader->CenterX;
	m_nCenterY    = pHeader->CenterY;
	m_nFrames     = pHeader->Frames;
	m_nColors     = pHeader->Colors;
	m_nDirections = pHeader->Directions;
	m_nInterval   = pHeader->Interval;

	// setup palette pointer
	pTemp += sizeof(SPRHEAD);
	m_pPal24 = (KPAL24*)pTemp;

	// setup offset pointer
	pTemp += m_nColors * sizeof(KPAL24);
	m_pOffset = (SPROFFS*)pTemp;

	// setup sprite pointer
	pTemp += m_nFrames * sizeof(SPROFFS);
	m_pSprite = (LPBYTE)pTemp; // ���ƫ��

	// make color table
	Make4444Palette();

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	Free
// ����:	�ͷ�
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
void KSprite::Free()
{
	m_Buffer.Free();
	m_Palette.Free();
	m_nFrames = 0;
	m_nColors = 0;
	m_pPal24  = NULL;
	m_pPal16  = NULL;
	m_pOffset = NULL;
	m_pSprite = NULL;
}
//---------------------------------------------------------------------------
// ����:	Make4444Palette
// ����:	����4444ɫ�̣�����alpha��Ϊ0
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
void KSprite::Make4444Palette()
{
	m_Palette.Alloc(m_nColors * sizeof(KPAL16));
	m_pPal16 = (KPAL16*)m_Palette.GetMemPtr();
	
	int nColors = m_nColors;
	KPAL24 * pPal24 = m_pPal24;
	KPAL16 * pPal16 = m_pPal16;
	
	while (nColors -- > 0)
	{
		//*pPal16 = pPal24->Red<<4 | pPal24->Green<<8 | pPal24->Blue << 12 | 0;
		WORD	Red = (pPal24->Red) >> 4;
		WORD	Green = (pPal24->Green) >> 4;
		WORD	Blue = (pPal24->Blue) >> 4;

		*pPal16 = (Red << 8) | (Green << 4) | Blue;

		pPal16++;
		pPal24++;
	}
	
}

//---------------------------------------------------------------------------
// ����:	MakePalette
// ����:	����ɫ��
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
void KSprite::MakePalette()
{
	m_Palette.Alloc(m_nColors * sizeof(KPAL16));
	m_pPal16 = (KPAL16*)m_Palette.GetMemPtr();
	g_Pal24ToPal16(m_pPal24, m_pPal16, m_nColors);
}
//---------------------------------------------------------------------------
// ����:	Draw
// ����:	Draw Sprite Onto Screen
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::Draw(int nX, int nY, int nFrame)
{
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);

	// draw the frame
	g_pCanvas->DrawSprite(
		nX + pFrame->OffsetX,
		nY + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16);
}

//---------------------------------------------------------------------------
// ����:	DrawCenter
// ����:	Draw Sprite Onto Screen in a CenterPoint
// ����:	CX		X����
//			CY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawCenter(int nX, int nY, int nFrame)
{
	int X0,Y0;
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	   X0=nX-m_nCenterX;
       Y0=nY-m_nCenterY;
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);

	// draw the frame
	g_pCanvas->DrawSprite(
		X0 + pFrame->OffsetX,
		Y0 + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16);
}
//---------------------------------------------------------------------------
// ����:	DrawMixColor
// ����:	Draw Sprite Onto Screen
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawMixColor(int nX, int nY, int nFrame,int nColor,int nAlpha)
{
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);

	// draw the frame
	g_pCanvas->DrawSpriteMixColor(
		nX + pFrame->OffsetX,
		nY + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16,nColor,nAlpha);
}


//---------------------------------------------------------------------------
// ����:	DrawWithColor
// ����:	Draw Sprite Onto Screen
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawWithColor(int nX, int nY, int nFrame,int nColor,int nAlpha)
{
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);

	// draw the frame
	g_pCanvas->DrawSpriteWithColor(
		nX + pFrame->OffsetX,
		nY + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16,nColor,nAlpha);
}

//---------------------------------------------------------------------------
// ����:	DrawAlpha
// ����:	���ƴ�Alpha�ľ���ͼ��
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawAlpha(int nX, int nY, int nFrame, int nExAlpha)
{
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);
	
	// draw the frame
	g_pCanvas->DrawSpriteAlpha(
		nX + pFrame->OffsetX,
		nY + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16, nExAlpha);
}
//---------------------------------------------------------------------------
// ����:	DrawAlphaCenter
// ����:	��nX,nYΪ���Ļ��ƴ�Alpha�ľ���ͼ��
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawAlphaCenter(int nX, int nY, int nFrame, int nExAlpha)
{
	int X0,Y0;
	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	   X0=nX-m_nCenterX;
       Y0=nY-m_nCenterY;
	
	// goto frame
	SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);
	
	// draw the frame
	g_pCanvas->DrawSpriteAlpha(
		X0 + pFrame->OffsetX,
		Y0 + pFrame->OffsetY,
		pFrame->Width,
		pFrame->Height,
		pFrame->Sprite,
		m_pPal16, nExAlpha);
}

//---------------------------------------------------------------------------
// ����:	DrawTrans
// ����:	���ƴ�Alpha�ľ���ͼ��
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawTrans(int nX, int nY, int nFrame)
{
}
//---------------------------------------------------------------------------
// ����:	DrawBorder
// ����:	Draw Sprite Onto Screen
// ����:	nX		X����
//			nY		Y����
//			nFrame	Ҫ���Ƶ�֡
// ����:	void
//---------------------------------------------------------------------------
void KSprite::DrawBorder(int nX, int nY, int nFrame, int nColor)
{
	LPBYTE	pSprite = m_pSprite;

	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return;
	
	// goto frame
	pSprite += m_pOffset[nFrame].Offset;

	// draw the frame
	g_pCanvas->DrawSpriteBorder(nX, nY, m_nWidth, m_nHeight, nColor, pSprite);
	//g_DrawSpriteBorder(nX, nY, m_nWidth, m_nHeight, nColor, pSprite);
}
//---------------------------------------------------------------------------
// ����:	NexFrame
// ����:	ȡ����һ֡
// ����:	nFrame		��ǰ֡
// ����:	��һ֡
//---------------------------------------------------------------------------
int KSprite::NextFrame(int nFrame)
{
	nFrame++;
	if (nFrame >= m_nFrames)
		nFrame = 0;
	return nFrame;
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// ����:	GetPixelAlpha
// ����:	ȡ��ĳһ���alphaֵ
// ����:	nFrame		��ǰ֡
//---------------------------------------------------------------------------
int	KSprite::GetPixelAlpha(int nFrame, int x, int y)
{
	int	nAlpha = 0;
	if (nFrame >= 0 && nFrame < m_nFrames)
	{
		SPRFRAME* pFrame = (SPRFRAME*)(m_pSprite + m_pOffset[nFrame].Offset);
		x -= pFrame->OffsetX;
		y -= pFrame->OffsetY;
		if (x >= 0  && x < pFrame->Width && y >= 0 && y < pFrame->Height)
		{

			int	nNumPixels = pFrame->Width;
			void*	pSprite = pFrame->Sprite;
			y++;
			_asm
			{
				//ʹSDIָ��sprite�е�ͼ������λ��
				mov		esi, pSprite
			dec_line:
				dec		y				//����һ��
				jz		last_line

				mov		edx, nNumPixels
			skip_line:
				movzx	eax, byte ptr[esi]
				inc		esi
				movzx	ebx, byte ptr[esi]
				inc		esi
				or		ebx, ebx
				jz		skip_line_continue
				add		esi, eax
			skip_line_continue:
				sub		edx, eax
				jg		skip_line
				jmp		dec_line

			last_line:
				mov		edx, x
			last_line_alpha_block:
				movzx	eax, byte ptr[esi]
				inc		esi
				movzx	ebx, byte ptr[esi]
				inc		esi
				or		ebx, ebx
				jz		last_line_continue
				add		esi, eax
			last_line_continue:
				sub		edx, eax
				jg		last_line_alpha_block
				mov		nAlpha, ebx
			}
		}
	}
	return nAlpha;
}

//---------------------------------------------------------------------------
// ����:	GetFrame
// ����:	Get Sprite Frame
// ����:	nFrame	֡
// ����:	void
//---------------------------------------------------------------------------
LPVOID KSprite::GetFrame(int nFrame)
{
	LPBYTE	pSprite = m_pSprite;

	// check frame range
	if (nFrame < 0 || nFrame >= m_nFrames)
		return NULL;
	
	// goto frame
	pSprite += m_pOffset[nFrame].Offset;
	
	return (LPVOID)pSprite;
}
