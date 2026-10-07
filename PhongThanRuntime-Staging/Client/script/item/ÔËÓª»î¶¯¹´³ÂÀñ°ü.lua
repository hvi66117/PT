ItemTableConst = {
    [1] = { name = "Tói L­¬ng Ngäc", ID = { 8, 1668, 2, 0 }, count = 1, pro = 1 },
    [2] = { name = "La H¸n hiÖu gi¸c", ID = { 8, 233, 0, 0 }, count = 1, pro = 8 },
    [3] = { name = "M¶nh Phï Th¹ch", ID = { 6, 1, 1276, 0 }, count = 1, pro = 4 },
    [4] = { name = "ThÇn CÈu phï", ID = { 8, 133, 0, 0 }, count = 1, pro = 10 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, count = 1, pro = 2 },
    [6] = { name = "M¶nh Hoµng thñy tinh", ID = { 3, 88, 0, 0 }, count = 1, pro = 15 },
    [7] = { name = "Håi thµnh phï (Siªu cÊp)", ID = { 8, 291, 2, 0 }, count = 1, pro = 10 },
    [8] = { name = "M¶nh Lôc Thñy tinh", ID = { 3, 248, 0, 0 }, count = 1, pro = 10 },
    [9] = { name = "ChØ nh©n", ID = { 8, 135, 2, 0 }, count = 1, pro = 20 },
    [10] = { name = "B¶o T¸ Thanh lé", ID = { 8, 198, 3, 0 }, count = 1, pro = 20 },
}

NeedBageCount = 3
BoxName = "¹´³ÂÀñ°ü"
boxID = { 6, 1, 1539, 1 }
function no()
    CloseDialog()
end

function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBageCount + 1) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng" .. NeedBageCount .. "h·y s¾p xÕp l¹i tói.")
        return
    end

    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local str = ""
    local temp = 1

    local rand = 0
    local rannum = math.random(100)
    for i = 1, table.getn(ItemTableConst) do
        rand = rand + ItemTableConst[i].pro
        if (rannum <= rand) then
            for j = 1, ItemTableConst[i].count do
                AddNormalItemBind(ItemTableConst[i].ID[1], ItemTableConst[i].ID[2], ItemTableConst[i].ID[3], ItemTableConst[i].ID[4], 0, 0, 1)
            end
            str = str .. ItemTableConst[i].name .. "*" .. ItemTableConst[i].count .. ","
            break
        end
    end

    AddNormalItemBind(8, 1523, 0, 0, 0, 0, 1)
    for itemnum = 1, 2 do
        AddNormalItemBind(6, 1, 1062, 1, 0, 0, 1)
    end
    str = str .. "Phï nhiÖm vô Chñ ®Ò ngµy vµ Kinh NghiÖm §¬n*2."

    BrocateMessage(temp, str)
    WriteLog("[»÷É±¹´³ÂËÍÕä±¦»î¶¯][Më][" .. BoxName .. "]")

end
function BrocateMessage(nMessageType, str)
    if (nMessageType >= 1) then
        Msg2Player("Më " .. BoxName .. " nhËn ®­îc " .. str)
    end
    if (nMessageType >= 2) then
        AddGlobalNews("<c=g>" .. GetName() .. "<c> më Ç§ÐÁÍò¿àµÃµ½µÄ" .. BoxName .. " nhËn ®­îc " .. str .. "¹§Ï²!")
    end
end
