require("¸£Àû»î¶¯Ä£°å.luax")

require("ÊôÐÔÁé³è.luax")

require("Éñ½«ÏµÍ³.luax")
G_SUPERMANTASK_TYPE = 1
G_SUPERMANTASK_ID = 5

Task_Divination = 1375

Task_Label_Type = 1376
Buff_Make_Drug = 636
Buff_Add_Life = 635
Buff_Polymorph = 404
Buff_Plutus = 228
Task_Num = 1039

ballID = 1570

Task_lingchong = 1395

KindPet_FeedTime = 1573

item_petLasttime = 1164

TaskTimes = {
    [1] = { totalTimes = 620, awardsTimes = 5, },
    [2] = { totalTimes = 380, awardsTimes = 4, },
    [3] = { totalTimes = 260, awardsTimes = 3, },
    [4] = { totalTimes = 200, awardsTimes = 2, },
    [5] = { totalTimes = 170, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1696
G_Double = 370

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

Task_Yiqi = 1532

YIBO_80_DESASTER_STATE = 1661

YIBO_CREATE_TIME = 1659
Task_EggTime = 1668

SEVEN_DAY_BUFF = 1239

MonsterEgg = { name = "Trøng Th«ng Linh", Item = { 6, 1, 793, 1, 0, 0 } }
Shien = { name = "S­ ¢n LÖnh", Item = { 3, 1088, 0, 0, 0, 0 } }
BossInfo = {
    [2] = { name = "Cïng Kú", id = 87 },
    [4] = { name = "§µo Ngét", id = 88 },
    [3] = { name = "Thao ThiÕt", id = 89 },
    [1] = { name = "Hçn §én", id = 90 },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 24
    if (GetLevel() >= startLevel) and (GetTaskBit(1377, 2) == 1) then
        local taskProcess = GetTaskByte(Task_Wedlock, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 27
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Divination, 1)
        if (GetLevel() - startLevel <= 5) then
            if (step == 1) then
                state = 3
                subState = 0
            elseif (step == 5 and HaveEventItem(232) > 0) then
                state = 3
                subState = 0
            elseif (step >= 2 and step <= 5) then
                state = 2
                subState = 0
            end
        else
            if (step == 1) then
                state = 3
                subState = 1
            elseif (step == 5 and HaveEventItem(232) > 0) then
                state = 3
                subState = 1
            elseif (step >= 2 and step <= 5) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 39
    if (GetLevel() >= startLevel) then
        local UTask_xq_1 = GetTask(51)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_xq_1 == 1) then
                state = 3
                subState = 0
            end
        else
            if (UTask_xq_1 == 1) then
                state = 3
                subState = 1
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 65
    if (GetLevel() >= startLevel) then
        local key = tongguanjiangli()
        local temp = GetTaskByte(1021, 2) + 1
        local times, addtimes = todayfreetimes(temp)
        local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        local alltimes = GetTaskByte(1477, 3)
        if (GetLevel() - startLevel <= 5) then
            if (key == 0 and thisday ~= lastday) then
                state = 1
                subState = 0
            elseif (key == 2 and times == 1) then
                state = 3
                subState = 0
            elseif (key == 1 and times == 1) then
                state = 2
                subState = 0
            end
        else
            if (key == 0 and thisday ~= lastday) then
                state = 1
                subState = 1
            elseif (key == 2 and times == 1) then
                state = 3
                subState = 1
            elseif (key == 1 and times == 1) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 73
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 1) then
                state = 1
                subState = 0
            end
        else
            if (taskStatus == 1) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 30
    if (GetLevel() >= startLevel) then
        local task = GetTaskByte(Task_PetEvolve, 1)
        if (PetIsAdd() > 0 and PetGetSpirit() >= 300 and task == 0) then
            state = 1
            subState = 0
        elseif (HaveNormalItem(3, 546, 0, 0) <= 0 and HaveNormalItem(3, 548, 0, 0) <= 0 and HaveNormalItem(3, 550, 0, 0) <= 0 and HaveNormalItem(3, 552, 0, 0) <= 0 and task == 1) then
            state = 2
            substate = 0
        elseif ((HaveNormalItem(3, 546, 0, 0) > 0 or HaveNormalItem(3, 548, 0, 0) > 0 or HaveNormalItem(3, 550, 0, 0) > 0 or HaveNormalItem(3, 552, 0, 0) > 0) and task == 1) then
            state = 3
            substate = 0
        end
        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, substate)
end

require("themeday_human.luax")

function main()
    local tasks = {
        { "Phi Tiªn", "renwu1"; show = 0 },
        { "Tø Linh", "sixiang"; show = 0 },
        { "MËt LÖnh", "processLeakOrder"; show = 0 },
        { "<c=yel>VÊn MÖnh Chi Thiªm<c>", "divination"; show = 0 },
        { "L­¬ng Duyªn", "wedlock"; show = 0 },
        { "KiÕp DiÖt Th©n", "Do_DesaterTask"; show = 0 },
        { "KiÕp DiÖt Th©n", "Do_DesaterOver"; show = 0 },

        { "TÞnh Hãa Linh thó", "NewPet"; show = 1 },


        { "§æi mµu Linh thó", "ChangePetColor"; show = 1 },

    }
    UTask_xq_1 = GetTask(51);
    if (UTask_xq_1 == 1) then
        tasks[1].show = 1;
    end ;

    if (GetLevel() >= 65) then
        tasks[2].show = 1;


    end ;

    if (isViewLeakOrder() == 1) then
        tasks[3].show = 1;
    end ;

    if (GetTaskByte(Task_Divination, 1) > 0 and GetTaskByte(Task_Divination, 1) < 7) then
        tasks[4].show = 1
    end

    if (isViewWedlock() > 0) then
        tasks[5].show = 1
    end

    local nLevel = GetLevel()
    local state = GetTaskByte(YIBO_80_DESASTER_STATE, 1)
    local bGetReward = GetTaskByte(YIBO_80_DESASTER_STATE, 3)
    if (state <= 1 and HaveIBBuff(SEVEN_DAY_BUFF) > 0) then
        tasks[6].show = 1
    elseif (state == 2 and bGetReward == 0) then
        tasks[7].show = 1
    end
    SayTask(14699, tasks)
end;

function ChangePetColor()
    CloseDialog()

    if (GetPlayerVipLevel() < 2) then
        MsgBox("Khi x­a ta ngao du thiªn h¹ gÆp ®­îc mét ®¹o tr­ëng thÇn bÝ, nãi r»ng biÕt c¸ch thay ®æi mµu s¾c Linh thó, ta tèn rÊt nhiÒu c«ng søc míi häc ®­îc ph­¬ng ph¸p ®ã. TiÓu huynh ®Ö muèn thay ®æi mµu s¾c cho Linh thó? Nh­ng cÇn ph¶i cã 1 <c=yel>BiÕn S¾c Hoµn hoÆc 900 Th«ng B¶o<c> míi ®­îc.", "Yes_Change", "no")
    else
        MsgBox("Bèi To¸n Tiªn Sinh: Ngµy tr­íc ta ngao du thiªn h¹, gÆp 1 ®¹o sÜ thÇn bÝ, nãi lµ biÕt thuËt biÕn mµu thó c­ng, ta bá c«ng søc häc ®­îc thuËt nµy, tiÓu tö ng­¬i muèn biÕn mµu thó c­ng ph¶i kh«ng?", "Yes_Change", "no")
    end


end

function Yes_Change()
    CloseDialog()
    OpenPetColorWnd()
end

function CallChangePetColorFuc(nHue, nAlpha)
    SetTaskWord(140, 1, nHue)
    SetTaskByte(140, 3, nAlpha)
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(151)

    if (GetPlayerVipLevel() < 2) then
        MsgBox("§ång ý tiÕn hµnh thay ®æi mµu s¾c cho Linh thó? Ng­¬i ph¶i ®­a cho ta 1 <c=yel>" .. costName .. "<c> hoÆc <c=yel>" .. costDisNum .. " Th«ng B¶o<c>.", "Yes_ChangeColor", "no")
    else
        MsgBox("Bèi To¸n Tiªn Sinh: §ång ý biÕn mµu cho thó c­ng kh«ng?", "Yes_ChangeColor", "no")
    end


end

function Yes_ChangeColor()
    CloseDialog()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(151)

    if (HaveNormalItem(8, 1348, 2, 0) <= 0 and GetCoin() < costIBNum and GetPlayerVipLevel() < 2) then
        Msg2Player("Kh«ng ®ñ Th«ng B¶o!")
        Talk(1, "no", "Kh«ng ®ñ Th«ng B¶o.")
        return
    end

    if (HaveNormalItem(8, 1348, 2, 0) > 0 and GetPlayerVipLevel() < 2) then
        DelNormalItem(8, 1348, 2, 0)
    elseif (GetCoin() < costIBNum and GetPlayerVipLevel() < 2) then
        CostCoinByIdx(151)
    end

    local nHue = GetTaskWord(140, 1)
    local nAlpha = GetTaskByte(140, 3)
    SetPetColor(nHue, nAlpha)

    Talk(1, "no", "Chóc mõng, Linh thó ®· ®æi mµu thµnh c«ng.")
end

function Get_TeamState()
    if (GetTeamSize() == 2) then
        local mateIdx = 0
        local selfIdx = PlayerIndex
        if (IsCaptain() == 0) then
            mateIdx = GetTeamMember(1)
        else
            mateIdx = GetTeamMember(2)
        end
        local str = GetMantleMasterName()
        PlayerIndex = mateIdx
        local mateName = GetName()
        PlayerIndex = selfIdx
        if (mateName == str) then
            return 1
        else
            return 0
        end
    end
    return 0
end

function Do_DesaterOver()
    CloseDialog()
    local str = ""
    if (IsMantleMaster(PlayerIndex) > 0) then
        str = "Ng­¬i ®· gióp ®å ®Ö v­ît qua kiÕp n¹n, cã muèn nhËn th­ëng ngay b©y giê?"
    else
        str = "Ng­¬i ®· v­ît qua kiÕp n¹n, cã muèn nhËn th­ëng ngay b©y giê?"
    end
    MsgBox(str, "Get_Rewoards", "no")
end

function Get_Rewoards()
    CloseDialog()
    if (IsMantleMaster(PlayerIndex) > 0) then
        local item = Shien.Item
        AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
        local addPRValue = AddMasterPRValue(5)
        ModifyFactionGlory(15)
        TopMessage("Chóc mõng b¹n bÊt ngê nhËn ®­îc 1 <color=green>S­ ¢n LÖnh<c> vµ <color=green>" .. addPRValue .. "<c> ®iÓm S­ ®å")

    else
        local item = MonsterEgg.Item
        for i = 0, 3 do
            ClearItem(item[1], item[2] + i, item[3], item[4])
        end

        AddOwnExp(300000)
        TaskNote(1516, -1)
        Msg2Player("V­ît qua kiÕp n¹n, b¹n nhËn ®­îc 300000 kinh nghiÖm")
    end
    SetTaskByte(YIBO_80_DESASTER_STATE, 3, 1)
end

function Do_DesaterTask()
    CloseDialog()
    local nState = GetTaskByte(YIBO_80_DESASTER_STATE, 1)
    if (HaveIBBuff(SEVEN_DAY_BUFF) > 0 and IsMantlePrentice(PlayerIndex) > 0) then
        if (nState == 0) then
            local tState = Get_TeamState()
            if (tState == 1) then
                local nType = math.random(1, 4)
                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 1)
                Msg2Team("§¸nh b¹i<c=red>" .. BossInfo[nType].name .. "<c>, tho¸t khái kiÕp n¹n!")
                SetTaskByte(YIBO_80_DESASTER_STATE, 2, nType)
                TaskNote(1516, 0, BossInfo[nType].name)
                Talk(2, "no", "Sau khi ®iÒu tra râ, lµ <c=red>" .. BossInfo[nType].name .. "<c>Ma V­¬ng tÝnh sÏ diÖt trõ anh hïng tr­íc khi anh hïng tu luyÖn thµnh c«ng ®Ó trõ hËu ho¹n. Søc m¹nh cña anh hïng hiÖn ch­a thÓ ®èi ®Þch víi Ma V­¬ng, ph¶i cÇn ®Õn sù gióp ®ì cña Y B¸t S­ Phô. §©y lµ thö th¸ch mµ «ng trêi giµnh cho 2 ng­êi xem cã thËt sù ®ång lßng víi nhau kh«ng", "Hai ng­êi hµng phôc Ma V­¬ng sÏ v­ît qua kiÕp n¹n nµy, ta cã 1 Trøng Th«ng Linh, cã thÓ t¹o thµnh hãa th©n Ma V­¬ng. Anh hïng hµng phôc hãa th©n nµy cã thÓ xãa bá ý ®Þnh cña Ma V­¬ng.")
                return
            else
                InfoBox("H·y tæ ®éi cïng Y B¸t S­ Phô ®Õn nhËn nhiÖm vô!")
            end
        elseif (nState == 1) then
            local tasks = {
                { "NhËn Trøng Th«ng Linh", "Get_MonsterEgg"; show = 1 }
            }
            SayTask("Trøng Th«ng Linh cã thÓ t¹o thµnh hãa th©n Ma V­¬ng, dïng Tiªn Lé t­íi vµo 3 lÇn sÏ lËp tøc cho ra hãa th©n Ma V­¬ng.", tasks)
        end
    elseif (HaveIBBuff(SEVEN_DAY_BUFF) > 0 and IsMantlePrentice(PlayerIndex) == 0) then
        local task1 = GetTaskWord(1660, 2)
        local task2 = GetTask(1664)
        for i = 1657, 1668 do
            SetTask(i, 0)
        end
        SetTaskWord(1660, 2, task1)
        SetTask(1664, task2)
        SetTask(1670, 0)
        SetTask(1671, 0)
        TaskNote(1516, -1)
        Msg2Player("Ng­¬i vµ s­ phô ®· hñy quan hÖ s­ ®å, kh«ng thÓ v­ît qua kiÕp n¹n! NhiÖm vô bÞ hñy!")
    end
end

function Get_MonsterEgg()
    CloseDialog()
    if (Get_EggTime() == 1) then
        if (Check_EggExistance() == 0) then
            if (GetCash() < 1000000) then
                InfoBox(" nhËn <c=g>Trøng Th«ng Linh<c> cÇn <c=g>100 v¹n<c> b¹c, b¹c cña ng­¬i kh«ng ®ñ!")
                return
            end
            Pay(1000000)
            local item = MonsterEgg.Item
            local nNum = GetTaskByte(YIBO_80_DESASTER_STATE, 2)
            for i = 0, 3 do
                ClearItem(item[1], item[2] + i, item[3], item[4])
            end
            AddNormalItem(item[1], item[2], item[3] + nNum - 1, item[4], item[5], item[6])
            local curTime = LocalSystemTime()
            SetTaskWord(Task_EggTime, 1, math.floor(curTime / 86400))
            Msg2Player("Ng­¬i nhËn ®­îc Trøng Th«ng Linh!")
        else
            InfoBox("Ng­¬i ®· cã 1 Trøng Th«ng Linh, víi n¨ng lùc cña ng­¬i kh«ng thÓ nu«i 2 Trøng Th«ng Linh, h·y tha lçi cho t¹i h¹ kh«ng thÓ ®­a Trøng Th«ng Linh cho ng­¬i!")
        end
    else
        InfoBox("H«m nay ng­¬i ®· nhËn Trøng Th«ng Linh!")
    end
end

function Get_EggTime()
    local lastTime = GetTaskWord(Task_EggTime, 1)
    local curTime = LocalSystemTime()
    if (lastTime == math.floor(curTime / 86400)) then
        return 0
    else
        return 1
    end
end

function Check_EggExistance()
    local item = MonsterEgg.Item
    local nNum = GetTaskByte(YIBO_80_DESASTER_STATE, 2)
    local nCount = HaveItemInAllRoom(item[1], item[2], item[3] + nNum - 1, item[4], 0, 0, 0)
    return nCount
end

function sixiang()

    if (SUPERMAN.CheckTaskIsDoing(G_SUPERMANTASK_TYPE, G_SUPERMANTASK_ID) > 0) then
        Talk(1, "no", "Xin lçi, ®· cã ThÇn T­íng gióp ng­¬i lµm nhiÖm vô nµy råi, h·y ®Õn chç Sø Gi¶ ThÇn T­íng t¹i L·nh ®Þa nhËn th­ëng tr­íc.")
        return
    end

    local tasksSixiang = {
        { "Tø Linh", "renwu2"; show = 1 },
        { "<c=g>Tø T­îng Tinh Th¹ch<c>", "renwu2_1"; show = 0 },
        { "T×m HiÓu", "into_sxlx"; show = 1 },

    }
    if (GetTask(1023) > task_yuansu[1][1]) then
        tasksSixiang[2].show = 1
    end

    local index = 6
    for i = 1, 6 do
        if (GetTask(1023) >= TaskTimes[i].totalTimes) then
            SetTaskByte(Double_Optimization, 2, TaskTimes[i].awardsTimes)
            index = i
            break
        end
    end

    local str = "Tø Tinh ®ang bÞ Ma v­¬ng Hçn §én, Cïng Kú, Thao ThiÕt, §µo Ngét khèng chÕ! Ng­¬i cã thÓ gãp chót c«ng søc ®Ó gi÷ cho nh©n thÕ nµy ®­îc th¸i b×nh! NÕu ng­¬i mang ®Õn cho ta 1 <c=g>Tha S¬n Th¹ch<c> vµ Ýt b¹c, ta sÏ gióp ng­¬i më Linh Tª m«n, ®Ó ®i gi¶i cøu Tø Tinh!"
    if (GetGlobalValueByte(G_Double, 1) == 1) then
        if (index > 1) then
            str = str .. "B¹n ®· hoµn thµnh nhiÖm vô thø <c=g>" .. GetTask(1023) .. "<c>, <c=r>nÕu sè nhiÖm vô hoµn thµnh ®¹t" .. TaskTimes[index - 1].totalTimes .. " lÇn, b¹n sÏ nhËn ®­îc phÇn th­ëng hÊp dÉn h¬n.<c>"
        else
            str = str .. "<c=r>TuÇn nµy b¹n cã 5 ngµy cã thÓ nh©n ®«i phÇn th­ëng!<c>"
        end
    end
    SayTask(str, tasksSixiang)

end

function NewPet()
    local NewPetTask = {
        { "Häc kü n¨ng", "StudySkill"; show = 0 },
        { "TÞnh Hãa Linh Thó", "NewPetEvolve"; show = 1 },
        { "Linh Néi §¬n", "Ball"; show = 1 },
        { "§æi T­ ChÊt", "ResetApt"; show = 0 },
        { "TÞnh ho¸ lÇn 2", "NewPetReborn"; show = 0 },
        { "Ph©n th©n Linh Thó", "NewPet1"; show = 0 },
        { "Giíi thiÖu", "Jieshao"; show = 1 }
    }

    local nPetIfEvolve = CheckPetIfEvolve()

    if (nPetIfEvolve ~= 0) then
        NewPetTask[1].show = 1
    end

    if (nPetIfEvolve ~= 0) then
        NewPetTask[2].show = 0
    end

    if (nPetIfEvolve ~= 0) then
        NewPetTask[4].show = 1
    end

    if (nPetIfEvolve ~= 0) then
        NewPetTask[5].show = 1
    end

    if (nPetIfEvolve ~= 0) then
        NewPetTask[6].show = 1
    end

    SayTask("Linh thó lµ linh vËt ®­îc t¹o bëi tinh hoa ®Êt trêi, chØ ¨n nh÷ng thø quý hiÕm. Khi linh lùc ®¹t <c=g>300<c>, ta cã thÓ gióp nã TÞnh Hãa ®Ó cã ®­îc nh÷ng kü n¨ng míi, t¨ng thuéc tÝnh vµ kü n¨ng cña chñ nh©n.", NewPetTask)
