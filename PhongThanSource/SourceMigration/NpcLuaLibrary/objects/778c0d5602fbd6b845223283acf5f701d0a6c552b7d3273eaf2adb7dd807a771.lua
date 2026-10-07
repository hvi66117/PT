Task_HelpScore = 1491
SCORE_LIMIT = 100

Task_LongAgo = 1529

require("¹ú¼ÒÈËÆø.luax")

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

require("ÊôĞÔÁé³è.luax")
TaskTable_NewAllPet = Able_Pet.TaskTable_NewAllPet

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

    AblePetBossTask()

    Sentiment.PubFuncAddSentiment(npcidx, 2)

    WorldBossDeath(npcidx)

    SetGlobalValue(109, 0)
    local i = GetName()
    AddGlobalCountNews("H¬i thë cña <c=g>Giao Long<c> ®· t¾t, thñ cÊp treo trªn vò khİ cña <c=g>" .. i .. "<c>.", 20)

    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    if (GetTeam() ~= 0) then
        local succeed = 0
        local addScore = 0
        local array = {}
        local help_num = 1

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            succeed = renwu110(w)
            if (succeed == 1) then
                addScore = addScore + 3
                array[help_num] = GetName()
                help_num = help_num + 1
            end
        end
        PlayerIndex = oldPlayer

        local scoreLimit = GetTaskByte(Task_HelpScore, 3)
        if (addScore > 0) then
            if (GetTask(3) >= 123 or GetTask(1) >= 123 or GetTask(2) >= 123) then
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
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Giao Long<c>, gióp ®ì " .. str .. "Khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 110, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. " ®iÓm kinh nghiÖm.", 1)
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc " .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            end
        end

        Throw_Equip(npcidx, PlayerIndex)

    else


        renwu110(w)

        Throw_Equip(npcidx, PlayerIndex)

    end ;

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 1)
        WriteLog("S¸ng lËp mét sù kiÖn thÕ giíi")
    else
        local prog = GetWorldEventProgress(1)
        if (prog < 3) then
            beginWorldevent()
        elseif (prog == 5) then
            if (GetTaskByte(1296, 1) >= 1) then
                beginWorldevent()
            else
                WriteLog("Ng­¬i ch­a b¸o danh s¸t Rång")
            end
        end
    end
    DelNpc(npcidx)
end;

function renwu110(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        local pt = GetPlayerType()
        if (taskval1 == 115) or (taskval2 == 115) or (taskval3 == 115) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")

            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 116)
                TaskNote(27, 45)
            elseif (pt == 1) then
                SetTask(1, 116)
                TaskNote(28, 49)
            else
                SetTask(2, 116)
                TaskNote(29, 44)
            end ;
            return 1
        elseif (taskval1 == 117) or (taskval2 == 117) or (taskval3 == 117) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 118)
                TaskNote(27, 47)
            elseif (pt == 1) then
                SetTask(1, 118)
                TaskNote(28, 51)
            else
                SetTask(2, 118)
                TaskNote(29, 46)
            end ;
            return 1
        elseif (GetTaskByte(Task_LongAgo, 2) == 2) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            SetTaskByte(Task_LongAgo, 2, 3)

            if (GetTaskByte(Task_LongAgo, 1) == 1) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 45)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 49)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 44)
                end
            elseif (GetTaskByte(Task_LongAgo, 1) == 2) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 47)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 51)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 46)
                end
            end
            return 1
        end
    end
    return 0
end

function beginWorldevent()
    local today = math.floor(LocalSystemTime() / 86400)
    SetWorldEventValue(1, 1, today)
end

function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 4
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do

        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)

        if (math.random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bŞ cam cao cÊp: rít trang bŞ tr¾ng" .. nFlag .. ",npcID:Giao Long")
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
    if (GetTaskByte(NeZha_Pet, 1) == 1) then
        local level = GetTaskByte(NeZha_Pet, 2)
        local step = GetTaskByte(NeZha_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_NeZhaPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÖúNa TraÔÙ»¯ÎªÈË.")
            TaskNote(2040, 1)
        end
    end
    if (GetTaskByte(LeiZhenZi_Pet, 1) == 1) then
        local level = GetTaskByte(LeiZhenZi_Pet, 2)
        local step = GetTaskByte(LeiZhenZi_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_LeiZhenZiPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÖúÀ×Õğ×ÓÔÙ»¯ÎªÈË.")
            TaskNote(2048, 1)
        end
    end
    if (GetTaskByte(ShiJi_Pet, 1) == 1) then
        local level = GetTaskByte(ShiJi_Pet, 2)
        local step = GetTaskByte(ShiJi_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_ShiJiPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÌáÉıTh¹ch C¬µÄ·¨Á¦.")
            TaskNote(2052, 1)
        end
    end
    if (GetTaskByte(TaiYi_Pet, 1) == 1) then
        local level = GetTaskByte(TaiYi_Pet, 2)
        local step = GetTaskByte(TaiYi_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_TaiYiPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÌáÉıTh¸i Êt Ch©n Nh©nµÄ·¨Á¦.")
            TaskNote(2056, 1)
        end
    end
    if (GetTaskByte(DaJi_Pet, 1) == 1) then
        local level = GetTaskByte(DaJi_Pet, 2)
        local step = GetTaskByte(DaJi_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_DaJiPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÌáÉı§¸t KûµÄ·¨Á¦.")
            TaskNote(2060, 1)
        end
    end
    if (GetTaskByte(ShenGongBao_Pet, 1) == 1) then
        local level = GetTaskByte(ShenGongBao_Pet, 2)
        local step = GetTaskByte(ShenGongBao_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_ShenGongBaoPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÌáTh©n C«ng B¸oµÄ·¨Á¦.")
            TaskNote(2064, 1)
        end
    end
    if (GetTaskByte(HuangFeiHu_Pet, 1) == 1) then
        local level = GetTaskByte(HuangFeiHu_Pet, 2)
        local step = GetTaskByte(HuangFeiHu_Pet, 3)
        if (level == 3 and step == 4) then
            SetTaskBit(Break_HuangFeiHuPet, 1, 1)
            Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«ÌáHoµng Phi HæµÄ·¨Á¦.")
            TaskNote(2068, 1)
        end
    end

    local petTaskList = {}
    for i = 1, #TaskTable_NewAllPet do
        petTaskList = TaskTable_NewAllPet[i].taskvalue
        if (GetTaskByte(petTaskList[1], 1) == 1) then
            if (GetTaskByte(petTaskList[1], 2) == 3 and GetTaskByte(petTaskList[1], 3) == 4) then
                SetTaskBit(petTaskList[3], 1, 1)
                Msg2Player("Ç°Íù<c=g>TriÒu CaËãÃüÏÈÉú<c>´¦, Ëû½«Ìá" .. TaskTable_NewAllPet[i].petname .. "_Ph¸p lùc.")
                TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[2], 1)
                break
            end
        end
    end

end

