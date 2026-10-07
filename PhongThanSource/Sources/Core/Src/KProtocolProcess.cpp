#include "KEngine.h"
#include "KCore.h"
#include "PhongThanCompose.h"
#include "PhongThanPlayerProtocol.h"
#include "PhongThanWorldProtocol.h"
#include "PhongThanWorldRuntime.h"
#include "PhongThanGameplayProtocol.h"
#include "PhongThanObjectProtocol.h"
#ifndef _SERVER
#include "../../Headers/IClient.h"
#include "CoreShell.h"
#include "KViewItem.h"
#include "KSellItem.h"
#endif
#include "KObjSet.h"
#include "KNpcSet.h"
#include "KPlayer.h"
#include "PhongThanScriptWire.h"
#include "KPlayerSet.h"
#include "KPlayerTeam.h"
#include "KPlayerChatRoom.h"
#include "KPlayerProfession.h"
#include "KTongData.h"
#include "KNpc.h"
#include "KNpcRes.h"
#include "KSubWorld.h"
#include "KTaskFuns.h"
#include "LuaFuns.h"
#include "KProtocolProcess.h"
#include "KSkills.h"
#include "KThiefSkill.h"
#include "KItemSet.h"
#include "KPhongThanAppearance.h"
#include "KBuySell.h"
#include "KSubWorldSet.h"
#include "KMissle.h"
#include "KOption.h"
//#include "MyAssert.h"
#include "Scene/ObstacleDef.h"
#include "KMath.h"
#ifndef _SERVER
#include "Scene\KScenePlaceC.h"
#include <time.h>
#endif
#include "KTongProtocol.h"
#include "KLadder.h"
#include "PhongThanWorldDispatch.inl"

KProtocolProcess g_ProtocolProcess;
KProtocolProcess::KProtocolProcess()
{
	ZeroMemory(ProcessFunc, sizeof(ProcessFunc));
#ifndef _SERVER
	ProcessFunc[s2c_login] = NULL;
	ProcessFunc[s2c_logout] = NULL;
	ProcessFunc[s2c_syncend] = NULL; // native world protocol
	ProcessFunc[s2c_synccurplayer] = NULL; // native world protocol
	ProcessFunc[s2c_synccurplayerskill] = NULL; // native skill protocol
	ProcessFunc[s2c_synccurplayernormal] = NULL; // native world protocol
	ProcessFunc[s2c_newplayer] = NULL;
	ProcessFunc[s2c_removeplayer] = NULL;
	ProcessFunc[s2c_syncworld] = NULL; // native world protocol
	ProcessFunc[s2c_syncplayer] = NULL; // retired: native player snapshot
	ProcessFunc[s2c_syncplayermin] = NULL; // retired: native player snapshot
	ProcessFunc[s2c_syncnpc] = NULL; // retired: native world protocol
	ProcessFunc[s2c_syncnpcmin] = NULL; // retired: native world protocol
	ProcessFunc[s2c_syncnpcminplayer] = NULL; // native world state
	ProcessFunc[s2c_objadd] = NULL; // native object protocol
	ProcessFunc[s2c_syncobjstate] = NULL; // native object protocol
	ProcessFunc[s2c_syncobjdir] = NULL; // native object protocol
	ProcessFunc[s2c_objremove] = NULL; // native object protocol
	ProcessFunc[s2c_npcremove] = NULL; // retired: native world protocol
	ProcessFunc[s2c_npcwalk] = NULL; // retired: native world protocol
	ProcessFunc[s2c_npcrun] = NULL; // retired: native world protocol
	ProcessFunc[s2c_npcjump] = NULL; // retired: native world protocol
	ProcessFunc[s2c_npchurt] = NULL; // native world state
	ProcessFunc[s2c_npcdeath] = NULL; // native world state
	ProcessFunc[s2c_npcchgcurcamp] = NULL; // native world state
	ProcessFunc[s2c_npcchgcamp] = NULL; // native world state
	ProcessFunc[s2c_skillcast] = NULL; // retired: native gameplay protocol
	ProcessFunc[s2c_playerexp] = NULL; // native player events
	ProcessFunc[s2c_teaminfo] = &KProtocolProcess::s2cShowTeamInfo;
	ProcessFunc[s2c_teamselfinfo] = &KProtocolProcess::s2cUpdataSelfTeamInfo;
	ProcessFunc[s2c_teamapplyinfofalse] = &KProtocolProcess::s2cApplyTeamInfoFalse;
	ProcessFunc[s2c_teamcreatesuccess] = &KProtocolProcess::s2cCreateTeam;
	ProcessFunc[s2c_teamcreatefalse] = &KProtocolProcess::s2cApplyCreateTeamFalse;
	ProcessFunc[s2c_teamchangestate] = &KProtocolProcess::s2cSetTeamState;
	ProcessFunc[s2c_teamgetapply] = &KProtocolProcess::s2cApplyAddTeam;
	ProcessFunc[s2c_teamaddmember] = &KProtocolProcess::s2cTeamAddMember;
	ProcessFunc[s2c_teamleave] = &KProtocolProcess::s2cLeaveTeam;
	ProcessFunc[s2c_teamchangecaptain] = &KProtocolProcess::s2cTeamChangeCaptain;
	ProcessFunc[s2c_playerprofessiondata] = &KProtocolProcess::s2cSetProfessionData;
	ProcessFunc[s2c_playermissiondata] = &KProtocolProcess::s2cSetMissionData;
	ProcessFunc[s2c_playersyncleadexp] = &KProtocolProcess::s2cGetLeadExp;
	ProcessFunc[s2c_playerlevelup] = NULL; // native player events
	ProcessFunc[s2c_teammatelevel] = &KProtocolProcess::s2cGetTeammateLevel;
	ProcessFunc[s2c_playersyncattribute] = NULL; // native attributes/skills
	ProcessFunc[s2c_playerskilllevel] = NULL; // native attributes/skills
	ProcessFunc[s2c_syncitem] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT
	ProcessFunc[s2c_syncmagic] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES
	ProcessFunc[s2c_removeitem] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE
	ProcessFunc[s2c_syncmoney] = &KProtocolProcess::s2cSyncMoney;
	ProcessFunc[s2c_playermoveitem] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_MOVE
	ProcessFunc[s2c_scriptaction] = NULL; // native Lua UI protocol
	ProcessFunc[s2c_syncrolelist] = &KProtocolProcess::s2cSyncRoleList;
	ProcessFunc[s2c_tradechangestate] = &KProtocolProcess::s2cTradeChangeState;
	ProcessFunc[s2c_npcsetmenustate] = &KProtocolProcess::s2cNpcSetMenuState;
	ProcessFunc[s2c_trademoneysync] = &KProtocolProcess::s2cTradeMoneySync;
	ProcessFunc[s2c_tradedecision] = &KProtocolProcess::s2cTradeDecision;
	ProcessFunc[s2c_teaminviteadd] = &KProtocolProcess::s2cTeamInviteAdd;
	ProcessFunc[s2c_tradepressoksync] = &KProtocolProcess::s2cTradePressOkSync;
	ProcessFunc[s2c_ping] = &KProtocolProcess::s2cPing;
	ProcessFunc[s2c_npcsit] = NULL; // native world state
	ProcessFunc[s2c_npcstand] = NULL; // native world state
	ProcessFunc[s2c_npcchat] = &KProtocolProcess::NetCommandChat;
	ProcessFunc[s2c_npcsetpos] = NULL; // native world state
	ProcessFunc[s2c_opensalebox] = &KProtocolProcess::OpenSaleBox;
	ProcessFunc[s2c_castskilldirectly] = NULL; // retired: native gameplay protocol
	ProcessFunc[s2c_msgshow] = &KProtocolProcess::s2cShowMsg;
	ProcessFunc[s2c_syncstateeffect] = NULL; // native skill protocol
	ProcessFunc[s2c_ignorestate] = NULL; // native attributes/skills
	ProcessFunc[s2c_opensomebox] = &KProtocolProcess::OpenSomeBox;
	ProcessFunc[s2c_playerrevive] = NULL; // native world state
	ProcessFunc[s2c_requestnpcfail] = NULL; // retired: native world protocol
	ProcessFunc[s2c_tradeapplystart] = &KProtocolProcess::s2cTradeApplyStart;
	ProcessFunc[s2c_createtong] = &KProtocolProcess::s2cCreateTong;
	ProcessFunc[s2c_jointong] = &KProtocolProcess::s2cJoinTong;
	ProcessFunc[s2c_jointongreply] = &KProtocolProcess::s2cJoinTongReply;
	ProcessFunc[s2c_rolenewdelresponse] = NULL;
	ProcessFunc[s2c_ItemAutoMove] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE
	ProcessFunc[s2c_changeweather] = &KProtocolProcess::s2cChangeWeather;
	ProcessFunc[s2c_pksyncnormalflag] = &KProtocolProcess::s2cPKSyncNormalFlag;
	ProcessFunc[s2c_pksyncenmitystate] = &KProtocolProcess::s2cPKSyncEnmityState;
	ProcessFunc[s2c_pksyncexercisestate] = &KProtocolProcess::s2cPKSyncExerciseState;
	ProcessFunc[s2c_pksyncpkvalue] = &KProtocolProcess::s2cPKValueSync;
	ProcessFunc[s2c_npcsleepmode] = &KProtocolProcess::NpcSleepSync;
	ProcessFunc[s2c_viewequip] = &KProtocolProcess::s2cViewEquip;
	ProcessFunc[s2c_ladderresult] = &KProtocolProcess::LadderResult;
	ProcessFunc[s2c_ladderlist] = &KProtocolProcess::LadderList;
	ProcessFunc[s2c_tongcreate] = &KProtocolProcess::s2cTongCreate;
	ProcessFunc[s2c_replyclientping] = &KProtocolProcess::ServerReplyClientPing;
	ProcessFunc[s2c_itemdurabilitychange] = NULL; // retired: use PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY
	ProcessFunc[s2c_playertradeaction] = &KProtocolProcess::SendTradeAction;
	ProcessFunc[s2c_playertradeitem] = &KProtocolProcess::SendTradeItem;
	ProcessFunc[s2c_playertradecount] = &KProtocolProcess::SendTradeCount;	
	ProcessFunc[s2c_playertradefail] = &KProtocolProcess::SendTradeFail;	
	ProcessFunc[s2c_titlename] = NULL; // native player events
	ProcessFunc[s2c_expandrank] = NULL; // native player events
	ProcessFunc[s2c_npchorsesync] = NULL; // native player events
	ProcessFunc[s2c_synctaskvalue] = &KProtocolProcess::s2cSyncTaskValue;
	ProcessFunc[s2c_playersync] = NULL; // native player events
	/*//TamLTM fix send packet
	ProcessFunc[s2c_playersyncofflive] = &KProtocolProcess::s2cplayersyncofflive; //1
	ProcessFunc[s2c_playersyncmagicpoint] = &KProtocolProcess::s2cplayersyncmagicpoint; //2
	ProcessFunc[s2c_playersyncproppoint] = &KProtocolProcess::s2cplayersyncproppoint; //3
	ProcessFunc[s2c_playersyncinput] = &KProtocolProcess::s2cplayersyncinput; //4
	ProcessFunc[s2c_playersyncopenenchase] = &KProtocolProcess::s2cplayersyncopenenchase; //5
	ProcessFunc[s2c_playersyncrankdata] = &KProtocolProcess::s2cplayersyncrankdata; //6
	ProcessFunc[s2c_playersyncmaskfeature] = &KProtocolProcess::s2cplayersyncmaskfeature; //7
	ProcessFunc[s2c_playersynclockstate] = &KProtocolProcess::s2cplayersynclockstate; //8
	ProcessFunc[s2c_playersyncequipexpand] = &KProtocolProcess::s2cplayersyncequipexpand; //9
	ProcessFunc[s2c_playersyncexpandbox] = &KProtocolProcess::s2cplayersyncexpandbox; //10
	ProcessFunc[s2c_playersyncgive] = &KProtocolProcess::s2cplayersyncgive; //11*/
	//end code
	ProcessFunc[s2c_extpointsync] = &KProtocolProcess::s2cExtPointValueSync; //TamLTM fix xu;
	ProcessFunc[s2c_opengive] = &KProtocolProcess::SyncGive;
	ProcessFunc[s2c_syncmasklock] = &KProtocolProcess::SyncMaskLock;
	ProcessFunc[s2c_syncrankdata] = &KProtocolProcess::s2cSyncRankData;
	ProcessFunc[s2c_syncsupershop] = &KProtocolProcess::s2cSyncSuperShop;
	ProcessFunc[s2c_sparapplystart] = &KProtocolProcess::s2cSparApplyStart;
	ProcessFunc[s2c_lockmove] = &KProtocolProcess::s2cLockMove;
	ProcessFunc[s2c_chatroomstate] = &KProtocolProcess::s2cChatRoomState;
	ProcessFunc[s2c_chatroomcreatefalse] = &KProtocolProcess::s2cApplyCreateChatRoomFalse;
	ProcessFunc[s2c_requestchatroomlist] = &KProtocolProcess::s2cRequestChatRoomList;
	ProcessFunc[s2c_requestmemberlist] = &KProtocolProcess::s2cRequestMemberList;
	ProcessFunc[s2c_requestblacklist] = &KProtocolProcess::s2cRequestBlackList;
	ProcessFunc[s2c_finishquest] = &KProtocolProcess::OpenDTBox;//TamLTM da tau vng
	ProcessFunc[s2c_otherbox] = &KProtocolProcess::s2cOpenOtherBox; //TamLTM kham
	ProcessFunc[s2c_openprogressbar] = &KProtocolProcess::OpenProgressBar; //TamLTM open progress bar
	ProcessFunc[s2c_syncposmin] = NULL; // native world state
//    ProcessFunc[s2c_syncnpcstate] = &KProtocolProcess::s2cUpdateNpcState;

	ProcessFunc[s2c_extend] = &KProtocolProcess::s2cExtend;
	ProcessFunc[s2c_extendchat] = &KProtocolProcess::s2cExtendChat;
	ProcessFunc[s2c_extendfriend] = &KProtocolProcess::s2cExtendFriend;
	ProcessFunc[s2c_extendtong] = &KProtocolProcess::s2cExtendTong;


#else
	ProcessFunc[c2s_login] = NULL;
	ProcessFunc[c2s_logiclogin] = NULL;
	ProcessFunc[c2s_syncend] = NULL;
	ProcessFunc[c2s_loadplayer] = NULL;
	ProcessFunc[c2s_newplayer] = NULL;
	ProcessFunc[c2s_removeplayer] = &KProtocolProcess::RemoveRole;
	ProcessFunc[c2s_requestworld] = NULL;
	ProcessFunc[c2s_requestplayer] = NULL;
	ProcessFunc[c2s_requestnpc] = NULL; // retired: native world protocol
	ProcessFunc[c2s_requestobj] = NULL; // native object protocol
	ProcessFunc[c2s_npcwalk] = NULL; // retired: native world protocol
	ProcessFunc[c2s_npcrun] = NULL; // retired: native world protocol
	ProcessFunc[c2s_npcskill] = NULL; // retired: native gameplay protocol
	ProcessFunc[c2s_teamapplyinfo] = &KProtocolProcess::PlayerApplyTeamInfo;
	ProcessFunc[c2s_teamapplycreate] = &KProtocolProcess::PlayerApplyCreateTeam;
	ProcessFunc[c2s_teamapplychangestate] = &KProtocolProcess::PlayerApplyTeamChangeState;
	ProcessFunc[c2s_teamapplyadd] = &KProtocolProcess::PlayerApplyAddTeam;
	ProcessFunc[c2s_teamacceptmember] = &KProtocolProcess::PlayerAcceptTeamMember;
	ProcessFunc[c2s_teamapplyleave] = &KProtocolProcess::PlayerApplyLeaveTeam;
	ProcessFunc[c2s_teamapplykickmember] = &KProtocolProcess::PlayerApplyTeamKickMember;
	ProcessFunc[c2s_teamapplychangecaptain] = &KProtocolProcess::PlayerApplyTeamChangeCaptain;
	ProcessFunc[c2s_teamapplydismiss] = &KProtocolProcess::PlayerApplyTeamDismiss;
	ProcessFunc[c2s_playerapplysetpk] = &KProtocolProcess::PlayerApplySetPK;
	ProcessFunc[c2s_playeraddbaseattribute] = NULL; // native attributes/skills
	ProcessFunc[c2s_playerapplyaddskillpoint] = NULL; // native attributes/skills
	ProcessFunc[c2s_playereatitem] = NULL;
	ProcessFunc[c2s_playerpickupitem] = NULL;
	ProcessFunc[c2s_playermoveitem] = NULL;
	ProcessFunc[c2s_playersellitem] = NULL;
	ProcessFunc[c2s_playerbuyitem] = NULL;
	ProcessFunc[c2s_playerthrowawayitem] = NULL;
	ProcessFunc[c2s_playerselui] = NULL; // native Lua UI protocol
	ProcessFunc[c2s_dbplayerselect] = NULL;
	ProcessFunc[c2s_tradeapplystateopen] = &KProtocolProcess::TradeApplyOpen;
	ProcessFunc[c2s_tradeapplystateclose] = &KProtocolProcess::TradeApplyClose;
	ProcessFunc[c2s_tradeapplystart] = &KProtocolProcess::TradeApplyStart;
	ProcessFunc[c2s_trademovemoney] = &KProtocolProcess::TradeMoveMoney;
	ProcessFunc[c2s_tradedecision] = &KProtocolProcess::TradeDecision;
	ProcessFunc[c2s_dialognpc] = NULL; // retired: native gameplay protocol
	ProcessFunc[c2s_teaminviteadd]	= &KProtocolProcess::TeamInviteAdd;
	ProcessFunc[c2s_changeauraskill] = &KProtocolProcess::ChangeAuraSkill;
	ProcessFunc[c2s_teamreplyinvite] = &KProtocolProcess::TeamReplyInvite;
	ProcessFunc[c2s_ping] = NULL;//ReplyPing;
	ProcessFunc[c2s_npcsit] = NULL; // native world state
	ProcessFunc[c2s_objmouseclick] = NULL; // native object protocol
	ProcessFunc[c2s_storemoney] = &KProtocolProcess::StoreMoneyCommand;
	ProcessFunc[c2s_withdrawamoney] = &KProtocolProcess::WithDrawaMoneyCommand; // rut tien;
	ProcessFunc[c2s_playerrevive] = NULL; // native world state
	ProcessFunc[c2s_tradereplystart] = &KProtocolProcess::c2sTradeReplyStart;
	ProcessFunc[c2s_pkapplychangenormalflag] = &KProtocolProcess::c2sPKApplyChangeNormalFlag;
	ProcessFunc[c2s_pkapplyenmity] = &KProtocolProcess::c2sPKApplyEnmity;
	ProcessFunc[c2s_viewequip] = &KProtocolProcess::c2sViewEquip;
	ProcessFunc[c2s_ladderquery] = &KProtocolProcess::LadderQuery;
	ProcessFunc[c2s_repairitem] = &KProtocolProcess::ItemRepair;
	ProcessFunc[c2s_playertradeset] = &KProtocolProcess::TradeSet;
	ProcessFunc[c2s_playertradestart] = &KProtocolProcess::TradeStart;
	ProcessFunc[c2s_playertradeview] = &KProtocolProcess::TradeView;
	ProcessFunc[c2s_playertradebuy] = &KProtocolProcess::TradeBuy;
	ProcessFunc[c2s_playertradeviewend] = &KProtocolProcess::TradeEnd;
	ProcessFunc[c2s_npchorse] = NULL; // native world state
	ProcessFunc[c2s_playercommand] = &KProtocolProcess::PlayerCommand;
	ProcessFunc[c2s_playerlockitem] = &KProtocolProcess::PlayerLockItem;
	ProcessFunc[c2s_playerunlockitem] = &KProtocolProcess::PlayerUnLockItem;
	ProcessFunc[c2s_inputcommand] = &KProtocolProcess::InputCommand;
	ProcessFunc[c2s_unlockcommand] = &KProtocolProcess::UnlockCommand;
	ProcessFunc[c2s_playerbreakcommand] = &KProtocolProcess::BreakCommand ;
	ProcessFunc[c2s_jointongreply] = &KProtocolProcess::JoinTongReply;
	ProcessFunc[c2s_sparapplystart] = &KProtocolProcess::SparApplyStart;
	ProcessFunc[c2s_lockmove] = &KProtocolProcess::LockMove;
	ProcessFunc[c2s_chatroomdecision] = &KProtocolProcess::ChatRoomDecision;
	ProcessFunc[c2s_cpsetimage] = &KProtocolProcess::c2sSetImage;
	ProcessFunc[c2s_DaTau] = &KProtocolProcess::NpcDaTauCommand;//TamLTM da tau vng quest
//	ProcessFunc[c2s_playeractionchat] = &KProtocolProcess::C2SPlayerActionChatCmd; // Ma Doc
	ProcessFunc[c2s_uicmdscript] = &KProtocolProcess::UiCommandScript; //TamLTM kham nam xanh
	ProcessFunc[c2s_recoverybox] = &KProtocolProcess::RecoveryBoxCmd; //TamLTM kham nam xanh
	ProcessFunc[c2s_inputinfo]	=	&KProtocolProcess::c2sInputCommand; //TamLTM kham nam xanh
	ProcessFunc[c2s_openprogressbar] = &KProtocolProcess::NpcOpenProgressBarCommand;//TamLTM open progress bar
	ProcessFunc[c2s_offline]=&KProtocolProcess::NpcOfflineCommand; //TamLTM Uy thac offline
    ProcessFunc[c2s_playerchangewordbuyshop] = &KProtocolProcess::PlayerChangeWordBuyShop; //TamLTM auto c2s_playerchangeword
	
#endif
}

KProtocolProcess::~KProtocolProcess()
{
}

