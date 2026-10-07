--description: ÖÁ×ðVIPÀñºÐ
--author: liujifang
--date: 2013-03-15

function main()
    if (HaveNormalItem(6, 1, 946, 1) <= 0) then
        return
    end

    local nList = {
        "XÝch Viªm Ngäc T©m (Ch­a mµi)/item_1_1",
        "Thanh Minh Ngäc T©m (Ch­a mµi)/item_1_1",
        "Tö Hµ Ngäc T©m (Ch­a mµi)/item_1_1",
    }
    Say("H·y chän mµu s¾c Ngäc T©m:", getn(nList), nList)
end

function item_1_1(nIndex)
    CloseDialog()

    local nList = {
        "KhÝ Tinh cao cÊp/item_1_2",
        "Tinh KhÝ trang bÞ cao cÊp/item_1_2",
    }
    SetTask(140, nIndex)
    Say("H·y chän vËt phÈm lo¹i tinh khÝ cÇn dïng:", getn(nList), nList)
end

function item_1_2(nIndex2)
    CloseDialog()
    local nIndex = GetTask(140)
    if (HaveNormalItem(6, 1, 946, 1) <= 0 or nIndex < 0 or nIndex >= 3 or nIndex2 < 0 or nIndex2 > 2) then
        return
    end

    if (IsHaveSpaceForTreasure(9) == 0) then
        Talk(1, "no", "Ph¶i cã tèi thiÓu 8 «.")
        return
    end

    DelNormalItem(6, 1, 946, 1)
    local str = ""
    if (nIndex == 0) then
        AddNormalItemBind(3, 258, 0, 0, 0, 0, 1)
        str = "XÝch Viªm Ngäc T©m (Ch­a mµi)"
    elseif (nIndex == 1) then
        AddNormalItemBind(3, 265, 0, 0, 0, 0, 1)
        str = "Thanh Minh Ngäc T©m (Ch­a mµi)"
    elseif (nIndex == 2) then
        AddNormalItemBind(3, 272, 0, 0, 0, 0, 1)
        str = "Tö Hµ Ngäc T©m (Ch­a mµi)"
    end

    if (nIndex2 == 0) then
        AddNormalItemBind(8, 372, 2, 0, 0, 0, 1)
        str = str .. ", tinh khÝ cao cÊp"
    elseif (nIndex2 == 1) then
        AddNormalItemBind(8, 373, 2, 0, 0, 0, 1)
        str = str .. ", TÝnh khÝ trang bÞ cao cÊp"
    end

    for i = 1, 4 do
        AddNormalItemBind(8, 1346, 2, 0, 0, 0, 1)
    end
    str = str .. ", HuyÒn S¾c Thñy Ng©n (tinh x¶o)*4"

    for i = 1, 2 do
        AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)
    end
    str = str .. ", Tinh Th¹ch cao cÊp*2"

    WriteLog("LÔ Bao VIP ChÝ T«n vip quay vÒ:" .. str)
    Msg2Player("Sö dông LÔ Bao VIP ChÝ T«n, nh©n ®­îc" .. str .. ", h·y nhËn lÊy!")
end

function no()
    CloseDialog()
end