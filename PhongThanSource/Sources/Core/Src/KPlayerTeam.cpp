//---------------------------------------------------------------------------
// Sword3 Engine (c) 2002 by Kingsoft
//
// File:	KPlayerTeam.cpp
// Date:	2002.01.06
// Code:	边城浪子
// Desc:	Team Class
//---------------------------------------------------------------------------

#include	"KCore.h"
#include	"KNpc.h"
#ifdef _SERVER
//#include	"KNetServer.h"
//#include "../../Headers/IServer.h"
#else
//#include	"KNetClient.h"
#include "../../Headers/IClient.h"
#include	"CoreShell.h"
#endif
#include	"KPlayer.h"
#include	"KPlayerSet.h"
#include	"KPlayerTeam.h"
//#include	"MyAssert.h"

KTeam		g_Team[MAX_TEAM];
#ifdef _SERVER
KTeamSet	g_TeamSet;
#endif

#ifndef _SERVER
KPlayerTeam::KPlayerTeam()
{
	Release();
}
#endif

#ifndef _SERVER
void	KPlayerTeam::Release()
{
	m_nFlag = 0;
	m_nFigure = TEAM_CAPTAIN;
	m_nApplyCaptainID = -1;
	m_nApplyCaptainID = 0;
	m_dwApplyTimer = 0;
	m_bAutoRefuseInviteFlag = FALSE;	 // TRUE 自动拒绝   FALSE 手动
	ReleaseList();
	m_bAutoAccept = FALSE;
	m_bAutoAcceptWithName = FALSE;
	m_bPKFollowCaptain = Team_S_NonFollow;
}
#endif

#ifndef _SERVER
void	KPlayerTeam::ReleaseList()
{
	for (int i = 0; i < MAX_TEAM_APPLY_LIST; i++)
		m_sApplyList[i].Release();
}
#endif