end

function Jieshao()
    CloseDialog()
    local JieshaoTask = {
        { "Cho ¨n", "JieshaoFeed"; show = 1 },
        { "Kh¶ n¨ng Linh thó", "JieshaoAbility"; show = 1 },
        { "TÞnh Hãa pet", "JieshaoNew"; show = 0 },

        { "TÞnh Hãa lÇn 2", "JieshaoReborn"; show = 1 },
    }
    SayTask("Linh thó ®· tÞnh ho¸ cã nhiÒu ph©n th©n, tèi ®a cã <c=g>4<c> ph©n th©n. Ph©n th©n kh¸c nhau cã thÓ nhËn ®­îc kü n¨ng míi kh«ng gièng nhau, ®ång thêi t¨ng n¨ng lùc cña chñ nh©n.", JieshaoTask)
end

function JieshaoAbility()
    CloseDialog()
    Talk(2, "JieshaoAbility1", "Linh thó sau khi TÞnh Hãa cã kh¶ n¨ng ph©n th©n, tuy kh«ng thÓ trùc tiÕp tham gia chiÕn ®Êu, nh­ng cã thÓ lµm t¨ng n¨ng lùc cña chñ nh©n. Mçi ph©n th©n ®Òu cã 4 thuéc tÝnh: <c=g>søc m¹nh<c>, <c=g>th©n ph¸p<c>, <c=g>thÓ chÊt<c>, <c=g>linh ho¹t<c>, cã thÓ trùc tiÕp t¨ng cho chñ nh©n nh÷ng thuéc tÝnh t­¬ng øng, mçi ph©n th©n cã ®Æc tÝnh riªng. Tïy theo ®iÓm TÞnh Hãa, thuéc tÝnh c¬ b¶n cña Linh thó ph©n th©n còng sÏ t¨ng theo.", "<c=g>T­ chÊt<c> cña Linh thó ph©n th©n sÏ ¶nh h­ëng ®Õn sù tr­ëng thµnh cña thuéc tÝnh, cao nhÊt lµ <c=g>100<c>. Thø tù tõ thÊp ®Õn cao cña T­ chÊt lµ: <c=g>phæ th«ng<c>, <c=g>­u tó<c>, <c=g>kiÖt xuÊt<c>, <c=g>tr¸c viÖt<c>, <c=g>hoµn mü<c>.")
end

function JieshaoAbility1()
    CloseDialog()

    Talk(1, "Jieshao", "ThÇy T­íng sè:Linh Thó cã thÓ nhËn ®­îc th«ng qua <c=g> s¸ch kü n¨ng <c> vµ <c=g> kü n¨ng néi ®¬n <c> khiÕn cho cÊp ®é kü n¨ng t¨ng lªn. T¨ng tèi ®a <c=g>4<c>, vµ mçi kü n¨ng tèi ®a t¨ng cÊp <c=g>4<c>.")

end

function JieshaoFeed()
    CloseDialog()
    Talk(2, "JieshaoFeed1", "Mçi ph©n th©n kh¸c nhau cña Linh thó cÇn nh÷ng thøc ¨n <c=g>®Æc biÖt<c> ®Ó t¨ng ®iÓm TÞnh Hãa, nhËn ®­îc th«ng qua kü n¨ng <c=g>nÊu n­íng<c>.", "Mçi ngµy mçi ph©n th©n chØ cã thÓ dïng thøc ¨n th«ng qua kü n¨ng <c=g>nÊu n­íng<c> <c=g>5<c> lÇn. Cßn cã thÓ dïng thªm lo¹i vËt phÈm hiÕm <c=g>TÞnh Hãa §¬n<c> ®Ó t¨ng ®iÓm TÞnh Hãa cña 1 ph©n th©n.")
end

function JieshaoFeed1()
    CloseDialog()
    Talk(1, "Jieshao", "Mçi lo¹i ph©n th©n cã thÓ dïng 2 lo¹i thøc ¨n.<enter>Ph©n th©n lo¹i linh ho¹t dïng <c=g>Ph¸ Thñy Hoµn<c> hoÆc <c=g>Ph¸ Thñy ThÊt Tinh Hoµn<c><enter>Ph©n th©n lo¹i thÓ chÊt dïng <c=g>CÊn Thæ Hoµn<c> hoÆc <c=g>CÊn Thæ ThËp Ph­¬ng Hoµn<c><enter>Ph©n th©n lo¹i th©n ph¸p dïng <c=g>Tèn Phong Hoµn<c> hoÆc <c=g>Tèn Phong B¸t VËn Hoµn<c><enter>Ph©n th©n lo¹i søc m¹nh dïng <c=g>Ly Háa Hoµn<c> hoÆc <c=g>Ly Háa Cöu Cung Hoµn<c>")
end

function JieshaoPet()
    CloseDialog()
    Talk(3, "Jieshao", "Mét Linh thó cã tèi ®a <c=g>4<c> ph©n th©n, cã thÓ nhËn hay cã nh÷ng ph©n th©n tõ ng­êi ch¬i kh¸c.", "§­a cho ta 2 <c=g>Hoµng thñy tinh<c>, Linh thó cña ng­¬i sÏ trùc tiÕp nhËn ®­îc 1 ph©n th©n.", "Hai ng­êi tæ ®éi ®Õn t×m ta, còng cã thÓ chuyÓn Linh thó ph©n th©n cña ng­êi ch¬i nµy sang tªn Linh thó cña ng­êi ch¬i kh¸c. ChØ cã thÓ chuyÓn n¨ng lùc, ngo¹i h×nh kh«ng thay ®æi.")
end

function JieshaoReborn()
    CloseDialog()
    Talk(2, "Jieshao", "NÕu ®iÓm TÞnh Hãa Linh thó ph©n th©n cña ng­¬i ®¹t <c=g>300<c> vµ ch­a qua <c=g>2 lÇn TÞnh Hãa<c>, cã thÓ tæ ®éi víi Linh thó ph©n th©n cïng lo¹i vµ phï hîp víi ®iÒu kiÖn trªn cña ng­êi ch¬i kh¸c ®Õn gÆp ta tiÕn hµnh <c=g>2 lÇn TÞnh Hãa<c>. Ph©n th©n cña 2 Linh thó cÇn tù ®iÒu chØnh ©m d­¬ng míi cã thÓ thùc hiÖn 2 lÇn TÞnh Hãa.", "Linh thó sau 2 lÇn tÞnh ho¸, sÏ nhËn ®­îc nh÷ng kü n¨ng míi, cÇn ph¶i tËp luyÖn tõ ®Çu, nh­ng nh÷ng kü n¨ng ®· häc ®­îc sÏ gi÷ l¹i, vµ häc ®­îc nhiÒu kü n¨ng kh¸c.")
end

function NewPet1()
    CloseDialog()
    local NewPet1Task = {
        { "NhËn ph©n th©n", "NewKindPet"; show = 0 },
        { "Ph©n th©n bÞ l·ng quªn", "PetForget"; show = 0 },
        { "TÆng ph©n th©n", "PetTrade"; show = 0 },
        { "Xãa ®iÓm TÞnh Hãa", "ResetFeedValue"; show = 0 },
        { "Ph©n biÖt ©m d­¬ng", "LookSex"; show = 0 },
    }

    if (CheckPetIfEvolve() < 4 and CheckPetIfEvolve() >= 1) then
        NewPet1Task[1].show = 1
    end

    if (CheckPetIfEvolve() >= 1) then
        NewPet1Task[2].show = 1
    end

    if (CheckPetIfEvolve() >= 1) then
        NewPet1Task[3].show = 1
    end

    if (CheckPetIfEvolve() >= 1) then
        NewPet1Task[4].show = 0
    end

    if (CheckPetIfEvolve() >= 1) then
        NewPet1Task[5].show = 1
    end

    SayTask("Mçi Linh thó tèi ®a chØ cã <c=g>4<c> ph©n th©n, ng­¬i cã thÓ khiÕn Linh thó nhËn ®­îc ph©n th©n míi, l·ng quªn ph©n th©n ®· cã, vµ cßn cã thÓ nh­êng 1 ph©n th©n cho Linh thó cña ng­êi kh¸c.", NewPet1Task)
end

arrCareerSkillName = {
    [0] = { "TÕ HuyÕt Tr¶m/SelSkill",
            "L¨ng Ba Vi Bé/SelSkill",
            "Khai S¬n Tr¶m/SelSkill",
            "Håi Phong Tr¶m/SelSkill",
            "§iÖn Quang Tr¶m/SelSkill",
            "Hoµnh Kh«ng Tr¶m/SelSkill",
            "Tinh th«ng ®o¶n ®ao/SelSkill",
            "Tinh th«ng tr­êng ®ao/SelSkill",
            "Tam §Çu Lôc Thñ/SelSkill",
            "HuyÒn B¨ng Tr¶m/SelSkill",
            "Háa Quang Tr¶m/SelSkill",
            "Liªn Hoµn Tr¶m/SelSkill",
            "L¹c §Þa Tr¶m/SelSkill",
            "ThuÇn D­¬ng Hé ThÓ/SelSkill",
            "Thiªn Qu©n Tr¶m/SelSkill",
            "Khuynh Thµnh NhÊt KÝch/SelSkill"
    },
    [1] = { "Ch­ëng T©m L«i/SelSkill",
            "L­u Tinh Th¹ch/SelSkill",
            "B¨ng TuyÕt §¹n/SelSkill",
            "TÝch LÞch Háa/SelSkill",
            "Tinh Th«ng L«i HÖ/SelSkill",
            "Thiªn Phong §Þa NhÉn/SelSkill",
            "B¨ng C¬ TuyÕt Cèt/SelSkill",
            "Phong L©m Háa S¬n/SelSkill",
            "H¹n §Þa L«i/SelSkill",
            "Tinh Th«ng Thæ HÖ/SelSkill",
            "ThiÕt M· B¨ng Qua/SelSkill",
            "Tinh Th«ng Háa HÖ/SelSkill",
            "Phong V©n L«i §éng/SelSkill",
            "Ngò Nh¹c TriÒu T«ng/SelSkill",
            "Tinh Th«ng B¨ng HÖ/SelSkill",
            "ThËp Ph­¬ng LiÖt Háa/SelSkill",
            "L«i Phong Gi¸p/SelSkill",
            "Thiªn B¨ng §Þa LiÖt/SelSkill",
            "B¨ng Phong B¹o/SelSkill",
            "Chóc Dung Ch©n KhÝ/SelSkill",
            "L«i §éng Cöu Thiªn/SelSkill",
            "HuyÒn N÷ Bæ Thiªn/SelSkill",
            "B¨ng Phong V¹n Lý/SelSkill",
            "Tam Muéi Ch©n Háa/SelSkill"
    },
    [2] = { "Kim Cang Chó/SelSkill",
            "Th«i Th©n Chó/SelSkill",
            "Bæ T©m Chó/SelSkill",
            "C­êng C«ng Chó/SelSkill",
            "Ph¸ Gi¸p Chó/SelSkill",
            "Bå §Ò Chó/SelSkill",
            "Tr¶m T©m Chó/SelSkill",
            "TËt Phong Chó/SelSkill",
            "V¹n Cèt Toµn Kh«/SelSkill",
            "Lùc SÜ TÕ/SelSkill",
            "Tr­êng Cung TÕ/SelSkill",
            "Thiªn Vò TÕ/SelSkill",
            "Liªn Nâ TÕ/SelSkill",
            "Háa L«i TÕ/SelSkill",
            "To¸i Cèt TÕ/SelSkill",
            "L­u Tinh TÕ/SelSkill",
            "Truy Hån TÕ/SelSkill",
            "Phong QuyÓn Tµn V©n/SelSkill"

    }
}

arrCareerSkillID = {
    [0] = { { name = "TÕ HuyÕt tr¶m", id = 27, itemid = 511, bookid = 24, idlist = {}, },
            { name = "L¨ng Ba Vi Bé", id = 28, itemid = 512, bookid = 25, idlist = {}, },
            { name = "Khai s¬n tr¶m", id = 29, itemid = 513, bookid = 26, idlist = {}, },
            { name = "Håi Phong Tr¶m", id = 30, itemid = 514, bookid = 27, idlist = { 30, 992, 993, 994, 995, 996, 997, 998 }, },
            { name = "§iÖn Quang Tr¶m", id = 31, itemid = 515, bookid = 28, idlist = { 31, 1058, 1059, 1060, 1061, 1062, 1063, 1064 }, },
            { name = "Hoµnh Kh«ng Tr¶m", id = 32, itemid = 516, bookid = 29, idlist = {}, },
            { name = "Tinh Th«ng §o¶n §ao", id = 33, itemid = 517, bookid = 30, idlist = { 33, 999, 1000, 1001, 1002, 1003, 1004, 1005 }, },
            { name = "Tinh Th«ng Tr­êng §ao", id = 34, itemid = 518, bookid = 31, idlist = { 34, 1065, 1066, 1067, 1068, 1069, 1070, 1071 }, },
            { name = "Tam §Çu Lôc Thñ", id = 35, itemid = 519, bookid = 32, idlist = { 35, 1072, 1073, 1074, 1075, 1076, 1077, 1078 }, },
            { name = "HuyÒn B¨ng tr¶m", id = 36, itemid = 520, bookid = 33, idlist = {}, },
            { name = "Háa Quang Tr¶m", id = 37, itemid = 521, bookid = 34, idlist = {}, },
            { name = "Liªn Hoµn Tr¶m", id = 38, itemid = 522, bookid = 35, idlist = { 38, 1006, 1007, 1008, 1009, 1010, 1011, 1012 }, },
            { name = "L¹c §Þa Tr¶m", id = 39, itemid = 523, bookid = 36, idlist = { 39, 1079, 1080, 1081, 1082, 1083, 1084, 1085 }, },
            { name = "ThuÇn D­¬ng Hé ThÓ", id = 40, itemid = 524, bookid = 37, idlist = { 40, 1013, 1014, 1015, 1016, 1017, 1018, 1019 }, },
            { name = "Thiªn Qu©n Tr¶m", id = 41, itemid = 525, bookid = 38, idlist = { 41, 1020, 1021, 1022, 1023, 1024, 1025, 1026 }, },
            { name = "Khuynh Thµnh NhÊt KÝch", id = 42, itemid = 526, bookid = 39, idlist = { 42, 1086, 1087, 1088, 1089, 1090, 1091, 1092 }, }
    },

    [1] = { { name = "Ch­ëng T©m L«i", id = 3, itemid = 487, bookid = 0, idlist = {}, },
            { name = "L­u Tinh Th¹ch", id = 4, itemid = 488, bookid = 1, idlist = {}, },
            { name = "B¨ng TuyÕt ®¹n", id = 5, itemid = 489, bookid = 2, idlist = {}, },
            { name = "TÝch LÞch Háa", id = 6, itemid = 490, bookid = 3, idlist = {}, },
            { name = "Tinh Th«ng L«i HÖ", id = 7, itemid = 491, bookid = 4, idlist = {}, },
            { name = "Thiªn Phong §Þa NhËn", id = 8, itemid = 492, bookid = 5, idlist = {}, },
            { name = "B¨ng C¬ TuyÕt Cèt", id = 9, itemid = 493, bookid = 6, idlist = {}, },
            { name = "Phong l©m háa s¬n", id = 10, itemid = 494, bookid = 7, idlist = { 10, 1220, 1221, 1222, 1223, 1224, 1225, 1226 }, },
            { name = "H¹n §Þa L«i", id = 11, itemid = 495, bookid = 8, idlist = {}, },
            { name = "Tinh Th«ng Thæ HÖ", id = 12, itemid = 496, bookid = 9, idlist = {}, },
            { name = "ThiÕt M· B¨ng Qua", id = 13, itemid = 497, bookid = 10, idlist = { 13, 1255, 1256, 1257, 1258, 1259, 1260, 1261 }, },
            { name = "Tinh Th«ng Háa HÖ", id = 14, itemid = 498, bookid = 11, idlist = {}, },
            { name = "Phong V©n L«i §éng", id = 15, itemid = 499, bookid = 12, idlist = { 15, 1311, 1312, 1313, 1314, 1315, 1316, 1317 }, },
            { name = "Ngò Nh¹c TriÒu T«ng", id = 16, itemid = 500, bookid = 13, idlist = { 16, 1290, 1291, 1292, 1293, 1294, 1295, 1296 }, },
            { name = "Tinh Th«ng B¨ng HÖ", id = 17, itemid = 501, bookid = 14, idlist = {}, },
            { name = "ThËp Ph­¬ng LiÖt Háa", id = 18, itemid = 502, bookid = 15, idlist = { 18, 1227, 1228, 1229, 1230, 1231, 1232, 1233 }, },
            { name = "L«i Phong Gi¸p", id = 19, itemid = 503, bookid = 16, idlist = {}, },
            { name = "Thiªn B¨ng ®Þa liÖt", id = 20, itemid = 504, bookid = 17, idlist = {}, },
            { name = "B¨ng Phong B¹o", id = 21, itemid = 505, bookid = 18, idlist = { 21, 1262, 1263, 1264, 1265, 1266, 1267, 1268 }, },
            { name = "Chóc Dung Ch©n KhÝ", id = 22, itemid = 506, bookid = 19, idlist = {}, },
            { name = "L«i §éng Cöu thiªn", id = 23, itemid = 507, bookid = 20, idlist = { 23, 1318, 1319, 1320, 1321, 1322, 1323, 1324 }, },
            { name = "HuyÒn N÷ Bæ Thiªn", id = 24, itemid = 508, bookid = 21, idlist = { 24, 1297, 1298, 1299, 1300, 1301, 1302, 1303 }, },
            { name = "B¨ng Phong V¹n Lý", id = 25, itemid = 509, bookid = 22, idlist = { 25, 1269, 1270, 1271, 1272, 1273, 1274, 1275 }, },
            { name = "Tam Muéi Ch©n Háa", id = 26, itemid = 510, bookid = 23, idlist = { 26, 1234, 1235, 1236, 1237, 1238, 1239, 1240 }, }
    },

    [2] = { { name = "Kim Cang chó", id = 43, itemid = 527, bookid = 40, idlist = {}, },
            { name = "Th«i Th©n Chó", id = 44, itemid = 528, bookid = 41, idlist = { 44, 1113, 1114, 1115, 1116, 1117, 1118, 1119 }, },
            { name = "Bæ T©m Chó", id = 45, itemid = 529, bookid = 42, idlist = { 45, 1120, 1121, 1122, 1123, 1124, 1125, 1126 }, },
            { name = "C­êng C«ng chó", id = 46, itemid = 530, bookid = 43, idlist = {}, },
            { name = "Ph¸ Gi¸p chó", id = 47, itemid = 531, bookid = 44, idlist = { 47, 1191, 1192, 1193, 1194, 1195 }, },
            { name = "Bå §Ò chó", id = 48, itemid = 532, bookid = 45, idlist = {}, },
            { name = "Tr¶m T©m Chó", id = 49, itemid = 533, bookid = 46, idlist = { 49, 1127, 1128, 1129, 1130, 1131 }, },
            { name = "TËt Phong chó", id = 50, itemid = 534, bookid = 47, idlist = {}, },
            { name = "V¹n Cèt Toµn Kh«", id = 51, itemid = 535, bookid = 48, idlist = {}, },
            { name = "Lùc SÜ tÕ", id = 450, itemid = 536, bookid = 49, idlist = {}, },
            { name = "Tr­êng Cung tÕ", id = 451, itemid = 537, bookid = 50, idlist = { 451, 461, 462, 463, 464, 465 }, },
            { name = "Thiªn Vò tÕ", id = 452, itemid = 538, bookid = 51, idlist = { 452, 466, 467, 468, 469, 470 }, },
            { name = "Liªn Nç TÕ", id = 453, itemid = 539, bookid = 52, idlist = { 453, 471, 472, 473, 474, 475 }, },
            { name = "Háa L«i TÕ", id = 454, itemid = 540, bookid = 53, idlist = { 454, 476, 477, 478, 479, 480 }, },
            { name = "To¸i Cèt tÕ", id = 455, itemid = 541, bookid = 54, idlist = { 455, 481, 482, 483, 484, 485 }, },
            { name = "L­u Tinh tÕ", id = 456, itemid = 542, bookid = 55, idlist = {}, },
            { name = "Truy Hån tÕ", id = 457, itemid = 543, bookid = 56, idlist = { 457, 486, 487, 488, 489, 490 }, },
            { name = "Phong QuyÓn Tµn V©n", id = 458, itemid = 544, bookid = 57, idlist = { 458, 491, 492, 493, 494, 495 }, }
    }
}

