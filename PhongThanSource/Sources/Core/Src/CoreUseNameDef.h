
#ifndef COREUSENAMEDEF_H
#define COREUSENAMEDEF_H

#define		MAX_PLAYER_IN_ACCOUNT			3

#define		SETTING_PATH					"\\settings"


#define		NPCNAME_KEY						"<npc>"
#define		PLAYERNAME_KEY					"<player>"
#define		SEXNAME_KEY						"<sex>"

#define 	STRANGER_UNITNAME 				"[Ng??i l?]"
#define 	FRIEND_INDEX					0
#define 	FRIEND_UNITNAME 				"H?o h?u"
#define 	ENEMY_INDEX						1
#define 	ENEMY_UNITNAME	 				"C?u nh?n"
#define 	ADDENEMY_UNITNAME	 			"C?u nh?n\n"
#define		BLACKLIST_UNITNAME				"S? ?en"
#define		BLACKLIST_INDEX					2
//---------------------------- npc res ???? ------------------------------
#define		RES_INI_FILE_PATH				"\\settings\\npcres"
#define		RES_NPC_STYLE_PATH				"\\spr\\npcres\\style"
#define		RES_SOUND_FILE_PATH				"sound"

#define		NPC_RES_KIND_FILE_NAME			"\\settings\\npcres\\\xC8\xCB\xCE\xEF\xC0\xE0\xD0\xCD.txt"
#define		NPC_NORMAL_RES_FILE				"\\settings\\npcres\\\xC6\xD5\xCD\xA8npc\xD7\xCA\xD4\xB4.txt"
#define		NPC_NORMAL_SPRINFO_FILE			"\\settings\\npcres\\\xC6\xD5\xCD\xA8npc\xD7\xCA\xD4\xB4\xD0\xC5\xCF\xA2.txt"
#define		STATE_MAGIC_TABLE_NAME			"\\settings\\npcres\\\xD7\xB4\xCC\xAC\xCD\xBC\xD0\xCE\xB6\xD4\xD5\xD5\xB1\xED.txt"
#define		PLAYER_RES_SHADOW_FILE			"\\settings\\npcres\\\xD6\xF7\xBD\xC7\xB6\xAF\xD7\xF7\xD2\xF5\xD3\xB0\xB6\xD4\xD3\xA6\xB1\xED.txt"
#define		NPC_RES_SHADOW_FILE				"\xC6\xD5\xCD\xA8npc\xB6\xAF\xD7\xF7\xD2\xF5\xD3\xB0\xB6\xD4\xD3\xA6\xB1\xED.txt"
#define		PLAYER_SOUND_FILE				"\\settings\\npcres\\\xD6\xF7\xBD\xC7\xB6\xAF\xD7\xF7\xC9\xF9\xD2\xF4\xB1\xED.txt"
#define		NPC_SOUND_FILE					"\\settings\\npcres\\npc\xB6\xAF\xD7\xF7\xC9\xF9\xD2\xF4\xB1\xED.txt"

#define		NPC_ACTION_NAME					"npc\xB6\xAF\xD7\xF7\xB1\xED.txt" //settings npcres
#define		ACTION_FILE_NAME				"\xB6\xAF\xD7\xF7\xB1\xE0\xBA\xC5\xB1\xED.txt"

#define		PLAYER_MENU_STATE_RES_FILE		"\\settings\\npcres\\\xBD\xE7\xC3\xE6\xD7\xB4\xCC\xAC\xD3\xEB\xCD\xBC\xD0\xCE\xB6\xD4\xD5\xD5\xB1\xED.txt"
#define		PLAYER_INSTANT_SPECIAL_FILE		"\\settings\\npcres\\\xCB\xB2\xBC\xE4\xCC\xD8\xD0\xA7.txt"

#define		SPR_INFO_NAME					"\xD7\xCA\xD4\xB4"
#define		SPR_EFFECT_NAME					"_effect"
#define		KIND_NAME_SECT					"CharacterType"
#define		KIND_NAME_SPECIAL				"SpecialNpc"
#define		KIND_NAME_NORMAL				"NormalNpc"
#define		KIND_FILE_SECT1					"PartFileName"
#define		KIND_FILE_SECT2					"WeaponActionTab1"
#define		KIND_FILE_SECT3					"WeaponActionTab2"
#define		KIND_FILE_SECT4					"ActionRenderOrderTab"
#define		KIND_FILE_SECT5					"ResFilePath"

//--------------------------- player ???????? ------------------------------
// ?????????????????????????? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??????????

//--------------------------- player PK???? ------------------------------
#define		defPK_PUNISH_FILE				"\\settings\\npc\\player\\PKPunish.txt"

//--------------------------- player ???????? ------------------------------
#define		defTONG_PARAM_FILE				"\\settings\\tong\\Tong_Setting.ini"
#define		defTONG_LEVEL_FILE				"\\settings\\tong\\Tong_Level.txt"
#define		defTONG_DATA_FILE				"\\settings\\tong\\Tong_Data.ini"

//---------------------------- player ???????? ------------------------------
#define		PLAYER_LEVEL_EXP_FILE			"\\settings\\npc\\player\\level_exp.txt"
#define		PLAYER_LEVEL_ADD_FILE			"\\settings\\npc\\player\\level_add.txt"
#define		PLAYER_LEVEL_LEAD_EXP_FILE		"\\settings\\npc\\player\\level_lead_exp.txt"
#define		PLAYER_MAGIC_LEVEL_EXP_FILE		"\\settings\\npc\\player\\magic_level_exp.txt"
#define		BASE_ATTRIBUTE_FILE_NAME		"\\settings\\npc\\player\\NewPlayerBaseAttribute.ini"
#define		PLAYER_PK_SET_FILE				"\\settings\\npc\\PKSet.ini"
#define		PLAYER_BASE_VALUE				"\\settings\\npc\\player\\BaseValue.ini"
#define		PLAYER_STAMINA_FILE_NAME		"\\settings\\npc\\player\\stamina.ini"

// 00???? 01???? 02???? 03???? 04???? 05???? 06???? 07???? 08???? 09????
#define		NEW_PLAYER_INI_FILE_NAME		"\\settings\\npc\\player\\NewPlayerIni%02d.ini"

//---------------------------- player ???????? ------------------------------
#define		BUYSELL_FILE					"\\settings\\buysell.txt"
#define		GOODS_FILE						"\\settings\\goods.txt"

