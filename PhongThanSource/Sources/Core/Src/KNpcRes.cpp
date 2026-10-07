//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KNpcRes.cpp
// Date:	2002.01.06
// Code:	�߳�����
// Desc:	Obj Class
//---------------------------------------------------------------------------

#include "KCore.h"

#ifndef _SERVER

#include "KSprite.h"
#include "KNpc.h"
#include "KNpcResList.h"
#include "KNpcRes.h"
#include "ImgRef.h"
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "scene/KScenePlaceC.h"
#include "KSubWorld.h"
#include "KOption.h"
#include "KMath.h"

static BOOL SameVisualPart(const PHONGTHAN_VISUAL_PART& Left,
	const PHONGTHAN_VISUAL_PART& Right)
{
	return Left.nResourceId == Right.nResourceId &&
		Left.nPaletteId == Right.nPaletteId &&
		Left.bVisible == Right.bVisible;
}

// Every VNG player component is authored as eight directional groups.  A few
// large mount SPR headers advertise one group even though their 40/88 frames
// still contain all eight directions.  Trusting that header makes the horse
// stay on direction zero while the rider turns, which visually separates the
// two and causes parts to blink during frame changes.
static int GetPhongThanPlayerSpriteDirs(const char *pszName, int nFrames, int nDirs)
{
	if (pszName && strstr(pszName, "npcres\\human") &&
		nFrames >= 8 && (nFrames % 8) == 0)
		return 8;
	return nDirs > 0 ? nDirs : 1;
}

// The VNG player resource is split into independent SPR components.  Keep a
// small, authoritative fallback for the two components that are required to
// draw a character (head and body).  This is only used when a legacy resource
// row has no usable filename; it never creates or combines a new asset.
static const char *GetPhongThanPlayerActionSpr(int nAction)
{
	// Exact order from the original VNG action-number table. In particular,
	// mounted actions are 16..29 and must never fall back to normal sit/run.
	static const char *s_ActionName[] =
	{
		"st", "sit", "st0", "st1", "st2",
		"run0", "run1", "run2",
		"at0", "at1", "at2",
		"bat0", "bat1", "bat2", "die", "gv",
		"rs0", "rs1", "rs2",
		"rr0", "rr1", "rr2",
		"ra0", "ra1", "ra2",
		"rb0", "rb1", "rb2", "rdi", "rgv"
	};
	const int nActionCount = sizeof(s_ActionName) / sizeof(s_ActionName[0]);
	return (nAction >= 0 && nAction < nActionCount) ? s_ActionName[nAction] : "st0";
}

static const char *GetPhongThanPlayerActionSprFromDoing(int nDoing, BOOL bRideHorse)
{
	if (bRideHorse)
	{
		switch (nDoing)
		{
		case cdo_walk:
		case cdo_run:
		case cdo_fightwalk:
		case cdo_fightrun:
			return "rr0";
		case cdo_attack:
		case cdo_attack1:
		case cdo_magic:
			return "ra0";
		case cdo_hurt:
			return "rb0";
		case cdo_death:
			return "rdi";
		default:
			return "rs0";
		}
	}

	switch (nDoing)
	{
	case cdo_sit:
		return "sit";
	case cdo_walk:
	case cdo_run:
	case cdo_fightwalk:
	case cdo_fightrun:
		return "run0";
	case cdo_attack:
	case cdo_attack1:
	case cdo_magic:
		return "at1";
	case cdo_hurt:
		return "bat0";
	case cdo_death:
		return "die";
	default:
		return "st0";
	}
}

static const char *GetPhongThanPlayerSprPrefix(int nProfession)
{
	switch (nProfession)
	{
	case 1:
		return "ss";
	case 2:
		return "yr";
	case 0:
	default:
		return "js";
	}
}

static void BindPhongThanPlayerPart(KSprControl *pSpr, char *pszName)
{
	if (!pSpr || !pszName || !pszName[0])
		return;

	int nFrames = 16;
	int nDirs = 8;
	int nInterval = 1;
	if (g_pRepresent)
	{
		KImageParam sImage;
		memset(&sImage, 0, sizeof(sImage));
		if (g_pRepresent->GetImageParam(pszName, &sImage, ISI_T_SPR))
		{
			if (sImage.nNumFrames > 0)
				nFrames = sImage.nNumFrames;
			nDirs = GetPhongThanPlayerSpriteDirs(pszName,
				nFrames, sImage.nNumFramesGroup);
			nInterval = sImage.nInterval;
		}
	}
	pSpr->SetSprFile(pszName, nFrames, nDirs, nInterval);
}
//---------------------------------------------------------------------------
//	���ܣ�	���캯��
//---------------------------------------------------------------------------
KNpcRes::KNpcRes()
{
	// Valid descriptors are required even if the resource-row lookup fails.
	ZeroMemory(m_cDrawFile, sizeof(m_cDrawFile));
	for (int nImage = 0; nImage < MAX_NPC_IMAGE_NUM; ++nImage)
	{
		m_cDrawFile[nImage].nType = ISI_T_SPR;
		m_cDrawFile[nImage].Color.Color_b.a = 255;
		m_cDrawFile[nImage].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		m_cDrawFile[nImage].nISPosition = IMAGE_IS_POSITION_INIT;
		m_cDrawFile[nImage].bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	}
	m_ulAdjustColorId = 0;
	m_pcResNode = NULL;
	m_pcResTemp = NULL;
	m_nDoing = cdo_stand;
	m_nAction = 0;
	m_nNpcKind = 1;
	ZeroMemory(&m_HelmVisual, sizeof(m_HelmVisual));
	m_HelmVisual.bVisible = TRUE;
	ZeroMemory(&m_ArmorVisual, sizeof(m_ArmorVisual));
	m_ArmorVisual.bVisible = TRUE;
	ZeroMemory(&m_WeaponVisual, sizeof(m_WeaponVisual));
	m_WeaponVisual.bVisible = TRUE;
	ZeroMemory(&m_PhiPhongVisual, sizeof(m_PhiPhongVisual));
	ZeroMemory(m_nPartPalette, sizeof(m_nPartPalette));
	ZeroMemory(&m_HorseVisual, sizeof(m_HorseVisual));
	m_bRideHorse = FALSE;
	m_nBlurState = 0;
	memset(m_szSoundName, 0, sizeof(m_szSoundName));
	memset(m_nSortTable, 0, sizeof(m_nSortTable));
	m_pSoundNode = NULL;
	m_pWave = NULL;

	m_SceneID_NPCIdx = 0;
	m_SceneID = 0;

	m_nMenuState = 0;
	m_nBackMenuState = 0;
	m_nSleepState = 0;
	m_nXpos = 0;
	m_nYpos = 0;
	m_nZpos = 0;
	m_nXposOld = 0;
	m_nYposOld = 0;
	m_nZposOld = 0;
	m_nXposNew = 0;
	m_nYposNew = 0;
	m_nZposNew = 0;
	//memset(m_szSentence, 0, sizeof(m_szSentence));
	//memset(m_szBackSentence, 0, sizeof(m_szBackSentence));
}

//---------------------------------------------------------------------------
//	���ܣ�	��ʼ��
//---------------------------------------------------------------------------
BOOL	KNpcRes::Init(char *lpszNpcName, KNpcResList *pNpcResList)
{
	// ��ʼ�� NpcResNode
	if (!lpszNpcName || !lpszNpcName[0])
		return FALSE;
	m_pcResNode = pNpcResList->AddNpcRes(lpszNpcName);
	m_pcResTemp = NULL;
	if ( m_pcResNode == NULL )
		return FALSE;

	m_nNpcKind = m_pcResNode->GetNpcKind();
	m_nAction = 0;
	ZeroMemory(&m_HelmVisual, sizeof(m_HelmVisual));
	m_HelmVisual.bVisible = TRUE;
	ZeroMemory(&m_ArmorVisual, sizeof(m_ArmorVisual));
	m_ArmorVisual.bVisible = TRUE;
	ZeroMemory(&m_WeaponVisual, sizeof(m_WeaponVisual));
	m_WeaponVisual.bVisible = TRUE;
	ZeroMemory(&m_HorseVisual, sizeof(m_HorseVisual));
	m_bRideHorse = FALSE;
	ZeroMemory(&m_PhiPhongVisual, sizeof(m_PhiPhongVisual));
	ZeroMemory(m_nPartPalette, sizeof(m_nPartPalette));
	memset(m_szSoundName, 0, sizeof(m_szSoundName));
	memset(m_nSortTable, 0, sizeof(m_nSortTable));
	m_pSoundNode = NULL;
	m_pWave = NULL;

	m_SceneID_NPCIdx = 0;
	m_SceneID = 0;


//	m_pSprNode = NULL;

	int		i;
	char	szBuffer[80];
	for (i = 0; i < MAX_PART; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			m_pcResNode->GetFileName(i, m_nAction, 0, "", szBuffer, sizeof(szBuffer));
			m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, 0, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, 0, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, 0, 0));

			m_pcResNode->GetFileName(i, m_nAction, 0, "", szBuffer, sizeof(szBuffer),true);
			m_cNpcEffectImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, 0, MAX_PART, true), m_pcResNode->GetTotalDirs(i, m_nAction, 0, MAX_PART, true), m_pcResNode->GetInterval(i, m_nAction, 0, 0,true));
		}
		// ����˲��������ڣ���Ӧ���ļ��������
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}

	int		nShadowFrame, nShadowDir, nShadowInterval, nShadowCgX, nShadowCgY;
	if ( m_pcResNode->m_cShadowInfo.GetFile(
		m_nAction,
		&nShadowFrame,
		&nShadowDir,
		&nShadowInterval,
		&nShadowCgX,
		&nShadowCgY,
		szBuffer) )
	{
		this->m_cNpcShadow.SetSprFile(szBuffer, nShadowFrame, nShadowDir, nShadowInterval);
		this->m_cNpcShadow.SetCenterPos(nShadowCgX, nShadowCgY);
	}
	else
	{
		this->m_cNpcShadow.Release();
	}

	for (i = 0; i < MAX_SKILL_STATE; i++)
	{
		m_cStateSpr[i].Release();
	}
	m_cSpecialSpr.Release();
	m_cMenuStateSpr.Release();
	m_nMenuState = 0;
	m_nBackMenuState = 0;
	m_nSleepState = 0;
	//memset(m_szSentence, 0, sizeof(m_szSentence));
	//memset(m_szBackSentence, 0, sizeof(m_szBackSentence));

	for (i = 0; i < MAX_NPC_IMAGE_NUM; i++)
	{
		m_cDrawFile[i].nType = ISI_T_SPR;
		m_cDrawFile[i].Color.Color_b.a = 255;
		m_cDrawFile[i].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		m_cDrawFile[i].uImage = 0;
		m_cDrawFile[i].nISPosition = IMAGE_IS_POSITION_INIT;
		m_cDrawFile[i].bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	}
	return m_cNpcBlur.Init();

}


