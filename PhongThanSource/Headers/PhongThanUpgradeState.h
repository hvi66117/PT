#ifndef PHONGTHAN_UPGRADE_STATE_H
#define PHONGTHAN_UPGRADE_STATE_H
// Backward-compatible encoding of the native Phong Than UpgradeLevel field.
// Old records contain only 0..15. New records carry the explicit source rule
// in bits 8..23 with bit30 tagging the extended representation. This field
// remains equipment upgrade state; no unrelated item/script field is reused.
inline int PhongThanEncodeUpgradeState(int level,int rule)
{
    if(level<0 || level>15 || rule<0 || rule>65535)return -1;
    return rule && level ? 0x40000000 | (rule<<8) | level : level;
}
inline bool PhongThanDecodeUpgradeState(int state,int& level,int& rule)
{
    level=rule=0;
    if(state>=0 && state<=15){level=state;return true;}
    if((state & 0xff0000f0)!=0x40000000)return false;
    level=state&15;rule=(state>>8)&65535;
    return level>0 && rule>0;
}
#endif
