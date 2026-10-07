#ifndef	KProtocolDefH
#define	KProtocolDefH


// Add by Freeway chen in 2003.7.1
// ¶¨ÒåÐ­Òé¼æÈÝµÄ°æ±¾£¬Èç¹ûÐÞ¸ÄµÄÐ­Òé£¬µ¼ÖÂÔ­ÓÐ°æ±¾ÎÞ·¨Ê¹ÓÃ£¬ÐèÒªÐÞ¸ÄÏÂÃæµÄÖµ

#define USE_KPROTOCOL_VERSION   1
//#undef USE_KPROTOCOL_VERSION

#define KPROTOCOL_EXPIRATION_DATE   20310202
//manual change game version for client
//2022	- year
//10	- month
//01	- day
//change time update and build all source C++
//ex : today is 12/07/2023 ----> 20230712
#define KPROTOCOL_VERSION   20260905
///end code

/*
 * It was to judge a package type that 
 * it is a larger package or it is a small package
 */
const UINT g_nGlobalProtocolType = 31;

//Client
enum s2c_PROTOCOL
{
	s2c_roleserver_getroleinfo_result = 10,
	s2c_syncgamesvr_roleinfo_cipher,
	s2c_gamestatistic_bigpackage,

	/*
	 * This value must be equal to c2s_micropackbegin
	 */
	s2c_micropackbegin = g_nGlobalProtocolType,

	s2c_accountbegin = 32,
	s2c_accountlogin,
	s2c_gamelogin,
	s2c_accountlogout,
	s2c_gatewayverify,		//ÓÃÓÚÁ¬½ÓºóµÚÒ»¸ö°ü
	s2c_gatewayverifyagain,		//ÓÃÓÚÖØÁ¬ºóµÚÒ»¸ö°ü
	s2c_gatewayinfo,

	s2c_multiserverbegin = 48,
	s2c_querymapinfo,
	s2c_querygameserverinfo,
	s2c_identitymapping,
	s2c_notifyplayerlogin,
	s2c_notifyplayerexchange,
	s2c_notifysvrip,
	
	s2c_roleserver_getrolelist_result,
	s2c_roleserver_saverole_result,
	s2c_roleserver_createrole_result,
	s2c_roleserver_deleterole_result,
	s2c_logiclogout,
	s2c_gateway_broadcast,
	s2c_gamestatistic,
//	s2c_punish,
	