arrLevelSkillId = {
    [0] = {
        [0] = { [0] = 27, [1] = 29, [2] = 30, [3] = 31, [4] = 32, [5] = 35, [6] = 37 },
        [1] = { [0] = 28, [1] = 36, [2] = 38, [3] = 39, [4] = 40 },
        [2] = { [0] = 33, [1] = 34, [2] = 41, [3] = 42 }
    },

    [1] = {
        [0] = { [0] = 3, [1] = 4, [2] = 5, [3] = 6, [4] = 8, [5] = 10, [6] = 11 },
        [1] = { [0] = 7, [1] = 9, [2] = 12, [3] = 13, [4] = 15, [5] = 16, [6] = 17, [7] = 18, [8] = 19, [9] = 20, [10] = 21, [11] = 22, [12] = 24, [13] = 25 },
        [2] = { [0] = 14, [1] = 26, [2] = 23 }
    },

    [2] = {
        [0] = { [0] = 450, [1] = 451, [2] = 452, [3] = 453, [4] = 454, [5] = 455, [6] = 456 },
        [1] = { [0] = 43, [1] = 44, [2] = 45, [3] = 46, [4] = 47, [5] = 48, [6] = 49, [7] = 50, [8] = 457 },
        [2] = { [0] = 51, [1] = 458 }
    }
}

function IsInSkillList(nIndex, nSkillID)
    local playerType = GetPlayerType()
    if (nIndex <= 0 or nIndex > table.getn(arrCareerSkillID[playerType])) then
        return 0
    end

    local idList = arrCareerSkillID[playerType][nIndex].idlist
    local nFlag = 0
    for i = 1, table.getn(idList) do
        if (nSkillID == idList[i]) then
            nFlag = idList[i]
            break
        end
    end
    return nFlag
end

function GetExtendNewSkillByID(nIndex, SelSkillId)
    local nExtendSkill = 0
    for i = 0, 5 do
        nExtendSkill = GetExtendSkillByIdx(i)
        if (nExtendSkill > 0 and IsInSkillList(nIndex, nExtendSkill) > 0) then
            return nExtendSkill
        end
    end

    return 0
end

function StudySkill()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña ng­¬i ®ang ngñ.")
        return
    end

    local StudySkillTask = {
        { "Häc kü n¨ng", "StudySkill1"; show = 1 },
        { "Giíi thiÖu kü n¨ng Linh thó", "ShowStudySkill"; show = 1 },
    }

    SayTask("Ta cã thÓ gióp Linh thó ph©n th©n cña ng­¬i häc kü n¨ng míi hay n©ng cÊp kü n¨ng häc ®­îc ®Ó th¨ng cÊp kü n¨ng chñ nh©n. CÇn <c=g>Néi ®¬n ®· gi¸m ®Þnh<c> vµ <c=g>S¸ch kü n¨ng<c> t­¬ng øng.", StudySkillTask)
end

function ShowStudySkill()
    CloseDialog()
    Talk(2, "no", "Linh thó ph©n th©n kh«ng thÓ trùc tiÕp tham gia chiÕn ®Êu, nh­ng häc kü n¨ng cã thÓ trùc tiÕp th¨ng cÊp kü n¨ng cña chñ nh©n. Th«ng qua <c=g>Kü n¨ng néi ®¬n<c> vµ <c=g>S¸ch kü n¨ng<c> t­¬ng øng, cã thÓ gióp Linh thó ph©n th©n cña ng­¬i häc ®­îc kü n¨ng míi hay n©ng cÊp kü n¨ng s½n cã. Th¨ng lªn bao nhiªu cÊp th× cÇn sè <c=g>Kü n¨ng néi ®¬n<c> vµ <c=g>S¸ch kü n¨ng<c> t­¬ng øng.", "Linh thó ph©n th©n ban ®Çu chØ cã thÓ häc 1 kü n¨ng, khi ®iÓm TÞnh Hãa ®¹t <c=g>100<c>, cã thÓ häc thªm 1 kü n¨ng, sau <c=g>2 lÇn TÞnh Hãa<c>, cã thÓ häc thªm 1 kü n¨ng n÷a. Khi ®iÓm TÞnh Hãa ®¹t <c=g>300<c>, Linh thó ph©n cã thÓ ®ång thêi häc ®­îc 4 kü n¨ng.")
end

function StudySkill1()
    CloseDialog()

    local Skill_Slot_List = { [1] = "Kü n¨ng 1/SelSlot",
                              [2] = "Kü n¨ng 2/SelSlot",
                              [3] = "Kü n¨ng 3/SelSlot",
                              [4] = "Kü n¨ng 4/SelSlot"
    }

    local msg = "Ng­¬i cã thÓ th«ng qua <c=g>Kü n¨ng néi ®¬n<c> vµ <c=g>S¸ch kü n¨ng<c> ®Ó gióp Linh thó ph©n th©n häc ®­îc kü n¨ng míi hay n©ng cÊp kü n¨ng cã s½n. H·y chän thay thÕ hay n©ng cÊp 1 kü n¨ng nµo ®ã."
    Say(msg, table.getn(Skill_Slot_List), Skill_Slot_List)
end

function SelSlot(n)
    CloseDialog()

    SetTaskByte(140, 1, n)

    local bOpen, nSkillID, nSkillLevel = GetEvolvePetSkill(n)

    if (bOpen ~= 1) then
        Talk(1, "no", "Linh thó ph©n th©n cña ng­¬i kh«ng thÓ häc qu¸ nhiÒu kü n¨ng. CÇn cho ¨n thªm míi cã thÓ häc thªm cµng nhiÒu kü n¨ng.")
        return
    end

    if (nSkillID ~= 0) then
        MsgBox("§ång ý thay thÕ hay n©ng cÊp nh÷ng kü n¨ng hiÖn t¹i kh«ng?", "Yes_Replace", "no")
    else
        Yes_Replace()
    end
end

function Yes_Replace()

    CloseDialog()
    local playerType = GetPlayerType()
    local msg = "H·y chän nh÷ng kü n¨ng cÇn häc hay n©ng cÊp."
    Say(msg, table.getn(arrCareerSkillName[playerType]), arrCareerSkillName[playerType])

end