//----------------------------- ???????? ------------------------------
#define		PHONGTHAN_APPEARANCE_MELEE_FILE			"\\settings\\item\\VNG_WeaponPart.txt"
#define		PHONGTHAN_APPEARANCE_RANGE_FILE			"\\settings\\item\\VNG_WeaponPart.txt"
#define		PHONGTHAN_APPEARANCE_ARMOR_FILE			"\\settings\\item\\VNG_ArmorPart.txt"
#define		PHONGTHAN_APPEARANCE_HELM_FILE				"\\settings\\item\\VNG_ArmorPart.txt"
#define		PHONGTHAN_APPEARANCE_HORSE_FILE			"\\settings\\item\\VNG_HorsePart.txt"
#define		PHONGTHAN_APPEARANCE_MASK_FILE				"\\settings\\item\\MaskRes.txt"
#define		ITEM_ABRADE_FILE				"\\settings\\item\\AbradeRate.ini"

//--------------- npc skill missles ?????????????????????? -------------
#define		SKILL_SETTING_FILE				"\\settings\\Skills.txt"
#define		MISSLES_SETTING_FILE			"\\settings\\Missles.txt"
#define		NPC_SETTING_FILE				"\\settings\\phongthan\\Npcs.txt"
#define		NPC_NAME_FILE					"\\settings\\NpcName.txt"

//---------------------------- object ???? ------------------------------
#define		OBJ_DATA_FILE_NAME		"\\settings\\obj\\ObjData.txt"
#define		MONEY_OBJ_FILE_NAME		"\\settings\\obj\\MoneyObj.txt"
#define		OBJ_NAME_COLOR_FILE		"\\settings\\obj\\ObjNameColor.ini"

//---------------------------- ?????????? -------------------------------
#define		defLITTLE_MAP_SET_FILE	"\\Ui\\Default\\??????????.ini"

//----------------------------- ???????? --------------------------------
#define		defINSTANT_SOUND_FILE	"\\settings\\SoundList.txt"
#define		defMUSIC_SET_FILE		"\\settings\\music\\MusicSet.txt"
#define		defMUSIC_FIGHT_SET_FILE	"\\settings\\music\\MusicFightSet.ini"

//------------------------------------------------------------------------
#define NPC_TEMPLATE_BINFILEPATH		"\\settings"
#define NPC_TEMPLATE_BINFILE			"NpcTemplate.Bin"
#define WEAPON_PHYSICSSKILLFILE			"\\settings\\ClientWeaponSkill.txt"
#define WEAPON_PARTICULARTYPE			"ParticularType"
#define	WEAPON_DETAILTYPE				"DetailType"
#define	WEAPON_SKILLID					"PhysicsSkillID"
//-----------------------------------------------------------------------
#define	WORLD_WAYPOINT_TABFILE			"\\settings\\WayPoint.txt"
#define WORLD_STATION_TABFILE			"\\settings\\Station.txt"
#define WORLD_STATIONPRICE_TABFILE		"\\settings\\StationPrice.txt"
#define WORLD_WAYPOINTPRICE_TABFILE		"\\settings\\WayPointPrice.txt"
#define WORLD_DOCK_TABFILE				"\\settings\\Wharf.txt"
#define WORLD_DOCKPRICE_TABFILE			"\\settings\\WharfPrice.txt"
#define STRINGRESOURSE_TABFILE			"\\settings\\StringResource.txt"
#define PLAYER_RANK_SETTING_TABFILE		"\\settings\\RankSetting.txt"
//---------------------------------????--------------------------
#define		MAGICATTRIB_LEVEL_FILE		"\\settings\\item\\magicattriblevel.txt"
#define		MAGICATTRIB_LVINDEX_FILE	"\\settings\\item\\magicattriblevel_index.txt"

#define		MAPLIST_SETTING_FILE		"\\settings\\WorldSet.ini"

#define		PLATINA_EQUIP_FILE			"\\settings\\item\\platinaequip.txt"
#define		GOLD_EQUIP_FILE				"\\settings\\item\\goldequip.txt"
#define		GOLD_EQUIP_MAGIC_FILE		"\\settings\\item\\magicattrib_ge.txt"

#define		GM_SCRIPT					"\\script\\gmscript.lua"
#define		SERVERTIMER_SCRIPT			"\\script\\servertimer.lua"
#define		SERVERSTARTUP_SCRIPT		"\\script\\serverscript.lua"

#define		LOGIN_SCRIPT				"\\script\\player\\playerlogin.lua"
#define		LEVELUP_SCRIPT				"\\script\\player\\playerlevelup.lua"
#define		LOGOUT_SCRIPT				"\\script\\player\\playerlogout.lua"
#define		SCRIPT_PROTOCOL_FILE		"\\script\\global\\script_protocol.lua"

#define		MINIMAP_SETTING_FILE_INI	"\\settings\\MapTraffic.ini"
#define 	GAME_DATA_FILE_INI			"\\settings\\GameData.ini" // TamLTM note Luu du lieu player trong game
#define 	GAME_SETTING_FILE_INI		"\\settings\\GameSetting.ini"

#define		UNKNOWNITEM_SPR				"\\spr\\item\\unknownitem.spr"
#define		UNKNOWNITEM_SPR36			"\\spr\\item\\unknownitem36.spr"
#define		RESIZEITEM_SPR				"\\spr\\item\\twzhuanyun\\zhuanyunbao_big.spr"

#define		TREMBLE_ITEM_SCRIPT			"\\script\\item\\khamxanh\\tremble.lua" //TamLTM kham nam xanh
#define		BUILD_ITEM_SCRIPT			"\\script\\item\\khamxanh\\builditem.lua" //TamLTM kham nam xanh

#define		SUPPERSHOP_CARD_SCRIPT		"\\script\\cardshop\\card.lua" //TamLTM suppershop card

#define		NORMAL_UNCLEAR_WORD			"Ch?a r?"
#define		NORMAL_FUNCTION_NAME		"main"
//---------------------------- ???????? ------------------------------
// ????????????????????????????????32?????????? %d %s ????????????????????????
#define		MSG_GET_EXP						"B?n nh?n ???c <color=green>%d <color>?i?m kinh nghi?m"
#define		MSG_DEC_EXP						"B?n t?n th?t <color=green>%d <color>?i?m kinh nghi?m"
#define		MSG_LEVEL_UP					"??ng c?p ??t %d c?p"
#define		MSG_LEADER_LEVEL_UP				"??ng c?p th?ng so?i c?a b?n ??t c?p %d"
#define		MSG_GET_ATTRIBUTE_POINT			"B?n c? %d ?i?m ti?m n?ng"
#define		MSG_GET_SKILL_POINT				"B?n c? %d ?i?m k? n?ng"
#define		MSG_GET_ATTRIBUTE_SKILL_POINT	"B?n c? %d ?i?m ti?m n?ng %d ?i?m k? n?ng"

