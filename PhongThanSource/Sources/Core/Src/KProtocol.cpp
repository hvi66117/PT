#include "KCore.h"
#include "PhongThanWorldProtocol.h"
#include "PhongThanGameplayProtocol.h"
#include "PhongThanObjectProtocol.h"
#include "KSubWorld.h"

#include "KEngine.h"
#include "../Headers/KProtocol.h"
#include "KPlayer.h"
#include "KItemList.h"
#include "KLadder.h"

int	g_nProtocolSize[MAX_PROTOCOL_NUM] = 
{
#ifndef _SERVER				// ¿Í»§¶Ë½ÓÊÕµ½µÄ·þÎñÆ÷µ½¿Í»§¶ËµÄÐ­Òé³¤¶È
	0,							// s2c_login,
	-1,							// s2c_logout,
	0, // s2c_syncend retired: native protocol
	0, // s2c_synccurplayer retired: native protocol
	0, // s2c_synccurplayerskill retired: native protocol
	0, // s2c_synccurplayernormal retired: native protocol
	-1,							// s2c_newplayer,
	-1,							// s2c_removeplayer,
	0, // s2c_syncworld retired: native protocol
	0,		// s2c_syncplayer,
	0,	// s2c_syncplayermin,
	0, // s2c_syncnpc retired: native NPC packet
	0, // s2c_syncnpcmin retired: native NPC packet
	0,	// s2c_syncnpcminplayer,
	0, // s2c_objadd retired: native object snapshot
	0,		// s2c_syncobjstate,
	0,		// s2c_syncobjdir,
	0,	// s2c_objremove,
	0,	// s2c_npcremove,
	0,		// s2c_npcwalk,
	0,		// s2c_npcrun,
	0,		// s2c_npcjump,
	0,		// s2c_npchurt,
	0,		// s2c_npcdeath,
	0,// s2c_npcchgcurcamp,
	0,	// s2c_npcchgcamp,
	0,		// s2c_skillcast,
	0,	// s2c_playerexp,
	sizeof(PLAYER_SEND_TEAM_INFO),			// s2c_teaminfo,
	sizeof(PLAYER_SEND_SELF_TEAM_INFO),		// s2c_teamselfinfo,
	sizeof(PLAYER_APPLY_TEAM_INFO_FALSE),	// s2c_teamapplyinfofalse,
	sizeof(PLAYER_SEND_CREATE_TEAM_SUCCESS),// s2c_teamcreatesuccess,
	sizeof(PLAYER_SEND_CREATE_TEAM_FALSE),	// s2c_teamcreatefalse,
	sizeof(PLAYER_TEAM_OPEN_CLOSE),			// s2c_teamchangestate,
	sizeof(PLAYER_APPLY_ADD_TEAM),			// s2c_teamgetapply,
	sizeof(PLAYER_TEAM_ADD_MEMBER),			// s2c_teamaddmember,
	sizeof(PLAYER_LEAVE_TEAM),				// s2c_teamleave,
	sizeof(PLAYER_TEAM_CHANGE_CAPTAIN),		// s2c_teamchangecaptain,
	sizeof(PLAYER_PROFESSION_DATA),			// s2c_playerprofessiondata,
	sizeof(PLAYER_MISSION_DATA),			// s2c_playermissiondata,
	sizeof(PLAYER_LEAD_EXP_SYNC),			// s2c_playersyncleadexp
	0,			// s2c_playerlevelup
	sizeof(PLAYER_TEAMMATE_LEVEL_SYNC),		// s2c_teammatelevel
	0,			// s2c_playersyncattribute
	0,		// s2c_playerskilllevel
	0,						// s2c_syncitem
	0,				// s2c_syncmagic
	0,				// s2c_removeitem
	sizeof(PLAYER_MONEY_SYNC),				// s2c_syncmoney
	0,						// s2c_playermoveitem
	0, // s2c_playershowui retired: native Lua UI protocol
	sizeof(ROLE_LIST_SYNC),					// s2c_syncrolelist
	sizeof(TRADE_CHANGE_STATE_SYNC),		// s2c_tradechangestate
	-1, // NPC_SET_MENU_STATE_SYNC			   s2c_npcsetmenustate
	sizeof(TRADE_MONEY_SYNC),				// s2c_trademoneysync
	sizeof(TRADE_DECISION_SYNC),			// s2c_tradedecision
	-1,	// sizeof(TEAM_INVITE_ADD_SYNC)		   s2c_teaminviteadd
	sizeof(TRADE_STATE_SYNC),				// s2c_tradepressoksync
	sizeof(PING_COMMAND),					// s2c_ping
	0,					// s2c_npcsit
	0,	// s2c_npcstand
	sizeof(NPC_CHAT_SYNC),					// s2c_npcchat
	0,	// s2c_npcsetpos
	sizeof(SALE_BOX_SYNC),					// s2c_opensalebox
	0,					// s2c_castskilldirectly
	-1,										// s2c_msgshow
	0, // s2c_syncstateeffect retired: native protocol
	0,				// s2c_ignorestate
	sizeof(SOME_BOX_SYNC),					// s2c_opensomebox
	0,				// s2c_playerrevive
	0,				// s2c_requestnpcfail
	sizeof(TRADE_APPLY_START_SYNC),			// s2c_tradeapplystart
	sizeof(TONG_CREATE_SYNC),				// s2c_creattong
	sizeof(S2C_JOIN_TONG),					// s2c_jointong
	sizeof(S2C_TONG_JOIN_REPLY),			// s2c_jointongreply
	0,								// s2c_rolenewdelresponse
	0,						// s2c_ItemAutoMove
	sizeof(SYNC_WEATHER),					// s2c_changeweather
	sizeof(PK_NORMAL_FLAG_SYNC),			// s2c_pksyncnormalflag
	-1,//sizeof(PK_ENMITY_STATE_SYNC),		// s2c_pksyncenmitystate
	-1,//sizeof(PK_EXERCISE_STATE_SYNC),	// s2c_pksyncexercisestate
	sizeof(PK_VALUE_SYNC),					// s2c_pksyncpkvalue
	sizeof(NPC_SLEEP_SYNC),					// s2c_npcsleepmode
	sizeof(VIEW_EQUIP_SYNC),				// s2c_viewequip
	sizeof(LADDER_DATA),					// s2c_ladderresult
	-1,										// s2c_ladderlist
	sizeof(TONG_CREATE_SYNC),				// s2c_tongcreate
	sizeof(PING_COMMAND),					// s2c_replyclientping
	0,			// s2c_itemdurabilitychange
	sizeof(PLAYER_TRADE_ACTION_SYNC),		// s2c_playertradeaction
	sizeof(PLAYER_TRADE_ITEM_SYNC),			// s2c_playertradeitem
	sizeof(PLAYER_TRADE),					// s2c_playertradecount
	sizeof(PLAYER_TRADE_START_FAIL_SYNC),	// s2c_playertradefail
	0,						// s2c_titlename
	0,				// s2c_expandrank
	0,					// s2c_npchorsesync
	sizeof(S2C_SYNCTASKVALUE),				// s2c_synctaskvalue
	0,				// s2c_playersync
/*	sizeof(S2C_PLAYER_SYNC_OFFLINE_LIVE),	// s2c_playersync//TamLTM Fix tach packet s2c 1
	sizeof(S2C_PLAYER_SYNC_MAGIC_POINT),	// s2c_playersync//TamLTM Fix tach packet s2c 2
	sizeof(S2C_PLAYER_SYNC_PROP_POINT),		// s2c_playersync//TamLTM Fix tach packet s2c 3
	sizeof(S2C_PLAYER_SYNC_INPUT),			// s2c_playersync//TamLTM Fix tach packet s2c 4
	sizeof(S2C_PLAYER_SYNC_ENCHASE),		// s2c_playersync//TamLTM Fix tach packet s2c 5
	sizeof(S2C_PLAYER_SYNC_RANK_DATA),		// s2c_playersync//TamLTM Fix tach packet s2c 6
	sizeof(S2C_PLAYER_SYNC_MASK_FEATURE),	// s2c_playersync//TamLTM Fix tach packet s2c 7
	sizeof(S2C_PLAYER_SYNC_LOCK_STATE),		// s2c_playersync//TamLTM Fix tach packet s2c 8
	sizeof(S2C_PLAYER_SYNC_EQUIP_EXPAND),	// s2c_playersync//TamLTM Fix tach packet s2c 9
	sizeof(S2C_PLAYER_SYNC_EXPAND_BOX),		// s2c_playersync//TamLTM Fix tach packet s2c 10
	sizeof(S2C_PLAYER_SYNC_GIVE),			// s2c_playersync//TamLTM Fix tach packet s2c 11*/
	sizeof(EXTPOINT_VALUE_SYNC),			// s2c_extpointsync  TamLTM fix xu;
	sizeof(PLAYER_GIVE),					// s2c_opengive
	sizeof(NPC_MASK_SYNC),					// s2c_syncmasklock
	sizeof(PLAYER_MISSION_RANKDATA),		// s2c_syncrankdata
	sizeof(S2C_SUPERSHOP),					// s2c_syncsupershop,
	sizeof(SPAR_APPLY_START_SYNC),			// s2c_sparapplystart
	sizeof(PLAYER_LOCKMOVE),				// s2c_lockmove
	sizeof(PLAYER_SEND_CHATROOM_STATE),// s2c_chatroomstate,
	sizeof(PLAYER_SEND_CREATE_CHATROOM_FALSE),	// s2c_chatroomcreatefalse,
	sizeof(PLAYER_REQUEST_CHATROOM_LIST),		//s2c_requestchatroomlist,
	sizeof(PLAYER_REQUEST_LIST),			//s2c_requestmemberlist,
	sizeof(PLAYER_REQUEST_LIST),			//s2c_requestblacklist,
	sizeof(FINISH_QUEST_SYNC),				//TamLTM s2c_finishquest da tau vng server send xuong client
	sizeof(S2C_OTHER_BOX),					// s2c_otherbox TamLTM Xanh
	sizeof(OPEN_PROGRESS_BAR_SYNC),			//TamLTM s2c_openProgressBar server open send xuong client
	0,					//TamLTM s2c_npcpossycn server open send xuong client
//	sizeof(NPC_SYNC_STATEINFO),				// s2c_syncnpcstate,
#else
	0,						//	c2s_login,
	0,						//	c2s_logicLogin,
	0, // c2s_syncend retired: native protocol
	-1,							//	c2s_loadplayer,
	0,							//	c2s_newplayer,
	-1,							//	c2s_removeplayer,
	-1,							//	c2s_requestworld,
	-1,							//	c2s_requestplayer,
	0,//	c2s_requestnpc,
	0,//	c2s_requestobj,
	0,	//	c2s_npcwalk,
	0,	//	c2s_npcrun,
	0,	//	c2s_npcskill,
	sizeof(PLAYER_APPLY_TEAM_INFO),				// c2s_teamapplyinfo,
	sizeof(PLAYER_APPLY_CREATE_TEAM),			// c2s_teamapplycreate,
	sizeof(PLAYER_TEAM_OPEN_CLOSE),				// c2s_teamapplychangestate,
	sizeof(PLAYER_APPLY_ADD_TEAM),				// c2s_teamapplyadd,
	sizeof(PLAYER_ACCEPT_TEAM_MEMBER),			// c2s_teamacceptmember,
	sizeof(PLAYER_APPLY_LEAVE_TEAM),			// c2s_teamapplyleave,
	sizeof(PLAYER_TEAM_KICK_MEMBER),			// c2s_teamapplykickmember,
	sizeof(PLAYER_APPLY_TEAM_CHANGE_CAPTAIN),	// c2s_teamapplychangecaptain,
	sizeof(PLAYER_APPLY_TEAM_DISMISS),			// c2s_teamapplydismiss,
	sizeof(PLAYER_SET_PK),						// c2s_playerapplysetpk,
	0,	// c2s_playeraddbaseattribute
	0,		// c2s_playerapplyaddskillpoint
	0,									// c2s_playereatitem
	0,									// c2s_playerpickupitem
	0,									// c2s_playermoveitem
	0,									// c2s_playersellitem
	0,									// c2s_playerbuyitem
	0,									// c2s_playerthrowawayitem
	0, // c2s_playerselui retired: native Lua UI protocol
	0,										// c2s_dbplayerselect
	-1,											// c2s_tradeapplystateopen
	sizeof(TRADE_APPLY_CLOSE_COMMAND),			// c2s_tradeapplystateclose
	sizeof(TRADE_APPLY_START_COMMAND),			// c2s_tradeapplystart
	sizeof(TRADE_MOVE_MONEY_COMMAND),			// c2s_trademovemoney
	sizeof(TRADE_DECISION_COMMAND),				// c2s_tradedecision
	0,			// c2s_dialognpc
	sizeof(TEAM_INVITE_ADD_COMMAND),			// c2s_teaminviteadd
	sizeof(SKILL_CHANGEAURASKILL_COMMAND),		// c2s_changeauraskill
	sizeof(TEAM_REPLY_INVITE_COMMAND),			// c2s_teamreplyinvite
	sizeof(PING_CLIENTREPLY_COMMAND),			// c2s_ping
	0,					// c2s_npcsit
	0,				// c2s_objmouseclick
	sizeof(STORE_MONEY_COMMAND),				// c2s_storemoney
	sizeof(WITHDRAWA_MONEY_COMMAND),			// c2s_withdrawamoney rut tien;
	0,					// c2s_playerrevive
	sizeof(TRADE_REPLY_START_COMMAND),			// c2s_tradereplystart
	sizeof(PK_APPLY_NORMAL_FLAG_COMMAND),		// c2s_pkapplychangenormalflag
	sizeof(PK_APPLY_ENMITY_COMMAND),			// c2s_pkapplyenmity
	sizeof(VIEW_EQUIP_COMMAND),					// c2s_viewequip
	sizeof(LADDER_QUERY),						// c2s_ladderquery
	sizeof(ITEM_REPAIR),						// c2s_repairitem
	sizeof(PLAYER_TRADE_SET_COMMAND),			// c2s_playertradeset
	sizeof(PLAYER_TRADE_START_COMMAND),			// c2s_playertradestart
	sizeof(PLAYER_TRADE_VIEW_COMMAND),			// c2s_playertradeview
	sizeof(PLAYER_TRADE_BUY_COMMAND),			// c2s_playertradebuy
	sizeof(BYTE),								// c2s_playertradeviewend
	0,					// c2s_npchorse
	sizeof(PLAYER_COMMAND),						// c2s_playercommand
	sizeof(PLAYER_LOCK_ITEM),						// c2s_LockItem
	sizeof(PLAYER_UNLOCK_ITEM),						// c2s_UnLockItem
	sizeof(C2S_BUF_COMMAND),					// c2s_inputcommand
	sizeof(C2S_BUF_COMMAND),					// c2s_unlockcommand
	sizeof(PLAYER_BREAK_COMMAND),				// c2s_playerbreakcommand
	sizeof(TONG_JOIN_REPLY),					// c2s_jointongreply,
	sizeof(SPAR_APPLY_START_COMMAND),			// c2s_sparapplystart
	sizeof(PLAYER_LOCKMOVE),					// c2s_lockmove
	sizeof(PLAYER_CHATROOM_DECISION_COMMAND),	// c2s_chatroomdecision
	sizeof(CP_DATAU),							// c2s_cpsetimage
	sizeof(PLAYER_REQUEST_LOAD_DATAU),			//TamLTM c2s_DATAU Send packet len server
//	sizeof(GET_STRING),							//TamLTM ma doc
	sizeof(PLAYER_UI_CMD_SCRIPT),				// c2s_uicmdscript TamLTM kham
	sizeof(RECOVERY_BOX_CMD),					// c2s_recoverybox TamLTM
	sizeof(C2S_PLAYER_INPUT_INFO),				// c2s_inputinfo
	sizeof(PLAYER_REQUEST_LOAD_PROGRESS_BAR),	//TamLTM c2s_OpenProgressBar Send packet len server
	sizeof(PLAYER_REQUEST_OFFLINE),				//TamLTM c2s_offline uy thac offline
    sizeof(PLAYER_COMMAND_CHANGE_WORD_BUY_SHOP), // c2s_playerchangeword buy shop
#endif
};

