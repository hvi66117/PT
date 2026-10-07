--description: ×êÊ¯VIPÀñºÐ
--author: liujifang
--date: 2013-03-15

function main()
    if (HaveNormalItem(6, 1, 945, 1) <= 0) then
        return
    end

    local nTask = {
        "KhÝ Nguyªn (cao cÊp)+HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2+Tinh Th¹ch cao cÊp/item_1",
        "Trang Nguyªn (cao cÊp)+HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2+Tinh Th¹ch cao cÊp/item_2",
    }

    Say("H·y chän vËt phÈm nhËn:", getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 945, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(5) == 0) then
        Talk(1, "no", "Tói tèi thiÓu cßn 4 «.")
        return
    end

    DelNormalItem(6, 1, 945, 1)

    AddNormalItemBind(8, 283, 2, 0, 0, 0, 1)
    for i = 1, 2 do
        AddNormalItemBind(8, 1346, 2, 0, 0, 0, 1)
    end
    AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)

    WriteLog(" LÔ b¶o VIP Kim C­¬ng Vip quay vÒ:KhÝ Nguyªn (cao cÊp), HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2, Tinh Th¹ch cao cÊp")
    Msg2Player("B¹n ®· sö dông lÔ b¶o VIP Kim C­¬ng, nhËn ®­îc KhÝ Nguyªn (cao cÊp), HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2, Tinh Th¹ch cao cÊp!")
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 945, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(5) == 0) then
        Talk(1, "no", "Tói tèi thiÓu cßn 4 «.")
        return
    end

    DelNormalItem(6, 1, 945, 1)

    AddNormalItemBind(8, 284, 2, 0, 0, 0, 1)
    for i = 1, 2 do
        AddNormalItemBind(8, 1346, 2, 0, 0, 0, 1)
    end
    AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)

    WriteLog("LÔ b¶o VIP Kim C­¬ng vip quay vÒ: Trang Nguyªn (cao cÊp), HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2, Tinh Th¹ch cao cÊp")
    Msg2Player("B¹n ®· sö dông lÔ b¶o VIP Kim C­¬ng, nhËn ®­îc Trang Nguyªn (cao cÊp), HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2, Tinh Th¹ch cao cÊp!")
end

function no()
    CloseDialog()
end