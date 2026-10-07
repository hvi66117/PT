CITY_build = 42

City_Pullulate = {
    [1] = { [1] = 4, [2] = 7, [3] = 9, },
    [2] = { [1] = 6, [2] = 9, [3] = 12, [4] = 14 },
    [3] = { [1] = 8, [2] = 11, [3] = 14, [4] = 17, [5] = 19 },
    [4] = { [1] = 10, [2] = 13, [3] = 16, [4] = 19, [5] = 22, [6] = 24, },
}

City_hatch = {
    [1] = {
        [1] = { { 1420, 1427 }, 5, 0 }, [2] = { { 1428, 1435 }, 2, 1 },
        [3] = { { 1444, 1445 }, 1, 2 }, },
    [2] = {
        [1] = { { 1420, 1427 }, 10, 0 }, [2] = { { 1428, 1435 }, 3, 1 },
        [3] = { { 1444, 1445 }, 1, 2 }, [4] = { { 1446, 1447, 1448, 1449 }, 1, 3 } },
    [3] = {
        [1] = { { 1420, 1427 }, 15, 0 }, [2] = { { 1428, 1435 }, 4, 1 }, [3] = { { 1444, 1445 }, 1, 2 },
        [4] = { { 1446, 1447, 1448, 1449 }, 1, 3 }, [5] = { { 1450, 1451, 1508 }, 1, 4 } },
    [4] = {
        [1] = { { 1420, 1427 }, 20, 0 }, [2] = { { 1428, 1435 }, 5, 1 }, [3] = { { 1444, 1445 }, 1, 2 },
        [4] = { { 1446, 1447, 1448, 1449 }, 1, 3 }, [5] = { { 1450, 1451, 1508 }, 1, 4 }, [6] = { { 1509, 1510 }, 1, 5 }, },
}

eggs = {
    [1] = { info = 1080, index = 1081, id = 1082, tim = 1083 },
    [2] = { info = 1407, index = 1408, id = 1409, tim = 1410 },
    [3] = { info = 1411, index = 1412, id = 1413, tim = 1414 }
}

function FindSameIdx()
    local taskNum = 0
    local dialogIdx = GetTask(142)
    for i = 1, 3, 1 do
        if (GetTask(eggs[i].index) == dialogIdx) then
            taskNum = i
            break
        end
    end
    return taskNum
end