#define		MSG_TEAM_SEND_INVITE			"B?n g?i ??n %s l?i m?i gia nh?p t? ??i"
#define		MSG_TEAM_GET_INVITE				"??i tr??ng %s g?i l?i m?i gia nh?p t? ??i ??n b?n"
#define		MSG_TEAM_REFUSE_INVITE			"Ng??i ch?i %s t? ch?i l?i gia nh?p t? ??i c?a nh?m b?n"
#define		MSG_TEAM_APPLY_INVITE_FAIL		"Nh?m m? b?n v?a ??ng ? gia nh?p kh?ng t?n t?i"
#define		MSG_TEAM_APPLY_INVITE_FAIL2		"Nh?m m? b?n v?a ??ng ? gia nh?p ?? ??ng ch?c n?ng chi?u m?"
#define		MSG_TEAM_CREATE					"B?n s?ng l?p n?n m?t nh?m m?i"
#define		MSG_TEAM_CREATE_FAIL			"S?ng l?p nh?m th?t b?i."
#define		MSG_TEAM_CREATE_FAIL1			"PK m? h?nh bang chi?n kh?ng th? s?ng l?p nh?m m?i!"
#define		MSG_TEAM_CANNOT_CREATE			"B?n hi?n gi? kh?ng th? l?p nh?m!"
#define		MSG_TEAM_TARGET_CANNOT_ADD_TEAM	"??i ph??ng hi?n gi? kh?ng th? l?p nh?m!"
#define		MSG_TEAM_IS_FULL				"Nh?m m? b?n xin ph?p gia nh?p ?? ?? s? l??ng"
#define		MSG_TEAM_OPEN					"Nh?m c?a b?n hi?n t?i c? th? ti?p nh?n th?nh vi?n m?i"
#define		MSG_TEAM_CLOSE					"Nh?m c?a b?n hi?n t?i kh?ng th? ti?p nh?n th?nh vi?n m?i"
#define		MSG_TEAM_MODEPICK_SELF			"T? nh?t"
#define		MSG_TEAM_MODEPICK_FREE			"T? do nh?t"
#define		MSG_TEAM_MODEPICK_CAPTAIN		"??i tr??ng nh?t"
#define		MSG_TEAM_MODEPICK_ALTERNATE		"Lu?n phi?n nh?t"
#define		MSG_TEAM_PKFOLLOW_OPEN			"B?n m? ch? ?? PK theo nh?m"
#define		MSG_TEAM_PKFOLLOW_CLOSE			"B?n ??ng ch? ?? PK theo nh?m"
#define		MSG_TEAM_ADD_MEMBER				"%s tr? th?nh b?ng h?u c?a nh?m B?n."
#define		MSG_TEAM_SELF_ADD				"B?n ?? tham gia nh?m c?a %s"
#define		MSG_TEAM_ADDMEMBER_NOTVALID		"B?n kh?ng th? tham gia nh?m c?a ng??i ch?i m?i"
#define		MSG_TEAM_DISMISS_CAPTAIN		"B?n ?? gi?i t?n nh?m c?a m?nh"
#define		MSG_TEAM_DISMISS_MEMBER			"%s gi?i t?n nh?m!"
#define		MSG_TEAM_KICK_ONE				"%s b? khai tr? kh?i nh?m"
#define		MSG_TEAM_BE_KICKEN				"B?n b? khai tr? kh?i nh?m"
#define		MSG_TEAM_APPLY_ADD				"%s xin ph?p gia nh?p nh?m!"
#define		MSG_TEAM_APPLY_ADD_SELF_MSG		"B?n g?i l?i xin ph?p gia nh?p t? ??i c?a %s"
#define		MSG_TEAM_LEAVE					"%s r?i kh?i nh?m."
#define		MSG_TEAM_LEAVE_SELF_MSG			"B?n ?? r?i kh?i nh?m c?a %s"
#define		MSG_TEAM_CHANGE_CAPTAIN_FAIL1	"??m nh?n nh?m tr??ng th?t b?i!"
#define		MSG_TEAM_CHANGE_CAPTAIN_FAIL2	"%s kh?ng ?? s?c th?ng so?i!"
#define		MSG_TEAM_CHANGE_CAPTAIN_FAIL3	"Kh?ng th? giao ch?c v? ??i tr??ng cho ng??i m?i ch?i"
#define		MSG_TEAM_CHANGE_CAPTAIN			"%s ???c ??m nh?n l? nh?m tr??ng"
#define		MSG_TEAM_CHANGE_CAPTAIN_SELF	"B?n ???c %s ??m nh?n l? nh?m tr??ng"
#define		MSG_TEAM_AUTO_CAPTAIN			"%s ???c h? th?ng ch? ??nh l? nh?m tr??ng"
#define		MSG_TEAM_AUTO_CAPTAIN_SELF		"B?n ???c h? th?ng ch? ??nh l? nh?m tr??ng"


#define		MSG_CHATROOM_CREATE				"B?n t?o ph?ng m?i %s"
#define		MSG_CHATROOM_CREATE_ERROR_SAMENAME	"T?n n?y ?? t?n t?i"
#define		MSG_CHATROOM_CREATE_ERROR_SAMEHOST	"B?n ?? t?o m?t ph?ng r?i"
#define		MSG_CHATROOM_CREATE_ERROR_NAME	"T?n kh?ng h?p l?"
#define		MSG_CHATROOM_CREATE_ERROR_PASS	"M?t m? ph?ng kh?ng h?p l?"
#define		MSG_CHATROOM_CREATE_ERROR_ROOMFULL	"S? ph?ng t?n g?u c?a m?y ch? n?y ?? ??, kh?ng th? t?o th?m"
#define		MSG_CHATROOM_SELF_JOIN			"B?n v?o ph?ng %s"
#define		MSG_CHATROOM_JOIN				"%s ?? v?o ph?ng"
#define		MSG_CHATROOM_JOIN_FAIL1			"B?n nh?p sai m?t m? ph?ng %s"
#define		MSG_CHATROOM_JOIN_FAIL2			"B?n b? li?t v?o s? ?en kh?ng th? ??ng nh?p v?o ph?ng %s"
#define		MSG_CHATROOM_JOIN_FAIL3			"Ph?ng %s ?? ??y"
#define		MSG_CHATROOM_SELF_LEAVE			"B?n r?i kh?i ph?ng %s"
#define		MSG_CHATROOM_LEAVE				"%s r?i kh?i ph?ng"
#define		MSG_CHATROOM_SELF_DELETE		"B?n ?? h?y ph?ng %s"
#define		MSG_CHATROOM_SELF_FORCELEAVE	"B?n b? ??y kh?i ph?ng %s"
#define		MSG_CHATROOM_SELF_BEKICK		"B?n b? khai tr? kh?i ph?ng %s"
#define		MSG_CHATROOM_BEKICK				"%s b? khai tr? kh?i ph?ng"
#define		MSG_CHATROOM_ADDBLACKLIST		"Th?m %s v?o s? ?en"
#define		MSG_CHATROOM_ADDBLACKLIST_FAIL	"Th?m %s v?o s? ?en th?t b?i"
#define		MSG_CHATROOM_REMOVEBLACKLIST	"L??c b? %s kh?i s? ?en"
#define		MSG_CHATROOM_SELD_CHANGEPW		"B?n ?? ??i m?t m? ph?ng %s"
#define		MSG_CHATROOM_OPENGAME			"L??t ch?i m?i ???c m?, l?n n?y ??t t?i ?a %d ?i?m"
#define		MSG_CHATROOM_REVERSE			"L??t ch?i c?a ph?ng %s ?? k?t th?c"

