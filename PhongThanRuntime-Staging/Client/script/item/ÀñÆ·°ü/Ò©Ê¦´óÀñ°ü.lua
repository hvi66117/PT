function main()

    local r = math.random(1, 100)
    if (r <= 80) then
        EarnBind(100000)
        Msg2Player("B¹n nhËn ®­îc 10 v¹n b¹c khãa")
        WriteLog("Tói quµ D­îc S­ 10 v¹n b¹c khãa")
    elseif (GetLevel() >= 60) and (r <= 82) then
        AddNormalItem(8, 1134, 2, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc TiÓu Ho¹t ThÓ §¬n")
        WriteLog("Tói quµ D­îc S­ TiÓu Ho¹t ThÓ §¬n")
    else
        EarnBind(200000)
        Msg2Player("B¹n nhËn ®­îc 20 v¹n b¹c khãa")
        WriteLog("Tói quµ D­îc S­ 20 v¹n b¹c khãa")
    end

    Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> håi hép më Tói quµ D­îc S­.")
end;

function no()
    CloseDialog()
end;