#ifndef _SERVER
BOOL	KPlayerTeam::ApplyCreate()//char *lpszTeamName)
{
	if (m_nFlag)
		return FALSE;

	PLAYER_APPLY_CREATE_TEAM	sCreateTeam;
	sCreateTeam.ProtocolType = c2s_teamapplycreate;
	sCreateTeam.dwID = Player[CLIENT_PLAYER_INDEX].GetPlayerID();			
	sCreateTeam.dwTimePacker = GetTickCount();

	if (g_pClient)
		g_pClient->SendPackToServer(&sCreateTeam, sizeof(PLAYER_APPLY_CREATE_TEAM));

	return TRUE;
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：邀请加入队伍
//---------------------------------------------------------------------------
void	KPlayerTeam::InviteAdd(DWORD dwNpcID)
{
//	if ( !this->m_nFlag || this->m_nFigure != TEAM_CAPTAIN || g_Team[0].m_nState != Team_S_Open)
//		return;
	TEAM_INVITE_ADD_COMMAND	sAdd;
	sAdd.ProtocolType = c2s_teaminviteadd;
	sAdd.dwID = Player[CLIENT_PLAYER_INDEX].GetPlayerID();			
	sAdd.dwTimePacker = GetTickCount();
	sAdd.m_dwNpcID = dwNpcID;
	if (g_pClient)
		g_pClient->SendPackToServer(&sAdd, sizeof(TEAM_INVITE_ADD_COMMAND));
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：收到邀请
//---------------------------------------------------------------------------
void	KPlayerTeam::ReceiveInvite(TEAM_INVITE_ADD_SYNC *pInvite)
{
	if ( !pInvite )
		return;
	char	szName[32];
	int		nIdx;
	memset(szName, 0, sizeof(szName));
	memcpy(szName, pInvite->m_szName, sizeof(pInvite->m_szName) - (sizeof(TEAM_INVITE_ADD_SYNC) - pInvite->m_wLength - 1));
	nIdx = pInvite->m_nIdx;

	// pt to doi
	if (m_bAutoRefuseInviteFlag && 
		Player[CLIENT_PLAYER_INDEX].m_cAI.m_bAutoParty)
	{
		ReplyInvite(nIdx, 0);
		return;
	}

	//TamLTM auto pt to doi
	if (m_bAutoAccept && 
			Player[CLIENT_PLAYER_INDEX].m_cAI.m_bAutoParty)
	{
		ReplyInvite(nIdx, 1);
		return;
	}
	if (m_bAutoAcceptWithName && 
			Player[CLIENT_PLAYER_INDEX].m_cAI.m_bAutoParty && 
			Player[CLIENT_PLAYER_INDEX].m_cAI.CheckPTList(szName))
	{
		ReplyInvite(nIdx, 1);
		return;
	}
	//end code

	// 通知界面有人邀请玩家加入某个队伍
	KUiPlayerItem	sPlayer;
	KSystemMessage	sMsg;

	strcpy(sPlayer.Name, szName);
	sPlayer.nIndex = pInvite->m_nIdx;
	sPlayer.uId = 0;
	sPlayer.nData = 0;

	sprintf(sMsg.szMessage, MSG_TEAM_GET_INVITE, szName);
	sMsg.eType = SMT_TEAM;
	sMsg.byConfirmType = SMCT_UI_TEAM_INVITE;
	sMsg.byPriority = 3;
	sMsg.byParamSize = sizeof(KUiPlayerItem);
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, (int)&sPlayer);
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：回复邀请
//	参数：nResult  if == 0 拒绝  if == 1 接受
//---------------------------------------------------------------------------
void	KPlayerTeam::ReplyInvite(int nIdx, int nResult)
{
	if (nIdx < 0 || nResult < 0 || nResult > 1)
		return;
	TEAM_REPLY_INVITE_COMMAND	sReply;
	sReply.ProtocolType = c2s_teamreplyinvite;
	sReply.dwID = Player[CLIENT_PLAYER_INDEX].GetPlayerID();			
	sReply.dwTimePacker = GetTickCount();
	sReply.m_nIndex = nIdx;
	sReply.m_btResult = nResult;
	if (g_pClient)
		g_pClient->SendPackToServer(&sReply, sizeof(TEAM_REPLY_INVITE_COMMAND));
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：设定是否自动拒绝别人的加入队伍的邀请
//---------------------------------------------------------------------------
void	KPlayerTeam::SetAutoRefuseInvite(BOOL bFlag)
{
	if (bFlag)
		m_bAutoRefuseInviteFlag = TRUE;
	else
		m_bAutoRefuseInviteFlag = FALSE;
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：获得是否自动拒绝别人的加入队伍的邀请状态
//---------------------------------------------------------------------------
BOOL	KPlayerTeam::GetAutoRefuseState()
{
	return m_bAutoRefuseInviteFlag;
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：获得自身队伍信息（给界面）
//---------------------------------------------------------------------------
//TamLTM auto pt to doi
int		KPlayerTeam::GetInfo(KUiPlayerTeam *pTeam)
{
	if (!pTeam)
		return 0;
	pTeam->nCaptainPower = g_Team[0].CalcCaptainPower();

	if (m_nFlag == 0)
	{
		pTeam->bTeamLeader = false;
		pTeam->cNumTojoin = 0;
		pTeam->nTeamServerID = -1;
		pTeam->cNumMember = 0;
		pTeam->bOpened = Team_S_Close;
		pTeam->nModePick = -1;
		pTeam->bPKFollowCaptain = Team_S_NonFollow;
		return 0;
	}

	if (m_nFigure == TEAM_CAPTAIN)
	{
		pTeam->bTeamLeader = true;
		int nNo = 0;
		for (int i = 0; i < MAX_TEAM_APPLY_LIST; i++)
		{
			if (this->m_sApplyList[i].m_dwNpcID > 0)
				nNo++;
		}
		pTeam->cNumTojoin = nNo;
	}
	else
	{
		pTeam->bTeamLeader = false;
		pTeam->cNumTojoin = 0;
	}
	pTeam->nTeamServerID = g_Team[0].m_nTeamServerID;
	pTeam->cNumMember = g_Team[0].m_nMemNum + 1;
	pTeam->bOpened = g_Team[0].m_nState;
	pTeam->nModePick = g_Team[0].m_nModePick;
	pTeam->bPKFollowCaptain = m_bPKFollowCaptain;
	return 1;
}

void	KPlayerTeam::SetPKFollowCaptain(BOOL bFlag)
{
	m_bPKFollowCaptain = Team_S_NonFollow;
	if (bFlag)
		m_bPKFollowCaptain = Team_S_PKFollow;
}

void	KPlayerTeam::SetCreatTeamFlag(BOOL bFlag)
{
	m_bCreatTeamFlag = FALSE;
	if (bFlag)
		m_bCreatTeamFlag = TRUE;
}
//end code
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：更新界面显示
//---------------------------------------------------------------------------
void	KPlayerTeam::UpdateInterface()
{
	KUiPlayerTeam	sTeam;
	if (GetInfo(&sTeam) == 0)
	{
		CoreDataChanged(GDCNI_TEAM, NULL, 0);
	}
	else
	{
		CoreDataChanged(GDCNI_TEAM, (unsigned int)&sTeam, 0);
	}
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：从申请人列表中删除某个申请人
//---------------------------------------------------------------------------
void	KPlayerTeam::DeleteOneFromApplyList(DWORD dwNpcID)
{
	for (int i = 0; i < MAX_TEAM_APPLY_LIST; i++)
	{
		if (m_sApplyList[i].m_dwNpcID == dwNpcID)
		{
			m_sApplyList[i].Release();
			return;
		}
	}
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：清空
//---------------------------------------------------------------------------
void	KPlayerTeam::Release()
{
	m_nFlag = 0;
	m_nID = -1;
	m_nFigure = 0;
	m_nApplyCaptainID = 0;
	memset(m_nInviteList, 0, sizeof(m_nInviteList));
	m_nListPos = 0;
}
#endif

#ifdef _SERVER
BOOL	KPlayerTeam::CreateTeam(int nIdx, PLAYER_APPLY_CREATE_TEAM *pCreateTeam)
{
	_ASSERT(pCreateTeam);

	// 当前处于不能组队状态
	if (!m_bCreatTeamFlag)
	{
		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
		sCreateFalse.m_btErrorID = Team_Create_Error_CannotCreate;
		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
		return FALSE;
	}

	if (m_nFlag)	// 队伍创建失败：已在队伍中
	{
		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
		sCreateFalse.m_btErrorID = Team_Create_Error_InTeam;
		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
		return FALSE;
	}

	if (Player[nIdx].m_cPK.GetNormalPKState() == enumPKTongWar)
	{
		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
		sCreateFalse.m_btErrorID = Team_Create_Error_NormalPK;
		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
		return FALSE;
	}
//	char	szTeamName[32];
//	memcpy(szTeamName, pCreateTeam->m_szTeamName, sizeof(szTeamName));
//	szTeamName[31] = 0;
//	if ( !szTeamName[0] )
//	{
//		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
//		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
//		sCreateFalse.m_btErrorID = Team_Create_Error_Name;
//		SendToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
//		return FALSE;
//	}
	// 创建队伍
	m_nID = g_TeamSet.CreateTeam(nIdx);//, szTeamName);
	if (m_nID >= 0)	// 队伍创建成功
	{
		m_nFlag = 1;
		m_nFigure = TEAM_CAPTAIN;
		m_nApplyCaptainID = 0;
		Npc[Player[nIdx].m_nIndex].RestoreCurrentCamp();

		if (Player[nIdx].m_cMenuState.m_nState == PLAYER_MENU_STATE_TRADEOPEN)
			Player[nIdx].m_cMenuState.SetState(nIdx, PLAYER_MENU_STATE_NORMAL);

		PLAYER_SEND_CREATE_TEAM_SUCCESS	sCreateSuccess;
		sCreateSuccess.ProtocolType = s2c_teamcreatesuccess;
		sCreateSuccess.nTeamServerID = m_nID;

		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateSuccess, sizeof(PLAYER_SEND_CREATE_TEAM_SUCCESS));
		g_Team[m_nID].SetTeamOpen();
		g_Team[m_nID].NotifyModePick();

		return TRUE;
	}
//	else if (m_nID == -1)					// 队伍创建失败：同名
//	{
//		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
//		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
//		sCreateFalse.m_btErrorID = Team_Create_Error_SameName;
//		SendToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
//		return FALSE;
//	}
	else if (m_nID == -2)
	{
		PLAYER_SEND_CREATE_TEAM_FALSE	sCreateFalse;
		sCreateFalse.ProtocolType = s2c_teamcreatefalse;
		sCreateFalse.m_btErrorID = Team_Create_Error_TeamFull;
		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, (BYTE*)&sCreateFalse, sizeof(PLAYER_SEND_CREATE_TEAM_FALSE));
		return FALSE;
	}
	else	// 其他错误
	{
		return FALSE;
	}

	return TRUE;
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：转发邀请加入队伍
//---------------------------------------------------------------------------
void	KPlayerTeam::InviteAdd(int nIdx, TEAM_INVITE_ADD_COMMAND *pAdd)
{
	if (!pAdd)
		return;
	// 如果不在队伍中或者不是队长或者队伍未开放
	if ( !this->m_nFlag || this->m_nFigure != TEAM_CAPTAIN)
	{
		return;
	}

	//TamLTM auto pt to doi
	if (!g_Team[this->m_nID].IsOpen())
	{
		if (Player[nIdx].m_cMenuState.m_bBackTeamState == true)
		{
			Player[nIdx].m_cMenuState.SetState(nIdx, PLAYER_MENU_STATE_NORMAL);
		}
		else
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_CANNOT_INVITE_TEAM;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			return;
		}
	}
	//end code

	int nTargetIdx = Player[nIdx].FindAroundPlayer(pAdd->m_dwNpcID);
	if (nTargetIdx == -1)
		return;
	if (!Player[nTargetIdx].m_cTeam.m_bCreatTeamFlag)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TARGET_CANNOT_ADD_TEAM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	this->m_nInviteList[this->m_nListPos] = nTargetIdx;
	this->m_nListPos++;
	this->m_nListPos %= MAX_TEAM_MEMBER;
	TEAM_INVITE_ADD_SYNC	sAdd;
	sAdd.ProtocolType = s2c_teaminviteadd;
	sAdd.m_nIdx = nIdx;
	memset(sAdd.m_szName, 0, sizeof(sAdd.m_szName));
	strcpy(sAdd.m_szName, Npc[Player[nIdx].m_nIndex].Name);
	sAdd.m_wLength = sizeof(TEAM_INVITE_ADD_SYNC) - 1 - sizeof(sAdd.m_szName) + strlen(sAdd.m_szName);
	g_pServer->PackDataToClient(Player[nTargetIdx].m_nNetConnectIdx, (BYTE*)&sAdd, sAdd.m_wLength + 1);


	SHOW_MSG_SYNC	sMsg;
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wMsgID = enumMSG_ID_GET_INVITE_TEAM_REPLY;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID) + sizeof(sAdd.m_szName);
	sMsg.m_lpBuf = new BYTE[sMsg.m_wLength + 1];
	memcpy(sMsg.m_lpBuf, &sMsg, sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID));
	memcpy((char*)sMsg.m_lpBuf + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), sAdd.m_szName, sizeof(sAdd.m_szName));
	g_pServer->PackDataToClient(Player[nIdx].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：收到邀请加入队伍的回复
//---------------------------------------------------------------------------
void	KPlayerTeam::GetInviteReply(int nSelfIdx, int nTargetIdx, int nResult)
{
	// 状态对不对
	if (!m_nFlag || m_nFigure != TEAM_CAPTAIN)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_APPLY_INVITE_FAIL;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nTargetIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	//TamLTM auto pt to doi
	if (!g_Team[m_nID].IsOpen() && !Player[nSelfIdx].m_cMenuState.m_bBackTeamState)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_APPLY_INVITE_FAIL2;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nTargetIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	// 有没有邀请
	int i;
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (m_nInviteList[i] == nTargetIdx)
			break;
	}
	if (i >= MAX_TEAM_MEMBER)
		return;
	if (Player[nTargetIdx].m_nIndex == 0)
		return;

	// 对方拒绝邀请
	if (nResult == 0)
	{
		// 需要向队长发消息通知对方拒绝
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_REFUSE_INVITE;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID) + sizeof(Npc[Player[nTargetIdx].m_nIndex].Name);
		sMsg.m_lpBuf = new BYTE[sMsg.m_wLength + 1];
		memcpy(sMsg.m_lpBuf, &sMsg, sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID));
		memcpy((char*)sMsg.m_lpBuf + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), Npc[Player[nTargetIdx].m_nIndex].Name, sizeof(Npc[Player[nTargetIdx].m_nIndex].Name));
		g_pServer->PackDataToClient(Player[nSelfIdx].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
		return;
	}

	if (g_Team[m_nID].m_nMemNum >= MAX_TEAM_MEMBER ||
		g_Team[m_nID].m_nMemNum >= g_Team[m_nID].CalcCaptainPower())
		return;
	// 自动离队
	if (Player[nTargetIdx].m_cTeam.m_nFlag)
	{
		PLAYER_APPLY_LEAVE_TEAM	sLeave;
		sLeave.ProtocolType = c2s_teamapplyleave;
		sLeave.bMySelf = FALSE;
		Player[nTargetIdx].LeaveTeam((BYTE*)&sLeave);
	}
	// 队伍添加成员
	if ( !g_Team[m_nID].AddMember(nTargetIdx) )
		return;
	// 改变队伍状态
	if (g_Team[m_nID].m_nMemNum >= MAX_TEAM_MEMBER || g_Team[m_nID].CheckFull())
	{
		g_Team[m_nID].SetTeamClose();
	}
	// 被接受队员队伍数据处理
	Player[nTargetIdx].m_cTeam.Release();
	Player[nTargetIdx].m_cTeam.m_nFlag = 1;
	Player[nTargetIdx].m_cTeam.m_nFigure = TEAM_MEMBER;
	Player[nTargetIdx].m_cTeam.m_nID = m_nID;
	Npc[Player[nTargetIdx].m_nIndex].SetCurrentCamp(Npc[Player[nSelfIdx].m_nIndex].m_Camp);


	// 给各个队员发消息
	PLAYER_TEAM_ADD_MEMBER	sAddMem;
	memset(sAddMem.m_szName, 0, sizeof(sAddMem.m_szName));
	sAddMem.ProtocolType = s2c_teamaddmember;
	sAddMem.m_dwNpcID = Npc[Player[nTargetIdx].m_nIndex].m_dwID;
	sAddMem.m_btLevel = (DWORD)Npc[Player[nTargetIdx].m_nIndex].m_Level;
	strcpy(sAddMem.m_szName, Npc[Player[nTargetIdx].m_nIndex].Name);

	// 给队长发消息
	g_pServer->PackDataToClient(Player[nSelfIdx].m_nNetConnectIdx, (BYTE*)&sAddMem, sizeof(PLAYER_TEAM_ADD_MEMBER));

	// 给老队员发消息
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_nID].m_nMember[i] < 0 || g_Team[m_nID].m_nMember[i] == nTargetIdx)
			continue;
		g_pServer->PackDataToClient(Player[g_Team[m_nID].m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sAddMem, sizeof(PLAYER_TEAM_ADD_MEMBER));
	}