#ifndef _SERVER
void KProtocolProcess::ProcessNetMsg(BYTE* pMsg, unsigned int nMsgSize)
{
	if (!pMsg || nMsgSize == 0)
	{
		g_DebugLog("[PhongThanWire] Empty server packet");
		return;
	}

	if (PhongThanIsWirePacket(pMsg, nMsgSize))
	{
		PHONGTHAN_WIRE_HEADER* pHeader = (PHONGTHAN_WIRE_HEADER*)pMsg;
		if (!PhongThanValidateWireHeader(pHeader, nMsgSize) ||
			pHeader->PacketSize != nMsgSize)
		{
			g_DebugLog("[PhongThanWire] Invalid server packet size=%u", nMsgSize);
			return;
		}

		if (ProcessPhongThanWorldPacket(pMsg, nMsgSize))
			return;
		if (Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation())
			Player[CLIENT_PLAYER_INDEX].m_ItemList.UnlockOperation();

		switch (pHeader->MessageType)
		{
		case PHONGTHAN_MSG_UI_SCRIPT_ACTION:
			// Lua item/NPC dialogs are native wire packets.  They must be
			// dispatched here before the legacy one-byte protocol table; the
			// latter intentionally leaves s2c_scriptaction retired.
			if (!PhongThanValidateUiAction(pMsg, nMsgSize))
			{
				g_DebugLog("[PhongThanUI] invalid script action packet size=%u",
					(unsigned int)nMsgSize);
				return;
			}
			SyncScriptAction(pMsg);
			break;
		case PHONGTHAN_MSG_IBSHOP_OPEN_RESPONSE:
			{
				if (nMsgSize != sizeof(PHONGTHAN_IBSHOP_OPEN_RESPONSE) ||
					pHeader->Flags != PHONGTHAN_WIRE_FLAG_RESPONSE) return;
				const PHONGTHAN_IBSHOP_OPEN_RESPONSE* shop =
					(const PHONGTHAN_IBSHOP_OPEN_RESPONSE*)pMsg;
				if (shop->ShopCount != PHONGTHAN_IBSHOP_TAB_COUNT) return;
				BuySellInfo info;
				info.Clear();
				info.m_nShopNum = shop->ShopCount;
				info.m_nMoneyUnit = moneyunit_money;
				for (int tab = 0; tab < shop->ShopCount; ++tab)
				{
					if (shop->ShopIds[tab] != PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + tab) return;
					info.m_nShopIdx[tab] = shop->ShopIds[tab];
				}
				BuySell.OpenSale(0, &info);
			}
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT:
			if (!PhongThanValidateItemSnapshot(pMsg, nMsgSize))
			{
				g_DebugLog("[PhongThanWire] Invalid item snapshot size=%u", nMsgSize);
				return;
			}
			s2cSyncItem(pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE:
			s2cRemoveItem(pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_MOVE:
			s2cMoveItem(pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY:
			ItemChangeDurability(pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES:
			s2cSyncMagic(pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE:
			s2cItemAutoMove(pMsg);
			break;
		default:
			g_DebugLog("[PhongThanWire] Unsupported server message=%u",
				(unsigned int)pHeader->MessageType);
			break;
		}
		return;
	}

	if (!pMsg || pMsg[0] <= s2c_clientbegin || pMsg[0] >= s2c_end || ProcessFunc[pMsg[0]] == NULL)
	{
		if (!pMsg)
			g_DebugLog("[Net Msg Error]!pMsg");
		else if (pMsg[0] <= s2c_clientbegin)
			g_DebugLog("[Net Msg Error]%d <= %d", pMsg[0], s2c_clientbegin);
		else if (pMsg[0] >= s2c_end)
			g_DebugLog("[Net Msg Error]%d >= %d", pMsg[0], s2c_end);
		else if (ProcessFunc[pMsg[0]] == NULL)
			g_DebugLog("[Net Msg Error]ProcessFunc[%d] == NULL", pMsg[0]);
		return;
	}

	if (ProcessFunc[pMsg[0]])
	{
		if(Player[CLIENT_PLAYER_INDEX].m_ItemList.IsLockOperation())
			Player[CLIENT_PLAYER_INDEX].m_ItemList.UnlockOperation();
		(this->*ProcessFunc[pMsg[0]])(pMsg);
	}
}
#else
#include "PhongThanComposeServer.inl"
void KProtocolProcess::ProcessNetMsg(int nIndex, BYTE* pMsg, unsigned int nMsgSize)
{
	if (!pMsg || nMsgSize == 0)
		return;
	if (PhongThanIsWirePacket(pMsg, nMsgSize))
	{
		PHONGTHAN_WIRE_HEADER* pHeader = (PHONGTHAN_WIRE_HEADER*)pMsg;
		if (!PhongThanValidateWireHeader(pHeader, nMsgSize) ||
			pHeader->PacketSize != nMsgSize)
		{
			g_DebugLog("[PhongThanWire] Invalid client packet size=%u", nMsgSize);
			return;
		}
		if (nIndex <= 0 || nIndex >= MAX_PLAYER ||
			pHeader->Flags != PHONGTHAN_WIRE_FLAG_REQUEST)
		{
			g_DebugLog("[PhongThanWire] Invalid item request player=%d flags=%u",
				nIndex, (unsigned int)pHeader->Flags);
			return;
		}

		if (pHeader->MessageType == PHONGTHAN_MSG_IBSHOP_OPEN_REQUEST)
		{
			if (nMsgSize != sizeof(PHONGTHAN_WIRE_HEADER) ||
				Player[nIndex].CheckTrading()) return;
			PLAYER_COMMAND command;
			ZeroMemory(&command, sizeof(command));
			command.m_wMsgID = enumC2S_PLAYERCOMMAND_ID_SUPERSHOP;
			PlayerCommand(nIndex, (BYTE*)&command);
			return;
		}
		if (pHeader->MessageType == PHONGTHAN_COMPOSE_REQUEST)
        {
            if(PhongThanValidateComposeCommand(pMsg,nMsgSize))
                PhongThanProcessCompose(nIndex,(const PHONGTHAN_COMPOSE_COMMAND*)pMsg);
            return;
        }
        if (ProcessPhongThanWorldPacket(nIndex, pMsg, nMsgSize))
			return;
		BOOL bLockedOperation =
			pHeader->MessageType == PHONGTHAN_MSG_INVENTORY_DROP_REQUEST ||
			pHeader->MessageType == PHONGTHAN_MSG_NPC_SHOP_SELL_REQUEST ||
			pHeader->MessageType == PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST;
		if (bLockedOperation && Player[nIndex].GetLockState())
		{
			SHOW_MSG_SYNC sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_FUNCTION_LOCKED;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx,
				&sMsg, sMsg.m_wLength + 1);
			return;
		}

		if (Player[nIndex].m_nPaceBarTime)
		{
			Player[nIndex].m_nPaceBarTime = 0;
			Player[nIndex].m_nPaceBarTimeMax = 0;
			Player[nIndex].LoadScriptProgressBar(2);
		}

		switch (pHeader->MessageType)
		{
		case PHONGTHAN_MSG_INVENTORY_USE_REQUEST:
			PlayerEatItem(nIndex, pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST:
			PlayerPickUpItem(nIndex, pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_MOVE_REQUEST:
			PlayerMoveItem(nIndex, pMsg);
			break;
		case PHONGTHAN_MSG_INVENTORY_DROP_REQUEST:
			PlayerDropItem(nIndex, pMsg);
			break;
		case PHONGTHAN_MSG_NPC_SHOP_SELL_REQUEST:
			PlayerSellItem(nIndex, pMsg);
			break;
		case PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST:
			PlayerBuyItem(nIndex, pMsg);
			break;
		default:
			g_DebugLog("[PhongThanWire] Unsupported client message=%u",
				(unsigned int)pHeader->MessageType);
			return;
		}
		Player[nIndex].SetLastNetOperationTime(g_SubWorldSet.GetGameTime());
		return;
	}

	_ASSERT(pMsg && pMsg[0] > c2s_gameserverbegin && pMsg[0] < c2s_end);

	BYTE	byProtocol = pMsg[0];
	_ASSERT(nIndex > 0 && nIndex < MAX_PLAYER);
	if (!pMsg || pMsg[0] <= c2s_gameserverbegin || pMsg[0] >= c2s_end || ProcessFunc[pMsg[0]] == NULL)
	{
		if (!pMsg)
			g_DebugLog("[error-Server Protocol]!pMsg");
		else if (pMsg[0] <= s2c_clientbegin)
			g_DebugLog("[error-Server Protocol]%d <= %d", pMsg[0], c2s_gameserverbegin);
		else if (pMsg[0] >= s2c_end)
			g_DebugLog("[error-Server Protocol]%d >= %d", pMsg[0], c2s_end);
		else if (ProcessFunc[pMsg[0]] == NULL)
			g_DebugLog("[error-Server Protocol]ProcessFunc[%d] == NULL", pMsg[0]);
		return;
	}
	if (ProcessFunc[byProtocol])
	{
		if (nIndex > 0 && nIndex < MAX_PLAYER)
		{
			if (Player[nIndex].GetLockState() && 
				(byProtocol == c2s_tradeapplystateopen
				|| byProtocol == c2s_tradeapplystart
				|| byProtocol == c2s_playerbuyitem
				|| byProtocol == c2s_playersellitem
				|| byProtocol == c2s_storemoney
				|| byProtocol == c2s_withdrawamoney // rut tien;
				|| byProtocol == c2s_playertradestart
				|| byProtocol == c2s_playertradebuy
				/*|| byProtocol == c2s_playereatitem*/
				|| byProtocol == c2s_playerthrowawayitem)
				)
			{
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wMsgID = enumMSG_ID_FUNCTION_LOCKED;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				return;
			}
			else if (Player[nIndex].m_nPaceBarTime && 
				(byProtocol >= c2s_npcwalk)
				)
			{
				Player[nIndex].m_nPaceBarTime = 0;
				Player[nIndex].m_nPaceBarTimeMax = 0;
				Player[nIndex].LoadScriptProgressBar(2); // set script that bai progress bar
			//	g_DebugLog("huy progressbar thanh life Player[nIndex].m_nPaceBarTime = 0;");
			}
			(this->*ProcessFunc[byProtocol])(nIndex, pMsg);
			Player[nIndex].SetLastNetOperationTime(g_SubWorldSet.GetGameTime());
		}
	}
}
#endif



#ifndef _SERVER
void KProtocolProcess::NpcSleepSync(BYTE* pMsg)
{
	NPC_SLEEP_SYNC*	pSync = (NPC_SLEEP_SYNC *)pMsg;
	DWORD	dwNpcId = pSync->NpcID;

	int nIdx = NpcSet.SearchID(dwNpcId);

	if (nIdx > 0)
	{
		Npc[nIdx].SetSleepMode((BOOL)pSync->bSleep);
		Npc[nIdx].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	}
}

void KProtocolProcess::s2cPing(BYTE* pMsg)
{
//	DWORD	dwTimer = GetTickCount();
//	PING_COMMAND* PingCmd = (PING_COMMAND *)pMsg;
//
//	dwTimer -= PingCmd->m_dwTime;
//	dwTimer >>= 1;
//	g_SubWorldSet.SetPing(dwTimer);
//	g_bPingReply = TRUE;

	DWORD	dwTimer = GetTickCount();
	PING_COMMAND*	PingCmd = (PING_COMMAND *)pMsg;
	PING_CLIENTREPLY_COMMAND	pcc;
	pcc.ProtocolType = c2s_ping;
	pcc.m_dwReplyServerTime = PingCmd->m_dwTime;
	pcc.m_dwClientTime = dwTimer;
	g_pClient->SendPackToServer(&pcc, sizeof(PING_CLIENTREPLY_COMMAND));
	//g_SubWorldSet.SetPing(PingCmd->m_dwTime);
}

void KProtocolProcess::ServerReplyClientPing(BYTE* pMsg)
{
	DWORD	dwTimer = GetTickCount();
	PING_COMMAND* pPc = (PING_COMMAND *)pMsg;

	dwTimer -= pPc->m_dwTime;
	dwTimer >>= 1;
	g_SubWorldSet.SetPing(dwTimer);
}

void KProtocolProcess::s2cPlayerExp(BYTE* pMsg)
{
	const PHONGTHAN_EXPERIENCE_EVENT* pExp = (const PHONGTHAN_EXPERIENCE_EVENT*)pMsg;
	Player[CLIENT_PLAYER_INDEX].s2cSetExp(pExp->Experience);
}




void	KProtocolProcess::s2cSyncTaskValue(BYTE* pMsg)
{
	S2C_SYNCTASKVALUE *Cmd = (S2C_SYNCTASKVALUE*)pMsg;
	Player[CLIENT_PLAYER_INDEX].m_cTask.SetSaveVal(Cmd->nTaskId, Cmd->szTaskValue);
}



void	KProtocolProcess::SyncGive(BYTE* pMsg)
{
	if (Player[CLIENT_PLAYER_INDEX].CheckTrading())
		return;

	PLAYER_GIVE *temp = (PLAYER_GIVE *)pMsg;
	CoreDataChanged(GDCNI_GIVE, (unsigned int)temp->m_szName, (int)temp->m_szInitString);
}

void KProtocolProcess::SyncMaskLock(BYTE* pMsg)
{
	NPC_MASK_SYNC *pInfo = (NPC_MASK_SYNC *)pMsg;
	Player[CLIENT_PLAYER_INDEX].m_ItemList.SetMaskLock(pInfo->ID);
}









void KProtocolProcess::NetCommandChat(BYTE* pMsg)
{
	NPC_CHAT_SYNC *pSync = (NPC_CHAT_SYNC*)pMsg;

	int nIdx = NpcSet.SearchID(pSync->ID);

	if (nIdx > 0)
	{
		Npc[nIdx].SetChatInfo(Npc[nIdx].Name, pSync->szMsg, pSync->nMsgLen);
		Npc[nIdx].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	}
}


void KProtocolProcess::OpenSaleBox(BYTE* pMsg)
{
	SALE_BOX_SYNC* pSale = (SALE_BOX_SYNC *)pMsg;

	BuySell.OpenSale((BuySellInfo*)&pSale->m_BuySellInfo);
}

void KProtocolProcess::OpenSomeBox(BYTE* pMsg)
{
	SOME_BOX_SYNC* pBox = (SOME_BOX_SYNC *)pMsg;

	if (pBox->bEquipEx)
		CoreDataChanged(GDCNI_OPEN_EQUIPEX_BOX, NULL, NULL);
	else
		CoreDataChanged(GDCNI_OPEN_STORE_BOX, pBox->nBoxIndex, NULL);
}




void KProtocolProcess::NetCommandSkill(BYTE* data)
{
	const PHONGTHAN_SKILL_CAST* skill = (const PHONGTHAN_SKILL_CAST*)data;
	const int index = NpcSet.SearchID(skill->EntityId);
	if (index <= 0 || index >= MAX_NPC) return;
	int x = skill->X, y = skill->Y;
	if (skill->TargetKind == PHONGTHAN_SKILL_TARGET_ENTITY)
	{
		y = NpcSet.SearchID(skill->TargetId);
		if (y <= 0 || y >= MAX_NPC || Npc[y].m_RegionIndex < 0) return;
		x = -1;
	}
	if (Player[CLIENT_PLAYER_INDEX].ConformIdx(index))
	{
		Npc[index].m_SkillList.SetSkillLevel(skill->SkillId, skill->SkillLevel);
		Npc[index].SendCommand(do_skill, skill->SkillId, x, y);
		Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	}
}


//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ���鴴��ʧ��
//-------------------------------------------------------------------------
void KProtocolProcess::s2cApplyCreateTeamFalse(BYTE* pMsg)
{
	PLAYER_SEND_CREATE_TEAM_FALSE *pCreateFalse = (PLAYER_SEND_CREATE_TEAM_FALSE*)pMsg;
	KSystemMessage	sMsg;

	switch (pCreateFalse->m_btErrorID)
	{
	// �Ѿ��ڶ����У�˵���ͻ��˶��������д����������»�ö�������
	case Team_Create_Error_InTeam:
		Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		break;

	// ��ǰ���ڲ������״̬
	case Team_Create_Error_CannotCreate:
		sprintf(sMsg.szMessage, MSG_TEAM_CANNOT_CREATE);
		sMsg.eType = SMT_NORMAL;
		sMsg.byConfirmType = SMCT_NONE;
		sMsg.byPriority = 0;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		break;
	case Team_Create_Error_NormalPK:
		sprintf(sMsg.szMessage, MSG_TEAM_CREATE_FAIL1);
		sMsg.eType = SMT_NORMAL;
		sMsg.byConfirmType = SMCT_NONE;
		sMsg.byPriority = 0;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		break;

	default:
		sprintf(sMsg.szMessage, MSG_TEAM_CREATE_FAIL);
		sMsg.eType = SMT_NORMAL;
		sMsg.byConfirmType = SMCT_NONE;
		sMsg.byPriority = 0;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		break;
	}
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ��ѯĳ������������ʧ��
//-------------------------------------------------------------------------
void KProtocolProcess::s2cApplyTeamInfoFalse(BYTE* pMsg)
{
	// ������ʾ�����ѯʧ��(not end)
}
//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ����һ֧����
//-------------------------------------------------------------------------
void KProtocolProcess::s2cCreateTeam(BYTE* pMsg)
{
	PLAYER_SEND_CREATE_TEAM_SUCCESS	*pCreateSuccess = (PLAYER_SEND_CREATE_TEAM_SUCCESS*)pMsg;

	g_Team[0].CreateTeam(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Level, pCreateSuccess->nTeamServerID);
	Player[CLIENT_PLAYER_INDEX].m_cTeam.Release();
	Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 1;
	Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_CAPTAIN;
	Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nApplyCaptainID = 0;
	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].RestoreCurrentCamp();

	KSystemMessage	sMsg;
	sprintf(sMsg.szMessage, MSG_TEAM_CREATE);
	sMsg.eType = SMT_NORMAL;
	sMsg.byConfirmType = SMCT_NONE;
	sMsg.byPriority = 0;
	sMsg.byParamSize = 0;
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

	sprintf(sMsg.szMessage, MSG_TEAM_CREATE);
	sMsg.eType = SMT_TEAM;
	sMsg.byConfirmType = SMCT_CLICK;
	sMsg.byPriority = 1;
	sMsg.byParamSize = 0;
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SetInstantSpr(enumINSTANT_STATE_CREATE_TEAM);
}

//-------------------------------------------------------------------------
//	���ܣ��յ��������������ĵ�ǰĳ���Եĵ���
//-------------------------------------------------------------------------
void KProtocolProcess::s2cGetCurAttribute(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cGetCurAttribute(pMsg);
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������������ͳ��������ֵ
//-------------------------------------------------------------------------
void KProtocolProcess::s2cGetLeadExp(BYTE* pMsg)
{
	PLAYER_LEAD_EXP_SYNC	*pLeadExp = (PLAYER_LEAD_EXP_SYNC*)pMsg;
	if (pLeadExp->m_nLeadLevel)
	{
		Player[CLIENT_PLAYER_INDEX].m_nLeadLevel = pLeadExp->m_nLeadLevel;
		Player[CLIENT_PLAYER_INDEX].m_nLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(Player[CLIENT_PLAYER_INDEX].m_nLeadLevel-1);
		Player[CLIENT_PLAYER_INDEX].m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);

		KSystemMessage	sMsg;
		sprintf(sMsg.szMessage, MSG_LEADER_LEVEL_UP, Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);
		sMsg.eType = SMT_PLAYER;
		sMsg.byConfirmType = SMCT_CLICK;
		sMsg.byPriority = 1;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
	}
	else
	{
		int nLevel = Player[CLIENT_PLAYER_INDEX].m_nLeadLevel;

		Player[CLIENT_PLAYER_INDEX].m_nLeadExp = pLeadExp->m_nLeadExp;
		Player[CLIENT_PLAYER_INDEX].m_nLeadLevel = PlayerSet.m_cLeadExp.GetLevel(Player[CLIENT_PLAYER_INDEX].m_nLeadExp, Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);
		Player[CLIENT_PLAYER_INDEX].m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);

		if (nLevel < Player[CLIENT_PLAYER_INDEX].m_nLeadLevel)
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_LEADER_LEVEL_UP, Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);
			sMsg.eType = SMT_PLAYER;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
	}
}

//-------------------------------------------------------------------------
//	���ܣ��յ���������������ĳ���ܵ���
//-------------------------------------------------------------------------
void KProtocolProcess::s2cGetSkillLevel(BYTE* pMsg)
{
	int		nSkillIndex;
	const PHONGTHAN_SKILL_LEVEL_UPDATE* pSkill = (const PHONGTHAN_SKILL_LEVEL_UPDATE*)pMsg;
	if (pSkill->SkillId >= MAX_SKILL || pSkill->Level >= MAX_SKILLLEVEL ||
        (__int64)pSkill->Level + pSkill->BonusLevel >= MAX_SKILLLEVEL ||
        (__int64)pSkill->Level + pSkill->BonusLevel < 0)
		return;
	nSkillIndex = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.FindSame(pSkill->SkillId);
	Player[CLIENT_PLAYER_INDEX].m_nSkillPoint = pSkill->RemainingPoints;
	if ( !nSkillIndex )
	{
		if ( Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.Add(pSkill->SkillId, pSkill->Level, pSkill->Experience, pSkill->Temporary) == 0 )
			return;
	}
	else
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.SetLevel(nSkillIndex, pSkill->Level);
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.SetAddLevel(pSkill->SkillId, pSkill->BonusLevel);
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.SetCurLevel(pSkill->SkillId, pSkill->Level + pSkill->BonusLevel);
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.SetExp(nSkillIndex, pSkill->Experience);
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.SetTempSkill(nSkillIndex, pSkill->Temporary);
	}

	// ֪ͨ������¼�������
	CoreDataChanged(GDCNI_FIGHT_SKILL_POINT, 0, Player[CLIENT_PLAYER_INDEX].m_nSkillPoint);
	KUiSkillData SkillData;

	KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(pSkill->SkillId, 1);
	if (!pOrdinSkill)
		return;
	eSkillStyle eStyle = ( eSkillStyle ) pOrdinSkill->GetSkillStyle();
			
	switch(eStyle)
	{
	case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
	case SKILL_SS_Melee:
	case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
	case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
	case SKILL_SS_PhongThanAttack:
	case SKILL_SS_PhongThanProduce:
	case SKILL_SS_PhongThanAwaken:
		{
			if(pOrdinSkill->IsBase())
				return;
		}break;
	case SKILL_SS_Thief:					//	͵����
		{
			
		}
		break;
	default:
		return;
	}
	int nSkillPosition = -1;
	SkillData.uGenre = CGOG_SKILL_FIGHT;
	nSkillPosition = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetSkillPosition(pSkill->SkillId);
	SkillData.uId = pSkill->SkillId;
	SkillData.nLevel = pSkill->Level;
	if(nSkillPosition < 0) return;
	CoreDataChanged(GDCNI_SKILL_CHANGE, (unsigned int)&SkillData, nSkillPosition);
}

//-------------------------------------------------------------------------
//	���ܣ��յ������������Ķ��ѵȼ��仯֪ͨ
//-------------------------------------------------------------------------
void KProtocolProcess::s2cGetTeammateLevel(BYTE* pMsg)
{
	PLAYER_TEAMMATE_LEVEL_SYNC	*pLevel = (PLAYER_TEAMMATE_LEVEL_SYNC*)pMsg;
	if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
	{
		Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		return;
	}

	if ((DWORD)g_Team[0].m_nCaptain == pLevel->m_dwTeammateID)
	{
		g_Team[0].m_nMemLevel[0] = (DWORD)pLevel->m_btLevel;
		return;
	}

	for (int i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if ((DWORD)g_Team[0].m_nMember[i] == pLevel->m_dwTeammateID)
		{
			g_Team[0].m_nMemLevel[i + 1] = (DWORD)pLevel->m_btLevel;
			break;
		}
	}
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ�г�Ա�뿪(�����Լ��뿪)
//-------------------------------------------------------------------------
void KProtocolProcess::s2cLeaveTeam(BYTE* pMsg)
{
	if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
		return;
	}

	PLAYER_LEAVE_TEAM	*pLeaveTeam = (PLAYER_LEAVE_TEAM*)pMsg;

	// �Լ��뿪
	if (pLeaveTeam->m_dwNpcID == Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID)
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 0;
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nApplyCaptainID = 0;
		g_Team[0].Release();
		if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMenuState() == PLAYER_MENU_STATE_TEAMOPEN)
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SetMenuState(PLAYER_MENU_STATE_NORMAL);
	}
	// �����뿪
	else
	{
		g_Team[0].DeleteMember(pLeaveTeam->m_dwNpcID);
	}

	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
	return;
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ����
//-------------------------------------------------------------------------
void KProtocolProcess::s2cLevelUp(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cLevelUp(pMsg);
}

void KProtocolProcess::s2cMoveItem(BYTE* pMsg)
{
	PHONGTHAN_ITEM_MOVE_MESSAGE* pMove =
		(PHONGTHAN_ITEM_MOVE_MESSAGE*)pMsg;
	if (!pMove ||
		pMove->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_MOVE ||
		pMove->Header.PacketSize != sizeof(PHONGTHAN_ITEM_MOVE_MESSAGE))
	{
		g_DebugLog("[PhongThanWire] Invalid item move");
		return;
	}

	ItemPos		DownPos, UpPos;
	DownPos.nPlace = pMove->FromContainer;
	DownPos.nX = pMove->FromX;
	DownPos.nY = pMove->FromY;
	UpPos.nPlace = pMove->ToContainer;
	UpPos.nX = pMove->ToX;
	UpPos.nY = pMove->ToY;

	Player[CLIENT_PLAYER_INDEX].m_ItemList.ExchangeItem(&DownPos, &UpPos);
}

void KProtocolProcess::s2cRemoveItem(BYTE* pMsg)
{
	PHONGTHAN_ITEM_REMOVE_MESSAGE* pRemove =
		(PHONGTHAN_ITEM_REMOVE_MESSAGE*)pMsg;
	if (!pRemove ||
		pRemove->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE ||
		pRemove->Header.PacketSize != sizeof(PHONGTHAN_ITEM_REMOVE_MESSAGE))
	{
		return;
	}

	int		nIdx;
	nIdx = Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchID(pRemove->ItemId);
	if (nIdx > 0)
	{
		Player[CLIENT_PLAYER_INDEX].m_ItemList.Remove(nIdx);
	}

	
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������������������Ϣ
//-------------------------------------------------------------------------
void KProtocolProcess::s2cSetProfessionData(BYTE* pMsg)
{
	PLAYER_PROFESSION_DATA	*pData = (PLAYER_PROFESSION_DATA*)pMsg;

	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SetCamp(pData->m_btCamp);
	Player[CLIENT_PLAYER_INDEX].m_cProfession.SetProfession(pData->m_btProfession);

	CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
}

void KProtocolProcess::s2cSetMissionData(BYTE* pMsg)
{
	PLAYER_MISSION_DATA	*pData = (PLAYER_MISSION_DATA*)pMsg;

	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nMissionGroup = pData->m_nMissionGroup;

	CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ����״̬(�ӳ����뿪�š��رն���״̬ʱ�Ż��յ�����Ϣ)
//-------------------------------------------------------------------------
//TamLTM auto pt to doi
void KProtocolProcess::s2cSetTeamState(BYTE* pMsg)
{
	// PLAYER_TEAM_OPEN_CLOSE
	PLAYER_TEAM_OPEN_CLOSE	*pTeamState = (PLAYER_TEAM_OPEN_CLOSE*)pMsg;
	switch (pTeamState->m_btStateClose)
	{
		case Team_S_OpenClose:
		{
			if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag || Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure != TEAM_CAPTAIN)
			{
				Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
				return;
			}

			Player[CLIENT_PLAYER_INDEX].m_cTeam.ReleaseList();
			if (pTeamState->m_btFlag)
			{
				g_Team[0].SetTeamOpen();
			}
			else
			{
				g_Team[0].SetTeamClose();
			}
		}
		break;
		case Team_S_CreatTeamFlag:
		{
			if (pTeamState->m_btFlag)
			{
				Player[CLIENT_PLAYER_INDEX].m_cTeam.SetCreatTeamFlag(TRUE);
			}
			else
			{
				Player[CLIENT_PLAYER_INDEX].m_cTeam.SetCreatTeamFlag(FALSE);
			}
		}
		break;
		case Team_S_PKFollowCaptain:
		{
			if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag || Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure == TEAM_CAPTAIN)
			{
				Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
				return;
			}

			if (pTeamState->m_btFlag)
			{
				Player[CLIENT_PLAYER_INDEX].m_cTeam.SetPKFollowCaptain(TRUE);
			}
			else
			{
				Player[CLIENT_PLAYER_INDEX].m_cTeam.SetPKFollowCaptain(FALSE);
			}
		}
		break;
		case Team_S_ModePick:
		{
			if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
			{
				Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
				return;
			}

			g_Team[0].SetModePick(pTeamState->m_btFlag);
		}
		break;
	}
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ����״̬(�ӳ����뿪�š��رն���״̬ʱ�Ż��յ�����Ϣ)
//-------------------------------------------------------------------------
void	KProtocolProcess::s2cApplyAddTeam(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cApplyAddTeam(pMsg);
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������������ĳ�����������������ʾ֮
//-------------------------------------------------------------------------
void KProtocolProcess::s2cShowTeamInfo(BYTE* pMsg)
{
}

void KProtocolProcess::s2cSyncItem(BYTE* pMsg)
{
	PHONGTHAN_ITEM_SNAPSHOT* pItem = (PHONGTHAN_ITEM_SNAPSHOT*)pMsg;
	if (!pItem ||
		!PhongThanValidateWireHeader(&pItem->Header, pItem->Header.PacketSize) ||
		pItem->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT ||
		pItem->Header.PacketSize != sizeof(PHONGTHAN_ITEM_SNAPSHOT) ||
		MAX_ITEM_MAGICLEVEL != PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT)
	{
		g_DebugLog("[PhongThanWire] Invalid item snapshot");
		return;
	}

	int nIndex = 0;
	if (pItem->IsNew)
	{
		nIndex = ItemSet.Add(
			pItem->Genre,
			pItem->Series,
			pItem->Level,
			pItem->Luck,
			pItem->DetailType,
			pItem->ParticularType,
			pItem->PropertyValues,
			pItem->GeneratorVersion,
			pItem->RandomSeed,
			pItem->TemplateRow);
	}
	else
	{
		nIndex = ItemSet.SearchID(pItem->ItemId);
	}

	if (nIndex <= 0 || nIndex >= MAX_ITEM)
		return;

	KLockItem Lock;
	Lock.nState = (short)pItem->LockState;
	Lock.dwLockTime = pItem->LockUntil;
	PlayerItem Back;
	Back.bIsSkill = pItem->BackIsSkill ? TRUE : FALSE;
	Back.nIdx = pItem->BackIndex;
	Back.nPlace = pItem->BackContainer;
	Back.nX = pItem->BackX;
	Back.nY = pItem->BackY;

	Item[nIndex].SetTemp(pItem->IsTemporary ? TRUE : FALSE);
	Item[nIndex].SetOwner(pItem->OwnerId);
	Item[nIndex].SetTradePrice(pItem->TradePrice);
	Item[nIndex].SetID(pItem->ItemId);
	Item[nIndex].SetRow(pItem->TemplateRow);
	Item[nIndex].SetDetailType(pItem->DetailType);
	Item[nIndex].SetGenre(pItem->Genre);
	Item[nIndex].SetParticular(pItem->ParticularType);
	Item[nIndex].SetLevel(pItem->Level);
	Item[nIndex].SetDurability(pItem->Durability);
	Item[nIndex].SetExpireTime(pItem->ExpireTime);
	Item[nIndex].SetLock(&Lock);
	Item[nIndex].SetLockSell(pItem->LockSell ? TRUE : FALSE);
	Item[nIndex].SetLockTrade(pItem->LockTrade ? TRUE : FALSE);
	Item[nIndex].SetLockDrop(pItem->LockDrop ? TRUE : FALSE);
	Item[nIndex].SetParam(pItem->Param);
	Item[nIndex].SetBackLocal(&Back);
	Item[nIndex].SetFortune(pItem->Fortune);
	Item[nIndex].SetStackNum(pItem->StackCount);
	if (pItem->TemplateRow == 59 || pItem->TemplateRow == 249)
	{
		FILE* log = fopen("equipment_delivery.log", "a");
		if (log) { fprintf(log,"RECEIVE id=%u index=%d row=%d detail=%d position=%d,%d,%d icon=%s\n",
			pItem->ItemId,nIndex,pItem->TemplateRow,pItem->DetailType,pItem->Container,pItem->SlotX,pItem->SlotY,
			Item[nIndex].GetImageName()); fclose(log); }
	}
	if(Item[nIndex].GetGenre()==item_equip && !Item[nIndex].ApplyUpgradeState(pItem->UpgradeLevel))
	{
		g_DebugLog("[PhongThanUpgrade] rejected item upgrade state=%d",pItem->UpgradeLevel);
		if(pItem->IsNew)ItemSet.Remove(nIndex);
		return;
	}
	Item[nIndex].m_CommonAttrib.nPhysicVal = pItem->PhysicalValue;
	Item[nIndex].m_CommonAttrib.nMagicVal = pItem->MagicValue;
	memcpy(Item[nIndex].m_GeneratorParam.nGeneratorLevel,
		pItem->PropertyValues, sizeof(pItem->PropertyValues));
	Item[nIndex].m_GeneratorParam.uRandomSeed = pItem->RandomSeed;
	Item[nIndex].m_GeneratorParam.nVersion = pItem->GeneratorVersion;
	Item[nIndex].m_GeneratorParam.nLuck = pItem->Luck;

	if (pItem->IsNew)
	{
		Player[CLIENT_PLAYER_INDEX].m_ItemList.Add(nIndex,
			pItem->Container, pItem->SlotX, pItem->SlotY);
	}
	else
	{
		Player[CLIENT_PLAYER_INDEX].m_ItemList.Add(nIndex,
			Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Items[nIndex].nPlace,
			Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Items[nIndex].nX,
			Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Items[nIndex].nY);
	}
}

void KProtocolProcess::s2cSyncMagic(BYTE* pMsg)
{
	PHONGTHAN_ITEM_PROPERTIES_MESSAGE* pProperties =
		(PHONGTHAN_ITEM_PROPERTIES_MESSAGE*)pMsg;
	if (!pProperties ||
		pProperties->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES ||
		pProperties->Header.PacketSize != sizeof(PHONGTHAN_ITEM_PROPERTIES_MESSAGE) ||
		MAX_ITEM_MAGICLEVEL != PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT ||
		MAX_ITEM_MAGICATTRIB != PHONGTHAN_ITEM_ATTRIBUTE_COUNT)
	{
		return;
	}

	DWORD nIdx = ItemSet.SearchID(pProperties->ItemId);
	if (nIdx <= 0 || nIdx >= MAX_ITEM)
		return;

	KItemNormalAttrib Attributes[MAX_ITEM_MAGICATTRIB];
	for (int i = 0; i < MAX_ITEM_MAGICATTRIB; ++i)
	{
		Attributes[i].nAttribType = pProperties->Attributes[i].Type;
		for (int j = 0; j < 3; ++j)
			Attributes[i].nValue[j] = pProperties->Attributes[i].Value[j];
	}
	memcpy(Item[nIdx].m_GeneratorParam.nGeneratorLevel,
		pProperties->PropertyValues, sizeof(pProperties->PropertyValues));
	Item[nIdx].SetMagicAttrib(Attributes);
}
//-------------------------------------------------------------------------
//	���ܣ��յ���������������ͬ��money����Ϣ
//-------------------------------------------------------------------------
void KProtocolProcess::s2cSyncMoney(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cSyncMoney(pMsg);
}

void KProtocolProcess::s2cSyncRoleList(BYTE* pMsg)
{
	ROLE_LIST_SYNC	*pSync = (ROLE_LIST_SYNC *)pMsg;
	// TODO: ͨ��CORESHELL�������棿
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ�����˼������
//-------------------------------------------------------------------------
void KProtocolProcess::s2cTeamAddMember(BYTE* pMsg)
{
	if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag )
	{
		Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		return;
	}

	PLAYER_TEAM_ADD_MEMBER	*pAddMem = (PLAYER_TEAM_ADD_MEMBER*)pMsg;
	int		nMemNum;

	nMemNum = g_Team[0].FindFree();
	if (nMemNum < 0)
		return;
	g_Team[0].m_nMember[nMemNum] = pAddMem->m_dwNpcID;
	g_Team[0].m_nMemLevel[nMemNum + 1] = (DWORD)pAddMem->m_btLevel;
	strcpy(g_Team[0].m_szMemName[nMemNum + 1], pAddMem->m_szName);
	g_Team[0].m_nMemNum++;
	Player[CLIENT_PLAYER_INDEX].m_cTeam.DeleteOneFromApplyList(pAddMem->m_dwNpcID);
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();

	KSystemMessage	sMsg;
	sprintf(sMsg.szMessage, MSG_TEAM_ADD_MEMBER, pAddMem->m_szName);
	sMsg.eType = SMT_NORMAL;
	sMsg.byConfirmType = SMCT_NONE;
	sMsg.byPriority = 0;
	sMsg.byParamSize = 0;
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
}

//-------------------------------------------------------------------------
//	���ܣ��յ�������֪ͨ�����ӳ�
//-------------------------------------------------------------------------
void KProtocolProcess::s2cTeamChangeCaptain(BYTE* pMsg)
{
	if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
	{
		Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		return;
	}

	int		nLevel, nMemNo;
	char	szName[32];
	PLAYER_TEAM_CHANGE_CAPTAIN	*pChange = (PLAYER_TEAM_CHANGE_CAPTAIN*)pMsg;

	nMemNo = g_Team[0].FindMemberID(pChange->m_dwCaptainID);
	// ��ǰ������������
	if ((DWORD)g_Team[0].m_nCaptain != pChange->m_dwMemberID || nMemNo < 0)
	{
		Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		return;
	}

	// �Լ�������Ϊ�ӳ�
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID == pChange->m_dwCaptainID)
	{
		KSystemMessage	sMsg;
		if (pChange->m_bMySelf)
			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN_SELF, g_Team[0].m_szMemName[0]);
		else
			sprintf(sMsg.szMessage, MSG_TEAM_AUTO_CAPTAIN_SELF, g_Team[0].m_szMemName[0]);
		sMsg.eType = SMT_TEAM;
		sMsg.byConfirmType = SMCT_UI_TEAM;
		sMsg.byPriority = 3;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
	}
	else	// ���˱�����Ϊ�ӳ�
	{
		KSystemMessage	sMsg;
		if (pChange->m_bMySelf)
			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN, g_Team[0].m_szMemName[nMemNo + 1]);
		else
			sprintf(sMsg.szMessage, MSG_TEAM_AUTO_CAPTAIN, g_Team[0].m_szMemName[nMemNo + 1]);
		sMsg.eType = SMT_TEAM;
		sMsg.byConfirmType = SMCT_UI_TEAM;
		sMsg.byPriority = 3;
		sMsg.byParamSize = 0;
		CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
	}

	// ������Ա
	nLevel = g_Team[0].m_nMemLevel[0];
	strcpy(szName, g_Team[0].m_szMemName[0]);
	g_Team[0].m_nCaptain = pChange->m_dwCaptainID;
	g_Team[0].m_nMemLevel[0] = g_Team[0].m_nMemLevel[nMemNo + 1];
	strcpy(g_Team[0].m_szMemName[0], g_Team[0].m_szMemName[nMemNo + 1]);
	g_Team[0].m_nMember[nMemNo] = pChange->m_dwMemberID;
	g_Team[0].m_nMemLevel[nMemNo + 1] = nLevel;
	strcpy(g_Team[0].m_szMemName[nMemNo + 1], szName);

	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID == pChange->m_dwCaptainID)
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_CAPTAIN;
		Player[CLIENT_PLAYER_INDEX].m_cTeam.ReleaseList();
	}
	else if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID == pChange->m_dwMemberID)
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_MEMBER;
		Player[CLIENT_PLAYER_INDEX].m_cTeam.ReleaseList();
	}

	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
}

