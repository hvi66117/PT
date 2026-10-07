#ifndef KProtocolProcessH
#define	KProtocolProcessH

#include "../Headers/KProtocol.h"
class KProtocolProcess
{
private:
#ifndef _SERVER
	void (KProtocolProcess::*ProcessFunc[s2c_end])(BYTE* pMsg);
#else
	void (KProtocolProcess::*ProcessFunc[c2s_end])(int nIndex, BYTE* pMsg);
#endif
public:
	KProtocolProcess();
	~KProtocolProcess();
#ifndef _SERVER
	void ProcessNetMsg(BYTE* pMsg, unsigned int nMsgSize);
	bool ProcessPhongThanWorldPacket(BYTE* pMsg, unsigned int nMsgSize);
#else
	void ProcessNetMsg(int nIndex, BYTE* pMsg, unsigned int nMsgSize);
	bool ProcessPhongThanWorldPacket(int nIndex, BYTE* pMsg, unsigned int nMsgSize);
#endif
private:
#ifdef TOOLVERSION
public:
#endif
#ifndef _SERVER
	void	s2cAccoutLoginResult(BYTE * pMsg);
	void	SyncCurNormalData(BYTE* pMsg);
	void	SyncWorld(BYTE* pMsg);
	void	SyncNpc(BYTE* pMsg);
	void	SyncNpcMin(BYTE* pMsg);
	void	SyncPlayer(BYTE* pMsg);
	void	SyncCurPlayer(BYTE* pMsg);
	void	SyncObjectAdd(BYTE* pMsg);
	void	NetCommandSkill(BYTE* pMsg);
	void	NetCommandChat(BYTE* pMsg);
	void	OpenSaleBox(BYTE* pMsg);
	void	OpenSomeBox(BYTE* pMsg);
	void	s2cShowTeamInfo(BYTE* pMsg);
	void	s2cUpdataSelfTeamInfo(BYTE* pMsg);
	void	s2cApplyTeamInfoFalse(BYTE* pMsg);
	void	s2cCreateTeam(BYTE* pMsg);
	void	s2cApplyCreateTeamFalse(BYTE* pMsg);
	void	s2cSetTeamState(BYTE* pMsg);
	void	s2cApplyAddTeam(BYTE* pMsg);
	void	s2cTeamAddMember(BYTE* pMsg);
	void	s2cLeaveTeam(BYTE* pMsg);
	void	s2cTeamChangeCaptain(BYTE* pMsg);
	void	s2cSetProfessionData(BYTE* pMsg);
	void	s2cSetMissionData(BYTE* pMsg);
	void	s2cGetLeadExp(BYTE* pMsg);
	void	s2cGetTeammateLevel(BYTE* pMsg);
	void	s2cLevelUp(BYTE* pMsg);
	void	s2cGetCurAttribute(BYTE* pMsg);
	void	s2cGetSkillLevel(BYTE* pMsg);
	void	s2cSyncAllSkill(BYTE * pMsg);
	void	s2cSyncMoney(BYTE* pMsg);
	void	s2cMoveItem(BYTE* pMsg);
	void	s2cRemoveItem(BYTE* pMsg);
	void	s2cSyncItem(BYTE* pMsg);
	void	s2cSyncMagic(BYTE* pMsg);
	void	SyncScriptAction(BYTE* pMsg);
	void	s2cChatGetApplyAddFriend(BYTE* pMsg);
	void	s2cSyncRoleList(BYTE* pMsg);
	void	SyncEnd(BYTE* pMsg);
	void	s2cTradeChangeState(BYTE* pMsg);
	void	s2cNpcSetMenuState(BYTE* pMsg);
	void	s2cTradeMoneySync(BYTE* pMsg);
	void	s2cTradeDecision(BYTE* pMsg);
	void	s2cPlayerExp(BYTE* pMsg);
	void	s2cTeamInviteAdd(BYTE * pMsg);
	void	s2cTradePressOkSync(BYTE * pMsg);
	void	s2cPing(BYTE* pMsg);
	void	s2cDirectlyCastSkill(BYTE * pMsg);
	void	s2cShowMsg(BYTE * pMsg);
	void	SyncStateEffect(BYTE* pMsg);
	void	IgnoreState(BYTE* pMsg);
	void	s2cTradeApplyStart(BYTE* pMsg);
	void	s2cCreateTong(BYTE* pMsg);
	void	s2cJoinTong(BYTE* pMsg);
	void	s2cJoinTongReply(BYTE* pMsg);
	void	s2cItemAutoMove(BYTE* pMsg);
	void	s2cChangeWeather(BYTE* pMsg);
	void	s2cPKSyncNormalFlag(BYTE* pMsg);
	void	s2cPKSyncEnmityState(BYTE* pMsg);
	void	s2cPKSyncExerciseState(BYTE* pMsg);
	void	s2cPKValueSync(BYTE* pMsg);
	void	NpcSleepSync(BYTE* pMsg);
	void	s2cViewEquip(BYTE* pMsg);
	void	LadderResult(BYTE* pMsg);
	void	LadderList(BYTE* pMsg);
	void	s2cTongCreate(BYTE* pMsg);
	void	ServerReplyClientPing(BYTE* pMsg);
	void	ItemChangeDurability(BYTE* pMsg);
	void	SendTradeAction(BYTE* pMsg);
	void	SendTradeItem(BYTE* pMsg);
	void	SendTradeCount(BYTE* pMsg);
	void	SendTradeFail(BYTE* pMsg);	
	void	s2cSyncTaskValue(BYTE* pMsg);
	void	s2cPlayerSync(BYTE* pMsg);
	/*//TamLTM fix s2c packet send sever to client
	void	s2cplayersyncofflive(BYTE* pMsg);
	void	s2cplayersyncmagicpoint(BYTE* pMsg);
	void	s2cplayersyncproppoint(BYTE* pMsg);
	void	s2cplayersyncinput(BYTE* pMsg);
	void	s2cplayersyncopenenchase(BYTE* pMsg);
	void	s2cplayersyncrankdata(BYTE* pMsg);
	void	s2cplayersyncmaskfeature(BYTE* pMsg);
	void	s2cplayersynclockstate(BYTE* pMsg);
	void	s2cplayersyncequipexpand(BYTE* pMsg);
	void	s2cplayersyncexpandbox(BYTE* pMsg);
	void	s2cplayersyncgive(BYTE* pMsg);
	//end code*/
	void	s2cExtPointValueSync(BYTE* pMsg); // protocol TamLTM fix xu;
	void	SyncGive(BYTE* pMsg);
	void	SyncMaskLock(BYTE* pMsg);
	void	SyncDataRes(BYTE* pMsg);
	void	s2cSyncRankData(BYTE* pMsg);
	void	s2cSyncSuperShop(BYTE* pMsg);
	void	s2cSparApplyStart(BYTE* pMsg);
	void	s2cLockMove(BYTE* pMsg);
	void	s2cChatRoomState(BYTE* pMsg);
	void	s2cApplyCreateChatRoomFalse(BYTE* pMsg);
	void	s2cRequestChatRoomList(BYTE* pMsg);
	void	s2cRequestMemberList(BYTE* pMsg);
	void	s2cRequestBlackList(BYTE* pMsg);
	void	s2cOpenMake(BYTE* pMsg);
	void	OpenDTBox(BYTE* pMsg);//TamLTM end code // nhan phan thuong da tau
	void	s2cOpenOtherBox(BYTE* pMsg); // TamLTM kham nam xanh
	void	OpenProgressBar(BYTE* pMsg);//TamLTM open OpenProgressBar
    void	s2cUpdateNpcState(BYTE * pMsg);

