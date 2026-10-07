//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KNpcResNode.cpp
// Date:	2002.01.06
// Code:	�߳�����
// Desc:	Obj Class
//---------------------------------------------------------------------------
#include "KCore.h"
#include "../../Engine/Src/KSG_StringProcess.h"

#ifndef _SERVER

#include	"KSprControl.h"
#include	"KTabFile.h"
#include	"KIniFile.h"
#include	"KFilePath.h"
//#include	"KStrBase.h"
#include	"KNpcResNode.h"
#include	"CoreUseNameDef.h"
#include	"../../Represent/iRepresent/iRepresentShell.h"
#include	"../../Represent/iRepresent/KRepresentUnit.h"
#include	"ImgRef.h"

#define	MAX_SORT_DIR			16

// CLIENTACTION has 14 runtime states, while the original VNG equipment
// mapping tables expose only these eight style columns:
// stand, sit, fight-stand, run, attack, hurt, death, give.
// Never use CLIENTACTION directly as a table column: doing so maps stand to
// sit and desynchronizes the rider/horse animations.
static int GetPhongThanStyleColumn(int nDoing)
{
	switch (nDoing)
	{
	case cdo_fightstand:
		return 2;
	case cdo_stand:
	case cdo_stand1:
		return 0;
	case cdo_fightwalk:
	case cdo_walk:
	case cdo_fightrun:
	case cdo_run:
	case cdo_jump:
		return 3;
	case cdo_attack:
	case cdo_attack1:
	case cdo_magic:
		return 4;
	case cdo_hurt:
		return 5;
	case cdo_death:
		return 6;
	case cdo_sit:
		return 1;
	default:
		return 0;
	}
}

static int GetPhongThanFallbackAction(int nStyle, BOOL bRideHorse)
{
	if (bRideHorse)
	{
		switch (nStyle)
		{
		case 3: return 19; // rr0
		case 4: return 22; // ra0
		case 5: return 25; // rb0
		case 6: return 28; // rdi
		case 7: return 29; // rgv
		default: return 16; // rs0; VNG has no mounted-sit action
		}
	}

	switch (nStyle)
	{
	case 1: return 1;
	case 2: return 2;
	case 3: return 5;
	case 4: return 8;
	case 5: return 11;
	case 6: return 14;
	case 7: return 15;
	default: return 0;
	}
}

// VNG resources are authoritative, but some extracted packages omit the
// companion SPR metadata table.  Read the metadata from the original SPR so
// a missing sidecar never drops the whole equipment component.
static void GetSprInfoFromAsset(const char *pszSprName, int *pnFrames,
	int *pnDirs, int *pnInterval)
{
	if (!pnFrames || !pnDirs || !pnInterval)
		return;
	*pnFrames = 16;
	*pnDirs = 16;
	*pnInterval = 0;
	if (!pszSprName || !pszSprName[0] || !g_pRepresent)
		return;
	KImageParam sImage;
	memset(&sImage, 0, sizeof(sImage));
	if (g_pRepresent->GetImageParam(pszSprName, &sImage, ISI_T_SPR))
	{
		if (sImage.nNumFrames > 0)
			*pnFrames = sImage.nNumFrames;
		if (sImage.nNumFramesGroup > 0)
			*pnDirs = sImage.nNumFramesGroup;
		// Some original VNG mount parts (notably the large jsx08 set) store
		// all eight directions but incorrectly report Directions=1.
		if (strstr(pszSprName, "npcres\\human") &&
			*pnFrames >= 8 && (*pnFrames % 8) == 0)
			*pnDirs = 8;
		*pnInterval = sImage.nInterval;
	}
}


KNpcResNode::KNpcResNode()
{
	m_nNpcKind = NPC_RES_NORMAL;
	m_nPartNum = 1;
	m_szNpcName[0] = 0;
	m_szResPath[0] = 0;
	memset(m_szSoundName, 0, sizeof(m_szSoundName));
}

KNpcResNode::~KNpcResNode()
{
}

BOOL	KNpcResNode::Init(char *lpszNpcName, CActionName *cActionName, CActionName *cNpcAction)
{
	if (lpszNpcName == NULL || lpszNpcName[0] == 0)
		return FALSE;

	KTabFile	KindFile;
	int			i, j, k, nFindNo;
	char		szBuffer[FILE_NAME_LENGTH], szTemp[FILE_NAME_LENGTH], szEfTemp[FILE_NAME_LENGTH], szBuf[FILE_NAME_LENGTH];
    const char *pcszTemp = NULL;

	strcpy(m_szNpcName, lpszNpcName);
	// �����ļ� ��������.txt
//	g_SetFilePath(RES_INI_FILE_PATH);
	if ( !KindFile.Load(NPC_RES_KIND_FILE_NAME) )
		return FALSE;
	nFindNo = KindFile.FindRow(lpszNpcName);
	if (nFindNo < 0)
		return FALSE;
	KindFile.GetString(nFindNo, KIND_NAME_SECT, "", szBuffer, sizeof(szBuffer));
	if (!szBuffer[0])
		KindFile.GetString(nFindNo, 2, "", szBuffer, sizeof(szBuffer));

	// �ж�npc����
	if (strcmp(szBuffer, KIND_NAME_SPECIAL) == 0 ||
		strcmp(szBuffer, "\xCC\xD8\xCA\xE2npc") == 0)
		m_nNpcKind = NPC_RES_SPECIAL;
	else
		m_nNpcKind = NPC_RES_NORMAL;
	// �õ���Դ�ļ�·��
	KindFile.GetString(nFindNo, KIND_FILE_SECT5, "", m_szResPath, sizeof(m_szResPath));
	if (!m_szResPath[0])
		KindFile.GetString(nFindNo, 3, "", m_szResPath, sizeof(m_szResPath));

	// ����npc
	if (m_nNpcKind == NPC_RES_SPECIAL)
	{
		KTabFile	PartFile, SoundName, ShadowName;
		// �õ�����˵���ļ���
		KindFile.GetString(nFindNo, KIND_FILE_SECT1, "", szBuffer, sizeof(szBuffer));
		if (!szBuffer[0])
			KindFile.GetString(nFindNo, 4, "", szBuffer, sizeof(szBuffer));
		if ( !szBuffer[0] )
			return FALSE;
//		g_SetFilePath(RES_INI_FILE_PATH);
		g_UnitePathAndName(RES_INI_FILE_PATH, szBuffer, szBuf);
		if ( !PartFile.Load(szBuf) )
			return FALSE;
		// �õ�����������?
		m_nPartNum = 0;
		for (i = 0; i < MAX_BODY_PART; i++)
		{
			for (j = 0; j < MAX_BODY_PART_SECT; j++)
			{
				m_nSectInfo[i * MAX_BODY_PART_SECT + j].Clear();
				PartFile.GetString(
					i + 2,
					j + 3,
					"",
					m_nSectInfo[i * MAX_BODY_PART_SECT + j].szSectName,
					sizeof(m_nSectInfo[i * MAX_BODY_PART_SECT + j].szSectName));
				if ( m_nSectInfo[i * MAX_BODY_PART_SECT + j].szSectName[0] )
				{
					m_nSectInfo[i * MAX_BODY_PART_SECT + j].nFlag = 1;
					m_nPartNum++;
				}
			}
		}
		// �õ�ÿ����������Դ˵���ļ���
		for (i = 0; i < MAX_PART; i++)
		{
			if (m_nSectInfo[i].nFlag)
			{
				KindFile.GetString(
					nFindNo,
					m_nSectInfo[i].szSectName,
					"",
					m_nSectInfo[i].szSectResName,
					sizeof(m_nSectInfo[i].szSectResName));
				// ��Դ��Ϣ˵���ļ�������Դ˵���ļ�������SPR_INFO_NAME������Ϣ����
				if (m_nSectInfo[i].szSectResName[0])
				{
					g_StrCpyLen(
						m_nSectInfo[i].szSectEffectName, 
						m_nSectInfo[i].szSectResName, 
						g_StrLen(m_nSectInfo[i].szSectResName) - 3
						);
					g_StrCat(m_nSectInfo[i].szSectEffectName, SPR_EFFECT_NAME);
					g_StrCat(m_nSectInfo[i].szSectEffectName, ".txt");

					g_StrCpyLen(
						m_nSectInfo[i].szSectSprInfoName, 
						m_nSectInfo[i].szSectResName, 
						g_StrLen(m_nSectInfo[i].szSectResName) - 3
						);
					g_StrCat(m_nSectInfo[i].szSectSprInfoName, SPR_INFO_NAME);
					g_StrCat(m_nSectInfo[i].szSectSprInfoName, ".txt");

					g_StrCpyLen(
						m_nSectInfo[i].szSectEffectInfoName, 
						m_nSectInfo[i].szSectSprInfoName, 
						g_StrLen(m_nSectInfo[i].szSectSprInfoName) - 3
						);
					g_StrCat(m_nSectInfo[i].szSectEffectInfoName, SPR_EFFECT_NAME);
					g_StrCat(m_nSectInfo[i].szSectEffectInfoName, ".txt");
				}
			}
		}
		// �õ�ÿ�������ľ������Դ�ļ���?
		KTabFile	SectFile, SectEffectFile, SectInfoFile, SectEffectInfoFile;
		int			nGetEquipNo, nActionCount;
		for (i = 0; i < MAX_PART; i++)
		{
			m_cResInfo[i].AutoDelete();
			if (m_nSectInfo[i].nFlag)
			{
				// KTabFile::Load() leaves the previous table in memory when the
				// requested file is missing.  Clear all optional tables before
				// loading a new component so one missing VNG sidecar cannot reuse
				// metadata from the preceding component.
				SectInfoFile.Clear();
				SectEffectFile.Clear();
				SectEffectInfoFile.Clear();
				BOOL bSectInfoLoaded = FALSE;
				BOOL bSectEffectLoaded = FALSE;
				BOOL bSectEffectInfoLoaded = FALSE;
//				g_SetFilePath(RES_INI_FILE_PATH);

#ifdef TOOLVERSION					
				g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectResName, szBuf);
				if (!SectFile.Load(szBuf))
					continue;
				else
				{
					g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectSprInfoName, szBuf);
					bSectInfoLoaded = SectInfoFile.Load(szBuf);
					if(i >= MAX_BODY_PART_SECT * 2 && i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT)
					{
						g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectEffectName, szBuf);
						bSectEffectLoaded = SectEffectFile.Load(szBuf);
						g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectEffectInfoName, szBuf);
						bSectEffectInfoLoaded = SectEffectInfoFile.Load(szBuf);
					}
				}
