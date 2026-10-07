GlobalSummer = 251

function main()
    local r = math.random(1, 100)
    DelNormalItem(6, 1, 571, 0)

    local cloth = ""
    if (GetSex() == 0) then
        AddNormalItem(8, 517, 2, 0, 0, 0)
        cloth = "<c=g>Méng NhiÔu Trang<c>"
        WriteLog("Träng H¹ Chi LuyÕn:Méng NhiÔu Trang")
    else
        AddNormalItem(8, 518, 2, 0, 0, 0)
        cloth = "<c=g>T×nh Khiªn Trang<c>"
        WriteLog("Träng H¹ Chi LuyÕn: T×nh Khiªn Trang")
    end

    if (r >= 1) and (r <= 15) then
        AddNormalItem(8, 225, 2, 0, 0, 0)
        AddNormalItem(8, 225, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=g>Kh­¬ng Tö Nha biÕn th©n phï<c> vµ" .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 2 Kh­¬ng Tö Nha biÕn th©n phï vµ " .. cloth .. " .")
        log_str = "Kh­¬ng Tö Nha biÕn th©n phï"
    elseif (r >= 16) and (r <= 35) then
        AddNormalItem(8, 224, 2, 0, 0, 0)
        AddNormalItem(8, 224, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Tam Th¸i Tö biÕn th©n phï<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc Tam Th¸i Tö biÕn th©n phï vµ " .. cloth .. " .")
        log_str = "Tam Th¸i Tö biÕn th©n phï"
    elseif (r >= 36) and (r <= 50) then
        AddNormalItem(8, 52, 2, 1, 0, 0)
        AddNormalItem(8, 52, 2, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=g>Long Nh©n biÕn th©n phï<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 2 Long Nh©n biÕn th©n phï vµ " .. cloth .. " .")
        log_str = "Long Nh©n biÕn th©n phï"
    elseif (r >= 51) and (r <= 65) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        AddNormalItem(6, 0, 20, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Ph¸o hoa<c> vµ" .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 2 Ph¸o hoa vµ " .. cloth .. " .")
        log_str = "Ph¸o hoa"
    elseif (r >= 66) and (r <= 77) then
        AddNormalItem(6, 0, 345, 1, 0, 1)
        AddNormalItem(6, 0, 345, 1, 0, 1)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>Hoa Hång<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 2 Hoa Hång vµ " .. cloth .. " .")
        log_str = "Hoa Hång"
    elseif (GetByte(GetGlobalValue(GlobalSummer), 3) < 50) and (r >= 78) and (r <= 87) then
        AddNormalItem(1, 6, 0, 0, 0, 0)

        local nNum = GetByte(GetGlobalValue(GlobalSummer), 3)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 3, nNum))

        TopMessage("B¹n nhËn ®­îc 1 <c=g>S« c« la<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 1 S« c« la vµ " .. cloth .. " .")
        log_str = "S« c« la"
    elseif (r >= 88) and (r <= 90) and (GetByte(GetGlobalValue(GlobalSummer), 2) < 6) then
        AddNormalItem(0, 4, 37, 0, 0, 0)
        local nNum = GetByte(GetGlobalValue(GlobalSummer), 2)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 2, nNum))
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Tam Sinh Th¹ch<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 1 Tam Sinh Th¹ch vµ " .. cloth .. " .")
        log_str = "Tam Sinh Th¹ch"
    elseif (r >= 91) and (r <= 100) and (GetByte(GetGlobalValue(GlobalSummer), 3) < 50) then
        AddNormalItem(1, 6, 0, 0, 0, 0)

        local nNum = GetByte(GetGlobalValue(GlobalSummer), 3)
        nNum = nNum + 1
        SetGlobalValue(GlobalSummer, SetByte(GetGlobalValue(GlobalSummer), 3, nNum))

        TopMessage("B¹n nhËn ®­îc 1 <c=g>S« c« la<c> vµ " .. cloth .. ".")
        Msg2Player("B¹n nhËn ®­îc 1 S« c« la vµ " .. cloth .. " .")
        log_str = "S« c« la"
    elseif (GetByte(GetGlobalValue(GlobalSummer), 2) >= 6) or (GetByte(GetGlobalValue(GlobalSummer), 3) >= 50) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        TopMessage("Anh hïng nhËn <c=g>LÔ Hoa<c> x1 vµ" .. cloth .. ".")
        Msg2Player("Anh hïng nhËn LÔ Hoa x1 vµ" .. cloth .. " .")
        log_str = "Ph¸o hoa"
    end

    WriteLog(log_str)
end

function no()
    CloseDialog()
end
