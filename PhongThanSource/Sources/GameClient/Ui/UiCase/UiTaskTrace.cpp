/*
 * File:     UiTaskTrace.cpp
 * Desc:     Phong Than quest tracker, left side of the screen (VNG "task hint" panel).
 *
 * Data:     the server sends quest notes as UI_NOTEINFO (Lua TaskNote/AddNote, packet 0x5001
 *           view 203). KUiTaskNote::WakeUp stores them in MissionMemory.dat (header id 0..35,
 *           act 0 explain / 1 perform / 2 finish, text "Title: step text" in TCVN3 with
 *           <color=..> tags) and forwards every record here. The tracker keeps the newest
 *           record per header id and shows the newest unfinished ones.
 * Layout:   <scheme>\UiTaskTrace.ini (ptfix plug-in extra_questtrack.py), falling back to the
 *           VNG layout \ui\ui3\<task hint>.ini read by PAK id, then to built-in defaults.
 *           Sections [Main], [List], [Scroll] (+ [List_800], [Scroll_800] for 800x600).
 * Toggle:   Alt+N (built-in when the key is not bound in autoexec.lua) or the shortcut script
 *           Open([[tasktrace]]); stored in UserData\UiCommon.ini [TaskTrace] Show=0/1.
 * Creation: 2026-10-03 (agent questtrack)
 */
#include "KWin32.h"
#include "KIniFile.h"
#include "GameDataDef.h"
#include "../Elem/wnds.h"
#include "../Elem/WndMessage.h"
#include "../UiBase.h"
#include "UiTaskNote.h"
#include "UiTaskTrace.h"
#include "../../../Engine/src/Text.h"
#include "../../../Core/Src/PhongThanGoToPath.h"    // 2026-10-04 timduong: PTGP_FindCoordInText

#define SCHEME_INI_TASKTRACE        "UiTaskTrace.ini"
// \ui\ui3\<task hint>.ini (GBK name) shipped by VNG in serverlist.pak.
#define PHONGTHAN_VNG_TASKTRACE_INI_ID  0xdd5ddfc2UL
#define TASKTRACE_SAVE_SECTION      "TaskTrace"

// TCVN3 strings (octal escapes so no hex digit can be swallowed).
// "Nhiem vu dang lam (Alt+N: an/hien)"
static const char s_szCaption[] = "Nhi\326m v\364 \256ang l\265m (Alt+N: \310n/hi\326n)";
// "Chua co nhiem vu dang lam. Nhan F11 de xem so nhiem vu."
static const char s_szEmpty[] = "Ch\255a c\343 nhi\326m v\364 \256ang l\265m. Nh\312n F11 \256\323 xem s\346 nhi\326m v\364.";

KUiTaskTrace *KUiTaskTrace::m_pSelf = NULL;
int KUiTaskTrace::ms_nEnabled = -1;

KUiTaskTrace::KUiTaskTrace() {
    m_bHasScroll = false;
    m_nMaxShow = TASKTRACE_DEFAULT_SHOW;
    m_uTitleColor = 0xFFFFD75A;
    m_uStepColor = 0xFFD8FB9F;
    m_uCaptionColor = 0xFFFFF994;
    m_nEntries = 0;
    m_uSeq = 0x40000000;
    m_uSeedSeq = 0x40000000;
    memset(m_Entries, 0, sizeof(m_Entries));
}

//--------------------------------------------------------------------------
// settings (UiCommon.ini)
//--------------------------------------------------------------------------
void KUiTaskTrace::LoadSetting() {
    if (ms_nEnabled >= 0)
        return;
    int nShow = 1;
    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    if (pSetting) {
        pSetting->GetInteger(TASKTRACE_SAVE_SECTION, "Show", 1, &nShow);
        g_UiBase.CloseCommSettingFile(false);
    }
    ms_nEnabled = nShow ? 1 : 0;
}

void KUiTaskTrace::StoreSetting() {
    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    if (pSetting) {
        pSetting->WriteInteger(TASKTRACE_SAVE_SECTION, "Show", ms_nEnabled > 0 ? 1 : 0);
        g_UiBase.CloseCommSettingFile(true);
    }
}

int KUiTaskTrace::IsEnabled() {
    LoadSetting();
    return ms_nEnabled > 0;
}

void KUiTaskTrace::Toggle() {
    LoadSetting();
    ms_nEnabled = (ms_nEnabled > 0) ? 0 : 1;
    StoreSetting();
    if (m_pSelf)
        m_pSelf->Rebuild();
}