#else
				g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectResName, szBuf);
				if ( !SectFile.Load(szBuf) )
					continue;
				g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectSprInfoName, szBuf);
				// The SPR info table is optional for the VNG assets.  The SPR
				// itself remains authoritative and is queried below when this
				// companion table is absent.
				bSectInfoLoaded = SectInfoFile.Load(szBuf);
				if(i >= MAX_BODY_PART_SECT * 2 && i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT)
				{
					g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectEffectName, szBuf);
					bSectEffectLoaded = SectEffectFile.Load(szBuf);
					g_UnitePathAndName(RES_INI_FILE_PATH, m_nSectInfo[i].szSectEffectInfoName, szBuf);
					bSectEffectInfoLoaded = SectEffectInfoFile.Load(szBuf);
				}
#endif

				nGetEquipNo = SectFile.GetHeight() - 1;
				if (nGetEquipNo <= 0)
					continue;
				nActionCount = cActionName->GetActionCount();
				if (nActionCount <= 0)
					continue;
				m_cResInfo[i].AutoNew(nActionCount, nGetEquipNo);
				for (j = 0; j < nGetEquipNo; j++)
				{
					for (k = 0; k < nActionCount; k++)
					{
						// ���ַ����Ƚ�̫��������ֱ���ñ�ţ����Ǳ�����뱣֤������
//						cActionName->GetActionName(k, szBuffer, sizeof(szBuffer));
//						SectFile.GetString(
//							j + 2,
//							szBuffer,
//							"",
//							szTemp,
//							80);
						SectFile.GetString(
							j + 2,
							k + 2,
							"",
							szTemp,
							sizeof(szTemp));
						ComposePathAndName(m_cResInfo[i].m_cSprInfo[j * nActionCount + k].szFileName, m_szResPath, szTemp);
						int nFrames = 0, nDirs = 0, nInterval = 0;
						if (bSectInfoLoaded && SectInfoFile.GetString(
							j + 2,
							k + 2,
							"",
							szTemp,
							sizeof(szTemp)))
						{
							pcszTemp = szTemp;
							nFrames = KSG_StringGetInt(&pcszTemp, 0);
							KSG_StringSkipSymbol(&pcszTemp, ',');
							nDirs = KSG_StringGetInt(&pcszTemp, 0);
							KSG_StringSkipSymbol(&pcszTemp, ',');
							nInterval = KSG_StringGetInt(&pcszTemp, 0);
						}
						// VNG SPR files contain their own frame/direction data.  Use
						// it whenever the sidecar is absent or incomplete.
						if (nFrames <= 0 || nDirs <= 0)
							GetSprInfoFromAsset(m_cResInfo[i].m_cSprInfo[j * nActionCount + k].szFileName, &nFrames, &nDirs, &nInterval);
						if (nFrames <= 0)
							nFrames = 1;
						if (nDirs <= 0)
							nDirs = 1;
						m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nTotalFrames = nFrames;
						m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nTotalDirs = nDirs;
						m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nInterval = nInterval;

						if(i >= MAX_BODY_PART_SECT * 2 && i < MAX_BODY_PART_SECT * 3 + MAX_BODY_PART_SECT)
						{
							if (bSectEffectLoaded)
								SectEffectFile.GetString(
									j + 2,
									k + 2,
									"",
									szEfTemp,
									sizeof(szEfTemp));
							else
								szEfTemp[0] = 0;
							ComposePathAndName(m_cResInfo[i].m_cSprInfo[j * nActionCount + k].szEffectFileName, m_szResPath, szEfTemp);
							if(m_cResInfo[i].m_cSprInfo[j * nActionCount + k].szEffectFileName[0])
							{
								int nEffectFrames = 0, nEffectDirs = 0, nEffectInterval = 0;
								if (bSectEffectInfoLoaded && SectEffectInfoFile.GetString(
									j + 2,
									k + 2,
									"",
									szEfTemp,
									sizeof(szEfTemp)))
								{
									pcszTemp = szEfTemp;
									nEffectFrames = KSG_StringGetInt(&pcszTemp, 0);
									KSG_StringSkipSymbol(&pcszTemp, ',');
									nEffectDirs = KSG_StringGetInt(&pcszTemp, 0);
									KSG_StringSkipSymbol(&pcszTemp, ',');
									nEffectInterval = KSG_StringGetInt(&pcszTemp, 0);
								}
								if (nEffectFrames <= 0 || nEffectDirs <= 0)
									GetSprInfoFromAsset(m_cResInfo[i].m_cSprInfo[j * nActionCount + k].szEffectFileName, &nEffectFrames, &nEffectDirs, &nEffectInterval);
								m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nTotalEffectFrames = nEffectFrames > 0 ? nEffectFrames : 1;
								m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nTotalEffectDirs = nEffectDirs > 0 ? nEffectDirs : 1;
								m_cResInfo[i].m_cSprInfo[j * nActionCount + k].nEffectInterval = nEffectInterval;
							}
						}
					}
				}
			}
		}
		// �õ�������Ϊ�������ļ���
		KTabFile	NoHorseFile, OnHorseFile;
		int			nTableWidth, nTableHeight, nGetNo;
		char	szNoHorseTableName[80], szOnHorseTableName[80];
		KindFile.GetString(nFindNo, KIND_FILE_SECT2, "", szNoHorseTableName, sizeof(szNoHorseTableName));
		KindFile.GetString(nFindNo, KIND_FILE_SECT3, "", szOnHorseTableName, sizeof(szOnHorseTableName));
		if (!szNoHorseTableName[0])
			KindFile.GetString(nFindNo, 5, "", szNoHorseTableName, sizeof(szNoHorseTableName));
		if (!szOnHorseTableName[0])
			KindFile.GetString(nFindNo, 6, "", szOnHorseTableName, sizeof(szOnHorseTableName));
		// δ������Ӧ��
		if (szNoHorseTableName[0])
		{
//			g_SetFilePath(RES_INI_FILE_PATH);
			g_UnitePathAndName(RES_INI_FILE_PATH, szNoHorseTableName, szBuf);
			if ( NoHorseFile.Load(szBuf) )
			{
				nTableWidth = NoHorseFile.GetWidth() - 1;
				nTableHeight = NoHorseFile.GetHeight() - 1;
				m_NoHorseTable.AutoNew(nTableWidth, nTableHeight);
				for (i = 0; i < nTableHeight; i++)
				{
					for (j = 0; j < nTableWidth; j++)
					{
						NoHorseFile.GetString(i + 2, j + 2, "", szBuffer, sizeof(szBuffer));
						nGetNo = cActionName->GetActionNo(szBuffer);
						m_NoHorseTable.SetValue(j, i, nGetNo);
					}
				}
			}
		}
		// ������Ӧ��
		if (szOnHorseTableName[0])
		{
//			g_SetFilePath(RES_INI_FILE_PATH);
			g_UnitePathAndName(RES_INI_FILE_PATH, szOnHorseTableName, szBuf);
			if ( OnHorseFile.Load(szBuf) )
			{
				nTableWidth = OnHorseFile.GetWidth() - 1;
				nTableHeight = OnHorseFile.GetHeight() - 1;
				m_OnHorseTable.AutoNew(nTableWidth, nTableHeight);
				for (i = 0; i < nTableHeight; i++)
				{
					for (j = 0; j < nTableWidth; j++)
					{
						OnHorseFile.GetString(i + 2, j + 2, "", szBuffer, sizeof(szBuffer));
						nGetNo = cActionName->GetActionNo(szBuffer);
						m_OnHorseTable.SetValue(j, i, nGetNo);
					}
				}
			}
		}
		// �õ���ͼ˳����ļ���?
		KindFile.GetString(nFindNo, KIND_FILE_SECT4, "", szBuffer, sizeof(szBuffer));
		if (!szBuffer[0])
			KindFile.GetString(nFindNo, 7, "", szBuffer, sizeof(szBuffer));
		if (szBuffer[0])
		{
			strcpy(m_cSortTable.m_sSortTableFileName, szBuffer);
			m_cSortTable.GetTable(szBuffer, cActionName, m_nPartNum);
		}

		// ��ö�����Ӱ�ļ����?
		int		nFindNo;
