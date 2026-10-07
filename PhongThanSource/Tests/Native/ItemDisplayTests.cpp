#include "../../Headers/PhongThanItemDisplay.h"
#include <assert.h>
#include <stdio.h>
int main()
{
    char output[80];
    PhongThanPlainItemName("#$<color=Cyan>Di ngo\xB9i ph\xEF<color>", output, sizeof(output));
    assert(!strcmp(output, "Di ngo\xB9i ph\xEF"));
    PhongThanPlainItemName("<color=red>$#Name</color><bclr=0,0,0>", output, sizeof(output));
    assert(!strcmp(output, "Name"));
    char small[4];
    PhongThanPlainItemName("abcdef", small, sizeof(small));
    assert(!strcmp(small, "abc"));
    PhongThanPlainItemName(0, output, sizeof(output));
    assert(output[0] == 0);
    puts("PASS: VNG name prefixes, color tags, Vietnamese bytes and bounded copy");
    return 0;
}