#define		MSG_CHAT_APPLY_ADD_FRIEND		"B?n ??n %s xin ph?p ???c k?t giao."
#define		MSG_CHAT_FRIEND_HAD_IN			"%s ?? ???c nh?n l?m b?ng h?u."
#define		MSG_CHAT_GET_FRIEND_APPLY		"%s xin ph?p gia nh?p b?ng h?u"
#define		MSG_CHAT_REFUSE_FRIEND			"%s t? ch?i y?u c?u k?t b?n"
#define		MSG_CHAT_ADD_FRIEND_FAIL		"Th?m %s v?o danh s?ch b?ng h?u th?t b?i"
#define		MSG_CHAT_ADD_FRIEND_SUCCESS		"Th?m %s v?o danh s?ch b?ng h?u th?nh c?ng"
#define		MSG_CHAT_FRIEND_ONLINE			"H?o h?u %s l?n m?ng r?i!"
#define		MSG_CHAT_FRIEND_OFFLINE			"H?o h?u %s r?i m?ng r?i!"
#define		MSG_CHAT_ENEMY_ONLINE			"C?u nh?n %s l?n m?ng r?i!"
#define		MSG_CHAT_ENEMY_OFFLINE			"C?u nh?n %s r?i m?ng r?i!"
#define		MSG_CHAT_DELETE_FRIEND			"B?n c?ng %s h?y b? quan h?"
#define		MSG_CHAT_DELETED_FRIEND			"%s c?ng B?n h?y b? quan h?"

#define		MSG_SHOP_NO_ROOM				"Kho?ng tr?ng trong t?i kh?ng ??"
#define		MSG_SHOP_NO_MONEY				"B?n kh?ng c? ?? ng?n l??ng"
#define		MSG_SHOP_NO_EXTPOINT			"B?n kh?ng c? ?? ti?n ??ng"
#define		MSG_SHOP_NO_FUYUAN				"B?n kh?ng c? ?? ph?c duy?n"
#define		MSG_SHOP_NO_REPUTE				"B?n kh?ng c? ?? danh v?ng"
#define		MSG_SHOP_NO_ACCUM				"B?n kh?ng c? ?? t?ch l?y"
#define		MSG_SHOP_NO_HONOR				"B?n kh?ng c? ?? vinh d?"
#define		MSG_SHOP_NO_RESPECT				"B?n kh?ng c? ?? uy danh"

#define		MSG_NPC_NO_MANA					"N?i l?c kh?ng ??!"
#define		MSG_NPC_NO_STAMINA				"Th? l?c kh?ng ??!"
#define		MSG_NPC_NO_LIFE					"Sinh l?c kh?ng ??!"

#define		MSG_NPC_NOT_USE_TOWNPORTAL		"Kh?ng th? s? d?ng th? ??a ph? ? ??y"
#define		MSG_NPC_NOT_PAY_FOR_SPEECH		"B?n b? c?m ph?t ng?n ??n %H:%M - %d/%m/%Y"
#define		MSG_NPC_NOT_USE_SKILL_SILENT	"B?n kh?ng th? thi tri?n v? c?ng l?c n?y"
#define		MSG_NPC_NOT_USE_SKILL_DISTANCE	"B?n ??ng c?ch ti?u ?i?m qu? xa, tr??c m?t s? d?ng v? c?ng n?y s? kh?ng ?? hi?u nghi?m"
#define		MSG_NPC_NOT_USE_SKILL_WEAPON	"V? kh? m? b?n ?ang s? d?ng kh?ng ph? h?p v?i lo?i v? c?ng m? b?n hi?n ?ang s? d?ng"
#define		MSG_NPC_NOT_USE_SKILL_HORSE1	"V? c?ng m? b?n s? d?ng hi?n gi? kh?ng th? c??i ng?a"
#define		MSG_NPC_NOT_USE_SKILL_HORSE2	"V? c?ng m? b?n s? d?ng hi?n gi? c?n ph?i c??i ng?a"
#define		MSG_NPC_RENASCENCE_SOMEONE		"B?n b? %s h? tr?ng th??ng"
#define		MSG_NPC_RENASCENCE				"B?n ?? b? tr?ng th??ng"
#define		MSG_NPC_DEATH					"%s ?? ch?t !"

#define		MSG_OBJ_CANNOT_PICKUP			"B?n kh?ng th? l?y v?t ph?m c?a ng??i kh?c"
#define		MSG_MONEY_CANNOT_PICKUP			"B?n kh?ng th? l?y ti?n c?a ng??i kh?c"
#define		MSG_OBJ_TOO_FAR					"V?t ph?m qu? xa kh?ng th? l?y"
#define		MSG_DEC_MONEY					"B?n b? m?t <color=yellow>%d <color>l??ng b?c"
#define		MSG_EARN_MONEY					"B?n nh?n ???c <color=yellow>%d <color>l??ng b?c"
#define		MSG_DEATH_LOSE_ITEM				"B?n ?? b? m?t <color=blue>%s<color>"
#define		MSG_ADD_ITEM					"B?n nh?n ???c m?t c?i <color=blue>%s<color>"
#define		MSG_ADD_ITEM_STACK				"B?n nh?n ???c %d c?i <color=blue>%s<color>"

#define		MSG_ITEM_SAME_IN_IMMEDIATE		"Hi?n ?? c? v?t ph?m ??ng lo?i r?i"
#define		MSG_ITEM_PUT_IN_IMMEDIATE		"Thanh ph?m t?t kh?ng th? ??t v?o v?t ph?m n?y!"

