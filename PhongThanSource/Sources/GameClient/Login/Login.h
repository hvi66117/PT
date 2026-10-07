/*****************************************************************************************
//	ÓÎÏ·µÄµÇÂ½Á¬½Ó¹¦ÄÜÂß¼­Ä£¿é
//	Copyright : Kingsoft 2002-2003
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-8-13
------------------------------------------------------------------------------------------
	×´Ì¬»ú
    ²Î¿´KLoginDef.hÎÄ¼þ»ñµÃÏà¹ØÒ»Ð©µÇÂ½Ïà¹ØÐÅÏ¢¡£
*****************************************************************************************/
#pragma once

#include "LoginDef.h"
#include "../NetConnect/NetMsgTargetObject.h"
#include "../../../Headers/PhongThanProtocol.h"
#include "PhongThanLoginRole.h"

#define $MAX_ACCOUNT_LIST        10
#define    $ACCOUNT_LIST            "AccountList"
#define    $RECENT_FIRST_ACCOUNT    "RecentAccount0"
#define    $RECENT_ACCOUNT            "RecentAccount%d"


enum LOGIN_LOGIC_STATUS {
    LL_S_IDLE = 0,                    //¿ÕÏÐ
    LL_S_WAIT_INPUT_ACCOUNT,        //µÈ´ý´«ÕËºÅÃÜÂë
    LL_S_ACCOUNT_CONFIRMING,        //µÈ´ýÕËºÅÃÜÂëÑéÖ¤
    LL_S_WAIT_ROLE_LIST,            //µÈ´ý½ÓÊÕ½ÇÉ«ÁÐ±íÊý¾Ý
    LL_S_ROLE_LIST_READY,            //½ÇÉ«ÁÐ±í¾ÍÐ÷
    LL_S_CREATING_ROLE,                //ÕýÔÚÐÂ½¨½ÇÉ«
    LL_S_DELETING_ROLE,                //ÕýÔÚÉ¾³ý½ÇÉ«
    LL_S_WAIT_TO_LOGIN_GAMESERVER,    //µÈ´ýµÇÂ½ÓÎÏ··þÎñÆ÷
    LL_S_ENTERING_GAME,                //ÕýÔÚ½øÈëÓÎÏ·
    LL_S_IN_GAME,                    //ÓÎÏ·ÔËÐÐÊ±
    LL_S_INVALID_PROTOCOLVERSION,
    LL_S_ACCOUNT_LOCKED,
};

enum LOGIN_LOGIC_RESULT_INFO {
    LL_R_NOTHING,                    //ÎÞ½á¹ûÐÅÏ¢
    LL_R_CONNECT_FAILED,            //Á¬½ÓÊ§°Ü
    LL_R_CONNECT_SERV_BUSY,            //·þÎñÆ÷Ã¦
    LL_R_CONNECT_TIMEOUT,            //Á¬½Ó³¬Ê±Î´»ñµÃÏìÓ¦
    LL_R_ACCOUNT_PWD_ERROR,            //ÕËºÅ/ÃÜÂë´íÎó
    LL_R_ACCOUNT_FREEZE,            //ÕËºÅ¶³½á
    LL_R_ACCOUNT_LOCKED,            //ÕËºÅ±»Ëø¶¨
    LL_R_INVALID_ROLENAME,            //(ÐÂ½¨)½ÇÉ«µÄÃû×Ö²»ºÏ·¨
    LL_R_SERVER_SHUTDOWN,            //ÓÎÏ··þÎñÆ÷ÒÑÂú»òÕýÔÚÎ¬»¤ÖÐ
    LL_R_INVALID_PROTOCOLVERSION,    //°æ±¾ºÅ½Ï¾É£¬ÐèÒªÉý¼¶µ½ÐÂµÄ¿Í»§¶Ë
    LL_R_INVALID_PASSWORD,            //£¨É¾³ý½ÇÉ«Ê±£©Ìá¹©µÄÃÜÂë´íÎó

    LL_R_ACCOUNT_CONFIRM_SUCCESS,    //ÕËºÅÑéÖ¤³É¹¦
    LL_R_CREATE_ROLE_SUCCESS,        //´´½¨½ÇÉ«³É¹¦
    LL_R_LOGIN_TO_GAMESERVER,        //¿ªÊ¼ÁËÓëÓÎÏ·ÊÀ½ç·þÎñÆ÷µÄÁ¬½Ó
    LL_R_ACCOUNT_NOT_ENOUGH_POINT,    //ÕËºÅµãÊý²»×ã
    LL_R_ACCOUNT_ENOUGH,            //only 3 acc
};