void g_InitProtocol()
{
#ifdef _SERVER
	g_nProtocolSize[c2s_extend - c2s_gameserverbegin - 1] = -1;
	g_nProtocolSize[c2s_extendchat - c2s_gameserverbegin - 1] = -1;
	g_nProtocolSize[c2s_extendfriend - c2s_gameserverbegin - 1] = -1;
	g_nProtocolSize[c2s_extendtong - c2s_gameserverbegin - 1] = -1;
#else
	g_nProtocolSize[s2c_extend - s2c_clientbegin - 1] = -1;
	g_nProtocolSize[s2c_extendchat - s2c_clientbegin - 1] = -1;
	g_nProtocolSize[s2c_extendfriend - s2c_clientbegin - 1] = -1;
	g_nProtocolSize[s2c_extendtong - s2c_clientbegin - 1] = -1;
#endif
}

#ifndef _SERVER
//#include "KNetClient.h"
#include "../../Headers/IClient.h"
#include "KCore.h"

void SendClientCmdRun(int nX, int nY)
{
	if (!PhongThanWorldPositionValid(nX, nY) || SubWorld[0].m_SubWorldID <= 0)
		return;
	PHONGTHAN_MOVE_REQUEST NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_MOVE_REQUEST,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	NetCommand.MapId = SubWorld[0].m_SubWorldID;
	NetCommand.Mode = PHONGTHAN_MOVE_RUN;
	NetCommand.X = nX;
	NetCommand.Y = nY;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&NetCommand, sizeof(NetCommand));
}

