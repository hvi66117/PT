#ifndef PHONGTHAN_EQUIPMENT_COLUMNS_H
#define PHONGTHAN_EQUIPMENT_COLUMNS_H
#include <stdlib.h>
#include <limits.h>
#include <errno.h>
#include "../../../Headers/PhongThanPowerExpression.h"

// Column identities from the original CP936 VNG headers. Physical row offsets
// are applied only after resolving the header (the shortened melee rows).
inline int PhongThanEquipColumn(KTabFile* table, const char* prefix, int index, const char* suffix)
{
    char key[96];
    if (index) sprintf(key, "%s%d%s", prefix, index, suffix);
    else sprintf(key, "%s%s", prefix, suffix);
    return table->FindColumn(key);
}
inline int PhongThanEquipInteger(KTabFile* table, int row, int column, int shift, int fallback)
{
    if (column <= 0) return fallback;
    char value[128];
    if (!table->GetString(row, column + shift, "", value, sizeof(value)) || !value[0]) return fallback;
    char* end = NULL;
    errno = 0;
    long number = strtol(value, &end, 10);
    // The percent unit belongs to the attribute type; tables may repeat it
    // in the numeric cell (90%). Keep 90, not 0 and not 0.9.
    if (end && end != value && *end == '%') ++end;
    while (end && (*end == ' ' || *end == '\r')) ++end;
    if (end == value || !end || *end || errno == ERANGE)
    {
        // Do not silently treat an expression or malformed value as a number.
        static int reports = 0;
        if (reports++ < 64)
            printf("[ITEM][SCHEMA] noninteger row=%d column=%d value=%s\n", row, column+shift, value);
        return fallback;
    }
    return (int)number;
}
inline void PhongThanReadEquipmentColumns(KTabFile* table, int row, int shift, KBASICPROP_EQUIPMENT* record)
{
    const char* basic = "\xBB\xF9\xB4\xA1\xCA\xF4\xD0\xD4";
    const char* req = "\xD0\xE8\xC7\xF3\xCA\xF4\xD0\xD4";
    const char* type = "\xC0\xE0\xD0\xCD";
    const char* low = "\xD7\xEE\xD0\xA1\xD6\xB5";
    const char* high = "\xD7\xEE\xB4\xF3\xD6\xB5";
    const char* val = "\xCA\xFD\xD6\xB5";
    ZeroMemory(record->m_aryPropBasic, sizeof(record->m_aryPropBasic));
    ZeroMemory(record->m_aryPropReq, sizeof(record->m_aryPropReq));
    for (int n=0;n<MAX_ITEM_BASEATTRIB;++n)
    {
        int tc=PhongThanEquipColumn(table,basic,n+1,type);
        int lc=PhongThanEquipColumn(table,basic,n+1,low);
        int hc=PhongThanEquipColumn(table,basic,n+1,high);
        if (tc<=0 || lc<=0 || hc<=0) continue;
        record->m_aryPropBasic[n].nType=PhongThanEquipInteger(table,row,tc,shift,0);
        record->m_aryPropBasic[n].sRange.nMin=PhongThanEquipInteger(table,row,lc,shift,0);
        record->m_aryPropBasic[n].sRange.nMax=PhongThanEquipInteger(table,row,hc,shift,0);
    }
    for (int r=0;r<6;++r)
    {
        int tc=PhongThanEquipColumn(table,req,r+1,type);
        int vc=PhongThanEquipColumn(table,req,r+1,val);
        if(tc<=0 || vc<=0) continue;
        record->m_aryPropReq[r].nType=PhongThanEquipInteger(table,row,tc,shift,0);
        record->m_aryPropReq[r].nPara=PhongThanEquipInteger(table,row,vc,shift,0);
    }
    struct Field { const char* name; int* target; int fallback; };
    Field fields[] = {
        {"\xB8\xBA\xD6\xD8", &record->m_nWeight, 0},
        {"\xCD\xAD\xC7\xAE\xBC\xDB\xB8\xF1", &record->m_nCopperPrice, 0},
        {"\xCA\xC7\xB7\xF1\xD3\xD0\xCC\xD8\xCA\xE2\xCD\xBC\xC6\xAC", &record->m_nHasSpecialImage,0},
        {"\xCA\xC7\xB7\xF1\xD3\xD0\xCC\xD8\xCA\xE2\xD0\xD4\xB1\xF0", &record->m_nSpecialSex,0},
        {"\xCA\xC7\xB7\xF1\xBF\xC9\xD2\xD4\xB6\xAA\xC6\xFA", &record->m_nCanDrop,1},
        {"\xCA\xC7\xB7\xF1\xBF\xC9\xD2\xD4\xBD\xBB\xBB\xBB", &record->m_nCanTrade,1},
        {"\xCA\xC7\xB7\xF1\xBF\xC9\xD2\xD4\xB6\xC4\xB2\xA9", &record->m_nCanGamble,1},
        {"\xCA\xC7\xB7\xF1\xB0\xDA\xCC\xAF", &record->m_nCanStall,1},
        {"PK\xB5\xF4\xC2\xE4\xB1\xEA\xBC\xC7", &record->m_nPkDropFlag,0},
        {"\xB4\xE6\xD4\xDA\xCA\xB1\xBC\xE4", &record->m_nExistTime,0},
        {"\xCA\xC7\xB7\xF1\xBF\xC9\xC2\xF4\xC9\xCC\xB5\xEA", &record->m_nCanSell,1},
        {"\xD7\xB0\xB1\xB8" "id", &record->m_nEquipId,0},
        {"\xB8\xBD\xBC\xD3\xCA\xF4\xD0\xD4\xB9\xA6\xC1\xA6", &record->m_nMagicPower,0},
        {"\xCC\xD7\xD7\xB0" "id", &record->m_nSetId,0}
    };
    for(int f=0;f<sizeof(fields)/sizeof(fields[0]);++f)
        *fields[f].target=PhongThanEquipInteger(table,row,
            PhongThanEquipColumn(table,fields[f].name,0,""),shift,fields[f].fallback);
    char powerText[128]; powerText[0]=0;
    int powerColumn=PhongThanEquipColumn(table,
        "\xBB\xF9\xB4\xA1\xCA\xF4\xD0\xD4\xB9\xA6\xC1\xA6",0,"");
    if(powerColumn>0) table->GetString(row,powerColumn+shift,"",powerText,sizeof(powerText));
    PhongThanPowerExpression power=PhongThanParsePower(powerText);
    record->m_nBasePowerKind=power.kind;
    record->m_nBasePowerFirst=power.first;
    record->m_nBasePowerSecond=power.second;
    record->m_nBasePower=power.kind==PT_POWER_SCALAR ? power.first : 0;
    if(power.kind==PT_POWER_INVALID)
        printf("[ITEM][SCHEMA] invalid power expression row=%d value=%s\n",row,powerText);
}
#endif