function SelSkill(n)
    CloseDialog()
    local playerType = GetPlayerType()
    local SelSkillId = arrCareerSkillID[playerType][n + 1].id
    local nNeedItemId = arrCareerSkillID[playerType][n + 1].itemid
    local nNeddBookId = arrCareerSkillID[playerType][n + 1].bookid
    local nPetKind = CheckPetKind()
    local nSelSlotId = GetTaskByte(140, 1)

    for i = 0, 3 do
        local bOpen, nSkillID, nSkillLevel = GetEvolvePetSkill(i)

        local nID = IsInSkillList(n + 1, nSkillID)
        if (nSkillID == SelSkillId or nID > 0) then


            if (i == nSelSlotId) then
                if (nSkillLevel >= 4) then
                    Talk(1, "no", "CÊp kü n¨ng nµy ®· <c=g>®Çy<c>, kh«ng cÇn häc n÷a.")
                    return
                end

                local nStudyLevel = nSkillLevel + 1
                if (HaveNormalItem(3, nNeedItemId, 0, 0) < nStudyLevel or HaveNormalItem(7, nNeddBookId, SelSkillId, 0) < nStudyLevel) then
                    Talk(1, "no", "S¸ch kü n¨ng hay Néi ®¬n t­¬ng øng cña ng­¬i kh«ng ®ñ")
                    return
                end

                if (nStudyLevel == 4 and HaveNormalItem(8, 1409, 2, 0) <= 0) then
                    Talk(1, "no", "N©ng lªn kü n¨ng cÊp 4 cÇn 1 <c=g> Phi Th¨ng Ng­ng Lé <c>, hiÖn t¹i b¹n kh«ng ®ñ vËt phÈm.")
                    return
                end

                if (nStudyLevel == 4) then
                    DelNormalItem(8, 1409, 2, 0)
                end

                for j = 1, nStudyLevel do
                    DelNormalItem(3, nNeedItemId, 0, 0)
                    DelNormalItem(7, nNeddBookId, SelSkillId, 0)
                end

                if (nID > 0) then
                    ModifyEvolvePetSkill(nSelSlotId, 1, nID, nStudyLevel)
                else
                    ModifyEvolvePetSkill(nSelSlotId, 1, SelSkillId, nStudyLevel)
                end

                Msg2Player("Linh thó ph©n th©n cña ng­¬i häc ®­îc " .. arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng" .. nStudyLevel .. " (cÊp)")
                Talk(1, "no", "Linh thó ph©n th©n cña ng­¬i häc ®­îc kü n¨ng <c=g>" .. arrCareerSkillID[playerType][n + 1].name .. "<c> cÊp <c=g>" .. nStudyLevel .. "<c>, n©ng cÊp lo¹i h×nh Linh thó  " .. arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng" .. nStudyLevel .. ".")
                WriteLog(arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng" .. nStudyLevel .. " (cÊp)" .. GetName() .. " lo¹i h×nh Linh Thó" .. nPetKind)
                if (nStudyLevel == 3 or nStudyLevel == 4) then
                    AddGlobalCountNews(GetName() .. "-Linh thó ph©n th©n häc ®­îc " .. arrCareerSkillID[playerType][n + 1].name .. nStudyLevel .. ".", 20)
                end
                return
            else
                Talk(1, "no", "Kü n¨ng nµy ®· tån t¹i, kh«ng cÇn häc n÷a.")
                return
            end

        end

    end

    if (HaveNormalItem(3, nNeedItemId, 0, 0) < 1 or HaveNormalItem(7, nNeddBookId, SelSkillId, 0) < 1) then
        Talk(1, "no", "Ng¹i qu¸! <c=g>S¸ch kü n¨ng<c> vµ <c=g>Kü n¨ng néi ®¬n<c> t­¬ng øng ®· gi¸m ®Þnh kh«ng ®ñ, kh«ng thÓ häc kü n¨ng nµy.")
        return
    else
        DelNormalItem(3, nNeedItemId, 0, 0)
        DelNormalItem(7, nNeddBookId, SelSkillId, 0)
    end

    local nNewSkillId = GetExtendNewSkillByID(n + 1, SelSkillId)
    if (nNewSkillId > 0) then
        ModifyEvolvePetSkill(nSelSlotId, 1, nNewSkillId, 1)
    else
        ModifyEvolvePetSkill(nSelSlotId, 1, SelSkillId, 1)
    end

    Msg2Player("Linh thó ph©n th©n cña ng­¬i häc ®­îc " .. arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng  cÊp 1, hiÖu qu¶ sö dông cña ng­¬i t¨ng 1 cÊp.")
    Talk(1, "no", "Linh thó ph©n th©n cña ng­¬i häc ®­îc kü n¨ng <c=g>" .. arrCareerSkillID[playerType][n + 1].name .. "<c>Kü n¨ng cÊp <c=g>1<c>, t¨ng  " .. arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng cÊp 1.")
    WriteLog(arrCareerSkillID[playerType][n + 1].name .. "Kü n¨ng cÊp 1" .. GetName() .. " lo¹i h×nh Linh Thó" .. nPetKind)
end

Task_PetEvolve = 1571

arrPetKindItem = {
    [0] = { id = 546, name = "Ph¸ Thñy Hoµn" },
    [1] = { id = 548, name = "CÊn Thæ Hoµn" },
    [2] = { id = 550, name = "Tèn Phong Hoµn" },
    [3] = { id = 552, name = "Ly Háa Hoµn" },
    [4] = { id = 547, name = "Ph¸ Thñy ThÊt Tinh Hoµn" },
    [5] = { id = 549, name = "CÊn Thæ ThËp Ph­¬ng Hoµn" },
    [6] = { id = 551, name = "Tèn Phong B¸t VËn Hoµn" },
    [7] = { id = 553, name = "Ly Háa Cöu Cung Hoµn" }
}

function NewPetEvolve()
    CloseDialog()
    local task = GetTaskByte(Task_PetEvolve, 1)
    if (task == 0) then
        if (PetGetSpirit() < 300) then
            Talk(3, "no", "Linh thó cña ng­¬i cã Linh lùc ch­a ®¹t <c=g>300<c>. Khi linh lùc ®¹t <c=g>300<c>, ta cã thÓ gióp nã TÞnh Hãa vµ nhËn ®­îc nh÷ng kü n¨ng míi, tõ ®ã n©ng cÊp <c=g>4 thuéc tÝnh c¬ b¶n<c> vµ <c=g>kü n¨ng<c>.", "Linh thó sau khi TÞnh Hãa cã nhiÒu ph©n th©n, h·y ®­a cho ta nh÷ng thøc ¨n kh¸c nhau cña Linh thó ph©n th©n ®Ó TÞnh Hãa thµnh nh÷ng ph©n th©n kh¸c nhau. Thøc ¨n Linh thó ph©n th©n ®­îc chÕ t¹o tõ <c=g>4 cÊp<c> kü n¨ng <c=g>nÊu n­íng<c>. NÕu Linh thó hµi lßng víi thøc ¨n mµ chñ nh©n cung cÊp sÏ cã nh÷ng thay ®æi bÊt ngê.")

        else
            SetTaskByte(Task_PetEvolve, 1, 1)
            TaskNote(1250, 0)
            Talk(1, "Newjieshao", "Khi Linh lùc cña Linh thó ®¹t <c=g>300<c>, cã thÓ ®Õn chç ta ®Ó TÞnh Hãa Linh thó ®Ó t¨ng thªm nhiÒu kü n¨ng. §­a cho ta nh÷ng vËt phÈm cÇn ®Ó TÞnh Hãa cho Linh thó, ta sÏ TÞnh Hãa cho Linh thó cña ng­¬i ®Ó t¨ng thªm nhiÒu kü n¨ng. Linh thó sau khi TÞnh Hãa cã thÓ ®iÒu khiÓn <c=g>4<c> ph©n th©n. Ban ®Çu chØ cã 1, nh­ng cã thÓ nhËn thªm nhiÒu ph©n th©n kh¸c th«ng qua nhiÒu c¸ch kh¸c nhau.")
        end

    elseif (task == 1) then
        MsgBox("Ng­¬i ®· mang ®Õn nh÷ng vËt phÈm cÇn thiÕt ch­a?", "Yes_Evolve", "no")
    end
end

function Newjieshao()
    CloseDialog()
    Talk(1, "Newjieshao1", "Linh thó sau khi TÞnh Hãa cã thÓ nhËn ®­îc nh÷ng ph©n th©n kh¸c nhau<enter><c=g>Ph¸ Thñy Hoµn<c> khiÕn Linh thó TÞnh Hãa thµnh ph©n th©n Tinh Minh Hå <c=y>lo¹i linh ho¹t<c>.<enter><c=g>CÊn Thæ Hoµn<c> khiÕn Linh thó TÞnh Hãa thµnh ph©n th©n §Ëu §Ëu Quy <c=y>lo¹i thÓ chÊt<c>.<enter><c=g>Tèn Phong Hoµn<c> khiÕn Linh thó TÞnh Hãa thµnh ph©n th©n Tra Tra §iÓu <c=y>lo¹i th©n ph¸p<c>.<enter><c=g>Ly Háa Hoµn<c> khiÕn Linh thó TÞnh Hãa thµnh ph©n th©n BiÕn S¾c Long <c=y>lo¹i søc m¹nh<c>.")
end

function Newjieshao1()
    CloseDialog()
    Talk(1, "no", "Nh÷ng nguyªn liÖu nµy nhËn ®­îc th«ng qua <c=g>4 cÊp<c> kü n¨ng <c=g>nÊu n­íng<c>. Mau chãng mang ®Õn cho ta theo nhu cÇu.")
end

function Yes_Evolve()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end
    if (PetIsAdd() <= 0) then
        Talk(1, "no", "Ng­¬i ch­a cã Linh thó ­.")
        return
    end

    if (PetGetSpirit() < 300) then
        Talk(1, "no", "Linh thó cña ng­¬i cã Linh lùc ch­a ®¹t <c=g>300<c>.")
        return
    end

    local kindlist = {
        "Ph¸ Thñy Hoµn (TÞnh Hãa thµnh Tinh Minh Hå lo¹i linh ho¹t)/SelKind",
        "CÊn Thæ Hoµn (TÞnh Hãa thµnh §Ëu §Ëu Quy lo¹i thÓ chÊt)/SelKind",
        "Tèn Phong Hoµn (TÞnh Hãa thµnh Tra Tra §iÓu lo¹i th©n ph¸p)/SelKind",
        "Ly Háa Hoµn (TÞnh Hãa thµnh BiÕn S¾c Long lo¹i søc m¹nh)/SelKind"
    }
    Say("§­a cho ta nh÷ng vËt phÈm kh¸c nhau sÏ nhËn ®­îc nh÷ng Linh thó ph©n th©n kh¸c nhau, h·y chän kü.", table.getn(kindlist), kindlist)
end

function GetSkillIDAndName(nGrade)
    local playerType = GetPlayerType()
    local n = table.getn(arrLevelSkillId[playerType][nGrade])
    local skillID = arrLevelSkillId[playerType][nGrade][math.random(0, n)]

    local skillName = ""
    for i = 1, table.getn(arrCareerSkillID[playerType]) do
        if (skillID == arrCareerSkillID[playerType][i].id) then
            skillName = arrCareerSkillID[playerType][i].name
            break
        end
    end

    return skillID, skillName
end

function GetRandomSkillIDAndName()
    local randomL = 7900
    local randomM = 2000
    local randomH = 100
    local p = math.random(1, 10000)

    local nGrade = -1
    if (p <= randomH) then
        nGrade = 2
    elseif (p <= randomH + randomM) then
        nGrade = 1
    else
        nGrade = 0
    end

    if (nGrade >= 0) then
        return GetSkillIDAndName(nGrade)
    else
        return -1, ""
    end
end

function GetSkillName()
end

function SelKind(n)
    CloseDialog()
    if (HaveNormalItem(3, arrPetKindItem[n].id, 0, 0) <= 0) then
        Talk(1, "no", "Ng­¬i kh«ng cã vËt phÈm nµy.")
        return
    end

    DelNormalItem(3, arrPetKindItem[n].id, 0, 0)
    if (PetEvolve(n + 1) ~= 0) then
        local nCon = GetEvolvePetConstitution()
        local nInt = GetEvolvePetIntellect()
        local nDex = GetEvolvePetDexterity()
        local nStr = GetEvolvePetStrength()

        local SkillID, SkillName = GetRandomSkillIDAndName()
        if (SkillID >= 0) then
            ModifyEvolvePetSkill(0, 1, SkillID, 1)
        end

        SetTaskByte(Task_PetEvolve, 1, 2)
        TaskNote(1250, -1)
        Talk(3, "RandomApt", "Chóc mõng, Linh thó cña ng­¬i TÞnh Ho¸ thµnh c«ng! Linh thó ph©n th©n nµy cã thuéc tÝnh ban ®Çu lµ:<enter>søc m¹nh<c=g>" .. nStr .. "<c>®iÓm<enter>th©n ph¸p<c=g>" .. nDex .. "<c>®iÓm<enter>linh ho¹t<c=g>" .. nInt .. "<c>®iÓm<enter>thÓ chÊt<c=g>" .. nCon .. "<c>", "Linh thó ph©n th©n cña ng­¬i ®· lÜnh ngé kü n¨ng <c=g>" .. SkillName .. "<c>, v× vËy kü n¨ng nµy cña ng­¬i ®­îc th¨ng lªn <c=g>1<c> cÊp. NhËn ®­îc <c=g>Néi ®¬n<c> tõ thñ lÜnh vµ NhÞ thËp b¸t tó, th«ng qua <c=g>gi¸m ®Þnh néi ®¬n<c> nhËn ®­îc <c=g>Kü n¨ng néi ®¬n<c> cã thÓ gióp Linh thó häc ®­îc kü n¨ng míi hay n©ng cÊp kü n¨ng.", "Linh thó nµy cÇn ®­îc cho dïng <c=g>" .. arrPetKindItem[n].name .. "<c> hoÆc <c=g>" .. arrPetKindItem[n + 4].name .. "<c> ®Ó t¨ng ®é TÞnh Ho¸, tõ ®ã t¨ng kü n¨ng. Nh÷ng vËt phÈm nµy nhËn ®­îc th«ng qua kü n¨ng <c=g>nÊu n­íng<c>.")
        WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô TÞnh Ho¸. NhËn ®­îc " .. n)
    else
        Talk(1, "no", "Ng¹i qu¸! Linh thó cña ng­¬i TÞnh Ho¸ thÊt b¹i")
        return
    end

    return
end

function RandomApt()
    CloseDialog()
    local nApt = GetEvolvePetnAptitude()
    MsgBox("Linh thó ph©n th©n cña ng­¬i cã t­ chÊt lµ <c=g>" .. nApt .. "<c>(tèi ®a lµ 100), nã sÏ ¶nh h­ëng ®Õn nh÷ng thuéc tÝnh sau nµy, nÕu ng­¬i kh«ng hµi lßng, chØ cÇn 1 <c=g>Thiªn Tiªn Qu¶<c> hay <c=g>15 Th«ng B¶o<c> cã thÓ thay ®æi t­ chÊt cña nã.", "Yes_RandomApt", "no")
end

function Yes_RandomApt()
    MsgBox("Cho ta 1 <c=g>Thiªn Tiªn Qu¶<c> hay <c=g>15 Th«ng B¶o<c> cã thÓ thay ®æi t­ chÊt Linh thó ph©n th©n cña ng­¬i, ®ång ý kh«ng?", "Yes_RandomApt1", "no")
end

function Yes_RandomApt1()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(137)

    if ((GetCoin() < costIBNum) and (HaveNormalItem(8, 1027, 2, 0) <= 0)) then
        Talk(1, "no", "Ng­¬i ph¶i cho ta 1 <c=g>Thiªn Tiªn Qu¶<c> hay <c=g>15 Th«ng B¶o<c> míi cã thÓ thay ®æi t­ chÊt Linh thó ph©n th©n.")
        return
    end
    if (HaveNormalItem(8, 1027, 2, 0) > 0) then
        DelNormalItem(8, 1027, 2, 0)
    else
        CostCoinByIdx(137)
    end

    local nApt = math.random(1, 100)
    ModifyEvolvePetAptitude(nApt)
    if (nApt == 100) then
        AddGlobalCountNews(GetName() .. "§­îc sù chiÕu cè cña thÇn, nhËn ®­îc Linh thó ph©n th©n cã t­ chÊt <c=g>Hoµn mü<c> (100).", 20)
    end
    MsgBox("Linh thó ph©n th©n cã t­ chÊt míi lµ <c=g>" .. nApt .. "<c>(Tèi ®a lµ 100), t­ chÊt sÏ ¶nh h­ëng nh÷ng thuéc tÝnh sau nµy, nÕu ng­¬i kh«ng hµi lßng, cÇn cã 1 <c=g>Thiªn Tiªn Qu¶<c> hay <c=g>" .. costDisNum .. " Th«ng B¶o<c> cã thÓ thay ®æi t­ chÊt.", "Yes_RandomApt", "no")

end

function Yes_GetSkill()
    CloseDialog()

    local playerType = GetPlayerType()
    local r = math.random(1, table.getn(arrCareerSkillID[playerType]))
    ModifyEvolvePetSkill(0, 1, arrCareerSkillID[playerType][r].id, 1)

    Talk(1, "no", "Linh thó ph©n th©n cña ng­¬i ®· lÜnh ngé kü n¨ng " .. arrCareerSkillID[playerType][r].name .. ", sau khi sö dông sÏ th¨ng 1 cÊp.")

    SetTaskByte(Task_PetEvolve, 1, 2)
end

function LookSex()
    CloseDialog()
    MsgBox("ChØ cÇn tèn 1 <c=g>Lam B¶o Th¹ch<c>, cã thÓ ®Õn chç ta nhËn biÕt ©m d­¬ng cña ph©n th©n hiÖn t¹i. Ng­¬i cã ®ång ý nhËn biÕt ©m d­¬ng cho Linh thó ph©n th©n kh«ng?", "LookSex1", "no")
end
function LookSex1()
    CloseDialog()
    local bCanSeeSex = CheckPetSex()

    if (bCanSeeSex == 1) then
        Talk(1, "no", "Linh thó ph©n th©n cña ng­¬i ®· nhËn biÕt ©m d­¬ng, kh«ng cÇn nhËn biÕt n÷a.")
        return
    end

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Linh thó ph©n th©n ®ang ngñ, kh«ng thÓ nhËn biÕt.")
        return
    end

    if (HaveNormalItem(3, 41, 0, 0) <= 0) then
        Talk(1, "no", "Ta cÇn 1 <c=g>Lam B¶o Th¹ch<c> ®Ó x¸c ®Þnh ¢m D­¬ng cho ph©n th©n.")
        return
    end

    DelNormalItem(3, 41, 0, 0)

    local nSex = GetPetSex()
    local strSex1 = ""
    local strSex2 = ""
    if (nSex == 0) then
        strSex1 = "¢m"
        strSex2 = "D­¬ng"
    else
        strSex1 = "D­¬ng"
        strSex2 = "¢m"
    end

    TellPetSex()
    Talk(1, "no", "Linh Thó ph©n th©n cña b¹n lµ <c=g>" .. strSex1 .. "<c>. Cã thÓ t×m ph©n th©n <c=g>" .. strSex2 .. "<c> cïng tiÕn hµnh TÞnh Ho¸ lÇn 2.")
end

function NewPetReborn()
    CloseDialog()

    MsgBox("NÕu trÞ TÞnh Ho¸ cña Linh Thó ph©n th©n ®¹t <c=g>300<c> vµ ch­a tiÕn hµnh TÞnh Ho¸ lÇn 2, cã thÓ t×m Linh Thó ph©n th©n cña mét ng­êi ch¬i kh¸c cã thuéc tÝnh t­¬ng tù vµ phï hîp c¸c ®iÒu kiÖn kÓ trªn, cïng ®Õn t×m ta ®Ó TÞnh Ho¸ lÇn 2. Hai Linh Thó ph©n th©n cÇn ©m d­¬ng bæ trî íi cã thÓ TÞnh Ho¸. X¸c ®Þnh TÞnh Ho¸ lÇn 2?", "NewPetReborn1", "no")
end

function RebornTell()
    CloseDialog()
    Talk(2, "no", "Khi trÞ TÞnh Ho¸ cña Linh Thó ph©n th©n ®¹t <c=g>300<c>, tæ ®éi víi ng­êi ch¬i kh¸c cã Linh Thó ph©n th©n kh«ng cïng thuéc tÝnh, ta cã thÓ gióp c¸c ng­¬i TÞnh Ho¸ lÇn 2.", "Sau khi TÞnh Ho¸ lÇn 2, ph©n th©n sÏ ®­îc trïng sinh, thuéc tÝnh sÏ trë vÒ giai ®o¹n ban ®Çu, nh­ng kü n¨ng vÉn giu74 nguyªn ®ång thêi ®îc häc thªm 1 kü n¨ng míi, khi trÞ TÞnh Ho¸ cña Linh Thó ph©n th©n ®¹t <c=g>300<c> cã thÓ nhËn thªm 1 kü n¨ng n÷a.")
end

Team_Type = 1
Team_CaptainID = 2
Team_Captain_Index = 3

function NewPetReborn1()
    CloseDialog()

    if (IsCanReborn() == 0) then
        Msg2Player("Linh Thó ph©n th©n cña hai bªn kh«ng phï hîp ®iÒu kiÖn TÞnh Ho¸ lÇn 2")
        return
    end

    if (IsCaptain() ~= 1) then
        Msg2Team("CÇn tæ ®éi hai ng­êi, do ®éi tr­ëng nhËn nhiÖm vô")
        return
    end

    local myPartner = 0
    if (PlayerIndex == GetTeamMember(1)) then
        myPartner = GetTeamMember(2)
    else
        myPartner = GetTeamMember(1)
    end

    SetTeamTask(Team_Type, 2)
    SetTeamTask(Team_CaptainID, GetPlayerID())
    SetTeamTask(Team_Captain_Index, oldPlayer)

    TeamAction("askPartner", myPartner, 0, 0)
end

function CheckDis(nX, nY)
    if ((nX - 1396) ^ 2 + (nY - 3016) ^ 2 < 300 * 300) then
        return 1
    end

    return 0
end

function askPartner(nParam)
    if (nParam == PlayerIndex) then
        local oldPlayer = PlayerIndex
        local nameStr = ""

        if (PlayerIndex == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end

        if (PlayerIndex > 0) then
            nameStr = GetName()
        end

        PlayerIndex = oldPlayer
        local myPartner = 0
        if (PlayerIndex == GetTeamMember(1)) then
            myPartner = GetTeamMember(2)
        else
            myPartner = GetTeamMember(1)
        end

        SetTask(140, myPartner)
        MsgBox("Ng­êi ch¬i " .. nameStr .. "-Linh Thó ph©n th©n muèn TÞnh Ho¸ lÇn 2 víi Linh Thó cña b¹n, ®ång ý kh«ng?", "agreeRequest", "refuseRequest")
    end
end

function agreeRequest()
    CloseDialog()
    local oldPlayer = PlayerIndex

    if (oldPlayer == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end

    if (GetPlayerID() ~= GetTeamTask(Team_CaptainID)) or (GetTeamTask(Team_Type) ~= 2) then
        Msg2Team("Trong qu¸ tr×nh TÞnh Ho¸ lÇn 2 kh«ng thÓ ®æi quyÒn ®éi tr­ëng, hoÆc thay ®æi ®éi ngò")
        PlayerIndex = oldPlayer
        return
    end

    if (IsCanReborn() == 0) then
        return
    end

    local year_baby, month_baby, day_baby = GetYMD()
    local num
    if (((year_baby == 2009) and (((month_baby == 11) and (day_baby >= 25)) or (month_baby > 11))) or ((year_baby == 2010) and (month_baby == 1) and (day_baby <= 15))) then
        num = LoadIniInteger("Save_fs_firstbaby_num", 1)
        if (num == 0) then
            SaveIniInteger("Save_fs_firstbaby_num", 1, 1)
            AddGlobalNews("C¸t tinh cao chiÕu, hång vËn ®­¬ng ®Çu <c=g>Phong ThÇn §Ö NhÊt B¶o B¶o<c> ®· xuÊt hiÖn!")
        end
    end

    for i = 1, GetTeamSize() do
        PlayerIndex = GetTeamMember(i)
        local nPetKind = CheckPetKind()
        PetReborn(nPetKind)
        ModifyEvolvePetFeedValue(-300)
        ModifyEvolvePetRebornNum(1)
        OpenOnePetSkillSlot()

        local nCon = GetEvolvePetConstitution()
        local nInt = GetEvolvePetIntellect()
        local nDex = GetEvolvePetDexterity()
        local nStr = GetEvolvePetStrength()
        TellPetSex()
        Msg2Player("Linh Thó ph©n th©n cña b¹n  l¹i häc thªm 1 kü n¨ng n÷a")

        if (((year_baby == 2009) and (((month_baby == 11) and (day_baby >= 25)) or (month_baby > 11))) or ((year_baby == 2010) and (month_baby == 1) and (day_baby <= 15))) then
            if (num == 0) then
                SaveIniString("Save_fs_firstbaby_num", i + 1, GetName())
                Msg2Player("Chóc mõng Linh Thó cña b¹n trë thµnh Phong ThÇn §Ö NhÊt B¶o B¶o, ®­îc céng 1 ®iÓm tÊt c¶ thuéc tÝnh.")
                local nPetSlot = GetPetSlot()
                local nKind = CheckPetKind()
                if (nKind == 3) then
                    SetEvolvePetColor(45, nPetSlot)
                else
                    SetEvolvePetColor(135, nPetSlot)
                end
                ModifyEvolvePetStrength(1)
                ModifyEvolvePetDexterity(1)
                ModifyEvolvePetConstitution(1)
                ModifyEvolvePetIntellect(1)

                Talk(1, "no", "Chóc mõng, Linh Thó cña b¹n TÞnh Ho¸ lÇn 2 thµnh c«ng, ®­îc häc thªm 1 kü n¨ng n÷a! Linh Thó cña b¹n lµ Linh Thó ®Çu tiªn hoµn thµnh TÞnh Ho¸ lÇn 2, ®­îc nhËn thªm phÇn th­ëng céng 1 ®iÓm tÊt c¶ thuéc tÝnh. Thuéc tÝnh cña Linh Thó ph©n th©n ®· TÞnh Ho¸ lÇn 2 lµ: <enter>Søc m¹nh <c=g>" .. nStr .. "(+1)<c> ®iÓm<enter>Th©n ph¸p <c=g>" .. nDex .. "(+1)<c> ®iÓm<enter>Linh ho¹t <c=g>" .. nInt .. "(+1)<c> ®iÓm<enter>ThÓ chÊt <c=g>" .. nCon .. "(+1)<c> ®iÓm")
            else
                Talk(1, "no", "Chóc mõng, Linh Thó ph©n th©n cña b¹n ®· TÞnh Ho¸ lÇn 2 thµnh c«ng, cã thÓ häc thªm 1 kü n¨ng! Thuéc tÝnh cña Linh Thó ®· tÞnh ho¸ lÇn 2 lµ:<enter>Søc m¹nh <c=g>" .. nStr .. "<c> ®iÓm<enter>Th©n ph¸p <c=g>" .. nDex .. "<c> ®iÓm<enter>Linh ho¹t <c=g>" .. nInt .. "<c> ®iÓm<enter>ThÓ chÊt <c=g>" .. nCon .. "<c>")
            end
        else
            Talk(1, "no", "Chóc mõng, Linh Thó ph©n th©n cña b¹n ®· TÞnh Ho¸ lÇn 2 thµnh c«ng, cã thÓ häc thªm 1 kü n¨ng! Thuéc tÝnh cña Linh Thó ®· tÞnh ho¸ lÇn 2 lµ:<enter>Søc m¹nh <c=g>" .. nStr .. "<c> ®iÓm<enter>Th©n ph¸p <c=g>" .. nDex .. "<c> ®iÓm<enter>Linh ho¹t <c=g>" .. nInt .. "<c> ®iÓm<enter>ThÓ chÊt <c=g>" .. nCon .. "<c>")
        end

        WriteLog(nPetKind .. "TÞnh Ho¸ lÇn 2." .. GetName())


    end

    PlayerIndex = oldPlayer
end

function refuseRequest()
    CloseDialog()

    local myPartner = GetTask(140)
    TeamAction("RefusePartner", myPartner, 0, 0)

end

function RefusePartner(nParam)

    if (nParam == PlayerIndex) then
        Talk(1, "no", "§èi ph­¬ng tõ chèi yªu cÇu cña b¹n.")
    end
end

function IsCanReborn()
    local nTeam = GetTeamSize()

    if (nTeam ~= 2) and (nTeam > 0) then
        Msg2Team("Nhãm cña c¸c ng­¬i kh«ng ph¶i nhãm 2 ng­êi.")
        return 0
    elseif (nTeam == 0) then
        Talk(1, "no", "CÇn tæ ®éi hai ng­êi cïng tíi ®©y míi cã thÓ TÞnh Ho¸ lÇn 2.")
        return 0
    end

    local oldPlayer = PlayerIndex
    for i = 1, nTeam do
        PlayerIndex = GetTeamMember(i)
        if (PetIsSleep() == 1) then
            Msg2Team(GetName() .. "-Linh Thó ®ang ë tr¹ng th¸i ngñ")
            Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
            return 0
        end
        local w1, x1, y1 = GetWorldPos()

        if (w1 ~= 20 or CheckDis(x1, y1) == 0) then
            Msg2Team(GetName() .. "C¸ch ThÇy t­íng sè T©y Kú qu¸ xa")
            PlayerIndex = oldPlayer
            Talk(1, "no", "C¸ch nhau qu¸ xa, kh«ng thÓ TÞnh Ho¸ lÇn 2")
            return 0
        end

        if (GetEvolvePetFeedValue() < 300) then
            Msg2Team(GetName() .. "-Linh Thó ph©n th©n ch­a thÓ TÞnh Ho¸ lÇn 2")
            Talk(1, "no", "Linh Thó cña b¹n  ph©n th©n ch­a ®ñ n¨ng lùc ®Ó TÞnh Ho¸ lÇn 2.")
            PlayerIndex = oldPlayer
            return 0
        end

        if (GetEvolvePetRebornNum() >= 1) then
            Msg2Team(GetName() .. "-Linh Thó ph©n th©n ®· TÞnh Ho¸ lÇn 2, kh«ng thÓ TÞnh Ho¸ n÷a")
            Talk(1, "no", "Linh Thó ph©n th©n cña b¹n ®· TÞnh Ho¸ lÇn 2 råi, kh«ng thÓ TÞnh Ho¸ n÷a.")
            PlayerIndex = oldPlayer
            return 0
        end
    end

    local nValue1 = 0
    local nValue2 = 0

    PlayerIndex = GetTeamMember(1)
    nValue1 = GetEvolvePetRebornNum()
    PlayerIndex = GetTeamMember(2)
    nValue2 = GetEvolvePetRebornNum()
    if (nValue1 ~= nValue2) then
        Msg2Team("§· cã Ýt nhÊt 1 Linh Thó ph©n th©n ®· TÞnh Ho¸ lÇn 2")
        PlayerIndex = oldPlayer
        return 0
    end

    PlayerIndex = GetTeamMember(1)
    nValue1 = CheckPetKind()
    PlayerIndex = GetTeamMember(2)
    nValue2 = CheckPetKind()
    if (nValue1 == 0 or nValue2 == 0 or nValue1 ~= nValue2) then
        Msg2Team("Chñng lo¹i cña 2 Linh Thó ph©n th©n kh¸c nhau, cÇn cã ph©n th©n cïng lo¹i")
        Talk(1, "no", "Linh Thó ph©n th©n cña c¸c ng­¬i kh¸c lo¹i, kh«ng thÓ TÞnh Ho¸ lÇn 2.")
        PlayerIndex = oldPlayer
        return 0
    end

    PlayerIndex = GetTeamMember(1)
    if (CheckPetSex() ~= 1) then
        Msg2Team(GetName() .. "-Linh Thó ph©n th©n ch­a ph©n biÖt ©m d­¬ng")
        Talk(1, "no", "Thuéc tÝnh ©m d­¬ng cña Linh Thó ph©n th©n ch­a râ rµng sÏ g©y hËu qu¶ khã cøu ch÷a, h·y mau ph©n biÖt ©m d­¬ng cho Linh Thó.")
        return 0
    end
    nValue1 = GetPetSex()
    PlayerIndex = GetTeamMember(2)
    if (CheckPetSex() ~= 1) then
        Msg2Team(GetName() .. "-Linh Thó ph©n th©n ch­a ph©n biÖt ©m d­¬ng")
        Talk(1, "no", "Thuéc tÝnh ©m d­¬ng cña Linh Thó ph©n th©n ch­a râ rµng sÏ g©y hËu qu¶ khã cøu ch÷a, h·y mau ph©n biÖt ©m d­¬ng cho Linh Thó.")
        return 0
    end
    nValue2 = GetPetSex()
    if (nValue1 == nValue2) then
        Msg2Team("Hai Linh Thó nµy thuéc tÝnh kh«ng phï hîp, kh«ng thÓ TÞnh Ho¸ lÇn 2")
        Talk(1, "no", "Hai Linh Thó nµy thuéc tÝnh kh«ng phï hîp, kh«ng thÓ TÞnh Ho¸ lÇn 2, h·y ®i t×m Linh Thó cã thuéc tÝnh ©m d­¬ng tr¸i ng­îc nhau.")
        PlayerIndex = oldPlayer
        return 0
    end

    PlayerIndex = oldPlayer
    return 1
end

function NewKindPet()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end

    MsgBox("NÕu b¹n cã 2 <c=g>Hoµng thñy tinh<c>, cã thÓ ®Õn ®©y nhËn thªm 1 ph©n th©n kh¸c.", "Yes_GetNewPet", "no")
end

function Yes_GetNewPet()
    CloseDialog()
    if (CheckPetIfEvolve() >= 4) then
        Talk(1, "no", "Linh Thó cña b¹n ®· cã <c=g>4 <c> ph©n th©n, kh«ng thÓ nhËn thªm n÷a. CÇn hñy 1 ph©n th©n hoÆc chuyÓn dêi cho ng­êi kh¸c míi cã thÓ nhËn ph©n th©n míi.")
        return
    end

    if (HaveNormalItem(3, 89, 0, 0) <= 1) then
        Talk(1, "no", "CÇn 2 <c=g>Hoµng thñy tinh<c>, míi cã thÓ gióp Linh Thó cña b¹n nhËn thªm ph©n th©n míi.")
        return
    end

    local kindlist = {
        "Tinh Minh Hå (Linh ho¹t)/SelNewKind",
        "§Ëu §Ëu Quy (ThÓ chÊt)/SelNewKind",
        "Tra Tra §iÓu (Th©n ph¸p)/SelNewKind",
        "BiÕn S¾c Long (Søc m¹nh)/SelNewKind"
    }

    Say("H·y chän lo¹i ph©n th©n.", table.getn(kindlist), kindlist)
end

function SelNewKind(n)
    CloseDialog()
    if (HaveNormalItem(3, 89, 0, 0) <= 1) then
        Talk(1, "no", "CÇn 2 <c=g>Hoµng thñy tinh<c>, míi cã thÓ gióp Linh Thó cña b¹n nhËn thªm ph©n th©n míi.")
        return
    end
    DelNormalItem(3, 89, 0, 0)
    DelNormalItem(3, 89, 0, 0)
    PetEvolve(n + 1)
    WriteLog(GetName() .. "NhËn 1 lo¹i ph©n th©n" .. n)
    Talk(1, "no", "Chóc mõng b¹n nhËn thµnh c«ng 1 Linh Thó ph©n th©n míi.")

end

function PetForget()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end
    MsgBox("B¹n cã thÓ hñy 1 ph©n th©n cña Linh Thó, cÇn l­u ý khi ®· hñy sÏ kh«ng thÓ t×m l¹i ph©n th©n nµy. X¸c ®Þnh hñy?", "Yes_Forget", "no")
end

function Yes_Forget()
    CloseDialog()
    if (CheckPetIfEvolve() < 2) then
        Talk(1, "no", "Linh Thó cña b¹n cÇn ph¶i gi÷ l¹i tèi thiÓu 1 ph©n th©n.")
        return
    end

    local kindlist = {}
    local nOpenSlotNum = CheckPetIfEvolve()
    for i = 1, nOpenSlotNum do
        kindlist[i] = "Ph©n th©n" .. i .. "/SelForgetKind"
    end

    Say("H·y chän ph©n th©n muèn hñy:", table.getn(kindlist), kindlist)
end

function SelForgetKind(n)
    CloseDialog()

    local nFeedValue = GetEvolvePetFeedValue()
    SetTask(ballID, n)
    MsgBox("B¹n muèn Linh Thó cña b¹n hñy ph©n th©n nµy?", "Yes_Forget1", "no")
end

function Yes_Forget1()
    CloseDialog()
    ModifyEvolvePetRebornNum(-1)
    local n = GetTask(ballID)
    ForgetKindPet(n)

    for i = n + 1, 3 do
        local nTimes = GetTaskByte(KindPet_FeedTime, i + 1)
        SetTaskByte(KindPet_FeedTime, i, nTimes)
    end

    Talk(1, "no", "Linh Thó cña b¹n ®· hñy thµnh c«ng ph©n th©n nµy.")
    WriteLog(GetName() .. "Hñy Linh Thó")
end

function PetTrade()
    CloseDialog()

    MsgBox("Ta cã thÓ gióp ®éi tr­ëng chuyÓn Linh Thó ph©n th©n cña m×nh cho ®ång ®éi ®· cã Linh Thó ph©n th©n. X¸c ®Þnh chuyÓn?", "Yes_Trade", "no")
end

function Yes_Trade()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end

    if (IsCaptain() ~= 1) then
        Msg2Team("CÇn tæ ®éi hai ng­êi, ®éi tr­ëng sÏ tÆng Linh Thó ph©n th©n.")
        Talk(1, "no", "§éi tr­ëng míi ®­îc tÆng Linh Thó ph©n th©n.")
        return
    end

    if (IsCanTrade() == 0) then

        return
    end

    local kindlist = {}
    local nOpenSlotNum = CheckPetIfEvolve()
    for i = 1, nOpenSlotNum do
        kindlist[i] = "Ph©n th©n" .. i .. "/SelTradeKind"
    end

    Say("H·y chän ph©n th©n muèn tÆng", table.getn(kindlist), kindlist)
end

function SelTradeKind(n)
    local oldPlayer = PlayerIndex

    local myPartner = 0
    if (PlayerIndex == GetTeamMember(1)) then
        myPartner = GetTeamMember(2)
    else
        myPartner = GetTeamMember(1)
    end

    local nSlot = GetColorPetSlot()
    if ((nSlot >= 0) and (nSlot < 4)) then
        if (n == nSlot) then
            PlayerIndex = myPartner
            local partnerSlot = GetColorPetSlot()
            if ((partnerSlot >= 0) and (partnerSlot < 4)) then
                Msg2Team(GetName() .. " ®· cã 1 Thiªn H¹ §Ö NhÊt B¶o B¶o.")
                PlayerIndex = oldPlayer
                Talk(1, "no", "§èi ph­¬ng ®· cã 1 Thiªn H¹ §Ö NhÊt B¶o B¶o, kh«ng thÓ nhËn thªm.")
                return
            else
                PlayerIndex = oldPlayer
            end
        end
    end

    SetTask(140, n)
    SetTeamTask(Team_Type, 2)
    SetTeamTask(Team_CaptainID, GetPlayerID())
    SetTeamTask(Team_Captain_Index, oldPlayer)
    TeamAction("askPartnerTrade", myPartner, 0, 0)
end

function askPartnerTrade(nParam)
    if (nParam == PlayerIndex) then
        local oldPlayer = PlayerIndex
        local nameStr = ""

        if (PlayerIndex == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end

        if (PlayerIndex > 0) then
            nameStr = GetName()
        end

        PlayerIndex = oldPlayer

        local myPartner = 0
        if (PlayerIndex == GetTeamMember(1)) then
            myPartner = GetTeamMember(2)
        else
            myPartner = GetTeamMember(1)
        end

        SetTask(140, myPartner)

        MsgBox("Ng­êi ch¬i " .. nameStr .. " muèn tÆng 1 ph©n th©n cho Linh Thó cña b¹n, ®ång ý kh«ng?", "agreeRequestPetTrade", "refuseRequest")

    end
end

function agreeRequestPetTrade()
    CloseDialog()
    local oldPlayer = PlayerIndex

    if (IsCanTrade() == 0) then

        return
    end

    local name1 = GetName()
    if (oldPlayer == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end
    local name2 = GetName()

    if (GetPlayerID() ~= GetTeamTask(Team_CaptainID)) or (GetTeamTask(Team_Type) ~= 2) then
        Msg2Team("Trong qu¸ tr×nh tÆng Linh Thó ph©n th©n kh«ng thÓ ®æi quyÒn ®éi tr­ëng, hoÆc thay ®æi nhãm.")
        PlayerIndex = oldPlayer
        return
    end

    if (IsCanTrade() == 0) then
        PlayerIndex = oldPlayer
        return
    end

    local nTrade_Pet_Slot = GetTask(140)
    TradeKindPet(oldPlayer, nTrade_Pet_Slot)

    local nFeedTimes = GetTaskByte(KindPet_FeedTime, nTrade_Pet_Slot + 1)
    for i = nTrade_Pet_Slot + 1, 3 do
        local nTimes = GetTaskByte(KindPet_FeedTime, i + 1)
        SetTaskByte(KindPet_FeedTime, i, nTimes)
    end

    nTrade_Pet_Slot = nTrade_Pet_Slot + 1
    Msg2Player("Linh Thó cña b¹n ®· mÊt 1 ph©n th©n")
    Talk(1, "no", "B¹n ®· chuyÓn thµnh c«ng 1 ph©n th©n cho Linh Thó cña ng­êi ch¬i kh¸c.")
    WriteLog("[" .. name2 .. "]ËÍ[" .. name1 .. "]1 c¸i Áé³è·ÖÉí" .. nTrade_Pet_Slot)

    PlayerIndex = oldPlayer

    local nNewSlot = GetPetSlot()
    SetTaskByte(KindPet_FeedTime, nNewSlot + 1, nFeedTimes)
    SetTask(item_petLasttime, LocalSystemTime())

    Msg2Player("B¹n nhËn ®­îc 1 Linh Thó ph©n th©n")
    Talk(1, "no", "Linh Thó cña b¹n nhËn thµnh c«ng Linh Thó ph©n th©n do ®éi tr­ëng tÆng.")
end

function IsCanTrade()
    local nTeam = GetTeamSize()

    if (nTeam ~= 2) and (nTeam > 0) then
        Msg2Team("Nhãm cña c¸c ng­¬i kh«ng ph¶i nhãm 2 ng­êi.")
        Talk(1, "no", "CÇn tæ ®éi hai ng­êi míi cã thÓ tiÕn hµnh.")
        return 0
    elseif (nTeam == 0) then
        Talk(1, "no", "CÇn tæ ®éi hai ng­êi míi cã thÓ tÆng Linh Thó ph©n th©n.")
        return 0
    end

    local oldPlayer = PlayerIndex
    for i = 1, nTeam do
        PlayerIndex = GetTeamMember(i)

        local nNowTime = LocalSystemTime()
        if (math.floor(GetTask(item_petLasttime) / 86400) ~= math.floor(nNowTime / 86400)) then

            SetTask(KindPet_FeedTime, 0)

        end

        if (GetTask(KindPet_FeedTime) ~= 0 or math.floor(GetTask(item_petLasttime) / 86400) == math.floor(nNowTime / 86400)) then
            Msg2Team(GetName() .. "-Linh Thó ®· cho ¨n, kh«ng thÓ giao dÞch")
            PlayerIndex = oldPlayer
            return 0
        end

        if (PetIsSleep() == 1) then
            Msg2Team(GetName() .. "-Linh Thó ®ang ë tr¹ng th¸i ngñ")
            Talk(1, "no", "Linh Thó ®ang ë tr¹ng th¸i ngñ.")
            PlayerIndex = oldPlayer
            return 0
        end

        if (CheckPetIfEvolve() == 0) then
            Msg2Team(GetName() .. "-Linh Thó kh«ng TÞnh Ho¸.")
            Talk(1, "no", "B¹n ph¶i Linh Thó ®· tÞnh ho¸ míi cã thÓ nhËn Linh Thó ph©n th©n tõ ®èi ph­¬ng.")
            PlayerIndex = oldPlayer
            return 0
        end
        local w1, x1, y1 = GetWorldPos()

        if (w1 ~= 20 or CheckDis(x1, y1) == 0) then
            Msg2Team(GetName() .. "C¸ch ThÇy t­íng sè T©y Kú qu¸ xa")
            PlayerIndex = oldPlayer
            Talk(1, "no", "§ång ®éi c¸ch b¹n qu¸ xa.")
            return 0
        end

        if (IsCaptain() ~= 1 and CheckPetIfEvolve() >= 4) then
            Msg2Team(GetName() .. " ®· cã 4 Linh Thó ph©n th©n, kh«ng thÓ nhËn thªm")
            Talk(1, "no", "B¹n ®· cã 4 Linh Thó ph©n th©n, kh«ng thÓ nhËn thªm.")
            PlayerIndex = oldPlayer
            return 0
        end

        if (IsCaptain() == 1 and CheckPetIfEvolve() < 2) then
            Msg2Team(GetName() .. "Kh«ng cã Linh Thó ph©n th©n tÆng")
            Talk(1, "no", "B¹n chØ cã 1 Linh Thó ph©n th©n, kh«ng thÓ tÆng ng­êi kh¸c.")
            PlayerIndex = oldPlayer
            return 0
        end
    end

    PlayerIndex = oldPlayer
    return 1
end

function ResetFeedValue()
    CloseDialog()
    MsgBox("X¸c nhËn t¸i thiÕt lËp ®iÓm TÞnh Ho¸ cña Linh Thó ph©n th©n nµy? CÇn 1 <c=g>Hçn ®én phï<c>.", "Yes_ResetFeedValue", "no")
end

function Yes_ResetFeedValue()
    CloseDialog()
    if (PetIsSleep() == 1) then
        Msg2Player("Linh thó cña ng­¬i ®ang ngñ!")
        Talk(1, "no", "Linh thó cña b¹n ®ang ngñ.")
        return
    end
    if (HaveNormalItem(8, 903, 2, 0) <= 0) then
        Talk(1, "no", "B¹n kh«ng cã Hçn ®én phï.")
        return
    end

    DelNormalItem(8, 903, 2, 0)
    PetResetFeedValue()
    local nCon = GetEvolvePetConstitution()
    local nInt = GetEvolvePetIntellect()
    local nDex = GetEvolvePetDexterity()
    local nStr = GetEvolvePetStrength()

    local nSlot = GetColorPetSlot()
    if ((nSlot >= 0) and (nSlot < 4) and (GetPetSlot() == nSlot)) then
        ModifyEvolvePetStrength(1)
        ModifyEvolvePetDexterity(1)
        ModifyEvolvePetConstitution(1)
        ModifyEvolvePetIntellect(1)
        Talk(1, "no", "§iÓm TÞnh Ho¸ cña Linh Thó ph©n th©n bÞ xãa, thuéc tÝnh còng trë vÒ trÞ ban ®Çu. HiÖn thuéc tÝnh lµ: <enter>Søc m¹nh <c=g>" .. nStr .. "(+1)<c> ®iÓm<enter>Th©n ph¸p <c=g>" .. nDex .. "(+1)<c> ®iÓm<enter>Linh ho¹t <c=g>" .. nInt .. "(+1)<c> ®iÓm<enter>ThÓ chÊt <c=g>" .. nCon .. "(+1)<c> ®iÓm")
    else
        Talk(1, "no", "§iÓm TÞnh Ho¸ cña Linh Thó ph©n th©n bÞ xãa, thuéc tÝnh còng trë vÒ trÞ ban ®Çu. HiÖn thuéc tÝnh lµ: <enter>Søc m¹nh <c=g>" .. nStr .. "<c> ®iÓm<enter>Th©n ph¸p <c=g>" .. nDex .. "<c> ®iÓm<enter>Linh ho¹t <c=g>" .. nInt .. "<c> ®iÓm<enter>ThÓ chÊt <c=g>" .. nCon .. "<c>")
    end

end

function ResetApt()
    MsgBox("§­a ta 1 <c=g>Thiªn Tiªn Qu¶<c> hoÆc <c=g>15 Th«ng B¶o<c> cã thÓ gióp thay ®æi t­ chÊt cña Linh Thó, ®ång ý kh«ng?", "Yes_RandomApt", "no")
    RandomApt()
end

function Ball()
    CloseDialog()
    tasksN = {
        { "Gi¸m ®Þnh", "modifyball"; show = 1 },
        { "Hoµn nguyªn", "returnball"; show = 1 },
        { "Giíi thiÖu", "showball"; show = 1 }
    }
    SayTask("<c=g>Kü n¨ng Néi §¬n<c> phèi hîp víi <c=g>s¸ch kü n¨ng<c> t­¬ng øng cã thÓ gióp Linh Thó ph©n th©n häc ®­îc kü n¨ng míi hoÆc n©ng cÊp kü n¨ng ®· häc, tõ ®ã n©ng cÊp kü n¨ng cña chñ nh©n.<enter><c=g>Chó ý<c>: kü n¨ng Néi §¬n cã ®­îc th«ng qua <c=g>Gi¸m ®Þnh Néi §¬n<c>, nÕu kh«ng hµi lßng víi kü n¨ng Néi §¬n, cã thÓ dïng <c=g>Hoµn nguyªn Néi §¬n<c> gi¸m ®Þnh l¹i.", tasksN)
end

arrCareerSkillNameID = {
    { name = "Ch­ëng T©m L«i", id = 3, itemid = 487, bookid = 0 },
    { name = "L­u Tinh Th¹ch", id = 4, itemid = 488, bookid = 1 },
    { name = "B¨ng TuyÕt ®¹n", id = 5, itemid = 489, bookid = 2 },
    { name = "TÝch LÞch Háa", id = 6, itemid = 490, bookid = 3 },
    { name = "Tinh Th«ng L«i HÖ", id = 7, itemid = 491, bookid = 4 },
    { name = "Thiªn Phong §Þa NhËn", id = 8, itemid = 492, bookid = 5 },
    { name = "B¨ng C¬ TuyÕt Cèt", id = 9, itemid = 493, bookid = 6 },
    { name = "Phong l©m háa s¬n", id = 10, itemid = 494, bookid = 7 },
    { name = "H¹n §Þa L«i", id = 11, itemid = 495, bookid = 8 },
    { name = "Tinh Th«ng Thæ HÖ", id = 12, itemid = 496, bookid = 9 },
    { name = "ThiÕt M· B¨ng Qua", id = 13, itemid = 497, bookid = 10 },
    { name = "Tinh Th«ng Háa HÖ", id = 14, itemid = 498, bookid = 11 },
    { name = "Phong V©n L«i §éng", id = 15, itemid = 499, bookid = 12 },
    { name = "Ngò Nh¹c TriÒu T«ng", id = 16, itemid = 500, bookid = 13 },
    { name = "Tinh Th«ng B¨ng HÖ", id = 17, itemid = 501, bookid = 14 },
    { name = "ThËp Ph­¬ng LiÖt Háa", id = 18, itemid = 502, bookid = 15 },
    { name = "L«i Phong Gi¸p", id = 19, itemid = 503, bookid = 16 },
    { name = "Thiªn B¨ng ®Þa liÖt", id = 20, itemid = 504, bookid = 17 },
    { name = "B¨ng Phong B¹o", id = 21, itemid = 505, bookid = 18 },
    { name = "Chóc Dung Ch©n KhÝ", id = 22, itemid = 506, bookid = 19 },
    { name = "L«i §éng Cöu thiªn", id = 23, itemid = 507, bookid = 20 },
    { name = "HuyÒn N÷ Bæ Thiªn", id = 24, itemid = 508, bookid = 21 },
    { name = "B¨ng Phong V¹n Lý", id = 25, itemid = 509, bookid = 22 },
    { name = "Tam Muéi Ch©n Háa", id = 26, itemid = 510, bookid = 23 },
    { name = "TÕ HuyÕt tr¶m", id = 27, itemid = 511, bookid = 24 },
    { name = "L¨ng Ba Vi Bé", id = 28, itemid = 512, bookid = 25 },
    { name = "Khai s¬n tr¶m", id = 29, itemid = 513, bookid = 26 },
    { name = "Håi Phong Tr¶m", id = 30, itemid = 514, bookid = 27 },
    { name = "§iÖn Quang Tr¶m", id = 31, itemid = 515, bookid = 28 },
    { name = "Hoµnh Kh«ng Tr¶m", id = 32, itemid = 516, bookid = 29 },
    { name = "Tinh Th«ng §o¶n §ao", id = 33, itemid = 517, bookid = 30 },
    { name = "Tinh Th«ng Tr­êng §ao", id = 34, itemid = 518, bookid = 31 },
    { name = "Tam §Çu Lôc Thñ", id = 35, itemid = 519, bookid = 32 },
    { name = "HuyÒn B¨ng tr¶m", id = 36, itemid = 520, bookid = 33 },
    { name = "Háa Quang Tr¶m", id = 37, itemid = 521, bookid = 34 },
    { name = "Liªn Hoµn Tr¶m", id = 38, itemid = 522, bookid = 35 },
    { name = "L¹c §Þa Tr¶m", id = 39, itemid = 523, bookid = 36 },
    { name = "ThuÇn D­¬ng Hé ThÓ", id = 40, itemid = 524, bookid = 37 },
    { name = "Thiªn Qu©n Tr¶m", id = 41, itemid = 525, bookid = 38 },
    { name = "Khuynh Thµnh NhÊt KÝch", id = 42, itemid = 526, bookid = 39 },
    { name = "Kim Cang chó", id = 43, itemid = 527, bookid = 40 },
    { name = "Th«i Th©n Chó", id = 44, itemid = 528, bookid = 41 },
    { name = "Bæ T©m Chó", id = 45, itemid = 529, bookid = 42 },
    { name = "C­êng C«ng chó", id = 46, itemid = 530, bookid = 43 },
    { name = "Ph¸ Gi¸p chó", id = 47, itemid = 531, bookid = 44 },
    { name = "Bå §Ò chó", id = 48, itemid = 532, bookid = 45 },
    { name = "Tr¶m T©m Chó", id = 49, itemid = 533, bookid = 46 },
    { name = "TËt Phong chó", id = 50, itemid = 534, bookid = 47 },
    { name = "V¹n Cèt Toµn Kh«", id = 51, itemid = 535, bookid = 48 },
    { name = "Lùc SÜ tÕ", id = 450, itemid = 536, bookid = 49 },
    { name = "Tr­êng Cung tÕ", id = 451, itemid = 537, bookid = 50 },
    { name = "Thiªn Vò tÕ", id = 452, itemid = 538, bookid = 51 },
    { name = "Liªn Nç TÕ", id = 453, itemid = 539, bookid = 52 },
    { name = "Háa L«i TÕ", id = 454, itemid = 540, bookid = 53 },
    { name = "To¸i Cèt tÕ", id = 455, itemid = 541, bookid = 54 },
    { name = "L­u Tinh tÕ", id = 456, itemid = 542, bookid = 55 },
    { name = "Truy Hån tÕ", id = 457, itemid = 543, bookid = 56 },
    { name = "Phong QuyÓn Tµn V©n", id = 458, itemid = 544, bookid = 57 },
}

function showball()
    CloseDialog()
    Talk(1, "no", "ËãÃüÏÈÉú: <c=g>ÄÚµ¤<c>¿ÉÒÔÍ¨¹ýÏûÃð<c=y>Ò°ÍâÍ·Áì<c> cïng <c=y>¶þÊ®°ËÐÇËÞ<c>»ñµÃ, ÐèÒª¼ø¶¨²ÅÄÜÊ¹ÓÃ.<enter> <c=g>1-30<c>¼¶µÄ¼¼ÄÜÄÚµ¤¿ÉÒÔÍ¨¹ý<c=y>µÍ¼¶ÄÚµ¤<c>¼ø¶¨µÃµ½<enter><c=g>31-60<c>¼¶µÄ¼¼ÄÜÄÚµ¤¿ÉÒÔÍ¨¹ý<c=y>ÖÐ¼¶ÄÚµ¤<c>¼ø¶¨µÃµ½<enter><c=g>61-90<c>¼¶µÄ¼¼ÄÜÄÚµ¤¿ÉÒÔÍ¨¹ý<c=y>¸ß¼¶ÄÚµ¤<c>¼ø¶¨µÃµ½<enter>")
end

function modifyball()
    CloseDialog()
    MsgBox("H·y chän <c=g>Néi §¬n<c> muèn gi¸m ®Þnh.", "selectball", "no")
end

function selectball()
    CloseDialog()
    MouseSelect(1, 6, "changeID", "no")
end

function changeID(itemID)
    local itemdel = GetItemDetail(itemID)
    local itemGen = GetItemGen(itemID)
    if (itemGen == 3) then
        SetTaskWord(ballID, 1, itemdel)
        selectedball()
    else
        Talk(1, "no", "Kh«ng ph¶i <c=g>Néi §¬n<c>, h·y chän<c=g>Néi §¬n (thÊp)<c>, <c=g>Néi §¬n (trung)<c> hoÆc <c=g>Néi §¬n (cao)<c>.")
    end
end

function selectedball()
    local itemdel = GetTaskWord(ballID, 1)
    if (itemdel == 554) then
        MsgBox("Muèn tr¶ 10 v¹n b¹c ®Ó gi¸m ®Þnh Néi §¬n (thÊp)?", "modifyballS", "no")
    elseif (itemdel == 555) then
        MsgBox("Muèn tr¶ 10 v¹n b¹c ®Ó gi¸m ®Þnh Néi §¬n (trung)?", "modifyballM", "no")
    elseif (itemdel == 556) then
        MsgBox("Muèn tr¶ 10 v¹n b¹c ®Ó gi¸m ®Þnh Néi §¬n (cao)?", "modifyballL", "no")
    else
        Talk(1, "no", "Kh«ng ph¶i <c=g>Néi §¬n<c>, h·y chän<c=g>Néi §¬n (thÊp)<c>, <c=g>Néi §¬n (trung)<c> hoÆc <c=g>Néi §¬n (cao)<c>.")
    end
end

function modifyballS()
    CloseDialog()
    if (HaveNormalItem(3, 554, 0, 0) <= 0) then
        WriteLog("Hack Néi §¬n (thÊp)")
        return
    end
    local r1 = 50
    local r2 = 40
    local r3 = 40
    local r4 = 40
    local r5 = 30
    local r6 = 40
    local r7 = 30
    local r8 = 40
    local r9 = 30
    local r10 = 80
    local r11 = 30
    local r12 = 80
    local r13 = 80
    local r14 = 60
    local r15 = 30
    local r16 = 30
    local r17 = 30
    local r18 = 80
    local r19 = 80
    local r20 = 80
    local itemID = 0
    if (GetCash() < 100000) then
        Talk(1, "no", "Xin lçi! B¹n kh«ng ®ñ b¹c.")
    else
        Pay(100000)
        i = math.random(1, 1000)
        if (i <= r1) then
            itemID = 487
        elseif (i <= r1 + r2) then
            itemID = 488
        elseif (i <= r1 + r2 + r3) then
            itemID = 489
        elseif (i <= r1 + r2 + r3 + r4) then
            itemID = 490
        elseif (i <= r1 + r2 + r3 + r4 + r5) then
            itemID = 491
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6) then
            itemID = 492
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7) then
            itemID = 493
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8) then
            itemID = 494
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9) then
            itemID = 495
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10) then
            itemID = 511
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11) then
            itemID = 512
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12) then
            itemID = 513
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13) then
            itemID = 514
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14) then
            itemID = 515
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15) then
            itemID = 527
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16) then
            itemID = 528
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17) then
            itemID = 529
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17 + r18) then
            itemID = 536
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17 + r18 + r19) then
            itemID = 537
        else
            itemID = 538
        end
        local n = itemID - 486
        DelNormalItem(3, 554, 0, 0)
        AddNormalItem(3, itemID, 0, 0, 0, 0)
        SetTaskWord(ballID, 2, itemID)
        MsgBox("§­îc 1 <c=g>Néi §¬n-" .. arrCareerSkillNameID[n].name .. "<c>. Tr¶ <c=g>9 Th«ng B¶o<c> ®Ó Hoµn nguyªn Néi §¬n (thÊp)?", "backballS", "no")
    end