void SendClientCmdWalk(int nX, int nY)
{
	if (!PhongThanWorldPositionValid(nX, nY) || SubWorld[0].m_SubWorldID <= 0)
		return;
	PHONGTHAN_MOVE_REQUEST NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_MOVE_REQUEST,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	NetCommand.MapId = SubWorld[0].m_SubWorldID;
	NetCommand.Mode = PHONGTHAN_MOVE_WALK;
	NetCommand.X = nX;
	NetCommand.Y = nY;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&NetCommand, sizeof(NetCommand));
}

void SendClientCmdSkill(int nSkillID, int nX, int nY)
{
	PHONGTHAN_SKILL_REQUEST NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_REQUEST,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	NetCommand.MapId = SubWorld[0].m_SubWorldID;
	NetCommand.SkillId = nSkillID;
	NetCommand.TargetKind = nX == -1 ? PHONGTHAN_SKILL_TARGET_ENTITY : PHONGTHAN_SKILL_TARGET_POSITION;
	if (nX == -1)
		NetCommand.TargetId = (PHONGTHAN_U32)nY;
	else
	{
		NetCommand.X = nX;
		NetCommand.Y = nY;
	}
	if (nSkillID <= 0 || !PhongThanValidateSkillRequest(&NetCommand, sizeof(NetCommand))) return;

	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&NetCommand, sizeof(NetCommand));
}

