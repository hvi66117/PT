#ifndef WNDBORDER_H_
#define WNDBORDER_H_
#pragma once


#include "../../Represent/iRepresent/KRepresentUnit.h"

enum eTypeEquip {
    VioletEquip, //Tim
    GoldEquip, //Vang
    PlatinaEquip, // Bach kim
    NumType
};

void
DrawBorder(unsigned char &cFrame, unsigned char &ucTimeDelay, int &zpos, unsigned char &zdir, unsigned char &ztimedelay,
           int x, int y, int width, int height, int nNature);

#endif