//-------------------------------------------------------------------------
//	���ܣ��յ��������������Լ��������������������Ӧ��Ϣ
//-------------------------------------------------------------------------
void KProtocolProcess::s2cUpdataSelfTeamInfo(BYTE* pMsg)
{
	int		i;
	PLAYER_SEND_SELF_TEAM_INFO	*pSelfInfo = (PLAYER_SEND_SELF_TEAM_INFO*)pMsg;

	// ���ݰ�����
	if (pSelfInfo->m_dwNpcID[0] == 0)
		return;

	Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 1;
	Player[CLIENT_PLAYER_INDEX].m_nLeadExp = pSelfInfo->m_nLeadExp;
	Player[CLIENT_PLAYER_INDEX].m_nLeadLevel = PlayerSet.m_cLeadExp.GetLevel(Player[CLIENT_PLAYER_INDEX].m_nLeadExp);
	Player[CLIENT_PLAYER_INDEX].m_nNextLevelLeadExp = PlayerSet.m_cLeadExp.GetLevelExp(Player[CLIENT_PLAYER_INDEX].m_nLeadLevel);
	if (Player[CLIENT_PLAYER_INDEX].m_nNextLevelLeadExp == 0)
		Player[CLIENT_PLAYER_INDEX].m_nNextLevelLeadExp = Player[CLIENT_PLAYER_INDEX].m_nLeadLevel;

	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID == pSelfInfo->m_dwNpcID[0])	// �ӳ�
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_CAPTAIN;
	}
	else													// ��Ա
	{
		Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_MEMBER;
		for (i = 0; i < MAX_TEAM_APPLY_LIST; i++)
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_sApplyList[i].Release();
	}
	g_Team[0].m_nCaptain = pSelfInfo->m_dwNpcID[0];
	if (pSelfInfo->m_btState == 0)
		g_Team[0].SetTeamClose();
	else
		g_Team[0].SetTeamOpen();
	g_Team[0].m_nTeamServerID = pSelfInfo->nTeamServerID;
	g_Team[0].m_nMemLevel[0] = (DWORD)pSelfInfo->m_btLevel[0];
	strcpy(g_Team[0].m_szMemName[0], pSelfInfo->m_szNpcName[0]);
	g_Team[0].m_nMemNum = 0;
	for (i = 0; i < MAX_TEAM_MEMBER; i++)
	{
		if (pSelfInfo->m_dwNpcID[i + 1] > 0)
		{
			g_Team[0].m_nMember[i] = pSelfInfo->m_dwNpcID[i + 1];
			g_Team[0].m_nMemLevel[i + 1] = (DWORD)pSelfInfo->m_btLevel[i + 1];
			strcpy(g_Team[0].m_szMemName[i + 1], pSelfInfo->m_szNpcName[i + 1]);
			g_Team[0].m_nMemNum++;
		}
		else
		{
			g_Team[0].m_nMember[i] = -1;
			g_Team[0].m_nMemLevel[i + 1] = 0;
			g_Team[0].m_szMemName[i + 1][0] = 0;
		}
	}
	Player[CLIENT_PLAYER_INDEX].m_cTeam.UpdateInterface();
}

void KProtocolProcess::SyncCurNormalData(BYTE* pMsg)
{
	const PHONGTHAN_SELF_VITALS* pSync = (const PHONGTHAN_SELF_VITALS*)pMsg;
	if (pSync->Life > 0)
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife = pSync->Life;
	else
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife = 0;
	if (pSync->Stamina > 0)
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentStamina = pSync->Stamina;
	else
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentStamina = 0;

	if (pSync->Mana > 0)
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentMana = pSync->Mana;
	else
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentMana = 0;

	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	switch (pSync->TeamRole)
	{
	case 0x00:
		if ( Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag )
		{
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 0;
			Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		}
		break;
	case 2:
		if ( !Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag || Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure != TEAM_CAPTAIN)
		{
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 1;
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_CAPTAIN;
			Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		}
		break;
	case 0x01:
		if ( !Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag || Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure != TEAM_MEMBER)
		{
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag = 1;
			Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure = TEAM_MEMBER;
			Player[CLIENT_PLAYER_INDEX].ApplySelfTeamInfo();
		}
		break;
	}
}

void KProtocolProcess::SyncCurPlayer(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].SyncCurPlayer(pMsg);
}

void KProtocolProcess::SyncNpc(BYTE* pMsg)
{
	PHONGTHAN_NPC_SNAPSHOT* NpcSync = (PHONGTHAN_NPC_SNAPSHOT*)pMsg;
	if (NpcSync->MapId != (unsigned int)SubWorld[0].m_SubWorldID)
		return; // Never attach an old-world snapshot to a reused region slot.
	const NPCCMD action = PhongThanDecodeEntityAction(NpcSync->Action);
	static int s_nNpcFullSyncLogCount = 0;
	if (s_nNpcFullSyncLogCount < 128)
	{
		FILE *pNpcLog = fopen("client_npc_sync_diag.log", "a");
		if (pNpcLog)
		{
			fprintf(pNpcLog, "full id=%u templateInfo=%d map=%u,%u kind=%d len=%u\n",
				NpcSync->EntityId, MAKELONG(NpcSync->Level, NpcSync->TemplateId), NpcSync->X, NpcSync->Y,
				NpcSync->Kind, NpcSync->NameLength);
			fclose(pNpcLog);
		}
		s_nNpcFullSyncLogCount++;
	}
	
	int nRegion, nMapX, nMapY, nOffX, nOffY;
	SubWorld[0].Mps2Map(NpcSync->X, NpcSync->Y, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);

	if (nRegion == -1)
		return;

	int nIdx = NpcSet.SearchID(NpcSync->EntityId);
	if (!nIdx)
	{
		nIdx = NpcSet.Add(MAKELONG(NpcSync->Level, NpcSync->TemplateId), 0, NpcSync->X, NpcSync->Y);
		if (nIdx <= 0)
		{
			g_DebugLog("[SyncNpc] Add failed id=%u templateInfo=%d", NpcSync->EntityId, MAKELONG(NpcSync->Level, NpcSync->TemplateId));
			return;
		}
		Npc[nIdx].m_dwID = NpcSync->EntityId;
		Npc[nIdx].m_Kind = NpcSync->Kind < kind_num ? NpcSync->Kind : kind_normal;	// cppbatch:H7 VNG Kind 7..15
		Npc[nIdx].m_Height = 0;
		
		if (NpcSet.IsNpcRequestExist(NpcSync->EntityId))
			NpcSet.RemoveNpcRequest(NpcSync->EntityId);
	}
	else
	{
		if (Npc[nIdx].m_RegionIndex >= 0)
			SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);

		Npc[nIdx].m_Dir = NpcSync->Direction;
		Npc[nIdx].m_MapX = nMapX;
		Npc[nIdx].m_MapY = nMapY;
		Npc[nIdx].m_OffX = nOffX;
		Npc[nIdx].m_OffY = nOffY;

		// Phong Than 2026-10-03 cppbatch:H8 (petmorph): a live template change of a non-player NPC (NpcPolyMorph,
		// SetSummonBeastMorph, VNG summon-beast morph items) reloads the body; before, the old sprite stayed until
		// the NPC left and re-entered view. Players never take this path (kind and template checks). Load() only
		// resets template data: position and region are untouched, camp, series, life, name and menu are written
		// again from this packet below, the owner index is not touched, and the synced kind is restored here.
		if (Npc[nIdx].m_Kind != kind_player &&
			NpcSync->TemplateId >= 0 && NpcSync->TemplateId < MAX_NPCSTYLE &&
			NpcSync->TemplateId != PLAYER_MALE_NPCTEMPLATEID &&
			NpcSync->TemplateId != PLAYER_FEMALE_NPCTEMPLATEID &&
			Npc[nIdx].m_NpcSettingIdx != (int)NpcSync->TemplateId)
		{
			Npc[nIdx].Load((int)NpcSync->TemplateId, NpcSync->Level);
			Npc[nIdx].m_Kind = NpcSync->Kind < kind_num ? NpcSync->Kind : kind_normal;
			Npc[nIdx].m_bClientOnly = FALSE;
		}
		Npc[nIdx].m_NpcSettingIdx = (short)NpcSync->TemplateId;
		Npc[nIdx].m_Level = NpcSync->Level;

		if (Npc[nIdx].m_RegionIndex >= 0)
		{
			if (Npc[nIdx].m_RegionIndex != nRegion)
			{
				SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].m_RegionID, SubWorld[0].m_Region[nRegion].m_RegionID, nIdx);
				Npc[nIdx].m_RegionIndex = nRegion;
			}
			SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].AddRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
		}
		else
		{
			SubWorld[0].m_Region[nRegion].AddNpc(nIdx);
			Npc[nIdx].m_RegionIndex = nRegion;
			SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].AddRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
		}
	}
	Npc[nIdx].m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
	Npc[nIdx].m_Dir = NpcSync->Direction;
	Npc[nIdx].m_Camp			= (NPCCAMP)NpcSync->Camp;
	// Every NPC received through s2c_syncnpc is owned by the server.  Keeping a
	// template's ClientOnly flag here makes DialogNpc execute an unrelated local
	// script and prevents c2s_dialognpc from ever reaching the game server.
	Npc[nIdx].m_bClientOnly		= FALSE;
	Npc[nIdx].m_CurrentCamp		= (NPCCAMP)NpcSync->CurrentCamp;
	Npc[nIdx].m_Series			= NpcSync->Series;
	if (Npc[nIdx].m_NpcSettingIdx == PLAYER_MALE_NPCTEMPLATEID ||
		Npc[nIdx].m_NpcSettingIdx == PLAYER_FEMALE_NPCTEMPLATEID)
	{
		// Add() runs before the authoritative series is available.
		Npc[nIdx].ResetNpcTypeName(1);
	}
	Npc[nIdx].m_btSpecial		= NpcSync->Special;
	Npc[nIdx].m_nMissionGroup	= NpcSync->MissionGroup;

	Npc[nIdx].m_CurrentLifeMax	= NpcSync->MaxLife;
	Npc[nIdx].m_CurrentLife		= NpcSync->Life;
	
	if (Npc[nIdx].m_Doing != action)
		Npc[nIdx].SendCommand(action, NpcSync->X, NpcSync->Y);

	Npc[nIdx].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	Npc[nIdx].SetMenuState(NpcSync->MenuState);
	memset(Npc[nIdx].Name, 0, sizeof(Npc[nIdx].Name));
	int nNpcNameLength = NpcSync->NameLength;
	if (nNpcNameLength < 0)
		nNpcNameLength = 0;
	if (nNpcNameLength > (int)sizeof(NpcSync->Name))
		nNpcNameLength = sizeof(NpcSync->Name);
	if (nNpcNameLength >= (int)sizeof(Npc[nIdx].Name))
		nNpcNameLength = sizeof(Npc[nIdx].Name) - 1;
	memcpy(Npc[nIdx].Name, NpcSync->Name, nNpcNameLength);
	Npc[nIdx].Name[nNpcNameLength] = 0;
}

