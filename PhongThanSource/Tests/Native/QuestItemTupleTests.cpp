#include "KCore.h"
#include "KPakList.h"
#include "KBasPropTbl.h"
#include "PhongThanQuestItemTuple.h"
#include <stdio.h>

KPakList* g_pPakList = NULL;

#define CHECK(x) do { if (!(x)) { printf("FAIL line=%d %s\n", __LINE__, #x); return 1; } } while(0)

struct TestItem
{
    int genre, detail, particular, level, series;
    int GetGenre() { return genre; }
    int GetDetailType() { return detail; }
    int GetParticular() { return particular; }
    int GetLevel() { return level; }
    int GetSeries() { return series; }
};

int main(int argc, char** argv)
{
    if (argc != 2 || !SetCurrentDirectoryA(argv[1])) return 2;
    g_SetRootPath(NULL);
    g_SetFilePath("\\");
    KPakList packs;
    CHECK(packs.Open("\\package.ini"));
    g_pPakList = &packs;
    g_SetPakFileMode(1);
    KLibOfBPT library;
    CHECK(library.Init());

    // Exercise the production VNG table loader and the production resolver,
    // including high IDs which the former detail*5 formula could not load.
    int checked = 0;
    for (int row = 0; row < library.GetMedicineRecordNumber(); ++row)
    {
        const KBASICPROP_MEDICINE* entry = library.GetMedicineRecord(row);
        CHECK(entry && entry->m_nItemGenre == item_medicine);
        CHECK(library.FindMedicine(entry->m_nDetailType, entry->m_nLevel) == entry);
        ++checked;
    }
    CHECK(checked == 29);
    CHECK(library.FindMedicine(0, 1) == library.GetMedicineRecord(0));
    CHECK(library.FindMedicine(3, 1) == library.GetMedicineRecord(3));
    CHECK(library.FindMedicine(28, 1) == library.GetMedicineRecord(28));
    CHECK(!library.FindMedicine(29, 1));
    CHECK(!library.FindMedicine(0, 2));
    CHECK(!library.FindMedicine(-1, 1));
    CHECK(!library.FindMedicine(0, 0));

    int books = 0;
    for (int bookRow = 0; bookRow < library.GetSkillBookRecordNumber(); ++bookRow)
    {
        const KBASICPROP_SKILLBOOK* book = library.SkillBookAt(bookRow);
        CHECK(book && book->m_nItemGenre == item_skillbook);
        CHECK(library.GetSkillBook(book->m_nDetailType, book->m_nParticularType) == book);
        ++books;
    }
    CHECK(books == 104);
    CHECK(library.GetSkillBook(58, 62) == library.SkillBookAt(58));
    CHECK(library.GetSkillBook(59, 128) == library.SkillBookAt(59));
    CHECK(!library.GetSkillBook(58, 128));
    CHECK(!library.GetSkillBook(59, 62));
    CHECK(!library.GetSkillBook(58, 0));

    PhongThanQuestItemTuple tuple;
    CHECK(PhongThanDecodeQuestItemTuple(1,0,1,1,0,0,tuple));
    CHECK(tuple.genre == item_medicine && tuple.detail == 0 && tuple.particular == 0 && tuple.level == 1);
    CHECK(PhongThanDecodeQuestItemTuple(1,3,1,1,0,0,tuple));
    CHECK(tuple.detail == 3 && tuple.particular == 0 && tuple.level == 1);
    CHECK(PhongThanDecodeQuestItemTuple(1,0,0,0,1,0,tuple));
    CHECK(tuple.level == 1 && tuple.series == 0);
    CHECK(PhongThanDecodeQuestItemTuple(1,3,0,0,1,0,tuple));
    CHECK(tuple.level == 1 && tuple.series == 0);
    CHECK(!PhongThanDecodeQuestItemTuple(1,2,1,1,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(1,3,2,1,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(1,3,1,2,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(1,2,0,0,1,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(1,28,0,1,0,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(0,10,30,1,0,0,tuple));
    CHECK(tuple.particular == 30);
    CHECK(!PhongThanDecodeQuestItemTuple(0,equip_detailnum,0,1,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(0,10,-1,1,0,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(6,1,1355,1,0,0,tuple));
    CHECK(tuple.detail == 1355 && tuple.particular == 0);
    CHECK(PhongThanDecodeQuestItemTuple(3,29,0,0,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(3,29,1,0,0,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(4,26,0,0,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(4,26,1,0,0,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(8,5,7,1,0,0,tuple));
    CHECK(tuple.detail == 5 && tuple.particular == 7);
    CHECK(!PhongThanDecodeQuestItemTuple(2,0,0,0,0,0,tuple));
    CHECK(PhongThanDecodeQuestItemTuple(7,58,62,1,0,0,tuple));
    CHECK(tuple.genre == item_skillbook && tuple.detail == 58 && tuple.particular == 62);
    CHECK(PhongThanDecodeQuestItemTuple(7,1,4,0,0,0,tuple));
    CHECK(!PhongThanDecodeQuestItemTuple(7,58,0,1,0,0,tuple));

    TestItem item = {0, 10, 30, 1, 0};
    CHECK(PhongThanDecodeQuestItemTuple(0,10,30,1,0,0,tuple));
    CHECK(PhongThanQuestItemMatches(item, tuple));
    item.particular = 31;
    CHECK(!PhongThanQuestItemMatches(item, tuple));
    item.particular = 30;
    item.level = 2;
    CHECK(!PhongThanQuestItemMatches(item, tuple));
    CHECK(PhongThanMapQuestItemIdentity(0,10,30,tuple));
    CHECK(PhongThanQuestItemMatches(item, tuple));

    g_pPakList = NULL;
    printf("PASS QUEST_ITEM_TUPLE medicines=%d books=%d aliases=4 particular_preserved=1\n", checked, books);
    return 0;
}
