Task_hetu = 1387

Hetu_playerID = 1388
Global_longmashui = 185
Global_longmahuo = 186

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local tasks = {
        { "TriÖu gäi Long M·", "zhaohuan"; show = 0 },
    }

    if (GetTaskByte(Task_hetu, 1) == 1 and GetTeam() ~= 0 and GetTeamSize() == 2 and checkRelation() == 1 and GetTaskByte(Task_hetu, 2) ~= 1) then
        tasks[1].show = 1
    end

    if (GetTaskByte(Task_hetu, 1) == 3 and GetTeam() ~= 0 and GetTeamSize() == 2 and checkRelation() == 1 and GetTaskByte(Task_hetu, 2) == 1) then
        tasks[1].show = 1
    end

    SayTask("Linh Th¹c chíp nho¸ng hµo quang, bÒ mÆt nh­ cã nh÷ng v¨n tù bÊt minh.", tasks)
end

function checkRelation()
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID()
    PlayerIndex = oldPlayer
    if (GetTask(Hetu_playerID) == playerID_temp) then
        return 1
    end
    return 0
end

function getduiyouID()
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID()
    PlayerIndex = oldPlayer
    return playerID_temp
end

function zhaohuan()

    CloseDialog()

    if (GetTaskByte(Task_hetu, 1) == 1) then
        if (GetTaskByte(Task_hetu, 2) == 1) then
            Talk(1, "no", "Mêi ®éi viªn lóc nhËn nhiÖm vô qua ®©y")
            return
        end
    elseif (GetTaskByte(Task_hetu, 1) == 3) then
        if (GetTaskByte(Task_hetu, 2) ~= 1) then
            Talk(1, "no", "Mêi ®éi tr­ëng lóc nhËn nhiÖm vô qua ®©y")
            return
        end
    end

    if (GetTeamSize() ~= 2 or checkRelation() ~= 1) then
        Talk(1, "no", GetName() .. " kh«ng cã ph¶n øng, xem ra chØ cã thÓ lµ ®ång ®éi cïng nhËn nhiÖm vô ®­îc.")
        return
    end

    local nMapNpcIndex1 = GetGlobalValue(Global_longmashui)
    local nMapNpcIndex2 = GetGlobalValue(Global_longmahuo)
    if (nMapNpcIndex1 ~= 0 or nMapNpcIndex2 ~= 0) then
        if (GetNpcTask(nMapNpcIndex1, 1) ~= getduiyouID() and GetNpcTask(nMapNpcIndex2, 1) ~= GetPlayerID()) then
            Talk(1, "no", GetName() .. "Long M· trong linh th¹ch ®· bÞ ng­êi kh¸c th¶ ®i, t¹m thêi kh«ng thÓ triÖu gäi")
        elseif (GetNpcTask(nMapNpcIndex1, 1) ~= getduiyouID() or GetNpcTask(nMapNpcIndex2, 1) ~= GetPlayerID()) then
            Talk(1, "no", GetName() .. "Long M· trong linh th¹ch chØ cã thÓ triÖu gäi thµnh ®«i, hiÖn cã 1 con cßn tån l¹i, t¹m thêi kh«ng thÓ triÖu gäi.")
        else
            TopMessage("<c=g>Long M·<c> ®· xuÊt hiÖn.")
        end
        return
    end

    if (HaveIBBuff(643) > 0) then


        if (GetTaskByte(Task_hetu, 4) == 0) then
            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                RemoveIBBuff(643)
                TopMessage("<c=g>Long M·<c> ®· xuÊt hiÖn.")
                SetTaskByte(Task_hetu, 4, 0)
                SetTaskByte(Task_hetu, 3, 0)

            end
            PlayerIndex = oldPlayer
            longma()
        else
            ScrollMessage("§îi ®éi viªn khëi ®éng")
        end

    elseif (HaveIBBuff(643) == 0) then

        if (GetTaskByte(Task_hetu, 4) == 0) then
            SetTaskByte(Task_hetu, 4, 1)
            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                AddIBBuff(643)
                TopMessage("Nghi thøc triÖu gäi Long M· ®· khëi ®éng")
            end
            PlayerIndex = oldPlayer
        end
    end
end

function longma()

    CloseDialog()

    local nMapNpcIndex1 = GetGlobalValue(Global_longmashui)
    local nMapNpcIndex2 = GetGlobalValue(Global_longmahuo)

    if (nMapNpcIndex1 == 0 and nMapNpcIndex2 == 0) then
        local mapid = SubWorldID2Idx(73)

        local longmashui = AddNpc(944, 30, mapid, 1840 * 32, 3208 * 32)
        SetGlobalValue(Global_longmashui, longmashui)
        SetNpcName(longmashui, "Long M· (Thñy)")
        SetNpcTask(longmashui, 1, getduiyouID())

        SetNpcTimer(longmashui, "\\script\\ontimer\\ÁúÂíÉ¾³ý×Ô¼º.lua", 180)

        local longmahuo = AddNpc(945, 30, mapid, 1851 * 32, 3835 * 32)
        SetGlobalValue(Global_longmahuo, longmahuo)
        SetNpcName(longmahuo, "Long M· (Háa)")
        SetNpcTask(longmahuo, 1, GetPlayerID())

        SetNpcTimer(longmahuo, "\\script\\ontimer\\ÁúÂíÉ¾³ý×Ô¼º.lua", 180)
    end
end

function no()
    CloseDialog()
end;