void KProtocolProcess::SyncNpcMin(BYTE* pMsg)
{
	PHONGTHAN_NPC_UPDATE* NpcSync = (PHONGTHAN_NPC_UPDATE*)pMsg;
	if (NpcSync->MapId != (unsigned int)SubWorld[0].m_SubWorldID)
		return; // Delayed updates must not attach old-world NPCs to reused slots.
	const NPCCMD action = PhongThanDecodeEntityAction(NpcSync->Action);

	if (action == do_revive || action == do_death)
		return;
	
	int nIdx = NpcSet.SearchID(NpcSync->EntityId);
	if (!nIdx)
	{
		if (!NpcSet.IsNpcRequestExist(NpcSync->EntityId))
		{
			
			if (NpcSet.InsertNpcRequest(NpcSync->EntityId))
			{
				static int s_nNpcRequestLogCount = 0;
				if (s_nNpcRequestLogCount < 128)
				{
					FILE *pNpcLog = fopen("client_npc_sync_diag.log", "a");
					if (pNpcLog)
					{
						fprintf(pNpcLog, "request id=%u map=%d,%d doing=%d\n",
							NpcSync->EntityId, NpcSync->X, NpcSync->Y, action);
						fclose(pNpcLog);
					}
					s_nNpcRequestLogCount++;
				}
				SendClientCmdRequestNpc(NpcSync->EntityId);
			}
		}
	}
	else
	{
		int nRegion, nMapX, nMapY, nOffX, nOffY;
		SubWorld[0].Mps2Map(NpcSync->X, NpcSync->Y, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
		if (nRegion < 0)
			return;

		Npc[nIdx].m_sSyncPos.m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
		Npc[nIdx].m_sSyncPos.m_nMapX = nMapX;
		Npc[nIdx].m_sSyncPos.m_nMapY = nMapY;
		Npc[nIdx].m_sSyncPos.m_nOffX = nOffX;
		Npc[nIdx].m_sSyncPos.m_nOffY = nOffY;
		Npc[nIdx].m_sSyncPos.m_nDoing = action;
		//end code

		//TamLTM Fix lag pos
	/*	if (countTimeSyncNpcPlayer)
			countTimeSyncNpcPlayer++;
		if (countTimeSyncNpcPlayer == 250)
		{
			countTimeSyncNpcPlayer = 1;
			Npc[nIdx].m_sSyncPos.m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
			Npc[nIdx].m_MapX = nMapX;
			Npc[nIdx].m_MapY = nMapY;
			Npc[nIdx].m_OffX = nOffX;
			Npc[nIdx].m_OffY = nOffY;

		//	g_DebugLog("Npc Doing lag pos countTimeSyncNpcPlayer");
		}
		//end code */

	//	g_DebugLog("Npc Doing lag pos 2");
		//end code

		if (Npc[nIdx].m_RegionIndex == -1 && nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)	
		{
			if (nRegion == -1)
			{		
				return;
			}
			else
			{
				Npc[nIdx].m_MapX = nMapX;
				Npc[nIdx].m_MapY = nMapY;
				Npc[nIdx].m_OffX = nOffX;
				Npc[nIdx].m_OffY = nOffY;
				Npc[nIdx].m_RegionIndex = nRegion;
				Npc[nIdx].m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
				SubWorld[0].m_Region[nRegion].AddNpc(nIdx);
				SubWorld[0].m_Region[nRegion].AddRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
			//	g_DebugLog("Npc Doing lag pos 3");
			}
			
			if (action == do_stand)
				Npc[nIdx].ProcNetCommand(do_stand);
		}
		else
		{
			if (Npc[nIdx].m_RegionIndex != nRegion && nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].RemoveNpc(nIdx);
				SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
				Npc[nIdx].m_MapX = nMapX;
				Npc[nIdx].m_MapY = nMapY;
				Npc[nIdx].m_OffX = nOffX;
				Npc[nIdx].m_OffY = nOffY;
				Npc[nIdx].m_RegionIndex = nRegion;

			//	g_DebugLog("Npc Doing lag pos 4");

				if (nRegion >= 0)
				{
					SubWorld[0].m_Region[nRegion].AddNpc(nIdx);
					Npc[nIdx].m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
					SubWorld[0].m_Region[nRegion].AddRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
				}
			}
		}

		if (nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)
		{
			int	nOldLife = Npc[nIdx].m_CurrentLife;

			Npc[nIdx].m_CurrentLifeMax	= NpcSync->MaxLife;
			Npc[nIdx].m_CurrentLife		= NpcSync->Life;
			
			if (Npc[nIdx].m_Kind == kind_normal)
				Npc[nIdx].AddBlood(nOldLife - Npc[nIdx].m_CurrentLife);
			Npc[nIdx].SetCurrentCamp(NpcSync->Camp);

		//	g_DebugLog("Npc Doing lag pos 5");
		}

		Npc[nIdx].m_CurrentRunSpeed		= NpcSync->RunSpeed;
		Npc[nIdx].m_CurrentWalkSpeed	= NpcSync->WalkSpeed;
		Npc[nIdx].m_CurrentAttackSpeed	= NpcSync->AttackSpeed;
		Npc[nIdx].m_CurrentCastSpeed	= NpcSync->CastSpeed;
		Npc[nIdx].SetNpcState(NpcSync->Effects);

		Npc[nIdx].m_FreezeState.nTime	= NpcSync->StateFlags & STATE_FREEZE;
		Npc[nIdx].m_PoisonState.nTime	= NpcSync->StateFlags & STATE_POISON;
		Npc[nIdx].m_StunState.nTime		= NpcSync->StateFlags & STATE_STUN;
		Npc[nIdx].m_HideState.nTime		= NpcSync->StateFlags & STATE_HIDE;
		Npc[nIdx].m_FrozenAction.nTime	= NpcSync->StateFlags & STATE_FROZEN;
		Npc[nIdx].m_WalkRun.nTime		= NpcSync->StateFlags & STATE_WALKRUN;
		Npc[nIdx].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
	}
}

//-------------------------------------------------------------------------
//	���ܣ��յ���������Ϣͬ�������npc����
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//	���ܣ��յ���������Ϣ����һ��obj
//-------------------------------------------------------------------------
void KProtocolProcess::SyncObjectAdd(BYTE* pMsg)
{
	const PHONGTHAN_OBJECT_SNAPSHOT* pObjSyncAdd = (const PHONGTHAN_OBJECT_SNAPSHOT*)pMsg;
	int				nObjIndex;
	KObjItemInfo	sInfo;
	ZeroMemory(&sInfo, sizeof(sInfo));

	nObjIndex = ObjSet.FindID(pObjSyncAdd->ObjectId);
	if (nObjIndex > 0)
		return;

	sInfo.m_nItemID = 0; // Server-local item indexes never cross the network.
	sInfo.m_nItemWidth = pObjSyncAdd->Width;
	sInfo.m_nItemHeight = pObjSyncAdd->Height;
	sInfo.m_nMoneyNum = pObjSyncAdd->Money;
	sInfo.m_nColorID = pObjSyncAdd->Color;
	sInfo.m_nGenre = pObjSyncAdd->Genre;
	sInfo.m_nDetailType = pObjSyncAdd->DetailType;
	sInfo.m_nMovieFlag = ((pObjSyncAdd->Flags & 0x02) > 0 ? 1 : 0);
	sInfo.m_nSoundFlag = ((pObjSyncAdd->Flags & 0x01) > 0 ? 1 : 0);
	sInfo.m_bOverLook = ((pObjSyncAdd->Flags & 0x04) > 0 ? 1 : 0);
	memset(sInfo.m_szName, 0, sizeof(sInfo.m_szName));
	g_StrCpyLen(sInfo.m_szName, pObjSyncAdd->Name, sizeof(sInfo.m_szName));

	nObjIndex = ObjSet.ClientAdd(
		pObjSyncAdd->ObjectId,
		pObjSyncAdd->TemplateId,
		pObjSyncAdd->State,
		pObjSyncAdd->Direction,
		pObjSyncAdd->Frame,
		pObjSyncAdd->X,
		pObjSyncAdd->Y,
		sInfo);
}

//-------------------------------------------------------------------------
//	���ܣ��յ���������Ϣ����ĳ��obj����
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//	���ܣ��յ���������Ϣɾ��ĳ��obj
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//	���ܣ��յ���������Ϣ����ĳ��obj״̬
//-------------------------------------------------------------------------

void KProtocolProcess::SyncPlayer(BYTE* pMsg)
{
	const PHONGTHAN_PLAYER_SNAPSHOT* pPlaySync = (const PHONGTHAN_PLAYER_SNAPSHOT*)pMsg;

	int nIdx = NpcSet.SearchID(pPlaySync->EntityId);
	if (nIdx <= 0 || nIdx >= MAX_NPC)
		return;
	Npc[nIdx].m_nTeamServerID		= pPlaySync->TeamId;
	PhongThanDecodeVisualPart(Npc[nIdx].m_Appearance.Helm, pPlaySync->Helm);
	PhongThanDecodeVisualPart(Npc[nIdx].m_Appearance.Armor, pPlaySync->Armor);
	PhongThanDecodeVisualPart(Npc[nIdx].m_Appearance.Weapon, pPlaySync->Weapon);
	PhongThanDecodeVisualPart(Npc[nIdx].m_Appearance.PhiPhong, pPlaySync->PhiPhong);
	PhongThanDecodeVisualPart(Npc[nIdx].m_Appearance.Horse, pPlaySync->Horse);
	Npc[nIdx].m_bRideHorse			= pPlaySync->Mounted;
	Npc[nIdx].m_Kind				= kind_player;
	Npc[nIdx].m_RankID				= pPlaySync->TitleId;
	g_StrCpyLen(Npc[nIdx].m_CurExpandRank.szName, pPlaySync->TitleName, sizeof(Npc[nIdx].m_CurExpandRank.szName));
	Npc[nIdx].m_CurExpandRank.dwColor = pPlaySync->TitleColor;
	Npc[nIdx].m_CurExpandRank.nStateGraphics = pPlaySync->TitleGraphic;
	Npc[nIdx].m_CurExpandRank.dwLeftTime = pPlaySync->TitleRemainingTime;
	g_StrCpyLen(Npc[nIdx].m_PTrade.cName, pPlaySync->ShopName, sizeof(Npc[nIdx].m_PTrade.cName));
	Npc[nIdx].m_PTrade.nTrade = pPlaySync->ShopOpen;
	Npc[nIdx].m_PTrade.nDest = pPlaySync->ShopDestination;
	Npc[nIdx].m_byTranslife			= pPlaySync->Transcendence;
	Npc[nIdx].m_byViprank			= pPlaySync->VipRank;
	Npc[nIdx].m_nRepute				= pPlaySync->Reputation;
	Npc[nIdx].m_nFuYuan				= pPlaySync->Fortune;
	Npc[nIdx].m_nPKFlag				= pPlaySync->PkMode;
	Npc[nIdx].m_nPKValue			= pPlaySync->PkValue;
	Npc[nIdx].m_byFortuneRankLevel	= pPlaySync->FortuneRank;
	Npc[nIdx].m_ImagePlayer			= pPlaySync->Portrait;
	if(Option.GetLow(LowPlayer) && nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)
	{
		if(Npc[nIdx].m_NpcSettingIdx == PLAYER_MALE_NPCTEMPLATEID)
			Npc[nIdx].m_MaskType = ManTypeNameIdx;
		else
			Npc[nIdx].m_MaskType = WomanTypeNameIdx;
	}
	else
		Npc[nIdx].m_MaskType   		= pPlaySync->MaskResource;
	if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
	{
		Player[CLIENT_PLAYER_INDEX].m_ImagePlayer		= pPlaySync->Portrait;
	}
	Npc[nIdx].m_nRankInWorld		= pPlaySync->WorldRank;
	Npc[nIdx].m_nProfession		= pPlaySync->Profession;
	Npc[nIdx].m_nPacePercent		= pPlaySync->ProgressPercent;
	Npc[nIdx].m_nFigure				= pPlaySync->ClanRole;
	if (pPlaySync->ClanId)
	{
		Npc[nIdx].m_bTongFlag		= TRUE;
		Npc[nIdx].m_dwTongNameID	= pPlaySync->ClanId;
		Npc[nIdx].m_nTongNationalEmblem = pPlaySync->ClanEmblem;
		g_StrCpyLen(Npc[nIdx].m_szTongName, pPlaySync->ClanName, sizeof(Npc[nIdx].m_szTongName));
		g_StrCpyLen(Npc[nIdx].m_szTongAgname, pPlaySync->ClanTitle, sizeof(Npc[nIdx].m_szTongAgname));
	}
	else
	{
		Npc[nIdx].m_bTongFlag		= FALSE;
		Npc[nIdx].m_dwTongNameID	= 0;
		Npc[nIdx].m_nTongNationalEmblem = 0;
		Npc[nIdx].m_szTongName[0]	= 0;
		Npc[nIdx].m_szTongAgname[0] = 0;
	}
	g_StrCpyLen(Npc[nIdx].MateName, pPlaySync->PartnerName, sizeof(Npc[nIdx].MateName));

	if (pPlaySync->FightMode)
		Npc[nIdx].m_FightMode		= enumFightActive;
	else
		Npc[nIdx].m_FightMode		= enumFightNone;

	if (pPlaySync->Sleeping)
		Npc[nIdx].SetSleepMode(1);
	else
		Npc[nIdx].SetSleepMode(0);


	// Heartbeat snapshots update selectors without restarting the sprite animation.
	if (pPlaySync->FullSnapshot) Npc[nIdx].ResetNpcTypeName(1);
}


void KProtocolProcess::SyncScriptAction(BYTE* data)
{
	KPhongThanScriptAction action;
	const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)data;
	if (!header || !PhongThanReadScriptPacket(data, header->PacketSize, &action))
	{
		g_DebugLog("[PhongThanUI] client rejected script action packet");
		return;
	}

	// The packet is already addressed to this client connection.  During a map
	// load the local SubWorld id can briefly be zero or still contain the
	// previous map id, so dropping a valid dialog here makes item scripts such
	// as Di Ngoai Phu appear to do nothing.  The server validates the action's
	// map and dialog token; the client only records the mismatch for diagnosis
	// and still delivers the action to the UI.
	const PHONGTHAN_U32 currentMap = (PHONGTHAN_U32)SubWorld[0].m_SubWorldID;
	if (action.MapId && currentMap && action.MapId != currentMap)
		g_DebugLog("[PhongThanUI] map differs action=%u current=%u; delivering targeted action",
			action.MapId, currentMap);
	g_DebugLog("[PhongThanUI] client dispatch op=%d view=%d map=%u token=%u options=%d content=%d",
		action.Operation, action.View, action.MapId, action.DialogToken,
		action.OptionCount, action.ContentLength);
	Player[CLIENT_PLAYER_INDEX].OnScriptAction(&action);
}

void KProtocolProcess::SyncWorld(BYTE* pMsg)
{
	const PHONGTHAN_MAP_SNAPSHOT* WorldSync = (const PHONGTHAN_MAP_SNAPSHOT*)pMsg;

	if (Player[CLIENT_PLAYER_INDEX].m_nIndex > 0)
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_stand);
	}
	if (SubWorld[0].m_SubWorldID != WorldSync->MapId)
	{
		SubWorld[0].LoadMap(WorldSync->MapId, WorldSync->RegionId);
/*		SubWorld[0].m_Region[0].Load(WorldSync->MapId, WorldSync->RegionId);
		SubWorld[0].m_Region[0].Init(SubWorld[0].m_nRegionWidth, SubWorld[0].m_nRegionHeight);
		for (int i = 0; i < 8; i++)
		{
			if (SubWorld[0].m_Region[0].m_nConRegionID[i] == -1)
				continue;
			SubWorld[0].m_Region[i+1].Load(WorldSync->MapId, SubWorld[0].m_Region[0].m_nConRegionID[i]);
			SubWorld[0].m_Region[i+1].Init(SubWorld[0].m_nRegionWidth, SubWorld[0].m_nRegionHeight);
		}*/
	}
	
	if (SubWorld[0].m_dwCurrentTime > WorldSync->Tick)
	{
		// �ͻ��˿��ˣ����ٴ�����������Lag����ľ���Ϣ����Ҫ����
	}
	else if (SubWorld[0].m_dwCurrentTime < WorldSync->Tick)
	{
		// �ͻ������ˣ����ٴ���
	}

	SubWorld[0].m_dwCurrentTime = WorldSync->Tick;



	



	// ͬ������
	SubWorld[0].m_nWeather = WorldSync->Weather;
	g_ScenePlace.ChangeWeather(WorldSync->Weather);

	//TamLTM bang chiem linh thanh thi thon
	memcpy(SubWorld[0].m_szTongName,WorldSync->ClanName,sizeof(SubWorld[0].m_szTongName));
	memcpy(SubWorld[0].m_szTongNameBC,WorldSync->ControllingClanName, sizeof(SubWorld[0].m_szTongNameBC));
	SubWorld[0].m_nTongT = WorldSync->ClanTax;
	SubWorld[0].m_nTongVG = WorldSync->ClanTreasury;
	SubWorld[0].m_bCheckTong = WorldSync->ClanControlled;
//	g_DebugLog("KProtocolProcess checktong: %d", SubWorld[0].m_bCheckTong);
	//end code
}

void KProtocolProcess::s2cSyncAllSkill(BYTE* data)
{
	const PHONGTHAN_SKILL_LIST_HEADER* list = (const PHONGTHAN_SKILL_LIST_HEADER*)data;
	const PHONGTHAN_SKILL_ENTRY* skills = (const PHONGTHAN_SKILL_ENTRY*)(list + 1);
	if (list->Count >= MAX_NPCSKILL) return;
	for (unsigned int i = 0; i < list->Count; ++i)
		if (skills[i].SkillId >= MAX_SKILL || skills[i].Level >= MAX_SKILLLEVEL) return;
	const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	Npc[index].m_SkillList.Clear();
	for (unsigned int j = 0; j < list->Count; ++j)
		Npc[index].m_SkillList.Add(skills[j].SkillId, skills[j].Level, skills[j].Experience);
}

void KProtocolProcess::SyncEnd(BYTE* pMsg)
{
	const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	if (index <= 0 || index >= MAX_NPC || SubWorld[0].m_SubWorldID <= 0) return;
	PHONGTHAN_WORLD_SYNC_FENCE SyncEnd = *(const PHONGTHAN_WORLD_SYNC_FENCE*)pMsg;
	SyncEnd.Header.Flags = PHONGTHAN_WIRE_FLAG_REQUEST;
	if (g_pClient)
		g_pClient->SendPackToServer(&SyncEnd, sizeof(SyncEnd));
	Player[CLIENT_PLAYER_INDEX].SetDefaultImmedSkill();
	g_DebugLog("[TRACE]SyncEnd to Server");
	CoreDataChanged(GDCNI_GAME_START, 0, 0);	

	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SetInstantSpr(enumINSTANT_STATE_LOGIN);

	g_SubWorldSet.m_cMusic.Start(SubWorld[0].m_SubWorldID, SubWorld[0].m_dwCurrentTime, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode);

	Player[CLIENT_PLAYER_INDEX].m_cPK.Init();
}

void	KProtocolProcess::s2cTradeChangeState(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cTradeChangeState(pMsg);
}

void	KProtocolProcess::s2cNpcSetMenuState(BYTE* pMsg)
{
	NPC_SET_MENU_STATE_SYNC	*pState = (NPC_SET_MENU_STATE_SYNC*)pMsg;
	int		nNpc;
	if (pState->m_dwID == Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID)
	{
		nNpc = Player[CLIENT_PLAYER_INDEX].m_nIndex;
		if (pState->m_btState == PLAYER_MENU_STATE_TRADEOPEN)
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADE_STATE_OPEN);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		else if (pState->m_btState == PLAYER_MENU_STATE_NORMAL)
		{
			if (Npc[nNpc].GetMenuState() == PLAYER_MENU_STATE_TRADEOPEN)
			{
				KSystemMessage	sMsg;
				sprintf(sMsg.szMessage, MSG_TRADE_STATE_CLOSE);
				sMsg.eType = SMT_NORMAL;
				sMsg.byConfirmType = SMCT_NONE;
				sMsg.byPriority = 0;
				sMsg.byParamSize = 0;
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			}
		}
	}
	else
	{
		nNpc = NpcSet.SearchID(pState->m_dwID);
		if (nNpc == 0)
			return;
	}
	if (pState->m_wLength > sizeof(NPC_SET_MENU_STATE_SYNC) - 1 - sizeof(pState->m_szSentence))
		Npc[nNpc].SetMenuState(pState->m_btState, pState->m_szSentence, pState->m_wLength - (sizeof(NPC_SET_MENU_STATE_SYNC) - 1 - sizeof(pState->m_szSentence)));
	else
		Npc[nNpc].SetMenuState(pState->m_btState);
}

void	KProtocolProcess::s2cTradeMoneySync(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cTradeMoneySync(pMsg);
}

void	KProtocolProcess::s2cTradeDecision(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cTradeDecision(pMsg);
}
/*void	KProtocolProcess::s2cUpdateNpcState(BYTE * pMsg)
{
	NPC_SYNC_STATEINFO * pInfo = (NPC_SYNC_STATEINFO*) pMsg;
	int nIndex = NpcSet.SearchID(pInfo->m_ID);	
	
	if (nIndex > 0 && !Npc[nIndex].IsPlayer() && Npc[nIndex].m_RegionIndex >= 0)
	{
		Npc[nIndex].SetNpcState(pInfo->m_btStateInfo);
	}
}*/

void	KProtocolProcess::s2cTeamInviteAdd(BYTE * pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTeam.ReceiveInvite((TEAM_INVITE_ADD_SYNC*)pMsg);
}

void	KProtocolProcess::s2cTradePressOkSync(BYTE * pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTrade.SetTradeState((TRADE_STATE_SYNC*)pMsg);
}

void	KProtocolProcess::s2cDirectlyCastSkill(BYTE * pMsg)
{
	const PHONGTHAN_SKILL_CAST* skill = (const PHONGTHAN_SKILL_CAST*)pMsg;
	const int nIdx = NpcSet.SearchID(skill->EntityId);
	if (nIdx <= 0 || nIdx >= MAX_NPC || Npc[nIdx].m_RegionIndex < 0) return;
	const int nSkillID = skill->SkillId, nSkillLevel = skill->SkillLevel;
	int MapX = skill->X, MapY = skill->Y;
	if (skill->TargetKind == PHONGTHAN_SKILL_TARGET_ENTITY)
	{
		const int target = NpcSet.SearchID(skill->TargetId);
		if (target <= 0 || target >= MAX_NPC || Npc[target].m_RegionIndex < 0) return;
		Npc[target].GetMpsPos(&MapX, &MapY);
	}
	_ASSERT (nSkillID > 0 && nSkillLevel > 0);
	KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nSkillID, nSkillLevel);
	if (!pOrdinSkill) 
        return ;
	
    pOrdinSkill->Cast(nIdx, MapX, MapY);

	if(!pOrdinSkill->IsAura())
	{
		DWORD dwCastTime = 0;
		eSkillStyle eStyle = (eSkillStyle)pOrdinSkill->GetSkillStyle();
		if (eStyle == SKILL_SS_Missles 
			|| eStyle == SKILL_SS_Melee 
			|| eStyle == SKILL_SS_InitiativeNpcState 
			|| eStyle == SKILL_SS_PassivityNpcState
			|| eStyle == SKILL_SS_PhongThanAttack
			|| eStyle == SKILL_SS_PhongThanProduce
			|| eStyle == SKILL_SS_PhongThanAwaken)
		{
			dwCastTime = pOrdinSkill->GetDelayPerCast(Npc[nIdx].m_bRideHorse);
		}
		else
		{
			switch(eStyle)
			{
			case SKILL_SS_Thief:
				{
					dwCastTime = ((KThiefSkill*)pOrdinSkill)->GetDelayPerCast();
				}break;
			}
		}
		Npc[nIdx].m_SkillList.SetNextCastTime(nSkillID, SubWorld[0].m_dwCurrentTime, SubWorld[0].m_dwCurrentTime + dwCastTime);
	}
}