#define		MSG_ITEM_DAMAGED				"Trang b? %s ?? b? h?ng r?i"
#define		MSG_ITEM_NEARLY_DAMAGED			"Trang b? %s s?p h?ng h?y ??n th? r?n ?? s?a ch?a l?i"
#define		MSG_ITEM_REPAIRED				"Ti?u t?n %d l??ng b?c ?? s?a ch?a %s"

#define		MSG_LOCK_NOT_THROW				"Nh?m b?o v? t?i s?n cho b?n V?t ph?m n?y kh?ng ???c t?y ? v?t b?"
#define		MSG_LOCK_NOT_TRADE				"Nh?m b?o v? t?i s?n cho b?n V?t ph?m n?y kh?ng th? giao d?ch"
#define		MSG_LOCK_NOT_SETPRICE			"Nh?m b?o v? t?i s?n cho b?n V?t ph?m n?y kh?ng th? ??nh gi?"

#define		MSG_BROKEN_CANTREPAIR			"Trang b? ?? h? h?ng ho?n to?n kh?ng th? s?a ch?a b?ng ph??ng ph?p b?nh th??ng"

#define		MSG_TRADE_STATE_OPEN			"B?n hi?n gi? c? th? giao d?ch"
#define		MSG_TRADE_STATE_CLOSE			"B?n hi?n gi? kh?ng th? giao d?ch"
#define		MSG_TRADE_SELF_LOCK				"B?n ?? kh?a ch?c n?ng giao d?ch v?t ph?m, ch? ??i ph??ng tr? l?i"
#define		MSG_TRADE_DEST_LOCK				"Ng??i ch?i %s ?? kh?a ch?c n?ng giao d?ch v?t ph?m"
#define		MSG_TRADE_SUCCESS				"B?n c?ng v?i %s giao d?ch th?nh c?ng"
#define		MSG_TRADE_FAIL					"B?n c?ng v?i %s giao d?ch th?t b?i"
#define		MSG_TRADE_SELF_ROOM_FULL		"Kho?ng tr?ng trong t?i c?a B?n kh?ng ??!"
#define		MSG_TRADE_DEST_ROOM_FULL		"%s kho?ng tr?ng trong t?i kh?ng ??!"
#define		MSG_TRADE_SEND_APPLY			"B?n g?p %s xin ph?p giao d?ch!"
#define		MSG_TRADE_GET_APPLY				"%s xin ph?p c?ng v?i B?n giao d?ch!"
#define		MSG_TRADE_REFUSE_APPLY			"%s c? tuy?t giao d?ch v?i B?n!"
#define		MSG_TRADE_INPUT_MONEY			"??i ph??ng ??t v?o s? ti?n %d l??ng"

#define		MSG_SPAR_SEND_APPLY				"B?n g?i l?i m?i t? th? v? ngh? ??n %s"
#define		MSG_SPAR_GET_APPLY				"Ng??i ch?i %s g?i l?i m?i t? th? v? ngh? ??n v?i b?n"
#define		MSG_SPAR_REFUSE_APPLY			"Ng??i ch?i %s t? ch?i l?i m?i t? v? c?a b?n"
#define		MSG_SPAR_VICTORY				"B?n ?? chi?n th?ng trong l?n t? th? v? ngh? n?y"
#define		MSG_SPAR_DEFEAT					"T? v? th?t b?i, xin ??ng ng? l?ng"

#define		MSG_TRADE_FOLKGAME_SEND_APPLY	"B?n g?i l?i m?i ??u ?? thu?t ??n %s"
#define		MSG_TRADE_FOLKGAME_GET_APPLY	"Ng??i ch?i %s g?i l?i m?i ??u ?? thu?t ??n v?i b?n"
#define		MSG_TRADEFOLKGAME_SELF_ROOM_FULL	"H?nh trang c?a b?n kh?ng ?? %dx%d ? tr?ng"
#define		MSG_TRADEFOLKGAME_DEST_ROOM_FULL	"H?nh trang c?a %s kh?ng ?? %dx%d ? tr?ng"

#define		MSG_PK_NORMAL_FLAG_OPEN			"Tr?ng th?i PK ? d?ng chi?n ??u"
#define		MSG_PK_NORMAL_FLAG_CLOSE		"Tr?ng th?i PK ? d?ng luy?n c?ng"
#define		MSG_PK_NORMAL_FLAG_DS			"Tr?ng th?i PK ? d?ng th?c gi?t ng??i"
#define		MSG_PK_NORMAL_FLAG_TONGWAR		"Tr?ng th?i PK ? d?ng th?c m? h?nh bang chi?n"
#define		MSG_PK_NORMAL_FLAG_UNKNOWN		"Tr?ng th?i PK ? d?ng th?c ch?a r?"
#define		MSG_PK_HIGHT_LOCK_NOT_SWITCH	"Hi?n gi? PK c?a b?n >= %d, tr??c khi PK xin h?y h?y b? tr?ng th?i kh?a b?o hi?m."
#define		MSG_PKSTATE_NOT_OPEN			"Tr?ng th?i PK n?y ch?a m?"
#define		MSG_PK_VALUE					"Tr? s? PK hi?n t?i l? %d"
#define		MSG_PK_ERROR_1					"B?n hi?n gi? ?ang ? trong tr?ng th?i phi chi?n ??u!"
#define		MSG_PK_ERROR_2					"Ng??i m?i kh?ng th? gi?t th?!"
#define		MSG_PK_ERROR_3					"B?n ?ang c?ng v?i ng??i kh?c trao ??i ? ki?n!"
#define		MSG_PK_ERROR_4					"B?n ?ang c?ng v?i ng??i kh?c gi?t th?!"
#define		MSG_PK_ERROR_5					"B?n kh?ng th? gi?t ng??i m?i!"
#define		MSG_PK_ERROR_6					"??i ph??ng ?ang ? trong tr?ng th?i phi chi?n ??u!"
#define		MSG_PK_ERROR_7					"??i ph??ng ?ang c?ng v?i ng??i kh?c gi?t th?!"
#define		MSG_PK_ERROR_8					"B?n hi?n gi? kh?ng th? c?u s?t!"
#define		MSG_PK_ERROR_9					"Ng??i n?y ?ang trong tr?ng th?i ??ng c?u s?t"
#define		MSG_PK_ENMITY_SUCCESS_1			"%s c?ng v?i B?n ti?n h?nh c?u s?t"
#define		MSG_PK_ENMITY_SUCCESS_2			"Sau 10 gi?y b?t ??u ti?n h?nh c?u s?t"
#define		MSG_PK_SPAR_ENMITY_SUCCESS_1	"%s c?ng v?i B?n ti?n h?nh t? v?"
#define		MSG_PK_SPAR_ENMITY_SUCCESS_2	"Sau 5 gi?y b?t ??u ti?n h?nh t? v?"
#define		MSG_PK_ENMITY_CLOSE				"Tr?ng th?i c?u s?t k?t th?c"
#define		MSG_PK_SPAR_ENMITY_CLOSE		"Tr?ng th?i t? v? k?t th?c"
#define		MSG_PK_ENMITY_OPEN				"B?t ??u ti?n h?nh c?u s?t"
#define		MSG_PK_SPAR_ENMITY_OPEN			"B?t ??u ti?n h?nh t? v?"
#define		MGS_PK_IS_LOCK					"PK t? phi chi?n ??u chuy?n sang luy?n c?ng ph?i m?t %d ph?t"
#define		MGS_PK_IS_LOCK1					"Tr?ng th?i ??c bi?t kh?ng th? chuy?n ki?u chi?n ??u"
#define		MGS_PK_IS_LOCK2					"Th?nh vi?n bang h?i m?i c? th? m? chi?n ??u bang h?i"
#define		MGS_PK_IS_LOCK3					"Ch? ??i PK nh?m kh?ng th? t? ? chuy?n tr?ng th?i chi?n ??u"
#define		MGS_PK_IS_LOCK4					"Trong t? ??i kh?ng th? chuy?n PK m? h?nh bang chi?n"
#define		MGS_PK_IS_LOCK5					"?i?m PK c?a b?n qu? nhi?u, kh?ng th? h? th? ???c!"
#define		MGS_PK_IS_LOCK6					"?i?m kinh nghi?m ?m c?a b?n qu? nhi?u, kh?ng th? h? th? ???c!"
#define		MGS_PK_IS_LOCK7					"PK chuy?n gi?a c?c tr?ng th?i chi?n ??u ph?i m?t %d gi?y"

