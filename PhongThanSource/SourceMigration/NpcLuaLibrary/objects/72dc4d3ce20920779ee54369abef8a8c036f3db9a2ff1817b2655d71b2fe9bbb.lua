Task_HelpScore = 1491
SCORE_LIMIT = 100

require("¹ú¼ÒÈËÆø.luax")

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

Value_AblePet = 2071

Task_AblePet = 2072
Break_AblePet = 2073

require("ÊôÐÔÁé³è.luax")

function OnDeath(npcidx)

    AblePetBossTask()

    Sentiment.PubFuncAddSentiment(npcidx, 1)

    WorldBossDeath(npcidx)

    SetGlobalValue(108, -1)

    local i = GetName()
    AddGlobalCountNews("<color=green>" .. i .. "<c> 1 chiªu khuÊt phôc <c=g>NhÞ Lang ThÇn<c>, §µo Hoa ®¶o l¹i ®­îc h­ëng sù thanh b×nh.", 20)
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    local logstr = "[D­¬ng TiÔn][" .. i .. "]¶ÓÓÑ: "
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
            succeed = renwu100(w)
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
            if (GetTask(3) >= 110 or GetTask(1) >= 110 or GetTask(2) >= 110) then
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
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>D­¬ng TiÔn<c>, gióp ®ì " .. str .. " ®· khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 100, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. " ®iÓm kinh nghiÖm.", 1)
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            end
        end

        Throw_Equip(npcidx, PlayerIndex)

    else

        city_shouji(w)
        renwu100(w)

        Throw_Equip(npcidx, PlayerIndex)

        logstr = logstr .. "B¶n th©n "
    end ;

    local NpcMap, Npcx, Npcy = GetNpcWorldPos(npcidx)
    Able_Pet.DropBook(npcidx, NpcMap, Npcx, Npcy)
    WriteLog(logstr)

    DelNpc(npcidx)
end;

TASK_today = 886
task_id = 866
item_id = 171
type_id = 16
item_name = "§Çu NhÞ Lang ThÇn"

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

function renwu100(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        if (taskval1 == 95) or (taskval2 == 95) or (taskval3 == 95) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng D­¬ng TiÔn!")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 96)
                TaskNote(27, 40)
            elseif (pt == 1) then
                SetTask(1, 96)
                TaskNote(28, 44)
            else
                SetTask(2, 96)
                TaskNote(29, 39)
            end ;
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
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID:D­¬ng TiÔn")
end

function AblePetBossTask()
    local OldPlayer = _G.PlayerIndex
    if (GetTeam() > 0) then
        local nPeople = GetTeamSize()
        for i = 1, nPeople do
            _G.PlayerIndex = GetTeamMember(i)
            AblePetBossTaskYes()
        end
    else
        AblePetBossTaskYes()
    end
    _G.PlayerIndex = OldPlayer
end
function AblePetBossTaskYes()
    local level = GetTaskByte(Value_AblePet, 2)
    local step = GetTaskByte(Value_AblePet, 3)
    if (GetTaskByte(Value_AblePet, 1) == 1) then
        if (level == 9 and step == 10 and GetTaskBit(Break_AblePet, 7) == 1) then
            SetTaskBit(Break_AblePet, 2, 1)
            Msg2Player("Hoµn thµnh nhiÖm vô ÁË´ò°ÜD­¬ng TiÔnµÄ, trë vÒ t×m ThÇy T­íng Sè t¹i TriÒu Ca, ®em Hå HØ MÞÖþ»ù.")
            TaskNote(2038, 3)
        end
    end
end