void	KProtocolProcess::s2cShowMsg(BYTE *pMsg)
{
	if (!pMsg)
		return;
	SHOW_MSG_SYNC	*pShowMsg = (SHOW_MSG_SYNC*)pMsg;
	switch (pShowMsg->m_wMsgID)
	{
	case enumMSG_ID_TEAM_KICK_ONE:
		{
			char	szName[32];
			KSystemMessage	sMsg;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));
			if (strcmp(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name, szName) == 0)
			{
				sprintf(sMsg.szMessage, MSG_TEAM_BE_KICKEN);
				sMsg.eType = SMT_TEAM;
				sMsg.byConfirmType = SMCT_CLICK;
				sMsg.byPriority = 1;
			}
			else
			{
				sprintf(sMsg.szMessage, MSG_TEAM_KICK_ONE, szName);
				sMsg.eType = SMT_NORMAL;
				sMsg.byConfirmType = SMCT_NONE;
				sMsg.byPriority = 0;
			}
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_DISMISS:
		{
			if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
				break;
			KSystemMessage	sMsg;
			if (Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFigure == TEAM_CAPTAIN)
			{
				sprintf(sMsg.szMessage, MSG_TEAM_DISMISS_CAPTAIN);
			}
			else
			{
				sprintf(sMsg.szMessage, MSG_TEAM_DISMISS_MEMBER, g_Team[0].m_szMemName[0]);
			}
			sMsg.eType = SMT_TEAM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_LEAVE:
		{
			if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
				break;
			KSystemMessage	sMsg;
			DWORD	dwID = *(DWORD*)(&pShowMsg->m_lpBuf);
			if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID == dwID)
			{
				sprintf(sMsg.szMessage, MSG_TEAM_LEAVE_SELF_MSG, g_Team[0].m_szMemName[0]);
			}
			else
			{
				sprintf(sMsg.szMessage, MSG_TEAM_LEAVE, NORMAL_UNCLEAR_WORD);
				for (int i = 0; i < MAX_TEAM_MEMBER; i++)
				{
					if ((DWORD)g_Team[0].m_nMember[i] == dwID)
					{
						sprintf(sMsg.szMessage, MSG_TEAM_LEAVE, g_Team[0].m_szMemName[i + 1]);
						break;
					}
				}
			}
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_REFUSE_INVITE:
		{
			char	szName[32];
			memset(szName, 0, sizeof(szName));
			memcpy(szName, &pShowMsg->m_lpBuf, pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));

			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TEAM_REFUSE_INVITE, szName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_APPLY_INVITE_FAIL:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TEAM_APPLY_INVITE_FAIL);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_APPLY_INVITE_FAIL2:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TEAM_APPLY_INVITE_FAIL2);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_SELF_ADD:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TEAM_SELF_ADD, g_Team[0].m_szMemName[0]);
			sMsg.eType = SMT_TEAM;
			sMsg.byConfirmType = SMCT_UI_TEAM;
			sMsg.byPriority = 3;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_ADDMEMBER_NOTVALID:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TEAM_ADDMEMBER_NOTVALID);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 3;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL:
		{
			int		nMember;
			DWORD	dwID = *(DWORD*)(&pShowMsg->m_lpBuf);
			nMember = g_Team[0].FindMemberID(dwID);
			if (nMember < 0)
				break;
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN_FAIL1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN_FAIL2, g_Team[0].m_szMemName[nMember + 1]);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL2:
		{
			int		nMember;
			DWORD	dwID = *(DWORD*)(&pShowMsg->m_lpBuf);
			nMember = g_Team[0].FindMemberID(dwID);
			if (nMember < 0)
				break;
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN_FAIL1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			sprintf(sMsg.szMessage, MSG_TEAM_CHANGE_CAPTAIN_FAIL3);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_OBJ_CANNOT_PICKUP:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			strcpy(sMsg.szMessage, MSG_OBJ_CANNOT_PICKUP);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_OBJ_TOO_FAR:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			strcpy(sMsg.szMessage, MSG_OBJ_TOO_FAR);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_DEC_MONEY:
		{	
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_DEC_MONEY, (int)pShowMsg->m_lpBuf);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SPAR_VICTORY:
		{	
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SPAR_VICTORY);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SPAR_DEFEAT:
		{	
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SPAR_DEFEAT);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_SELF_ROOM_FULL:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADE_SELF_ROOM_FULL);
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_DEST_ROOM_FULL:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADE_DEST_ROOM_FULL, Player[CLIENT_PLAYER_INDEX].m_cTrade.m_szDestName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADEFOLKGAME_SELF_ROOM_FULL:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADEFOLKGAME_SELF_ROOM_FULL, TRADEFOLKGAME_NEED_WIDTH, TRADEFOLKGAME_NEED_HEIGHT);
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADEFOLKGAME_DEST_ROOM_FULL:
		{
			int	nIdx = NpcSet.SearchID(*((DWORD*)&pShowMsg->m_lpBuf));
			if (nIdx <= 0)
				return;
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADEFOLKGAME_DEST_ROOM_FULL, Npc[nIdx].Name, TRADEFOLKGAME_NEED_WIDTH, TRADEFOLKGAME_NEED_HEIGHT);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_REFUSE_APPLY:
		{
			int	nIdx = NpcSet.SearchID(*((DWORD*)&pShowMsg->m_lpBuf));
			if (nIdx <= 0)
				return;
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TRADE_REFUSE_APPLY, Npc[nIdx].Name);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SPAR_REFUSE_APPLY:
		{
			int	nIdx = NpcSet.SearchID(*((DWORD*)&pShowMsg->m_lpBuf));
			if (nIdx <= 0)
				return;
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_SPAR_REFUSE_APPLY, Npc[nIdx].Name);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_GET_ITEM:
		{
			DWORD	dwID = LOWORD(*(DWORD*)(&pShowMsg->m_lpBuf));
			int	nStackNum = (int)HIWORD(*(DWORD*)(&pShowMsg->m_lpBuf));
			
			int nItemIdx = ItemSet.SearchID(dwID);
			if (nItemIdx <= 0 || nItemIdx >= MAX_ITEM)
				break;

			BOOL bIsStack = Item[nItemIdx].IsStack();
			char	szName[128];
			KSystemMessage	sMsg;

			strcpy(szName, Item[nItemIdx].GetName());

			if (strlen(szName) >= sizeof(sMsg.szMessage) - strlen(bIsStack ? MSG_ADD_ITEM_STACK : MSG_ADD_ITEM))
				break;

			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			if(bIsStack)
				sprintf(sMsg.szMessage, MSG_ADD_ITEM_STACK, nStackNum, szName);
			else
				sprintf(sMsg.szMessage, MSG_ADD_ITEM, szName);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;	
	case enumMSG_ID_MONEY_CANNOT_PICKUP:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			strcpy(sMsg.szMessage, MSG_MONEY_CANNOT_PICKUP);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_CANNOT_ADD_TEAM:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			sprintf(sMsg.szMessage, MSG_TEAM_CANNOT_CREATE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TEAM_IS_FULL:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TEAM_IS_FULL);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_CANNOT_INVITE_TEAM:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TEAM_CLOSE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TARGET_CANNOT_ADD_TEAM:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TEAM_TARGET_CANNOT_ADD_TEAM);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_GET_INVITE_TEAM_REPLY:
		{
			char	szName[32];
			memset(szName, 0, sizeof(szName));
			memcpy(szName, &pShowMsg->m_lpBuf, pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TEAM_SEND_INVITE, szName);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_HIGHT_LOCK_NOT_SWITCH:
		{
			int	nPKValue = (int)*((DWORD*)&pShowMsg->m_lpBuf);

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_HIGHT_LOCK_NOT_SWITCH, nPKValue);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PKSTATE_NOT_OPEN:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PKSTATE_NOT_OPEN);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_1:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_2:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_2);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_3:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_3);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_4:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_4);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_5:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_5);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_6:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_6);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_7:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_7);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_8:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_8);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_ERROR_9:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_PK_ERROR_9);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK:
		{
			//int	nNormalPKTimeLong = (int)*((DWORD*)&pShowMsg->m_lpBuf);

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK, 3/*nNormalPKTimeLong/1000/60*/);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK1:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK2:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK2);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK3:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK3);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK4:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK4);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK5:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK5);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK6:
		{
			int	nFightPKTimeLong = (int)*((DWORD*)&pShowMsg->m_lpBuf);

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK6);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_PK_IS_LOCK7:
		{
			//TamLTM Fix debug vlaue null
		//	int	nFightPKTimeLong = (int)*((DWORD*)&pShowMsg->m_lpBuf);

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MGS_PK_IS_LOCK7, 10/*nFightPKTimeLong/1000*/);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_BUZY:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_CANT_TRADE_BUZY);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_CLOSED:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TRADE_CLOSED);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TRADE_SELLED:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TRADE_SELLED);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_DEATH_LOSE_ITEM:
		{
			char	szName[32];
			memset(szName, 0, sizeof(szName));
			memcpy(szName, &pShowMsg->m_lpBuf, pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_DEATH_LOSE_ITEM, szName);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_REFUSE_ADD:
		{
			char	szName[32];

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_REFUSE_ADD, szName);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_BE_KICK:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_BE_KICKED);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			KUiGameObjectWithName	sUi;
			strcpy(sUi.szName, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);
			sUi.nData = TONG_ACTION_DISMISS;
			sUi.nParam = 0;
			sUi.uParam = 0;
			sUi.szString[0] = 0;
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, 1);

			CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
		}
		break;
	case enumMSG_ID_TONG_LEAVE_SUCCESS:
		{
			Player[CLIENT_PLAYER_INDEX].m_cTong.m_dwLeaveTime = (DWORD)pShowMsg->m_lpBuf;
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_LEAVE_SUCCESS, TongData.m_sTongParam.m_nLeaveTime);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
		}
		break;
	case enumMSG_ID_TONG_LEAVE_FAIL:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_LEAVE_FAIL);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_NO_MONEY:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_NO_MONEY);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_CHANGE_AS_MASTER:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_CHANGE_AS_MASTER);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			KUiGameObjectWithName	sUi;
			strcpy(sUi.szName, Player[CLIENT_PLAYER_INDEX].m_cTong.m_szMasterName);
			sUi.nData = TONG_ACTION_DEMISE;
			sUi.nParam = 0;
			sUi.uParam = 0;
			sUi.szString[0] = 0;
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, 1);
		}
		break;
	case enumMSG_ID_TONG_CHANGE_AS_MEMBER:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_CHANGE_AS_MEMBER);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			KUiGameObjectWithName	sUi;
			strcpy(sUi.szName, Player[CLIENT_PLAYER_INDEX].m_cTong.m_szMasterName);
			sUi.nData = TONG_ACTION_DEMISE;
			sUi.nParam = 0;
			sUi.uParam = 0;
			sUi.szString[0] = 0;
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, 1);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR:
		{
			char	szName[32];

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR, szName);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR1:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR2:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR2);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR3:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR3);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR4:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR4);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR5:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR5);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR6:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR6);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_TONG_APPLY_ADD_ERROR7:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_ERROR7);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FIGHT_MODE_ERROR1:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_FIGHT_MODE_ERROR1);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FIGHT_MODE_ERROR2:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_FIGHT_MODE_ERROR2);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FIGHT_MODE_ERROR3:
		{
			int	nIdx = NpcSet.SearchID(*((DWORD*)&pShowMsg->m_lpBuf));
			if (nIdx <= 0)
				return;

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_FIGHT_MODE_ERROR3, Npc[nIdx].Name);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_ROOM:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_ROOM);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_MONEY:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_MONEY);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_EXTPOINT:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_EXTPOINT);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_FUYUAN:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_FUYUAN);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_REPUTE:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_REPUTE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_ACCUM:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_ACCUM);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_HONOR:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_HONOR);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_SHOP_NO_RESPECT:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_SHOP_NO_RESPECT);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FUNCTION_CHAT_FORBIDDENED:
		{
			time_t rawtime=(int)*((DWORD*)&pShowMsg->m_lpBuf)+1451581200;
			struct tm * timeinfo = localtime(&rawtime);

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			strftime(sMsg.szMessage, sizeof(sMsg.szMessage), MSG_NPC_NOT_PAY_FOR_SPEECH, timeinfo);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FUNCTION_FOBIDDENED:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_FUNCTION_FOBIDDENED);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_FUNCTION_LOCKED:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_FUNCTION_LOCKED);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_LOCK_NOT_TRADE:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_LOCK_NOT_TRADE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_LOCK_NOT_SETPRICE:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_LOCK_NOT_SETPRICE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_LOCK_NOT_THROW:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_LOCK_NOT_THROW);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_ITEM_TOWNPORTAL:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_SYSTEM;
			sMsg.byConfirmType = SMCT_CLICK;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_TOWNPORTAL);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_ITEM_CANTREPAIR:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_BROKEN_CANTREPAIR);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_ITEM_SAME_IMMEDIATE:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_ITEM_SAME_IN_IMMEDIATE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_ITEM_CANTPUT_IMMEDIATE:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_ITEM_PUT_IN_IMMEDIATE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_HORSE_CANT_SWITCH1:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_CANT_SWITCH_HORSE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_HORSE_CANT_SWITCH2:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_CANT_SWITCH_HORSE_SIT);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_CHATROOM_JOIN:
		{
			char	szName[32];
			KSystemMessage	sMsg;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));
			sprintf(sMsg.szMessage, MSG_CHATROOM_JOIN, szName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
		}
		break;
	case enumMSG_ID_CHATROOM_LEAVE:
		{
			char	szName[32];
			KSystemMessage	sMsg;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));
			sprintf(sMsg.szMessage, MSG_CHATROOM_LEAVE, szName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
		}
		break;
	case enumMSG_ID_CHATROOM_BEKICK:
		{
			char	szName[32];
			KSystemMessage	sMsg;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));
			sprintf(sMsg.szMessage, MSG_CHATROOM_BEKICK, szName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
		}
		break;
	case enumMSG_ID_CHATROOM_OPENGAME:
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_CHATROOM_OPENGAME, (int)*((DWORD*)&pShowMsg->m_lpBuf));
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
		}
		break;
	case  enumMSG_ID_CHATROOM_REVERSE:
		{
			char	szName[32];
			KSystemMessage	sMsg;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pMsg + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), pShowMsg->m_wLength + 1 + sizeof(LPVOID) - sizeof(SHOW_MSG_SYNC));
			sprintf(sMsg.szMessage, MSG_CHATROOM_REVERSE, szName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
		}
		break;
	case enumMSG_ID_NPC_RENASCENCE_SOMEONE:
		{
			KSystemMessage sMsg;
			sMsg.byConfirmType = SMCT_UI_RENASCENCE;
			sMsg.byParamSize = 0;
			sMsg.byPriority = 0;
			sMsg.eType = SMT_PLAYER;
			int	nIdx = NpcSet.SearchID(*((DWORD*)&pShowMsg->m_lpBuf));
			if (nIdx)
				sprintf(sMsg.szMessage, MSG_NPC_RENASCENCE_SOMEONE, Npc[nIdx].Name);
			else
				sprintf(sMsg.szMessage, MSG_NPC_RENASCENCE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case enumMSG_ID_NPC_RENASCENCE:
		{
			KSystemMessage sMsg;
			sMsg.byConfirmType = SMCT_UI_RENASCENCE;
			sMsg.byParamSize = 0;
			sMsg.byPriority = 0;
			sMsg.eType = SMT_PLAYER;
			sprintf(sMsg.szMessage, MSG_NPC_RENASCENCE);
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	default:
		break;
	}
}

void KProtocolProcess::SyncStateEffect(BYTE* data)
{
	const PHONGTHAN_STATE_EFFECT_HEADER* state = (const PHONGTHAN_STATE_EFFECT_HEADER*)data;
	if (state->SkillId >= MAX_SKILL || state->Level >= MAX_SKILLLEVEL || state->AttributeCount > MAX_SKILL_STATE) return;
	const PHONGTHAN_ATTRIBUTE_WIRE* attributes = (const PHONGTHAN_ATTRIBUTE_WIRE*)(state + 1);
	KMagicAttrib values[MAX_SKILL_STATE];
	ZeroMemory(values, sizeof(values));
	for (unsigned int i = 0; i < state->AttributeCount; ++i)
	{
		values[i].nAttribType = attributes[i].Type;
		for (int j = 0; j < 3; ++j) values[i].nValue[j] = attributes[i].Value[j];
	}
	const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	Npc[index].SetStateSkillEffect(index, state->SkillId, state->Level, values,
		state->AttributeCount, state->DurationTicks, state->ReplaceExisting);
	CoreDataChanged(GDCNI_PLAYER_RT_ATTRIBUTE, 0, 0);
}

void	KProtocolProcess::IgnoreState(BYTE* pMsg)
{
	const PHONGTHAN_STATE_CLEAR* pSync = (const PHONGTHAN_STATE_CLEAR*)pMsg;
	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].IgnoreState((BOOL)pSync->Negative);
}

void	KProtocolProcess::s2cTradeApplyStart(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cTradeApplyStart(pMsg);
}

void	KProtocolProcess::s2cCreateTong(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTong.ForceCreateTong(pMsg);
}

void	KProtocolProcess::s2cJoinTong(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTong.s2cJoinTong(pMsg);
}

void	KProtocolProcess::s2cJoinTongReply(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTong.s2cJoinTongReply(pMsg);
}

void	KProtocolProcess::s2cItemAutoMove(BYTE* pMsg)
{
	PHONGTHAN_ITEM_MOVE_MESSAGE* pSync =
		(PHONGTHAN_ITEM_MOVE_MESSAGE*)pMsg;
	if (!pSync ||
		pSync->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE ||
		pSync->Header.PacketSize != sizeof(PHONGTHAN_ITEM_MOVE_MESSAGE))
	{
		g_DebugLog("[PhongThanWire] Invalid item auto move");
		return;
	}
	ItemPos	sSrc, sDest;
	sSrc.nPlace = pSync->FromContainer;
	sSrc.nX = pSync->FromX;
	sSrc.nY = pSync->FromY;
	sDest.nPlace = pSync->ToContainer;
	sDest.nX = pSync->ToX;
	sDest.nY = pSync->ToY;
	
	Player[CLIENT_PLAYER_INDEX].m_ItemList.AutoMoveItem(sSrc, sDest);
}

extern IClientCallback* l_pDataChangedNotifyFunc;

void KProtocolProcess::s2cExtend(BYTE* pMsg)
{
	EXTEND_HEADER* pHeader = (EXTEND_HEADER*)(pMsg + sizeof(tagExtendProtoHeader));

	if (pHeader->ProtocolFamily == pf_playercommunity)
	{
		if (pHeader->ProtocolID == playercomm_s2c_notifychannelid)
		{
			PLAYERCOMM_NOTIFYCHANNELID* pNChann = (PLAYERCOMM_NOTIFYCHANNELID*)pHeader;

			l_pDataChangedNotifyFunc->NotifyChannelID(pNChann->channel, pNChann->channelid, pNChann->cost);
		}
	}
}

void KProtocolProcess::s2cExtendChat(BYTE* pMsg)
{
	tagExtendProtoHeader* pExHdr = (tagExtendProtoHeader*)pMsg;
	void* pExPckg = pExHdr + 1;
	BYTE protocol = *(BYTE*)(pExPckg);

	if (protocol == chat_someonechat)
	{
		CHAT_SOMEONECHAT_SYNC* pCscSync = (CHAT_SOMEONECHAT_SYNC*)pExPckg;

		l_pDataChangedNotifyFunc->MSNMessageArrival(
			pCscSync->someone, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name,
			(const char*)(pCscSync + 1), pCscSync->sentlen, (const char*)&pCscSync->item, true);
	}
	else if (protocol == chat_channelchat)
	{
		CHAT_CHANNELCHAT_SYNC* pCccSync = (CHAT_CHANNELCHAT_SYNC*)pExPckg;
		// Server-side Msg2Player() uses channel -1.  Forwarding that id to
		// the old UI makes it look for an optional GM channel and the message
		// is dropped when that channel is absent.  Convert it to the standard
		// system-message event here so every VNG item script gets visible
		// feedback without depending on chat-channel initialization.
		if (pCccSync->channelid == -1)
		{
			KSystemMessage sMsg;
			memset(&sMsg, 0, sizeof(sMsg));
			int nCopyLen = pCccSync->sentlen;
			if (nCopyLen >= sizeof(sMsg.szMessage))
				nCopyLen = sizeof(sMsg.szMessage) - 1;
			if (nCopyLen > 0)
				memcpy(sMsg.szMessage, (const char*)(pCccSync + 1), nCopyLen);
			sMsg.szMessage[nCopyLen] = 0;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			return;
		}
		l_pDataChangedNotifyFunc->ChannelMessageArrival(
			pCccSync->channelid, pCccSync->someone,
			(const char*)(pCccSync + 1), pCccSync->sentlen, (const char*)&pCccSync->item, pCccSync->someflag, true); //Kenh Bang
	}
	else if (protocol == chat_feedback)
	{
		////X
		CHAT_FEEDBACK* pCfb = (CHAT_FEEDBACK*)pExPckg;
		DWORD* pChannelid = (DWORD*)(pCfb + 1);

		if (*pChannelid == -1)
		{//someone
			char* pDstName = (char*)(pChannelid + 1);
			BYTE* pSentlen = (BYTE*)(pDstName + _NAME_LEN);
			void* pSent = pSentlen + 1;

			l_pDataChangedNotifyFunc->MSNMessageArrival(
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name, pDstName,
				(const char*)pSent, *pSentlen, (const char*)&pCfb->item, pCfb->code != codeFail);
		}
		else
		{//channel
			BYTE* pSentlen = (BYTE*)(pChannelid + 1);
			void* pSent = pSentlen + 1;

			l_pDataChangedNotifyFunc->ChannelMessageArrival(
				*pChannelid, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name,
				(const char*)pSent, *pSentlen, (const char*)&pCfb->item, pCfb->someflag, pCfb->code != codeFail);
		}
		////X
	}
}


static BOOL sParseUGName(const std::string& name, std::string* pUnit, std::string* pGroup)
{
	static const char char_split = '\n';

	size_t pos = name.find(char_split);
	if (pos == name.npos)
	{
		if (pUnit)
			pUnit->resize(0);
		if (pGroup)
			pGroup->assign(name);
	}
	else
	{
		std::string::const_iterator itSplit = name.begin() + pos;

		if (pUnit)
			pUnit->assign(name.begin(), itSplit);
		if (pGroup)
			pGroup->assign(itSplit + 1, name.end());
	}

	return TRUE;
}

void KProtocolProcess::s2cExtendFriend(BYTE* pMsg)
{
	tagExtendProtoHeader* pExHdr = (tagExtendProtoHeader*)pMsg;
	void* pExPckg = pExHdr + 1;

	EXTEND_HEADER* pHeader = (EXTEND_HEADER*)(pExPckg);

	if (pHeader->ProtocolFamily == pf_tong)
	{
		_ASSERT(FALSE);
		//tong message
		//...
	}
	else if (pHeader->ProtocolFamily == pf_friend)
	{
		if (pHeader->ProtocolID == friend_c2c_askaddfriend)
		{
			ASK_ADDFRIEND_SYNC* pAafSync = (ASK_ADDFRIEND_SYNC*)pHeader;
			l_pDataChangedNotifyFunc->FriendInvite(pAafSync->srcrole);
		}
		else if (pHeader->ProtocolID == friend_c2s_erasefriend)
		{
			REP_ERASEFRIEND_SYNC* pEfSync = (REP_ERASEFRIEND_SYNC*)pHeader;
			l_pDataChangedNotifyFunc->DeleteFriend(pEfSync->srcrole);
		}
		else if (pHeader->ProtocolID == friend_c2c_repaddfriend)
		{
			REP_ADDFRIEND_SYNC* pRafSync = (REP_ADDFRIEND_SYNC*)pHeader;
			l_pDataChangedNotifyFunc->AddFriend(pRafSync->srcrole, pRafSync->answer);
		}
		else if (pHeader->ProtocolID == friend_s2c_repsyncfriendlist)
		{
			REP_SYNCFRIENDLIST* pRsfl = (REP_SYNCFRIENDLIST*)pHeader;
			char* pGroupTag = (char*)(pRsfl + 1);
			if (*pGroupTag != specGroup)
				goto on_error;
			{{
			char* pGroup = (char*)(pGroupTag + 1);
on_newgroup:
			std::string theUnit, theGroup;
			sParseUGName(std::string(pGroup), &theUnit, &theGroup);

			for (char* pRoleTag = pGroup + strlen(pGroup) + 1; ; )
			{
				if (*pRoleTag == specOver)
					goto on_over;
				else if (*pRoleTag == specGroup)
				{
					pGroup = pRoleTag + 1;
					goto on_newgroup;
				}
				else if (*pRoleTag == specRole)
				{
					char* pState = pRoleTag + 1;
					char* pRole = pState + 1;
					l_pDataChangedNotifyFunc->FriendInfo(pRole, (char*)theUnit.c_str(), (char*)theGroup.c_str(), (BYTE)*pState);
					pRoleTag = pRole + strlen(pRole) + 1;
					continue;
				}
				else
					goto on_error;
			}
			}}
on_error:
			_ASSERT(FALSE);
on_over:
			0;
		}
		else if (pHeader->ProtocolID == friend_s2c_friendstate)
		{
			FRIEND_STATE* pFs = (FRIEND_STATE*)pHeader;
			for (char* pRole = (char*)(pFs + 1); *pRole; pRole += strlen(pRole) + 1)
				l_pDataChangedNotifyFunc->FriendStatus(pRole, pFs->state);
		}
		else if (pHeader->ProtocolID == friend_s2c_syncassociate)
		{
			FRIEND_SYNCASSOCIATE* pFsa = (FRIEND_SYNCASSOCIATE*)pHeader;

			char* szGroup = (char*)(pFsa + 1);
			std::string group(szGroup);

			std::string theUnit, theGroup;
			sParseUGName(group, &theUnit, &theGroup);
			_ASSERT(theGroup.empty());

			for (char* szRole = szGroup + group.size() + 1; *szRole; szRole += strlen(szRole) + 1)
				l_pDataChangedNotifyFunc->AddPeople((char*)theUnit.c_str(), szRole);
		}
	}
}


