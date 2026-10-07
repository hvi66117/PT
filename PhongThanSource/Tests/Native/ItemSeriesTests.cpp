#include "../../Headers/PhongThanItemSeries.h"
#include <assert.h>
#include <stdio.h>
int main(){
 for(int n=0;n<5;++n){assert(PhongThanResolveItemSeries(1000,n,5,5)==n);assert(PhongThanResolveItemSeries(n,2,5,5)==n);}
 assert(PhongThanResolveItemSeries(1000,-1,5,5)==5);
 assert(PhongThanResolveItemSeries(1000,1000,5,5)==5);
 assert(PhongThanResolveItemSeries(1000,5,5,5)==5);
 assert(PhongThanResolveItemSeries(5,0,5,5)==5);
 puts("PASS: VNG 1000 marker resolves before wire; explicit series preserved.");return 0;
}
