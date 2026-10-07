Task_Time = 1505
Task_Process = 1506

Task_CoorDinate = 1507
Task_PartnerID = 1508
Task_Distance = 1509

taskInfoIndex = 1090

lightname = {
    [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
    [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
    [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
    [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
}

function isFillQua()
    local today = math.floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(Task_Time)) then
        Talk(1, "no", "<c=g>Tµng b¶o ®å<c> cña b¹n ®· qu¸ h¹n!")
        return 0
    end

    if (GetTaskByte(Task_Process, 1) ~= 1) then
        Talk(1, "no", "§Õn LÔ Quan ë Ngäc H­ Cung b¸o danh lµ cã thÓ tham gia ho¹t ®éng TÇm B¶o! B¹n vÉn ch­a b¸o danh.")
        return 0
    end

    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "Ph¶i cã 2 ng­êi ch¬i, ph©n biÖt cã <c=g>Tµng b¶o ®å (th­îng)<c> vµ <c=g>Tµng b¶o ®å (h¹)<c> tæ ®éi víi nhau míi cã thÓ tham gia t×m B¶o tµng. §éi cña b¹n ch­a phï hîp ®iÒu kiÖn!")
        return 0
    end

    local w1, x1, y1 = GetWorldPos()
    if (w1 ~= 9) then
        Talk(1, "no", "Ph¶i ®Õn T©y C«n L«n míi cã thÓ sö dông <c=g>Tµng b¶o ®å<c>, b¹n hiÖn kh«ng ë T©y C«n L«n.")
        return 0
    end

    local oldPlayer = PlayerIndex
    local partnerID = 0
    local w2, x2, y2 = 0

    if (PlayerIndex == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
        partnerID = GetPlayerID()
        w2, x2, y2 = GetWorldPos()
    else
        PlayerIndex = GetTeamMember(1)
        partnerID = GetPlayerID()
        w2, x2, y2 = GetWorldPos()
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
    local distance = 0
    local light = 1
    if (GetTaskByte(Task_Process, 2) == 1) then
        distance = math.abs((x1 - pX) * (x1 - pX) + (y1 - pY) * (y1 - pY))
        if (distance <= 25) then
            light = 4;
        elseif (distance <= 400) then
            light = 3;
        elseif (distance <= 2500) then
            light = 2;
        end ;
        local msg = "Tµng b¶o ®å ph¸t ra" .. lightname[light]
        local lastdist = GetTask(Task_Distance)

        if (light == 4) and (lastdist >= 0) then
            msg = msg .. ", B¶o tµng h×nh nh­ ®ang ë gÇn ®©y, h·y thö vËn may cña m×nh xem!"
            MsgBox(msg, "freeDragon", "no")
        else
            if (lastdist == -1) then
                msg = msg .. ", B¶o tµng h×nh nh­ ë ngay trong khu vùc nµy!"
            elseif (lastdist < distance) then
                msg = msg .. ", b¹n d­êng nh­ ®· ®i <c=r>c¸ch xa<c> kho b¸u."
            else
                msg = msg .. ", b¹n d­êng nh­ ®· <c=g>tiÕp cËn<c> kho b¸u."
            end ;
            Talk(1, "no", msg)
        end ;
        SetTask(Task_Distance, distance)
    elseif (GetTaskByte(Task_Process, 2) == 2) then
        distance = math.abs((x1 - pX) * (x1 - pX) + (y1 - pY) * (y1 - pY))
        local screen = math.floor(distance / 25)
        local msg = "Tµng b¶o ®å hiÓn thÞ B¶o tµng ®ang ë c¸ch b¹n <color=red>" .. screen .. "<c>"
        local lastdist = GetTask(Task_Distance)
        if (distance < 25) and (lastdist >= 0) then
            msg = msg .. ", B¶o tµng h×nh nh­ ®ang ë gÇn ®©y, b¹n h·y chó ý t×m kü!"
            MsgBox(msg, "freeDragon", "no")
        else
            if (lastdist == -1) then
                msg = msg .. ", B¶o tµng h×nh nh­ ë ngay trong khu vùc nµy!"
            end ;
            Talk(1, "no", msg)
        end ;
        SetTask(Task_Distance, distance)
    else
        Talk(1, "no", "B¹n ch­a ®Õn LÔ Quan ®Ó më ho¹t ®éng nµy!")
        return
    end
end

function freeDragon()
    CloseDialog()

    if (isFillQua() == 0) then
        return
    end

    if (GetTaskByte(Task_Process, 2) == 1) then
        ClearItem(6, 1, 537, 0)
    elseif (GetTaskByte(Task_Process, 2) == 2) then
        ClearItem(6, 1, 538, 0)
    end

    local pX = GetTaskWord(Task_CoorDinate, 1)
    local pY = GetTaskWord(Task_CoorDinate, 2)
    local playerLevel = GetLevel()
    local monstLevel = 80
    local templateID = 1197
    if (playerLevel >= 40) and (playerLevel <= 69) then
        monstLevel = 40
        templateID = 1195
    elseif (playerLevel >= 70) and (playerLevel <= 90) then
        monstLevel = 70
        templateID = 1196
    end

    local npcidx = AddNpc(templateID, monstLevel, SubWorldID2Idx(9), pX * 32, pY * 32)
    SetNpcScript(npcidx, "\\script\\npcdeath\\ÊØ»¤Áú.lua")
    SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
    SetNpcName(npcidx, "Thñ Hé Long (" .. GetName() .. ")")

    SetNpcTask(npcidx, 1, GetPlayerID())
    Msg2Player("XuÊt hiÖn 1 Giao Long, cã thÓ nã biÕt bÝ mËt cña B¶o tµng!")
    TaskNote(taskInfoIndex, 1)

end

function no()
    CloseDialog()
end