// ------------------------------------- 给新队员发消息 --------------------------
	int		nNpcIndex;
	PLAYER_SEND_SELF_TEAM_INFO	sSelfInfo;
	sSelfInfo.ProtocolType = s2c_teamselfinfo;
	sSelfInfo.nTeamServerID = m_nID;
	sSelfInfo.m_nLeadExp = Player[nTargetIdx].m_nLeadExp;
	sSelfInfo.m_btState = g_Team[m_nID].m_nState;
	// 队长数据
	nNpcIndex = Player[nSelfIdx].m_nIndex;
	sSelfInfo.m_dwNpcID[0] = Npc[nNpcIndex].m_dwID;
	sSelfInfo.m_btLevel[0] = (DWORD)Npc[nNpcIndex].m_Level;
	strcpy(sSelfInfo.m_szNpcName[0], Npc[nNpcIndex].Name);
	// 队员数据
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (g_Team[m_nID].m_nMember[i] >= 0)
		{
			nNpcIndex = Player[g_Team[m_nID].m_nMember[i]].m_nIndex;
			sSelfInfo.m_dwNpcID[i + 1] = Npc[nNpcIndex].m_dwID;
			sSelfInfo.m_btLevel[i + 1] = (DWORD)Npc[nNpcIndex].m_Level;
			strcpy(sSelfInfo.m_szNpcName[i + 1], Npc[nNpcIndex].Name);
		}
		else
		{
			sSelfInfo.m_dwNpcID[i + 1] = 0;
			sSelfInfo.m_btLevel[i + 1] = 0;
			memset(sSelfInfo.m_szNpcName[i + 1], 0, sizeof(sSelfInfo.m_szNpcName[i + 1]));
		}
	}
	// 发送消息
	g_pServer->PackDataToClient(Player[nTargetIdx].m_nNetConnectIdx, (BYTE*)&sSelfInfo, sizeof(PLAYER_SEND_SELF_TEAM_INFO));

	SHOW_MSG_SYNC	sMsg;
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wMsgID = enumMSG_ID_TEAM_SELF_ADD;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
	g_pServer->PackDataToClient(Player[nTargetIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

// --------------------------------- 给新队员发消息 end --------------------------
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：收到邀请加入队伍的回复
//---------------------------------------------------------------------------
//TamLTM auto pt to doi
void	KPlayerTeam::SetCreatTeamFlag(int nSelfIdx, BOOL bFlag)
{
	m_bCreatTeamFlag = FALSE;

	if (bFlag)
		m_bCreatTeamFlag = TRUE;

	PLAYER_TEAM_OPEN_CLOSE	sTeamState;
	sTeamState.ProtocolType = (BYTE)s2c_teamchangestate;
	sTeamState.m_btStateClose = Team_S_CreatTeamFlag;
	sTeamState.m_btFlag = m_bCreatTeamFlag;
	g_pServer->PackDataToClient(Player[nSelfIdx].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
}

void	KPlayerTeam::SetFreezeTeamFlag(int nSelfIdx, BOOL bFlag)
{
	m_bFreezeTeamFlag = FALSE;
	if (bFlag)
		m_bFreezeTeamFlag = TRUE;
}

void	KPlayerTeam::SetPKFollowCaptain(int nSelfIdx, BOOL bFlag)
{
	m_bPKFollowCaptain = Team_S_NonFollow;
	if (bFlag)
	{
		Player[nSelfIdx].m_cPK.SetNormalPKState(Player[g_Team[m_nID].m_nCaptain].m_cPK.GetNormalPKState());
		m_bPKFollowCaptain = Team_S_PKFollow;
	}
	if (bFlag)
	{
		Player[nSelfIdx].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_PKFOLLOW_OPEN);
	}
	else
	{
		Player[nSelfIdx].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_PKFOLLOW_CLOSE);
	}

	PLAYER_TEAM_OPEN_CLOSE	sTeamState;
	sTeamState.ProtocolType = (BYTE)s2c_teamchangestate;
	sTeamState.m_btStateClose = Team_S_PKFollowCaptain;
	sTeamState.m_btFlag = m_bPKFollowCaptain;
	g_pServer->PackDataToClient(Player[nSelfIdx].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
}
//end code
#endif

//---------------------------------------------------------------------------
//	功能：构造函数
//---------------------------------------------------------------------------
KTeam::KTeam()
{
	Release();
}

//---------------------------------------------------------------------------
//	功能：清空
//---------------------------------------------------------------------------
void	KTeam::Release()
{
#ifdef _SERVER
	m_nTurnPick = -1;
#endif
	m_nCaptain = -1;
	m_nMemNum = 0;
	int		i;
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		m_nMember[i] = -1;
	}
	m_nState = Team_S_Close;
	m_nModePick = Team_S_FreePick;
#ifndef _SERVER
	for (i = 0; i < MAX_TEAM_MEMBER + 1; i++)
	{
		m_nMemLevel[i] = 0;
		memset(m_szMemName, 0, 32 * (MAX_TEAM_MEMBER + 1));
	}
	m_nTeamServerID = -1;
#endif
}

//---------------------------------------------------------------------------
//	功能：设定 Team 在 g_Team 中的位置
//---------------------------------------------------------------------------
void	KTeam::SetIndex(int nIndex)
{
	m_nIndex = nIndex;
}

//---------------------------------------------------------------------------
//	功能：寻找队员空位
//---------------------------------------------------------------------------
int		KTeam::FindFree()
{
	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (m_nMember[i] < 0)
			return i;
	}
	return -1;
}

