/*****************************************************************************************
//	´æµµ½ÇÉ«Ñ¡Ôñ
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-9-12

//	¡ö¡ö¹À¼Æ´ËÄ£¿é´úÂëÁ¿600-800ÐÐ£¬ÉÐÐè¹¤Ê±8-12Ð¡Ê±¡£¡ö¡ö
------------------------------------------------------------------------------------------
	´ËÄ£¿éÓÃÓÚ»ñÈ¡Íæ¼ÒÒÑ¾­ÓµÓÐµÄ½ÇÉ«µÄÐÅÏ¢£¬²¢¿ÉÒÔ½øÐÐÌí¼Ó/É¾³ý/ÔØÈë½ÇÉ«µÈ²Ù×÷¡£

	Ó¦Îª´ËÄ£¿é½«Á¬½Ó·þÎñÆ÷Ö´ÐÐ²Ù×÷£¬ËùÒÔµ÷ÓÃ·½·¨LoadData¡¢NewCharacter¡¢DeleteCharacter¡¢
SelCharacter£¬Á¢¼´·µ»ØµÄ¶¼ÊÇ(ÕûÊý±íÊ¾µÄ²¼¶ûÖµ)±íÊ¾·¢ËÍ²Ù×÷ÇëÇóÊÇ·ñ³É¹¦(0Öµ±íÊ¾Ê§°Ü£¬·Ç0Öµ
±íÊ¾³É¹¦)£¬¶ø²»ÊÇ²Ù×÷µÄÊµ¼Ê½á¹û¡£Í¨¹ýGetLastActionResult·½·¨¿ÉÒÔÖªµÀ×îºóÒ»´Î²Ù×÷µÄÖ´ÐÐ½á¹û¡£

	¹ØÓÚ´ËÄ£¿éµÄ×´Ì¬£º
	1 Ä£¿é³õÊ¼µÄÊ±ºòÊÇ'¿ÕÏÐ'×´Ì¬(SSC_S_IDLE)¡£
	2 µ÷ÓÃLoadData·½·¨ÇëÇóÔØÈë´æµµ½ÇÉ«Êý¾Ý£¬ÔØÈë½ÇÉ«Êý¾ÝÊ±´¦ÓÚ'ÔØÈë½ÇÉ«Êý¾ÝÖÐ'×´Ì¬(SSC_S_LOADING_DATA)£¬
	Èç¹û³É¹¦ÔòÇÐ»»Îª'½ÇÉ«ÒÑ¾­ÔØÈë'×´Ì¬(SSC_S_STANDBY)£¬Èç¹ûÊ§°ÜÔò·µ»Ø'¿ÕÏÐ'×´Ì¬(SSC_S_IDLE)¡£
	3 ´¦ÓÚSSC_S_STANDBY×´Ì¬µÄÊ±ºò¿ÉÒÔÖ´ÐÐNewCharacter¡¢DeleteCharacter¡¢SelCharacter²Ù×÷¡£
	4 ³É¹¦Ö´ÐÐNewCharacterºó×ªÈë'ÕýÔÚÐÂ½¨½ÇÉ«'×´Ì¬(SSC_S_CREATING_CHARACTER)£¬²Ù×÷½áÊøºó£¬
	ÎÞÂÛ³É¹¦Óë·ñ¶¼×ªÈëSSC_S_STANDBY×´Ì¬¡£²Ù×÷µÄÖ´ÐÐ½á¹ûÍ¨¹ýGetLastActionResult·½·¨»ñµÃ¡£
	5 ³É¹¦Ö´ÐÐDeleteCharacterºó×ªÈë'ÕýÔÚÉ¾³ý½ÇÉ«'×´Ì¬(SSC_S_DELETING_CHARACTER)£¬²Ù×÷½áÊøºó£¬
	ÎÞÂÛ³É¹¦Óë·ñ¶¼×ªÈëSSC_S_STANDBY×´Ì¬¡£²Ù×÷µÄÖ´ÐÐ½á¹ûÍ¨¹ýGetLastActionResult·½·¨»ñµÃ¡£
	6 ³É¹¦Ö´ÐÐSelCharacterºó×ªÈë'°Ñ½ÇÉ«ÔØÈëÓÎÏ·ÖÐ'×´Ì¬(SSC_S_LOADING_CHARACTER)£¬²Ù×÷½áÊøºó£¬
	³É¹¦Ôò×ªÈë'½ÇÉ«ÒÑ¾­³É¹¦ÔØÈëÓÎÏ·'×´Ì¬(SSC_S_LOAD_CHARACTER_LOADED)£¬Ê§°ÜÔó×ªÈëSSC_S_STANDBY
	×´Ì¬¡£
*****************************************************************************************/
#pragma once

#include "../../NetConnect/NetConnectAgent.h"

#ifndef MAX_PLAYER_PER_ACCOUNT
#define    MAX_PLAYER_PER_ACCOUNT    3
#endif