end

function modifyballM()
    CloseDialog()
    if (HaveNormalItem(3, 555, 0, 0) <= 0) then
        WriteLog("Hack Néi §¬n (trung)")
        return
    end
    local r1 = 20
    local r2 = 90
    local r3 = 15
    local r4 = 90
    local r5 = 90
    local r6 = 20
    local r7 = 15
    local r8 = 70
    local r9 = 15
    local r10 = 15
    local r11 = 120
    local r12 = 110
    local r13 = 15
    local r14 = 20
    local r15 = 25
    local r16 = 90
    local r17 = 90
    local r18 = 90
    local itemID = 0
    if (GetCash() < 100000) then
        Talk(1, "no", "Xin lçi! B¹n kh«ng ®ñ b¹c.")
    else
        Pay(100000)
        i = math.random(1, 1000)
        if (i <= r1) then
            itemID = 496
        elseif (i <= r1 + r2) then
            itemID = 497
        elseif (i <= r1 + r2 + r3) then
            itemID = 498
        elseif (i <= r1 + r2 + r3 + r4) then
            itemID = 499
        elseif (i <= r1 + r2 + r3 + r4 + r5) then
            itemID = 500
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6) then
            itemID = 501
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7) then
            itemID = 502
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8) then
            itemID = 516
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9) then
            itemID = 517
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10) then
            itemID = 518
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11) then
            itemID = 519
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12) then
            itemID = 520
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13) then
            itemID = 530
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14) then
            itemID = 531
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15) then
            itemID = 532
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16) then
            itemID = 539
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17) then
            itemID = 540
        else
            itemID = 541
        end
        local n = itemID - 486
        DelNormalItem(3, 555, 0, 0)
        AddNormalItem(3, itemID, 0, 0, 0, 0)
        SetTaskWord(ballID, 2, itemID)
        MsgBox("§­îc 1 <c=g>Néi §¬n-" .. arrCareerSkillNameID[n].name .. "<c>. Tr¶ <c=g>9 Th«ng B¶o<c> ®Ó Hoµn nguyªn Néi §¬n (trung)?", "backballM", "no")
    end