//---------------------------------------------------------------------------
//	功能：寻找具有指定npc id的队员（不包括队长）
//	返回值：队员在 m_nMember 数组中的位置
//---------------------------------------------------------------------------
int		KTeam::FindMemberID(DWORD dwNpcID)
{
	for (int i = 0; i <	MAX_TEAM_MEMBER; i++)
	{
#ifdef _SERVER
		if (m_nMember[i] >= 0 && Npc[Player[m_nMember[i]].m_nIndex].m_dwID == dwNpcID)
			return i;
#else
		if (m_nMember[i] > 0 && (DWORD)m_nMember[i] == dwNpcID)
			return i;
#endif
	}
	return -1;
}

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：判断队伍是否已经满员
//	返回值：FALSE 未满员  TRUE 已满员
//---------------------------------------------------------------------------
BOOL	KTeam::CheckFull()
{
	if (m_nMemNum < CalcCaptainPower())
		return FALSE;
	return TRUE;
}
#endif

//---------------------------------------------------------------------------
//	功能：设定队伍状态：打开（允许接受新成员）
//---------------------------------------------------------------------------
BOOL	KTeam::SetTeamOpen(BOOL bNotify)
{
#ifdef _SERVER
	if (CheckFull())
		return FALSE;

	m_nState = Team_S_Open;

	PLAYER_TEAM_OPEN_CLOSE	sTeamState;
	sTeamState.ProtocolType = (BYTE)s2c_teamchangestate;
	sTeamState.m_btStateClose = Team_S_OpenClose;
	sTeamState.m_btFlag = Team_S_Open;
	g_pServer->PackDataToClient(Player[m_nCaptain].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));

	//TamLTM auto pt to doi
	Player[m_nCaptain].m_cMenuState.m_bBackTeamState = false;

	Player[m_nCaptain].m_cMenuState.SetState(m_nCaptain, PLAYER_MENU_STATE_TEAMOPEN);

	NPC_SET_MENU_STATE_SYNC	sSync;
	sSync.ProtocolType = s2c_npcsetmenustate;
	sSync.m_dwID = Npc[Player[m_nCaptain].m_nIndex].m_dwID;
	sSync.m_btState = PLAYER_MENU_STATE_TEAMOPEN;
	sSync.m_wLength = sizeof(NPC_SET_MENU_STATE_SYNC) - 1 - sizeof(sSync.m_szSentence);
	Npc[Player[m_nCaptain].m_nIndex].SendDataToNearRegion((LPVOID)&sSync, sSync.m_wLength + 1);

	if (bNotify)
		Player[m_nCaptain].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_OPEN);

	return TRUE;
