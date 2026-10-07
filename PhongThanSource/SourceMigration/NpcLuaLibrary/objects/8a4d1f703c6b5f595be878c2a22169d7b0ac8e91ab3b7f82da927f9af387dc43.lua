require("¸£Àû»î¶¯Ä£°å.luax")

require("Éñ½«ÏµÍ³.luax")
G_SUPERMANTASK_TYPE = 1
G_SUPERMANTASK_ID = 5

require("ÊôÐÔÁé³è.luax")
AllPetTable = Able_Pet.AllPetTable
L_PETCOMBOS = Able_Pet.L_PETCOMBOS
TaskTable_NewAllPet = Able_Pet.TaskTable_NewAllPet
TaskTable_AllPet2New = Able_Pet.TaskTable_AllPet2New
PetRoleCombosTask = 2199

Task_lingchong = 1395

Value_AblePet = 2071

Task_AblePet = 2072
Break_AblePet = 2073

Task_Pet_name = {
    [1] = "Lôc Phi Phi",
    [2] = "TuyÕt Linh Thö",
    [3] = "TiÕu Thiªn KhuyÓn",
    [4] = "¾«ÁéÍÃ",
    [5] = "§¹i NhÜ",
    [6] = "Phi Thiªn Linh Miªu",
    [7] = "Phông hoµng",
    [8] = "",
    [9] = "B¹ch Tr­",
    [10] = "Hång Tr­",
    [11] = "Kim Tr­",
    [12] = "Ng­u B¶o B¶o",
    [13] = "§Ëu §Ëu Hå",
    [14] = "§Ëu §Ëu Hå (biÕn dÞ)",
    [15] = "Tinh Minh Quy",
    [16] = "Tinh Minh Quy (biÕn dÞ)",
    [17] = "Tra Tra §iÓu",
    [18] = "Tra Tra §iÓu (biÕn dÞ)",
    [19] = "Rång ®æi mµu",
    [20] = "Rång ®æi mµu (biÕn dÞ)",
    [21] = "Tø BÊt T­íng",
    [22] = "¹Ô¹ÔÍÃ",
    [23] = "°×ÍÃ",
    [24] = "Ngäc Thè",
    [25] = "½ðÍÃ",
    [26] = "Ð¡ÏéÁú",
    [27] = "Ð¡»ðÁú",
    [28] = "ÇàÁú",
    [29] = "ÒøÁú",
    [30] = "½ðÁú",
    [31] = "ÃÔÀëÍÃ",

}

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

    startLevel = 23
    if (GetLevel() >= startLevel) then
        local taskProcess = GetTask(91)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) and (HaveNormalItem(6, 1, 12, 1) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) and (HaveNormalItem(6, 1, 12, 1) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 0
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
    SetPlayerTaskState(state, subState)
end

require("themeday_human.luax")

function main(sel)
    tasks = {
        { "Yªn Phóc", "renwu1"; show = 0 },
        { "Tø Linh", "sixiang"; show = 0 },
        { "MËt LÖnh", "processLeakOrder"; show = 0 },
        { "<c=g>Linh thó chi nguyÖn<c>", "pet_wish"; show = 0 },
        { "<c=g>Tu luyÖn Linh lùc<c>", "magic_learn"; show = 0 },
        { "Nu«i d­ìng Linh thó", "GetPet"; show = 1 },
        { "TriÖu ho¸n biÕn th©n", "bs"; show = 0 },
        { "Håi sinh Linh thó", "PetReborn"; show = 0 },
        { "Thuéc tÝnh giíi h¹n", "limitPet"; show = 1 },
    }

    UTask_world_1 = GetTask(91)
    UTask_cg_0 = GetTask(40);

    if (UTask_world_1 == 3) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_1 == 1) then
        tasks[1].show = 1;
    end ;
    if (GetPlayerType() == 2) then
        tasks[7].show = 1;
    end ;

    if (GetLevel() >= 65) then
        tasks[2].show = 1;


    end ;

    if (isViewLeakOrder() == 1) then
        tasks[3].show = 1;
    end ;

    local lingchongstate = GetTaskByte(Task_lingchong, 1)
    if ((PetIsAdd() == 0 and GetIBBuffTimes(418) > 0) or (PetIsAdd() == 1 and PetGetType() == 0) or (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate >= 1 and lingchongstate <= 2) or GetTaskByte(Task_lingchong, 3) == 1) then
        tasks[4].show = 1
    end

    local petspirit = PetGetSpirit()
    if (PetIsAdd() == 1 and PetGetType() > 0 and petspirit == 0) then
        if (lingchongstate ~= 0) then
            if (lingchongstate == 3) then
                tasks[5].show = 1
            end
        elseif (GetTaskByte(Task_lingchong, 3) ~= 1) then
            tasks[5].show = 1
        end
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate == 4) then
        tasks[5].show = 1
    end

    if (PetIsSleep() == 1) then
        tasks[8].show = 1
    end

    if (tasks[8].show == 1) then
        tasks[6].show = 0
    end

    SayTask(14498, tasks)

end;

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

function pet_wish()
    CloseDialog()

    if (PetIsAdd() == 0 and GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        Talk(1, "no", "Anh hïng thu thËp ®ñ 30 Linh thó chi nguyÖn h·y ®Õn t×m ta.")
        return
    end

    if (((PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30) or (PetIsAdd() == 1)) and GetTaskByte(Task_lingchong, 3) == 1) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        SetTaskByte(Task_lingchong, 3, 0)
        refreshNpcTaskState()
        Talk(1, "no", "Chóc mõng ng­êi thu thËp ®ñ Linh thó chi nguyÖn, nÕu anh hïng cã thêi gian, h·y trë l¹i lÇn n÷a, l·o phu cßn cã viÖc yªu cÇu.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30 and GetTaskByte(Task_lingchong, 3) == 0) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        SetTaskByte(Task_lingchong, 3, 2)
        Talk(1, "no", "L·o phu hy väng ng­êi nhËn 1 trøng linh thó chç ta vÒ nu«i, l·o phu sÏ truyÒn bÝ quyÕt cho ng­êi.")
        TaskNote(1048, 2)
        return
    elseif (PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30 and GetTaskByte(Task_lingchong, 3) == 2) then
        Talk(1, "no", "L·o phu hy väng ng­êi nhËn 1 trøng linh thó chç ta vÒ nu«i, l·o phu sÏ truyÒn bÝ quyÕt cho ng­êi.")
        return
    end

    if (PetIsAdd() == 1 and GetTaskByte(Task_lingchong, 3) == 2) then
        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 0)
        Talk(1, "no", "Trøng Linh thó do linh khÝ trêi ®Êt t¹o thµnh, cÇn dç dµnh ch¨m sãc chu ®¸o, nÕu anh hïng cã thêi gian, h·y nghe l·o phu nãi qua.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 1 and PetGetType() == 0 and GetTaskByte(Task_lingchong, 3) == 0) then
        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 3)
        Talk(1, "no", "ViÖc cÇn lµm cña ng­êi b©y giê lµ dÉn Linh thó ®i ch¬i, sau khi nã në h·y l¹i ®©y t×m  ta.<enter><enter>BÝ quyÕt:Sau khi tÝch lòy 1 thêi gian trªn m¹ng Linh thó sÏ në ra.")
        TaskNote(1048, 3)
        return
    elseif (PetIsAdd() == 1 and PetGetType() == 0 and GetTaskByte(Task_lingchong, 3) == 3) then
        Talk(1, "no", "ViÖc cÇn lµm cña ng­êi b©y giê lµ dÉn Linh thó ®i ch¬i, sau khi nã në h·y l¹i ®©y t×m  ta.<enter><enter>BÝ quyÕt:Sau khi tÝch lòy 1 thêi gian trªn m¹ng Linh thó sÏ në ra.")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 3) == 3) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 0)
        Talk(1, "no", "Chóc mõng ng­êi, Linh thó ®· në thµnh h×nh råi. L·o phu sÏ truyÒn hÕt bÝ quyÕt c¶ ®êi cho ng­êi, nÕu anh hïng cã thêi gian, h·y nghe ta nãi.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 1 and GetTaskByte(Task_lingchong, 3) == 0) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        local PetStrength = PetGetStrength()
        if (PetStrength + 36000 >= 360000) then
            PetModifyStrength(-(PetGetStrength() - 323999))
        end

        SetTaskByte(Task_lingchong, 1, 2)
        SetTaskByte(Task_lingchong, 2, 1)
        refreshNpcTaskState()
        TaskNote(1048, 4)

        Talk(2, "no", " Linh thó cña ng­êi míi në kh«ng l©u, xem ra suy yÕu kh¸c th­êng, mau dïng <c=g>Lôc §¹o, Tø Tinh hoÆc Ph¸c Ngäc<c> ®Ó trÞ liÖu cho nã.", " <c=g>Lôc §¹o<c> vµ <c=g>Tø Tinh<c> cã thÓ ®Õn chç XÝch Tïng Tö dïng nguyªn liÖu Lôc §¹o hoÆc Tø T­îng ®Ó hîp thµnh.")

        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 2) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        if (GetTaskByte(Task_lingchong, 2) == 2) then
            AddOwnExp(5000)
            TopMessage("NhËn ®­îc <c=g>5000<c> kinh nghiÖm.")
            Msg2Player("Hoµn thµnh Linh thó chi nguyÖn, nhËn ®­îc 5000 kinh nghiÖm.")
            SetTaskByte(Task_lingchong, 1, 3)
            Talk(1, "bianshen", "Xem ra ng­¬i ®· lÜnh héi hÕt ph­¬ng ph¸p ta truyÒn ®¹t, nÕu linh lùc Linh thó cña ng­êi ch­a cã, l·o phu sÏ gióp ng­êi 1 tay.")
            TaskNote(1048, -1)
        else
            Talk(1, "no", " Linh thó cña ng­¬i ®· suy yÕu, h·y mau dïng Lôc §¹o, Tø Tinh hoÆc Ph¸c Ngäc ®Ó trÞ liÖu cho nã.")
        end
    end
end

