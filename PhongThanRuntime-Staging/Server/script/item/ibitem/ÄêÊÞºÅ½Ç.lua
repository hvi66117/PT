nTaskInfo = 1175;
nTaskTimes = 1176;
nTaskNpcIdx = 1177;
function callboss()
    CloseDialog()
    if (HaveNormalItem(6, 1, 343, 0) >= 1) then
        local h, m, s = GetHMS()
        if (h < 20 and h >= 1) then
            Talk(1, "no", "VËt phÈm nµy chØ cã thÓ sö dông vµo lóc 20g ®Õn 1g s¸ng.")
            Msg2Player("VËt phÈm nµy chØ cã thÓ sö dông vµo lóc 20g ®Õn 1g s¸ng.")
            return
        end
        local mapId, posX, posY = GetWorldPos();
        if (mapId ~= 14) then
            Talk(1, "no", "VËt phÈm nµy chØ cã thÓ sö dông t¹i §ång Quan.")
            Msg2Player("VËt phÈm nµy chØ cã thÓ sö dông t¹i §ång Quan.")
            return
        end
        if (GetTeam() == 0) then
            Talk(1, "no", "ChØ khi tæ ®éi míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
            Msg2Player("ChØ khi tæ ®éi míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
            return
        end
        if (IsCaptain() == 0) then
            Talk(1, "no", "ChØ cã ®éi tr­ëng míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
            Msg2Player("ChØ cã ®éi tr­ëng míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
            return
        end
        local nMemberCount = GetTeamSize()
        local nNowLevel = GetLevel()
        local nMaxLevel = nNowLevel
        local nMinLevel = nNowLevel
        local nLevelTatol = 0
        local oldPlayer = PlayerIndex
        for i = 1, nMemberCount do
            PlayerIndex = GetTeamMember(i)
            local mapId, posX, posY = GetWorldPos();
            if (mapId ~= 14) then
                PlayerIndex = oldPlayer
                Talk(1, "no", "TÊc c¶ thµnh viªn ph¶i ë trªn cïng mét b¶n ®å míi cã thÓ sö dông.")
                Msg2Player("TÊc c¶ thµnh viªn ph¶i ë trªn cïng mét b¶n ®å míi cã thÓ sö dông.")
                return
            end
            local nMyLevel = GetLevel()
            if (nMyLevel < 50) then
                PlayerIndex = oldPlayer
                Talk(1, "no", "B¾t buéc mçi thµnh viªn ®Òu trªn cÊp 50 míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
                Msg2Player("B¾t buéc mçi thµnh viªn ®Òu trªn cÊp 50 míi cã thÓ sö dông Niªn Thó HiÖu Gi¸c.")
                return
            end
            if (nMyLevel > nMaxLevel) then
                nMaxLevel = nMyLevel
            end
            if (nMyLevel < nMinLevel) then
                nMinLevel = nMyLevel
            end
            if ((nMaxLevel - nMinLevel) > 30) then
                PlayerIndex = oldPlayer
                Talk(1, "no", "§¼ng cÊp bËc c¸c thµnh viªn kh«ng chªnh lÖch qu¸ 30")
                Msg2Player("§¼ng cÊp bËc c¸c thµnh viªn kh«ng chªnh lÖch qu¸ 30")
                return
            end
            nLevelTatol = nLevelTatol + nMyLevel
        end
        PlayerIndex = oldPlayer
        local nAverageLevel = math.floor(nLevelTatol / nMemberCount)
        local npcidx = 0
        if (nAverageLevel <= 60) then
            npcidx = AddNpc(669, 60, SubWorld, posX * 32, posY * 32)
            if (npcidx == 0) then
                Talk(1, "no", "Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                Msg2Player("Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                return
            end
            local namestring = GetName() .. "Niªn Thó"
            SetNpcName(npcidx, namestring)
            SetNpcOwer(npcidx, PlayerIndex)
        elseif (nAverageLevel <= 80) then
            npcidx = AddNpc(670, 80, SubWorld, posX * 32, posY * 32)
            if (npcidx == 0) then
                Talk(1, "no", "Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                Msg2Player("Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                return
            end
            local namestring = "<c=g>" .. GetName() .. "Niªn Thó"
            SetNpcName(npcidx, namestring)
            SetNpcOwer(npcidx, PlayerIndex)
        else
            npcidx = AddNpc(671, 100, SubWorld, posX * 32, posY * 32)
            if (npcidx == 0) then
                Talk(1, "no", "Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                Msg2Player("Khiªu chiÕn Niªn Thó thÊt b¹i, xin ®îi mét chót thö l¹i!")
                return
            end
            local namestring = "<c=yel>" .. GetName() .. "Niªn Thó"
            SetNpcName(npcidx, namestring)
            SetNpcOwer(npcidx, PlayerIndex)
        end
        local nNpcID = GetNpcID(npcidx)
        local nTaskInformation = nNpcID * nMemberCount
        for i = 1, nMemberCount do
            PlayerIndex = GetTeamMember(i)
            SetTask(nTaskInfo, nTaskInformation)
            SetTask(nTaskNpcIdx, 0)
            Msg2Player("Niªn Thó bÞ khiªu chiÕn")
        end
        PlayerIndex = oldPlayer
        SetTask(nTaskNpcIdx, nNpcID)
        SetTask(nTaskTimes, GetTask(nTaskTimes) + 1)
        DelNormalItem(6, 1, 343, 0)
    else
        Talk(1, "no", "Khiªu chiÕn Niªn Thó cÇn Niªn Thó HiÖu Gi¸c.")
    end
end

function main()
    local lucky = GetTask(nTaskTimes)
    local luckstrike = 0
    if (lucky <= 10) then
        luckstrike = lucky * 5
    elseif (lucky <= 20) then
        luckstrike = (lucky - 10) * 10 + 50
    elseif (lucky <= 30) then
        luckstrike = (lucky - 20) * 15 + 50 + 100
    else
        luckstrike = 300
    end
    MsgBox("§iÓm may m¾n cña b¹n lµ <c=yel>" .. luckstrike .. "<c>, mçi lÇn b¹n triÖu håi ®­îc Niªn Thó hoÆc cïng ®ång ®éi hµnh phôc Niªn Thó sÏ t¨ng ®iÓm may m¾n. TriÖu håi xong, h·y gi÷ nguyªn tr¹ng th¸i ®éi ngò ®Ó hµng phôc Niªn Thó.", "callboss", "no")
end

function no()
    CloseDialog()
end;
