#include <stdio.h>
#include <string.h>
#include "../../Sources/GameClient/Login/PhongThanLoginRole.h"

#define CHECK(value) do { if (!(value)) { printf("FAIL line=%d\n", __LINE__); return 1; } } while (0)

int main() {
    const char* names[] = {
        "PhongThanPl", "PhongThan123", "PhongThanPlay",
        "1234567890123456789012345678901"
    };
    for (unsigned int i = 0; i < sizeof(names) / sizeof(names[0]); ++i) {
        PHONGTHAN_CHARACTER_SUMMARY wire;
        memset(&wire, 0, sizeof(wire));
        strcpy((char*)wire.Name, names[i]);
        wire.Gender = 1;
        wire.Profession = 2;
        wire.Level = 200;
        KRoleChiefInfo role;
        CHECK(PhongThanReadLoginRole(wire, role));
        CHECK(strcmp(role.Name, names[i]) == 0);
        CHECK(role.Gender == 1 && role.Profession == 2 && role.nLevel == 200);
        PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST select;
        memset(&select, 0, sizeof(select));
        strncpy((char*)select.RoleName, role.Name, sizeof(select.RoleName) - 1);
        CHECK(strcmp((char*)select.RoleName, names[i]) == 0);
    }
    PHONGTHAN_CHARACTER_SUMMARY invalid;
    memset(&invalid, 0, sizeof(invalid));
    KRoleChiefInfo role;
    CHECK(!PhongThanReadLoginRole(invalid, role));
    memset(invalid.Name, 'A', sizeof(invalid.Name));
    CHECK(!PhongThanReadLoginRole(invalid, role));
    CHECK(role.Name[0] == 0);
    puts("PASS LOGIN_ROLE_IDENTITY: 11/12/13/31-byte names preserved; empty/unterminated rejected");
    return 0;
}
