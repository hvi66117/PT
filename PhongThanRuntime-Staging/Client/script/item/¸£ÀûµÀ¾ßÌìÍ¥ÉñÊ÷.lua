g_ItemId = { 6, 1, 1404, 1 }
g_ItemName = "¸£Àû»î¶¯µÀ¾ßThiªn §×nh ThÇn Thô"
g_BuffID = 1747

function main(nLevel, t, nNpcIdx, nItemId)
    g_ItemName = GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4])
    if (HaveNormalItem(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) > 0) then
        DelNormalItem(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4])
        WriteLog("Trõ" .. g_ItemName .. " thµnh c«ng")
        AddNormalItemBind(3, 1625, 0, 0, 0, 0, 1)
        AddIBBuff(g_BuffID, 1800)
    end

end;