void	KNpcRes::_Init(char *lpszNpcName, KNpcResList *pNpcResList)
{
	// ��ʼ�� NpcResNode
	if (!lpszNpcName || !lpszNpcName[0])
		return;
	m_pcResNode = pNpcResList->AddNpcRes(lpszNpcName);
	m_pcResTemp = NULL;
	if ( m_pcResNode == NULL )
		return;

	m_nNpcKind = m_pcResNode->GetNpcKind();
	m_nAction = 0;
	ZeroMemory(&m_HelmVisual, sizeof(m_HelmVisual));
	m_HelmVisual.bVisible = TRUE;
	ZeroMemory(&m_ArmorVisual, sizeof(m_ArmorVisual));
	m_ArmorVisual.bVisible = TRUE;
	ZeroMemory(&m_WeaponVisual, sizeof(m_WeaponVisual));
	m_WeaponVisual.bVisible = TRUE;
	ZeroMemory(&m_HorseVisual, sizeof(m_HorseVisual));
	m_bRideHorse = FALSE;
	ZeroMemory(&m_PhiPhongVisual, sizeof(m_PhiPhongVisual));
	ZeroMemory(m_nPartPalette, sizeof(m_nPartPalette));
	memset(m_szSoundName, 0, sizeof(m_szSoundName));
	memset(m_nSortTable, 0, sizeof(m_nSortTable));
	m_pSoundNode = NULL;
	m_pWave = NULL;

	m_SceneID_NPCIdx = 0;
	m_SceneID = 0;


//	m_pSprNode = NULL;

	int		i;
	char	szBuffer[80];
	for (i = 0; i < MAX_PART; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			m_pcResNode->GetFileName(i, m_nAction, 0, "", szBuffer, sizeof(szBuffer));
			m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, 0, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, 0, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, 0, 0));

			m_pcResNode->GetFileName(i, m_nAction, 0, "", szBuffer, sizeof(szBuffer),true);
			m_cNpcEffectImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, 0, MAX_PART, true), m_pcResNode->GetTotalDirs(i, m_nAction, 0, MAX_PART, true), m_pcResNode->GetInterval(i, m_nAction, 0, 0,true));
		}
		// ����˲��������ڣ���Ӧ���ļ��������
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}

	int		nShadowFrame, nShadowDir, nShadowInterval, nShadowCgX, nShadowCgY;
	if ( m_pcResNode->m_cShadowInfo.GetFile(
		m_nAction,
		&nShadowFrame,
		&nShadowDir,
		&nShadowInterval,
		&nShadowCgX,
		&nShadowCgY,
		szBuffer) )
	{
		this->m_cNpcShadow.SetSprFile(szBuffer, nShadowFrame, nShadowDir, nShadowInterval);
		this->m_cNpcShadow.SetCenterPos(nShadowCgX, nShadowCgY);
	}
	else
	{
		this->m_cNpcShadow.Release();
	}
}

