Task_Variety_Process = 1389

Task_Time_Stemp = 1390
Task_NpcID = 1391
puteGhost = 956
bigHeadFish = 952
foldFish = 952
greatTongueFish = 952

Coordinate = {
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045

function OnDeath(npcindex)

    processJiangshan(npcindex)

    local flag = 0
    if (GetTeam() == 0 and GetTaskByte(Task_Variety_Process, 1) == 9) then
        flag = 1
    elseif (GetTeam() ~= 0) then
        local oldPlayerIndex = PlayerIndex
        local memberNum = GetTeamSize()
        for i = 1, memberNum do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Variety_Process, 1) == 9) then
                flag = 1
                break
            end
        end
        PlayerIndex = oldPlayerIndex
    end

    if (flag == 1) then
        if (GetTask(Task_Time_Stemp) + 60 >= SystemTime()) then
            return
        end

        local id, x, y = GetNpcWorldPos(npcindex)

        local fishIndex = AddNpc(greatTongueFish, 1, SubWorldID2Idx(id), x * 32, y * 32)
        SetNpcScript(fishIndex, "\\script\\ÁúÌ×\\¾Þ¹ÇÉàÓã.lua")
        SetNpcName(fishIndex, "<c=g>Cù Cèt ThiÖt Ng­<c>")
        SetNpcTimer(fishIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60)
        local fishID = GetNpcID(fishIndex)

        if (GetTeam() == 0) then
            SetTask(Task_NpcID, fishID)
            SetTask(Task_Time_Stemp, SystemTime())
            TopMessage("XuÊt hiÖn 1 Cù Cèt ThiÖt Ng­ l¹")
            Msg2Player("Cù Cèt ThiÖt Ng­ xuÊt hiÖn, mau ®i hái manh mèi.")
            return
        end

        if (GetTeam() ~= 0) then
            local oldPlayerIndex = PlayerIndex
            local memberNum = GetTeamSize()
            for i = 1, memberNum do
                PlayerIndex = GetTeamMember(i)
                SetTask(Task_Time_Stemp, SystemTime())
                if (GetTaskByte(Task_Variety_Process, 1) == 9) then
                    SetTask(Task_NpcID, fishID)
                    TopMessage("XuÊt hiÖn 1 Cù Cèt ThiÖt Ng­ l¹")
                    Msg2Player("Cù Cèt ThiÖt Ng­ xuÊt hiÖn, mau ®i hái manh mèi.")
                end
                PlayerIndex = oldPlayerIndex
            end
        end
    end
end

TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

CONST_JS_FISH = {
    { name = "§¹i §Çu Ng­", ratio = 50 },
    { name = "TriÕt La Ng­", ratio = 80 },
    { name = "Cù Cèt ThiÖt Ng­", ratio = 100 },
}

function processJiangshan(npcindex)
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    local teamSize = GetTeamSize()
    if (teamSize == 0) then
        processJiangshanForOne(npcindex)
    else
        local playerIndexCache = PlayerIndex
        for i = 1, teamSize do
            PlayerIndex = GetTeamMember(i)
            local mapid2, x2, y2 = GetWorldPos()
            if (mapid2 == mapgid) then
                processJiangshanForOne(npcindex)
            end
        end
        PlayerIndex = playerIndexCache
    end
end

function processJiangshanForOne(npcindex)
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    if (mainStatus > 0 or oneStep ~= 3 or page2Step ~= 3) then
        return 0
    end
    local twoStepStatus = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3)
    local twoStepOption = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4)
    if (twoStepStatus ~= 1 or twoStepOption ~= 1) then
        return 0
    end
    local twoStepOption2 = GetTaskByte(TASK_JIANGSHAN_ONE_DATE, 3)
    if (twoStepOption2 ~= 3) then
        return 0
    end

    SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3, 2)
    SetTaskByte(TASK_JIANGSHAN_ONE_DATE, 3, 0)
    TaskNote(Task_Info_JIANGSHAN_TWO, 7)
    FinishNpcCollection(6)
    TopMessage("ThiÕt Ng­ v­¬ng c©u kÕt ng­êi ngoµi h¹i ta")
    Msg2Player("Gióp ThiÕt Ng­ v­¬ng diÖt trõ Cù Cèt ThiÖt Ng­ thµnh c«ng, chøng thùc ThiÕt Ng­ v­¬ng chÝnh lµ néi øng cña D­ Kh¸nh n¨m x­a, vÒ phôc mÖnh D­ Kh¸nh.")
end


