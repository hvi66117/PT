#include <stdio.h>
#include <string.h>
#include <string>
#include <vector>
#include <assert.h>
#ifdef REAL_ENGINE_TABLE
#include <windows.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
#include "KTabFile.h"
#endif
#define MAX_ITEM_BASEATTRIB 20
#define ZeroMemory(p,n) memset(p,0,n)
struct Basic { int nType; struct { int nMin,nMax; } sRange; };
struct Req { int nType,nPara; };
struct KBASICPROP_EQUIPMENT {
 int m_nBasePowerKind,m_nBasePowerFirst,m_nBasePowerSecond;
 Basic m_aryPropBasic[20]; Req m_aryPropReq[6];
 int m_nWeight,m_nCopperPrice,m_nHasSpecialImage,m_nSpecialSex,m_nCanDrop,m_nCanTrade,m_nCanGamble,m_nCanStall,m_nPkDropFlag,m_nExistTime,m_nCanSell,m_nEquipId,m_nBasePower,m_nMagicPower,m_nSetId;
};
#ifndef REAL_ENGINE_TABLE
class KTabFile {
public:
 std::vector<std::vector<std::string> > rows;
 int FindColumn(char* key) { for(unsigned i=0;i<rows[0].size();++i) if(rows[0][i]==key) return i+1; return -1; }
 int GetString(int row,int col,const char*,char* out,int size) {
  out[0]=0;if(row<=0||col<=0||row>(int)rows.size()||col>(int)rows[row-1].size())return 0;
  strncpy(out,rows[row-1][col-1].c_str(),size-1);out[size-1]=0;return 1;
 }
 bool Load(const char* name) {
  FILE* f=fopen(name,"rb");if(!f)return false;char line[65536];
  while(fgets(line,sizeof(line),f)) {
   char* end=strpbrk(line,"\r\n");if(end)*end=0;if(!line[0])continue;
   std::vector<std::string> cols;char* p=line;char* tab;
   while((tab=strchr(p,'\t'))!=0){*tab=0;cols.push_back(p);p=tab+1;}cols.push_back(p);rows.push_back(cols);
  }fclose(f);return !rows.empty();
 }
};
#endif
#include "../../Sources/Core/Src/PhongThanEquipmentColumns.h"
int main(int argc,char** argv) {
 if(argc!=2)return 2;
#ifndef REAL_ENGINE_TABLE
 KTabFile unitTable;std::vector<std::string> unitRow;
 unitRow.push_back("90%");unitRow.push_back("90%junk");unitTable.rows.push_back(unitRow);
 assert(PhongThanEquipInteger(&unitTable,1,1,0,-1)==90);
 assert(PhongThanEquipInteger(&unitTable,1,2,0,-1)==-1);
#endif
#ifdef REAL_ENGINE_TABLE
 g_SetRootPath(NULL); KPakList pak;
 if(!pak.Open(argv[1]))return 4;
 g_pPakList=&pak; g_SetPakFileMode(1);
#endif
 const char* names[]={"armor","helm","belt","boot","pendant","meleeweapon","rangeweapon","horse","amulet","ring","cuff"};
 int total=0, shifted=0;
 for(int t=0;t<11;++t){
  char path[1024];
#ifdef REAL_ENGINE_TABLE
  sprintf(path,"\\settings\\item\\001\\%s.txt",names[t]);
#else
  sprintf(path,"%s\\%s.txt",argv[1],names[t]);
#endif
  KTabFile table;if(!table.Load(path))return 3;
#ifdef REAL_ENGINE_TABLE
  const int height=table.GetHeight();
#else
  const int height=(int)table.rows.size();
#endif
  for(int row=2;row<=height;++row){
   int shift=0;char col4[256];table.GetString(row,4,"",col4,sizeof(col4));
   if(t==5 && (col4[0]=='\\'||col4[0]=='/')){shift=-1;++shifted;}
   KBASICPROP_EQUIPMENT record;ZeroMemory(&record,sizeof(record));PhongThanReadEquipmentColumns(&table,row,shift,&record);
   if(t==0 && row==41){assert(record.m_nSetId==5);assert(record.m_aryPropBasic[5].nType==179);assert(record.m_aryPropReq[0].nType==36);}
   if(t==5 && row==61){assert(record.m_nSetId==0);assert(record.m_aryPropBasic[5].nType==115);
     assert(record.m_nBasePowerKind==PT_POWER_PAIR);assert(record.m_nBasePowerFirst==15);assert(record.m_nBasePowerSecond==62);}
   ++total;
  }
 }
 fprintf(stderr,"COUNTS total=%d shifted=%d\n",total,shifted);
 assert(total==27471);assert(shifted==0);
 puts("PASS: shared production column reader exercised across 27471 raw-byte records / 11 tables.");
#ifdef REAL_ENGINE_TABLE
 g_pPakList=NULL;pak.Close();
#endif
 return 0;
}
