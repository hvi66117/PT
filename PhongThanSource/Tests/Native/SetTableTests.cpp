#include "../../Headers/PhongThanSetTable.h"
#include "../../Headers/PhongThanSetActivation.h"
#include <stdio.h>
#include <assert.h>
int main(int argc,char** argv){
 if(argc!=2)return 2;FILE* f=fopen(argv[1],"rb");if(!f)return 3;
 char bytes[65536];int n=fread(bytes,1,sizeof(bytes),f);fclose(f);
 PhongThanSetRow rows[4096];int count=PhongThanParseSetTable(bytes,n,rows,4096);
 if(count<=0){fprintf(stderr,"parse error=%d\n",count);return 4;}
 int lines=0;for(int i=0;i<count;++i)for(int j=0;j<10;++j)if(rows[i].type[j])++lines;
 printf("PASS parsed %d set IDs / %d effects; source slots retained\n",count,lines);
 for(int set=0;set<count;++set){
  int effects=0;for(int slot=0;slot<10;++slot)if(rows[set].type[slot])++effects;
  assert(PhongThanActiveSetEffectCount(0,effects)==0);
  assert(PhongThanActiveSetEffectCount(2,effects)==0);
  assert(PhongThanActiveSetEffectCount(3,effects)==(effects<3?effects:3));
  assert(PhongThanActiveSetEffectCount(4,effects)==(effects<4?effects:4));
  assert(PhongThanActiveSetEffectCount(5,effects)==effects);
  // Unequip from full to below threshold has no residual active lines.
  assert(PhongThanActiveSetEffectCount(2,effects)==0);
 }
 puts("PASS: production activation helper covers every parsed set at 0/2/3/4/5 pieces.");
 const char invalid[]="GroupID\tPrefix\tRulePercent\n5\tx\t100\n";
 assert(PhongThanParseSetTable(invalid,sizeof(invalid)-1,rows,4096)<0);
 // Repeated parsing must replace old rows, preserve negative values and holes,
 // and reject duplicates rather than selecting an arbitrary version.
 const char head[]="\xC2\xCC\xD7\xB0\xC3\xFB\xB3\xC6\tID\t";
 char fixture[256];sprintf(fixture,"%sTypes\nx\t5\t182\t20\t\t\t113\t-30\n",head);
 assert(PhongThanParseSetTable(fixture,strlen(fixture),rows,4096)==1);
 assert(rows[0].type[0]==182 && rows[0].value[0]==20);
 assert(rows[0].type[1]==0 && rows[0].type[2]==113 && rows[0].value[2]==-30);
 strcat(fixture,"x\t5\t182\t21\n");
 assert(PhongThanParseSetTable(fixture,strlen(fixture),rows,4096)==-3);
 assert(PhongThanParseSetTable(bytes,n,rows,1)==-4);
 return 0;
}
