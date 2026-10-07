//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KObj.cpp
// Date:	2002.01.06
// Code:	�߳�����
// Desc:	Obj Class
//---------------------------------------------------------------------------
#include "KCore.h"
#include "PhongThanObjectProtocol.h"
#include "KNpc.h"
#include "KObjSet.h"
#include "KPlayer.h"
#include "KSubWorld.h"
#include "KItemSet.h"
#include "KItem.h"
#include "LuaFuns.h"
#include "KSortScript.h"
#ifdef _SERVER
//#include "KNetServer.h"
//#include "../MultiServer/Heaven/Interface/iServer.h"
#else
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "scene/KScenePlaceC.h"
#include "ImgRef.h"
#include "KOption.h"
#endif
#include "KObj.h"

#define		OBJ_SHOW_NAME_Y_OFF		48

KObj	Object[MAX_OBJECT];

//-------------------------------------------------------------------------
//	���ܣ�	��ʼ��
//-------------------------------------------------------------------------
KObj::KObj()
{
	Release();
}

//-------------------------------------------------------------------------
//	���ܣ�	������
//-------------------------------------------------------------------------
void	KObj::Release()
{
	m_nID				= -1;
	m_nKind				= 0;
	m_nBelongRegion		= -1;

	m_nIndex			= 0;
	m_nSubWorldID		= 0;
	m_nRegionIdx		= 0;
	m_nMapX				= 0;
	m_nMapY				= 0;
	m_nOffX				= 0;
	m_nOffY				= 0;
	m_nDir				= 0;

#ifndef _SERVER
	m_nLayer			= 1;
	m_nHeight			= 0;

	m_sObjLight.Release();
	m_Image.uImage = 0;
	m_SceneID = 0;
#endif

	m_nState			= 0;
	m_nLifeTime			= 0;
	m_nBornTime			= 0;
	m_nObjValue			= 0;

#ifdef _SERVER
	if (m_nItemDataID)
	{
		ItemSet.Remove(m_nItemDataID);
	}
#endif
	m_nItemDataID		= 0;
	m_nItemWidth		= 0;
	m_nItemHeight		= 0;
	m_nMoneyNum			= 0;

	m_szName[0]			= 0;
	m_dwScriptID		= 0;
	m_nColorID			= 0;
	m_nGenre			= 0;
	m_nDetailType		= 0;
	m_bOverLook			= 0;

#ifdef _SERVER
	m_bPickExecute		= FALSE;
	m_nBelong			= -1;
	m_nBelongTime		= 0;
	m_cImage.Release();
#endif

#ifndef _SERVER
	m_szImageName[0]	= 0;
	m_szImageDropName[0]= 0;
	m_szSoundName[0]	= 0;
	m_nDropState		= 0;
	m_cImage.Release();
	m_cImageDrop.Release();
	this->m_dwNameColor = 0x00ffffff;
#endif

	m_dwTimer			= 0;

	memset(m_btBar, 0, sizeof(m_btBar));
	Polygon.Clear();

#ifndef _SERVER
	m_pSoundNode		= NULL;
	m_pWave				= NULL;
#endif
}

//-------------------------------------------------------------------------
//	���ܣ�	�趨���������ֵ
//-------------------------------------------------------------------------
void	KObj::SetIndex(int nIndex)
{
	if (nIndex >= 0)
		m_nIndex = nIndex;
	else
		m_nIndex = 0;
}

//-------------------------------------------------------------------------
//	���ܣ�	�趨�������Ψһ ID ��ע��ֻ�ڿͻ��˴��ڵ������ ID ͳһΪ 0��
//-------------------------------------------------------------------------
void	KObj::SetWorldID(int nID)
{
	if (nID < 0)
		m_nID = 0;
	else
		m_nID = nID;
}

//-------------------------------------------------------------------------
//	���ܣ�	�趨���������ʱ�� ��ע��ֻ��ʬ�塢װ�������������Ч��
//-------------------------------------------------------------------------
void	KObj::SetLifeTime(int nLifeTime)
{
	if (nLifeTime < 0)
		return;
	m_nLifeTime = nLifeTime;
}

//-------------------------------------------------------------------------
//	���ܣ�	�趨���״̬
//-------------------------------------------------------------------------
void	KObj::SetState(int nState, int nPlaySoundFlag/* = 0*/)
{
	if (nState < 0)
		return;
	m_nState = nState;
	switch (m_nKind)
	{
	case Obj_Kind_Box:
		if (nState == OBJ_BOX_STATE_CLOSE)
			BoxClose();
		else if (nState == OBJ_BOX_STATE_OPEN)
			BoxOpen();
		break;
	case Obj_Kind_Door:
		if (nState == OBJ_DOOR_STATE_CLOSE)
			DoorClose();
		else if (nState == OBJ_DOOR_STATE_OPEN)
			DoorOpen();
		break;
	case Obj_Kind_Prop:
		if (nState == OBJ_PROP_STATE_HIDE)
		{
			m_nBornTime = m_nLifeTime;
		}
		break;
	}

#ifndef _SERVER
	if (nPlaySoundFlag)
		PlaySound();
#endif

#ifdef _SERVER
	SyncState();
#endif
}