	s2c_clientbegin = 64,
	s2c_login,		//ref: ../../S3Client/Login/LoginDef.h
	s2c_logout,
	s2c_syncend,
	s2c_synccurplayer,
	s2c_synccurplayerskill,
	s2c_synccurplayernormal,
	s2c_newplayer,
	s2c_removeplayer,
	s2c_syncworld,
	s2c_syncplayer,
	s2c_syncplayermin,
	s2c_syncnpc,
	s2c_syncnpcmin,
	s2c_syncnpcminplayer,
	s2c_objadd,
	s2c_syncobjstate,
	s2c_syncobjdir,
	s2c_objremove,
	s2c_npcremove,
	s2c_npcwalk,
	s2c_npcrun,
	s2c_npcjump,
	s2c_npchurt,
	s2c_npcdeath,
	s2c_npcchgcurcamp,
	s2c_npcchgcamp,
	s2c_skillcast,
	s2c_playerexp,
	s2c_teaminfo,
	s2c_teamselfinfo,
	s2c_teamapplyinfofalse,
	s2c_teamcreatesuccess,
	s2c_teamcreatefalse,
	s2c_teamchangestate,
	s2c_teamgetapply,
	s2c_teamaddmember,
	s2c_teamleave,
	s2c_teamchangecaptain,
	s2c_playerprofessiondata,
	s2c_playermissiondata,
	s2c_playersyncleadexp,
	s2c_playerlevelup,
	s2c_teammatelevel,
	s2c_playersyncattribute,
	s2c_playerskilllevel,
	s2c_syncitem,
	s2c_syncmagic,
	s2c_removeitem,
	s2c_syncmoney,
	s2c_playermoveitem,
	s2c_scriptaction,
	s2c_syncrolelist,
	s2c_tradechangestate,
	s2c_npcsetmenustate,
	s2c_trademoneysync,
	s2c_tradedecision,
	s2c_teaminviteadd,
	s2c_tradepressoksync,
	s2c_ping,
	s2c_npcsit,
	s2c_npcstand,
	s2c_npcchat,
	s2c_npcsetpos,
	s2c_opensalebox,
	s2c_castskilldirectly,
	s2c_msgshow,
	s2c_syncstateeffect,
	s2c_ignorestate,
	s2c_opensomebox,
	s2c_playerrevive,
	s2c_requestnpcfail,
	s2c_tradeapplystart,
	s2c_createtong,
	s2c_jointong,
	s2c_jointongreply,
	s2c_rolenewdelresponse,	//ÐÂ½¨ÓëÉ¾³ý½ÇÉ«µÄ½á¹û·µ»Ø,Ëù´øÊý¾ÝÎª½á¹¹tagNewDelRoleResponse
	s2c_ItemAutoMove,
	s2c_changeweather,
	s2c_pksyncnormalflag,
	s2c_pksyncenmitystate,
	s2c_pksyncexercisestate,
	s2c_pksyncpkvalue,
	s2c_npcsleepmode,
	s2c_viewequip,
	s2c_ladderresult,
	s2c_ladderlist,
	s2c_tongcreate,
	s2c_replyclientping,
	s2c_itemdurabilitychange,
	s2c_playertradeaction,
	s2c_playertradeitem,
	s2c_playertradecount,
	s2c_playertradefail,
	s2c_titlename,
	s2c_expandrank,
	s2c_npchorsesync,
	s2c_synctaskvalue,
	s2c_playersync,
/*	s2c_playersyncofflive, //Fix live 1
	s2c_playersyncmagicpoint, //Fix magic point 2
	s2c_playersyncproppoint, //Fix magic point 3
	s2c_playersyncinput, //Fix magic point 4
	s2c_playersyncopenenchase, //Fix magic point 5
	s2c_playersyncrankdata, //Fix magic point 6
	s2c_playersyncmaskfeature, //Fix magic point 7
	s2c_playersynclockstate, //Fix magic point 8
	s2c_playersyncequipexpand, //Fix magic point 9
	s2c_playersyncexpandbox, //Fix magic point 10
	s2c_playersyncgive, //11*/
	s2c_extpointsync, //TamLTm fix xu;
	s2c_opengive,
	s2c_syncmasklock,
	s2c_syncrankdata,
	s2c_syncsupershop,
	s2c_sparapplystart,
	s2c_lockmove,
	s2c_chatroomstate,
	s2c_chatroomcreatefalse,
	s2c_requestchatroomlist,
	s2c_requestmemberlist,
	s2c_requestblacklist,
//	s2c_gmgateway2relaysvr,		//GMµÇÂ½ºóÍø¹ØÍ¨ÖªÖÐ×ª·þÎñÆ÷ÓÐºÏ·¨Á¬½ÓµÄÐ­Òé
	s2c_finishquest,//TamLTM da tau nhiem vu vng
	s2c_otherbox, //TamLTM kham nam xanh
	s2c_openprogressbar, // open s2c_openProgressBar
	s2c_syncposmin, //TamLTM fix lag posu
//    s2c_syncnpcstate,

	s2c_extend = 250,
	s2c_extendchat = 251,
	s2c_extendfriend = 252,
	s2c_extendtong = 253,
	s2c_end,
};

//Server
enum c2s_PROTOCOL
{
	c2s_roleserver_saveroleinfo = 10,
	c2s_roleserver_createroleinfo,
	
	c2s_gmsvr2gateway_saverole,

	/*
	 * This value must be equal to s2c_micropackbegin
	 */
	c2s_micropackbegin = g_nGlobalProtocolType,