//		g_SetFilePath(RES_INI_FILE_PATH);
		nActionCount = cActionName->GetActionCount();
		this->m_cShadowInfo.Init(nActionCount);
		ShadowName.Load(PLAYER_RES_SHADOW_FILE);
		nFindNo = ShadowName.FindRow(lpszNpcName);
		if (nFindNo > 0 && nActionCount > 0)
		{
			for (i = 0; i < nActionCount; i++)
			{
				ShadowName.GetString(nFindNo, 2 + i * 2, "", szTemp, sizeof(szTemp));
				if (szTemp[0])
					this->ComposePathAndName(m_cShadowInfo.m_psInfo[i].m_szName, m_szResPath, szTemp);
				ShadowName.GetString(nFindNo, 2 + i * 2 + 1, "16,8,1", szTemp, sizeof(szTemp));
				
                pcszTemp = szTemp;
                m_cShadowInfo.m_psInfo[i].m_nTotalFrame = KSG_StringGetInt(&pcszTemp, 16);
                KSG_StringSkipSymbol(&pcszTemp, ',');
                m_cShadowInfo.m_psInfo[i].m_nTotalDir = KSG_StringGetInt(&pcszTemp, 8);
                KSG_StringSkipSymbol(&pcszTemp, ',');
                m_cShadowInfo.m_psInfo[i].m_nInterval = KSG_StringGetInt(&pcszTemp, 1);
                //sscanf(szTemp, "%d,%d,%d", &m_cShadowInfo.m_psInfo[i].m_nTotalFrame, &m_cShadowInfo.m_psInfo[i].m_nTotalDir, &m_cShadowInfo.m_psInfo[i].m_nInterval);

				m_cShadowInfo.m_psInfo[i].m_nCgX = SPR_X_OFF;
				m_cShadowInfo.m_psInfo[i].m_nCgY = SPR_Y_OFF;
			}
		}

		// ��ö�����Ч�ļ���?
