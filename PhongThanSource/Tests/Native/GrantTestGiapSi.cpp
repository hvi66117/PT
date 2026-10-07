#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"

enum
{
    TEST_LEVEL = 200,
    GIAP_SI_FIRST_SKILL = 27,
    GIAP_SI_LAST_SKILL = 42,
    GIAP_SI_SKILL_LEVEL = 10,
    INVENTORY_CONTAINER = 3,
    INVENTORY_TEST_ROW = 2,
    EQUIPMENT_GENRE = 0,
    IBITEM_GENRE = 8,
    WILD_PORTAL_DETAIL = 35,
    WILD_PORTAL_PARTICULAR = 2
};

struct EQUIPMENT_SPEC
{
    int DetailType;
    int TemplateRow;
    int ParticularType;
};

static const EQUIPMENT_SPEC s_Equipment[] =
{
    { 0, 99, 9 }, // level-10 Giap Si long melee weapon (Dai dao)
    { 2, 9, 0 },  // level-10 Giap Si armor
    { 7, 9, 0 },  // level-10 Giap Si helm
    { 6, 9, 0 },  // level-10 Giap Si belt
    { 5, 9, 0 },  // level-10 Giap Si boots
    { 9, 9, 0 }   // level-10 Giap Si cloak
};

static void InitializeEquipment(PHONGTHAN_CHARACTER_ITEM_RECORD* pItem,
    const EQUIPMENT_SPEC& Spec, int nSlot)
{
    ZeroMemory(pItem, sizeof(*pItem));
    pItem->SchemaVersion = PHONGTHAN_EMBEDDED_ITEM_VERSION;
    pItem->TemplateRow = Spec.TemplateRow;
    pItem->Genre = EQUIPMENT_GENRE;
    pItem->Container = INVENTORY_CONTAINER;
    pItem->SlotX = nSlot;
    pItem->SlotY = INVENTORY_TEST_ROW;
    pItem->DetailType = Spec.DetailType;
    pItem->ParticularType = Spec.ParticularType;
    pItem->Level = 10;
    pItem->Series = PHONGTHAN_PROFESSION_GIAP_SI;
    pItem->TableVersion = 1;
    pItem->RandomSeed = 0x50544710UL + nSlot;
    pItem->Durability = -2;
    pItem->StackCount = 1;
}

static void InitializeWildPortal(PHONGTHAN_CHARACTER_ITEM_RECORD* pItem)
{
    ZeroMemory(pItem, sizeof(*pItem));
    pItem->SchemaVersion = PHONGTHAN_EMBEDDED_ITEM_VERSION;
    pItem->Genre = IBITEM_GENRE;
    pItem->Container = INVENTORY_CONTAINER;
    pItem->SlotX = sizeof(s_Equipment) / sizeof(s_Equipment[0]);
    pItem->SlotY = INVENTORY_TEST_ROW;
    pItem->DetailType = WILD_PORTAL_DETAIL;
    pItem->ParticularType = WILD_PORTAL_PARTICULAR;
    pItem->TableVersion = 1;
    pItem->Durability = -2;
    pItem->StackCount = 1;
}