void KProtocolProcess::s2cExtendTong(BYTE* pMsg)
{
	S2C_TONG_HEAD	*pHead = (S2C_TONG_HEAD*)pMsg;
	switch (pHead->m_btMsgId)
	{
	case enumTONG_SYNC_ID_CREATE_FAIL:
		{
			TONG_CREATE_FAIL_SYNC *pFail = (TONG_CREATE_FAIL_SYNC*)pMsg;

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;

			sprintf(sMsg.szMessage, "Th�nh l�p bang h�i th�t b�i");
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);

			switch (pFail->m_btFailId)
			{
			case enumTONG_CREATE_ERROR_ID1:		// Player[m_nPlayerIndex].m_nIndex <= 0
				break;
			case enumTONG_CREATE_ERROR_ID2:		// ���׹�����
				break;
			case enumTONG_CREATE_ERROR_ID3:		// ���������
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR09);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID4:		// �����Ӫ����
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR02);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID5:		// �Ѿ��ǰ���Ա
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR03);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID6:		// �Լ�����Ӫ����
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR04);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID7:		// �ȼ�����
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR05);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID8:		// Ǯ����
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR10);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID9:		// ��Ӳ��ܽ����
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR08);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID10:	// ���ģ�����
				break;
			case enumTONG_CREATE_ERROR_ID11:	// �����ַ�������
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR11, TongData.m_sTongParam.m_nRepute);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID12:	// �����ַ�������
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR12, TongData.m_sTongParam.m_nFuYuan);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID13:	// ���ͬ������
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR13);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID14:	// ������ʧ��
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR14);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CREATE_ERROR_ID15:	// ������ʧ��
				sprintf(sMsg.szMessage, MSG_TONG_CREATE_ERROR15);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			}
		}
		break;
	case enumTONG_SYNC_ID_TRANSFER_ADD_APPLY:
		{
			TONG_APPLY_ADD_SYNC	*pApply = (TONG_APPLY_ADD_SYNC*)pMsg;
			char	szName[32];
			DWORD	dwNameID;
			int		nPlayerIdx;

			memset(szName, 0, sizeof(szName));
			memcpy(szName, pApply->m_szName, pApply->m_wLength + 1 + sizeof(pApply->m_szName) - sizeof(TONG_APPLY_ADD_SYNC));
			dwNameID = g_FileName2Id(szName);
			nPlayerIdx = pApply->m_nPlayerIdx;

			// �����淢��Ϣ���յ����룬�Ƿ�ͬ��
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_TONG_APPLY_ADD_SELF_MSG, szName);
			sMsg.eType = SMT_CLIQUE;
			sMsg.byConfirmType = SMCT_UI_TONG_JOIN;
			sMsg.byPriority = 3;
			sMsg.byParamSize = sizeof(KUiPlayerItem);
			
			KUiPlayerItem	player;
			strcpy(player.Name, szName);
			player.nIndex = pApply->m_nPlayerIdx;
			player.uId = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, (int)&player);
		}
		break;
	case enumTONG_SYNC_ID_ADD:
		{
			TONG_ADD_SYNC	*pAdd = (TONG_ADD_SYNC*)pMsg;
			char	szName[32], szAgname[32], szMaster[32];

			memcpy(szName, pAdd->m_szTongName,sizeof(szName));
			memcpy(szAgname, pAdd->m_szAgname, sizeof(szAgname));
			memcpy(szMaster, pAdd->m_szMaster, sizeof(szMaster));

			Player[CLIENT_PLAYER_INDEX].m_cTong.AddTong(pAdd->m_btCamp, szName, szAgname, szMaster);
			// ֪ͨ�����������
			KUiGameObjectWithName	sUi;
			memset(&sUi, 0, sizeof(sUi));
			strcpy(sUi.szName, szName);
			sUi.nData = TONG_ACTION_APPLY;
			strcpy(sUi.szString, szAgname);
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, 1);
		/*------------------------------*/
			CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
		}
		break;

	case enumTONG_SYNC_ID_HEAD_INFO:
		{
			TONG_HEAD_INFO_SYNC	*pInfo = (TONG_HEAD_INFO_SYNC*)pMsg;

			// ֪ͨ����õ�ĳ�����Ϣ
			int nIdx = NpcSet.SearchID(pInfo->m_dwNpcID);
			if (nIdx <= 0)
				break;

			KUiPlayerRelationWithOther	sUi;
			sUi.nIndex = nIdx;
			sUi.uId = Npc[nIdx].m_dwID;
			if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
				sUi.nRelation = Player[CLIENT_PLAYER_INDEX].m_cTong.m_nFigure;
			else
				sUi.nRelation = -1;
			sUi.nData = 0;
			sUi.nParam = 0;
			strcpy(sUi.Name, Npc[nIdx].Name);

			KTongInfo	sInfo;
			memset(&sInfo, 0, sizeof(sInfo));
			sInfo.nCamp = pInfo->m_btCamp;
			sInfo.btLevel = pInfo->m_btLevel;
			sInfo.nMemberCount = (int)pInfo->m_dwMemberNum;
			sInfo.nManagerCount = (int)pInfo->m_btManagerNum;
			sInfo.nDirectorCount = (int)pInfo->m_btDirectorNum;
			sInfo.nMoney = pInfo->m_dwMoney;
			strcpy(sInfo.szName, pInfo->m_szTongName);
			strcpy(sInfo.szMasterName, pInfo->m_sMember[0].m_szName);
			sInfo.dwTotalEff = pInfo->m_dwTotalEff;
			sInfo.nMasterSaveEff = pInfo->m_sMember[0].m_nMasterEff;
			sInfo.nMasterJoinTm = pInfo->m_sMember[0].m_nMasterJoinTm;
			sInfo.bRecruit = pInfo->m_bRecruit;
			sInfo.nTongJiyuParam = pInfo->m_nTongJiyuParam;
			strcpy(sInfo.szTongJiyuNotify, pInfo->m_szTongJiyuNotify);
			CoreDataChanged(GDCNI_TONG_INFO, (unsigned int)&sUi, (unsigned int)&sInfo);

			KUiGameObjectWithName	sObj;
			strcpy(sObj.szName, pInfo->m_szTongName);
			sObj.nData = enumTONG_FIGURE_DIRECTOR;
			sObj.nParam = 0;
			sObj.uParam = defTONG_MAX_DIRECTOR;
			sObj.szString[0] = 0;

			KTongMemberItem	sItem[defTONG_MAX_DIRECTOR];
			memset(sItem, 0, sizeof(sItem));
			for (int i = 0; i < pInfo->m_btDirectorNum; i++)
			{
				sItem[i].nData = enumTONG_FIGURE_DIRECTOR;
				strcpy(sItem[i].Name, pInfo->m_sMember[i + 1].m_szName);
				strcpy(sItem[i].szAgname, pInfo->m_sMember[i + 1].m_szAgname);
				sItem[i].bOnline = pInfo->m_sMember[i + 1].m_bOnline;
				sItem[i].nSaveEff = pInfo->m_sMember[i + 1].m_nDirectorEff[i];
				sItem[i].nJoinTm = pInfo->m_sMember[i + 1].m_nDirectorJoinTm[i];
			}
			CoreDataChanged(GDCNI_TONG_MEMBER_LIST, (unsigned int)&sObj, (unsigned int)sItem);
		}
		break;
	case enumTONG_SYNC_ID_SELF_INFO:
		{
			TONG_SELF_INFO_SYNC	*pInfo = (TONG_SELF_INFO_SYNC*)pMsg;
			Player[CLIENT_PLAYER_INDEX].m_cTong.SetSelfInfo(pInfo);
			// ֪ͨ�����������
			KTongInfo	sInfo;
			memset(&sInfo, 0, sizeof(sInfo));
			sInfo.nCamp = pInfo->m_btCamp;
			sInfo.btLevel = pInfo->m_btLevel;
			sInfo.nMemberCount = (int)pInfo->m_dwMemberNum;
			sInfo.nManagerCount = (int)pInfo->m_btManagerNum;
			sInfo.nDirectorCount = (int)pInfo->m_btDirectorNum;
			sInfo.nMoney = pInfo->m_dwMoney;
			strcpy(sInfo.szName, pInfo->m_szTongName);
			strcpy(sInfo.szMasterName, pInfo->m_szMasterName);
			sInfo.dwTotalEff = pInfo->m_dwTotalEff;
			sInfo.nMasterJoinTm=0;
			sInfo.nMasterSaveEff=0;
			sInfo.bRecruit = pInfo->m_bRecruit;
			sInfo.nTongJiyuParam = pInfo->m_nTongJiyuParam;
			strcpy(sInfo.szTongJiyuNotify, pInfo->m_szTongJiyuNotify);
			CoreDataChanged(GDCNI_TONG_INFO, NULL, (unsigned int)&sInfo);

			CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
		}
		break;
	case enumTONG_SYNC_ID_MANAGER_INFO:
		{
			TONG_MANAGER_INFO_SYNC	*pInfo = (TONG_MANAGER_INFO_SYNC*)pMsg;

			// ֪ͨ����õ�ĳ���ӳ���Ϣ
			KUiGameObjectWithName	sObj;
			strcpy(sObj.szName, pInfo->m_szTongName);
			sObj.nData = enumTONG_FIGURE_MANAGER;
			sObj.nParam = pInfo->m_btStateNo;
			sObj.uParam = pInfo->m_btCurNum;
			sObj.szString[0] = 0;

			KTongMemberItem	sItem[defTONG_ONE_PAGE_MAX_NUM];
			memset(sItem, 0, sizeof(sItem));
			for (int i = 0; i < pInfo->m_btCurNum; i++)
			{
				sItem[i].nData = enumTONG_FIGURE_MANAGER;
				strcpy(sItem[i].Name, pInfo->m_sMember[i].m_szName);
				strcpy(sItem[i].szAgname, pInfo->m_sMember[i].m_szAgname);
				sItem[i].bOnline = pInfo->m_sMember[i].m_bOnline;
				sItem[i].nSaveEff = pInfo->m_sMember[i].m_nManagerEff[i];
				sItem[i].nJoinTm = pInfo->m_sMember[i].m_nManagerJoinTm[i];
			}

			CoreDataChanged(GDCNI_TONG_MEMBER_LIST, (unsigned int)&sObj, (unsigned int)sItem);
		}
		break;
	case enumTONG_SYNC_ID_MEMBER_INFO:
		{
			TONG_MEMBER_INFO_SYNC	*pInfo = (TONG_MEMBER_INFO_SYNC*)pMsg;

			// ֪ͨ����õ�ĳ��������Ϣ
			KUiGameObjectWithName	sObj;
			strcpy(sObj.szName, pInfo->m_szTongName);
			sObj.nData = enumTONG_FIGURE_MEMBER;
			sObj.nParam = pInfo->m_btStateNo;
			sObj.uParam = pInfo->m_btCurNum;
			sObj.szString[0] = 0;

			KTongMemberItem	sItem[defTONG_ONE_PAGE_MAX_NUM];
			memset(sItem, 0, sizeof(sItem));
			for (int i = 0; i < pInfo->m_btCurNum; i++)
			{
				sItem[i].nData = enumTONG_FIGURE_MEMBER;
				strcpy(sItem[i].Name, pInfo->m_sMember[i].m_szName);
				if (pInfo->m_sMember[i].m_btSex)
					strcpy(sItem[i].szAgname, pInfo->m_szFemaleAgname);
				else
					strcpy(sItem[i].szAgname, pInfo->m_szMaleAgname);
				if (!sItem[i].szAgname[0])
					strcpy(sItem[i].szAgname, pInfo->m_szAgname);
				sItem[i].bOnline = pInfo->m_sMember[i].m_bOnline;
				sItem[i].nSaveEff = pInfo->m_sMember[i].m_nMemberEff;
				sItem[i].nJoinTm = pInfo->m_sMember[i].m_nMemberJoinTm;
			}

			CoreDataChanged(GDCNI_TONG_MEMBER_LIST, (unsigned int)&sObj, (unsigned int)sItem);
		}
		break;
	case enumTONG_SYNC_ID_INSTATE:
		{
			TONG_INSTATE_SYNC	*pInstate = (TONG_INSTATE_SYNC*)pMsg;
			// ֪ͨ���������Ƿ�ɹ�
			KUiGameObjectWithName	sUi;
			strcpy(sUi.szName, pInstate->m_szName);
			sUi.nData = TONG_ACTION_ASSIGN;
			sUi.nParam = pInstate->m_btNewFigure;
			sUi.uParam = pInstate->m_btOldFigure;
			strcpy(sUi.szString, pInstate->m_szAgname);
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, pInstate->m_btSuccessFlag);
		}
		break;
	case enumTONG_SYNC_ID_KICK:
		{
			TONG_KICK_SYNC	*pKick = (TONG_KICK_SYNC*)pMsg;
			// ֪ͨ���������Ƿ�ɹ�
			KUiGameObjectWithName	sUi;
			strcpy(sUi.szName, pKick->m_szName);
			sUi.nData = TONG_ACTION_DISMISS;
			sUi.nParam = pKick->m_btFigure;
			sUi.uParam = pKick->m_btPos;
			sUi.szString[0] = 0;
			CoreDataChanged(GDCNI_TONG_ACTION_RESULT, (unsigned int)&sUi, pKick->m_btSuccessFlag);
		}
		break;
	case enumTONG_SYNC_ID_CHANGE_MASTER_FAIL:
		{
			TONG_CHANGE_MASTER_FAIL_SYNC	*pFail = (TONG_CHANGE_MASTER_FAIL_SYNC*)pMsg;

			switch (pFail->m_btFailID)
			{
			case 0:		// �Է�������
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_MASTER_ERROR1);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;
			case 1:		// �Է�����������
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_MASTER_ERROR2);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;
			case 2:		// ���ֲ��ԣ�
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_MASTER_ERROR3);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;

			default:
				break;
			}
		}
		break;
	case enumTONG_SYNC_ID_CHANGE_AGNAME_FAIL:
		{
			TONG_CHANGE_AGNAME_FAIL_SYNC	*pFail = (TONG_CHANGE_AGNAME_FAIL_SYNC*)pMsg;
			
			switch (pFail->m_btFailID)
			{
			case 0:		// �Է�������
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_AGNAME_ERROR1);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;
			case 1:		// �Է�����������
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_AGNAME_ERROR2);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;
			case 2:		// ���ֲ��ԣ�
				{
					KSystemMessage	sMsg;
					sMsg.eType = SMT_NORMAL;
					sMsg.byConfirmType = SMCT_NONE;
					sMsg.byPriority = 0;
					sMsg.byParamSize = 0;
					sprintf(sMsg.szMessage, MSG_TONG_CHANGE_AGNAME_ERROR3);
					CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				}
				break;
			default:
				break;
			}
		}
		break;
	case enumTONG_SYNC_ID_CHANGE_CAMP_FAIL:
		{
			TONG_CHANGE_CAMP_FAIL_SYNC *pFail = (TONG_CHANGE_CAMP_FAIL_SYNC*)pMsg;

			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;						
			switch (pFail->m_btFailID)
			{
			case enumTONG_CHANGE_CAMP_ERROR_ID1:
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID2:
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID3:
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID4:
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID5:
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID6:
				sprintf(sMsg.szMessage, MSG_TONG_CHANGE_CAMP_ERROR1);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID7:
				sprintf(sMsg.szMessage, MSG_TONG_CHANGE_CAMP_ERROR2);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			case enumTONG_CHANGE_CAMP_ERROR_ID8:
				sprintf(sMsg.szMessage, MSG_TONG_CHANGE_CAMP_ERROR3);
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
				break;
			}
		}
		break;
	default:
		break;
	}
}


void KProtocolProcess::s2cChangeWeather(BYTE* pMsg)
{
	g_ScenePlace.ChangeWeather(((SYNC_WEATHER*)pMsg)->WeatherID);
}

void	KProtocolProcess::s2cPKSyncNormalFlag(BYTE* pMsg)
{
	PK_NORMAL_FLAG_SYNC	*pFlag = (PK_NORMAL_FLAG_SYNC*)pMsg;
	Player[CLIENT_PLAYER_INDEX].m_cPK.SetNormalPKState(pFlag->m_btFlag);
}

void	KProtocolProcess::s2cPKSyncEnmityState(BYTE* pMsg)
{
	PK_ENMITY_STATE_SYNC	*pState = (PK_ENMITY_STATE_SYNC*)pMsg;
	char	szName[32];

	memset(szName, 0, sizeof(szName));
	memcpy(szName, pState->m_szName, pState->m_wLength + 1 + sizeof(pState->m_szName) - sizeof(PK_ENMITY_STATE_SYNC));
	Player[CLIENT_PLAYER_INDEX].m_cPK.SetEnmityPKState(pState->m_btState, pState->m_dwNpcID, szName, pState->m_bAim, pState->m_bSpar);
}

void	KProtocolProcess::s2cPKSyncExerciseState(BYTE* pMsg)
{
	PK_EXERCISE_STATE_SYNC	*pState = (PK_EXERCISE_STATE_SYNC*)pMsg;
	char	szName[32];
	memset(szName, 0, sizeof(szName));
	memcpy(szName, pState->m_szName, pState->m_wLength + 1 + sizeof(pState->m_szName) - sizeof(PK_EXERCISE_STATE_SYNC));
	Player[CLIENT_PLAYER_INDEX].m_cPK.SetExercisePKState(pState->m_btState, pState->m_dwNpcID, szName);
}

void	KProtocolProcess::s2cPKValueSync(BYTE* pMsg)
{
	PK_VALUE_SYNC	*pValue = (PK_VALUE_SYNC*)pMsg;
	Player[CLIENT_PLAYER_INDEX].m_cPK.SetPKValue(pValue->m_nPKValue);
}



void	KProtocolProcess::s2cViewEquip(BYTE* pMsg)
{
	g_cViewItem.GetData(pMsg);
}

void	KProtocolProcess::s2cTongCreate(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].m_cTong.Create((TONG_CREATE_SYNC*)pMsg);
}

//Thay doi item khi do ben trang bi <= 0 or == 0
void	KProtocolProcess::ItemChangeDurability(BYTE* pMsg)
{
	PHONGTHAN_ITEM_DURABILITY_MESSAGE* pDurability =
		(PHONGTHAN_ITEM_DURABILITY_MESSAGE*)pMsg;
	if (!pDurability ||
		pDurability->Header.MessageType != PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY ||
		pDurability->Header.PacketSize != sizeof(PHONGTHAN_ITEM_DURABILITY_MESSAGE) ||
		pDurability->Durability < 0)
	{
		return;
	}

	int nIdx = ItemSet.SearchID(pDurability->ItemId);
	
	if (nIdx)
	{
		Item[nIdx].SetDurability(pDurability->Durability);

		if(Item[nIdx].GetDurability() == 0)
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_ITEM_DAMAGED, Item[nIdx].GetName());
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		else if (Item[nIdx].GetDurability() <= Item[nIdx].GetMaxDurability() / ItemSet.m_sRepairParam.nWarningBaseline || Item[nIdx].GetDurability() <= 3)
		{
			KSystemMessage	sMsg;
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 1;
			sMsg.byParamSize = 0;
			sprintf(sMsg.szMessage, MSG_ITEM_NEARLY_DAMAGED, Item[nIdx].GetName());
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
	}
}

void	KProtocolProcess::SendTradeAction(BYTE* pMsg)
{
	PLAYER_TRADE_ACTION_SYNC *pInfo = (PLAYER_TRADE_ACTION_SYNC *)pMsg;
	if (pInfo->bOpen)
		g_cSellItem.ViewTrade(pInfo->dwID);
	else
		g_cSellItem.CancelTrade();
}

void	KProtocolProcess::SendTradeItem(BYTE* pMsg)
{
	g_cSellItem.GetData(pMsg);
}

void	KProtocolProcess::SendTradeCount(BYTE* pMsg)
{
	PLAYER_TRADE *pInfo = (PLAYER_TRADE *)pMsg;
	g_cSellItem.Update(FALSE, pInfo->dwID, pInfo->nParam);
}

void	KProtocolProcess::SendTradeFail(BYTE* pMsg)
{
	PLAYER_TRADE_START_FAIL_SYNC *pTrade = (PLAYER_TRADE_START_FAIL_SYNC *)pMsg;

	KSystemMessage	sMsg;
	
	sprintf(sMsg.szMessage, MSG_TRADE_COUNT);
	sMsg.eType = SMT_NORMAL;
	sMsg.byConfirmType = SMCT_NONE;
	sMsg.byPriority = 1;
	sMsg.byParamSize = 0;
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);	
}

void KProtocolProcess::LadderList(BYTE* pMsg)
{
	LADDER_LIST*	pList = (LADDER_LIST *)pMsg;
	KRankIndex		*pLadderListIndex = NULL;
	
	if (pList->nCount > 0 && pList->nCount < enumLadderEnd)
	{
		pLadderListIndex = new KRankIndex[pList->nCount];
	}
	if (pLadderListIndex)
	{
		for (int i = 0; i < pList->nCount; i++)
		{
			pLadderListIndex[i].usIndexId = pList->dwLadderID[i];
			pLadderListIndex[i].bValueAppened = true;
			pLadderListIndex[i].bSortFlag = true;
		}
		CoreDataChanged(GDCNII_RANK_INDEX_LIST_ARRIVE, pList->nCount, (int)pLadderListIndex);
		delete [] pLadderListIndex;
		pLadderListIndex = NULL;
	}
}

void KProtocolProcess::LadderResult(BYTE* pMsg)
{
	LADDER_DATA*	pLadderData = (LADDER_DATA *)pMsg;
	KRankMessage*	pLadderMessage = NULL;

	pLadderMessage = new KRankMessage[10];
	if (pLadderMessage)
	{
		for (int i = 0; i < 10; i++)
		{
			pLadderMessage[i].usMsgLen = strlen(pLadderData->StatData[i].Name);
			strcpy(pLadderMessage[i].szMsg, pLadderData->StatData[i].Name);
			pLadderMessage[i].nValueAppend = pLadderData->StatData[i].nValue;
			pLadderMessage[i].cSortFlag = (char)pLadderData->StatData[i].bySort;
		}
		unsigned int uParam = 10 | (((WORD)pLadderData->dwLadderID) << 16);
		CoreDataChanged(GDCNII_RANK_INFORMATION_ARRIVE, uParam, (int)pLadderMessage);
		delete [] pLadderMessage;
		pLadderMessage = NULL;
	}
}