#else
	m_nState = Team_S_Open;
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
	return TRUE;
#endif
}

//---------------------------------------------------------------------------
//	功能：设定队伍状态：关闭（不允许接受新成员）
//---------------------------------------------------------------------------
//TamLTM auto pt to toi
BOOL	KTeam::SetTeamClose(BOOL bNotify)
{
#ifdef _SERVER
	m_nState = Team_S_Close;

	PLAYER_TEAM_OPEN_CLOSE	sTeamState;
	sTeamState.ProtocolType = (BYTE)s2c_teamchangestate;
	sTeamState.m_btStateClose = Team_S_OpenClose;
	sTeamState.m_btFlag = Team_S_Close;
	g_pServer->PackDataToClient(Player[m_nCaptain].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));

	Player[m_nCaptain].m_cMenuState.SetState(m_nCaptain, PLAYER_MENU_STATE_NORMAL);

	NPC_SET_MENU_STATE_SYNC	sSync;
	sSync.ProtocolType = s2c_npcsetmenustate;
	sSync.m_dwID = Npc[Player[m_nCaptain].m_nIndex].m_dwID;
	sSync.m_btState = PLAYER_MENU_STATE_NORMAL;
	sSync.m_wLength = sizeof(NPC_SET_MENU_STATE_SYNC) - 1 - sizeof(sSync.m_szSentence);
	Npc[Player[m_nCaptain].m_nIndex].SendDataToNearRegion((LPVOID)&sSync, sSync.m_wLength + 1);

	if (bNotify)
		Player[m_nCaptain].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_CLOSE);

	return TRUE;
