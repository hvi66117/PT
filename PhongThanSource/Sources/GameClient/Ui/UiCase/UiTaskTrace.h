/*
 * File:     UiTaskTrace.h
 * Desc:     Phong Than quest tracker (VNG "task hint" panel, left side of the screen).
 *           Shows the newest unfinished F11 quest records (title + current step) and
 *           follows every TaskNote/AddNote record the server sends.
 * Creation: 2026-10-03 (agent questtrack)
 */
#pragma once

#if !defined _UITASKTRACE
#define _UITASKTRACE

#include "../Elem/WndWindow.h"
#include "../Elem/WndMessageListBox.h"
#include "../Elem/WndScrollBar.h"

#define TASKTRACE_MAX_ENTRY        48      // distinct journal headers remembered (server uses 0..35)
#define TASKTRACE_TEXT_LEN         512     // == MAX_MESSAGE_LENGTH
#define TASKTRACE_DEFAULT_SHOW     5       // quests shown at most (ini [Main] MaxTrace)

class KUiTaskTrace : public KWndWindow {
public:
    static KUiTaskTrace *OpenWindow();          // create once per game session, reload MissionMemory.dat
    static void CloseWindow();                  // destroy (leaving the game)
    static KUiTaskTrace *GetSelf() { return m_pSelf; }
    static void LoadScheme(const char *pScheme);
    static void Toggle();                       // hotkey Alt+N / Open([[tasktrace]]); persisted in UiCommon.ini
    static int  IsEnabled();

    // A record the client just received (KUiTaskNote::WakeUp).
    static void OnRecord(unsigned int uHeaderID, int nAct, const char *pText, int nLen);
    // Seed from the stored journal, newest record first (KUiTaskNote::FeedTaskTrace).
    static void SeedRecord(unsigned int uHeaderID, int nAct, const char *pText, int nLen);
    // 2026-10-04 timduong: first "(x.y)" / "(x/y)" of the newest unfinished quest that has one (Alt+F prefill).
    static int PTFindCoord(int *px, int *py);

    virtual int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

private:
    KUiTaskTrace();
    virtual ~KUiTaskTrace() {}

    void Initialize();
    void ApplyLayout(KIniFile *pIni);
    void Reload();
    void Rebuild();
    int  FindEntry(unsigned int uHeaderID);
    int  AllocEntry();
    void SetEntry(int nIndex, unsigned int uHeaderID, int nAct, const char *pText, int nLen, unsigned int uSeq);
    int  BuildLine(int nIndex, char *pOut, int nOutSize);

    static void LoadSetting();
    static void StoreSetting();

private:
    struct KTraceEntry {
        unsigned int uHeaderID;
        int nAct;
        unsigned int uSeq;
        int nLen;
        char szText[TASKTRACE_TEXT_LEN];
    };

    static KUiTaskTrace *m_pSelf;
    static int ms_nEnabled;                     // -1 not loaded yet

    KWndMessageListBox m_List;
    KWndScrollBar m_Scroll;
    int m_bHasScroll;
    int m_nMaxShow;
    unsigned int m_uTitleColor, m_uStepColor, m_uCaptionColor;

    KTraceEntry m_Entries[TASKTRACE_MAX_ENTRY];
    int m_nEntries;
    unsigned int m_uSeq;                        // live records get ++m_uSeq
    unsigned int m_uSeedSeq;                    // seeded records count down from below the live range
};

#endif
