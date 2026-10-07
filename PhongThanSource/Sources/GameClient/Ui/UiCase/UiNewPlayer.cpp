#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "UiNewPlayer.h"
#include "UiInformation.h"
#include "UiLoginBg.h"
#include "UiConnectInfo.h"
#include "PhongThanNativeUiLayout.h"
#include "PhongThanRoleCreationLayout.h"
#include "UiSelPlayer.h"
#include "../UiBase.h"
#include "../UiShell.h"
#include "../UiSoundSetting.h"
#include "../../../core/src/gamedatadef.h"
#include "../../../core/src/coreshell.h"
#include "../../../Engine/Src/Text.h"
#include "../../../Engine/Src/KDebug.h"
#include <crtdbg.h>

extern iCoreShell *g_pCoreShell;

#define    SCHEME_INI_NEWPLAYER    "UiNewPlayer.ini"
#define    PROFESSION_INI            "\\Ui\\Profession.ini"

//TamLTM check ky tu dat biet
#define CHECK_KEY_KY_TU_DAT_BIET_INPUT_LOGIN    "!@#$%^&*()|?'{ },./;<>"

static const char *s_szProfessionSectionList[PHONGTHAN_PROFESSION_COUNT] =
        {
                "GiapSi",
                "DaoSi",
                "DiNhan",
        };

const char *PROFESSION_GetTitleString(int nProfession) {
    _ASSERT(nProfession >= 0 && nProfession < PHONGTHAN_PROFESSION_COUNT);
    return (s_szProfessionSectionList[nProfession]);
}

KUiNewPlayer *KUiNewPlayer::m_pSelf = NULL;

KUiNewPlayer::KUiNewPlayer() {
    memset(&m_Info, 0, sizeof(m_Info));
    m_Info.Profession = PHONGTHAN_PROFESSION_GIAP_SI;
    m_Info.Gender = OBJ_G_MALE;
    m_szLoginBg[0] = 0;
    m_szPlayerImgPrefix[0] = 0;
    m_bJustClicked = false;
    memset(m_NativePlaces, 0, sizeof(m_NativePlaces));
    memset(&m_propTypeInfoTable, 0, sizeof(m_propTypeInfoTable));
    m_propTypeInfoTable[0].pBtn = (KWndWindow *) &m_GiapSi;
    m_propTypeInfoTable[1].pBtn = (KWndWindow *) &m_DaoSi;
    m_propTypeInfoTable[2].pBtn = (KWndWindow *) &m_DiNhan;
}

//--------------------------------------------------------------------------
//	���ܣ��򿪴��ڣ�����Ψһ��һ�������ʵ��
//--------------------------------------------------------------------------
KUiNewPlayer *KUiNewPlayer::OpenWindow(int nNativePlaceId) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiNewPlayer;
        if (m_pSelf && !m_pSelf->Initialize()) {
            delete m_pSelf;
            m_pSelf = NULL;
            MessageBox(NULL, "Khong nap duoc giao dien tao nhan vat VNG. Xem role_creation_diag.log.",
                       "Phong Than", MB_OK | MB_ICONERROR);
        }
    }
    if (m_pSelf) {
        m_pSelf->m_Info.NativePlaceId = nNativePlaceId;
        UiSoundPlay(UI_SI_POPUP_OUTGAME_WND);
        m_pSelf->UpdateProperty();
        KUiLoginBackGround::SetConfig(m_pSelf->m_szLoginBg);
        m_pSelf->Show();
    }
    return m_pSelf;
}

KUiNewPlayer::~KUiNewPlayer() {
    for (int i = 0; i < PHONGTHAN_PROFESSION_COUNT; i++)
        m_propTypeInfoTable[i].pBtn = 0;
}

//--------------------------------------------------------------------------
//	���ܣ��رմ��ڣ�ͬʱ����ѡ���Ƿ�ɾ������ʵ��
//--------------------------------------------------------------------------
void KUiNewPlayer::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        if (bDestroy == false)
            m_pSelf->Hide();
        else {
            m_pSelf->m_Name.Clear(false);
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
    }
}

