#ifndef PHONGTHAN_LOGIN_ROLE_H
#define PHONGTHAN_LOGIN_ROLE_H

#include "../../../Headers/PhongThanProtocol.h"
#include <string.h>

// Storage must preserve the server identity. The UI's new-name input limit
// must never truncate a character already returned by the server.
struct KRoleChiefInfo {
    char Name[sizeof(((PHONGTHAN_CHARACTER_SUMMARY*)0)->Name)];
    unsigned char Gender;
    unsigned char Profession;
    union {
        unsigned short NativePlaceId;
        short nLevel;
    };
};

inline bool PhongThanReadLoginRole(const PHONGTHAN_CHARACTER_SUMMARY& source,
                                 KRoleChiefInfo& destination) {
    memset(&destination, 0, sizeof(destination));
    if (!source.Name[0] || !memchr(source.Name, 0, sizeof(source.Name)))
        return false;
    memcpy(destination.Name, source.Name, sizeof(source.Name));
    destination.Profession = source.Profession;
    destination.Gender = source.Gender;
    destination.nLevel = source.Level;
    return true;
}

#endif
