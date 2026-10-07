GlobalSummer = 251

function main()
    DelNormalItem(6, 1, 570, 0)
    local r = math.random(1, 100)
    if (r >= 1) and (r <= 15) then
        AddNormalItem(8, 225, 2, 0, 0, 0)
        AddNormalItem(8, 225, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Kh­¬ng Tö Nha biÕn th©n phï<c>")
        Msg2Player("B¹n nhËn ®­îc 2 Kh­¬ng Tö Nha biÕn th©n phï.")
        log_str = "Kh­¬ng Tö Nha biÕn th©n phï"
    elseif (r >= 16) and (r <= 45) then
        AddNormalItem(8, 224, 2, 0, 0, 0)
        AddNormalItem(8, 224, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Tam Th¸i Tö biÕn th©n phï<c>")
        Msg2Player("B¹n nhËn ®­îc 2 Tam Th¸i Tö biÕn th©n phï.")
        log_str = "Tam Th¸i Tö biÕn th©n phï"
    elseif (r >= 46) and (r <= 60) then
        AddNormalItem(8, 52, 2, 1, 0, 0)
        AddNormalItem(8, 52, 2, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Long Nh©n biÕn th©n phï<c>")
        Msg2Player("B¹n nhËn ®­îc 2 Long Nh©n biÕn th©n phï.")
        log_str = "Long Nh©n biÕn th©n phï"
    elseif (r >= 61) and (r <= 70) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        AddNormalItem(6, 0, 20, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Ph¸o hoa<c>")
        Msg2Player("B¹n nhËn ®­îc 2 Ph¸o hoa.")
        log_str = "Ph¸o hoa"
    elseif (r >= 71) and (r <= 83) then
        AddNormalItem(6, 0, 345, 1, 0, 1)
        AddNormalItem(6, 0, 345, 1, 0, 1)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Hoa Hång<c>")
        Msg2Player("B¹n nhËn ®­îc 2 Hoa Hång.")
        log_str = "Hoa Hång"
    elseif (r >= 84) and (r <= 88) and (GetByte(GetGlobalValue(GlobalSummer), 3) < 50) then
        AddNormalItem(1, 6, 0, 0, 0, 0)

        local nNum = GetByte(GetGlobalValue(GlobalSummer), 3)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 3, nNum))

        TopMessage("B¹n nhËn ®­îc 1 <c=g>S« c« la<c>")
        Msg2Player("B¹n nhËn ®­îc S« c« la.")
        log_str = "S« c« la"
    elseif (r >= 89) and (r <= 90) and (GetByte(GetGlobalValue(GlobalSummer), 2) < 6) then
        AddNormalItem(0, 4, 37, 0, 0, 0)
        local nNum = GetByte(GetGlobalValue(GlobalSummer), 2)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 2, nNum))
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Tam Sinh Th¹ch<c>")
        Msg2Player("B¹n nhËn ®­îc 1 Tam Sinh Th¹ch.")
        log_str = "Tam Sinh Th¹ch"
    elseif (r >= 91) and (r <= 100) and (GetByte(GetGlobalValue(GlobalSummer), 3) < 50) then
        AddNormalItem(1, 6, 0, 0, 0, 0)

        local nNum = GetByte(GetGlobalValue(GlobalSummer), 3)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 3, nNum))

        TopMessage("B¹n nhËn ®­îc 1 <c=g>S« c« la<c>")
        Msg2Player("B¹n nhËn ®­îc S« c« la.")
        log_str = "S« c« la"
    elseif (GetByte(GetGlobalValue(GlobalSummer), 3) >= 50) or (GetByte(GetGlobalValue(GlobalSummer), 2) >= 6) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        TopMessage("Anh hïng nhËn <c=g>LÔ Hoa<c> x1")
        Msg2Player("Anh hïng nhËn 1 LÔ Hoa. ")
        log_str = "Ph¸o hoa"
    end

    WriteLog(log_str)
end

function no()
    CloseDialog()
end