function bianshen()

    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Sao t«i chÕt råi!")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 3) then
        if (PetGetType() == 1 or PetGetType() == 2) then
            MsgBox("Chñ nh©n ta häc ®­îc chiªu thøc míi råi, ta sÏ lµm cho chñ nh©n biÕn thµnh h×nh d¸ng cña ta, nh­ng do n¨ng lùc cã h¹n, nªn chØ duy tr× ®­îc 30 phót.", "change_type", "no")
        end
    end
end

function change_type()
    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Sao t«i chÕt råi!")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 3) then

        if (PetGetType() ~= 1 and PetGetType() ~= 2) then
            Talk(1, "no", "BiÕn th©n thÊt b¹i, ch¼ng lÏ do linh lùc cña ta ch­a ®ñ sao?")
            return
        end

        if (((GetMorphType() >= 363 and GetMorphType() <= 366) or GetMorphType() == 420 or GetMorphType() == 419)) then
            Talk(1, "no", "Chñ nh©n ®· biÕn th©n råi, n¨ng lùc ta kh«ng ®ñ ®Ó gióp ng­êi biÕn th©n tiÕp.")
        else
            if (PetGetType() == 1) then
                PolyMorph(435, 1, 0, -1, 1800)
            elseif (PetGetType() == 2) then
                PolyMorph(436, 1, 0, -1, 1800)
            end
        end
    end
end

function magic_learn()
    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Linh thó cña ng­êi ®· ngñ, gäi nã dËy h·y ®Õn t×m ta")
        return
    end

    local lingchongstate = GetTaskByte(Task_lingchong, 1)
    local petspirit = PetGetSpirit()

    if (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate == 4) then

        if (petspirit == 0) then
            Talk(1, "no", " Båi d­ìng linh lùc cho Linh thó: cã thÓ x«ng pha vµo V¹n Tiªn trËn t×m c¸c lo¹i TrËn Nh·n hoÆc sö dông MËt b¶o Tô Linh Ch©u tiÕn hµnh båi d­ìng linh lùc.")
        else
            SetTaskByte(Task_lingchong, 1, 5)
            AddOwnExp(10000)
            Msg2Player("Tu luyÖn Linh lùc hoµn thµnh, nhËn ®­îc 10000 kinh nghiÖm.")
            TopMessage("NhËn ®­îc <c=g>10000<c> kinh nghiÖm.")
            Talk(1, "no", " L·o phu ®· khai më linh lùc cho Linh thó, sau nµy ch¨m sãc nhiÒu cho nã, sÏ cã thªm sù ng¹c nhiªn, nÕu cã vÊn ®Ò vÒ nu«i d­ìng Linh thó, cø ®Õn t×m l·o phu.")
            TaskNote(1049, -1)
        end
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and petspirit == 0) then
        if (lingchongstate ~= 0) then
            if (lingchongstate == 3) then
                SetTaskByte(Task_lingchong, 1, 4)
                Talk(1, "no", " L·o phu sÏ d¹y ng­êi c¸ch ®Ó Tu luyÖn Linh lùc, viÖc nµy kh¸ gian nan, cÇn ®Õn V¹n Tiªn trËn thu phôc yªu ma, lÊy ®­îc §¹i §Þa Nh·n, Hoµn Quan Nh·n, LiÖt DiÖm Nh·n, Phong B¹o Nh·n, hoÆc cã thÓ vµo Kú Tr©n C¸c mua MËt b¶o Tô Linh Ch©u cho Linh thó ¨n míi cã thÓ t¨ng linh lùc. Sau khi Linh thó t¨ng tr­ëng linh lùc, th× quay l¹i t×m ta.")
                TaskNote(1049, 0)
            end
        else
            SetTaskByte(Task_lingchong, 1, 4)
            Talk(1, "no", " L·o phu sÏ d¹y ng­êi c¸ch ®Ó Tu luyÖn Linh lùc, viÖc nµy kh¸ gian nan, cÇn ®Õn V¹n Tiªn trËn thu phôc yªu ma, lÊy ®­îc §¹i §Þa Nh·n, Hoµn Quan Nh·n, LiÖt DiÖm Nh·n, Phong B¹o Nh·n, hoÆc cã thÓ vµo Kú Tr©n C¸c mua MËt b¶o Tô Linh Ch©u cho Linh thó ¨n míi cã thÓ t¨ng linh lùc. Sau khi Linh thó t¨ng tr­ëng linh lùc, th× quay l¹i t×m ta.")
            TaskNote(1049, 0)
        end
    end

end

function PetReborn()
    CloseDialog()
    MsgBox(" Mang ®Õn cho ta 1 Phôc Ma Linh hoÆc 9.9 Th«ng B¶o, ta cã thÓ ®¸nh thøc l¹i Linh Thó cña ng­¬i!", "Yes_Reborn", "no")
end

function Yes_Reborn()
    CloseDialog()
    local i = FindAValidIBItem(8, 414, 2, 0)
    local costName, uCost, uCostForShow
    costName, uCost, uCostForShow = GetCostCoinInfoByIdx(132)
    if (i > 0) then
        CostIBItem(i)
        PetWake()
        PetModifyStrength(360000 - PetGetStrength())
        PetModifySpirit(-PetGetSpirit())
        PetModifyProtect(-PetGetProtect() + 1)
        PetModifyTrain(-PetGetTrain() + 1)
        Msg2Player(" ®· sö dông Phôc Ma Linh, Linh thó cña b¹n ®· thøc giÊc!")
    else
        if (GetCoin() >= uCost) then
            if (CostCoinByIdx(132) == 0) then
                Talk(1, "no", 11736)
                return
            end
            PetWake()
            PetModifyStrength(360000 - PetGetStrength())
            PetModifySpirit(-PetGetSpirit())
            PetModifyProtect(-PetGetProtect() + 1)
            PetModifyTrain(-PetGetTrain() + 1)
            Msg2Player("B¹n giao cho ThÇy t­íng sè 9.9 Th«ng B¶o, Linh thó cña b¹n ®· thøc giÊc!")
        else
            Talk(1, "no", "CÇn cã Phôc Ma Linh hoÆc 9.9 Th«ng B¶o míi cã thÓ ®¸nh thøc Linh Thó.")
        end
    end
end

function GetPet()
    tasksPet = {
        { "NhËn nu«i", "AdoptionPet"; show = 0 },
        { "Lµm ®Ñp", "Hairdresspet"; show = 0 },
        { "BiÕn h×nh", "PetHairChange"; show = 0 },
        { "Giíi thiÖu", "PetIntroduction"; show = 1 },
    }
    if (PetIsAdd() == 0) then
        tasksPet[1].show = 1;
    else
        tasksPet[2].show = 1;
    end ;

    if (GetTask(1167) > 0) then
        tasksPet[3].show = 1;
    end

    SayTask(14499, tasksPet)
end

function PetIntroduction()
    local tasksPetIntro = {
        { "Cho ¨n", "FeedPet"; show = 1 },
        { "B¶n lÜnh", "PetSkill"; show = 1 },
        { "Tr¹ng th¸i", "PetStatus"; show = 0 },
        { "Lµm ®Ñp", "PetAppearance"; show = 1 },
        { "BiÕn h×nh", "PetChange"; show = 0 },
        { "Linh Thó Chi NguyÖn", "PetHope"; show = 0 },
    }
    SayTask(14500, tasksPetIntro)
end
function FeedPet()
    CloseDialog()
    Talk(1, "FeedPet1", 14501)
end
function FeedPet1()
    CloseDialog()
    Talk(2, "PetIntroduction", 14502, "<c=g>[Cho ¨n]<c><enter><c=y>Lôc §¹o<c> vµ <c=y>Tø Tinh<c> cã thÓ ®Õn chç <c=g>XÝch Tïng Tö<c> dïng nguyªn liÖu Lôc §¹o hoÆc Tø T­îng ®Ó hîp thµnh. <c=y>Ph¸c Ngäc, Tô Linh Ch©u<c> cã thÓ mua ë <c=g>Kú Tr©n C¸c<c>.")
end

function PetSkill()
    CloseDialog()
    Talk(2, "PetSkill1", 14503, "<c=g>[Tù nu«i]<c><enter>Sau khi më, khi ®iÓm søc kháe cña Linh Thó thÊp h¬n 40, sÏ tù ®éng khÊu trõ thøc ¨n cña ng­êi ch¬i trong hµnh trang, ®Ó nu«i Linh Thó.")
end

function PetSkill1()
    CloseDialog()
    Talk(1, "PetSkill2", 14504)
end

function PetSkill2()
    CloseDialog()
    Talk(1, "PetSkill3", "<c=g>[ÅãÖ÷ÁÄÌì]<c><enter><c=yel>ÅãÖ÷ÁÄÌì<c>: ³èÎï<c=g>·õ»¯<c>ºó¿ªÆô.³èÎï»áÔÚÄúµÄÉí±ß²»Ê±µÄ¸úÄãËµ¼¸¾ä»°, ÅãÄú¶È¹ýÓÎÏ·ÖÐÃÀºÃµÄÊ±¹â, ²¢»áÔÚBOSS³öÊÀ, ÍòÏÉÕó¿ªÆôµÄÊ±ºòÌáÐÑÄú.")
end
function PetSkill3()
    CloseDialog()
    Talk(1, "PetSkill4", "<c=g>[Ê°½ð¼ñ±¦]<c><enter><c=yel>Ê°½ð¼ñ±¦<c>: ÔÚÏß<c=g>1 giê<c>¿ªÆô.³èÎï¿ÉÒÔ×Ô¶¯µÄ°ïÄúÊ°È¡µØÉÏµÄÎïÆ·, ·½±ã¿ì½Ý.Í¨¹ý³èÎï½çÃæÖÐÊ°½ð¼ñ±¦µÄÉèÖÃ, ¿ÉÒÔÖÇÄÜµÄÖ»Ê°È¡ÄúÐèÒªµÄÎïÆ·.")
end

