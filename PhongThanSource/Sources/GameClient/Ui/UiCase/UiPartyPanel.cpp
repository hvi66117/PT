/*
 * File:     UiPartyPanel.cpp
 * Desc:     Phong Than team list, VNG style ("to doi" list on the right side, under the mini map).
 *
 * Data:     every 200 ms the panel asks CoreClient (PAIOperation PTPP_GPI_QUERY, PhongThanPartyPanel.inl):
 *           real team members (g_Team[0]) or, without a team, the "[To doi]" bot companions near the player
 *           (the player is listed first as the captain). Nothing is sent to the server.
 * Layout:   <scheme>\UiPartyPanel.ini (optional loose override), else VNG's team member list read by PAK id
 *           d180f81d (serverlist.pak: 240x350 at 550,190, CalculateWay=2 = anchored to the right edge),
 *           else the same numbers built in. VNG keys: MemberWnd*, Name*, CaptainName*, Level*, CareerWnd*,
 *           SkeletonWnd*, LifeBar*, Border*, LifeImage, BorderImage, SwordsmanImg / TaoistImg /
 *           specialmanImg, SkeletonImg. Phong Than additions (all optional, [Main]): MemberTop, MaxMember,
 *           CaptionLeft/Top/Font/Color, LevelFont/LevelColor, FarNameColor, DeadNameColor, LeaderImg,
 *           LeaderLeft/LeaderTop.
 * Row:      [badge: profession icon + level] [name (captain yellow + flag)] / [life bar in its border].
 *           Dead: skeleton instead of the badge, empty bar. Not in view (real team): grey name, empty bar.
 * Caption:  "Dong doi bot: N (Alt+G)" or "To doi: N nguoi (Alt+G)". Nothing is drawn when the list is empty.
 * Input:    PtInWindow() is always 0: the panel never takes a click (game space gets it).
 * Toggle:   Alt+G (built in when autoexec.lua does not bind it) or Open([[partypanel]]);
 *           stored in UserData\UiCommon.ini [PartyPanel] Show=0/1 (default 1).
 * Text:     TCVN3 bytes from the server are drawn as they are; fixed strings are TCVN3 octal escapes,
 *           sprite paths are GBK octal escapes, so this file is ASCII only.
 * Creation: 2026-10-03 (agent partypanel)
 */
#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/wnds.h"
#include "../Elem/WndMessage.h"
#include "../UiBase.h"
#include "UiMsgCentrePad.h"
#include "UiPartyPanel.h"
#include "../../../core/src/coreshell.h"
#include "../../../Represent/iRepresent/iRepresentShell.h"

extern iCoreShell *g_pCoreShell;
extern iRepresentShell *g_pRepresentShell;

#define SCHEME_INI_PARTYPANEL       "UiPartyPanel.ini"
// VNG team member list layout (GBK file name unknown), serverlist.pak + ui.pak; the first PAK in
// package.ini order that has it is serverlist.pak (240 wide version with profession badges).
#define PHONGTHAN_VNG_TEAMLIST_INI_ID   0xd180f81dUL
#define PARTYPANEL_SAVE_SECTION     "PartyPanel"
#define PARTYPANEL_QUERY_MS         200

// GBK sprite paths (VNG ini values), octal escaped.
static const char s_szImgJiashi[]   = "\\spr\\Ui4\\\326\367\275\347\303\346\\jiashi.spr";
static const char s_szImgDaoshi[]   = "\\spr\\Ui4\\\326\367\275\347\303\346\\daoshi.spr";
static const char s_szImgYiren[]    = "\\spr\\Ui4\\\326\367\275\347\303\346\\yiren.spr";
static const char s_szImgLife[]     = "\\Spr\\Ui4\\\326\367\275\347\303\346\\\321\252\314\365.spr";
static const char s_szImgBorder[]   = "\\Spr\\Ui4\\\326\367\275\347\303\346\\\321\252\314\365\261\337\277\362.spr";
static const char s_szImgSkeleton[] = "\\spr\\Ui4\\\315\267\266\245\315\274\261\352\\\273\260\277\362\\\367\274\367\303.spr";
static const char s_szImgFlag[]     = "\\spr\\Ui4\\\327\351\266\323\\\306\354\327\323\272\354.spr";

