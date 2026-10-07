#include "../../Headers/PhongThanEquipmentProjection.h"
#include <assert.h>
#include <string.h>
#include <stdio.h>
struct A {int nAttribType;int nValue[3];};
int main(){
 A base[20]={0},out[6]={0};
 base[0].nAttribType=45;base[5].nAttribType=115;base[5].nValue[0]=20;
 base[6].nAttribType=58;base[7].nAttribType=177;base[7].nValue[0]=150;
 base[8].nAttribType=400;base[9].nAttribType=182;base[9].nValue[0]=30;
 assert(PhongThanProjectEquipmentModifiers(base,20,out,6,84,357)==3);
 assert(out[0].nAttribType==115 && out[0].nValue[0]==20);
 assert(out[1].nAttribType==177 && out[1].nValue[0]==150);
 assert(out[2].nAttribType==182 && out[2].nValue[0]==30);
 assert(base[0].nAttribType==45 && base[6].nAttribType==58 && base[8].nAttribType==400);
 assert(base[5].nAttribType==0 && base[7].nAttribType==0);
 base[5].nAttribType=115;assert(PhongThanProjectEquipmentModifiers(base,20,out,0,84,357)==0);
 assert(base[5].nAttribType==115);
 puts("PASS: modifier values/order preserved; primary/unknown/overflow attributes retained; no SetID dependency.");return 0;
}
