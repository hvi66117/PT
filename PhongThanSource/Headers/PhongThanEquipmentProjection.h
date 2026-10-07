#ifndef PHONGTHAN_EQUIPMENT_PROJECTION_H
#define PHONGTHAN_EQUIPMENT_PROJECTION_H
// Transfer modifiers without changing values; keep primary and unknown types.
template<class Attribute>
int PhongThanProjectEquipmentModifiers(Attribute* base, int baseCount,
    Attribute* modifiers, int capacity, int normalBegin, int normalEnd)
{
    int used=0;
    for(int i=5;i<baseCount && used<capacity;++i){
        if(base[i].nAttribType<=normalBegin || base[i].nAttribType>=normalEnd)continue;
        modifiers[used++]=base[i];
        base[i].nAttribType=0;
        base[i].nValue[0]=base[i].nValue[1]=base[i].nValue[2]=0;
    }
    return used;
}
#endif