// TCVN3 strings.
static const char s_szCapBot[]  = "\247\345ng \256\351i bot: ";                  // "Dong doi bot: "
static const char s_szCapTeam[] = "T\346 \256\351i: ";                           // "To doi: "
static const char s_szPeople[]  = " ng\255\352i";                                // " nguoi"
static const char s_szHotkey[]  = " (Alt+G)";
static const char s_szMsgOn[]   = "Khung t\346 \256\351i: B\313T (Alt+G \256\323 \310n)";       // BAT (Alt+G de an)
static const char s_szMsgOff[]  = "Khung t\346 \256\351i: T\276T (Alt+G \256\323 hi\326n)";     // TAT (Alt+G de hien)

KUiPartyPanel *KUiPartyPanel::m_pSelf = NULL;
int KUiPartyPanel::ms_nEnabled = -1;

void KUiPartyPanel::SetImage(KUiImageRef &Img, const char *pPath) {
    IR_InitUiImageRef(Img);
    Img.nType = ISI_T_SPR;
    Img.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    Img.uImage = 0;
    Img.nISPosition = IMAGE_IS_POSITION_INIT;
    Img.nFrame = 0;
    if (pPath) {
        strncpy(Img.szImage, pPath, sizeof(Img.szImage) - 1);
        Img.szImage[sizeof(Img.szImage) - 1] = 0;
    }
}

KUiPartyPanel::KUiPartyPanel() {
    memset(&m_Info, 0, sizeof(m_Info));
    m_uLastQuery = 0;
    m_bTestData = false;
    ApplyLayout(NULL);
}

//--------------------------------------------------------------------------
// settings (UiCommon.ini)
//--------------------------------------------------------------------------
void KUiPartyPanel::LoadSetting() {
    if (ms_nEnabled >= 0)
        return;
    int nShow = 1;
    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    if (pSetting) {
        pSetting->GetInteger(PARTYPANEL_SAVE_SECTION, "Show", 1, &nShow);
        g_UiBase.CloseCommSettingFile(false);
    }
    ms_nEnabled = nShow ? 1 : 0;
}

void KUiPartyPanel::StoreSetting() {
    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    if (pSetting) {
        pSetting->WriteInteger(PARTYPANEL_SAVE_SECTION, "Show", ms_nEnabled > 0 ? 1 : 0);
        g_UiBase.CloseCommSettingFile(true);
    }
}

int KUiPartyPanel::IsEnabled() {
    LoadSetting();
    return ms_nEnabled > 0;
}

void KUiPartyPanel::Toggle() {
    LoadSetting();
    ms_nEnabled = (ms_nEnabled > 0) ? 0 : 1;
    StoreSetting();
    if (m_pSelf) {
        if (ms_nEnabled > 0) {
            m_pSelf->m_uLastQuery = 0;
            m_pSelf->Query();
            m_pSelf->Show();
        } else {
            m_pSelf->Hide();
        }
    }
    const char *pMsg = (ms_nEnabled > 0) ? s_szMsgOn : s_szMsgOff;
    KUiMsgCentrePad::SystemMessageArrival(pMsg, (unsigned short) strlen(pMsg));
}

//--------------------------------------------------------------------------
// window life cycle
//--------------------------------------------------------------------------
KUiPartyPanel *KUiPartyPanel::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiPartyPanel;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        memset(&m_pSelf->m_Info, 0, sizeof(m_pSelf->m_Info));
        m_pSelf->m_uLastQuery = 0;
        if (IsEnabled())
            m_pSelf->Show();
        else
            m_pSelf->Hide();
    }
    return m_pSelf;
}

void KUiPartyPanel::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

void KUiPartyPanel::Initialize() {
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, sizeof(Scheme));
    LoadScheme(Scheme);
    m_Style &= ~WND_S_VISIBLE;
    Wnd_AddWindow(this, WL_LOWEST);
}

