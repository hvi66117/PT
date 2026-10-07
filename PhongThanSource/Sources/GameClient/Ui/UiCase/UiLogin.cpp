/*****************************************************************************************
//	????--login????
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-8-12
*****************************************************************************************/
#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "../UiBase.h"
#include "UiInformation.h"
#include "UiLogin.h"
#include "UiSelServer.h"
#include "UiLoginBg.h"
#include "UiConnectInfo.h"
#include "PhongThanNativeUiLayout.h"
#include "../../Login/Login.h"
#include "../UiSoundSetting.h"
#include <crtdbg.h>
#include "../../ENGINE/Src/KSG_MD5_String.h"

#define    SCHEME_INI_LOGIN                "UiLogin.ini"
#define    VNG_PAK_UI_LOGIN                0x5775C328UL


KUiLogin *KUiLogin::m_pSelf = NULL;

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KUiLogin::KUiLogin() {
    m_szLoginBg[0] = 0;
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KUiLogin::~KUiLogin() {
}

//--------------------------------------------------------------------------
//	????????????????????????????????????????
//--------------------------------------------------------------------------
KUiLogin *KUiLogin::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiLogin;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_POPUP_OUTGAME_WND);
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	????????????????????????????????????????????
//--------------------------------------------------------------------------
void KUiLogin::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        Wnd_SetFocusWnd(NULL);
        g_LoginLogic.SetRememberAccountFlag(m_pSelf->m_RememberAccount.IsButtonChecked() != 0);
        g_LoginLogic.SetLastInvisibleFlag(m_pSelf->m_Invisible.IsButtonChecked() != 0);
        if (bDestroy) {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        } else {
            m_pSelf->m_PassWord.Clear(true);
            m_pSelf->Hide();
        }
    }
}

void KUiLogin::Show() {
    KWndShowAnimate::Show();
    KUiLoginBackGround::SetConfig(m_szLoginBg);

    char szAccount[32];
    m_RememberAccount.CheckButton(g_LoginLogic.GetLoginAccount(szAccount));
    m_Invisible.CheckButton(g_LoginLogic.GetLoginLastInvisible());
    m_Account.SetText(szAccount);
    if (szAccount[0])
        Wnd_SetFocusWnd(&m_PassWord);
    else
        Wnd_SetFocusWnd(&m_Account);
}

//--------------------------------------------------------------------------
//	????????????
//--------------------------------------------------------------------------
void KUiLogin::Initialize() {
    AddChild(&m_Account);
    AddChild(&m_PassWord);
    AddChild(&m_Login);
    AddChild(&m_Cancel);
    AddChild(&m_Text);
    AddChild(&m_Invisible);
    AddChild(&m_RememberAccount);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    Wnd_AddWindow(this, WL_TOPMOST);
}

