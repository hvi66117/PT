ItemTableConst = {
    [1] = { name = "Vi Quang Qu¸i Phï (ch­a mµi)", ID = { 3, 374, 0, 0 }, count = 1 },
    [2] = { name = "Di Quang kÝnh", ID = { 8, 509, 2, 0 }, count = 1 },
    [3] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, count = 3 },
}
NeedBageCount = 3
BoxName = "¹´³Â±¦Îï"
boxID = { 6, 1, 1538, 1 }
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

    for i = 1, table.getn(ItemTableConst) do
        for j = 1, ItemTableConst[i].count do
            AddNormalItemPile(ItemTableConst[i].ID[1], ItemTableConst[i].ID[2], ItemTableConst[i].ID[3], ItemTableConst[i].ID[4], 0, 0)
        end
        if (i == table.getn(ItemTableConst)) then
            str = str .. ItemTableConst[i].name .. "*" .. ItemTableConst[i].count .. "."
        else
            str = str .. ItemTableConst[i].name .. "*" .. ItemTableConst[i].count .. ","
        end
    end

    BrocateMessage(temp, str)
    WriteLog("[»÷É±¹´³ÂËÍÕä±¦»î¶¯][´ò¿ª" .. BoxName .. "]")

end
function BrocateMessage(nMessageType, str)
    if (nMessageType >= 1) then
        Msg2Player("Më " .. BoxName .. " nhËn ®­îc " .. str)
    end
    if (nMessageType >= 2) then
        AddGlobalNews("<c=g>" .. GetName() .. "<c> më Ç§ÐÁÍò¿àµÃµ½µÄ" .. BoxName .. " nhËn ®­îc " .. str .. "¹§Ï²!")
    end
    if (nMessageType >= 3) then

    end
end
