--description: °×½ðVIPÀñºÐ
--author: liujifang
--date: 2013-03-15

function main()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    local nTask = {
        "HuyÒn S¾c Thñy Ng©n (tinh x¶o)/item_1",
        "Tinh Th¹ch cao cÊp*2/item_2",
    }

    Say("H·y chän vËt phÈm nhËn:", getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    DelNormalItem(6, 1, 943, 1)

    AddNormalItemBind(8, 1346, 2, 0, 0, 0, 1)

    WriteLog("LÔ bao VIP Hoµng Kim vip quay vÒ:HuyÒn S¾c Thñy Ng©n (tinh x¶o)")
    Msg2Player("B¹n ®· sö dông lÔ bao Hoµng Kim VIP, nhËn ®­îc HuyÒn S¾c Thñy Ng©n (tinh x¶o)!")
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu ph¶i ®ñ 2 «.")
        return
    end

    DelNormalItem(6, 1, 943, 1)
    AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)
    AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)

    WriteLog("LÔ bao VIP Hoµng Kim vip quay vÒ: Tinh Th¹ch cao cÊp*2")
    Msg2Player("B¹n ®· sö dông lÔ bao VIP Hoµng Kim, nhËn ®­îc 2#Tinh Th¹ch cao cÊp!")
end

function no()
    CloseDialog()
end