//-------------------------------------------------------------------------
//	���ܣ�	�����
//-------------------------------------------------------------------------
void	KObj::BoxOpen()
{
#ifndef _SERVER
	if (m_nState != 1)
		PlaySound();
#endif
	m_nState = 1;
	m_nBornTime = m_nLifeTime;
}

//-------------------------------------------------------------------------
//	���ܣ�	����ر�
//-------------------------------------------------------------------------
void	KObj::BoxClose()
{
#ifndef _SERVER
	if (m_nState != 0)
		PlaySound();
#endif
	m_nState = 0;
	m_nBornTime = 0;
}

//-------------------------------------------------------------------------
//	���ܣ�	�Ŵ�
//-------------------------------------------------------------------------
void	KObj::DoorOpen()
{
#ifndef _SERVER
	if (m_nState != 1)
		PlaySound();
#endif
	m_nState = 1;

	// ȱ�ٴ�������ϰ�
}

//-------------------------------------------------------------------------
//	���ܣ�	�Źر�
//-------------------------------------------------------------------------
void	KObj::DoorClose()
{
#ifndef _SERVER
	if (m_nState != 0)
		PlaySound();
#endif
	m_nState = 0;

	// ȱ�ٴ�������ϰ�
}

BOOL	KObj::SetDir(int n64Dir)
{
	if (n64Dir < 0 || n64Dir >= 64)
	{
		n64Dir = 0;
		_ASSERT(0);
	}

#ifdef _SERVER
	m_nDir = n64Dir;
	m_cImage.SetCurDir64(n64Dir);
	SyncDir();
#else
	m_nDir = n64Dir;
	m_cImage.SetCurDir64(n64Dir);
	m_cImageDrop.SetCurDir64(n64Dir);
#endif

	return TRUE;
}

void	KObj::SetScriptFile(char *lpszScriptFile)
{
	char	szScript[80];
	if ( !lpszScriptFile || strlen(lpszScriptFile) >= sizeof(szScript))
	{
		g_DebugLog("[error]Script FileName Error!!!");
	}
	else
	{
		if (lpszScriptFile[0])
		{
			if (lpszScriptFile[0] == '.')
				g_StrCpyLen(szScript, &lpszScriptFile[1], sizeof(szScript));
			else
				g_StrCpyLen(szScript, lpszScriptFile, sizeof(szScript));
			g_StrLower(szScript);
			m_dwScriptID = g_FileName2Id(szScript);
		}
	}
}

void	KObj::SetImageDir(int nDir)
{
#ifdef _SERVER
	m_cImage.SetCurDir(nDir);
	SetDir(m_cImage.m_nCurDir * 64 / m_cImage.m_nTotalDir);
#else
	m_cImage.SetCurDir(nDir);
	SetDir(m_cImage.m_nCurDir * 64 / m_cImage.m_nTotalDir);
#endif
}

#ifdef _SERVER
void	KObj::SetItemDataID(int nItemDataID)
{
	if (nItemDataID >= 0)
		m_nItemDataID = nItemDataID;
}
#endif


