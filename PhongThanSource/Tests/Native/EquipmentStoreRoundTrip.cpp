#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"
#include "../../Headers/PhongThanUpgradeState.h"
int main(int argc,char** argv){
 if(argc!=2)return 2;
 CPhongThanCharacterStore store;if(!store.Open(argv[1]))return 3;
 BYTE buffer[PHONGTHAN_CHARACTER_MAX_STATE_SIZE]={0};
 PHONGTHAN_CHARACTER_STATE_HEADER* state=(PHONGTHAN_CHARACTER_STATE_HEADER*)buffer;
 state->SchemaVersion=PHONGTHAN_CHARACTER_SCHEMA_VERSION;
 strcpy((char*)state->RoleName,"EquipmentRoundTrip");strcpy((char*)state->AccountName,"isolated_test");
 state->FightLevel=100;state->ItemCount=3;
 PHONGTHAN_CHARACTER_ITEM_RECORD* items=PhongThanCharacterItems(state);
 for(int i=0;i<3;++i){
  items[i].SchemaVersion=PHONGTHAN_EMBEDDED_ITEM_VERSION;
  items[i].TemplateRow=10+i;items[i].Genre=0;items[i].Container=3;
  items[i].SlotX=i;items[i].DetailType=i;items[i].Level=10;items[i].TableVersion=1;
  items[i].RandomSeed=0x123400+i;items[i].StackCount=1;
  items[i].UpgradeLevel=PhongThanEncodeUpgradeState(i*6,i==2?41:1);items[i].PhysicalValue=20+i;items[i].MagicValue=90+i;
 }
 state->StateSize=PhongThanCharacterExpectedStateSize(state);
 if(!store.Create(state,state->StateSize))return 4;
 BYTE restored[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];PHONGTHAN_U32 size=0;
 if(!store.Load("EquipmentRoundTrip",restored,sizeof(restored),&size) ||
   size!=state->StateSize || memcmp(buffer,restored,size))return 5;
 for(int n=0;n<3;++n){
  const PHONGTHAN_CHARACTER_ITEM_RECORD& item=PhongThanCharacterItems((PHONGTHAN_CHARACTER_STATE_HEADER*)restored)[n];
  PHONGTHAN_ITEM_SNAPSHOT packet={0};
  PhongThanInitializeWireHeader(&packet.Header,PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,sizeof(packet),PHONGTHAN_WIRE_FLAG_RESPONSE,0);
  packet.UpgradeLevel=item.UpgradeLevel;packet.PhysicalValue=item.PhysicalValue;packet.MagicValue=item.MagicValue;
  int level=0,rule=0;if(!PhongThanDecodeUpgradeState(packet.UpgradeLevel,level,rule) || level!=n*6 || (n && rule!=(n==2?41:1)))return 7;
  if(!PhongThanValidateItemSnapshot(&packet,sizeof(packet)) || packet.UpgradeLevel!=items[n].UpgradeLevel ||
    packet.PhysicalValue!=items[n].PhysicalValue || packet.MagicValue!=items[n].MagicValue)return 6;
 }
 puts("PASS: actual CharacterStore create/load preserves all item bytes and equipment metadata transfers to validated wire layout.");
 return 0;
}