#define		MSG_TONG_CREATE_ERROR01			"B?n nh?p v?o t?n bang h?i kh?ng h?p l?"
#define		MSG_TONG_CREATE_ERROR02			"Phe ph?i trong bang h?i kh?ng h?p l?"
#define		MSG_TONG_CREATE_ERROR03			"Th?nh vi?n bang h?i kh?ng th? kh?ng th? l?p m?t bang h?i kh?c!"
#define		MSG_TONG_CREATE_ERROR04			"B?n kh?ng ph?i l? s?t th? kh?ng th? l?p bang!"
#define		MSG_TONG_CREATE_ERROR05			"B?n kh?ng ?? %d c?p kh?ng th? l?p bang!"
#define		MSG_TONG_CREATE_ERROR06			"B?n kh?ng ?? %d ??ng c?p th?ng so?i!"
#define		MSG_TONG_CREATE_ERROR07			"B?n kh?ng ?? %d ng?n l??ng b?c ?? l?p bang!"
#define		MSG_TONG_CREATE_ERROR08			"B?n ?ang trong ??i ng?, kh?ng th? l?p bang!"
#define		MSG_TONG_CREATE_ERROR09			"B?n kh?ng c? Nh?c v??ng ki?m!"
#define		MSG_TONG_CREATE_ERROR10			"B?n ?ang b?n ho?c ?ang giao d?ch kh?ng th? l?p bang"
#define		MSG_TONG_CREATE_ERROR11			"B?n kh?ng ?? %d danh v?ng"
#define		MSG_TONG_CREATE_ERROR12			"B?n kh?ng ?? %d ph?c duy?n"
#define		MSG_TONG_CREATE_ERROR13			"S? bang h?i c?a server ?? ??t gi?i h?n kh?ng th? t?o th?m"
#define		MSG_TONG_CREATE_ERROR14			"T?n bang h?i ho?c t?n bang ch? b? l?i kh?ng th? t?o"
#define		MSG_TONG_CREATE_ERROR15			"Bang h?i ?? t?n t?i ho?c b?n ?ang l? bang ch? c?a m?t bang h?i kh?c"
#define		MSG_TONG_APPLY_CREATE			"B?n g?i y?u c?u th?nh l?p bang h?i"
#define		MSG_TONG_CREATE_SUCCESS			"Th?nh l?p bang h?i th?nh c?ng"
#define		MSG_TONG_SEND_APPLY				"B?n g?i l?i m?i gia nh?p bang h?i ??n %s"
#define		MSG_TONG_REV_APPLY				"%s g?i l?i m?i gia nh?p bang h?i ??n b?n"
#define		MSG_TONG_APPLY_ADD				"B?n g?i y?u c?u xin gia nh?p bang h?i!"
#define		MSG_TONG_APPLY_ADD_SELF_MSG		"Ng??i ch?i %s xin ph?p gia nh?p bang h?i"
#define		MSG_TONG_APPLY_ADD_ERROR		"Ng??i ch?i %s kh?ng ?? ?i?u ki?n gia nh?p bang h?i"
#define		MSG_TONG_APPLY_ADD_ERROR1		"Th?nh vi?n bang h?i kh?ng th? gia nh?p bang h?i kh?c"
#define		MSG_TONG_APPLY_ADD_ERROR2		"B?n ph?i l? s?t th? m?i c? th? gia nh?p bang h?i"
#define		MSG_TONG_APPLY_ADD_ERROR3		"B?n ph?i r?i kh?i t? ??i m?i c? th? gia nh?p bang h?i"
#define		MSG_TONG_APPLY_ADD_ERROR4		"B?n v?a ch? ??ng r?i kh?i bang h?i, ?ang trong th?i gian th? th?ch kh?ng th? g?i y?u c?u"
#define		MSG_TONG_APPLY_ADD_ERROR5		"Bang h?i m? b?n v?a xin gia nh?p ?? ??ng ch?c n?ng chi?u m? ?? t?"
#define		MSG_TONG_APPLY_ADD_ERROR6		"Bang h?i ?? ??ng ch?c n?ng chi?u m? ?? t?"
#define		MSG_TONG_APPLY_ADD_ERROR7		"Ng??i n?y v?a r?i kh?i bang h?i ch?a th? gia nh?p b?y gi?"
#define		MSG_TONG_REFUSE_ADD				"Ng??i ch?i %s t? ch?i l?i m?i gia nh?p bang h?i"
#define		MSG_TONG_ADD_SUCCESS			"B?n ?? gia nh?p bang h?i th?nh c?ng"
#define		MSG_TONG_CANNOT_LEAVE1			"Th?nh vi?n ch?nh th?c kh?ng th? r?i kh?i bang"
#define		MSG_TONG_CANNOT_LEAVE2			"Tr??ng l?o kh?ng th? r?i kh?i bang"
#define		MSG_TONG_BE_KICKED				"B?n b? tr?c xu?t ra kh?i bang"
#define		MSG_TONG_KICK_ERROR1			"Thao t?c phi ph?p, b?n kh?ng thu?c b?t k? bang h?i n?o"
#define		MSG_TONG_KICK_ERROR2			"Thao t?c th?t b?i, ch?c Tr??ng l?o tr? l?n m?i c? th? tr?c xu?t th?nh vi?n"
#define		MSG_TONG_KICK_ERROR3			"Tr??ng l?o kh?ng th? tr?c xu?t tr?c ti?p"
#define		MSG_TONG_LEAVE_SUCCESS			"B?n ?? r?i kh?i bang h?i th?nh c?ng, c? th? xin gia nh?p bang h?i kh?c sau %d ph?t"
#define		MSG_TONG_LEAVE_FAIL				"R?i kh?i bang h?i th?t b?i"
#define		MSG_TONG_NO_MONEY				"B?n kh?ng c? ?? ng?n l??ng kh?ng th? t? ? r?i kh?i"
#define		MSG_TONG_CHANGE_AS_MASTER		"B?n b?y gi? ??m nh?n ch?c v? Bang ch?"
#define		MSG_TONG_CHANGE_MASTER_ERROR1	"Chuy?n v? th?t b?i, ??i ph??ng kh?ng tr?c tuy?n!"
#define		MSG_TONG_CHANGE_MASTER_ERROR2	"Chuy?n v? th?t b?i, ??i ph??ng n?ng l?c kh?ng ??!"
#define		MSG_TONG_CHANGE_MASTER_ERROR3	"Chuy?n v? th?t b?i, trong bang kh?ng c? ng??i n?y!"
#define		MSG_TONG_CHANGE_AS_MEMBER		"B?y gi? b?n tr? th?nh th?nh vi?n b?nh th??ng"
#define		MSG_TONG_CHANGE_AGNAME_ERROR1	"Ng??i ch?i n?y hi?n kh?ng tr?c tuy?n, thao t?c th?t b?i"
#define		MSG_TONG_CHANGE_AGNAME_ERROR2	"Ng??i ch?i n?y kh?ng ?? t?i l?nh ??o, thao t?c th?t b?i"
#define		MSG_TONG_CHANGE_AGNAME_ERROR3	"Ng??i ch?i n?y kh?ng t?n t?i, thao t?c th?t b?i"
#define		MSG_TONG_CHANGE_CAMP			"Ti?n h?nh thay ??i phe ph?i b?n bang"
#define		MSG_TONG_CHANGE_CAMP_ERROR1		"Ch? c? bang ch? m?i s? d?ng ???c ch?c n?ng n?y"
#define		MSG_TONG_CHANGE_CAMP_ERROR2		"Vui l?ng ch?n phe ph?i thay ??i ??n"
#define		MSG_TONG_CHANGE_CAMP_ERROR3		"Ng?n kh? kh?ng c? ?? %d l??ng, kh?ng th? thay ??i phe ph?i b?n bang"
#define		MSG_TONG_CHANGE_SAVEJIYU_ERROR	"Ng?n kh? kh?ng c? ?? %d l??ng, kh?ng th? b?o l?u"