void KUiPartyPanel::LoadScheme(const char *pScheme) {
    if (m_pSelf == NULL)
        return;
    KIniFile Ini;
    int bOk = false;
    if (pScheme && pScheme[0]) {
        char Buff[256];
        _snprintf(Buff, sizeof(Buff) - 1, "%s\\%s", pScheme, SCHEME_INI_PARTYPANEL);
        Buff[sizeof(Buff) - 1] = 0;
        bOk = Ini.Load(Buff) ? true : false;
    }
    if (!bOk)
        bOk = Ini.LoadPakEntry(PHONGTHAN_VNG_TEAMLIST_INI_ID) ? true : false;
    m_pSelf->ApplyLayout(bOk ? &Ini : NULL);
}

static unsigned int PartyPanel_IniColor(KIniFile *pIni, const char *pKey, unsigned int uDefault) {
    char Buff[64];
    Buff[0] = 0;
    if (pIni && pIni->GetString("Main", pKey, "", Buff, sizeof(Buff)) && Buff[0])
        return GetColor(Buff) | 0xFF000000;
    return uDefault;
}

static void PartyPanel_IniImage(KIniFile *pIni, const char *pKey, const char *pDefault, char *pOut, int nOut) {
    pOut[0] = 0;
    if (pIni)
        pIni->GetString("Main", pKey, "", pOut, nOut);
    if (pOut[0] == 0) {
        strncpy(pOut, pDefault, nOut - 1);
        pOut[nOut - 1] = 0;
    }
}

static int PartyPanel_IniInt(KIniFile *pIni, const char *pKey, int nDefault) {
    int n = nDefault;
    if (pIni)
        pIni->GetInteger("Main", pKey, nDefault, &n);
    return n;
}

