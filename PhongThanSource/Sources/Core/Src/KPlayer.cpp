#include "KCore.h"
#include "PhongThanPlayerProtocol.h"
#include "PhongThanGameplayProtocol.h"
#ifndef WM_MOUSEHOVER
#define WM_MOUSEHOVER 0x02A1
#endif
#include "KEngine.h"
#ifdef _SERVER
//#include "KNetServer.h"
//#include "../MultiServer/Heaven/Interface/iServer.h"
#else
//#include "KNetClient.h"
#include "../../Headers/IClient.h"
#include "Scene/KScenePlaceC.h"
#include "KIme.h"
#endif
#include "KNpc.h"
#include "KObj.h"
#include "KNpcSet.h"
#include "KSubWorld.h"
#include "KPlayer.h"
#include "PhongThanScriptWire.h"
#include "ImgRef.h"

#include "LuaFuns.h"
#include "KSortScript.h"
#include "KScriptValueSet.h"
#include "KObjSet.h"
#include "KSkills.h"
#include "KPlayerSet.h"
#include "KSubWorldSet.h"
#include "KFile.h"
#include "GameDataDef.h"
#include "KBuySell.h"
#include "KTongData.h"
//#include "MyAssert.h"
#include "MsgGenreDef.h"
#include "KItemSet.h"
#include "KTaskFuns.h"
#include "Text.h"
#include "KMath.h"
#include "KPhongThanAppearance.h"
#include "ItemActionDiag.h"

//new sql
#include <sqlext.h>
#include <sqltypes.h>
#include <sql.h>
#include <string.h>
#ifdef _SERVER
//#include "../AccountServices/AccountServer/S3PDB_MSSQLServer_Connection.h"
//#include "../AccountServices/AccountServer/KThread.h" //msado15.tlh
#include "../AccountServices/AccountServer/msado15.tlh"
//#include <mysql.h>
#pragma comment(lib, "Ws2_32.lib")	// anti 3 acc by veg
#include "inoutmac.h"		//veg
#include "../AccountServices/RelayServer/S3PAccount.h" //S3PDBConVBC
#include "../../AccountServices/AccountServer/S3PDBConVBC.h"
#else
#include "CoreShell.h"
#endif

#include "KMath.h"

#define		defPLAYER_LOGIN_TIMEOUT			10 * 20// 10 sec
#define		defPLAYER_SAVE_TIMEOUT			30 * 20
#define		defPLAYER_TRADE_STATE			5000

#define		PLAYER_PREFIX_LEVEL				1
#define		PLAYER_LEVEL_1_EXP				48
#define		PLAYER_LEVEL_ADD_ATTRIBUTE		5
#define		PLAYER_LEVEL_ADD_SKILL			1
#define		PLAYER_TEAM_EXP_ADD				50

#define		MAX_APPLY_TEAM_TIME				500

#define		BASE_WALK_SPEED					5
#define		BASE_RUN_SPEED					10

//TamLTM Khang max option 75
#define		BASE_FIRE_RESIST_MAX			75
#define		BASE_COLD_RESIST_MAX			75
#define		BASE_POISON_RESIST_MAX			75
#define		BASE_LIGHT_RESIST_MAX			75
#define		BASE_EARTH_RESIST_MAX			75
#define		BASE_PHYSICS_RESIST_MAX			75

#define		BASE_ATTACK_SPEED				0
#define		BASE_CAST_SPEED					0
#define		BASE_VISION_RADIUS				120
#define		BASE_HIT_RECOVER				6

#define		TOWN_PORTAL_TIME				1800

KPlayer	Player[MAX_PLAYER];

//-------------------------------------------------------------------------
//	���ܣ����캯��
//-------------------------------------------------------------------------
KPlayer::KPlayer()
{
    Release();
}

//-------------------------------------------------------------------------
//	���ܣ���������
//-------------------------------------------------------------------------
KPlayer::~KPlayer()
{
    Release();
}

//-------------------------------------------------------------------------
//	���ܣ����
//-------------------------------------------------------------------------

void	KPlayer::Release()
{
#ifndef _SERVER
    m_RunStatus = 0;
    m_nNextLevelLeadExp = 0;
    m_nLeftSkillID = 0;
    m_nLeftSkillLevel = 0;
    m_nRightSkillID = 0;
    m_nRightSkillLevel = 0;
    m_nSendMoveFrames = defMAX_PLAYER_SEND_MOVE_FRAME;
    m_MouseDown[0] = FALSE;
    m_MouseDown[1] = FALSE;
    m_dwRightMouse = 0;
    m_bDebugMode	= FALSE;

    m_MissionData.Clear();
    memset(m_MissionRank, 0, sizeof(m_MissionRank));
    m_cAI.Release();
#endif
    m_dwID = 0;
    m_nIndex = 0;
	m_nLastNpcIndex = 0;
    m_nNetConnectIdx = -1;
    m_cMenuState.Release();
    m_cTrade.Release();
    m_cTong.Clear();
    m_cTask.Release();
    m_cRoom.Release();
    m_nAttributePoint = 0;
    m_nSkillPoint = 0;

    m_nStrength = 0;
    m_nDexterity = 0;
    m_nVitality = 0;
    m_nEngergy = 0;
    m_nLucky = 0;
    m_nCurStrength = 0;
    m_nCurDexterity = 0;
    m_nCurVitality = 0;
    m_nCurEngergy = 0;

    m_nExp = 0;
    m_nNextLevelExp = PLAYER_LEVEL_1_EXP;
    m_bExchangeServer = FALSE;
    m_bLockState = FALSE;
    m_LockMove.Release();
    m_dwEquipExpandTime = 0;
    m_btRepositoryNum = 0;
    m_nLeadExp = 0;
    m_nLeadLevel = 1;

    //TamLTM Hiden npc and player
    m_bIsHideNpc = FALSE;
    m_bIsHidePlayer = FALSE;
    //end code

    //TamLTM Fix set save pass Khoa ruong
    m_bLock = FALSE;
    m_bOk = FALSE;
    //end code

    m_nPeapleIdx = 0;
    m_nObjectIdx = 0;
    m_bWaitingPlayerFeedBack = false;
    m_UiDialogSerial = 0;
    m_UiDialogToken = 0;
    m_UiDialogView = 0;
	m_nPhongThanTaskState = 0;
	m_nPhongThanTaskSubState = 0;
	m_dwPhongThanTaskRevision = 0;
    m_btTryExecuteScriptTimes = 0;	//

    m_TalkUiScriptId = 0;
    m_SelUiScriptId = 0;

    m_nKillPeopleNumber = 0;  //Pk 10

    //TamLTM code
    m_nExtPoint = 0; //TamLTM fix code xu;
    m_nChangeExtPoint = 0;
    m_nMacDatabase = 0; //TamLTM nMac data sql
    m_nVersionGame = 0;

    //TamLTM code Check get hardware pc
    m_bNotPickUpItem = FALSE;
    m_bNotPickUpMoney = FALSE;

    //end code

#ifdef _SERVER
    m_bUseReviveIdWhenLogin = 0;
	m_dwDeathScriptId = 0;
	m_dwDamageScriptId = 0;
	m_dwTaskExcuteScriptId = 0;
	memset(m_szTaskExcuteFun, 0, sizeof(m_szTaskExcuteFun));
	memset(m_szLastInput, 0, sizeof(m_szLastInput));
	m_nPaceBarTime = 0;
	m_nPaceBarTimeMax = 0;
//	m_byLixian = LIXIAN_IDLE;
	memset(m_szLastName, 0, sizeof(m_szLastName));

	m_sLoginRevivalPos.m_nSubWorldID = 0;
	m_sLoginRevivalPos.m_nMpsX = 0;
	m_sLoginRevivalPos.m_nMpsY = 0;

	m_sDeathRevivalPos.m_nSubWorldID = 0;
	m_sDeathRevivalPos.m_nMpsX = 0;
	m_sDeathRevivalPos.m_nMpsY = 0;

	m_sPortalPos.m_nSubWorldId = 0;
	m_sPortalPos.m_nTime = 0;
	m_sPortalPos.m_nMpsX = 0;
	m_sPortalPos.m_nMpsY = 0;

	m_pLastScriptCacheNode = NULL;
	m_dwLoginTime			= -1;
	//	m_uLastPingTime			= -1;
	m_bFinishLoading = FALSE;
	m_uMustSave = SAVE_IDLE;
	m_bIsQuiting = FALSE;
	m_TimerTask.SetOwner(this);
	m_bSleepMode = FALSE;
	m_nLastNetOperationTime = 0;
	m_nPrePayMoney = 0;
	m_nForbiddenTm = 0;
	m_bForbidEnmity = FALSE;
	m_bForbidTrade = FALSE;
	m_bForbidTrade = FALSE;
	m_bForbidUseTownP = FALSE;
	m_bForbidName = 0;
	m_PlayerDBLoad = FALSE;
	m_ImagePlayer = 0;
	PhongThanRouletteClear();

	//	ZeroMemory(m_SaveBuffer, sizeof(m_SaveBuffer));

	//GetHardwareIDPC();
	//end code
#endif
}

//-------------------------------------------------------------------------
//	���ܣ��趨 m_nPlayerIndex (������ֻ������PlayerSet��Init�е���)
//-------------------------------------------------------------------------
void	KPlayer::SetPlayerIndex(int nNo)
{
    if (nNo < 0)
        m_nPlayerIndex = 0;
    else
        m_nPlayerIndex = nNo;
}

//-------------------------------------------------------------------------

//	���ܣ���ñ�ʵ���� Player �����е�λ��
//-------------------------------------------------------------------------
int		KPlayer::GetPlayerIndex()
{
    return m_nPlayerIndex;
}

//-------------------------------------------------------------------------
//	���ܣ����ÿ����Ϸѭ������Ҫ�����Ķ���
//-------------------------------------------------------------------------
void	KPlayer::Active()
{

#ifdef _SERVER
    if (m_nNetConnectIdx == -1 || m_bExchangeServer)
	{
		// Disconnect/logout/server exchange: drop a running Can Khon Luan spin (no reward).
		PhongThanRouletteAbort("offline", FALSE);
		return;
	}

	//ʱ������Ĵ���
	m_TimerTask.Activate(g_PlayerTimerCallBackFun);
	this->SendCurNormalSyncData();
	PhongThanRouletteActive();

	if (m_nPaceBarTime)
	{
		m_nPaceBarTime--;
		if (m_nPaceBarTime == 0)
		{
			if (m_szTaskExcuteFun[0])
				this->ExecuteScript(m_dwTaskExcuteScriptId, m_szTaskExcuteFun, 0);
		}
	}

	// ��ɱ����ʱ
	this->m_cPK.Active();
	this->m_cRoom.Active();
#define	defMAX_SLEEP_TIME	3600
	if (Npc[m_nIndex].m_FightMode == 0 && m_bSleepMode == FALSE && g_SubWorldSet.GetGameTime() - m_nLastNetOperationTime > defMAX_SLEEP_TIME)
	{
		NPC_SLEEP_SYNC	SleepSync;
		SleepSync.ProtocolType = s2c_npcsleepmode;
		SleepSync.bSleep = 1;
		SleepSync.NpcID = Npc[m_nIndex].m_dwID;
		Npc[m_nIndex].SendDataToNearRegion(&SleepSync, sizeof(NPC_SLEEP_SYNC));
		m_bSleepMode = TRUE;
	}
#else
    // ���������˵Ĵ���
    if ( !m_cTeam.m_nFlag )
    {
        if (m_cTeam.m_nApplyCaptainID > 0)
        {
            if ( m_cTeam.m_dwApplyTimer == 0 )
            {
                m_cTeam.m_nApplyCaptainID = 0;

            }
            else
            {
                m_cTeam.m_dwApplyTimer--;
                if ( !NpcSet.SearchID(m_cTeam.m_nApplyCaptainID) )
                {
                    m_cTeam.m_nApplyCaptainID = 0;
                    m_cTeam.m_dwApplyTimer = 0;
                }
            }
        }
    }
        // �ӳ��Ĵ���
    else if (m_cTeam.m_nFigure == TEAM_CAPTAIN)
    {
        for (int i = 0; i < MAX_TEAM_APPLY_LIST; i++)
        {
            if (m_cTeam.m_sApplyList[i].m_dwNpcID > 0)
            {
                if (m_cTeam.m_sApplyList[i].m_dwTimer == 0)
                {
                    m_cTeam.m_sApplyList[i].m_dwNpcID = 0;
                    m_cTeam.UpdateInterface();
                }
                else
                {
                    m_cTeam.m_sApplyList[i].m_dwTimer--;
                    if ( !Npc[this->m_nIndex].SearchAroundID(m_cTeam.m_sApplyList[i].m_dwNpcID) )
                    {
                        m_cTeam.m_sApplyList[i].m_dwNpcID = 0;
                        m_cTeam.m_sApplyList[i].m_dwTimer = 0;
                        m_cTeam.UpdateInterface();
                    }
                }
            }
        }
    }

    m_nSendMoveFrames++;

    // ��ɱ����ʱ
    this->m_cPK.Active();
    this->m_cAI.Active();

#endif
}

#ifdef _SERVER
//-------------------------------------------------------------------------
// Phong Than 2026-10-02: Can Khon Luan (Thai Tue Su, npc_fix\1020_thai_tue.lua).
// Lua Roulette(k[, "name0|name1|..."]) starts a spin; KPlayer::Active shows a slowing
// sequence of sector names as top messages, stops on sector k, then calls the script's
// Finished() which gives the reward. Strings are TCVN3 (same as the VNG scripts).
//-------------------------------------------------------------------------
#define PT_ROULETTE_STEPS			20			// animated steps, the last one is sector k
#define PT_ROULETTE_FINAL_PAUSE		GAME_FPS	// pause on the result before Finished()

static const char * const s_szPhongThanRouletteDefaultNames[12] =
{
	"Ng\xf2 Qu\xfb",						// 0 Ngu Quy
	"\xa7\xb9i Hao",						// 1 Dai Hao
	"B\xb9""ch H\xe6",						// 2 Bach Ho
	"Thi\xaan C\xc8u",						// 3 Thien Cau
	"B\xb8""ch Vi\xd6t",					// 4 Bach Viet
	"T\xf6 Vi",								// 5 Tu Vi
	"Thi\xaan \xa7\xf8""c",					// 6 Thien Duc
	"Th\xb8i \xa2m",						// 7 Thai Am
	"Th\xb8i D\xad\xacng",					// 8 Thai Duong
	"Th\xb8i Tu\xd5",						// 9 Thai Tue
	"Ti\xd3u Hao",							// 10 Tieu Hao
	"D\xde""ch M\xb7",						// 11 Dich Ma
};
static const char s_szPhongThanRouletteSpin[]  = "C\xb5n Kh\xabn Lu\xa9n \xae""ang quay: ";	// "Can Khon Luan dang quay: "
static const char s_szPhongThanRouletteStop[]  = "C\xb5n Kh\xabn Lu\xa9n d\xf5ng t\xb9i: ";		// "Can Khon Luan dung tai: "
static const char s_szPhongThanRouletteAbort[] = "C\xb5n Kh\xabn Lu\xa9n b\xde gi\xb8n \xaeo\xb9n, l\xad\xeet quay n\xb5y kh\xabng c\xe3 ph\xc7n th\xad\xebng.";

void KPlayer::PhongThanRouletteClear()
{
	m_nRouletteK = -1;
	m_nRouletteCount = 0;
	m_nRouletteStep = 0;
	m_nRouletteSubWorld = -1;
	m_dwRouletteNextFrame = 0;
	m_dwRouletteScriptId = 0;
	memset(m_szRouletteNames, 0, sizeof(m_szRouletteNames));
}

void KPlayer::PhongThanRouletteSend(const char* pszText)
{
	if (!pszText || !pszText[0] || m_nNetConnectIdx < 0)
		return;
	KPhongThanScriptAction UiInfo;
	ZeroMemory(&UiInfo, sizeof(UiInfo));
	UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
	UiInfo.View = UI_TOPMESSAGE;
	g_StrCpyLen(UiInfo.Content, pszText, sizeof(UiInfo.Content));
	UiInfo.ResourceText = 0;
	UiInfo.ContentLength = (int)strlen(UiInfo.Content);
	UiInfo.ServerOwned = 1;
	DoScriptAction(&UiInfo);
}

BOOL KPlayer::PhongThanRouletteStart(int nWinK, DWORD dwScriptId, const char* pszNames)
{
	if (m_nRouletteK >= 0)			// one spin at a time
		return FALSE;
	if (!dwScriptId || m_nIndex <= 0 || m_nIndex >= MAX_NPC || m_nNetConnectIdx < 0)
		return FALSE;

	memset(m_szRouletteNames, 0, sizeof(m_szRouletteNames));
	int nCount = 0;
	if (pszNames && pszNames[0])
	{
		const char* p = pszNames;
		while (*p && nCount < PT_ROULETTE_MAX_SECTORS)
		{
			const char* e = strchr(p, '|');
			int nLen = e ? (int)(e - p) : (int)strlen(p);
			int nCopy = nLen < PT_ROULETTE_NAME_LEN - 1 ? nLen : PT_ROULETTE_NAME_LEN - 1;
			memcpy(m_szRouletteNames[nCount], p, nCopy);
			m_szRouletteNames[nCount][nCopy] = 0;
			nCount++;
			if (!e)
				break;
			p = e + 1;
		}
	}
	if (nCount < 2)
	{
		nCount = 12;
		for (int i = 0; i < nCount; i++)
			g_StrCpyLen(m_szRouletteNames[i], s_szPhongThanRouletteDefaultNames[i], PT_ROULETTE_NAME_LEN);
	}
	if (nWinK < 0)
		nWinK = 0;
	nWinK %= nCount;

	m_nRouletteCount = nCount;
	m_nRouletteK = nWinK;
	m_nRouletteStep = 0;
	m_nRouletteSubWorld = Npc[m_nIndex].m_SubWorldIndex;
	m_dwRouletteScriptId = dwScriptId;
	m_dwRouletteNextFrame = (DWORD)g_SubWorldSet.GetGameTime();
	g_DebugLog("[Roulette] start player=%d k=%d count=%d script=%u", m_nPlayerIndex, nWinK, nCount, dwScriptId);
	return TRUE;
}

void KPlayer::PhongThanRouletteAbort(const char* pszReason, BOOL bNotify)
{
	if (m_nRouletteK < 0)
		return;
	g_DebugLog("[Roulette] abort player=%d reason=%s k=%d step=%d", m_nPlayerIndex,
		pszReason ? pszReason : "", m_nRouletteK, m_nRouletteStep);
	PhongThanRouletteClear();
	if (bNotify)
		PhongThanRouletteSend(s_szPhongThanRouletteAbort);
}

void KPlayer::PhongThanRouletteActive()
{
	if (m_nRouletteK < 0)
		return;
	if (m_nIndex <= 0 || m_nIndex >= MAX_NPC)
	{
		PhongThanRouletteAbort("npc", FALSE);
		return;
	}
	if (Npc[m_nIndex].m_Doing == do_death || Npc[m_nIndex].m_Doing == do_revive || Npc[m_nIndex].m_CurrentLife <= 0)
	{
		PhongThanRouletteAbort("death", TRUE);
		return;
	}
	if (Npc[m_nIndex].m_SubWorldIndex != m_nRouletteSubWorld)
	{
		PhongThanRouletteAbort("map", TRUE);
		return;
	}

	DWORD dwNow = (DWORD)g_SubWorldSet.GetGameTime();
	if (dwNow < m_dwRouletteNextFrame)
		return;

	if (m_nRouletteStep >= PT_ROULETTE_STEPS)
	{
		// Spin finished on sector k: clear the state first (Finished may start a new spin,
		// e.g. Ngu Quy offers another roll), then let the script give the reward.
		DWORD dwScriptId = m_dwRouletteScriptId;
		int nWinK = m_nRouletteK;
		PhongThanRouletteClear();
		g_DebugLog("[Roulette] finished player=%d k=%d script=%u", m_nPlayerIndex, nWinK, dwScriptId);
		ExecuteScript(dwScriptId, "Finished", nWinK);
		return;
	}

	// Positions advance one sector per step and land exactly on k at the last step.
	int nPos = (m_nRouletteK - (PT_ROULETTE_STEPS - 1 - m_nRouletteStep)) % m_nRouletteCount;
	if (nPos < 0)
		nPos += m_nRouletteCount;

	char szText[256];
	if (m_nRouletteStep == PT_ROULETTE_STEPS - 1)
	{
		_snprintf(szText, sizeof(szText) - 1, "%s<color=yellow>%s", s_szPhongThanRouletteStop, m_szRouletteNames[nPos]);
		m_dwRouletteNextFrame = dwNow + PT_ROULETTE_FINAL_PAUSE;
	}
	else
	{
		_snprintf(szText, sizeof(szText) - 1, "%s%s", s_szPhongThanRouletteSpin, m_szRouletteNames[nPos]);
		// Slowing down: 2 frames at first, about 11 frames (0.6 s) near the end; ~5.5 s in total.
		m_dwRouletteNextFrame = dwNow + 2 + (m_nRouletteStep * m_nRouletteStep) / 40;
	}
	szText[sizeof(szText) - 1] = 0;
	PhongThanRouletteSend(szText);
	m_nRouletteStep++;
}
#endif


void	KPlayer::ProcessMsg(KWorldMsgNode *lpMsg)
{
    switch (lpMsg->m_dwMsgType)
    {
        case GWM_PLAYER_SKILL:
            break;
        case GWM_PLAYER_RUNTO:
            break;
        case GWM_PLAYER_WALKTO:
            break;
        case GWM_PLAYER_JUMPTO:
            break;
        default:
            break;
    }
}

#ifndef _SERVER
void KPlayer::ProcessInputMsg(UINT uMsg, WPARAM wParam, LPARAM lParam)
{
//	g_DebugLog("ProcessInputMsg KPlayer 2");
    switch(uMsg)
    {
        case WM_MOUSEMOVE:
        case WM_MOUSEHOVER:
            if (wParam & MK_LBUTTON)
            {
                OnButtonMove(LOWORD(lParam), HIWORD(lParam),
                             (wParam & ~(MK_LBUTTON | MK_MBUTTON | MK_RBUTTON)), button_left);
                //	g_DebugLog("WM_MOUSEHOVER MK_LBUTTON KPlayer");
            }
            else if (wParam & MK_RBUTTON)
            {
                OnButtonMove(LOWORD(lParam), HIWORD(lParam),
                             (wParam & ~(MK_LBUTTON | MK_MBUTTON | MK_RBUTTON)), button_right);
                //	g_DebugLog("WM_MOUSEHOVER MK_RBUTTON KPlayer");
            }
            else
            {
                OnMouseMove(LOWORD(lParam), HIWORD(lParam));
                //	g_DebugLog("WM_MOUSEHOVER else KPlayer");
            }
            break;

        case WM_LBUTTONUP:
            OnButtonUp(LOWORD(lParam), HIWORD(lParam), button_left);
            //	g_DebugLog("WM_MOUSEHOVER OnButtonUp KPlayer");
            break;

        case WM_LBUTTONDOWN:
            OnButtonDown(LOWORD(lParam), HIWORD(lParam),
                         (wParam & ~(MK_LBUTTON | MK_MBUTTON | MK_RBUTTON)), button_left);
            //	g_DebugLog("WM_MOUSEHOVER WM_LBUTTONDOWN KPlayer");
            break;

        case WM_RBUTTONUP:
            OnButtonUp(LOWORD(lParam), HIWORD(lParam), button_right);
            break;

        case WM_RBUTTONDOWN:
            OnButtonDown(LOWORD(lParam), HIWORD(lParam),
                         (wParam & ~(MK_LBUTTON | MK_MBUTTON | MK_RBUTTON)), button_right);
            break;
    }
}

void KPlayer::OnButtonDown(int x,int y, int Key, MOUSE_BUTTON nButton)
{

    m_MouseDown[(int)nButton] = TRUE;

    FindSelectNpc(x, y, relation_all);
    FindSelectObject(x, y);
    ProcessMouse(x, y, Key, nButton);
}

void KPlayer::OnButtonMove(int x,int y,int Key, MOUSE_BUTTON nButton)
{
    if (m_MouseDown[(int)nButton])
    {
        ProcessMouse(x, y, Key, nButton);
    }
}

void KPlayer::OnButtonUp(int x,int y,MOUSE_BUTTON nButton)
{
    m_MouseDown[(int)nButton] = 0;
}

void KPlayer::OnMouseMove(int x,int y)
{
    m_nPeapleIdx = 0;
    m_nObjectIdx = 0;
    FindSelectNpc(x, y, relation_all);
    FindSelectObject(x, y);
    if (m_nPeapleIdx)
    {
        if (Npc[m_nPeapleIdx].m_Kind == kind_player &&
            Npc[m_nPeapleIdx].m_PTrade.nTrade && GetKeyState(VK_CONTROL) & 0x8000)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_TRADE);
        else if (Npc[m_nPeapleIdx].m_Kind == kind_dialoger)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_DIALOG);
        else if (NpcSet.GetRelation(m_nIndex, m_nPeapleIdx) == relation_enemy)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_FIGHT);
        else
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_NORMAL);
    }
    else if (m_nObjectIdx)
    {
        if (Object[m_nObjectIdx].m_nKind == Obj_Kind_MapObj)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_DIALOG);
        else if (Object[m_nObjectIdx].m_nKind == Obj_Kind_Item || Object[m_nObjectIdx].m_nKind == Obj_Kind_Money)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_PICK);
        else if (Object[m_nObjectIdx].m_nKind == Obj_Kind_Prop)
            CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_USE);
    }
    else
        CoreDataChanged(GDCNI_SWITCH_CURSOR, NULL, MOUSE_CURSOR_NORMAL);
}

void KPlayer::ProcessMouse(int x, int y, int Key, MOUSE_BUTTON nButton)
{
#ifndef _SERVER
    // Phong Than 2026-10-03 autofight:H2 a manual click or drag in the game world pauses auto fight.
    { extern void PTAutoFight_OnManualInput(); PTAutoFight_OnManualInput(); }
    // Phong Than 2026-10-04 timduong:H2 ... and ends a go-to-coordinates trip (PhongThanGoTo.inl).
    { extern void PTGoTo_OnManualInput(); PTGoTo_OnManualInput(); }
#endif
    if (CheckTrading())
        return;

    if (m_ItemList.m_Hand > 0)
    {
        if (nButton == button_left)
        {
            ThrowAwayItem();
            return;
        }
    }

    int nX = x;
    int nY = y;
    int nZ = 0;
    g_ScenePlace.ViewPortCoordToSpaceCoord(nX, nY, nZ);

    if (Npc[m_nIndex].IsCanInput())
    {
        int nIdx = 0;

        if (nButton == button_right)
        {
            nIdx = Npc[m_nIndex].m_SkillList.FindSame(m_nRightSkillID);
        }
        else
        {
            nIdx = Npc[m_nIndex].m_SkillList.FindSame(m_nLeftSkillID);
        }
        Npc[m_nIndex].SetActiveSkill(nIdx);
    }
    else
    {
        Npc[m_nIndex].m_nPeopleIdx = 0;
        return;
    }

    if ((Key & MK_SHIFT) || (nButton == button_right))
    {
        if (Npc[m_nIndex].m_ActiveSkillID > 0)
        {
            ISkill * pISkill = (KSkill *) g_SkillManager.GetSkill(Npc[m_nIndex].m_ActiveSkillID, 1);
            if (!pISkill)
                return;

            if (pISkill->IsAura())
                return;
            int nAttackRange = pISkill->GetAttackRadius();

            int nTargetIdx = 0;
            //			m_nPeapleIdx = 0;
            //����Object / Enemy / Ally �����ȼ��ҵ���Ҫ��Ķ���id


            if (pISkill->IsTargetAlly())
            {
                FindSelectNpc(x, y, relation_ally);
                if (m_nPeapleIdx)
                {
                    nTargetIdx = m_nPeapleIdx;
                }
            }

            if (pISkill->IsTargetEnemy())
            {
                FindSelectNpc(x, y, relation_enemy);
                if (m_nPeapleIdx)
                {
                    nTargetIdx = m_nPeapleIdx;
                }
            }

            if (pISkill->IsTargetObj())
            {
                FindSelectObject(x, y);
                if (m_nObjectIdx)
                {
                    nTargetIdx = m_nObjectIdx;
                }
            }
            //������ܱ���ָ�����󣬶���ǰλ���޶���Ļ���ֱ���˳�
            if (pISkill->IsTargetOnly() && !nTargetIdx)
            {
                Npc[m_nIndex].m_nPeopleIdx = 0;
                m_nPeapleIdx = 0;
                return;
            }

            if (m_nIndex == nTargetIdx)
            {
                Npc[m_nIndex].m_nPeopleIdx = 0;
                m_nPeapleIdx = 0;
                return;
            }

            if ((!Npc[m_nIndex].m_SkillList.CanCast(Npc[m_nIndex].m_ActiveSkillID, SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_dwCurrentTime))
                ||
                (!Npc[m_nIndex].Cost(pISkill->GetSkillCostType() , pISkill->GetSkillCost(&Npc[m_nIndex]), TRUE))
                    )
            {
                Npc[m_nIndex].m_nPeopleIdx = 0;
                m_nPeapleIdx = 0;
                return ;
            }
            //�޶���ֱ�ӷ�����
            if (!nTargetIdx)
            {
                Npc[m_nIndex].SendCommand(do_skill, Npc[m_nIndex].m_ActiveSkillID, nX, nY);
                SendClientCmdSkill(Npc[m_nIndex].m_ActiveSkillID, nX, nY);
            }
            else
            {
                if (pISkill->IsTargetOnly())
                {
                    if (NpcSet.GetDistance(m_nIndex , nTargetIdx) > pISkill->GetAttackRadius())
                    {
                        m_nPeapleIdx = nTargetIdx;
                        return ;
                    }
                }

                if (m_nIndex == nTargetIdx && pISkill->GetSkillStyle() == SKILL_SS_Missles)
                    return ;
                if (NpcSet.GetDistance(m_nIndex , nTargetIdx) <= pISkill->GetAttackRadius())
                {
                    Npc[m_nIndex].SendCommand(do_skill, Npc[m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
                    SendClientCmdSkill(Npc[m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
                }
            }
        }
        Npc[m_nIndex].m_nPeopleIdx = 0;
        return;
    }


	if (Key == 0 )
	{
		int nRelation = NpcSet.GetRelation(m_nIndex, m_nPeapleIdx);
		if (nRelation == relation_dialog && m_nPeapleIdx > 0 &&
			Npc[m_nPeapleIdx].m_Kind == kind_dialoger)
		{
			if (NpcSet.GetDistance(m_nIndex, m_nPeapleIdx) <= Npc[m_nPeapleIdx].m_DialogRadius)
			{
				DialogNpc(m_nPeapleIdx);
				Npc[m_nIndex].m_nPeopleIdx = 0;
				return;
			}
			Npc[m_nIndex].m_nPeopleIdx = m_nPeapleIdx;
		}
		else if (nRelation == relation_enemy)
		{
			Npc[m_nIndex].m_nPeopleIdx = m_nPeapleIdx;
		}

        if (m_nSendMoveFrames >= defMAX_PLAYER_SEND_MOVE_FRAME)
        {
            m_nPickObjectIdx = m_nObjectIdx;
            Npc[m_nIndex].m_nObjectIdx = m_nPickObjectIdx;
            if (!m_RunStatus)
            {
                Npc[m_nIndex].SendCommand(do_walk, nX, nY);
                // Send to Server
                SendClientCmdWalk(nX, nY);
            }
            else
            {
                Npc[m_nIndex].SendCommand(do_run, nX, nY);
                // Send to Server
                SendClientCmdRun(nX, nY);
            }
            m_nSendMoveFrames = 0;
        }
        return;
    }
}
void KPlayer::Walk(int nDir, int nSpeed)
{
    int	nMapX = Npc[m_nIndex].m_MapX;
    int nMapY = Npc[m_nIndex].m_MapY;
    int	nOffX = Npc[m_nIndex].m_OffX;
    int	nOffY = Npc[m_nIndex].m_OffY;
    int	nSubWorld = Npc[m_nIndex].m_SubWorldIndex;
    int	nRegion = Npc[m_nIndex].m_RegionIndex;
    int	nX, nY;

    SubWorld[nSubWorld].Map2Mps(nRegion, nMapX, nMapY, nOffX, nOffY, &nX, &nY);
    SubWorld[nSubWorld].GetMps(&nX, &nY, nSpeed * 2, nDir);

    if (m_RunStatus)
    {
        Npc[m_nIndex].SendCommand(do_run, nX, nY);
        // Send to Server
        if ( !CheckTrading() )
            SendClientCmdRun(nX, nY);
    }
    else
    {
        Npc[m_nIndex].SendCommand(do_walk, nX, nY);
        // Send to Server
        if (!CheckTrading())
            SendClientCmdWalk(nX, nY);
    }
}


void KPlayer::TurnLeft()
{
    if (Npc[m_nIndex].m_Doing != do_stand &&
        Npc[m_nIndex].m_Doing != do_sit)
        return;

    if (Npc[m_nIndex].m_Dir > 8)
        Npc[m_nIndex].m_Dir -= 8;
    else
        Npc[m_nIndex].m_Dir = MAX_NPC_DIR - 1;
}

void KPlayer::TurnRight()
{
    if (Npc[m_nIndex].m_Doing != do_stand &&
        Npc[m_nIndex].m_Doing != do_sit)
        return;

    if (Npc[m_nIndex].m_Dir < MAX_NPC_DIR - 9)
        Npc[m_nIndex].m_Dir += 8;
    else
        Npc[m_nIndex].m_Dir = 0;
}

void KPlayer::TurnBack()
{
    if (Npc[m_nIndex].m_Doing != do_stand &&
        Npc[m_nIndex].m_Doing != do_sit)
        return;

    if (Npc[m_nIndex].m_Dir < MAX_NPC_DIR / 2)
        Npc[m_nIndex].m_Dir += MAX_NPC_DIR / 2;
    else
        Npc[m_nIndex].m_Dir -= MAX_NPC_DIR / 2;
}

void KPlayer::FindSelectNpc(int x, int y, int nRelation)
{
    int	nNpcIdx = 0;
    nNpcIdx = NpcSet.SearchNpcAt(x, y, nRelation, 40);

    if (nNpcIdx)
        m_nPeapleIdx = nNpcIdx;
    else
        m_nPeapleIdx = 0;

    if (Npc[nNpcIdx].m_HideState.nTime > 0)
        m_nPeapleIdx = 0;
}

void KPlayer::FindSelectObject(int x, int y)
{
    int	nObjIdx = 0;

    nObjIdx = ObjSet.SearchObjAt(x, y, 40);
    if (nObjIdx)
        m_nObjectIdx = nObjIdx;
    else
        m_nObjectIdx = 0;
}


BOOL KPlayer::ConformIdx(int nIdx)
{
    if (nIdx == m_nIndex || nIdx == 0)
        return FALSE;
    return TRUE;
}
#endif

#ifdef _SERVER
BOOL KPlayer::IsWaitingRemove()
{
	if (!m_dwID)
		return FALSE;
	return m_bIsQuiting;
}

void KPlayer::WaitForRemove()
{
	m_bIsQuiting = TRUE;
}

BOOL KPlayer::IsLoginTimeOut()
{
	if (m_nNetConnectIdx != -1)
		return FALSE;

	if (!m_dwID)
		return FALSE;

	if (-1 != m_dwLoginTime &&
		g_SubWorldSet.GetGameTime() - m_dwLoginTime > defPLAYER_LOGIN_TIMEOUT)
	{
		//		m_dwLoginTime = -1;
		return TRUE;
	}

	return FALSE;
}


void KPlayer::LoginTimeOut()
{
	m_pStatusLoadPlayerInfo = NULL;

	Release();
}

BOOL KPlayer::Save()
{
	if (m_nIndex <= 0 && m_dwID == 0)
		return FALSE;
	if (CheckTrading())
	{
		TRADE_DECISION_COMMAND Trade;
		Trade.ProtocolType = c2s_tradedecision;
		Trade.m_btDecision = 0;
		TradeDecision((BYTE*)&Trade);
	}
	BYTE* pScratch = (BYTE*)malloc(sizeof(m_SaveBuffer));
	if (!pScratch)
		return FALSE;
	memcpy(pScratch, m_SaveBuffer, sizeof(m_SaveBuffer));
	PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(PHONGTHAN_CHARACTER_STATE_HEADER*)pScratch;
	if (UpdateCharacterState(pState, sizeof(m_SaveBuffer)) != 1 ||
		pState->StateSize > sizeof(m_SaveBuffer))
	{
		free(pScratch);
		return FALSE;
	}
	ZeroMemory(m_SaveBuffer, sizeof(m_SaveBuffer));
	memcpy(m_SaveBuffer, pState, pState->StateSize);
	free(pScratch);
	m_ulLastSaveTime = g_SubWorldSet.GetGameTime();
	return TRUE;
}
BOOL KPlayer::CanSave()
{
	if (m_nNetConnectIdx == -1)
		return FALSE;

	if (m_nIndex <= 0)
		return FALSE;

	if (m_bExchangeServer)
		return FALSE;

	if (m_bIsQuiting)
		return FALSE;

	if (CheckTrading(true))
		return FALSE;

	//TamLTM bo tam cho nay xem sao gs giam ko
	if (m_uMustSave == SAVE_DOING && g_SubWorldSet.GetGameTime() - m_ulLastSaveTime > defPLAYER_SAVE_TIMEOUT)
		return TRUE;

	if (m_uMustSave != SAVE_IDLE)
		return FALSE; //*/

	return TRUE;
}

BOOL KPlayer::SendSyncData(int &nStep, unsigned int &nParam)
{
	BOOL bRet = FALSE;
	FILE *pLoginDiag = fopen("core_login_diag.log", "a+b");
	if (pLoginDiag)
	{
		fprintf(pLoginDiag, "send_sync_start step=%d param=%u player_index=%d npc_index=%d\\n",
			nStep, nParam, m_nPlayerIndex, m_nIndex);
		fclose(pLoginDiag);
	}
	switch(nStep)
	{
	case STEP_BASE_INFO:
		{
			bRet = SubWorld[Npc[m_nIndex].m_SubWorldIndex].SendSyncData(m_nIndex, m_nNetConnectIdx);
			pLoginDiag = fopen("core_login_diag.log", "a+b");
			if (pLoginDiag)
			{
				fprintf(pLoginDiag, "send_sync_subworld result=%d subworld_index=%d region_index=%d net_id=%d\\n",
					(int)bRet, Npc[m_nIndex].m_SubWorldIndex, Npc[m_nIndex].m_RegionIndex, m_nNetConnectIdx);
				fclose(pLoginDiag);
			}
			if (!bRet)
			{
				printf("SubWorld Fail.\n");
				break;
			}
			bRet = Npc[m_nIndex].SendSyncData(m_nNetConnectIdx);
			pLoginDiag = fopen("core_login_diag.log", "a+b");
			if (pLoginDiag)
			{
				fprintf(pLoginDiag, "send_sync_npc result=%d\\n", (int)bRet);
				fclose(pLoginDiag);
			}
			if (!bRet)
			{
				printf("NPC Fail.\n");
				break;
			}
			// �����Ϣ������ͬ������NPC���ݺ�����ʹ�ͻ������ҵ���ǰ����ڿͻ��˵�Npc����
			PHONGTHAN_SELF_SNAPSHOT sSync;
			ZeroMemory(&sSync, sizeof(sSync));
			PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_WORLD_SELF_SNAPSHOT,
				sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
			sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
			sSync.PlayerId = m_dwID;
			sSync.Series = Npc[m_nIndex].m_Series;
			sSync.EntityId = Npc[m_nIndex].m_dwID;
			sSync.Level = (DWORD)Npc[m_nIndex].m_Level;
			sSync.Gender = Npc[m_nIndex].m_nSex;
			sSync.Profession = (BYTE)m_cProfession.GetProfession();
			//printf("NPC Fail %d\n", Npc[m_nIndex].m_Series);
			sSync.BaseMaxLife = Npc[m_nIndex].m_LifeMax;
			sSync.BaseMaxStamina = Npc[m_nIndex].m_StaminaMax;
			sSync.BaseMaxMana = Npc[m_nIndex].m_ManaMax;
			sSync.HeadImage = Npc[m_nIndex].m_HeadImage;
			sSync.AttributePoints = this->m_nAttributePoint;
			sSync.SkillPoints = this->m_nSkillPoint;
			sSync.Power = this->m_nStrength;
			sSync.Agility = this->m_nDexterity;
			sSync.Physique = this->m_nVitality;
			sSync.Wisdom = this->m_nEngergy;
			sSync.Luck = this->m_nLucky;
			sSync.Experience = this->m_nExp;
			sSync.Transcendence = Npc[m_nIndex].m_byTranslife;
			sSync.LeadershipExperience = this->m_nLeadExp;
			sSync.Portrait = this->m_ImagePlayer;
			sSync.MissionGroup = Npc[m_nIndex].m_nMissionGroup;
			sSync.ChatRoomId = this->m_cRoom.m_nID;
			sSync.WorldRank = m_nWorldStat;
			sSync.ProfessionRank = m_nProfessionRank;
			sSync.KillCount = (int)this->m_nKillPeopleNumber;  //Pk 10
			sSync.Money = this->m_ItemList.GetMoney(room_equipment);
			sSync.BankMoney = this->m_ItemList.GetMoney(room_repository);
            //g_DebugLog("SendSyncData->sSync.Money-2: %d - %d", sSync.Money, sSync.BankMoney);
			sSync.ExtraEquipUntil = this->m_dwEquipExpandTime;
			sSync.BankPages = this->m_btRepositoryNum;
			sSync.ClanLeaveTime = (DWORD)m_cTong.m_dwLeaveTime;
			sSync.ExtensionPoint = this->m_nExtPoint; // TamLTM fix xu;
			if (SUCCEEDED(g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync))))
			{
				bRet = TRUE;
			}
			else
			{
				printf("player Packing sync data failed...\n");
				bRet = FALSE;
				break;
			}
		}
		break;
	case STEP_FIGHT_SKILL_LIST:
		{
			bRet = SendSyncData_Skill();
		}
		break;
	case STEP_STATE_SKILL_LIST:
		bRet = TRUE;
		break;
	case STEP_ITEM_LIST:
		{
			int nSyncedItemCount = 0;
			PlayerItem* pItem = m_ItemList.GetFirstItem();
			while (pItem)
			{
				int nItemIdx = pItem->nIdx;
				if (nItemIdx > 0 && nItemIdx < MAX_ITEM && Item[nItemIdx].GetID() != 0)
				{
					m_ItemList.SyncItem(nItemIdx, TRUE, pItem->nPlace, pItem->nX, pItem->nY, m_nPlayerIndex);
					m_ItemList.SyncItemMagicAttrib(nItemIdx);
					nSyncedItemCount++;
				}
				pItem = m_ItemList.GetNextItem();
			}
			bRet = TRUE;
		}
		break;
	case STEP_TASK_LIST:
		bRet = TRUE;
		break;
	case STEP_SYNC_END:
		bRet = TRUE;
		break;
	}
	if (!bRet)
	{
		printf("Load PlayerInfo Step %d Failed...\n", nStep);
	}
	return bRet;
}

BOOL KPlayer::SendSyncData_Skill()
{
	PHONGTHAN_U8 buffer[sizeof(PHONGTHAN_SKILL_LIST_HEADER) + MAX_NPCSKILL * sizeof(PHONGTHAN_SKILL_ENTRY)];
	ZeroMemory(buffer, sizeof(buffer));
	PHONGTHAN_SKILL_LIST_HEADER* list = (PHONGTHAN_SKILL_LIST_HEADER*)buffer;
	PHONGTHAN_SKILL_ENTRY* entries = (PHONGTHAN_SKILL_ENTRY*)(list + 1);
	list->MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	list->EntityId = Npc[m_nIndex].m_dwID;
	for (int i = 1; i < MAX_NPCSKILL; ++i)
	{
		const NPCSKILL& skill = Npc[m_nIndex].m_SkillList.m_Skills[i];
		if (skill.SkillId <= 0) continue;
		entries[list->Count].SkillId = skill.SkillId;
		entries[list->Count].Level = skill.SkillLevel;
		entries[list->Count].Experience = skill.SkillExp;
		++list->Count;
	}
	const unsigned int size = sizeof(*list) + list->Count * sizeof(*entries);
	PhongThanInitializeWireHeader(&list->Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LIST,
		size, PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	if (!PhongThanValidateSkillList(buffer, size)) return FALSE;
	return SUCCEEDED(g_pServer->PackDataToClient(m_nNetConnectIdx, buffer, size));
}

void	KPlayer::SendCurNormalSyncData()
{
	PHONGTHAN_SELF_VITALS sSync;
	ZeroMemory(&sSync, sizeof(sSync));

	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_WORLD_SELF_VITALS,
		sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Life = Npc[m_nIndex].m_CurrentLife;
	sSync.Stamina = Npc[m_nIndex].m_CurrentStamina;
	sSync.Mana = Npc[m_nIndex].m_CurrentMana;
	if ( !m_cTeam.m_nFlag )
		sSync.TeamRole = 0;
	else
	{
		if (m_cTeam.m_nFigure == TEAM_CAPTAIN)
			sSync.TeamRole = 2;
		else
			sSync.TeamRole = 0x01;
	}

	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}

void KPlayer::QuitGame(int nType)
{
	Save();
}

void KPlayer::BuyItem(BYTE* pProtocol)
{
	PHONGTHAN_NPC_SHOP_BUY_REQUEST* pCommand =
		(PHONGTHAN_NPC_SHOP_BUY_REQUEST*)pProtocol;
	if (!pCommand ||
		pCommand->Header.MessageType != PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST ||
		pCommand->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pCommand->Header.PacketSize != sizeof(PHONGTHAN_NPC_SHOP_BUY_REQUEST) ||
		pCommand->ShopPage < 0 ||
		pCommand->ShopPage >= m_BuyInfo.m_nShopNum ||
		pCommand->ShopPage >= MAX_SUPERSHOP_SHOPTAB ||
		pCommand->ShopSlot < 0 || pCommand->Count == 0 || pCommand->Count > 255)
	{
		return;
	}

	int nNowMapX = 0;
	int nCurMapY = m_BuyInfo.m_nMpsY;
	int nNowMapY = 0;

	SubWorld[Npc[m_nIndex].m_SubWorldIndex].Map2Mps(Npc[m_nIndex].m_RegionIndex,
	  Npc[m_nIndex].m_MapX,
	  Npc[m_nIndex].m_MapY,
	  Npc[m_nIndex].m_OffX,
	  Npc[m_nIndex].m_OffY,
	  &nNowMapX,
	  &nNowMapY);

	const int nShopId = m_BuyInfo.m_nShopIdx[pCommand->ShopPage];
	const BOOL bPhongThanGlobalShop =
		nShopId >= PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX &&
		nShopId < PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + PHONGTHAN_IBSHOP_TAB_COUNT;
	if (bPhongThanGlobalShop ||
		(Npc[m_nIndex].m_SubWorldIndex == m_BuyInfo.m_SubWorldID)	/* Phong Than 2026-10-02: same map is enough (was exact position) */)
	{
		BuySell.Buy(m_nPlayerIndex,
			nShopId,
			pCommand->ShopSlot, (BYTE)pCommand->Count);
	}
}

void KPlayer::SellItem(BYTE* pProtocol)
{
	PHONGTHAN_NPC_SHOP_SELL_REQUEST* pCommand =
		(PHONGTHAN_NPC_SHOP_SELL_REQUEST*)pProtocol;
	if (!pCommand ||
		pCommand->Header.MessageType != PHONGTHAN_MSG_NPC_SHOP_SELL_REQUEST ||
		pCommand->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pCommand->Header.PacketSize != sizeof(PHONGTHAN_NPC_SHOP_SELL_REQUEST) ||
		pCommand->ItemId == 0 || pCommand->Count == 0 ||
		m_BuyInfo.m_nCurShop < 0 ||
		m_BuyInfo.m_nCurShop >= m_BuyInfo.m_nShopNum ||
		m_BuyInfo.m_nCurShop >= MAX_SUPERSHOP_SHOPTAB)
	{
		return;
	}
	int nNowMapX = 0;
	int nCurMapY = m_BuyInfo.m_nMpsY;
	int nNowMapY = 0;

	SubWorld[Npc[m_nIndex].m_SubWorldIndex].Map2Mps(Npc[m_nIndex].m_RegionIndex,
	  Npc[m_nIndex].m_MapX,
	  Npc[m_nIndex].m_MapY,
	  Npc[m_nIndex].m_OffX,
	  Npc[m_nIndex].m_OffY,
	  &nNowMapX,
	  &nNowMapY);

	if ( Npc[m_nIndex].m_SubWorldIndex == m_BuyInfo.m_SubWorldID )	/* Phong Than 2026-10-02: same map is enough (was exact position) */
	{
		int nItemIndex = m_ItemList.SearchID(pCommand->ItemId);
		if (nItemIndex > 0 && nItemIndex < MAX_ITEM)
			BuySell.Sell(m_nPlayerIndex,
				m_BuyInfo.m_nShopIdx[m_BuyInfo.m_nCurShop],
				nItemIndex, pCommand->Count);
	}
}

#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���ȡ���������λ��
//-------------------------------------------------------------------------
void KPlayer::GetLoginRevivalPos(int *lpnSubWorld, int *lpnMpsX, int *lpnMpsY)
{
	*lpnSubWorld = m_sLoginRevivalPos.m_nSubWorldID;
	*lpnMpsX = m_sLoginRevivalPos.m_nMpsX;
	*lpnMpsY = m_sLoginRevivalPos.m_nMpsY;
}


void KPlayer::GetDeathRevivalPos(int *lpnSubWorld, int *lpnMpsX, int *lpnMpsY)
{
	*lpnSubWorld = m_sDeathRevivalPos.m_nSubWorldID;
	*lpnMpsX = m_sDeathRevivalPos.m_nMpsX;
	*lpnMpsY = m_sDeathRevivalPos.m_nMpsY;
}
#endif
#ifdef _SERVER
void	KPlayer::SetTimer(DWORD nTime, int nTimerTaskId)					//ʱ������ű���������ʱ��
{
	if (!nTime || !nTimerTaskId) return ;
	m_TimerTask.SetTimer(nTime, nTimerTaskId);
}

void	KPlayer::CloseTimer()							//�ر�ʱ���ʱ��
{
	m_TimerTask.CloseTimer();
}
#endif


#ifdef _SERVER
//------------------------------------------------------------------------------
//	���ܣ��趨���������λ��
//------------------------------------------------------------------------------
void	KPlayer::SetRevivalPos(int nSubWorld, int nReviveId)
{
	if (nSubWorld > 0)  //���С��0����ʾ���õ�ǰ��
	{
		m_sLoginRevivalPos.m_nSubWorldID = nSubWorld;
	}
	else
	{
		m_sLoginRevivalPos.m_nSubWorldID = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	}

	POINT Pos;

	g_SubWorldSet.GetRevivalPosFromId(m_sLoginRevivalPos.m_nSubWorldID, nReviveId, &Pos);
	m_sLoginRevivalPos.m_ReviveID = nReviveId;
	m_sLoginRevivalPos.m_nMpsX = Pos.x;
	m_sLoginRevivalPos.m_nMpsY = Pos.y;

	m_sDeathRevivalPos = m_sLoginRevivalPos;
}
#endif

#ifdef _SERVER
//------------------------------------------------------------------------------
//	���ܣ��յ��ͻ��˲�ѯĳ��npc�����Ϣ�������������ͻ��˷��Ͷ�����Ϣ
//------------------------------------------------------------------------------
void	KPlayer::S2CSendTeamInfo(BYTE* pProtocol)
{
	PLAYER_APPLY_TEAM_INFO	*pApplyTeamInfo = (PLAYER_APPLY_TEAM_INFO*)pProtocol;

	//------------------------------ ��ѯ���������Ϣ -----------------------------
	if (pApplyTeamInfo->m_dwTarNpcID == Npc[m_nIndex].m_dwID)
	{
		SendSelfTeamInfo();
		return;
	}

	if (Npc[m_nIndex].m_SubWorldIndex >= MAX_SUBWORLD || Npc[m_nIndex].m_SubWorldIndex < 0 || Npc[m_nIndex].m_RegionIndex >= SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_nTotalRegion || Npc[m_nIndex].m_RegionIndex < 0)
	{
		Npc[m_nIndex].m_SubWorldIndex = 0;
		Npc[m_nIndex].m_RegionIndex = 381;
		Npc[m_nIndex].m_MapX = 0;
		Npc[m_nIndex].m_MapY = 0;
		Npc[m_nIndex].m_OffX = 0;
		Npc[m_nIndex].m_OffY = 0;
		printf("Xay ra loi tim kiem nguoi choi, tu dong xua loi !\n");
	}
	//--------------------------- ��ѯ���� npc �����Ϣ -----------------------------
	PLAYER_SEND_TEAM_INFO	sTeamInfo;
	PLAYER_APPLY_TEAM_INFO_FALSE	sTeamInfoFalse;
	// Ѱ����Ӧ npc id �� player ���
	int		nPlayer, nRegionNo, i;
	nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].FindPlayer(pApplyTeamInfo->m_dwTarNpcID);
	if ( nPlayer >= 0)
		goto SendMsg;
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].FindPlayer(pApplyTeamInfo->m_dwTarNpcID);
		if (nPlayer >= 0)
			break;
	}
	if (i >= 8)
		goto SendFalse;

SendMsg:
	// Ѱ�Ҷ���
	KTeam	*pTeam;
	if ( !Player[nPlayer].m_cTeam.m_nFlag )
		goto SendFalse;
	pTeam = &g_Team[Player[nPlayer].m_cTeam.m_nID];
	if (pTeam->m_nCaptain < 0 || !pTeam->IsOpen())
		goto SendFalse;

	// ���Ͷ�����Ϣ
	sTeamInfo.ProtocolType = (BYTE)s2c_teaminfo;
	sTeamInfo.m_nCaptain = Npc[Player[pTeam->m_nCaptain].m_nIndex].m_dwID;
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (pTeam->m_nMember[i] < 0)
			sTeamInfo.m_nMember[i] = 0;
		else
			sTeamInfo.m_nMember[i] = Npc[Player[pTeam->m_nMember[i]].m_nIndex].m_dwID;
	}
	//	strcpy(sTeamInfo.m_szTeamName, pTeam->m_szName);

	// ����
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sTeamInfo, sizeof(PLAYER_SEND_TEAM_INFO));
	return;

	// ����ʧ��֪ͨ
SendFalse:
	sTeamInfoFalse.ProtocolType = s2c_teamapplyinfofalse;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sTeamInfoFalse, sizeof(PLAYER_APPLY_TEAM_INFO_FALSE));
	return;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���������ͻ��˷��Ͷ�����Ϣ
//-------------------------------------------------------------------------
void	KPlayer::SendSelfTeamInfo()
{
	if (m_cTeam.m_nFlag && m_cTeam.m_nID >= 0)	// ���Ͷ�����Ϣ
	{
		int		nNpcIndex;
		PLAYER_SEND_SELF_TEAM_INFO	sSelfInfo;
		sSelfInfo.ProtocolType = s2c_teamselfinfo;
		sSelfInfo.nTeamServerID = m_cTeam.m_nID;
		sSelfInfo.m_nLeadExp = m_nLeadExp;
		sSelfInfo.m_btState = g_Team[m_cTeam.m_nID].m_nState;

		// �ӳ�
		nNpcIndex = Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex;
		sSelfInfo.m_dwNpcID[0] = Npc[nNpcIndex].m_dwID;
		sSelfInfo.m_btLevel[0] = (DWORD)Npc[nNpcIndex].m_Level;
		strcpy(sSelfInfo.m_szNpcName[0], Npc[nNpcIndex].Name);
		// ��Ա
		for (int i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (g_Team[m_cTeam.m_nID].m_nMember[i] >= 0)
			{
				nNpcIndex = Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex;
				sSelfInfo.m_dwNpcID[i + 1] = Npc[nNpcIndex].m_dwID;
				sSelfInfo.m_btLevel[i + 1] = (DWORD)Npc[nNpcIndex].m_Level;
				strcpy(sSelfInfo.m_szNpcName[i + 1], Npc[nNpcIndex].Name);
			}
			else
			{
				sSelfInfo.m_dwNpcID[i + 1] = 0;
				sSelfInfo.m_btLevel[i + 1] = 0;
			}
		}
		// ������Ϣ
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSelfInfo, sizeof(PLAYER_SEND_SELF_TEAM_INFO));
	}
	else	// ���������Ϣ
	{
		PLAYER_LEAVE_TEAM	sLeaveTeam;
		sLeaveTeam.ProtocolType = s2c_teamleave;
		sLeaveTeam.m_dwNpcID = Npc[m_nIndex].m_dwID;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ������󴴽�һ֧����
//-------------------------------------------------------------------------
BOOL	KPlayer::CreateTeam(BYTE* pProtocol)
{
	return m_cTeam.CreateTeam(this->m_nPlayerIndex, (PLAYER_APPLY_CREATE_TEAM*)pProtocol);
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ������󿪷š��رձ�player�����Ƿ�������Ա����״̬
//-------------------------------------------------------------------------
//TamLTM auto pt to doi
BOOL	KPlayer::SetTeamState(BYTE* pProtocol)
{
	if (this->CheckTrading())
		return FALSE;

	PLAYER_TEAM_OPEN_CLOSE	*pTeamState = (PLAYER_TEAM_OPEN_CLOSE*)pProtocol;
	switch (pTeamState->m_btStateClose)
	{
		case Team_S_OpenClose:
		{
			if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN || m_cTeam.m_nID < 0)
			{
				SendSelfTeamInfo();
				return FALSE;
			}

			if (pTeamState->m_btFlag == 0)
			{
				g_Team[m_cTeam.m_nID].SetTeamClose(true);

			}
			else
			{
				if (m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADEOPEN)
					m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_NORMAL);

				g_Team[m_cTeam.m_nID].SetTeamOpen(true);
			}
		}
		break;
		case Team_S_PKFollowCaptain:
			if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure == TEAM_CAPTAIN || m_cTeam.m_nID < 0)
			{
				SendSelfTeamInfo();
				return FALSE;
			}

			m_cTeam.SetPKFollowCaptain(this->m_nPlayerIndex, pTeamState->m_btFlag);
		break;
		case Team_S_ModePick:
		{
			if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN || m_cTeam.m_nID < 0)
			{
				SendSelfTeamInfo();
				return FALSE;
			}
			g_Team[m_cTeam.m_nID].SetModePick((int)pTeamState->m_btFlag);
		}
		break;
	}
	return TRUE;
}
#endif
//end code

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ����������һ֧����
//-------------------------------------------------------------------------
BOOL	KPlayer::S2CSendAddTeamInfo(BYTE* pProtocol)
{
	if (!m_cTeam.m_bCreatTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_CANNOT_ADD_TEAM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}

	PLAYER_APPLY_ADD_TEAM	*pAddTeam = (PLAYER_APPLY_ADD_TEAM*)pProtocol;

	if (Npc[m_nIndex].m_SubWorldIndex >= MAX_SUBWORLD || Npc[m_nIndex].m_SubWorldIndex < 0 || Npc[m_nIndex].m_RegionIndex >= SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_nTotalRegion || Npc[m_nIndex].m_RegionIndex < 0)
	{
		Npc[m_nIndex].m_SubWorldIndex = 0;
		Npc[m_nIndex].m_RegionIndex = 381;
		Npc[m_nIndex].m_MapX = 0;
		Npc[m_nIndex].m_MapY = 0;
		Npc[m_nIndex].m_OffX = 0;
		Npc[m_nIndex].m_OffY = 0;
		printf("Xay ra loi tim kiem nguoi choi, tu dong xua loi !\n");
	}


	// Ѱ�Ҷӳ� npc id �� player ���
	int		nPlayer, nRegionNo, i;
	nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].FindPlayer(pAddTeam->m_dwTarNpcID);
	if ( nPlayer >= 0)
		goto SendMsg;
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].FindPlayer(pAddTeam->m_dwTarNpcID);
		if (nPlayer >= 0)
			break;
	}
	if (i >= 8)
		return FALSE;

SendMsg:
	if (Npc[Player[nPlayer].m_nIndex].m_Camp == camp_begin && Npc[m_nIndex].m_Camp != camp_begin)
		return FALSE;
	if (g_Team[Player[nPlayer].m_cTeam.m_nID].m_nMemNum >= MAX_TEAM_MEMBER ||
		g_Team[Player[nPlayer].m_cTeam.m_nID].m_nMemNum >= g_Team[Player[nPlayer].m_cTeam.m_nID].CalcCaptainPower())
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_IS_FULL;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	m_cTeam.m_nApplyCaptainID = pAddTeam->m_dwTarNpcID;
	PLAYER_APPLY_ADD_TEAM	sAddTeam;
	sAddTeam.ProtocolType = s2c_teamgetapply;
	sAddTeam.m_dwTarNpcID = Npc[m_nIndex].m_dwID;
	g_pServer->PackDataToClient(Player[nPlayer].m_nNetConnectIdx, (BYTE*)&sAddTeam, sizeof(PLAYER_APPLY_ADD_TEAM));
	return TRUE;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ�֪ͨ����������ĳ��npcΪ�����Ա
//-------------------------------------------------------------------------
BOOL	KPlayer::AddTeamMember(BYTE* pProtocol)
{
	// ������(�Ƿ���ӡ��Ƿ�ӳ������鿪��״̬����Ա����ͳ����)
	if ( !m_cTeam.m_nFlag ||
		m_cTeam.m_nFigure != TEAM_CAPTAIN ||
		!g_Team[m_cTeam.m_nID].IsOpen() ||
		g_Team[m_cTeam.m_nID].m_nMemNum >= MAX_TEAM_MEMBER ||
		g_Team[m_cTeam.m_nID].m_nMemNum >= g_Team[m_cTeam.m_nID].CalcCaptainPower())
	{
		SendSelfTeamInfo();
		return FALSE;
	}

	// ��npc id����player
	int		nPlayer, i;
	PLAYER_ACCEPT_TEAM_MEMBER	*pAccept = (PLAYER_ACCEPT_TEAM_MEMBER*)pProtocol;
	nPlayer = FindAroundPlayer(pAccept->m_dwNpcID);
	if (nPlayer < 0)
		return FALSE;
	// �Է������ڲ������״̬
	if (!Player[nPlayer].m_cTeam.m_bCreatTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TARGET_CANNOT_ADD_TEAM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	// �Ѿ��ڶ�����
	if (Player[nPlayer].m_cTeam.m_nFlag)
		return FALSE;
	if (Player[nPlayer].m_cTeam.m_nApplyCaptainID != Npc[this->m_nIndex].m_dwID)
		return FALSE;
	// �������ӳ�Ա
	if ( !g_Team[m_cTeam.m_nID].AddMember(nPlayer) )
		return FALSE;
	// �ı����״̬
	if (g_Team[m_cTeam.m_nID].m_nMemNum >= MAX_TEAM_MEMBER ||
		g_Team[m_cTeam.m_nID].CheckFull())
		g_Team[m_cTeam.m_nID].SetTeamClose();
	// �����ܶ�Ա�������ݴ���
	Player[nPlayer].m_cTeam.Release();
	Player[nPlayer].m_cTeam.m_nFlag = 1;
	Player[nPlayer].m_cTeam.m_nFigure = TEAM_MEMBER;
	Player[nPlayer].m_cTeam.m_nID = m_cTeam.m_nID;
	Npc[Player[nPlayer].m_nIndex].SetCurrentCamp(Npc[m_nIndex].m_Camp);

	// ��������Ա����Ϣ
	PLAYER_TEAM_ADD_MEMBER	sAddMem;
	sAddMem.ProtocolType = s2c_teamaddmember;
	sAddMem.m_dwNpcID = Npc[Player[nPlayer].m_nIndex].m_dwID;
	sAddMem.m_btLevel = (DWORD)Npc[Player[nPlayer].m_nIndex].m_Level;
	strcpy(sAddMem.m_szName, Npc[Player[nPlayer].m_nIndex].Name);

	// ���ӳ�����Ϣ
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sAddMem, sizeof(PLAYER_TEAM_ADD_MEMBER));

	// ���϶�Ա����Ϣ
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_cTeam.m_nID].m_nMember[i] < 0 || g_Team[m_cTeam.m_nID].m_nMember[i] == nPlayer)
			continue;
		g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sAddMem, sizeof(PLAYER_TEAM_ADD_MEMBER));
	}

	// ------------------------------------- ���¶�Ա����Ϣ --------------------------
	int		nNpcIndex;
	PLAYER_SEND_SELF_TEAM_INFO	sSelfInfo;
	sSelfInfo.ProtocolType = s2c_teamselfinfo;
	sSelfInfo.nTeamServerID = m_cTeam.m_nID;
	sSelfInfo.m_nLeadExp = Player[nPlayer].m_nLeadExp;
	sSelfInfo.m_btState = g_Team[m_cTeam.m_nID].m_nState;
	// �ӳ�����
	nNpcIndex = m_nIndex;
	sSelfInfo.m_dwNpcID[0] = Npc[nNpcIndex].m_dwID;
	sSelfInfo.m_btLevel[0] = (DWORD)Npc[nNpcIndex].m_Level;
	strcpy(sSelfInfo.m_szNpcName[0], Npc[nNpcIndex].Name);
	// ��Ա����
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_cTeam.m_nID].m_nMember[i] >= 0)
		{
			nNpcIndex = Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex;
			sSelfInfo.m_dwNpcID[i + 1] = Npc[nNpcIndex].m_dwID;
			sSelfInfo.m_btLevel[i + 1] = (DWORD)Npc[nNpcIndex].m_Level;
			strcpy(sSelfInfo.m_szNpcName[i + 1], Npc[nNpcIndex].Name);
		}
		else
		{
			sSelfInfo.m_dwNpcID[i + 1] = 0;
			sSelfInfo.m_btLevel[i + 1] = 0;
		}
	}
	// ������Ϣ
	g_pServer->PackDataToClient(Player[nPlayer].m_nNetConnectIdx, (BYTE*)&sSelfInfo, sizeof(PLAYER_SEND_SELF_TEAM_INFO));

	SHOW_MSG_SYNC	sMsg;
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wMsgID = enumMSG_ID_TEAM_SELF_ADD;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
	sMsg.m_lpBuf = 0;
	g_pServer->PackDataToClient(Player[nPlayer].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

	// --------------------------------- ���¶�Ա����Ϣ end --------------------------

	return TRUE;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ��˶�Ա֪ͨ�뿪����
//-------------------------------------------------------------------------
void	KPlayer::LeaveTeam(BYTE* pProtocol)
{
	PLAYER_APPLY_LEAVE_TEAM* pLeave = (PLAYER_APPLY_LEAVE_TEAM*)pProtocol;

	if (!m_cTeam.m_nFlag)
		return;
	if (pLeave->bMySelf && !m_cTeam.m_bFreezeTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	BOOL bOpen = FALSE;

	if (g_Team[m_cTeam.m_nID].IsOpen())
		bOpen = TRUE;

	if (this->m_cTeam.m_nFigure == TEAM_CAPTAIN && g_Team[m_cTeam.m_nID].IsOpen())
	{
		if (pLeave->bMySelf || g_Team[m_cTeam.m_nID].m_nMemNum < 1)
			g_Team[m_cTeam.m_nID].SetTeamClose();
		else
		{
			int nLeadLevel = 0;
			int nPlayerIdx = 0;
			for (int i = 0; i < MAX_TEAM_MEMBER; i ++)
			{
				int nIndex = g_Team[m_cTeam.m_nID].m_nMember[i];
				if (nIndex > 0)
				{
					if (Npc[m_nIndex].m_Camp != camp_begin &&
						Npc[Player[nIndex].m_nIndex].m_Camp == camp_begin)
					{
						continue;
					}
					if (Player[nIndex].m_nLeadLevel > nLeadLevel)
					{
						nPlayerIdx = nIndex;
						nLeadLevel = Player[nIndex].m_nLeadLevel;
					}
				}
			}
			if (nPlayerIdx > 0)
			{
			PLAYER_APPLY_TEAM_CHANGE_CAPTAIN	sTeamChange;
			sTeamChange.ProtocolType = c2s_teamapplychangecaptain;
			sTeamChange.m_dwNpcID = Npc[Player[nPlayerIdx].m_nIndex].m_dwID;
			sTeamChange.m_bMySelf = FALSE;
			if (!this->TeamChangeCaptain((BYTE*)&sTeamChange))
				g_Team[m_cTeam.m_nID].SetTeamClose();
			}
			else
				g_Team[m_cTeam.m_nID].SetTeamClose();
		}
	}

	// �Ƕӳ��뿪���飬��ϵͳ��Ϣ���ӳ��뿪�����ϵͳ��Ϣ������DeleteMember����
	if (m_cTeam.m_nFigure != TEAM_CAPTAIN)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_LEAVE;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (void*)Npc[this->m_nIndex].m_dwID;

		g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		for (int i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (g_Team[m_cTeam.m_nID].m_nMember[i] > 0)
			{
				g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			}
		}
		sMsg.m_lpBuf = 0;
	if (g_Team[m_cTeam.m_nID].m_nMemNum < MAX_TEAM_MEMBER ||
		g_Team[m_cTeam.m_nID].CheckFull() == FALSE)
	{
		if (bOpen && !g_Team[m_cTeam.m_nID].IsOpen())
			g_Team[m_cTeam.m_nID].SetTeamOpen();
	}
	}

	// �������˶�Ա�뿪�Ĵ���
	g_Team[m_cTeam.m_nID].DeleteMember(GetPlayerIndex());
}

void	KPlayer::SendSystemMessage(const char* szHead, const char* szMessage)
{
	if (!szHead || !szMessage)
		return;

	KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, (char *)szHead,(char *) szMessage, strlen(szMessage) );
}

void	KPlayer::SendTeamMessage(int nTeamID, const char* szMessage)
{
	if (!szMessage[0])
		return;
	if ( !m_cTeam.m_nFlag || nTeamID < 0 || nTeamID > MAX_TEAM)
	{
		KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_TEAM_ANNOUCE_HEAD,(char *) szMessage, strlen(szMessage) );
		return;
	}

	KPlayerChat::SendSystemInfo(1, g_Team[nTeamID].m_nCaptain, MESSAGE_TEAM_ANNOUCE_HEAD,(char *) szMessage, strlen(szMessage) );

	for (int i = 0; i < MAX_TEAM_MEMBER; i ++)
	{
		int nMemberId = g_Team[nTeamID].m_nMember[i] ;
		if (nMemberId > 0)
		{
			if (szMessage)
				KPlayerChat::SendSystemInfo(1, nMemberId, MESSAGE_TEAM_ANNOUCE_HEAD, (char *)szMessage, strlen(szMessage) );
		}
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ��˶ӳ�֪ͨ�߳�ĳ����Ա
//-------------------------------------------------------------------------
void	KPlayer::TeamKickOne(BYTE* pProtocol)
{
	if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
		return;

	if (!m_cTeam.m_bFreezeTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	int		nMemNo;
	PLAYER_TEAM_KICK_MEMBER	*pKickOne = (PLAYER_TEAM_KICK_MEMBER*)pProtocol;
	nMemNo = g_Team[m_cTeam.m_nID].FindMemberID(pKickOne->m_dwNpcID);
	if (nMemNo < 0)
		return;
	int		nPlayerNo;
	// �������˶�Ա�뿪�Ĵ���
	nPlayerNo = g_Team[m_cTeam.m_nID].m_nMember[nMemNo];
	g_Team[m_cTeam.m_nID].DeleteMember(nPlayerNo);

	// ����Ϣ���ͻ���
	int		nLength;
	SHOW_MSG_SYNC	sMsg;

	nLength = strlen(Npc[Player[nPlayerNo].m_nIndex].Name);
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wMsgID = enumMSG_ID_TEAM_KICK_ONE;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID) + nLength;
	sMsg.m_lpBuf = new BYTE[sMsg.m_wLength + 1];

	memcpy(sMsg.m_lpBuf, &sMsg, sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID));
	memcpy((char*)sMsg.m_lpBuf + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), Npc[Player[nPlayerNo].m_nIndex].Name, nLength);

	g_pServer->PackDataToClient(Player[nPlayerNo].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);

	g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_cTeam.m_nID].m_nMember[i] > 0)
			g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
	}
	sMsg.Release();
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ��˶ӳ�֪ͨ�Ѷӳ����ݽ���ĳ����Ա
//-------------------------------------------------------------------------
BOOL	KPlayer::TeamChangeCaptain(BYTE* pProtocol)
{
	if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
		return FALSE;

	if (!m_cTeam.m_bFreezeTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}

	int		i, nMember, nPlayerNo;
	BOOL	bOpen = FALSE;
	PLAYER_APPLY_TEAM_CHANGE_CAPTAIN	*pChange = (PLAYER_APPLY_TEAM_CHANGE_CAPTAIN*)pProtocol;
	nMember = g_Team[m_cTeam.m_nID].FindMemberID(pChange->m_dwNpcID);
	if (nMember < 0)
		return FALSE;
	if (Npc[Player[g_Team[m_cTeam.m_nID].m_nMember[nMember]].m_nIndex].m_Camp == camp_begin && Npc[this->m_nIndex].m_Camp != camp_begin)
	{
		// �ӳ��ƽ�ʧ�ܣ��Է�ͳ˧������
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL2;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (LPVOID)pChange->m_dwNpcID;
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		sMsg.m_lpBuf = 0;
		return FALSE;
	}
	if (g_Team[m_cTeam.m_nID].m_nMemNum > PlayerSet.m_cLeadExp.GetMemNumFromLevel(Player[g_Team[m_cTeam.m_nID].m_nMember[nMember]].m_nLeadLevel))
	{
		// �ӳ��ƽ�ʧ�ܣ��Է�ͳ˧������
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (LPVOID)pChange->m_dwNpcID;
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		sMsg.m_lpBuf = 0;
		return FALSE;
	}
	if (g_Team[m_cTeam.m_nID].IsOpen())
	{
		g_Team[m_cTeam.m_nID].SetTeamClose();
		bOpen = TRUE;
	}
	nPlayerNo = g_Team[m_cTeam.m_nID].m_nCaptain;
	g_Team[m_cTeam.m_nID].m_nCaptain = g_Team[m_cTeam.m_nID].m_nMember[nMember];
	g_Team[m_cTeam.m_nID].m_nMember[nMember] = nPlayerNo;
	m_cTeam.m_nFigure = TEAM_MEMBER;
	Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_cTeam.m_nFigure = TEAM_CAPTAIN;
	// �ı���Ӫ
	Npc[Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex].RestoreCurrentCamp();
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		nPlayerNo = g_Team[m_cTeam.m_nID].m_nMember[i];
		if (nPlayerNo < 0)
			continue;
		Npc[Player[nPlayerNo].m_nIndex].SetCurrentCamp(Npc[Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex].m_Camp);
	}

	// ��������Ա����Ϣ
	PLAYER_TEAM_CHANGE_CAPTAIN	sChangeCaptain;
	sChangeCaptain.ProtocolType = s2c_teamchangecaptain;
	sChangeCaptain.m_dwCaptainID = pChange->m_dwNpcID;
	sChangeCaptain.m_bMySelf = pChange->m_bMySelf;
	sChangeCaptain.m_dwMemberID = Npc[m_nIndex].m_dwID;
	// ���ӳ�����Ϣ
	g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nNetConnectIdx, (BYTE*)&sChangeCaptain, sizeof(PLAYER_TEAM_CHANGE_CAPTAIN));
	// ����Ա����Ϣ
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		nPlayerNo = g_Team[m_cTeam.m_nID].m_nMember[i];
		if (nPlayerNo < 0)
			continue;
		g_pServer->PackDataToClient(Player[nPlayerNo].m_nNetConnectIdx, (BYTE*)&sChangeCaptain, sizeof(PLAYER_TEAM_CHANGE_CAPTAIN));
	}

	if (bOpen && !g_Team[m_cTeam.m_nID].IsOpen())
	{
		g_Team[m_cTeam.m_nID].SetTeamOpen();
	}
	return TRUE;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ��˶ӳ������ɢ����
//-------------------------------------------------------------------------
void	KPlayer::TeamDismiss(BYTE* pProtocol)
{
	if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
		return;

	if (!m_cTeam.m_bFreezeTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	PLAYER_LEAVE_TEAM	sLeaveTeam;
	int		i;
	SHOW_MSG_SYNC	sMsg;

	// �����ɢ��Ϣ
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wMsgID = enumMSG_ID_TEAM_DISMISS;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
	g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

	// ���ӳ�����Ϣ
	sLeaveTeam.ProtocolType = s2c_teamleave;
	sLeaveTeam.m_dwNpcID = Npc[m_nIndex].m_dwID;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
	// ����Ա����Ϣ
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

		sLeaveTeam.m_dwNpcID = Npc[Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex].m_dwID;
		g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
		// ��Ա���ݸı�
		Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_cTeam.m_nFlag = 0;
		Npc[Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex].RestoreCurrentCamp();;
	}
	// �������
	g_Team[m_cTeam.m_nID].Release();
	// �ӳ����ݸı�
	m_cTeam.m_nFlag = 0;
	Npc[m_nIndex].RestoreCurrentCamp();
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ��������趨PK״̬
//-------------------------------------------------------------------------
void	KPlayer::SetPK(BYTE* pProtocol)
{
	PLAYER_SET_PK	*pPK = (PLAYER_SET_PK*)pProtocol;

	if (pPK->m_btPKFlag)
		Npc[m_nIndex].SetCurrentCamp(camp_free);
	else
		Npc[m_nIndex].RestoreCurrentCamp();
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���ͻ��˷�����������
//-------------------------------------------------------------------------
void	KPlayer::SendProfessionData()
{
	// ���ͻ��˷���Ϣ
	PLAYER_PROFESSION_DATA	sData;
	sData.ProtocolType = s2c_playerprofessiondata;
	sData.m_btCamp = Npc[m_nIndex].m_Camp;
	sData.m_btProfession = (BYTE)m_cProfession.GetProfession();

	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sData, sizeof(PLAYER_PROFESSION_DATA));
}
#endif

#ifdef _SERVER
// not end
void KPlayer::GetAboutPos(KMapPos *pMapPos)
{
	if (m_nIndex <= 0)
		return;

	if (Npc[m_nIndex].m_SubWorldIndex < 0)
		return;

	POINT Pos;
	int nX, nY;
	Npc[m_nIndex].GetMpsPos(&nX, &nY);
	Pos.x = nX;
	Pos.y = nY;
	SubWorld[Npc[m_nIndex].m_SubWorldIndex].GetFreeObjPos(Pos);
	pMapPos->nSubWorld = Npc[m_nIndex].m_SubWorldIndex;
	SubWorld[Npc[m_nIndex].m_SubWorldIndex].Mps2Map(
		Pos.x,
		Pos.y,
		&pMapPos->nRegion,
		&pMapPos->nMapX,
		&pMapPos->nMapY,
		&pMapPos->nOffX,
		&pMapPos->nOffY);
}
#endif


#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�Ѱ�������Χ��ĳ��ָ��npc id��player index
//-------------------------------------------------------------------------
int		KPlayer::FindAroundPlayer(DWORD dwNpcID)
{
	if (dwNpcID == 0)
		return -1;

	if (Npc[m_nIndex].m_SubWorldIndex >= MAX_SUBWORLD || Npc[m_nIndex].m_SubWorldIndex < 0 || Npc[m_nIndex].m_RegionIndex >= SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_nTotalRegion || Npc[m_nIndex].m_RegionIndex < 0)
	{
		Npc[m_nIndex].m_SubWorldIndex = 0;
		Npc[m_nIndex].m_RegionIndex = 381;
		Npc[m_nIndex].m_MapX = 0;
		Npc[m_nIndex].m_MapY = 0;
		Npc[m_nIndex].m_OffX = 0;
		Npc[m_nIndex].m_OffY = 0;
		printf("Xay ra loi tim kiem nguoi choi, tu dong xua loi !\n");
	}

	int		nPlayer, nRegionNo, i;
	nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].FindPlayer(dwNpcID);
	printf("Xay ra loi tim kiem nguoi choi11111111%d\n", nPlayer);
	if ( nPlayer >= 0)
		return nPlayer;
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nPlayer = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].FindPlayer(dwNpcID);
		printf("Xay ra loi tim kiem nguoi choi11111111%d %d\n", nPlayer, nRegionNo);
		if (nPlayer >= 0)
			return nPlayer;
	}

	return -1;
}

//-------------------------------------------------------------------------
//	���ܣ�Ѱ�������Χ��ĳ��ָ��npc id��npc index
//-------------------------------------------------------------------------
int		KPlayer::FindAroundNpc(DWORD dwNpcID)
{
	if (dwNpcID == 0)
		return 0;
   // g_DebugLog("Son debug dwNpcID :%d", dwNpcID);//Son debug FindNpc
	if (Npc[m_nIndex].m_SubWorldIndex >= MAX_SUBWORLD || Npc[m_nIndex].m_SubWorldIndex < 0 || Npc[m_nIndex].m_RegionIndex >= SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_nTotalRegion || Npc[m_nIndex].m_RegionIndex < 0)
	{
		Npc[m_nIndex].m_SubWorldIndex = 0;
		Npc[m_nIndex].m_RegionIndex = 381;
		Npc[m_nIndex].m_MapX = 0;
		Npc[m_nIndex].m_MapY = 0;
		Npc[m_nIndex].m_OffX = 0;
		Npc[m_nIndex].m_OffY = 0;
		printf("Xay ra loi tim kiem npc, tu dong sua loi !\n");
	}

	int		nNpc, nRegionNo, i;
	nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].SearchNpc(dwNpcID);
    //g_DebugLog("Son debug nNpc1:%d", nNpc);//Son debug FindNpc
	if ( nNpc > 0)
		return nNpc;
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].SearchNpc(dwNpcID);
		if (nNpc > 0)
			return nNpc;
        //g_DebugLog("Son debug nNpc2:%d", nNpc);//Son debug FindNpc
	}

	return 0;
}

int		KPlayer::FindNearNpc(int  nNpcSettingIdx, int nDist)
{
	if (nNpcSettingIdx == 0)
		return 0;

	int		nNpc, nRegionNo, i;
	nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].SearchNpcSettingIdx(nNpcSettingIdx);
	if (nNpc > 0)
	{
		if (nDist <= 0 || (nDist >= NpcSet.GetDistance(m_nIndex, nNpc)))
			return nNpc;
	}
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].SearchNpcSettingIdx(nNpcSettingIdx);
		if (nNpc > 0)
		{
			if (nDist <= 0 || (nDist >= NpcSet.GetDistance(m_nIndex, nNpc)))
				return nNpc;
		}
	}

	return 0;
}

int		KPlayer::FindNearNpc(const char* szName, int nDist)
{
	if (!szName || !szName[0])
		return 0;

	int		nNpc, nRegionNo, i;
	nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].SearchNpcName(szName);
	if (nNpc > 0)
	{
		if (nDist <= 0 || (nDist >= NpcSet.GetDistance(m_nIndex, nNpc)))
			return nNpc;
	}
	for (i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[Npc[m_nIndex].m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nNpc = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_Region[nRegionNo].SearchNpcName(szName);
		if (nNpc > 0)
		{
			if (nDist <= 0 || (nDist >= NpcSet.GetDistance(m_nIndex, nNpc)))
				return nNpc;
		}
	}

	return 0;
}
#endif

//-------------------------------------------------------------------------
//	���ܣ�����ҵ�½ʱ�����������Բ��� ���� ���� ���� ���� ������ֵ
//-------------------------------------------------------------------------
BOOL	KPlayer::NewPlayerGetBaseAttribute(int Series)
{
    if (Series < series_metal || Series > series_earth)
        return FALSE;

    Npc[m_nIndex].SetSeries(Series);

    m_nStrength = PlayerSet.m_cNewPlayerAttribute.m_nStrength[Series];
    m_nDexterity = PlayerSet.m_cNewPlayerAttribute.m_nDexterity[Series];
    m_nVitality = PlayerSet.m_cNewPlayerAttribute.m_nVitality[Series];
    m_nEngergy = PlayerSet.m_cNewPlayerAttribute.m_nEngergy[Series];
    m_nLucky = PlayerSet.m_cNewPlayerAttribute.m_nLucky[Series];

    m_nCurStrength = m_nStrength;
    m_nCurDexterity = m_nDexterity;
    m_nCurVitality = m_nVitality;
    m_nCurEngergy = m_nEngergy;

    if (!m_cProfession.SetProfession(Series))
        return FALSE;

    return TRUE;
}

//-------------------------------------------------------------------------
//	���ܣ����㵱ǰ����
//-------------------------------------------------------------------------
//void	KPlayer::CalcCurStrength()
//{	// ����Ҫ���� װ�������ܡ�״̬ ��Ӱ��
//	m_nCurStrength = m_nStrength;
//}

//-------------------------------------------------------------------------
//	���ܣ����㵱ǰ����
//-------------------------------------------------------------------------
//void	KPlayer::CalcCurDexterity()
//{	// ����Ҫ���� װ�������ܡ�״̬ ��Ӱ��
//	m_nCurDexterity = m_nDexterity;
//}

//-------------------------------------------------------------------------
//	���ܣ����㵱ǰ����
//-------------------------------------------------------------------------
//void	KPlayer::CalcCurVitality()
//{	// ����Ҫ���� װ�������ܡ�״̬ ��Ӱ��
//	m_nCurVitality = m_nVitality;
//}

//-------------------------------------------------------------------------
//	���ܣ����㵱ǰ����
//-------------------------------------------------------------------------
//void	KPlayer::CalcCurEngergy()
//{	// ����Ҫ���� װ�������ܡ�״̬ ��Ӱ��
//	m_nCurEngergy = m_nEngergy;
//}

//-------------------------------------------------------------------------
//	���ܣ����㵱ǰ����
//-------------------------------------------------------------------------

#ifdef _SERVER

void  KPlayer::SyncCurrentBaseAttriibute(int type,int attribute,int curAttribute)
{
	PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
	ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Attribute = PhongThanEncodeAttribute(type);
	sSync.Base = attribute;
	sSync.Current = curAttribute;
	sSync.RemainingPoints = m_nAttributePoint;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}

//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::AddBaseStrength(int nData)
{
	if (nData > 0 && nData <= m_nAttributePoint)
	{
		m_nStrength += nData;
		m_nAttributePoint -= nData;
		m_nCurStrength += nData;

		UpdataCurData();
		SetNpcPhysicsDamage();
		// �ѵ�ǰ���������ͻ���
		PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
		sSync.Attribute = PhongThanEncodeAttribute(0);
		sSync.Base = m_nStrength;
		sSync.Current = m_nCurStrength;
		sSync.RemainingPoints = m_nAttributePoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	}
}

void	KPlayer::ResetBaseStrength(int nData)
{
	m_nStrength = nData;
	m_nCurStrength = nData;
	UpdataCurData();
	SetNpcPhysicsDamage();
	SyncCurrentBaseAttriibute(ATTRIBUTE_STRENGTH, m_nStrength, m_nCurStrength);
}

//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::AddBaseDexterity(int nData)
{
	if (nData > 0 && nData <= m_nAttributePoint)
	{
		m_nDexterity += nData;
		m_nAttributePoint -= nData;
		m_nCurDexterity += nData;

		SetNpcAttackRating();
		SetNpcDefence();
		UpdataCurData();
		SetNpcPhysicsDamage();

		// �ѵ�ǰ���������ͻ���
		PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
		sSync.Attribute = PhongThanEncodeAttribute(1);
		sSync.Base = m_nDexterity;
		sSync.Current = m_nCurDexterity;
		sSync.RemainingPoints = m_nAttributePoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	}
}

void	KPlayer::ResetBaseDexterity(int nData)
{
		m_nDexterity = nData;
		m_nCurDexterity = nData;

		SetNpcAttackRating();
		SetNpcDefence();
		UpdataCurData();
		SetNpcPhysicsDamage();

		// �ѵ�ǰ���������ͻ���
		SyncCurrentBaseAttriibute(ATTRIBUTE_DEXTERITY, m_nDexterity, m_nCurDexterity);

}

//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::AddBaseVitality(int nData)
{
	if (nData > 0 && nData <= m_nAttributePoint)
	{
		m_nVitality += nData;
		m_nAttributePoint -= nData;
		m_nCurVitality += nData;

		Npc[m_nIndex].AddBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * nData);
		Npc[m_nIndex].AddBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * nData);
		UpdataCurData();

		// �ѵ�ǰ���������ͻ���
		PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
		sSync.Attribute = PhongThanEncodeAttribute(2);
		sSync.Base = m_nVitality;
		sSync.Current = m_nCurVitality;
		sSync.RemainingPoints = m_nAttributePoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	}
}

void	KPlayer::ResetBaseVitality(int nData)
{
	m_nVitality = nData;
	m_nCurVitality = nData;

	Npc[m_nIndex].SetBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * nData);
	Npc[m_nIndex].SetBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * nData);
	UpdataCurData();

	// �ѵ�ǰ���������ͻ���
	SyncCurrentBaseAttriibute(ATTRIBUTE_VITALITY, m_nVitality, m_nCurVitality);
}
//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::AddBaseEngergy(int nData)
{
	if (nData > 0 && nData <= m_nAttributePoint)
	{
		m_nEngergy += nData;
		m_nAttributePoint -= nData;
		m_nCurEngergy += nData;

		Npc[m_nIndex].AddBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * nData);
		UpdataCurData();

		// �ѵ�ǰ���������ͻ���
		PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
		sSync.Attribute = PhongThanEncodeAttribute(3);
		sSync.Base = m_nEngergy;
		sSync.Current = m_nCurEngergy;
		sSync.RemainingPoints = m_nAttributePoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	}
}

void	KPlayer::ResetBaseEngergy(int nData)
{
	m_nEngergy = nData;
	m_nCurEngergy = nData;

	Npc[m_nIndex].SetBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * nData);
	UpdataCurData();

	// �ѵ�ǰ���������ͻ���
	SyncCurrentBaseAttriibute(ATTRIBUTE_ENGERGY, m_nEngergy, m_nCurEngergy);
}

#endif


#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::SetBaseStrength(int nData)
{
	m_nStrength += nData;
	//m_nAttributePoint -= nData;
	m_nCurStrength += nData;

	UpdataCurData();
	SetNpcPhysicsDamage();
	// �ѵ�ǰ���������ͻ���
	PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
	ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Attribute = PhongThanEncodeAttribute(0);
	sSync.Base = m_nStrength;
	sSync.Current = m_nCurStrength;
	sSync.RemainingPoints = m_nAttributePoint;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::SetBaseDexterity(int nData)
{
	m_nDexterity += nData;
	//m_nAttributePoint -= nData;
	m_nCurDexterity += nData;

	SetNpcAttackRating();
	SetNpcDefence();
	UpdataCurData();
	SetNpcPhysicsDamage();

	// �ѵ�ǰ���������ͻ���
	PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
	ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Attribute = PhongThanEncodeAttribute(1);
	sSync.Base = m_nDexterity;
	sSync.Current = m_nCurDexterity;
	sSync.RemainingPoints = m_nAttributePoint;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::SetBaseVitality(int nData)
{
	m_nVitality += nData;
	//m_nAttributePoint -= nData;
	m_nCurVitality += nData;

	Npc[m_nIndex].AddBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * nData);
	Npc[m_nIndex].AddBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * nData);
	UpdataCurData();

	// �ѵ�ǰ���������ͻ���
	PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
	ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Attribute = PhongThanEncodeAttribute(2);
	sSync.Base = m_nVitality;
	sSync.Current = m_nCurVitality;
	sSync.RemainingPoints = m_nAttributePoint;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::SetBaseEngergy(int nData)
{
	m_nEngergy += nData;
	//m_nAttributePoint -= nData;
	m_nCurEngergy += nData;

	Npc[m_nIndex].AddBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * nData);
	UpdataCurData();

	// �ѵ�ǰ���������ͻ���
	PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
	ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
	sSync.Attribute = PhongThanEncodeAttribute(3);
	sSync.Base = m_nEngergy;
	sSync.Current = m_nCurEngergy;
	sSync.RemainingPoints = m_nAttributePoint;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
}
#endif
//-------------------------------------------------------------------------
//	���ܣ��ı䵱ǰ����(�� nData С�� 0 ʱ������)
//-------------------------------------------------------------------------
void	KPlayer::ChangeCurStrength(int nData)
{
/*	if (m_nCurStrength + nData < m_nStrength)
return;
	*/
    m_nCurStrength += nData;
    SetNpcPhysicsDamage();
    // �ѵ�ǰ���������ͻ���
}

//-------------------------------------------------------------------------
//	���ܣ��ı䵱ǰ����(�� nData С�� 0 ʱ������)
//-------------------------------------------------------------------------
void	KPlayer::ChangeCurDexterity(int nData)
{
/*	if (m_nCurDexterity + nData < 0)
return;
	*/
    m_nCurDexterity += nData;

    int nRating = nData * 4;
    Npc[m_nIndex].m_CurrentAttackRating += nRating;

    int nDefence = nData / 4;
    Npc[m_nIndex].m_CurrentDefend += nDefence;

    SetNpcPhysicsDamage();

}


//-------------------------------------------------------------------------
//	���ܣ��ı䵱ǰ����(�� nData С�� 0 ʱ������)
//-------------------------------------------------------------------------
void	KPlayer::ChangeCurVitality(int nData)
{
/*	if (nData + m_nAttributePoint < 0)
return;
	*/
    m_nCurVitality += nData;

    Npc[m_nIndex].AddCurLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * nData);
    Npc[m_nIndex].AddCurStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * nData);

}

//-------------------------------------------------------------------------
//	���ܣ��ı䵱ǰ����(�� nData С�� 0 ʱ������)
//-------------------------------------------------------------------------
void	KPlayer::ChangeCurEngergy(int nData)
{
/*	if (m_nAttributePoint + nData < 0)
return;
	*/
    m_nCurEngergy += nData;

    Npc[m_nIndex].AddCurManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * nData);

}

//-------------------------------------------------------------------------
//	���ܣ����ӻ�������
//-------------------------------------------------------------------------
void	KPlayer::AddBaseLucky(int nData)
{
    m_nLucky += nData;
    Npc[m_nIndex].CalcCurLucky();
}

//-------------------------------------------------------------------------
//	���ܣ��ɵ�ǰ���������Ӧnpc�������˺�(PhysicsDamage)
//-------------------------------------------------------------------------
void	KPlayer::SetNpcPhysicsDamage()
{
    int		nMinDamage, nMaxDamage;
    m_ItemList.GetWeaponDamage(&nMinDamage, &nMaxDamage);

    if (m_ItemList.GetWeaponType() == equip_meleeweapon)	// (��ǰװ���ǽ�������)
    {
        nMinDamage += m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
        nMaxDamage += m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
        Npc[m_nIndex].SetPhysicsDamage(nMinDamage, nMaxDamage);
    }
    else if (m_ItemList.GetWeaponType() == equip_rangeweapon)	// (��ǰװ����Զ������)
    {
        nMinDamage += m_nCurDexterity / DEXTERITY_SET_DAMAGE_VALUE;
        nMaxDamage += m_nCurDexterity / DEXTERITY_SET_DAMAGE_VALUE;
        Npc[m_nIndex].SetPhysicsDamage(nMinDamage, nMaxDamage);
    }
    else
    {
        // Phong Than 2026-10-02: bare hands still hit by strength (VNG). Without a weapon the
        // damage was 0 + 0, KNpc::CalcDamage drops nMin + nMax <= 0 and no number is shown.
        nMinDamage += m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
        nMaxDamage += m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
        if (nMaxDamage < 1)
            nMaxDamage = 1;
        Npc[m_nIndex].SetPhysicsDamage(nMinDamage, nMaxDamage);
    }
}

//-------------------------------------------------------------------------
//	���ܣ��ɵ�ǰ���ݼ����Ӧnpc�Ĺ���������(AttackRating)
//-------------------------------------------------------------------------
void	KPlayer::SetNpcAttackRating()
{
    int		nRating;

    nRating = m_nDexterity * 4 - 28;
    Npc[m_nIndex].SetBaseAttackRating(nRating);
}

//-------------------------------------------------------------------------
//	���ܣ��ɵ�ǰ���ݼ����Ӧnpc�ķ�����
//-------------------------------------------------------------------------
void	KPlayer::SetNpcDefence()
{
    int		nDefence;

    nDefence = m_nDexterity / 4;
    Npc[m_nIndex].SetBaseDefence(nDefence);
}

/*
#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ɵ�ǰ���ݼ����Ӧnpc�������ٶ�
//-------------------------------------------------------------------------
void	KPlayer::SetNpcWalkSpeed()
{
int		nSpeed;
nSpeed = BASE_WALK_SPEED * (m_nCurDexterity + 320) / 320;
Npc[m_nIndex].SetBaseWalkSpeed(nSpeed);
}
#endif
*/

/*
#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ɵ�ǰ���ݼ����Ӧnpc���ܲ��ٶ�
//-------------------------------------------------------------------------
void	KPlayer::SetNpcRunSpeed()
{
int		nSpeed;
nSpeed = BASE_RUN_SPEED * (m_nCurDexterity + 320) / 320;
Npc[m_nIndex].SetBaseRunSpeed(nSpeed);
}
#endif
*/

//-------------------------------------------------------------------------
//	���ܣ����Ӿ���(ԭʼ���ݣ���δ������������Ҫ������ӵ�Ӱ��)
//-------------------------------------------------------------------------
#ifdef _SERVER
//void	KPlayer::AddExp(int nExp, int nTarLevel)
void	KPlayer::AddExp(int nExp, int nTarLevel, BOOL bCheck) // TamLTM fix exp
{
	// û�����
	if ( !m_cTeam.m_nFlag )
	{
		AddSelfExp(nExp, nTarLevel);
		return;
	}

	// �Ѿ����
	int		i, j, nShareFlag[MAX_TEAM_MEMBER + 1], nRegion, nTotalLevel = 0, nTotalPlayer = 0;
	memset(nShareFlag, 0, sizeof(nShareFlag));

	int		nMpsX, nMpsY, nNpcIdx, nSelfSubIdx, nSelfMpsX, nSelfMpsY;

	nSelfSubIdx = Npc[m_nIndex].m_SubWorldIndex;
	SubWorld[nSelfSubIdx].Map2Mps(
		Npc[m_nIndex].m_RegionIndex,
		Npc[m_nIndex].m_MapX,
		Npc[m_nIndex].m_MapY,
		Npc[m_nIndex].m_OffX,
		Npc[m_nIndex].m_OffY,
		&nSelfMpsX,
		&nSelfMpsY);

	// �ӳ�
	nNpcIdx = Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex;
	if (nSelfSubIdx == Npc[nNpcIdx].m_SubWorldIndex)
	{
		SubWorld[Npc[nNpcIdx].m_SubWorldIndex].Map2Mps(
			Npc[nNpcIdx].m_RegionIndex,
			Npc[nNpcIdx].m_MapX,
			Npc[nNpcIdx].m_MapY,
			Npc[nNpcIdx].m_OffX,
			Npc[nNpcIdx].m_OffY,
			&nMpsX,
			&nMpsY);
		if ( (nMpsX - nSelfMpsX) * (nMpsX - nSelfMpsX) +
			(nMpsY - nSelfMpsY) * (nMpsY - nSelfMpsY) <=
			PLAYER_SHARE_EXP_DISTANCE * PLAYER_SHARE_EXP_DISTANCE)
		{
			nTotalLevel += Npc[nNpcIdx].m_Level;
			nShareFlag[0] = 1;
			nTotalPlayer++;
			if (nTotalPlayer >= g_Team[m_cTeam.m_nID].m_nMemNum + 1)
				goto SharePlace;
		}
	}
	// ��Ա
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_cTeam.m_nID].m_nMember[i] < 0)
			continue;
		nNpcIdx = Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex;
		if (nSelfSubIdx != Npc[nNpcIdx].m_SubWorldIndex)
			continue;
		SubWorld[Npc[nNpcIdx].m_SubWorldIndex].Map2Mps(
			Npc[nNpcIdx].m_RegionIndex,
			Npc[nNpcIdx].m_MapX,
			Npc[nNpcIdx].m_MapY,
			Npc[nNpcIdx].m_OffX,
			Npc[nNpcIdx].m_OffY,
			&nMpsX,
			&nMpsY);
		if ( (nMpsX - nSelfMpsX) * (nMpsX - nSelfMpsX) +
			(nMpsY - nSelfMpsY) * (nMpsY - nSelfMpsY) >
			PLAYER_SHARE_EXP_DISTANCE * PLAYER_SHARE_EXP_DISTANCE)
			continue;
		nTotalLevel += Npc[nNpcIdx].m_Level;
		nShareFlag[i + 1] = 1;
		nTotalPlayer++;
		if (nTotalPlayer >= g_Team[m_cTeam.m_nID].m_nMemNum + 1)
			goto SharePlace;
	}

SharePlace:
	_ASSERT(nTotalPlayer >= 1);
	_ASSERT(nTotalLevel >= 1);
	if (nTotalPlayer < 1 || nTotalLevel < 1)
		return;
	if (nTotalPlayer == 1)
	{
		AddSelfExp(nExp, nTarLevel);
		return;
	}

/*	int		k, nGetExp;
	k = 100 + nTotalPlayer * 15;


	// ���ӳ����侭��
	if (nShareFlag[0])
	{
		nGetExp = k * Npc[Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex].m_Level / nTotalLevel;
		if (nGetExp <= 0)
			nGetExp = 1;
		Player[g_Team[m_cTeam.m_nID].m_nCaptain].AddSelfExp(nExp * nGetExp / 100, nTarLevel);

		// LeadExp = �����ṩ�ľ���ֵ * �� * �����ߵȼ� / �����ߵȼ��ͣ�
		int		nLeadExp = nExp * k * PlayerSet.m_cLevelAdd.GetLeadExpShare(Npc[m_nIndex].m_Series) * (nTotalLevel - Npc[m_nIndex].m_Level) / (nTotalLevel * 10000);
		Player[g_Team[m_cTeam.m_nID].m_nCaptain].AddLeadExp(nLeadExp);
	}
	// ����Ա���侭��
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if ( !nShareFlag[i + 1] )
			continue;
		nGetExp = k * Npc[Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex].m_Level / nTotalLevel;
		if (nGetExp <= 0)
			nGetExp = 1;
		Player[g_Team[m_cTeam.m_nID].m_nMember[i]].AddSelfExp(nExp * nGetExp / 100, nTarLevel);
	}*/

	// TamLTM fix exp
	int		k, nGetExp;
	k = 100 + (nTotalPlayer-1) * 15;

	int ShareExp;
	nTotalPlayer = g_Team[m_cTeam.m_nID].m_nMemNum + 1;
	if (nTotalPlayer == 2)
	ShareExp = 80;
	else if (nTotalPlayer == 3)
	ShareExp = 70;
	else if (nTotalPlayer == 4)
	ShareExp = 60;
	else if (nTotalPlayer == 5)
	ShareExp = 55;
	else if (nTotalPlayer == 6)
	ShareExp = 55;
	else if (nTotalPlayer == 7)
	ShareExp = 50;
	else if (nTotalPlayer == 8)
	ShareExp = 50;
	else
	ShareExp = 60;
	if (nShareFlag[0] == 1)
	{
		nGetExp = k * Npc[Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nIndex].m_Level / nTotalLevel;
		if (nGetExp < 5)
			nGetExp = 5;
		if (m_nPlayerIndex != g_Team[m_cTeam.m_nID].m_nCaptain || bCheck)
		{
			Player[g_Team[m_cTeam.m_nID].m_nCaptain].AddSelfExp(nExp * ShareExp / 100, nTarLevel);
		}
		else
		{
			Player[g_Team[m_cTeam.m_nID].m_nCaptain].AddSelfExp(nExp , nTarLevel);
		}
		int		nLeadExp = nExp * k * PlayerSet.m_cLevelAdd.GetLeadExpShare(Npc[m_nIndex].m_Series) * (nTotalLevel - Npc[m_nIndex].m_Level) / (nTotalLevel * 10000);
		Player[g_Team[m_cTeam.m_nID].m_nCaptain].AddLeadExp(nLeadExp);
	}
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (nShareFlag[i + 1] != 1)
			continue;
		nGetExp = k * Npc[Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nIndex].m_Level / nTotalLevel;
		if (nGetExp < 5)
			nGetExp = 5;
		if (m_nPlayerIndex != g_Team[m_cTeam.m_nID].m_nMember[i] || bCheck)
		{
			Player[g_Team[m_cTeam.m_nID].m_nMember[i]].AddSelfExp(nExp * ShareExp / 100, nTarLevel);
		}
		else
		{
			Player[g_Team[m_cTeam.m_nID].m_nMember[i]].AddSelfExp(nExp, nTarLevel);
		}
	}
	//end code*/
}

//-------------------------------------------------------------------------
//	���ܣ����Ӿ���(����Ҫ�پ����������Ĵ���)
//  nExp ���ӵľ���  nTarLevel ��������npc�ĵȼ�
//	������� sourcesafe�߻���\document\System\ս�������趨.doc
//-------------------------------------------------------------------------
void	KPlayer::AddSelfExp(int nExp, int nTarLevel)
{
	if (nExp <= 0)
		return;
	if (Npc[m_nIndex].m_Doing == do_death || Npc[m_nIndex].m_Doing == do_revive)
		return;

	int	nGetExp = 0;
	int	nSubLevel = abs(Npc[m_nIndex].m_Level - nTarLevel);

	nExp *= g_ExpRate;

	// Phong Than 2026-10-03 noexppenalty (user request): full EXP whatever the level difference, on every
	// map. Was -0.5%/level for lower monsters and the desertexp -5%/level (floor 50%) for higher ones.
	nGetExp = nExp;
	(void)nSubLevel;

	if (nGetExp <= 0)
		nGetExp = 1;

	// VNG getmoreexp_p stores a percentage bonus. A value of 100 means
	// +100% (double experience), not 100% of the original experience.
	if(Npc[m_nIndex].m_CurrentExpEnhance)
		nGetExp = nGetExp *
		(MAX_PERCENT + Npc[m_nIndex].m_CurrentExpEnhance) / MAX_PERCENT;
	m_nExp += nGetExp;

	if(g_Skill120ExpRate)
		AddSkillExp(nGetExp * g_Skill120ExpRate / MAX_PERCENT);

	if (m_nExp > m_nNextLevelExp)	// ����
	{
			LevelUp();
			return;
	}
	else if (m_nExp == m_nNextLevelExp)						// ͬ������
	{
		if (Npc[m_nIndex].m_Level < MAX_LEVEL)
		{
			LevelUp();
			return;
		}
	}
	PHONGTHAN_EXPERIENCE_EVENT	sSyncExp;
	ZeroMemory(&sSyncExp, sizeof(sSyncExp));
	PhongThanInitializeWireHeader(&sSyncExp.Header, PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE, sizeof(sSyncExp), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSyncExp.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSyncExp.EntityId = Npc[m_nIndex].m_dwID;
	sSyncExp.Experience = m_nExp;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSyncExp, sizeof(PHONGTHAN_EXPERIENCE_EVENT));
}

void KPlayer::AddSkillExp(int nExp)
{
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (Npc[m_nIndex].m_SkillList.m_Skills[i].SkillLevel <= 0)
			continue;
		if (Npc[m_nIndex].m_SkillList.m_Skills[i].SkillLevel >= MAX_TRAIN_SKILLEXPLEVEL)
			continue;
		if (Npc[m_nIndex].m_SkillList.m_Skills[i].NextSkillExp <= 0)
			continue;

		KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId, Npc[m_nIndex].m_SkillList.m_Skills[i].CurrentSkillLevel);
		if (pOrdinSkill)
		{
			if (pOrdinSkill->IsExp() && !pOrdinSkill->IsTargetEnemy())
			{
				if (Npc[m_nIndex].m_SkillList.IncreaseExp(i, nExp))
					this->UpdataCurData();

				PHONGTHAN_SKILL_LEVEL_UPDATE sSkill;
				ZeroMemory(&sSkill, sizeof(sSkill));
	PhongThanInitializeWireHeader(&sSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(sSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSkill.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSkill.EntityId = Npc[m_nIndex].m_dwID;
				sSkill.SkillId = Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId;
				sSkill.Level = Npc[m_nIndex].m_SkillList.GetLevel(Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId);
				sSkill.BonusLevel = Npc[m_nIndex].m_SkillList.GetAddLevel(Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId);
				sSkill.Experience = Npc[m_nIndex].m_SkillList.GetExp(Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId);
				sSkill.Temporary = (Npc[m_nIndex].m_SkillList.IsTempSkill(Npc[m_nIndex].m_SkillList.m_Skills[i].SkillId)) ? 1 : 0;
				sSkill.RemainingPoints = m_nSkillPoint;
				g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSkill, sizeof(sSkill));
			}
		}
	}
}
//-------------------------------------------------------------------------
//	���ܣ�ֱ�����Ӿ���ֵ����������������
//-------------------------------------------------------------------------
void	KPlayer::DirectAddExp(int nExp)
{
	m_nExp += nExp;
	if (m_nExp < 0)
	{
		if (-m_nExp > m_nNextLevelExp)
			m_nExp = -m_nNextLevelExp;
	}

	if (m_nExp > m_nNextLevelExp)	// ����
	{
			LevelUp();
			return;
	}
	else if (m_nExp == m_nNextLevelExp)						// ͬ������
	{
		if (Npc[m_nIndex].m_Level < MAX_LEVEL)
		{
			LevelUp();
			return;
		}
	}
	PHONGTHAN_EXPERIENCE_EVENT	sSyncExp;
	ZeroMemory(&sSyncExp, sizeof(sSyncExp));
	PhongThanInitializeWireHeader(&sSyncExp.Header, PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE, sizeof(sSyncExp), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSyncExp.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSyncExp.EntityId = Npc[m_nIndex].m_dwID;
	sSyncExp.Experience = m_nExp;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSyncExp, sizeof(PHONGTHAN_EXPERIENCE_EVENT));
}

//-------------------------------------------------------------------------
//	���ܣ������һ��
//-------------------------------------------------------------------------
void	KPlayer::LevelUp()
{
	m_nExp = 0;
	if (Npc[m_nIndex].m_Level >= MAX_LEVEL)
		return;
	Npc[m_nIndex].m_Level++;
	m_nNextLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(Npc[m_nIndex].m_Level, Npc[m_nIndex].m_byTranslife);

	// -------------------------- �ȼ�����ʱ������������ ----------------------
	// ����δ�������Ե�
	m_nAttributePoint += PLAYER_LEVEL_ADD_ATTRIBUTE;
	// ����δ���似�ܵ�
	m_nSkillPoint += PLAYER_LEVEL_ADD_SKILL;

	// ��������������������ֵ��Ӱ������������������������ֵ�����أ��ȼ������Ե㣬Ӱ�쵱ǰ�������ֵ�����أ�װ�������ܡ�ҩ���ʱ����
	LevelAddBaseLifeMax();
	LevelAddBaseStaminaMax();
	LevelAddBaseManaMax();
	//	Npc[m_nIndex].ResetLifeReplenish();

	// �������ֿ��Եı仯 �𡢱��������硢����
	Npc[m_nIndex].m_FireResist				= PlayerSet.m_cLevelAdd.GetFireResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentFireResist		= Npc[m_nIndex].m_FireResist;
	Npc[m_nIndex].m_ColdResist				= PlayerSet.m_cLevelAdd.GetColdResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentColdResist		= Npc[m_nIndex].m_ColdResist;
	Npc[m_nIndex].m_PoisonResist			= PlayerSet.m_cLevelAdd.GetPoisonResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentPoisonResist		= Npc[m_nIndex].m_PoisonResist;
	Npc[m_nIndex].m_LightResist				= PlayerSet.m_cLevelAdd.GetLightResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentLightResist		= Npc[m_nIndex].m_LightResist;
	Npc[m_nIndex].m_EarthResist				= PlayerSet.m_cLevelAdd.GetEarthResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentEarthResist		= Npc[m_nIndex].m_EarthResist;
	Npc[m_nIndex].m_PhysicsResist			= PlayerSet.m_cLevelAdd.GetPhysicsResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
	Npc[m_nIndex].m_CurrentPhysicsResist	= Npc[m_nIndex].m_PhysicsResist;
	Npc[m_nIndex].m_FireResistMax			= BASE_FIRE_RESIST_MAX;
	Npc[m_nIndex].m_ColdResistMax			= BASE_COLD_RESIST_MAX;
	Npc[m_nIndex].m_PoisonResistMax			= BASE_POISON_RESIST_MAX;
	Npc[m_nIndex].m_LightResistMax			= BASE_LIGHT_RESIST_MAX;
	Npc[m_nIndex].m_EarthResistMax			= BASE_EARTH_RESIST_MAX;
	Npc[m_nIndex].m_PhysicsResistMax		= BASE_PHYSICS_RESIST_MAX;
	Npc[m_nIndex].m_CurrentFireResistMax	= Npc[m_nIndex].m_FireResistMax;
	Npc[m_nIndex].m_CurrentColdResistMax	= Npc[m_nIndex].m_ColdResistMax;
	Npc[m_nIndex].m_CurrentPoisonResistMax	= Npc[m_nIndex].m_PoisonResistMax;
	Npc[m_nIndex].m_CurrentLightResistMax	= Npc[m_nIndex].m_LightResistMax;
	Npc[m_nIndex].m_CurrentEarthResistMax	= Npc[m_nIndex].m_EarthResistMax;
	Npc[m_nIndex].m_CurrentPhysicsResistMax	= Npc[m_nIndex].m_PhysicsResistMax;

	int nOldCurCamp = Npc[m_nIndex].m_CurrentCamp;
	// ����װ����������Ϣ���µ�ǰ����
	this->UpdataCurData();
	SetNpcPhysicsDamage();
	Npc[m_nIndex].SetCurrentCamp(nOldCurCamp);

	// ����������������ֵ����
	Npc[m_nIndex].m_CurrentLife = Npc[m_nIndex].m_CurrentLifeMax;
	Npc[m_nIndex].m_CurrentStamina = Npc[m_nIndex].m_CurrentStaminaMax;
	Npc[m_nIndex].m_CurrentMana = Npc[m_nIndex].m_CurrentManaMax;

	// ���ͻ��˷�������
	// �Լ�������
	PHONGTHAN_LEVEL_EVENT	sLevelUp;
	ZeroMemory(&sLevelUp, sizeof(sLevelUp));
	PhongThanInitializeWireHeader(&sLevelUp.Header, PHONGTHAN_MSG_GAMEPLAY_LEVEL, sizeof(sLevelUp), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sLevelUp.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sLevelUp.EntityId = Npc[m_nIndex].m_dwID;
	sLevelUp.ResetAttributes		= FALSE;
	sLevelUp.Level			= (DWORD)Npc[m_nIndex].m_Level;
	sLevelUp.Experience				= m_nExp;
	sLevelUp.AttributePoints	= m_nAttributePoint;
	sLevelUp.SkillPoints		= m_nSkillPoint;
	sLevelUp.BaseMaxLife		= Npc[m_nIndex].m_LifeMax;
	sLevelUp.BaseMaxStamina	= Npc[m_nIndex].m_StaminaMax;
	sLevelUp.BaseMaxMana		= Npc[m_nIndex].m_ManaMax;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLevelUp, sizeof(PHONGTHAN_LEVEL_EVENT));
	// �����ѷ��͵ȼ�����
	if ( m_cTeam.m_nFlag )
	{
		PLAYER_TEAMMATE_LEVEL_SYNC	sLevel;
		sLevel.ProtocolType = s2c_teammatelevel;
		sLevel.m_btLevel = (DWORD)Npc[m_nIndex].m_Level;
		sLevel.m_dwTeammateID = Npc[m_nIndex].m_dwID;
		// ���ӳ���
		if (m_cTeam.m_nFigure != TEAM_CAPTAIN)
			g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nCaptain].m_nNetConnectIdx, (BYTE*)&sLevel, sizeof(PLAYER_TEAMMATE_LEVEL_SYNC));
		for (int i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (g_Team[m_cTeam.m_nID].m_nMember[i] >= 0 && g_Team[m_cTeam.m_nID].m_nMember[i] != GetPlayerIndex())
				g_pServer->PackDataToClient(Player[g_Team[m_cTeam.m_nID].m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sLevel, sizeof(PLAYER_TEAMMATE_LEVEL_SYNC));
		}
	}
	ExecuteScript(LEVELUP_SCRIPT, NORMAL_FUNCTION_NAME, 0);
	//TamLTM fix save data;
	if (this->CanSave())
	{
		if (this->Save())
		{
			this->m_uMustSave = SAVE_REQUEST;
		//	g_DebugLog("CanSave(1)");
		}

	}
	//end code;
}
#endif
// need spe edit not end
void	KPlayer::UpdataCurData()
{
    if (m_nIndex <= 0 || m_nIndex >= MAX_NPC)
        return;
    Npc[m_nIndex].m_SkillList.m_nAllSkillV = 0;
    for (int i = 0; i < MAX_NPCSKILL; i++)
    {
        int nAddLevel = Npc[m_nIndex].m_SkillList.m_Skills[i].AddLevel;
        if (nAddLevel > 0)
        {
            Npc[m_nIndex].m_SkillList.m_Skills[i].CurrentSkillLevel -= nAddLevel;
            Npc[m_nIndex].m_SkillList.m_Skills[i].AddLevel = Npc[m_nIndex].m_SkillList.m_nAllSkillV;
        }
        if (Npc[m_nIndex].m_SkillList.m_Skills[i].TempSkill)
            Npc[m_nIndex].m_SkillList.RemoveIdx(i);
    }
    Npc[m_nIndex].m_CurrentLifeMax		= Npc[m_nIndex].m_LifeMax;
    Npc[m_nIndex].m_CurrentManaMax		= Npc[m_nIndex].m_ManaMax;
    Npc[m_nIndex].m_CurrentStaminaMax	= Npc[m_nIndex].m_StaminaMax;
    Npc[m_nIndex].m_CurrentAttackRating	= Npc[m_nIndex].m_AttackRating;
    Npc[m_nIndex].m_CurrentAttackSpeed	= Npc[m_nIndex].m_AttackSpeed;
    Npc[m_nIndex].m_CurrentCastSpeed	= Npc[m_nIndex].m_CastSpeed;
    ZeroMemory(&Npc[m_nIndex].m_CurrentColdDamage, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_CurrentColdMagic, sizeof(KMagicAttrib));
    Npc[m_nIndex].m_CurrentColdEnhance	= 0;
    Npc[m_nIndex].m_CurrentColdResist	= Npc[m_nIndex].m_ColdResist;
    Npc[m_nIndex].m_CurrentColdResistMax	= Npc[m_nIndex].m_ColdResistMax;
    Npc[m_nIndex].m_CurrentDamage2Mana	= 0;
    Npc[m_nIndex].m_CurrentDeadlyStrikeEnhanceP	= 0;
    Npc[m_nIndex].m_CurrentFatallyStrikeEnhanceP	= 0;
    Npc[m_nIndex].m_CurrentFatallyStrikeResP = 0;
    Npc[m_nIndex].m_CurrentExDefend = 0;
    Npc[m_nIndex].m_CurrentIgnoreDefensePercent = 0;
    Npc[m_nIndex].m_CurrentIgnoreExDefence = 0;
    Npc[m_nIndex].m_CurrentIgnoreFireResist = 0;
    Npc[m_nIndex].m_CurrentIgnoreColdResist = 0;
    Npc[m_nIndex].m_CurrentIgnoreLightResist = 0;
    Npc[m_nIndex].m_CurrentIgnoreEarthResist = 0;
    Npc[m_nIndex].m_CurrentColdDamageMinPercent = 0;
    Npc[m_nIndex].m_CurrentColdDamageMaxPercent = 0;
    Npc[m_nIndex].m_CurrentAllMagicDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentFireDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentColdDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentLightDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentEarthDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentReducePhysicsDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentReduceMagicDeadlyStrike = 0;
    Npc[m_nIndex].m_CurrentDefend		= Npc[m_nIndex].m_Defend;
    Npc[m_nIndex].m_CurrentElementDamageReduce = 0;
    ZeroMemory(&Npc[m_nIndex].m_CurrentFireDamage, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_CurrentFireMagic, sizeof(KMagicAttrib));
    Npc[m_nIndex].m_CurrentFireEnhance	= 0;
    Npc[m_nIndex].m_CurrentFireResist	= Npc[m_nIndex].m_FireResist;
    Npc[m_nIndex].m_CurrentFireResistMax	= Npc[m_nIndex].m_FireResistMax;
    Npc[m_nIndex].m_CurrentHandEnhance	= 0;
    Npc[m_nIndex].m_CurrentHitRecover	= Npc[m_nIndex].m_HitRecover;
    Npc[m_nIndex].m_CurrentJumpSpeed	= Npc[m_nIndex].m_JumpSpeed;
    Npc[m_nIndex].m_CurrentLifeReplenish	= Npc[m_nIndex].m_LifeReplenish;
    Npc[m_nIndex].m_CurrentLifeReplenishPercent	= 0;
    Npc[m_nIndex].m_CurrentLifeStolen	= 0;
    ZeroMemory(&Npc[m_nIndex].m_CurrentLightDamage, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_CurrentLightMagic, sizeof(KMagicAttrib));
	ZeroMemory(&Npc[m_nIndex].m_CurrentEarthDamage, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_CurrentEarthMagic, sizeof(KMagicAttrib));
    Npc[m_nIndex].m_CurrentLightEnhance	= 0;
    Npc[m_nIndex].m_CurrentLightResist	= Npc[m_nIndex].m_LightResist;
    Npc[m_nIndex].m_CurrentLightResistMax = Npc[m_nIndex].m_LightResistMax;
	Npc[m_nIndex].m_CurrentEarthEnhance	= 0;
    Npc[m_nIndex].m_CurrentEarthResist	= Npc[m_nIndex].m_EarthResist;
    Npc[m_nIndex].m_CurrentEarthResistMax = Npc[m_nIndex].m_EarthResistMax;
    Npc[m_nIndex].m_CurrentManaReplenish	= Npc[m_nIndex].m_ManaReplenish;
    Npc[m_nIndex].m_CurrentManaStolen	= 0;
    Npc[m_nIndex].m_CurrentMeleeDmgRet	= 0;
    Npc[m_nIndex].m_CurrentMeleeDmgRetPercent = 0;
    ZeroMemory(&Npc[m_nIndex].m_CurrentMeleeEnhance, sizeof(Npc[m_nIndex].m_CurrentMeleeEnhance));
    Npc[m_nIndex].m_CurrentPhysicsResist	= Npc[m_nIndex].m_PhysicsResist;
    Npc[m_nIndex].m_CurrentPhysicsResistMax	= Npc[m_nIndex].m_PhysicsResistMax;
    Npc[m_nIndex].m_CurrentPiercePercent	= 0;
    ZeroMemory(&Npc[m_nIndex].m_CurrentPoisonDamage, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_CurrentPoisonMagic, sizeof(KMagicAttrib));
    Npc[m_nIndex].m_CurrentPoisonEnhance	= 0;
    Npc[m_nIndex].m_CurrentPoisonResist	= Npc[m_nIndex].m_PoisonResist;
    Npc[m_nIndex].m_CurrentPoisonResistMax	= Npc[m_nIndex].m_PoisonResistMax;
    Npc[m_nIndex].m_CurrentRangeDmgRet	= 0;
    Npc[m_nIndex].m_CurrentRangeDmgRetPercent	= 0;
    Npc[m_nIndex].m_CurrentRangeEnhance	= 0;
    Npc[m_nIndex].m_CurrentRunSpeed	= Npc[m_nIndex].m_RunSpeed;
    Npc[m_nIndex].m_CurrentSlowMissle	= 0;
    Npc[m_nIndex].m_CurrentStaminaGain	= Npc[m_nIndex].m_StaminaGain;
    Npc[m_nIndex].m_CurrentStaminaLoss	= Npc[m_nIndex].m_StaminaLoss;
    Npc[m_nIndex].m_CurrentStaminaStolen	= 0;
    Npc[m_nIndex].m_CurrentVisionRadius	= Npc[m_nIndex].m_VisionRadius;
    Npc[m_nIndex].m_CurrentWalkSpeed	= Npc[m_nIndex].m_WalkSpeed;
    Npc[m_nIndex].m_CurrentAddPhysicsDamage = 0;
    Npc[m_nIndex].m_CurrentAddPhysicsMagic = 0;
    Npc[m_nIndex].m_CurrentAttackSpeed = BASE_ATTACK_SPEED;
    Npc[m_nIndex].m_CurrentCastSpeed = BASE_CAST_SPEED;

    m_nCurStrength						= m_nStrength;
    m_nCurDexterity						= m_nDexterity;
    m_nCurVitality						= m_nVitality;
    m_nCurEngergy						= m_nEngergy;

    Npc[m_nIndex].m_CurrentLucky		= m_nLucky;
    Npc[m_nIndex].m_CurrentExpEnhance	= 0;
    Npc[m_nIndex].m_CurrentFreezeTimeReducePercent = 0;
    Npc[m_nIndex].m_CurrentPoisonTimeReducePercent = 0;
    Npc[m_nIndex].m_CurrentStunTimeReducePercent = 0;
    Npc[m_nIndex].m_CurrentDamageReduce = 0;
    Npc[m_nIndex].m_CurrentReturnSkillPercent = 0;
    Npc[m_nIndex].m_CurrentIgnoreSkillPercent = 0;
    Npc[m_nIndex].m_CurrentPoisonDamageReturnPercent = 0;
    ZeroMemory(&Npc[m_nIndex].m_PhysicsArmor, sizeof(Npc[m_nIndex].m_PhysicsArmor));
    ZeroMemory(&Npc[m_nIndex].m_ColdArmor, sizeof(Npc[m_nIndex].m_ColdArmor));
    ZeroMemory(&Npc[m_nIndex].m_FireArmor, sizeof(Npc[m_nIndex].m_FireArmor));
    ZeroMemory(&Npc[m_nIndex].m_PoisonArmor, sizeof(Npc[m_nIndex].m_PoisonArmor));
    ZeroMemory(&Npc[m_nIndex].m_LightArmor, sizeof(Npc[m_nIndex].m_LightArmor));
	ZeroMemory(&Npc[m_nIndex].m_EarthArmor, sizeof(Npc[m_nIndex].m_EarthArmor));
    ZeroMemory(&Npc[m_nIndex].m_ManaShield, sizeof(KMagicAttrib));
    ZeroMemory(&Npc[m_nIndex].m_ReplySkill, sizeof(KMagicAutoSkill) * MAX_AUTOSKILL);
    ZeroMemory(&Npc[m_nIndex].m_RescueSkill, sizeof(KMagicAutoSkill) * MAX_AUTOSKILL);
    ZeroMemory(&Npc[m_nIndex].m_AttackSkill, sizeof(KMagicAutoSkill) * MAX_AUTOSKILL);
    ZeroMemory(&Npc[m_nIndex].m_DeathSkill, sizeof(KMagicAutoSkill) * MAX_AUTOSKILL);
    Npc[m_nIndex].m_CurrentManaShield = 0;
    Npc[m_nIndex].m_CurrentStaticMagicShieldP = 0;
    Npc[m_nIndex].m_CurrentReturnResPercent = 0;
    Npc[m_nIndex].m_CurrentFiveElementsEnhance	= 0;
    Npc[m_nIndex].m_CurrentSkillEnhancePercent = 0;
    Npc[m_nIndex].m_CurrentFiveElementsResist = 0;
    Npc[m_nIndex].m_CurrentIgnoreNegativeStateP = 0;
    Npc[m_nIndex].m_CurrentManaToSkillEnhanceP	= 0;
    Npc[m_nIndex].m_CurrentExpSkillsEnchance	= 1; //TamLTM ExpSkills x2

    ReCalcEquip();
    ReCalcState();
#ifdef _SERVER
    // skilllv: passives follow bonus levels from equipment (see KSkillList::PtSkillLvRefreshPassive)
    Npc[m_nIndex].m_SkillList.PtSkillLvRefreshPassive();
#endif
}

#ifdef _SERVER
// Set-activation aura (Phong Than 2026-09-29). The rebuilt source applied set
// attributes but never showed the VNG set glow. State graphics come from
// \settings\npcres\ state-graphics table (VNG): 26..28 = circle-perfect1..3 (set effect 1-3).
// 3-4 pieces of one set -> 26, full set (5+) -> 27. The node is a temporary
// graphics-only state (no attributes, no timeout) like SetExpandRank uses.
enum { PT_SET_AURA_PARTIAL = 26, PT_SET_AURA_FULL = 27, PT_SET_AURA_LAST = 28 };
static void PhongThanUpdateSetAura(KItemList& List, KNpc& Owner)
{
    int nBest = 0;
    for (int i = 0; i < itempart_num; ++i)
    {
        int nIdx = List.m_EquipItem[i];
        if (nIdx <= 0 || nIdx >= MAX_ITEM || Item[nIdx].GetGenre() != item_equip)
            continue;
        int nGroup = Item[nIdx].GetGroup(), nSet = Item[nIdx].GetSetID();
        if (nGroup <= 0 || nSet <= 0)
            continue;
        int nCount = 0;
        for (int j = 0; j < itempart_num; ++j)
        {
            int nOther = List.m_EquipItem[j];
            if (nOther > 0 && nOther < MAX_ITEM && Item[nOther].GetGenre() == item_equip &&
                Item[nOther].GetGroup() == nGroup && Item[nOther].GetSetID() == nSet)
                ++nCount;
        }
        if (nCount > nBest)
            nBest = nCount;
    }
    int nWanted = nBest >= 5 ? PT_SET_AURA_FULL : (nBest >= 3 ? PT_SET_AURA_PARTIAL : 0);

    KStateNode* pFound = NULL;
    KStateNode* pNode = (KStateNode*)Owner.m_StateSkillList.GetHead();
    while (pNode)
    {
        KStateNode* pNext = (KStateNode*)pNode->GetNext();
        if (pNode->m_bTempStateGraphics && pNode->m_SkillID == 0 &&
            pNode->m_StateGraphics >= PT_SET_AURA_PARTIAL && pNode->m_StateGraphics <= PT_SET_AURA_LAST)
        {
            if (pFound || nWanted == 0)
            {
                pNode->Remove();
                delete pNode;
            }
            else
                pFound = pNode;
        }
        pNode = pNext;
    }
    if (nWanted == 0)
    {
        Owner.UpdateNpcStateInfo();
        return;
    }
    if (!pFound)
    {
        pFound = new KStateNode;
        if (!pFound)
            return;
        ZeroMemory(pFound->m_State, sizeof(pFound->m_State));
        pFound->m_SkillID = 0;
        pFound->m_Level = 0;
        pFound->m_LeftTime = -1;
        pFound->m_bOverLook = TRUE;
        pFound->m_bTempStateGraphics = TRUE;
        Owner.m_StateSkillList.AddTail(pFound);
    }
    pFound->m_StateGraphics = nWanted;
    Owner.UpdateNpcStateInfo();
}
#endif

void KPlayer::ReCalcEquip()
{
    _ASSERT(m_nIndex > 0 && m_nIndex < MAX_NPC);

    for (int i = 0; i < itempart_num; i++)
    {
        int nIdx = m_ItemList.m_EquipItem[i];
        if (!nIdx)
            continue;
        if ((i ==  itempart_horse) && (!Npc[m_nIndex].m_bRideHorse))
            continue;

        int nGoldAct = m_ItemList.GetGoldEquipEnhance(i);
		// A set-wide effect is shown on every piece but applied only once.
		if (nGoldAct > 0)
		{
			for (int previous = 0; previous < i; ++previous)
			{
				int other = m_ItemList.m_EquipItem[previous];
				if (other > 0 && other < MAX_ITEM && Item[other].GetSetID() == Item[nIdx].GetSetID() &&
					m_ItemList.GetGoldEquipEnhance(previous) > 0)
					{ nGoldAct = 0; break; }
			}
		}
        Item[nIdx].ApplyMagicAttribToNPC(&Npc[m_nIndex], 0, nGoldAct);
    }
#ifdef _SERVER
    PhongThanUpdateSetAura(m_ItemList, Npc[m_nIndex]);
#endif
}

void KPlayer::ReCalcState()
{
    _ASSERT(m_nIndex > 0 && m_nIndex < MAX_NPC);

    Npc[m_nIndex].ReCalcStateEffect();
}

//-------------------------------------------------------------------------
//	���ܣ�����ͳ��������
//-------------------------------------------------------------------------
void	KPlayer::AddLeadExp(int nExp)
{
    if (m_nLeadLevel >= MAX_LEAD_LEVEL)
        return;
    if (Npc[m_nIndex].m_Doing == do_death || Npc[m_nIndex].m_Doing == do_revive)
        return;
    m_nLeadExp += nExp;
    if (m_nLeadExp >= (DWORD)PlayerSet.m_cLeadExp.GetLevelExp(m_nLeadLevel))
    {
        // ����
        m_nLeadLevel = PlayerSet.m_cLeadExp.GetLevel(m_nLeadExp, m_nLeadLevel);
#ifndef _SERVER
        m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(m_nLeadLevel);
#endif
    }

#ifdef _SERVER
    PLAYER_LEAD_EXP_SYNC	sLeadExp;
	sLeadExp.ProtocolType = s2c_playersyncleadexp;
	sLeadExp.m_nLeadLevel = 0;
	sLeadExp.m_nLeadExp = m_nLeadExp;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLeadExp, sizeof(PLAYER_LEAD_EXP_SYNC));
#endif

}

void	KPlayer::SetLeadLevel(int nLevel)
{
    if (nLevel <= 0 || nLevel > MAX_LEAD_LEVEL)
        return;
    if (Npc[m_nIndex].m_Doing == do_death || Npc[m_nIndex].m_Doing == do_revive)
        return;
    m_nLeadLevel = nLevel;
    m_nLeadExp = (DWORD)PlayerSet.m_cLeadExp.GetLevelExp(m_nLeadLevel-1);

#ifndef _SERVER
    m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(m_nLeadLevel);
#endif

#ifdef _SERVER
    PLAYER_LEAD_EXP_SYNC	sLeadExp;
	sLeadExp.ProtocolType = s2c_playersyncleadexp;
	sLeadExp.m_nLeadLevel = m_nLeadLevel;
	sLeadExp.m_nLeadExp = m_nLeadExp;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLeadExp, sizeof(PLAYER_LEAD_EXP_SYNC));
#endif

}

//-------------------------------------------------------------------------
//	���ܣ������һ��������
//-------------------------------------------------------------------------
void KPlayer::LevelAddBaseLifeMax()
{
    Npc[m_nIndex].m_LifeMax += PlayerSet.m_cLevelAdd.GetLifePerLevel(Npc[m_nIndex].m_Series);
    Npc[m_nIndex].m_CurrentLifeMax = Npc[m_nIndex].m_LifeMax;
}

//-------------------------------------------------------------------------
//	���ܣ������һ��������
//-------------------------------------------------------------------------
void KPlayer::LevelAddBaseStaminaMax()
{
    Npc[m_nIndex].m_StaminaMax += PlayerSet.m_cLevelAdd.GetStaminaPerLevel(Npc[m_nIndex].m_nSex, Npc[m_nIndex].m_Series);
    Npc[m_nIndex].m_CurrentStaminaMax = Npc[m_nIndex].m_StaminaMax;
}

//-------------------------------------------------------------------------
//	���ܣ������һ��������
//-------------------------------------------------------------------------
void KPlayer::LevelAddBaseManaMax()
{
    Npc[m_nIndex].m_ManaMax += PlayerSet.m_cLevelAdd.GetManaPerLevel(Npc[m_nIndex].m_Series);
    Npc[m_nIndex].m_CurrentManaMax = Npc[m_nIndex].m_ManaMax;
}

//-------------------------------------------------------------------------
//	���ܣ��ı������Ӫ
//-------------------------------------------------------------------------
void	KPlayer::ChangePlayerCamp(int nCamp)
{
    if (nCamp < camp_begin || nCamp >= camp_num)
        return;
    Npc[m_nIndex].SetCamp((NPCCAMP)nCamp);
}

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�������������ѯĳ��npc���ڶ������Ϣ
//-------------------------------------------------------------------------
void	KPlayer::ApplyTeamInfo(DWORD dwNpcID)
{
    if (dwNpcID <= 0)
        return;
    PLAYER_APPLY_TEAM_INFO	sApplyInfo;
    sApplyInfo.ProtocolType = (BYTE)c2s_teamapplyinfo;
    sApplyInfo.m_dwTarNpcID = dwNpcID;
    if (g_pClient)
        g_pClient->SendPackToServer(&sApplyInfo, sizeof(PLAYER_APPLY_TEAM_INFO));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�������������ѯ��������Ķ������
//-------------------------------------------------------------------------
void	KPlayer::ApplySelfTeamInfo()
{
    ApplyTeamInfo(Npc[m_nIndex].m_dwID);
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��������������봴������
//-------------------------------------------------------------------------
BOOL	KPlayer::ApplyCreateTeam()//char *lpszTeamName)
{
//	g_DebugLog("ApplyCreateTeam");
    return m_cTeam.ApplyCreate();//lpszTeamName);
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ�����������뿪�š��رն����Ƿ����������Ա״̬
//-------------------------------------------------------------------------
BOOL	KPlayer::ApplyTeamOpenClose(BOOL bFlag)
{
//	g_DebugLog("ApplyTeamOpenClose");
    if ( !m_cTeam.m_nFlag )					// δ���
    {
        if (bFlag)
            return m_cTeam.ApplyCreate();
        return FALSE;
    }
    if (m_cTeam.m_nFigure != TEAM_CAPTAIN)	// ���Ƕӳ�
        return FALSE;
    if (this->CheckTrading())	// ���ڽ���״̬
        return FALSE;

    if (bFlag)
    {
        if (PlayerSet.m_cLeadExp.GetMemNumFromLevel(m_nLeadLevel) <= g_Team[0].m_nMemNum)	// ͳ˧������
            return FALSE;
    }

    PLAYER_TEAM_OPEN_CLOSE	sTeamState;
    sTeamState.ProtocolType = c2s_teamapplychangestate;
    sTeamState.dwID = Player[CLIENT_PLAYER_INDEX].GetPlayerID();
    sTeamState.dwTimePacker = GetTickCount();
    sTeamState.m_btStateClose = Team_S_OpenClose; //TamLTM auto pt to doi
    sTeamState.m_btFlag = bFlag;
    if (g_pClient)
        g_pClient->SendPackToServer(&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
    return TRUE;
}

BOOL	KPlayer::ApplyTeamPKFollow(BOOL bFlag)
{
//	g_DebugLog("ApplyTeamPKFollow");
    if ( !m_cTeam.m_nFlag )					// δ���
        return FALSE;
    if (m_cTeam.m_nFigure == TEAM_CAPTAIN)	// ���Ƕӳ�
        return FALSE;
    if (this->CheckTrading())	// ���ڽ���״̬
        return FALSE;

    PLAYER_TEAM_OPEN_CLOSE	sTeamState;
    sTeamState.ProtocolType = c2s_teamapplychangestate;
    sTeamState.m_btStateClose = Team_S_PKFollowCaptain;
    sTeamState.m_btFlag = bFlag;
    if (g_pClient)
        g_pClient->SendPackToServer(&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
    return TRUE;
}

BOOL	KPlayer::ApplyTeamModePick(int nSel)
{
//	g_DebugLog("ApplyTeamModePick");
    if ( !m_cTeam.m_nFlag )					// δ���
        return FALSE;
    if (m_cTeam.m_nFigure != TEAM_CAPTAIN)	// ���Ƕӳ�
        return FALSE;
    if (this->CheckTrading())	// ���ڽ���״̬
        return FALSE;

    PLAYER_TEAM_OPEN_CLOSE	sTeamState;
    sTeamState.ProtocolType = c2s_teamapplychangestate;
    sTeamState.m_btStateClose = Team_S_ModePick;
    sTeamState.m_btFlag = nSel;
    if (g_pClient)
        g_pClient->SendPackToServer(&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
    return TRUE;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������������������ĳ������
//	������int nNpcIndex Ŀ�����ӳ��ڿͻ���Npc�����е�λ��
// TamLTM Chap nhan vao nhom
//-------------------------------------------------------------------------
void	KPlayer::ApplyAddTeam(int nNpcIndex)
{
//	g_DebugLog("ApplyAddTeam");
    if (this->CheckTrading())
        return;
    if (m_cTeam.m_nFlag)					// �Ѿ���ӣ�������������Ķ���
        return;

    // ��ͬ��Ӫ���ڿ�����ӣ����ֲ��ܼ������˶��飬���˿��Լ������ֶ���
    if (Npc[nNpcIndex].m_Camp == camp_begin && Npc[m_nIndex].m_Camp != camp_begin)
        return;
    //	if (Npc[nNpcIndex].m_Camp != Npc[m_nIndex].m_Camp)	// ��Ӫ��ͬ
    //		return;

    // �ж�Ŀ�����ӳ��ǲ��Ǵ��ڶ��鿪��״̬
    if (Npc[nNpcIndex].GetMenuState() != PLAYER_MENU_STATE_TEAMOPEN)
        return;

    m_cTeam.m_nApplyCaptainID = Npc[nNpcIndex].m_dwID;
    m_cTeam.m_dwApplyTimer = MAX_APPLY_TEAM_TIME;
    PLAYER_APPLY_ADD_TEAM	sAddTeam;
    sAddTeam.ProtocolType = c2s_teamapplyadd;
    sAddTeam.m_dwTarNpcID = Npc[nNpcIndex].m_dwID;
    if (g_pClient)
        g_pClient->SendPackToServer(&sAddTeam, sizeof(PLAYER_APPLY_ADD_TEAM));

    KSystemMessage	sMsg;
    sprintf(sMsg.szMessage, MSG_TEAM_APPLY_ADD_SELF_MSG, Npc[nNpcIndex].Name);
    sMsg.eType = SMT_NORMAL;
    sMsg.byConfirmType = SMCT_NONE;
    sMsg.byPriority = 0;
    sMsg.byParamSize = 0;
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����֪ͨ����������ĳ��npcΪ�����Ա
//-------------------------------------------------------------------------
void	KPlayer::AcceptTeamMember(DWORD dwNpcID)
{
//	g_DebugLog("AcceptTeamMember");
    // �ж�״̬ ��ȱ�ٶ�npc���鿪��״̬�ļ�� not end��
    if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
    {
        ApplySelfTeamInfo();
        return;
    }
    if (dwNpcID == 0)
        return;

    // ���������б�
    int		i;
    for (i = 0; i < MAX_TEAM_APPLY_LIST; i++)
    {
        if (m_cTeam.m_sApplyList[i].m_dwNpcID == dwNpcID)
        {
            m_cTeam.m_sApplyList[i].m_dwNpcID = 0;
            m_cTeam.UpdateInterface();
            break;
        }
    }
    // ���û�ҵ�
//	if (i >= MAX_TEAM_APPLY_LIST)
//		return;

    // �������������
    PLAYER_ACCEPT_TEAM_MEMBER	sAcceptTeam;
    sAcceptTeam.ProtocolType = c2s_teamacceptmember;
    sAcceptTeam.m_dwNpcID = dwNpcID;
    if (g_pClient)
        g_pClient->SendPackToServer(&sAcceptTeam, sizeof(PLAYER_ACCEPT_TEAM_MEMBER));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ�ɾ��������������б��е�ĳ��npc
//-------------------------------------------------------------------------
void	KPlayer::TeamDropApplyOne(DWORD dwNpcID)
{
    if (dwNpcID == 0)
        return;
    // ���������б�
    int		i;
    for (i = 0; i < MAX_TEAM_APPLY_LIST; i++)
    {
        if (m_cTeam.m_sApplyList[i].m_dwNpcID == dwNpcID)
        {
            m_cTeam.m_sApplyList[i].m_dwNpcID = 0;
            m_cTeam.m_sApplyList[i].m_dwTimer = 0;
            m_cTeam.m_sApplyList[i].m_nLevel = 0;
            m_cTeam.m_sApplyList[i].m_szName[0] = 0;
            break;
        }
    }
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�֪ͨ������������뿪����
//-------------------------------------------------------------------------
void	KPlayer::LeaveTeam()
{
    PLAYER_APPLY_LEAVE_TEAM	sLeaveTeam;
    sLeaveTeam.ProtocolType = c2s_teamapplyleave;
    sLeaveTeam.bMySelf = TRUE;
    if (g_pClient)
        g_pClient->SendPackToServer(&sLeaveTeam, sizeof(PLAYER_APPLY_LEAVE_TEAM));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ�֪ͨ�������߳�ĳ����Ա
//-------------------------------------------------------------------------
void	KPlayer::TeamKickMember(DWORD dwNpcID)
{
    if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
        return;

    PLAYER_TEAM_KICK_MEMBER	sKickOne;
    sKickOne.ProtocolType = c2s_teamapplykickmember;
    sKickOne.m_dwNpcID = dwNpcID;
    if (g_pClient)
        g_pClient->SendPackToServer(&sKickOne, sizeof(PLAYER_TEAM_KICK_MEMBER));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ��������������Լ��Ķӳ����ݽ�����Ķ�Ա
//-------------------------------------------------------------------------
void	KPlayer::ApplyTeamChangeCaptain(DWORD dwNpcID)
{
    if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
        return;

    PLAYER_APPLY_TEAM_CHANGE_CAPTAIN	sTeamChange;
    sTeamChange.ProtocolType = c2s_teamapplychangecaptain;
    sTeamChange.m_dwNpcID = dwNpcID;
    sTeamChange.m_bMySelf = TRUE;
    if (g_pClient)
        g_pClient->SendPackToServer(&sTeamChange, sizeof(PLAYER_APPLY_TEAM_CHANGE_CAPTAIN));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ�������������ɢ����
//-------------------------------------------------------------------------
void	KPlayer::ApplyTeamDismiss()
{
    if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
        return;

    PLAYER_APPLY_TEAM_DISMISS	sTeamDismiss;
    sTeamDismiss.ProtocolType = c2s_teamapplydismiss;
    if (g_pClient)
        g_pClient->SendPackToServer(&sTeamDismiss, sizeof(PLAYER_APPLY_TEAM_DISMISS));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���������������򿪡��ر�pk����
//-------------------------------------------------------------------------
void	KPlayer::ApplySetPK(BOOL bPK) // Chap nhan pk
{
    PLAYER_SET_PK	sPK;
    sPK.ProtocolType = c2s_playerapplysetpk;
    sPK.m_btPKFlag = bPK;
    if (g_pClient)
        g_pClient->SendPackToServer(&sPK, sizeof(PLAYER_SET_PK));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ӳ��������������������������ĳһ��ĵ���(0=Strength 1=Dexterity 2=Vitality 3=Engergy)
//-------------------------------------------------------------------------
void	KPlayer::ApplyAddBaseAttribute(int nAttribute, int nNo)
{
    if (nAttribute < 0 || nAttribute > 3)
        return;
    if (nNo <= 0)
        return;
    PHONGTHAN_ATTRIBUTE_REQUEST sAdd;
    ZeroMemory(&sAdd, sizeof(sAdd));
    PhongThanInitializeWireHeader(&sAdd.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_REQUEST,
        sizeof(sAdd), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    sAdd.MapId = SubWorld[0].m_SubWorldID;
    sAdd.Attribute = PhongThanEncodeAttribute(nAttribute);
    sAdd.Points = nNo;
    if (g_pClient)
        g_pClient->SendPackToServer(&sAdd, sizeof(sAdd));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������������ĳ����������
//-------------------------------------------------------------------------
BOOL	KPlayer::ApplyAddSkillLevel(int nSkillID, int nAddPoint)
{
    if (nSkillID <= 0 || nSkillID >= MAX_SKILL || nAddPoint <= 0) return FALSE;
    if ( !Npc[m_nIndex].m_SkillList.FindSame(nSkillID) )
        return FALSE;
    if (m_nSkillPoint < nAddPoint || nAddPoint >= MAX_SKILLLEVEL - Npc[m_nIndex].m_SkillList.GetLevel(nSkillID))
        return FALSE;

    PHONGTHAN_SKILL_LEVEL_REQUEST sSkill;
    ZeroMemory(&sSkill, sizeof(sSkill));
    PhongThanInitializeWireHeader(&sSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_REQUEST,
        sizeof(sSkill), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    sSkill.MapId = SubWorld[0].m_SubWorldID;
    sSkill.SkillId = nSkillID;
    sSkill.Points = nAddPoint;

    if (g_pClient)
        g_pClient->SendPackToServer(&sSkill, sizeof(sSkill));

    return TRUE;
}
//-------------------------------------------------------------------------
//	���ܣ������������ʹ��ĳ����Ʒ������Ҽ��������Ʒ��ֻ�����ڳ�ҩ��
//-------------------------------------------------------------------------
BOOL	KPlayer::ApplyUseItem(int nItemID, ItemPos SrcPos)
{
    // nItemID is the runtime index used by the local item table.  Never
    // dereference an unchecked value received from UI code.
    if (nItemID <= 0 || nItemID >= MAX_ITEM)
        return FALSE;
    if (SrcPos.nPlace <= 0 || SrcPos.nPlace >= pos_num ||
        SrcPos.nX < 0 || SrcPos.nY < 0)
        return FALSE;
    SO_ItemActionDiagText("ApplyUseItem_BEGIN", Item[nItemID].GetScript(), nItemID, Item[nItemID].GetID());

    ItemPos DesPos;
    DesPos.nPlace = DesPos.nX = -1;
    DesPos.nY = 0;
    KSystemMessage	sMsg;

    if (this->CheckTrading())
        return FALSE;
    int nRet = this->m_ItemList.UseItem(nItemID);
    SO_ItemActionDiagText("ApplyUseItem_USE_RESULT", "UseItem", nItemID, nRet);
    if (nRet == 0)
    {
        if (!g_pClient || m_ItemList.IsLockOperation())
            return FALSE;

        nRet = m_ItemList.ChangeItemInPlayer(nItemID);//edit by phong kieu mac trang bi vao nguoi
        switch(nRet)
        {
            case equip_horse:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 10;
                strcpy(sMsg.szMessage, "Mang ng�a ...");
                break;
            case equip_meleeweapon:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 3;
                strcpy(sMsg.szMessage, "Mang v� kh� c�n chi�n ...");
                break;
            case equip_rangeweapon:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 3;
                strcpy(sMsg.szMessage, "Mang v� kh� t�m xa ...");
                break;
            case equip_armor:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 1;
                strcpy(sMsg.szMessage, "Mang y ph�c ...");
                break;
            case equip_ring:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 7;
                strcpy(sMsg.szMessage, "Mang nh�n ...");
                break;
            case equip_amulet:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 6;
                strcpy(sMsg.szMessage, "Mang d�y chuy�n ...");
                break;
            case equip_boots:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 4;
                strcpy(sMsg.szMessage, "Mang gi�y ...");
                break;
            case equip_belt:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 2;
                strcpy(sMsg.szMessage, "Mang �ai l�ng ...");
                break;
            case equip_helm:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 0;
                strcpy(sMsg.szMessage, "Mang m� ...");
                break;
            case equip_cuff:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 5;
                strcpy(sMsg.szMessage, "Mang bao tay ...");
                break;
            case equip_pendant:
                DesPos.nPlace = pos_equip;
                DesPos.nX = 9;
                strcpy(sMsg.szMessage, "Mang ng�c b�i ...");
                break;
        }
        if(DesPos.nPlace<0)
        {
            return FALSE;
        }

        SendClientCmdMoveItem(&SrcPos, &DesPos);

        sMsg.byConfirmType = SMCT_NONE;
        sMsg.eType = SMT_NORMAL;
        sMsg.byParamSize = 0;
        sMsg.byPriority = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

        return TRUE;
    }


    if (m_dwRightMouse && m_dwRightMouse > g_SubWorldSet.GetGameTime())
        return FALSE;

    m_dwRightMouse = g_SubWorldSet.GetGameTime() + GAME_FPS / 3;
    m_nLastNpcIndex = 0;

    if (Item[nItemID].GetID() == 0)
        return FALSE;

    PHONGTHAN_ITEM_USE_REQUEST Request;
    ZeroMemory(&Request, sizeof(Request));
    PhongThanInitializeWireHeader(&Request.Header,
        PHONGTHAN_MSG_INVENTORY_USE_REQUEST, sizeof(Request),
        PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    Request.ItemId = Item[nItemID].GetID();
    Request.Container = (PHONGTHAN_U8)SrcPos.nPlace;
    Request.SlotX = (PHONGTHAN_U8)SrcPos.nX;
    Request.SlotY = (PHONGTHAN_U8)SrcPos.nY;
    if (g_pClient)
        g_pClient->SendPackToServer(&Request, sizeof(Request));
    SO_ItemActionDiag("ApplyUseItem_REQUEST_SENT", Item[nItemID].GetGenre(), nItemID, SrcPos.nX, SrcPos.nY, 0, 0, SrcPos.nPlace, Request.ItemId);

    if (nRet != REQUEST_EAT_MEDICINE && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_sit)
        Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_stand);

    return TRUE;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ͻ��������obj����ĳ����Ʒ�������������Ϣ
//-------------------------------------------------------------------------
void	KPlayer::PickUpObj(int nObjIndex)
{
    if (this->CheckTrading())
        return;

    if (nObjIndex <= 0)
        return;


    if (Object[nObjIndex].m_nKind != Obj_Kind_Item && Object[nObjIndex].m_nKind != Obj_Kind_Money)
        return;

    PHONGTHAN_ITEM_PICKUP_REQUEST Request;
    ZeroMemory(&Request, sizeof(Request));
    PhongThanInitializeWireHeader(&Request.Header,
        PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST, sizeof(Request),
        PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    Request.WorldObjectId = Object[nObjIndex].m_nID;
    if (Object[nObjIndex].m_nKind == Obj_Kind_Money)
    {
        Request.DestinationContainer = 0;
        Request.DestinationX = 0;
        Request.DestinationY = 0;
    }
    else
    {
        ItemPos	sItemPos;
        if (FALSE == m_ItemList.SearchPosition(Object[nObjIndex].m_nItemWidth, Object[nObjIndex].m_nItemHeight, &sItemPos))
        {
            KSystemMessage	sMsg;

            sMsg.byConfirmType = SMCT_NONE;
            sMsg.eType = SMT_NORMAL;
            sMsg.byParamSize = 0;
            sMsg.byPriority = 0;
            strcpy(sMsg.szMessage, MSG_SHOP_NO_ROOM);
            CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
            return;
        }
        Request.DestinationContainer = (PHONGTHAN_U8)sItemPos.nPlace;
        Request.DestinationX = (PHONGTHAN_U8)sItemPos.nX;
        Request.DestinationY = (PHONGTHAN_U8)sItemPos.nY;
    }

    if (g_pClient)
        g_pClient->SendPackToServer(&Request, sizeof(Request));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ͻ��������obj�������������Ϣ
//-------------------------------------------------------------------------
void	KPlayer::ObjMouseClick(int nObjIndex)
{
    if (this->CheckTrading())
        return;
    if (nObjIndex <= 0)
        return;
    if (Object[nObjIndex].m_nKind != Obj_Kind_Box && Object[nObjIndex].m_nKind != Obj_Kind_Prop)
        return;
    SendObjMouseClick(Object[nObjIndex].m_nID, SubWorld[0].m_Region[Object[nObjIndex].m_nRegionIdx].m_RegionID);
}
#endif

#ifndef _SERVER
// DownPos ������ϵ���Ʒ�ĵ�ǰ���꣬UpPos ������������Ʒ�ŵ�����ϵ�����
void	KPlayer::MoveItem(ItemPos DownPos, ItemPos UpPos)
{
    if (this->CheckTrading() && DownPos.nPlace == pos_traderoom)
    {
        if (this->m_cTrade.m_nTradeLock)
            return;
    }

    SendClientCmdMoveItem(&DownPos, &UpPos);
}
#endif

#ifndef _SERVER
int	KPlayer::ThrowAwayItem()
{
    int	nHandIdx = m_ItemList.Hand();
    if (nHandIdx)
    {
        if (this->CheckTrading())
            return 0;
        if ( !m_ItemList.Hand() )
            return 0;
        //	if ( m_cAI.m_bIsActive &&
        //	(m_cAI.m_bFilterEquipment || m_cAI.m_bSortEquipment) )
        //	return 0;

        SendClientCmdDropItem(Item[nHandIdx].GetID());
        return 1;
    }
    return 0;
}
#endif

#ifndef _SERVER
void	KPlayer::TradeApplyOpen(char *lpszSentence, int nLength)
{
    if (this->CheckTrading())
        return;
    if (!lpszSentence)
        nLength = 0;
    TRADE_APPLY_OPEN_COMMAND	sOpen;
    sOpen.ProtocolType = c2s_tradeapplystateopen;
    if (nLength >= MAX_SENTENCE_LENGTH)
        nLength = MAX_SENTENCE_LENGTH - 1;
    sOpen.m_wLength = sizeof(TRADE_APPLY_OPEN_COMMAND) - 1 - sizeof(sOpen.m_szSentence) + nLength;
    memset(m_cMenuState.m_szSentence, 0, sizeof(m_cMenuState.m_szSentence));
    if (lpszSentence)
        memcpy(m_cMenuState.m_szSentence, lpszSentence, nLength);
    memset(sOpen.m_szSentence, 0, sizeof(sOpen.m_szSentence));
    memcpy(sOpen.m_szSentence, m_cMenuState.m_szSentence, nLength);
    if (g_pClient)
        g_pClient->SendPackToServer(&sOpen, sOpen.m_wLength + 1);
}
#endif

#ifndef _SERVER
void	KPlayer::TradeApplyClose()
{
    TRADE_APPLY_CLOSE_COMMAND	sApply;
    sApply.ProtocolType = c2s_tradeapplystateclose;
    if (g_pClient)
        g_pClient->SendPackToServer(&sApply, sizeof(TRADE_APPLY_CLOSE_COMMAND));
}
#endif

#ifndef _SERVER
void	KPlayer::TradeApplyStart(int nNpcIdx, bool bFolkGame)
{
    if (nNpcIdx < 0 || nNpcIdx >= MAX_NPC)
        return;
    TRADE_APPLY_START_COMMAND	sStart;
    sStart.ProtocolType = c2s_tradeapplystart;
    sStart.m_dwID = Npc[nNpcIdx].m_dwID;
    sStart.m_bFolkGame = (BOOL)bFolkGame;
    if (g_pClient)
        g_pClient->SendPackToServer(&sStart, sizeof(TRADE_APPLY_START_COMMAND));

    KSystemMessage	sMsg;
    if (bFolkGame)
        sprintf(sMsg.szMessage, MSG_TRADE_FOLKGAME_SEND_APPLY, Npc[nNpcIdx].Name);
    else
        sprintf(sMsg.szMessage, MSG_TRADE_SEND_APPLY, Npc[nNpcIdx].Name);
    sMsg.eType = SMT_NORMAL;
    sMsg.byConfirmType = SMCT_NONE;
    sMsg.byPriority = 0;
    sMsg.byParamSize = 0;
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
}
#endif

#ifndef _SERVER
BOOL	KPlayer::TradeMoveMoney(int nMoney)
{
    if (!CheckTrading())
        return FALSE;
    if (this->m_cTrade.m_nTradeLock)
        return FALSE;
    // Ǯ��������
    if (nMoney < 0 || nMoney > (m_ItemList.GetEquipmentMoney() + m_ItemList.GetTradeMoney()))
        return FALSE;
    TRADE_MOVE_MONEY_COMMAND	sMoney;

    sMoney.ProtocolType = c2s_trademovemoney;
    sMoney.m_nMoney = nMoney;
    if (g_pClient)
        g_pClient->SendPackToServer(&sMoney, sizeof(TRADE_MOVE_MONEY_COMMAND));

    return TRUE;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�����ȷ����ȡ��
//	if nDecision == 0 �Ƴ�����  if nDecision == 1 ȷ������  if nDecision == 2 ȡ������ȷ��
//-------------------------------------------------------------------------
void	KPlayer::TradeDecision(int nDecision, int nId)
{
    if ( !CheckTrading() )
        return;

    TRADE_DECISION_COMMAND	sDecision;
    sDecision.ProtocolType = c2s_tradedecision;
    if (nDecision == 0)
    {
        sDecision.m_btDecision = 0;
    }
    else if (nDecision == 1)
    {
        sDecision.m_btDecision = 1;
    }
    else if(nDecision == 2)
    {
        sDecision.m_btDecision = 3;
    }
    sDecision.m_btFolkGame = nId;
    if (g_pClient)
        g_pClient->SendPackToServer(&sDecision, sizeof(TRADE_DECISION_COMMAND));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�����������ȡ������
//-------------------------------------------------------------------------
void	KPlayer::TradeApplyLock()
{
    if ( !CheckTrading() )
        return;
    TRADE_DECISION_COMMAND	sDecision;
    sDecision.ProtocolType = c2s_tradedecision;
    sDecision.m_btDecision = 2;
    sDecision.m_btFolkGame = 0;
    if (g_pClient)
        g_pClient->SendPackToServer(&sDecision, sizeof(TRADE_DECISION_COMMAND));
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ��������������
//-------------------------------------------------------------------------
void	KPlayer::s2cApplyAddTeam(BYTE* pProtocol)
{
    // ״̬��� (����Ҫ��� npc �Ķ��鿪��״̬ not end)
    if ( !m_cTeam.m_nFlag || m_cTeam.m_nFigure != TEAM_CAPTAIN)
    {
        ApplySelfTeamInfo();
        return;
    }

    // Ѱ�� npc
    PLAYER_APPLY_ADD_TEAM	*pAddTeam = (PLAYER_APPLY_ADD_TEAM*)pProtocol;
    int nNpcNo = NpcSet.SearchID(pAddTeam->m_dwTarNpcID);
    if (nNpcNo == 0)
        return;

    int i, nFreeListNo;
    // ����Ѿ����ڣ�����
    for (i = 0; i < MAX_TEAM_APPLY_LIST; i++)
    {
        if (m_cTeam.m_sApplyList[i].m_dwNpcID == pAddTeam->m_dwTarNpcID)
        {
            m_cTeam.m_sApplyList[i].m_nLevel = Npc[nNpcNo].m_Level;
            m_cTeam.m_sApplyList[i].m_dwTimer = MAX_APPLY_TEAM_TIME;
            strcpy(m_cTeam.m_sApplyList[i].m_szName, Npc[nNpcNo].Name);
            m_cTeam.UpdateInterface();
            return;
        }
    }
    // Ѱ��������list��λ
    for (i = 0; i < MAX_TEAM_APPLY_LIST; i++)
    {
        if (m_cTeam.m_sApplyList[i].m_dwNpcID == 0)
        {
            nFreeListNo = i;
            break;
        }
    }
    if (i >= MAX_TEAM_APPLY_LIST)	// û�ҵ������˿�λ
        return;

    m_cTeam.m_sApplyList[nFreeListNo].m_dwNpcID = pAddTeam->m_dwTarNpcID;
    m_cTeam.m_sApplyList[nFreeListNo].m_nLevel = Npc[nNpcNo].m_Level;
    m_cTeam.m_sApplyList[nFreeListNo].m_dwTimer = MAX_APPLY_TEAM_TIME;
    strcpy(m_cTeam.m_sApplyList[nFreeListNo].m_szName, Npc[nNpcNo].Name);

    m_cTeam.UpdateInterface();

    KSystemMessage	sMsg;
    sprintf(sMsg.szMessage, MSG_TEAM_APPLY_ADD, Npc[nNpcNo].Name);
    sMsg.eType = SMT_TEAM;
    sMsg.byConfirmType = SMCT_UI_TEAM_APPLY;
    sMsg.byPriority = 3;
    sMsg.byParamSize = sizeof(KUiPlayerItem);

    KUiPlayerItem	player;
    strcpy(player.Name, Npc[nNpcNo].Name);
    player.nIndex = 0;
    player.uId = pAddTeam->m_dwTarNpcID;
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, (int)&player);

    return;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���������
//-------------------------------------------------------------------------
BOOL	KPlayer::SetProfession(char *pszProfession)
{
	return SetProfession(g_Profession.GetID(pszProfession));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ���������
//-------------------------------------------------------------------------
BOOL	KPlayer::SetProfession(int nProfession)
{
	if (!m_cProfession.SetProfession(nProfession))
		return FALSE;
	Npc[m_nIndex].m_Series = nProfession;
	Npc[m_nIndex].SetCamp(m_cProfession.GetCamp());
	SendProfessionData();
	return TRUE;
}
#endif

#ifndef _SERVER
void	KPlayer::SetDefaultImmedSkill()
{
    //��ȡ������Ҽ�����ΪĬ����������
    int nDetailType = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetWeaponType();
    int nParticularType = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetWeaponParticular();

    //��������
    if (nDetailType == 0)
    {
        Player[CLIENT_PLAYER_INDEX].SetLeftSkill(g_nMeleeWeaponSkill[nParticularType]);
        Player[CLIENT_PLAYER_INDEX].SetRightSkill(g_nMeleeWeaponSkill[nParticularType]);
    }//Զ������
    else if (nDetailType == 1)
    {
        Player[CLIENT_PLAYER_INDEX].SetLeftSkill(g_nRangeWeaponSkill[nParticularType]);
        Player[CLIENT_PLAYER_INDEX].SetRightSkill(g_nRangeWeaponSkill[nParticularType]);
    }//����
    else if (nDetailType == -1)
    {
        Player[CLIENT_PLAYER_INDEX].SetLeftSkill(g_nHandSkill);
        Player[CLIENT_PLAYER_INDEX].SetRightSkill(g_nHandSkill);
    }
}

void	KPlayer::SetLeftSkill(int nSkillID)
{
    if (nSkillID < 0) return;
    if (nSkillID > 0 &&
        Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetLevel(nSkillID) <= 0) return;
    m_nLeftSkillID = nSkillID;

    KUiGameObject Info;
    Info.uGenre = CGOG_SKILL_SHORTCUT;
    Info.uId = m_nLeftSkillID;
    CoreDataChanged(GDCNI_PLAYER_IMMED_ITEMSKILL, (unsigned int)&Info, -1);
}

void	KPlayer::SetRightSkill(int nSkillID)
{
    if (nSkillID < 0) return;
    if (nSkillID > 0 &&
        Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetLevel(nSkillID) <= 0) return;
    m_nRightSkillID = nSkillID;
	if (nSkillID == 0)
	{
		Npc[m_nIndex].SetAuraSkill(0);
		KUiGameObject EmptyInfo;
		EmptyInfo.uGenre = CGOG_SKILL_SHORTCUT;
		EmptyInfo.uId = 0;
		CoreDataChanged(GDCNI_PLAYER_IMMED_ITEMSKILL, (unsigned int)&EmptyInfo, -2);
		return;
	}
    // ����Ƿ��ǹ⻷����
    ISkill * pOrdinSkill = g_SkillManager.GetSkill(nSkillID, 1);
    if (!pOrdinSkill)
        return;

    if (pOrdinSkill->IsAura())
    {
        Npc[m_nIndex].SetAuraSkill(nSkillID);
    }
    else
    {
        Npc[m_nIndex].SetAuraSkill(0);
    }

    KUiGameObject Info;
    Info.uGenre = CGOG_SKILL_SHORTCUT;
    Info.uId = m_nRightSkillID;
    CoreDataChanged(GDCNI_PLAYER_IMMED_ITEMSKILL, (unsigned int)&Info, -2);
}

void KPlayer::UpdateWeaponSkill()
{
    if (m_nLeftSkillID > 0)
    {
        ISkill * pISkill = g_SkillManager.GetSkill(m_nLeftSkillID, 1);
        if (!pISkill)
            return;

        if (pISkill->IsPhysical())
        {
            SetLeftSkill(Npc[m_nIndex].GetCurActiveWeaponSkill());
        }
    }
    if (m_nRightSkillID > 0)
    {
        ISkill * pISkill = (KSkill *) g_SkillManager.GetSkill(m_nRightSkillID, 1);
        if (!pISkill)
            return;

        if (pISkill->IsPhysical())
        {
            SetRightSkill(Npc[m_nIndex].GetCurActiveWeaponSkill());
        }
    }
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�����������
//-------------------------------------------------------------------------
void	KPlayer::TeamInviteAdd(DWORD dwNpcID)
{
    m_cTeam.InviteAdd(dwNpcID);
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ���Ҫ�����ӻ������Ե�(0=Strength 1=Dexterity 2=Vitality 3=Engergy)
//-------------------------------------------------------------------------
void	KPlayer::AddBaseAttribute(BYTE* pProtocol)
{
	const PHONGTHAN_ATTRIBUTE_REQUEST* pAdd = (const PHONGTHAN_ATTRIBUTE_REQUEST*)pProtocol;
	if(pAdd->Points <= 0 || pAdd->Points > m_nAttributePoint)
		return;

	switch (PhongThanDecodeAttribute(pAdd->Attribute))
	{
	case ATTRIBUTE_STRENGTH:
		AddBaseStrength(pAdd->Points);
		break;
	case ATTRIBUTE_DEXTERITY:
		AddBaseDexterity(pAdd->Points);
		break;
	case ATTRIBUTE_VITALITY:
		AddBaseVitality(pAdd->Points);
		break;
	case ATTRIBUTE_ENGERGY:
		AddBaseEngergy(pAdd->Points);
		break;
	}
}

int		KPlayer::ResetProp()
{
		char cBaseFile[80];
		sprintf(cBaseFile, NEW_PLAYER_INI_FILE_NAME, Npc[m_nIndex].m_Series * 2 + Npc[m_nIndex].m_nSex);

		KIniFile BaseAttrib;
		if(!BaseAttrib.Load(cBaseFile)) return 0;

		int nBaseStr, nBaseDex, nBaseVit, nBaseEn;
		BaseAttrib.GetInteger("ROLE", "ipower", 0, &nBaseStr);
		BaseAttrib.GetInteger("ROLE", "iagility", 0, &nBaseDex);
		BaseAttrib.GetInteger("ROLE", "iouter", 0, &nBaseVit);
		BaseAttrib.GetInteger("ROLE", "iinside", 0, &nBaseEn);

		int nStr = m_nStrength - nBaseStr;
		int nDex = m_nDexterity - nBaseDex;
		int nVit = m_nVitality - nBaseVit;
		int nEn = m_nEngergy - nBaseEn;

		m_nStrength = nBaseStr;
		m_nDexterity = nBaseDex;
		m_nVitality = nBaseVit;
		m_nEngergy = nBaseEn;
		m_nCurStrength = m_nStrength;
		m_nCurDexterity = m_nDexterity;
		m_nCurVitality = m_nVitality;
		m_nCurEngergy = m_nEngergy;

		SetNpcAttackRating();
		SetNpcDefence();
		Npc[m_nIndex].AddBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * (-nVit));
		Npc[m_nIndex].AddBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * (-nVit));
		Npc[m_nIndex].AddBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * (-nEn));
		UpdataCurData();
		SetNpcPhysicsDamage();

		PHONGTHAN_ATTRIBUTE_UPDATE	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSync.EntityId = Npc[m_nIndex].m_dwID;
		sSync.Attribute = PhongThanEncodeAttribute(ATTRIBUTE_RESET_ALL);
		sSync.Base = 0;
		sSync.Current = 0;
		sSync.RemainingPoints = m_nAttributePoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));

		return nStr + nDex + nVit + nEn;
}

#ifdef _SERVER
void	KPlayer::SetLevel(int nLevel)
{
	if (nLevel <= 0 || nLevel > MAX_LEVEL)
		return;

	m_nExp = 0;

	char cBaseFile[80];
	sprintf(cBaseFile, NEW_PLAYER_INI_FILE_NAME, Npc[m_nIndex].m_Series * 2 + Npc[m_nIndex].m_nSex);

	KIniFile BaseAttrib;
	if(!BaseAttrib.Load(cBaseFile)) return;

	int nBaseStr, nBaseDex, nBaseVit, nBaseEn;
	BaseAttrib.GetInteger("ROLE", "ipower", 0, &nBaseStr);
	BaseAttrib.GetInteger("ROLE", "iagility", 0, &nBaseDex);
	BaseAttrib.GetInteger("ROLE", "iouter", 0, &nBaseVit);
	BaseAttrib.GetInteger("ROLE", "iinside", 0, &nBaseEn);

	int nStr = m_nStrength - nBaseStr;
	int nDex = m_nDexterity - nBaseDex;
	int nVit = m_nVitality - nBaseVit;
	int nEn = m_nEngergy - nBaseEn;

	m_nStrength = nBaseStr;
	m_nDexterity = nBaseDex;
	m_nVitality = nBaseVit;
	m_nEngergy = nBaseEn;

	m_nCurStrength = m_nStrength;
	m_nCurDexterity = m_nDexterity;
	m_nCurVitality = m_nVitality;
	m_nCurEngergy = m_nEngergy;

	m_nNextLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(nLevel, Npc[m_nIndex].m_byTranslife);

	int nBaseLife, nBaseMana, nBaseStamina;
	BaseAttrib.GetInteger("ROLE", "imaxlife", 0, &nBaseLife);
	BaseAttrib.GetInteger("ROLE", "imaxinner", 0, &nBaseMana);
	BaseAttrib.GetInteger("ROLE", "imaxstamina", 0, &nBaseStamina);

	Npc[m_nIndex].m_LifeMax = nBaseLife + (nLevel - PLAYER_PREFIX_LEVEL) * PlayerSet.m_cLevelAdd.GetLifePerLevel(Npc[m_nIndex].m_Series);
	Npc[m_nIndex].m_ManaMax = nBaseMana + (nLevel - PLAYER_PREFIX_LEVEL) * PlayerSet.m_cLevelAdd.GetManaPerLevel(Npc[m_nIndex].m_Series);
	Npc[m_nIndex].m_StaminaMax = nBaseStamina + (nLevel - PLAYER_PREFIX_LEVEL) * PlayerSet.m_cLevelAdd.GetStaminaPerLevel(Npc[m_nIndex].m_nSex, Npc[m_nIndex].m_Series);

	Npc[m_nIndex].m_CurrentLifeMax = Npc[m_nIndex].m_LifeMax;
	Npc[m_nIndex].m_CurrentManaMax = Npc[m_nIndex].m_ManaMax;
	Npc[m_nIndex].m_CurrentStaminaMax = Npc[m_nIndex].m_StaminaMax;

	m_nAttributePoint += nStr + nDex + nVit + nEn - (Npc[m_nIndex].m_Level - nLevel) * PLAYER_LEVEL_ADD_ATTRIBUTE;
	m_nSkillPoint += Npc[m_nIndex].m_SkillList.RollBackSkills(false) - (Npc[m_nIndex].m_Level - nLevel) * PLAYER_LEVEL_ADD_SKILL;
	SendSyncData_Skill();

	Npc[m_nIndex].m_FireResist				= PlayerSet.m_cLevelAdd.GetFireResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentFireResist		= Npc[m_nIndex].m_FireResist;
	Npc[m_nIndex].m_ColdResist				= PlayerSet.m_cLevelAdd.GetColdResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentColdResist		= Npc[m_nIndex].m_ColdResist;
	Npc[m_nIndex].m_PoisonResist			= PlayerSet.m_cLevelAdd.GetPoisonResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentPoisonResist		= Npc[m_nIndex].m_PoisonResist;
	Npc[m_nIndex].m_LightResist				= PlayerSet.m_cLevelAdd.GetLightResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentLightResist		= Npc[m_nIndex].m_LightResist;
	Npc[m_nIndex].m_EarthResist				= PlayerSet.m_cLevelAdd.GetEarthResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentEarthResist		= Npc[m_nIndex].m_EarthResist;
	Npc[m_nIndex].m_PhysicsResist			= PlayerSet.m_cLevelAdd.GetPhysicsResist(Npc[m_nIndex].m_Series, nLevel);
	Npc[m_nIndex].m_CurrentPhysicsResist	= Npc[m_nIndex].m_PhysicsResist;
	Npc[m_nIndex].m_FireResistMax			= BASE_FIRE_RESIST_MAX;
	Npc[m_nIndex].m_ColdResistMax			= BASE_COLD_RESIST_MAX;
	Npc[m_nIndex].m_PoisonResistMax			= BASE_POISON_RESIST_MAX;
	Npc[m_nIndex].m_LightResistMax			= BASE_LIGHT_RESIST_MAX;
	Npc[m_nIndex].m_EarthResistMax			= BASE_EARTH_RESIST_MAX;
	Npc[m_nIndex].m_PhysicsResistMax		= BASE_PHYSICS_RESIST_MAX;
	Npc[m_nIndex].m_CurrentFireResistMax	= Npc[m_nIndex].m_FireResistMax;
	Npc[m_nIndex].m_CurrentColdResistMax	= Npc[m_nIndex].m_ColdResistMax;
	Npc[m_nIndex].m_CurrentPoisonResistMax	= Npc[m_nIndex].m_PoisonResistMax;
	Npc[m_nIndex].m_CurrentLightResistMax	= Npc[m_nIndex].m_LightResistMax;
	Npc[m_nIndex].m_CurrentEarthResistMax	= Npc[m_nIndex].m_EarthResistMax;
	Npc[m_nIndex].m_CurrentPhysicsResistMax	= Npc[m_nIndex].m_PhysicsResistMax;

	int nOldCurCamp = Npc[m_nIndex].m_CurrentCamp;
	this->UpdataCurData();
	SetNpcPhysicsDamage();
	Npc[m_nIndex].SetCurrentCamp(nOldCurCamp);

	Npc[m_nIndex].m_CurrentLife = Npc[m_nIndex].m_CurrentLifeMax;
	Npc[m_nIndex].m_CurrentStamina = Npc[m_nIndex].m_CurrentStaminaMax;
	Npc[m_nIndex].m_CurrentMana = Npc[m_nIndex].m_CurrentManaMax;

	PHONGTHAN_LEVEL_EVENT	sLevelUp;
	ZeroMemory(&sLevelUp, sizeof(sLevelUp));
	PhongThanInitializeWireHeader(&sLevelUp.Header, PHONGTHAN_MSG_GAMEPLAY_LEVEL, sizeof(sLevelUp), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sLevelUp.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sLevelUp.EntityId = Npc[m_nIndex].m_dwID;
	sLevelUp.ResetAttributes		= TRUE;
	sLevelUp.Level			= (DWORD)nLevel;
	sLevelUp.Experience				= m_nExp;
	sLevelUp.AttributePoints	= m_nAttributePoint;
	sLevelUp.SkillPoints		= m_nSkillPoint;
	sLevelUp.BaseMaxLife		= Npc[m_nIndex].m_LifeMax;
	sLevelUp.BaseMaxStamina	= Npc[m_nIndex].m_StaminaMax;
	sLevelUp.BaseMaxMana		= Npc[m_nIndex].m_ManaMax;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sLevelUp, sizeof(PHONGTHAN_LEVEL_EVENT));

	Npc[m_nIndex].m_Level = nLevel;
	this->ExecuteScript(LEVELUP_SCRIPT, NORMAL_FUNCTION_NAME, 0);
}
#endif

void	KPlayer::ResetBaseAttribute(int attribute, int value)
{
	switch (attribute)
	{
	case ATTRIBUTE_STRENGTH:
		ResetBaseStrength(value);
		break;
	case ATTRIBUTE_DEXTERITY:
		ResetBaseDexterity(value);
		break;
	case ATTRIBUTE_VITALITY:
		ResetBaseVitality(value);
		break;
	case ATTRIBUTE_ENGERGY:
		ResetBaseEngergy(value);
		break;
	}
}

#endif

#define MAX_ORDINSKILL_LEVEL_ALWAYS  20//��������������Լ��ܵȼ��ı䶯֮��ģ�һ������ܵȼ�
#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ���Ҫ������ĳ�����ܵĵ���
//-------------------------------------------------------------------------
#include "KPhongThanProfessionSkills.h"
void	KPlayer::AddSkillPoint(BYTE* pProtocol)
{
	const PHONGTHAN_SKILL_LEVEL_REQUEST* pAdd = (const PHONGTHAN_SKILL_LEVEL_REQUEST*)pProtocol;
	if (!pAdd || pAdd->Points <= 0 || pAdd->SkillId <= 0 || pAdd->SkillId > MAX_SKILL)
		return;
	if (PhongThanIsProfessionSkill(pAdd->SkillId) &&
		!PhongThanProfessionOwnsSkill(m_cProfession.GetProfession(), pAdd->SkillId))
		return;

	int		nSkillIndex, nSkillLevel;

	nSkillIndex = Npc[m_nIndex].m_SkillList.FindSame(pAdd->SkillId);
	if (nSkillIndex == 0)
		return;
	nSkillLevel = Npc[m_nIndex].m_SkillList.GetLevel(pAdd->SkillId);
	if (m_nSkillPoint >= pAdd->Points && nSkillIndex )//&& nSkillLevel + pAdd->Points <= MAX_SKILLLEVEL
	{
		ISkill * pSkill = NULL;

		if (nSkillLevel == 0)
		{
			pSkill =  g_SkillManager.GetSkill(pAdd->SkillId, 1);
		}
		else
		{
			pSkill =  g_SkillManager.GetSkill(pAdd->SkillId, nSkillLevel);
		}

		if (pSkill)
		{
			//�ж�Ӧ�ļ��������ű�,����ִ�нű�
			if (pSkill->IsExp())
			{
				char szMsg[128];
				sprintf(szMsg, "K� n�ng %s c�a b�n ch� c� th� th�ng c�p khi t�ch l�y �� kinh nghi�m", pSkill->GetSkillName());
				KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_SKILL, (char *) szMsg, strlen(szMsg) );
				return;
			}
			if (pSkill->GetSkillLevelUpScriptId())
			{
				ExecuteScript(pSkill->GetSkillLevelUpScriptId(), NORMAL_FUNCTION_NAME, pAdd->Points);
				nSkillLevel = Npc[m_nIndex].m_SkillList.GetSkillIdxLevel(nSkillIndex);
			}
			else
			{
			/*
			���������ĳ���
			1�������ܹ��ӵ�ļ��ܣ����ֻ�ܼӵ�20����
			2������һ����ҵĵȼ���x,һ�����ܵĻ���ѧϰ�ȼ���y����ô���ܹ�ѧϰ������ܵ���ߵȼ���x-y��
			3��ʹ�ü�����Ҫ����һЩ������жϣ���һ���Ƿ�������״̬���ڶ�����װ������������ϸ����Ƿ�Ϊָ����ֵ��-1��ʾû������
				*/
				switch(pSkill->GetSkillStyle())
				{
				case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
				case SKILL_SS_Melee:
				case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
				case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
				case SKILL_SS_PhongThanAttack:
				case SKILL_SS_PhongThanProduce:
				case SKILL_SS_PhongThanAwaken:
					{
						int nWantToBeLevel = nSkillLevel + pAdd->Points;
						//Limit2
						if (nWantToBeLevel <= g_SkillManager.GetSkillMaxLevel(pAdd->SkillId) && nWantToBeLevel <= Npc[m_nIndex].m_Level - ((KSkill*)pSkill)->GetSkillReqLevel() + 1)
						{
							if ( !Npc[m_nIndex].m_SkillList.IncreaseLevel(nSkillIndex, pAdd->Points))
								return;
							m_nSkillPoint -= pAdd->Points;
							nSkillLevel += pAdd->Points;
						}
						else
						{
							if (nWantToBeLevel >=  g_SkillManager.GetSkillMaxLevel(pAdd->SkillId))
							{
								char szMsg[128];
								if (pSkill->IsExp())
									sprintf(szMsg, "Kh�ng th� s� d�ng �i�m k� n�ng �� th�ng c�p k� n�ng %s c�a b�n", pSkill->GetSkillName());
								else
									sprintf(szMsg, "K� n�ng %s c�a B�n �� ��t c�p t�i �a, kh�ng c�n th�ng c�p th�m n�a.", pSkill->GetSkillName());
								KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_SKILL, (char *) szMsg, strlen(szMsg) );
							}
							else
							{
								char szMsg[128];
								sprintf(szMsg, "K� n�ng %s c�a B�n ph�i ��t ��n c�p %d m�i c� th� th�ng c�p.", ((KSkill*)pSkill)->GetSkillName(), ((KSkill *)pSkill)->GetSkillReqLevel() -1 +  pAdd->Points + nSkillLevel);
								KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_SKILL, (char *) szMsg, strlen(szMsg) );
							}

						}
					}
					break;
				case SKILL_SS_Thief:
					{
						return;
					}break;

				}

			}
			UpdataCurData();
			// �ѵ�ǰ�˼��ܵĵ�����ʣ�༼�ܵ㷢���ͻ���
			PHONGTHAN_SKILL_LEVEL_UPDATE	sSkill;
			ZeroMemory(&sSkill, sizeof(sSkill));
	PhongThanInitializeWireHeader(&sSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(sSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSkill.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSkill.EntityId = Npc[m_nIndex].m_dwID;
			sSkill.SkillId = pAdd->SkillId;
			sSkill.Level = Npc[m_nIndex].m_SkillList.GetLevel(pAdd->SkillId);
			sSkill.BonusLevel = Npc[m_nIndex].m_SkillList.GetAddLevel(pAdd->SkillId);
			sSkill.Experience = Npc[m_nIndex].m_SkillList.GetExp(pAdd->SkillId);
			sSkill.Temporary = (Npc[m_nIndex].m_SkillList.IsTempSkill(pAdd->SkillId)) ? 1 : 0;
			sSkill.RemainingPoints = m_nSkillPoint;
			g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSkill, sizeof(sSkill));
		}
	}


}

void	KPlayer::IncSkillLevel(int nSkillId, int nAddLevel)
{
	int		nSkillIndex, nSkillLevel;

	nSkillIndex = Npc[m_nIndex].m_SkillList.FindSame(nSkillId);
	if (nSkillIndex <= 0)
		return;

	nSkillLevel = Npc[m_nIndex].m_SkillList.GetLevel(nSkillId);
	if (nSkillLevel >= MAX_SKILLLEVEL)
		return;

	if (m_nSkillPoint >= nAddLevel && nSkillIndex )//&& nSkillLevel + nAddLevel <= MAX_SKILLLEVEL
	{
		ISkill * pSkill = NULL;
		if (nSkillLevel <= 0)
		{
			pSkill =  g_SkillManager.GetSkill(nSkillId, 1);
		}
		else
		{
			pSkill =  g_SkillManager.GetSkill(nSkillId, nSkillLevel);
		}

		if (pSkill)
		{
			//�ж�Ӧ�ļ��������ű�,����ִ�нű�
			/*
			���������ĳ���
			1�������ܹ��ӵ�ļ��ܣ����ֻ�ܼӵ�20����
			2������һ����ҵĵȼ���x,һ�����ܵĻ���ѧϰ�ȼ���y����ô���ܹ�ѧϰ������ܵ���ߵȼ���x-y��
			3��ʹ�ü�����Ҫ����һЩ������жϣ���һ���Ƿ�������״̬���ڶ�����װ������������ϸ����Ƿ�Ϊָ����ֵ��-1��ʾû������
				*/
				switch(pSkill->GetSkillStyle())
				{
				case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
				case SKILL_SS_Melee:
				case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
				case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
				case SKILL_SS_PhongThanAttack:
				case SKILL_SS_PhongThanProduce:
				case SKILL_SS_PhongThanAwaken:
					{
						int nWantToBeLevel = nSkillLevel + nAddLevel;
						//Limit2
						if (nWantToBeLevel <= g_SkillManager.GetSkillMaxLevel(nSkillId) && nWantToBeLevel <= Npc[m_nIndex].m_Level - ((KSkill*)pSkill)->GetSkillReqLevel() + 1)
						{
							if ( !Npc[m_nIndex].m_SkillList.IncreaseLevel(nSkillIndex, nAddLevel) )
								return;
							m_nSkillPoint -= nAddLevel;
							nSkillLevel += nAddLevel;
						}
						else
						{
							if (nWantToBeLevel >=  g_SkillManager.GetSkillMaxLevel(nSkillId))
							{
								char szMsg[128];
								if (pSkill->IsExp())
									sprintf(szMsg, "Kh�ng th� s� d�ng �i�m k� n�ng �� th�ng c�p k� n�ng %s c�a b�n", pSkill->GetSkillName());
								else
									sprintf(szMsg, "K� n�ng %s c�a B�n �� ��t c�p t�i �a, kh�ng c�n th�ng c�p th�m n�a.", pSkill->GetSkillName());
								KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_SKILL, (char *) szMsg, strlen(szMsg) );
							}
							else
							{
								char szMsg[128];
								sprintf(szMsg, "K� n�ng chi�n ��u c�a B�n ph�i ��t ��n c�p %d m�i c� th� th�ng c�p %s k� n�ng.", ((KSkill *)pSkill)->GetSkillReqLevel() -1 +  nAddLevel + nSkillLevel,  ((KSkill*)pSkill)->GetSkillName());
								KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_SKILL, (char *) szMsg, strlen(szMsg) );
							}

						}
					}
					break;
				case SKILL_SS_Thief:
					{
						return;
					}break;

				}

			// �ѵ�ǰ�˼��ܵĵ�����ʣ�༼�ܵ㷢���ͻ���
			UpdataCurData();
			PHONGTHAN_SKILL_LEVEL_UPDATE	sSkill;
			ZeroMemory(&sSkill, sizeof(sSkill));
	PhongThanInitializeWireHeader(&sSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(sSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSkill.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSkill.EntityId = Npc[m_nIndex].m_dwID;
			sSkill.SkillId = nSkillId;
			sSkill.Level = Npc[m_nIndex].m_SkillList.GetLevel(nSkillId);
			sSkill.BonusLevel = Npc[m_nIndex].m_SkillList.GetAddLevel(nSkillId);
			sSkill.Experience = Npc[m_nIndex].m_SkillList.GetExp(nSkillId);
			sSkill.Temporary = (Npc[m_nIndex].m_SkillList.IsTempSkill(nSkillId)) ? 1 : 0;
			sSkill.RemainingPoints = m_nSkillPoint;
			g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSkill, sizeof(sSkill));
		}
	}
}

void	KPlayer::IncSkillExp(int nSkillId, int nAddExp)
{
	int		nSkillIndex, nSkillLevel;

	nSkillIndex = Npc[m_nIndex].m_SkillList.FindSame(nSkillId);
	if (nSkillIndex <= 0)
		return;

	nSkillLevel = Npc[m_nIndex].m_SkillList.GetLevel(nSkillId);
	if (nSkillLevel >= MAX_SKILLLEVEL)
		return;

	ISkill * pSkill = NULL;
	if (nSkillLevel <= 0)
	{
		pSkill =  g_SkillManager.GetSkill(nSkillId, 1);
	}
	else
	{
		pSkill =  g_SkillManager.GetSkill(nSkillId, nSkillLevel);
	}

	if (pSkill)
	{
		if  (Npc[m_nIndex].m_SkillList.IncreaseExp(nSkillIndex, nAddExp))
			UpdataCurData();

		PHONGTHAN_SKILL_LEVEL_UPDATE	sSkill;
		ZeroMemory(&sSkill, sizeof(sSkill));
	PhongThanInitializeWireHeader(&sSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(sSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSkill.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sSkill.EntityId = Npc[m_nIndex].m_dwID;
		sSkill.SkillId = nSkillId;
		sSkill.Level = Npc[m_nIndex].m_SkillList.GetLevel(nSkillId);
		sSkill.BonusLevel = Npc[m_nIndex].m_SkillList.GetAddLevel(nSkillId);
		sSkill.Experience = Npc[m_nIndex].m_SkillList.GetExp(nSkillId);
		sSkill.Temporary = (Npc[m_nIndex].m_SkillList.IsTempSkill(nSkillId)) ? 1 : 0;
		sSkill.RemainingPoints = m_nSkillPoint;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSkill, sizeof(sSkill));
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��������˼���Ʒ
//-------------------------------------------------------------------------
BOOL	KPlayer::ServerPickUpItem(BYTE* pProtocol)
{
	if(!Npc[m_nIndex].IsAlive())
		return FALSE;

	PHONGTHAN_ITEM_PICKUP_REQUEST* pPickUp =
		(PHONGTHAN_ITEM_PICKUP_REQUEST*)pProtocol;
	if (!pPickUp ||
		pPickUp->Header.MessageType != PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST ||
		pPickUp->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pPickUp->Header.PacketSize != sizeof(PHONGTHAN_ITEM_PICKUP_REQUEST) ||
		pPickUp->WorldObjectId == 0)
	{
		return FALSE;
	}

	int		nObjIndex, nNpcX, nNpcY, nObjX, nObjY;
	nObjIndex = ObjSet.FindID(pPickUp->WorldObjectId);
	if (nObjIndex == 0)
		return FALSE;

	/*if (Object[nObjIndex].m_nBelong != -1)
	{
		if (!m_cTeam.m_nFlag || Item[Object[nObjIndex].m_nItemDataID].GetLockTrade())
		{
			if (Object[nObjIndex].m_nKind == Obj_Kind_Money)
			{
				if (Object[nObjIndex].m_nBelong != m_nPlayerIndex)
				{
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_MONEY_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else if (Object[nObjIndex].m_nKind == Obj_Kind_Item)
			{
				if (Object[nObjIndex].m_nItemDataID <= 0 || Object[nObjIndex].m_nItemDataID >= MAX_ITEM)
				{
					_ASSERT(0);
					return FALSE;
				}
				if (Object[nObjIndex].m_nBelong != m_nPlayerIndex)
				{
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_OBJ_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else
			{
				return FALSE;
			}
		}
		else
		{
			if (Object[nObjIndex].m_nKind == Obj_Kind_Money)
			{
				if (!g_Team[m_cTeam.m_nID].CheckIn(m_nPlayerIndex, Object[nObjIndex].m_nBelong))
				{
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_MONEY_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else if (Object[nObjIndex].m_nKind == Obj_Kind_Item)
			{
				if (Object[nObjIndex].m_nItemDataID <= 0 || Object[nObjIndex].m_nItemDataID >= MAX_ITEM)
				{
					_ASSERT(0);
					return FALSE;
				}
				if (!g_Team[m_cTeam.m_nID].CheckIn(m_nPlayerIndex, Object[nObjIndex].m_nBelong))
				{
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_OBJ_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else
			{
				return FALSE;
			}
		}
	}*/

	//TamLTM and Kinox fix auto ingame nhat do
	if (Object[nObjIndex].m_nBelong != -1)
	{
		if (!m_cTeam.m_nFlag || Item[Object[nObjIndex].m_nItemDataID].GetLockTrade())
		{
			//TamLTM fix nhat do;

			if (Object[nObjIndex].m_nBelong != m_nPlayerIndex)
			{
				// g_DebugLog("KHONG THE NHAT DUOC DO");
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;

				if (Object[nObjIndex].m_nKind == Obj_Kind_Money)
				{
					sMsg.m_wMsgID = enumMSG_ID_MONEY_CANNOT_PICKUP;
				}
				else
				{
					sMsg.m_wMsgID = enumMSG_ID_OBJ_CANNOT_PICKUP;
				}

				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				return FALSE;
			}
			//end code;
		}
		else
		{
			if (Object[nObjIndex].m_nKind == Obj_Kind_Money)
			{
				if (!g_Team[m_cTeam.m_nID].CheckIn(m_nPlayerIndex, Object[nObjIndex].m_nBelong))
				{
					// g_DebugLog("NHAT TIEN");
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_MONEY_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else if (Object[nObjIndex].m_nKind == Obj_Kind_Item)
			{
				if (Object[nObjIndex].m_nItemDataID <= 0 || Object[nObjIndex].m_nItemDataID >= MAX_ITEM)
				{
					_ASSERT(0);
					return FALSE;
				}
				if (!g_Team[m_cTeam.m_nID].CheckIn(m_nPlayerIndex, Object[nObjIndex].m_nBelong))
				{
					// g_DebugLog("NHAT TRANG BI");
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_OBJ_CANNOT_PICKUP;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					return FALSE;
				}
			}
			else
			{
				return FALSE;
			}
		}
	}
	//end code

	// �жϾ���
	if (Object[nObjIndex].m_nSubWorldID != Npc[m_nIndex].m_SubWorldIndex)
		return FALSE;
	SubWorld[Object[nObjIndex].m_nSubWorldID].Map2Mps(
		Object[nObjIndex].m_nRegionIdx,
		Object[nObjIndex].m_nMapX,
		Object[nObjIndex].m_nMapY,
		Object[nObjIndex].m_nOffX,
		Object[nObjIndex].m_nOffY,
		&nObjX,
		&nObjY);
	SubWorld[Npc[m_nIndex].m_SubWorldIndex].Map2Mps(
		Npc[m_nIndex].m_RegionIndex,
		Npc[m_nIndex].m_MapX,
		Npc[m_nIndex].m_MapY,
		Npc[m_nIndex].m_OffX,
		Npc[m_nIndex].m_OffY,
		&nNpcX,
		&nNpcY);

	if ( PLAYER_PICKUP_SERVER_DISTANCE < (nNpcX - nObjX) * (nNpcX - nObjX) + (nNpcY - nObjY) * (nNpcY - nObjY))
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_OBJ_TOO_FAR;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}

	if (Object[nObjIndex].m_dwScriptID)
	{
		DWORD dwScriptId = Object[nObjIndex].m_dwScriptID;//g_FileName2Id(m_szScriptName);
		KLuaScript * pScript = (KLuaScript*)g_GetScript(dwScriptId);
		try
		{
			if (pScript)
			{
				if (m_nIndex < 0) return FALSE;
				Npc[m_nIndex].m_ActionScriptID = dwScriptId;
				Lua_PushNumber(pScript->m_LuaState, GetPlayerIndex());
				pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

				Lua_PushNumber(pScript->m_LuaState, GetPlayerID());
				pScript->SetGlobalName(SCRIPT_PLAYERID);

				Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
				pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

				Lua_PushNumber(pScript->m_LuaState, m_nIndex);
				pScript->SetGlobalName(SCRIPT_OBJINDEX);

				int nTopIndex = 0;
				pScript->SafeCallBegin(&nTopIndex);

				BOOL bResult = FALSE;
				bResult = pScript->CallFunction(NORMAL_FUNCTION_NAME, 0, "d", nObjIndex);
				pScript->SafeCallEnd(nTopIndex);
			}
		}
		catch(...)
		{
			printf("-->Error Execute: %u [%s]\n", dwScriptId, NORMAL_FUNCTION_NAME);
		}
	}

	switch (Object[nObjIndex].m_nKind)
	{
	case Obj_Kind_Item:				// ���ڵ��ϵ�װ��
		{
			int nStackNum = Item[Object[nObjIndex].m_nItemDataID].GetStackNum();

			int nItemIdx = m_ItemList.Add(Object[nObjIndex].m_nItemDataID,
				pPickUp->DestinationContainer,
				pPickUp->DestinationX, pPickUp->DestinationY);

			if (nItemIdx <= 0 || nItemIdx >= MAX_PLAYER_ITEM)
				return FALSE;

			////TamLTM fix nhat do;
		//	if (Object[nObjIndex].m_nItemDataID <= 0 || Object[nObjIndex].m_nItemDataID >= MAX_ITEM)
		//		return FALSE;
			//end code

			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_GET_ITEM;
			sMsg.m_lpBuf = (LPVOID)MAKELONG(Item[m_ItemList.m_Items[nItemIdx].nIdx].GetID(), nStackNum);
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
			g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			sMsg.m_lpBuf = 0;


			if (Object[nObjIndex].GetObjPickExecute()) //load script ngay sau khi nhat vat pham
			{
				m_ItemList.ExecuteScript(m_ItemList.m_Items[nItemIdx].nIdx);
			}

			if (Object[nObjIndex].m_nItemDataID <= 0 || Object[nObjIndex].m_nItemDataID >= MAX_ITEM)
				return FALSE;


			// ȥ��Object[nObjIndex]����ߵĹ���������ItemSet��Remove��Object��Remove����
			Object[nObjIndex].m_dwScriptID = 0;
			Object[nObjIndex].m_nItemDataID = 0;
			Object[nObjIndex].m_nItemWidth = 0;
			Object[nObjIndex].m_nItemHeight = 0;
			Object[nObjIndex].m_bPickExecute = FALSE;
			Object[nObjIndex].Remove(FALSE);

			//TamLTM fix save data;
			//if (Object[nObjIndex].m_bByPlayer)
			//{
				if (this->CanSave())
				{
					if (this->Save())
					{
						this->m_uMustSave = SAVE_REQUEST;
					//	g_DebugLog("CanSave(2)");
					}
				}
			//}
			//end code;

		}
		break;
	case Obj_Kind_Money:			// ���ڵ��ϵ�Ǯ

		//TamLTM Bang hoi chiem linh thanh thi thon
		int nMoneyMapT;
		nMoneyMapT = 0;
		int mMapAddMoney;
		mMapAddMoney = 0;
		if (SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 224) // Sac Mac Dia Bieu, Mac Cao Quat
			mMapAddMoney = 37; // Bien Kinh
		else if (SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 321 || SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 227) // truong bach nam, sa mac 3
			mMapAddMoney = 1;//6; // Phuong Tuong
		else if (SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 322 || SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 226) // truong bach nam, sa mac 2
			mMapAddMoney = 78;//14; // Tuong Duong
		else if (SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID == 225) // Mac bac, sa mac 1
			mMapAddMoney = 37; // Chi co 1 thanh thi, tat ca ban do thu thue ve Bien Kinh


		mMapAddMoney = 11; // Thanh Do

		if (mMapAddMoney != 0)
		{
		if (SubWorld[mMapAddMoney].m_bCheckTong)
			{
				//int nTongT = SubWorld[mMapAddMoney].m_nTongVG;
				int nTongT = 5;
				if (nTongT >= 0 && nTongT <= 50)
				{
					if (SubWorld[mMapAddMoney].m_dwTongName == m_cTong.GetTongNameID())
					{
					nMoneyMapT = Object[nObjIndex].m_nMoneyNum * nTongT /200;
					}
					else
					{
					nMoneyMapT = Object[nObjIndex].m_nMoneyNum * nTongT /100;
					}


					if (Object[nObjIndex].m_nMoneyNum <= nMoneyMapT || nMoneyMapT < 0)
					{
						nMoneyMapT = 0;
					}
				}
			}
		}

		if ( !Earn(Object[nObjIndex].m_nMoneyNum - nMoneyMapT) )
			return FALSE;

		if (mMapAddMoney != 0)
		{
			if (SubWorld[mMapAddMoney].m_bCheckTong)
			{
				try
				{
					bool bExecuteScriptMistake = true;
					KLuaScript * pScript = (KLuaScript* )g_GetScript("\\script\\item\\banghoi\\banghoi.lua");;
					if (pScript)
					{
						int nTopIndex = 0;
						pScript->SafeCallBegin(&nTopIndex);
						if (pScript->CallFunction("AddMoneyMain",0, "dsd",SubWorld[mMapAddMoney].m_dwTongName,SubWorld[mMapAddMoney].m_szTongNameBC,nMoneyMapT));
						{
							bExecuteScriptMistake = false;
						}

						pScript->SafeCallEnd(nTopIndex);
					}
				}
				catch(...)
				{
					printf("Exception Have Caught When Execute Script[%d]!!!!!", g_FileName2Id("\\script\\item\\banghoi\\banghoi.lua"));
				}
			}
		}
		//TamLTM fix save data;
	//	if (Object[nObjIndex].m_bByPlayer)
	//	{
		  if (this->CanSave())
			{
				if (this->Save())
				{
					this->m_uMustSave = SAVE_REQUEST;
				//	g_DebugLog("CanSave(3)");
				}
			}
	//	}
		//end code */

		if ( !Earn(Object[nObjIndex].m_nMoneyNum) )
			return FALSE;
		Object[nObjIndex].SyncRemove(TRUE);
		if (Object[nObjIndex].m_nRegionIdx >= 0)
			SubWorld[Object[nObjIndex].m_nSubWorldID].m_Region[Object[nObjIndex].m_nRegionIdx].RemoveObj(nObjIndex);
		ObjSet.Remove(nObjIndex);
		break;
	}

	return TRUE;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ���Ҫ��ʹ��ĳ����Ʒ(����Ҽ����)
//-------------------------------------------------------------------------
void	KPlayer::EatItem(BYTE* pProtocol)
{
	if (this->CheckTrading())
		return;
	if (!pProtocol)
		return;

	PHONGTHAN_ITEM_USE_REQUEST* pUse = (PHONGTHAN_ITEM_USE_REQUEST*)pProtocol;
	if (!pUse ||
		pUse->Header.MessageType != PHONGTHAN_MSG_INVENTORY_USE_REQUEST ||
		pUse->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pUse->Header.PacketSize != sizeof(PHONGTHAN_ITEM_USE_REQUEST) ||
		pUse->ItemId == 0 || pUse->Container <= 0 || pUse->Container >= pos_num)
	{
		return;
	}
	SO_ItemActionDiag("UseItem_REQUEST", 0, pUse->ItemId,
		pUse->SlotX, pUse->SlotY, 0, 0, pUse->Container, m_nPlayerIndex);

	BOOL bUseRet = m_ItemList.EatItemByID(pUse->ItemId,
		pUse->Container, pUse->SlotX, pUse->SlotY);
	SO_ItemActionDiagText("UseItem_RESULT", "EatItemByID", pUse->ItemId, bUseRet);

}
#endif

#ifdef _SERVER
void	KPlayer::ServerMoveItem(BYTE* pProtocol)
{
	if (!pProtocol)
		return;
	PHONGTHAN_ITEM_MOVE_REQUEST* pMove =
		(PHONGTHAN_ITEM_MOVE_REQUEST*)pProtocol;
	if (pMove->Header.MessageType != PHONGTHAN_MSG_INVENTORY_MOVE_REQUEST ||
		pMove->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pMove->Header.PacketSize != sizeof(PHONGTHAN_ITEM_MOVE_REQUEST))
	{
		return;
	}
	ItemPos		DownPos, UpPos;

	DownPos.nPlace = pMove->FromContainer;
	DownPos.nX = pMove->FromX;
	DownPos.nY = pMove->FromY;
	UpPos.nPlace = pMove->ToContainer;
	UpPos.nX = pMove->ToX;
	UpPos.nY = pMove->ToY;
	if (DownPos.nPlace <= 0 || DownPos.nPlace >= pos_num ||
		UpPos.nPlace <= 0 || UpPos.nPlace >= pos_num)
		return;

	if (this->CheckTrading() && DownPos.nPlace == pos_traderoom)
	{
		if (this->m_cTrade.m_nTradeLock)
			return;

		int nHandIdx = this->m_ItemList.Hand();
		if (Item[nHandIdx].GetLock()->IsLock() ||
			Item[nHandIdx].IsTemp() ||
			Item[nHandIdx].GetLockTrade())
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_LOCK_NOT_TRADE;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			if(g_pServer && m_nNetConnectIdx != -1)
				g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			return;
		}
	}

	SO_ItemActionDiag("Move_SERVER_BEGIN", DownPos.nPlace, m_ItemList.Hand(), DownPos.nX, DownPos.nY, UpPos.nX, UpPos.nY, UpPos.nPlace, m_nPlayerIndex);
	m_ItemList.ExchangeItem(&DownPos, &UpPos);
	SO_ItemActionDiagText("Move_SERVER_END", "hand", m_ItemList.Hand(), m_nPlayerIndex);
}
#endif

#ifdef _SERVER
void	KPlayer::ServerThrowAwayItem(BYTE* pProtocol)
{
	PHONGTHAN_ITEM_DROP_REQUEST* pDrop =
		(PHONGTHAN_ITEM_DROP_REQUEST*)pProtocol;
	if (!pDrop ||
		pDrop->Header.MessageType != PHONGTHAN_MSG_INVENTORY_DROP_REQUEST ||
		pDrop->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pDrop->Header.PacketSize != sizeof(PHONGTHAN_ITEM_DROP_REQUEST) ||
		pDrop->ItemId == 0)
	{
		return;
	}
	if (this->CheckTrading())
		return;

	if (this->GetLockMove()->bLock)
		return;

	if ( !this->m_ItemList.Hand() )
		return;

	int nItemIdx = m_ItemList.m_Hand;

	if (nItemIdx <= 0 || nItemIdx >= MAX_ITEM ||
		Item[nItemIdx].GetID() != pDrop->ItemId)
		return;

	if (Item[nItemIdx].GetLock()->IsLock() ||
		Item[nItemIdx].GetLockDrop() ||
		Item[nItemIdx].GetSetID() > 0)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_LOCK_NOT_THROW;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	if (Item[nItemIdx].IsTemp())
	{
		m_ItemList.Remove(nItemIdx);
		ItemSet.Remove(nItemIdx);
		return;
	}

	KMapPos		sMapPos;

	GetAboutPos(&sMapPos);
	if (m_ItemList.Remove(nItemIdx))
	{
		int		nObj;
		KObjItemInfo	sInfo;
		sInfo.m_nItemID = nItemIdx;
		sInfo.m_nItemWidth = Item[nItemIdx].GetWidth();
		sInfo.m_nItemHeight = Item[nItemIdx].GetHeight();
		sInfo.m_nMoneyNum = 0;
		strcpy(sInfo.m_szName, Item[nItemIdx].GetName());
		sInfo.m_nColorID = Item[nItemIdx].GetQuality();
		sInfo.m_nGenre = Item[nItemIdx].GetGenre();
		sInfo.m_nDetailType = Item[nItemIdx].GetDetailType();
		sInfo.m_nMovieFlag = 1;
		sInfo.m_nSoundFlag = 1;
		sInfo.m_bOverLook = 1;

		nObj = ObjSet.Add(Item[nItemIdx].GetObjIdx(), sMapPos, sInfo);
		if (nObj >= 0)
		{
			if (Item[nItemIdx].GetLockTrade())
			{
				Object[nObj].SetEntireBelong(this->m_nPlayerIndex);
			}
			else
			{
				Object[nObj].SetItemBelong(-1);
			}
		}

		if (this->CanSave())
		{
			if (this->Save())
			{
				this->m_uMustSave = SAVE_REQUEST;
			//	g_DebugLog("CanSave(4)");
			}
		}
	}
}
#endif


#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ���������������״̬
//-------------------------------------------------------------------------
void	KPlayer::TradeApplyOpen(BYTE* pProtocol)
{
	if ( CheckTrading() )
		return;
	if (m_bForbidTrade)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	TRADE_APPLY_OPEN_COMMAND	*pApply = (TRADE_APPLY_OPEN_COMMAND*)pProtocol;
	char	szSentence[MAX_SENTENCE_LENGTH];
	int		nLength = pApply->m_wLength - (sizeof(TRADE_APPLY_OPEN_COMMAND) - 1 - sizeof(pApply->m_szSentence));
	if (nLength >= MAX_SENTENCE_LENGTH)
		nLength = MAX_SENTENCE_LENGTH - 1;
	memset(szSentence, 0, sizeof(szSentence));
	memcpy(szSentence, pApply->m_szSentence, nLength);

	switch (m_cMenuState.m_nState)
	{
	case PLAYER_MENU_STATE_NORMAL:
	case PLAYER_MENU_STATE_TRADEOPEN:
		m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_TRADEOPEN, szSentence, nLength);
		break;
	//TamLTM auto pt to doi
	case PLAYER_MENU_STATE_TEAMOPEN:
		//TamLTM auto pt to doi
		if (m_cTeam.m_nFlag && g_Team[m_cTeam.m_nID].IsOpen())
			m_cMenuState.m_bBackTeamState = true;
		//end code

		if (m_cTeam.m_nFlag && m_cTeam.m_nID >= 0)
			g_Team[m_cTeam.m_nID].SetTeamClose();

		//TamLTM check trade
		if (m_cTeam.m_nFlag && m_cTeam.m_nID >= 0)
		{
		//	m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_TRADEOPEN);
			m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_TRADEOPEN, szSentence, nLength);
		}
		//end code


		break;
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ�������ȡ��������״̬
//-------------------------------------------------------------------------
void	KPlayer::TradeApplyClose(BYTE* pProtocol)
{
	m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_NORMAL);
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��յ��ͻ������뿪ʼ����
//-------------------------------------------------------------------------
void	KPlayer::TradeApplyStart(BYTE* pProtocol)
{
	if (this->CheckTrading())
		return;

	TRADE_APPLY_START_COMMAND	*pStart = (TRADE_APPLY_START_COMMAND*)pProtocol;

	int		nPlayer;
	nPlayer = FindAroundPlayer(pStart->m_dwID);
	if (nPlayer < 0)
		return;
	if (Player[nPlayer].m_cMenuState.m_nState != PLAYER_MENU_STATE_TRADEOPEN)
		return;

	this->m_cTrade.m_nApplyIdx = nPlayer;

	for (int i = MAX_PLAYER - 1; i > 0; i--)
	{
		if (i != m_nPlayerIndex && !IsExchangingServer() && Player[i].m_cTrade.m_nTradeDest == m_nPlayerIndex)
		{
			return;
		}
	}

	TRADE_APPLY_START_SYNC	sApply;
	sApply.ProtocolType = s2c_tradeapplystart;
	sApply.m_nDestIdx = this->m_nPlayerIndex;
	sApply.m_dwNpcId = Npc[m_nIndex].m_dwID;
	sApply.m_bFolkGame = pStart->m_bFolkGame;
	if (g_pServer)
		g_pServer->PackDataToClient(Player[nPlayer].m_nNetConnectIdx, (BYTE*)&sApply, sizeof(TRADE_APPLY_START_SYNC));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�
//-------------------------------------------------------------------------
void	KPlayer::TradeMoveMoney(BYTE* pProtocol)
{
	if ( !CheckTrading() )
		return;
	if (this->m_cTrade.m_nTradeLock)
		return;

	int		nMoney;
	TRADE_MOVE_MONEY_COMMAND	*pMoney = (TRADE_MOVE_MONEY_COMMAND*)pProtocol;
	if (pMoney->m_nMoney < 0 || pMoney->m_nMoney > (m_ItemList.GetEquipmentMoney() + m_ItemList.GetTradeMoney()))
		nMoney = 0;
	else
		nMoney = pMoney->m_nMoney;

	m_ItemList.TradeMoveMoney(nMoney);
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�ִ�л�ȡ������
//-------------------------------------------------------------------------
void	KPlayer::TradeDecision(BYTE* pProtocol)
{
	if ( !CheckTrading(true) )
		return;

	TRADE_DECISION_COMMAND	*pDecision = (TRADE_DECISION_COMMAND*)pProtocol;
	if (pDecision->m_btDecision == 0)	// ȡ������
	{
		int	nDestIdx;
		nDestIdx = this->m_cTrade.m_nTradeDest;
		// ȡ�����׵����ݻָ�
		this->m_ItemList.RecoverTrade();
		this->m_ItemList.ClearRoom(room_trade);
		this->m_ItemList.ClearRoom(room_trade1);
		this->m_cTrade.Release();
		Player[nDestIdx].m_ItemList.RecoverTrade();
		Player[nDestIdx].m_ItemList.ClearRoom(room_trade);
		Player[nDestIdx].m_ItemList.ClearRoom(room_trade1);
		Player[nDestIdx].m_cTrade.Release();

		TRADE_DECISION_SYNC	sSync;
		sSync.ProtocolType = s2c_tradedecision;
		sSync.m_btDecision = 0;
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));
		g_pServer->PackDataToClient(Player[nDestIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));

		// ȡ�����׵�״̬�ָ�(����״̬һ�������� trading)(����)
		this->m_cMenuState.RestoreBackupState(m_nPlayerIndex);

		// ȡ�����׵�״̬�ָ�(����״̬һ�������� trading)(�Է�)
		Player[nDestIdx].m_cMenuState.RestoreBackupState(nDestIdx);

		return;
	}
	else if (pDecision->m_btDecision == 2)	// ��������
	{
		if (this->m_cTrade.m_nTradeLock == 0)
			this->m_cTrade.m_nTradeLock = 1;

		SyncTradeState();
		return;
	}
	else if (pDecision->m_btDecision == 3)
	{
		if(this->m_cTrade.m_bTradeFolkGame && Player[m_cTrade.m_nTradeDest].m_cTrade.m_bTradeFolkGame)
		{
			if(pDecision->m_btFolkGame != 0 && pDecision->m_btFolkGame != 1)
			{
				char szMsg[128];
				sprintf(szMsg, "B�n ch� c� th� nh�p v�o 0 ho�c 1, vui l�ng nh�p l�i");
				KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
				SyncTradeState(TRUE);
				return;
			}
			if(Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeFolkId == -1)
			{
				this->m_cTrade.m_nTradeFolkId = pDecision->m_btFolkGame;
				Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeState = 1;

				char szMsg[128];
				sprintf(szMsg, "B�n �� ra s� %d, xin ch� ��i ph��ng ��i s�",this->m_cTrade.m_nTradeFolkId);
				KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );

				SyncTradeState(FALSE, TRUE);
			}
			else
			{
				this->m_cTrade.m_nTradeFolkId = pDecision->m_btFolkGame;
				TradeFolkGameDecision(this->m_cTrade.m_nTradeFolkId == Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeFolkId ? 0 : 1);
			}
		}
		return;
	}
	else if (pDecision->m_btDecision == 1)	// ִ�н���
	{
		// ���˫��û��ͬʱ����������ȷ��
		if (this->m_cTrade.m_nTradeLock != 1 ||
			Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeLock != 1)
		{
			SyncTradeState();
			return;
		}
		// �Է���ûȷ����֪ͨ�Է��Լ���ȷ��
		else if (Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeState == 0)
		{
			m_cTrade.m_nTradeState = 1;
			Player[m_cTrade.m_nTradeDest].m_cTrade.m_uTradeOkTime = GetTickCount();
			SyncTradeState(this->m_cTrade.m_bTradeFolkGame);
			return;
		}
		// �Է���ȷ����ִ�н���
		else
		{
			if (this->m_cTrade.m_bTradeFolkGame && Player[m_cTrade.m_nTradeDest].m_cTrade.m_bTradeFolkGame)
			{
				if(Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeFolkId == -1)
				{
					char szMsg[128];
					sprintf(szMsg, "��i ph��ng �ang ra s�, xin ��i m�t l�t");
					KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
					return;
				}
				return;
			}
			else
			{
				if (GetTickCount() - m_cTrade.m_uTradeOkTime < defPLAYER_TRADE_STATE)
					return;
				// ִ�н���֮ǰ���ȼ��һ���Ƿ��д���
				// -------------------- ��� money --------------------
				int	nSM1, nSM2, nDM1, nDM2;
				int	nDestIdx = m_cTrade.m_nTradeDest;
				nSM1 = m_ItemList.GetMoney(room_equipment);
				nSM2 = m_ItemList.GetMoney(room_trade);
				nDM1 = Player[nDestIdx].m_ItemList.GetMoney(room_equipment);
				nDM2 = Player[nDestIdx].m_ItemList.GetMoney(room_trade);
				if (nSM2 < 0 || nSM1 + nDM2 - nSM2 < 0)
				{
					this->m_ItemList.TradeMoveMoney(0);
					// ֪ͨ�ͻ���Ǯ������ not end
					return;
				}
				if (nDM2 < 0 || nDM1 + nSM2 - nDM2 < 0)
				{
					Player[nDestIdx].m_ItemList.TradeMoveMoney(0);
					// ֪ͨ�ͻ���Ǯ������ not end
					return;
				}
				// ------------------ ��� money end ------------------

				// --------- ���˫����Ʒ���ܷ�����������Ʒ ---------
				int		nSelfCanGet, nDestCanGet;

				// �жϼ�����Ʒ���ܷ�����������Ʒ
				Player[nDestIdx].m_ItemList.GetTradeRoomItemInfo();
				nSelfCanGet = m_ItemList.TradeCheckCanPlace();
				ItemSet.BackItemInfo();

				// �ж϶Է���Ʒ���ܷ�����������Ʒ
				this->m_ItemList.GetTradeRoomItemInfo();
				nDestCanGet = Player[nDestIdx].m_ItemList.TradeCheckCanPlace();

				if (!nSelfCanGet || !nDestCanGet)
				{
					if (!nSelfCanGet)
					{
						this->m_cTrade.m_nTradeState = 0;

						// ֪ͨ�ͻ�������Ķ����Ų���
						SHOW_MSG_SYNC	sMsg;
						sMsg.ProtocolType = s2c_msgshow;
						sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
						sMsg.m_wMsgID = enumMSG_ID_TRADE_SELF_ROOM_FULL;
						g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
						sMsg.m_wMsgID = enumMSG_ID_TRADE_DEST_ROOM_FULL;
						g_pServer->PackDataToClient(Player[nDestIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					}
					if (!nDestCanGet)
					{
						Player[nDestIdx].m_cTrade.m_nTradeState = 0;

						// ֪ͨ�ͻ�������Ķ����Ų���
						SHOW_MSG_SYNC	sMsg;
						sMsg.ProtocolType = s2c_msgshow;
						sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
						sMsg.m_wMsgID = enumMSG_ID_TRADE_SELF_ROOM_FULL;
						g_pServer->PackDataToClient(Player[nDestIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
						sMsg.m_wMsgID = enumMSG_ID_TRADE_DEST_ROOM_FULL;
						g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
					}
					SyncTradeState();
					return;
				}
				// ------- ���˫����Ʒ���ܷ�����������Ʒ end -------

				// ֪ͨ�ͻ��˽������
				TRADE_DECISION_SYNC	sSync;
				sSync.ProtocolType = s2c_tradedecision;
				sSync.m_btDecision = 1;
				g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));
				g_pServer->PackDataToClient(Player[nDestIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));

				// �������˽�������״̬
				m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_NORMAL);
				Player[nDestIdx].m_cMenuState.SetState(nDestIdx, PLAYER_MENU_STATE_NORMAL);
				this->m_cTrade.Release();
				Player[nDestIdx].m_cTrade.Release();
				// �����н�Ǯ�Ľ���
				if (nSM2 <= nDM2)
				{
					this->Earn(nDM2 - nSM2);
					Player[nDestIdx].Pay(nDM2 - nSM2);
				}
				else
				{
					this->Pay(nSM2 - nDM2);
					Player[nDestIdx].Earn(nSM2 - nDM2);
				}

				//--------------- ��������Ʒ�Ľ��� ---------------------
				// �Է�����Ʒ������
				int		nPos;
				nPos = 0;
				while (1)
				{
					if (nPos >= TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT)
						break;
					if (!ItemSet.m_psBackItemInfo[nPos].m_nIdx)
						break;
					// �Է�ȥ������Ʒ
					Player[nDestIdx].m_ItemList.Remove(ItemSet.m_psBackItemInfo[nPos].m_nIdx);
					// �����õ�����Ʒ
					m_ItemList.Add(
						ItemSet.m_psBackItemInfo[nPos].m_nIdx,
						pos_equiproom,
						ItemSet.m_psBackItemInfo[nPos].m_nX,
						ItemSet.m_psBackItemInfo[nPos].m_nY);
					nPos++;
				}
				// ��������Ʒ���Է�
				nPos = 0;
				while (1)
				{
					if (nPos >= TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT)
						break;
					if (!ItemSet.m_psItemInfo[nPos].m_nIdx)
						break;
					// ����ȥ������Ʒ
					this->m_ItemList.Remove(ItemSet.m_psItemInfo[nPos].m_nIdx);
					// �Է��õ�����Ʒ
					Player[nDestIdx].m_ItemList.Add(
						ItemSet.m_psItemInfo[nPos].m_nIdx,
						pos_equiproom,
						ItemSet.m_psItemInfo[nPos].m_nX,
						ItemSet.m_psItemInfo[nPos].m_nY);
					nPos++;
				}
				//------------- ��������Ʒ�Ľ��� end -------------------
				//TamLTM fix save data;
				if (Player[nDestIdx].CanSave())
				{
					if (Player[nDestIdx].Save())
					{
						Player[nDestIdx].m_uMustSave = SAVE_REQUEST;
					//	g_DebugLog("CanSave(7)");
					}

				}
				if (this->CanSave())
				{
					if (this->Save())
					{
						this->m_uMustSave = SAVE_REQUEST;
					//	g_DebugLog("CanSave(6)");
					}

				}
				//end code;
				return;
			}
		}
	}
}

void	KPlayer::TradeFolkGameDecision(BYTE btDecision)
{
	if ( !CheckTrading() )
		return;
	// ִ�н���֮ǰ���ȼ��һ���Ƿ��д���
	// -------------------- ��� money --------------------
	int	nSM1, nSM2, nDM1, nDM2;
	int	nDestIdx = m_cTrade.m_nTradeDest;
	nSM1 = m_ItemList.GetMoney(room_equipment);
	nSM2 = m_ItemList.GetMoney(room_trade);
	nDM1 = Player[nDestIdx].m_ItemList.GetMoney(room_equipment);
	nDM2 = Player[nDestIdx].m_ItemList.GetMoney(room_trade);
	if (nSM2 < 0 || nSM1 + nDM2 - nSM2 < 0)
	{
		this->m_ItemList.TradeMoveMoney(0);
		// ֪ͨ�ͻ���Ǯ������ not end
		return;
	}
	if (nDM2 < 0 || nDM1 + nSM2 - nDM2 < 0)
	{
		Player[nDestIdx].m_ItemList.TradeMoveMoney(0);
		// ֪ͨ�ͻ���Ǯ������ not end
		return;
	}
	// ------------------ ��� money end ------------------

	Player[nDestIdx].m_ItemList.GetTradeRoomItemInfo();
	ItemSet.BackItemInfo();

	// �ж϶Է���Ʒ���ܷ�����������Ʒ
	this->m_ItemList.GetTradeRoomItemInfo();

	// ֪ͨ�ͻ��˽������
	TRADE_DECISION_SYNC	sSync;
	sSync.ProtocolType = s2c_tradedecision;
	sSync.m_btDecision = 1;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));
	g_pServer->PackDataToClient(Player[nDestIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_DECISION_SYNC));

	// �������˽�������״̬
	m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_NORMAL);
	Player[nDestIdx].m_cMenuState.SetState(nDestIdx, PLAYER_MENU_STATE_NORMAL);
	this->m_cTrade.Release();
	Player[nDestIdx].m_cTrade.Release();

	this->Pay(nSM2);
	Player[nDestIdx].Pay(nDM2);
	int		nPos;
	nPos = 0;
	while (1)
	{
		if (nPos >= TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT)
			break;
		if (ItemSet.m_psBackItemInfo[nPos].m_nIdx)
			Player[nDestIdx].m_ItemList.Remove(ItemSet.m_psBackItemInfo[nPos].m_nIdx);
		if (ItemSet.m_psItemInfo[nPos].m_nIdx)
			this->m_ItemList.Remove(ItemSet.m_psItemInfo[nPos].m_nIdx);
		nPos++;
	}


	if (btDecision == 0)	// ִ�н���
	{
		char szMsg[128];
		sprintf(szMsg, "L�n ��u �� n�y b�n th�ng!");
		KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
		sprintf(szMsg, "L�n ��u �� n�y b�n thua!");
		KPlayerChat::SendSystemInfo(1, nDestIdx, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
		this->Earn(nSM2 + nDM2);
		Player[nDestIdx].Pay(nDM2);
		//--------------- ��������Ʒ�Ľ��� ---------------------
		// �Է�����Ʒ������
		int		nPos;
		nPos = 0;
		while (1)
		{
			if (nPos >= TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT)
				break;
			if (ItemSet.m_psBackItemInfo[nPos].m_nIdx)
				m_ItemList.InsertEquipment(ItemSet.m_psBackItemInfo[nPos].m_nIdx);

			if (ItemSet.m_psItemInfo[nPos].m_nIdx)
				m_ItemList.InsertEquipment(ItemSet.m_psItemInfo[nPos].m_nIdx);
			nPos++;
		}
		return;
	}
	else if (btDecision == 1)	// ִ�н���
	{
		char szMsg[128];
		sprintf(szMsg, "L�n ��u �� n�y b�n thua!");
		KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
		sprintf(szMsg, "L�n ��u �� n�y b�n th�ng!");
		KPlayerChat::SendSystemInfo(1, nDestIdx, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );

		this->Pay(nSM2);
		Player[nDestIdx].Earn(nSM2 + nDM2);

		int		nPos;
		nPos = 0;
		while (1)
		{
			if (nPos >= TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT)
				break;
			if (ItemSet.m_psBackItemInfo[nPos].m_nIdx)
				Player[nDestIdx].m_ItemList.InsertEquipment(ItemSet.m_psBackItemInfo[nPos].m_nIdx);

			if (ItemSet.m_psItemInfo[nPos].m_nIdx)
				m_ItemList.InsertEquipment(ItemSet.m_psItemInfo[nPos].m_nIdx);
			nPos++;
		}
		return;
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�ִ�л�ȡ������
//-------------------------------------------------------------------------
void	KPlayer::c2sTradeReplyStart(BYTE* pProtocol)
{
	if (this->CheckTrading())
		return;
	if (!pProtocol)
		return;
	TRADE_REPLY_START_COMMAND *pReply = (TRADE_REPLY_START_COMMAND*)pProtocol;

	int		nPlayerIdx = pReply->m_nDestIdx;
	if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER)
		return;
	if (Player[nPlayerIdx].m_nIndex <= 0)
		return;

	if (Npc[m_nIndex].m_FightMode)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR2;
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR3;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (LPVOID)Npc[m_nIndex].m_dwID;
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	if (Npc[Player[nPlayerIdx].m_nIndex].m_FightMode)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR2;
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR3;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (LPVOID)Npc[Player[nPlayerIdx].m_nIndex].m_dwID;
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	if (Player[nPlayerIdx].m_cTrade.m_nApplyIdx != this->m_nPlayerIndex)
		return;
	if (Player[nPlayerIdx].m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADING)
		return;
	if (Player[nPlayerIdx].m_bForbidTrade)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	for (int i = MAX_PLAYER - 1;i > 0; i--)
	{
		if (i != m_nPlayerIndex && !IsExchangingServer() && Player[i].m_cTrade.m_nTradeDest == m_nPlayerIndex)
		{
			return;
		}
		if (i != nPlayerIdx && Player[i].m_cTrade.m_nTradeDest == nPlayerIdx)
		{
			return;
		}
	}
	// �ܾ�
	if (pReply->m_bDecision == 0)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TRADE_REFUSE_APPLY;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
		sMsg.m_lpBuf = (LPVOID)Npc[m_nIndex].m_dwID;
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		sMsg.m_lpBuf = 0;
		return;
	}

	if (this->m_cMenuState.m_nState != PLAYER_MENU_STATE_TRADEOPEN || this->m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADING)
		return;

	if (pReply->m_bFolkGame)
	{
		int		nSelfCanGet, nDestCanGet;
		POINT ItemSize;
		ItemSize.x = TRADEFOLKGAME_NEED_WIDTH;
		ItemSize.y = TRADEFOLKGAME_NEED_HEIGHT;
		ItemPos	sItemPos;
		nSelfCanGet = this->m_ItemList.SearchPosition(ItemSize, &sItemPos);
		nDestCanGet = Player[nPlayerIdx].m_ItemList.SearchPosition(ItemSize, &sItemPos);

		if (!nSelfCanGet || !nDestCanGet)
		{
			if (!nSelfCanGet)
			{
				// ֪ͨ�ͻ�������Ķ����Ų���
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				sMsg.m_wMsgID = enumMSG_ID_TRADEFOLKGAME_SELF_ROOM_FULL;
				g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
				sMsg.m_lpBuf = (LPVOID)Npc[Player[m_nPlayerIndex].m_nIndex].m_dwID;
				sMsg.m_wMsgID = enumMSG_ID_TRADEFOLKGAME_DEST_ROOM_FULL;
				g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			}
			if (!nDestCanGet)
			{
				// ֪ͨ�ͻ�������Ķ����Ų���
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				sMsg.m_wMsgID = enumMSG_ID_TRADEFOLKGAME_SELF_ROOM_FULL;
				g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
				sMsg.m_lpBuf = (LPVOID)Npc[Player[nPlayerIdx].m_nIndex].m_dwID;
				sMsg.m_wMsgID = enumMSG_ID_TRADEFOLKGAME_DEST_ROOM_FULL;
				g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			}
			return;
		}
	}

	// ������ڶ��鿪��״̬���ر�֮
	// �����Ļ���Ҫվ����
	if (Npc[m_nIndex].m_Doing == do_sit)
	{
		Npc[m_nIndex].SendCommand(do_stand);
	}
	if (Npc[Player[nPlayerIdx].m_nIndex].m_Doing == do_sit)
	{
		Npc[Player[nPlayerIdx].m_nIndex].SendCommand(do_stand);
	}

	// �������Ĵ������ı�״̬����������
	this->m_ItemList.StartTrade();
	this->m_cTrade.Release();
	this->m_cTrade.StartTrade(nPlayerIdx, pReply->m_bFolkGame); //m_bFolkGame tro choi dan giang lac xi ngau`

	//TamLTM auto pt to doi
	if (this->m_cTeam.m_nFlag && g_Team[this->m_cTeam.m_nID].IsOpen())
		this->m_cMenuState.m_bBackTeamState = true;

	this->m_cMenuState.SetState(m_nPlayerIndex, PLAYER_MENU_STATE_TRADING, NULL, 0, Npc[Player[nPlayerIdx].m_nIndex].m_dwID);


	Player[nPlayerIdx].m_ItemList.StartTrade();
	Player[nPlayerIdx].m_cTrade.Release();
	Player[nPlayerIdx].m_cTrade.StartTrade(m_nPlayerIndex, pReply->m_bFolkGame);

	//TamLTM auto pt to doi
	if (Player[nPlayerIdx].m_cTeam.m_nFlag && g_Team[Player[nPlayerIdx].m_cTeam.m_nID].IsOpen())
		Player[nPlayerIdx].m_cMenuState.m_bBackTeamState = true;

	if (Player[nPlayerIdx].m_cMenuState.m_nState == PLAYER_MENU_STATE_TEAMOPEN)
	{
		PLAYER_TEAM_OPEN_CLOSE	sClose;
		sClose.m_btFlag = 0; //TamLTM auto pt to doi
		Player[nPlayerIdx].SetTeamState((BYTE*)&sClose);
	}

	Player[nPlayerIdx].m_cMenuState.SetState(nPlayerIdx, PLAYER_MENU_STATE_TRADING, NULL, 0, Npc[m_nIndex].m_dwID);
}
#endif

//-------------------------------------------------------------------------
//	���ܣ�������˫���Ŀͻ��˷��ͽ���״̬��Ϣ
//-------------------------------------------------------------------------
#ifdef _SERVER
void	KPlayer::SyncTradeState(BOOL bSelfAsk, BOOL bDestReply)
{
	if ( !CheckTrading() )
		return;

	TRADE_STATE_SYNC	sSync;
	sSync.ProtocolType = s2c_tradepressoksync;
	sSync.m_bSelfAskFolkGame = bSelfAsk;
	sSync.m_bDestReplyFolkGame = FALSE;
	sSync.m_btSelfLock = this->m_cTrade.m_nTradeLock;
	sSync.m_btDestLock = Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeLock;
	sSync.m_btSelfOk = m_cTrade.m_nTradeState;
	sSync.m_btDestOk = Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeState;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_STATE_SYNC));

	sSync.m_bSelfAskFolkGame = FALSE;
	sSync.m_bDestReplyFolkGame = bDestReply;
	sSync.m_btSelfLock = Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeLock;
	sSync.m_btDestLock = m_cTrade.m_nTradeLock;
	sSync.m_btSelfOk = Player[m_cTrade.m_nTradeDest].m_cTrade.m_nTradeState;
	sSync.m_btDestOk = m_cTrade.m_nTradeState;
	g_pServer->PackDataToClient(Player[m_cTrade.m_nTradeDest].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(TRADE_STATE_SYNC));
}
#endif

//-------------------------------------------------------------------------
//	���ܣ������Լ�װ�������ϵ�װ����Ϣ�����˿�
//-------------------------------------------------------------------------
#ifdef _SERVER
void	KPlayer::SendEquipItemInfo(int nTargetPlayer)
{
	if (nTargetPlayer <= 0 || nTargetPlayer >= MAX_PLAYER || Player[nTargetPlayer].m_nIndex <= 0)
		return;

	int				nIdx, i, j;
	PHONGTHAN_VIEW_ITEM_INFO	*pInfo;
	VIEW_EQUIP_SYNC	sView;
	ZeroMemory(&sView, sizeof(sView));

	sView.ProtocolType = s2c_viewequip;
	sView.m_dwNpcID = Npc[m_nIndex].m_dwID;
	sView.m_Avatar = m_ImagePlayer;//nay ben sv

	for (i = 0; i < itempart_num; i++)
	{
		nIdx = m_ItemList.m_EquipItem[i];
		pInfo = &sView.m_sInfo[i];
		if (nIdx <= 0)
		{
			memset(pInfo, 0, sizeof(PHONGTHAN_VIEW_ITEM_INFO));
			continue;
		}
		pInfo->m_nID			= Item[nIdx].GetID();
		pInfo->m_btGenre		= Item[nIdx].GetGenre();
		pInfo->m_WireVersion = PHONGTHAN_EMBEDDED_ITEM_VERSION;
		pInfo->m_nTemplateRow = Item[nIdx].GetRow();
		pInfo->m_btDetail = Item[nIdx].GetDetailType();
		pInfo->m_nParticularType		= Item[nIdx].GetParticular();
		pInfo->m_btSeries		= Item[nIdx].GetSeries();
		pInfo->m_btLevel		= Item[nIdx].GetLevel();
		pInfo->m_btLuck			= Item[nIdx].m_GeneratorParam.nLuck;
		pInfo->m_dwRandomSeed	= Item[nIdx].m_GeneratorParam.uRandomSeed;
		pInfo->m_wVersion		= Item[nIdx].m_GeneratorParam.nVersion;
		for (j = 0; j < MAX_ITEM_MAGICLEVEL; j++)
			pInfo->m_btMagicLevel[j] = (int)Item[nIdx].m_GeneratorParam.nGeneratorLevel[j];
	}
	g_pServer->PackDataToClient(Player[nTargetPlayer].m_nNetConnectIdx, (BYTE*)&sView, sizeof(sView));
}
#endif

#ifdef _SERVER
void	KPlayer::SparApplyStart(BYTE* pProtocol)
{
	SPAR_APPLY_START_COMMAND	*pStart = (SPAR_APPLY_START_COMMAND*)pProtocol;

	int		nPlayer;
	nPlayer = FindAroundPlayer(pStart->m_dwID);
	if (nPlayer < 0)
		return;

	SPAR_APPLY_START_SYNC	sApply;
	sApply.ProtocolType = s2c_sparapplystart;
	sApply.m_nDestIdx = this->m_nPlayerIndex;
	sApply.m_dwNpcId = Npc[m_nIndex].m_dwID;
	if (g_pServer)
		g_pServer->PackDataToClient(Player[nPlayer].m_nNetConnectIdx, (BYTE*)&sApply, sizeof(SPAR_APPLY_START_SYNC));
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������봫���ŵ���صĺ���
//-------------------------------------------------------------------------
BOOL KPlayer::UseTownPortal() //TamLTM Su dung item phu
{
	if (m_nPlayerIndex <= 0)
		return FALSE;
	if (m_nIndex <= 0)
		return FALSE;
	if (Npc[m_nIndex].m_SubWorldIndex < 0)
		return FALSE;
	if (Npc[m_nIndex].m_Doing == do_death ||
		Npc[m_nIndex].m_Doing == do_revive || Npc[m_nIndex].m_Doing == do_hurt) // fix lag frame khi ve thanh
		return FALSE;

//	g_DebugLog("adsdasdasdasdasd phu`");

	if (m_bForbidUseTownP)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	if (!Npc[m_nIndex].m_FightMode)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_ITEM_TOWNPORTAL;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}

	int nSubWorldID, nX, nY;
	nSubWorldID = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	Npc[m_nIndex].GetMpsPos(&nX, &nY);
	if (Npc[m_nIndex].ChangeWorld(m_sDeathRevivalPos.m_nSubWorldID, m_sDeathRevivalPos.m_nMpsX, m_sDeathRevivalPos.m_nMpsY))
	{
		m_sPortalPos.m_nSubWorldId = nSubWorldID;
		m_sPortalPos.m_nMpsX = nX;
		m_sPortalPos.m_nMpsY = nY;
		m_sPortalPos.m_nTime = TOWN_PORTAL_TIME;

		Npc[m_nIndex].SetFightMode(enumFightNone);
		return TRUE;
	}
	return FALSE;
}

BOOL KPlayer::BackToTownPortal()
{
	if (m_nPlayerIndex <= 0)
		return FALSE;
	if (m_nIndex <= 0)
		return FALSE;
	if (m_sPortalPos.m_nTime <= 0)
		return FALSE;

	Npc[m_nIndex].ChangeWorld(m_sPortalPos.m_nSubWorldId, m_sPortalPos.m_nMpsX, m_sPortalPos.m_nMpsY);
	m_sPortalPos.m_nSubWorldId = 0;
	m_sPortalPos.m_nTime = 0;
	m_sPortalPos.m_nMpsX = 0;
	m_sPortalPos.m_nMpsY = 0;
	Npc[m_nIndex].SetFightMode(TRUE);
	return TRUE;
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�������������
//-------------------------------------------------------------------------
void KPlayer::Revive(int nType)
{
	int	nSubWorldID = 0;
	int nMpsX = 0, nMpsY = 0;

	PHONGTHAN_ENTITY_STATUS	Sync;
	ZeroMemory(&Sync, sizeof(Sync));
	PhongThanInitializeWireHeader(&Sync.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(Sync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	Sync.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	Sync.Kind = PHONGTHAN_STATUS_REVIVE;
	Sync.EntityId = Npc[m_nIndex].m_dwID;
	Sync.Value = nType;
	g_pServer->PackDataToClient(m_nNetConnectIdx, (const void*)&Sync, sizeof(Sync));
	Npc[m_nIndex].BroadCastRevive(nType);

	switch(nType)
	{
	case REMOTE_REVIVE_TYPE:
		GetDeathRevivalPos(&nSubWorldID, &nMpsX, &nMpsY);
		Npc[m_nIndex].ChangeWorld(nSubWorldID, nMpsX, nMpsY);
		Npc[m_nIndex].m_FightMode = enumFightNone;
		break;
	case LOCAL_REVIVE_TYPE:
		Npc[m_nIndex].m_FightMode = enumFightActive;
		break;
	default:
		break;
	}

	Npc[m_nIndex].m_CurrentLife = Npc[m_nIndex].m_CurrentLifeMax;
	Npc[m_nIndex].m_CurrentMana = Npc[m_nIndex].m_CurrentManaMax;
	Npc[m_nIndex].m_CurrentStamina = Npc[m_nIndex].m_CurrentStaminaMax;
	//RestoreLiveData();
	Npc[m_nIndex].SendCommand(do_revive);
}


void KPlayer::RestoreLiveData()
{
	Npc[m_nIndex].RestoreNpcBaseInfo();
}

BOOL KPlayer::Pay(int nMoney)
{
	if (nMoney < 0)
		return FALSE;

	return m_ItemList.CostMoney(nMoney);
}

BOOL KPlayer::PrePay(int nMoney)
{
	if (nMoney < 0)
		return FALSE;

	if (Pay(nMoney))
	{
		m_nPrePayMoney = nMoney;
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

BOOL KPlayer::Earn(int nMoney)
{
	if (nMoney < 0)
		return FALSE;
	return m_ItemList.AddMoney(room_equipment, nMoney);
}

//�������������ݿ��л�����ȫ�����ݣ�������֮��ʹ�������Ч
void	KPlayer::LaunchPlayer()
{
	int nSubWorld = Npc[m_nIndex].m_SubWorldIndex;
	int nRegion = Npc[m_nIndex].m_RegionIndex;
	int nX = Npc[m_nIndex].m_MapX;
	int nY = Npc[m_nIndex].m_MapY;
	int nOffX = Npc[m_nIndex].m_OffX;
	int nOffY = Npc[m_nIndex].m_OffY;
	SubWorld[nSubWorld].AddPlayer(nRegion, m_nPlayerIndex);
	m_ulLastSaveTime = g_SubWorldSet.GetGameTime();

	//g_DebugLog("%d %d ", nX, nY);
	//TamLTM va cham GetBarrierMin
	if (SubWorld[nSubWorld].m_Region[nRegion].GetBarrierMin(nX, nY, nOffX, nOffY, FALSE, FALSE) != Obstacle_NULL)
	{
		Npc[m_nIndex].ChangeWorld(m_sLoginRevivalPos.m_nSubWorldID, m_sLoginRevivalPos.m_nMpsX, m_sLoginRevivalPos.m_nMpsY);
	}
	Npc[m_nIndex].SetExpandRank(&Npc[m_nIndex].m_ExpandRank);
	this->ExecuteScript(LOGIN_SCRIPT, NORMAL_FUNCTION_NAME, 0);
	// Static authored NPCs must be present on initial entry, not only after
	// movement or a periodic refresh. The login script may have changed maps.
	const int nLoadedWorld = Npc[m_nIndex].m_SubWorldIndex;
	if (nLoadedWorld >= 0 && nLoadedWorld < MAX_SUBWORLD)
		SubWorld[nLoadedWorld].SyncNpcNearPlayer(m_nPlayerIndex);
}
#endif


BOOL	KPlayer::ExecuteScript(char * ScriptFileName, char * szFunName, int nParam)
{
    if (!ScriptFileName || !ScriptFileName[0] || !szFunName  || !szFunName[0]) return FALSE;
    return ExecuteScript(g_FileName2Id(ScriptFileName), szFunName, nParam);
}
#define MAX_PARAMLIST_COUNT 5
BOOL	KPlayer::ExecuteScript(DWORD dwScriptId,  char * szFunName, int nParam)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);
            int nTopIndex = 0;

            pScript->SafeCallBegin(&nTopIndex);

            char* pListParam = 0;
            if (pListParam = strstr(szFunName, "("))
            {
                char szBuff[128];
                int PList[MAX_PARAMLIST_COUNT],nCnt =0,nLgth=0,nSat=0;
                g_StrCpyLen(szBuff,pListParam+1,sizeof(szBuff));
                *pListParam = 0;
                while (nCnt<MAX_PARAMLIST_COUNT)
                {
                    ++nLgth;
                    ++pListParam;
                    if (*pListParam)
                    {
                        if (*pListParam == ',')
                        {
                            g_StrCpyLen(szBuff,pListParam-nLgth+1,sizeof(szBuff));
                            PList[nCnt]=atoi(szBuff);
                            ++nCnt;nLgth = 0;continue;
                        }
                    }
                    else
                    {
                        g_StrCpyLen(szBuff,pListParam-nLgth+1,sizeof(szBuff));
                        PList[nCnt]=atoi(szBuff);
                        ++nCnt;nLgth=0;
                        for(nCnt;nCnt < MAX_PARAMLIST_COUNT;++nCnt)
                            PList[nCnt]=0;
                        break;
                    }
                }
                if (pScript->CallFunction(szFunName,0, "ddddd", PList[0],PList[1],PList[2],PList[3],PList[4]))
                {
                    bExecuteScriptMistake = false;
                }
            }
            else
            {
                if (pScript->CallFunction(szFunName,0, "d", nParam))
                {
                    bExecuteScriptMistake = false;
                }
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            if (pScript)
                g_DebugLog("[ExecuteScript] failed script=%s function=%s player=%d", pScript->m_szScriptName, szFunName, m_nPlayerIndex);
            else
                g_DebugLog("[ExecuteScript] script not found id=%u function=%s player=%d", dwScriptId, szFunName, m_nPlayerIndex);
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }

        return TRUE;
    }
    catch(...)
    {
        printf("-->Error Execute: %u [%s]\n", dwScriptId, szFunName);
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}

BOOL	KPlayer::ExecuteScript(DWORD dwScriptId, char * szFunName, char *  szParams)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        int nTopIndex = 0;

        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

            pScript->SafeCallBegin(&nTopIndex);

            char* pListParam = 0;
            if (pListParam = strstr(szFunName, "("))
            {
                char szBuff[128];
                int PList[MAX_PARAMLIST_COUNT],nCnt =0,nLgth=0,nSat=0;
                g_StrCpyLen(szBuff,pListParam+1,sizeof(szBuff));
                *pListParam = 0;
                while (nCnt<MAX_PARAMLIST_COUNT)
                {
                    ++nLgth;
                    ++pListParam;
                    if (*pListParam)
                    {
                        if (*pListParam == ',')
                        {
                            g_StrCpyLen(szBuff,pListParam-nLgth+1,sizeof(szBuff));
                            PList[nCnt]=atoi(szBuff);
                            ++nCnt;nLgth = 0;continue;
                        }
                    }
                    else
                    {
                        g_StrCpyLen(szBuff,pListParam-nLgth+1,sizeof(szBuff));
                        PList[nCnt]=atoi(szBuff);
                        ++nCnt;nLgth=0;
                        for(nCnt;nCnt < MAX_PARAMLIST_COUNT;++nCnt)
                            PList[nCnt]=0;
                        break;
                    }
                }
                if (pScript->CallFunction(szFunName,0, "ddddd", PList[0],PList[1],PList[2],PList[3],PList[4]))
                {
                    bExecuteScriptMistake = false;
                }
            }
            else
            {
                if ( (!szParams) || !szParams[0])
                {
                    if (pScript->CallFunction(szFunName, 0,""))
                    {
                        bExecuteScriptMistake = false;
                    }
                }
                else
                {
                    if (pScript->CallFunction(szFunName,0, "sd", szParams,0))
                    {
                        bExecuteScriptMistake = false;
                    }
                }
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }
        return TRUE;
    }
    catch(...)
    {
        printf("-->Error Execute: %u [%s]\n", dwScriptId, szFunName);
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}


BOOL	KPlayer::ExecuteScript(char * ScriptFileName, char * szFunName, char *  szParams)
{
    if (!ScriptFileName || !ScriptFileName[0] || !szFunName  || !szFunName[0]) return FALSE;
    DWORD dwScriptId = g_FileName2Id(ScriptFileName);
    return ExecuteScript(dwScriptId, szFunName, szParams);
}

BOOL	KPlayer::ExecuteScript2Param(char * ScriptFileName, char * cFuncName, int nResultCount, int nParam1, int nParam2)
{
    if (!ScriptFileName || !ScriptFileName[0] || !cFuncName  || !cFuncName[0]) return FALSE;
    DWORD dwScriptId = g_FileName2Id(ScriptFileName);
    return ExecuteScript2Param(dwScriptId, cFuncName, nResultCount, nParam1, nParam2);
}

BOOL	KPlayer::ExecuteScript2Param(DWORD dwScriptId, char * cFuncName, int nResultCount, int nParam1, int nParam2)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        int nTopIndex = 0;

        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

            pScript->SafeCallBegin(&nTopIndex);

            if (pScript->CallFunction(cFuncName, nResultCount, "dd", nParam1, nParam2))
            {
                bExecuteScriptMistake = false;
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }
        return TRUE;
    }
    catch(...)
    {
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}

BOOL	KPlayer::ExecuteScript3Param(char * ScriptFileName, char * cFuncName, int nResultCount, int nParam1, int nParam2, int nParam3)
{
    if (!ScriptFileName || !ScriptFileName[0] || !cFuncName  || !cFuncName[0]) return FALSE;
    DWORD dwScriptId = g_FileName2Id(ScriptFileName);
    return ExecuteScript3Param(dwScriptId, cFuncName, nResultCount, nParam1, nParam2, nParam3);
}

BOOL KPlayer::ExecuteScript3Param(DWORD dwScriptId, char * cFuncName, int nResultCount, int nParam1, int nParam2, int nParam3)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        int nTopIndex = 0;

        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

            pScript->SafeCallBegin(&nTopIndex);

            if (pScript->CallFunction(cFuncName, nResultCount, "ddd", nParam1, nParam2, nParam3))
            {
                bExecuteScriptMistake = false;
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }
        return TRUE;
    }
    catch(...)
    {
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}

//TamLTM Kham

BOOL	KPlayer::ExecuteScript2(DWORD dwScriptId, char * szFunName, char *  szParams1, char *  szParams2)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        int nTopIndex = 0;

        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

            pScript->SafeCallBegin(&nTopIndex);

            if ( ((!szParams1) || !szParams1[0]) && ((!szParams2) || !szParams2[0]))
            {
                if (pScript->CallFunction(szFunName, 0,""))
                {
                    bExecuteScriptMistake = false;
                }
            }
            else
            {
                if (pScript->CallFunction(szFunName, 0, "ssd", szParams1, szParams2, 0))
                {
                    bExecuteScriptMistake = false;
                }
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }
        return TRUE;
    }
    catch(...)
    {
        printf("Exception Have Caught When Execute Script[%u]!!!!!\n", dwScriptId);
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}

BOOL	KPlayer::ExecuteScript2(DWORD dwScriptId,  char * szFunName, int nParam1, int nParam2)
{
    try
    {
        m_btTryExecuteScriptTimes = 0;
        bool bExecuteScriptMistake = true;
        int nTopIndex = 0;
        KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
        if (pScript)
        {
            Npc[m_nIndex].m_ActionScriptID = dwScriptId;
            Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

            Lua_PushNumber(pScript->m_LuaState, m_dwID);
            pScript->SetGlobalName(SCRIPT_PLAYERID);

            Lua_PushNumber(pScript->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
            pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

            pScript->SafeCallBegin(&nTopIndex);
            if (pScript->CallFunction(szFunName, 0, "dd", nParam1, nParam2))
            {
                bExecuteScriptMistake = false;
            }
            pScript->SafeCallEnd(nTopIndex);
        }

        if (bExecuteScriptMistake)
        {
            m_bWaitingPlayerFeedBack = false;
            m_btTryExecuteScriptTimes = 0;
            Npc[m_nIndex].m_ActionScriptID = 0;
            return FALSE;
        }

        return TRUE;
    }
    catch(...)
    {
        printf("Exception Have Caught When Execute Script[%u]!!!!!\n", dwScriptId);
        m_bWaitingPlayerFeedBack = false;
        m_btTryExecuteScriptTimes = 0;
        Npc[m_nIndex].m_ActionScriptID = 0;
        return FALSE;
    }
    return TRUE;
}

BOOL	KPlayer::ExecuteScript2(char * ScriptFileName, char * szFunName, int nParam1, int nParam2)
{
    if (!ScriptFileName || !ScriptFileName[0] || !szFunName  || !szFunName[0]) return FALSE;
    return ExecuteScript2(g_FileName2Id(ScriptFileName), szFunName, nParam1, nParam2);
}

BOOL	KPlayer::ExecuteScript2(char * ScriptFileName, char * szFunName, char *  szParams1, char *  szParams2)
{
    if (!ScriptFileName || !ScriptFileName[0] || !szFunName  || !szFunName[0])
        return FALSE;
    DWORD dwScriptId = g_FileName2Id(ScriptFileName);
    return ExecuteScript2(dwScriptId, szFunName, szParams1, szParams2);
}

//end code

BOOL	KPlayer::DoScript(char * ScriptCommand)
{
    if (NULL == ScriptCommand) return FALSE;
    KLuaScript *Script = new KLuaScript;
    Script->Init();
    Script->RegisterFunctions(GameScriptFuns, g_GetGameScriptFunNum());
    //GM Standand Script Functions
    Script->Load(GM_SCRIPT);


    Lua_PushNumber(Script->m_LuaState, m_nPlayerIndex);
    Script->SetGlobalName(SCRIPT_PLAYERINDEX);
    Lua_PushNumber(Script->m_LuaState, m_dwID);
    Script->SetGlobalName(SCRIPT_PLAYERID);

    Lua_PushNumber(Script->m_LuaState, Npc[m_nIndex].m_SubWorldIndex);
    Script->SetGlobalName(SCRIPT_SUBWORLDINDEX);

    if (Script->LoadBuffer((PBYTE)ScriptCommand, strlen(ScriptCommand)))
    {
        BOOL bResult = Script->ExecuteCode();
        delete Script; //Question!
        return bResult;
    }
    delete Script; //Question!
    return FALSE;
}

#include "PhongThanPlayerDialog.inl"
#include "PhongThanStarterBag.inl"

//�������˻�֪���ѡ����ĳ��󣬴���~~


#ifndef _SERVER
//����ڽ��潻����ѡ����ĳ�����������˷���

#endif

// ��õ�ǰ��������
void	KPlayer::GetProfessionKey(char *lpszName)
{
    this->m_cProfession.GetName(lpszName);
}

void	KPlayer::GetProfessionName(char *lpszName)
{
    this->m_cProfession.GetName(lpszName);
}

int	KPlayer::GetProfessionCamp()
{
    return this->m_cProfession.GetCamp();
}

// ��õ�ǰ��������
int	KPlayer::GetProfession()
{
    return this->m_cProfession.GetProfession();
}

#ifdef _SERVER

#endif

#ifndef _SERVER
void	KPlayer::OnScriptAction(KPhongThanScriptAction * pMsg)
{
    KPhongThanScriptAction * pScriptAction = (KPhongThanScriptAction *)pMsg;
    if (!pScriptAction || pScriptAction->ContentLength < 0 ||
        pScriptAction->ContentLength >= MAX_SCIRPTACTION_BUFFERNUM ||
        pScriptAction->OptionCount > MAX_ANSWERNUM)
        return;
    g_DebugLog("[PhongThanUI] client OnScriptAction op=%d view=%d map=%u token=%u options=%d content=%d server=%d",
        pScriptAction->Operation, pScriptAction->View, pScriptAction->MapId,
        pScriptAction->DialogToken, pScriptAction->OptionCount,
        pScriptAction->ContentLength, pScriptAction->ServerOwned);
    if (pScriptAction->ServerOwned)
    {
        if (pScriptAction->Operation == PHONGTHAN_SCRIPT_CLOSE)
            m_UiDialogToken = 0;
        else if (pScriptAction->Operation == PHONGTHAN_SCRIPT_SHOW &&
            (pScriptAction->View == UI_SELECTDIALOG || pScriptAction->View == UI_TALKDIALOG || pScriptAction->View == UI_NUMBER_INPUT))
        {
            m_UiDialogToken = pScriptAction->DialogToken;
            m_UiDialogView = PhongThanEncodeScriptView(pScriptAction->View);
        }
    }
    char szString[5140];

    switch(pScriptAction->Operation)
    {
        case PHONGTHAN_SCRIPT_SHOW:
        {
            switch(pScriptAction->View)
            {
                case UI_NUMBER_INPUT:
                    CoreDataChanged(GDCNI_INPUT, pScriptAction->NumberArgument, (int)pScriptAction->Content);
                    break;
                case UI_SELECTDIALOG://֪ͨ�ͻ�����ʾѡ�񴰿�
                {
                    KUiQuestionAndAnswer	*pQuest = NULL;
                    KUiImage                *pImage = NULL;
                    if (pScriptAction->ContentLength <= 0) break;
                    if (pScriptAction->ResourceText != 0 &&
                        pScriptAction->ContentLength < (int)sizeof(int)) break;

                    size_t nQuestSize = sizeof(KUiQuestionAndAnswer);
                    if (pScriptAction->OptionCount > 0)
                        nQuestSize += sizeof(KUiAnswer) * (pScriptAction->OptionCount - 1);

                    pQuest = (KUiQuestionAndAnswer *)malloc(nQuestSize);
                    pImage = (KUiImage *)malloc(sizeof(KUiImage));
                    if (!pQuest || !pImage)
                    {
                        if (pImage) free(pImage);
                        if (pQuest) free(pQuest);
                        break;
                    }
                    memset(pQuest, 0, nQuestSize);
                    memset(pImage, 0, sizeof(KUiImage));

                    char strContent[MAX_QUESTION_LENGTH];
                    char * pAnswer = NULL;
                    pQuest->LeftTime = pScriptAction->NumberArgument;
                    pQuest->AnswerCount = 0;
                    //����ϢΪ�ַ���
                    if (pScriptAction->ResourceText == 0)
                    {
                        int nCopyLen = pScriptAction->ContentLength;
                        if (nCopyLen >= sizeof(strContent))
                            nCopyLen = sizeof(strContent) - 1;
                        memcpy(strContent, pScriptAction->Content, nCopyLen);
                        strContent[nCopyLen] = 0;
                        pAnswer = strstr(strContent, "|");
                        if (!pAnswer)
                        {
                            pScriptAction->OptionCount = 0;
                            pQuest->AnswerCount = 0;
                        }
                        else
                            *pAnswer++ = 0;

                        g_StrCpyLen(pQuest->Question, strContent, sizeof(pQuest->Question));
                        if (m_nLastNpcIndex)
                            TReplaceText(pQuest->Question, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                        TReplaceText(pQuest->Question, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                        TReplaceText(pQuest->Question, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                        pQuest->QuestionLen = TEncodeText(pQuest->Question, strlen(pQuest->Question));
                    }
                        //����ϢΪ���ֱ�ʶ
                    else
                    {
                        g_StrCpyLen(pQuest->Question, g_GetStringRes(*(int *)pScriptAction->Content, szString, sizeof(szString)), sizeof(pQuest->Question));

                        if (m_nLastNpcIndex)
                            TReplaceText(pQuest->Question, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                        TReplaceText(pQuest->Question, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                        TReplaceText(pQuest->Question, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");

                        pQuest->QuestionLen = TEncodeText(pQuest->Question, strlen(pQuest->Question));

                        int nOptionBytes = pScriptAction->ContentLength - sizeof(int);
                        if (nOptionBytes >= (int)sizeof(strContent))
                            nOptionBytes = sizeof(strContent) - 1;
                        if (nOptionBytes > 0)
                            memcpy(strContent, pScriptAction->Content + sizeof(int), nOptionBytes);
                        strContent[nOptionBytes] = 0;
                        pAnswer = strContent;
                        if (*pAnswer == '|')
                            pAnswer++;
                    }

                    for (int i = 0; pAnswer && i < pScriptAction->OptionCount; i ++)
                    {
                        char * pNewAnswer = strstr(pAnswer, "|");

                        if (pNewAnswer)
                        {
                            *pNewAnswer = 0;
                            g_StrCpyLen(pQuest->Answer[i].AnswerText, pAnswer, sizeof(pQuest->Answer[i].AnswerText));
                            pQuest->Answer[i].AnswerLen = -1;
                            pQuest->AnswerCount = i + 1;
                            pAnswer = pNewAnswer + 1;
                        }
                        else
                        {
                            g_StrCpyLen(pQuest->Answer[i].AnswerText, pAnswer, sizeof(pQuest->Answer[i].AnswerText));
                            pQuest->Answer[i].AnswerLen = -1;
                            pQuest->AnswerCount = i + 1;
                            break;
                        }
                    }

                    g_bUISelIntelActiveWithServer = pScriptAction->ServerOwned;
                    g_bUISelLastSelCount = pQuest->AnswerCount;

                    memset(pImage->Name, 0, sizeof(pImage->Name));
                    if (pScriptAction->BooleanArgument)
                        Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].KeyToImage(pScriptAction->Key, pScriptAction->AuxiliaryArgument, pImage);

                    if (pImage->Name[0])
                        CoreDataChanged(GDCNI_QUESTION_CHOOSE,(unsigned int) pQuest, (int) pImage);
                    else
                        CoreDataChanged(GDCNI_QUESTION_CHOOSE,(unsigned int) pQuest, NULL);

                    free(pImage);
                    pImage = NULL;
                    free(pQuest);
                    pQuest = NULL;
                }
                    break;
                case UI_TALKDIALOG:
                {
                    BOOL bUsingSpeakId = pScriptAction->ResourceText;
                    int	 nSentenceCount = pScriptAction->OptionCount;
                    if (nSentenceCount <= 0) return ;
                    KUiInformationParam *pSpeakList  = new KUiInformationParam[nSentenceCount];
                    memset(pSpeakList, 0, sizeof(KUiInformationParam) * nSentenceCount);

                    char * pAnswer = new char [pScriptAction->ContentLength + 1];
                    char * pBackupAnswer = pAnswer;
                    g_StrCpyLen(pAnswer, pScriptAction->Content, pScriptAction->ContentLength + 1);

                    int nCount = 0;
                    for (int i = 0; pAnswer && i < pScriptAction->OptionCount; i ++)
                    {
                        char * pNewAnswer = strstr(pAnswer, "|");

                        if (pNewAnswer)
                        {
                            *pNewAnswer = 0;
                            if (!bUsingSpeakId)
                            {
                                g_StrCpyLen(pSpeakList[i].sInformation, pAnswer, sizeof(pSpeakList[i].sInformation));
                                if (m_nLastNpcIndex)
                                    TReplaceText(pSpeakList[i].sInformation, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                            }
                            else
                            {
                                g_StrCpyLen(pSpeakList[i].sInformation, g_GetStringRes(atoi(pAnswer), szString, sizeof(szString)), sizeof(pSpeakList[i].sInformation));
                                if (m_nLastNpcIndex)
                                    TReplaceText(pSpeakList[i].sInformation, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                            }

                            if (i >= (pScriptAction->OptionCount - 1))
                            {
                                if (pScriptAction->NumberArgument == 1)
                                    pSpeakList[i].bNeedConfirmNotify = TRUE;
                            }

                            pSpeakList[i].nInforLen = TEncodeText(pSpeakList[i].sInformation, strlen(pSpeakList[i].sInformation));
                            pAnswer = pNewAnswer + 1;
                        }
                        else
                        {
                            if (!bUsingSpeakId)
                            {
                                g_StrCpyLen(pSpeakList[i].sInformation, pAnswer, sizeof(pSpeakList[i].sInformation));
                                if (m_nLastNpcIndex)
                                    TReplaceText(pSpeakList[i].sInformation, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                            }
                            else
                            {
                                g_StrCpyLen(pSpeakList[i].sInformation, g_GetStringRes(atoi(pAnswer), szString ,sizeof(szString)), sizeof(pSpeakList[i].sInformation));
                                if (m_nLastNpcIndex)
                                    TReplaceText(pSpeakList[i].sInformation, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                                TReplaceText(pSpeakList[i].sInformation, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                            }

                            if (pScriptAction->NumberArgument == 1)
                                pSpeakList[i].bNeedConfirmNotify = TRUE;

                            pSpeakList[i].nInforLen = TEncodeText(pSpeakList[i].sInformation, strlen(pSpeakList[i].sInformation));
                            nCount++;
                            break;
                        }
                        nCount ++;
                    }
                    if (pBackupAnswer)
                    {
                        delete []pBackupAnswer;
                        pBackupAnswer = NULL;
                    }
                    g_bUISpeakActiveWithServer = pScriptAction->ServerOwned;
                    if (pScriptAction->BooleanArgument)
                    {
                        CoreDataChanged(GDCNI_INFORMATION,(unsigned int)pSpeakList, MAKELONG(pScriptAction->OptionCount, pScriptAction->AuxiliaryArgument));
                    }
                    else
                        CoreDataChanged(GDCNI_SPEAK_WORDS,(unsigned int)pSpeakList, nCount);
                    if (pSpeakList)
                    {
                        delete []pSpeakList;
                        pSpeakList = NULL;
                    }
                }
                    break;
                case UI_NOTEINFO:
                {
                    if (pScriptAction->ContentLength <= 0)
                        break;

                    char * pAnswer = new char [pScriptAction->ContentLength + 1];
                    g_StrCpyLen(pAnswer, pScriptAction->Content, pScriptAction->ContentLength + 1);
                    KMissionRecord Record;

                    char * pNewAnswer = strstr(pAnswer, "|");

                    if (pNewAnswer)
                    {
                        Record.nRecordAct = pScriptAction->NumberArgument;
                        *pNewAnswer = 0;
                        strcpy(Record.szHeader, pAnswer);
                        Record.nHeaderLen= strlen(Record.szHeader);
                        pAnswer = pNewAnswer + 1;

                        if (pScriptAction->ResourceText == 0)
                        {
                            strcpy(Record.szContent, pAnswer);
                            Record.uValue = *(unsigned int*) (pAnswer + pScriptAction->ContentLength -Record.nHeaderLen - sizeof(int));
                        }
                        else
                        {
                            g_GetStringRes(atoi(pAnswer), Record.szContent ,sizeof(Record.szContent));
                            Record.uValue = *(unsigned int* ) (Record.szContent + sizeof(int));
                        }
                        if (m_nLastNpcIndex)
                            TReplaceText(Record.szContent, NPCNAME_KEY, Npc[m_nLastNpcIndex].Name);

                        TReplaceText(Record.szContent, PLAYERNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
                        TReplaceText(Record.szContent, SEXNAME_KEY, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nSex? "C� n��ng":"Thi�u hi�p");
                        Record.nContentLen = strlen(Record.szContent);
                        CoreDataChanged(pScriptAction->BooleanArgument?GDCNI_MISSION_NOTE:GDCNI_MISSION_RECORD, (unsigned long)&Record, 0);
                    }
                }
                    break;
                case UI_MSGINFO:
                {
                    if (pScriptAction->ContentLength <= 0)
                        break;

                    char strContent[1024];
                    //����ϢΪ�ַ���
                    if (pScriptAction->ResourceText == 0)
                    {
                        int nCopyLen = pScriptAction->ContentLength;
                        if (nCopyLen >= sizeof(strContent))
                            nCopyLen = sizeof(strContent) - 1;
                        memcpy(strContent, pScriptAction->Content, nCopyLen);
                        strContent[nCopyLen] = 0;
                    }
                    else
                    {
                        g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                    }

                    KSystemMessage	sMsg;
                    sMsg.eType = pScriptAction->NumberArgument;
                    sMsg.byConfirmType = pScriptAction->AuxiliaryArgument;
                    sMsg.byPriority = 0;
                    sMsg.byParamSize = 0;
                    g_StrCpyLen(sMsg.szMessage, strContent, sizeof(sMsg.szMessage));
                    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
                }break;

                case UI_NEWSINFO:
                {
                    if (pScriptAction->ContentLength <= 0)
                        break;
                    switch(pScriptAction->OptionCount) //OPtionNum��������һ��News����
                    {
                        case NEWSMESSAGE_NORMAL:
                        {

                            KNewsMessage News;
                            News.nType = NEWSMESSAGE_NORMAL;

                            char strContent[1024];
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                int nCopyLen = pScriptAction->ContentLength;
                        if (nCopyLen >= sizeof(strContent))
                            nCopyLen = sizeof(strContent) - 1;
                        memcpy(strContent, pScriptAction->Content, nCopyLen);
                        strContent[nCopyLen] = 0;
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));

                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;

                            memset(&systime, 0, sizeof(SYSTEMTIME));
                            systime.wSecond = *(int *)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(int)));

                            CoreDataChanged(GDCNI_NEWS_MESSAGE, (unsigned int)&News, (unsigned int)&systime);
                        }
                            break;
                            //STRING|STRINGID + TIME(INT)
                        case NEWSMESSAGE_COUNTING:
                        {
                            KNewsMessage News;
                            News.nType = pScriptAction->OptionCount;

                            char strContent[1024];
                            int nTime = 0;
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                g_StrCpyLen(strContent, pScriptAction->Content,  pScriptAction->ContentLength - sizeof(int) + 1);
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));
                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;

                            memset(&systime, 0, sizeof(SYSTEMTIME));
                            systime.wSecond = *(int *)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(int)));

                            CoreDataChanged(GDCNI_NEWS_MESSAGE, (unsigned int)&News, (unsigned int)&systime);

                        }break;

                        case NEWSMESSAGE_TIMEEND:
                        {
                            KNewsMessage News;
                            News.nType = pScriptAction->OptionCount;

                            char strContent[1024];
                            int nTime = 0;
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                g_StrCpyLen(strContent, pScriptAction->Content,  pScriptAction->ContentLength - sizeof(SYSTEMTIME) + 1);
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));
                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;
                            systime = *(SYSTEMTIME*)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(SYSTEMTIME)));
                            CoreDataChanged(GDCNI_NEWS_MESSAGE, (unsigned int)&News, (unsigned int)&systime);

                        }break;

                    }

                }break;
                case UI_NEWSINFO1:
                {
                    if (pScriptAction->ContentLength <= 0)
                        break;
                    switch(pScriptAction->OptionCount) //OPtionNum��������һ��News����
                    {
                        case NEWSMESSAGE_NORMAL:
                        {

                            KNewsMessage News;
                            News.nType = NEWSMESSAGE_NORMAL;

                            char strContent[1024];
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                int nCopyLen = pScriptAction->ContentLength;
                        if (nCopyLen >= sizeof(strContent))
                            nCopyLen = sizeof(strContent) - 1;
                        memcpy(strContent, pScriptAction->Content, nCopyLen);
                        strContent[nCopyLen] = 0;
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));

                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;

                            memset(&systime, 0, sizeof(SYSTEMTIME));
                            systime.wSecond = *(int *)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(int)));

                            CoreDataChanged(GDCNI_NEWS_MESSAGE2, (unsigned int)&News, (unsigned int)&systime);
                        }
                            break;
                            //STRING|STRINGID + TIME(INT)
                        case NEWSMESSAGE_COUNTING:
                        {
                            KNewsMessage News;
                            News.nType = pScriptAction->OptionCount;

                            char strContent[1024];
                            int nTime = 0;
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                g_StrCpyLen(strContent, pScriptAction->Content,  pScriptAction->ContentLength - sizeof(int) + 1);
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));
                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;

                            memset(&systime, 0, sizeof(SYSTEMTIME));
                            systime.wSecond = *(int *)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(int)));

                            CoreDataChanged(GDCNI_NEWS_MESSAGE2, (unsigned int)&News, (unsigned int)&systime);

                        }break;

                        case NEWSMESSAGE_TIMEEND:
                        {
                            KNewsMessage News;
                            News.nType = pScriptAction->OptionCount;

                            char strContent[1024];
                            int nTime = 0;
                            //����ϢΪ�ַ���
                            if (pScriptAction->ResourceText == 0)
                            {
                                g_StrCpyLen(strContent, pScriptAction->Content,  pScriptAction->ContentLength - sizeof(SYSTEMTIME) + 1);
                            }
                            else
                            {
                                g_GetStringRes(*(int *)pScriptAction->Content, strContent ,sizeof(strContent));
                            }

                            g_StrCpyLen(News.sMsg,  strContent, sizeof(News.sMsg));
                            News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                            SYSTEMTIME systime;
                            systime = *(SYSTEMTIME*)((pScriptAction->Content + pScriptAction->ContentLength - sizeof(SYSTEMTIME)));
                            CoreDataChanged(GDCNI_NEWS_MESSAGE2, (unsigned int)&News, (unsigned int)&systime);

                        }break;
                    }

                }break;
                case UI_TOPMESSAGE:
                case UI_SCROLLMESSAGE:
                {
                    if (pScriptAction->ContentLength <= 0)
                        break;

                    char strContent[1024];
                    if (pScriptAction->ResourceText == 0)
                    {
                        int nCopyLen = pScriptAction->ContentLength;
                        if (nCopyLen >= sizeof(strContent))
                            nCopyLen = sizeof(strContent) - 1;
                        memcpy(strContent, pScriptAction->Content, nCopyLen);
                        strContent[nCopyLen] = 0;
                    }
                    else if (pScriptAction->ContentLength >= (int)sizeof(int))
                    {
                        g_GetStringRes(*(int *)pScriptAction->Content,
                            strContent, sizeof(strContent));
                    }
                    else
                    {
                        break;
                    }

                    if (pScriptAction->View == UI_TOPMESSAGE)
                    {
                        CoreDataChanged(GDCNI_TOP_MESSAGE,
                            (unsigned int)strContent, strlen(strContent));
                    }
                    else
                    {
                        KNewsMessage News;
                        memset(&News, 0, sizeof(News));
                        News.nType = NEWSMESSAGE_NORMAL;
                        g_StrCpyLen(News.sMsg, strContent, sizeof(News.sMsg));
                        News.nMsgLen = TEncodeText(News.sMsg, strlen(News.sMsg));
                        SYSTEMTIME systime;
                        memset(&systime, 0, sizeof(systime));
                        CoreDataChanged(GDCNI_NEWS_MESSAGE,
                            (unsigned int)&News, (unsigned int)&systime);
                    }
                }
                    break;
                case UI_PLAYMUSIC:
                {
                    char szMusicFile[MAX_PATH];
                    if (pScriptAction->ContentLength < 0 || pScriptAction->ContentLength >= sizeof(szMusicFile)) break;
                    memcpy(szMusicFile, pScriptAction->Content, pScriptAction->ContentLength);
                    szMusicFile[pScriptAction->ContentLength] = 0;
                    g_SubWorldSet.m_cMusic.ScriptPlay(szMusicFile);
                }break;

                case UI_OPENTONGUI:
                {
                    Player[CLIENT_PLAYER_INDEX].m_cTong.OpenCreateInterface();
                    break;
                }
            }
        } break;
        case PHONGTHAN_SCRIPT_CLOSE:
        {
            g_bUISelIntelActiveWithServer = FALSE;
            g_bUISpeakActiveWithServer = FALSE;
            g_bUISelLastSelCount = 0;
            CoreDataChanged(GDCNI_CLOSE_DIALOG, 0, 0);
        }
            break;
        case PHONGTHAN_SCRIPT_EXECUTE://Ҫ��ͻ��˵���ĳ���ű�
        {
            if (pScriptAction->ContentLength <= 0 ) break;
            char szScriptInfo[1000];
            g_StrCpyLen(szScriptInfo, pScriptAction->Content, sizeof(szScriptInfo));
            char * pDivPos = strchr(szScriptInfo, '|');
            if (pDivPos)	*pDivPos++ = 0;
            if (pDivPos)
                ExecuteScript(szScriptInfo, "OnCall", pDivPos);
            else
                ExecuteScript(szScriptInfo, "OnCall", "");
        }
            break;
    }


}
#endif

#ifdef _SERVER
//�ͻ���������ĳ��Npc�Ի�
//�������汾
void	KPlayer::DialogNpc(BYTE * pProtocol)
{
	//if (m_nAvailableAnswerNum > 0) return ;
const PHONGTHAN_ENTITY_REFERENCE* pDialogNpc = (const PHONGTHAN_ENTITY_REFERENCE*)pProtocol;
	if (!pDialogNpc->EntityId || m_nIndex <= 0 || m_nIndex >= MAX_NPC || Npc[m_nIndex].m_CurrentLife <= 0) return;
	int nIdx = FindAroundNpc(pDialogNpc->EntityId);
	if (nIdx > 0)
	{
		m_nLastNpcIndex = nIdx;
		int distance = NpcSet.GetDistance(nIdx, m_nIndex);
		// С�ڶԻ��뾶�Ϳ�ʼ�Ի�
		if ((Npc[nIdx].m_Kind == kind_dialoger) ||
			(NpcSet.GetRelation(m_nIndex, nIdx) == relation_none))
		{
			if (distance <= Npc[nIdx].m_DialogRadius * 2)	// �Ŵ�server�Ի��뾶
			{
				if (Npc[nIdx].ActionScript[0])
				{
					ExecuteScript(Npc[nIdx].m_ActionScriptID, NORMAL_FUNCTION_NAME, nIdx);
				}
			}
		}
	}
}
#endif

#ifndef _SERVER
void	KPlayer::s2cTradeChangeState(BYTE* pMsg)
{
    TRADE_CHANGE_STATE_SYNC	*pTrade = (TRADE_CHANGE_STATE_SYNC*)pMsg;


    switch (m_cMenuState.m_nState)
    {
        case PLAYER_MENU_STATE_NORMAL:		// ��ǰ�ͻ��� NORMAL
        case PLAYER_MENU_STATE_TRADEOPEN:	// ��ǰ�ͻ��� TRADEOPEN
            if (pTrade->m_btState == 0)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_NORMAL);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 1)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_TRADEOPEN);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 2)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_TRADING);
                m_cTrade.StartTrade(pTrade->m_dwNpcID);
                m_ItemList.StartTrade();

                // ֪ͨ������뽻�׽���
                KUiPlayerItem	sTradePlayer;
                int	nIdx;

                nIdx = NpcSet.SearchID(pTrade->m_dwNpcID);
                if (nIdx > 0)
                    strcpy(sTradePlayer.Name, Npc[nIdx].Name);
                else
                    sTradePlayer.Name[0] = 0;
                sTradePlayer.nIndex = 0;
                sTradePlayer.uId = 0;
                sTradePlayer.nData = 0;
                CoreDataChanged(GDCNI_TRADE_START, (unsigned int)(&sTradePlayer), pTrade->m_bFolkGame);

                if (Npc[m_nIndex].m_Doing == do_sit)
                {
                    Npc[m_nIndex].SendCommand(do_stand);
                }
            }
            break;
        case PLAYER_MENU_STATE_TEAMOPEN:	// ��ǰ�ͻ��� TEAMOPEN
            g_Team[0].SetTeamClose();
            if (pTrade->m_btState == 0)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_NORMAL);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 1)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_TRADEOPEN);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 2)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_TRADING);
                m_cTrade.StartTrade(pTrade->m_dwNpcID, pTrade->m_bFolkGame);
                m_ItemList.StartTrade();

                // ֪ͨ������뽻�׽���
                KUiPlayerItem	sTradePlayer;
                int	nIdx;

                nIdx = NpcSet.SearchID(pTrade->m_dwNpcID);
                if (nIdx > 0)
                    strcpy(sTradePlayer.Name, Npc[nIdx].Name);
                else
                    sTradePlayer.Name[0] = 0;
                sTradePlayer.Name[0] = 0;
                sTradePlayer.nIndex = 0;
                sTradePlayer.uId = 0;
                sTradePlayer.nData = 0;
                CoreDataChanged(GDCNI_TRADE_START, (unsigned int)(&sTradePlayer), pTrade->m_bFolkGame);

                if (Npc[m_nIndex].m_Doing == do_sit)
                {
                    Npc[m_nIndex].SendCommand(do_stand);
                }
            }
            break;
        case PLAYER_MENU_STATE_TRADING:		// ��ǰ�ͻ��� TRADING
            // ���ͻ��˴��� TRADING ʱ����Ӧ���յ���Э��
            if (pTrade->m_btState == 0)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_NORMAL);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 1)
            {
                m_cMenuState.SetState(PLAYER_MENU_STATE_TRADEOPEN);
                CoreDataChanged(GDCNI_TRADE_OPER_DATA, 0, 0);
            }
            else if (pTrade->m_btState == 2)	// �ͻ��˴�ʱ��Ӧ�������״̬���ͻ����ѳ���
            {
                m_cMenuState.m_nState = PLAYER_MENU_STATE_TRADING;
                m_cMenuState.m_nTradeDest = pTrade->m_dwNpcID;
                m_cMenuState.m_nTradeState = 0;
                m_cMenuState.m_nTradeDestState = 0;
                this->m_ItemList.RecoverTrade();
                this->m_ItemList.BackupTrade();
                this->m_ItemList.ClearRoom(room_trade);
                this->m_ItemList.ClearRoom(room_trade1);

                // ֪ͨ������뽻�׽���
                KUiPlayerItem	sTradePlayer;
                int	nIdx;

                nIdx = NpcSet.SearchID(pTrade->m_dwNpcID);
                if (nIdx > 0)
                    strcpy(sTradePlayer.Name, Npc[nIdx].Name);
                else
                    sTradePlayer.Name[0] = 0;
                sTradePlayer.Name[0] = 0;
                sTradePlayer.nIndex = 0;
                sTradePlayer.uId = 0;
                sTradePlayer.nData = 0;
                CoreDataChanged(GDCNI_TRADE_START, (unsigned int)(&sTradePlayer), 0);

                if (Npc[m_nIndex].m_Doing == do_sit)
                {
                    Npc[m_nIndex].SendCommand(do_stand);
                }
            }
            break;
    }
}
#endif

#ifndef _SERVER
void	KPlayer::s2cLevelUp(BYTE* pMsg)
{
    const PHONGTHAN_LEVEL_EVENT* pLevel = (const PHONGTHAN_LEVEL_EVENT*)pMsg;

    if ((DWORD)Npc[m_nIndex].m_Level < (DWORD)pLevel->Level &&
        m_nExp < PlayerSet.m_cLevelAdd.GetLevelExp(Npc[m_nIndex].m_Level, Npc[m_nIndex].m_byTranslife) &&
        !pLevel->ResetAttributes)
    {
        KSystemMessage	sMsg;
        sprintf(sMsg.szMessage, MSG_GET_EXP, PlayerSet.m_cLevelAdd.GetLevelExp(Npc[m_nIndex].m_Level, Npc[m_nIndex].m_byTranslife) - m_nExp);
        sMsg.eType = SMT_NORMAL;
        sMsg.byConfirmType = SMCT_NONE;
        sMsg.byPriority = 0;
        sMsg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
    }

    m_nExp = 0;
    Npc[m_nIndex].m_Level = (DWORD)pLevel->Level;
    m_nNextLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(Npc[m_nIndex].m_Level, Npc[m_nIndex].m_byTranslife);

    if(pLevel->ResetAttributes)
    {
        char cBaseFile[80];
        sprintf(cBaseFile, NEW_PLAYER_INI_FILE_NAME, Npc[m_nIndex].m_Series * 2 + Npc[m_nIndex].m_nSex);

        KIniFile BaseAttrib;
        if(!BaseAttrib.Load(cBaseFile)) return;

        int nBaseStr, nBaseDex, nBaseVit, nBaseEn;
        BaseAttrib.GetInteger("ROLE", "ipower", 0, &nBaseStr);
        BaseAttrib.GetInteger("ROLE", "iagility", 0, &nBaseDex);
        BaseAttrib.GetInteger("ROLE", "iouter", 0, &nBaseVit);
        BaseAttrib.GetInteger("ROLE", "iinside", 0, &nBaseEn);

        m_nStrength = nBaseStr;
        m_nDexterity = nBaseDex;
        m_nVitality = nBaseVit;
        m_nEngergy = nBaseEn;
        m_nCurStrength = m_nStrength;
        m_nCurDexterity = m_nDexterity;
        m_nCurVitality = m_nVitality;
        m_nCurEngergy = m_nEngergy;

        SetDefaultImmedSkill();
    }

    // -------------------------- �ȼ�����ʱ��������ͬ�� ----------------------
    // ͬ��δ�������Ե�
    if (pLevel->AttributePoints > m_nAttributePoint)
    {
        KSystemMessage Msg;
        sprintf(Msg.szMessage, MSG_GET_ATTRIBUTE_POINT, pLevel->AttributePoints - m_nAttributePoint);
        Msg.eType = SMT_PLAYER;
        Msg.byConfirmType = SMCT_UI_ATTRIBUTE;
        Msg.byPriority = 3;
        Msg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&Msg, NULL);
    }
    m_nAttributePoint = pLevel->AttributePoints;

    // ͬ��δ���似�ܵ�
    if (m_nSkillPoint < pLevel->SkillPoints)
    {
        KSystemMessage Msg;
        sprintf(Msg.szMessage, MSG_GET_SKILL_POINT, pLevel->SkillPoints - m_nSkillPoint);
        Msg.eType = SMT_PLAYER;
        Msg.byConfirmType = SMCT_UI_SKILLS;
        Msg.byPriority = 3;
        Msg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&Msg, NULL);
    }
    m_nSkillPoint = pLevel->SkillPoints;

    // ��������������������ֵ��Ӱ������������������������ֵ�����أ��ȼ������Ե㣬Ӱ�쵱ǰ�������ֵ�����أ�װ�������ܡ�ҩ���ʱ����
    Npc[m_nIndex].m_LifeMax = pLevel->BaseMaxLife;
    Npc[m_nIndex].m_StaminaMax = pLevel->BaseMaxStamina;
    Npc[m_nIndex].m_ManaMax = pLevel->BaseMaxMana;
    //	Npc[m_nIndex].ResetLifeReplenish();
    Npc[m_nIndex].m_CurrentLifeMax = Npc[m_nIndex].m_LifeMax;
    Npc[m_nIndex].m_CurrentStaminaMax = Npc[m_nIndex].m_StaminaMax;
    Npc[m_nIndex].m_CurrentManaMax = Npc[m_nIndex].m_ManaMax;

    // �������ֿ��Եı仯 �𡢱��������硢����
    Npc[m_nIndex].m_FireResist				= PlayerSet.m_cLevelAdd.GetFireResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentFireResist		= Npc[m_nIndex].m_FireResist;
    Npc[m_nIndex].m_ColdResist				= PlayerSet.m_cLevelAdd.GetColdResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentColdResist		= Npc[m_nIndex].m_ColdResist;
    Npc[m_nIndex].m_PoisonResist			= PlayerSet.m_cLevelAdd.GetPoisonResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentPoisonResist		= Npc[m_nIndex].m_PoisonResist;
    Npc[m_nIndex].m_LightResist				= PlayerSet.m_cLevelAdd.GetLightResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentLightResist		= Npc[m_nIndex].m_LightResist;
    Npc[m_nIndex].m_EarthResist				= PlayerSet.m_cLevelAdd.GetEarthResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentEarthResist		= Npc[m_nIndex].m_EarthResist;
    Npc[m_nIndex].m_PhysicsResist			= PlayerSet.m_cLevelAdd.GetPhysicsResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_CurrentPhysicsResist	= Npc[m_nIndex].m_PhysicsResist;
    Npc[m_nIndex].m_FireResistMax			= BASE_FIRE_RESIST_MAX;
    Npc[m_nIndex].m_ColdResistMax			= BASE_COLD_RESIST_MAX;
    Npc[m_nIndex].m_PoisonResistMax			= BASE_POISON_RESIST_MAX;
    Npc[m_nIndex].m_LightResistMax			= BASE_LIGHT_RESIST_MAX;
    Npc[m_nIndex].m_EarthResistMax			= BASE_EARTH_RESIST_MAX;
    Npc[m_nIndex].m_PhysicsResistMax		= BASE_PHYSICS_RESIST_MAX;
    Npc[m_nIndex].m_CurrentFireResistMax	= Npc[m_nIndex].m_FireResistMax;
    Npc[m_nIndex].m_CurrentColdResistMax	= Npc[m_nIndex].m_ColdResistMax;
    Npc[m_nIndex].m_CurrentPoisonResistMax	= Npc[m_nIndex].m_PoisonResistMax;
    Npc[m_nIndex].m_CurrentLightResistMax	= Npc[m_nIndex].m_LightResistMax;
    Npc[m_nIndex].m_CurrentEarthResistMax	= Npc[m_nIndex].m_EarthResistMax;
    Npc[m_nIndex].m_CurrentPhysicsResistMax	= Npc[m_nIndex].m_PhysicsResistMax;

    int nOldCurCamp = Npc[m_nIndex].m_CurrentCamp;
    // ����װ����������Ϣ���µ�ǰ����
    this->UpdataCurData();
    SetNpcPhysicsDamage();
    Npc[m_nIndex].SetCurrentCamp(nOldCurCamp);

    // ����������������ֵ����
    Npc[m_nIndex].m_CurrentLife = Npc[m_nIndex].m_CurrentLifeMax;
    Npc[m_nIndex].m_CurrentStamina = Npc[m_nIndex].m_CurrentStaminaMax;
    Npc[m_nIndex].m_CurrentMana = Npc[m_nIndex].m_CurrentManaMax;

    // �ͻ��˶������Լ��ĵȼ���һ
    if (this->m_cTeam.m_nFlag)
    {
        if (m_cTeam.m_nFigure == TEAM_CAPTAIN)
        {
            g_Team[0].m_nMemLevel[0] = Npc[m_nIndex].m_Level;
        }
        else
        {
            for (int i = 0; i < MAX_TEAM_MEMBER; i++)
            {
                if ((DWORD)g_Team[0].m_nMember[i] == Npc[m_nIndex].m_dwID)
                {
                    g_Team[0].m_nMemLevel[i] = Npc[m_nIndex].m_Level;
                    break;
                }
            }
        }
    }

    KSystemMessage Msg;

    Msg.byConfirmType = SMCT_CLICK;
    Msg.byParamSize = 0;
    Msg.byPriority = 1;
    Msg.eType = SMT_PLAYER;
    sprintf(Msg.szMessage, MSG_LEVEL_UP, Npc[m_nIndex].m_Level);
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&Msg, NULL);

    Npc[this->m_nIndex].SetInstantSpr(enumINSTANT_STATE_LEVELUP);
    CoreDataChanged(GDCNI_PLAYER_RT_ATTRIBUTE, 0, 0);
    CoreDataChanged(GDCNI_FIGHT_SKILL_POINT, 0, Player[CLIENT_PLAYER_INDEX].m_nSkillPoint);
}
#endif

#ifndef _SERVER
void	KPlayer::s2cGetCurAttribute(BYTE* pMsg)
{
    const PHONGTHAN_ATTRIBUTE_UPDATE* pAttribute = (const PHONGTHAN_ATTRIBUTE_UPDATE*)pMsg;
    m_nAttributePoint = pAttribute->RemainingPoints;
    int nData;
    switch (PhongThanDecodeAttribute(pAttribute->Attribute))
    {
        case ATTRIBUTE_STRENGTH:
            nData = pAttribute->Base - m_nStrength;
            m_nStrength = pAttribute->Base;
            m_nCurStrength = pAttribute->Current;
            UpdataCurData();
            SetNpcPhysicsDamage();
            break;
        case ATTRIBUTE_DEXTERITY:
            nData = pAttribute->Base - m_nDexterity;
            m_nDexterity = pAttribute->Base;
            SetNpcAttackRating();
            SetNpcDefence();
            UpdataCurData();
            SetNpcPhysicsDamage();
            break;
        case ATTRIBUTE_VITALITY:
            nData = pAttribute->Base - m_nVitality;
            m_nVitality = pAttribute->Base;
            Npc[m_nIndex].AddBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * nData);
            Npc[m_nIndex].AddBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * nData);
            UpdataCurData();
            break;
        case ATTRIBUTE_ENGERGY:
            nData = pAttribute->Base - m_nEngergy;
            m_nEngergy = pAttribute->Base;
            Npc[m_nIndex].AddBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * nData);
            UpdataCurData();
            break;
        case ATTRIBUTE_RESET_ALL:
            char cBaseFile[80];
            sprintf(cBaseFile, NEW_PLAYER_INI_FILE_NAME, Npc[m_nIndex].m_Series * 2 + Npc[m_nIndex].m_nSex);

            KIniFile BaseAttrib;
            if(!BaseAttrib.Load(cBaseFile)) return;

            int nBaseStr, nBaseDex, nBaseVit, nBaseEn;
            BaseAttrib.GetInteger("ROLE", "ipower", 0, &nBaseStr);
            BaseAttrib.GetInteger("ROLE", "iagility", 0, &nBaseDex);
            BaseAttrib.GetInteger("ROLE", "iouter", 0, &nBaseVit);
            BaseAttrib.GetInteger("ROLE", "iinside", 0, &nBaseEn);

            int nStr = m_nStrength - nBaseStr;
            if(nStr < 0) nStr = 0;
            int nDex = m_nDexterity - nBaseDex;
            if(nDex < 0) nDex = 0;
            int nVit = m_nVitality - nBaseVit;
            if(nVit < 0) nVit = 0;
            int nEn = m_nEngergy - nBaseEn;
            if(nEn < 0) nEn = 0;

            m_nStrength = nBaseStr;
            m_nDexterity = nBaseDex;
            m_nVitality = nBaseVit;
            m_nEngergy = nBaseEn;
            m_nCurStrength = m_nStrength;
            m_nCurDexterity = m_nDexterity;
            m_nCurVitality = m_nVitality;
            m_nCurEngergy = m_nEngergy;

            SetNpcAttackRating();
            SetNpcDefence();
            Npc[m_nIndex].AddBaseLifeMax(PlayerSet.m_cLevelAdd.GetLifePerVitality(Npc[m_nIndex].m_Series) * (-nVit));
            Npc[m_nIndex].AddBaseStaminaMax(PlayerSet.m_cLevelAdd.GetStaminaPerVitality(Npc[m_nIndex].m_Series) * (-nVit));
            Npc[m_nIndex].AddBaseManaMax(PlayerSet.m_cLevelAdd.GetManaPerEnergy(Npc[m_nIndex].m_Series) * (-nEn));
            UpdataCurData();
            SetNpcPhysicsDamage();
            break;
    }
    CoreDataChanged(GDCNI_PLAYER_RT_ATTRIBUTE, 0, 0);
}
#endif

#ifndef _SERVER
void	KPlayer::s2cSetExp(int nExp)
{
    if (nExp > m_nExp)
    {
        KSystemMessage	sMsg;
        sprintf(sMsg.szMessage, MSG_GET_EXP, nExp - m_nExp);
        sMsg.eType = SMT_NORMAL;
        sMsg.byConfirmType = SMCT_NONE;
        sMsg.byPriority = 0;
        sMsg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
    }
    else if (nExp < m_nExp)
    {
        KSystemMessage	sMsg;
        sprintf(sMsg.szMessage, MSG_DEC_EXP, m_nExp - nExp);
        sMsg.eType = SMT_NORMAL;
        sMsg.byConfirmType = SMCT_NONE;
        sMsg.byPriority = 0;
        sMsg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
    }

    this->m_nExp = nExp;
}
#endif

#ifndef _SERVER
void	KPlayer::s2cSyncMoney(BYTE* pMsg)
{
    PLAYER_MONEY_SYNC	*pMoney = (PLAYER_MONEY_SYNC*)pMsg;

    if ( CheckTrading(true) )
    {
        if (pMoney->m_nMoney1 >= pMoney->m_nMoney3)
        {
            m_ItemList.SetMoney(pMoney->m_nMoney1 - pMoney->m_nMoney3, pMoney->m_nMoney2, pMoney->m_nMoney3);
        }
        else
        {
            m_ItemList.SetMoney(0, pMoney->m_nMoney2 + pMoney->m_nMoney1 - pMoney->m_nMoney3, pMoney->m_nMoney3);
        }
        m_cTrade.m_nTradeState = 0;
        m_cTrade.m_nTradeDestState = 0;
        m_cTrade.m_nBackEquipMoney = pMoney->m_nMoney1;
        m_cTrade.m_nBackRepositoryMoney = pMoney->m_nMoney2;
    }
    else
    {
        // ��Ǯһ���ǵ�room_equipment
        int nMoney1 = m_ItemList.GetMoney(room_equipment);
        //g_DebugLog("nMoney1: %d", nMoney1);
        if (pMoney->m_nMoney1 - nMoney1 > 0)
        {
            KSystemMessage	sMsg;
            sMsg.eType = SMT_NORMAL;
            sMsg.byConfirmType = SMCT_NONE;
            sMsg.byPriority = 0;
            sMsg.byParamSize = 0;
            sprintf(sMsg.szMessage, MSG_EARN_MONEY, pMoney->m_nMoney1 - nMoney1);
            CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
        }
        m_ItemList.SetMoney(pMoney->m_nMoney1, pMoney->m_nMoney2, pMoney->m_nMoney3);
    }
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ�������뽻��
//---------------------------------------------------------------------
void	KPlayer::s2cTradeApplyStart(BYTE* pMsg)
{
    if (!pMsg)
        return;
    TRADE_APPLY_START_SYNC	*pApply = (TRADE_APPLY_START_SYNC*)pMsg;
    int		nNpcIdx;
    nNpcIdx = NpcSet.SearchID(pApply->m_dwNpcId);
    if (nNpcIdx == 0)
        return;

    KSystemMessage	sMsg;
    KUiPlayerItem	sPlayer;

    strcpy(sPlayer.Name, Npc[nNpcIdx].Name);
    sPlayer.nIndex = pApply->m_nDestIdx;
    sPlayer.uId = pApply->m_dwNpcId;
    sPlayer.nData = 0;

    if (pApply->m_bFolkGame)
    {
        sprintf(sMsg.szMessage, MSG_TRADE_FOLKGAME_GET_APPLY, Npc[nNpcIdx].Name);
        sMsg.byConfirmType = SMCT_UI_TRADE_FOLKGAME;
    }
    else
    {
        sprintf(sMsg.szMessage, MSG_TRADE_GET_APPLY, Npc[nNpcIdx].Name);
        sMsg.byConfirmType = SMCT_UI_TRADE;
    }
    sMsg.eType = SMT_SYSTEM;
    sMsg.byPriority = 3;
    sMsg.byParamSize = sizeof(KUiPlayerItem);
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, (int)&sPlayer);
}
#endif

#ifndef _SERVER
void	KPlayer::s2cSparApplyStart(BYTE* pMsg)
{
    if (!pMsg)
        return;
    SPAR_APPLY_START_SYNC	*pApply = (SPAR_APPLY_START_SYNC*)pMsg;
    int		nNpcIdx;
    nNpcIdx = NpcSet.SearchID(pApply->m_dwNpcId);
    if (nNpcIdx == 0)
        return;

    KSystemMessage	sMsg;
    KUiPlayerItem	sPlayer;

    strcpy(sPlayer.Name, Npc[nNpcIdx].Name);
    sPlayer.nIndex = pApply->m_nDestIdx;
    sPlayer.uId = pApply->m_dwNpcId;
    sPlayer.nData = 0;

    sprintf(sMsg.szMessage, MSG_SPAR_GET_APPLY, Npc[nNpcIdx].Name);
    sMsg.eType = SMT_SYSTEM;
    sMsg.byConfirmType = SMCT_UI_SPAR;
    sMsg.byPriority = 3;
    sMsg.byParamSize = sizeof(KUiPlayerItem);
    CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, (int)&sPlayer);
}
#endif

#ifndef _SERVER
void	KPlayer::s2cTradeMoneySync(BYTE* pMsg)
{
    TRADE_MONEY_SYNC	*pMoney = (TRADE_MONEY_SYNC*)pMsg;

    m_ItemList.SetRoomMoney(room_trade1, pMoney->m_nMoney);

    // ֪ͨ����
    KUiObjAtRegion	sMoney;
    sMoney.Obj.uGenre = CGOG_MONEY;
    sMoney.Obj.uId = pMoney->m_nMoney;
    CoreDataChanged(GDCNI_TRADE_DESIRE_ITEM, (unsigned int)&sMoney, 0);
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ������ɻ�ȡ��
//---------------------------------------------------------------------
void	KPlayer::s2cTradeDecision(BYTE* pMsg)
{
    TRADE_DECISION_SYNC	*pSync = (TRADE_DECISION_SYNC*)pMsg;
    if (pSync->m_btDecision == 1)	// ��ɽ���
    {
        KSystemMessage	sMsg;
        sprintf(sMsg.szMessage, MSG_TRADE_SUCCESS, m_cTrade.m_szDestName);
        sMsg.eType = SMT_NORMAL;
        sMsg.byConfirmType = SMCT_NONE;
        sMsg.byPriority = 0;
        sMsg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

        // ����ItemList.Remove����� modify by spe 03/06/14
        //m_ItemList.ClearRoom(room_trade);
        m_ItemList.RemoveRoom(room_trade1);
        //m_ItemList.ClearRoom(room_trade1);
        m_ItemList.ClearRoom(room_tradeback);
        this->m_cTrade.Release();
        m_cMenuState.SetState(PLAYER_MENU_STATE_NORMAL);

        // ֪ͨ���潻�׽���
        CoreDataChanged(GDCNI_TRADE_END, 0, TRUE);

        m_ItemList.MenuSetMouseItem();
    }
    else if (pSync->m_btDecision == 0)	// ȡ������
    {
        if ( !CheckTrading() )
            return;

        KSystemMessage	sMsg;
        sprintf(sMsg.szMessage, MSG_TRADE_FAIL, m_cTrade.m_szDestName);
        sMsg.eType = SMT_NORMAL;
        sMsg.byConfirmType = SMCT_NONE;
        sMsg.byPriority = 0;
        sMsg.byParamSize = 0;
        CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

        // ȡ�����׵����ݻָ�
        m_ItemList.RecoverTrade();
        m_ItemList.SetMoney(m_cTrade.m_nBackEquipMoney, m_cTrade.m_nBackRepositoryMoney, 0);
        m_ItemList.ClearRoom(room_trade);
        m_ItemList.RemoveRoom(room_trade1);
        //		m_ItemList.ClearRoom(room_trade1);
        m_ItemList.ClearRoom(room_tradeback);
        m_cTrade.Release();
        m_cMenuState.SetState(PLAYER_MENU_STATE_NORMAL);

        // ֪ͨ���潻�׽���
        CoreDataChanged(GDCNI_TRADE_END, 0, 0);
        // ������Ʒ���
        CoreDataChanged(GDCNI_CONTAINER_OBJECT_CHANGED, UOC_ITEM_TAKE_WITH, 0);

        m_ItemList.MenuSetMouseItem();
    }
}
#endif

#ifndef _SERVER
void	KPlayer::SyncCurPlayer(BYTE* pMsg)
{
    dacheck = TRUE;



    //g_DebugLog("Chay vao day SyncCurPlayer");

    const PHONGTHAN_SELF_SNAPSHOT* PlaySync = (const PHONGTHAN_SELF_SNAPSHOT*)pMsg;
    this->m_nIndex = NpcSet.SearchID(PlaySync->EntityId);
    if (m_nIndex <= 0 || m_nIndex >= MAX_NPC) return;
    this->m_dwID = PlaySync->PlayerId;
    m_ItemList.RemoveAll();

    Npc[m_nIndex].m_Kind = kind_player;
    Npc[m_nIndex].m_Level = (DWORD)PlaySync->Level;
    Npc[m_nIndex].m_nSex = PlaySync->Gender;
    Npc[m_nIndex].m_Series  = PlaySync->Series;
    Npc[m_nIndex].SetPlayerIdx(CLIENT_PLAYER_INDEX);

    m_nAttributePoint = PlaySync->AttributePoints;
    m_nSkillPoint = PlaySync->SkillPoints;
    m_nStrength = PlaySync->Power;
    m_nDexterity = PlaySync->Agility;
    m_nVitality = PlaySync->Physique;
    m_nEngergy = PlaySync->Wisdom;
    m_nLucky = PlaySync->Luck;

    m_nCurStrength = m_nStrength;
    m_nCurDexterity = m_nDexterity;
    m_nCurVitality = m_nVitality;
    m_nCurEngergy = m_nEngergy;
    Npc[m_nIndex].m_CurrentLucky		= m_nLucky;

    SetFirstDamage();
    SetFirstMagic();
    SetBaseAttackRating();
    SetBaseDefence();
    Npc[m_nIndex].m_ActionScriptID = 0;
    Npc[m_nIndex].m_TrapScriptID = 0;
    m_nExp = PlaySync->Experience;
    Npc[m_nIndex].m_byTranslife = PlaySync->Transcendence;
    m_ImagePlayer = PlaySync->Portrait;
    m_nNextLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(PlaySync->Level, PlaySync->Transcendence);
    m_nLeadExp = PlaySync->LeadershipExperience;
    m_nLeadLevel = PlayerSet.m_cLeadExp.GetLevel(m_nLeadExp);
    m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(m_nLeadLevel);

    m_cProfession.SetProfession(PlaySync->Profession);

    m_nWorldStat = (int)PlaySync->WorldRank;
    m_nProfessionRank = (int)PlaySync->ProfessionRank;
    m_nKillPeopleNumber = (int)PlaySync->KillCount;  //Pk 10

    m_ItemList.Init(CLIENT_PLAYER_INDEX);
    m_ItemList.SetMoney(PlaySync->Money, PlaySync->BankMoney, 0);
    //g_DebugLog("PlaySync->Money-1: %d - %d", PlaySync->Money, PlaySync->BankMoney);

    Npc[m_nIndex].m_nMissionGroup = PlaySync->MissionGroup;
    m_cRoom.m_nID = PlaySync->ChatRoomId;
    CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);

    m_dwEquipExpandTime = PlaySync->ExtraEquipUntil;
    m_btRepositoryNum = PlaySync->BankPages;
    m_cTong.m_dwLeaveTime = PlaySync->ClanLeaveTime;

    Npc[m_nIndex].m_LifeMax = PlaySync->BaseMaxLife;
    Npc[m_nIndex].m_ManaMax = PlaySync->BaseMaxMana;
    Npc[m_nIndex].m_StaminaMax = PlaySync->BaseMaxStamina;
    Npc[m_nIndex].m_LifeReplenish = PLAYER_LIFE_REPLENISH;
    Npc[m_nIndex].m_ManaReplenish = PLAYER_MANA_REPLENISH;
    Npc[m_nIndex].m_StaminaGain = PLAYER_STAMINA_GAIN;
    Npc[m_nIndex].m_StaminaLoss = PLAYER_STAMINA_LOSS;

    SetBaseResistData();
    SetBaseSpeedAndRadius();

    Npc[m_nIndex].RestoreNpcBaseInfo();

    m_BuyInfo.Clear();
    m_cMenuState.Release();
    m_cChat.Release();
    m_cTong.Clear();
    m_cTask.Release();
    m_cAI.Release();
    m_LockMove.Release();

    memset(m_szTaskAnswerFun, 0, sizeof(m_szTaskAnswerFun));
    m_nAvailableAnswerNum = 0;

    Npc[m_nIndex].m_Experience = 0;
    memset(Npc[m_nIndex].m_szChatBuffer, 0, sizeof(Npc[m_nIndex].m_szChatBuffer));
    Npc[m_nIndex].m_nCurChatTime = 0;
    Npc[m_nIndex].m_bNpcRemoveDeath = FALSE;
    Npc[m_nIndex].m_nNpcTimeout = 0;
    ZeroMemory(Npc[m_nIndex].m_nNpcParam, sizeof(Npc[m_nIndex].m_nNpcParam));
    Npc[m_nIndex].m_bNpcFollowFindPath = FALSE;
    Npc[m_nIndex].m_uFindPathTime = 0;
    Npc[m_nIndex].m_uLastFindPathTime = 0;

    m_RunStatus = 1;
    m_nLeftSkillID = 0;
    m_nLeftSkillLevel = 0;
    m_nRightSkillID = 0;
    m_nRightSkillLevel = 0;
    m_nPeapleIdx = 0;
    m_nObjectIdx = 0;
    m_MouseDown[0] = 0;
    m_MouseDown[1] = 0;

    Npc[m_nIndex].m_SyncSignal = 0;
    // CURPLAYER_SYNC is authoritative for the local character series and sex.
    Npc[m_nIndex].ResetNpcTypeName(1);
    //Npc[m_nIndex].RestoreLiveData();
    //	SubWorld[0].AddPlayer(Npc[m_nIndex].m_RegionIndex, 0);//m_Region[Npc[m_nIndex].m_RegionIndex].AddPlayer(0);// m_WorldMessage.Send(GWM_PLAYER_ADD, Npc[m_nIndex].m_RegionIndex, 0);
}
#endif

BOOL	KPlayer::CheckTrading(bool bOverLookTrade)
{
    if (bOverLookTrade)
        return (m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADING ? TRUE : FALSE);
    else
    {
#ifdef _SERVER
        if (m_PTrade.nTrade)
			return TRUE;
#else
        if (Npc[m_nIndex].m_PTrade.nTrade)
            return TRUE;
#endif
    }
    return (m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADING ? TRUE : FALSE);
}

void	KPlayer::SetFirstDamage()
{
    int nDamageBase = m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE/* + 1*/;

    Npc[m_nIndex].m_PhysicsDamage.nValue[0] = nDamageBase;
    Npc[m_nIndex].m_PhysicsDamage.nValue[2] = nDamageBase;
    Npc[m_nIndex].m_PhysicsDamage.nValue[1] = 0;

    Npc[m_nIndex].m_CurrentFireDamage.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentFireDamage.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentFireDamage.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentColdDamage.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentColdDamage.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentColdDamage.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentLightDamage.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentLightDamage.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentLightDamage.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentEarthDamage.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentEarthDamage.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentEarthDamage.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentPoisonDamage.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentPoisonDamage.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentPoisonDamage.nValue[2] = 0;
}

void	KPlayer::SetFirstMagic()
{
    int nDamageBase = 0;
    if(ENGERGY_SET_DAMAGE_VALUE)
        nDamageBase = m_nCurEngergy / ENGERGY_SET_DAMAGE_VALUE;

    Npc[m_nIndex].m_PhysicsMagic.nValue[0] = nDamageBase;
    Npc[m_nIndex].m_PhysicsMagic.nValue[2] = nDamageBase;
    Npc[m_nIndex].m_PhysicsMagic.nValue[1] = 0;

    Npc[m_nIndex].m_CurrentFireMagic.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentFireMagic.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentFireMagic.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentColdMagic.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentColdMagic.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentColdMagic.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentLightMagic.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentLightMagic.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentLightMagic.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentEarthMagic.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentEarthMagic.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentEarthMagic.nValue[2] = 0;

    Npc[m_nIndex].m_CurrentPoisonMagic.nValue[0] = 0;
    Npc[m_nIndex].m_CurrentPoisonMagic.nValue[1] = 0;
    Npc[m_nIndex].m_CurrentPoisonMagic.nValue[2] = 0;

}
void	KPlayer::SetBaseAttackRating()
{
    Npc[m_nIndex].m_AttackRating = m_nDexterity * 4 - 28;
}

void	KPlayer::SetBaseDefence()
{
    Npc[m_nIndex].m_Defend = m_nDexterity >> 2;
}

void	KPlayer::SetBaseResistData()
{
    Npc[m_nIndex].m_FireResist			= PlayerSet.m_cLevelAdd.GetFireResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_ColdResist			= PlayerSet.m_cLevelAdd.GetColdResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_PoisonResist		= PlayerSet.m_cLevelAdd.GetPoisonResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_LightResist			= PlayerSet.m_cLevelAdd.GetLightResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_EarthResist			= PlayerSet.m_cLevelAdd.GetEarthResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_PhysicsResist		= PlayerSet.m_cLevelAdd.GetPhysicsResist(Npc[m_nIndex].m_Series, Npc[m_nIndex].m_Level);
    Npc[m_nIndex].m_FireResistMax		= BASE_FIRE_RESIST_MAX;
    Npc[m_nIndex].m_ColdResistMax		= BASE_COLD_RESIST_MAX;
    Npc[m_nIndex].m_PoisonResistMax		= BASE_POISON_RESIST_MAX;
    Npc[m_nIndex].m_LightResistMax		= BASE_LIGHT_RESIST_MAX;
	Npc[m_nIndex].m_EarthResistMax		= BASE_EARTH_RESIST_MAX;
    Npc[m_nIndex].m_PhysicsResistMax	= BASE_PHYSICS_RESIST_MAX;
}

void	KPlayer::SetBaseSpeedAndRadius()
{
    Npc[m_nIndex].m_WalkSpeed = BASE_WALK_SPEED;
    Npc[m_nIndex].m_RunSpeed = BASE_RUN_SPEED;
    Npc[m_nIndex].m_AttackSpeed = BASE_ATTACK_SPEED;
    Npc[m_nIndex].m_CastSpeed = BASE_CAST_SPEED;
    Npc[m_nIndex].m_VisionRadius = BASE_VISION_RADIUS;
    Npc[m_nIndex].m_HitRecover = BASE_HIT_RECOVER;
}

#ifndef _SERVER
//�ͻ��˰汾
void KPlayer::DialogNpc(int nIndex)
{
    if (nIndex > 0 && Npc[nIndex].m_Index > 0)
    {
        FILE *pDialogLog = fopen("client_npc_dialog_diag.log", "a");
        if (pDialogLog)
        {
            fprintf(pDialogLog, "click index=%d id=%u kind=%d script=%s name=%s\n",
                nIndex, Npc[nIndex].m_dwID, Npc[nIndex].m_Kind,
                Npc[nIndex].ActionScript, Npc[nIndex].Name);
            fclose(pDialogLog);
        }
        if(nIndex)
            m_nLastNpcIndex = nIndex;
        if (Npc[nIndex].m_bClientOnly && Npc[nIndex].ActionScript[0])
        {
            ExecuteScript(Npc[nIndex].m_ActionScriptID, NORMAL_FUNCTION_NAME, nIndex);
        }
        else
        {
PHONGTHAN_ENTITY_REFERENCE DialogNpcCmd;
            PhongThanInitializeWireHeader(&DialogNpcCmd.Header, PHONGTHAN_MSG_NPC_INTERACT_REQUEST,
                sizeof(DialogNpcCmd), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
            DialogNpcCmd.MapId = SubWorld[0].m_SubWorldID;
            DialogNpcCmd.EntityId = Npc[nIndex].m_dwID;
            if (g_pClient)
                g_pClient->SendPackToServer(&DialogNpcCmd, sizeof(DialogNpcCmd));

        }
    }
}
#endif

#ifndef _SERVER
void KPlayer::CheckObject(int nIdx) // TamLTM Fix kiem tra va theo sau nhat do item
{
/*	enum	// �������
{
Obj_Kind_MapObj = 0,		// ��ͼ�������Ҫ���ڵ�ͼ����
Obj_Kind_Body,				// npc ��ʬ��
Obj_Kind_Box,				// ����
Obj_Kind_Item,				// ���ڵ��ϵ�װ��
Obj_Kind_Money,				// ���ڵ��ϵ�Ǯ
Obj_Kind_LoopSound,			// ѭ����Ч
Obj_Kind_RandSound,			// �����Ч
Obj_Kind_Light,				// ��Դ��3Dģʽ�з���Ķ�����
Obj_Kind_Door,				// ����
Obj_Kind_Trap,				// ����
Obj_Kind_Prop,				// С���ߣ�������
Obj_Kind_Num,				// �����������
};*/

//	S2C_PLAYER_SYNC	sMsg;
//	g_DebugLog("m_bNotPickUpItem %d", enumMSG_ID_MONEY_CANNOT_PICKUP);

    switch(Object[nIdx].m_nKind)
    {
        case Obj_Kind_Item:
            //	break;
        case Obj_Kind_Money:
            PickUpObj(nIdx);
            Npc[m_nIndex].m_nObjectIdx = 0;
            break;
        case Obj_Kind_Box:
            //	break;
        case Obj_Kind_Door:
            //	break;
        case Obj_Kind_Trap:
            //	break;
        case Obj_Kind_Prop:
            this->ObjMouseClick(nIdx);
            Npc[m_nIndex].m_nObjectIdx = 0;
            break;
        default:
            break;
    }
    m_nObjectIdx = 0;
    m_nPickObjectIdx = 0;
}

void KPlayer::PickObjectNear()
{
    int nX1, nY1;
    Npc[m_nIndex].GetMpsPos(&nX1, &nY1);

    int nSubWorldIdx = Npc[m_nIndex].m_SubWorldIndex;
    int nRegionIdx = Npc[m_nIndex].m_RegionIndex;

    int nObjIdx = SubWorld[nSubWorldIdx].m_Region[nRegionIdx].FindObjectNear(nX1, nY1);

    if (nObjIdx && Object[nObjIdx].GetKind() == Obj_Kind_Item ||
        Object[nObjIdx].GetKind() == Obj_Kind_Money)
        this->CheckObject(nObjIdx);
}
#endif

//TamLTM Damage attack ho tro skill 6x
#ifndef _SERVER
void KPlayer::GetEchoAttack(int* nAttack, int nType)
{


    int nSkillId;
    *nAttack = 0;

    if (m_nIndex <= 0 || m_nIndex >= MAX_NPC
        || NULL == nAttack)
        return;

    nSkillId = (0 == nType)?m_nLeftSkillID:m_nRightSkillID;

    int nLevel = Npc[m_nIndex].m_SkillList.GetCurrentLevel(nSkillId);

    if (nSkillId <= 0 ||nLevel <= 0 || nLevel >= MAX_SKILLLEVEL)
        return;

    KMagicAttrib*	pMagicData = NULL;

    KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nSkillId, nLevel);
    if (!pOrdinSkill)
        return ;

    switch(pOrdinSkill->GetSkillStyle())
    {
        case SKILL_SS_Missles:
        case SKILL_SS_Melee:
        case SKILL_SS_InitiativeNpcState:
        case SKILL_SS_PassivityNpcState:
		case SKILL_SS_PhongThanAttack:
		case SKILL_SS_PhongThanProduce:
		case SKILL_SS_PhongThanAwaken:
        {
        }
            break;
        default:
            return;
    }


    BOOL	bIsMele = pOrdinSkill->IsUseAR();

    if (!bIsMele)
        return;

    pMagicData = pOrdinSkill->GetDamageAttribs();

    if (!pMagicData)
        return;


    if (pMagicData->nAttribType == magic_attackrating_p)
    {
        *nAttack = Npc[m_nIndex].m_CurrentAttackRating + Npc[m_nIndex].m_AttackRating * pMagicData->nValue[0] / 100;
    }
    else
    {
        *nAttack = Npc[m_nIndex].m_CurrentAttackRating;
    }
}
#endif
//end

#ifndef _SERVER
void KPlayer::GetEchoDamage(int* nMin, int* nMax, int nType)
{
    int nSkillId;
    *nMin = 0;
    *nMax = 0;

    if (m_nIndex <= 0 || m_nIndex >= MAX_NPC
        || nType < 0 || nType > 1
        || NULL == nMin || NULL == nMax)
        return;

    nSkillId = (0 == nType)?m_nLeftSkillID:m_nRightSkillID;
    int nLevel = Npc[m_nIndex].m_SkillList.GetCurrentLevel(nSkillId);

    if (nSkillId <= 0 ||nLevel <= 0 || nLevel >= MAX_SKILLLEVEL)
        return;

    KMagicAttrib*	pMagicData = NULL;

    KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nSkillId, nLevel);
    if (!pOrdinSkill)
        return ;

    switch(pOrdinSkill->GetSkillStyle())
    {
        case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
        case SKILL_SS_Melee:
        case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
        case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
		case SKILL_SS_PhongThanAttack:
		case SKILL_SS_PhongThanProduce:
		case SKILL_SS_PhongThanAwaken:
        {
        }
            break;
        default:
            return;
    }

    BOOL	bIsPhysical = pOrdinSkill->IsPhysical();


    pMagicData = pOrdinSkill->GetDamageAttribs();

    if (!pMagicData)
        return;

    int nMinNpcDamage = Npc[m_nIndex].m_PhysicsDamage.nValue[0] + Npc[m_nIndex].m_CurrentAddPhysicsDamage;
    int nMaxNpcDamage = Npc[m_nIndex].m_PhysicsDamage.nValue[2] + Npc[m_nIndex].m_CurrentAddPhysicsDamage;
    int nAddDamageP = Npc[m_nIndex].m_SkillList.GetAddSkillDamage(nSkillId) + Npc[m_nIndex].m_CurrentSkillEnhancePercent;
    if(Npc[m_nIndex].m_CurrentMana == Npc[m_nIndex].m_CurrentManaMax)
        nAddDamageP += Npc[m_nIndex].m_CurrentManaToSkillEnhanceP;

    // Skip attackrating
    pMagicData++;
    // Skip ignoredefense
    pMagicData++;
    // Calc magic damage
    if (magic_magicdamage_v == pMagicData->nAttribType)
    {
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);
    }
    pMagicData++;
    // Skip seriesdamage
    pMagicData++;
    // Skip deadlystrike
    pMagicData++;
    // Skip fatallystrike
    pMagicData++;
    // Skip stolenlife
    pMagicData++;
    // Skip stolenmana
    pMagicData++;
    // Skip stolenstamina
    pMagicData++;
    // Calc physics damage

    if (magic_physicsenhance_p == pMagicData->nAttribType)
    {
        *nMin += nMinNpcDamage * (100 + (pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100))) / 100;
        *nMax += nMaxNpcDamage * (100 + (pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100))) / 100;

        int nEnhance;
        if (equip_meleeweapon == m_ItemList.GetWeaponType())
        {
            nEnhance = Npc[m_nIndex].m_CurrentMeleeEnhance[m_ItemList.GetWeaponParticular()];
        }
        else if (equip_rangeweapon == m_ItemList.GetWeaponType())
        {
            nEnhance = Npc[m_nIndex].m_CurrentRangeEnhance;
        }
        else
        {
            nEnhance = Npc[m_nIndex].m_CurrentHandEnhance;
        }
        *nMin += nMinNpcDamage * nEnhance / 100;
        *nMax += nMaxNpcDamage * nEnhance / 100;
    }
    else if (magic_physicsdamage_v == pMagicData->nAttribType)
    {
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);

        if (!bIsPhysical)
        {
            *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + Npc[m_nIndex].m_CurrentAddPhysicsMagic;
            *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + Npc[m_nIndex].m_CurrentAddPhysicsMagic;
        }
    }

    pMagicData++;
    // Calc cold damage
    if (magic_colddamage_v == pMagicData->nAttribType)
    {
//		g_DebugLog("Calc cold damage KPlayer");
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);

        if (!bIsPhysical)
        {
            *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + Npc[m_nIndex].m_CurrentColdMagic.nValue[0];
            *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + Npc[m_nIndex].m_CurrentColdMagic.nValue[2];
        }
    }
    if (bIsPhysical)
    {
        *nMin += Npc[m_nIndex].m_CurrentColdDamage.nValue[0];
        *nMax += Npc[m_nIndex].m_CurrentColdDamage.nValue[2];
    }
    pMagicData++;
    // Calc fire damage
    if (magic_firedamage_v == pMagicData->nAttribType)
    {
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);

        if (!bIsPhysical)
        {
            *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + Npc[m_nIndex].m_CurrentFireMagic.nValue[0];
            *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + Npc[m_nIndex].m_CurrentFireMagic.nValue[2];
        }
    }
    if (bIsPhysical)
    {
        *nMin += Npc[m_nIndex].m_CurrentFireDamage.nValue[0];
        *nMax += Npc[m_nIndex].m_CurrentFireDamage.nValue[2];
    }
    pMagicData++;
    // Calc lighting damage
    if (magic_lightingdamage_v == pMagicData->nAttribType)
    {
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);

        if (!bIsPhysical)
        {
            *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + Npc[m_nIndex].m_CurrentLightMagic.nValue[0];
            *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + Npc[m_nIndex].m_CurrentLightMagic.nValue[2];
        }
    }
    if (bIsPhysical)
    {
        *nMin += Npc[m_nIndex].m_CurrentLightDamage.nValue[0];
        *nMax += Npc[m_nIndex].m_CurrentLightDamage.nValue[2];
    }
    pMagicData++;
    // Calc earth damage
    if (magic_earthdamage_v == pMagicData->nAttribType)
    {
        *nMin += pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100);
        *nMax += pMagicData->nValue[2] + (pMagicData->nValue[2] * nAddDamageP / 100);

        if (!bIsPhysical)
        {
            *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + Npc[m_nIndex].m_CurrentEarthMagic.nValue[0];
            *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + Npc[m_nIndex].m_CurrentEarthMagic.nValue[2];
        }
    }
    if (bIsPhysical)
    {
        *nMin += Npc[m_nIndex].m_CurrentEarthDamage.nValue[0];
        *nMax += Npc[m_nIndex].m_CurrentEarthDamage.nValue[2];
    }
    pMagicData++;
    // Calc poison damage
    // if (magic_poisondamage_v == pMagicData->nAttribType)
    // {
    //     if (pMagicData->nValue[2] > 0)
    //     {

    //         int nPoisonDamage = ((pMagicData->nValue[0] + (pMagicData->nValue[0] * nAddDamageP / 100)) * pMagicData->nValue[1] / pMagicData->nValue[2]);
    //         *nMin += nPoisonDamage;
    //         *nMax += nPoisonDamage;
    //     }
    //     if (!bIsPhysical)
    //     {
    //         if (Npc[m_nIndex].m_CurrentPoisonMagic.nValue[2] > 0)
    //         {
    //             int nPoisonDamage = (Npc[m_nIndex].m_CurrentPoisonMagic.nValue[0]
    //                                  * Npc[m_nIndex].m_CurrentPoisonMagic.nValue[1]
    //                                  / Npc[m_nIndex].m_CurrentPoisonMagic.nValue[2]);
    //             *nMin += Npc[m_nIndex].m_PhysicsMagic.nValue[0] + nPoisonDamage;
    //             *nMax += Npc[m_nIndex].m_PhysicsMagic.nValue[2] + nPoisonDamage;
    //         }
    //     }
    // }
    // if (bIsPhysical)
    // {
    //     if (Npc[m_nIndex].m_CurrentPoisonDamage.nValue[2] > 0)
    //     {
    //         int nPoisonDamage = (Npc[m_nIndex].m_CurrentPoisonDamage.nValue[0]
    //                              * Npc[m_nIndex].m_CurrentPoisonDamage.nValue[1]
    //                              / Npc[m_nIndex].m_CurrentPoisonDamage.nValue[2]);
    //         *nMin += nPoisonDamage;
    //         *nMax += nPoisonDamage;
    //     }
    // }
    // pMagicData++;
    // Skip stun
}
#endif
void KPlayer::SetNpcDamageAttrib()
{
    SetNpcPhysicsDamage();
}

#ifdef _SERVER
void KPlayer::TobeExchangeServer(DWORD dwMapID, int nX, int nY)
{
	if (!m_dwID || m_nNetConnectIdx == -1)
		return;

	m_sExchangePos.m_dwMapID = dwMapID;
	m_sExchangePos.m_nX = nX;
	m_sExchangePos.m_nY = nY;
	m_bExchangeServer = TRUE;
}
#endif

#ifdef _SERVER
BOOL KPlayer::IsExchangingServer()
{
	return m_bExchangeServer;
}

void 	KPlayer::SetNumImg(int ID)
{
	if(ID>0 && ID < 28)
		m_ImagePlayer=ID;
}
#endif


void KPlayer::SetLockMove(LockMoveItem *LockMove)
{
    m_LockMove = *LockMove;

#ifdef _SERVER
    PLAYER_LOCKMOVE	Lock;
	Lock.ProtocolType = s2c_lockmove;
	Lock.m_LockMove = *LockMove;
	if(g_pServer && m_nNetConnectIdx != -1)
		g_pServer->PackDataToClient(this->m_nNetConnectIdx, &Lock, sizeof(PLAYER_LOCKMOVE));
#endif
}

void	KPlayer::SetLockState(BOOL bLock)
{
    int nTaskLen = strlen(this->m_cTask.GetSaveStr(TASKVALUE_BASEDATA_PASSWORD));
    if(nTaskLen > MIN_PASSWORD_LENGTH && nTaskLen <= MAX_PASSWORD_LENGTH)
    {
        m_bLockState = bLock;
#ifdef _SERVER
        PHONGTHAN_PLAYER_EVENT	sMsg;
		ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[m_nIndex].m_dwID;
		sMsg.Value = bLock;
		sMsg.Operation = PHONGTHAN_PLAYER_LOCK;
		if(g_pServer && m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sizeof(sMsg));
#endif
    }
}

//TamLTM fix send packet
/*void	KPlayer::SetLockState(BOOL bLock)
{
	int nTaskLen = strlen(this->m_cTask.GetSaveStr(TASKVALUE_BASEDATA_PASSWORD));
	if (nTaskLen > MIN_PASSWORD_LENGTH && nTaskLen <= MAX_PASSWORD_LENGTH)
	{
		m_bLockState = bLock;
#ifdef _SERVER
		S2C_PLAYER_SYNC_LOCK_STATE	sMsg;
		sMsg.ProtocolType = s2c_playersynclockstate;
		sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_LOCK_STATE) - 1;
		sMsg.m_lpBuf = (LPVOID)bLock;
		sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_LOCKSTATE;
		if (g_pServer && m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif
	}
}
//end code */

BOOL KPlayer::GetLockState()
{
    return this->m_bLockState;
}

void	KPlayer::SetEquipExpandTime(int dwTime)
{
    m_dwEquipExpandTime = dwTime;

#ifdef _SERVER
    PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[m_nIndex].m_dwID;
	sMsg.Value = dwTime;
	sMsg.Operation = PHONGTHAN_PLAYER_EQUIP_EXPIRY;
	g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sizeof(sMsg));
#endif
}

void	KPlayer::SetExpandBoxNum(int nNum)
{
    m_btRepositoryNum = nNum;

#ifdef _SERVER
    PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[m_nIndex].m_dwID;
	sMsg.Value = nNum;
	sMsg.Operation = PHONGTHAN_PLAYER_BANK_PAGES;
	g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sizeof(sMsg));
#endif
}

/*//TamLTM fix send packet
void	KPlayer::SetEquipExpandTime(int dwTime)
{
	m_dwEquipExpandTime = dwTime;

#ifdef _SERVER
	S2C_PLAYER_SYNC_EQUIP_EXPAND	sMsg;
	sMsg.ProtocolType = s2c_playersyncequipexpand;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_EQUIP_EXPAND) - 1;
	sMsg.m_lpBuf = (LPVOID)dwTime;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_EQUIPEXPAND;
	g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif
}

void	KPlayer::SetExpandBoxNum(int nNum)
{
	m_btRepositoryNum = nNum;

#ifdef _SERVER
	S2C_PLAYER_SYNC_EXPAND_BOX	sMsg;
	sMsg.ProtocolType = s2c_playersyncexpandbox;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_EXPAND_BOX) - 1;
	sMsg.m_lpBuf = (LPVOID)nNum;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_EXPANDBOX;
	g_pServer->PackDataToClient(this->m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif
}
//end code */

#ifdef _SERVER
void KPlayer::SetLastNetOperationTime(int nTime)
{
	if (m_nNetConnectIdx == -1 || m_dwID == 0 || m_nIndex <= 0)
		return;

	m_nLastNetOperationTime = nTime;
	if (m_bSleepMode)
	{
		m_bSleepMode = FALSE;
		NPC_SLEEP_SYNC	SleepSync;
		SleepSync.ProtocolType = s2c_npcsleepmode;
		SleepSync.bSleep = m_bSleepMode;
		SleepSync.NpcID = Npc[m_nIndex].m_dwID;
		Npc[m_nIndex].SendDataToNearRegion(&SleepSync, sizeof(NPC_SLEEP_SYNC));
	}
}
#endif

#ifdef _SERVER
BOOL	KPlayer::CreateTong(int nCamp, char *lpszTongName)
{
	return this->m_cTong.Create(nCamp, lpszTongName);
}
#endif

#ifdef _SERVER
//Sua trang bi do ben
void KPlayer::RepairItem(DWORD dwItemID)
{
	if (FALSE && Npc[m_nIndex].m_FightMode)	/* Phong Than 2026-10-02: repair in fight mode too */
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR1;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		if(g_pServer && m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	int nIdx = m_ItemList.SearchID(dwItemID);
	int nCost = Item[nIdx].GetRepairPrice();
	/* Phong Than 2026-10-02: a zero repair price (cheap items) repairs for free instead of doing nothing */
	int nMaxDur = Item[nIdx].GetMaxDurability();
	int nDur = Item[nIdx].GetDurability();
	if (nDur == 0)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_ITEM_CANTREPAIR;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		if(g_pServer && m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	if (Pay(nCost) && m_nNetConnectIdx >= 0)
	{
		Item[nIdx].SetDurability(nMaxDur);
		m_ItemList.SyncItemDurability(nIdx);

		char szMsg[128];
		sprintf(szMsg, MSG_ITEM_REPAIRED, nCost, Item[nIdx].GetName());
		KPlayerChat::SendSystemInfo(1, m_nPlayerIndex, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );
	}
}
#endif

//TamLTM Code Get Hardware id PC
//#include <iomanip>
//#include <iphlpapi.h>
//#pragma comment(lib, "iphlpapi.lib")

#ifdef _SERVER

//Hardware
std::string checkCodeHardware;
char* codeHardWare;

//nMacCheck
int codeMac = 0;
/// Name SQL Test here local
char* connectDBGet;
char* connectDBXu;

//Get hardre
void KPlayer::GetHardwareIDPC()
{
	GetNameForDatabase(1); // 1: local - 2: vps

	//Get Hardware id
	HW_PROFILE_INFO   HwProfInfo;
	if (!GetCurrentHwProfile(&HwProfInfo))
	{
		//GetCurrentHwProfile failed with error
		exit(0);
		return;
	}
//	g_DebugLog("DockInfo = %d", HwProfInfo.dwDockInfo);
//	g_DebugLog("Profile Guid = %s", HwProfInfo.szHwProfileGuid);
//	g_DebugLog("Friendly Name = %s", HwProfInfo.szHwProfileName);

	std::string fileGuild(HwProfInfo.szHwProfileGuid);
	std::string codeHardWareCh(codeHardWare);
	checkCodeHardware = fileGuild;

	//ANTIFA - them MAC gioi han server run
	DWORD Address;
	BYTE MacAddress[6];
	gGetMacAndIPAddress(NULL, NULL, MacAddress, &Address);
	DWORD Id = 0;
	for (int i = 0; i < 6; i++)
	{
		Id = (Id + (i + 1) * MacAddress[i]) % 0x8000000b * 0xffffffef;
	}
	Address = Id ^ 0x12345678;
	int CoverAddress = Address;

	if (fileGuild != codeHardWareCh || CoverAddress != codeMac)
	{
	//	exit(0); // Tat cai nay ra moi debug hardware duoc
	}


	//Mo cai nay ra moi debug hardware duoc
	//Save file - output file
/*	ofstream myfile;
	//Save in file txt
	myfile.open("hoangdebug.txt", ios::app);
	//Save data file
	// myfile << HwProfInfo.dwDockInfo << endl; //Index
	myfile << HwProfInfo.szHwProfileGuid << endl; //Hardware id
	// myfile << HwProfInfo.szHwProfileName << endl; //unlock hardware
	myfile << CoverAddress << endl; // */
}

//TamLTM thy doi hoat dong du lieu khi chay local hoac vps
//int changeOne = 0;
void KPlayer::GetNameForDatabase(int numberChange)
{
	//if (changeOne >= 5)
//		return;

	if (numberChange == 1) // 1 local
	{
		//Hard ware
		codeHardWare = "{afc2f581-a677-11eb-81a4-806e6f6e6963}"; //local

		//nMacCheck
		codeMac = 1676832191; // 1676832191; //local ko ra so am vkl

		// Name SQL Test here local
	//	connectDBGet = "DRIVER={SQL Server}; SERVER=DESKTOP-G95488V\\SQLEXPRESS; DATABASE=account; UID=sa; PWD=@SA123;";
	//	connectDBXu = "Provider=SQLOLEDB;Data Source=DESKTOP-G95488V\\SQLEXPRESS;Initial Catalog=account;User ID=sa;Password=@SA123;Connect Timeout=30;";

	//	changeOne++;
	}
	else if (numberChange == 2) // VPS
	{
		//Hard ware VPS
		codeHardWare = "{afc856c0-606f-11ea-994c-806e6f6e6963}"; //VPS {afc856c0-606f-11ea-994c-806e6f6e6963}

		//nMac VPS
		codeMac = -508159479;


		//SQL Name VPS
	//	connectDBGet = "DRIVER={SQL Server}; SERVER=VIETNIX-DEB1DE0\\SQLEXPRESS; DATABASE=account; UID=sa; PWD=@P92021s@zS2;";
	//	connectDBXu = "Provider=SQLOLEDB;Data Source=VIETNIX-DEB1DE0\\SQLEXPRESS;Initial Catalog=account;User ID=sa;Password=@P92021s@zS2;Connect Timeout=30;";

	//	changeOne++;
	}
}
//end code

//TamLTM Get Mac form SQL -> Fetches the MAC address and prints it
void KPlayer::GetMACaddress()
{
#ifdef _SERVER
	int id;
	char serverName[32];
	char cMemoMac[32];

	SQLHANDLE SQLEnvHandle = NULL;
	SQLHANDLE SQLConnectionHandle = NULL;
	SQLHANDLE SQLStatementHandle = NULL;
	SQLRETURN retCode = 0;

	char SQLQuery[] = "SELECT * FROM ServerList";

	do {
		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &SQLEnvHandle))
			break;
		if (SQL_SUCCESS != SQLSetEnvAttr(SQLEnvHandle, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0))
			break;
		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_DBC, SQLEnvHandle, &SQLConnectionHandle))
			break;
		if (SQL_SUCCESS != SQLSetConnectAttr(SQLConnectionHandle, SQL_LOGIN_TIMEOUT, (SQLPOINTER)5, 0))
			break;

		SQLCHAR retConString[1024]; // Conection string

		switch (SQLDriverConnect(SQLConnectionHandle,
			NULL,
			(SQLCHAR*)connectDBGet,
			SQL_NTS,
			retConString,
			1024,
			NULL,
			SQL_DRIVER_NOPROMPT)) {
		case SQL_SUCCESS:
			break;
		case SQL_SUCCESS_WITH_INFO:
			break;
		case SQL_NO_DATA_FOUND:
			retCode = -1;
			break;
		case SQL_INVALID_HANDLE:
			retCode = -1;
			break;
		case SQL_ERROR:
			retCode = -1;
			exit(0);
			break;
		default:
			break;
		}

		if (retCode == -1)
			break;
		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_STMT, SQLConnectionHandle, &SQLStatementHandle))
			break;
		if (SQL_SUCCESS != SQLExecDirect(SQLStatementHandle, (SQLCHAR*)SQLQuery, SQL_NTS)) {
			break;
		}
		else
		{
			while (SQLFetch(SQLStatementHandle) == SQL_SUCCESS)
			{
				// Fetches the next rowset of data from the result
				SQLGetData(SQLStatementHandle, 1, SQL_C_DEFAULT, &id, sizeof(id), NULL); //, 1, la cot can get data sql
				SQLGetData(SQLStatementHandle, 2, SQL_C_DEFAULT, &serverName, sizeof(serverName), NULL);
				SQLGetData(SQLStatementHandle, 6, SQL_C_DEFAULT, &cMemoMac, sizeof(cMemoMac), NULL); //6 la cot cMemoMac

				// Retrieves data for a single column in the result set

				std::string cServerName(serverName);
				std::string nMac(cMemoMac);

				//Mac Local: E0D5-5EA6-3C49 - 0200-4C4F-4F50 , Mac vps: 0050-56A2-CFDC
				if (cServerName == "txjx")
				{
					if (nMac != "0050-56A2-5981")
					{
						exit(0);
					}
				}
				else if (cServerName == "txjx")
				{
					if (nMac != "0050-56A2-5981")
					{
						exit(0);
					}
				}
				else
				{
					exit(0);
				}
			}
		}
	} while (FALSE);

	SQLFreeHandle(SQL_HANDLE_STMT, SQLStatementHandle);
	SQLDisconnect(SQLConnectionHandle);
	SQLFreeHandle(SQL_HANDLE_DBC, SQLConnectionHandle);
	SQLFreeHandle(SQL_HANDLE_ENV, SQLEnvHandle);
#endif
}

#endif
//end code
#ifdef _SERVER
void KPlayer::SetExtPoint(int nPoint, int nChangePoint)
{
	m_nExtPoint = nPoint;
	m_nChangeExtPoint = nChangePoint;
	EXTPOINT_VALUE_SYNC	sValue;
	sValue.ProtocolType = s2c_extpointsync;
	sValue.m_nExtPointValue = m_nExtPoint;
	sValue.m_nChangeExtPoint = m_nChangeExtPoint;
//	g_DebugLog("s2c_extpointsync %d", s2c_extpointsync);
	g_pServer->PackDataToClient(Player[m_nPlayerIndex].m_nNetConnectIdx, (BYTE*)&sValue, sizeof(EXTPOINT_VALUE_SYNC));
}

//Check update database
int KPlayer::GetExtPoint()
{
	return m_nExtPoint;
}

int KPlayer::GetExtPointChanged()
{

	return m_nChangeExtPoint;
}


BOOL KPlayer::PayExtPoint(int nPoint)
{
	if (m_nExtPoint < nPoint)
		return FALSE;

	m_nExtPoint -= nPoint;
	m_nChangeExtPoint += nPoint;
	EXTPOINT_VALUE_SYNC	sValue;
	sValue.ProtocolType = s2c_extpointsync;
	sValue.m_nExtPointValue = m_nExtPoint;
	sValue.m_nChangeExtPoint = m_nChangeExtPoint;
	g_pServer->PackDataToClient(Player[m_nPlayerIndex].m_nNetConnectIdx, (BYTE*)&sValue, sizeof(EXTPOINT_VALUE_SYNC));
	return TRUE;
}

//TamLTM Code load sql
void KPlayer::UpdateSQL(IN char *cAccName, IN int nExtPoint, bool iCheckExtPoint) {

	_ConnectionPtr pConn;
	_CommandPtr m_pCmd;

	_bstr_t strCon(connectDBXu); //Connect sql

	HRESULT hr = S_OK;
	CoInitialize(NULL);

	try
	{
		hr = pConn.CreateInstance((__uuidof(Connection)));
		if (FAILED(hr))
		{
		//	g_DebugLog("Error instantiating Connection objectn");
		}

		hr = pConn->Open(strCon, "", "", 0);
		if (FAILED(hr))
		{
		//	g_DebugLog("Error Opening Database object using ADO _ConnectionPtr n");
		}
		hr = m_pCmd.CreateInstance(__uuidof(Command));

		if (FAILED(hr))
		{
		//	g_DebugLog("Error creating command instance!!");
		}

		char strsql[MAX_PATH];
		if (m_nExtPoint == NULL)
		{
			sprintf(strsql, "UPDATE Account_Habitus SET nExtPoint = '%d' WHERE (cAccName = '%s')", 0, cAccName);
		}
		else
		{
			if (iCheckExtPoint == true)
			{
				sprintf(strsql, "UPDATE Account_Habitus SET nExtPoint = '%d' WHERE (cAccName = '%s')", nExtPoint + 1, cAccName);
			//	SetExtPoint(nExtPoint, false);
			}
		}

		m_pCmd->ActiveConnection = pConn;
		m_pCmd->CommandText = strsql;
		m_pCmd->CommandType = adCmdText;

		m_pCmd->Execute(NULL, NULL, adCmdText);

//		g_DebugLog("Data Added Successfully");

		pConn->Close();

	}
	catch (_com_error & ce)
	{
	//	g_DebugLog("Error: %s", ce.ErrorInfo);
	}
}

//end code


#endif

#ifndef _SERVER
void KPlayer::SetExtPoint(int nPoint)
{
    m_nExtPoint = nPoint;
}
#endif

#ifdef _SERVER
//TamLTM Code kham nam xanh
//===============new add load scipt TamLTM kham nam
void KPlayer::RecoveryBox(DWORD dwID, int nX, int nY)
{
	if (CheckTrading())
		return;

	int nIndex = m_ItemList.SearchID(dwID);

	if (nIndex <= 0)
		return ;

	m_ItemList.Remove(nIndex);

	int		p, x, y;
	if (m_ItemList.CheckCanPlaceInEquipment(nX, nY, &p, &x, &y))
	{
		m_ItemList.Add(nIndex, pos_equiproom, x, y);
	}
	else
	{
		int	nIdx = m_ItemList.Hand();
		if (nIdx)
		{
			m_ItemList.Remove(nIdx);

			KMapPos sMapPos;
			KObjItemInfo	sInfo;
			char			szNameTemp[OBJ_NAME_LENGHT];

			GetAboutPos(&sMapPos);

			sInfo.m_nItemID = nIdx;
			sInfo.m_nItemWidth = Item[nIdx].GetWidth();
			sInfo.m_nItemHeight = Item[nIdx].GetHeight();
			sInfo.m_nMoneyNum = 0;
			if (Item[nIdx].GetStackNum() > 1)
			{
				sprintf(szNameTemp, "%s x %d", Item[nIdx].GetName(), Item[nIdx].GetStackNum());
				strcpy(sInfo.m_szName, szNameTemp);
			}
			else
				strcpy(sInfo.m_szName, Item[nIdx].GetName());
			sInfo.m_nColorID = Item[nIdx].GetColorItem();
			sInfo.m_nGenre = Item[nIdx].GetGenre();
			sInfo.m_nDetailType = Item[nIdx].GetDetailType();
			sInfo.m_nMovieFlag = 1;
			sInfo.m_nSoundFlag = 1;
			sInfo.m_dwNpcId = 0;

			int nObj = ObjSet.Add(Item[nIdx].GetObjIdx(), sMapPos, sInfo);
			if (nObj >= 0)
			{
				if (Item[nIdx].GetGenre() == item_task ||
					Item[nIdx].GetGenre() == item_materials)
					Object[nObj].SetEntireBelong(m_nPlayerIndex);
				else
					Object[nObj].SetItemBelong(m_nPlayerIndex);
			}
		}
		m_ItemList.Add(nIndex, pos_hand, 0, 0);
	}
}
//End code

#endif


#ifdef _SERVER
void KPlayer::AutoLoseItem(DWORD dwItemID)
{
	if (this->CheckTrading())
		return;
	if (this->GetLockMove()->bLock)
		return;

	int nIdx = m_ItemList.SearchID(dwItemID);

	if (nIdx)
	{
		if (Item[nIdx].GetGenre() != item_medicine)
			return;

		int	nItemIdx, nXpos, nYpos, nPos;
		nItemIdx = 0;
		nXpos = 0;
		nYpos = 0;
		nPos = 0;
		while (1)
		{
			nItemIdx = m_ItemList.m_Room[room_equipment].GetNextItem(nItemIdx, nXpos, nYpos, &nXpos, &nYpos);
			if (nItemIdx == 0)
				break;
			if  (Item[nItemIdx].GetLockTrade())
				continue;
			if  (Item[nItemIdx].GetLockDrop())
				continue;
			if  (Item[nItemIdx].GetLock()->IsLock())
				continue;

			ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nIdx = nItemIdx;
			ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nPlace = pos_equiproom;
			ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nX = nXpos;
			ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nY = nYpos;
			nPos++;
		}
		if (nPos == 0)
			return;
		KMapPos			sMapPos;
		int				nObj;
		KObjItemInfo	sInfo;
		char			szNameTemp[OBJ_NAME_LENGTH];
		for (int i = 0; i < nPos; i++)
		{
			nItemIdx = ItemSet.m_sLoseItemFromEquipmentRoom[i].nIdx;
			GetAboutPos(&sMapPos);
			// ����
			if (m_ItemList.CompareRemoveItem(nIdx, nItemIdx))
			{
				if (m_ItemList.Remove(nItemIdx))
				{
					sInfo.m_nItemID = nItemIdx;
					sInfo.m_nItemWidth = Item[nItemIdx].GetWidth();
					sInfo.m_nItemHeight = Item[nItemIdx].GetHeight();
					sInfo.m_nMoneyNum = 0;
					strcpy(sInfo.m_szName, Item[nItemIdx].GetName());
					sInfo.m_nColorID = Item[nItemIdx].GetQuality();
					sInfo.m_nGenre = Item[nItemIdx].GetGenre();
					sInfo.m_nDetailType = Item[nItemIdx].GetDetailType();
					sInfo.m_nMovieFlag = 1;
					sInfo.m_nSoundFlag = 1;
					sInfo.m_bOverLook = 1;
					nObj = ObjSet.Add(Item[nItemIdx].GetObjIdx(), sMapPos, sInfo);
					if (nObj >= 0)
					{
						Object[nObj].SetItemBelong(-1);
					}
				}
			}
		}
	}
}

void KPlayer::PlayerBreakItem(DWORD dwItemID, int nNum, BOOL bIsBreakAll)
{

	if (this->CheckTrading())
		return;
	if (this->GetLockMove()->bLock)
		return;


	int nIdx = m_ItemList.SearchID(dwItemID);

	if (nIdx)
	{
		if (bIsBreakAll)
		{
			while (Item[nIdx].GetStackNum() > nNum)
			{
				int p,x, y;
				if (m_ItemList.CheckCanPlaceInEquipment(Item[nIdx].GetWidth(), Item[nIdx].GetHeight(), &p, &x, &y) == FALSE)
					break;
				Item[nIdx].SetStackNum(Item[nIdx].GetStackNum() - nNum);
				m_ItemList.SyncItem(nIdx);

				int nIndex = ItemSet.Add(&Item[nIdx]);
				if (nIndex <= 0)
					break;
				Item[nIndex].SetStackNum(nNum);
				m_ItemList.Add(nIndex, p, x, y, false);
			}
		}
		else
		{
			if (Item[nIdx].GetStackNum() > nNum)
			{
				Item[nIdx].SetStackNum(Item[nIdx].GetStackNum() - nNum);
				m_ItemList.SyncItem(nIdx);

				int nIndex = ItemSet.Add(&Item[nIdx]);
				if (nIndex <= 0)
					return;
				Item[nIndex].SetStackNum(nNum);
				int	nIdx = m_ItemList.Hand();
				if (nIdx)
				{
					m_ItemList.Remove(nIdx);

					KMapPos sMapPos;
					KObjItemInfo	sInfo;

					GetAboutPos(&sMapPos);

					sInfo.m_nItemID = nIdx;
					sInfo.m_nItemWidth = Item[nIdx].GetWidth();
					sInfo.m_nItemHeight = Item[nIdx].GetHeight();
					sInfo.m_nMoneyNum = 0;
					strcpy(sInfo.m_szName, Item[nIdx].GetName());
					sInfo.m_nColorID = Item[nIdx].GetQuality();
					sInfo.m_nGenre = Item[nIdx].GetGenre();
					sInfo.m_nDetailType = Item[nIdx].GetDetailType();
					sInfo.m_nMovieFlag = 1;
					sInfo.m_nSoundFlag = 1;
					sInfo.m_bOverLook = 0;
					int nObj = ObjSet.Add(Item[nIdx].GetObjIdx(), sMapPos, sInfo);
					if (nObj >= 0)
					{
						if (Item[nIdx].GetLockTrade())
						{
							Object[nObj].SetEntireBelong(m_nPlayerIndex);
						}
						else
						{
							Object[nObj].SetItemBelong(m_nPlayerIndex);
						}
					}
				}
				m_ItemList.Add(nIndex, pos_hand, 0 ,0, false);
			}
		}
	}
}

void KPlayer::TradeStart(BYTE* pProtocol)
{
	if (m_bForbidTrade)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FUNCTION_FOBIDDENED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	if (!m_PTrade.nTrade && (
		Npc[m_nIndex].m_bRideHorse || m_cMenuState.m_nState != PLAYER_MENU_STATE_NORMAL))
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TRADE_BUZY;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	KLuaScript* pScript = (KLuaScript*)g_GetScript(SCRIPT_PROTOCOL_FILE);

	if (pScript)
	{
		Lua_PushNumber(pScript->m_LuaState, m_nPlayerIndex);
		pScript->SetGlobalName(SCRIPT_PLAYERINDEX);

		Lua_PushNumber(pScript->m_LuaState, m_dwID);
		pScript->SetGlobalName(SCRIPT_PLAYERID);

		Lua_PushNumber(pScript->m_LuaState, Npc[Player[m_nPlayerIndex].m_nIndex].m_SubWorldIndex);
		pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

		int nTopIndex = 0;
		int nReturn = 0;
		pScript->SafeCallBegin(&nTopIndex);
		pScript->CallFunction("PermitTrade", 1, "");
		nTopIndex = Lua_GetTopIndex(pScript->m_LuaState);
		nReturn = (int) Lua_ValueToNumber(pScript->m_LuaState, nTopIndex);
		pScript->SafeCallEnd(nTopIndex);

		if(!nReturn) return;
	}

	PLAYER_TRADE_START_COMMAND *pInfo = (PLAYER_TRADE_START_COMMAND *)pProtocol;
	Player[m_nPlayerIndex].m_PTrade.nTrade = !Player[m_nPlayerIndex].m_PTrade.nTrade;

	if (m_PTrade.nTrade)
	{
		if (GetTradeCount())
		{
			strcpy(m_PTrade.cName, pInfo->Name);
		}
		else
		{
			m_PTrade.Release();

			PLAYER_TRADE_START_FAIL_SYNC sync;
			sync.ProtocolType = s2c_playertradefail;
			g_pServer->PackDataToClient(m_nNetConnectIdx, &sync, sizeof(PLAYER_TRADE_START_FAIL_SYNC));
		}
	}
	else
	{
		Player[m_nPlayerIndex].SendTradeCancel();
	}
}

void KPlayer::SendTradeCancel()
{
	Player[m_nPlayerIndex].m_PTrade.Release();
	for (int i = 1; i < MAX_PLAYER; i ++)
	{
		if (Player[i].m_PTrade.nDest == m_nPlayerIndex)
		{
			PLAYER_TRADE_ACTION_SYNC	sSync;
			sSync.ProtocolType = s2c_playertradeaction;
			sSync.dwID = 0;
			sSync.bOpen = FALSE;
			if (Player[i].m_nNetConnectIdx != -1)
				g_pServer->PackDataToClient(Player[i].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(PLAYER_TRADE_ACTION_SYNC));
		}
	}
}

BOOL KPlayer::SendTradeItem( int nIndex)
{
	if (Player[nIndex].CheckTrading())
		return FALSE;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER || Player[nIndex].m_nIndex <= 0)
		return FALSE;

	int				nIdx, i, j;
	PHONGTHAN_TRADE_ITEM_INFO	*pInfo;

	PLAYER_TRADE_ITEM_SYNC	sSellItem;
	ZeroMemory(&sSellItem, sizeof(sSellItem));
	sSellItem.ProtocolType = s2c_playertradeitem;

	for (i = 0; i < MAX_PLAYER_ITEM; i++)
	{
		nIdx = m_ItemList.m_Items[i].nIdx;

		if (nIdx <= 0 || Item[nIdx].GetLock()->IsLock() ||
				Item[nIdx].GetLockTrade() || Item[nIdx].GetTradePrice() <= 0 || m_ItemList.m_Items[i].nPlace != pos_equiproom)
			continue;

		pInfo = &sSellItem.m_sInfo;

		pInfo->m_uPrice = Item[nIdx].GetTradePrice();
		pInfo->m_bX = m_ItemList.m_Items[i].nX;
		pInfo->m_bY = m_ItemList.m_Items[i].nY;
		pInfo->m_nIdx = m_ItemList.m_Items[i].nIdx;

		pInfo->m_nID			= Item[nIdx].GetID();
		pInfo->m_btGenre		= Item[nIdx].GetGenre();
		pInfo->m_WireVersion = PHONGTHAN_EMBEDDED_ITEM_VERSION;
		pInfo->m_nTemplateRow = Item[nIdx].GetRow();
		pInfo->m_btDetail = Item[nIdx].GetDetailType();
		pInfo->m_nParticularType		= Item[nIdx].GetParticular();
		pInfo->m_btSeries		= Item[nIdx].GetSeries();
		pInfo->m_btLevel		= Item[nIdx].GetLevel();
		pInfo->m_btLuck			= Item[nIdx].m_GeneratorParam.nLuck;
		pInfo->m_dwRandomSeed	= Item[nIdx].m_GeneratorParam.uRandomSeed;
		pInfo->m_wVersion		= Item[nIdx].m_GeneratorParam.nVersion;
		pInfo->m_nStackNum		= Item[nIdx].GetStackNum();
		pInfo->m_ExpireTime		= Item[nIdx].GetExpireTime();
		pInfo->m_nParam			= Item[nIdx].GetParam();
		pInfo->m_nFortune		= Item[nIdx].GetFortune();
		for (j = 0;j < MAX_ITEM_MAGICLEVEL;j++)
			pInfo->m_btMagicLevel[j] = (int)Item[nIdx].m_GeneratorParam.nGeneratorLevel[j];

		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, (BYTE*)&sSellItem, sizeof(sSellItem));
	}

	Player[nIndex].m_PTrade.nDest = m_nPlayerIndex;

	PLAYER_TRADE_ACTION_SYNC	command;
	command.ProtocolType = s2c_playertradeaction;
	command.dwID = Npc[m_nIndex].m_dwID;
	command.bOpen = TRUE;
	g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, (BYTE*)&command, sizeof(PLAYER_TRADE_ACTION_SYNC));
	return TRUE;
}

void KPlayer::SendTradeCount( int nIndex )
{
	if (nIndex <= 0 || nIndex >= MAX_PLAYER || Player[nIndex].m_nIndex <= 0)
		return;

	int nCount = 0;
	for (int i = 0;i < MAX_PLAYER_ITEM;i++)
	{
		int nIdx = m_ItemList.m_Items[i].nIdx;
		if (nIdx <= 0 || Item[nIdx].GetTradePrice() == 0 || m_ItemList.m_Items[i].nPlace != pos_equiproom)
			continue;

		nCount++;
	}

	if (nCount <= 0)
	{
		Player[m_nPlayerIndex].SendTradeCancel();
		return;
	}

	PLAYER_TRADE command;
	command.ProtocolType = s2c_playertradecount;
	command.dwID = Npc[m_nIndex].m_dwID;
	command.nParam = nCount;
	g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, (BYTE*)&command, sizeof(PLAYER_TRADE));
}

int KPlayer::GetTradeCount()
{
	int nCount = 0;
	for (int i = 0;i < MAX_PLAYER_ITEM;i++)
	{
		int nIdx = m_ItemList.m_Items[i].nIdx;
		if (nIdx <= 0 || Item[nIdx].GetTradePrice() == 0 || m_ItemList.m_Items[i].nPlace != pos_equiproom)
			continue;
		else
		nCount++;
	}

	return nCount;
}
#endif


#ifdef _SERVER
void KPlayer::ForbidEnmity(BOOL bFlag)
{
	this->m_bForbidEnmity = bFlag;
}

void KPlayer::ForbidTrade(BOOL bFlag)
{
	this->m_bForbidTrade = bFlag;
	if (m_bForbidTrade)
	{
		if (this->m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADEOPEN)
			this->TradeApplyClose(NULL);
	}
}

void KPlayer::ForbidUseTownP(BOOL bFlag)
{
	this->m_bForbidUseTownP = bFlag;
}

void KPlayer::ForbidName(BOOL bFlag)
{
	this->m_bForbidName = bFlag;
	Npc[m_nIndex].SendSyncData(0, TRUE);
}

void KPlayer::ForbidCamp(BOOL bFlag)
{
	this->m_bForbidCamp = bFlag;
}

void KPlayer::SendMSGroup()
{
	// ���ͻ��˷���Ϣ
	PLAYER_MISSION_DATA	sData;
	sData.ProtocolType = s2c_playermissiondata;
	sData.m_nMissionGroup = Npc[m_nIndex].m_nMissionGroup;
	if (g_pServer && m_nNetConnectIdx != -1)
		g_pServer->PackDataToClient(m_nNetConnectIdx, (BYTE*)&sData, sizeof(PLAYER_MISSION_DATA));
}

void KPlayer::SendMSRank(TMissionLadderSelfInfo* SelfData, TMissionLadderInfo* RankData)
{
	int i;
	PLAYER_MISSION_RANKDATA sData;
	sData.ProtocolType = s2c_syncrankdata;
	sData.SelfData = *SelfData;
	for(i =0;i<MISSION_STATNUM;i++)
		memcpy(&sData.MissionRank[i], &RankData[i], sizeof(RankData[i]));
	if (g_pServer && m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(m_nNetConnectIdx, &sData, sizeof(PLAYER_MISSION_RANKDATA));

	g_DebugLog("SendMSRank: %d", sData.SelfData); // Ko thay bay vao day
}

//TamLTM Fix set save pass Khoa ruong
void KPlayer::SetSavePw(char *szTask, BOOL bShow)
{
	this->m_cTask.SetSaveVal(TASKVALUE_BASEDATA_PASSWORD, szTask);
	int nTaskLen = strlen(szTask);
	if(nTaskLen > MIN_PASSWORD_LENGTH && nTaskLen <= MAX_PASSWORD_LENGTH)
	{
		m_bLock = TRUE;
		if(bShow)
			this->SendSystemMessage(MESSAGE_SYSTEM_ANNOUCE_PROTECT, "Thay ��i m�t m� b�o v� th�nh c�ng!");
	}
	else
	{
		if(bShow)
			this->SendSystemMessage(MESSAGE_SYSTEM_ANNOUCE_PROTECT, "M�t kh�a b�o v� �� ���c x�a b�! h�y thi�t l�p l�i m�t m� m�i!");
	}
	this->SetLockState(m_bLock);
}

//TamLTM Fix Check pass Khoa ruong
BOOL KPlayer::CheckSavePw(const char *szTask)
{
	if(strcmp(this->m_cTask.GetSaveStr(TASKVALUE_BASEDATA_PASSWORD),szTask)==0)
	{
		SetLockState(FALSE);
		SendSystemMessage(MESSAGE_SYSTEM_ANNOUCE_PROTECT, "Gi�i m� kh�a b�o v� th�nh c�ng!");
		m_bOk = TRUE;
	}
	else
		SendSystemMessage(MESSAGE_SYSTEM_ANNOUCE_PROTECT, "Gi�i m� kh�a b�o v� th�t b�i: m�t m� ki�m ch�ng kh�ng ch�nh x�c!");

	return m_bOk;
}


int KPlayer::Compound(int nKind)
{
	int nIdx1=m_ItemList.GetCompoundItem(compound_box1);
	int nIdx2=m_ItemList.GetCompoundItem(compound_box2);
	int nIdx3=m_ItemList.GetCompoundItem(compound_box3);

	int nIndex=0;

	switch (nKind)
	{
	case CPA_FUSION:
		{
		int nLevel = Item[nIdx1].GetLevel();
		nLevel += Item[nIdx2].GetLevel();
		nLevel += Item[nIdx3].GetLevel();

		int nMax = nLevel / 5;
		int nMin = nLevel / 10;
		if (nMin < 0) nMin = 1;

		nIndex = ItemSet.Add(item_magicscript,series_nil,::GetRandomNumber(nMin,nMax),0,146,0);
		}
		break;
	case CPA_CRYOLITE:
		{
		int nLevel = Item[nIdx1].GetLevel();
		int nNum = Item[nIdx1].GetStackNum() + Item[nIdx2].GetStackNum() + Item[nIdx3].GetStackNum();

		nNum = nNum / 3;

		for (int i = 0;i < nNum;i++)
		{
			if (GetRandomNumber(0,10) <= 1)
				nNum--;
		}

		if (nNum == 0)
		{
			m_ItemList.Remove(nIdx1);
			return 0;
		}

		nIndex = ItemSet.Add(item_magicscript,series_nil,nLevel + 1,0,146,0);
		Item[nIndex].SetStackNum(nNum);
		}
		break;
	case CPA_PROPMINE:
		{
		int nDetailTyple = Item[nIdx1].GetDetailType();
		int nSerise = Item[nIdx1].GetSeries();
		int nLevel = Item[nIdx1].GetLevel();
		int nLuck = Item[nIdx1].GetItemParam()->nLuck;
		int nItemLevel[MAX_ITEM_MAGICLEVEL];
		ZeroMemory(nItemLevel, sizeof(nItemLevel));
		nItemLevel[0] = Item[nIdx1].GetItemParam()->nGeneratorLevel[0];

		if (::GetRandomNumber(0,10) <= 1)
		{
			m_ItemList.Remove(nIdx1);
			return 0;
		}

		nIndex = ItemSet.Add(item_magicscript,nSerise,nLevel + 1,nLuck,nDetailTyple,0,nItemLevel);
		}
		break;
	}

	m_ItemList.Remove(nIdx1);
	m_ItemList.Remove(nIdx2);
	m_ItemList.Remove(nIdx3);

	if (nIndex < 0)
	{
		return 0;
	}

	int		p, x, y;
	if (m_ItemList.CheckCanPlaceInEquipment(Item[nIndex].GetWidth(), Item[nIndex].GetHeight(), &p, &x, &y))
	{
		m_ItemList.Add(nIndex, p, x, y);
	}
	return nIndex;
}

int KPlayer::Enchase(int nKind,int nId1,int nId2,int nId3)
{
	int nIndex=0;

	switch(nKind)
	{
/*	case ECA_DISTILL:
		{
		int nId1=m_ItemList.GetCompoundItem(compound_box1);
		int nId2=m_ItemList.GetCompoundItem(compound_box2);
		int nId3=m_ItemList.GetCompoundItem(compound_box3);
		int nPlace = Item[nId3].GetDetailType() - 148;

		nMin += Item[nId2].GetLevel() + Item[nId1].GetItemParam()->nGeneratorLevel[nPlace] - 15;
		if (nMin < 1) nMin = 1;

		int nMax = nMin + Item[nId2].GetLevel();

		int nAdd = ::GetRandomNumber(nMin,nMax);

		if (nAdd > 10) nAdd = 10;

		if (3 > ::GetRandomNumber(nMin,nMax))
		{
			m_ItemList.Remove(nId2);
			m_ItemList.Remove(nId3);
			return 0;
		}

		int nSerise = Item[nId1].GetSeries();
		int nLuck = Item[nId2].GetItemParam()->nLuck;
		int nItemLevel[MAX_ITEM_MAGICLEVEL];
		ZeroMemory(nItemLevel, sizeof(nItemLevel));
		nItemLevel[0] = Item[nId1].m_aryMagicAttrib[nPlace].nAttribType;

		if (nLuck < 0)
		{
			return 0;
		}
		nIndex = ItemSet.Add(item_magicscript,nSerise,0,nLuck,nPlace+199,0,nItemLevel);;
		m_ItemList.Remove(nId1);
		m_ItemList.Remove(nId2);
		m_ItemList.Remove(nId3);
		}
		break;
	case ECA_FORGE:
		{
		int nId1=m_ItemList.GetCompoundItem(compound_box1);
		int nId2=m_ItemList.GetCompoundItem(compound_box2);
		int nMax = Item[nId2].GetLevel() + 2;
		int nMin = Item[nId2].GetLevel();

		if (nMax > 5) nMax = 5;
		if (nMin > 5) nMax = 5;

		if (nMax < 1) nMax = 1;
		if (nMin < 1) nMax = 1;

		int nLuck = ::GetRandomNumber(nMin,nMax);

		int nItemClass		= Item[nId1].GetGenre();
		int nDetailType		= Item[nId1].GetDetailType();
		int nParticularType	= Item[nId1].GetParticular();
		int nLevel			= Item[nId1].GetLevel();
		int nSeries			= Item[nId1].GetSeries();
		int nItemLevel[MAX_ITEM_MAGICLEVEL];
		ZeroMemory(nItemLevel, sizeof(nItemLevel));

		nIndex = ItemSet.Add(nItemClass,nSeries,nLevel,nLuck,nDetailType,nParticularType,nItemLevel);
		m_ItemList.Remove(nId1);
		m_ItemList.Remove(nId2);
		}
		break;*/
	case ECA_ENCHASE:
		{
		if (::GetRandomNumber(0,MAX_PERCENT) < 5)
		{
			m_ItemList.Remove(nId2);
			m_ItemList.Remove(nId3);
			return 0;
		}

		//int nId1=m_ItemList.GetCompoundItem(compound_box1);
		//int nId2=m_ItemList.GetCompoundItem(compound_box2);
		//int nId3=m_ItemList.GetCompoundItem(compound_box3);
		int nPlace = Item[nId3].GetDetailType() - 199;

		int nLevelAdd = (Item[nId2].GetLevel() + Item[nId3].GetLevel())/2;

		int nItemClass		= Item[nId1].GetGenre();
		int nDetailType		= Item[nId1].GetDetailType();
		int nParticularType	= Item[nId1].GetParticular();
		int nLevel			= Item[nId1].GetLevel();
		int nSeries			= Item[nId1].GetSeries();
		int nLucky			= Item[nId1].GetItemParam()->nLuck;
		int nItemLevel[MAX_ITEM_MAGICLEVEL];
		ZeroMemory(nItemLevel, sizeof(nItemLevel));

		KTabFile tabMagic;
		tabMagic.Load(MAGICATTRIB_LVINDEX_FILE);

		int nRow, nMinRow, nColumn, nNeedSr, nMagic;
		char szTmp[8];
		sprintf(szTmp,"%d",Item[nId3].GetItemParam()->nLuck);
		nRow = tabMagic.FindRow(szTmp);

		tabMagic.GetInteger(nRow,"MAGATTRLVL_START",0,&nMinRow);
		nMinRow += nLevelAdd;
		tabMagic.Clear();
		tabMagic.Load(MAGICATTRIB_LEVEL_FILE);
		tabMagic.GetInteger(nMinRow, 3,series_nil,&nNeedSr);
		//g_DebugLog("%d",nLevelAdd);
		if(nNeedSr != series_nil && nNeedSr != nSeries)
			return 0;
		switch(nDetailType)
		{
			case equip_meleeweapon:
				nColumn = nParticularType + 13;
				break;
			case equip_rangeweapon:
				nColumn = nParticularType + MAX_MELEE_WEAPON + 13;
				break;
			default:
				nColumn = nDetailType + MAX_WEAPON;
				break;
		}
		tabMagic.GetInteger(nMinRow, nColumn,0,&nMagic);
		if (nMagic <= 0)
		{
			return 0;
		}
		for (int k = 0;k < MAX_ITEM_MAGICATTRIB;k++)
		{
			if (nPlace > k)
			{
				if (Item[nId1].m_aryMagicAttrib[k].nAttribType <= 0 || Item[nId1].m_aryMagicAttrib[k].nAttribType == Item[nId3].GetItemParam()->nLuck)
				{
					return 0;
				}
			}
			else if (nPlace == k &&  Item[nId1].m_aryMagicAttrib[k].nAttribType <= 0)
			{
				KItemNormalAttrib sMA;
				int nType,nMax,nMin;
				tabMagic.GetInteger(nMinRow,5,0,&nType);
				tabMagic.GetInteger(nMinRow,6,0,&nMin);
				tabMagic.GetInteger(nMinRow,7,0,&nMax);
				sMA.nAttribType = nType;
				sMA.nValue[0] = ::GetRandomNumber(nMin, nMax);
				tabMagic.GetInteger(nMinRow,8,0,&nMin);
				tabMagic.GetInteger(nMinRow,9,0,&nMax);
				sMA.nValue[1] = ::GetRandomNumber(nMin, nMax);
				tabMagic.GetInteger(nMinRow,10,0,&nMin);
				tabMagic.GetInteger(nMinRow,11,0,&nMax);
				sMA.nValue[2] = ::GetRandomNumber(nMin, nMax);

				nItemLevel[k] = Item[nId3].GetItemParam()->nLuck;
				nItemLevel[k+MAX_ITEM_MAGICATTRIB] = MAKELONG(sMA.nValue[0], sMA.nValue[2]);
				continue;
			}
			else if (nPlace == k && Item[nId1].m_aryMagicAttrib[k].nAttribType > 0)
			{
				return 0;
			}
			nItemLevel[k] = Item[nId1].GetItemParam()->nGeneratorLevel[k];
			nItemLevel[k+MAX_ITEM_MAGICATTRIB] = Item[nId1].GetItemParam()->nGeneratorLevel[k+MAX_ITEM_MAGICATTRIB];
		}

		nIndex = ItemSet.Add(nItemClass,nSeries,nLevel,nLucky,nDetailType,nParticularType,nItemLevel);
		m_ItemList.Remove(nId1);
		m_ItemList.Remove(nId2);
		m_ItemList.Remove(nId3);
		}
		break;
	}

	if (nIndex < 0)
	{
		return 0;
	}

	int		p,x, y;
	if (m_ItemList.CheckCanPlaceInEquipment(Item[nIndex].GetWidth(), Item[nIndex].GetHeight(), &p, &x, &y))
	{
		m_ItemList.Add(nIndex, p, x, y);
	}
	return nIndex;
}

#endif

//TamLTM da tau quest
#ifdef _SERVER
void	KPlayer::LoadScript(int nScript)
{
	char ScriptName[64];

//	g_DebugLog("LoadScript->nScript: %d", nScript);

	if (nScript == 1)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_exp.lua");
	//	g_DebugLog("quest_exp.lua->nScript: %d", nScript);
	}
	else if (nScript == 2)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_item.lua");
	//	g_DebugLog("quest_item.lua->nScript: %d", nScript);
	}
	else if (nScript == 3)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_luck.lua");
	//	g_DebugLog("quest_luck.lua->nScript: %d", nScript);
	}
	else if (nScript == 4)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_money.lua");
	//	g_DebugLog("quest_money.lua->nScript: %d", nScript);
	}
	else if (nScript == 5)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_point.lua");
	//	g_DebugLog("quest_point.lua->nScript: %d", nScript);
	}
	else if (nScript == 6)
	{
		sprintf(ScriptName,"\\script\\system\\datau\\quest_random.lua");
	//	g_DebugLog("quest_random.lua->nScript: %d", nScript);
	}
	this->ExecuteScript(ScriptName, "main", "");
}
#endif
//end code

//TamLTM da tau quest
#ifdef _SERVER
void	KPlayer::LoadScriptProgressBar(int nScript)
{
	char ScriptName[64];

//	g_DebugLog("LoadScriptProgressBar->nScript: %d", nScript);

	if (nScript == 1)
	{
		sprintf(ScriptName, "\\script\\event\\demhuyhoang\\eventdabiet\\huyhoang.lua");
	}
	else if (nScript == 2)
	{
		sprintf(ScriptName, "\\script\\event\\demhuyhoang\\eventdabiet\\huyboprogressbar.lua");
	}
	this->ExecuteScript(ScriptName, "main", "");
}
#endif
//end code

//TamLTM Uy thac Offline
#ifdef _SERVER
void KPlayer::Offline()
{
    char scriptName[255];
    sprintf(scriptName,"\\script\\system\\uythac.lua"); //Duong dan den script
    ExecuteScript(scriptName,"main",0);
}
#endif
//end code

//TamLTM Code load sql get Address MAC
#ifdef _SERVER
//Get SQL
int id;
char name[32];
//int iClientID;
int nMac;

void KPlayer::GetMacInSQL(IN char *cAccountName) {

	SQLHANDLE SQLEnvHandle = NULL;
	SQLHANDLE SQLConnectionHandle = NULL;
	SQLHANDLE SQLStatementHandle = NULL;
	SQLRETURN retCode = 0;

	bool isCheckData = false;

	char SQLQuery[] = "SELECT * FROM Account_Info";

	do {
		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &SQLEnvHandle))
			// Allocates the environment
			break;

		if (SQL_SUCCESS != SQLSetEnvAttr(SQLEnvHandle, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0))
			// Sets attributes that govern aspects of environments
			break;

		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_DBC, SQLEnvHandle, &SQLConnectionHandle))
			// Allocates the connection
			break;

		if (SQL_SUCCESS != SQLSetConnectAttr(SQLConnectionHandle, SQL_LOGIN_TIMEOUT, (SQLPOINTER)5, 0))
			// Sets attributes that govern aspects of connections
			break;

		SQLCHAR retConString[1024]; // Conection string

		//Kieu Connect SQL Server
		/*switch (SQLDriverConnect(SQLConnectionHandle,NULL,(SQLCHAR*)"DRIVER={SQL Server}; SERVER=localhost, 1433; DATABASE=myDB; UID=myID; PWD=@myPW;",
			SQL_NTS,
			retConString,
			1024,
			NULL,
			SQL_DRIVER_NOPROMPT))*/

		//Connect database KV-PC
		switch (SQLDriverConnect(SQLConnectionHandle,
			NULL,
			(SQLCHAR*)connectDBGet,
			SQL_NTS,
			retConString,
			1024,
			NULL,
			SQL_DRIVER_NOPROMPT)) {
			// Establishes connections to a driver and a data source
		case SQL_SUCCESS:
			break;
		case SQL_SUCCESS_WITH_INFO:
			break;
		case SQL_NO_DATA_FOUND:
			retCode = -1;
			break;
		case SQL_INVALID_HANDLE:
			retCode = -1;
			break;
		case SQL_ERROR:
			retCode = -1;
			break;
		default:
			break;
		}

		if (retCode == -1)
			break;

		if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_STMT, SQLConnectionHandle, &SQLStatementHandle))
			// Allocates the statement
			break;

		if (SQL_SUCCESS != SQLExecDirect(SQLStatementHandle, (SQLCHAR*)SQLQuery, SQL_NTS)) {
			// Executes a preparable statement
			break;
		}
		else
		{
			while (SQLFetch(SQLStatementHandle) == SQL_SUCCESS)
			{
				if (isCheckData)
					return;

				// Fetches the next rowset of data from the result
				SQLGetData(SQLStatementHandle, 1, SQL_C_DEFAULT, &id, sizeof(id), NULL); //, 1, la cot can get data sql
				SQLGetData(SQLStatementHandle, 2, SQL_C_DEFAULT, &name, sizeof(name), NULL);
				SQLGetData(SQLStatementHandle, 20, SQL_C_DEFAULT, &nMac, sizeof(nMac), NULL); //20 la cot client id
				// Retrieves data for a single column in the result set
			//	g_DebugLog("iid %d", id);
			//	g_DebugLog("accountName %s", name);
			//	g_DebugLog("nMac %d", nMac);

				std::string nameSql(name);
				std::string accName(AccountName);

				std::string cAccName(cAccountName);

				if (cAccName == nameSql)
				{
				//	AddExtPoint(200, 0);
				}

				if (accName == nameSql)
				{
				//	g_DebugLog("nMac Ok SQL %d", nMac);
					m_nMacDatabase = nMac;
					isCheckData = true;
				}

			//	cout << name << " " << age << endl;
			}
		}
	} while (FALSE);

	SQLFreeHandle(SQL_HANDLE_STMT, SQLStatementHandle);
	SQLDisconnect(SQLConnectionHandle);
	SQLFreeHandle(SQL_HANDLE_DBC, SQLConnectionHandle);
	SQLFreeHandle(SQL_HANDLE_ENV, SQLEnvHandle);
}

int KPlayer::GetMacSQL()
{
	//them MAC gioi han cua so // anti 3 acc by veg
	DWORD Address;
	BYTE MacAddress[6];
	gGetMacAndIPAddress(NULL, NULL, MacAddress, &Address);
	DWORD Id = 0;
	for (int i = 0; i < 6; i++)
	{
		Id = (Id + (i + 1) * MacAddress[i]) % 0x8000000b * 0xffffffef;
	}
	Address = Id ^ 0x12345678;
	int CoverAddress = Address;

//	GetMacInSQL(AccountName);
//	g_DebugLog("GetMacSQL %d + %s", m_nMacDatabase, AccountName);
	return CoverAddress;
}

#endif

//Get Version game, Get number version update game neu truong hop chua update
int KPlayer::GetVersionGame()
{
//	g_DebugLog("m_nVersionGame %d", m_nVersionGame);
//	m_nVersionGame = 5;
    return m_nVersionGame;
}

//end code
