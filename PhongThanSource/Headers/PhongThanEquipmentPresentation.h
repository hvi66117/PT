#ifndef PHONGTHAN_EQUIPMENT_PRESENTATION_H
#define PHONGTHAN_EQUIPMENT_PRESENTATION_H
#include <string.h>
#include <stdio.h>
#include <limits.h>

// Reserved system inline-picture range, below Text.h's 512 custom boundary.
// Original yellow strip: 15 stars, pitch 14, width 208; +12 uses 166 pixels.
#define PT_UPGRADE_PIC_BASE 480
inline int PhongThanStarCount(int pic) { return pic>480 && pic<=492 ? pic-480 : 0; }
inline int PhongThanStarWidth(int count) { return count==12?172:count*14-2; }
inline bool PhongThanBigItemPath(const char* icon,bool female,char* out,int capacity)
{
    if(!icon || !out || capacity<1)return false;
    int len=(int)strlen(icon);
    const char* suffix=female?"_big_female.spr":"_big_male.spr";
    if(len<4 || _stricmp(icon+len-4,".spr") || len-4+(int)strlen(suffix)>=capacity)return false;
    memcpy(out,icon,len-4);strcpy(out+len-4,suffix);return true;
}
inline bool PhongThanSumKnownItemPower(int base,int magic,int upgrade,int& total)
{
    total=0;
    if(base<0 || magic<0 || upgrade<0 || base>INT_MAX-magic || base+magic>INT_MAX-upgrade)return false;
    total=base+magic+upgrade;return true;
}
#define PT_VNG_STAR_STRIP "\\spr\\ui4\\tips\\\xD0\xC7\xD0\xC7\xBB\xC6\xC9\xAB.spr"
#define PT_VNG_STAR_FRAME12 "\\spr\\ui4\\tips\\\xB1\xDF\xBF\xF2" "12.spr"
#define PT_VNG_EQUIP_FX_ROOT "\\spr\\ui4\\\xB5\xC0\xBE\xDF\xC0\xB8\\"
#endif