function main()
    CloseDialog()
    local H, M, S = GetHMS()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx <= 0) or (GetNpcTemplateID(TargetNpcIdx) ~= 587) then
        Talk(1, "no", "¢m D­¬ng Thiªn Th­ chØ sö dông víi ThÊt s¾c Th¹ch CÇu.")
        Msg2Player("B¹n ch­a chän tróng ThÊt s¾c Th¹ch CÇu!")
        return
    end

    SetTask(142, DialogNpcIdx)
    local taskNum = FindSameIdx()
    if (taskNum > 0) then
        Talk(1, "no", "Kh«ng thÓ sö dông ¢m D­¬ng Thiªn Th­ víi ThÊt s¾c Th¹ch CÇu chÝnh m×nh nu«i.")
        return
    end

    if (IsInMonsterAttackDay() == 1) and (H == 20 and M < 40) then
        if (IsInCity() == 1) and (GetFightState() == 1) then
            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                return 0
            end

            if (GetNpcTask(DialogNpcIdx, 5) == 1) then
                Talk(1, "no", "ThÊt s¾c Th¹ch CÇu ®· chÞu ¶nh h­ëng cña ¢m D­¬ng Thiªn Th­, kh«ng thÓ sö dông ¢m D­¬ng Thiªn Th­ n÷a.")
                return
            end

            startReadProcess()

        else
            Talk(1, "no", "¢m D­¬ng Thiªn Th­ chØ sö dông trong l·nh ®Þa tù x©y trong thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "¢m D­¬ng Thiªn Th­ chØ sö dông trong l·nh ®Þa tù x©y trong thêi gian Quèc ChiÕn.")
    end
end;

function no()
    CloseDialog()
end;

EGG_TEMPLATE = 587
BAR_TIME = 3

function startReadProcess()
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(EGG_TEMPLATE, 0, BAR_TIME, "\\script\\motion\\Ê¹ÓÃÒõÑôÌìÊé.lua", nInterrupt)
end

function hatch_yes(npcindex)
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local lvl = GetNpcTask(npcindex, 2)
    local j, nums, r, min, npcID, npcBossIdx, m
    local Pullulate = GetNpcTask(npcindex, 1) - 2
    local iswar = GetNpcTask(npcindex, 3)
    j = 0
    nums = 0
    for i = table.getn(City_Pullulate[lvl]), 1, -1 do
        if (Pullulate >= City_Pullulate[lvl][i]) then
            j = i
            break
        end
    end

    if (j >= 3) then
        nums = 1
        min = table.getn(City_hatch[lvl][j][1])
        r = math.random(1, min)
        npcID = City_hatch[lvl][j][1][r]
    elseif (j > 0) then
        nums = City_hatch[lvl][j][2]
        local npcId_j = { [1] = { 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1511, 1512, 1513, 1514, 1515, 1516 },
                          [2] = { 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1511, 1512, 1513, 1514, 1515, 1516 } }

        for nk = table.getn(npcId_j[j]), 1, -1 do
            if (GetLevel() >= 30 + nk * 10) then
                npcID = npcId_j[j][nk]
                break ;
            end
        end
    else
        Talk(1, "no", "§é tr­ëng thµnh qu¸ thÊp, kh«ng thÓ th¶")

        SetNpcTask(npcindex, 5, 1)
        SetNpcName(npcindex, "<c=g>ThÊt s¾c Th¹ch CÇu tæn h¹i<c>")

        return 0
    end

    m = 0
    local w, x, y = GetWorldPos()
    local GateNpcIdx = GetCityGateNpcIdxByNpc(npcindex)
    local TotemNpcIdx = GetCityTotemNpcIdxByNpc(npcindex)
    for k = 1, nums do
        local Npc_Lvl = {}
        for a = 1, 8 do
            Npc_Lvl[a + 1419] = 30 + a * 10
        end
        for a = 1, 8 do
            Npc_Lvl[a + 1427] = 30 + a * 10
        end
        for a = 1, 6 do
            Npc_Lvl[a + 1510] = 110 + a * 10
        end
        for a = 1, 4 do
            Npc_Lvl[1443 + a] = 60
        end
        for a = 1, 2 do
            Npc_Lvl[1449 + a] = 80
        end
        Npc_Lvl[1508] = 80
        Npc_Lvl[1509] = 100
        Npc_Lvl[1510] = 120

        local H, M, S = GetHMS()
        if (j == 2) then
            if (GetCamp() ~= 2) then
                npcBossIdx = CallMonsterAttacker(GateNpcIdx, npcID, Npc_Lvl[npcID], x * 32, y * 32, "\\script\\ontimer\\É¾µô×Ô¼º.lua", (40 - M) * 60, "\\script\\¹ÖÎï\\¹¥³Çµ°.lua", 1, 15, TotemNpcIdx)
                SetNpcCamp(npcBossIdx, 4)

                local npcName = GetNpcName(npcBossIdx)
                SetNpcName(npcBossIdx, "<c=pk>Bªn tÊn c«ng*" .. npcName .. "<c>")
            else
                npcBossIdx = AddNpc(npcID, Npc_Lvl[npcID], SubWorld, x * 32, y * 32, 1)
                SetNpcScript(npcBossIdx, "\\script\\¹ÖÎï\\¹¥³Çµ°.lua")
                SetNpcTimer(npcBossIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", (40 - M) * 60)
                SetNpcCamp(npcBossIdx, 2)

                local npcName = GetNpcName(npcBossIdx)
                SetNpcName(npcBossIdx, "<c=pk>Bªn phßng thñ*" .. npcName .. "<c>")
            end
        else
            if (GetCamp() ~= 2) then
                npcBossIdx = CallMonsterAttacker(GateNpcIdx, npcID, Npc_Lvl[npcID], x * 32, y * 32, "\\script\\ontimer\\É¾µô×Ô¼º.lua", (40 - M) * 60, "\\script\\¹ÖÎï\\¹¥³Çµ°.lua", 0, 15, TotemNpcIdx)
                SetNpcCamp(npcBossIdx, 4)

                local npcName = GetNpcName(npcBossIdx)
                SetNpcName(npcBossIdx, "<c=pk>Bªn tÊn c«ng*" .. npcName .. "<c>")
            else
                npcBossIdx = AddNpc(npcID, Npc_Lvl[npcID], SubWorld, x * 32, y * 32)
                SetNpcScript(npcBossIdx, "\\script\\¹ÖÎï\\¹¥³Çµ°.lua")
                SetNpcTimer(npcBossIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", (40 - M) * 60)
                SetNpcCamp(npcBossIdx, 2)

                local npcName = GetNpcName(npcBossIdx)
                SetNpcName(npcBossIdx, "<c=pk>Bªn phßng thñ*" .. npcName .. "<c>")
            end
        end

        if (npcBossIdx > 0) then
            local NewNpcName = GetNpcName(npcBossIdx)
            if (j >= 3) then
                if (j >= 5) then
                    if (IsTongMember() > 0) then
                        Msg2CurMapAnnounce(GetTongName() .. "- <RoleName=\"" .. GetName() .. "\"> dïng ¢m D­¬ng Thiªn Th­ biÕn ThÊt s¾c Th¹ch CÇu thµnh " .. NewNpcName .. ", ph¸ háng kh«ng th­ong tiÕc!")
                    else
                        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> dïng ¢m D­¬ng Thiªn Th­ biÕn ThÊt s¾c Th¹ch CÇu thµnh " .. NewNpcName .. ", ph¸ háng kh«ng th­ong tiÕc!")
                    end
                end
            end
        end
    end

    SetNpcTask(npcindex, 5, 1)
    SetNpcName(npcindex, "<c=g>ThÊt s¾c Th¹ch CÇu tæn h¹i<c>")

end