void KUiPartyPanel::ApplyLayout(KIniFile *pIni) {
    int nScreenW = 800, nScreenH = 600;
    Wnd_GetScreenSize(nScreenW, nScreenH);

    // [Main] window rectangle; VNG numbers when no ini.
    int nLeft = PartyPanel_IniInt(pIni, "Left", 550);
    int nTop = PartyPanel_IniInt(pIni, "Top", 190);
    int nWidth = PartyPanel_IniInt(pIni, "Width", 240);
    int nHeight = PartyPanel_IniInt(pIni, "Height", 350);
    int nCalc = PartyPanel_IniInt(pIni, "CalculateWay", 2);
    // VNG lays its HUD out on an 800-wide canvas; the team list hangs on the right edge
    // (CalculateWay=2, or an old layout whose right side touches the edge), like the mini map.
    if (nScreenW > 800 && (nCalc == 2 || nLeft + nWidth >= 760))
        nLeft += nScreenW - 800;
    if (nLeft + nWidth > nScreenW)
        nLeft = nScreenW - nWidth;
    if (nLeft < 0)
        nLeft = 0;
    if (nTop < 0)
        nTop = 0;
    SetPosition(nLeft, nTop);
    KWndWindow::SetSize(nWidth, nHeight);

    m_nRowHeight = PartyPanel_IniInt(pIni, "MemberWndHeight", 30);
    if (m_nRowHeight < 16)
        m_nRowHeight = 16;
    m_nNameLeft = PartyPanel_IniInt(pIni, "NameLeft", 123);
    m_nNameTop = PartyPanel_IniInt(pIni, "NameTop", 0);
    m_nNameWidth = PartyPanel_IniInt(pIni, "NameWidth", 112);
    m_nNameFont = PartyPanel_IniInt(pIni, "NameFont", 14);
    if (m_nNameFont != 12 && m_nNameFont != 14 && m_nNameFont != 16)
        m_nNameFont = 14;
    m_uNameColor = PartyPanel_IniColor(pIni, "NameColor", 0xFF00FF00);
    m_uCaptainColor = PartyPanel_IniColor(pIni, "CaptainNameColor", 0xFFEFF74A);
    m_uFarColor = PartyPanel_IniColor(pIni, "FarNameColor", 0xFFA0A0A0);
    m_uDeadColor = PartyPanel_IniColor(pIni, "DeadNameColor", 0xFFB4B4B4);
    m_uLevelColor = PartyPanel_IniColor(pIni, "LevelColor", 0xFFFFFFFF);
    // Badge column: the serverlist.pak layout has CareerWndLeft=83; the older ui.pak layout (124 wide, name at
    // x=12) has no badge keys, so no badge is drawn with it (it would cover the name).
    m_nCareerLeft = PartyPanel_IniInt(pIni, "CareerWndLeft", pIni ? -1 : 83);
    m_nLevelLeft = PartyPanel_IniInt(pIni, "LevelLeft", m_nCareerLeft);
    m_nLevelTop = PartyPanel_IniInt(pIni, "LevelTop", 14);
    m_nLevelFont = PartyPanel_IniInt(pIni, "LevelFont", 12);
    if (m_nLevelFont != 12 && m_nLevelFont != 14 && m_nLevelFont != 16)
        m_nLevelFont = 12;
    m_nCareerTop = PartyPanel_IniInt(pIni, "CareerWndTop", 12);
    m_nSkeletonLeft = PartyPanel_IniInt(pIni, "SkeletonWndLeft", m_nCareerLeft);
    m_nSkeletonTop = PartyPanel_IniInt(pIni, "SkeletonWndTop", 15);
    m_nLifeLeft = PartyPanel_IniInt(pIni, "LifeBarLeft", 125);
    m_nLifeTop = PartyPanel_IniInt(pIni, "LifeBarTop", 21);
    m_nBorderLeft = PartyPanel_IniInt(pIni, "BorderLeft", 123);
    m_nBorderTop = PartyPanel_IniInt(pIni, "BorderTop", 18);
    m_nFlagLeft = PartyPanel_IniInt(pIni, "LeaderLeft", -1);
    m_nFlagTop = PartyPanel_IniInt(pIni, "LeaderTop", 1);
    m_nCaptionLeft = PartyPanel_IniInt(pIni, "CaptionLeft", m_nCareerLeft >= 0 ? m_nCareerLeft : m_nNameLeft);
    m_nCaptionTop = PartyPanel_IniInt(pIni, "CaptionTop", 0);
    m_nCaptionFont = PartyPanel_IniInt(pIni, "CaptionFont", 12);
    if (m_nCaptionFont != 12 && m_nCaptionFont != 14 && m_nCaptionFont != 16)
        m_nCaptionFont = 12;
    m_uCaptionColor = PartyPanel_IniColor(pIni, "CaptionColor", 0xFFFFF994);
    m_nMemberTop = PartyPanel_IniInt(pIni, "MemberTop", m_nCaptionTop + m_nCaptionFont + 4);
    m_nMaxMember = PartyPanel_IniInt(pIni, "MaxMember", PTPP_MAX_MEMBER);
    if (m_nMaxMember < 1)
        m_nMaxMember = 1;
    if (m_nMaxMember > PTPP_MAX_MEMBER)
        m_nMaxMember = PTPP_MAX_MEMBER;

    char szPath[128];
    PartyPanel_IniImage(pIni, "SwordsmanImg", s_szImgJiashi, szPath, sizeof(szPath));
    SetImage(m_ImgCareer[0], szPath);
    PartyPanel_IniImage(pIni, "TaoistImg", s_szImgDaoshi, szPath, sizeof(szPath));
    SetImage(m_ImgCareer[1], szPath);
    PartyPanel_IniImage(pIni, "specialmanImg", s_szImgYiren, szPath, sizeof(szPath));
    SetImage(m_ImgCareer[2], szPath);
    PartyPanel_IniImage(pIni, "SkeletonImg", s_szImgSkeleton, szPath, sizeof(szPath));
    SetImage(m_ImgSkeleton, szPath);
    PartyPanel_IniImage(pIni, "BorderImage", s_szImgBorder, szPath, sizeof(szPath));
    SetImage(m_ImgBorder, szPath);
    PartyPanel_IniImage(pIni, "LeaderImg", s_szImgFlag, szPath, sizeof(szPath));
    SetImage(m_ImgFlag, szPath);

    IR_InitUiImagePartRef(m_ImgLife);
    m_ImgLife.nType = ISI_T_SPR;
    m_ImgLife.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    m_ImgLife.uImage = 0;
    m_ImgLife.nISPosition = IMAGE_IS_POSITION_INIT;
    m_ImgLife.nFrame = 0;
    m_ImgLife.nDivideFashion = IDF_LEFT_TO_RIGHT;
    m_ImgLife.Width = 0;        // IR_UpdateImagePart reads the sprite size on first use
    m_ImgLife.Height = 0;
    PartyPanel_IniImage(pIni, "LifeImage", s_szImgLife, szPath, sizeof(szPath));
    strncpy(m_ImgLife.szImage, szPath, sizeof(m_ImgLife.szImage) - 1);
    m_ImgLife.szImage[sizeof(m_ImgLife.szImage) - 1] = 0;
}