#ifndef _SERVER
void KObj::DrawInfo(int nFontSize)
{
	int		nMpsX, nMpsY, nHeightOff;
//	DWORD	dwColor;
	if (m_nKind != Obj_Kind_Item && m_nKind != Obj_Kind_Money)
		return;

	if (m_nKind == Obj_Kind_Money)
	{
		char szName[128];
		GetMpsPos(&nMpsX, &nMpsY);
		nHeightOff = OBJ_SHOW_NAME_Y_OFF;
		if (m_nMoneyNum < MONEY_FLOOR)
		{
			sprintf(szName,"%d l��ng",m_nMoneyNum);
			g_pRepresent->OutputText(nFontSize, szName, KRF_ZERO_END, nMpsX - 12 * g_StrLen(szName) / 4, nMpsY, 0x00ffffff, 0, nHeightOff);
		}
		else if ((m_nMoneyNum % MONEY_FLOOR) == 0)
		{
			sprintf(szName,"%d v�n l��ng",m_nMoneyNum / MONEY_FLOOR);
			g_pRepresent->OutputText(nFontSize, szName, KRF_ZERO_END, nMpsX - 12 * g_StrLen(szName) / 4, nMpsY, 0x00ffffff, 0, nHeightOff);
		}
		else
		{
			sprintf(szName,"%d v�n %d l��ng",m_nMoneyNum / MONEY_FLOOR, m_nMoneyNum % MONEY_FLOOR);
			g_pRepresent->OutputText(nFontSize, szName, KRF_ZERO_END, nMpsX - 12 * g_StrLen(szName) / 4, nMpsY, 0x00ffffff, 0, nHeightOff);
		}

	}
	else if (m_nKind == Obj_Kind_Item)
	{
		GetMpsPos(&nMpsX, &nMpsY);
		nHeightOff = OBJ_SHOW_NAME_Y_OFF;
		g_pRepresent->OutputText(nFontSize, m_szName, KRF_ZERO_END, nMpsX - 12 * g_StrLen(m_szName) / 4, nMpsY, this->m_dwNameColor, 0, nHeightOff);
	}
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�	�������
//-------------------------------------------------------------------------
void KObj::Draw()
{
	if ( m_nIndex <= 0 )
		return;
	if ( !m_cImage.CheckExist() )
		return;
	if (m_bDrawFlag)
		return;
	if (m_nRegionIdx < 0 || m_nRegionIdx >= 9)
		return;

	int			x, y;
	SubWorld[m_nSubWorldID].Map2Mps(m_nRegionIdx, m_nMapX, m_nMapY, m_nOffX, m_nOffY, &x, &y);
//	SubWorld[m_nSubWorldID].Mps2Screen(&x, &y);

	m_Image.Color.Color_b.a = 255;
	m_Image.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	m_Image.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
	m_Image.nType = ISI_T_SPR;
	m_Image.oPosition.nZ = 0;
	if (m_nKind == Obj_Kind_Item && m_nDropState == 1)	// ��Ʒ��������
	{
		m_Image.nFrame = m_cImageDrop.m_nCurFrame;
		m_Image.oPosition.nX = x;// - m_cImageDrop.m_nCgXpos;
		m_Image.oPosition.nY = y;// - m_cImageDrop.m_nCgYpos * 2;
		strcpy(m_Image.szImage, m_cImageDrop.m_szName);
	}
	else
	{
		m_Image.nFrame = m_cImage.m_nCurFrame;
		m_Image.oPosition.nX = x;// - m_cImage.m_nCgXpos;
		m_Image.oPosition.nY = y;// - m_cImage.m_nCgYpos * 2;
		strcpy(m_Image.szImage, m_cImage.m_szName);
	}

	switch(m_nKind)
	{
	case Obj_Kind_MapObj:
		g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	case Obj_Kind_Prop:
		if ( m_nState == OBJ_PROP_STATE_DISPLAY )
			g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	default:
		g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	}
#ifdef SWORDONLINE_SHOW_DBUG_INFO
	if (Player[CLIENT_PLAYER_INDEX].m_bDebugMode)
	{
		KRULine	Line;
		int nX, nY;
		SubWorld[0].Map2Mps(m_nRegionIdx, m_nMapX, m_nMapY, 0, 0, &nX, &nY);
		Line.Color.Color_dw = 0xffffffff;
		Line.oPosition.nZ = 0;
		Line.oEndPos.nZ = 0;

		Line.oPosition.nX = nX;
		Line.oPosition.nY = nY;
		Line.oEndPos.nX = nX + 32;
		Line.oEndPos.nY = nY + 32;
		g_pRepresent->DrawPrimitives(1, &Line, RU_T_LINE, 0);

	}
#endif
}

#endif

//-------------------------------------------------------------------------
//	���ܣ�	��������Ĵ���
//-------------------------------------------------------------------------
void	KObj::Activate()
{
	if ( m_nIndex <= 0 )
		return;

#ifdef _SERVER
	int		nEnemyIndex, x, y;
#else
	int		nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
#endif

	switch(m_nKind)
	{
#ifndef _SERVER
	case Obj_Kind_MapObj:					// ��ͼ�������
		if (m_nState == 0)					// ��ͼ�������ѭ������
			m_cImage.GetNextFrame();
		nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
		break;
	case Obj_Kind_Light:					// ��Դ
		if (m_nState == 0)
			m_cImage.GetNextFrame();
		nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
		break;
	case Obj_Kind_LoopSound:				// ѭ����Ч
		PlayLoopSound();
		break;
	case Obj_Kind_RandSound:				// �����Ч
		PlayRandSound();
		break;
	case Obj_Kind_Body:						// ʬ������ʧ
		m_cImage.GetNextFrame(FALSE);		// ʬ�嶯�������򲥷�
		m_nLifeTime--;
		if (m_nLifeTime <= 0)
			Remove(FALSE);
		nMask = IPOT_RL_COVER_GROUND | IPOT_RL_INFRONTOF_ALL;
		break;
#endif
	case Obj_Kind_Box:						// ����
#ifdef _SERVER
		if (m_nState == OBJ_BOX_STATE_OPEN)	// ����ر�����
		{
			m_nBornTime--;
			if (m_nBornTime <= 0)
				SetState(OBJ_BOX_STATE_CLOSE);
		}
#else
		if (m_nState == OBJ_BOX_STATE_CLOSE)// ����ر�״̬
			m_cImage.GetPrevFrame(FALSE);
		else// if (m_nState == OBJ_BOX_STATE_OPEN)// �����״̬
			m_cImage.GetNextFrame(FALSE);
		nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
#endif
		break;
	case Obj_Kind_Door:						// ��
#ifdef _SERVER
#else
		if (m_nState == OBJ_DOOR_STATE_CLOSE)// �Źر�״̬
			m_cImage.GetPrevFrame(FALSE);
		else// if (m_nState == OBJ_DOOR_STATE_OPEN)// �Ŵ�״̬
			m_cImage.GetNextFrame(FALSE);
		nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
#endif
		break;
	case Obj_Kind_Item:						// װ������ѭ������
#ifdef _SERVER
		if (m_nBelong >= 0)
		{
			m_nBelongTime--;
			if (m_nBelongTime <= 0)
			{
				m_nBelongTime = 0;
				m_nBelong = -1;

			}
		}
		m_nLifeTime--;
		if (m_nLifeTime <= 0)
			Remove(FALSE);
#else
		if (this->m_nDropState == 1)		// ��Ʒ��������
		{
			if (m_cImageDrop.GetNextFrame(FALSE))
			{
				if (m_cImageDrop.CheckEnd())
				{
					m_nDropState = 0;			// ��Ʒ���������������ˣ���Ϊ����ѭ������
					m_Image.uImage = 0;
				}
			}
			nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
		}
		else
		{
			if (this->m_nDropState == 2)
			{
				if (m_cImage.GetNextFrame(FALSE))
				{
					if (m_cImage.CheckEnd())
						this->m_nDropState = 0;
				}
			}
			else
			{
				if (g_Random(40) == 0)
				{
					m_nDropState = 2;
				}
				else
				{
					m_cImage.SetDirStart();
				}
			}
			nMask = IPOT_RL_COVER_GROUND | IPOT_RL_INFRONTOF_ALL;
		}
		m_nLifeTime--;
		if (m_nLifeTime <= -100)
			Remove(FALSE);
#endif
		break;
	case Obj_Kind_Money:
#ifdef _SERVER
		if (m_nBelong >= 0)
		{
			m_nBelongTime--;
			if (m_nBelongTime <= 0)
			{
				m_nBelongTime = 0;
				m_nBelong = -1;
			}
		}
		m_nLifeTime--;
		if (m_nLifeTime <= 0)
			Remove(FALSE);
#else
		m_cImage.GetNextFrame();
		nMask = IPOT_RL_COVER_GROUND | IPOT_RL_INFRONTOF_ALL;
		m_nLifeTime--;
		if (m_nLifeTime <= -100)
			Remove(FALSE);
#endif
		break;
	case Obj_Kind_Prop:
#ifdef _SERVER
		if (m_nState == OBJ_PROP_STATE_HIDE)	// ��������״̬
		{
			m_nBornTime--;
			if (m_nBornTime <= 0)
				SetState(OBJ_PROP_STATE_DISPLAY);// ��������
		}
#else
		if (m_nState == OBJ_PROP_STATE_DISPLAY)
		{
			m_cImage.GetNextFrame();
			nMask = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
		}
#endif
		break;
	}
#ifndef _SERVER
	int nMpsX, nMpsY;
	SubWorld[m_nSubWorldID].Map2Mps(m_nRegionIdx, m_nMapX, m_nMapY, m_nOffX, m_nOffY, &nMpsX, &nMpsY);
	g_ScenePlace.MoveObject(CGOG_OBJECT, m_nIndex, nMpsX, nMpsY, 0, m_SceneID, nMask);
#endif
}

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�	����ѭ����Ч
//-------------------------------------------------------------------------
void	KObj::PlayLoopSound()
{
	if (!m_szSoundName[0])
		return;

	m_pSoundNode = (KCacheNode*) g_SoundCache.GetNode(m_szSoundName, (KCacheNode * )m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		if (!m_pWave->IsPlaying())
		{
			m_pWave->Play(GetSoundPan(), GetSoundVolume(), 0);
		}
		else
		{
			m_pWave->SetPan(GetSoundPan());
			m_pWave->SetVolume(GetSoundVolume());
		}
	}
}

//-------------------------------------------------------------------------
//	���ܣ�	���������Ч
//-------------------------------------------------------------------------
void	KObj::PlayRandSound()
{
	if (!m_szSoundName[0])
		return;

	if (g_Random(500) != 0)
		return;

	m_pSoundNode = (KCacheNode*) g_SoundCache.GetNode(m_szSoundName, (KCacheNode * )m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		if (m_pWave->IsPlaying())
			return;
		m_pWave->Play(GetSoundPan(), GetSoundVolume(), 0);
	}
}

//-------------------------------------------------------------------------
//	���ܣ�	�õ����������С
//-------------------------------------------------------------------------
int		KObj::GetSoundPan()
{
	int		nNpcX, nNpcY, nObjX, nObjY;

	SubWorld[Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SubWorldIndex].Map2Mps(
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapX,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapY,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_OffX,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_OffY,
		&nNpcX,
		&nNpcY);
	SubWorld[m_nSubWorldID].Map2Mps(
		m_nRegionIdx,
		m_nMapX,
		m_nMapY,
		m_nOffX,
		m_nOffY,
		&nObjX,
		&nObjY);

	return (nObjX - nNpcX) * 5;
}

//-------------------------------------------------------------------------
//	���ܣ�	�õ�����������С
//-------------------------------------------------------------------------
int		KObj::GetSoundVolume()
{
	int		nNpcX, nNpcY, nObjX, nObjY;

	SubWorld[Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SubWorldIndex].Map2Mps(
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapX,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapY,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_OffX,
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_OffY,
		&nNpcX,
		&nNpcY);
	SubWorld[m_nSubWorldID].Map2Mps(
		m_nRegionIdx,
		m_nMapX,
		m_nMapY,
		m_nOffX,
		m_nOffY,
		&nObjX,
		&nObjY);

	return ((10000 - (abs(nObjX - nNpcX) + abs(nObjY - nNpcY) * 2)) * Option.GetSndVolume() / 100) - 10000;
//	return -((abs(nObjX - nNpcX) + abs(nObjY - nNpcY) * 2) * Option.GetSndVolume() / 100);
}

//-------------------------------------------------------------------------
//	���ܣ�	��������
//-------------------------------------------------------------------------
void	KObj::PlaySound()
{
	if (!m_szSoundName[0])
		return;

	m_pSoundNode = (KCacheNode*) g_SoundCache.GetNode(m_szSoundName, (KCacheNode * )m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		if (m_pWave->IsPlaying())
			return;
		m_pWave->Play(GetSoundPan(), GetSoundVolume(), 0);
	}
}

#endif

//-------------------------------------------------------------------------
//	���ܣ�	��������ű�
//-------------------------------------------------------------------------
void	KObj::ExecScript(int nPlayerIdx)
{
	if (!m_dwScriptID)
		return;
	if (nPlayerIdx < 0)
		return;
	DWORD dwScriptId = m_dwScriptID;//g_FileName2Id(m_szScriptName);
	KLuaScript * pScript = (KLuaScript*)g_GetScript(dwScriptId);
	try
	{
		if (pScript)
		{
			if (Player[nPlayerIdx].m_nIndex < 0) return ;
			Npc[Player[nPlayerIdx].m_nIndex].m_ActionScriptID = dwScriptId;
			Lua_PushNumber(pScript->m_LuaState, Player[nPlayerIdx].GetPlayerIndex());
			pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

			Lua_PushNumber(pScript->m_LuaState, Player[nPlayerIdx].GetPlayerID());
			pScript->SetGlobalName(SCRIPT_PLAYERID);

			Lua_PushNumber(pScript->m_LuaState, Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex);
			pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

			Lua_PushNumber(pScript->m_LuaState, m_nIndex);
			pScript->SetGlobalName(SCRIPT_OBJINDEX);

			int nTopIndex = 0;
			pScript->SafeCallBegin(&nTopIndex);

			BOOL bResult = FALSE;
			bResult = pScript->CallFunction(NORMAL_FUNCTION_NAME, 0, "d", m_nIndex);
			pScript->SafeCallEnd(nTopIndex);

		}
	}
	catch(...)
	{
		printf("-->Error6 Execute: %u [%s]\n", dwScriptId, NORMAL_FUNCTION_NAME);
	}
	return;
}

#ifdef _SERVER
BOOL	KObj::SyncAdd(int nClient)
{
	PHONGTHAN_OBJECT_SNAPSHOT cObjAdd;
	int				nTempX, nTempY;

	ZeroMemory(&cObjAdd, sizeof(cObjAdd));
	PhongThanInitializeWireHeader(&cObjAdd.Header, PHONGTHAN_MSG_WORLD_OBJECT_SNAPSHOT,
		sizeof(cObjAdd), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	cObjAdd.MapId = SubWorld[m_nSubWorldID].m_SubWorldID;
	cObjAdd.RegionId = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_RegionID;
	cObjAdd.ObjectId = m_nID;
	cObjAdd.TemplateId = m_nDataID;
	cObjAdd.Direction = m_nDir;
	cObjAdd.State = m_nState;
	cObjAdd.Frame = m_cImage.m_nCurFrame;
	SubWorld[m_nSubWorldID].Map2Mps(m_nRegionIdx, m_nMapX, m_nMapY, m_nOffX, m_nOffY, &nTempX, &nTempY);
	cObjAdd.X = nTempX;
	cObjAdd.Y = nTempY;
	cObjAdd.Money = m_nMoneyNum;
	cObjAdd.Width = m_nItemWidth;
	cObjAdd.Height = m_nItemHeight;
	cObjAdd.Color = this->m_nColorID;
	cObjAdd.Genre = this->m_nGenre;
	cObjAdd.DetailType = this->m_nDetailType;
	cObjAdd.Flags = 0;
	if (this->m_bOverLook)
		cObjAdd.Flags |= 0x04;
	g_StrCpyLen(cObjAdd.Name, this->m_szName, sizeof(cObjAdd.Name));
	cObjAdd.NameLength = strlen(cObjAdd.Name);

	g_pServer->PackDataToClient(nClient, (BYTE*)&cObjAdd, sizeof(cObjAdd));

	return TRUE;
}

void	KObj::SyncState()
{
	PHONGTHAN_OBJECT_EVENT cObjState;

	ZeroMemory(&cObjState, sizeof(cObjState));
	PhongThanInitializeWireHeader(&cObjState.Header, PHONGTHAN_MSG_WORLD_OBJECT_STATE, sizeof(cObjState), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	cObjState.MapId = SubWorld[m_nSubWorldID].m_SubWorldID;
	cObjState.RegionId = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_RegionID;
	cObjState.ObjectId = m_nID;
	cObjState.Value = (BYTE)m_nState;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].BroadCast((BYTE*)&cObjState, sizeof(cObjState), nMaxCount, m_nMapX, m_nMapY);
	int nConRegion;
	for (int i = 0; i < 8; i++)
	{
		nConRegion = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_nConnectRegion[i];
		if (nConRegion == -1)
			continue;
		SubWorld[m_nSubWorldID].m_Region[nConRegion].BroadCast((BYTE*)&cObjState, sizeof(cObjState), nMaxCount, m_nMapX - POff[i].x, m_nMapY - POff[i].y);
	}
}

void	KObj::SyncDir()
{
	PHONGTHAN_OBJECT_EVENT cObjDir;

	ZeroMemory(&cObjDir, sizeof(cObjDir));
	PhongThanInitializeWireHeader(&cObjDir.Header, PHONGTHAN_MSG_WORLD_OBJECT_DIRECTION, sizeof(cObjDir), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	cObjDir.MapId = SubWorld[m_nSubWorldID].m_SubWorldID;
	cObjDir.RegionId = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_RegionID;
	cObjDir.ObjectId = m_nID;
	cObjDir.Value = (BYTE)m_nDir;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].BroadCast((BYTE*)&cObjDir, sizeof(cObjDir), nMaxCount, m_nMapX, m_nMapY);
	int nConRegion;
	for (int i = 0; i < 8; i++)
	{
		nConRegion = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_nConnectRegion[i];
		if (nConRegion == -1)
			continue;
		SubWorld[m_nSubWorldID].m_Region[nConRegion].BroadCast((BYTE*)&cObjDir, sizeof(cObjDir), nMaxCount, m_nMapX - POff[i].x, m_nMapY - POff[i].y);
	}
}

void	KObj::SyncRemove(BOOL bSoundFlag)
{
	PHONGTHAN_OBJECT_EVENT cObjSyncRemove;

	ZeroMemory(&cObjSyncRemove, sizeof(cObjSyncRemove));
	PhongThanInitializeWireHeader(&cObjSyncRemove.Header, PHONGTHAN_MSG_WORLD_OBJECT_REMOVE, sizeof(cObjSyncRemove), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	cObjSyncRemove.MapId = SubWorld[m_nSubWorldID].m_SubWorldID;
	cObjSyncRemove.RegionId = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_RegionID;
	cObjSyncRemove.ObjectId = m_nID;
	cObjSyncRemove.Value = bSoundFlag ? 1 : 0;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].BroadCast((BYTE*)&cObjSyncRemove, sizeof(cObjSyncRemove), nMaxCount, m_nMapX, m_nMapY);
	int nConRegion;
	for (int i = 0; i < 8; i++)
	{
		nConRegion = SubWorld[m_nSubWorldID].m_Region[m_nRegionIdx].m_nConnectRegion[i];
		if (nConRegion == -1)
			continue;
		SubWorld[m_nSubWorldID].m_Region[nConRegion].BroadCast((BYTE*)&cObjSyncRemove, sizeof(cObjSyncRemove), nMaxCount, m_nMapX - POff[i].x, m_nMapY - POff[i].y);
	}
}

int		KObj::GetItemDataID()
{
	return m_nItemDataID;
}

#endif

#ifdef _SERVER
void	KObj::SetItemBelong(int nPlayerIdx)
{
	m_nBelong = nPlayerIdx;
	if (m_nBelong >= 0)
		this->m_nBelongTime = OBJ_BELONG_TIME;
	else
		this->m_nBelongTime = 0;
}
#endif

#ifdef _SERVER
void	KObj::SetEntireBelong(int nPlayerIdx)
{
	m_nBelong = nPlayerIdx;
	if (m_nBelong >= 0)
		this->m_nBelongTime = this->m_nLifeTime * 2;
	else
		this->m_nBelongTime = 0;
}
#endif

void	KObj::Remove(BOOL bSoundFlag)
{
#ifdef _SERVER
	SyncRemove(bSoundFlag);
#else
	if (bSoundFlag)
	{
		switch (m_nKind)
		{
		case Obj_Kind_Money:
			PlaySound();
			break;
		case Obj_Kind_Box:
		case Obj_Kind_Item:
		case Obj_Kind_Door:
		case Obj_Kind_Prop:
			break;
		}
	}
	m_Image.uImage = 0;
	g_ScenePlace.RemoveObject(CGOG_OBJECT, m_nIndex, m_SceneID);
#endif
	SubWorld[m_nSubWorldID].m_WorldMessage.Send(GWM_OBJ_DEL, m_nIndex);
}

int		KObj::GetKind()
{
	return m_nKind;
}

//-------------------------------------------------------------------------
//	���ܣ�	͹�����ת��Ϊ�ϰ���Ϣ
//-------------------------------------------------------------------------
void	KObj::PolygonChangeToBar(
								 KPolygon Polygon,	// ͹�����
								 int nGridWidth,	// ���ӳ�
								 int nGridHeight,	// ���ӿ�
								 int nTableWidth,	// ����
								 int nTableHeight,	// �����
								 BYTE *lpbBarTable)	// ��������
{
	if ( !lpbBarTable )
		return;
	if (nGridWidth <= 0 || nGridHeight <= 0 || nTableWidth <= 0 || nTableHeight <= 0)
		return;

	int		nTemp, nTempLT, nTempRT, nTempLB, nTempRB, nFlag = 0;
	POINT	TempPos;
	for (int i = 0; i < nTableWidth * nTableHeight; i++)
	{
		Polygon.GetCenterPos(&TempPos);
		// ����
		TempPos.x += ((i % nTableWidth) * nGridWidth) - ((nTableWidth / 2) * nGridWidth + nGridWidth / 2);
		TempPos.y += ((i / nTableWidth) * nGridHeight) - ((nTableHeight / 2) * nGridHeight + nGridHeight / 2);
		nTempLT = Polygon.IsPointInPolygon(TempPos);
		// ����
		TempPos.x += nGridWidth;
		nTempRT = Polygon.IsPointInPolygon(TempPos);
		// ����
		TempPos.x -= nGridWidth;
		TempPos.y += nGridHeight;
		nTempLB = Polygon.IsPointInPolygon(TempPos);
		// ����
		TempPos.x += nGridWidth;
		nTempRB = Polygon.IsPointInPolygon(TempPos);

		nTemp = nTempLT + nTempRT + nTempLB + nTempRB;
		if (nTemp == 0)
			lpbBarTable[i] = Obj_Bar_Empty;
		else if (nTemp > 1)
		{
			lpbBarTable[i] = Obj_Bar_Full;
			nFlag = 1;
		}
		else
		{
			if (nTempLT)
				lpbBarTable[i] = Obj_Bar_LT;
			else if (nTempRT)
				lpbBarTable[i] = Obj_Bar_RT;
			else if (nTempLB)
				lpbBarTable[i] = Obj_Bar_LB;
			else if (nTempRB)
				lpbBarTable[i] = Obj_Bar_RB;
		}
	}

	lpbBarTable[(nTableHeight / 2) * nTableWidth + nTableWidth / 2] = Obj_Bar_Full;
}


#ifdef _SERVER
ServerImage::ServerImage()
{
	Release();
}

void	ServerImage::Release()
{
	m_nTotalFrame = 1;
	m_nCurFrame = 0;
	m_nTotalDir = 1;
	m_nCurDir = 0;
	m_dwTimer = 0;
	m_dwInterval = 0;
	m_nDirFrames = 1;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��֡��
//---------------------------------------------------------------------------
void	ServerImage::SetTotalFrame(int nTotalFrame)
{
	if (nTotalFrame > 0)
	{
		m_nTotalFrame = nTotalFrame;
		m_nDirFrames = m_nTotalFrame / m_nTotalDir;
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ֡
//---------------------------------------------------------------------------
void	ServerImage::SetCurFrame(int nCurFrame)
{
	if (nCurFrame < 0 || nCurFrame >= m_nTotalFrame)
		return;
	m_nCurFrame = nCurFrame;
	if (m_nTotalFrame && m_nTotalDir)
		m_nCurDir = nCurFrame / m_nDirFrames;
	else
		m_nCurDir = 0;
	m_dwTimer = SubWorld[0].m_dwCurrentTime;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨�ܷ�����
//---------------------------------------------------------------------------
void	ServerImage::SetTotalDir(int nTotalDir)
{
	if (nTotalDir > 0)
	{
		m_nTotalDir = nTotalDir;
		m_nDirFrames = m_nTotalFrame / m_nTotalDir;
	}
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ����
//---------------------------------------------------------------------------
BOOL	ServerImage::SetCurDir(int nDir)
{
	if (m_nCurDir == nDir)
		return TRUE;
	if (nDir < 0 || nDir >= m_nTotalDir)
		return FALSE;
	m_nCurDir = nDir;
	m_nCurFrame = m_nDirFrames * nDir;
	m_dwTimer = SubWorld[0].m_dwCurrentTime;
	return FALSE;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨֡���
//---------------------------------------------------------------------------
void	ServerImage::SetInterVal(DWORD dwInterval)
{
	m_dwInterval = dwInterval;
}

//---------------------------------------------------------------------------
//	���ܣ�	��õ�����֡��
//---------------------------------------------------------------------------
int		ServerImage::GetOneDirFrames()
{
	return m_nDirFrames;
}

//---------------------------------------------------------------------------
//	���ܣ�	�ж϶����Ƿ񲥷ŵ���󣬵�ǰ�ǵ� 0 ֡
//---------------------------------------------------------------------------
BOOL	ServerImage::CheckEnd()
{
	if (m_nCurFrame == m_nDirFrames * (m_nCurDir + 1) - 1)
		return TRUE;
	return FALSE;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ����ĵ�ǰ֡Ϊ��һ֡
//---------------------------------------------------------------------------
void	ServerImage::SetDirStart()
{
	m_nCurFrame = m_nCurDir * m_nDirFrames;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ����ĵ�ǰ֡Ϊ���һ֡
//---------------------------------------------------------------------------
void	ServerImage::SetDirEnd()
{
	m_nCurFrame = (m_nCurDir + 1) * m_nDirFrames - 1;
}

//---------------------------------------------------------------------------
//	���ܣ�	ȡ�õ�ǰ�������һ֡
//---------------------------------------------------------------------------
BOOL	ServerImage::GetNextFrame(BOOL bLoop)
{
	if (SubWorld[0].m_dwCurrentTime - m_dwTimer >= m_dwInterval)
	{
		m_dwTimer = SubWorld[0].m_dwCurrentTime;
		m_nCurFrame++;
		if (m_nCurFrame >= m_nDirFrames * (m_nCurDir + 1))
		{
			if (bLoop)
				m_nCurFrame = m_nDirFrames * m_nCurDir;
			else
				m_nCurFrame = m_nDirFrames * (m_nCurDir + 1) - 1;
		}
		return TRUE;
	}

	return FALSE;
}

//---------------------------------------------------------------------------
//	���ܣ�	ȡ�õ�ǰ�����ǰһ֡
//---------------------------------------------------------------------------
BOOL	ServerImage::GetPrevFrame(BOOL bLoop)
{
	if (SubWorld[0].m_dwCurrentTime - m_dwTimer >= m_dwInterval)
	{
		m_dwTimer = SubWorld[0].m_dwCurrentTime;
		m_nCurFrame--;
		if (m_nCurFrame < m_nDirFrames * m_nCurDir)
		{
			if (bLoop)
				m_nCurFrame = m_nDirFrames * (m_nCurDir + 1) - 1;
			else
				m_nCurFrame = m_nDirFrames * m_nCurDir;
		}
		return TRUE;
	}

	return FALSE;
}

//---------------------------------------------------------------------------
//	���ܣ�	�趨��ǰ����(�������64����ת���������ķ���)
//---------------------------------------------------------------------------
BOOL	ServerImage::SetCurDir64(int nDir)
{
	if (nDir < 0 || nDir >= 64)
		return FALSE;

	int nTempDir;

	nTempDir = (nDir + (32 / m_nTotalDir)) / (64 / m_nTotalDir);
	if (nTempDir >= m_nTotalDir)
		nTempDir -= m_nTotalDir;
	if (m_nCurDir == nTempDir)
		return TRUE;
	m_nCurDir = nTempDir;
	m_nCurFrame = m_nDirFrames * nTempDir;
	m_dwTimer = SubWorld[0].m_dwCurrentTime;
	return FALSE;
}

//---------------------------------------------------------------------------
//	���ܣ�	��õ�ǰ����ڼ�֡
//---------------------------------------------------------------------------
int		ServerImage::GetCurDirFrameNo()
{
	return m_nCurFrame - m_nCurDir * m_nDirFrames;
}

#endif

void KObj::GetMpsPos(int *pX, int *pY)
{
	SubWorld[m_nSubWorldID].Map2Mps(m_nRegionIdx, m_nMapX, m_nMapY, m_nOffX, m_nOffY, pX, pY);
}

#ifndef _SERVER
void KObj::DrawBorder()
{
	if (m_bDrawFlag)
		return;

	m_Image.bRenderStyle = IMAGE_RENDER_STYLE_BORDER_RECT;
	switch(m_nKind)
	{
	case Obj_Kind_MapObj:
		g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	case Obj_Kind_Prop:
		if ( m_nState == OBJ_PROP_STATE_DISPLAY )
			g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	default:
		g_pRepresent->DrawPrimitives(1, &m_Image, RU_T_IMAGE, 0);
		break;
	}
	m_Image.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
}
#endif


int KObj::GetDistanceSquare(int nNpcIndex)
{
	int	nRet = 0;
	if ( m_nSubWorldID != Npc[nNpcIndex].m_SubWorldIndex)
		return -1;

	int XOff = 0;
	int YOff = 0;

	if (m_nRegionIdx == Npc[nNpcIndex].m_RegionIndex)
	{
		XOff = (m_nMapX - Npc[nNpcIndex].GetMapX()) * REGION_CELL_SIZE_X;
		XOff += (m_nOffX - Npc[nNpcIndex].GetOffX()) >> 10;

		YOff = (m_nMapY - Npc[nNpcIndex].GetMapY()) * REGION_CELL_SIZE_Y;
		YOff += (m_nOffY - Npc[nNpcIndex].GetOffY()) >> 10;
	}
	else
	{
		int X1, Y1;
		int X2, Y2;
		GetMpsPos( &X1, &Y1 );
		Npc[nNpcIndex].GetMpsPos( &X2, &Y2 );

		XOff = (X2 - X1);
		YOff = (Y2 - Y1);
	}

	nRet = (int)(XOff * XOff + YOff * YOff);

	return nRet;
}
