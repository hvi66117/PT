#include "../../Sources/Core/Src/PhongThanNpcVisibility.h"
#include <assert.h>
#include <stdio.h>
int main()
{
    assert(PhongThanNpcInView(0,0));
    assert(PhongThanNpcInView(500,760)); // visible corner, rejected by old circle
    assert(PhongThanNpcInView(-500,-760));
    assert(PhongThanNpcInView(0,1000)); // sprite at bottom edge
    assert(PhongThanNpcInView(768,1280));
    assert(!PhongThanNpcInView(769,0));
    assert(!PhongThanNpcInView(0,1281));
    assert(!PhongThanNpcInView(-769,0));
    assert(!PhongThanNpcInView(0,-1281));
    assert(!PhongThanNpcInView(2147483647,2147483647));
    puts("PASS NPC_VIEWPORT_INTEREST");
    return 0;
}