//=====================================
//	KSelSavedCharacterµÄ×´Ì¬¶¨Òå
//=====================================
enum SSC_STATUS {
    SSC_S_IDLE = 0,                //¿ÕÏÐ×´Ì¬
    SSC_S_LOADING_DATA,                //ÔØÈë½ÇÉ«Êý¾ÝÖÐ
    SSC_S_STANDBY,                    //½ÇÉ«ÒÑ¾­ÔØÈë
    SSC_S_LOADING_CHARACTER,        //°Ñ½ÇÉ«ÔØÈëÓÎÏ·ÖÐ
    SSC_S_LOAD_CHARACTER_LOADED,    //½ÇÉ«ÒÑ¾­³É¹¦ÔØÈëÓÎÏ·
    SSC_S_CREATING_CHARACTER,        //ÕýÔÚÐÂ½¨½ÇÉ«
    SSC_S_DELETING_CHARACTER,        //ÕýÔÚÉ¾³ý½ÇÉ«
};

//=====================================
//	KSelSavedCharacterµÄ²Ù×÷·µ»Ø½á¹û
//=====================================
enum SSC_RESULT {
    SSC_R_IN_PROGRESS = 0,    //²Ù×÷Ö´ÐÐÖÐ
    SSC_R_NOTHING,            //²Ù×÷Íê±Ï£¬Ã»ÓÐ±ä»¯
    SSC_R_UPDATE,            //¸üÐÂ
    SSC_R_INVALID_ROLENAME,    //ÐÂ½¨µÄ½ÇÉ«µÄÃû×Ö²»ºÏ·¨»òÒÔ´æÔÚ
    SSC_R_CREATE_ROLE_SUCCEED,//´´½¨½ÇÉ«³É¹¦
    SSC_R_START_GAME,        //¿ªÊ¼ÓÎÏ·
    SSC_R_SVR_DOWN,            //ÕÒ²»µ½ÓÐÐ§µÄ·þÎñÆ÷
    SSC_R_FAILED,            //Ê§°Ü
};

//=====================================
//	ÐÂ½¨½ÇÉ«Ê±ÐèÒªµÄ½ÇÉ«Ïà¹ØÐÅÏ¢½á¹¹
//=====================================
struct KNewCharacterInfo {
    char Name[32];
    unsigned char Gender;
    unsigned char Profession;
    union {
        unsigned short NativePlaceId;    //³öÉúµØID
        short nLevel;            //µÈ¼¶
    };
};

class KSelSavedCharacter {
public:
    KSelSavedCharacter();                //¹¹Ôìº¯Êý
    ~KSelSavedCharacter();                //Îö¹¹º¯Êý
    void AcceptNetMsg(void *pMsgData);//½ÓÊÜÍøÂçÏûÏ¢
    int LoadData();                    //¿ªÊ¼ÔØÈë½ÇÉ«Êý¾Ý
    int GetStatus();                //·µ»ØÖµÎªÃ·¾ÙSSC_STATUSµÄÈ¡ÖµÖ®Ò»£¬·µ»ØÖµº¬ÒåÇë¿´Ïà¹ØµÄÖµÉùÃ÷
    void SetLastActionResult(int nResult);        //ÉèÖÃ×îºóÒ»´Î²Ù×÷µÄ·µ»Ø½á¹û
    int GetLastActionResult();        //µÃµ½×îºóÒ»´Î²Ù×÷µÄ·µ»Ø½á¹û
    int GetCharacterNum();            //»ñÈ¡½ÇÉ«µÄÊýÄ¿
    int GetCharacterInfo(int nIndex, KNewCharacterInfo *pInfo);    //»ñÈ¡Ä³¸ö½ÇÉ«µÄÐÅÏ¢
    int NewCharacter(KNewCharacterInfo *pData);                    //ÇëÇóÐÂ½¨Ò»¸ö½ÇÉ«
    int DeleteCharacter(int nIndex, const char *pszPassword);    //ÇëÇóÉ¾³ýÒ»¸ö½ÇÉ«
    int SelCharacter(int nIndex);                                //Ñ¡ÔñÄ³¸ö½ÇÉ«
    void FreeData();                                                //ÊÍ·Å½ÇÉ«Êý¾Ý
    void SetCharacterBaseInfo(int nNum, const RoleBaseInfo *pInfo);

    void SetAccountName(const char *pAccount);

private:
    SSC_STATUS m_Status;
    RoleBaseInfo m_BaseInfo[MAX_PLAYER_PER_ACCOUNT];
    int m_nNumCharacter;    //½ÇÉ«µÄÊýÄ¿
    unsigned int m_nRequestTime;        //·¢³öÇéÇóµÄÊ±¼ä
    int m_nLastOperResult;    //ÉÏ´ÎµÄ²Ù×÷·µ»Ø½á¹û
    char m_AccountName[32];
    char m_szProcessingRoleName[32];
};