void	KNpcRes::Remove(int nNpcIdx)
{
	if (m_SceneID)
	{
		g_ScenePlace.RemoveObject(CGOG_NPC, nNpcIdx, m_SceneID);
		m_SceneID = 0;
	}
	//m_cNpcBlur.Remove();
}
//---------------------------------------------------------------------------
//	���ܣ�	����
//---------------------------------------------------------------------------
void	KNpcRes::Draw(int nNpcIdx, int nDir, int nAllFrame, int nCurFrame, BOOL bInMenu, BOOL bPaintBody)
{
	int		i, nGetFrame = 1, nGetDir = 1, nFirst, nPos;
	int		nCurFrameNo = 0, nCurDirNo = 0;
	// One authoritative world anchor for body, shadow, effects and blur.
	// SPR frame OffsetX/OffsetY remains asset metadata, not a gameplay offset.
	int		nScreenX = m_nXpos, nScreenY = m_nYpos, nScreenZ = m_nZpos;

	BOOL	bBodySubmitted = FALSE;

	if (nDir < 0 || nAllFrame < 0 || nCurFrame < 0)
		return;

	const BOOL bPhongThanPlayer =
		(nNpcIdx > 0 && nNpcIdx < MAX_NPC && Npc[nNpcIdx].m_Kind == kind_player);
	if (!m_pcResNode && !bPhongThanPlayer)
		return;

	// A failed character-row lookup must not drop the complete player body.
	// Bind the two mandatory original VNG components directly from the
	// authoritative appearance snapshot; normal NpcResType tables stay primary.
	if (bPhongThanPlayer && !m_pcResNode)
	{
		const char cSex =
			(Npc[nNpcIdx].m_NpcSettingIdx == PLAYER_FEMALE_NPCTEMPLATEID ||
			 Npc[nNpcIdx].m_nSex) ? 'f' : 'm';
		const char *pszPrefix = GetPhongThanPlayerSprPrefix(Npc[nNpcIdx].m_Series);
		const char *pszAction = m_pcResNode ?
			GetPhongThanPlayerActionSpr(m_nAction) :
			GetPhongThanPlayerActionSprFromDoing(Npc[nNpcIdx].m_ClientDoing,
				Npc[nNpcIdx].m_bRideHorse);
		int nHelm = Npc[nNpcIdx].m_Appearance.Helm.nResourceId;
		int nArmor = Npc[nNpcIdx].m_Appearance.Armor.nResourceId;
		if (nHelm < 0 || nHelm > 99)
			nHelm = 0;
		if (nArmor < 0 || nArmor > 99)
			nArmor = 0;

		char szPlayerPart[80];
		sprintf(szPlayerPart, "\\spr\\npcres\\human\\%s%c%02d_hd_%s.spr",
			pszPrefix, cSex, nHelm, pszAction);
		if (strcmp(m_cNpcImage[0].m_szName, szPlayerPart) != 0)
			BindPhongThanPlayerPart(&m_cNpcImage[0], szPlayerPart);

		sprintf(szPlayerPart, "\\spr\\npcres\\human\\%s%c%02d_bd_%s.spr",
			pszPrefix, cSex, nArmor, pszAction);
		if (strcmp(m_cNpcImage[MAX_BODY_PART_SECT].m_szName, szPlayerPart) != 0)
			BindPhongThanPlayerPart(&m_cNpcImage[MAX_BODY_PART_SECT], szPlayerPart);
	}
	// �ⲿ���ƻ�֡
	if (nAllFrame > 0)
	{
		// ������Ӱ��ǰ֡
		nGetDir = this->m_cNpcShadow.m_nTotalDir;
		if (nGetDir <= 0)
			nGetDir = 1;
		nCurDirNo = (nDir + (32 / nGetDir)) / (64 / nGetDir);
		if (nCurDirNo >= nGetDir)
			nCurDirNo -= nGetDir;
		nGetFrame = this->m_cNpcShadow.m_nTotalFrame;
		nCurFrameNo = nCurDirNo * (nGetFrame / nGetDir) + (nGetFrame / nGetDir) * nCurFrame / nAllFrame;
		this->m_cNpcShadow.SetCurFrame(nCurFrameNo);

		// ��������
		nFirst = 0;
		// �ҵ������ĵ�ǰ��
		for (i = 0; i < MAX_PART; i++)
		{
			if (m_cNpcImage[i].CheckExist())
			{
				if (nFirst == 0)
				{
					nGetDir = m_cNpcImage[i].m_nTotalDir;
					if (nGetDir <= 0)
						nGetDir = 1;

					nCurDirNo = (nDir + (32 / nGetDir)) / (64 / nGetDir);
					if (nCurDirNo >= nGetDir)
						nCurDirNo -= nGetDir;

					nGetFrame = m_cNpcImage[i].m_nTotalFrame;

					nCurFrameNo = nCurDirNo * (nGetFrame / nGetDir) + (nGetFrame / nGetDir) * nCurFrame / nAllFrame;
					m_cNpcImage[i].SetCurFrame(nCurFrameNo);
					nFirst = 1;
				}
				else
				{
					// Metadata was resolved when binding the SPR. Components may
					// have different frame counts: map the same animation phase.
					int dirs = m_cNpcImage[i].m_nTotalDir;
					if (dirs < 1 || dirs > 64) dirs = 1;
					int frames = m_cNpcImage[i].m_nTotalFrame / dirs;
					int dir = ((nDir + 32 / dirs) / (64 / dirs)) % dirs;
					int phase = frames * nCurFrame / nAllFrame;
					if (phase >= frames) phase = frames - 1;
					if (frames > 0) m_cNpcImage[i].SetCurFrame(dir * frames + phase);
				}
			}
			if (m_cNpcEffectImage[i].CheckExist())
			{
				KImageParam	sImage;
				if (g_pRepresent->GetImageParam(m_cNpcEffectImage[i].m_szName, &sImage, ISI_T_SPR))
				{
					m_cNpcEffectImage[i].m_nTotalDir = sImage.nNumFramesGroup;
					m_cNpcEffectImage[i].m_nTotalFrame = sImage.nNumFrames;
					m_cNpcEffectImage[i].m_nTotalDir>1?m_cNpcEffectImage[i].SetCurFrame(nCurFrameNo):m_cNpcEffectImage[i].GetNextFrame();
				}
			}
		}
	}
	else
	{
		// ������Ӱ��ǰ֡
		if (m_cNpcShadow.SetCurDir64(nDir))
		{
			m_cNpcShadow.GetNextFrame();
		}

		// ��������
		for (i = 0; i < MAX_PART; i++)
		{
			if ( m_cNpcEffectImage[i].CheckExist() )
			{
				if ( m_cNpcEffectImage[i].SetCurDir64(nDir) )
				{
					m_cNpcEffectImage[i].GetNextFrame();
				}
			}
			if ( !m_cNpcImage[i].CheckExist() )
				continue;
			if ( m_cNpcImage[i].SetCurDir64(nDir) )
			{
				m_cNpcImage[i].GetNextFrame();

				nCurDirNo = m_cNpcImage[i].m_nCurDir;
				nCurFrameNo = m_cNpcImage[i].m_nCurFrame;
			}
		}
	}

	// ״̬��Ч��֡
	for (i = 0; i < MAX_SKILL_STATE; i++)
		m_cStateSpr[i].m_SprContrul.GetNextFrame();
	if ( m_cSpecialSpr.GetNextFrame(FALSE) )
	{
		if ( m_cSpecialSpr.CheckEnd() )
			m_cSpecialSpr.Release();
	}

	// ��������
	if (nCurFrame < nAllFrame / 4)
	{
		this->GetSoundName();
		this->PlaySound(this->m_nXpos, this->m_nYpos);
	}

	// Obtain the configured part order. Some original VNG player rows return a
	// formally valid sort table whose entries do not reference the body parts
	// selected by the current equipment. Rebuild the order from the SPR parts
	// that really exist so a valid character resource can never draw body=0.
	BOOL bGotSort = m_pcResNode &&
		m_pcResNode->GetSort(m_nAction, nCurDirNo, nCurFrameNo,
			m_nSortTable, MAX_PART);
	BOOL bHaveSortedPart = FALSE;
	if (bGotSort)
	{
		for (i = 0; i < MAX_PART; i++)
		{
			int nPartNo = m_nSortTable[i];
			if (nPartNo >= 0 && nPartNo < MAX_PART &&
				(m_cNpcImage[nPartNo].CheckExist() ||
				 m_cNpcEffectImage[nPartNo].CheckExist()))
			{
				bHaveSortedPart = TRUE;
				break;
			}
		}
	}
	if (!bGotSort || !bHaveSortedPart)
	{
		int nFallbackPart = 0;
		for (i = 0; i < MAX_PART; i++)
		{
			m_nSortTable[i] = -1;
			if ((m_cNpcImage[i].CheckExist() || m_cNpcEffectImage[i].CheckExist()) &&
				nFallbackPart < MAX_PART)
			{
				m_nSortTable[nFallbackPart++] = i;
			}
		}
	}
// ---------------------------------- ���������б� -------------------------------
	nPos = 0;
	// ��Ӱ�ļ���
	if ((IgnoreShowRes()==FALSE) && bPaintBody && m_cNpcShadow.CheckExist())
	{
		strcpy(m_cDrawFile[nPos].szImage, this->m_cNpcShadow.m_szName);
		m_cDrawFile[nPos].uImage = m_cNpcShadow.m_dwNameID;
		m_cDrawFile[nPos].nFrame = this->m_cNpcShadow.m_nCurFrame;
		m_cDrawFile[nPos].oPosition.nX = nScreenX;
		m_cDrawFile[nPos].oPosition.nY = nScreenY;
		m_cDrawFile[nPos].oPosition.nZ = 0;//nScreenZ;
		nPos++;
	}
	// �ŵ�״̬��Ч
	for ( i = MAX_SKILL_STATE - (MAX_SKILL_STATE/3); i < MAX_SKILL_STATE; i++)
	{
		if (m_cStateSpr[i].m_nID)
		{
			strcpy(m_cDrawFile[nPos].szImage, m_cStateSpr[i].m_SprContrul.m_szName);
			m_cDrawFile[nPos].uImage = m_cStateSpr[i].m_SprContrul.m_dwNameID;
			m_cDrawFile[nPos].nFrame = m_cStateSpr[i].m_SprContrul.m_nCurFrame;
			m_cDrawFile[nPos].oPosition.nX = nScreenX;
			m_cDrawFile[nPos].oPosition.nY = nScreenY;
			m_cDrawFile[nPos].oPosition.nZ = 0;
			nPos++;
		}
	}
	
	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);
	nPos = 0;

	// ����״̬��Ч(npc����)
	for (i = (MAX_SKILL_STATE/3); i < MAX_SKILL_STATE - (MAX_SKILL_STATE/3); i++)
	{
		if (m_cStateSpr[i].m_nID)
		{
			if (m_cStateSpr[i].m_nBackStart <= m_cStateSpr[i].m_SprContrul.m_nCurFrame && 
				m_cStateSpr[i].m_SprContrul.m_nCurFrame < m_cStateSpr[i].m_nBackEnd)
			{
				strcpy(m_cDrawFile[nPos].szImage, m_cStateSpr[i].m_SprContrul.m_szName);
				
				m_cDrawFile[nPos].uImage = m_cStateSpr[i].m_SprContrul.m_dwNameID;
				m_cDrawFile[nPos].nFrame = m_cStateSpr[i].m_SprContrul.m_nCurFrame;
				m_cDrawFile[nPos].oPosition.nX = nScreenX;
				m_cDrawFile[nPos].oPosition.nY = nScreenY;
				int nHeightOff = 0;
				if (m_bRideHorse && !Npc[nNpcIdx].m_MaskType)
					nHeightOff += 38;
				m_cDrawFile[nPos].oPosition.nZ = nScreenZ + nHeightOff;
				nPos++;
			}
		}

	}

	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);
	nPos = 0;

	// npc����
	if (bPaintBody)
	{
		for (i = 0; i < MAX_PART; i++)
		{
			if (m_nSortTable[i] >= 0 && m_nSortTable[i] < MAX_PART &&
				m_cNpcEffectImage[m_nSortTable[i]].CheckExist())
			{
				if (m_ulAdjustColorId > 0 && m_ulAdjustColorId <= g_ulAdjustColorCount)
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA_COLOR_ADJUST;
					m_cDrawFile[nPos].Color.Color_dw = g_pAdjustColorTab[m_ulAdjustColorId - 1];
				}
				else if (m_nPartPalette[m_nSortTable[i]] > 0 &&
					 m_nPartPalette[m_nSortTable[i]] <= (int)g_ulAdjustColorCount)
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA_COLOR_ADJUST;
					m_cDrawFile[nPos].Color.Color_dw =
						 g_pAdjustColorTab[m_nPartPalette[m_nSortTable[i]] - 1];
				}
				else
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
					if (Npc[nNpcIdx].m_HideState.nTime)
						m_cDrawFile[nPos].Color.Color_b.a = START_BLUR_ALPHA;
					else
						m_cDrawFile[nPos].Color.Color_b.a = 255;
				}
				strcpy(m_cDrawFile[nPos].szImage, m_cNpcEffectImage[m_nSortTable[i]].m_szName);
				m_cDrawFile[nPos].uImage = m_cNpcEffectImage[m_nSortTable[i]].m_dwNameID;
				m_cDrawFile[nPos].nFrame = m_cNpcEffectImage[m_nSortTable[i]].m_nCurFrame;
				m_cDrawFile[nPos].oPosition.nX = nScreenX;
				m_cDrawFile[nPos].oPosition.nY = nScreenY;
				m_cDrawFile[nPos].oPosition.nZ = nScreenZ;

				nPos++;
			}
		}
		if (nPos > 0)
			g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);
		nPos = 0;
		for (i = 0; i < MAX_PART; i++)
		{
			if (m_nSortTable[i] >= 0 && m_nSortTable[i] < MAX_PART &&
				m_cNpcImage[m_nSortTable[i]].CheckExist())
			{
				if (m_ulAdjustColorId > 0 && m_ulAdjustColorId <= g_ulAdjustColorCount)
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA_COLOR_ADJUST;
					m_cDrawFile[nPos].Color.Color_dw = g_pAdjustColorTab[m_ulAdjustColorId - 1];
				}
				else if (m_nPartPalette[m_nSortTable[i]] > 0 &&
					 m_nPartPalette[m_nSortTable[i]] <= (int)g_ulAdjustColorCount)
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA_COLOR_ADJUST;
					m_cDrawFile[nPos].Color.Color_dw =
						 g_pAdjustColorTab[m_nPartPalette[m_nSortTable[i]] - 1];
				}
				else
				{
					m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
					if (Npc[nNpcIdx].m_HideState.nTime)
						m_cDrawFile[nPos].Color.Color_b.a = 128;
					else
						m_cDrawFile[nPos].Color.Color_b.a = 255;				
				}
				strcpy(m_cDrawFile[nPos].szImage, m_cNpcImage[m_nSortTable[i]].m_szName);
				m_cDrawFile[nPos].uImage = m_cNpcImage[m_nSortTable[i]].m_dwNameID;
				m_cDrawFile[nPos].nFrame = m_cNpcImage[m_nSortTable[i]].m_nCurFrame;
				m_cDrawFile[nPos].oPosition.nX = nScreenX;
				m_cDrawFile[nPos].oPosition.nY = nScreenY;
				m_cDrawFile[nPos].oPosition.nZ = nScreenZ;

				nPos++;
			}
		}
		if (nPos > 0)
		{
			bBodySubmitted = TRUE;
			static BYTE s_bNpcBodyLogged[MAX_NPC] = {0};
			// Initial-spawn-only logging hid subsequent equipment/mount failures.
			static DWORD s_dwAppearanceTraceTick = 0;
			if (bPhongThanPlayer && nNpcIdx > 0 && nNpcIdx < MAX_NPC &&
				GetTickCount() - s_dwAppearanceTraceTick >= 3000)
			{
				s_dwAppearanceTraceTick = GetTickCount();
				s_bNpcBodyLogged[nNpcIdx] = 0;
			}
			if (nNpcIdx > 0 && nNpcIdx < MAX_NPC && !s_bNpcBodyLogged[nNpcIdx])
			{
				s_bNpcBodyLogged[nNpcIdx] = 1;
				FILE *pNpcBodyLog = fopen("client_npc_render_diag.log", "a");
				if (pNpcBodyLog)
				{
					fprintf(pNpcBodyLog,
						"body=1 index=%d template=%d parts=%d doing=%d action=%d ride=%d helm=%d armor=%d weapon=%d horse=%d screen=%d,%d,%d\n",
						nNpcIdx, Npc[nNpcIdx].m_NpcSettingIdx, nPos,
						m_nDoing, m_nAction, m_bRideHorse,
						m_HelmVisual.nResourceId, m_ArmorVisual.nResourceId, m_WeaponVisual.nResourceId, m_HorseVisual.nResourceId,
						nScreenX, nScreenY, nScreenZ);
					for (int nLogPart = 0; nLogPart < MAX_PART; nLogPart++)
					{
						if (m_cNpcImage[nLogPart].CheckExist())
						{
							fprintf(pNpcBodyLog,
								"part=%d image=%s frame=%d frames=%d dirs=%d\n",
								nLogPart, m_cNpcImage[nLogPart].m_szName,
								m_cNpcImage[nLogPart].m_nCurFrame,
								m_cNpcImage[nLogPart].m_nTotalFrame,
								m_cNpcImage[nLogPart].m_nTotalDir);
						}
					}
					fprintf(pNpcBodyLog, "sort=");
					for (int nLogSort = 0; nLogSort < MAX_PART; nLogSort++)
					{
						if (m_nSortTable[nLogSort] >= 0 &&
							m_nSortTable[nLogSort] < MAX_PART)
							fprintf(pNpcBodyLog, "%s%d", nLogSort ? "," : "",
								m_nSortTable[nLogSort]);
					}
					fprintf(pNpcBodyLog, "\n");
					fclose(pNpcBodyLog);
				}
			}
			g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);
		}
		nPos = 0;
	}
	// ����״̬��Ч(npc��ǰ)
	for (i = (MAX_SKILL_STATE/3); i < MAX_SKILL_STATE - (MAX_SKILL_STATE/3); i++)
	{
		if (m_cStateSpr[i].m_nID)
		{
			if (m_cStateSpr[i].m_SprContrul.m_nCurFrame < m_cStateSpr[i].m_nBackStart || 
				m_cStateSpr[i].m_SprContrul.m_nCurFrame >= m_cStateSpr[i].m_nBackEnd)
			{
				strcpy(m_cDrawFile[nPos].szImage, m_cStateSpr[i].m_SprContrul.m_szName);
				m_cDrawFile[nPos].uImage = m_cStateSpr[i].m_SprContrul.m_dwNameID;
				m_cDrawFile[nPos].nFrame = m_cStateSpr[i].m_SprContrul.m_nCurFrame;
				m_cDrawFile[nPos].oPosition.nX = nScreenX;
				m_cDrawFile[nPos].oPosition.nY = nScreenY;
				int nHeightOff = 0;
				if (m_bRideHorse && !Npc[nNpcIdx].m_MaskType)
					nHeightOff += 38;
				m_cDrawFile[nPos].oPosition.nZ = nScreenZ + nHeightOff;
				nPos++;
			}
		}
	}
	// �����ֻ����һ���spr�ļ�
	if (m_cSpecialSpr.m_szName[0])
	{
		strcpy(m_cDrawFile[nPos].szImage, m_cSpecialSpr.m_szName);
		m_cDrawFile[nPos].uImage = m_cSpecialSpr.m_dwNameID;
		m_cDrawFile[nPos].nFrame = m_cSpecialSpr.m_nCurFrame;
		m_cDrawFile[nPos].oPosition.nX = nScreenX;
		m_cDrawFile[nPos].oPosition.nY = nScreenY;
		int nHeightOff = 0;
		if (m_bRideHorse && !Npc[nNpcIdx].m_MaskType)
			nHeightOff += 38;
		m_cDrawFile[nPos].oPosition.nZ = nScreenZ + nHeightOff;

		nPos++;
	}		
	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);

	nPos = 0;
	// ͷ��״̬��Ч
	for ( i = 0; i < (MAX_SKILL_STATE/3); i++)
	{
		if (m_cStateSpr[i].m_nID)
		{
			strcpy(m_cDrawFile[nPos].szImage, m_cStateSpr[i].m_SprContrul.m_szName);
			m_cDrawFile[nPos].uImage = m_cStateSpr[i].m_SprContrul.m_dwNameID;
			m_cDrawFile[nPos].nFrame = m_cStateSpr[i].m_SprContrul.m_nCurFrame;
			m_cDrawFile[nPos].oPosition.nX = nScreenX;
			m_cDrawFile[nPos].oPosition.nY = nScreenY;
			int nHeightOff = 10;
			if (m_bRideHorse && !Npc[nNpcIdx].m_MaskType)
				nHeightOff += 38;
			if (Npc[nNpcIdx].m_szTongName[0] || Npc[nNpcIdx].m_CurExpandRank.szName[0])
				nHeightOff += 24;
			if (Npc[nNpcIdx].m_MaskType)
				nHeightOff += 20;
			m_cDrawFile[nPos].oPosition.nZ = nScreenZ + nHeightOff;
			nPos++;
		}
	}
	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, bInMenu);

	if (bPaintBody && !bBodySubmitted)
	{
		static BYTE s_bNpcBodyMissingLogged[MAX_NPC] = {0};
		if (nNpcIdx > 0 && nNpcIdx < MAX_NPC && !s_bNpcBodyMissingLogged[nNpcIdx])
		{
			s_bNpcBodyMissingLogged[nNpcIdx] = 1;
			FILE *pNpcBodyLog = fopen("client_npc_render_diag.log", "a");
			if (pNpcBodyLog)
			{
				fprintf(pNpcBodyLog,
					"body=0 index=%d template=%d action=%d frame=%d dir=%d screen=%d,%d,%d\n",
					nNpcIdx, Npc[nNpcIdx].m_NpcSettingIdx, m_nAction,
					nCurFrameNo, nCurDirNo, nScreenX, nScreenY, nScreenZ);
				fclose(pNpcBodyLog);
			}
		}
	}

	nPos = 0;