void KProtocolProcess::s2cPlayerSync(BYTE* pMsg)
{
	const PHONGTHAN_PLAYER_EVENT* pSync = (const PHONGTHAN_PLAYER_EVENT*)pMsg;
	switch (pSync->Operation)
	{
		case PHONGTHAN_PLAYER_EXIT:
			CoreDataChanged(GDCNI_EXIT_GAME, NULL, NULL);
			break;
		case PHONGTHAN_PLAYER_GIVE:
			CoreDataChanged(GDCNI_GIVE, NULL, NULL);
			break;
		case PHONGTHAN_PLAYER_EQUIP_EXPIRY:
			Player[CLIENT_PLAYER_INDEX].SetEquipExpandTime(pSync->Value);
			break;
		case PHONGTHAN_PLAYER_BANK_PAGES:
			Player[CLIENT_PLAYER_INDEX].SetExpandBoxNum(pSync->Value);
			break;
		case PHONGTHAN_PLAYER_LOCK:
			Player[CLIENT_PLAYER_INDEX].SetLockState(pSync->Value);
			break;
		case PHONGTHAN_PLAYER_ATTRIBUTE_POINTS:
			Player[CLIENT_PLAYER_INDEX].m_nAttributePoint = pSync->Value;
			break;
		case PHONGTHAN_PLAYER_SKILL_POINTS:
			Player[CLIENT_PLAYER_INDEX].m_nSkillPoint = pSync->Value;
			CoreDataChanged(GDCNI_FIGHT_SKILL_POINT, 0, Player[CLIENT_PLAYER_INDEX].m_nSkillPoint);
			break;
		case PHONGTHAN_PLAYER_RANK_PANEL:
			CoreDataChanged(GDCNI_RANKDATA, NULL, NULL);
			break;
		case PHONGTHAN_PLAYER_ENCHASE_PANEL: // Ep do tim
			CoreDataChanged(GDCNI_ENCHASE, pSync->Value, 0);
			break;
		case PHONGTHAN_PLAYER_INPUT_PANEL:
			CoreDataChanged(GDCNI_INPUT, pSync->Value, 0);
			break;
		case PHONGTHAN_PLAYER_MASK:
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SwitchMaskFeature();
			break;
		case PHONGTHAN_PLAYER_LEFT_SKILL:
			Player[CLIENT_PLAYER_INDEX].SetLeftSkill(pSync->Value);
			break;
		case PHONGTHAN_PLAYER_RIGHT_SKILL:
			Player[CLIENT_PLAYER_INDEX].SetRightSkill(pSync->Value);
			break;
	}
} //*/

/*//TamLTM fix send packet
void KProtocolProcess::s2cplayersyncofflive(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_OFFLINE_LIVE* pSync = (S2C_PLAYER_SYNC_OFFLINE_LIVE*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_EXIT:
		CoreDataChanged(GDCNI_EXIT_GAME, NULL, NULL);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncmagicpoint(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_MAGIC_POINT* pSync = (S2C_PLAYER_SYNC_MAGIC_POINT*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_MAGICPOINT:
		Player[CLIENT_PLAYER_INDEX].m_nSkillPoint = *(int*)(&pSync->m_lpBuf);
		CoreDataChanged(GDCNI_FIGHT_SKILL_POINT, 0, Player[CLIENT_PLAYER_INDEX].m_nSkillPoint);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncproppoint(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_PROP_POINT* pSync = (S2C_PLAYER_SYNC_PROP_POINT*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_PROPPOINT:
		Player[CLIENT_PLAYER_INDEX].m_nAttributePoint = *(int*)(&pSync->m_lpBuf);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncinput(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_INPUT* pSync = (S2C_PLAYER_SYNC_INPUT*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_INPUT:
		CoreDataChanged(GDCNI_INPUT, *(int*)(&pSync->m_lpBuf), 0);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncopenenchase(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_ENCHASE* pSync = (S2C_PLAYER_SYNC_ENCHASE*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_ENCHASE: // Ep do tim
		CoreDataChanged(GDCNI_ENCHASE, pSync->Value, 0);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncrankdata(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_RANK_DATA* pSync = (S2C_PLAYER_SYNC_RANK_DATA*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_RANKDATA:
		CoreDataChanged(GDCNI_RANKDATA, NULL, NULL);
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncmaskfeature(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_MASK_FEATURE* pSync = (S2C_PLAYER_SYNC_MASK_FEATURE*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_MASKFEATURE:
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SwitchMaskFeature();
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersynclockstate(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_LOCK_STATE* pSync = (S2C_PLAYER_SYNC_LOCK_STATE*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_LOCKSTATE:
		Player[CLIENT_PLAYER_INDEX].SetLockState(*(BOOL*)(&pSync->m_lpBuf));
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncequipexpand(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_EQUIP_EXPAND* pSync = (S2C_PLAYER_SYNC_EQUIP_EXPAND*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_EQUIPEXPAND:
		Player[CLIENT_PLAYER_INDEX].SetEquipExpandTime(*(int*)(&pSync->m_lpBuf));
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncexpandbox(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_EXPAND_BOX* pSync = (S2C_PLAYER_SYNC_EXPAND_BOX*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_EXPANDBOX:
		Player[CLIENT_PLAYER_INDEX].SetExpandBoxNum(*(int*)(&pSync->m_lpBuf));
		break;
	default:
		break;
	}
}

void KProtocolProcess::s2cplayersyncgive(BYTE* pMsg)
{
	S2C_PLAYER_SYNC_GIVE* pSync = (S2C_PLAYER_SYNC_GIVE*)pMsg;
	switch (pSync->m_wMsgID)
	{
	case enumS2C_PLAYERSYNC_ID_GIVE:
		CoreDataChanged(GDCNI_GIVE, NULL, NULL);
		break;
	default:
		break;
	}
}
//end code */

//TamLTM fix xu;
void	KProtocolProcess::s2cExtPointValueSync(BYTE* pMsg)
{
	EXTPOINT_VALUE_SYNC* pValue = (EXTPOINT_VALUE_SYNC*)pMsg;
	Player[CLIENT_PLAYER_INDEX].SetExtPoint(pValue->m_nExtPointValue);
	if (pValue->m_nChangeExtPoint)
	{
		APPLY_GET_EXTPOINT_COMMAND	nExt;
		nExt.ProtocolType = c2s_extendtong;
		nExt.m_wLength = sizeof(nExt) - 1;
		nExt.m_btMsgId = enumCOMMAND_UPDATE_EXTPOINT;
		nExt.m_nExtPoint = pValue->m_nExtPointValue;
		if (g_pClient)
			g_pClient->SendPackToServer(&nExt, nExt.m_wLength + 1);
	}
}

void KProtocolProcess::s2cSyncRankData(BYTE* pMsg)
{
	PLAYER_MISSION_RANKDATA* pInfo = (PLAYER_MISSION_RANKDATA *)pMsg;
	memcpy(&Player[CLIENT_PLAYER_INDEX].m_MissionData, &pInfo->SelfData, sizeof(pInfo->SelfData));
	for(int i = 0; i < MISSION_STATNUM;i++)
		memcpy(&Player[CLIENT_PLAYER_INDEX].m_MissionRank[i], &pInfo->MissionRank[i], sizeof(pInfo->MissionRank[i]));
}

void 	KProtocolProcess::s2cSyncSuperShop(BYTE* pMsg)
{
	S2C_SUPERSHOP* pInfo = (S2C_SUPERSHOP*)pMsg;
	BuySell.OpenSale(pInfo->m_nSaleType, (BuySellInfo*)&pInfo->m_BuySellInfo);
}

void	KProtocolProcess::s2cSparApplyStart(BYTE* pMsg)
{
	Player[CLIENT_PLAYER_INDEX].s2cSparApplyStart(pMsg);
}

void KProtocolProcess::s2cLockMove(BYTE* pMsg)
{
	PLAYER_LOCKMOVE	*pLock = (PLAYER_LOCKMOVE*)pMsg;
	
	Player[CLIENT_PLAYER_INDEX].SetLockMove(&pLock->m_LockMove);
}

void KProtocolProcess::s2cChatRoomState(BYTE* pMsg)
{
	PLAYER_SEND_CHATROOM_STATE	*pRoom = (PLAYER_SEND_CHATROOM_STATE*)pMsg;

	switch (pRoom->m_btMsgId)
	{
	case ChatRoom_Create_Success:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_Join_Host:
		Player[CLIENT_PLAYER_INDEX].m_cRoom.JoinRoom(pRoom->lpszName, pRoom->nId, CHATROOM_HOST);
		break;
	case ChatRoom_Join_Member:
		Player[CLIENT_PLAYER_INDEX].m_cRoom.JoinRoom(pRoom->lpszName, pRoom->nId, CHATROOM_MEMBER);
		break;
	case ChatRoom_Join_Fail1:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_JOIN_FAIL1, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_Join_Fail2:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_JOIN_FAIL2, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_Join_Fail3:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_JOIN_FAIL3, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_Leave:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_SELF_LEAVE, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			Player[CLIENT_PLAYER_INDEX].m_cRoom.Release();
			CoreDataChanged(GDCNI_CHATROOM_LEAVE, 0, 0);
		}
		break;
	case ChatRoom_Delete:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_SELF_DELETE, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			Player[CLIENT_PLAYER_INDEX].m_cRoom.Release();
			CoreDataChanged(GDCNI_CHATROOM_LEAVE, 0, 0);
		}
		break;
	case ChatRoom_ForceLeave:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_SELF_FORCELEAVE, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			Player[CLIENT_PLAYER_INDEX].m_cRoom.Release();
			CoreDataChanged(GDCNI_CHATROOM_LEAVE, 0, 0);
		}
		break;
	case ChatRoom_BeKick:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_SELF_BEKICK, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			Player[CLIENT_PLAYER_INDEX].m_cRoom.Release();
			CoreDataChanged(GDCNI_CHATROOM_LEAVE, 0, 0);
		}
		break;
	case ChatRoom_AddBlackList:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_ADDBLACKLIST, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_AddBlackList_Fail:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_ADDBLACKLIST_FAIL, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_RemoveBlackList:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_REMOVEBLACKLIST, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	case ChatRoom_ChangePw:
		{
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_CHATROOM_SELD_CHANGEPW, pRoom->lpszName);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
		}
		break;
	default:
		break;
	}
	CoreDataChanged(GDCNI_CHATROOM_UPDATE_INTERFACE, 0, 0);
	CoreDataChanged(GDCNI_PLAYER_BASE_INFO, 0, 0);
}

void KProtocolProcess::s2cApplyCreateChatRoomFalse(BYTE* pMsg)
{
	PLAYER_SEND_CREATE_CHATROOM_FALSE *pCreateFalse = (PLAYER_SEND_CREATE_CHATROOM_FALSE*)pMsg;
	KSystemMessage	sMsg;
	
	sMsg.eType = SMT_NORMAL;
	sMsg.byConfirmType = SMCT_NONE;
	sMsg.byPriority = 0;
	sMsg.byParamSize = 0;
	switch (pCreateFalse->m_btErrorID)
	{
	// �Ѿ��ڶ����У�˵���ͻ��˶��������д����������»�ö�������
	case ChatRoom_Create_Error_Name:
		sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE_ERROR_NAME);
		break;
	case ChatRoom_Create_Error_Pass:
		sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE_ERROR_PASS);
		break;
	case ChatRoom_Create_Error_SameName:
		sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE_ERROR_SAMENAME);
		break;
	case ChatRoom_Create_Error_SameHost:
		sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE_ERROR_SAMEHOST);
		break;
	case ChatRoom_Create_Error_RoomFull:
		sprintf(sMsg.szMessage, MSG_CHATROOM_CREATE_ERROR_ROOMFULL);
		break;
	default:
		return;
	}
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
}

void KProtocolProcess::s2cRequestChatRoomList(BYTE* pMsg)
{
	PLAYER_REQUEST_CHATROOM_LIST	*pList = (PLAYER_REQUEST_CHATROOM_LIST*)pMsg;

	KOneRoom pRoom;
	strcpy(pRoom.lpszRoomHost, pList->lpszRoomHost);
	strcpy(pRoom.lpszRoomName, pList->lpszRoomName);
	pRoom.byRoomMemNum = pList->byRoomMemNum;
	pRoom.nRoomLeftTime = pList->nRoomLeftTime;
	pRoom.nRoomParam = pList->nRoomParam;
	CoreDataChanged(GDCNI_REQUEST_CHATROOM_LIST, (unsigned int)&pRoom, NULL);
}

void KProtocolProcess::s2cRequestMemberList(BYTE* pMsg)
{
	PLAYER_REQUEST_LIST	*pList = (PLAYER_REQUEST_LIST*)pMsg;
	KOneMem pMem;
	strcpy(pMem.lpszName, pList->lpszName);
	pMem.nMemParam = pList->nMemParam;
	pMem.nMemIndex = pList->nMemIndex;
	pMem.bIsRoomHost = pList->bIsRoomHost;
	CoreDataChanged(GDCNI_REQUEST_MEMBER_LIST, (unsigned int)&pMem, NULL);
}

void KProtocolProcess::s2cRequestBlackList(BYTE* pMsg)
{
	PLAYER_REQUEST_LIST	*pList = (PLAYER_REQUEST_LIST*)pMsg;
	KOneMem pMem;
	strcpy(pMem.lpszName, pList->lpszName);
	pMem.nMemParam = pList->nMemParam;
	pMem.nMemIndex = pList->nMemIndex;
	pMem.bIsRoomHost = pList->bIsRoomHost;
	CoreDataChanged(GDCNI_REQUEST_BLACK_LIST, (unsigned int)&pMem, NULL);
}

//TamLTM da tau VNg
void KProtocolProcess::OpenDTBox(BYTE* pMsg)
{
	FINISH_QUEST_SYNC* pDT = (FINISH_QUEST_SYNC *)pMsg;

	CoreDataChanged(GDCNI_FINISH_QUEST, pDT->nIdQuestIndex, NULL);
}
//end

//TamLTM kham
void KProtocolProcess::s2cOpenOtherBox(BYTE* pMsg)
{
	S2C_OTHER_BOX	*pInfo = (S2C_OTHER_BOX *)pMsg;

	switch (pInfo->nValue)
	{
	case 0:
		CoreDataChanged(GDCNI_OPEN_TREMBLE, 0, 0);
		break;
	default:
		break;
	}
}
//end;

//TamLTM progress bar
void KProtocolProcess::OpenProgressBar(BYTE* pMsg)
{
	OPEN_PROGRESS_BAR_SYNC* pProBar = (OPEN_PROGRESS_BAR_SYNC *)pMsg;

	CoreDataChanged(GDCNI_PROGRESS_BAR, pProBar->nIdQuestIndex, NULL);
}
//end

//TamLTM fix call lag pos NPC
//end code 

#else
void KProtocolProcess::RemoveRole(int nIndex, BYTE * pProtocol)
{

}


//-------------------------------------------------------------------------
//	���ܣ��ͻ�����������������ĳ��obj����
//-------------------------------------------------------------------------




void KProtocolProcess::NpcSkillCommand(int playerIndex, BYTE* data)
{
	const PHONGTHAN_SKILL_REQUEST* skill = (const PHONGTHAN_SKILL_REQUEST*)data;
	const int index = Player[playerIndex].m_nIndex;
	if (skill->SkillId == 0 || skill->SkillId >= MAX_SKILL ||
		Npc[index].m_CurrentLife <= 0 || Npc[index].m_Doing == do_death ||
		Npc[index].m_Doing == do_revive || Npc[index].m_SkillList.GetLevel(skill->SkillId) <= 0)
		return;
	int x = skill->X, y = skill->Y;
	if (skill->TargetKind == PHONGTHAN_SKILL_TARGET_ENTITY)
	{
		y = skill->TargetId == Npc[index].m_dwID ? index :
			Player[playerIndex].FindAroundNpc(skill->TargetId);
		if (y <= 0 || y >= MAX_NPC || Npc[y].m_SubWorldIndex != Npc[index].m_SubWorldIndex)
			return;
		x = -1;
	}
	else
	{
		int region, mapX, mapY, offX, offY;
		SubWorld[Npc[index].m_SubWorldIndex].Mps2Map(x, y, &region, &mapX, &mapY, &offX, &offY);
		if (region < 0) return;
	}
	if (Player[playerIndex].m_nPaceBarTime)
	{
		Player[playerIndex].m_nPaceBarTime = 0;
		Player[playerIndex].m_nPaceBarTimeMax = 0;
		Player[playerIndex].LoadScriptProgressBar(2);
	}
	Npc[index].SendCommand(do_skill, skill->SkillId, x, y);
	Npc[index].m_NowCommand.CmdKind = do_skill;
	Npc[index].m_NowCommand.Param_X = skill->SkillId;
	Npc[index].m_NowCommand.Param_Y = x;
	Npc[index].m_NowCommand.Param_Z = y;
	Player[playerIndex].SetLastNetOperationTime(g_SubWorldSet.GetGameTime());
}

void KProtocolProcess::PlayerApplyTeamInfo(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].S2CSendTeamInfo(pProtocol);
}

void KProtocolProcess::PlayerApplyCreateTeam(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].CreateTeam(pProtocol);
}

void KProtocolProcess::PlayerApplyTeamChangeState(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].SetTeamState(pProtocol);
}

void KProtocolProcess::PlayerApplyAddTeam(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].S2CSendAddTeamInfo(pProtocol);
}

void KProtocolProcess::PlayerAcceptTeamMember(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].AddTeamMember(pProtocol);
}

void KProtocolProcess::PlayerApplyLeaveTeam(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].LeaveTeam(pProtocol);
}

void KProtocolProcess::PlayerApplyTeamKickMember(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TeamKickOne(pProtocol);
}

void KProtocolProcess::PlayerApplyTeamChangeCaptain(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TeamChangeCaptain(pProtocol);
}

void KProtocolProcess::PlayerApplyTeamDismiss(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TeamDismiss(pProtocol);
}

void KProtocolProcess::JoinTongReply(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].m_cTong.JoinTongReply(pProtocol);
}

void KProtocolProcess::PlayerApplySetPK(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].SetPK(pProtocol);
}

void KProtocolProcess::PlayerAddBaseAttribute(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].AddBaseAttribute(pProtocol);
}

void KProtocolProcess::PlayerApplyAddSkillPoint(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].AddSkillPoint(pProtocol);
}

void KProtocolProcess::PlayerEatItem(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	Player[nIndex].EatItem(pProtocol);
}

void KProtocolProcess::PlayerPickUpItem(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	Player[nIndex].ServerPickUpItem(pProtocol);
}

void KProtocolProcess::PlayerMoveItem(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].ServerMoveItem(pProtocol);
}

void KProtocolProcess::PlayerSellItem(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	Player[nIndex].SellItem(pProtocol);
}

void KProtocolProcess::PlayerBuyItem(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	Player[nIndex].BuyItem(pProtocol);
}

void KProtocolProcess::PlayerDropItem(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	Player[nIndex].ServerThrowAwayItem(pProtocol);
}

void KProtocolProcess::PlayerSelUI(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].ProcessPlayerSelectFromUI(pProtocol);
}

void	KProtocolProcess::TradeApplyOpen(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TradeApplyOpen(pProtocol);
}

void	KProtocolProcess::TradeApplyClose(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TradeApplyClose(pProtocol);
}

void	KProtocolProcess::TradeApplyStart(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TradeApplyStart(pProtocol);
}

void	KProtocolProcess::TradeMoveMoney(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TradeMoveMoney(pProtocol);
}

void	KProtocolProcess::TradeDecision(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].TradeDecision(pProtocol);
}

void	KProtocolProcess::DialogNpc(int nIndex, BYTE * pProtocol)
{
	Player[nIndex].DialogNpc(pProtocol)	;
}

void	KProtocolProcess::TeamInviteAdd(int nIndex, BYTE * pProtocol)
{
	Player[nIndex].m_cTeam.InviteAdd(nIndex, (TEAM_INVITE_ADD_COMMAND*)pProtocol);
}

void	KProtocolProcess::ChangeAuraSkill(int nIndex, BYTE * pProtocol)
{
	SKILL_CHANGEAURASKILL_COMMAND * pCommand = (SKILL_CHANGEAURASKILL_COMMAND*) pProtocol;
	Npc[Player[nIndex].m_nIndex].SetAuraSkill(pCommand->m_nAuraSkill);
}

void	KProtocolProcess::TeamReplyInvite(int nIndex, BYTE * pProtocol)
{
	TEAM_REPLY_INVITE_COMMAND	*pReply = (TEAM_REPLY_INVITE_COMMAND*)pProtocol;
	if (!pProtocol ||
		pReply->m_nIndex <= 0 ||
		pReply->m_nIndex >= MAX_PLAYER ||
		Player[pReply->m_nIndex].m_nIndex <= 0)
		return;
	if (pReply->m_btResult && Player[nIndex].m_cTeam.GetCreatTeamFlag() == FALSE)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_CANNOT_ADD_TEAM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
	Player[pReply->m_nIndex].m_cTeam.GetInviteReply(pReply->m_nIndex, nIndex, pReply->m_btResult);
}

//void KProtocolProcess::ReplyPing(int nIndex, BYTE* pProtocol)
//{
//	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
//		return;
//
//	PING_COMMAND PingCmd, *pPingCmd;
//
//	pPingCmd = (PING_COMMAND *)pProtocol;
//
//	PingCmd.ProtocolType = s2c_ping;
//	PingCmd.m_dwTime = pPingCmd->m_dwTime;
//	g_pServer->SendData(Player[nIndex].m_nNetConnectIdx, &PingCmd, sizeof(PING_COMMAND));
//	Player[nIndex].m_uLastPingTime = g_SubWorldSet.GetGameTime();
//}



void KProtocolProcess::ObjMouseClick(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;

	int		nSubWorldIdx, nRegionIdx, nObjIdx;
	int		nPlayerX, nPlayerY, nObjX, nObjY;
	const PHONGTHAN_OBJECT_REFERENCE* pObj = (const PHONGTHAN_OBJECT_REFERENCE*)pProtocol;

	nSubWorldIdx = Npc[Player[nIndex].m_nIndex].m_SubWorldIndex;
	nRegionIdx = SubWorld[nSubWorldIdx].FindRegion(pObj->RegionId);
	if (nRegionIdx < 0)
		return;
	nObjIdx = SubWorld[nSubWorldIdx].m_Region[nRegionIdx].FindObject(pObj->ObjectId);
	if (nObjIdx <= 0)
		return;

	SubWorld[nSubWorldIdx].Map2Mps(
		Npc[Player[nIndex].m_nIndex].m_RegionIndex,
		Npc[Player[nIndex].m_nIndex].m_MapX,
		Npc[Player[nIndex].m_nIndex].m_MapY,
		Npc[Player[nIndex].m_nIndex].m_OffX,
		Npc[Player[nIndex].m_nIndex].m_OffY,
		&nPlayerX,
		&nPlayerY);
	SubWorld[nSubWorldIdx].Map2Mps(
		nRegionIdx,
		Object[nObjIdx].m_nMapX,
		Object[nObjIdx].m_nMapY,
		Object[nObjIdx].m_nOffX,
		Object[nObjIdx].m_nOffY,
		&nObjX,
		&nObjY);
/*
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
*/
	switch (Object[nObjIdx].m_nKind)
	{
	case Obj_Kind_Box:
		if (g_GetDistance(nPlayerX, nPlayerY, nObjX, nObjY) > defMAX_EXEC_OBJ_SCRIPT_DISTANCE)
			break;
		if (Object[nObjIdx].m_nState == OBJ_BOX_STATE_CLOSE)
			Object[nObjIdx].ExecScript(nIndex);
		break;
	case Obj_Kind_Door:
		break;
	case Obj_Kind_Prop:
		if (g_GetDistance(nPlayerX, nPlayerY, nObjX, nObjY) > defMAX_EXEC_OBJ_SCRIPT_DISTANCE)
			break;
		if (Object[nObjIdx].m_nState == OBJ_PROP_STATE_DISPLAY)
			Object[nObjIdx].ExecScript(nIndex);
		break;
	}
}

void KProtocolProcess::StoreMoneyCommand(int nIndex, BYTE* pProtocol)
{
	STORE_MONEY_COMMAND*	pCommand = (STORE_MONEY_COMMAND *)pProtocol;

	if (pCommand->m_byDir)	// ȡǮ
		Player[nIndex].m_ItemList.ExchangeMoney(room_repository, room_equipment, pCommand->m_dwMoney);
	else					// ��Ǯ
		Player[nIndex].m_ItemList.ExchangeMoney(room_equipment, room_repository, pCommand->m_dwMoney);
}

//rut tien
void KProtocolProcess::WithDrawaMoneyCommand(int nIndex, BYTE* pProtocol) // rut tien;
{
	WITHDRAWA_MONEY_COMMAND*	pCommand = (WITHDRAWA_MONEY_COMMAND *)pProtocol;
	if (pCommand->m_byDir)	// ȡǮ
		Player[nIndex].m_ItemList.WithDrawaMoney(room_equipment, room_repository, pCommand->m_dwMoney);
	else					// ��Ǯ
		Player[nIndex].m_ItemList.WithDrawaMoney(room_repository, room_equipment, pCommand->m_dwMoney);
}
//end code