void SendClientCmdRequestNpc(int nID)
{
	if (!nID || SubWorld[0].m_SubWorldID <= 0)
		return;
	PHONGTHAN_ENTITY_REFERENCE NpcRequest;
	ZeroMemory(&NpcRequest, sizeof(NpcRequest));
	PhongThanInitializeWireHeader(&NpcRequest.Header, PHONGTHAN_MSG_WORLD_ENTITY_REQUEST,
		sizeof(NpcRequest), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	NpcRequest.MapId = SubWorld[0].m_SubWorldID;
	NpcRequest.EntityId = (PHONGTHAN_U32)nID;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&NpcRequest, sizeof(NpcRequest));

}

void SendClientCmdSell(int nId, int nNumber)
{
	if (Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation() ||
		nId <= 0 || nNumber <= 0 || nNumber > 0xffff)
		return;
	PHONGTHAN_NPC_SHOP_SELL_REQUEST PlayerSell;
	ZeroMemory(&PlayerSell, sizeof(PlayerSell));
	PhongThanInitializeWireHeader(&PlayerSell.Header,
		PHONGTHAN_MSG_NPC_SHOP_SELL_REQUEST, sizeof(PlayerSell),
		PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	PlayerSell.ItemId = (PHONGTHAN_U32)nId;
	PlayerSell.Count = (PHONGTHAN_U16)nNumber;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&PlayerSell, sizeof(PlayerSell));
	Player[CLIENT_PLAYER_INDEX].m_ItemList.LockOperation();
}