#ifndef MAX_PLAYER_PER_ACCOUNT
#define    MAX_PLAYER_PER_ACCOUNT    3
#endif

//=====================================
//	ÐÂ½¨½ÇÉ«Ê±ÐèÒªµÄ½ÇÉ«Ïà¹ØÐÅÏ¢½á¹¹
//=====================================

struct KLoginServer {
    char Title[32];        //·þÎñÆ÷ÎÄ×ÖËµÃ÷
    unsigned char Address[4];        //·þÎñÆ÷ipµØÖ·
};

class KLogin : public iKNetMsgTargetObject {
public:
    KLogin();                                //¹¹Ôìº¯Êý
    ~KLogin();                                //Îö¹¹º¯Êý

    //====iKNetMsgTargetObject½Ó¿Úº¯Êý====
    void AcceptNetMsg(void *pMsgData);    //½ÓÊÜÍøÂçÏûÏ¢

    //====²Ù×÷º¯Êý£¬ËüÃÇÒ»°ãÒý·¢×´Ì¬Ô¾Ç¨====
    //Óë£¨ÕËºÅ£©·þÎñÆ÷½¨Á¢Á¬½Ó
    int CreateConnection(const unsigned char *pAddress);

    //´«ÈëÕÊºÅÃÜÂë£¬ÕËºÅµÇÂ½
    int AccountLogin(const char *pAccount, const KSG_PASSWORD &crPassword, bool bOrignPassword = true);

    //Ñ¡ÖÐÓÎÏ·½ÇÉ«
    int SelectRole(int nIndex);

    //ÇëÇóÐÂ½¨ÓÎÏ·½ÇÉ«
    int CreateRole(KRoleChiefInfo *pCreateInfo);

    //ÇëÇóÉ¾³ýÓÎÏ·½ÇÉ«
    int DeleteRole(int nIndex, const KSG_PASSWORD &crSupperPassword);

    //Í¨ÖªµÈ´ý·µ»Ø½á¹û³¬Ê±ÁË
    void NotifyTimeout();

    //Í¨ÖªÒª¿ªÊ¼ÓÎÏ·ÁË
    void NotifyToStartGame();

    //Í¨ÖªÍøÂçÁ¬½Ó£¨ÒâÍâ£©¶Ï¿ªÁË
    void NotifyDisconnect();

    //»Øµ½¿ÕÏÐ×´Ì¬
    void ReturnToIdle();

    //È«³Ì×Ô¶¯Á¬½Ó
    void AutoLogin();

    //ÅÐ¶ÏÊÇ·ñ¿ÉÒÔÖ´ÐÐÈ«³Ì×Ô¶¯Á¬½Ó
    int IsAutoLoginEnable();

    //ÉèÖÃ¼ÍÂ¼±ê¼Ç
    void SetRememberAccountFlag(bool bEnable);

    //ÉèÖÃ¼ÍÂ¼±ê¼Ç
    void SetRememberAllFlag(bool bEnable);

    void SetVirtualKeyboardFlag(bool bEnable);

    void SetLastInvisibleFlag(int nEnable);


    //====Êý¾Ý»ñÈ¡º¯Êý====
    //»ñÈ¡µÇÂ½Âß¼­µ±Ç°µÄ×´Ì¬
    LOGIN_LOGIC_STATUS GetStatus() { return m_Status; }

    //»ñÈ¡²Ù×÷µÄ½á¹ûÐÅÏ¢
    LOGIN_LOGIC_RESULT_INFO GetResult();

    //»ñÈ¡½ÇÉ«µÄÊýÄ¿
    int GetRoleCount(int &nAdviceChoice);

    //»ñÈ¡Ä³¸ö½ÇÉ«µÄÐÅÏ¢
    int GetRoleInfo(int nIndex, KRoleChiefInfo *pInfo);

    //±£´æµÇÂ½Ñ¡Ôñ
    void SaveLoginChoice();

    //¶ÁÈ¡ÒÔÇ°µÄµÄµÇÂ½Ñ¡Ôñ
    void LoadLoginChoice();

    void GetRegionServer(char *pszRegion, char *pszServer);

