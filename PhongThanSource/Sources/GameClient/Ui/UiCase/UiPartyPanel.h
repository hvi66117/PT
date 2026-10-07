/*
 * File:     UiPartyPanel.h
 * Desc:     Phong Than team list, VNG style (right side of the screen, under the mini map).
 *           Shows the bot party ("[To doi]" companions, docs\features\to-doi-bot-phong-than-20261003.md)
 *           and also a real team: one row per member with name, level/profession badge and life bar.
 *           Layout and sprites are VNG's own team member list (PAK id d180f81d, serverlist.pak).
 * Creation: 2026-10-03 (agent partypanel)
 */
#pragma once

#if !defined _UIPARTYPANEL
#define _UIPARTYPANEL

#include "../Elem/WndWindow.h"
#include "../Elem/UiImage.h"
#include "../../../core/src/PhongThanPartyPanel.h"

class KUiPartyPanel : public KWndWindow {
public:
    static KUiPartyPanel *OpenWindow();         // create once per game session (UiStartGame)
    static void CloseWindow();                  // destroy (leaving the game)
    static KUiPartyPanel *GetSelf() { return m_pSelf; }
    static void LoadScheme(const char *pScheme);
    static void Toggle();                       // Alt+G / Open([[partypanel]]); persisted in UiCommon.ini
    static int  IsEnabled();

    virtual int PtInWindow(int x, int y) { return 0; }   // click-through, never blocks the game space
    virtual void PaintWindow();

    // Offline tests: feed data instead of asking CoreClient.
    void SetDataForTest(const KPTPartyInfo *pInfo);
    const KPTPartyInfo &GetData() const { return m_Info; }
    int  GetRowTop(int nRow) const { return m_nMemberTop + nRow * m_nRowHeight; }

private:
    KUiPartyPanel();
    virtual ~KUiPartyPanel() {}

    virtual void Breathe();
    void Initialize();
    void ApplyLayout(KIniFile *pIni);
    void Query();
    void PaintRow(int nRow, const KPTPartyMember &m);
    void DrawImage(KUiImageRef &Img, int x, int y);
    void DrawText(int nFont, const char *pText, int nLen, int x, int y, unsigned int uColor);

    static void LoadSetting();
    static void StoreSetting();
    static void SetImage(KUiImageRef &Img, const char *pPath);

private:
    static KUiPartyPanel *m_pSelf;
    static int ms_nEnabled;                     // -1 not loaded yet

    KPTPartyInfo m_Info;
    unsigned int m_uLastQuery;
    int m_bTestData;

    // layout (VNG keys of the team member list ini + a few Phong Than additions)
    int m_nRowHeight;                           // MemberWndHeight
    int m_nMemberTop;                           // first row (below the caption)
    int m_nMaxMember;
    int m_nNameLeft, m_nNameTop, m_nNameWidth, m_nNameFont;
    unsigned int m_uNameColor, m_uCaptainColor, m_uFarColor, m_uDeadColor, m_uLevelColor;
    int m_nLevelLeft, m_nLevelTop, m_nLevelFont;
    int m_nCareerLeft, m_nCareerTop;
    int m_nSkeletonLeft, m_nSkeletonTop;
    int m_nLifeLeft, m_nLifeTop;
    int m_nBorderLeft, m_nBorderTop;
    int m_nFlagLeft, m_nFlagTop;                // < 0: right end of the name line
    int m_nCaptionLeft, m_nCaptionTop, m_nCaptionFont;
    unsigned int m_uCaptionColor;

    KUiImageRef m_ImgCareer[3];                 // jiashi / daoshi / yiren
    KUiImageRef m_ImgSkeleton;
    KUiImageRef m_ImgBorder;
    KUiImageRef m_ImgFlag;
    KUiImagePartRef m_ImgLife;
};

#endif