function PetSkill4()
    CloseDialog()
    Talk(1, "PetSkill5", "<c=g>[ÆúÎïÇåÀí]<c><enter><c=yel>ÆúÎïÇåÀí<c>: ÔÚÏß<c=g>2 giê<c>¿ªÆô.³èÎï¿ÉÒÔ°ïÄú×Ô¶¯Âôµô²»ÐèÒªµÄ×°±¸, ÎïÆ·.Í¨¹ý³èÎï½çÃæÖÐÆúÎïÇåÀíµÄÉèÖÃ, ¿ÉÒÔÖÇÄÜµÄÂôµô²»ÐèÒªµÄ×°±¸, ±£ÁôºÃµÄ×°±¸.")
end

function PetSkill5()
    CloseDialog()
    Talk(1, "PetSkill6", "<c=g>[ÁéÁ¦ÐÞ¸´]<c><enter><c=yel>ÁéÁ¦ÐÞ¸´<c>: ÔÚÏß<c=g>4 giê<c>¿ªÆô.µ±Äú×°±¸ÄÍ¾ÃµÍÓÚ5Ê±, ³èÎï»á×Ô¶¯°ïÄúÐÞ¸´×°±¸, ·ÀÖ¹Ëð»µ.")
end

function PetSkill6()
    CloseDialog()

    Talk(2, "PetSkill7", 14505, "<c=g>[Linh Nh·n]<c><enter><c=yel>Linh Nh·n<c>: Khi Linh lùc ®¹t <c=g>150<c> sÏ häc ®­îc kü n¨ng nµy. Linh Thó cã thÓ gióp chñ nh©n xem ®iÓm sinh lùc cña ng­êi ch¬i kh¸c, ®iÒu nµy rÊt h÷u hiÖu khi chñ nh©n PK víi ng­êi kh¸c!")

end

function PetSkill7()
    CloseDialog()
    Talk(3, "PetIntroduction", 14506, 14507, 14508)
end

function PetStatus()
    CloseDialog()
    Talk(1, "PetStatus1", 14507)
end

function PetStatus1()
    CloseDialog()
    Talk(1, "PetIntroduction", 14508)
end

function PetAppearance()
    CloseDialog()
    Talk(1, "PetAppearance1", 14509)
end

function PetAppearance1()
    CloseDialog()
    Talk(1, "PetChange", 14510)
end

function PetChange()
    CloseDialog()
    Talk(1, "PetIntroduction", 14511)
end

function PetHope()
    CloseDialog()
    Talk(1, "PetIntroduction", 14512)
end

function AdoptionPet()
    if (PetIsAdd() == 1) then
        Talk(1, "no", 14513)
    else
        MsgBox(14514, "lingyang", "no")
    end

end
function lingyang()

    if (IsHaveSpaceForTreasure(2) <= 0) then
        Talk(1, "no", " H·y s¾p xÕp tói l¹i, ta cã phÇn th­ëng muèn tÆng ng­¬i. ")
        return
    end

    if (GetCash() >= 100000) then
        if (GetIBBuffTimes(418) >= 30) then
            Pay(100000)
            RemoveIBBuff(418)
            PetAdd()
            Msg2Player("B¹n nhËn ®­îc 1 trøng linh thó!")

            for i = 1, 5 do
                AddNormalItemBind(3, 114, 0, 0, 0, 0, 1)
            end
            Talk(2, "no", "Ng­¬i nhËn ®­îc trøng linh thó, h·y cè t©m ch¨m sãc! Kh«ng l©u sau nã sÏ në thµnh linh thó!", "tÆng 5 Lôc §¹o Tinh Hoa, cã thÓ dïng ®Ó nu«i Linh Thó!")


        else
            Talk(1, "no", 14516)
        end
    else
        Talk(1, "no", 14517)
    end

end

function Hairdresspet()
    local ChangePetAppearance = {
        "Lôc Phi Phi/ChangePetApp",
        "TuyÕt Linh Thö/ChangePetApp",


    }
    if (PetIsAdd() == 0) then
        Talk(1, "no", 14518)
    elseif (PetIsAdd() == 1 and PetGetType() == 0) then
        Talk(1, "no", 14519)
    else
        Say(14520, table.getn(ChangePetAppearance), ChangePetAppearance)
    end
end

function ChangePetApp(n1)
    local n = n1 + 1
    if (PetIsAdd() == 0) then
        Talk(1, "no", 14521)
    elseif (PetIsSleep() == 1) then
        Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
        Talk(1, "no", 14522)
    else

        if (HaveNormalItem(3, 100, 0, 0) < 20) then
            Talk(1, "no", 14523)

        elseif (n == 1) then
            if (PetGetType() == 1) then
                Talk(1, "no", 14524)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 1, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Lôc Phi Phi")
                Talk(1, "no", 14525)
            end

        elseif (n == 2) then
            if (PetGetType() == 2) then
                Talk(1, "no", 14526)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 2, 1))
                Msg2Player("Linh thó ®· biÕn thµnh TuyÕt Linh Thö.")
                Talk(1, "no", 14527)
            end
        elseif (n == 3) then
            if (PetGetType() == 3) then
                Talk(1, "no", 14528)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 3, 1))
                Msg2Player("Linh thó ®· biÕn thµnh TiÕu Thiªn KhuyÓn")
                Talk(1, "no", 14529)
            end
        elseif (n == 4) then
            if (PetGetType() == 4) then
                Talk(1, "no", 14530)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 4, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Ngäc Thè")
                Talk(1, "no", 14531)
            end
        elseif (n == 5) then
            if (PetGetType() == 5) then
                Talk(1, "no", 14532)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 5, 1))
                Msg2Player("Linh thó ®· biÕn thµnh §¹i NhÜ")
                Talk(1, "no", 14533)
            end
        elseif (n == 6) then
            if (PetGetType() == 6) then
                Talk(1, "no", 14534)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 6, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Lam Tinh Linh")
                Talk(1, "no", 14535)
            end
        elseif (n == 7) then
            if (PetGetType() == 7) then
                Talk(1, "no", 14536)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                Able_Pet.ChangePet()
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 7, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Ph­îng Hoµng")
                Talk(1, "no", 14537)
            end
        else
            Talk(1, "no", 14538)
        end
    end
end

function PetHairChange()

    if (PetIsAdd() == 0) then
        CloseDialog()
        Talk(1, "no", "Ng¹i qu¸! B¹n hiÖn ch­a cã thó nu«i nµo, kh«ng thÓ biÕn th©n cho thó nu«i cña b¹n ®­îc!")
        return
    end

    local petTy = PetGetType()
    if (petTy >= 3) and (petTy <= 12) and (GetTaskBit(1167, petTy) == 0) then
        SetTaskBit(1167, petTy, 1)
    end

    local list = {}
    local j = 1

    for i = 1, 12 do
        if (GetBit(GetTask(1167), i) == 1) then
            list[j] = Task_Pet_name[i] .. "/PetHairReSet"
            j = j + 1
        end
    end

    local newPetName = {
        [1] = "§Ëu §Ëu Hå",
        [2] = "Tinh Minh Quy",
        [3] = "Tra Tra §iÓu",
        [4] = "Rång ®æi mµu",
    }
    for i = 13, 20 do
        SetTask(1167, SetBit(GetTask(1167), i, 0))
    end

    local nPetKind = CheckPetKind()
    local nVariation = GetPetVariation()
    if (nPetKind > 0) then
        list[j] = newPetName[nPetKind] .. "/PetHairReSet"
        SetTask(1167, SetBit(GetTask(1167), 13 + 2 * (nPetKind - 1) + nVariation, 1))
        j = j + 1
    end

    for i = 21, 31 do
        if (GetBit(GetTask(1167), i) == 1) then
            list[j] = Task_Pet_name[i] .. "/PetHairReSet"
            j = j + 1
        end
    end

    Say(14539, table.getn(list), list)
end

function PetHairReSet(nIndex)
    if (GetCash() >= 500000) then
        local name = ""
        local j = 0
        local nID = 0

        for i = 1, 31 do
            if (GetBit(GetTask(1167), i) == 1) then
                j = j + 1
            end

            if (j == nIndex + 1) then
                name = Task_Pet_name[i]
                nID = i
                break
            end
        end

        if (nID == 0) then
            Talk(1, "no", "ËãÃüÏÈÉú: ThËt xin lçi, Ñ¡Ôñ´íÎó, xin h·y chän l¹i")
            return 0
        elseif (PetGetType() == nID) then
            Talk(1, "no", "Linh thó ®· biÕn thµnh <c=g>" .. name .. "<c>, kh«ng thÓ biÕn h×nh n÷a!")
        elseif (PetIsSleep() == 1) then
            Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
            Talk(1, "no", 14522)
        else
            Pay(500000)
            Able_Pet.ChangePet()
            PetSetType(nID)
            SetTask(1167, SetBit(GetTask(1167), nID, 1))
            Msg2Player("Linh thó ®· biÕn thµnh" .. name)
            Talk(1, "no", "Linh thó ®· biÕn thµnh <c=g>" .. name .. "<c> xanh nµo!")
        end
    else
        Talk(1, "no", 14540)
    end
end

function renwu1()

    UTask_world_1 = GetTask(91)
    if (UTask_world_1 == 3) then
        if (HaveNormalItem(6, 1, 12, 1) < 1) then
            Talk(1, "no", 14541)
            return
        end

        DelNormalItem(6, 1, 12, 1)
        Talk(5, "no", 10098, 10099, 10100, 10101, 10102)
        SetTask(91, 4)

        AddOwnExp(10000)
        Msg2Player("NhËn ®­îc 10000 kinh nghiÖm")
        TopMessage(14542)

        SetSubTask(25, -1, 1)

        TaskNote(25, -1)

        refreshNpcTaskState()


    end ;
    if (UTask_world_1 == 1) then
        Talk(3, "no", 10103, 10104, 10105)
        SetTask(91, 2)
        Msg2Player("Th× ra Tèng DÞ nh©n ®ang ®­îc vËn may nµy, nãi cho «ng ta biÕt? Hay lµ......")
        TaskNote(25, 1)

        refreshNpcTaskState()


    end ;
end;

function no()
    CloseDialog()
end;

function bs()
    Say(10106, 3, "Hoµng Kim Cù Nh©n/m1", "ThiÕt Thè/m2", "Anh Vò/m3")
end;

function m1()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 359)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
end;

function m2()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 408)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
end;