#define		MSG_CANT_SIT_RIDE				"L?c c??i ng?a kh?ng th? thi?n t?a"
#define		MSG_CANT_SWITCH_HORSE_SIT		"B?n ?ang thi?n t?a kh?ng th? l?n ng?a"
#define		MSG_CANT_SWITCH_HORSE			"B?n qu? m?t m?i kh?ng th? li?n t?c l?n ho?c xu?ng ng?a"
#define		MSG_CANT_TRADE_BUZY				"Trong l?c c?i ng?a ho?c ?ang giao d?ch v?i t? ??i kh?ng th? b?y b?n!"

#define		MESSAGE_BROADCAST_ANNOUCE_HEAD	"C?ng b?"
#define		MESSAGE_SYSTEM_ANNOUCE_HEAD		"H? th?ng"
#define		MESSAGE_SYSTEM_ANNOUCE_SKILL	"H? th?ng k? n?ng"
#define		MESSAGE_SYSTEM_ANNOUCE_PROTECT	"H? th?ng b?o m?t"
#define		MESSAGE_TEAM_ANNOUCE_HEAD		"Tin ??i"
#define		MESSAGE_TONG_ANNOUCE_HEAD		"Tin bang"
#define		MESSAGE_ROOM_ANNOUCE_HEAD		"Tin ph?ng"

#define		defTONG_VICEROY_AGNAME			"[Th?i th?]"
#define		defTONG_MASTER_AGNAME			"Bang ch?"
#define		defTONG_DIRECTOR_AGNAME			"Tr??ng l?o"
#define		defTONG_MANAGER_AGNAME			"??i tr??ng"
#define		defTONG_MEMBER_AGNAME			"?? t?"

#define		MSG_TRADE_COUNT					"B?n ch?a ??nh gi? cho b?t k? v?t ph?m n?o"
#define		MSG_TRADE_SELLED				"V?t ph?m n?y ?? ???c b?n ra r?i!"
#define		MSG_TRADE_CLOSED				"Ng??i b?y b?n ?? c?t ?i r?i"

#define		MSG_FIGHT_MODE_ERROR1			"Tr?ng th?i kh?ng ???c b?o v? kh?ng th? th?c hi?n"
#define		MSG_FIGHT_MODE_ERROR2			"B?n trong tr?ng th?i kh?ng ???c b?o v? kh?ng th? th?c hi?n"
#define		MSG_FIGHT_MODE_ERROR3			"%s trong tr?ng th?i kh?ng ???c b?o v? kh?ng th? th?c hi?n"

#define		MSG_SUBWORLD_NOT_OPEN			"???ng ?i ph?a tr??c kh?ng th?ng"

#define		MSG_PASSWORD_ERROR1				"M?t kh?u ph?i c? ?? d?i t? 4 ??n 16 k? t?"
#define		MSG_PASSWORD_ERROR2				"M?t kh?u x?c nh?n kh?ng tr?ng kh?p. Xin m?i nh?p l?i"
#define		MSG_PASSWORD_ERROR3				"M?t kh?u m?i nh?p v?o kh?ng th? tr?ng v?i m?t kh?u hi?n t?i"

#define		MSG_FUNCTION_FOBIDDENED			"Xin l?i, c?ng n?ng n?y t?m th?i ?? b? ??ng!"
#define		MSG_FUNCTION_LOCKED				"Thao t?c ?? b? kh?a! vui l?ng m? kh?a b?o v? tr??c khi th?c hi?n."


