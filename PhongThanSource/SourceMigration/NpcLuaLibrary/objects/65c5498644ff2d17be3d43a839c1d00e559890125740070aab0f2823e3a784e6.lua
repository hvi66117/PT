--description: °×½ðVIPÀñºÐ
--author: liujifang
--date: 2013-03-15

function main()
    if (HaveNormalItem(6, 1, 944, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói ph¶i cã tèi thiÓu 3 «.")
        return
    end

    DelNormalItem(6, 1, 944, 1)

    for i = 1, 2 do
        AddNormalItemBind(8, 1346, 2, 0, 0, 0, 1)
    end
    AddNormalItemBind(8, 508, 2, 0, 0, 0, 1)

    WriteLog("LÔ Bao VIP B¹ch Kim cho vip quay vÒ:HuyÒn S¾c Thñy Ng©n (tinh x¶o)*2, Tinh Th¹ch cao cÊp")
    Msg2Player("B¹n ®· sö dông VIP B¹ch Kim, nhËn ®­îc HuyÒn S¾c Thñy Ng©n (tinh x¶o) *2, Tinh Th¹ch cao cÊp!")
end

function no()
    CloseDialog()
end