	void	s2cExtend(BYTE* pMsg);
	void	s2cExtendChat(BYTE* pMsg);
	void	s2cExtendFriend(BYTE* pMsg);
	void	s2cExtendTong(BYTE* pMsg);
	

#else
	void	RemoveRole(int nIndex, BYTE * pProtocol);
	void	NpcSkillCommand(int nIndex, BYTE* pProtocol);
	void	PlayerApplyTeamInfo(int nIndex, BYTE* pProtocol);
	void	PlayerApplyCreateTeam(int nIndex, BYTE* pProtocol);
	void	PlayerApplyTeamChangeState(int nIndex, BYTE* pProtocol);
	void	PlayerApplyAddTeam(int nIndex, BYTE* pProtocol);
	void	PlayerAcceptTeamMember(int nIndex, BYTE* pProtocol);
	void	PlayerApplyLeaveTeam(int nIndex, BYTE* pProtocol);
	void	PlayerApplyTeamKickMember(int nIndex, BYTE* pProtocol);
	void	PlayerApplyTeamChangeCaptain(int nIndex, BYTE* pProtocol);
	void	PlayerApplyTeamDismiss(int nIndex, BYTE* pProtocol);
	void	PlayerApplySetPK(int nIndex, BYTE* pProtocol);
	void	PlayerSendChat(int nIndex, BYTE* pProtocol);
	void	PlayerAddBaseAttribute(int nIndex, BYTE* pProtocol);
	void	PlayerApplyAddSkillPoint(int nIndex, BYTE* pProtocol);
	void	PlayerEatItem(int nIndex, BYTE* pProtocol);
	void	PlayerPickUpItem(int nIndex, BYTE* pProtocol);
	void	PlayerMoveItem(int nIndex, BYTE* pProtocol);
	void	PlayerSellItem(int nIndex, BYTE* pProtocol);
	void	PlayerBuyItem(int nIndex, BYTE* pProtocol);
	void	PlayerDropItem(int nIndex, BYTE* pProtocol);
	void	PlayerSelUI(int nIndex, BYTE* pProtocol);
	void	TradeApplyOpen(int nIndex, BYTE* pProtocol);
	void	TradeApplyClose(int nIndex, BYTE* pProtocol);
	void	TradeApplyStart(int nIndex, BYTE* pProtocol);
	void	TradeMoveMoney(int nIndex, BYTE* pProtocol);
	void	TradeDecision(int nIndex, BYTE* pProtocol);
	void	DialogNpc(int nIndex, BYTE * pProtocol);
	void	TeamInviteAdd(int nIndex, BYTE * pProtocol);
	void	ChangeAuraSkill(int nIndex, BYTE * pProtocol);
	void	TeamReplyInvite(int nIndex, BYTE * pProtocol);
	//void	ReplyPing(int nIndex, BYTE* pProtocol);
	void	ObjMouseClick(int nIndex, BYTE* pProtocol);
	void	StoreMoneyCommand(int nIndex, BYTE* pProtocol);
	void	WithDrawaMoneyCommand(int nIndex, BYTE* pProtocol); // rut tien;
	void	NpcReviveCommand(int nIndex, BYTE* pProtocol);
	void	c2sTradeReplyStart(int nIndex, BYTE* pProtocol);
	void	c2sPKApplyChangeNormalFlag(int nIndex, BYTE* pProtocol);
	void	c2sPKApplyEnmity(int nIndex, BYTE* pProtocol);
	void	c2sViewEquip(int nIndex, BYTE* pProtocol);
	void	LadderQuery(int nIndex, BYTE* pProtocol);
	void	ItemRepair(int nIndex, BYTE* pProtocol);
	void	TradeSet(int nIndex, BYTE* pProtocol);
	void	TradeStart(int nIndex, BYTE* pProtocol);
	void	TradeView(int nIndex, BYTE* pProtocol);
	void	TradeBuy(int nIndex, BYTE* pProtocol);
	void	TradeEnd(int nIndex, BYTE* pProtocol);	
	void	PlayerCommand(int nIndex, BYTE* pProtocol);
	void	PlayerLockItem(int nIndex, BYTE* pProtocol);
	void	PlayerUnLockItem(int nIndex, BYTE* pProtocol);
	void	InputCommand(int nIndex, BYTE* pProtocol);
	void	UnlockCommand(int nIndex, BYTE* pProtocol);
	void	BreakCommand(int nIndex, BYTE* pProtocol);
	void	JoinTongReply(int nIndex, BYTE* pProtocol);
	void	SparApplyStart(int nIndex, BYTE* pProtocol);
	void	LockMove(int nIndex, BYTE* pProtocol);
	void	ChatRoomDecision(int nIndex, BYTE* pProtocol);
	void	c2sSetImage(int nIndex, BYTE* pProtocol);
	void	NpcDaTauCommand(int nIndex, BYTE* pProtocol);//TamLTM da tau
	//void	C2SPlayerActionChatCmd(int nIndex, BYTE* pProtocol); // Ma Doc
	void	UiCommandScript(int nIndex, BYTE* pProtocol);	// TamLTM kham nam
	void	RecoveryBoxCmd(int nIndex, BYTE* pProtocol);	//TamLTM Kham nam
	void	c2sInputCommand(int nIndex, BYTE*pProtocol);	//TamLTM Kham nam
	void	NpcOpenProgressBarCommand(int nIndex, BYTE* pProtocol);//TamLTM progress bar
	void	NpcOfflineCommand(int nIndex, BYTE*pProtocol);//TamLTM Uy thac offline
    void    PlayerChangeWordBuyShop(int nIndex, BYTE* pProtocol);
#endif
};

extern KProtocolProcess g_ProtocolProcess;
#endif
