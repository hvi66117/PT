require("¹ú¼ÒÈËÆø.luax")

require("ÊôÐÔÁé³è.luax")

require("¼×¹ÇÎÄ»î¶¯.luax")

require("ÐÂ·þ»î¶¯.luax")

YIBO_TIME = 1659

YIBO_80_DESASTER_STATE = 1661

SEVEN_DAY_BUFF = 1239

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

TaskTable_NewAllPet = Able_Pet.TaskTable_NewAllPet

Value_AblePet = 2071

Task_AblePet = 2072
Break_AblePet = 2073

NeZha_Pet = 2078

Task_NeZhaPet = 2079
Break_NeZhaPet = 2080

LeiZhenZi_Pet = 2091

Task_LeiZhenZiPet = 2092
Break_LeiZhenZiPet = 2093

ShiJi_Pet = 2106

Task_ShiJiPet = 2107
Break_ShiJiPet = 2108

TaiYi_Pet = 2114

Task_TaiYiPet = 2115
Break_TaiYiPet = 2116

DaJi_Pet = 2117

Task_DaJiPet = 2118
Break_DaJiPet = 2119

ShenGongBao_Pet = 2120

Task_ShenGongBaoPet = 2121
Break_ShenGongBaoPet = 2122

HuangFeiHu_Pet = 2123

Task_HuangFeiHuPet = 2124
Break_HuangFeiHuPet = 2125

function OnDeath(npcidx)
    OracleAct()

    AblePetBossTask()

    Sentiment.PubFuncAddSentiment(npcidx, 1)

    if (GetGlobalValue(155) > 0) then
        DelNpc(GetGlobalValue(155))
        SetGlobalValue(155, 0)
    end

    Check_ShituExist(npcidx)

    WorldBossDeath(npcidx)

    SetGlobalValue(105, -1)
    AddNormalItem(3, 123, 0, 0, 0, 1)
    Msg2Player("B¹n nhËn ®­îc §µo C¬!")
    local i = GetName()
    local j = GetLevel()
    if (j <= 90) then
        AddGlobalCountNews("Dòng sÜ <c=g>" .. i .. "<c> mét kiÕm h¹ s¸t <c=g>§µo Ngét<c>, nh©n gian l¹i ®­îc h­ëng sù thanh b×nh.", 20)
    end ;
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            city_shouji(w)
        end
        PlayerIndex = oldPlayer
    else
        city_shouji(w)
    end ;

    local bossItemId = 1109
    local bossBuffId = 1659
    local bossItemName = "M¶nh §µo Ngét Hån"
    local nGetPlayer = 0
    local nBuffCount = 0
    local AddBuffTimes = 0
    local mapid, xpos, ypos = GetNpcWorldPos(npcidx)
    local mapidx = SubWorldID2Idx(mapid)
    local nPlayerCount = GetSubWorldPlayerCount(mapidx)
    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, i)
        if (PlayerIndex > 0) then
            local nWordID, nX, nY = GetWorldPos()
            if (nWordID == mapid) and (math.sqrt((nX - xpos) ^ 2 + (nY - ypos) ^ 2) * 32 <= 800) then
                nGetPlayer = nGetPlayer + 1
                local nIBBuffCount = GetIBBuffTimes(bossBuffId)
                if (nIBBuffCount > 0) then
                    nBuffCount = nBuffCount + nIBBuffCount
                    AddBuffTimes = nIBBuffCount * 6
                    for i = 1, nIBBuffCount do
                        local nRand = math.random(1, 100)
                        if (nRand <= 10) then
                            AddBuffTimes = AddBuffTimes + 2
                        elseif (nRand <= 60) then
                            AddBuffTimes = AddBuffTimes + 1
                        end
                    end
                    for i = 1, AddBuffTimes do
                        AddNormalItemPile(6, 1, bossItemId, 1, 0, 0)
                    end
                    local nRand = math.random(1, 10000)
                    if (nRand < 20 and GetGlobalStoreValueByte(8, 4) < 2) then
                        AddNormalItem(3, 123, 0, 0, 0, 1)
                        SetGlobalStoreValueByte(8, 4, GetGlobalStoreValueByte(8, 4) + 1, 1)
                        local str = "<bc=r><RoleName=\"" .. GetName() .. "\">ThËt may m¾n! Trong tr¹ng th¸i B¨ng Phong Háa PhÖ nhËn thªm 1  hån §µo Ngét"
                        Msg2CurMapAnnounce(str)
                        AddGlobalNews(str)
                        if (IsTongMember() > 0) then
                            Msg2TongMemberByTongName(str)
                        end
                    end

                    RemoveIBBuff(bossBuffId)
                    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. AddBuffTimes .. "." .. bossItemName .. ".")
                    WriteLog("[M¶nh ®Çu TiÓu Tø][§¸nh b¹i BOSS][nhËn" .. bossItemName .. "][" .. nIBBuffCount .. "]")
                end
            end
        end
    end
    PlayerIndex = oldPlayer
    WriteLog("[Sè l­îng ng­êi ch¬i" .. nGetPlayer .. "][Sè l­îng BUFF" .. nBuffCount .. "]")
    nGetPlayer = 0
    nBuffCount = 0

    AddGiftItem(npcidx)

    DelNpc(npcidx)


