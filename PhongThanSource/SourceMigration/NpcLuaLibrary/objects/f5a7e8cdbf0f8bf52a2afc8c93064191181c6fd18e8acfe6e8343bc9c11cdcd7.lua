TASK_JIANGSHAN = 1426

Task_HelpScore = 1491
SCORE_LIMIT = 100

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
    { name = "B¶n ®å §«ng H¶i täa ®é 1", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å §«ng h¶i täa ®é 2", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å §«ng h¶i täa ®é 3", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å §«ng h¶i täa ®é 4", x = 200 * 8, y = 200 * 16 },
    { name = "B¶n ®å §«ng H¶i täa ®é 5", x = 200 * 8, y = 200 * 16 },
}

CONST_JS_MAP_ID = {
    name = "§«ng H¶i tÇng 1", id = 37,
}

CONST_JS_SKILL_BOOK = {
    {
        { name = "Tinh Th«ng Háa HÖ", item = { 7, 11, 14, 1 }, ratio = 30 },
        { name = "Phong V©n L«i §éng", item = { 7, 12, 15, 1 }, ratio = 30 },
        { name = "Ngò Nh¹c TriÒu T«ng", item = { 7, 13, 16, 1 }, ratio = 30 },
        { name = "Tinh Th«ng Tr­êng §ao", item = { 7, 31, 34, 1 }, ratio = 30 },
        { name = "Tinh Th«ng §o¶n §ao", item = { 7, 30, 33, 1 }, ratio = 30 },
        { name = "Tam §Çu Lôc Thñ", item = { 7, 32, 35, 1 }, ratio = 30 },
        { name = "Háa L«i TÕ", item = { 7, 53, 454, 1 }, ratio = 30 },
        { name = "Ph¸ Gi¸p chó", item = { 7, 44, 47, 1 }, ratio = 30 },
    },
    {
        { name = "Tinh Th«ng B¨ng HÖ", item = { 7, 14, 17, 1 }, ratio = 30 },
        { name = "ThËp Ph­¬ng LiÖt Háa", item = { 7, 15, 18, 1 }, ratio = 30 },
        { name = "HuyÒn B¨ng tr¶m", item = { 7, 33, 36, 1 }, ratio = 30 },
        { name = "Háa Quang Tr¶m", item = { 7, 34, 37, 1 }, ratio = 30 },
        { name = "To¸i Cèt tÕ", item = { 7, 54, 455, 1 }, ratio = 30 },
        { name = "Bå §Ò chó", item = { 7, 45, 48, 1 }, ratio = 30 },
    },
}

function OnDeath(npcidx)
    local mapid, x, y = GetNpcWorldPos(npcidx)
    local teamSize = GetTeamSize()
    local bindPlayerID = GetNpcTask(npcidx, 1)

    local playerLevel = 0
    local nIP = 0
    local addScore = 0
    local array = {}
    local help_num = 1

    if (teamSize == 0) then
        local playerID = GetPlayerID()
        if (playerID == bindPlayerID) then
            local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
            local ghostStatus = GetTaskByte(TASK_JIANGSHAN, 2)
            local idolStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4)
            if (ghostStatus == 1 and idolStep == 4) then
                SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4, 5)
                TaskNote(Task_Info_JIANGSHAN_IDOLUM, 5)
                FinishNpcCollection(27)
                local bookIdx = math.random(1, 5)
                local bookIdx2 = 1
                if (bookIdx <= 3) then
                    bookIdx = 1
                    bookIdx2 = math.random(1, 8)
                else
                    bookIdx = 2
                    bookIdx2 = math.random(1, 6)
                end
                local class, detail, particular, level = myunpack(CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].item)
                ThrowItem(npcidx, -1, class, detail, particular, level, 0, 0)
                TopMessage("Cïng Kú r¬i rít<c=yel>" .. CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].name)
                Msg2Player("§· tiªu diÖt Cïng Kú ¶o c¶nh, r¬i ra 1" .. CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].name .. ", cã thÓ vÒ TriÒu Ca t×m D­ Kh¸nh nhËn th­ëng.")
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
                if (ghostStatus == 1 and idolStep == 4) then
                    SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4, 5)
                    TaskNote(Task_Info_JIANGSHAN_IDOLUM, 5)
                    FinishNpcCollection(27)
                    local bookIdx = math.random(1, 5)
                    local bookIdx2 = 1
                    if (bookIdx <= 3) then
                        bookIdx = 1
                        bookIdx2 = math.random(1, 8)
                    else
                        bookIdx = 2
                        bookIdx2 = math.random(1, 6)
                    end
                    local class, detail, particular, level = myunpack(CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].item)
                    ThrowItem(npcidx, -1, class, detail, particular, level, 0, 0)
                    TopMessage("Cïng Kú r¬i rít<c=yel>" .. CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].name)
                    Msg2Player("§· tiªu diÖt Cïng Kú ¶o c¶nh, r¬i ra 1" .. CONST_JS_SKILL_BOOK[bookIdx][bookIdx2].name .. ", cã thÓ vÒ TriÒu Ca t×m D­ Kh¸nh nhËn th­ëng.")

                    playerLevel = GetLevel()
                    nIP = GetIPValue()
                    addScore = addScore + 1
                    array[help_num] = GetName()
                    help_num = help_num + 1

                end
                break
            end
        end
        PlayerIndex = playerIndexCache

        if (playerLevel > 0) then
            if (GetLevel() - playerLevel >= 20) then
                if (nIP ~= GetIPValue()) then
                    local scoreLimit = GetTaskByte(Task_HelpScore, 3)
                    if (scoreLimit < SCORE_LIMIT) then
                        scoreLimit = scoreLimit + addScore
                        if (scoreLimit > SCORE_LIMIT) then
                            addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                        end
                        SetTaskByte(Task_HelpScore, 3, scoreLimit)
                        AddHelpScore(addScore)
                        local str = ""
                        for i = 1, help_num - 1 do
                            str = str .. "<c=g><RoleName=\"" .. array[i] .. "\"><c> "
                        end
                        AddEvent("%s ®· ®¸nh b¹i <c=g>Cïng Kú ¶o C¶nh<c>, gióp" .. str .. " ®· khiªu chiÕn qu¸i ¶o C¶nh trong nhiÖm vô Giang S¬n Y Cùu, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. " ®iÓm kinh nghiÖm.", 1)
                        Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa!")
                        WriteLog(GetName() .. " nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa.")
                    else
                        Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                    end
                else
                    Msg2Player("Do cïng IP nªn kh«ng thÓ nhËn ®iÓm Nh©n NghÜa!")
                end
            end
        end

    end
    DelNpc(npcidx)
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end
