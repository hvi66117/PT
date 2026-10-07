#include "../../Headers/PhongThanPowerExpression.h"
#include <assert.h>
#include <stdio.h>
int main(){
 PhongThanPowerExpression p=PhongThanParsePower("*15,62*");
 assert(p.kind==PT_POWER_PAIR && p.first==15 && p.second==62);
 p=PhongThanParsePower(" 48 ");assert(p.kind==PT_POWER_SCALAR && p.first==48);
 assert(PhongThanParsePower(0).kind==PT_POWER_EMPTY);
 assert(PhongThanParsePower(" ").kind==PT_POWER_EMPTY);
 const char* bad[]={"*15,62", "*15*", "*15,x*", "*15,62*\"\"\"", "999999999999999999999", "12junk", "90%"};
 for(int i=0;i<sizeof(bad)/sizeof(bad[0]);++i)assert(PhongThanParsePower(bad[i]).kind==PT_POWER_INVALID);
 puts("PASS: scalar/pair/empty preserved; malformed/overflow/trailing garbage rejected.");return 0;
}