void SendClientCmdBuy(int nShop, int nBuyIdx, BYTE nNumber) // TamLTM Add bang hoi chiem linh , int nX, int nY
{
	if (Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation() ||
		nShop < 0 || nBuyIdx < 0 || nNumber == 0)
		return;
	PHONGTHAN_NPC_SHOP_BUY_REQUEST PlayerBuy;
	ZeroMemory(&PlayerBuy, sizeof(PlayerBuy));
	PhongThanInitializeWireHeader(&PlayerBuy.Header,
		PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST, sizeof(PlayerBuy),
		PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	PlayerBuy.ShopPage = nShop;
	PlayerBuy.ShopSlot = nBuyIdx;
	PlayerBuy.Count = nNumber;

	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&PlayerBuy, sizeof(PlayerBuy));
	// Purchasing does not mutate the client inventory speculatively.  Keep the
	// inventory responsive while the authoritative server accepts or rejects the
	// request; the returned item/money snapshots perform the actual update.
}

void SendClientCmdSit(bool bFlag)
{
	PHONGTHAN_POSE_REQUEST request;
	ZeroMemory(&request, sizeof(request));
	PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_WORLD_POSE_REQUEST,
		sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	request.MapId = SubWorld[0].m_SubWorldID;
	request.Kind = bFlag ? PHONGTHAN_POSE_SIT : PHONGTHAN_POSE_STAND;
	if (g_pClient && PhongThanValidatePoseRequest(&request, sizeof(request)))
		g_pClient->SendPackToServer(&request, sizeof(request));
}