#else
	m_nState = Team_S_Close;
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
	return TRUE;
#endif
}

//TamLTM auto pt to toi
BOOL	KTeam::SetModePick(int nMode)
{
	if (nMode < Team_S_SelfPick || nMode > Team_S_AlternatePick)
		return FALSE;
	if (m_nModePick == nMode)
		return FALSE;
	m_nModePick = nMode;

#ifdef _SERVER
	NotifyModePick();

	PLAYER_TEAM_OPEN_CLOSE	sTeamState;
	sTeamState.ProtocolType = (BYTE)s2c_teamchangestate;
	sTeamState.m_btStateClose = Team_S_ModePick;
	sTeamState.m_btFlag = m_nModePick;
	g_pServer->PackDataToClient(Player[m_nCaptain].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
	for (int i = 0; i < MAX_TEAM_MEMBER; i ++)
	{
		if (m_nMember[i])
			g_pServer->PackDataToClient(Player[m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sTeamState, sizeof(PLAYER_TEAM_OPEN_CLOSE));
	}
#else
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
#endif
	return TRUE;
}

#ifdef _SERVER
void	KTeam::NotifyModePick()
{
	if (m_nModePick < Team_S_SelfPick || m_nModePick > Team_S_AlternatePick)
		return;
		
	switch (m_nModePick)
	{
		case Team_S_SelfPick:
			Player[m_nCaptain].SendTeamMessage(Player[m_nCaptain].m_cTeam.m_nID, MSG_TEAM_MODEPICK_SELF);
			break;
		case Team_S_FreePick:
			Player[m_nCaptain].SendTeamMessage(Player[m_nCaptain].m_cTeam.m_nID, MSG_TEAM_MODEPICK_FREE);
			break;
		case Team_S_CaptainPick:
			Player[m_nCaptain].SendTeamMessage(Player[m_nCaptain].m_cTeam.m_nID, MSG_TEAM_MODEPICK_CAPTAIN);
			break;
		case Team_S_AlternatePick:
			Player[m_nCaptain].SendTeamMessage(Player[m_nCaptain].m_cTeam.m_nID, MSG_TEAM_MODEPICK_ALTERNATE);
			break;
	}
}

void	KTeam::NotifyMemberModePick(int nPlayerIndex)
{
	if (nPlayerIndex < 0 || nPlayerIndex >= MAX_PLAYER)
		return;
	if (m_nModePick < Team_S_SelfPick || m_nModePick > Team_S_AlternatePick)
		return;
		
	switch (m_nModePick)
	{
		case Team_S_SelfPick:
			Player[nPlayerIndex].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_MODEPICK_SELF);
			break;
		case Team_S_FreePick:
			Player[nPlayerIndex].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_MODEPICK_FREE);
			break;
		case Team_S_CaptainPick:
			Player[nPlayerIndex].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_MODEPICK_CAPTAIN);
			break;
		case Team_S_AlternatePick:
			Player[nPlayerIndex].SendSystemMessage(MESSAGE_TEAM_ANNOUCE_HEAD, MSG_TEAM_MODEPICK_ALTERNATE);
			break;
	}
}
//---------------------------------------------------------------------------
//	功能：判断队伍是否是打开状态
//---------------------------------------------------------------------------
BOOL	KTeam::IsOpen()
{
	return m_nState;
}
#endif