end

function modifyballL()
    CloseDialog()
    if (HaveNormalItem(3, 556, 0, 0) <= 0) then
        WriteLog("Hack Néi §¬n (cao)")
        return
    end
    local r1 = 60
    local r2 = 60
    local r3 = 60
    local r4 = 30
    local r5 = 30
    local r6 = 50
    local r7 = 40
    local r8 = 10
    local r9 = 100
    local r10 = 120
    local r11 = 50
    local r12 = 30
    local r13 = 20
    local r14 = 10
    local r15 = 100
    local r16 = 30
    local r17 = 30
    local r18 = 80
    local r19 = 80
    local r20 = 10
    local itemID = 0
    if (GetCash() < 100000) then
        Talk(1, "no", "Xin lçi! B¹n kh«ng ®ñ b¹c.")
    else
        Pay(100000)
        i = math.random(1, 1000)
        if (i <= r1) then
            itemID = 503
        elseif (i <= r1 + r2) then
            itemID = 504
        elseif (i <= r1 + r2 + r3) then
            itemID = 505
        elseif (i <= r1 + r2 + r3 + r4) then
            itemID = 506
        elseif (i <= r1 + r2 + r3 + r4 + r5) then
            itemID = 507
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6) then
            itemID = 508
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7) then
            itemID = 509
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8) then
            itemID = 510
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9) then
            itemID = 521
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10) then
            itemID = 522
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11) then
            itemID = 523
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12) then
            itemID = 524
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13) then
            itemID = 525
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14) then
            itemID = 526
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15) then
            itemID = 533
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16) then
            itemID = 534
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17) then
            itemID = 535
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17 + r18) then
            itemID = 542
        elseif (i <= r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17 + r18 + r19) then
            itemID = 543
        else
            itemID = 544
        end
        local n = itemID - 486
        DelNormalItem(3, 556, 0, 0)
        AddNormalItem(3, itemID, 0, 0, 0, 0)
        SetTaskWord(ballID, 2, itemID)
        MsgBox("§­îc 1 <c=g>Néi §¬n-" .. arrCareerSkillNameID[n].name .. "<c>. Tr¶ <c=g>9 Th«ng B¶o<c> ®Ó Hoµn nguyªn Néi §¬n (cao)?", "backballL", "no")
    end
end

function returnball()
    CloseDialog()
    MsgBox("H·y chän <c=g>kü n¨ng Néi §¬n<c> muèn hoµn nguyªn.", "returnball1", "no")
end

function returnball1()
    CloseDialog()
    MouseSelect(1, 6, "changeskillID", "no")
end

function changeskillID(itemID)
    local itemdel = GetItemDetail(itemID)
    local itemGen = GetItemGen(itemID)
    if (itemGen == 3) then
        SetTaskWord(ballID, 2, itemdel)
        Selectedskillball()
    else
        Talk(1, "no", "§©y kh«ng ph¶i <c=g>kü n¨ng Néi §¬n<c>.")
    end
end

function Selectedskillball()
    local itemdel = GetTaskWord(ballID, 2)
    if ((itemdel > 486 and itemdel < 496) or (itemdel > 510 and itemdel < 516) or (itemdel > 526 and itemdel < 530) or (itemdel > 535 and itemdel < 539)) then
        MsgBox("Tr¶ <c=g>9 Th«ng B¶o<c> hoÆc <c=g>Linh Quang KÝnh<c> ®Ó hoµn nguyªn <c=g>kü n¨ng Néi §¬n<c> thµnh <c=g>Néi §¬n (thÊp)<c>?", "backballS", "no")
    elseif ((itemdel > 495 and itemdel < 503) or (itemdel > 515 and itemdel < 521) or (itemdel > 529 and itemdel < 533) or (itemdel > 538 and itemdel < 542)) then
        MsgBox("Tr¶ <c=g>9 Th«ng B¶o<c> hoÆc <c=g>Linh Quang KÝnh<c> ®Ó hoµn nguyªn <c=g>kü n¨ng Néi §¬n<c> thµnh <c=g>Néi §¬n (trung)<c>?", "backballM", "no")
    elseif ((itemdel > 502 and itemdel < 511) or (itemdel > 520 and itemdel < 527) or (itemdel > 532 and itemdel < 536) or (itemdel > 541 and itemdel < 545)) then
        MsgBox("Tr¶ <c=g>9 Th«ng B¶o<c> hoÆc <c=g>Linh Quang KÝnh<c> ®Ó hoµn nguyªn <c=g>kü n¨ng Néi §¬n<c> thµnh <c=g>Néi §¬n (cao)<c>?", "backballL", "no")
    else
        Talk(1, "no", "§©y kh«ng ph¶i <c=g>kü n¨ng Néi §¬n<c>.")
    end
end

function backballS()
    CloseDialog()
    local itemdel = GetTaskWord(ballID, 2)
    if ((GetCoin() < 900) and (HaveNormalItem(8, 1026, 2, 0) <= 0)) then
        Talk(1, "no", "B¹n cÇn 1 <c=g>Linh Quang KÝnh<c> hoÆc <c=g>9 Th«ng B¶o<c> ®Ó hoµn nguyªn.")
        return
    end

    if (HaveNormalItem(3, itemdel, 0, 0) <= 0) then
        return
    end

    if (HaveNormalItem(8, 1026, 2, 0) > 0) then
        DelNormalItem(8, 1026, 2, 0)
    else
        CostCoinByIdx(136)
    end
    DelNormalItem(3, itemdel, 0, 0)
    AddNormalItem(3, 554, 0, 0, 0, 0)
    SetTaskWord(ballID, 1, 554)
    selectedball()
end

function backballM()
    CloseDialog()
    local itemdel = GetTaskWord(ballID, 2)
    if ((GetCoin() < 900) and (HaveNormalItem(8, 1026, 2, 0) <= 0)) then
        Talk(1, "no", "B¹n cÇn 1 <c=g>Linh Quang KÝnh<c> hoÆc <c=g>9 Th«ng B¶o<c> ®Ó hoµn nguyªn.")
        return
    end

    if (HaveNormalItem(3, itemdel, 0, 0) <= 0) then
        return
    end

    if (HaveNormalItem(8, 1026, 2, 0) > 0) then
        DelNormalItem(8, 1026, 2, 0)
    else
        CostCoinByIdx(136)
    end
    DelNormalItem(3, itemdel, 0, 0)
    AddNormalItem(3, 555, 0, 0, 0, 0)
    SetTaskWord(ballID, 1, 555)
    selectedball()
end

function backballL()
    CloseDialog()
    local itemdel = GetTaskWord(ballID, 2)
    if ((GetCoin() < 900) and (HaveNormalItem(8, 1026, 2, 0) <= 0)) then
        Talk(1, "no", "B¹n cÇn 1 <c=g>Linh Quang KÝnh<c> hoÆc <c=g>9 Th«ng B¶o<c> ®Ó hoµn nguyªn.")
        return
    end

    if (HaveNormalItem(3, itemdel, 0, 0) <= 0) then
        return
    end

    if (HaveNormalItem(8, 1026, 2, 0) > 0) then
        DelNormalItem(8, 1026, 2, 0)
    else
        CostCoinByIdx(136)
    end
    DelNormalItem(3, itemdel, 0, 0)
    AddNormalItem(3, 556, 0, 0, 0, 0)
    SetTaskWord(ballID, 1, 556)
    selectedball()
end

Task_Wedlock = 1527

Task_Active_Totem = 1528

TIME_DEFINE = 3
BUFFID = 762

QuestkeyStone = 266
QuestkeyFire = 268
Questkeyflower = 267
HoneyGirl = 1214

TaskNoteIndex = 1092

