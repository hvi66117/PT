module("OLDROLEGOBACK", package.seeall)

function FinishTask(nTask, nNpcIdx)

    local nYear, nMon, nDay = GetYMD()
    if not (nYear == 2015 and (nMon == 10 and nDay >= 13) and (nMon == 10 and nDay <= 19)) then
        return
    end

    if not (GetLevel() >= 60) then
        return
    end

    if (GetTaskByte(2026, 1) ~= nDay) then
        SetTaskByte(2026, 1, nDay)
        SetTaskByte(1987, 2, 0)
        SetTaskByte(1987, 4, 0)
    end

    local nTimes = 0
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1

    if (nTask == 1) then
        Msg2Player("ƒ„Hoµn thµnh nhi÷m vÙ ¡À“ª¥ŒTh∏m Qu©n.")
        AddFsl(1)


    elseif (nTask == 2 and GetTaskByte(1987, 2) < 5) then
        nTimes = GetTaskByte(1987, 2)
        SetTaskByte(1987, 2, nTimes + 1)
        Msg2Player("ƒ„Hoµn thµnh nhi÷m vÙ ¡À“ª¥ŒVÀn L≠¨ng.")
        AddFsl(1)


    elseif (nTask == 4 and GetTaskByte(1987, 4) < 10) then
        local H, M, S = GetHMS()
        if (H < 19 or H > 22) then
            return
        end
        nTimes = GetTaskByte(1987, 4)
        SetTaskByte(1987, 4, nTimes + 1)
        Msg2Player("ƒ„Hoµn thµnh nhi÷m vÙ ¡À“ª¥Œº¥ ±π˙’Ω.")
        AddFsl(1)

    elseif (nTask == 5) then
        WriteLog("[◊ ¡œ∆¨¿œ”√ªßªÿ¡˜][" .. GetName() .. "][¥ÚÀ¿¡ÀÕÚœ…’Ûboss]")
        local oldPlayer = _G.PlayerIndex
        local npcMap, npcMapX, npcMapY = GetNpcWorldPos(nNpcIdx)
        local mapidx = SubWorldID2Idx(npcMap)
        local nPlayerCount = GetSubWorldPlayerCount(mapidx)
        for i = 1, nPlayerCount do
            _G.PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, i)
            if (_G.PlayerIndex > 0) then
                local nWordID, nX, nY = GetWorldPos()
                local nDis = math.sqrt((nX - npcMapX) ^ 2 + (nY - npcMapY) ^ 2) * 32
                if (npcMap == nWordID and nDis <= 400) then


                    if (nNpcIdx > 0) then


                        Msg2Player("ƒ„Hoµn thµnh nhi÷m vÙ ¡À“ª¥Œ”¬¥≥ÕÚœ….")
                        WriteLog("[◊ ¡œ∆¨¿œ”√ªßªÿ¡˜][" .. GetName() .. "][ÕÚœ…’Ûboss∏ΩΩ¸][" .. nDis .. "¬Îæ‡¿Î]")
                        AddFsl(2)
                    end
                else
                    WriteLog("[◊ ¡œ∆¨¿œ”√ªßªÿ¡˜][" .. GetName() .. "][ÕÚœ…’Ûboss‘∂¿Î][" .. nDis .. "¬Îæ‡¿Î][npcMap:" .. npcMap .. "][nWordID:" .. nWordID .. "]")
                end
            end
        end
        _G.PlayerIndex = oldPlayer

        if (IsAddExtra() > 0) then
            AddExtra(1)
        end

    end
end

function AddFsl(count)


    if (count == nil or count <= 0) then
        return
    end
    for i = 1, count do
        AddNormalItemBind(3, 1622, 0, 0, 0, 0, 1)
    end
    Msg2Player("ChÛc mıng ngµi nhÀn Æ≠Óc Phong Th«n L÷nh*" .. count .. ".")
    WriteLog("NhÀn Æ≠Óc Phong Th«n L÷nh*" .. count)
end

function AddExtra(count)
    if not (GetGameServerName() == "") then
        return
    end
    if (count == nil or count <= 0) then
        return
    end

    if (GetTeam() == 0) then


    else

        local oldPlayer = _G.PlayerIndex

        local size = GetTeamSize()
        for i = 1, size do
            _G.PlayerIndex = GetTeamMember(i)
            for i = 1, count do
                AddNormalItemBind(3, 1622, 0, 0, 0, 0, 1)
            end
            Msg2Player("ChÛc mıng ngµi nhÀn Æ≠Óc Phong Th«n L÷nh*" .. count .. ".")
            WriteLog("NhÀn Æ≠Óc Phong Th«n L÷nh*" .. count)
        end

        _G.PlayerIndex = oldPlayer
    end
end

function IsAddExtra()

    if (GetTeam() == 0) then
        if (GetTaskByte(2024, 1) >= 1) then
            return 0
        else
            return 0
        end
    else

        local oldPlayer = _G.PlayerIndex

        local size = GetTeamSize()
        for i = 1, size do
            _G.PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(2024, 1) >= 1) then
                _G.PlayerIndex = oldPlayer
                return 1
            end
        end

        _G.PlayerIndex = oldPlayer
        return 0
    end
end

