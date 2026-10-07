G_Task = {
    { Name = "Ho¶ Vò 10 c¸i", ID = 8, },
    { Name = "Ngäc Cèt 10 c¸i", ID = 9, },
    { Name = "§o¹n KiÕm 10 c¸i", ID = 10, },
    { Name = "To¸i Gi¸p 10 c¸i", ID = 11, },
    { Name = "Quû DiÖn 10 c¸i", ID = 12, },
    { Name = "B¨ng C¬ 10 c¸i", ID = 13, },
}

function main()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end
    local list = {}
    for i = 1, getn(G_Task) do
        list[i] = G_Task[i].Name .. "/item_sel"
    end
    Say("Chän lo¹i nguyªn liÖu Lôc §¹o muèn nhËn: ", table.getn(list), list)
end

function item_sel(index)
    CloseDialog()
    index = index + 1
    if (index <= 0 or index > 6) then
        Talk(1, "main", "Chän sai, h·y chän l¹i.")
        return
    end

    if (DelNormalItem(6, 1, 1653, 1) <= 0) then
        Talk(1, "no", "H·y ®Æt lÔ bao trong hµnh trang.")
        return
    end

    for i = 1, 10 do
        AddNormalItemBind(3, G_Task[index].ID, 0, 0, 0, 0, 1)
    end
    local name = G_Task[index].Name
    ScrollMessage("NhËn ®­îc <c=y>" .. name .. "<c>")
    Msg2Player("Ngµi sö dông Tói Lôc §¹o-Nhá , nhËn ®­îc " .. name .. ", xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2017) and (m == 10) then
        WriteLog("[Tói Lôc §¹o-Nhá][" .. name .. "]")
    end
end

function no()
    CloseDialog()
end