end;

function Check_ShituExist(npcidx)
    local oldPlayer = PlayerIndex
    local nSize = GetTeamSize()
    if (nSize > 0) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(YIBO_80_DESASTER_STATE, 2) == 4) then
                if (IsMantlePrentice(PlayerIndex) > 0 and IsPlayerInDeath() == 0) then
                    local masterIdx = Check_MasterIdx()
                    if (masterIdx > 0) then
                        local bDis = Check_Distance(PlayerIndex, masterIdx, npcidx)
                        if (bDis > 0) then
                            if (HaveIBBuff(SEVEN_DAY_BUFF) == 0 and GetTaskByte(YIBO_80_DESASTER_STATE, 1) == 1) then
                                Msg2Player("B¹n kh«ng hoµn thµnh §é KiÕp trong thêi gian h¹n ®Þnh!")
                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 3)
                            else
                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 2)
                                SetTaskWord(YIBO_TIME, 1, 0)
                                Msg2Player("Chóc mõng b¹n ®· v­ît qua ®­îc kiÕp n¹n, h·y vÒ phôc mÖnh ThÇy t­íng sè!")
                                TaskNote(1516, 1)
                                RemoveIBBuff(SEVEN_DAY_BUFF)
                                PlayerIndex = masterIdx

                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 2)
                                SetTaskWord(YIBO_TIME, 1, 0)
                                Msg2Player("Chóc mõng b¹n ®· hç trî ®å ®Ö v­ît qua ®­îc kiÕp n¹n, h·y vÒ phôc mÖnh ThÇy t­íng sè!")
                            end
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

function Check_MasterIdx()
    local nSize = GetTeamSize()
    local strMasterName = GetMantleMasterName()
    local selfIdx = PlayerIndex
    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if (strMasterName == GetName()) then
            PlayerIndex = selfIdx
            return GetTeamMember(i)
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

TASK_today = 886
task_id = 864
item_id = 166
type_id = 11
item_name = "§Çu §µo Ngét"

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
                if (type2 == 0) and (count2 == 3) then
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

function AddGiftItem(npcidx)

    if not (NewServer.Pub_IsNewServerOpen() > 0) then
        return
    end
    local oldPlayer = PlayerIndex

    local mapid, xpos, ypos = GetNpcWorldPos(npcidx)
    local mapidx = SubWorldID2Idx(mapid)
    local nPlayerCount = GetSubWorldPlayerCount(mapidx)
    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, i)
        if (PlayerIndex > 0) then
            local nWordID, nX, nY = GetWorldPos()
            if (nWordID == mapid) and (math.sqrt((nX - xpos) ^ 2 + (nY - ypos) ^ 2) * 32 <= 600) then
                AddPlayerGift()
            end
        end
    end

    PlayerIndex = oldPlayer
end

