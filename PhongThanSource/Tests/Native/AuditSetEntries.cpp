#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
int main(int argc,char** argv) {
 if(argc!=3)return 2;g_SetRootPath(NULL);KPakList pak;
 if(!pak.Open(argv[1]))return 3;
 unsigned long ids[]={771097478,884177972};
 for(int i=0;i<2;++i){XPackElemFileRef ref;ZeroMemory(&ref,sizeof(ref));
  if(!pak.FindElemFile(ids[i],ref)){printf("MISSING %lu\n",ids[i]);continue;}
  char* data=(char*)malloc(1024*1024);int n=pak.ElemFileRead(ref,data,1024*1024);
  if(n<=0){free(data);return 4;}char path[1024];sprintf(path,"%s\\set_%lu.txt",argv[2],ids[i]);
  FILE* f=fopen(path,"wb");if(!f){free(data);return 5;}fwrite(data,1,n,f);fclose(f);free(data);
  printf("FOUND id=%lu bytes=%d path=%s\n",ids[i],n,path);
 }pak.Close();return 0;
}
