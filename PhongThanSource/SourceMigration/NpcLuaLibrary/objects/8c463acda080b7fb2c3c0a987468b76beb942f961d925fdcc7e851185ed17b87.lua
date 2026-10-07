Task_HelpScore = 1491
SCORE_LIMIT = 100

YIBO_90_DESASTER_STATE = 1662

YIBO_TIME = 1659

ELEVEN_DAY_BUFF = 1240

require("¹ú¼ÒÈËÆø.luax")

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

require("ÊôÐÔÁé³è.luax")

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx, 1)

    Check_ShituExist(npcidx)

    WorldBossDeath(npcidx)

    SetGlobalValue(106, -1)

    local i = GetName()
    AddGlobalCountNews("<color=green>" .. i .. "<c> 1 ®ao thu phôc <c=g>Bµn Cæ<c>, Khæn Tiªn cung l¹i ®­îc h­ëng sù thanh b×nh.", 20)
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    local logstr = "[Bµn Cæ][" .. i .. "]¶ÓÓÑ: "
    if (GetTeam() ~= 0) then
        local succeed = 0
        local addScore = 0
        local array = {}
        local help_num = 1

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            city_shouji(w)
            succeed = renwu1(w)
            if (succeed == 1) then
                addScore = addScore + 3
                array[help_num] = GetName()
                help_num = help_num + 1
            end
            logstr = logstr .. GetName() .. ","
        end
        PlayerIndex = oldPlayer

        local scoreLimit = GetTaskByte(Task_HelpScore, 3)
        if (addScore > 0) then
            if (GetTask(3) >= 83 or GetTask(1) >= 83 or GetTask(2) >= 83) then
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
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Bµn Cæ<c>, gióp ®ì " .. str .. "Khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 85, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. " ®iÓm kinh nghiÖm.", 1)
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. " nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            end
        end

        Throw_Equip(npcidx, PlayerIndex)

    else

        city_shouji(w)
        renwu1(w)

        Throw_Equip(npcidx, PlayerIndex)

        logstr = logstr .. "B¶n th©n "
    end ;

    local NpcMap, Npcx, Npcy = GetNpcWorldPos(npcidx)
    Able_Pet.DropBook(npcidx, NpcMap, Npcx, Npcy)
    WriteLog(logstr)

    DelNpc(npcidx)
end;

function renwu1(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        if (taskval1 == 81 or taskval1 == 82) or (taskval2 == 81 or taskval2 == 82) or (taskval3 == 81 or taskval3 == 82) then
            local item_count = IsExistItem(4, 175, 0, 1)
            if (item_count < 1) then
                AddNormalItem(4, 175, 0, 0, 0, 0)
                Msg2Player("B¹n nhËn ®­îc Bµn Cæ thÇn khÝ")
                TopMessage(11595)
                return 1
            end
        end
    end
    return 0
end
TASK_today = 886
task_id = 866
item_id = 172
type_id = 17
item_name = "§Çu Bµn Cæ"

function city_shouji(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(task_id)
        local type1 = GetByte(task_val, 1)
        local count1 = GetByte(task_val, 2)
        local type2 = GetByte(task_val, 3)
        local count2 = GetByte(task_val, 4)

        local item_count = IsExistItem(4, item_id, 0, 1)
        if (type1 == type_id) then
            local today = math.floor(LocalSystemTime() / 86400)
            if (today == GetTask(TASK_today)) then
                if (type2 == 0) and (count2 >= 3) then
                    AddNormalItem(4, item_id, 0, 0, 0, 0)
                    item_count = item_count + 1

                    if (item_count < count1) then
                        Msg2Player("Cßn ph¶i thu thËp" .. item_name .. (count1 - item_count) .. ".")
                    else
                        Msg2Player("Thu thËp ®ñ" .. item_name .. ".")
                    end
                    SetTask(task_id, SetByte(task_val, 4, 0))
                else
                    Msg2Player("H«m nay ®· giao cho ng­¬i" .. item_name .. ", ng­¬i ph¶i tiÕp tôc giao nép råi nhËn l¹i míi cã thÓ nhËn ®­îc")
                end
            else
                Msg2Player("NhiÖm vô LÝnh ®¸nh thuª ®· hÕt h¹n")
            end
        end
    end
end

function Check_ShituExist(npcidx)
    local oldPlayer = PlayerIndex
    local nSize = GetTeamSize()
    if (nSize > 0) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (HaveIBBuff(ELEVEN_DAY_BUFF) > 0 and GetTaskByte(YIBO_90_DESASTER_STATE, 1) == 1) then
                if (IsMantlePrentice(PlayerIndex) > 0 and IsPlayerInDeath() == 0) then
                    local masterIdx = Check_MasterIdx(PlayerIndex)
                    if (masterIdx > 0) then
                        local bDis = Check_Distance(PlayerIndex, masterIdx, npcidx)
                        if (bDis > 0) then
                            SetTaskByte(YIBO_DESASTER_STATE, 1, 2)
                            Msg2Player("Chóc mõng b¹n ®· v­ît qua ®­îc kiÕp n¹n, mau vÒ phôc mÖnh Nhiªn §¨ng §¹o Nh©n!")
                            TaskNote(1517, 1)
                            SetTaskWord(YIBO_TIME, 1, 0)
                            RemoveIBBuff(ELEVEN_DAY_BUFF)
                            PlayerIndex = masterIdx
                            SetTaskWord(YIBO_TIME, 1, 0)
                            SetTaskByte(YIBO_DESASTER_STATE, 1, 2)
                            Msg2Player("Chóc mõng b¹n ®· hç trî ®å ®Ö v­ît qua ®­îc kiÕp n¹n, mau vÒ phôc mÖnh Nhiªn §¨ng §¹o Nh©n!")
                        else
                            PlayerIndex = masterIdx
                            Msg2Player("B¹n vµ Y B¸t ®Ö tö cña b¹n c¸ch nhau qu¸ xa, kh«ng thÓ gióp ®Ö tö §é KiÕp!")
                            PlayerIndex = GetTeamMember(i)
                            Msg2Player("B¹n vµ Y B¸t S­ Phô cña m×nh c¸ch nhau qu¸ xa, kh«ng thÓ hoµn thµnh §é KiÕp!")
                        end
                    end
                end
            end
        end
    end
    PlayerIndex = oldPlayer
    return 0
end

function Check_MasterIdx(playerIdx)
    local nSize = GetTeamSize()
    local strMasterName = GetMantleMasterName()
    local selfIdx = PlayerIndex
    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if (strMasterName == GetName()) then
            PlayerIndex = selfIdx
            return 1
        end
    end
    return 0
end

function Check_Distance(playerIdx1, playerIdx2, npcidx)
    local nMapid, nX, nY = GetNpcWorldPos(npcidx)
    local selfIdx = PlayerIndex
    PlayerIndex = playerIdx1
    local pMapid1, pX1, pY1 = GetWorldPos()
    PlayerIndex = playerIdx2
    local pMapid2, pX2, pY2 = GetWorldPos()
    PlayerIndex = selfIdx
    if (pMapid1 == nMapid and pMapid2 == nMapid) then
        if (((nX - pX1) ^ 2 + (nY - pY1) ^ 2) < 500) and (((nX - pX2) ^ 2 + (nY - pY2) ^ 2) < 1000) then
            return 1
        end
    end
    return 0
end

function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 2
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do

        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)

        if (math.random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID:Bµn Cæ")
end