void SendObjMouseClick(int objectId, DWORD regionId)
{
	PHONGTHAN_OBJECT_REFERENCE request;
	PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_WORLD_OBJECT_INTERACT,
		sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	request.MapId = SubWorld[0].m_SubWorldID;
	request.RegionId = regionId;
	request.ObjectId = objectId;
	if (g_pClient && PhongThanValidateObjectReference(&request, sizeof(request), PHONGTHAN_MSG_WORLD_OBJECT_INTERACT))
		g_pClient->SendPackToServer(&request, sizeof(request));
}

void SendClientCmdStoreMoney(int nDir, int nMoney)
{
	STORE_MONEY_COMMAND	StoreMoneyCmd;

	StoreMoneyCmd.ProtocolType = c2s_storemoney;
	StoreMoneyCmd.m_byDir = (BYTE)nDir;
	StoreMoneyCmd.m_dwMoney = nMoney;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&StoreMoneyCmd, sizeof(STORE_MONEY_COMMAND));
}

//rut tien auto
void SendClientCmdWithDrawaMoney(int nDir, int nMoney)// rut tien;
{
	WITHDRAWA_MONEY_COMMAND	StoreMoneyCmd;
	StoreMoneyCmd.ProtocolType = c2s_withdrawamoney;
	StoreMoneyCmd.m_byDir = (BYTE)nDir;
	StoreMoneyCmd.m_dwMoney = nMoney;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&StoreMoneyCmd, sizeof(WITHDRAWA_MONEY_COMMAND));
}
//end code

void SendClientCmdRevive()
{
	PHONGTHAN_POSE_REQUEST request;
	ZeroMemory(&request, sizeof(request));
	PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_WORLD_POSE_REQUEST,
		sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	request.MapId = SubWorld[0].m_SubWorldID;
	request.Kind = PHONGTHAN_POSE_REVIVE;
	if (g_pClient && PhongThanValidatePoseRequest(&request, sizeof(request)))
		g_pClient->SendPackToServer(&request, sizeof(request));
}


