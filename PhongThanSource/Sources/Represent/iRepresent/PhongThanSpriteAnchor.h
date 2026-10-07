#ifndef PHONGTHAN_SPRITE_ANCHOR_H
#define PHONGTHAN_SPRITE_ANCHOR_H
#include <string.h>

// VNG human composites and passerby NPCs share the 510-square authoring
// canvas. An absent SPR centre is not a SwordOnline (160,192) anchor.
inline bool PhongThanUsesActorCanvas(const char* path, int width, int height)
{
    return path && width == 510 && height == 510 &&
        strstr(path,"npcres\\") != 0;  // 2026-10-03: was npcres human/passerby only (byte patch 0xB0C3)
}
inline void PhongThanActorReference(const char* path, int cx, int cy, int& x, int& y)
{
    const bool human = path && strstr(path,"npcres\\human\\");
    x -= (!human && (cx || cy)) ? cx : 255;
    y -= (!human && (cx || cy)) ? cy : 293;
}
#endif