function m3()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 409)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
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
        strValue = "Muèn tiÕp tôc më Linh Tª m«n cÇn cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", ngoµi ra cÇn cã <c=yel>Ch×a khãa Linh Tª hoÆc" .. Cfs .. " Th«ng B¶o<c>, chuÈn bÞ ®ñ vËt liÖu nhÐ!"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        Talk(1, "no", strValue)
    end
end

function item_maze(nIdx)
    nIdx = nIdx + 1
    SetTaskByte(1022, 3, nIdx)
    refreshNpcTaskState()

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
        MsgBox("Cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_1", "yes1")
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
            offlineTotimes()
            times = 1
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
            if (mr == 1) or (mr == 3) then
                mr = mr + 1
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
                expl = expl + exp2
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
            refreshNpcTaskState()
        end

        local nLuckyNum1 = GetTask(1186)
        local nlvl = 0
        if (lingxi >= task_yuansu[1][1]) then
            for i = table.getn(task_yuansu), 1, -1 do
                if (lingxi >= task_yuansu[i][1]) then
                    if (nLuckyNum1 == 0) then
                        nLuckyNum1 = task_yuansu[i][2]
                        SetTask(1186, nLuckyNum1)
                        refreshNpcTaskState()
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
                refreshNpcTaskState()
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
                refreshNpcTaskState()
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

        if (GetGlobalValueByte(370, 1) == 1 and index < 6) then
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
    refreshNpcTaskState()
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
    refreshNpcTaskState()
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
            if (mr == 1) or (mr == 3) then
                mr = mr + 1
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
        Msg2Player("§©y lµ ­u ®·i tÝch lòy rêi game lÇn thø " .. addtimes .. "lÇn nhËn nhiÖm vô Tø Linh.")
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

function limitPet()
    local tasks = {
        { "Danh s¸ch", "HuximeiMain"; show = 1 },
        { "<c=y>Tæ hîp Kü n¨ng Linh thó<c>", "PetCombos"; show = 1 },
        { "Hép Linh Sñng B¸ch BiÕn", "PetBox"; show = 1 },
    }
    SayTask("Mçi thó c­ng thuéc tÝnh giíi h¹n ®Òu cã siªu kü n¨ng, cã thÓ gióp anh hïng chu du Tam Giíi trong Phong ThÇn thªm dÔ dµng.", tasks)
end

function HuximeiMain()
    local tasks = {
        { "Trang 1", "Huximei"; show = 1 },
        { "Trang 2", "Huximei2"; show = 1 },
        { "Quay l¹i", "limitPet"; show = 1 },
    }
    SayTask("Mçi thó c­ng thuéc tÝnh giíi h¹n ®Òu cã siªu kü n¨ng, cã thÓ gióp anh hïng chu du Tam Giíi trong Phong ThÇn thªm dÔ dµng.", tasks)
end

function Huximei()
    local opra = {
        "Hå HØ MÞ/AblePet",
        "Na Tra/NeZha",
        "L«i ChÊn Tö/LeiZhenZi",
        "Th¹ch C¬ N­¬ng N­¬ng/ShiJi",
        "Th¸i Êt Ch©n Nh©n/TaiYi",
        "§¸t Kû/DaJi",
        "Th©n C«ng B¸o/ShenGongBao",
        "Hoµng Phi Hæ/HuangFeiHu",
        "Hao Thiªn KhuyÓn/NewAllPetsOne",
        "D­¬ng TiÔn/NewAllPetsOne",
        "Kh­¬ng Tö Nha/NewAllPetsOne",
        "Lý TÞnh/NewAllPetsOne",
        "Phi Th¨ng-Hå HØ MÞ/NewAllPetsOne",
        "Phi Th¨ng-Na Tra/NewAllPetsOne",
        "Phi Th¨ng-L«i ChÊn Tö/NewAllPetsOne",
        "Phi Th¨ng-Th¹ch C¬/NewAllPetsOne",
        "Phi Th¨ng-Th¸i Êt/NewAllPetsOne",
        "Phi Th¨ng-§¸t Kû/NewAllPetsOne",
        "Phi Th¨ng-Th©n C«ng B¸o/NewAllPetsOne",
        "Phi Th¨ng-Hoµng Phi Hæ/NewAllPetsOne",
        "Phi Th¨ng-Hao Thiªn KhuyÓn/NewAllPetsOne",
        "Phi Th¨ng-D­¬ng TiÔn/NewAllPetsOne",
        "Phi Th¨ng-Kh­¬ng Tö Nha/NewAllPetsOne",
        "Phi Th¨ng-Lý TÞnh/NewAllPetsOne",
        "Trang tr­íc/limitPet",
    }
    Say("Sñng vËt thuéc tÝnh hiÕm, chØ khi ngµi ®¹t ®iÒu kiÖn liªn quan míi cã thÓ nhËn.", table.getn(opra), opra)
end

function Huximei2()
    local opra = {
        "Lôc ¸p §¹o Nh©n/AllPetsOne2New",
        "Trang tr­íc/HuximeiMain",
    }
    Say("Sñng vËt thuéc tÝnh hiÕm, chØ khi ngµi ®¹t ®iÒu kiÖn liªn quan míi cã thÓ nhËn.", table.getn(opra), opra)
end
function boxshuoming()
    Talk(2, "PetBox", "NhÊn vµo [Hép Linh Sñng B¸ch BiÕn] ®Ó l­u biÕn th©n phï cña c¸c Sñng vËt thuéc tÝnh hiÖn cã cña ng­¬i, (HiÖn cã Hå HØ MÞ/Na Tra/L«i ChÊn Tö/Th¹ch C¬/Th¸i Êt Ch©n Nh©n/§¸t Kû/Th©n C«ng B¸o/Hoµng Phi Hæ/Hao Thiªn KhuyÓn/D­¬ng TiÔn/Kh­¬ng Tö Nha/Lý TÞnh), cã thÓ l­u tÊt c¶ biÕn th©n phï ngµi cã vµo Hép Linh Sñng B¸ch BiÕn. Khi cÇn biÕn th©n Sñng vËt, chØ cÇn sö dông Hép Linh Sñng B¸ch BiÕn.", "NÕu x¶y ra tr­êng hîp bÊt th­êng khi 1 sñng vËt cã nhiÒu quyÓn trôc, h·y lÊy quyÓn trôc cÊp cao h¬n, lóc trõ sÏ trõ tÊt c¶ quyÓn trôc hiÖn cã. VÝ dô: Trong hµnh trang cã quyÓn trôc Na Tra Hoµng Kim vµ quyÓn trôc Na Tra cÊp 1, th× l­u vµo hép quyÓn trôc Na Tra Hoµng Kim, ®ång thêi khi l­u quyÓn trôc Hoµng Kim vµ quyÓn trôc cÊp 1 ®Òu biÕn mÊt.")
end

function PetBox()
    local tasks = {
        { "<c=y>L­u tÊt c¶ vµo hép Linh Sñng<c>", "allinbox"; show = 1 },
        { "<c=g>L­u chØ ®Þnh<c>", "SavePetItemMain"; show = 1 },

        { "ThuyÕt minh", "boxshuoming"; show = 1 },
        { "Tr­íc", "limitPet"; show = 1 },
    }
    SayTask("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô dïng ®Ó l­u tr÷ tÊt c¶ c¸c lo¹i biÕn th©n phï Linh Sñng VÜnh viÔn, sau khi l­u biÕn th©n phï t¹i chç ta, cã thÓ dïng Hép B¸ch BiÕn ®Ó biÕn ho¸ Linh sñng thay cho biÕn th©n phï. LÇn ®Çu l­u biÕn th©n phï sÏ nhËn ®­îc 1 Hép B¸ch BiÕn.", tasks)
end

function SavePetItemMain()
    local tasks = {
        { "Trang 1", "SavePetItem"; show = 1 },
        { "Trang 2", "SavePetItem2"; show = 1 },
        { "Tr­íc", "PetBox"; show = 1 },
    }
    SayTask("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô dïng ®Ó l­u tr÷ tÊt c¶ c¸c lo¹i biÕn th©n phï Linh Sñng VÜnh viÔn, sau khi l­u biÕn th©n phï t¹i chç ta, cã thÓ dïng Hép B¸ch BiÕn ®Ó biÕn ho¸ Linh sñng thay cho biÕn th©n phï. LÇn ®Çu l­u biÕn th©n phï sÏ nhËn ®­îc 1 Hép B¸ch BiÕn.", tasks)
end

function SavePetItem()
    local opra = {
        "Hå HØ MÞ/AblePetbox",
        "Na Tra/NeZhabox",
        "L«i ChÊn Tö/LeiZhenZibox",
        "Th¹ch C¬ N­¬ng N­¬ng/ShiJibox",
        "Th¸i Êt Ch©n Nh©n/TaiYibox",
        "§¸t Kû/DaJibox",
        "Th©n C«ng B¸o/ShenGongBaobox",
        "Hoµng Phi Hæ/HuangFeiHubox",
        "Hao Thiªn KhuyÓn/XiaoTianQuanbox",
        "D­¬ng TiÔn/YangJanbox",
        "Kh­¬ng Tö Nha/JiangZiYabox",
        "Lý TÞnh/LiJingbox",
        "Phi Th¨ng-Hå HØ MÞ/AblePetUpbox",
        "Phi Th¨ng-Na Tra/SuperNezhaBox",
        "Phi Th¨ng-L«i ChÊn Tö/SuperLeiZhenZi",
        "Phi Th¨ng-Th¹ch C¬/SuperShiJi",
        "Phi Th¨ng-Th¸i Êt/SuperTaiYi",
        "Phi Th¨ng-§¸t Kû/SuperDaJi",
        "Phi Th¨ng-Th©n C«ng B¸o/SuperShenGongBao",
        "Phi Th¨ng-Hoµng Phi Hæ/SuperHuangFeiHu",
        "Phi Th¨ng-Hao Thiªn KhuyÓn/SuperXiaoTianQuan",
        "Phi Th¨ng-D­¬ng TiÔn/SuperYangJanbox",
        "Phi Th¨ng-Kh­¬ng Tö Nha/SuperJiangZiYabox",
        "Phi Th¨ng-Lý TÞnh/SuperLiJingbox",
        "<c=y>Trë l¹i<c>/SavePetItemMain",
    }
    Say("Chän lo¹i BiÕn th©n phï ngµi muèn l­u:", table.getn(opra), opra)