//--------------------------------------------------------------------------
// data
//--------------------------------------------------------------------------
void KUiPartyPanel::SetDataForTest(const KPTPartyInfo *pInfo) {
    m_bTestData = (pInfo != NULL);
    if (pInfo)
        m_Info = *pInfo;
    else
        memset(&m_Info, 0, sizeof(m_Info));
}

void KUiPartyPanel::Query() {
    if (m_bTestData)
        return;
    KPTPartyInfo Info;
    memset(&Info, 0, sizeof(Info));
    Info.nSize = sizeof(Info);
    if (g_pCoreShell)
        g_pCoreShell->PAIOperation(PTPP_GPI_QUERY, (unsigned int) &Info, sizeof(Info), 0);
    // never trust counts coming back
    if (Info.nCount < 0)
        Info.nCount = 0;
    if (Info.nCount > PTPP_MAX_MEMBER)
        Info.nCount = PTPP_MAX_MEMBER;
    for (int i = 0; i < PTPP_MAX_MEMBER; i++)
        Info.aMember[i].szName[PTPP_NAME_LEN - 1] = 0;
    m_Info = Info;
}

void KUiPartyPanel::Breathe() {
    unsigned int uNow = IR_GetCurrentTime();
    if (m_uLastQuery == 0 || uNow - m_uLastQuery >= PARTYPANEL_QUERY_MS) {
        m_uLastQuery = uNow ? uNow : 1;
        Query();
    }
}

//--------------------------------------------------------------------------
// painting
//--------------------------------------------------------------------------
void KUiPartyPanel::DrawImage(KUiImageRef &Img, int x, int y) {
    if (g_pRepresentShell == NULL || Img.szImage[0] == 0)
        return;
    Img.oPosition.nX = x;
    Img.oPosition.nY = y;
    Img.oPosition.nZ = 0;
    g_pRepresentShell->DrawPrimitives(1, &Img, RU_T_IMAGE, true);
}

void KUiPartyPanel::DrawText(int nFont, const char *pText, int nLen, int x, int y, unsigned int uColor) {
    if (g_pRepresentShell == NULL || pText == NULL || nLen <= 0)
        return;
    g_pRepresentShell->OutputText(nFont, pText, nLen, x, y, uColor, 0, TEXT_IN_SINGLE_PLANE_COORD, 0xFF000000);
}