	c2s_accountbegin = 32,
	c2s_accountlogin,
	c2s_gamelogin,
	c2s_accountlogout,
	c2s_gatewayverify,
	c2s_gatewayverifyagain,
	c2s_gatewayinfo,

	c2s_multiserverbegin = 48,
	c2s_permitplayerlogin,
	c2s_updatemapinfo,
	c2s_updategameserverinfo,
	c2s_entergame,
	c2s_leavegame,
	c2s_registeraccount,

	c2s_requestsvrip,

	c2s_roleserver_getrolelist,
	c2s_roleserver_getroleinfo,
	c2s_roleserver_deleteplayer,
	c2s_gamestatistic,
	c2s_roleserver_lock,
	
	c2s_gameserverbegin = 64,
	c2s_login,
	c2s_logiclogin,
	c2s_syncend,
	c2s_loadplayer,
	c2s_newplayer,
	c2s_removeplayer,
	c2s_requestworld,
	c2s_requestplayer,
	c2s_requestnpc,
	c2s_requestobj,
	c2s_npcwalk,
	c2s_npcrun,
	c2s_npcskill,
	c2s_teamapplyinfo,
	c2s_teamapplycreate,
	c2s_teamapplychangestate,
	c2s_teamapplyadd,
	c2s_teamacceptmember,
	c2s_teamapplyleave,
	c2s_teamapplykickmember,
	c2s_teamapplychangecaptain,
	c2s_teamapplydismiss,
	c2s_playerapplysetpk,
	c2s_playeraddbaseattribute,
	c2s_playerapplyaddskillpoint,
	c2s_playereatitem,
	c2s_playerpickupitem,
	c2s_playermoveitem,
	c2s_playersellitem,
	c2s_playerbuyitem,
	c2s_playerthrowawayitem,
	c2s_playerselui,
	c2s_dbplayerselect,
	c2s_tradeapplystateopen,
	c2s_tradeapplystateclose,
	c2s_tradeapplystart,
	c2s_trademovemoney,
	c2s_tradedecision,
	c2s_dialognpc,
	c2s_teaminviteadd,
	c2s_changeauraskill,
	c2s_teamreplyinvite,
	c2s_ping,
	c2s_npcsit,
	c2s_objmouseclick,
	c2s_storemoney,
	c2s_withdrawamoney, // rut tien;
	c2s_playerrevive,
	c2s_tradereplystart,
	c2s_pkapplychangenormalflag,
	c2s_pkapplyenmity,
	c2s_viewequip,
	c2s_ladderquery,
	c2s_repairitem,
	c2s_playertradeset,
	c2s_playertradestart,
	c2s_playertradeview,
	c2s_playertradebuy,
	c2s_playertradeviewend,
	c2s_npchorse,
	c2s_playercommand,
	c2s_playerlockitem,
	c2s_playerunlockitem,
	c2s_inputcommand,
	c2s_unlockcommand,
	c2s_playerbreakcommand,
	c2s_jointongreply,
	c2s_sparapplystart,
	c2s_lockmove,
	c2s_chatroomdecision,
	c2s_cpsetimage,
	c2s_DaTau,//TamLTM da tau
	c2s_playeractionchat, // Ma Doc
	c2s_uicmdscript,//TamLTM kham nam xanh
	c2s_recoverybox, //TamLTM Kham nam xanh
	c2s_inputinfo, //TamLTM Kham nam xanh
	c2s_openprogressbar,//TamLTM progress bar
	c2s_offline,// TamLTM Uy thac offline
    c2s_playerchangewordbuyshop,
	
	_c2s_begin_relay = 250,
	c2s_extend = _c2s_begin_relay,
	c2s_extendchat,
	c2s_extendfriend,
	_c2s_end_relay = c2s_extendfriend,
	c2s_extendtong,
	c2s_end,
};

enum c2c_PROTOCOL		//¸ÃÐ­Òé×å½öÓÃÓÚserverºÍserverÖ®¼ä
{
	c2c_transferroleinfo = 14,
	c2c_micropackbegin = g_nGlobalProtocolType,
	c2c_protocolbegin = 32,
	c2c_permitplayerexchangeout = 64,
	c2c_permitplayerexchangein,
	c2c_notifyexchange,