//--------------------------------------------------------------------------
//	????????????????????????
//--------------------------------------------------------------------------
void KUiLogin::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_LOGIN);
    if (Ini.LoadPakEntry(VNG_PAK_UI_LOGIN) || Ini.Load(Buff)) {
        int nScreenWidth, nScreenHeight, nOffsetX, nOffsetY;
        PhongThanGetNativeUiMetrics(nScreenWidth, nScreenHeight, nOffsetX, nOffsetY);
        PhongThanCenterIniWindow(Ini, "Main", nOffsetX, nOffsetY);

        KWndShowAnimate::Init(&Ini, "Main");
        m_Account.Init(&Ini, "Account");
        m_PassWord.Init(&Ini, "Password");
        m_Login.Init(&Ini, "Login");
        m_Cancel.Init(&Ini, "Cancel");
        m_Text.Init(&Ini, "Text");
        m_Invisible.Init(&Ini, "Invisible");
        m_RememberAccount.Init(&Ini, "Remember");
        Ini.GetString("Main", "LoginBg", "", m_szLoginBg, sizeof(m_szLoginBg));
    }
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// Force account/password hit-test before decorative controls.
//--------------------------------------------------------------------------
KWndWindow *KUiLogin::TopChildFromPoint(int x, int y) {
    if (m_Account.PtInWindow(x, y) && !m_Account.IsDisable())
        return &m_Account;
    if (m_PassWord.PtInWindow(x, y) && !m_PassWord.IsDisable())
        return &m_PassWord;
    return KWndShowAnimate::TopChildFromPoint(x, y);
}
int KUiLogin::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_Login) {
                OnLogin();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_Cancel)
                OnCancel();
            break;
        case WND_N_EDIT_SPECIAL_KEY_DOWN:
            if (nParam == VK_TAB) {
                if ((GetKeyState(VK_SHIFT) & 0x8000) == 0) {
                    // ????????????Shift
                    if (uParam == (unsigned int) (KWndWindow *) &m_Account) {
                        int x, y, cx;
                        m_PassWord.GetAbsolutePos(&x, &y);
                        m_PassWord.GetSize(&cx, NULL);
                        Wnd_SetCursorPos(x + cx, y);
                        Wnd_SetFocusWnd(&m_PassWord);
                        nRet = 1;
                    } else if (uParam == (unsigned int) (KWndWindow *) &m_PassWord) {
                        Wnd_SetFocusWnd(NULL);
                        m_Login.SetCursorAbove();
                        nRet = 1;
                    }
                } else {
                    // ????????Shift
                    if (uParam == (unsigned int) (KWndWindow *) &m_Account) {
                        Wnd_SetFocusWnd(NULL);
                        m_Cancel.SetCursorAbove();
                        nRet = 1;
                    } else if (uParam == (unsigned int) (KWndWindow *) &m_PassWord) {
                        int x, y, cx;
                        m_Account.GetAbsolutePos(&x, &y);
                        m_Account.GetSize(&cx, NULL);
                        Wnd_SetCursorPos(x + cx, y);
                        Wnd_SetFocusWnd(&m_Account);

                        nRet = 1;
                    }
                }
            } else if (nParam == VK_RETURN) {
                if (uParam == (unsigned int) (KWndWindow *) &m_Account) {
                    Wnd_SetFocusWnd(&m_PassWord);
                    nRet = 1;
                } else if (uParam == (unsigned int) (KWndWindow *) &m_PassWord) {
                    OnLogin();
                    nRet = 1;
                }
            } else if (nParam == VK_ESCAPE) {
                OnCancel();
                nRet = 1;
            }
            break;
        case WM_KEYDOWN:
            OnKeyDown(uParam);
            nRet = 1;
            break;
        case WM_SYSKEYDOWN:
            if (uParam == 'A')
                OnEnableAutoLogin();
            break;
        default:
            nRet = KWndShowAnimate::WndProc(uMsg, uParam, nParam);
            break;
    }
    return nRet;
}

void KUiLogin::OnEnableAutoLogin() {
    KIniFile *pSetting = g_UiBase.GetCommConfigFile();
    int nAutoLogin = false;
    if (pSetting) {
        pSetting->GetInteger("Main", "AutoLogin", 0, &nAutoLogin);
        g_UiBase.CloseCommConfigFile();
    }
    if (nAutoLogin == 6323) {
        g_LoginLogic.SetRememberAllFlag(true);
        m_RememberAccount.CheckButton(true);
    }
}

void KUiLogin::OnKeyDown(unsigned int uKey) {
    if (uKey == VK_RETURN) {
        if (m_Cancel.IsButtonActive())
            OnCancel();
        else
            OnLogin();
    } else if (uKey == VK_TAB) {
        if ((GetKeyState(VK_SHIFT) & 0x8000) == 0) {
            // ????????????Shift
            if (m_Login.IsButtonActive())
                m_RememberAccount.SetCursorAbove();
            else if (m_RememberAccount.IsButtonActive())
                m_Cancel.SetCursorAbove();
            else {
                int x, y, cx;
                m_Account.GetAbsolutePos(&x, &y);
                m_Account.GetSize(&cx, NULL);
                Wnd_SetCursorPos(x + cx, y);
                Wnd_SetFocusWnd(&m_Account);
            }
        } else {
            // ????????Shift
            if (m_Login.IsButtonActive()) {
                int x, y, cx;
                m_PassWord.GetAbsolutePos(&x, &y);
                m_PassWord.GetSize(&cx, NULL);
                Wnd_SetCursorPos(x + cx, y);
                Wnd_SetFocusWnd(&m_PassWord);
            } else if (m_RememberAccount.IsButtonActive()) {
                m_Login.SetCursorAbove();
            } else   // if m_Cancel.IsButtonActive()
            {
                m_RememberAccount.SetCursorAbove();
            }

        }
    } else if (uKey == VK_SPACE) {
        if (m_Login.IsButtonActive())
            OnLogin();
        else if (m_Cancel.IsButtonActive())
            OnCancel();
        else if (m_RememberAccount.IsButtonActive())
            m_RememberAccount.CheckButton(!m_RememberAccount.IsButtonChecked());
        else if (m_Invisible.IsButtonActive())
            m_Invisible.CheckButton(!m_Invisible.IsButtonChecked());
    } else if (uKey == VK_LEFT)
        m_Login.SetCursorAbove();
    else if (uKey == VK_RIGHT)
        m_Cancel.SetCursorAbove();
    else if (uKey == VK_ESCAPE)
        OnCancel();
}

