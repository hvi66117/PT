#ifndef S3CLIENT_WORKING_DIRECTORY_FIX_H
#define S3CLIENT_WORKING_DIRECTORY_FIX_H

#include <windows.h>
#include <string.h>

// The engine resolves rooted resource names (for example, \config.ini)
// relative to the process working directory.  Make that directory stable
// regardless of whether Game.exe is started from the batch file, Explorer,
// Codex, or another launcher.
class KClientWorkingDirectoryFix
{
public:
    KClientWorkingDirectoryFix()
    {
        char szExePath[MAX_PATH];
        DWORD dwLength = GetModuleFileNameA(NULL, szExePath, sizeof(szExePath));
        if (dwLength > 0 && dwLength < sizeof(szExePath))
        {
            char *pszLastSlash = strrchr(szExePath, '\\');
            if (pszLastSlash)
            {
                *pszLastSlash = 0;
                SetCurrentDirectoryA(szExePath);
            }
        }
    }
};

static KClientWorkingDirectoryFix g_ClientWorkingDirectoryFix;

#endif