end

function SavePetItem2()
    local opra = {
        "Lôc ¸p §¹o Nh©n/SuperNew2box",
        "<c=y>Trë l¹i<c>/SavePetItemMain",
    }
    Say("Chän lo¹i BiÕn th©n phï ngµi muèn l­u:", table.getn(opra), opra)
end

temp_boxidx = {
    [1] = { 140, 2 },
    [2] = { 140, 3 },
    [3] = { 140, 4 },
    [4] = { 141, 1 },
    [5] = { 141, 2 },
    [6] = { 141, 3 },
    [7] = { 141, 4 },
    [8] = { 142, 1 },
    [9] = { 142, 2 },
    [10] = { 142, 3 },
    [11] = { 142, 4 },
}
function SavePetItemYes()
    local pettype = GetTaskByte(140, 1) - 1
    if (pettype < 0) then
        Talk(1, "no", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    elseif (pettype >= 8) then
        SavePetItemYesNew()
        return 0
    end

    local Lmin = 1 + pettype * 10
    local Lmax = 10 + pettype * 10
    local tempList = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local key = 0

    for i = 1, 11 do
        tempList[i] = GetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2])
        if (tempList[i] > 0) then
            key = key + 1
        end
    end
    SetTask(140, 0)
    SetTask(141, 0)
    SetTask(142, 0)
    if (key == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBox(Lmin, Lmax, pettype, tempList) == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end
end

function allinbox()
    local str = "Ngµi x¸c ®Þnh ®em tÊt c¶ biÕn th©n phï d­íi ®©y cho vµo Hép B¸ch BiÕn chø? <c=r>Huû bá sÏ quay l¹i lùa chän tr­íc<c>\n"
    local id = { 0, 0, 0, 0 }
    local petList = {}
    local key = 0
    for i = 81, 88 do
        id = AllPetTable[i].itemid
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=y>" .. AllPetTable[i].itemname .. "<c>  "
            key = key + 1
        end
    end

    for i = 1, 80 do
        id = AllPetTable[i].itemid
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=g>" .. AllPetTable[i].itemname .. "(" .. AllPetTable[i].lvl .. " cÊp)<c>  "
            key = key + 1
        end
    end

    for i = 1, #TaskTable_NewAllPet do
        petList = TaskTable_NewAllPet[i].task
        for j = 1, #petList do
            id = petList[j].id
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                if (petList[j].lvl == 11) then
                    str = str .. "<c=y>" .. petList[j].itemname .. "<c>  "
                else
                    str = str .. "<c=g>" .. TaskTable_NewAllPet[i].petname .. "(" .. petList[j].lvl .. " cÊp)<c>  "
                end
                key = key + 1
            end
        end
    end

    for i = 1, #TaskTable_AllPet2New do
        id = TaskTable_AllPet2New[i].id
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=g>" .. TaskTable_AllPet2New[i].petname .. "<c>  "
            key = key + 1
        end
    end

    if (key == 0) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "PetBox", "no")
    else
        MsgBox(str, "allinboxYes", "PetBox")
    end
end

function allinboxYes()
    local list = {}
    local str = ""
    local idx = 0
    local id = { 0, 0, 0, 0 }
    local name = ""
    local key = 0

    for i = 0, 7 do
        for j = 1, 10 do
            idx = j + i * 10
            id = AllPetTable[idx].itemid
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                name = AllPetTable[idx].itemname
                if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                    ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. name .. "(" .. AllPetTable[idx].lvl .. ")")
                    str = str .. name .. "(" .. AllPetTable[idx].lvl .. " cÊp), "
                    SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
                    key = 1
                end
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end

        if (i < 8) then
            idx = 81 + i
            id = AllPetTable[idx].itemid
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. AllPetTable[idx].itemname)
                str = str .. AllPetTable[idx].itemname .. ","
                SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
                key = 1
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    local cstr = ""
    for i = 1, #TaskTable_NewAllPet do
        petList = TaskTable_NewAllPet[i].task
        for j = 1, #petList do
            id = petList[j].id
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                if (petList[j].lvl == 11) then
                    cstr = petList[j].itemname
                    ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. cstr)
                    str = str .. cstr .. ","
                    SetTaskBit(petList[j].useTask[1], petList[j].useTask[2], 1)
                    key = 1
                else
                    name = TaskTable_NewAllPet[i].petname
                    if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                        cstr = name .. "(" .. petList[j].lvl .. ")"
                        ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. cstr)
                        str = str .. cstr .. ","
                        SetTaskBit(petList[j].useTask[1], petList[j].useTask[2], 1)
                        key = 1
                    end
                end
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    for i = 1, #TaskTable_AllPet2New do
        id = TaskTable_AllPet2New[i].id
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            name = TaskTable_AllPet2New[i].petname
            if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. name)
                str = str .. name .. ","
                SetTaskBit(TaskTable_AllPet2New[i].useTask[1], TaskTable_AllPet2New[i].useTask[2], 1)
                key = 1
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    if (key == 0) then
        Talk(1, "no", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
            AddNormalItem(6, 1, 1594, 0, 0, 0)
            Msg2Player("Ngµi thµnh c«ng thu n¹p " .. str .. " ®ång thêi nhËn ®­îc 1 Hép Linh Sñng B¸ch BiÕn.")
        else
            Msg2Player("Ngµi thµnh c«ng thu n¹p " .. str .. " ®Òu ®· ®­îc bá vµo bªn trong Hép Linh Sñng B¸ch BiÕn")
        end
        Talk(1, "no", "TÊt c¶ biÕn th©n phï cña ngµi ®Òu ®· ®­îc bá vµo bªn trong <c=g>Hép Linh Sñng B¸ch BiÕn<c>")
        WriteLog("[Hép Linh Sñng B¸ch BiÕn]" .. str)
    end
end

function AblePetbox()
    SetTask(140, 1)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(1, 10, 81, 0)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function NeZhabox()
    SetTask(140, 2)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(11, 20, 82, 1)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function LeiZhenZibox()
    SetTask(140, 3)
    SetTask(141, 0)
    SetTask(142, 0)

    local key, str, tempList = Able_Pet.PetBoxInfo(21, 30, 83, 2)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function ShiJibox()
    SetTask(140, 4)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(31, 40, 84, 3)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function TaiYibox()
    SetTask(140, 5)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(41, 50, 85, 4)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function DaJibox()
    SetTask(140, 6)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(51, 60, 86, 5)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function ShenGongBaobox()
    SetTask(140, 7)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(61, 70, 87, 6)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function HuangFeiHubox()
    SetTask(140, 8)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(71, 80, 88, 7)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function SavePetItemYesNew()
    local pettype = GetTaskByte(140, 1)

    if (pettype < 0) then
        Talk(1, "no", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    elseif (pettype < 9) then
        SavePetItemYes()
        return 0
    elseif (pettype >= 25) then
        SavePetItemYes2New()
        return 0
    end

    local idx = GetTaskByte(140, 2)
    local tempList = GetTaskWord(140, 2)
    SetTask(140, 0)

    if (tempList == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBoxNew(idx, pettype, tempList) == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end

end

function XiaoTianQuanbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(9)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 9)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function YangJanbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(10)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 10)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function JiangZiYabox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(11)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 11)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function LiJingbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(12)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 12)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function AblePetUpbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(13)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 13)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperNezhaBox()

    local key, str, tempList = Able_Pet.PetBoxInfoNew(14)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 14)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil and tempList[i] == i) then
                SetTaskBit(140, 16 + i, 1)
            end
        end
        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperLeiZhenZi()

    local key, str, tempList = Able_Pet.PetBoxInfoNew(15)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 15)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil and tempList[i] == i) then
                SetTaskBit(140, 16 + i, 1)
            end
        end
        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperShiJi()
    local nIdx = 16
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperTaiYi()
    local nIdx = 17
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperDaJi()
    local nIdx = 18
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperShenGongBao()
    local nIdx = 19
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperHuangFeiHu()
    local nIdx = 20
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperXiaoTianQuan()
    local nIdx = 21
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperYangJanbox()
    local nIdx = 22
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperJiangZiYabox()
    local nIdx = 23
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperLiJingbox()
    local nIdx = 24
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperNew2box(nIndex)
    nIndex = nIndex + 25
    if (nIndex <= 24) or (nIndex > table.getn(Able_Pet.t_GetPetRight)) then
        no()
        return 0
    end
    local key, str = Able_Pet.PetBoxInfoNew2(nIndex)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem2", "no")
    else
        SetTask(140, nIndex)
        SetTaskByte(140, 2, key)

        MsgBox(str, "SavePetItem2YesNew", "SavePetItem2")
    end
end