//--------------------------------------------------------------------------
//	���ܣ���ʼ��
//--------------------------------------------------------------------------
bool KUiNewPlayer::Initialize() {
    AddChild(&m_Male);
    AddChild(&m_Female);
    AddChild(&m_Container);
    AddChild(&m_PropertyShow);
    AddChild(&m_Name);
    AddChild(&m_OK);
    AddChild(&m_Cancel);
    AddChild(&m_GiapSi);
    AddChild(&m_DaoSi);
    AddChild(&m_DiNhan);

    char Buff[256];
    KIniFile Ini;
    if (Ini.Load(PROFESSION_INI)) {
        for (int i = 0; i < PHONGTHAN_PROFESSION_COUNT; i++) {
            Ini.GetString(s_szProfessionSectionList[i], "PropText", "", Buff, sizeof(Buff));
            m_propTypeInfoTable[i].nShowTextLen = strlen(Buff);
            m_propTypeInfoTable[i].nShowTextLen = TEncodeText(Buff, m_propTypeInfoTable[i].nShowTextLen);
            memcpy(m_propTypeInfoTable[i].propertyShow, Buff, m_propTypeInfoTable[i].nShowTextLen);

            Ini.GetString(s_szProfessionSectionList[i], "SelSound_m", "",
                          m_propTypeInfoTable[i].szMaleSound, sizeof(m_propTypeInfoTable[i].szMaleSound));
            Ini.GetString(s_szProfessionSectionList[i], "SelSound_f", "",
                          m_propTypeInfoTable[i].szFemaleSound, sizeof(m_propTypeInfoTable[i].szFemaleSound));

            Ini.GetString(s_szProfessionSectionList[i], "SelProfession", "",
                          m_propTypeInfoTable[i].szProfession, sizeof(m_propTypeInfoTable[i].szProfession));
        }
    }

    g_UiBase.GetCurSchemePath(Buff, 256);
    if (!LoadScheme(Buff))
        return false;

    Wnd_AddWindow(this, WL_TOPMOST);
    return true;
}

void KUiNewPlayer::SelGender() {
    char szFile[128];
    bool bMale = (m_Info.Gender == OBJ_G_MALE);
    KUiSelPlayer::GetRoleImageName(szFile, m_szPlayerImgPrefix, false, m_Info.Profession, bMale ? 1 : 2);
    m_Male.CheckButton(bMale);
    m_Male.SetImage(ISI_T_SPR, szFile);
    m_Male.SetFrame(0);

    KUiSelPlayer::GetRoleImageName(szFile, m_szPlayerImgPrefix, true, m_Info.Profession, bMale ? 2 : 1);
    m_Female.CheckButton(!bMale);
    m_Female.SetImage(ISI_T_SPR, szFile);
    m_Female.SetFrame(0);

    Wnd_SetFocusWnd(&m_Name);
    m_bJustClicked = true;
    UiSoundPlay(m_Info.Gender == OBJ_G_MALE ?
                m_propTypeInfoTable[m_Info.Profession].szMaleSound :
                m_propTypeInfoTable[m_Info.Profession].szFemaleSound);
}

//--------------------------------------------------------------------------
//	���ܣ����봰�ڵĽ��淽��
//--------------------------------------------------------------------------
bool KUiNewPlayer::LoadScheme(const char *pScheme) {
    char Buff[300];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_NEWPLAYER);
    if (Ini.LoadPakEntry(PHONGTHAN_PAK_NEWPLAYER) || Ini.Load(Buff)) {
        int width, height, offsetX, offsetY;
        PhongThanGetNativeUiMetrics(width, height, offsetX, offsetY);
        if (!PhongThanAdaptRoleCreationLayout(Ini, width, height))
            return false;
        // The runtime map catalog namespaces VNG source IDs as 1000+ID.
        // Require the mapped entry to exist before allowing character creation.
        KIniFile worlds;
        if (!worlds.Load("\\settings\\WorldSet.ini"))
            return false;
        for (int p = 0; p < PHONGTHAN_PROFESSION_COUNT; ++p) {
            char key[24], mapName[128];
            sprintf(key, "%d", p);
            int originalMap = 0;
            Ini.GetInteger("Nativeplace", key, 0, &originalMap);
            m_NativePlaces[p] = originalMap > 0 && originalMap < 1000 ? originalMap + 1000 : originalMap;
            sprintf(key, "%d", m_NativePlaces[p]);
            if (!worlds.GetString("List", key, "", mapName, sizeof(mapName)) || !mapName[0])
                return false;
        }
        Init(&Ini, "NewPlayer");
        Ini.GetString("NewPlayer", "LoginBg", "", m_szLoginBg, sizeof(m_szLoginBg));
        Ini.GetString("NewPlayer", "PlayerImgPrefix", "", m_szPlayerImgPrefix, sizeof(m_szPlayerImgPrefix));

        m_Male.Init(&Ini, "Male");
        m_Female.Init(&Ini, "Female");
        m_Male.RemoveImage();
        m_Female.RemoveImage();
        m_Name.Init(&Ini, "Name");
        m_OK.Init(&Ini, "OK");
        m_Cancel.Init(&Ini, "Cancel");
        m_Container.Init(&Ini, "EditBG");
        m_PropertyShow.Init(&Ini, "PropertyShow");

        for (int i = 0; i < PHONGTHAN_PROFESSION_COUNT; i++) {
            m_propTypeInfoTable[i].pBtn->Init(&Ini, PHONGTHAN_NEWPLAYER_SECTIONS[i]);
            Ini.GetString(s_szProfessionSectionList[i], "MaleImg", "",
                          m_propTypeInfoTable[i].szMaleImg, sizeof(m_propTypeInfoTable[i].szMaleImg));
            Ini.GetString(s_szProfessionSectionList[i], "FemaleImg", "",
                          m_propTypeInfoTable[i].szFemaleImg, sizeof(m_propTypeInfoTable[i].szFemaleImg));
        }
        FILE* log = fopen("role_creation_diag.log", "a");
        if (log) {
            fprintf(log, "layout_ready canvas=%dx%d sections=Gold,Wood,Water maps=%d,%d,%d\n",
                    width, height, m_NativePlaces[0], m_NativePlaces[1], m_NativePlaces[2]);
            fclose(log);
        }
        return true;
    }
    FILE* log = fopen("role_creation_diag.log", "a");
    if (log) { fprintf(log, "layout_load_failed pak=%08lX fallback=%s\n", PHONGTHAN_PAK_NEWPLAYER, Buff); fclose(log); }
    return false;
}