//		g_SetFilePath(RES_INI_FILE_PATH);
		SoundName.Load(PLAYER_SOUND_FILE);
		nFindNo = SoundName.FindColumn(lpszNpcName);
		nActionCount = cActionName->GetActionCount();
		if (nFindNo > 0 && nActionCount > 0)
		{
			for (i = 0; i < nActionCount; i++)
			{
				SoundName.GetString(i + 2, nFindNo, "", szTemp, sizeof(szTemp));
				if (szTemp[0])
					this->ComposePathAndName(this->m_szSoundName[i], RES_SOUND_FILE_PATH, szTemp);
			}
		}

	}
	// ��ͨnpc
	else if (m_nNpcKind == NPC_RES_NORMAL)
	{
		int			nActionCount;
		KTabFile	NormalNpc, NormalNpcSprInfo, SoundName;

		for (i = 0; i < MAX_PART; i++)
			m_nSectInfo[i].nFlag = 0;
		m_nSectInfo[NORMAL_NPC_PART_NO].nFlag = 1;
		m_nPartNum = 1;

		for (i = 0; i < MAX_PART; i++)
			m_cResInfo[i].AutoDelete();
		nActionCount = cNpcAction->GetActionCount();
		if (nActionCount < 0)
			nActionCount = 0;
		m_cResInfo[NORMAL_NPC_PART_NO].AutoNew(nActionCount, 1);
		this->m_cShadowInfo.Init(nActionCount);

//		g_SetFilePath(RES_INI_FILE_PATH);
		if ( !NormalNpc.Load(NPC_NORMAL_RES_FILE))
			return FALSE;
		// ������Ϣ�ļ�û��û�б�Ҫ��ʼ�����ɹ�������û��If(!) return FALSE;
		NormalNpcSprInfo.Load(NPC_NORMAL_SPRINFO_FILE);
		SoundName.Load(NPC_SOUND_FILE);
		nFindNo = NormalNpc.FindRow(lpszNpcName);
		if (nFindNo < 0)
			return FALSE;

		for (i = 0; i < nActionCount; i++)
		{
			cNpcAction->GetActionName(i, szBuffer, sizeof(szBuffer));
			NormalNpc.GetString(nFindNo, szBuffer, "", szTemp, sizeof(szTemp));
			ComposePathAndName(m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].szFileName, m_szResPath, szTemp);
			NormalNpcSprInfo.GetString(nFindNo, szBuffer, "16,8,0", szTemp, sizeof(szTemp));

            pcszTemp = szTemp;
            m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalFrames = KSG_StringGetInt(&pcszTemp, 16);
            KSG_StringSkipSymbol(&pcszTemp, ',');
            m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalDirs = KSG_StringGetInt(&pcszTemp, 8);
            KSG_StringSkipSymbol(&pcszTemp, ',');
            m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nInterval = KSG_StringGetInt(&pcszTemp, 0);
            //sscanf(szTemp, "%d,%d,%d", 
			//	&m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalFrames,
			//	&m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalDirs,
			//	&m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nInterval
            //);

			KNpcResNode::GetShadowName(m_cShadowInfo.m_psInfo[i].m_szName, m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].szFileName);
			m_cShadowInfo.m_psInfo[i].m_nTotalFrame = m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalFrames;
			m_cShadowInfo.m_psInfo[i].m_nTotalDir = m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nTotalDirs;
			m_cShadowInfo.m_psInfo[i].m_nInterval = m_cResInfo[NORMAL_NPC_PART_NO].m_cSprInfo[i].nInterval;
			m_cShadowInfo.m_psInfo[i].m_nCgX = SPR_X_OFF;
			m_cShadowInfo.m_psInfo[i].m_nCgY = SPR_Y_OFF;

			SoundName.GetString(nFindNo, szBuffer, "", szTemp, sizeof(szTemp));
			if (szTemp[0])
				ComposePathAndName(m_szSoundName[i], RES_SOUND_FILE_PATH, szTemp);
		}
	}

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	��·�����ļ����ϳ���һ���Ϊ��·�����ļ���?
//---------------------------------------------------------------------------
void	KNpcResNode::ComposePathAndName(char *lpszGet, char *lpszPath, char *lpszName)
{
	if (strlen(lpszName) == 0)
	{
		lpszGet[0] = 0;
		return;
	}
	if (strlen(lpszPath) == 0)
	{
		strcpy(lpszGet, lpszName);
		return;
	}
	if (lpszPath[0] != '\\')
	{
		lpszGet[0] = '\\';
		lpszGet[1] = 0;
	}
	else
	{
		lpszGet[0] = 0;
	}
	strcat(lpszGet, lpszPath);
	if (lpszGet[strlen(lpszGet) - 1] != '\\')
		strcat(lpszGet, "\\");
	strcat(lpszGet, lpszName);
}

//---------------------------------------------------------------------------
// ����:	�ж�ĳ�������Ƿ����?
//---------------------------------------------------------------------------
BOOL	KNpcResNode::CheckPartExist(int nPartNo)
{
	if (nPartNo < 0 || nPartNo >= MAX_PART)
		return FALSE;
	if (m_nSectInfo[nPartNo].nFlag)
		return TRUE;
	return FALSE;
}

//---------------------------------------------------------------------------
// ����:	���ĳ��������ĳ��װ����ĳ�������µ�?spr �ļ���
//---------------------------------------------------------------------------
BOOL	KNpcResNode::GetFileName(int nPartNo, int nActionNo, int nEquipNo, char *lpszDefault, char *lpszGetName, int nStrLen, bool bEffect/* = false*/)
{
	if (!lpszGetName || nStrLen <= 0)
		return FALSE;
	lpszGetName[0] = 0;
	if (nPartNo < 0 || nPartNo >= MAX_PART)
		return FALSE;
	if (nActionNo < 0 || nEquipNo < 0)
		return FALSE;
	if ( m_cResInfo[nPartNo].GetName(nActionNo, nEquipNo, "", lpszGetName, nStrLen, bEffect) )
	{
		if (nPartNo >= MAX_BODY_PART_SECT * 4 && nPartNo < MAX_BODY_PART_SECT * 5 && lpszGetName[0])
		{
			KImageParam info;
			ZeroMemory(&info, sizeof(info));
			if (!g_pRepresent || !g_pRepresent->GetImageParam(lpszGetName, &info, ISI_T_SPR))
			{
				lpszGetName[0] = 0;
				return FALSE;
			}
		}
		return TRUE;
	}
	return FALSE;
}

//---------------------------------------------------------------------------
// ����:	���ĳ��������ĳ��װ����ĳ�������µ�?spr �ļ���Ϣ
//---------------------------------------------------------------------------
int		KNpcResNode::GetInterval(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect/* = false*/)
{
	if (nPartNo < 0 || nPartNo >= MAX_PART)
		return nDefault;

	return m_cResInfo[nPartNo].GetInterval(nActionNo, nEquipNo, nDefault, bEffect);
}

//---------------------------------------------------------------------------
// ����:	���ĳ��������ĳ��װ����ĳ�������µ�?spr �ļ���Ϣ
//---------------------------------------------------------------------------
int		KNpcResNode::GetTotalFrames(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect/* = false*/)
{
	if (nPartNo < 0 || nPartNo >= MAX_PART)
		return nDefault;

	return m_cResInfo[nPartNo].GetTotalFrames(nActionNo, nEquipNo, nDefault, bEffect);
}

//---------------------------------------------------------------------------
// ����:	���ĳ��������ĳ��װ����ĳ�������µ�?spr �ļ���Ϣ
//---------------------------------------------------------------------------
int		KNpcResNode::GetTotalDirs(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect/* = false*/)
{
	if (nPartNo < 0 || nPartNo >= MAX_PART)
		return nDefault;

	return m_cResInfo[nPartNo].GetTotalDirs(nActionNo, nEquipNo, nDefault, bEffect);
}

//---------------------------------------------------------------------------
// ����:	���ĳ����ĳ״̬�µĶ������
//---------------------------------------------------------------------------
int		KNpcResNode::GetActNo(int nDoing, int nEquipNo, BOOL bRideHorse)
{
	// ��ͨnpc Doing �� Action ��ͬ
	if (m_nNpcKind == NPC_RES_NORMAL)
		return nDoing;

	const int nStyle = GetPhongThanStyleColumn(nDoing);
	const int nFallbackAction = GetPhongThanFallbackAction(nStyle, bRideHorse);

	// A missing/invalid equipment row must still resolve to the original VNG
	// action family so all composite parts keep the same mounted state.
	if (nEquipNo < 0)
		return nFallbackAction;

	int nActionNo;
	if (bRideHorse == FALSE)
	{
		nActionNo = m_NoHorseTable.GetValue(nEquipNo, nStyle);
	}
	else
	{
		nActionNo = m_OnHorseTable.GetValue(nEquipNo, nStyle);
	}
	return nActionNo < 0 ? nFallbackAction : nActionNo;
}