void KUiPartyPanel::PaintRow(int nRow, const KPTPartyMember &m) {
    const int x0 = m_nAbsoluteLeft;
    const int y0 = m_nAbsoluteTop + GetRowTop(nRow);
    const int bDead = (m.nFlags & PTPP_F_DEAD) != 0;
    const int bFar = (m.nFlags & PTPP_F_FAR) != 0;

    // badge: profession icon with the level on it, or the skeleton when dead
    if (bDead) {
        if (m_nSkeletonLeft >= 0)
            DrawImage(m_ImgSkeleton, x0 + m_nSkeletonLeft, y0 + m_nSkeletonTop);
    } else if (m_nCareerLeft >= 0) {
        if (m.nProfession >= 0 && m.nProfession <= 2)
            DrawImage(m_ImgCareer[m.nProfession], x0 + m_nCareerLeft, y0 + m_nCareerTop);
        if (m.nLevel > 0) {
            char szLevel[16];
            int nLen = _snprintf(szLevel, sizeof(szLevel) - 1, "%d", m.nLevel);
            if (nLen < 0)
                nLen = 0;
            szLevel[nLen] = 0;
            // the coloured field right of the icon (badge 40 wide, icon about 14)
            int nTextW = nLen * m_nLevelFont / 2;
            int nX = m_nLevelLeft + 14 + (26 - nTextW) / 2;
            if (nX < m_nLevelLeft)
                nX = m_nLevelLeft;
            DrawText(m_nLevelFont, szLevel, nLen, x0 + nX, y0 + m_nLevelTop, m_uLevelColor);
        }
    }

    // name (captain in VNG yellow), clipped to NameWidth
    int nLen = 0;
    while (nLen < PTPP_NAME_LEN - 1 && m.szName[nLen])
        nLen++;
    int nMaxChars = m_nNameWidth * 2 / m_nNameFont;
    if ((m.nFlags & PTPP_F_CAPTAIN) && m_ImgFlag.szImage[0] && m_nFlagLeft < 0)
        nMaxChars -= 2;                         // room for the flag at the end of the line
    if (nMaxChars < 1)
        nMaxChars = 1;
    if (nLen > nMaxChars)
        nLen = nMaxChars;
    unsigned int uColor = m_uNameColor;
    if (m.nFlags & PTPP_F_CAPTAIN)
        uColor = m_uCaptainColor;
    if (bFar)
        uColor = m_uFarColor;
    else if (bDead)
        uColor = m_uDeadColor;
    DrawText(m_nNameFont, m.szName, nLen, x0 + m_nNameLeft, y0 + m_nNameTop, uColor);

    // leader mark
    if (m.nFlags & PTPP_F_CAPTAIN) {
        int nFlagX = m_nFlagLeft;
        if (nFlagX < 0)
            nFlagX = m_nNameLeft + m_nNameWidth - 13;
        DrawImage(m_ImgFlag, x0 + nFlagX, y0 + m_nFlagTop);
    }

    // life bar inside its border
    DrawImage(m_ImgBorder, x0 + m_nBorderLeft, y0 + m_nBorderTop);
    int nPct = m.nLifePercent;
    if (!bFar && !bDead && nPct > 0 && m_ImgLife.szImage[0] && g_pRepresentShell) {
        if (nPct > 100)
            nPct = 100;
        IR_UpdateImagePart(m_ImgLife, nPct, 100);
        if (m_ImgLife.szImage[0] && m_ImgLife.oImgRBPos.nX > 0) {
            m_ImgLife.oPosition.nX = x0 + m_nLifeLeft;
            m_ImgLife.oPosition.nY = y0 + m_nLifeTop;
            m_ImgLife.oPosition.nZ = 0;
            g_pRepresentShell->DrawPrimitives(1, &m_ImgLife, RU_T_IMAGE_PART, true);
        }
    }
}

void KUiPartyPanel::PaintWindow() {
    KWndWindow::PaintWindow();
    int nCount = m_Info.nCount;
    if (nCount <= 0)
        return;                                 // empty list: nothing on screen
    if (nCount > m_nMaxMember)
        nCount = m_nMaxMember;

    char szCap[96];
    int n = 0;
    if (m_Info.nMode == PTPP_MODE_TEAM) {
        n = _snprintf(szCap, sizeof(szCap) - 1, "%s%d%s%s", s_szCapTeam, m_Info.nCount, s_szPeople, s_szHotkey);
    } else {
        n = _snprintf(szCap, sizeof(szCap) - 1, "%s%d%s", s_szCapBot, m_Info.nBots, s_szHotkey);
    }
    if (n < 0)
        n = 0;
    szCap[n] = 0;
    DrawText(m_nCaptionFont, szCap, n, m_nAbsoluteLeft + m_nCaptionLeft, m_nAbsoluteTop + m_nCaptionTop,
             m_uCaptionColor);

    for (int i = 0; i < nCount; i++)
        PaintRow(i, m_Info.aMember[i]);
}