#include "ItemActionDiag.h"
void SendClientCmdMoveItem(void* pDownPos, void* pUpPos)
{
	if (!pDownPos || !pUpPos)
		return;

	SO_ItemActionDiagText("Move_CLIENT_LOCK", "locked", Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation(), 0);
	if (Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation())
		return;

	ItemPos* pos1 = (ItemPos *)pDownPos;
	ItemPos* pos2 = (ItemPos *)pUpPos;
	SO_ItemActionDiag("Move_CLIENT_REQUEST", pos1->nPlace, 0, pos1->nX, pos1->nY, pos2->nX, pos2->nY, pos2->nPlace, 0);

	if (pos1->nPlace <= 0 || pos1->nPlace >= pos_num ||
		pos2->nPlace <= 0 || pos2->nPlace >= pos_num ||
		pos1->nX < 0 || pos1->nX > 255 || pos1->nY < 0 || pos1->nY > 255 ||
		pos2->nX < 0 || pos2->nX > 255 || pos2->nY < 0 || pos2->nY > 255)
		return;

	PHONGTHAN_ITEM_MOVE_REQUEST sMove;
	ZeroMemory(&sMove, sizeof(sMove));
	PhongThanInitializeWireHeader(&sMove.Header,
		PHONGTHAN_MSG_INVENTORY_MOVE_REQUEST, sizeof(sMove),
		PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	sMove.FromContainer = (PHONGTHAN_U8)pos1->nPlace;
	sMove.FromX = (PHONGTHAN_U8)pos1->nX;
	sMove.FromY = (PHONGTHAN_U8)pos1->nY;
	sMove.ToContainer = (PHONGTHAN_U8)pos2->nPlace;
	sMove.ToX = (PHONGTHAN_U8)pos2->nX;
	sMove.ToY = (PHONGTHAN_U8)pos2->nY;

	if (g_pClient)
		g_pClient->SendPackToServer(&sMove, sizeof(sMove));

	if (pos1->nPlace != pos_traderoom)
		Player[CLIENT_PLAYER_INDEX].m_ItemList.LockOperation();
}

void SendClientCmdDropItem(DWORD dwItemId)
{
	if (!g_pClient || dwItemId == 0)
		return;
	PHONGTHAN_ITEM_DROP_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_INVENTORY_DROP_REQUEST, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	Request.ItemId = dwItemId;
	g_pClient->SendPackToServer(&Request, sizeof(Request));
}

void SendClientCmdQueryLadder(DWORD	dwLadderID)
{
	if (dwLadderID <= enumLadderBegin || dwLadderID >= enumLadderEnd)
		return;

	if (g_pClient)
	{
		LADDER_QUERY	LadderQuery;
		LadderQuery.ProtocolType = c2s_ladderquery;
		LadderQuery.dwLadderID = dwLadderID;
		g_pClient->SendPackToServer(&LadderQuery, sizeof(LADDER_QUERY));
	}
}

void SendClientCmdRepair(DWORD dwID)
{
	ITEM_REPAIR ItemRepair;
	ItemRepair.ProtocolType = c2s_repairitem;
	ItemRepair.dwItemID = dwID;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&ItemRepair, sizeof(ITEM_REPAIR));
}

void SendClientCmdRide()
{
	PHONGTHAN_POSE_REQUEST request;
	ZeroMemory(&request, sizeof(request));
	PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_WORLD_POSE_REQUEST,
		sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	request.MapId = SubWorld[0].m_SubWorldID;
	request.Kind = PHONGTHAN_POSE_TOGGLE_MOUNT;
	if (g_pClient && PhongThanValidatePoseRequest(&request, sizeof(request)))
		g_pClient->SendPackToServer(&request, sizeof(request));
}

void SendClientCmdBreak(DWORD dwID, int nNum, BOOL bIsBreakAll)
{
	PLAYER_BREAK_COMMAND command;
	command.ProtocolType = c2s_playerbreakcommand;
	command.dwItemID = dwID;
	command.nNum = nNum;
	command.bIsBreakAll = bIsBreakAll;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&command, sizeof(PLAYER_BREAK_COMMAND));
}

