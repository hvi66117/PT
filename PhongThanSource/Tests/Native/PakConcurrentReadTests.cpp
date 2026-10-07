#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
struct Entry {XPackElemFileRef ref; char* bytes;int size;};
static Entry entries[32];static int count=0;static KPakList* pak=0;static LONG failures=0;
static DWORD WINAPI Worker(void* arg){
 int id=(int)arg;
 for(int pass=0;pass<30;++pass)for(int j=0;j<count;++j){
  Entry& e=entries[(j+id+pass)%count];XPackElemFileRef ref=e.ref;ref.nOffset=0;
  char* bytes=(char*)malloc(e.size);if(!bytes){InterlockedIncrement(&failures);return 1;}
  int n=pak->ElemFileRead(ref,bytes,e.size);
  if(n!=e.size || memcmp(bytes,e.bytes,e.size))InterlockedIncrement(&failures);
  free(bytes);
 }return 0;
}
int main(int argc,char** argv){
 if(argc!=2)return 2;SetCurrentDirectoryA(argv[1]);g_SetRootPath(NULL);KPakList list;
 if(!list.Open("\\package.ini"))return 3;pak=&list;
 const char* files[]={"armor","helm","belt","boot","pendant","horse","meleeweapon","rangeweapon","amulet","ring","cuff","material","questkey","ibitem","magicscript"};
 for(int i=0;i<15;++i){char name[160];sprintf(name,"\\settings\\item\\001\\%s.txt",files[i]);
  Entry& e=entries[count];memset(&e,0,sizeof(e));
  if(!list.FindElemFile(name,e.ref))return 4;e.size=e.ref.nSize;e.bytes=(char*)malloc(e.size);
  if(!e.bytes || list.ElemFileRead(e.ref,e.bytes,e.size)!=e.size)return 5;e.ref.nOffset=0;++count;
 }
 // Include original settings.pak entries alongside override PAK item tables.
 unsigned long ids[]={771097478,884177972};for(int k=0;k<2;++k){Entry& e=entries[count];memset(&e,0,sizeof(e));
  if(!list.FindElemFile(ids[k],e.ref))return 6;e.size=e.ref.nSize;e.bytes=(char*)malloc(e.size);
  if(!e.bytes || list.ElemFileRead(e.ref,e.bytes,e.size)!=e.size)return 7;e.ref.nOffset=0;++count;
 }
 HANDLE threads[4];for(int t=0;t<4;++t)threads[t]=CreateThread(NULL,0,Worker,(void*)t,0,NULL);
 WaitForMultipleObjects(4,threads,TRUE,INFINITE);for(t=0;t<4;++t)CloseHandle(threads[t]);
 for(i=0;i<count;++i)free(entries[i].bytes);list.Close();
 printf("PAK_CONCURRENT reads=%d threads=4 byte_mismatches=%ld\n",count*30*4,failures);
 return failures?8:0;
}