//--------------------------------------------------------------------------
// window life cycle
//--------------------------------------------------------------------------
KUiTaskTrace *KUiTaskTrace::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiTaskTrace;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        m_pSelf->Reload();
        m_pSelf->Rebuild();
    }
    return m_pSelf;
}

void KUiTaskTrace::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

void KUiTaskTrace::Initialize() {
    AddChild(&m_List);
    AddChild(&m_Scroll);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, sizeof(Scheme));
    LoadScheme(Scheme);

    m_Style &= ~WND_S_VISIBLE;
    Wnd_AddWindow(this, WL_LOWEST);
}

void KUiTaskTrace::LoadScheme(const char *pScheme) {
    if (m_pSelf == NULL)
        return;
    KIniFile Ini;
    int bOk = false;
    if (pScheme && pScheme[0]) {
        char Buff[256];
        _snprintf(Buff, sizeof(Buff) - 1, "%s\\%s", pScheme, SCHEME_INI_TASKTRACE);
        Buff[sizeof(Buff) - 1] = 0;
        bOk = Ini.Load(Buff) ? true : false;
    }
    if (!bOk)
        bOk = Ini.LoadPakEntry(PHONGTHAN_VNG_TASKTRACE_INI_ID) ? true : false;
    m_pSelf->ApplyLayout(bOk ? &Ini : NULL);
    m_pSelf->Rebuild();
}

void KUiTaskTrace::ApplyLayout(KIniFile *pIni) {
    int nScreenW = 800, nScreenH = 600;
    Wnd_GetScreenSize(nScreenW, nScreenH);

    char Buff[64];
    if (pIni) {
        const char *pList = "List";
        const char *pScroll = "Scroll";
        int nSmallH = 0;
        pIni->GetInteger("List_800", "Height", 0, &nSmallH);
        if (nScreenH < 700 && nSmallH > 0) {
            pList = "List_800";
            pScroll = "Scroll_800";
        }
        Init(pIni, "Main");
        m_List.Init(pIni, pList);
        int nScrollH = 0;
        pIni->GetInteger(pScroll, "Height", 0, &nScrollH);
        m_bHasScroll = (nScrollH > 0);
        if (m_bHasScroll) {
            m_Scroll.Init(pIni, pScroll);
            m_List.SetScrollbar(&m_Scroll);
        } else {
            m_List.SetScrollbar(NULL);
        }

        pIni->GetInteger("Main", "MaxTrace", TASKTRACE_DEFAULT_SHOW, &m_nMaxShow);
        if (pIni->GetString(pList, "MsgColor", "", Buff, sizeof(Buff)) && Buff[0])
            m_uStepColor = GetColor(Buff);
        if (pIni->GetString("Main", "TitleColor", "", Buff, sizeof(Buff)) && Buff[0])
            m_uTitleColor = GetColor(Buff);
        if (pIni->GetString("Main", "CaptionColor", "", Buff, sizeof(Buff)) && Buff[0])
            m_uCaptionColor = GetColor(Buff);
    } else {
        // Built-in VNG geometry: below the player status frame and its buff row.
        int nHeight = (nScreenH < 700) ? 180 : 320;
        SetPosition(0, 190);
        KWndWindow::SetSize(255, nHeight);
        m_Style |= WND_S_SIZE_WITH_ALL_CHILD;
        m_List.SetCapability(64);
        m_List.SetPosition(19, 0);
        m_List.SetSize(236, nHeight);
        m_List.SetScrollbar(NULL);
        m_bHasScroll = false;
        m_nMaxShow = TASKTRACE_DEFAULT_SHOW;
    }
    if (m_nMaxShow < 1)
        m_nMaxShow = 1;
    if (m_nMaxShow > TASKTRACE_MAX_ENTRY)
        m_nMaxShow = TASKTRACE_MAX_ENTRY;
    m_Scroll.Hide();
}

//--------------------------------------------------------------------------
// data
//--------------------------------------------------------------------------
int KUiTaskTrace::FindEntry(unsigned int uHeaderID) {
    for (int i = 0; i < m_nEntries; i++) {
        if (m_Entries[i].uHeaderID == uHeaderID)
            return i;
    }
    return -1;
}

int KUiTaskTrace::AllocEntry() {
    if (m_nEntries < TASKTRACE_MAX_ENTRY)
        return m_nEntries++;
    int nOld = 0;
    for (int i = 1; i < m_nEntries; i++) {
        if (m_Entries[i].uSeq < m_Entries[nOld].uSeq)
            nOld = i;
    }
    return nOld;
}

