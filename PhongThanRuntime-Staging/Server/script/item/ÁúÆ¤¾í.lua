Task_Time = 1505
Task_Process = 1506

Task_CoorDinate = 1507
Task_PartnerID = 1508
Task_Distance = 1509

taskInfoIndex = 1090

function isFillQua()
    local today = math.floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(Task_Time)) then
        Talk(1, "no", "<c=g>Tµng b¶o ®å<c> cña b¹n ®· qu¸ h¹n!")
        return 0
    end

    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "Ph¶i cã 2 ng­êi ch¬i, ph©n biÖt cã <c=g>Long B× QuyÓn (th­îng)<c> vµ <c=g>Long B× QuyÓn (h¹)<c> tæ ®éi víi nhau míi cã thÓ tham gia t×m B¶o tµng. §éi cña b¹n ch­a phï hîp ®iÒu kiÖn!")
        return 0
    end

    local w1, x1, y1 = GetWorldPos()
    local morphType1 = GetMorphType()
    local process1 = GetTaskByte(Task_Process, 1)
    if (w1 ~= 9) then
        Talk(1, "no", "Ph¶i ®Õn T©y C«n L«n míi cã thÓ sö dông <c=g>Tµng b¶o ®å<c>, b¹n hiÖn kh«ng ë T©y C«n L«n.")
        return 0
    end

    if (HaveIBBuff(752) <= 0) then
        Talk(1, "no", "B¹n kh«ng trong tr¹ng th¸i C¸t T­êng, kh«ng thÓ ®µo b¶o.")
        return 0
    end

    local oldPlayer = PlayerIndex
    local partnerID = 0
    local w2, x2, y2 = 0
    local morphType2 = 0
    local process2 = 0
    local isHaveBuff = 0

    if (PlayerIndex == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
        partnerID = GetPlayerID()
        w2, x2, y2 = GetWorldPos()
        morphType2 = GetMorphType()
        process2 = GetTaskByte(Task_Process, 1)
        isHaveBuff = HaveIBBuff(752)

    else
        PlayerIndex = GetTeamMember(1)
        partnerID = GetPlayerID()
        w2, x2, y2 = GetWorldPos()
        morphType2 = GetMorphType()
        process2 = GetTaskByte(Task_Process, 1)
        isHaveBuff = HaveIBBuff(752)
    end

    PlayerIndex = oldPlayer
    if (partnerID ~= GetTask(Task_PartnerID)) then
        Talk(1, "no", "Ng­êi trong ®éi cña b¹n kh«ng ph¶i lµ b»ng h÷u lóc nhËn nhiÖm vô, nªn b¹n kh«ng thÓ tiÕn hµnh tÇm b¶o.")
        return 0
    end

    if (w2 ~= 9) then
        Talk(1, "no", "Thµnh viªn trong ®éi kh«ng ë T©y C«n L«n, kh«ng thÓ t×m B¶o tµng.")
        return 0
    end


end

function main()
    local w1, x1, y1 = GetWorldPos()

    if (isFillQua() == 0) then
        return
    end

    local pX = GetTaskWord(Task_CoorDinate, 1)
    local pY = GetTaskWord(Task_CoorDinate, 2)
    local playerX = math.floor(x1 / 8)
    local playerY = math.floor(y1 / 16)
    local mapType = GetTaskByte(Task_Process, 2)

    if (math.floor(pX / 8) ~= playerX) or (math.floor(pY / 16) ~= playerY) or (GetTaskByte(Task_Process, 1) ~= 3) then
        if (mapType == 1) then
            Talk(1, "no", "Hoµnh ®é Tµng b¶o r­¬ng lµ " .. math.floor(pX / 8))
        elseif (mapType == 2) then
            Talk(1, "no", "Tung ®é Tµng b¶o r­¬ng lµ " .. math.floor(pY / 16))
        end
        return
    end

    local oldPlayer = PlayerIndex
    if (GetTeamMember(1) == oldPlayer) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end

    local w2, x2, y2 = GetWorldPos()
    distance = math.abs((x2 - pX) * (x2 - pX) + (y2 - pY) * (y2 - pY))
    local morphType = GetMorphType()
    local isHaveBuff = HaveIBBuff(752)

    PlayerIndex = oldPlayer

    if (isHaveBuff <= 0) then
        Talk(1, "no", "§ång ®éi cña b¹n kh«ng trong tr¹ng th¸i C¸t T­êng, kh«ng thÓ ®µo b¶o.")
        return
    end

    if (distance > 400) then
        Talk(1, "no", "§ång ®éi cña b¹n c¸ch B¶o tµng qu¸ xa.")
    else
        MsgBox("H×nh nh­ b¹n ®· ®Õn täa ®é cña Tµng b¶o ®å. B©y giê b¾t ®Çu ®µo t×m B¶o tµng chø?", "digBox", "no")
    end
end

function digBox()
    CloseDialog()
    local w1, x1, y1 = GetWorldPos()

    if (isFillQua() == 0) then
        return
    end

    local pX = GetTaskWord(Task_CoorDinate, 1)
    local pY = GetTaskWord(Task_CoorDinate, 2)
    local playerX = math.floor(x1 / 8)
    local playerY = math.floor(y1 / 16)

    local mapType = GetTaskByte(Task_Process, 2)

    if (math.floor(pX / 8) ~= playerX) or (math.floor(pY / 16) ~= playerY) or (GetTaskByte(Task_Process, 1) ~= 3) then
        if (mapType == 1) then
            Talk(1, "no", "Hoµnh ®é Tµng b¶o r­¬ng lµ " .. math.floor(pX / 8))
        elseif (mapType == 2) then
            Talk(1, "no", "Tung ®é Tµng b¶o r­¬ng lµ " .. math.floor(pY / 16))
        end
        return
    end

    local oldPlayer = PlayerIndex
    if (GetTeamMember(1) == oldPlayer) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end

    local w2, x2, y2 = GetWorldPos()
    distance = math.abs((x2 - pX) * (x2 - pX) + (y2 - pY) * (y2 - pY))
    local morphType = GetMorphType()
    local isHaveBuff = HaveIBBuff(752)

    PlayerIndex = oldPlayer

    if (isHaveBuff <= 0) then
        Talk(1, "no", "§ång ®éi cña b¹n kh«ng trong tr¹ng th¸i biÕn th©n C¸t T­êng, kh«ng thÓ ®µo b¶o.")
        return
    end

    if (distance > 400) then
        Talk(1, "no", "§ång ®éi cña b¹n c¸ch B¶o tµng qu¸ xa!")
        return
    end

    SetTaskByte(Task_Process, 1, 4)
    if (GetTaskByte(Task_Process, 2) == 1) then
        ClearItem(6, 1, 539, 0)
    elseif (GetTaskByte(Task_Process, 2) == 2) then
        ClearItem(6, 1, 540, 0)
    end
    AddNormalItem(6, 1, 541, 0, 0, 0)
    Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc Cµn Kh«n B¶o R­¬ng.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc Cµn Kh«n B¶o R­¬ng.")
    TaskNote(taskInfoIndex, 3)
end

function no()
    CloseDialog()
end
