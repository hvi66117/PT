task_renwu = 1309

totleNumber = 1311
killTimes = 1325

function OnDeath(monsterNpcIdx)
    local killerIdx = PlayerIndex
    local killerID = GetPlayerID()
    local playerID = GetNpcTask(monsterNpcIdx, 0)
    local playerCredit = GetNpcTask(monsterNpcIdx, 1)
    local TargetNpcIdx = GetNpcTask(monsterNpcIdx, 2)

    local number = GetNpcTask(TargetNpcIdx, 5)
    local killerCredit

    if (GetJusticEvilCredit() > 0) then
        killerCredit = 1
    else
        killerCredit = 0
    end

    local id, x, y = GetNpcWorldPos(monsterNpcIdx)
    if (GetNpcTask(TargetNpcIdx, 6) + 180 >= SystemTime()) then
        if (killerID == playerID) then
            PlayerIndex = SearchPlayerById(playerID)

            number = number - 1
            SetNpcTask(TargetNpcIdx, 5, number)
            local refreshTimes = GetTaskByte(killTimes, 1)
            refreshTimes = refreshTimes + 1
            SetTaskByte(killTimes, 1, refreshTimes)

            local isDropStone = GetTaskByte(killTimes, 2)
            if (refreshTimes <= 10 and isDropStone == 0 and number < 3) then
                MonsterDrop(monsterNpcIdx, TargetNpcIdx)
            end

            if (GetNpcTask(TargetNpcIdx, 1) >= 15 and GetNpcTask(TargetNpcIdx, 1) <= 18) then
                if (number == 0) and (GetNpcTask(TargetNpcIdx, 9) == 0) then
                    local id1, x1, y1 = GetNpcWorldPos(TargetNpcIdx)
                    local id2, x2, y2 = GetWorldPos()

                    if (id1 == id2) then
                        SetNpcTask(TargetNpcIdx, 0, 0)
                        DelNpcTimer(TargetNpcIdx)

                        SetTaskByte(task_renwu, 3, 0)
                        SetTaskByte(task_renwu, 4, 1)
                        RemoveIBBuff(515)
                        TaskNote(1026, 4)
                        Msg2Player("§· siªu ®é thµnh c«ng tÊt c¶ Phi Thè Ma, vÒ gÆp N÷ Oa n­¬ng n­¬ng nhËn th­ëng")
                    end
                end
            end

            PlayerIndex = killerIdx
        elseif (killerCredit == playerCredit) then
            local temp = math.random(1, 100)
            if (temp <= 20) then
                number = number - 1
                SetNpcTask(TargetNpcIdx, 5, number)

                if (GetNpcTask(TargetNpcIdx, 1) >= 15 and GetNpcTask(TargetNpcIdx, 1) <= 18) then
                    if (number == 0) then
                        local id1, x1, y1 = GetNpcWorldPos(TargetNpcIdx)
                        local id2, x2, y2 = GetWorldPos()
                        local pld = SearchPlayerById(playerID)

                        if (id1 == id2) and (pld > 0) and (GetNpcTask(TargetNpcIdx, 9) == 0) then
                            PlayerIndex = pld
                            SetNpcTask(TargetNpcIdx, 0, 0)
                            DelNpcTimer(TargetNpcIdx)

                            SetTaskByte(task_renwu, 3, 0)
                            SetTaskByte(task_renwu, 4, 1)
                            RemoveIBBuff(515)
                            TaskNote(1026, 4)
                            Msg2Player("§· siªu ®é thµnh c«ng tÊt c¶ Phi Thè Ma, vÒ gÆp N÷ Oa n­¬ng n­¬ng nhËn th­ëng")
                        end
                    end
                end
                PlayerIndex = killerIdx

            else

                local pld = SearchPlayerById(playerID)
                if (pld > 0) then

                    PlayerIndex = pld

                    number = number - 1
                    local k = AddNpc(810, 15, SubWorldID2Idx(id), x * 32, y * 32)
                    SetNpcScript(k, "\\script\\npcdeath\\ìåÄ§ËÀÍö.lua")
                    SetNpcName(k, GetName() .. "Phi Thè Ma")

                    local lifetime = 180 - (SystemTime() - GetNpcTask(TargetNpcIdx, 6))
                    if (lifetime <= 0) then
                        lifetime = 1
                    end
                    SetNpcTimer(k, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lifetime)

                    SetNpcTask(k, 0, playerID)
                    SetNpcTask(k, 1, playerCredit)
                    SetNpcTask(k, 2, TargetNpcIdx)

                    number = number + 1
                    SetNpcTask(TargetNpcIdx, 5, number)
                    PlayerIndex = killerIdx

                end

            end
        elseif (killerCredit ~= playerCredit) then
            number = number - 1
            for i = 1, 2, 1 do
                if (number >= 30) then
                    break
                end

                local pld = SearchPlayerById(playerID)
                if (pld > 0) then

                    PlayerIndex = pld

                    local k = AddNpc(810, 15, SubWorldID2Idx(id), x * 32, y * 32)
                    SetNpcScript(k, "\\script\\npcdeath\\ìåÄ§ËÀÍö.lua")
                    SetNpcName(k, GetName() .. "Phi Thè Ma")

                    local lifetime = 180 - (SystemTime() - GetNpcTask(TargetNpcIdx, 6))
                    if (lifetime <= 0) then
                        lifetime = 1
                    end
                    SetNpcTimer(k, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lifetime)

                    SetNpcTask(k, 0, playerID)
                    SetNpcTask(k, 1, playerCredit)
                    SetNpcTask(k, 2, TargetNpcIdx)
                    number = number + 1

                end

            end
            PlayerIndex = killerIdx
            SetNpcTask(TargetNpcIdx, 5, number)
        end
    end
    DelNpc(monsterNpcIdx)
end

function MonsterDrop(monsterNpcIdx, TargetNpcIdx)
    local playerID = GetNpcTask(TargetNpcIdx, 4)
    local pld = SearchPlayerById(playerID)
    if (pld > 0) then
        PlayerIndex = pld
    else
        return
    end

    local t = math.random(1, 150)
    if (t == 1) then
        local r = math.random(1, 20)
        if (r >= 1 and r <= 14) then
            local s = math.random(0, 2)
            s = 254 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        elseif (r >= 15 and r <= 19) then
            local s = math.random(0, 2)
            s = 255 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        else
            local s = math.random(0, 2)
            s = 256 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        end
        SetTaskByte(killTimes, 2, 1)
        Msg2Player("r¬i ra 1 B¶o Th¹ch ch­a mµi s¸ng")

    end
end
