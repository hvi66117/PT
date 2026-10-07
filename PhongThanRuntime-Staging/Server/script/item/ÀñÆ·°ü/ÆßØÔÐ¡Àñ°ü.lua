G_Task = {
    { Name = "§Þa Qu¸i 1 c¸i", ID = 15, },
    { Name = "Thuû Qu¸i 1 c¸i", ID = 16, },
    { Name = "Ho¶ Qu¸i 1 c¸i", ID = 17, },
    { Name = "S¬n Qu¸i 1 c¸i", ID = 18, },
    { Name = "Tr¹ch Qu¸i 1 c¸i", ID = 19, },
    { Name = "Phong Qu¸i 1 c¸i", ID = 20, },
    { Name = "L«i Qu¸i 1 c¸i", ID = 21, },
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
    Say("Xin lùa chän nguyªn liÖu ThÊt Qu¸i muèn nhËn: ", table.getn(list), list)
end

function item_sel(index)
    CloseDialog()
    index = index + 1
    if (index <= 0 or index > 7) then
        Talk(1, "main", "Chän sai, h·y chän l¹i.")
        return
    end

    if (DelNormalItem(6, 1, 1654, 1) <= 0) then
        Talk(1, "no", "H·y ®Æt lÔ bao trong hµnh trang.")
        return
    end

    AddNormalItemBind(3, G_Task[index].ID, 0, 0, 0, 0, 1)

    local name = G_Task[index].Name
    ScrollMessage("NhËn ®­îc <c=y>" .. name .. "<c>")
    Msg2Player("Ngµi sö dông Tói ThÊt Qu¶i-Nhá , nhËn ®­îc " .. name .. ", xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2017) and (m == 10) then
        WriteLog("[Tói ThÊt Qu¶i-Nhá][" .. name .. "]")
    end
end

function no()
    CloseDialog()
end