void KUiTaskTrace::SetEntry(int nIndex, unsigned int uHeaderID, int nAct, const char *pText, int nLen,
                            unsigned int uSeq) {
    if (nIndex < 0 || nIndex >= TASKTRACE_MAX_ENTRY)
        return;
    KTraceEntry &e = m_Entries[nIndex];
    if (nLen < 0)
        nLen = 0;
    if (nLen > TASKTRACE_TEXT_LEN - 1)
        nLen = TASKTRACE_TEXT_LEN - 1;
    e.uHeaderID = uHeaderID;
    e.nAct = nAct;
    e.uSeq = uSeq;
    e.nLen = nLen;
    if (nLen > 0 && pText)
        memcpy(e.szText, pText, nLen);
    e.szText[nLen] = 0;
}

void KUiTaskTrace::OnRecord(unsigned int uHeaderID, int nAct, const char *pText, int nLen) {
    if (m_pSelf == NULL || pText == NULL || nLen <= 0)
        return;
    int nIndex = m_pSelf->FindEntry(uHeaderID);
    if (nIndex < 0)
        nIndex = m_pSelf->AllocEntry();
    m_pSelf->SetEntry(nIndex, uHeaderID, nAct, pText, nLen, ++m_pSelf->m_uSeq);
    m_pSelf->Rebuild();
}

void KUiTaskTrace::SeedRecord(unsigned int uHeaderID, int nAct, const char *pText, int nLen) {
    if (m_pSelf == NULL || pText == NULL || nLen <= 0)
        return;
    if (m_pSelf->FindEntry(uHeaderID) >= 0)       // an older record of a header already seen
        return;
    if (m_pSelf->m_nEntries >= TASKTRACE_MAX_ENTRY)
        return;
    int nIndex = m_pSelf->AllocEntry();
    m_pSelf->SetEntry(nIndex, uHeaderID, nAct, pText, nLen, --m_pSelf->m_uSeedSeq);
}

// 2026-10-04 timduong: coordinate of the newest unfinished quest record that prints one, for the Alt+F box
// (UiMiniMap.cpp PTGoto_OpenInput). 1 when found.
int KUiTaskTrace::PTFindCoord(int *px, int *py) {
    if (m_pSelf == NULL || px == NULL || py == NULL)
        return 0;
    int nBest = -1;
    int i, x = 0, y = 0;
    for (i = 0; i < m_pSelf->m_nEntries; i++) {
        const KTraceEntry &e = m_pSelf->m_Entries[i];
        if (e.nAct == REA_FINISH || e.nLen <= 0)
            continue;
        if (nBest >= 0 && m_pSelf->m_Entries[nBest].uSeq >= e.uSeq)
            continue;
        int cx, cy;
        if (PTGP_FindCoordInText(e.szText, e.nLen, &cx, &cy)) {
            nBest = i;
            x = cx;
            y = cy;
        }
    }
    if (nBest < 0)
        return 0;
    *px = x;
    *py = y;
    return 1;
}

void KUiTaskTrace::Reload() {
    m_nEntries = 0;
    m_uSeedSeq = 0x40000000;
    if (m_uSeq < 0x40000000)
        m_uSeq = 0x40000000;
    KUiTaskNote::FeedTaskTrace();
}

