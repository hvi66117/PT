#pragma once

// The original out-game layouts were authored on an 800x600 canvas. Keep
// their assets at 1:1 scale and only translate the layout into the centre of
// the native canvas.
static inline void PhongThanGetNativeUiMetrics(int &nWidth, int &nHeight,
                                               int &nOffsetX, int &nOffsetY)
{
    nWidth = 800;
    nHeight = 600;
    Wnd_GetScreenSize(nWidth, nHeight);
    if (nWidth < 800)
        nWidth = 800;
    if (nHeight < 600)
        nHeight = 600;
    nOffsetX = (nWidth - 800) / 2;
    nOffsetY = (nHeight - 600) / 2;
}

static inline void PhongThanOffsetIniPosition(KIniFile &Ini,
                                              const char *pszSection,
                                              int nOffsetX, int nOffsetY)
{
    int nLeft = 0;
    int nTop = 0;
    Ini.GetInteger(pszSection, "Left", 0, &nLeft);
    Ini.GetInteger(pszSection, "Top", 0, &nTop);
    Ini.WriteInteger(pszSection, "Left", nLeft + nOffsetX);
    Ini.WriteInteger(pszSection, "Top", nTop + nOffsetY);
}

static inline void PhongThanOffsetIniPairIfPresent(KIniFile &Ini,
                                                   const char *pszSection,
                                                   const char *pszKey,
                                                   int nOffsetX, int nOffsetY)
{
    char szValue[64];
    szValue[0] = 0;
    Ini.GetString(pszSection, pszKey, "", szValue, sizeof(szValue));
    if (szValue[0])
    {
        int nX = 0;
        int nY = 0;
        Ini.GetInteger2(pszSection, pszKey, &nX, &nY);
        Ini.WriteInteger2(pszSection, pszKey, nX + nOffsetX, nY + nOffsetY);
    }
}

static inline void PhongThanCenterIniWindow(KIniFile &Ini,
                                            const char *pszSection,
                                            int nOffsetX, int nOffsetY)
{
    PhongThanOffsetIniPosition(Ini, pszSection, nOffsetX, nOffsetY);
    PhongThanOffsetIniPairIfPresent(Ini, pszSection, "StartPos", nOffsetX, nOffsetY);
    PhongThanOffsetIniPairIfPresent(Ini, pszSection, "EndPos", nOffsetX, nOffsetY);
}

static inline void PhongThanMakeIniRootNative(KIniFile &Ini,
                                              const char *pszSection,
                                              int nWidth, int nHeight)
{
    Ini.WriteInteger(pszSection, "Left", 0);
    Ini.WriteInteger(pszSection, "Top", 0);
    Ini.WriteInteger(pszSection, "Width", nWidth);
    Ini.WriteInteger(pszSection, "Height", nHeight);
}
