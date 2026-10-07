#ifndef PHONGTHAN_COMPOSE_H
#define PHONGTHAN_COMPOSE_H
#include "PhongThanWorldProtocol.h"
enum {
    PHONGTHAN_COMPOSE_REQUEST=0x5110, PHONGTHAN_COMPOSE_RESPONSE=0x5111,
    PHONGTHAN_COMPOSE_CORE_OP=0x505443, PHONGTHAN_COMPOSE_CORE_RESULT=0x505444
};
enum {
    PT_COMPOSE_OK=0,PT_COMPOSE_NO_RECIPE=1,PT_COMPOSE_NOT_NEAR_NPC=2,
    PT_COMPOSE_INVALID_ITEMS=3,PT_COMPOSE_NO_ROOM=4,PT_COMPOSE_LOCKED=5,
    PT_COMPOSE_TABLE_ERROR=6,PT_COMPOSE_STALE=7,PT_COMPOSE_NO_MONEY=8,
    PT_COMPOSE_NO_COST=9,PT_COMPOSE_UPGRADE_OK=10,PT_COMPOSE_RESTORE_OK=11,
    PT_COMPOSE_FAILED_LEVEL3=12,PT_COMPOSE_FAILED_LOST=13,PT_COMPOSE_FAILED_RESET=14,
    PT_COMPOSE_UPGRADE_RULE_MISSING=15,PT_COMPOSE_UPGRADE_MODE_MIX=16,
    PT_COMPOSE_RATE_UNVERIFIED=17
};
#pragma pack(push,1)
struct PHONGTHAN_COMPOSE_COMMAND {
    PHONGTHAN_WIRE_HEADER Header;
    PHONGTHAN_U32 MapId;
    PHONGTHAN_U32 Items[9];
};
struct PHONGTHAN_COMPOSE_RESULT {
    PHONGTHAN_WIRE_HEADER Header;
    PHONGTHAN_U32 MapId,EntityId;
    PHONGTHAN_S32 Result,RecipeId,OutputDetail;
};
#pragma pack(pop)
inline int PhongThanValidateComposeCommand(const void* data,unsigned int size) {
    if(!PhongThanWorldFixedPacket(data,size,PHONGTHAN_COMPOSE_REQUEST,PHONGTHAN_WIRE_FLAG_REQUEST,sizeof(PHONGTHAN_COMPOSE_COMMAND)))return 0;
    const PHONGTHAN_COMPOSE_COMMAND* c=(const PHONGTHAN_COMPOSE_COMMAND*)data;
    if(!c->MapId)return 0;
    for(int i=0;i<9;++i)for(int j=0;j<i;++j)if(c->Items[i] && c->Items[i]==c->Items[j])return 0;
    return 1;
}
inline int PhongThanComposeCountsEqual(const int* details,const int* counts,int count,
                                      const int* wanted,const int* quantities,int required) {
    for(int i=0;i<count;++i){int total=0;for(int j=0;j<required;++j)if(details[i]==wanted[j])total+=quantities[j];if(total!=counts[i])return 0;}
    for(int j=0;j<required;++j){bool found=false;for(int i=0;i<count;++i)if(details[i]==wanted[j])found=true;if(!found)return 0;}
    return count>0 && required>0;
}
#endif