//---------------------------------------------------------------------------
// ����:	�ӱ����еõ�һ��������Ϣ
//---------------------------------------------------------------------------
BOOL	KNpcResNode::GetSort(int nActNo, int nDir, int nFrameNo, int *lpnTable, int nTableLen)
{
	// ��ͨnpc
	if (m_nNpcKind == NPC_RES_NORMAL)
	{
		if (!lpnTable || nTableLen <= 0)
			return FALSE;
		for (int i = 0; i < nTableLen; i++)
			lpnTable[i] = -1;
		lpnTable[0] = NORMAL_NPC_PART_NO;
		return TRUE;
	}

	// ����npc
	if ( m_cSortTable.GetSort(nActNo, nDir, nFrameNo, lpnTable, nTableLen) )
		return TRUE;
	return FALSE;
}

//---------------------------------------------------------------------------
// ���ܣ����ĳ��������Ӧ����Ч�ļ���?
//---------------------------------------------------------------------------
void	KNpcResNode::GetActionSoundName(int nAction, char *lpszSoundName)
{
	if (nAction < 0 || nAction >= MAX_ACTION)
		return;
	if (!lpszSoundName)
		return;
	g_StrCpy(lpszSoundName, m_szSoundName[nAction]);
}

//---------------------------------------------------------------------------
// ���ܣ���Ĭ�Ϲ����һ��npc��sprͼ�ļ���ת������Ӧ����Ӱ�ļ���
//---------------------------------------------------------------------------
void	KNpcResNode::GetShadowName(char *lpszShadow, char *lpszSprName)
{
	if (lpszSprName[0] == 0)
	{
		lpszShadow[0] = 0;
		return;
	}
	strcpy(lpszShadow, lpszSprName);
	for (int i = strlen(lpszShadow) - 1; i >= 0; i--)
	{
		if (lpszShadow[i] == '.')
		{
			lpszShadow[i] = 0;
			break;
		}
	}
	strcat(lpszShadow, "b.spr");
}

//---------------------------- class CActionName ----------------------------
//---------------------------------------------------------------------------
// ����:	���캯��
//---------------------------------------------------------------------------
CActionName::CActionName()
{
	m_nMaxAction = MAX_ACTION;
	m_nCurActionNo = 0;
	for (int i = 0; i < MAX_ACTION; i++)
		m_szName[i][0] = 0;
}