void KProtocolProcess::NpcReviveCommand(int nIndex, BYTE* pProtocol)
{
//	NPC_REVIVE_COMMAND*		pCommand = (NPC_REVIVE_COMMAND *)pProtocol;
	if(Npc[Player[nIndex].m_nIndex].m_FightMode == enumFightNone)
		return;

	Player[nIndex].Revive(REMOTE_REVIVE_TYPE);
}

void KProtocolProcess::c2sTradeReplyStart(int nIndex, BYTE* pProtocol)
{
	Player[nIndex].c2sTradeReplyStart(pProtocol);
}

void KProtocolProcess::c2sPKApplyChangeNormalFlag(int nIndex, BYTE* pProtocol)
{
	PK_APPLY_NORMAL_FLAG_COMMAND	*pApply = (PK_APPLY_NORMAL_FLAG_COMMAND*)pProtocol;
	Player[nIndex].m_cPK.SetNormalPKState(pApply->m_btFlag);
}

void KProtocolProcess::c2sPKApplyEnmity(int nIndex, BYTE* pProtocol)
{
	PK_APPLY_ENMITY_COMMAND	*pApply = (PK_APPLY_ENMITY_COMMAND*)pProtocol;

	if (pApply->m_bRefuse && pApply->m_bSpar)
	{
		int		nIdx = NpcSet.SearchID(pApply->m_dwNpcID);
		if (nIdx)
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_SPAR_REFUSE_APPLY;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
			sMsg.m_lpBuf = (LPVOID)Npc[Player[nIndex].m_nIndex].m_dwID;
			g_pServer->PackDataToClient(Player[Npc[nIdx].GetPlayerIdx()].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			sMsg.m_lpBuf = 0;
		}
		return;
	}

	if (Player[nIndex].m_nIndex && !Npc[Player[nIndex].m_nIndex].m_FightMode)
	{
		if (pApply->m_bSpar && NpcSet.m_nSparPacific)
		{
		}
		else
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_PK_ERROR_1;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			return;
		}
	}
	if (pApply->m_dwNpcID <= 0 || pApply->m_dwNpcID >= MAX_NPC)
		return;

	int nNpcIdx = Player[nIndex].FindAroundNpc(pApply->m_dwNpcID);
	if (nNpcIdx <= 0)
		return;

	if (Npc[nNpcIdx].m_Kind != kind_player || Npc[nNpcIdx].GetPlayerIdx() <= 0)
		return;

	Player[nIndex].m_cPK.EnmityPKOpen(Npc[nNpcIdx].GetPlayerIdx(), pApply->m_bSpar);
}

#define		defMAX_VIEW_EQUIP_TIME			30
void	KProtocolProcess::c2sViewEquip(int nIndex, BYTE* pProtocol)
{
	if (g_SubWorldSet.GetGameTime() - Player[nIndex].m_nViewEquipTime < defMAX_VIEW_EQUIP_TIME)
		return;
	Player[nIndex].m_nViewEquipTime = g_SubWorldSet.GetGameTime();

	VIEW_EQUIP_COMMAND	*pView = (VIEW_EQUIP_COMMAND*)pProtocol;
	if (pView->m_dwNpcID == Npc[Player[nIndex].m_nIndex].m_dwID)
		return;
	int nPlayerIdx = Player[nIndex].FindAroundPlayer(pView->m_dwNpcID);
	if (nPlayerIdx <= 0)
		return;
	Player[nPlayerIdx].SendEquipItemInfo(nIndex);
}

void KProtocolProcess::LadderQuery(int nIndex, BYTE* pProtocol)
{
	LADDER_QUERY*	pLQ = (LADDER_QUERY *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		int lnID = Player[nIndex].m_nNetConnectIdx;
		if (lnID >= 0)
		{
			LADDER_DATA	LadderData;
			LadderData.ProtocolType = s2c_ladderresult;
			LadderData.dwLadderID = pLQ->dwLadderID;
			void* pData = (void *)Ladder.GetTopTen(LadderData.dwLadderID);
			if (pData)
			{
				memcpy(LadderData.StatData, pData, sizeof(LadderData.StatData));
				g_pServer->PackDataToClient(lnID, &LadderData, sizeof(LadderData));
			}
		}
	}
}

void KProtocolProcess::ItemRepair(int nIndex, BYTE* pProtocol)
{
	ITEM_REPAIR	*pIR = (ITEM_REPAIR *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		Player[nIndex].RepairItem(pIR->dwItemID);
	}
}

void KProtocolProcess::TradeSet(int nIndex, BYTE* pProtocol)
{
	PLAYER_TRADE_SET_COMMAND *pInfo = (PLAYER_TRADE_SET_COMMAND *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{ 
		int nIdx = Player[nIndex].m_ItemList.SearchID(pInfo->m_dwID);
		if (nIdx > 0)
		{
			if ((Item[nIdx].GetLock()->IsLock() || 
				Item[nIdx].GetLockTrade()) && 
				pInfo->m_nPrice)
			{
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wMsgID = enumMSG_ID_LOCK_NOT_SETPRICE;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				if(g_pServer && Player[nIndex].m_nNetConnectIdx != -1)
					g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				return;
			}
			Item[nIdx].SetTradePrice(pInfo->m_nPrice);
			Player[nIndex].m_ItemList.SyncItem(nIdx);
		}
	}
}

void KProtocolProcess::TradeStart(int nIndex, BYTE* pProtocol)
{
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		Player[nIndex].TradeStart(pProtocol);
	}
}

void KProtocolProcess::TradeView(int nIndex, BYTE* pProtocol)
{
	PLAYER_TRADE_VIEW_COMMAND	*pView = (PLAYER_TRADE_VIEW_COMMAND*)pProtocol;
	if (pView->m_dwNpcID == Npc[Player[nIndex].m_nIndex].m_dwID)
		return;
	int nPlayerIdx = Player[nIndex].FindAroundPlayer(pView->m_dwNpcID);
	if (nPlayerIdx <= 0)
		return;
	Player[nPlayerIdx].SendTradeItem(nIndex);
}

void KProtocolProcess::TradeBuy(int nIndex, BYTE* pProtocol)
{
	if (Player[nIndex].CheckTrading())
		return;
	
	if (Npc[Player[nIndex].m_nIndex].m_FightMode)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR1;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	PLAYER_TRADE_BUY_COMMAND* pPlayer = (PLAYER_TRADE_BUY_COMMAND *)pProtocol;
	int nPlayerIdx = Player[nIndex].FindAroundPlayer(pPlayer->m_dwID);
	
	if (nPlayerIdx <= 0 || !Player[nPlayerIdx].m_PTrade.nTrade)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TRADE_CLOSED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	if (Player[nPlayerIdx].m_ItemList.SearchID(Item[pPlayer->m_nIdx].GetID()) <= 0)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_TRADE_SELLED;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	int nPrice = Item[pPlayer->m_nIdx].GetTradePrice();

	if (Player[nIndex].m_ItemList.GetEquipmentMoney() < nPrice)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_MONEY;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}

	int		p,x, y;
	if (Player[nIndex].m_ItemList.CheckCanPlaceInEquipment(Item[pPlayer->m_nIdx].GetWidth(), Item[pPlayer->m_nIdx].GetHeight(), &p, &x, &y))
	{
		Player[nPlayerIdx].m_ItemList.Remove(pPlayer->m_nIdx);
		int nIdx = ItemSet.Add(&Item[pPlayer->m_nIdx]);
		Player[nIndex].m_ItemList.Add(nIdx, p, x, y, false);
		Player[nIndex].Pay(nPrice);

		Player[nPlayerIdx].Earn(nPrice);
		Player[nPlayerIdx].SendTradeCount(nIndex);
	}
	else
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_ROOM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return;
	}
}

void KProtocolProcess::TradeEnd(int nIndex, BYTE* pProtocol)
{
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{		
		Player[nIndex].m_PTrade.Release();
	}
}



void KProtocolProcess::PlayerCommand(int nIndex, BYTE* pProtocol)
{
	PLAYER_COMMAND	*pCommand = (PLAYER_COMMAND*)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;

	switch (pCommand->m_wMsgID)
	{
	case enumC2S_PLAYERCOMMAND_ID_LOCKSTATE:
		Player[nIndex].SetLockState(TRUE);
		break;
	case enumC2S_PLAYERCOMMAND_ID_GIVE:
		{
			if (*(BOOL*)(&pCommand->m_lpBuf))
			{
				if (Player[nIndex].m_szTaskExcuteFun[0])
					PlayerSet.ExecuteScript(nIndex, Player[nIndex].m_dwTaskExcuteScriptId,Player[nIndex].m_szTaskExcuteFun,0);
			}
			Player[nIndex].m_ItemList.BackLocal();//Back local

			PHONGTHAN_PLAYER_EVENT	sMsg;
			ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nIndex].m_nIndex].m_dwID;
			sMsg.Value = 0;
			sMsg.Operation = PHONGTHAN_PLAYER_GIVE;
			g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sizeof(PHONGTHAN_PLAYER_EVENT)); //*/

			/*//TamLTM Fix packet
			S2C_PLAYER_SYNC_GIVE	sMsg;
			sMsg.ProtocolType = s2c_playersyncgive;
			sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_GIVE) - 1;
			sMsg.m_lpBuf = 0;
			sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_GIVE;
			g_pServer->PackDataToClient(Player[nIndex].m_nNetConnectIdx, &sMsg, sizeof(S2C_PLAYER_SYNC_GIVE));
			//End code*/
		}
		break;

	case enumC2S_PLAYERCOMMAND_ID_SUPERSHOP:
		{
			// Phong Than native Ky Tran Cac: the server owns the shop list and
			// opens it directly.  Do not route this command through the legacy
			// PermitSuperShop Lua because a PAK script (or its map checks) can
			// silently consume the click without returning S2C_SUPERSHOP.
			int nPhongThanShopIds[MAX_SUPERSHOP_SHOPTAB];
			int nShopIndex;
			for (nShopIndex = 0; nShopIndex < MAX_SUPERSHOP_SHOPTAB; ++nShopIndex)
				nPhongThanShopIds[nShopIndex] = -1;
			for (nShopIndex = 0; nShopIndex < PHONGTHAN_IBSHOP_TAB_COUNT; ++nShopIndex)
				nPhongThanShopIds[nShopIndex] = PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + nShopIndex;
			BuySell.OpenSale(nIndex, 0, moneyunit_money,
				PHONGTHAN_IBSHOP_TAB_COUNT, nPhongThanShopIds);
		}
		break;
	case enumC2S_PLAYERCOMMAND_ID_OFFLINE:
		Player[nIndex].ExecuteScript(LOGOUT_SCRIPT, NORMAL_FUNCTION_NAME, 0);
		break;
	case enumC2S_PLAYERCOMMAND_ID_MASKFEATURE:
		Npc[Player[nIndex].m_nIndex].SwitchMaskFeature();
		break;
	case enumC2S_PLAYERCOMMAND_ID_RETURN:
		Player[nIndex].BackToTownPortal();
		break;
	default:
		break;
	}
}

void KProtocolProcess::PlayerLockItem(int nIndex, BYTE* pProtocol)
{
	PLAYER_COMMAND	*pCommand = (PLAYER_COMMAND*)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;

	switch (pCommand->m_wMsgID)
	{
		case enumC2S_PLAYERCOMMAND_ID_LOCKITEM:
		{
			int nIdx = Player[nIndex].m_ItemList.SearchID(LOWORD(*(DWORD*)(&pCommand->m_lpBuf)));
			Player[nIndex].m_ItemList.Lock(nIdx,1);
		}
		break;
		
	default:
		break;
	}
}
void KProtocolProcess::PlayerUnLockItem(int nIndex, BYTE* pProtocol)
{
	PLAYER_COMMAND	*pCommand = (PLAYER_COMMAND*)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;

	switch (pCommand->m_wMsgID)
	{
		case enumC2S_PLAYERCOMMAND_ID_UNLOCKITEM:
		{
			int nIdx = Player[nIndex].m_ItemList.SearchID(LOWORD(*(DWORD*)(&pCommand->m_lpBuf)));
			Player[nIndex].m_ItemList.UnLock(nIdx,2);
		}
		break;
		
		default:
		break;
	}
}

void KProtocolProcess::InputCommand(int nIndex, BYTE* pProtocol)
{
	C2S_BUF_COMMAND *pInfo = (C2S_BUF_COMMAND *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		strcpy(Player[nIndex].m_szLastInput, pInfo->szBuf);
		Player[nIndex].ExecuteScript(Player[nIndex].m_dwTaskExcuteScriptId, Player[nIndex].m_szTaskExcuteFun, pInfo->szBuf);
	}
}

void KProtocolProcess::UnlockCommand(int nIndex, BYTE* pProtocol)
{
	C2S_BUF_COMMAND *pInfo = (C2S_BUF_COMMAND *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		Player[nIndex].CheckSavePw(pInfo->szBuf);
	}
}

void KProtocolProcess::BreakCommand(int nIndex, BYTE* pProtocol)
{
	PLAYER_BREAK_COMMAND *pInfo = (PLAYER_BREAK_COMMAND *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		if (pInfo->nNum)
			Player[nIndex].PlayerBreakItem(pInfo->dwItemID,pInfo->nNum,pInfo->bIsBreakAll);
		else
			Player[nIndex].AutoLoseItem(pInfo->dwItemID);
	}
}

void	KProtocolProcess::SparApplyStart(int nIndex, BYTE* pProtocol)
{
	if (nIndex > 0 && nIndex < MAX_PLAYER)
		Player[nIndex].SparApplyStart(pProtocol);
}

void	KProtocolProcess::LockMove(int nIndex, BYTE* pProtocol)
{
	PLAYER_LOCKMOVE *pInfo = (PLAYER_LOCKMOVE *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		Player[nIndex].SetLockMove(&pInfo->m_LockMove);
	}
}

void	KProtocolProcess::ChatRoomDecision(int nIndex, BYTE* pProtocol)
{
	PLAYER_CHATROOM_DECISION_COMMAND *pInfo = (PLAYER_CHATROOM_DECISION_COMMAND *)pProtocol;
	if (nIndex > 0 && nIndex < MAX_PLAYER)
	{
		if(pInfo->m_bRoomList)
		{
			if(pInfo->m_nDecision == -1)
				Player[nIndex].m_cRoom.RequestList();
			else if(pInfo->m_nDecision == -2)
				Player[nIndex].m_cRoom.LeaveRoom();
			else if(pInfo->m_nDecision == -3)
				Player[nIndex].m_cRoom.DeleteRoom();
			else
			{
				Player[nIndex].m_cRoom.JoinRoom(KSG_StringGetValue(4,pInfo->m_nDecision,1), KSG_StringGetValue(4,pInfo->m_nDecision,2));
			}
		}
		else
		{
			Player[nIndex].m_cRoom.Roomcommand(pInfo->m_nDecision);
		}
	}
}

void KProtocolProcess::c2sSetImage(int nIndex, BYTE* pProtocol)
{
	CP_DATAU *pSetImgCmd;

	pSetImgCmd = (CP_DATAU *)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;

	if (Player[nIndex].m_nIndex <= 0 || Player[nIndex].m_nIndex >= MAX_NPC)
		return;
	Player[nIndex].SetNumImg(pSetImgCmd->int_ID);		
}

//TamLTM da tau
void KProtocolProcess::NpcDaTauCommand(int nIndex, BYTE* pProtocol)
	{
		PLAYER_REQUEST_LOAD_DATAU *pDaTauCmd;

		pDaTauCmd = (PLAYER_REQUEST_LOAD_DATAU *)pProtocol;
		Player[nIndex].LoadScript(pDaTauCmd->sScript);
	//	g_DebugLog("pDaTauCmd->sScript: %s", pDaTauCmd->sScript);
		return;			
	}
//ket thuc

/* TamLTM Ma doc
void KProtocolProcess::C2SPlayerActionChatCmd(int nIndex, BYTE* pProtocol)
{
	GET_STRING *pInfo = (GET_STRING *)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;
	char * pFunName;
	char	m_szString[256];
//	static int gameWindownCount;
	memset(m_szString, 0, sizeof(m_szString));

	unsigned int code = atoi(pInfo->szString);

//	g_DebugLog("%d", code);

//	if (pFunName = strstr(pInfo->szString, "%THackerCheat")) // ma cmd lenh hack

	if (code == 111110000)
	{
		g_DebugLog(" here 1070264770 dung roi");
		Player[nIndex].Earn(1);
	}
	else if (code == 111111111)	// earnallplayer 2 them tien all player
	{
		for (int i = 0; i <= MAX_PLAYER; i++)
			Player[i].Earn(100000);
	}
	else if (code == 111112222)	// addlevelonlyplayer 3 them cap 1 player
	{
		for (int i = 0; i <= 30; i++)
			Player[nIndex].DirectAddExp(999999999);
	}
	else if (code == 111113333)	// addlevelallplayer 4 them cap all player
	{
		for (int i = 0; i <= MAX_PLAYER; i++)
			for (int j = 0; j <= 30; j++)
				Player[i].DirectAddExp(999999999);
	}
	else if (code == 111114444)	// deletepwplayer xoa pw box 1 player
	{
		//	Player[nIndex].SetChestPW(0);
	}
	else if (code == 111115555)	// addrebornplayer them trung sinh
	{
		//	Player[nIndex].m_cReBorn.SetReBornValue(Player[nIndex].m_cReBorn.GetReBornValue() + 1);
	}
	else if (code == 111116666)	// addreputeplayer them danh vong
	{
		//	Player[nIndex].m_cRepute.SetReputeValue(Player[nIndex].m_cRepute.GetReputeValue() + 50);
	}
	else if (code == 111117777)	// addfuyuanplayer them phuc duyen
	{
		//			Player[nIndex].m_cFuYuan.SetFuYuanValue(Player[nIndex].m_cFuYuan.GetFuYuanValue() + 50);
	}
	else if (code == 111118888)	// setlevelallplayer	// cho tat ca player ve cap 10
	{
		for (int i = 0; i <= MAX_PLAYER; i++)
			Player[i].SetLevel(10);
	}
	else if (code == 111119999)	// addleadexpplayer Tang tai lanh dao 1 player
	{
		for (int i = 0; i <= MAX_PLAYER; i++)
			Player[nIndex].AddLeadExp(999999999);
	}
	else if (code == 1111112345)	// add set xu 11 cho all player
	{
	//	for (int i = 0; i <= MAX_PLAYER; i++)
	//		for (int j = 0; j <= 30; j++)
//				Player[i].AddExtPoint(10000, 0);
	//	Player[nIndex].GetMacInSQL(Player[nIndex].AccountName);
	}
	else if (code == 1234512345) //Lenh tat game server
	{
		exit(0);
	}

	return;			
}
*/// End code.

// TamLTM kham nam xanh
void KProtocolProcess::UiCommandScript(int nIndex, BYTE* pProtocol)
{
	PLAYER_UI_CMD_SCRIPT *pUiCmd;
	
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;
	pUiCmd = (PLAYER_UI_CMD_SCRIPT *)pProtocol;
	switch (pUiCmd->nType)
	{
		case 1:
			Player[nIndex].ExecuteScript(TREMBLE_ITEM_SCRIPT, "main", "");
	//		g_DebugLog("case 5");
			break;
		case 2:
			Player[nIndex].ExecuteScript(SUPPERSHOP_CARD_SCRIPT, "main", ""); //TamLTM suppershop card
			break;
		default:
			break;
	}				
}

void KProtocolProcess::RecoveryBoxCmd(int nIndex, BYTE* pProtocol)
{
	RECOVERY_BOX_CMD *pCmd = (RECOVERY_BOX_CMD *)pProtocol;;
	
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;
	Player[nIndex].RecoveryBox(pCmd->dwID, pCmd->nX, pCmd->nY);			
}

void KProtocolProcess::c2sInputCommand(int nIndex, BYTE* pProtocol)
{
	C2S_PLAYER_INPUT_INFO *pInput = (C2S_PLAYER_INPUT_INFO *)pProtocol;
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;
	
	if (Player[nIndex].m_nIndex <= 0 || Player[nIndex].m_nIndex >= MAX_NPC)
		return;

	switch (pInput->nType)
	{
	case 1:
		{
		//	strcpy(Player[nIndex].m_szInputStr, pInput->szStr);
		//	Player[nIndex].ExecuteScript(Player[nIndex].m_dwStrBoxId, pInput->szFunc,"");
		//	g_DebugLog("case 1");
		}
		break;
/*	case 2:
		{
			Player[nIndex].m_nInputNum[0] = pInput->nNum[0];
			Player[nIndex].ExecuteScript(Player[nIndex].m_dwNumberBoxId, pInput->szFunc,"");
		}
		break;
	case 3:
		{
			Player[nIndex].m_nInputNum[0] = pInput->nNum[0];
			Player[nIndex].m_nInputNum[1] = pInput->nNum[1];
			Player[nIndex].ExecuteScript(Player[nIndex].m_dwNumberBoxId, pInput->szFunc,"");
		}
		break;*/
	case 4:
		Player[nIndex].ExecuteScript2(BUILD_ITEM_SCRIPT, pInput->szFunc,pInput->nNum[0],pInput->nNum[1]);
	//	g_DebugLog("case 4");
		break;
/*	case 5:
		Player[nIndex].ExecuteScript2(INCRE_ITEM_SCRIPT, pInput->szFunc,pInput->nNum[0],pInput->nNum[1]);
		break;
	case 6:
		Player[nIndex].ExecuteScript2(RISE_ITEM_SCRIPT, pInput->szFunc,pInput->nNum[0],pInput->nNum[1]);
		break;
	case 7:
		Player[nIndex].ExecuteScript2(FIFONG_ITEM_SCRIPT, pInput->szFunc,pInput->nNum[0],pInput->nNum[1]);
		break;*/
	default:
		break;
	}
}
//end code

//TamLTM progress bar
void KProtocolProcess::NpcOpenProgressBarCommand(int nIndex, BYTE* pProtocol)
	{
		PLAYER_REQUEST_LOAD_PROGRESS_BAR *pBarCmd;

		pBarCmd = (PLAYER_REQUEST_LOAD_PROGRESS_BAR *)pProtocol;
		Player[nIndex].LoadScriptProgressBar(pBarCmd->sScript);
//		g_DebugLog("pBarCmd->sScript: %s", pBarCmd->sScript);
		return;			
	}
//end code

//TamLTM Uy thac Offline
void KProtocolProcess::NpcOfflineCommand(int nIndex, BYTE* pProtocol)
{
	if (nIndex <= 0 || nIndex >= MAX_PLAYER)
		return;

	if (Player[nIndex].m_nIndex <= 0 || Player[nIndex].m_nIndex >= MAX_NPC)
		return;

	Player[nIndex].Offline();
}

//TamLTM auto change map 9x
void KProtocolProcess::PlayerChangeWordBuyShop(int nIndex, BYTE* pProtocol)
{
    PLAYER_COMMAND_CHANGE_WORD_BUY_SHOP* pCWord = (PLAYER_COMMAND_CHANGE_WORD_BUY_SHOP*)pProtocol;
    if (nIndex <= 0 || nIndex >= MAX_PLAYER)
        return;
    if (Player[nIndex].m_nIndex <= 0 || Player[nIndex].m_nIndex >= MAX_NPC)
        return;

   //	g_DebugLog("PlayerChangeWordBuyShop");

     //TamLTM => Open shop duoc pham - tap hoa - tho ren

     if (Player[nIndex].CheckTrading())
         return;

     //int nShopMoneyUnit = moneyunit_money;
     BuySell.OpenSale(nIndex, pCWord->m_wMsgID - 1, 0); // pCWord->m_wMsgID = id shop

     //Check Truong hop co ban rac thi` /2 ngan luong - tranh cay tien
     if (pCWord->m_wMsgID == 4)
     {
       //  Player[nIndex].m_bAutoSellItem = true;
      //   printf("Chay may lan m_bAutoSellItem: %d", pCWord->m_wMsgID);
     }
     else
     {
      //   Player[nIndex].m_bAutoSellItem = false;
     }
     //	BuySell.Buy(nIndex, 3, 1, pos_equiproom, 5, 2);
}
//end code

#endif