//---------------------------------------------------------------------------
//	功能：计算队长能统帅队员的人数
//---------------------------------------------------------------------------
int		KTeam::CalcCaptainPower()
{
#ifdef _SERVER
	return PlayerSet.m_cLeadExp.GetMemNumFromLevel(Player[m_nCaptain].m_nLeadLevel);
#else
	return PlayerSet.m_cLeadExp.GetMemNumFromLevel(Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);
#endif
}

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：判断加入队伍的属性条件是否合适
//---------------------------------------------------------------------------
BOOL	KTeam::CheckAddCondition(int nPlayerIndex)
{
	if (Npc[Player[nPlayerIndex].m_nIndex].m_Camp != camp_begin && Npc[Player[m_nCaptain].m_nIndex].m_Camp == camp_begin)
		return FALSE;
	return TRUE;
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：创建一支队伍
//---------------------------------------------------------------------------
BOOL	KTeam::CreateTeam(int nPlayerIndex)//, char *lpszName)
{
	Release();
	m_nCaptain = nPlayerIndex;
	m_nTurnPick = m_nCaptain;
//	if (lpszName && lpszName[0])
//		strcpy(m_szName, lpszName);

	return TRUE;
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：添加一个队伍成员
//---------------------------------------------------------------------------
BOOL	KTeam::AddMember(int nPlayerIndex)
{
	// 队伍是否为空
	if (m_nCaptain < 0)
		return FALSE;
	// 阵营是否相同
	if ( !CheckAddCondition(nPlayerIndex) )
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_ADDMEMBER_NOTVALID;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	// 是否已经满员
	if (CheckFull())
		return FALSE;

	int n;
	n = FindFree();
	if (n < 0)
		return FALSE;
	m_nMember[n] = nPlayerIndex;
	NotifyMemberModePick(nPlayerIndex);
	m_nMemNum++;

	return TRUE;
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：删除一个队伍成员
//---------------------------------------------------------------------------
BOOL	KTeam::DeleteMember(int nPlayerIndex)
{
	int		i;
	PLAYER_LEAVE_TEAM	sLeaveTeam;

	if (nPlayerIndex == m_nCaptain)
	{
		SHOW_MSG_SYNC	sMsg;

		// 队伍解散消息
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TEAM_DISMISS;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

		Player[nPlayerIndex].m_cTeam.Release();
		Npc[Player[nPlayerIndex].m_nIndex].RestoreCurrentCamp();
		sLeaveTeam.ProtocolType = s2c_teamleave;
		sLeaveTeam.m_dwNpcID = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));

		for (i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (m_nMember[i] < 0)
				continue;

			g_pServer->PackDataToClient(Player[m_nMember[i]].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

			Npc[Player[m_nMember[i]].m_nIndex].RestoreCurrentCamp();
			Player[m_nMember[i]].m_cTeam.Release();
			sLeaveTeam.m_dwNpcID = Npc[Player[m_nMember[i]].m_nIndex].m_dwID;
			g_pServer->PackDataToClient(Player[m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
		}
		Release();
		return TRUE;
	}
	else
	{
		Player[nPlayerIndex].m_cTeam.Release();
		sLeaveTeam.ProtocolType = s2c_teamleave;
		sLeaveTeam.m_dwNpcID = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
		g_pServer->PackDataToClient(Player[m_nCaptain].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
		for (i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (m_nMember[i] == nPlayerIndex)
			{
				Npc[Player[m_nMember[i]].m_nIndex].RestoreCurrentCamp();
				m_nMember[i] = -1;
				m_nMemNum--;
				g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
				
				if (m_nTurnPick == m_nMember[i])
				{
					for (i; i<MAX_TEAM_MEMBER; i++)
						m_nTurnPick = m_nMember[i];
					if (m_nTurnPick == -1)
						m_nTurnPick = m_nCaptain;
				}
			}
			else
			{
				if (m_nMember[i] >= 0)
					g_pServer->PackDataToClient(Player[m_nMember[i]].m_nNetConnectIdx, (BYTE*)&sLeaveTeam, sizeof(PLAYER_LEAVE_TEAM));
			}
		}
	}

	return TRUE;
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：客户端创建一支队伍（客户端只可能存在一支的队伍，属于本地玩家）
//---------------------------------------------------------------------------
void	KTeam::CreateTeam(int nCaptainNpcID, char *lpszCaptainName, int nCaptainLevel, DWORD nTeamServerID)
{
	Release();
	m_nCaptain = nCaptainNpcID;
	m_nMemLevel[0] = nCaptainLevel;
	strcpy(m_szMemName[0], lpszCaptainName);
	m_nTeamServerID = nTeamServerID;		// 队伍在服务器上的唯一标识
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：添加一个队伍成员
//---------------------------------------------------------------------------
BOOL	KTeam::AddMember(DWORD dwNpcID, int nLevel, char *lpszNpcName)
{
	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (m_nMember[i] == (int)dwNpcID)
			return TRUE;
	}

	int nFreeNo;
	nFreeNo = FindFree();
	if (nFreeNo < 0)
		return FALSE;
	m_nMember[nFreeNo] = dwNpcID;
	m_nMemLevel[nFreeNo + 1] = nLevel;
	strcpy(m_szMemName[nFreeNo + 1], lpszNpcName);
	m_nMemNum++;

	return TRUE;
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：客户端删除一个队伍成员
//---------------------------------------------------------------------------
void	KTeam::DeleteMember(DWORD dwNpcID)
{
	if (dwNpcID == (DWORD)m_nCaptain)
	{
		Release();
		return;
	}

	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if ((DWORD)m_nMember[i] == dwNpcID)
		{
			m_nMemNum--;
			m_nMember[i] = -1;
			m_nMemLevel[i + 1] = 0;
			m_szMemName[i + 1][0] = 0;
			return;
		}
	}
}
#endif

#ifndef _SERVER
//---------------------------------------------------------------------------
//	功能：输出队员信息(按界面的要求，给界面)
//---------------------------------------------------------------------------
int		KTeam::GetMemberInfo(KUiPlayerItem *pList, int nCount)
{
	if (this->m_nCaptain < 0)
		return 0;
	int		i, nNum = 0;
	if (!pList || nCount <= m_nMemNum)
	{
		return m_nMemNum + 1;
	}
	
	// 队长名字
	strcpy(pList[nNum].Name, m_szMemName[0]);
	pList[nNum].uId = this->m_nCaptain;
	pList[nNum].nIndex = 0;
	nNum++;

	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (nNum >= nCount)
			break;
		if (this->m_nMember[i] <= 0)
			continue;
		strcpy(pList[nNum].Name, m_szMemName[i + 1]);
		pList[nNum].uId = m_nMember[i];
		pList[nNum].nIndex = 0;
		nNum++;
	}

	return nNum;
}
#endif


#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：判断某人是否是队伍成员
//---------------------------------------------------------------------------
BOOL	KTeam::CheckIn(int nSelfIndex, int nPlayerIndex)
{
	if (nPlayerIndex <= 0)
		return TRUE;
	if (!CheckItemIn(nPlayerIndex))
		return FALSE;
	if (m_nModePick < Team_S_SelfPick || m_nModePick > Team_S_AlternatePick)
	{
		if (nPlayerIndex == m_nCaptain)
			return TRUE;
		for (int i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if (m_nMember[i] == nPlayerIndex)
				return TRUE;
		}
		return FALSE;
	}
	
	switch (m_nModePick)
	{
		case Team_S_SelfPick:
			if (nSelfIndex == nPlayerIndex)
				return TRUE;
			break;
		case Team_S_FreePick:
			{
				if (nPlayerIndex == m_nCaptain)
					return TRUE;
					
				for (int i = 0; i < MAX_TEAM_MEMBER; i++)
				{
					if (m_nMember[i] == nPlayerIndex)
						return TRUE;
				}
			}
			break;
		case Team_S_CaptainPick:
			if (nSelfIndex == m_nCaptain)
				return TRUE;
			break;
		case Team_S_AlternatePick:
			if (nSelfIndex == m_nTurnPick)
			{
				int i;
				if (m_nTurnPick == m_nCaptain)
				{
					i = 0;
					m_nTurnPick = -1;
				}
				else
				{
					for (int i = 0; i < MAX_TEAM_MEMBER; i++)
					{
						if (m_nMember[i] && (m_nMember[i] == m_nTurnPick))
						{
							m_nTurnPick = -1;
							break;
						}
					}
				}
				for (i; i < MAX_TEAM_MEMBER; i++)
				{
					if (m_nMember[i] && (m_nTurnPick == -1))
						m_nTurnPick = m_nMember[i];
				}				
				if (m_nTurnPick == -1)
					m_nTurnPick = m_nCaptain;

				return TRUE;
			}
			break;					
	}
	return FALSE;
}

BOOL	KTeam::CheckItemIn(int nPlayerIndex)
{
	if (nPlayerIndex <= 0)
		return TRUE;

	if (nPlayerIndex == m_nCaptain)
		return TRUE;
	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (m_nMember[i] == nPlayerIndex)
			return TRUE;
	}
	return FALSE;
}
#endif


#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：初始化
//---------------------------------------------------------------------------
void	KTeamSet::Init()
{
	for (int i = 0; i < MAX_TEAM; i++)
		g_Team[i].SetIndex(i);
}
#endif

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：差找 g_Team 中的空位
//---------------------------------------------------------------------------
int		KTeamSet::FindFree()
{
	for (int i = 0; i < MAX_TEAM; i++)
	{
		if (g_Team[i].m_nCaptain < 0)
			return i;
	}
	return -1;
}
#endif

/*
#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：判断队名是否可用
//---------------------------------------------------------------------------
BOOL	KTeamSet::CheckName(char *lpszName)
{
	if (!lpszName || !lpszName[0])
		return FALSE;

	for (int i = 0; i < MAX_TEAM; i++)
	{
		if (g_Team[i].m_nCaptain < 0)
			continue;
		if (strcmp(lpszName, g_Team[i].m_szName) == 0)
			return FALSE;
	}

	return TRUE;
}
#endif
*/

#ifdef _SERVER
//---------------------------------------------------------------------------
//	功能：创建一支队伍
//---------------------------------------------------------------------------
int		KTeamSet::CreateTeam(int nPlayerID)//, char *lpszName)
{
	int nTeamID;
	nTeamID = FindFree();
	if (nTeamID < 0)
		return -2;
//	if (!CheckName(lpszName))
//		return -1;
	if (g_Team[nTeamID].CreateTeam(nPlayerID));//, lpszName))
		return nTeamID;
	return -1;
}
#endif






















