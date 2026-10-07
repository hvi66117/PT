#include "KWin32.h"
#include "KIniFile.h"
#include <stdio.h>

int main()
{
    KIniFile ini;
    for (int i = 0; i < 2000000; ++i)
    {
        ini.WriteInteger("Player", "Moving", i & 1);
    }
    int value = -1;
    if (!ini.GetInteger("Player", "Moving", -1, &value) || value != 1) return 2;
    printf("PASS: 2000000 repeated INI updates\n");
    return 0;
}