TotemInfo = {
    [1] = { name = "VËt tæ Th©n T×nh", templateID = 1216 },
    [2] = { name = "VËt tæ H÷u T×nh", templateID = 1217 },
    [3] = { name = "VËt tæ ¸i T×nh", templateID = 1218 },
    [4] = { name = "VËt tæ Cõu HËn", templateID = 1219 },
    [5] = { name = "VËt tæ ThÕ Tôc", templateID = 1220 }
}

TotemSequence = {
    [1] = { 4, 1, 5, 3, 2 },
    [2] = { 1, 5, 3, 2, 4 },
    [3] = { 3, 2, 5, 4, 1 },
    [4] = { 5, 4, 1, 2, 3 }
}

function isViewWedlock()
    if (GetTaskBit(1377, 2) == 1) and (GetLevel() >= 24) and (GetTaskByte(Task_Wedlock, 1) == 0) then
        return 1
    else
        return 0
    end
end

function wedlock()
    CloseDialog()
    if (GetTaskByte(Task_Wedlock, 1) ~= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(1) ~= 1) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ chç trèng, cÇn 1 « trèng ®Ó b¾t ®Çu nhiÖm vô.")
        return
    end

    local linkPos = "<HyperLinkWorldPos=\"áªÉ½[17,222,215]\">"

    SetTaskByte(Task_Wedlock, 1, 1)
    AddEventItem(QuestkeyStone)
    Talk(4, "no", "Anh hïng tr¶i qua nhiÒu kiÕp lu©n håi, do uèng Canh M¹nh Bµ nªn ®· mÊt hÕt ký øc. Song Tam Sinh Th¹ch cña N÷ Oa N­¬ng N­¬ng vÉn cßn ghi l¹i t×nh duyªn cña ng­¬i, niÖm t×nh c¸c ng­¬i son s¾t mÆn nång, ta cho ng­¬i m­în dïng 1 lóc.", "Tam Sinh Th¹ch tr¶i qua nhiÒu kiÕp, linh lùc ®· dÇn mÊt ®i.", "Mong tiªn sinh chØ d¹y.", "T©y V­¬ng MÉu biÕt anh hïng ®ang gÆp khã kh¨n, ®· cho t× n÷ Liªn BÝch ®Õn Kú S¬n gióp anh hïng håi phôc linh lùc cña Tam Sinh Th¹ch.")
    TopMessage("NhËn ®­îc Tam Sinh Th¹ch")
    Msg2Player("B¹n nhËn ®­îc Tam Sinh Th¹ch. T×m Liªn BÝch <c=g>" .. linkPos .. "<c> håi phôc ph¸p lùc cña Tam Sinh Th¹ch")

    TaskNote(TaskNoteIndex, 1)

    SetSubTask(TaskNoteIndex, 1, 1)
    refreshNpcTaskState()
end

function divination()
    CloseDialog()

    local labelType = {
        { "CÇu tµi vËn", "getMoney"; show = 1 },
        { "CÇu c¸t hung", "liveSafe"; show = 1 },
        { "CÇu nh©n duyªn", "propose"; show = 1 }
    }
    local step = GetTaskByte(Task_Divination, 1)
    if (step == 1) then
        MsgBox("L·o phu 1 ®êi nghiªn cøu t­íng sè, biÕt kiÕp tr­íc kiÕp nµy, biÕt c¸t hung häa ph­íc, nh­ng bÞ tiÓu nh©n ¸m h¹i, bÞ h¹ ®éc mï 2 m¾t, hy väng anh hïng cã thÓ ®Õn chç <c=g>Nam Cùc Tiªn ¤ng<c> xin lÊy <c=r>Cöu ChuyÓn Tiªn §¬n<c>.", "yes_divination", "no")
        return
    end

    if (step >= 2 and step <= 4) then
        Talk(1, "no", " anh hïng ch­a xin vÒ <c=r>Cöu ChuyÓn Tiªn §¬n<c>, mong anh hïng mau ®i mau vÒ.")
        return
    end

    if (step == 5) then
        if (HaveEventItem(232) <= 0) then
            SetTaskByte(Task_Divination, 1, 2)
            SetTaskByte(Task_Divination, 2, 0)
            SetTaskByte(Task_Divination, 3, 0)
            SetTaskByte(Task_Divination, 4, 0)
            Talk(1, "no", " anh hïng ch­a xin vÒ <c=r>Cöu ChuyÓn Tiªn §¬n<c>, mong anh hïng mau ®i mau vÒ.")
            TaskNote(Task_Num, 1)
            refreshNpcTaskState()
            return
        end
        DelEventItem(232)
        SetTaskByte(Task_Divination, 1, 6)
        AddOwnExp(10000)
        Msg2Player("NhËn ®­îc 10000 kinh nghiÖm")
        SayTask(" anh hïng qu¶ nhiªn lµ ng­êi ch©n thËt, gióp ®«i m¾t ta s¸ng l¹i nh­ x­a, c¶m kÝch kh«ng t¶ xiÕt, l·o phu nguyÖn hÕt lßng v× anh hïng xñ 1 quÎ, kh«ng biÕt c¸c h¹ cÇu g×?", labelType)
        refreshNpcTaskState()
    end

    if (step == 6) then
        SayTask(" anh hïng qu¶ nhiªn lµ ng­êi ch©n thËt, gióp ®«i m¾t ta s¸ng l¹i nh­ x­a, c¶m kÝch kh«ng t¶ xiÕt, l·o phu nguyÖn hÕt lßng v× anh hïng xñ 1 quÎ, kh«ng biÕt c¸c h¹ cÇu g×?", labelType)
    end
end

function getMoney()
    CloseDialog()
    SetTaskByte(Task_Divination, 1, 7)
    SetTaskByte(Task_Label_Type, 1, 1)
    Talk(1, "no", "QuÎ hiÖn thÞ: N¹p tµi. Ng­êi ®­îc quÎ nµy, cã nhiÒu tµi vËn, h«m nay nªn mua b¸n giao dÞch, sÏ cã thu ho¹ch cao. <c=g>T©n Gi¸p<c> T©y Kú ®ang mua l­îng hµng lín, tin r»ng ©n c«ng t×m ®Õn h¾n sÏ ®­îc nhiÒu thu ho¹ch.")
    Msg2Player("T×m T©n Gi¸p ë T©y Kú.")
    TaskNote(Task_Num, 5)
    refreshNpcTaskState()
end

function liveSafe()
    CloseDialog()
    SetTaskByte(Task_Divination, 1, 7)
    SetTaskByte(Task_Label_Type, 1, 2)
    Talk(1, "no", "QuÎ hiÖn thÞ:HuyÕt quang. Ng­êi ®­îc quÎ nµy, e lµ cã kiÕp n¹n, nh­ng nÕu lµm viÖc tèt sÏ cã thÓ hãa hiÓm thµnh b×nh an. L·o phu nghe nãi <c=g>Kim Hµ §ång Tö<c> bÞ Tiªn thó lµm bÞ th­¬ng, ©n c«ng mau ®i t­¬ng trî, nguyÖn v­ît qua kiÕp n¹n nµy.")
    Msg2Player("T×m Kim Hµ §ång Tö ë Ngäc H­ Cung.")
    TaskNote(Task_Num, 6)
    refreshNpcTaskState()
end

function propose()
    CloseDialog()
    if (GetMorphType() == 364) or (GetMorphType() == 249) or (GetMorphType() == 420) or (GetMorphType() == 419) then
        Msg2Player("Trong tr¹ng th¸i nµy kh«ng thÓ nhËn ®­îc quÎ nh©n duyªn.")
        Talk(1, "no", "Trong tr¹ng th¸i nµy kh«ng thÓ nhËn ®­îc quÎ nh©n duyªn.")
        return
    end

    SetTaskWord(Task_Divination, 1, 7)
    SetTaskByte(Task_Label_Type, 1, 3)
    PolyMorph(249, 1, 0, -1, 1800)
    Talk(1, "no", "QuÎ hiÖn thÞ: Nghi s¾c. Ng­êi ®­îc quÎ nµy, hÊp dÉn v« h¹n, sÏ ®­îc ng­êi kh¸c giíi yªu mÕn. L·o phu ®· thay ®æi chót diÖn m¹o cña ©n c«ng, nh­ng ph¸p lùc chØ cã thÓ duy tr× 30 phót.")
    Msg2Player("NhËn ®­îc tr¹ng th¸i BiÕn th©n t×nh yªu")
    TaskNote(Task_Num, -1)
    refreshNpcTaskState()
end

function yes_divination()
    CloseDialog()
    local step = GetTaskByte(Task_Divination, 1)
    if (step == 1) then
        SetTaskByte(Task_Divination, 1, 2)
        SetTaskByte(Task_Divination, 2, 0)
        SetTaskByte(Task_Divination, 3, 0)
        SetTaskByte(Task_Divination, 4, 0)
        Talk(1, "no", GetName() .. "Ta lËp tøc tt×m <c=g>Nam Cùc Tiªn ¤ng<c> xin <c=r>Cöu ChuyÓn Tiªn §¬n<c>.")
        Msg2Player("T×m Nam Cùc Tiªn ¤ng")
        TaskNote(Task_Num, 1)
        refreshNpcTaskState()
    end
end

function renwu1()
    MsgBox(10468, "yes_1", "no")
end;

function yes_1()
    if (GetCash() >= 1000) then
        Talk(5, "no", 10469, 10470, 10471, 10472, 10473)
        Msg2Player("T×m Cao Minh hái th¨m vÞ trÝ cô thÓ cña m¶nh L­u Tinh, nhËn ®­îc B¸ L¹c Nh·n.")
        AddNormalItem(3, 29, 0, 0, 0, 0)
        Pay(1000)
        TaskNote(22, 1)
        SetTask(51, 2)
        refreshNpcTaskState()
    else
        Talk(1, "no", 10474)
    end ;
end;

function no()
    CloseDialog()
end;

exp_jiangli = { 1000, 2000, 3000, 4000, 6000 }

task_time = { "Duy tr× trong 10 phót", "Duy tr× trong 8 phót", "Duy tr× 6 phót" }
task_lingxi = { 10, 5 }
task_sel = 300
task_yuansu = {
    [1] = { 200, 30, 3 },
    [2] = { 450, 70, 3 },
}
map_idx = {
    [1] = { 22, 23, 24, 25, 26, { 331, 326, 327, 328 }, "Sa m¹c" },
    [2] = { 27, 28, 29, 30, 31, { 351, 342, 343, 344 }, "Hiªn Viªn §éng" },
    [3] = { 32, 33, 34, 35, 36, { 352, 345, 346, 347 }, "B¨ng Xuyªn" },
    [4] = { 37, 38, 39, 40, 41, { 353, 348, 349, 350 }, "§«ng H¶i" },
}
mapname = {
    [0] = "Mª Cung",
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong ThÇn",
    [25] = "Lôc Ch©u",
    [26] = "Sa M¹c chÕt",
    [27] = "Hiªn Viªn tÇng 1",
    [28] = "Hiªn Viªn tÇng 2",
    [29] = "Hiªn Viªn tÇng 3",
    [30] = "Hiªn Viªn tÇng 4",
    [31] = "Hiªn Viªn tÇng 5",
    [32] = "Ngäc TuyÒn",
    [33] = "TuyÕt Cèc",
    [34] = "§¹i Phong",
    [35] = "§¹i Th¹ch",
    [36] = "B¨ng Xuyªn Cùc",
    [37] = "Thñy Vùc",
    [38] = "Long Cung",
    [39] = "H¶i C©u",
    [40] = "Long Vùc",
    [41] = "Long Uyªn",
}

function into_sxlx()
    Talk(3, "no", 11940, " Muèn gi¶i cøu c¸c Tø Tinh cÇn ph¶i më <c=g>Linh Tª m«n<c>, vµo ma giíi cña ma v­¬ng tiªu diÖt hÕt bän l©u la, míi cã c¬ héi gi¶i tho¸t Tø Tinh. Më Linh Tª m«n ph¶i dïng 1 <c=yel>Tha S¬n Th¹ch vµ l­îng lín b¹c.", "Linh Tª m«n chØ duy tr× trong thêi gian nhÊt ®Þnh, B¹n cã thÓ lµm theo chØ dÉn vµ khiªu chiÕn yªu ma trong 5 tÇng Mª Cung. §¼ng cÊp nguyªn linh ®­îc phãng thÝch cµng cao, phÇn th­ëng ng­¬i nhËn ®­îc cµng nhiÒu. Mçi ngµy Linh Tª m«n chØ më 1 lÇn nh­ng cã <c=yel>ch×a khãa Linh Tª<c> sÏ gióp ng­¬i më Linh Tª m«n ®­îc nhiÒu lÇn h¬n!")
end

