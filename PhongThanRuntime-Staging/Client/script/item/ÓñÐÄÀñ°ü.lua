function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end

    local task = {
        "XÝch Viªm Ngäc T©m/coinReward2_Sure",
        "Thanh Minh Ngäc T©m/coinReward2_Sure",
        "Tö Hµ Ngäc T©m/coinReward2_Sure",
    }
    SetTask(140, itemID)
    Say("ÇëÑ¡ÔñÄãÏëÒªµÄÓñÐÄÀàÐÍ: ", table.getn(task), task)
end

function coinReward2_Sure(nIndex)
    CloseDialog()
    local task = {
        { "XÝch Viªm Ngäc T©m (ch­a mµi)"; ID = { 3, 258, 0, 0 } },
        { "Thanh Minh Ngäc T©m (ch­a mµi)"; ID = { 3, 265, 0, 0 } },
        { "Tö Hµ Ngäc T©m (ch­a mµi)"; ID = { 3, 272, 0, 0 } },
    }

    if (nIndex < 0 or nIndex >= table.getn(task)) then
        return
    end

    local nItem = GetTask(140)
    local nBind = IsItemBind(nItem)
    local itemID = task[nIndex + 1].ID
    DelItemByID(nItem)
    AddNormalItemBind(itemID[1], itemID[2], itemID[3], itemID[4], 0, 0, nBind)
    Msg2Player("Ngµi më lÔ bao nhËn ®­îc 1 c¸i " .. task[nIndex + 1][1] .. ".")
end

function no()
    CloseDialog()
end