//--------------------------------------------------------------------------
//	??????????
//--------------------------------------------------------------------------
void KUiLogin::OnLogin() {
    char szAccount[32];
    char szPassword[KSG_PASSWORD_MAX_SIZE];
    KSG_PASSWORD Password;

    int nLen = m_Account.GetText(szAccount, sizeof(szAccount), false);

    int i = 0;
    for (i = 0; i < nLen;) {
        unsigned char cCode = (unsigned char) szAccount[i];
        if (cCode > 0x80)
            i++;
        else if (cCode <= 0x20 || cCode > 0x7e)
            break;
        else
            i++;
    }

    if (i < nLen) {
        CloseWindow(false);
        //g_DebugLog("i < nLen %d < %d", i < nLen);

        //Neu nLen ma nho hon input hoac ky tu khong hop le co khoang trong' thi return.
        KUiConnectInfo::OpenWindow(CI_MI_INVALID_KYTU_DACBIET_INPUT, CI_NS_LOGIN_WND);

        return;
    }

    if (GetInputInfo(szAccount, szPassword)) {
        KSG_StringToMD5String(Password.szPassword, szPassword);

        //TamLTM check doi khi load nhan vat thanh cong, th? connect den tro choi.
        Sleep(2);

        g_LoginLogic.AccountLogin(szAccount, Password);
        KUiConnectInfo::OpenWindow(CI_MI_CONNECTING, LL_S_ROLE_LIST_READY);
        memset(&szPassword, 0, sizeof(szPassword));
        memset(&Password, 0, sizeof(Password));
        CloseWindow(false);
    }
}

//--------------------------------------------------------------------------
//	??????????
//--------------------------------------------------------------------------
void KUiLogin::OnCancel() {
    CloseWindow(false);
    g_LoginLogic.ReturnToIdle();
    KUiSelServer::OpenWindow();    //??????????????????????????????????
}

//--------------------------------------------------------------------------
//	????????????????????????????
//--------------------------------------------------------------------------
int KUiLogin::GetInputInfo(char *pszAccount, char *pszPassword) {
    _ASSERT(pszAccount && pszPassword);
    if (m_Account.GetText(pszAccount, 32, false) &&
        m_PassWord.GetText(pszPassword, 32, false)) {
        return true;
    }
    CloseWindow(false);
    KUiConnectInfo::OpenWindow(CI_MI_ERROR_LOGIN_INPUT, CI_NS_LOGIN_WND);
    return false;
    /* int nLen = m_Account.GetText(m_szAccount, 32, false);
    unsigned char	cCode;
    if (nLen >= LOGIN_ACCOUNT_MIN_LEN && nLen <= LOGIN_ACCOUNT_MAX_LEN)
    {
        for (int i = 0; i < nLen;)
        {
            cCode = (unsigned char)m_szAccount[i];
            if (i + 2 <= nLen && cCode >= 0x81 && cCode <= 0xfe &&
                (cCode <= 0xa0 || cCode >= 0xaa))
            {
                i += 2;
            }
            else if ((cCode >= 0x30 && cCode <= 0x39) ||
                (cCode >= 0x41 && cCode <= 0x5a) ||
                (cCode >= 0x61 && cCode <= 0x7a))
            {
                i++;
            }
            else
                break;
        }

        if (i == nLen)
        {
            nLen = m_PassWord.GetText(m_szPassword, 32, false);
            if (IsValidPwd(m_szPassword, nLen))
                return true;
        }
    }

    KUiConnectInfo::OpenWindow(CI_MI_ACCOUNT_PWD_ERROR, CI_AE_BACK_TO_LOGIN);
    CloseWindow(false);
    return false;*/
}

bool KUiLogin::IsValidPassword(const char *pszPassword, int nLen) {
    return true;    //to be del this line;

    if (pszPassword) {
        if (nLen < 0)
            nLen = strlen(pszPassword);

        if (nLen >= LOGIN_PASSWORD_MIN_LEN && nLen <= LOGIN_PASSWORD_MAX_LEN) {
            for (int i = 0; i < nLen; i++) {
                unsigned char cCode = (unsigned char) pszPassword[i];
                if ((cCode < 0x30 || cCode > 0x39) &&
                    (cCode < 0x41 || cCode > 0x5a) &&
                    (cCode < 0x61 || cCode > 0x7a)) {
                    break;
                }
                if (i == nLen)
                    return true;
            }
        }
    }
    return false;
}

