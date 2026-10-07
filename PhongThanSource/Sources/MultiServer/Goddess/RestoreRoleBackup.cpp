#include "stdafx.h"
#include "DBTable.h"

#include <direct.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
struct RoleBasePrefix
{
    DWORD roleTime;
    char roleName[32];
    bool sex;
    char accountName[32];
};
#pragma pack(pop)

static int GetAccountIndex(DB *, const DBT *, const DBT *data, DBT *indexKey)
{
    memset(indexKey, 0, sizeof(DBT));
    if (!data || !data->data || data->size < sizeof(RoleBasePrefix))
        return EINVAL;

    RoleBasePrefix *role = (RoleBasePrefix *)data->data;
    role->accountName[sizeof(role->accountName) - 1] = '\0';
    indexKey->data = role->accountName;
    indexKey->size = strlen(role->accountName) + 1;
    return 0;
}

static bool ReadExact(FILE *file, void *buffer, size_t length)
{
    return file && buffer && fread(buffer, 1, length, file) == length;
}

int main(int argc, char **argv)
{
    if (argc < 4)
    {
        fprintf(stderr,
                "Usage: RestoreRoleBackup.exe <server-dir> <backup.bak> <account>\n");
        return 2;
    }

    const char *serverDirectory = argv[1];
    const char *backupPath = argv[2];
    const char *wantedAccount = argv[3];

    if (!SetCurrentDirectory(serverDirectory))
    {
        fprintf(stderr, "Cannot enter server directory: %s (error=%lu)\n",
                serverDirectory, GetLastError());
        return 3;
    }

    FILE *backup = fopen(backupPath, "rb");
    if (!backup)
    {
        fprintf(stderr, "Cannot open Goddess backup: %s\n", backupPath);
        return 4;
    }

    ZDBTable table("database", "roledb");
    if (table.addIndex(GetAccountIndex) != 0 || !table.open())
    {
        fclose(backup);
        fprintf(stderr, "Cannot open runtime role database. Stop Goddess first.\n");
        return 5;
    }

    int scanned = 0;
    int matched = 0;
    int imported = 0;
    int skipped = 0;
    int invalid = 0;

    for (;;)
    {
        size_t keySize = 0;
        size_t dataSize = 0;
        char key[64];
        char *data = NULL;

        if (fread(&keySize, sizeof(keySize), 1, backup) != 1)
        {
            if (!feof(backup))
                invalid++;
            break;
        }

        if (keySize == 0 || keySize > sizeof(key))
        {
            fprintf(stderr, "Invalid key size at record %d: %lu\n", scanned + 1,
                    (unsigned long)keySize);
            invalid++;
            break;
        }

        memset(key, 0, sizeof(key));
        if (!ReadExact(backup, key, keySize) ||
            fread(&dataSize, sizeof(dataSize), 1, backup) != 1 ||
            dataSize < sizeof(RoleBasePrefix) || dataSize >= 64 * 1024)
        {
            fprintf(stderr, "Invalid record header at record %d\n", scanned + 1);
            invalid++;
            break;
        }

        data = (char *)malloc(dataSize);
        if (!data || !ReadExact(backup, data, dataSize))
        {
            if (data)
                free(data);
            fprintf(stderr, "Cannot read record %d\n", scanned + 1);
            invalid++;
            break;
        }

        scanned++;
        RoleBasePrefix *role = (RoleBasePrefix *)data;
        role->roleName[sizeof(role->roleName) - 1] = '\0';
        role->accountName[sizeof(role->accountName) - 1] = '\0';

        if (strcmp(role->accountName, wantedAccount) != 0)
        {
            free(data);
            continue;
        }

        matched++;
        if (key[keySize - 1] != '\0' || strcmp(key, role->roleName) != 0)
        {
            fprintf(stderr, "Reject mismatched role record: key=%s data=%s\n", key,
                    role->roleName);
            invalid++;
            free(data);
            continue;
        }

        ZCursor *existing = table.search(key, (int)keySize);
        if (existing)
        {
            table.closeCursor(existing);
            printf("SKIP existing role=%s account=%s bytes=%lu\n", role->roleName,
                   role->accountName, (unsigned long)dataSize);
            skipped++;
            free(data);
            continue;
        }

        if (table.add(key, (int)keySize, data, (int)dataSize))
        {
            printf("IMPORTED role=%s account=%s bytes=%lu\n", role->roleName,
                   role->accountName, (unsigned long)dataSize);
            imported++;
        }
        else
        {
            fprintf(stderr, "FAILED role=%s account=%s\n", role->roleName,
                    role->accountName);
            invalid++;
        }

        free(data);
    }

    table.commit();
    table.close();
    fclose(backup);

    printf("SUMMARY scanned=%d matched=%d imported=%d skipped=%d invalid=%d\n",
           scanned, matched, imported, skipped, invalid);
    return (matched > 0 && imported + skipped == matched && invalid == 0) ? 0 : 6;
}
