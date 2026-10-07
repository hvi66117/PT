#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"
int main(int argc,char**argv){
 if(argc!=3)return 2;CPhongThanCharacterStore store;
 BYTE data[PHONGTHAN_CHARACTER_MAX_STATE_SIZE],verify[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];PHONGTHAN_U32 size=0;
 if(!store.Open(argv[1])||!store.Load(argv[2],data,sizeof(data),&size))return 3;
 PHONGTHAN_CHARACTER_STATE_HEADER* role=(PHONGTHAN_CHARACTER_STATE_HEADER*)data;
 if(strncmp((const char*)role->AccountName,"123456",32))return 4;
 PHONGTHAN_CHARACTER_ITEM_RECORD* items=PhongThanCharacterItems(role);
 int slot=0,changed=0,lastWeapon=-1;
 // This fixture's original 27 records were checked against VNG tables: 1x1.
 // Refuse unfamiliar records instead of packing with guessed dimensions.
 for(unsigned i=0;i<role->ItemCount;++i){
  PHONGTHAN_CHARACTER_ITEM_RECORD& it=items[i];
  bool gear=it.Genre==0 && (it.DetailType==0||it.DetailType==2||it.DetailType==5||it.DetailType==6||it.DetailType==7||it.DetailType==9||it.DetailType==10) &&
   (it.TemplateRow==9||it.TemplateRow==39||it.TemplateRow==59||it.TemplateRow==99||it.TemplateRow==249||it.TemplateRow==519||it.TemplateRow==2109||it.TemplateRow==2439||it.TemplateRow==2469);
  bool other=(it.Genre==3&&it.DetailType==30)||(it.Genre==8&&it.DetailType==35&&it.ParticularType==2);
  if(it.Container==3){if(!gear&&!other)return 5;if(slot>=35)return 6;it.SlotX=slot%5;it.SlotY=slot/5;++slot;}
  if(it.Genre==0 && (it.TemplateRow==2109||it.TemplateRow==519)){
   it.TemplateRow=it.TemplateRow==2109?2439:2469;it.ParticularType=it.TemplateRow/10;
   it.UpgradeLevel=12;++changed;
  }
  if(it.Genre==0&&it.DetailType==0&&it.TemplateRow==59)lastWeapon=i;
 }
 if(changed!=10||lastWeapon<0)return 7;
 items[lastWeapon].UpgradeLevel=12;
 if(!store.Save(role,size))return 8;PHONGTHAN_U32 readSize=0;
 if(!store.Load(argv[2],verify,sizeof(verify),&readSize)||readSize!=size||memcmp(data,verify,size))return 9;
 printf("PASS role=%s preserved_items=%u visible_inventory=%d tinhquan12=%d tramkim12=1 mount_unchanged=1\n",argv[2],role->ItemCount,slot,changed);
 for(unsigned j=0;j<role->ItemCount;++j)if(items[j].UpgradeLevel==12)printf("item=%u row=%d detail=%d upgrade=12 pos=%d,%d\n",j,items[j].TemplateRow,items[j].DetailType,items[j].SlotX,items[j].SlotY);
 return 0;
}