//--------------------------------------------------------------------------
//	���ܣ�������Ϣ����
//--------------------------------------------------------------------------
int KUiNewPlayer::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            OnClickButton((KWndWindow *) uParam);
            break;
        case WM_KEYDOWN:
            if (uParam == VK_ESCAPE) {
                OnCancel();
                nRet = 1;
            } else if (uParam == VK_RETURN) {
                OnOk();
                nRet = 1;
            }
            break;
        default:
            nRet = KWndShowAnimate::WndProc(uMsg, uParam, nParam);
            break;
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	���ܣ���Ӧ�����ť
//--------------------------------------------------------------------------
void KUiNewPlayer::OnClickButton(KWndWindow *pWnd) {
    if (pWnd == (KWndWindow *) &m_Male) {
        UiSoundPlay(UI_SI_PLAYER_ATTRIB);
        m_Info.Gender = OBJ_G_MALE;
        SelGender();
    } else if (pWnd == (KWndWindow *) &m_Female) {
        UiSoundPlay(UI_SI_PLAYER_ATTRIB);
        m_Info.Gender = OBJ_G_FEMALE;
        SelGender();
    } else if (pWnd == (KWndWindow *) &m_OK)
        OnOk();
    else if (pWnd == (KWndWindow *) &m_Cancel)
        OnCancel();
    else {
        for (int i = 0; i < PHONGTHAN_PROFESSION_COUNT; i++) {
            if (pWnd == m_propTypeInfoTable[i].pBtn) {
                m_Info.Profession = i;
                break;
            }
        }
        if (i < PHONGTHAN_PROFESSION_COUNT) {
            UiSoundPlay(UI_SI_PLAYER_ATTRIB);
            UpdateProperty();
        }
    }
}

//--------------------------------------------------------------------------
//	���ܣ���������˵��
//--------------------------------------------------------------------------
void KUiNewPlayer::UpdateProperty() {
    m_Info.NativePlaceId = m_NativePlaces[m_Info.Profession];
    for (int i = 0; i < PHONGTHAN_PROFESSION_COUNT; i++) {
        ((KWndButton *) m_propTypeInfoTable[i].pBtn)->CheckButton(i == m_Info.Profession);
        if (m_Info.Profession == i)
            m_ProfessionBanner.SetImage(ISI_T_SPR, m_propTypeInfoTable[i].szProfession);
    }
    if (m_Info.Profession == PHONGTHAN_PROFESSION_GIAP_SI) {
        m_Info.Gender = OBJ_G_MALE;
        SelGender();
        m_Male.Enable(true);
        m_Female.Enable(true);
    } else if (m_Info.Profession == PHONGTHAN_PROFESSION_DI_NHAN) {
        m_Info.Gender = OBJ_G_FEMALE;
        SelGender();
        m_Female.Enable(true);
        m_Male.Enable(true);
    } else {
        m_Info.Gender = OBJ_G_MALE;
        SelGender();
        m_Male.Enable(true);
        m_Female.Enable(true);
    }

    m_PropertyShow.SetText(m_propTypeInfoTable[m_Info.Profession].propertyShow,
                           m_propTypeInfoTable[m_Info.Profession].nShowTextLen);

    Wnd_SetFocusWnd(&m_Name);
}

//--------------------------------------------------------------------------
//	���ܣ���ɽ�ɫѡ�����
//--------------------------------------------------------------------------
void KUiNewPlayer::OnOk() {
    //TamLTM add sleep waint create nhan vat.
    Sleep(2);

    if (GetInputInfo()) {
        //Create nhan vat thanh cong.
        g_LoginLogic.CreateRole(&m_Info);
        //Thong bao dang tao nhan vat hoac xoa nhan vat
        KUiConnectInfo::OpenWindow(CI_MI_CREATING_ROLE, LL_S_IN_GAME, m_Info.NativePlaceId);
        //An cua so
        CloseWindow(false);
    }
}