int main(int argc, char** argv)
{
    if (argc < 2 || argc > 3)
    {
        puts("Usage: GrantTestGiapSi.exe <CharacterStore> [RoleName]");
        return 2;
    }
    const char* pRoleName = argc == 3 ? argv[2] : "PhongThanNpc";
    CPhongThanCharacterStore Store;
    BYTE OldBytes[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    BYTE NewBytes[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 nOldSize = 0;
    if (!Store.Open(argv[1]) ||
        !Store.Load(pRoleName, OldBytes, sizeof(OldBytes), &nOldSize))
        return 3;

    const PHONGTHAN_CHARACTER_STATE_HEADER* pOld =
        (const PHONGTHAN_CHARACTER_STATE_HEADER*)OldBytes;
    if (_stricmp((const char*)pOld->AccountName, "123456") != 0)
        return 4;

    ZeroMemory(NewBytes, sizeof(NewBytes));
    PHONGTHAN_CHARACTER_STATE_HEADER* pNew =
        (PHONGTHAN_CHARACTER_STATE_HEADER*)NewBytes;
    *pNew = *pOld;
    pNew->Revision = pOld->Revision + 1;
    pNew->FightLevel = TEST_LEVEL;
    pNew->FightExperience = 0;
    pNew->Profession = PHONGTHAN_PROFESSION_GIAP_SI;
    pNew->Power = 500;
    pNew->Agility = 500;
    pNew->Physique = 500;
    pNew->Wisdom = 500;
    pNew->RemainingAttributePoints = 0;
    pNew->RemainingSkillPoints = 0;

    PHONGTHAN_CHARACTER_SKILL_RECORD* pFight =
        PhongThanCharacterFightSkills(pNew);
    pFight[0].SkillId = 1;
    pFight[0].Level = 1;
    pFight[1].SkillId = 2;
    pFight[1].Level = 1;
    int nFightCount = 2;
    for (int nSkillId = GIAP_SI_FIRST_SKILL;
        nSkillId <= GIAP_SI_LAST_SKILL; ++nSkillId)
    {
        pFight[nFightCount].SkillId = nSkillId;
        pFight[nFightCount].Level = GIAP_SI_SKILL_LEVEL;
        pFight[nFightCount].Value = 0;
        ++nFightCount;
    }
    pNew->FightSkillCount = nFightCount;

    PHONGTHAN_CHARACTER_SKILL_RECORD* pState =
        PhongThanCharacterStateSkills(pNew);
    memcpy(pState, PhongThanCharacterStateSkills(pOld),
        pOld->StateSkillCount * sizeof(*pState));
    pNew->StateSkillCount = pOld->StateSkillCount;

    PHONGTHAN_CHARACTER_TASK_RECORD* pTasks =
        PhongThanCharacterTasks(pNew);
    memcpy(pTasks, PhongThanCharacterTasks(pOld),
        pOld->TaskCount * sizeof(*pTasks));
    pNew->TaskCount = pOld->TaskCount;

    PHONGTHAN_CHARACTER_ITEM_RECORD* pItems =
        PhongThanCharacterItems(pNew);
    const PHONGTHAN_CHARACTER_ITEM_RECORD* pOldItems =
        PhongThanCharacterItems(pOld);
    int nItemCount = 0;
    bool bHasWildPortal = false;
    unsigned int i;
    for (i = 0; i < pOld->ItemCount; ++i)
    {
        if (pOldItems[i].Genre != EQUIPMENT_GENRE)
        {
            pItems[nItemCount++] = pOldItems[i];
            if (pOldItems[i].Genre == IBITEM_GENRE &&
                pOldItems[i].DetailType == WILD_PORTAL_DETAIL &&
                pOldItems[i].ParticularType == WILD_PORTAL_PARTICULAR)
                bHasWildPortal = true;
        }
    }
    for (i = 0; i < sizeof(s_Equipment) / sizeof(s_Equipment[0]); ++i)
        InitializeEquipment(&pItems[nItemCount++], s_Equipment[i], i);
    if (!bHasWildPortal)
        InitializeWildPortal(&pItems[nItemCount++]);
    pNew->ItemCount = nItemCount;
    pNew->StateSize = PhongThanCharacterExpectedStateSize(pNew);
    if (!pNew->StateSize || pNew->StateSize > sizeof(NewBytes) ||
        !PhongThanValidateCharacterState(pNew, pNew->StateSize))
        return 5;
    if (!Store.Save(pNew, pNew->StateSize))
        return 6;

    printf("PASS role=%s level=%d profession=GiapSi skills=%u equipment=%u wildPortal=1 items=%u size=%u\n",
        pRoleName, pNew->FightLevel, pNew->FightSkillCount,
        (unsigned int)(sizeof(s_Equipment) / sizeof(s_Equipment[0])),
        pNew->ItemCount, pNew->StateSize);
    return 0;
}
