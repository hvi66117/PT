#ifndef PHONGTHAN_QUEST_ITEM_TUPLE_H
#define PHONGTHAN_QUEST_ITEM_TUPLE_H

// Lua item tuples are identities, not row numbers. Keep ParticularType for
// equipment and IBItem: dropping it grants or removes a different item.
struct PhongThanQuestItemTuple
{
    int genre, detail, particular, level, series, luck;
};

inline bool PhongThanMapQuestItemIdentity(int genre, int detail, int particular,
    PhongThanQuestItemTuple& result)
{
    result.genre = genre;
    result.detail = detail;
    result.particular = particular;
    result.level = -1;
    result.series = -1;
    result.luck = 0;
    if (detail < 0 || particular < 0)
        return false;
    switch (genre)
    {
    case item_equip:
        return detail < equip_detailnum;
    case item_medicine:
        if (particular == 0)
            return true;
        // Original active VNG Su Hu.lua explicitly awards small red/blue
        // potions with (1,0,1,1,0,0)/(1,3,1,1,0,0). potion.txt stores those
        // two identities with ParticularType=0. This is a bounded legacy
        // alias, not permission to discard any medicine ParticularType.
        if (particular == 1 && (detail == 0 || detail == 3))
        {
            result.particular = 0;
            return true;
        }
        return false;
    case item_materials:
    case item_task:
        return particular == 0;
    case item_magicscript:
        if (detail != 1 || particular <= 0)
            return false;
        result.detail = particular;
        result.particular = 0;
        return true;
    case item_skillbook:
        return particular > 0;
    case item_ibitem:
        return true;
    default:
        return false;
    }
}

inline bool PhongThanDecodeQuestItemTuple(int genre, int detail, int particular,
    int level, int series, int luck, PhongThanQuestItemTuple& result)
{
    if (!PhongThanMapQuestItemIdentity(genre, detail, particular, result) ||
        level < 0 || series < 0)
        return false;
    result.level = level;
    result.series = series;
    result.luck = luck;
    if (genre == item_medicine)
    {
        if (particular == 1 && (level != 1 || series != 0 || luck != 0))
            return false;
        // The active VNG Chao Lei / Ju Liu Sun registration rewards use the
        // older (1,0|3,0,0,1,0) spelling for the same small potions. Do not
        // reinterpret level/series for any other item or any other tuple.
        if (particular == 0 && (detail == 0 || detail == 3) &&
            level == 0 && series == 1 && luck == 0)
        {
            result.level = 1;
            result.series = 0;
        }
        return result.level > 0;
    }
    return genre != item_equip || level > 0;
}

template<class TItem>
inline bool PhongThanQuestItemMatches(TItem& item,
    const PhongThanQuestItemTuple& tuple)
{
    if (item.GetGenre() != tuple.genre || item.GetDetailType() != tuple.detail ||
        item.GetParticular() != tuple.particular)
        return false;
    if (tuple.level >= 0 && item.GetLevel() != tuple.level)
        return false;
    // Zero in the original query APIs means unrestricted profession/series.
    return tuple.series <= 0 || item.GetSeries() == tuple.series;
}

#endif
