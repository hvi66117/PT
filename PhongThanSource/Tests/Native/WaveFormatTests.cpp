#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KWavFile.h"
static void Make(const char* path,bool truncated){
 FILE* f=fopen(path,"wb");assert(f);
 WAVEHEADER h={0x46464952,40,0x45564157,0x20746d66,16};
 WAVEFORMATEX fmt={1,1,22050,22050,1,8,0};
 DWORD id=0x61746164,size=truncated?1000:4;unsigned char samples[4]={128,128,128,128};
 fwrite(&h,1,sizeof(h),f);fwrite(&fmt,1,16,f);fwrite(&id,1,4,f);fwrite(&size,1,4,f);fwrite(samples,1,4,f);fclose(f);
}
int main(int argc,char** argv){if(argc!=2)return 2;g_SetRootPath(argv[1]);
 char path[1024];sprintf(path,"%s\\pcm16header.wav",argv[1]);Make(path,false);
 sprintf(path,"%s\\truncated.wav",argv[1]);Make(path,true);
 KWavFile file;assert(file.Open("\\pcm16header.wav"));WAVEFORMATEX fmt;memset(&fmt,0xCC,sizeof(fmt));file.GetPcmWavFormat(&fmt);
 assert(fmt.cbSize==0 && fmt.nChannels==1 && fmt.nBlockAlign==1);
 file.Close();assert(!file.Open("\\truncated.wav"));
 puts("PASS: 16-byte PCM format normalized; out-of-file audio length rejected.");return 0;}
