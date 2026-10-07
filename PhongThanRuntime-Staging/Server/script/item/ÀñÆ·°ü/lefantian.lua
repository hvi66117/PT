Task_ks_Time = 83
function main()
    CloseDialog()
    DelNormalItem(6, 1, 491, 0)
    local rand_ks = math.random(1, 10000)
    local log_str = ""
    local w, x, y = GetWorldPos()
    if (rand_ks <= 1) then
        local times = GetByte(GetGlobalValue(Task_ks_Time), 2) + 1
        if (w == 20) and (GetLevel() >= 50) and (times <= 1) then
            AddItemPileNum(3, 138, 0, 0, 300)
            SetGlobalValue(Task_ks_Time, SetByte(GetGlobalValue(Task_ks_Time), 2, times))
            TopMessage("B¹n nhËn ®­îc 300 <c=g>ThiÖp Nh­ ý<c>")
            Msg2Player("B¹n nhËn ®­îc 300 ThiÖp Nh­ ý")
            log_str = "L¹c Phiªn Thiªn:ThiÖp Nh­ ý"
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më lÔ bao L¹c Phiªn Thiªn, may m¾n ®­îc <c=g>300 ThiÖp Nh­ ý<c>!", 1)
        else
            AddNormalItem(8, 224, 2, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc 1 <c=g>Tam Th¸i Tö biÕn th©n phï <c>")
            Msg2Player("B¹n nhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
            log_str = "L¹c Phiªn Thiªn:ThiÖp Nh­ ý chuyÓn sang BiÕn th©n phï"
        end
    elseif (rand_ks <= 501) then
        if (GetLevel() >= 30) then
            AddNormalItem(8, 650, 2, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc <c=g>lÔ phôc L¹c Phiªn Thiªn<c>")
            Msg2Player("B¹n nhËn ®­îc lÔ phôc L¹c Phiªn Thiªn.")
            log_str = "L¹c Phiªn Thiªn:LÔ phôc L¹c Phiªn Thiªn"
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më lÔ bao L¹c Phiªn Thiªn, may m¾n nhËn ®­îc cùc phÈm <c=g>lÔ phôc L¹c Phiªn Thiªn<c>!", 1)
        else
            AddNormalItem(8, 225, 2, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc 1 <c=g>Kh­¬ng Tö Nha biÕn th©n phï <c>")
            Msg2Player("B¹n nhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
            log_str = "L¹c Phiªn Thiªn:Th¸i y L¹c Phiªn Thiªn chuyÓn sang BiÕn th©n phï"
        end
    elseif (rand_ks <= 1501) then
        AddNormalItem(8, 225, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Kh­¬ng Tö Nha biÕn th©n phï <c>")
        Msg2Player("B¹n nhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
        log_str = "L¹c Phiªn Thiªn: Kh­¬ng Tö Nha biÕn th©n phï"
    elseif (rand_ks <= 4501) then
        AddNormalItem(8, 224, 2, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Tam Th¸i Tö biÕn th©n phï <c>")
        Msg2Player("B¹n nhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
        log_str = "L¹c Phiªn Thiªn:Tam Th¸i Tö biÕn th©n phï"
    elseif (rand_ks <= 6001) then
        AddNormalItem(8, 52, 2, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Long Nh©n biÕn th©n phï <c>")
        Msg2Player("B¹n nhËn ®­îc 1 Long Nh©n biÕn th©n phï")
        log_str = "L¹c Phiªn Thiªn:Long Nh©n biÕn th©n phï"
    elseif (rand_ks <= 7501) then
        AddNormalItem(6, 0, 345, 1, 0, 1)
        TopMessage("B¹n nhËn ®­îc 1 <c=g>Hoa hång<c>")
        Msg2Player("B¹n nhËn ®­îc 1 Hoa hång.")
        log_str = "L¹c Phiªn Thiªn: Hoa hång"
    elseif (rand_ks <= 8800) then
        RemoveIBBuff(528)
        AddIBBuff(528, 30 * 60)
        TopMessage("B¹n nhËn ®­îc <c=g>hiÖu øng vßng s¸ng T×nh Khiªn<c>")
        Msg2Player("B¹n nhËn ®­îc hiÖu øng vßng s¸ng T×nh Khiªn")
        log_str = "L¹c Phiªn Thiªn: HiÖu øng vßng s¸ng T×nh Khiªn"
    else
        RemoveIBBuff(527)
        AddIBBuff(527, 30 * 60)
        TopMessage("B¹n nhËn ®­îc <c=g>hiÖu øng vßng s¸ng Méng NhiÔu<c>")
        Msg2Player("B¹n nhËn ®­îc hiÖu øng vßng s¸ng Méng NhiÔu")
        log_str = "L¹c Phiªn Thiªn: HiÖu øng vßng s¸ng Méng NhiÔu"
    end
    if (w == 20) then
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> nhÑ nhµng më lÔ bao L¹c Phiªn Thiªn!")
    end
    WriteLog(log_str)
end;

function no()
    CloseDialog()
end
