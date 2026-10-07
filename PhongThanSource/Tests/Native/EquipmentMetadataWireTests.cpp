#include "../../Headers/PhongThanProtocol.h"
#include "../../Headers/PhongThanCharacter.h"
#include <assert.h>
#include <string.h>
#include <stdio.h>
int main(){
 PHONGTHAN_CHARACTER_ITEM_RECORD saved;memset(&saved,0,sizeof(saved));
 saved.UpgradeLevel=12;saved.PhysicalValue=62;saved.MagicValue=197;
 PHONGTHAN_ITEM_SNAPSHOT packet;memset(&packet,0,sizeof(packet));
 PhongThanInitializeWireHeader(&packet.Header,PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,
   sizeof(packet),PHONGTHAN_WIRE_FLAG_RESPONSE,0);
 packet.UpgradeLevel=saved.UpgradeLevel;
 packet.PhysicalValue=saved.PhysicalValue;packet.MagicValue=saved.MagicValue;
 unsigned char bytes[sizeof(packet)];memcpy(bytes,&packet,sizeof(packet));
 PHONGTHAN_ITEM_SNAPSHOT decoded;memcpy(&decoded,bytes,sizeof(decoded));
 assert(decoded.Header.PacketSize==sizeof(decoded));
 assert(PhongThanValidateWireHeader(&decoded.Header,sizeof(decoded)));
 assert(PhongThanValidateItemSnapshot(bytes,sizeof(bytes)));
 assert(decoded.UpgradeLevel==12 && decoded.PhysicalValue==62 && decoded.MagicValue==197);
 assert(sizeof(decoded)>12 && !PhongThanValidateWireHeader(&decoded.Header,sizeof(decoded)-12));
 assert(!PhongThanValidateItemSnapshot(bytes,sizeof(bytes)-12));
 assert(!PhongThanValidateItemSnapshot(0,sizeof(bytes)));
 decoded.Header.PacketSize=sizeof(decoded)-12;
 assert(!PhongThanValidateItemSnapshot(&decoded,sizeof(decoded)));
 decoded.Header.PacketSize=sizeof(decoded);
 decoded.Header.Flags=PHONGTHAN_WIRE_FLAG_REQUEST;
 assert(!PhongThanValidateItemSnapshot(&decoded,sizeof(decoded)));
 decoded.Header.Flags=PHONGTHAN_WIRE_FLAG_RESPONSE;
 decoded.Header.MessageType=PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST;
 assert(!PhongThanValidateItemSnapshot(&decoded,sizeof(decoded)));
 puts("PASS: persisted equipment metadata round-trips through wire bytes; truncated old packet rejected.");
 return 0;
}