enum enumMSG_ID
{
	enumMSG_ID_NONE = 0,
	enumMSG_ID_TEAM_KICK_ONE,
	enumMSG_ID_TEAM_DISMISS,
	enumMSG_ID_TEAM_LEAVE,
	enumMSG_ID_TEAM_REFUSE_INVITE,
	enumMSG_ID_TEAM_APPLY_INVITE_FAIL,
	enumMSG_ID_TEAM_APPLY_INVITE_FAIL2,
	enumMSG_ID_TEAM_SELF_ADD,
	enumMSG_ID_TEAM_ADDMEMBER_NOTVALID,
	enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL,
	enumMSG_ID_TEAM_CHANGE_CAPTAIN_FAIL2,
	enumMSG_ID_OBJ_CANNOT_PICKUP,
	enumMSG_ID_OBJ_TOO_FAR,
	enumMSG_ID_DEC_MONEY,
	enumMSG_ID_SPAR_VICTORY,
	enumMSG_ID_SPAR_DEFEAT,
	enumMSG_ID_TRADE_SELF_ROOM_FULL,
	enumMSG_ID_TRADE_DEST_ROOM_FULL,
	enumMSG_ID_TRADE_REFUSE_APPLY,
	enumMSG_ID_TRADEFOLKGAME_SELF_ROOM_FULL,
	enumMSG_ID_TRADEFOLKGAME_DEST_ROOM_FULL,
	enumMSG_ID_SPAR_REFUSE_APPLY,
	enumMSG_ID_GET_ITEM,
	enumMSG_ID_MONEY_CANNOT_PICKUP,
	enumMSG_ID_CANNOT_ADD_TEAM,
	enumMSG_ID_TEAM_IS_FULL,
	enumMSG_ID_CANNOT_INVITE_TEAM,
	enumMSG_ID_TARGET_CANNOT_ADD_TEAM,
	enumMSG_ID_GET_INVITE_TEAM_REPLY,
	enumMSG_ID_PK_NORMAL_NOT_OPEN,
	enumMSG_ID_PK_HIGHT_LOCK_NOT_SWITCH,
	enumMSG_ID_PKSTATE_NOT_OPEN,
	enumMSG_ID_PK_ERROR_1,
	enumMSG_ID_PK_ERROR_2,
	enumMSG_ID_PK_ERROR_3,
	enumMSG_ID_PK_ERROR_4,
	enumMSG_ID_PK_ERROR_5,
	enumMSG_ID_PK_ERROR_6,
	enumMSG_ID_PK_ERROR_7,
	enumMSG_ID_PK_ERROR_8,
	enumMSG_ID_PK_ERROR_9,
	enumMSG_ID_PK_IS_LOCK,
	enumMSG_ID_PK_IS_LOCK1,
	enumMSG_ID_PK_IS_LOCK2,
	enumMSG_ID_PK_IS_LOCK3,
	enumMSG_ID_PK_IS_LOCK4,
	enumMSG_ID_PK_IS_LOCK5,
	enumMSG_ID_PK_IS_LOCK6,
	enumMSG_ID_PK_IS_LOCK7,
	enumMSG_ID_TRADE_BUZY,
	enumMSG_ID_TRADE_SELLED,
	enumMSG_ID_TRADE_CLOSED,
	enumMSG_ID_DEATH_LOSE_ITEM,
	enumMSG_ID_TONG_REFUSE_ADD,
	enumMSG_ID_TONG_BE_KICK,
	enumMSG_ID_TONG_LEAVE_SUCCESS,
	enumMSG_ID_TONG_LEAVE_FAIL,
	enumMSG_ID_TONG_NO_MONEY,
	enumMSG_ID_TONG_CHANGE_AS_MASTER,
	enumMSG_ID_TONG_CHANGE_AS_MEMBER,
	enumMSG_ID_TONG_APPLY_ADD_ERROR,
	enumMSG_ID_TONG_APPLY_ADD_ERROR1,
	enumMSG_ID_TONG_APPLY_ADD_ERROR2,
	enumMSG_ID_TONG_APPLY_ADD_ERROR3,
	enumMSG_ID_TONG_APPLY_ADD_ERROR4,
	enumMSG_ID_TONG_APPLY_ADD_ERROR5,
	enumMSG_ID_TONG_APPLY_ADD_ERROR6,
	enumMSG_ID_TONG_APPLY_ADD_ERROR7,
	enumMSG_ID_FIGHT_MODE_ERROR1,
	enumMSG_ID_FIGHT_MODE_ERROR2,
	enumMSG_ID_FIGHT_MODE_ERROR3,
	enumMSG_ID_SHOP_NO_ROOM,
	enumMSG_ID_SHOP_NO_MONEY,
	enumMSG_ID_SHOP_NO_EXTPOINT,
	enumMSG_ID_SHOP_NO_FUYUAN,
	enumMSG_ID_SHOP_NO_REPUTE,
	enumMSG_ID_SHOP_NO_ACCUM,
	enumMSG_ID_SHOP_NO_HONOR,
	enumMSG_ID_SHOP_NO_RESPECT,
	enumMSG_ID_FUNCTION_CHAT_FORBIDDENED,
	enumMSG_ID_FUNCTION_FOBIDDENED,
	enumMSG_ID_FUNCTION_LOCKED,
	enumMSG_ID_LOCK_NOT_TRADE,
	enumMSG_ID_LOCK_NOT_SETPRICE,
	enumMSG_ID_LOCK_NOT_THROW,
	enumMSG_ID_ITEM_TOWNPORTAL,
	enumMSG_ID_ITEM_CANTREPAIR,
	enumMSG_ID_ITEM_SAME_IMMEDIATE,
	enumMSG_ID_ITEM_CANTPUT_IMMEDIATE,
	enumMSG_ID_HORSE_CANT_SWITCH1,
	enumMSG_ID_HORSE_CANT_SWITCH2,
	enumMSG_ID_CHATROOM_JOIN,
	enumMSG_ID_CHATROOM_LEAVE,
	enumMSG_ID_CHATROOM_BEKICK,
	enumMSG_ID_CHATROOM_OPENGAME,
	enumMSG_ID_CHATROOM_REVERSE,
	enumMSG_ID_NPC_RENASCENCE_SOMEONE,
	enumMSG_ID_NPC_RENASCENCE,
	enumMSG_ID_NUM,
};

//---------------------------- ???????????? ------------------------------
#define		MOUSE_CURSOR_NORMAL				0
#define		MOUSE_CURSOR_FIGHT				1
#define		MOUSE_CURSOR_DIALOG				2
#define		MOUSE_CURSOR_PICK				3
#define		MOUSE_CURSOR_USE				8
#define		MOUSE_CURSOR_TRADE				11
#define		MOUSE_CURSOR_FINGER				12
#define		MOUSE_CURSOR_HELP				13
#endif