function SavePetItem2YesNew()
    local pettype = GetTaskByte(140, 1)

    if (pettype < 0) then
        Talk(1, "no", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    elseif (pettype < 9) then
        SavePetItemYes()
        return 0
    elseif (pettype < 25) then
        SavePetItemYesNew()
        return 0
    end

    local idx = GetTaskByte(140, 2)
    SetTask(140, 0)

    if (idx == 0) then
        Talk(1, "SavePetItem2", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBoxNew2(idx, pettype) == 0) then
        Talk(1, "SavePetItem2", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem2", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end

end

function AblePet()

    local menu = {
        { "NhËn Hå HØ MÞ", "GetAblePet"; show = 1 },
        { "Hå HØ MÞ-tu luyÖn", "FosterPet"; show = 1 },
    }
    if (GetTaskByte(Value_AblePet, 4) == 1) or (GetTaskBit(2109, 1) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Value_AblePet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Linh sñng thuéc tÝnh ®Æc biÖt cña B¸t C¶nh Cung <color=orange>Hå HØ MÞ<c> kü n¨ng thiªn phó\n<color=orange>Phi Tö TiÕu<c>: Kinh nghiÖm VËn l­¬ng t¨ng (Ng­êi ch¬i max cÊp nhËn ®­îc thªm b¹c)\n<color=orange>Tû Muéi T×nh Th©m<c>: Cã giao t×nh ngµn n¨m víi V­¬ng Quý nh©n, gÆp ThËp TuyÖt Thiªn Qu©n vµ Th«ng Thiªn Gi¸o Chñ cã c¬ héi nhËn ngäc th¹ch hiÕm, tèi ®a ®Õn Ngäc T©m\nNgoµi ra <color=orange>Hå HØ MÞ<c> cßn gióp më kho¸ ®Æc quyÒn HuyÒn Vò!", menu)
end
function NeZha()

    local menu = {
        { "NhËn Na Tra", "GetNeZha"; show = 1 },
        { "Na Tra-tu luyÖn", "FosterNeZha"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.NeZha_Pet, 4) == 1) or (GetTaskBit(2109, 2) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.NeZha_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Linh sñng thuéc tÝnh ®Æc biÖt thuéc Giíi Bµi Quan <color=orange>Na Tra<c> kü n¨ng thiªn phó\n<color=orange>Linh Ch©u Tö<c>: Kinh nghiÖm nhiÖm vô Thiªn Tµi §Þa B¶o t¨ng. \n<color=orange>Liªn Hoa Ho¸ Th©n<c>: T¨ng 1 lÇn hé chñ, bÞ tÊn c«ng cã x¸c suÊt t¹o hé thuÉn hÊp thu 3650 ®iÓm s¸t th­¬ng\nNgoµi ra <color=orange>Na Tra<c> cßn gióp më kho¸ ®Æc quyÒn HuyÒn Vò!", menu)
end

function GetAblePet()
    local Acoountlist = Able_Pet.t_GetPetRight[1].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            if (GetTaskByte(Value_AblePet, 4) == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 1]")
                return
            end
            local flag = 0
            for i = 1339, 1348 do
                if (HaveItemInAllRoom(6, 1, i, 1, 0, 0, 0) > 0) then
                    flag = 1
                    break
                end
            end
            if (flag == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 2]")
                return
            end
            SetTaskByte(Value_AblePet, 4, 1)
            AddNormalItemBind(6, 1, 1339, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Hå HØ MÞ QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Hå HØ MÞ QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Hå HØ MÞ!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end

function GetNeZha()
    local Acoountlist = Able_Pet.t_GetPetRight[2].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            if (GetTaskByte(Able_Pet.NeZha_Pet, 4) == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 1]")
                return
            end
            local flag = 0
            for i = 1359, 1368 do
                if (HaveItemInAllRoom(6, 1, i, 1, 0, 0, 0) > 0) then
                    flag = 1
                    break
                end
            end
            if (flag == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 2]")
                return
            end
            SetTaskByte(Able_Pet.NeZha_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1359, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Na Tra QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Na Tra QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Na Tra!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end

function FosterPet()

    if (HaveNormalItem(6, 1, 1339, 0) > 0) then
        if (DelNormalItem(6, 1, 1339, 0) > 0) then
            AddNormalItemBind(6, 1, 1339, 1, 0, 0, 1)
        end
    end

    Able_Pet.FosterPet()
end

function FosterNeZha()
    Able_Pet.FosterNeZha()
end

function LeiZhenZi()

    local menu = {
        { "NhËn L«i ChÊn Tö", "GetLeiZhenZi"; show = 1 },
        { "L«i ChÊn Tö-tu luyÖn", "FosterLeiZhenZi"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.LeiZhenZi_Pet, 4) == 1) or (GetTaskBit(2109, 3) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.LeiZhenZi_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Linh sñng ®Æc biÖt Ngäc Trô §éng - <color=orange>L«i ChÊn Tö<c> kü n¨ng thiªn phó\n<color=orange>Thiªn §Þa Linh KhÝ<c>: Tinh th«ng th«ng tø t­îng, ®em theo gióp t¨ng kinh nghiÖm th­ëng nhiÖm vô <color=orange>Tø T­îng Linh Tª<c>\n<color=orange>Thiªn L«i Phô ThÓ<c>: Th©n phi thiªn l«i, tay cÇm cµn kh«n, hµng phôc ThËp TuyÖt Thiªn Qu©n vµ Th«ng Thiªn gi¸o chñ cã x¸c suÊt <color=orange>§¸nh r¬i Phï th¹ch<c>.\nNgoµi ra, L«i ChÊn Tö cßn më kho¸ <color=orange>miÔn phÝ ®Æc quyÒn HuyÒn Vò<c>!", menu)
end
function GetLeiZhenZi()
    local Acoountlist = Able_Pet.t_GetPetRight[3].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            if (GetTaskByte(Able_Pet.LeiZhenZi_Pet, 4) == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 1]")
                return
            end
            local flag = 0
            for i = 1426, 1435 do
                if (HaveItemInAllRoom(6, 1, i, 1, 0, 0, 0) > 0) then
                    flag = 1
                    break
                end
            end
            if (flag == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 2]")
                return
            end
            SetTaskByte(Able_Pet.LeiZhenZi_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1426, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc L«i ChÊn Tö QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc L«i ChÊn Tö QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn L«i ChÊn Tö!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterLeiZhenZi()
    Able_Pet.FosterLeiZhenZi()
end

function ShiJi()

    local menu = {
        { "NhËn Th¹ch C¬ N­¬ng N­¬ng", "GetShiJi"; show = 1 },
        { "Th¹ch C¬ N­¬ng N­¬ng-tu luyÖn", "FosterShiJi"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.ShiJi_Pet, 4) == 1) or (GetTaskBit(2109, 4) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.ShiJi_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Khi ®¹t cÊp tèi ®a <c=g>Th¹ch C¬ N­¬ng N­¬ng<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn Nhiªn Chi Lùc]<c> kinh nghiÖm nhiÖm vô Thiªn §×nh ThÇn Thô t¨ng 100%<c>\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[M¹o Mü Tuý Nh©n]<c>Th¹ch C¬ N­¬ng N­¬ngµÄ¾ªÊÀÈÝÃ²ÁîÈË³Á×í, ¿ÉÁîÄãÉÏ½»<c=g>B¸ch Niªn TrÇn Nh­ìngÈÎÎñ<c>Ê±»ñµÃµÄ¾­ÑéÌáÉý100% (×ªÉúºóÌáÉý120%)", menu)
end
function GetShiJi()
    local Acoountlist = Able_Pet.t_GetPetRight[4].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            if (GetTaskByte(Able_Pet.ShiJi_Pet, 4) == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 1]")
                return
            end
            local flag = 0
            for i = 1448, 1457 do
                if (HaveItemInAllRoom(6, 1, i, 1, 0, 0, 0) > 0) then
                    flag = 1
                    break
                end
            end
            if (flag == 1) then
                WriteLog("[Linh Sñng Thuéc TÝnh][LÆp l¹i nhËn Linh Sñng 2]")
                return
            end
            SetTaskByte(Able_Pet.ShiJi_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1448, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Th¹ch C¬ N­¬ng N­¬ng QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Th¹ch C¬ N­¬ng N­¬ng QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Th¹ch C¬ N­¬ng N­¬ng!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterShiJi()
    Able_Pet.FosterShiJi()
end

function TaiYi()

    local menu = {
        { "NhËn Th¸i Êt Ch©n Nh©n", "GetTaiYi"; show = 1 },
        { "Th¸i Êt Ch©n Nh©n-tu luyÖn", "FosterTaiYi"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.TaiYi_Pet, 4) == 1) or (GetTaskBit(2109, 5) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.TaiYi_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Khi ®¹t cÊp tèi ®a <c=g>Th¸i Êt Ch©n Nh©n<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Tu luyÖn §¾c §¹o]<c>kinh nghiÖm nhiÖm vô thÝ luyÖn ThÊt Qu¶i t¨ng 100%<c>\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Nh­ H÷u ThÇn Trî]<c>Th¸i Êt Ch©n Nh©n´øÓÐ 1 c¸i Õ½¶·ÊôÐÔÔöÒæbuff<c=g>", menu)
end
function GetTaiYi()
    local Acoountlist = Able_Pet.t_GetPetRight[5].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            SetTaskByte(Able_Pet.TaiYi_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1465, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Th¸i Êt Ch©n Nh©n QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Th¸i Êt Ch©n Nh©n QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Th¸i Êt Ch©n Nh©n!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterTaiYi()
    Able_Pet.FosterTaiYi()
end

function DaJi()

    local menu = {
        { "NhËn §¸t Kû", "GetDaJi"; show = 1 },
        { "§¸t Kû-tu luyÖn", "FosterDaJi"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.DaJi_Pet, 4) == 1) or (GetTaskBit(2109, 6) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.DaJi_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Khi ®¹t cÊp tèi ®a <c=g>§¸t Kû<c> cã nh÷ng kü n¨ng sau:\n<c=y>[ThiÕu N÷ Hoµi Xu©n]<c> kinh nghiÖm nhiÖm vô thu thËp ®¹o cô t¨ng 100%<c>\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Së Së §éng Nh©n]<c> ThÇn Thô nhËn ®­îc ®é tr­ëng thµnh, Tø T­îng Linh Tª nhËn ®­îc L©m Tiªn Lé<c=g>", menu)
end
function GetDaJi()
    local Acoountlist = Able_Pet.t_GetPetRight[6].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            SetTaskByte(Able_Pet.DaJi_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1478, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc §¸t Kû QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc §¸t Kû QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn §¸t Kû!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterDaJi()
    Able_Pet.FosterDaJi()
end

function ShenGongBao()

    local menu = {
        { "NhËn Th©n C«ng B¸o", "GetShenGongBao"; show = 1 },
        { "Th©n C«ng B¸o-tu luyÖn", "FosterShenGongBao"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.ShenGongBao_Pet, 4) == 1) or (GetTaskBit(2109, 7) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.ShenGongBao_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Khi ®¹t cÊp tèi ®a <c=g>Th©n C«ng B¸o<c> cã nh÷ng kü n¨ng sau:\n<c=y>[B¸t DiÖn Linh Lung]<c> kinh nghiÖm nhiÖm vô th¨m dß t×nh b¸o t¨ng 100%<c>\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Hoa Ng«n X¶o Ng÷]<c> t¹i Phong L©m ®æi lÖnh bµi vËn l­¬ng nhËn ®­îc thªm 1~5 T­íng Qu©n LÖnh (Kho¸)<c=g>", menu)
end
function GetShenGongBao()
    local Acoountlist = Able_Pet.t_GetPetRight[7].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            SetTaskByte(Able_Pet.ShenGongBao_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1488, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Th©n C«ng B¸o QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Th©n C«ng B¸o QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Th©n C«ng B¸o!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterShenGongBao()
    Able_Pet.FosterShenGongBao()
end

function HuangFeiHu()

    local menu = {
        { "NhËn Hoµng Phi Hæ", "GetHuangFeiHu"; show = 1 },
        { "Hoµng Phi Hæ-tu luyÖn", "FosterHuangFeiHu"; show = 1 },
    }
    if (GetTaskByte(Able_Pet.HuangFeiHu_Pet, 4) == 1) or (GetTaskBit(2109, 8) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(Able_Pet.HuangFeiHu_Pet, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask("Khi ®¹t cÊp tèi ®a <c=g>Hoµng Phi Hæ<c> cã nh÷ng kü n¨ng sau:\n<c=y>[H¹o Nhiªn ChÝnh KhÝ]<c> kinh nghiÖm nhiÖm vô Siªu ®é t¨ng 30%-100%<c>\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[ý ChÝ BÊt T]<c> S¸t th­¬ng c¬ b¶n, Ho¶ S¸t, B¨ng S¸t, Thæ S¸t, tèi ®a, bá qua Kh¸ng L«i 30%", menu)
end
function GetHuangFeiHu()
    local Acoountlist = Able_Pet.t_GetPetRight[8].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            SetTaskByte(Able_Pet.HuangFeiHu_Pet, 4, 1)
            AddNormalItemBind(6, 1, 1498, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Hoµng Phi Hæ QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ngµi nhËn ®­îc Hoµng Phi Hæ QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn Hoµng Phi Hæ!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterHuangFeiHu()
    Able_Pet.FosterHuangFeiHu()
end

function NewAllPetsOne(nIndex)
    nIndex = nIndex + 1
    if (nIndex <= 8) then
        no()
        return 0
    end

    SetTask(142, nIndex)
    local list = {}
    list = TaskTable_NewAllPet[nIndex - 8]
    local nPetTask = list.taskvalue[1]
    local sPetName = list.petname
    local menu = {
        { "NhËn" .. sPetName, "GetNewPetOne"; show = 1 },
        { sPetName .. " tu luyÖn", "FosterNewPet"; show = 1 },
    }
    if (GetTaskByte(nPetTask, 4) == 1) or (GetTaskBit(2109, nIndex) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(nPetTask, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask(list.wenzi, menu)
end
function GetNewPetOne()
    local nIndex = GetTask(142)
    if (nIndex <= 8) then
        no()
        return 0
    end

    local Acoountlist = Able_Pet.t_GetPetRight[nIndex].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            local list = TaskTable_NewAllPet[nIndex - 8]
            local sPetName = list.petname
            local id = list.task[1].id
            SetTaskByte(list.taskvalue[1], 4, 1)
            AddNormalItemBind(id[1], id[2], id[3], id[4], 0, 0, 1)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. sPetName .. " QuyÓn Trôc cÊp 1!")
            Talk(1, "no", "Ng­¬i ®· nhËn ®­îc " .. sPetName .. " QuyÓn Trôc cÊp 1!")
            WriteLog("NhËn " .. sPetName .. "!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterNewPet()
    local nIndex = GetTask(142)
    if (nIndex <= 8) then
        no()
        return 0
    end

    Able_Pet.FosterNewAllPet(nIndex - 8)
end

function AllPetsOne2New(nIndex)
    nIndex = nIndex + 1
    if (nIndex <= 0) or (nIndex > table.getn(TaskTable_AllPet2New)) then
        no()
        return 0
    end

    SetTask(142, nIndex)
    local list = {}
    list = TaskTable_AllPet2New[nIndex]
    local nPetTask = list.taskvalue[1]
    local sPetName = list.petname
    local menu = {
        { "NhËn " .. sPetName, "GetPetOne2New"; show = 1 },
        { sPetName .. " tu luyÖn", "FosterPet2New"; show = 1 },
    }
    if (GetTaskByte(nPetTask, 4) == 1) or (GetTaskBit(2109, nIndex) > 0) then
        menu[1].show = 0
    end
    if (GetTaskByte(nPetTask, 2) >= 10) then
        menu[2].show = 0
    end
    SayTask(list.wenzi, menu)
end
function GetPetOne2New()
    local nIndex = GetTask(142)
    if (nIndex <= 0) then
        no()
        return 0
    end

    if (GetLevel() < 121 and GetNewBirthTimes() < 1) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t 121, kh«ng thÓ nhËn Linh sñng Thuéc tÝnh.")
        return 0
    end

    local Acoountlist = Able_Pet.t_GetPetRight[nIndex + 24].Acoountlist
    if (HaveIBBuff(628) > 0 or HaveIBBuff(629) > 0) then
        Talk(1, "no", "Ngµi ®ang trong thêi gian chê chuyÓn nh©n vËt, kh«ng thÓ nhËn sñng vËt thuéc tÝnh..")
        return
    end
    local account = GetPlayerAccount()
    for i = 1, table.getn(Acoountlist) do
        if (account == Acoountlist[i]) then
            local list = TaskTable_AllPet2New[nIndex]
            local sPetName = list.petname
            local id = list.id
            SetTaskByte(list.taskvalue[1], 4, 1)
            SetTaskByte(list.taskvalue[1], 2, 1)
            AddNormalItemBind(id[1], id[2], id[3], id[4], 0, 0, 1)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. sPetName .. " QuyÓn Trôc!")
            Talk(1, "no", "Ng­¬i ®· nhËn ®­îc " .. sPetName .. " QuyÓn Trôc!")
            WriteLog("NhËn " .. sPetName .. "!")
            return
        end
    end
    Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t ®ñ ®iÒu kiÖn nhËn.")
end
function FosterPet2New()
    no()
    local nIndex = GetTask(142)
    if (nIndex <= 0) or (nIndex > table.getn(TaskTable_AllPet2New)) then
        Msg2Player("Sai th«ng tin, vui lßng chän l¹i")
        return 0
    end

    Able_Pet.FosterAllPet2New(nIndex)
end
function PetCombos()
    no()
    local tasks = {
        { "<c=y>KÝch ho¹t Tæ hîp kü<c>", "getPetCombos"; show = 1 },
        { "B¶o ®iÓn", "PetCombosInfo"; show = 1 },
        { "Tr­íc", "limitPet"; show = 1 },
    }
    SayTask("GÇn ®©y ta ph¸t hiÖn ra sù t­¬ng quan gi÷a c¸c linh sñng thuéc tÝnh, nÕu lËp mét trµng ph¸p tù, cã thÓ kÝch ho¹t vµ sinh ra tæ hîp linh sñng, sau khi tæ hîp sÏ nhËn ®­îc <c=y>tæ hîp kü<c>, cã thÓ mang theo <c=g>2 kü n¨ng linh sñng<c> xuÊt hµnh, oai phong kh«ng ai ®Þch næi.", tasks)
end

function PetCombosInfo()
    no()
    Talk(1, "PetCombosInfo3", "<c=y>Trung KhuyÓn Tuú Chñ<c>: <c=g>D­¬ng TiÔn<c>+<c=g>Hao Thiªn KhuyÓn<c>: \nCã kü n¨ng Tu luyÖn Thiªn Giíi: Treo m¸y t¹i Thiªn th­îng cã x¸c suÊt nhËn ®­îc Minh Quang Ng­ng Lé, giíi h¹n mçi ngµy 1 c¸i. Minh Quang Ng­ng Lé: §¸nh qu¸i trªn thiªn th­îng t¨ng 1.5 lÇn kinh nghiÖm trong 1 giê\n<c=y>TuyÖt §¹i Song KiÒu<c>: <c=g>§¸t Kû<c>+<c=g>Hå HØ MÞ<c>: \nCã kü n¨ng Lo¹n Hoa Mª Nh·n: Gi¶m x¸c suÊt bÞ b¹o kÝch vËt lý, ph¸p thuËt 5%")
end

function PetCombosInfo1()
    no()
    Talk(1, "PetCombosInfo11", "<c=y>TuyÖt Gi¸o Tinh NhuÖ<c>: <c=g>Th¹ch C¬<c>+<c=g>Th©n C«ng B¸o<c>: \nCã kü n¨ng ThuËt ch¹y trèn: TÊt c¶ kh¸ng tÝnh+5%, Gi¶m thêi gian thä th­¬ng 25 ®iÓm")
end

function PetCombosInfo11()
    no()
    Talk(1, "PetCombos", "<c=y>ChÝnh NghÜa Chi §¹o<c>: <c=g>Hoµng Phi Hæ<c>+<c=g>L«i ChÊn Tö<c>: \nCã kü n¨ng NhÊt Th©n ChÝnh KhÝ: ChÞu S¸t th­¬ng c¬ b¶n, s¸t th­¬ng PhÊp thuËt gi¶m 5%")
end

function PetCombosInfo2()
    no()
    Talk(1, "PetCombosInfo1", "<c=y>§øc Cao Väng Träng<c>: <c=g>Kh­¬ng Tö Nha<c>+<c=g>Lý TÞnh<c>: \nCã kü n¨ng HiÒn Gi¶ trî uy, t¨ng thêi gian thä th­¬ng 10, s¸t th­¬ng c¬ b¶n +30 ®iÓm")
end

function PetCombosInfo3()
    no()
    Talk(1, "PetCombosInfo2", "<c=y>Y B¸t T­¬ng TruyÒn<c>: <c=g>Th¸i Êt<c>+<c=g>Na Tra<c>: \nCã kü n¨ng S­ §å T­¬ng Hç: Sè lÇn Hé chñ +1, t¨ng tèc ®é xuÊt chiªu vò khÝ, ma ph¸p 2%")
end

function getPetCombos()
    local list = {}
    list[1] = "Trë l¹i Trang tr­íc/PetCombos"
    for i = 1, 6 do
        list[i + 1] = L_PETCOMBOS[i].name .. "/isPetCombos"
    end
    Say("Muèn kÝch ho¹t Tæ hîp Kü n¨ng Linh thó, ngµi cÇn cã <c=g>2 Linh Sñng cÊp 10 trë lªn<c> ®· ®­îc thu n¹p vµo Hép Linh Sñng B¸ch BiÕn. §ång thêi giao cho ta <c=g> 10 c¸i Tinh Hoa Tiªn Sñng+20T­íng Qu©n LÖnh<c> ta cã thÓ gióp ngµi lµm phÐp KÝch ho¹t Tæ hîp kü\nChän tæ hîp ngµi muèn kÝch ho¹t:", table.getn(list), list)
end

function isPetCombos(index)
    no()
    if (index <= 0) or (index > table.getn(L_PETCOMBOS)) then
        Talk(1, "PetCombos", "Lùa chän sai, xin h·y chän l¹i tæ hîp kü!")
        return 0
    end

    SetTask(140, index)
    MsgBox("Mang theo tæ hîp Linh Sñng " .. L_PETCOMBOS[index].name .. ", ngoµi 2 kü n¨ng cña linh sñng, cßn nhËn ®­îc thuéc tÝnh d­íi ®©y:\n" .. L_PETCOMBOS[index].info, "isPetCombosYes1", "PetCombos")
end

function isPetCombosYes1()
    local index = GetTask(140)
    if (index <= 0) or (index > table.getn(L_PETCOMBOS)) then
        Talk(1, "PetCombos", "Lùa chän sai, xin h·y chän l¹i tæ hîp kü!")
        return 0
    end

    if (GetTaskByte(L_PETCOMBOS[index].taskIdx[1], L_PETCOMBOS[index].taskIdx[2]) == L_PETCOMBOS[index].petID) then
        Talk(1, "PetCombos", "Ngµi <c=r>®· kÝch ho¹t<c> qua tæ hîp kü n¨ng nµy, xin h·y chän l¹i!")
        return 0
    end

    local temp = {}
    temp = L_PETCOMBOS[index].pet1
    if (GetTaskBit(temp[3], temp[4]) == 0) then
        if (GetTaskBit(temp[1], temp[2]) == 0) or (Able_Pet.JudgePetItem(L_PETCOMBOS[index].petname1) == 1) then
            Talk(1, "PetCombos", "ThËt xin lçi, Linh sñng cña ngµi <c=r>" .. L_PETCOMBOS[index].petname1 .. "<c> ch­a ®¹t cÊp 10, xin h·y chän l¹i!\nLinh sñng cÇn ph¶i ®­îc thu vµo Hép Linh Sñng B¸ch BiÕn..")
            return 0
        end
    end

    temp = L_PETCOMBOS[index].pet2
    if (GetTaskBit(temp[3], temp[4]) == 0) then
        if (GetTaskBit(temp[1], temp[2]) == 0) or (Able_Pet.JudgePetItem(L_PETCOMBOS[index].petname2) == 1) then
            Talk(1, "PetCombos", "ThËt xin lçi, Linh sñng cña ngµi <c=r>" .. L_PETCOMBOS[index].petname2 .. "<c> ch­a ®¹t cÊp 10, xin h·y chän l¹i!\nLinh sñng cÇn ph¶i ®­îc thu vµo Hép Linh Sñng B¸ch BiÕn..")
            return 0
        end
    end

    if (HaveNormalItem(3, 100, 0, 0) < 20) then
        Talk(1, "no", "ThËt xin lçi, <c=r>T­íng Qu©n LÖnh<c>²»×ã 20 c¸i, ÎÞ·¨KÝch ho¹t Tæ hîp kü.")
        return
    end

    local num = 10
    local num1 = HaveNormalItem(3, 1638, 0, 0)
    local num2 = HaveNormalItem(3, 1634, 0, 0)
    local num3 = HaveNormalItem(3, 1639, 0, 0)
    if (num3 > 0) and (index == 1) then
        num = num - 7 - num2
    else
        num = num - math.min(num1, 2) * 4 - num2
    end

    if (num > 0) then
        Talk(1, "no", "ThËt xin lçi, <c=r>Tinh Hoa Tiªn Sñng<c> kh«ng ®ñ 10 c¸i, kh«ng thÓ KÝch ho¹t Tæ hîp kü.\nPhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng cã thÓ gióp khÊu trõ 4 c¸i Tinh Hoa Tiªn Sñng, tèi ®a dïng 2 phiÕu\nPhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng (Chuyªn dông) cã thÓ gióp khÊu trõ 7 c¸i Tinh Hoa Tiªn Sñng, tèi ®a dïng 1 phiÕu\nHai lo¹i nµy kh«ng thÓ dïng chung!")
        return
    end
    if (num3 > 0) and (index == 1) then
        MsgBox("Ngµi x¸c ®Þnh kÝch ho¹t <c=y>" .. L_PETCOMBOS[index].name .. "<c> tæ hîp kü sao?\nCÇn <c=g>" .. L_PETCOMBOS[index].petname1 .. "<c> vµ <c=g>" .. L_PETCOMBOS[index].petname2 .. "<c> cÊp 10 trë lªn, vµ tiªu hao thªm <c=g> 10 c¸i Tinh Hoa Tiªn Sñng<c> cïng <c=g> 20 c¸i T­íng Qu©n LÖnh<c>.\nMÆc ®Þnh sÏ dïng phiÕu ®Ó khÊu trõ 7 c¸i Tinh Hoa Tiªn Sñng, nªn cho phiÕu vµo r­¬ng nÕu ch­a muèn sö dông!", "isPetCombosYes", "PetCombos")
    else
        MsgBox("Ngµi x¸c ®Þnh kÝch ho¹t <c=y>" .. L_PETCOMBOS[index].name .. "<c> tæ hîp kü sao?\nCÇn <c=g>" .. L_PETCOMBOS[index].petname1 .. "<c> vµ <c=g>" .. L_PETCOMBOS[index].petname2 .. "<c> cÊp 10 trë lªn, vµ tiªu hao thªm <c=g> 10 c¸i Tinh Hoa Tiªn Sñng<c> cïng <c=g> 20 c¸i T­íng Qu©n LÖnh<c> NÕu cã PhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng sÏ ­u tiªn khÊu trõ!", "isPetCombosYes", "PetCombos")
    end

end

function isPetCombosYes()
    local index = GetTask(140)
    SetTask(140, 0)
    if (index <= 0) or (index > table.getn(L_PETCOMBOS)) then
        Talk(1, "PetCombos", "Lùa chän sai, xin h·y chän l¹i tæ hîp kü!")
        return 0
    end

    if (HaveNormalItem(3, 100, 0, 0) < 20) then
        Talk(1, "no", "ThËt xin lçi, <c=r>T­íng Qu©n LÖnh<c>²»×ã 20 c¸i, ÎÞ·¨KÝch ho¹t Tæ hîp kü.")
        return
    end

    local num1 = HaveNormalItem(3, 1638, 0, 0)
    local num2 = 10
    local num3 = HaveNormalItem(3, 1639, 0, 0)
    if (num1 > 2) then
        num1 = 2
    end

    if (num3 > 1) then
        num3 = 1
    end

    if (num3 > 0) and (index == 1) then
        num2 = 3
    else
        num2 = 10 - num1 * 4
    end

    if (HaveNormalItem(3, 1634, 0, 0) < num2) then
        Talk(1, "no", "ThËt xin lçi, PhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng tèi ®a chØ ®­îc dïng 2 tÊm, <c=r>Tinh Hoa Tiªn Sñng<c> cña ngµi kh«ng ®ñ " .. num2 .. " c¸i, kh«ng thÓ KÝch ho¹t Tæ hîp kü\nPhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng cã thÓ gióp khÊu trõ 4 c¸i Tinh Hoa Tiªn Sñng, tèi ®a dïng 2 phiÕu\nPhiÕu lo¹i chuyªn dông cã thÓ khÊu trõ 7 c¸i Tinh Hoa Tiªn Sñng, tèi ®a dïng 1 phiÕu\nHai lo¹i nµy kh«ng thÓ dïng chung!")
        return
    end

    if (DelNormalItem(3, 1634, 0, 0) > 0) then
        for i = 1, 20 do
            DelNormalItem(3, 100, 0, 0)
        end
        if (num3 > 0) and (index == 1) then
            DelNormalItem(3, 1639, 0, 0)
        else
            for i = 1, num1 do
                DelNormalItem(3, 1638, 0, 0)
            end
        end

        for i = 1, (num2 - 1) do
            DelNormalItem(3, 1634, 0, 0)
        end

        local name = L_PETCOMBOS[index].name
        SetTaskByte(L_PETCOMBOS[index].taskIdx[1], L_PETCOMBOS[index].taskIdx[2], L_PETCOMBOS[index].petID)
        Msg2Player("Chóc mõng ngµi thµnh c«ng kÝch ho¹t tæ hîp Linh Sñng " .. name .. ", cã thÓ triÖu gäi ra tõ Hép Linh Sñng B¸ch BiÕn, ®· tiªu hao " .. num1 .. " PhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng, " .. num2 .. " Tinh Hoa Tiªn Sñng vµ 20 c¸i T­íng Qu©n LÖnh.")
        WriteLog("[KÝch ho¹t Tæ hîp kü][" .. num1 .. " c¸i phiÕu khÊu trõ, " .. num2 .. " Tinh Hoa Tiªn Sñng, 20 c¸i T­íng Qu©n LÖnh]" .. name)
        Talk(1, "no", "Chóc mõng ngµi thµnh c«ng kÝch ho¹t tæ hîp Linh Sñng <c=y>" .. name .. "<c>, cã thÓ dïng Hép Linh Sñng B¸ch BiÕn triÖu håi tæ hîp linh sñng.")

    else
        Talk(1, "no", "ThËt xin lçi, <c=r>Tinh Hoa Tiªn Sñng<c>²»×ã 1 c¸i, ÎÞ·¨KÝch ho¹t Tæ hîp kü.")
        return
    end
end