//---------------------------------------------------------------------------
// ����:	��ȡ�������ࡢ���Ƶ���Ϣ
//---------------------------------------------------------------------------
BOOL	CActionName::Init(char *lpszFileName)
{
	if (!lpszFileName || !lpszFileName[0])
		return FALSE;

	char		szBuf[FILE_NAME_LENGTH];
	KTabFile	cTabFile;
	int			i;

//	g_SetFilePath(RES_INI_FILE_PATH);
	g_UnitePathAndName(RES_INI_FILE_PATH, lpszFileName, szBuf);
	if ( !cTabFile.Load(szBuf) )
		return FALSE;
	m_nCurActionNo = cTabFile.GetHeight() - 1;
	if (m_nCurActionNo <= 0)
		return FALSE;
	if (m_nCurActionNo > m_nMaxAction)
		m_nCurActionNo = m_nMaxAction;
	for (i = 0; i < m_nCurActionNo; i++)
	{
		cTabFile.GetString(i + 2, 1, "", m_szName[i], sizeof(m_szName[i]));
	}
	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	�ɶ������Ƶõ��������?
//---------------------------------------------------------------------------
int		CActionName::GetActionNo(char *lpszName)
{
	if ( !lpszName || !lpszName[0] )
		return -1;
	for (int i = 0; i < m_nCurActionNo; i++)
	{
		if (strcmp(lpszName, m_szName[i]) == 0)
			return i;
	}
	return -1;
}

//---------------------------------------------------------------------------
// ����:	�õ�����������
//---------------------------------------------------------------------------
int		CActionName::GetActionCount()
{
	return m_nCurActionNo;
}

//---------------------------------------------------------------------------
// ����:	�ɶ�����ŵõ���������?
//---------------------------------------------------------------------------
BOOL	CActionName::GetActionName(int nNo, char *lpszName, int nSize)
{
	if (!lpszName)
		return FALSE;
	if (nNo < 0 || nNo >= m_nCurActionNo)
		return FALSE;
	if (strlen(m_szName[nNo]) >= (DWORD)nSize)
		return FALSE;
	strcpy(lpszName, m_szName[nNo]);

	return TRUE;
}
//-------------------------- class CActionName end --------------------------


//-------------------------- class CShadowFileName --------------------------

//---------------------------------------------------------------------------
// ���ܣ����캯��
//---------------------------------------------------------------------------
CShadowFileName::CShadowFileName()
{
	m_psInfo = NULL;
	m_nInfoLength = 0;
}

//---------------------------------------------------------------------------
// ���ܣ���������
//---------------------------------------------------------------------------
CShadowFileName::~CShadowFileName()
{
	if (m_psInfo)
		delete []m_psInfo;
	m_psInfo = NULL;
	m_nInfoLength = 0;
}

void	CShadowFileName::Init(int nActionCount)
{
	if (m_psInfo)
		delete []m_psInfo;
	m_psInfo = NULL;
	m_nInfoLength = 0;

	if (nActionCount <= 0)
		return;

	m_psInfo = (SShadowFileInfo*)new SShadowFileInfo[nActionCount];
	memset(m_psInfo, 0, sizeof(SShadowFileInfo) * nActionCount);
	m_nInfoLength = nActionCount;
}

//---------------------------------------------------------------------------
// ���ܣ��õ�ĳ����������Ӱ�ļ�����������ļ����?
//---------------------------------------------------------------------------
BOOL	CShadowFileName::GetFile(int nActionNo, int *pnFrame, int *pnDir, int *pnInterval, int *pnCgX, int *pnCgY, char *lpszName)
{
	if (nActionNo < 0 || nActionNo >= m_nInfoLength)
		return FALSE;
	if (!m_psInfo)
		return FALSE;

	*pnFrame	= m_psInfo[nActionNo].m_nTotalFrame;
	*pnDir		= m_psInfo[nActionNo].m_nTotalDir;
	*pnInterval	= m_psInfo[nActionNo].m_nInterval;
	*pnCgX		= m_psInfo[nActionNo].m_nCgX;
	*pnCgY		= m_psInfo[nActionNo].m_nCgY;
	strcpy(lpszName, m_psInfo[nActionNo].m_szName);

	return TRUE;
}

//------------------------ class CShadowFileName end ------------------------


//------------------------- class CStateMagicTable --------------------------
//---------------------------------------------------------------------------
// ����:	���캯��
//---------------------------------------------------------------------------
CStateMagicTable::CStateMagicTable()
{
	for (int i = 0; i < MAX_RES_STATE; i++)
	{
		m_nType[i] = 0;
		m_nPlayType[i] = 0;
		m_nBackStart[i] = 0;
		m_nBackEnd[i] = 0;
		m_nTotalFrame[i] = 1;
		m_nTotalDir[i] = 1;
		m_nInterVal[i] = 1;
		m_szName[i][0] = 0;
	}
}

//---------------------------------------------------------------------------
// ����:	��ʼ��
//---------------------------------------------------------------------------
BOOL	CStateMagicTable::Init()
{
	KTabFile	cTabFile;
	int			i;
	char		szBuffer[80], szTemp[80];

//	g_SetFilePath(RES_INI_FILE_PATH);
	if ( !cTabFile.Load(STATE_MAGIC_TABLE_NAME) )
		return FALSE;

	//KNpcResNode		Temp;
	for (i = 0; i < MAX_RES_STATE; i++)
	{
		cTabFile.GetString(i + 2, 3, "", szBuffer, sizeof(szBuffer));
		if (strcmp(szBuffer, "Head") == 0)
			m_nType[i] = STATE_MAGIC_HEAD;
		else if (strcmp(szBuffer, "Foot") == 0)
			m_nType[i] = STATE_MAGIC_FOOT;
		else
			m_nType[i] = STATE_MAGIC_BODY;
		cTabFile.GetString(i + 2, 4, "", szBuffer, sizeof(szBuffer));
		if (strcmp(szBuffer, "Loop") == 0)
			m_nPlayType[i] = 0;
		else
			m_nPlayType[i] = 1;
		cTabFile.GetInteger(i + 2, 5, 0, &m_nBackStart[i]);
		cTabFile.GetInteger(i + 2, 6, 0, &m_nBackEnd[i]);
		cTabFile.GetInteger(i + 2, 7, 1, &m_nTotalFrame[i]);
		cTabFile.GetInteger(i + 2, 8, 1, &m_nTotalDir[i]);
		cTabFile.GetInteger(i + 2, 9, 1, &m_nInterVal[i]);
		cTabFile.GetString(i + 2, 2, "", szTemp, sizeof(szTemp));
		g_StrCpy(m_szName[i], szTemp);
//		Temp.ComposePathAndName(m_szName[i], RES_NPC_STYLE_PATH, szTemp);
	}

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	�õ�ĳ��״̬�Ĺ�ӰЧ������Ϣ
// nNo �� 1 �� MAX_RES_STATE
//---------------------------------------------------------------------------
void	CStateMagicTable::GetInfo(int nNo, char *lpszGetName, int *pnType, int *pnPlayType, int *pnBackStart, int *pnBackEnd, int *pnTotalFrame, int *pnTotalDir, int *pnInterVal)
{
	if (!lpszGetName)
		return;
	if (nNo <= 0 || nNo > MAX_RES_STATE)
	{
		lpszGetName[0] = 0;
		*pnType = 0;
		*pnPlayType = 0;
		*pnBackStart = 0;
		*pnBackEnd = 0;
		*pnTotalFrame = 1;
		*pnTotalDir = 1;
		*pnInterVal = 1;
		return;
	}
	strcpy(lpszGetName, m_szName[nNo - 1]);
	*pnType = m_nType[nNo - 1];
	*pnPlayType = m_nPlayType[nNo - 1];
	*pnBackStart = m_nBackStart[nNo - 1];
	*pnBackEnd = m_nBackEnd[nNo - 1];
	*pnTotalFrame = m_nTotalFrame[nNo - 1];
	*pnTotalDir = m_nTotalDir[nNo - 1];
	*pnInterVal = m_nInterVal[nNo - 1];
}
//----------------------- class CStateMagicTable end ------------------------

//----------------------------- class CRESINFO ------------------------------
//---------------------------------------------------------------------------
// ����:	���캯��
//---------------------------------------------------------------------------
CRESINFO::CRESINFO()
{
	m_nActionKind = 0;
	m_nEquipKind = 0;
	m_cSprInfo = NULL;
}

//---------------------------------------------------------------------------
// ����:	��������
//---------------------------------------------------------------------------
CRESINFO::~CRESINFO()
{
	AutoDelete();
}

//---------------------------------------------------------------------------
// ����:	�������?
//---------------------------------------------------------------------------
void	CRESINFO::AutoDelete()
{
	if (m_cSprInfo)
		delete [] m_cSprInfo;
	m_cSprInfo = NULL;

	m_nActionKind = 0;
	m_nEquipKind = 0;
}

//---------------------------------------------------------------------------
// ����:	�趨������������װ������������������ڴ滺����?
//---------------------------------------------------------------------------
BOOL	CRESINFO::AutoNew(int nWidth, int nHeight)
{
	int		i;

	AutoDelete();

	m_nActionKind = nWidth;
	if (m_nActionKind < 0)
		m_nActionKind = 0;
	m_nEquipKind = nHeight;
	if (m_nEquipKind < 0)
		m_nEquipKind = 0;

	if (m_nActionKind == 0 || m_nEquipKind == 0)
		return FALSE;

	m_cSprInfo = (CSPR_INFO *)new CSPR_INFO[m_nActionKind * m_nEquipKind];
	if (m_cSprInfo == NULL)
		return FALSE;
	ZeroMemory(m_cSprInfo, sizeof(CSPR_INFO) * m_nActionKind * m_nEquipKind);
	
	for (i = 0; i < m_nActionKind * m_nEquipKind; i++)
	{
		m_cSprInfo[i].szFileName[0] = 0;
	}

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	���ݶ�����š�װ����ŵõ���Դ�ļ���
//---------------------------------------------------------------------------
BOOL	CRESINFO::GetName(int nActionNo, int nEquipNo, char *lpszDefault, char *lpszGetName, int nStrLen,bool bEffect/*=false*/)
{
	if (!lpszGetName)
		return FALSE;
	if (m_cSprInfo == NULL)
		goto FALSE_LAB;
	if (nActionNo < 0 || nActionNo >= m_nActionKind || nEquipNo < 0 || nEquipNo >= m_nEquipKind)
		goto FALSE_LAB;

	if(bEffect)
		g_StrCpyLen(lpszGetName, m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].szEffectFileName, nStrLen);
	else
		g_StrCpyLen(lpszGetName, m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].szFileName, nStrLen);

	return TRUE;

FALSE_LAB:
	g_StrCpyLen(lpszGetName, lpszDefault, nStrLen);
	return FALSE;

}

int		CRESINFO::GetInterval(int nActionNo, int nEquipNo, int nDefault,bool bEffect/*=false*/)
{
	if (nActionNo < 0 || nActionNo >= m_nActionKind || nEquipNo < 0 || nEquipNo >= m_nEquipKind)
		return nDefault;

	return bEffect?m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nEffectInterval:m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nInterval;
}

int		CRESINFO::GetTotalFrames(int nActionNo, int nEquipNo, int nDefault,bool bEffect/*=false*/)
{
	if (nActionNo < 0 || nActionNo >= m_nActionKind || nEquipNo < 0 || nEquipNo >= m_nEquipKind)
		return nDefault;

	return bEffect?m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nTotalEffectFrames:m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nTotalFrames;
}

int		CRESINFO::GetTotalDirs(int nActionNo, int nEquipNo, int nDefault,bool bEffect/*=false*/)
{
	if (nActionNo < 0 || nActionNo >= m_nActionKind || nEquipNo < 0 || nEquipNo >= m_nEquipKind)
		return nDefault;

	return bEffect?m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nTotalEffectDirs:m_cSprInfo[nEquipNo * m_nActionKind + nActionNo].nTotalDirs;
}
//--------------------------- class CRESINFO end ----------------------------

//------------------------- class CEquipStyleTable --------------------------
//---------------------------------------------------------------------------
// ����:	���캯��
//---------------------------------------------------------------------------
CEquipStyleTable::CEquipStyleTable()
{
	m_nStyleKind = 0;
	m_nEquipKind = 0;
	m_lpnActionNo = NULL;
}

//---------------------------------------------------------------------------
// ����:	��������
//---------------------------------------------------------------------------
CEquipStyleTable::~CEquipStyleTable()
{
	AutoDelete();
}

//---------------------------------------------------------------------------
// ����:	�������?
//---------------------------------------------------------------------------
void	CEquipStyleTable::AutoDelete()
{
	if (m_lpnActionNo)
		delete [] m_lpnActionNo;
	m_lpnActionNo = NULL;
	m_nStyleKind = 0;
	m_nEquipKind = 0;
}

//---------------------------------------------------------------------------
// ����:	�趨���񳤿�����ʼ�����񻺳���
//---------------------------------------------------------------------------
BOOL	CEquipStyleTable::AutoNew(int nWidth, int nHeight)
{
	AutoDelete();

	if (nWidth < 0 || nHeight < 0)
		return FALSE;

	m_nStyleKind = nWidth;
	m_nEquipKind = nHeight;

	m_lpnActionNo = new int[nWidth * nHeight];
	if (m_lpnActionNo == NULL)
		return FALSE;
	for (int i = 0; i < nWidth * nHeight; i++)
		m_lpnActionNo[i] = -1;

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	�趨������ĳһ����?
//---------------------------------------------------------------------------
void	CEquipStyleTable::SetValue(int nXpos, int nYpos, int nValue)
{
	if (nXpos < 0 || nXpos >= m_nStyleKind || nYpos < 0 || nYpos >= m_nEquipKind)
		return;
	m_lpnActionNo[nYpos * m_nStyleKind + nXpos] = nValue;
}

//---------------------------------------------------------------------------
// ����:	�õ�������ĳһ����?
// ����:	nXpos : װ�����? nYpos : ״̬���?
// ����:	�������?
//---------------------------------------------------------------------------
int		CEquipStyleTable::GetValue(int nXpos, int nYpos)
{
	if (nXpos < 0 || nXpos >= m_nEquipKind || nYpos < 0 || nYpos >= m_nStyleKind)
		return -1;
	if (m_lpnActionNo == NULL)
		return -1;
	return m_lpnActionNo[nXpos * m_nStyleKind + nYpos];
}

//----------------------- class CEquipStyleTable end ------------------------

//---------------------------- class CSortTable -----------------------------
//---------------------------------------------------------------------------
// ����:	���캯��
//---------------------------------------------------------------------------
CSortTable::CSortTable()
{
	m_lpnSortTable = NULL;
	m_nSortTableSize = 0;
	m_nPartNum = 1;
	strcpy(m_sSortTableFileName,"");
}

//---------------------------------------------------------------------------
// ����:	��������
//---------------------------------------------------------------------------
CSortTable::~CSortTable()
{
	Release();
}

//---------------------------------------------------------------------------
// ����:	�������?
//---------------------------------------------------------------------------
void	CSortTable::Release()
{
	int		i;

	if (m_lpnSortTable)
	{
		delete [] m_lpnSortTable;
		m_lpnSortTable = NULL;
	}
	m_nSortTableSize = 0;

	for (i = 0; i < MAX_ACTION; i++)
		m_sActTableOff[i].Clear();
}

//---------------------------------------------------------------------------
// ����:	���ַ����а�һϵ������ȡ����
// ����:	lpszStr : �ַ���  lpnTable : �������ֵ�����  nTableSize : ����Ĵ��?
//---------------------------------------------------------------------------
void	CSortTable::SortStrToNum(char *lpszStr, int *lpnTable, int nTableSize)
{
	if ( !lpszStr || !lpszStr[0] || !lpnTable || nTableSize < 1)
		return;
	if (nTableSize > m_nPartNum + 1)
		nTableSize = m_nPartNum + 1;

	int		nTablePos = 0, nNumPos = 0, nStrPos = 0;
	char	szNum[32];

	while (1)
	{
		if (lpszStr[nStrPos] == '-' || 
			('0' <= lpszStr[nStrPos] && lpszStr[nStrPos] <= '9'))
		{
			szNum[nNumPos] = lpszStr[nStrPos];
			nNumPos++;
		}
		else
		{
			if (nNumPos > 0)
			{
				szNum[nNumPos] = 0;
				nNumPos = 0;
				if (nTablePos < nTableSize)
				{
					lpnTable[nTablePos] = atoi(szNum);
					nTablePos++;
				}
			}
			if ( lpszStr[nStrPos] == 0 )
				break;
		}
		nStrPos ++;
	}
	for (int i = nTablePos; i < nTableSize; i++)
		lpnTable[i] = -1;
}

//---------------------------------------------------------------------------
// ����:	�������ļ��а�������Ϣ��ȡ����
// ����:	
//			lpszFileName: �����ļ���
//			*cActionName: ���ڻ�ȡ�����ĸ�����Ϣ
//			nPartNum������������
// ����:	��ȡ�ɹ����?
//---------------------------------------------------------------------------
BOOL	CSortTable::GetTable(char *lpszFileName, CActionName *cActionName, int nPartNum)
{
	if ( !lpszFileName || !lpszFileName[0])
		return FALSE;

	char		szBuf[FILE_NAME_LENGTH];
	KIniFile	SortIni;

//	g_SetFilePath(RES_INI_FILE_PATH);
	g_UnitePathAndName(RES_INI_FILE_PATH, lpszFileName, szBuf);
	if ( !SortIni.Load(szBuf) )
		return FALSE;
	return GetTable(&SortIni, cActionName, nPartNum);
}
BOOL	CSortTable::GetTable(KIniFile *pIni, CActionName *cActionName, int nPartNum)
{
//	if ( !lpszFileName || !lpszFileName[0])
//		return FALSE;
	if (nPartNum > 1)
		m_nPartNum = nPartNum;

//	KIniFile	SortIni;
	int			i, j, nActNo;
	char		szBuffer[256], szKey[80], szActName[80];

//	g_SetFilePath(RES_INI_FILE_PATH);
//	if ( !SortIni.Load(lpszFileName) )
//		return FALSE;
//	KIniFile	*pIni = &SortIni;

// ----------------------- ͨ�������ļ����� Table �Ĵ�С --------------------------
	Release();
	// default ���֣�16 ������
	for (i = 0; i < MAX_SORT_DIR; i++)
	{
		sprintf(szKey, "Dir%d", i + 1);
		if( pIni->GetString("DEFAULT", szKey, "", szBuffer, sizeof(szBuffer)) )
			m_nSortTableSize ++;
	}
	// �������������?
	nActNo = cActionName->GetActionCount();
	if (nActNo <= 0)
		return FALSE;
	for (i = 0; i < nActNo; i++)
	{
		// �õ�������
		if ( !cActionName->GetActionName(i, szActName, sizeof(szActName)) )
			continue;
		if( !pIni->IsSectionExist(szActName) )
			continue;
		// �ж��Ƿ�ʹ��Ĭ�Ϸ���˳��
		for (j = 0; j < MAX_SORT_DIR; j++)
		{
			sprintf(szKey, "Dir%d", j + 1);
			if( pIni->GetString(szActName, szKey, "", szBuffer, sizeof(szBuffer)) )
			{
				m_sActTableOff[i].bUseDefault = FALSE;
				m_sActTableOff[i].nActOff = m_nSortTableSize;
				m_sActTableOff[i].nLineNum = MAX_SORT_DIR;
				break;
			}
		}
		// �ж��Ƿ�����Ҫ���������������?
		j = 1;
		while (1)
		{
			sprintf(szKey, "Line%d", j);
			if( pIni->GetString(szActName, szKey, "", szBuffer, sizeof(szBuffer)) )
			{
				if (m_sActTableOff[i].nActOff == 0)
				{
					m_sActTableOff[i].nActOff = m_nSortTableSize;
					m_sActTableOff[i].nLineNum = 1;
				}
				else
				{
					m_sActTableOff[i].nLineNum++;
				}
			}
			else
			{
				break;
			}

			j++;
		}
		m_nSortTableSize += m_sActTableOff[i].nLineNum;
	}
	if (m_nSortTableSize < MAX_SORT_DIR)
		return FALSE;
// --------------------- ͨ�������ļ����� Table �Ĵ�С end ------------------------

// ------------------------------ �������Ķ�Ӧ������ ----------------------------
	// �� m_lpnSortTable �����ڴ�
	m_lpnSortTable = (int *)new int[m_nSortTableSize * (m_nPartNum + 1)];
	if (m_lpnSortTable == NULL)
	{
		Release();
		return FALSE;
	}
	for (i = 0; i < m_nSortTableSize * (m_nPartNum + 1); i++)
	{
		m_lpnSortTable[i] = -1;
	}

	int		nTablePos = 0;
	// default ���֣�16 ������
	for (i = 0; i < MAX_SORT_DIR; i++)
	{
		sprintf(szKey, "Dir%d", i + 1);
		if( pIni->GetString("DEFAULT", szKey, "", szBuffer, sizeof(szBuffer)) )
		{
			SortStrToNum(szBuffer, &m_lpnSortTable[nTablePos * (m_nPartNum + 1)], m_nPartNum + 1);
		}
		nTablePos++;
	}
	// �������������?
	for (i = 0; i < nActNo; i++)
	{
		// �����ȫʹ��Ĭ��ֵ�������ٴ���?
		if (m_sActTableOff[i].nActOff == 0)
			continue;
		// �õ�������
		if ( !cActionName->GetActionName(i, szActName, sizeof(szActName)) )
			continue;
		if( !pIni->IsSectionExist(szActName) )
			continue;
		// �������ʹ��Ĭ��ֵ�����뷽��˳��?
		if (m_sActTableOff[i].bUseDefault == FALSE)
		{
			for (j = 0; j < MAX_SORT_DIR; j++)
			{
				sprintf(szKey, "Dir%d", j + 1);
				if ( pIni->GetString(szActName, szKey, "", szBuffer, sizeof(szBuffer)) )
				{
					SortStrToNum(szBuffer, &m_lpnSortTable[nTablePos * (m_nPartNum + 1)], m_nPartNum + 1);
				}
				else
				{
					memcpy(&m_lpnSortTable[nTablePos * (m_nPartNum + 1)], &m_lpnSortTable[j * (m_nPartNum + 1)], sizeof(int) * (m_nPartNum + 1));
				}
				nTablePos++;
			}
		}
		// ����������˳��
		if ((m_sActTableOff[i].bUseDefault == FALSE && m_sActTableOff[i].nLineNum > MAX_SORT_DIR) || 
			(m_sActTableOff[i].bUseDefault == TRUE && m_sActTableOff[i].nLineNum > 0))
		{
			j = 1;
			while (1)
			{
				sprintf(szKey, "Line%d", j);
				if( !pIni->GetString(szActName, szKey, "", szBuffer, sizeof(szBuffer)) )
					break;
				SortStrToNum(szBuffer, &m_lpnSortTable[nTablePos * (m_nPartNum + 1)], m_nPartNum + 1);
				nTablePos++;
				j++;
			}
		}
	}
// ---------------------------- �������Ķ�Ӧ������ end --------------------------

	return TRUE;
}

//---------------------------------------------------------------------------
// ����:	�ӱ����еõ�һ��������Ϣ
// ����:	
//			nActNo : �������?
//			nDir : ��ǰ���� ( 0 -- 16 )
//			nFrameNo : ��ǰ�ڼ���
//			lpnTable : ����������Ϣ������
//			nTableLen : lpnTable�ĳ���
// ����:	��ȡ�ɹ����?
//---------------------------------------------------------------------------
BOOL	CSortTable::GetSort(int nActNo, int nDir, int nFrameNo, int *lpnTable, int nTableLen)
{
	if (!lpnTable)
		return FALSE;
	if (nActNo < 0 || nActNo >= MAX_ACTION)
		return FALSE;
	if (nDir < 0 || nDir >= MAX_SORT_DIR)
		return FALSE;
	if (!m_lpnSortTable)
		return FALSE;

	int		i;

	// ��ȫʹ��Ĭ��
	if (m_sActTableOff[nActNo].nActOff == 0)
	{
		if (nTableLen <= m_nPartNum)
			memcpy(lpnTable, &m_lpnSortTable[nDir * (m_nPartNum + 1) + 1], sizeof(int) * nTableLen);
		else
		{
			memcpy(lpnTable, &m_lpnSortTable[nDir * (m_nPartNum + 1) + 1], sizeof(int) * m_nPartNum);
			for (i = m_nPartNum; i < nTableLen; i++)
				lpnTable[i] = -1;
		}
	}
	else
	{
		// ����ʹ��Ĭ�ϣ���������
		if (m_sActTableOff[nActNo].bUseDefault == TRUE)
		{
			// �ж��Ƿ���������
			for (i = 0; i < m_sActTableOff[nActNo].nLineNum; i++)
			{
				// �ҵ�������
				if (nFrameNo == m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1)])
				{
					if (nTableLen <= m_nPartNum)
						memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1) + 1], sizeof(int) * nTableLen);
					else
					{
						memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1) + 1], sizeof(int) * m_nPartNum);
						for (int j = m_nPartNum; j < nTableLen; j++)
							lpnTable[j] = -1;
					}
					return TRUE;
				}
			}
			// ���ˣ�û���ҵ�������
			if (nTableLen <= m_nPartNum)
				memcpy(lpnTable, &m_lpnSortTable[nDir * (m_nPartNum + 1) + 1], sizeof(int) * nTableLen);
			else
			{
				memcpy(lpnTable, &m_lpnSortTable[nDir * (m_nPartNum + 1) + 1], sizeof(int) * m_nPartNum);
				for (i = m_nPartNum; i < nTableLen; i++)
					lpnTable[i] = -1;
			}
		}
		// ����ʹ��Ĭ��
		else
		{
			// �ж��Ƿ���������
			for (i = MAX_SORT_DIR; i < m_sActTableOff[nActNo].nLineNum; i++)
			{
				// �ҵ�������
				if (nFrameNo == m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1)])
				{
					if (nTableLen <= m_nPartNum)
						memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1) + 1], sizeof(int) * nTableLen);
					else
					{
						memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + i) * (m_nPartNum + 1) + 1], sizeof(int) * m_nPartNum);
						for (int j = m_nPartNum; j < nTableLen; j++)
							lpnTable[j] = -1;
					}
					return TRUE;
				}
			}
			// ���ˣ�û���ҵ�������
			if (nTableLen <= m_nPartNum)
				memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + nDir) * (m_nPartNum + 1) + 1], sizeof(int) * nTableLen);
			else
			{
				memcpy(lpnTable, &m_lpnSortTable[(m_sActTableOff[nActNo].nActOff + nDir) * (m_nPartNum + 1) + 1], sizeof(int) * m_nPartNum);
				for (i = m_nPartNum; i < nTableLen; i++)
					lpnTable[i] = -1;
			}
		}
	}

	return TRUE;
}
//-------------------------- class CSortTable end ---------------------------

#endif
