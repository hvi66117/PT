#ifndef SWORDONLINE_ITEM_ACTION_DIAG_H
#define SWORDONLINE_ITEM_ACTION_DIAG_H

// Small, opt-in runtime trace for the inventory use-item path.  The legacy
// binaries are launched without a debugger, so a file in the active runtime
// is the most reliable way to identify where an action stops.
#include <stdio.h>

static void SO_ItemActionDiag(const char *pszEvent,
                              unsigned int uGenre,
                              unsigned int uId,
                              int nX,
                              int nY,
                              int nWidth,
                              int nHeight,
                              int nStatus,
                              int nExtra)
{
    const char *pszPath = "item_action_diag.log";
    FILE *pFile = fopen(pszPath, "a+b");
    if (!pFile)
        return;
    fprintf(pFile,
            "%s genre=%u id=%u pos=%d,%d size=%d,%d status=%d extra=%d\\r\\n",
            pszEvent ? pszEvent : "item_action",
            uGenre, uId, nX, nY, nWidth, nHeight, nStatus, nExtra);
    fclose(pFile);
}

static void SO_ItemActionDiagText(const char *pszEvent, const char *pszText,
                                  int nValue1, int nValue2)
{
    const char *pszPath = "item_action_diag.log";
    FILE *pFile = fopen(pszPath, "a+b");
    if (!pFile)
        return;
    fprintf(pFile, "%s text=%s value1=%d value2=%d\\r\\n",
            pszEvent ? pszEvent : "item_action",
            pszText ? pszText : "", nValue1, nValue2);
    fclose(pFile);
}

#endif
