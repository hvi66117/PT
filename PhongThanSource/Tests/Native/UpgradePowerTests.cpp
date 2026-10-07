#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "../../Headers/PhongThanUpgradePower.h"
int main(int argc,char** argv){
 if(argc!=2)return 2;FILE* f=fopen(argv[1],"rb");if(!f)return 3;
 char line[2048];fgets(line,sizeof(line),f);int records=0;
 while(fgets(line,sizeof(line),f)){
  int id=atoi(line);if(id<=0)continue;
  int steps[12];char* p=strchr(line,'\t');
  for(int i=0;i<12;++i){if(!p)return 4;steps[i]=atoi(++p);p=strchr(p,'\t');}
  int prev=0;
  for(int level=0;level<=12;++level){int result=-1;assert(PhongThanSumUpgradePower(steps,12,level,result));
   if(level)assert(result-prev==steps[level-1]);else assert(result==0);prev=result;
   if(id==6 && level==1)assert(270+result==283);
   if(id==6 && level==2)assert(270+result==299);
   if(id==6 && level==3)assert(270+result==318);
  }
  int invalid;assert(!PhongThanSumUpgradePower(steps,12,13,invalid));
  printf("equipId=%d cumulative12=%d\n",id,prev);++records;
 }
 fclose(f);assert(records==7);
 int bad[]={INT_MAX,1},total;assert(!PhongThanSumUpgradePower(bad,2,2,total));
 puts("PASS: all seven equipment categories, levels 0..12, screenshot deltas and overflow.");return 0;
}
