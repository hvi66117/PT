G_Task = {
    { Name = "Ho¶ Vò 10 c¸i", ID = 8, count = 10, },
    { Name = "Ngäc Cèt 10 c¸i", ID = 9, count = 10, },
    { Name = "§o¹n KiÕm 10 c¸i", ID = 10, count = 10, },
    { Name = "To¸i Gi¸p 10 c¸i", ID = 11, count = 10, },
    { Name = "Quû DiÖn 10 c¸i", ID = 12, count = 10, },
    { Name = "B¨ng C¬ 10 c¸i", ID = 13, count = 10, },
    { Name = "§Þa T©m 10 c¸i", ID = 22, count = 10, },
    { Name = "Phong LÖ 10 c¸i", ID = 23, count = 10, },
    { Name = "Thuû Hån 10 c¸i", ID = 24, count = 10, },
    { Name = "Ho¶ Linh 10 c¸i", ID = 25, count = 10, },
    { Name = "Lôc §¹o Tinh Hoa 1 c¸i", ID = 114, count = 1, },
    { Name = "Tø T­îng Tinh Hoa 1 c¸i", ID = 115, count = 1, },
}

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end
    local list = {}
    for i = 1, getn(G_Task) do
        list[i] = G_Task[i].Name .. "/item_sel"
    end

    SetTask(140, itemID)
    Say("ÇëÑ¡ÔñÏëÒª»ñµÃµÄ²ÄÁÏ: ", table.getn(list), list)
end

function item_sel(index)
    CloseDialog()
    index = index + 1
    if (index <= 0 or index > table.getn(G_Task)) then
        Talk(1, "main", "Chän sai, h·y chän l¹i.")
        return
    end

    local itemID = GetTask(140)
    local nItemBind = IsItemBind(itemID)
    if (DelItemByID(itemID) <= 0) then
        Talk(1, "no", "H·y ®Æt lÔ bao trong hµnh trang.")
        return
    end

    for i = 1, G_Task[index].count do
        AddNormalItemBind(3, G_Task[index].ID, 0, 0, 0, 0, nItemBind)
    end
    local name = G_Task[index].Name
    ScrollMessage("NhËn ®­îc <c=y>" .. name .. "<c>")
    Msg2Player("Ngµi sö dông ÁùµÀTói Tø T­îng-Nhá, nhËn ®­îc " .. name .. ", xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2020) and (m <= 9) then
        WriteLog("[ÁùµÀTói Tø T­îng-Nhá][" .. name .. "]")
    end
end

function no()
    CloseDialog()
end