// -------------------------------- ���������б� end -----------------------------

// ----------------------------------- ������Ӱ ----------------------------------
	int j = 0;
	m_cNpcBlur.ChangeAlpha();
	if (m_nBlurState == TRUE && m_cNpcBlur.NowGetBlur())
	{
		//m_cNpcBlur.ClearCurNo();
		for (i = 0, j = 0; i < MAX_PART; i++)
		{
			if (m_nSortTable[i] >= 0 && m_nSortTable[i] < MAX_PART)
			{
				m_cNpcBlur.SetFile(j, m_cNpcImage[m_nSortTable[i]].m_szName, m_cNpcImage[m_nSortTable[i]].m_dwNameID, m_cNpcImage[m_nSortTable[i]].m_nCurFrame, nScreenX, nScreenY, nScreenZ);
				j++;
			}
		}

		m_cNpcBlur.SetMapPos(nScreenX, nScreenY, nScreenZ, nNpcIdx);

		m_cNpcBlur.SetNextNo();
	}
}

void	KNpcRes::GetShadowName(char *lpszShadow, char *lpszSprName)
{
	KNpcResNode::GetShadowName(lpszShadow, lpszSprName);
}

KNpcRes::~KNpcRes()
{
}

void KNpcRes::GetResFile(int nActionNo, char *lpszSprName)
{
	int	i;
	if ( !m_pcResTemp )
		return;

	for (i = 0; i < MAX_PART; i++)
	{
		if ( m_pcResTemp->CheckPartExist(i) )
		{
			m_pcResTemp->GetFileName(i, nActionNo, 0, "", lpszSprName, sizeof(lpszSprName));
		}
		if (lpszSprName[0])
			break;
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨ͷ������
//---------------------------------------------------------------------------
BOOL KNpcRes::SetHelm(const PHONGTHAN_VISUAL_PART& Visual)
{
	if (!m_pcResNode || (Visual.bVisible && Visual.nResourceId < 0) || Visual.nPaletteId < 0)
		return FALSE;
	if (SameVisualPart(m_HelmVisual, Visual))
		return TRUE;

	m_HelmVisual = Visual;
	char szBuffer[80];
	for (int i = 0; i < MAX_BODY_PART_SECT; ++i)
	{
		m_nPartPalette[i] = Visual.nPaletteId;
		if (!Visual.bVisible || IgnoreShowRes() || !m_pcResNode->CheckPartExist(i))
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
			continue;
		}
		m_pcResNode->GetFileName(i, m_nAction, Visual.nResourceId, "", szBuffer, sizeof(szBuffer));
		m_cNpcImage[i].SetSprFile(szBuffer,
			m_pcResNode->GetTotalFrames(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetTotalDirs(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetInterval(i, m_nAction, Visual.nResourceId, 0));
	}
	return TRUE;
}

BOOL KNpcRes::SetArmor(const PHONGTHAN_VISUAL_PART& Visual)
{
	if (!m_pcResNode || (Visual.bVisible && Visual.nResourceId < 0) || Visual.nPaletteId < 0)
		return FALSE;
	if (SameVisualPart(m_ArmorVisual, Visual))
		return TRUE;

	m_ArmorVisual = Visual;
	char szBuffer[80];
	for (int i = MAX_BODY_PART_SECT; i < MAX_BODY_PART_SECT * 2; ++i)
	{
		m_nPartPalette[i] = Visual.nPaletteId;
		if (!Visual.bVisible || !m_pcResNode->CheckPartExist(i))
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
			continue;
		}
		m_pcResNode->GetFileName(i, m_nAction, Visual.nResourceId, "", szBuffer, sizeof(szBuffer));
		m_cNpcImage[i].SetSprFile(szBuffer,
			m_pcResNode->GetTotalFrames(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetTotalDirs(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetInterval(i, m_nAction, Visual.nResourceId, 0));
	}
	return TRUE;
}

BOOL KNpcRes::SetPhiPhong(const PHONGTHAN_VISUAL_PART& Visual)
{
	if (!m_pcResNode || (Visual.bVisible && Visual.nResourceId < 0) || Visual.nPaletteId < 0)
		return FALSE;
	if (SameVisualPart(m_PhiPhongVisual, Visual))
		return TRUE;

	m_PhiPhongVisual = Visual;
	char szBuffer[80];
	for (int i = MAX_BODY_PART_SECT * 3; i < MAX_BODY_PART_SECT * 4; ++i)
	{
		m_nPartPalette[i] = Visual.nPaletteId;
		if (!Visual.bVisible || IgnoreShowRes() || !m_pcResNode->CheckPartExist(i))
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
			continue;
		}
		m_pcResNode->GetFileName(i, m_nAction, Visual.nResourceId, "", szBuffer, sizeof(szBuffer));
		m_cNpcImage[i].SetSprFile(szBuffer,
			m_pcResNode->GetTotalFrames(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetTotalDirs(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetInterval(i, m_nAction, Visual.nResourceId, 0));
	}
	return TRUE;
}
BOOL KNpcRes::SetWeapon(const PHONGTHAN_VISUAL_PART& Visual)
{
	int i;
	if (!m_pcResNode || (Visual.bVisible && Visual.nResourceId < 0) || Visual.nPaletteId < 0)
		return FALSE;
	if (SameVisualPart(m_WeaponVisual, Visual))
		return TRUE;

	m_WeaponVisual = Visual;
	for (i = MAX_BODY_PART_SECT * 2; i < MAX_BODY_PART_SECT * 3; ++i)
		m_nPartPalette[i] = Visual.nPaletteId;

	m_nAction = m_pcResNode->GetActNo(m_nDoing, m_WeaponVisual.nResourceId, m_bRideHorse);

	char	szBuffer[80];
	int		nFrame, nDir, nInterval, nCgX, nCgY, nPhiPhongResource;

	if ( m_pcResNode->m_cShadowInfo.GetFile(m_nAction, &nFrame, &nDir, &nInterval, &nCgX, &nCgY, szBuffer) )
	{
		m_cNpcShadow.SetSprFile(szBuffer, nFrame, nDir, nInterval);
		m_cNpcShadow.SetCenterPos(nCgX, nCgY);
	}
	else
	{
		m_cNpcShadow.Release();
	}

	for (i = MAX_BODY_PART_SECT * 0; i < MAX_BODY_PART_SECT * 0 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HelmVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HelmVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	for (i = MAX_BODY_PART_SECT * 1; i < MAX_BODY_PART_SECT * 1 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			// VNG group 1 is the complete body/armor group.
			m_pcResNode->GetFileName(i, m_nAction, m_ArmorVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
			m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_ArmorVisual.nResourceId, 0));
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	for (i = MAX_BODY_PART_SECT * 2; i < MAX_BODY_PART_SECT * 2 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0));

				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer),true);
				m_cNpcEffectImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0,true));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
	}
	// VNG group 3 is Phi Phong.
	for (i = MAX_BODY_PART_SECT * 3; i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			if (m_PhiPhongVisual.bVisible && (IgnoreShowRes() == FALSE))
			{
				nPhiPhongResource = m_PhiPhongVisual.nResourceId;
				m_pcResNode->GetFileName(i, m_nAction, nPhiPhongResource, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, nPhiPhongResource, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	// VNG group 4 is the horse (front/middle/back).
	for (i = MAX_BODY_PART_SECT * 4; i < MAX_BODY_PART_SECT * 4 + MAX_BODY_PART_SECT; i++)
	{
		if (!m_HorseVisual.bVisible || !m_bRideHorse || IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HorseVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HorseVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	return TRUE;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ƥ����
//---------------------------------------------------------------------------
BOOL KNpcRes::SetHorse(const PHONGTHAN_VISUAL_PART& Visual)
{
	if (!m_pcResNode || (Visual.bVisible && Visual.nResourceId < 0) || Visual.nPaletteId < 0)
		return FALSE;
	if (SameVisualPart(m_HorseVisual, Visual))
		return TRUE;

	m_HorseVisual = Visual;
	char szBuffer[80];
	for (int i = MAX_BODY_PART_SECT * 4; i < MAX_BODY_PART_SECT * 5; ++i)
	{
		m_nPartPalette[i] = Visual.nPaletteId;
		if (!Visual.bVisible || !m_bRideHorse || !m_pcResNode->CheckPartExist(i))
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
			continue;
		}
		m_pcResNode->GetFileName(i, m_nAction, Visual.nResourceId, "", szBuffer, sizeof(szBuffer));
		m_cNpcImage[i].SetSprFile(szBuffer,
			m_pcResNode->GetTotalFrames(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetTotalDirs(i, m_nAction, Visual.nResourceId, MAX_PART),
			m_pcResNode->GetInterval(i, m_nAction, Visual.nResourceId, 0));
		m_pcResNode->GetFileName(i, m_nAction, Visual.nResourceId, "", szBuffer, sizeof(szBuffer), true);
		m_cNpcEffectImage[i].SetSprFile(szBuffer,
			m_pcResNode->GetTotalFrames(i, m_nAction, Visual.nResourceId, MAX_PART, true),
			m_pcResNode->GetTotalDirs(i, m_nAction, Visual.nResourceId, MAX_PART, true),
			m_pcResNode->GetInterval(i, m_nAction, Visual.nResourceId, 0, true));
	}
	return TRUE;
}
//---------------------------------------------------------------------------
//	���ܣ�	�趨��������
//---------------------------------------------------------------------------
BOOL	KNpcRes::SetAction(int nDoing)
{
	if (!m_pcResNode)
		return FALSE;
	if (nDoing < 0)
		return FALSE;
	// The logical state alone is not a sufficient cache key. Equipping a
	// mount or weapon can change the VNG action family while nDoing remains
	// stand. In that case the old body can still be bound to *_sit.spr while
	// the horse is already bound to *_rs0.spr.
	const int nResolvedAction = m_pcResNode->GetActNo(
		nDoing, m_WeaponVisual.nResourceId, m_bRideHorse);
	if (m_nDoing == nDoing && m_nAction == nResolvedAction)
		return TRUE;

	m_nDoing = nDoing;
	m_nAction = nResolvedAction;
		
	int		i;
	char	szBuffer[80];
	int		nFrame, nDir, nInterval, nCgX, nCgY, nPhiPhongResource;

	// A small number of original VNG rows reference a death SPR that is not
	// present in any supplied VNG package.  Keep the authoritative table and
	// files untouched; use another original action from the same NPC so the
	// body never vanishes merely because that optional animation is absent.
	if (m_nNpcKind == NPC_RES_NORMAL)
	{
		m_pcResNode->GetFileName(NORMAL_NPC_PART_NO, m_nAction, 0, "", szBuffer, sizeof(szBuffer));
		if (!szBuffer[0] || !g_FileExists(szBuffer))
		{
			int nFallbackAction = m_pcResNode->GetActNo(cdo_hurt, m_WeaponVisual.nResourceId, m_bRideHorse);
			m_pcResNode->GetFileName(NORMAL_NPC_PART_NO, nFallbackAction, 0, "", szBuffer, sizeof(szBuffer));
			if (!szBuffer[0] || !g_FileExists(szBuffer))
				nFallbackAction = m_pcResNode->GetActNo(cdo_stand, m_WeaponVisual.nResourceId, m_bRideHorse);
			m_nAction = nFallbackAction;
		}
	}

	if ( m_pcResNode->m_cShadowInfo.GetFile(m_nAction, &nFrame, &nDir, &nInterval, &nCgX, &nCgY, szBuffer) )
	{
		m_cNpcShadow.SetSprFile(szBuffer, nFrame, nDir, nInterval);
		m_cNpcShadow.SetCenterPos(nCgX, nCgY);
	}
	else
	{
		m_cNpcShadow.Release();
	}

	for (i = MAX_BODY_PART_SECT * 0; i < MAX_BODY_PART_SECT * 0 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HelmVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HelmVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	for (i = MAX_BODY_PART_SECT * 1; i < MAX_BODY_PART_SECT * 1 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i))
		{
			// VNG group 1 is the complete body/armor group.
			m_pcResNode->GetFileName(i, m_nAction, m_ArmorVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
			m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_ArmorVisual.nResourceId, 0));
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	for (i = MAX_BODY_PART_SECT * 2; i < MAX_BODY_PART_SECT * 2 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0));

				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer),true);
				m_cNpcEffectImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0,true));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
	}
	// VNG group 3 is Phi Phong.
	for (i = MAX_BODY_PART_SECT * 3; i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			if (m_PhiPhongVisual.bVisible && (IgnoreShowRes() == FALSE))
			{
				nPhiPhongResource = m_PhiPhongVisual.nResourceId;
				m_pcResNode->GetFileName(i, m_nAction, nPhiPhongResource, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, nPhiPhongResource, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	// VNG group 4 is the horse (front/middle/back).
	// VNG group 4 is the horse (front/middle/back).
	for (i = MAX_BODY_PART_SECT * 4; i < MAX_BODY_PART_SECT * 4 + MAX_BODY_PART_SECT; i++)
	{
		if (!m_HorseVisual.bVisible || !m_bRideHorse || IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HorseVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HorseVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	return TRUE;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨�Ƿ�����
//---------------------------------------------------------------------------
BOOL	KNpcRes::SetRideHorse(BOOL bRideHorse)
{
	if (!m_pcResNode)
		return FALSE;
	const int nResolvedAction = m_pcResNode->GetActNo(
		m_nDoing, m_WeaponVisual.nResourceId, bRideHorse);
	// Special (player) resources are also called from the per-frame update
	// path. The resolved action is part of the cache key: the ride flag may
	// already be true while a resource reload has left the body on *_sit.spr.
	if (m_bRideHorse == bRideHorse && m_nAction == nResolvedAction)
		return TRUE;

	m_bRideHorse = bRideHorse;
	m_nAction = nResolvedAction;

	int		i;
	char	szBuffer[80];
	int		nFrame, nDir, nInterval, nCgX, nCgY, nPhiPhongResource;

	if ( m_pcResNode->m_cShadowInfo.GetFile(m_nAction, &nFrame, &nDir, &nInterval, &nCgX, &nCgY, szBuffer) )
	{
		m_cNpcShadow.SetSprFile(szBuffer, nFrame, nDir, nInterval);
		m_cNpcShadow.SetCenterPos(nCgX, nCgY);
	}
	else
	{
		m_cNpcShadow.Release();
	}

	for (i = MAX_BODY_PART_SECT * 0; i < MAX_BODY_PART_SECT * 0 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HelmVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HelmVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HelmVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	for (i = MAX_BODY_PART_SECT * 1; i < MAX_BODY_PART_SECT * 1 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i))
		{
			// VNG group 1 is the complete body/armor group.
			m_pcResNode->GetFileName(i, m_nAction, m_ArmorVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
			m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_ArmorVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_ArmorVisual.nResourceId, 0));
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	for (i = MAX_BODY_PART_SECT * 2; i < MAX_BODY_PART_SECT * 2 + MAX_BODY_PART_SECT; i++)
	{
		if (IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0));

				m_pcResNode->GetFileName(i, m_nAction, m_WeaponVisual.nResourceId, "", szBuffer, sizeof(szBuffer),true);
				m_cNpcEffectImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetTotalDirs(i, m_nAction, m_WeaponVisual.nResourceId, MAX_PART, true), m_pcResNode->GetInterval(i, m_nAction, m_WeaponVisual.nResourceId, 0,true));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
	}
	for (i = MAX_BODY_PART_SECT * 3; i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT; i++)
	{
		if ( m_pcResNode->CheckPartExist(i) )
		{
			// VNG group 3 is Phi Phong.
			if (m_PhiPhongVisual.bVisible && (IgnoreShowRes() == FALSE))
			{
				nPhiPhongResource = m_PhiPhongVisual.nResourceId;
				m_pcResNode->GetFileName(i, m_nAction, nPhiPhongResource, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, nPhiPhongResource, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, nPhiPhongResource, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
				m_cNpcEffectImage[i].Release();
			}
		}
		else
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
	}
	for (i = MAX_BODY_PART_SECT * 4; i < MAX_BODY_PART_SECT * 4 + MAX_BODY_PART_SECT; i++)
	{
		if (!m_HorseVisual.bVisible || !m_bRideHorse || IgnoreShowRes())
		{
			m_cNpcImage[i].Release();
			m_cNpcEffectImage[i].Release();
		}
		else
		{
			if ( m_pcResNode->CheckPartExist(i) )
			{
				m_pcResNode->GetFileName(i, m_nAction, m_HorseVisual.nResourceId, "", szBuffer, sizeof(szBuffer));
				m_cNpcImage[i].SetSprFile(szBuffer, m_pcResNode->GetTotalFrames(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetTotalDirs(i, m_nAction, m_HorseVisual.nResourceId, MAX_PART), m_pcResNode->GetInterval(i, m_nAction, m_HorseVisual.nResourceId, 0));
			}
			else
			{
				m_cNpcImage[i].Release();
			}
		}
	}
	return TRUE;
}


BOOL	KNpcRes::IgnoreShowRes()
{
	if (!m_pcResNode)
		return FALSE;

	if (m_nNpcKind == NPC_RES_SPECIAL)
	{
		if (!m_bRideHorse && 
			(m_nDoing == cdo_fightstand || 
			m_nDoing == cdo_stand || 
			m_nDoing == cdo_stand1 || 
			m_nDoing == cdo_fightrun || 
			m_nDoing == cdo_walk || 
			m_nDoing == cdo_fightwalk || 
			m_nDoing == cdo_run || 
			m_nDoing == cdo_sit) && 
			(m_pcResNode->GetInterval(5, m_nAction, m_ArmorVisual.nResourceId, 0) > 1))
		{
			return TRUE;
		}
	}

	return FALSE;
}
//---------------------------------------------------------------------------
//	���ܣ�	�趨 npc λ��
//---------------------------------------------------------------------------
void	KNpcRes::SetPos(int nNpcIdx, int x, int y, int z, BOOL bFocus, BOOL bMenu)
{
	if (m_nXposNew == 0 && m_nYposNew == 0 && m_nZposNew == 0)
	{
		m_nXposOld = 0;
		m_nYposOld = 0;
		m_nZposOld = 0;
	}
	else
	{
		m_nXposOld = m_nXposNew + ((x - m_nXposNew)/2);
		m_nYposOld = m_nYposNew + ((y - m_nYposNew)/2);
		m_nZposOld = m_nZposNew + ((z - m_nZposNew)/2);
	}
	
	m_nXposNew = x;
	m_nYposNew = y;
	m_nZposNew = z;
	
 	m_nXpos = x;
	m_nYpos = y;
	m_nZpos = z;

	if (bFocus)
		g_ScenePlace.SetFocusPosition(x, y, z);

	if (!bMenu)
    {
		m_SceneID_NPCIdx = nNpcIdx; 
        g_ScenePlace.MoveObject(CGOG_NPC, nNpcIdx, x, y, z, m_SceneID, IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL | IPOT_RL_LIGHT_PROP);

    }
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨״̬��Ч
//---------------------------------------------------------------------------
void	KNpcRes::SetState(BYTE *pNpcStateList, KNpcResList *pNpcResList)
{
	if ( !pNpcStateList || !pNpcResList)
		return;

	int		i,j, nFind, nFindFlag[MAX_SKILL_STATE];
	//KStateNode	*pNode;
	int		nType, nPlayType, nBackStart, nBackEnd, nTotalFrame, nTotalDir, nInterVal;
	char	szBuffer[80];

	// ������е��Ƿ�Ҫͣ�?
	memset(nFindFlag, 0, sizeof(nFindFlag));

	for (i = 0; i < MAX_SKILL_STATE; i++)
	{
		if(*(pNpcStateList + i))
		{
			for(j = 0; j < MAX_SKILL_STATE; j++)
			{
				if (*(pNpcStateList + i) == m_cStateSpr[j].m_nID)
					nFindFlag[j] = 1;
			}
		}
	}
	for (i = 0; i < MAX_SKILL_STATE; i++)
	{
		if ( !nFindFlag[i] && m_cStateSpr[i].m_nID)
			m_cStateSpr[i].Release();
	}

	for (i = 0; i < MAX_SKILL_STATE; i++)
	{
		if (*(pNpcStateList + i) <= 0)
			continue;
		// ����Ƿ��Ѿ�����?
		nFind = 0;
		for (j = 0; j < MAX_SKILL_STATE; j++)
		{
			if (*(pNpcStateList + i) == m_cStateSpr[j].m_nID)
			{
				nFind = 1;
				break;
			}
		}
		if (nFind > 0)	
			continue;

		szBuffer[0] = 0;
		pNpcResList->m_cStateTable.GetInfo(*(pNpcStateList + i), szBuffer, &nType, &nPlayType, &nBackStart, &nBackEnd, &nTotalFrame, &nTotalDir, &nInterVal);
		if ( !szBuffer[0] )
			continue;

		if (nType < 0 || nType >= STATE_MAGIC_TYPE_NUM)
			continue;

		for (j = nType * (MAX_SKILL_STATE/3); j < nType * (MAX_SKILL_STATE/3) + (MAX_SKILL_STATE/3); j++)
		{
			if (m_cStateSpr[j].m_nID == 0)
			{
				// �����µ�
				m_cStateSpr[j].Release();
				m_cStateSpr[j].m_nID = *(pNpcStateList + i);
				m_cStateSpr[j].m_nType = nType;
				m_cStateSpr[j].m_nPlayType = nPlayType;
				m_cStateSpr[j].m_nBackStart = nBackStart;
				m_cStateSpr[j].m_nBackEnd = nBackEnd;
				m_cStateSpr[j].m_SprContrul.SetSprFile(szBuffer, nTotalFrame, nTotalDir, nInterVal);
				break;
			}
		}
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨�����ֻ����һ�������spr�ļ�
//---------------------------------------------------------------------------
void	KNpcRes::SetSpecialSpr(char *lpszSprName)
{
	KImageParam	sImage;
	g_pRepresent->GetImageParam(lpszSprName, &sImage, ISI_T_SPR);
	if (sImage.nInterval <= 0)
		sImage.nInterval = 1;
	if (sImage.nInterval > 1000)
		sImage.nInterval = 1000;
	if (sImage.nNumFramesGroup <= 0)
		sImage.nNumFramesGroup = 1;
	if (sImage.nNumFrames < sImage.nNumFramesGroup)
		sImage.nNumFrames = sImage.nNumFramesGroup;

	m_cSpecialSpr.SetSprFile(lpszSprName, sImage.nNumFrames, sImage.nNumFramesGroup, (sImage.nNumFrames / sImage.nNumFramesGroup) * sImage.nInterval / 50);
}

//---------------------------------------------------------------------------
//	���ܣ�set menu state spr
//---------------------------------------------------------------------------
void	KNpcRes::SetMenuStateSpr(int nMenuState)
{
	if (nMenuState < PLAYER_MENU_STATE_NORMAL || nMenuState >= PLAYER_MENU_STATE_NUM)
	{
		this->m_cMenuStateSpr.Release();
		return;
	}
	char	szName[80];
	g_NpcResList.m_cMenuState.GetStateSpr(nMenuState, szName);
	if (szName[0])
	{
		KImageParam	sImage;
		g_pRepresent->GetImageParam(szName, &sImage, ISI_T_SPR);
		if (sImage.nInterval <= 0)
			sImage.nInterval = 1;
		if (sImage.nInterval > 1000)
			sImage.nInterval = 1000;
		if (sImage.nNumFramesGroup <= 0)
			sImage.nNumFramesGroup = 1;
		if (sImage.nNumFrames < sImage.nNumFramesGroup)
			sImage.nNumFrames = sImage.nNumFramesGroup;
		m_cMenuStateSpr.SetSprFile(szName, sImage.nNumFrames, sImage.nNumFramesGroup, (sImage.nNumFrames / sImage.nNumFramesGroup) * sImage.nInterval / 50);
	}
	else
	{
		this->m_cMenuStateSpr.Release();
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	��Ӱ�򿪹ر�
//	������	bBlur	if == TRUE  ��  if == FLASE  �ر�
//---------------------------------------------------------------------------
void	KNpcRes::SetBlur(BOOL bBlur)
{
	if (m_nBlurState == bBlur)
		return;

	m_nBlurState = bBlur;
}

void KNpcRes::CreateBlur(int nNpcIdx, int nRange, int nDir)
{
	if(nNpcIdx <= 0 || nRange <= 0)
		return;

	int	nSin = g_DirSin(nDir, 64);
	int	nCos = g_DirCos(nDir, 64);

	int nNo, i, j, nBlurRange = 50, nBlurNum = nRange / nBlurRange;
	if(nBlurNum > MAX_BLUR_FRAME)
	{
		nBlurRange += (nBlurNum - MAX_BLUR_FRAME) * nBlurRange / MAX_BLUR_FRAME;
		nBlurNum = MAX_BLUR_FRAME;
	}
	for (nNo = 0; nNo < nBlurNum +1; nNo++)
	{
		int		nScreenX = m_nXpos + ((nCos * nNo * nBlurRange) >> 10);
		int		nScreenY = m_nYpos + ((nSin * nNo * nBlurRange) >> 10);
		int		nScreenZ = m_nZpos;

		//m_cNpcBlur.ClearCurNo();
		for (i = 0, j = 0; i < MAX_PART; i++)
		{
			if (m_nSortTable[i] >= 0 && m_nSortTable[i] < MAX_PART)
			{
				m_cNpcBlur.SetFile(j, m_cNpcImage[m_nSortTable[i]].m_szName, m_cNpcImage[m_nSortTable[i]].m_dwNameID, m_cNpcImage[m_nSortTable[i]].m_nCurFrame, nScreenX, nScreenY, nScreenZ, START_BLUR_ALPHA + nNo * BLUR_ALPHA_CHANGE);
				j++;
			}
		}
		m_cNpcBlur.SetMapPos(nScreenX, nScreenY, m_nZpos, nNpcIdx);
		m_cNpcBlur.SetNextNo();
	}
}
//---------------------------------------------------------------------------
//	���ܣ�	��õ�ǰ��������Ч�ļ���?
//---------------------------------------------------------------------------
void	KNpcRes::GetSoundName()
{
	if (m_pcResNode)
		m_pcResNode->GetActionSoundName(this->m_nAction, this->m_szSoundName);
}

//---------------------------------------------------------------------------
//	���ܣ�	���ŵ�ǰ��������Ч
//---------------------------------------------------------------------------
void	KNpcRes::PlaySound(int nX, int nY)
{
	if (!m_szSoundName[0])
		return;

	int		nCenterX = 0, nCenterY = 0, nCenterZ = 0;

	// �����Ļ���ĵ�ĵ�ͼ���� not end
	g_ScenePlace.GetFocusPosition(nCenterX, nCenterY, nCenterZ);

	m_pSoundNode = (KCacheNode*) g_SoundCache.GetNode(m_szSoundName, (KCacheNode*)m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		if (m_pWave->IsPlaying())
			return;
		int nVol = -(abs(nX - nCenterX) + abs(nY - nCenterY));
		m_pWave->Play((nX - nCenterX) * 5,  GetSndVolume(nVol), 0);
	}
}

int	KNpcRes::GetSndVolume(int nVol)
{
	return (10000 + nVol) * Option.GetSndVolume() / 100 - 10000;
}

void	KNpcRes::StopSound()
{
	m_pSoundNode = (KCacheNode*)g_SoundCache.GetNode(m_szSoundName, (KCacheNode*)m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		m_pWave->Stop();
	}
}
//---------------------------------------------------------------------------
//	���ܣ��趨ͷ��״̬
//---------------------------------------------------------------------------
void	KNpcRes::SetMenuState(int nState, char *lpszSentence, int nSentenceLength)
{
	if (nState < PLAYER_MENU_STATE_NORMAL || nState >= PLAYER_MENU_STATE_NUM)
		return;

	if (nState != m_nMenuState)
	{
		m_nBackMenuState = m_nMenuState;
		//strcpy(m_szBackSentence, m_szSentence);
		m_nMenuState = nState;
	}

	if (nSentenceLength > 0 && lpszSentence)
	{
		if (nSentenceLength >= MAX_SENTENCE_LENGTH)
			nSentenceLength = MAX_SENTENCE_LENGTH - 1;
		//memcpy(m_szSentence, lpszSentence, nSentenceLength);
		//m_szSentence[nSentenceLength] = 0;
	}
	else
	{
		//m_szSentence[0] = 0;
	}

	if (!m_nSleepState)
		SetMenuStateSpr(m_nMenuState);
}

//---------------------------------------------------------------------------
//	���ܣ����ͷ��״�?
//---------------------------------------------------------------------------
int		KNpcRes::GetMenuState()
{
	if (m_nSleepState)
		return m_nSleepState;
	return this->m_nMenuState;
}

//---------------------------------------------------------------------------
//	���ܣ��趨˯��״̬
//---------------------------------------------------------------------------
void	KNpcRes::SetSleepState(BOOL bFlag)
{
	if (bFlag)
	{
		m_nSleepState = PLAYER_MENU_STATE_IDLE;
		SetMenuStateSpr(m_nSleepState);
	}
	else
	{
		m_nSleepState = 0;
		if (m_nMenuState)
		{
			SetMenuStateSpr(m_nMenuState);
		}
		else
		{
			SetMenuStateSpr(PLAYER_MENU_STATE_NORMAL);
		}
	}
}

//---------------------------------------------------------------------------
//	���ܣ����˯��״�?
//---------------------------------------------------------------------------
BOOL	KNpcRes::GetSleepState()
{
	return (m_nSleepState ? 1 : 0);
}

//---------------------------------------------------------------------------
//	���ܣ�����npc�ı߿�(3Dģʽ�и�Ϊ����)
//---------------------------------------------------------------------------
void	KNpcRes::DrawBorder()
{
	if (!m_pcResNode)
		return;
	int		i, nPos = 0;

	for (i = 0; i < MAX_PART; i++)
	{
		if (m_nSortTable[i] >= 0 && m_nSortTable[i] < MAX_PART)
		{
			strcpy(m_cDrawFile[nPos].szImage, m_cNpcImage[m_nSortTable[i]].m_szName);
			m_cDrawFile[nPos].uImage = m_cNpcImage[m_nSortTable[i]].m_dwNameID;
			m_cDrawFile[nPos].nFrame = m_cNpcImage[m_nSortTable[i]].m_nCurFrame;
			m_cDrawFile[nPos].oPosition.nX = m_nXpos;
			m_cDrawFile[nPos].oPosition.nY = m_nYpos;
			m_cDrawFile[nPos].oPosition.nZ = m_nZpos;
			m_cDrawFile[nPos].bRenderStyle = IMAGE_RENDER_STYLE_BORDER;
			nPos++;
		}
	}
	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, FALSE);
	for (i = 0; i < nPos; i++)
		m_cDrawFile[i].bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	nPos = 0;
}

//��ָ���߶Ȼ���ͷ��״̬
int	KNpcRes::DrawMenuState(int nHeightOffset)
{
	int		nScreenX = m_nXpos, nScreenY = m_nYpos, nScreenZ = 0;

	if (!m_pcResNode)
		return nHeightOffset;
	// ͷ��״̬��Ч
	//int i;
	//for ( i = 0; i < MAX_SKILL_STATE; i++)
	//{
	//	if (m_cStateSpr[i].m_nID)
	//	{
	//		return nHeightOffset;	//��ͷ����Чʱ�����ƽ��׵�״̬
	//	}
	//}

	int nPos = 0;
	nHeightOffset += 10;
	// MenuState
	if (m_cMenuStateSpr.m_szName[0])
	{
		m_cMenuStateSpr.GetNextFrame();

		strcpy(m_cDrawFile[nPos].szImage, m_cMenuStateSpr.m_szName);
		m_cDrawFile[nPos].uImage = m_cMenuStateSpr.m_dwNameID;
		m_cDrawFile[nPos].nFrame = m_cMenuStateSpr.m_nCurFrame;
		m_cDrawFile[nPos].oPosition.nX = nScreenX;
		m_cDrawFile[nPos].oPosition.nY = nScreenY;
		m_cDrawFile[nPos].oPosition.nZ = nScreenZ + nHeightOffset;
		nPos++;
	}
	if (nPos > 0)
		g_pRepresent->DrawPrimitives(nPos, m_cDrawFile, RU_T_IMAGE, false);

	return nHeightOffset;
}

//---------------------------------------------------------------------------
//	���ܣ�����֡��ת�����߼�����(0 - 63)
//---------------------------------------------------------------------------
int		KNpcRes::GetNormalNpcStandDir(int nFrame)
{
	if (!m_pcResNode)
		return 0;

	int nTotalFrames = m_pcResNode->GetTotalFrames(NORMAL_NPC_PART_NO, cdo_stand, m_HelmVisual.nResourceId, MAX_PART);
	if (nTotalFrames <= 0)
		return 0;

	nFrame %= nTotalFrames;

	return (MAX_NPC_DIR * nFrame) / nTotalFrames;
}


//---------------------------------------------------------------------------
//	���ܣ�	���캯��
//---------------------------------------------------------------------------
KStateSpr::KStateSpr()
{
	Release();
}

//---------------------------------------------------------------------------
//	���ܣ�	��գ���ʼ��?
//---------------------------------------------------------------------------
void	KStateSpr::Release()
{
	m_nID = 0;
	m_nType = 0;
	m_nPlayType = 0;
	m_nBackStart = 0;
	m_nBackEnd = 0;
	m_SprContrul.Release();
}

//---------------------------------------------------------------------------
//	���ܣ�	���캯��
//---------------------------------------------------------------------------
KNpcBlur::KNpcBlur()
{
	m_nActive = 0;
	m_nCurNo = 0;
	m_dwInterval = 3;
	m_dwTimer = 0;
}

//---------------------------------------------------------------------------
//	���ܣ�	��������
//---------------------------------------------------------------------------
KNpcBlur::~KNpcBlur()
{
    //Remove();
}


//---------------------------------------------------------------------------
//	���ܣ�	��ǰ���ָ��ָ����һ��?�ܹ�7����ָ��ѭ��)
//---------------------------------------------------------------------------
void	KNpcBlur::SetNextNo()
{
	m_nCurNo++;
	if (m_nCurNo >= MAX_BLUR_FRAME)
		m_nCurNo = 0;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ��Ӱ֡��ͼ����
//---------------------------------------------------------------------------
void	KNpcBlur::SetMapPos(int x, int y, int z, int nNpcIdx)
{
	m_nMapXpos[m_nCurNo] = x;
	m_nMapYpos[m_nCurNo] = y;
	m_nMapZpos[m_nCurNo] = z;
    m_SceneIDNpcIdx[m_nCurNo] = nNpcIdx;
	g_ScenePlace.MoveObject(CGOG_NPC_BLUR_DETAIL(m_nCurNo), nNpcIdx, x, y, z, m_SceneID[m_nCurNo]);
}

//---------------------------------------------------------------------------
//	���ܣ�	�ı�alpha��
//---------------------------------------------------------------------------
void	KNpcBlur::ChangeAlpha()
{
	if (m_nActive == 0)
		return;

	int		i, j;
	for (i = 0; i < MAX_BLUR_FRAME; i++)
	{
		for (j = 0; j < MAX_PART; j++)
		{
			if (m_Blur[i][j].Color.Color_b.a)
			{
				m_Blur[i][j].oPosition.nX = m_nMapXpos[i];
				m_Blur[i][j].oPosition.nY = m_nMapYpos[i];
				m_Blur[i][j].oPosition.nZ = m_nMapZpos[i];
			}
		}
	}

	m_dwTimer++;
	if (m_dwTimer < m_dwInterval)
		return;
	m_dwTimer = 0;

	m_nActive = 0;
	for (i = 0; i < MAX_BLUR_FRAME; i++)
	{
		for (j = 0; j < MAX_PART; j++)
		{
			if (m_Blur[i][j].Color.Color_b.a)
			{
				if (m_Blur[i][j].Color.Color_b.a > BLUR_ALPHA_CHANGE)
					m_Blur[i][j].Color.Color_b.a -= BLUR_ALPHA_CHANGE;
				else
					m_Blur[i][j].Color.Color_b.a = 0;
				m_nActive = 1;
			}
		}
	}
	if (m_nActive == 0)
	{
		Remove();
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	��յ�ǰָ��ָ�������
//---------------------------------------------------------------------------
void	KNpcBlur::ClearCurNo()
{
	for (int i = 0; i < MAX_PART; i++)
	{
		m_Blur[m_nCurNo][i].Color.Color_b.a = 0;
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰĳһ�������?
//---------------------------------------------------------------------------
void	KNpcBlur::SetFile(int nNo, char *lpszFileName, int nSprID, int nFrameNo, int nXpos, int nYpos, int nZpos, int nBlurAlpha/* = START_BLUR_ALPHA*/)
{
	if (nNo < 0 || nNo >= MAX_PART)
		return;
	if (!lpszFileName)
		return;
	strcpy(m_Blur[m_nCurNo][nNo].szImage, lpszFileName);
	m_Blur[m_nCurNo][nNo].uImage = nSprID;
	m_Blur[m_nCurNo][nNo].nFrame = nFrameNo;
	m_Blur[m_nCurNo][nNo].oPosition.nX = nXpos;
	m_Blur[m_nCurNo][nNo].oPosition.nY = nYpos;
	m_Blur[m_nCurNo][nNo].oPosition.nZ = nZpos;
	m_Blur[m_nCurNo][nNo].Color.Color_b.a = nBlurAlpha;
	m_nActive = 1;
}

//---------------------------------------------------------------------------
//	���ܣ�	���Ʋ�Ӱ
//---------------------------------------------------------------------------
void	KNpcBlur::Draw(int nIdx)
{
	if (m_nActive == 0)
		return;

	g_pRepresent->DrawPrimitives(MAX_PART, m_Blur[nIdx], RU_T_IMAGE, FALSE);
}

//---------------------------------------------------------------------------
//	���ܣ�	����ʱ���ж��Ƿ�ȡ��Ӱ
//---------------------------------------------------------------------------
BOOL	KNpcBlur::NowGetBlur()
{
	if (m_dwTimer == 0)
		return TRUE;
	return FALSE;
}

BOOL	KNpcBlur::Init()
{
	for (int i = 0; i < MAX_BLUR_FRAME; i++)
	{
		for (int j = 0; j < MAX_PART; j++)
		{
			m_Blur[i][j].nType = ISI_T_SPR;
			m_Blur[i][j].uImage = 0;
			m_Blur[i][j].nISPosition = IMAGE_IS_POSITION_INIT;
			m_Blur[i][j].bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		}
	}
	return TRUE;
}

void	KNpcBlur::Remove()
{
	m_nCurNo = 0;
	for (int i = 0; i < MAX_BLUR_FRAME; i++)
	{
		if (m_SceneID[i])
		{
			g_ScenePlace.RemoveObject(CGOG_NPC_BLUR_DETAIL(i), m_SceneIDNpcIdx[i], m_SceneID[i]);
			m_SceneID[i] = 0;
		}
	}
}

#endif
