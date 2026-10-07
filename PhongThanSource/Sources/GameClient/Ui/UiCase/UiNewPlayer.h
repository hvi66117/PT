// -------------------------------------------------------------------------
//	ÎÄ¼þÃû		£º	UiNewPlayer.h
//	´´½¨Õß		£º	Åí½¨²¨
//	´´½¨Ê±¼ä	£º	2002-9-10 14:25:21
//	¹¦ÄÜÃèÊö	£º	½ÇÉ«ÐÂ½¨½çÃæ£­1
//
// -------------------------------------------------------------------------
#ifndef __UINEWPLAYER_H__
#define __UINEWPLAYER_H__

#include "../Elem/WndImage.h"
#include "../Elem/WndEdit.h"
#include "../Elem/WndButton.h"
#include "../Elem/WndShowAnimate.h"
#include "../Elem/WndShadow.h"
#include "../../Login/Login.h"


class KUiNewPlayer : protected KWndShowAnimate {
public:
    //----½çÃæÃæ°åÍ³Ò»µÄ½Ó¿Úº¯Êý----
    static KUiNewPlayer *OpenWindow(int nNativePlaceId);//´ò¿ª´°¿Ú£¬·µ»ØÎ¨Ò»µÄÒ»¸öÀà¶ÔÏóÊµÀý
    static void CloseWindow(bool bDestroy);        //¹Ø±Õ´°¿Ú£¬Í¬Ê±¿ÉÒÔÑ¡ÔòÊÇ·ñÉ¾³ý¶ÔÏóÊµÀý

private:
    KUiNewPlayer();

    ~KUiNewPlayer();

    bool Initialize();
    bool LoadScheme(const char *pScheme);
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnClickButton(KWndWindow *pWnd);    //ÏìÓ¦µã»÷°´Å¥
    int GetInputInfo();

    void OnOk();                                //Íê³É½ÇÉ«Ñ¡Ôñ½çÃæ
    void OnCancel();                            //·µ»Ø¡°½ÇÉ«Ñ¡Ôñ½çÃæ¡±
    void SelGender();

private:
    static KUiNewPlayer *m_pSelf;

    void UpdateProperty();                //¸üÐÂÊôÐÔËµÃ÷
    void Breathe();

    int CheckKyTuDatBieString(char *lpstrBuffer, char *lpstrControl);

private:
    KWndEdit32 m_Name;                        // ÐÕÃû
    KWndButton m_OK;                        // È·¶¨
    KWndButton m_Cancel;                    // È¡Ïû
    KWndButton m_Male, m_Female;            // ÐÔ±ð°´Å¥

    KWndText256 m_PropertyShow;                // ÊôÐÔËµÃ÷
    KWndButton m_GiapSi;
    KWndButton m_DaoSi;
    KWndButton m_DiNhan;
    KWndButton m_Container;
    KWndButton m_ProfessionBanner;
    KRoleChiefInfo m_Info;
    char m_szLoginBg[32];
    char m_szPlayerImgPrefix[128];
    int m_NativePlaces[PHONGTHAN_PROFESSION_COUNT];
    int m_bJustClicked;
    struct PROPTYPEINFO {
        KWndWindow *pBtn;
        int nShowTextLen;
        char propertyShow[256];        //ÊôÐÔËµÃ÷
        char szMaleImg[128];
        char szFemaleImg[128];
        char szMaleSound[128];
        char szFemaleSound[128];
        char szProfession[128];
    } m_propTypeInfoTable[PHONGTHAN_PROFESSION_COUNT];
};

const char *PROFESSION_GetTitleString(int nProfession);

#endif // __UINEWPLAYER_H__
