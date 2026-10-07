TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

Task_HelpScore = 1491
SCORE_LIMIT = 100

CONST_JS_SKILL_BOOK = {

    { name = "Tinh Th«ng B¨ng HÖ", item = { 7, 14, 17, 1 }, ratio = 30 },
    { name = "ThËp Ph­¬ng LiÖt Háa", item = { 7, 15, 18, 1 }, ratio = 30 },
    { name = "HuyÒn B¨ng tr¶m", item = { 7, 33, 36, 1 }, ratio = 30 },
    { name = "Háa Quang Tr¶m", item = { 7, 34, 37, 1 }, ratio = 30 },
    { name = "To¸i Cèt tÕ", item = { 7, 54, 455, 1 }, ratio = 30 },
    { name = "Bå §Ò chó", item = { 7, 45, 48, 1 }, ratio = 30 },

}

function OnDeath(npcindex)
    local bindPlayerID = GetNpcTask(npcindex, 0)

    local playerLevel = 0
    local nIP = 0
    local addScore = 0
    local array = {}
    local help_num = 1

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        local w, x, y = GetNpcWorldPos(npcindex)

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            local w1, x1, y1 = GetWorldPos()
            if ((bindPlayerID == GetPlayerID()) and (w == w1)) then
                huanxiang(npcindex)

                playerLevel = GetLevel()
                nIP = GetIPValue()
                addScore = addScore + 1
                array[help_num] = GetName()
                help_num = help_num + 1

            end
        end

        PlayerIndex = oldPlayer

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
                        AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Thao ThiÕt ¶o C¶nh <c>, gióp ®ì " .. str .. " ®· khiªu chiÕn qu¸i ¶o C¶nh trong nhiÖm vô Giang S¬n Y Cùu, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. " ®iÓm kinh nghiÖm.", 1)
                        Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa!")
                        WriteLog(GetName() .. "NhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa.")
                    else
                        Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                    end
                else
                    Msg2Player("Do cïng IP nªn kh«ng thÓ nhËn ®iÓm Nh©n NghÜa!")
                end
            end
        end


    else

        if (bindPlayerID == GetPlayerID()) then
            huanxiang(npcindex)
        end

    end

    DelNpc(npcindex)
end

function huanxiang(idx)
    if (GetTaskByte(TASK_JS_BOOK2, 2) == 10) then
        SetTaskByte(TASK_JS_BOOK2, 2, 11)
        FinishNpcCollection(28)

        local bookIdx = math.random(1, 6)
        local class, detail, particular, level = myunpack(CONST_JS_SKILL_BOOK[bookIdx].item)
        ThrowItem(idx, -1, class, detail, particular, level, 0, 0)
        TopMessage("Thao ThiÕt r¬i ra <c=yel>" .. CONST_JS_SKILL_BOOK[bookIdx].name .. "<c>")
        Msg2Player("Chinh phôc ¶o gi¸c Thao ThiÕt thµnh c«ng, nhËn ®­îc ký øc Can ViÔn, Thao ThiÕt r¬i ra" .. CONST_JS_SKILL_BOOK[bookIdx].name .. ", cã thÓ vÒ TriÒu Ca t×m D­ Kh¸nh nhËn th­ëng.")
        TaskNote(1055, 8)

    end
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end
