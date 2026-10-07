#ifndef PHONGTHAN_POWER_EXPRESSION_H
#define PHONGTHAN_POWER_EXPRESSION_H
#include <stdlib.h>
#include <errno.h>

// Preserve syntax independently of evaluation. A pair is not automatically
// a random interval: its VNG evaluation rule must be established separately.
enum PhongThanPowerKind { PT_POWER_EMPTY, PT_POWER_SCALAR, PT_POWER_PAIR, PT_POWER_INVALID };
struct PhongThanPowerExpression { int kind; int first; int second; };
inline const char* PhongThanPowerSpace(const char* p) {
    while(*p==' ' || *p=='\t' || *p=='\r' || *p=='\n') ++p;
    return p;
}
inline bool PhongThanPowerNumber(const char*& p, int& value) {
    p=PhongThanPowerSpace(p);char* end=0;errno=0;
    long n=strtol(p,&end,10);
    if(p==end || errno==ERANGE)return false;
    p=end;value=(int)n;return true;
}
inline PhongThanPowerExpression PhongThanParsePower(const char* text) {
    PhongThanPowerExpression result={PT_POWER_EMPTY,0,0};
    if(!text)return result;
    const char* p=PhongThanPowerSpace(text);
    if(!*p)return result;
    result.kind=PT_POWER_INVALID;
    bool pair=*p=='*';if(pair)++p;
    int first=0,second=0;
    if(!PhongThanPowerNumber(p,first))return result;
    p=PhongThanPowerSpace(p);
    if(pair){
        if(*p++!=',')return result;
        if(!PhongThanPowerNumber(p,second))return result;
        p=PhongThanPowerSpace(p);
        if(*p++!='*')return result;
    }
    if(*PhongThanPowerSpace(p))return result;
    result.kind=pair?PT_POWER_PAIR:PT_POWER_SCALAR;
    result.first=first;result.second=pair?second:first;
    return result;
}
#endif