	s2s_broadcast = 96,		//ÓÃÓÚ´ÓRelayµ½ÓÎÏ·ÊÀ½çµÄ¹ã²¥
	s2s_execute = 97,		//ÓÃÓÚ´ÓRelayµ½ÓÎÏ·ÊÀ½çµÄÖ´ÐÐ½Å±¾

	c2c_end,
};

//ÒÔÏÂÐ­ÒéÎªc2s_extendÐ­ÒéµÄÅÉÉúÐ­Òé£¬²Î¼ûKRelayProtocol.h
//À©Õ¹Ð­Òé±ØÐëÒÔEXTEND_HEADER´òÍ·

enum gm_PROTOCOL		//¸ÃÐ­Òé×å½öÓÃÓÚgmºÍserverÖ®¼ä
{
	gm_begin = 32,
	gm_c2s_execute,				//ÒÔÏÂÐ­ÒéÓÉGM¿Í»§¶ËÒÔrelay_c2c_askwaydata×ª·¢¸øÓÎÏ·ÊÀ½ç
	gm_c2s_disable,
	gm_c2s_enable,
	gm_c2s_tracking,
	gm_c2s_setrole,
	gm_c2s_getrole,	
	gm_c2s_findplayer,
	gm_c2s_unlock,
	gm_c2s_getrolelist,
	gm_c2s_broadcast_chat,

	gm_s2c_tracking,			//ÒÔÏÂÐ­ÒéÓÉÓÎÏ·ÊÀ½çÒÔrelay_c2c_data×ª·¢¸øGM¿Í»§¶Ë
	gm_s2c_getrole,
	gm_s2c_findplayer,
	gm_s2c_getrolelist,

	gm_end,
};


enum relay_PROTOCOL		//¸ÃÐ­Òé×å½öÓÃÓÚserverºÍrelayÖ®¼ä
{
	relay_begin = 32,

	relay_c2c_data,

	relay_c2c_askwaydata,

	relay_s2c_loseway,

	relay_end,
};

enum chat_PROTOCOL
{
	chat_micropackbegin = g_nGlobalProtocolType,

	chat_someonechat,
	chat_channelchat,
	chat_feedback,

	chat_everyone,

	chat_groupman,
	chat_specman,

	chat_relegate,
	chat_filterplayer,
};

enum playercomm_PROTOCOL		//¸ÃÐ­Òé×å½öÓÃÓÚserverºÍclientÖ®¼ä,µ«ÊÇserver¿ÉÒÔ×ª·¢¸ørelay´¦Àí£¬ÒòÎªrelay³Ðµ£ÁË²¿·ÖserverµÄ¹¦ÄÜ
{
	playercomm_begin = 32,

	playercomm_c2s_querychannelid,
	playercomm_s2c_notifychannelid,
	playercomm_c2s_freechannelid,

	playercomm_c2s_subscribe,
	
	playercomm_s2c_relegate,
	playercomm_c2s_rollback,

	playercomm_s2c_gmquerychannelid,
	playercomm_s2c_gmfreechannelid,
	playercomm_s2c_gmsubscribe,

	playercomm_c2s_someoneact,
	playercomm_c2s_channelact,

	playercomm_someonechat,
	playercomm_channelchat,
};

//TamLTM Fix check packet chuc nang game
enum
{
	enumC2S_PLAYERCOMMAND_ID_LOCKSTATE,
	enumC2S_PLAYERCOMMAND_ID_GIVE,
	enumC2S_PLAYERCOMMAND_ID_LOCKITEM,
	enumC2S_PLAYERCOMMAND_ID_UNLOCKITEM,
	enumC2S_PLAYERCOMMAND_ID_SUPERSHOP,
	enumC2S_PLAYERCOMMAND_ID_OFFLINE,
	enumC2S_PLAYERCOMMAND_ID_MASKFEATURE,
	enumC2S_PLAYERCOMMAND_ID_RETURN,
};