void SendClientCPSetImageCmd(int ID)
{
	CP_DATAU SetImageCmd;

	SetImageCmd.ProtocolType = c2s_cpsetimage;
	SetImageCmd.int_ID = ID;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&SetImageCmd, sizeof(CP_DATAU));
}


//TamLTM da tau
void SendClientDaTauCmd(int szScript)
{
	PLAYER_REQUEST_LOAD_DATAU DaTauCmd;

	DaTauCmd.ProtocolType = c2s_DaTau;
	DaTauCmd.sScript = szScript;
//	g_DebugLog("c2s_DaTau: %d", c2s_DaTau); // 136 packet send
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&DaTauCmd, sizeof(PLAYER_REQUEST_LOAD_DATAU));
} 
//end code

/*/ Ma Doc
void SendClientCPActionCheatCmd(char* zString)
{
	GET_STRING GetStringCmd;

	GetStringCmd.ProtocolType = c2s_playeractionchat;
	strcpy(GetStringCmd.szString,zString);
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&GetStringCmd, sizeof(GET_STRING));
}
/*/// End code

//TamLTM kham nam xanh
void SendUiCmdScript(int nType, char*szFunc)
{
	PLAYER_UI_CMD_SCRIPT Cmd;

	Cmd.ProtocolType = c2s_uicmdscript;
	Cmd.nType = nType;
	strcpy(Cmd.szFunc, szFunc);
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&Cmd, sizeof(PLAYER_UI_CMD_SCRIPT));
}

void SendClientRecoveryBox(DWORD dwID, int nX, int nY)
{
	RECOVERY_BOX_CMD Cmd;
	Cmd.ProtocolType = c2s_recoverybox;
	Cmd.dwID   = dwID;
	Cmd.nX	   = nX;
	Cmd.nY     = nY;
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&Cmd, sizeof(RECOVERY_BOX_CMD));
}

void SendClientCmdInputBox(BYTE nType, int* nNum, char* szStr, char* szFunc)
{
	C2S_PLAYER_INPUT_INFO pInput;
	pInput.ProtocolType = c2s_inputinfo;
	pInput.nType = nType;
	strcpy(pInput.szFunc, szFunc);
	strcpy(pInput.szStr, szStr);
	pInput.nNum[0] = nNum[0];
	pInput.nNum[1] = nNum[1];
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&pInput, sizeof(C2S_PLAYER_INPUT_INFO));
}
//end code

//TamLTM progress bar
void SendClientOpenProgressBarCmd(int szScript)
{
	PLAYER_REQUEST_LOAD_PROGRESS_BAR ProgressBarCmd;

	ProgressBarCmd.ProtocolType = c2s_openprogressbar;
	ProgressBarCmd.sScript = szScript;
//	g_DebugLog("szScript->nScript: %s", szScript);
	if (g_pClient)
		g_pClient->SendPackToServer((BYTE*)&ProgressBarCmd, sizeof(PLAYER_REQUEST_LOAD_PROGRESS_BAR));
} 
//end code

//TamLTM Uy Thac offline
void SendClientOffline()
{
	PLAYER_REQUEST_OFFLINE Offline;

	Offline.ProtocolType = c2s_offline;
	if (g_pClient)
	g_pClient->SendPackToServer((BYTE*)&Offline, sizeof(PLAYER_REQUEST_OFFLINE));
}
//end code

void SendClientAutoSellItemCmd(int idShop)
{
    PLAYER_COMMAND_CHANGE_WORD_BUY_SHOP	sCW;
    sCW.ProtocolType = c2s_playerchangewordbuyshop;
    sCW.dwID = Player[CLIENT_PLAYER_INDEX].GetPlayerID();
    sCW.dwTimePacker = GetTickCount();
    sCW.m_wMsgID = idShop;
    if (g_pClient)
        g_pClient->SendPackToServer((BYTE*)&sCW, sizeof(PLAYER_COMMAND_CHANGE_WORD_BUY_SHOP));
}

#endif


#ifdef _SERVER
void SendServerCmdWalk(int nX, int nY)
{
}

void SendServerCmdRun(int nX, int nY)
{
}
#endif