// "Title: step" -> [title colour]Title<enter>[step colour]  step.  Returns the encoded length.
int KUiTaskTrace::BuildLine(int nIndex, char *pOut, int nOutSize) {
    if (nIndex < 0 || nIndex >= m_nEntries || pOut == NULL || nOutSize < 64)
        return 0;
    char szText[TASKTRACE_TEXT_LEN + 8];        // TEncodeText may read a 4-byte colour code past the end
    memset(szText + TASKTRACE_TEXT_LEN - 8, 0, 16);
    int nLen = m_Entries[nIndex].nLen;
    if (nLen > TASKTRACE_TEXT_LEN - 1)
        nLen = TASKTRACE_TEXT_LEN - 1;
    memcpy(szText, m_Entries[nIndex].szText, nLen);
    szText[nLen] = 0;
    nLen = TEncodeText(szText, nLen);
    if (nLen <= 0)
        return 0;

    // Find the "Title:" separator in the first 96 encoded bytes, skipping control sequences.
    int nSplit = -1;
    int k = 0;
    while (k < nLen && k < 96) {
        unsigned char c = (unsigned char) szText[k];
        if (c == KTC_COLOR || c == KTC_BORDER_COLOR) {
            k += 4;
            continue;
        }
        if (c == KTC_INLINE_PIC) {
            k += 3;
            continue;
        }
        if (c == KTC_ENTER)
            break;
        if (c == ':') {
            nSplit = k;
            break;
        }
        k++;
    }

    int n = 0;
    const int nLimit = nOutSize - 16;
    if (nSplit > 0) {
        pOut[n++] = KTC_COLOR;
        pOut[n++] = (char) ((m_uTitleColor >> 16) & 0xff);
        pOut[n++] = (char) ((m_uTitleColor >> 8) & 0xff);
        pOut[n++] = (char) (m_uTitleColor & 0xff);
        int nTitle = nSplit;
        if (nTitle > nLimit - n)
            nTitle = nLimit - n;
        memcpy(pOut + n, szText, nTitle);
        n += nTitle;
        pOut[n++] = KTC_ENTER;
        k = nSplit + 1;
        while (k < nLen && szText[k] == ' ')
            k++;
    } else {
        k = 0;
    }
    pOut[n++] = KTC_COLOR;
    pOut[n++] = (char) ((m_uStepColor >> 16) & 0xff);
    pOut[n++] = (char) ((m_uStepColor >> 8) & 0xff);
    pOut[n++] = (char) (m_uStepColor & 0xff);
    pOut[n++] = ' ';
    pOut[n++] = ' ';
    int nRest = nLen - k;
    if (nRest > nLimit - n)
        nRest = nLimit - n;
    if (nRest > 0) {
        memcpy(pOut + n, szText + k, nRest);
        n += nRest;
    }
    pOut[n] = 0;
    return n;
}

void KUiTaskTrace::Rebuild() {
    m_List.Clear();
    if (!IsEnabled()) {
        m_Scroll.Hide();
        Hide();
        return;
    }

    // newest unfinished records first
    int nOrder[TASKTRACE_MAX_ENTRY];
    int nShow = 0;
    int i, j;
    for (i = 0; i < m_nEntries; i++) {
        if (m_Entries[i].nAct == REA_FINISH || m_Entries[i].nLen <= 0)
            continue;
        nOrder[nShow++] = i;
    }
    for (i = 1; i < nShow; i++) {
        int nCur = nOrder[i];
        for (j = i; j > 0 && m_Entries[nOrder[j - 1]].uSeq < m_Entries[nCur].uSeq; j--)
            nOrder[j] = nOrder[j - 1];
        nOrder[j] = nCur;
    }
    if (nShow > m_nMaxShow)
        nShow = m_nMaxShow;

    char szLine[TASKTRACE_TEXT_LEN + 64];
    int n = 0;
    szLine[n++] = KTC_COLOR;
    szLine[n++] = (char) ((m_uCaptionColor >> 16) & 0xff);
    szLine[n++] = (char) ((m_uCaptionColor >> 8) & 0xff);
    szLine[n++] = (char) (m_uCaptionColor & 0xff);
    memcpy(szLine + n, s_szCaption, sizeof(s_szCaption) - 1);
    n += sizeof(s_szCaption) - 1;
    m_List.AddOneMessage(szLine, n);

    if (nShow == 0) {
        n = 0;
        szLine[n++] = KTC_COLOR;
        szLine[n++] = (char) ((m_uStepColor >> 16) & 0xff);
        szLine[n++] = (char) ((m_uStepColor >> 8) & 0xff);
        szLine[n++] = (char) (m_uStepColor & 0xff);
        memcpy(szLine + n, s_szEmpty, sizeof(s_szEmpty) - 1);
        n += sizeof(s_szEmpty) - 1;
        m_List.AddOneMessage(szLine, n);
    } else {
        for (i = 0; i < nShow; i++) {
            n = BuildLine(nOrder[i], szLine, sizeof(szLine));
            if (n > 0)
                m_List.AddOneMessage(szLine, n);
        }
    }

    if (m_bHasScroll && !m_Scroll.IsDisable())
        m_Scroll.Show();
    else
        m_Scroll.Hide();
    Show();
}

int KUiTaskTrace::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_Scroll)
                m_List.SetFirstShowLine(nParam);
            return 0;
        case WND_N_LIST_ITEM_ACTIVE:
            // Ctrl+click on a quest title opens the F11 journal.
            if (uParam == (unsigned int) (KWndWindow *) &m_List && KUiTaskNote::GetIfVisible() == NULL)
                KUiTaskNote::OpenWindow();
            return 0;
    }
    return KWndWindow::WndProc(uMsg, uParam, nParam);
}