    //»ñÈ¡·þÎñÆ÷ÇøÓòµÄÁÐ±í
    KLoginServer *GetServerRegionList(int &nCount, int &nAdviceChoice);

    //µÇÂ½·þÎñÆ÷ÁÐ±í»ñÈ¡
    KLoginServer *GetServerList(int nRegion, int &nCount, int &nAdviceChoice);

    //»ñÈ¡½¨Òé£¨¾ÉµÄ£©µÇÂ½ÕËºÅ
    bool GetLoginAccount(char *pszAccount);

    int GetLoginLastInvisible();

    bool GetLoginVirtualKeyboard();

    //È¡µÃµ±Ç°ÕËºÅµÄÊ£ÓàÊ±¼ä
    DWORD GetAccountLifeTime() { return m_LeftTime; }

    int GetAccountLeftLockTime() { return m_LeftLockTime; }

    //ÅÐ¶Ïµ±Ç°½ÇÉ«ÊÇ·ñÎªÐÂ½¨µÄ½ÇÉ«
    int IsRoleNewCreated() { return m_Choices.bIsRoleNewCreated; }

    //ÉèÖÃÑ¡ÖÐµÄ·þÎñÆ÷£¬ÓÃÀ´´æÅÌ
    int SetAccountServer(const KLoginServer &rcSelectServer);

    void GetAccountPassword(char *pszAccount, KSG_PASSWORD *pPassword);

private:
    //====¸÷²Ù×÷µÄÍøÂçÏìÓ¦µÄ·µ»Ø´¦Àí====
    void ProcessAccountLoginResponse(PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE *pResponse);
    void ProcessRoleListResponse(PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE *pResponse);
    void ProcessDeleteRoleResponse(PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE *pResponse);
    void ProcessCreateRoleResponse(PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE *pResponse);
    void ProcessToLoginGameServResponse(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE *pResponse);

    //·¢ËÍÏûÏ¢ÇëÇó
    int Request(const char *pszAccount, const KSG_PASSWORD *pcPassword);

    //Á¬½ÓÕËºÅ·þÎñÆ÷
    int ConnectAccountServer(const unsigned char *pIpAddress);

    void RegistNetAgent();

    void UnRegistNetAgent();

    void SetAccountPassword(const char *pszAccount, const KSG_PASSWORD *pcPassword);

    void ClearAccountPassword(bool bAccount, bool bPassword);

private:
    LOGIN_LOGIC_STATUS m_Status;
    LOGIN_LOGIC_RESULT_INFO m_Result;

    bool m_bInAutoProgress;                //ÊÇ·ñÕý´¦ÓÚ×Ô¶¯µÇÂ½¹ý³ÌÖÐ
    bool m_bReserved;
    short m_nNumRole;                        //½ÇÉ«µÄÊýÄ¿
    KRoleChiefInfo m_RoleList[MAX_PLAYER_PER_ACCOUNT];
    DWORD m_LeftTime;
    int m_LeftLockTime;

    struct LOGIN_CHOICE {
        char RegionName[32];
        KLoginServer AccountServer;                //µ±Ç°Ê¹ÓÃµÄ·þÎñÆ÷
        char Account[32];                //µ±Ç°ÕËºÅ
        KSG_PASSWORD Password;                    //µ±Ç°ÕËºÅµÄÃÜÂë
        char szProcessingRoleName[32];    //µ±Ç°´¦ÀíµÄ½ÇÉ«µÄÃû×Ö
        bool bRememberAccount;            //ÊÇ·ñ¼ÍÂ¼µÇÂ½ÕËºÅ
        int nLastInvisible;
        bool bRememberAll;                //ÊÇ·ñ¼ÍÂ¼È«²¿µÄµÇÂ½Ñ¡Ôñ
        bool bAutoLoginEnable;            //ÊÇ·ñÔÊÐí×Ô¶¯µÇÂ½
        bool bIsRoleNewCreated;            //µ±Ç°½ÇÉ«ÊÇ·ñÎªÐÂ½¨µÄ½ÇÉ«
        bool bLoaded;                    //ÊÇ·ñÒÑ¼ÓÔØÑ¡Ôñ¼ÍÂ¼
        bool bVirtualKeyboard;            //ÊÇ·ñ¼ÍÂ¼µÇÂ½ÕËºÅ
    } m_Choices;
};

extern KLogin g_LoginLogic;