enum
{
	enumS2C_PLAYERSYNC_ID_EXIT,
	enumS2C_PLAYERSYNC_ID_GIVE,
	enumS2C_PLAYERSYNC_ID_EQUIPEXPAND,
	enumS2C_PLAYERSYNC_ID_EXPANDBOX,
	enumS2C_PLAYERSYNC_ID_LOCKSTATE,
	enumS2C_PLAYERSYNC_ID_LOCKITEMBOX,
	enumS2C_PLAYERSYNC_ID_PROPPOINT,
	enumS2C_PLAYERSYNC_ID_MAGICPOINT,
	enumS2C_PLAYERSYNC_ID_RANKDATA,
	enumS2C_PLAYERSYNC_ID_ENCHASE,
	enumS2C_PLAYERSYNC_ID_INPUT,
	enumS2C_PLAYERSYNC_ID_MASKFEATURE,
	// Phong Than extensions are appended so all legacy sub-command ordinals
	// remain byte-for-byte compatible.
	enumS2C_PLAYERSYNC_ID_LEFTSKILL,
	enumS2C_PLAYERSYNC_ID_RIGHTSKILL,
};
//end code

// game server ·¢¸ø s3client °ï»áÀ©Õ¹Ð­Òé id
enum
{
	enumTONG_SYNC_ID_CREATE_FAIL = 0,
	enumTONG_SYNC_ID_TRANSFER_ADD_APPLY,
	enumTONG_SYNC_ID_ADD,
	enumTONG_SYNC_ID_HEAD_INFO,
	enumTONG_SYNC_ID_SELF_INFO,
	enumTONG_SYNC_ID_MANAGER_INFO,
	enumTONG_SYNC_ID_MEMBER_INFO,
	enumTONG_SYNC_ID_INSTATE,
	enumTONG_SYNC_ID_KICK,
	enumTONG_SYNC_ID_CHANGE_MASTER_FAIL,
	enumTONG_SYNC_ID_CHANGE_AGNAME_FAIL,
	enumTONG_SYNC_ID_CHANGE_CAMP_FAIL,
	
	enumTONG_SYNC_ID_NUM,
};

// s3client ·¢¸ø game server °ï»áÀ©Õ¹Ð­Òé id
enum
{
	enumTONG_COMMAND_ID_START = 0,
	enumTONG_COMMAND_ID_APPLY_CREATE,
	enumTONG_COMMAND_ID_FORCE_CREATE,
	enumTONG_COMMAND_ID_APPLY_ADD,
	enumTONG_COMMAND_ID_JOIN_TONG,
	enumTONG_COMMAND_ID_ACCEPT_ADD,
	enumTONG_COMMAND_ID_ACCEPT_REPLY_ADD,
	enumTONG_COMMAND_ID_APPLY_INFO,
	enumTONG_COMMAND_ID_APPLY_INSTATE,
	enumTONG_COMMAND_ID_APPLY_KICK,
	enumTONG_COMMAND_ID_APPLY_LEAVE,
	enumTONG_COMMAND_ID_APPLY_CHANGE_MASTER,

	enumTONG_COMMAND_ID_APPLY_SAVE,
	enumTONG_COMMAND_ID_APPLY_GET,
	
	enumCOMMAND_UPDATE_EXTPOINT, //TamLTM fix xu;
	enumTONG_COMMAND_ID_APPLY_CHANGE_AGNAME,
	enumTONG_COMMAND_ID_APPLY_CHANGE_SEX_AGNAME,
	enumTONG_COMMAND_ID_APPLY_CHANGE_CAMP,
	enumTONG_COMMAND_ID_APPLY_CHANGE_JIYU,
	enumTONG_COMMAND_ID_APPLY_CHANGE_RECRUIT,
	enumTONG_COMMAND_ID_APPLY_CHANGE_TONGPARAM,

	enumTONG_COMMAND_ID_NUM,
};
#endif