function AddPlayerGift()

    if not (GetTaskBit(2028, 22) == 0) then
        return
    end
    if (math.random(1, 100) <= 10) then
        SetTaskBit(2028, 22, 1)
        AddNormalItemBind(6, 1, 1289, 1, 0, 0, 1)
        TopMessage("NhËn ®­îc <c=g>HuyÒn Vò Tµn Ph¸ch-BÝch<c>")
        Msg2Player("NhËn ®­îc HuyÒn Vò Tµn Ph¸ch-BÝch")
        WriteLog("[NhËn ®­îc HuyÒn Vò Tµn Ph¸ch-BÝch kho¸]")
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
        if (level == 6 and step == 7) then
            SetTaskBit(Break_AblePet, 3, 1)
            local str = Able_Pet.Check4boss()
            if (str == "") then
                TaskNote(2037, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2037, 0, str)
            end
        end
    end
    if (GetTaskByte(NeZha_Pet, 1) == 1) then
        local level = GetTaskByte(NeZha_Pet, 2)
        local step = GetTaskByte(NeZha_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_NeZhaPet, 3, 1)
            local str = Able_Pet.Check4boss_1()
            if (str == "") then
                TaskNote(2041, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2041, 0, str)
            end
        end
    end
    if (GetTaskByte(LeiZhenZi_Pet, 1) == 1) then
        local level = GetTaskByte(LeiZhenZi_Pet, 2)
        local step = GetTaskByte(LeiZhenZi_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_LeiZhenZiPet, 3, 1)
            local str = Able_Pet.Check4boss_2()
            if (str == "") then
                TaskNote(2049, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2049, 0, str)
            end
        end
    end
    if (GetTaskByte(ShiJi_Pet, 1) == 1) then
        local level = GetTaskByte(ShiJi_Pet, 2)
        local step = GetTaskByte(ShiJi_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_ShiJiPet, 3, 1)
            local str = Able_Pet.Check4boss_3()
            if (str == "") then
                TaskNote(2053, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2053, 0, str)
            end
        end
    end
    if (GetTaskByte(TaiYi_Pet, 1) == 1) then
        local level = GetTaskByte(TaiYi_Pet, 2)
        local step = GetTaskByte(TaiYi_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_TaiYiPet, 3, 1)
            local str = Able_Pet.Check4boss_4()
            if (str == "") then
                TaskNote(2057, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2057, 0, str)
            end
        end
    end
    if (GetTaskByte(DaJi_Pet, 1) == 1) then
        local level = GetTaskByte(DaJi_Pet, 2)
        local step = GetTaskByte(DaJi_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_DaJiPet, 3, 1)
            local str = Able_Pet.Check4boss_5()
            if (str == "") then
                TaskNote(2061, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2061, 0, str)
            end
        end
    end
    if (GetTaskByte(ShenGongBao_Pet, 1) == 1) then
        local level = GetTaskByte(ShenGongBao_Pet, 2)
        local step = GetTaskByte(ShenGongBao_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_ShenGongBaoPet, 3, 1)
            local str = Able_Pet.Check4boss_6()
            if (str == "") then
                TaskNote(2065, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2065, 0, str)
            end
        end
    end
    if (GetTaskByte(HuangFeiHu_Pet, 1) == 1) then
        local level = GetTaskByte(HuangFeiHu_Pet, 2)
        local step = GetTaskByte(HuangFeiHu_Pet, 3)
        if (level == 6 and step == 7) then
            SetTaskBit(Break_HuangFeiHuPet, 3, 1)
            local str = Able_Pet.Check4boss_7()
            if (str == "") then
                TaskNote(2069, 1)
            else
                Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                TaskNote(2069, 0, str)
            end
        end
    end

    local petTaskList = {}
    local str = ""
    for i = 1, #TaskTable_NewAllPet do
        petTaskList = TaskTable_NewAllPet[i].taskvalue
        if (GetTaskByte(petTaskList[1], 1) == 1) then
            if (GetTaskByte(petTaskList[1], 2) == 6 and GetTaskByte(petTaskList[1], 3) == 7) then
                SetTaskBit(petTaskList[3], 3, 1)
                Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«Ìá" .. TaskTable_NewAllPet[i].petname .. "_Ph¸p lùc.")
                str = Able_Pet.Check4boss_NewAllPet(i)
                if (str == "") then
                    TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[3], 1)
                else
                    Msg2Player("Hoµn thµnh nhiÖm vô ÁË—ƒè»µÄÏûÃð.")
                    TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[3], 0, str)
                end
                break
            end
        end
    end

end

function OracleAct()
    ORACLEBONE.GetCardWayApply(22, 0)
    ORACLEBONE.GetCardWayApply(23, 0)
    ORACLEBONE.GetCardWayApply(24, 24)
end