function renwu2()
    if (GetLevel() < 65) then
        CloseDialog()
        return 0
    end

    local key = tongguanjiangli()
    local temp = GetTaskByte(1021, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    local alltimes = GetTaskByte(1477, 3)

    if (key > 0) then
        if (key == 2) then
            MsgBox(11941, "jiangli", "no")
        else
            local w_map = mapname[GetTaskByte(1022, 1)]
            Talk(1, "no", "Linh Tª m«n chØ më trong thêi gian nhÊt ®Þnh! HiÖn ng­¬i cÇn ®i <c=r>" .. w_map .. "<c>, tiªu diÖt c¸c qu¸i vËt xung quanh, gi¶i tho¸t c¸c nguyªn linh bÞ chóng giam gi÷!")
        end
    elseif (times >= 4 and alltimes < addtimes) and (thisday == lastday) then
        Talk(1, "no", 11942)
        TaskNote(54, -1)
        SyncBibleState(54, 3, 1)
        refreshNpcTaskState()

    else
        local taskDay = GetWeekDay()
        if (GetGlobalValueByte(G_Double, 1) == 0) then
            SetTask(Double_Optimization, 0)
        end
        if (GetGlobalValueByte(G_Double, 1) == 1 and taskDay > GetTaskByte(Double_Optimization, 3)) then
            SetTaskByte(Double_Optimization, 3, 0)
        end

        if (GetGlobalValueByte(G_Double, 1) == 1 and GetTaskByte(Double_Optimization, 4) ~= taskDay and GetTaskByte(Double_Optimization, 1) < GetTaskByte(Double_Optimization, 2)) then
            MsgBox(" Ng­¬i tuÇn nµy cã <c=g>" .. GetTaskByte(Double_Optimization, 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· hÕt <c=g>" .. GetTaskByte(Double_Optimization, 1) .. "<c> ngµy. <c=r>H«m nay b¹n cã muèn nhËn phÇn th­ëng nh©n ®«i kh«ng?<c>", "Yes_AcceptDouble", "No_AcceptDouble")
            return 0
        end

        Accept_renwu2()
    end

end

function No_AcceptDouble()
    Talk(1, "Accept_renwu2", " NÕu ng­¬i kh«ng nhËn phÇn th­ëng nh©n ®«i tuÇn nµy, th× phÇn th­ëng nh©n ®«i cña ng­¬i sÏ tù ®éng mÊt ®i!")
end

function Yes_AcceptDouble()
    local nTimes = GetTaskByte(Double_Optimization, 1)
    local taskDay = GetWeekDay()

    SetTaskByte(Double_Optimization, 1, nTimes + 1)
    SetTaskByte(Double_Optimization, 3, taskDay)
    Accept_renwu2()

end

function Accept_renwu2()
    CloseDialog()
    local key = tongguanjiangli()
    local temp = GetTaskByte(1021, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    local alltimes = GetTaskByte(1477, 3)

    local taskDay = GetWeekDay()
    SetTaskByte(Double_Optimization, 4, taskDay)
    if (GetTask(1023) > task_sel) then
        local task1 = {
            "Sa m¹c/item_maze",
            "Hiªn Viªn §éng/item_maze",
            "B¨ng Xuyªn/item_maze",
            "§«ng H¶i/item_maze",
        }
        Say(" Sau khi hoµn thµnh <c=g>" .. task_sel .. "<c>, b¹n cã thÓ tïy ý chän nhiÖm vô", 4, task1)
    else
        local pm = payMoney()
        if (thisday ~= lastday) then
            MsgBox(" §ång ý ®­a ta 1 <c=g>Tha S¬n Th¹ch<c> vµ " .. pm .. " b¹c ®Ó ®i gi¶i cøu cho nguyªn linh chø?", "yiqiBuff_1", "no")
        else
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹p tµi tu luyÖn", "yiqiBuff_3"; show = 0 },
                { "Ch×a khãa Linh Tª", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end

            if (times <= 5) then
                task[2].show = 1
            end
            SayTask("HiÖn t¹i ng­êi tæng céng" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó më Linh tª m«n 1 <c=g>S¬n th¹ch<c> vµ" .. pm .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
        end ;
    end
end

function coin_renwu()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("Tø Linh")

    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName
    TaskNote(54, -1)
    local pm = payMoney()

    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        pm = pm * 0.9
    end

    local strValue = ""
    if (HaveNormalItem(8, 329, 2, 0) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox("Ph¸p lùc cña ta cã h¹n, kh«ng thÓ më cöa thø hai cña Linh Tª m«n, trõ khi cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", nÕu cã <c=yel>Ch×a khãa Linh Tª<c>, ta cã thÓ gióp ng­¬i!", "yiqiBuff_2", "no")
    elseif (GetCoin() >= Cv) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        strValue = "Ph¸p lùc cña ta cã h¹n, kh«ng thÓ më cöa thø hai cña Linh Tª m«n, trõ khi cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", nÕu cã <c=yel>Ch×a khãa Linh Tª<c>, ta cã thÓ gióp ng­¬i, chØ cÇn phÝ dông <c=yel>" .. PriceName .. " Th«ng B¶o<c>, ta sÏ dïng ch×a khãa thÇn bÝ gióp ng­¬i!"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        MsgBox(strValue, "yiqiBuff_2", "no")
    else
        local strValue = "Muèn tiÕp tôc më Linh Tª m«n cÇn cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", ngoµi ra cÇn cã <c=yel>Ch×a khãa Linh Tª hoÆc" .. Cfs .. " Th«ng B¶o<c>, chuÈn bÞ ®ñ vËt liÖu nhÐ!"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        Talk(1, "no", strValue)
    end
end

function item_maze(nIdx)
    nIdx = nIdx + 1
    SetTaskByte(1022, 3, nIdx)

    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    if (thisday ~= lastday) then
        yiqiBuff_1()
    else
        local temp = GetTaskByte(1021, 2)
        local times, addtimes = todayfreetimes(temp)
        local alltimes = GetTaskByte(1477, 3)
        local pm_free = payMoneyfree(addtimes)
        local pm = payMoney()
        local task = {
            { "N¹p tµi tu luyÖn", "yiqiBuff_3"; show = 0 },
            { "Ch×a khãa Linh Tª", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        else
            coin_renwu()
            return 0
        end

        if (times <= 5) then
            task[2].show = 1
        end
        SayTask("HiÖn t¹i ng­êi tæng céng" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó më Linh tª m«n 1 <c=g>S¬n th¹ch<c> vµ" .. pm .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
    end
end

function yiqiBuff_1()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox(" Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_1", "yes1")
    else
        yes1()
    end
end

function costYiqi_1()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes1()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_2()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox(" Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_2", "yes2")
    else
        yes2()
    end
end

function costYiqi_2()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes2()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_3()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox(" Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes_freefsb()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yes1()
    local pm = payMoney()

    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end

    if (GetLevel() >= 65) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        if (GetIBBuffCount() >= 31) then
            Talk(1, "no", 14543)
            return 0
        end

        local temp = GetTaskByte(1021, 2) + 1
        local times, addtimes = todayfreetimes(temp)
        local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        if (thisday ~= lastday) then
            SetTaskByte(1021, 1, thisday)
            refreshNpcTaskState()
            SetTaskByte(1021, 2, 0)
            refreshNpcTaskState()
            times = 1
            offlineTotimes()
        else
            SetTaskByte(1021, 2, temp)
            refreshNpcTaskState()
            times = times + 1
        end

        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() - pm

            Msg2Player("Trõ tr¹ng th¸i nghÜa khÝ ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() - pm

            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        end

        Pay(pm)
        DelNormalItem(3, 82, 0, 0)

        local w, mr, pl, mi, s1, t1
        if (GetTask(1023) > task_sel) then
            mr = GetTaskByte(1022, 3)
        else
            mr = math.random(1, 4)
            if (mr == 2) or (mr == 4) then
                mr = mr - 1
            end
        end

        local targname = ""
        targname = map_idx[mr][7]
        mi = map_idx[mr][1]
        w = mapname[mi]
        SetTaskByte(1022, 1, mi)
        refreshNpcTaskState()
        SetTaskByte(1022, 2, 0)
        refreshNpcTaskState()

        if (GetLevel() >= 100) then
            t1 = map_idx[mr][6][4]
            AddIBBuff(t1)
            s1 = task_time[3]
        elseif (GetLevel() >= 85) then
            t1 = map_idx[mr][6][3]
            AddIBBuff(t1)
            s1 = task_time[2]
        elseif (GetLevel() >= 75) then
            t1 = map_idx[mr][6][2]
            AddIBBuff(t1)
            s1 = task_time[1]
        elseif (GetLevel() >= 65) then
            t1 = map_idx[mr][6][1]
            AddIBBuff(t1)
            s1 = task_time[1]
        end

        Msg2Player("§©y lµ nhiÖm vô thø" .. times .. "lÇn nhËn nhiÖm vô Tø Linh.")
        TaskNote(54, 0, w)

        if (times <= 5) then
            SyncBibleState(54, 2, 1)
        else
            SyncBibleState(54, 3, 1)
        end ;

        Talk(1, "no", "Linh Tª m«n ®· më! LÇn nµy ng­¬i cÇn" .. w .. "phãng thÝch <c=g>" .. targname .. "<c> nguyªn linh, ta sÏ ngÉu nhiªn h­íng dÉn. Ng­¬i cã thÓ gi¶i phãng cho nguyªn linh ë 5 tÇng mª cung, cøu ®­îc bao nhiªu cßn tïy vµo n¨ng lùc cña ng­¬i!")
        return 1
    else
        Talk(1, "no", "Më Linh Tª m«n cÇn cã 1 <c=g>Tha S¬n Th¹ch<c> vµ" .. pm .. ", cã ®ñ råi quay l¹i t×m ta nhÐ!")
        return 0
    end
end

function yes2()
    CloseDialog()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("Tø Linh")

    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local i = FindAValidIBItem(8, 329, 2, 0)
    if (i ~= 0) then
        if (yes1() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Nép ch×a khãa Linh Tª cho ThÇy t­íng sè, nhËn 1 lÇn nhiÖm vô Tø Linh")


    elseif (GetCoin() >= Cv) then
        if (yes1() ~= 1) then
            return 0
        end

        CostCoinByIdx(CostId)
        Msg2Player("Ng­¬i ®­a " .. Cfs .. " Th«ng B¶o cho ThÇy t­íng sè, nhËn 1 lÇn nhiÖm vô Tø Linh.")
    else
        Talk(1, "no", "Muèn tiÕp tôc më Linh Tª m«n cÇn cã <c=g>ch×a khãa Linh Tª<c> hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, chuÈn bÞ ®ñ råi h·y ®Õn t×m ta!")
    end
end

function payMoney()
    local m = 50000
    if (GetLevel() > 74) then
        m = m + math.floor((GetLevel() - 65) / 10) * 50000

    end
    return m
end

function tongguanjiangli()
    for i = 1, 4 do
        for j = 1, 5 do
            if (GetIBBuffTimes(300 + i * 5 + j) > 0) then
                return 2
            end
        end
    end

    local nkey = 0
    if (HaveIBBuff(326) > 0) or (HaveIBBuff(327) > 0) or (HaveIBBuff(328) > 0) or (HaveIBBuff(331) > 0) then
        nkey = 1
    else
        for k = 1, 12 do
            if (HaveIBBuff(341 + k) > 0) then
                nkey = 1
                break ;
            end
        end
    end
    return nkey
end

function jiangli()
    CloseDialog()

    local temp = GetTaskByte(1021, 2)
    local times, addtimes = todayfreetimes(temp)

    local PetTyte = PetGetType()
    if (times == 3) and (PetTyte == 74 or PetTyte == 103) then

        AddNormalItemBind(8, 330, 0, 0, 0, 0, 1)
        Msg2Player("ÊôÐÔÁé³è§¸t KûÎªÄú´øÀ´¶îÍâ½±ÀøÁÙÏÉÂ¶*1.")
        WriteLog("[Linh Sñng Thuéc TÝnh][Tø T­îng Linh Tª][§¸t KûÔùËÍÁÙÏÉÂ·]")
    end

    if (tongguanjiangli() == 2) then
        local nLuckyNum = GetTask(1024)
        local rluck = math.random(1, 1000)
        local lingxi = GetTask(1023) + 1
        SetTask(1023, lingxi)
        refreshNpcTaskState()

        local expl = 0
        local mapidx = 0
        for i = 1, 4 do
            for j = 1, 5 do
                if (GetIBBuffTimes(300 + i * 5 + j) > 0) then
                    CostIBBuff(300 + i * 5 + j, 1)
                    expl = GetLevel() * exp_jiangli[j]
                    if (j == 5) then
                        mapidx = i
                    end
                    break ;
                end
            end
            if (expl > 0) then
                break ;
            end
        end

        local weekDay = GetWeekDay()
        if (GetTaskByte(Double_Optimization, 3) < 8) then
            local exp2 = expl
            if (GetTaskByte(Double_Optimization, 3) > 0) then
                expl = expl * 2
            end
            if (weekDay == 2) then

                Msg2Player("NhiÖm vô chñ ®Ò ngµy h«m nay lµ Tø T­îng Linh Tª, chóc m­õng ngµi, nhËn ®­îc Ë«±¶½±Àø")
                local nDoubel = 1
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                expl = expl + math.floor(exp2 * nDoubel)

            end

        elseif (GetTaskByte(Double_Optimization, 3) >= 8) then
            local nTemp = GetTaskByte(Double_Optimization, 3)
            nTemp = SetBit(nTemp, 6, 0)
            SetTaskByte(Double_Optimization, 3, nTemp)
        end

        if (expl == 0) then
            Talk(1, "no", 11943)
            return 0
        end

        RemoveIBBuff(326)
        RemoveIBBuff(327)
        RemoveIBBuff(328)
        RemoveIBBuff(331)
        SetTaskWord(1022, 2, 0)

        for k = 1, 12 do
            RemoveIBBuff(341 + k)
        end

        GetGiftHosr()

        if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
            local pr = math.random(1, 5)
            if (pr == 5) then
                AddIBBuff(418)
                AddIBBuff(418)

                if (GetIBBuffTimes(418) == 2) then
                    TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                else
                    TopMessage(14422)
                end

                if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                    TaskNote(1048, 0, GetIBBuffTimes(418))
                end

                if (GetIBBuffTimes(418) >= 30) then
                    TaskNote(1048, 1)
                end

                SetTaskByte(Task_lingchong, 3, 1)
                refreshNpcTaskState()

                Msg2Player("B¹n nhËn ®­îc 2 Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

            else
                AddIBBuff(418)

                if (GetIBBuffTimes(418) == 1) then
                    TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                else
                    TopMessage(14423)
                end

                if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                    TaskNote(1048, 0, GetIBBuffTimes(418))
                end

                if (GetIBBuffTimes(418) >= 30) then
                    TaskNote(1048, 1)
                end

                SetTaskByte(Task_lingchong, 3, 1)
                refreshNpcTaskState()

                Msg2Player("B¹n nhËn ®­îc Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

            end

        end

        if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
            AddIBBuff(426)
            Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
        end

        if (HaveIBBuff(1782) > 0) then
            expl = expl * 2
        end

        AddOwnExp(expl)

        Able_Pet.AblePetExp(3, 3000)
        Able_Pet.AblePetExp(16, 3000)

        TaskNote(54, -1)
        Msg2Player("B¹n nhËn ®­îc " .. expl .. " ®iÓm kinh nghiÖm.")

        if (nLuckyNum == 0) then
            nLuckyNum = task_lingxi[1]
            SetTask(1024, nLuckyNum)
            refreshNpcTaskState()
        end

        local str1 = ""
        if (rluck <= nLuckyNum) then
            AddNormalItem(8, 330, 0, 0, 0, 0)
            SetTask(1024, task_lingxi[1])
            refreshNpcTaskState()
            Msg2Player("B¹n nhËn ®­îc 1 L©m Tiªn Lé.")
            TopMessage(11944)
            str1 = "Ngoµi ra n¬i nµy cã <c=yel>L©m Tiªn Lé<c>, gióp t¨ng 0.5 kinh nghiÖm"
        else
            SetTask(1024, (nLuckyNum + task_lingxi[2]))
        end

        local nLuckyNum1 = GetTask(1186)
        local nlvl = 0
        if (lingxi >= task_yuansu[1][1]) then
            for i = table.getn(task_yuansu), 1, -1 do
                if (lingxi >= task_yuansu[i][1]) then
                    if (nLuckyNum1 == 0) then
                        nLuckyNum1 = task_yuansu[i][2]
                        SetTask(1186, nLuckyNum1)
                    end
                    nlvl = i
                    break
                end
            end
        end

        if (nlvl > 0) and (mapidx > 0) then
            rluck = math.random(1, 1000)
            if (rluck <= nLuckyNum1) then
                local mname = map_idx[mapidx][7]
                AddNormalItemPile(3, 199 + mapidx, 0, 0, 0, 0)
                SetTask(1186, task_yuansu[nlvl][2])
                Msg2Player("Chóc mõng B¹n nhËn ®­îc 1 Tø T­îng Tinh Ph¸ch.")
                TopMessage(14544)
                str1 = "Ngoµi ra n¬i nµy cã <c=g>" .. mname .. "<c> Mª Cung <c=yel>Tø T­îng Tinh Ph¸ch<c>, ng­¬i ®em ®i gÆp Tø T­îng Nguyªn Tè Tr­ëng l·o trong Mª Cung, «ng ta sÏ nãi cho ng­¬i biÕt c¸ch sö dông."

            else
                SetTask(1186, (nLuckyNum1 + task_yuansu[nlvl][3]))
                refreshNpcTaskState()
            end
        end

        local playerLevel = GetLevel()
        local leakTaskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
        local nextFunc = "no"
        if (leakTaskStatus == 0 and playerLevel >= 73 and lingxi > 10) then
            local rand = math.random(1, 100)
            if (rand <= 30) then
                SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 1))
                TaskNote(TASK_INFO_ID_LEAK, 0)
                nextFunc = "leakOrderGuide"
            end
        end

        local str = ""
        local taskDay = GetWeekDay()
        local index = 6
        for i = 1, 6 do
            if (GetTask(1023) == TaskTimes[i].totalTimes) then
                index = i
                break
            end
        end

        if (GetGlobalValueByte(370, 4) == 1 and index < 6) then
            if (taskDay < 7) then
                str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " ngµy, ngµy mai ®Õn nhËn nhÐ!"
            else
                str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " phÇn th­ëng nh©n ®«i kinh nghiÖm trong ngµy, ®Õn ®ît gi¶i cøu nguyªn linh tuÇn sau xin ®Õn nhËn nhÐ!"
            end
        end

        Talk(1, nextFunc, "NhiÖm vô hoµn thµnh, ng­¬i nhËn ®­îc <c=g>" .. expl .. "<c> kinh nghiÖm," .. str1 .. "Hi väng anh hïng sau nµy cã thÓ tiÕp tôc t¹o phóc cho thiªn h¹!" .. str)
    else
        Talk(1, "no", 11943)
    end
end

function renwu2_1()
    local tasks = {
        { "Tø T­îng Ng­ng Ph¸ch", "yuansu_1"; show = 0 },
        { "Tø t­îng tinh th¹ch", "yuansu_2"; show = 0 },

    }
    local key = 0
    for i = 0, 3 do
        if (HaveNormalItem(3, 204 + i, 0, 0) >= 1) then
            key = key + 1
        end
    end

    if (key >= 1) then
        tasks[1].show = 1;
    end ;

    if (key >= 4) then
        tasks[2].show = 1;
    end ;

    SayTask(14545, tasks)
end

function yuansu_1()
    local task1 = {
        "Thæ Ng­ng Ph¸ch/item_yuansu",
        "Háa Ng­ng Ph¸ch/item_yuansu",
        "Phong Ng­ng Ph¸ch/item_yuansu",
        "Thñy Ng­ng Ph¸ch/item_yuansu",

    }
    local exp1 = GetLevel() * 18000
    Say("HÊp thô Linh lùc mét viªnTø T­îng Ng­ng Ph¸ch, cã thÓ gióp ng­¬i n©ng cao tu hµnh, ®¹t ®­îc <c=g>" .. exp1 .. "<c> kinh nghiÖm, ng­¬i x¸c ®Þnh hÊp thô Linh lùc cña viªn Ng­ng Ph¸ch nµy?", 4, task1)
end

function item_yuansu(n)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 3)
    if (thisday ~= lastday) then
        if (HaveNormalItem(3, 204 + n, 0, 0) > 0) then
            SetTaskByte(1021, 3, thisday)
            refreshNpcTaskState()
            DelNormalItem(3, 204 + n, 0, 0)
            local exp1 = GetLevel() * 18000
            AddOwnExp(exp1)
            Msg2Player("B¹n ®· hÊp thô" .. map_idx[n + 1][7] .. " Ng­ng Ph¸ch, ®¹t ®­îc" .. exp1 .. " kinh nghiÖm")
            TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

            no()
        else
            Talk(1, "no", 14546)
        end
    else
        Talk(1, "no", 14547)
    end
end

function yuansu_2()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 3)
    if (thisday ~= lastday) then
        SetTaskByte(1021, 3, thisday)
        refreshNpcTaskState()

        for i = 0, 3 do
            if (HaveNormalItem(3, 204 + i, 0, 0) == 0) then
                Talk(1, "no", 14548)
                return 0
            end
        end

        for i = 0, 3 do
            DelNormalItem(3, 204 + i, 0, 0)
            AddNormalItemPile(3, 208, 0, 0, 0, 0)
        end
        Msg2Player("LuyÖn Tø T­îng Ng­ng Ph¸ch, nhËn ®­îc 4 viªn Tø T­îng Tinh Th¹ch")
        TopMessage(14549)
        Talk(1, "no", 14550)
    else
        Talk(1, "no", 14547)
    end
end

TASK_ID_LEAK = 1234
TASK_INFO_ID_LEAK = 1015

function leakOrderGuide()
    Talk(1, "main", 14551)
end

function isViewLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 1) then
        return 1
    else
        return 0
    end
end

function processLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 1) then
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 2))
        TaskNote(TASK_INFO_ID_LEAK, 1)
        Talk(4, "no", 14552, GetName() .. ": Xin…xin cøu ta víi…", "Theo quÎ nµy….nªn ®Õn Ngäc H­ Cung gÆp tiªn nh©n, ¾t cã c¬ duyªn", GetName() .. ":§a t¹ tiªn sinh!")
        refreshNpcTaskState()
    else
        no()
    end
end

function offlineTotimes()
    local localday = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = math.mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = math.floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (math.mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
        refreshNpcTaskState()
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)
    if (nums > 7) then
        nums = 7
    end
    local n_times = { 50, 50, 50, 100, 100, 100, 100 }
    local m = 60 * n_times[nums] * GetLevel()
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(1021, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)

    local pm = payMoney()
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm

    if (GetLevel() >= 65) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        if (GetIBBuffCount() >= 31) then
            Talk(1, "no", 14543)
            return 0
        end

        local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        if (thisday ~= lastday) then
            yiqiBuff_1()
            return 1
        else
            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end
            SetTaskByte(1021, 2, temp)
            refreshNpcTaskState()
        end

        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() + apm - pm

            Msg2Player("Trõ tr¹ng th¸i nghÜa khÝ ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() + apm - pm

            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        end

        Pay(pm)
        DelNormalItem(3, 82, 0, 0)

        local w, mr, pl, mi, s1, t1
        if (GetTask(1023) > task_sel) then
            mr = GetTaskByte(1022, 3)
        else
            mr = math.random(1, 4)
            if (mr == 2) or (mr == 4) then
                mr = mr - 1
            end
        end

        local targname = ""
        targname = map_idx[mr][7]
        mi = map_idx[mr][1]
        w = mapname[mi]
        SetTaskWord(1022, 1, mi)

        if (GetLevel() >= 100) then
            t1 = map_idx[mr][6][4]
            AddIBBuff(t1)
            s1 = task_time[3]
        elseif (GetLevel() >= 85) then
            t1 = map_idx[mr][6][3]
            AddIBBuff(t1)
            s1 = task_time[2]
        elseif (GetLevel() >= 75) then
            t1 = map_idx[mr][6][2]
            AddIBBuff(t1)
            s1 = task_time[1]
        elseif (GetLevel() >= 65) then
            t1 = map_idx[mr][6][1]
            AddIBBuff(t1)
            s1 = task_time[1]
        end

        local nTemp = GetTaskByte(Double_Optimization, 3)
        nTemp = SetBit(nTemp, 6, 1)
        SetTaskByte(Double_Optimization, 3, nTemp)

        Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
        Msg2Player("§©y lµ ­u ®·i tÝch lòy rêi game lÇn thø " .. addtimes .. "LÇn nhËn thªm nhiÖm vô Tø Linh.")
        TaskNote(54, 0, w)

        Talk(1, "no", "Linh Tª m«n ®· më! LÇn nµy ng­¬i cÇn" .. w .. "phãng thÝch <c=g>" .. targname .. "<c> nguyªn linh, ta sÏ ngÉu nhiªn h­íng dÉn. Ng­¬i cã thÓ gi¶i phãng cho nguyªn linh ë 5 tÇng mª cung, cøu ®­îc bao nhiªu cßn tïy vµo n¨ng lùc cña ng­¬i!")
        return 1
    else
        Talk(1, "no", "Më Linh Tª m«n cÇn cã 1 <c=g>Tha S¬n Th¹ch<c> vµ" .. pm .. ", cã ®ñ råi quay l¹i t×m ta nhÐ!")
        return 0
    end
end

Task_HorseGift = 1908
ActivityHorseStart = 109
gItemName = "Ö¸ÒýØÔÇ©"
function GetGiftHosr()

    WELFALE.PubFuncWelfareActivitie2_Item()

end

function ClearHorseTodayTask()


    local nYear, nMon, nDay = GetYMD()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    if (nYear == 2015 and nMon == 1 and nDay >= 16 and nDay <= 28) then
        if (GetTaskByte(Task_HorseGift, 3) ~= ActivityHorseStart) then
            SetTask(Task_HorseGift, 0)
            SetTaskBit(Task_HorseGift, 29, 1)
            SetTaskByte(Task_HorseGift, 1, nToday)
            SetTaskByte(Task_HorseGift, 3, ActivityHorseStart)
        else
            local nTaskDay = GetTaskByte(Task_HorseGift, 1)
            if (nTaskDay ~= nToday) then
                SetTaskByte(Task_HorseGift, 4, 0)
                SetTaskByte(Task_HorseGift, 1, nToday)
            end
        end
        return 1
    end
    return 0
end