//--------------------------------------------------------------------------
//	���ܣ����ء���ɫѡ����桱
//--------------------------------------------------------------------------
void KUiNewPlayer::OnCancel() {
    CloseWindow(false);
    KUiSelPlayer::OpenWindow();
}


void KUiNewPlayer::Breathe() {
    int nLoopBackMale = m_Male.NextFrame();
    int nLoopBackFemale = m_Female.NextFrame();

    if (m_bJustClicked) {
        char szFileName[128];
        KWndImage *pBtn = NULL;
        if ((m_Info.Gender == OBJ_G_MALE) && nLoopBackMale)
            pBtn = &m_Male;
        else if (m_Info.Gender == OBJ_G_FEMALE && nLoopBackFemale)
            pBtn = &m_Female;
        if (pBtn) {
            KUiSelPlayer::GetRoleImageName(szFileName, m_szPlayerImgPrefix, m_Info.Gender, m_Info.Profession, 0);
            pBtn->SetImage(ISI_T_SPR, szFileName);
            pBtn->SetFrame(0);
            m_bJustClicked = false;
        }
    }
}

//TamLTM Check ky tu dat biet khi dat ten nhan vat
/*
* Cach su dung Ham check ky tu - chuoi ky tu dc kiem tra hop le -> "!@#$"
	if (-1 != CheckKyTuDatBieString( password, "!@#$" ) )
	{
		// Xu l� truong hop ky tu or password hop le
	}
	else
	{
		// ky or password kh�ng hop le
	}
*/
int KUiNewPlayer::CheckKyTuDatBieString(char *lpstrBuffer, char *lpstrControl) {
    char *pSet = NULL;
    char *lpstrScan = lpstrBuffer;

    if ((lpstrControl == NULL) || (lpstrBuffer == NULL))
        return -1;

    //T�m thay ki tu dau tien th� dung lai
    while (*lpstrScan) {
        for (pSet = lpstrControl; *pSet; ++pSet) {
            if (*pSet == *lpstrScan)
                return (int) (lpstrScan - lpstrBuffer);
        }
        lpstrScan++;
    }

    return -1;
}
// End code

#include "../ChatFilter.h"

extern CChatFilter g_ChatFilter;

int KUiNewPlayer::GetInputInfo() {
    int nLen = m_Name.GetText(m_Info.Name, sizeof(m_Info.Name), false);

    int i = 0;
    for (i = 0; i < nLen;) {
        unsigned char cCode = (unsigned char) m_Info.Name[i];
        if (cCode > 0x80)
            i++;
        else if (cCode <= 0x20 || cCode > 0x7e)
            break;
        else
            i++;
    }

    if (!g_ChatFilter.IsTextPass(m_Info.Name))
        i = 0;

    // Check ky tu dat biet here
    if (-1 != CheckKyTuDatBieString(m_Info.Name, CHECK_KEY_KY_TU_DAT_BIET_INPUT_LOGIN)) {
        // Xu l� truong hop ky tu or password hop le
        //g_DebugLog("Xu l� truong hop ky tu or password kh�ng hop le %d + %d", i, nLen);
        CloseWindow(false);

        //Show error check ky tu dat biet
        KUiConnectInfo::OpenWindow(CI_MI_INVALID_KYTU_DACBIET_INPUT, CI_NS_NEW_ROLE_WND, m_Info.NativePlaceId);
    } else {
        if (i < nLen) {
            CloseWindow(false);
            //g_DebugLog("i < nLen %d < %d", i < nLen);

            //Neu nLen ma nho hon input hoac ky tu khong hop le co khoang trong' thi return.
            //CI_MI_INVALID_LOGIN_INPUT1 -> T�n nh�n v�t kh�ng th� ch�a kho�ng tr�ng! = 17
            KUiConnectInfo::OpenWindow(CI_MI_INVALID_LOGIN_INPUT1, CI_NS_NEW_ROLE_WND, m_Info.NativePlaceId);

            return false;
        }

        if (nLen >= LOGIN_ROLE_NAME_MIN_LEN && nLen <= LOGIN_ROLE_NAME_MAX_LEN)
            return true;

        // ky or password kh�ng hop le
        //g_DebugLog("ky tu dat biet or password hop le");

        // Close windown khi input hop le
        CloseWindow(false);

        //input phai 6 -> 16 ky tu create nhan vat ko hop le thong bao, id: 18=�� d�i t�n ph�i t� 6 ��n 16 k� t�.
        KUiConnectInfo::OpenWindow(CI_MI_INVALID_LOGIN_INPUT2, CI_NS_NEW_ROLE_WND, m_Info.NativePlaceId);
    }

    //end code

    return false;
}
