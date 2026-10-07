TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

CONST_JS_MAP_BOOK = {
    { name = "B¶n ®å Hoang M¹c", item = { 6, 1, 504, 0 }, boss1 = 30, boss2 = 33, boss3 = 980 },
    { name = "B¶n ®å §«ng H¶i", item = { 6, 1, 505, 0 }, boss1 = 34, boss2 = 38, boss3 = 981 },
}

CONST_JS_MAP_COORD = {
    { name = "B¶n ®å Hoang m¹c täa ®é 1", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 2", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 3", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 4", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å Hoang M¹c täa ®é 5", x = 200 * 8, y = 200 * 16 },
}

CONST_JS_MAP_ID = {
    name = "Hoang M¹c tÇng", id = 22,
}

CONST_JS_SKILL_BOOK = {
    { name = "Tinh Th«ng Háa HÖ", item = { 7, 11, 14, 1 }, ratio = 30 },
    { name = "Phong V©n L«i §éng", item = { 7, 12, 15, 1 }, ratio = 90 },
    { name = "Ngò Nh¹c TriÒu T«ng", item = { 7, 13, 16, 1 }, ratio = 90 },
    { name = "Tinh Th«ng Tr­êng §ao", item = { 7, 31, 34, 1 }, ratio = 90 },
    { name = "Tinh Th«ng §o¶n §ao", item = { 7, 30, 33, 1 }, ratio = 90 },
    { name = "Tam §Çu Lôc Thñ", item = { 7, 32, 35, 1 }, ratio = 90 },
    { name = "Háa L«i TÕ", item = { 7, 53, 454, 1 }, ratio = 90 },
    { name = "Ph¸ Gi¸p chó", item = { 7, 44, 47, 1 }, ratio = 90 },
}

function OnDeath(npcidx)
    local mapid, x, y = GetNpcWorldPos(npcidx)
    local teamSize = GetTeamSize()
    local bindPlayerID = GetNpcTask(npcidx, 1)
    if (teamSize == 0) then
        local playerID = GetPlayerID()
        if (playerID == bindPlayerID) then
            local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
            local ghostStatus = GetTaskByte(TASK_JIANGSHAN, 2)
            local idolStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4)
            if (ghostStatus == 0 and idolStep == 4) then
                SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4, 5)
                TaskNote(Task_Info_JIANGSHAN_IDOLUM, 2)
                FinishNpcCollection(26)
                local bookIdx = math.random(1, 8)
                local class, detail, particular, level = myunpack(CONST_JS_SKILL_BOOK[bookIdx].item)
                ThrowItem(npcidx, -1, class, detail, particular, level, 0, 0)
                TopMessage("Hçn §én r¬i rít<c=yel>" .. CONST_JS_SKILL_BOOK[bookIdx].name)
                Msg2Player("§· tiªu diÖt Hçn §én ¶o c¶nh, r¬i ra 1" .. CONST_JS_SKILL_BOOK[bookIdx].name .. ", cã thÓ vÒ TriÒu Ca t×m D­ Kh¸nh nhËn th­ëng.")
            end
        end
    else
        local playerIndexCache = PlayerIndex
        for i = 1, teamSize do
            PlayerIndex = GetTeamMember(i)
            local mapid2, x2, y2 = GetWorldPos()
            local playerID = GetPlayerID()
            if (playerID == bindPlayerID and mapid2 == mapid) then
                local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
                local ghostStatus = GetTaskByte(TASK_JIANGSHAN, 2)
                local idolStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4)
                if (ghostStatus == 0 and idolStep == 4) then
                    SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4, 5)
                    TaskNote(Task_Info_JIANGSHAN_IDOLUM, 2)
                    FinishNpcCollection(26)
                    local bookIdx = math.random(1, 8)
                    local class, detail, particular, level = myunpack(CONST_JS_SKILL_BOOK[bookIdx].item)
                    ThrowItem(npcidx, -1, class, detail, particular, level, 0, 0)
                    TopMessage("Hçn §én r¬i rít<c=yel>" .. CONST_JS_SKILL_BOOK[bookIdx].name)
                    Msg2Player("§· tiªu diÖt Hçn §én ¶o c¶nh, r¬i ra 1" .. CONST_JS_SKILL_BOOK[bookIdx].name .. ", cã thÓ vÒ TriÒu Ca t×m D­ Kh¸nh nhËn th­ëng.")
                end
                break
            end
        end
        PlayerIndex = playerIndexCache
    end
    DelNpc(npcidx)
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end
