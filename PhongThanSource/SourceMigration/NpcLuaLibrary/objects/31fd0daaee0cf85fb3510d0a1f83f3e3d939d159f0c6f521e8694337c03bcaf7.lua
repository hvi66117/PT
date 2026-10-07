TASK_JIANGSHAN = 1426
TASK_JIANGSHAN_PAGE5_STATUS = 1438
TASK_INFO_JIANGSHAN_PAGE5 = 1058
Task_Info_JIANGSHAN_IDOLUM = 1055

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

    SetGlobalValue(107, -1)

    local i = GetName()
    AddGlobalCountNews("<color=green>" .. i .. "<c> mét ®ao kÕt liÔu <c=g>§¹i §iªu<c>, BÝch Du cung l¹i ®­îc h­ëng thanh b×nh.", 20)
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    local logstr = "[§¹i §iªu][" .. i .. "]¶ÓÓÑ: "
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            logstr = logstr .. GetName() .. ","
            city_shouji(w)
        end
        PlayerIndex = oldPlayer
    else

        logstr = logstr .. "B¶n th©n "
        city_shouji(w)
    end ;

    local nMap, nX, nY = GetWorldPos()
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            nMap1, nX1, nY1 = GetWorldPos()
            if (PlayerIndex > 0 and nMap == nMap1) then
                killdapeng()
            end
            PlayerIndex = oldPlayer
        end
    else
        killdapeng()
    end

    Throw_Equip(npcidx, PlayerIndex)

    local NpcMap, Npcx, Npcy = GetNpcWorldPos(npcidx)
    Able_Pet.DropBook(npcidx, NpcMap, Npcx, Npcy)
    WriteLog(logstr)

    DelNpc(npcidx)
end;

TASK_today = 886
task_id = 866
item_id = 170
type_id = 15
item_name = "§Çu §¹i §iªu"

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
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID: §¹i Bµng")
end

function killdapeng()
    if (GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4) == 101 and
            GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3) == 1 and

            GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 2) == 1) then

        RemoveIBBuff(663)
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3, 2)
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4, 16)

        TopMessage("B¹n tiªu diÖt thµnh c«ng <c=g>§¹i §iªu<c>")
        Msg2Player("B¹n tiªu diÖt thµnh c«ng §¹i §iªu")
        FinishNpcCollection(30)
        TopMessage("<c=g>nhiÖm vô hoµn thµnh<c>")

        TaskNote(Task_Info_JIANGSHAN_IDOLUM, 15)
    end
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
    if (GetTaskByte(Value_AblePet, 1) == 1) then
        local level = GetTaskByte(Value_AblePet, 2)
        local step = GetTaskByte(Value_AblePet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_AblePet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, ®em Hå HØ MÞÖþ»ù.")
            TaskNote(2036, 1)
        end
    end
end

