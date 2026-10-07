#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KTabFile.h"
#include "../../Headers/PhongThanUpgradeStats.h"
int main(int argc,char** argv){
 if(argc!=2)return 2;g_SetRootPath(argv[1]);
 KTabFile weapon,armor;char path[1024];
 strcpy(path,"\\jia_shi_wu_qi_sheng_ji_shu_zhi_biao.txt");if(!weapon.Load(path))return 3;
 strcpy(path,"\\jia_shi_kui_jia_sheng_ji_shu_zhi_biao.txt");if(!armor.Load(path))return 4;
 PhongThanUpgradeStat stats[20];int count=0;
 assert(PhongThanReadUpgradeStats(weapon,1,3,stats,20,count));
 assert(count==3 && stats[0].type==36 && stats[0].delta==12);
 assert(stats[1].type==28 && stats[1].delta==30);
 assert(stats[2].type==29 && stats[2].delta==30);
 assert(PhongThanReadUpgradeStats(armor,41,4,stats,20,count));
 assert(count==2 && stats[1].type==45 && stats[1].delta==42);
 assert(!PhongThanReadUpgradeStats(armor,999999,4,stats,20,count));
 assert(!PhongThanReadUpgradeStats(armor,41,16,stats,20,count));
 assert(!PhongThanReadUpgradeStats(weapon,1,3,stats,1,count));
 puts("PASS: original upgrade-rule deltas, weapon +30/+30 at 3, armor +42 at 4; unknown rules/overflow capacity rejected.");
 return 0;
}
