task_gather = 1289
lastDate = 1290

beadCount_Must = 8

grass_renwu = 1322
grass_npcDialog = 1323

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
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

    startLevel = 15
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskKnight == 130) or (taskWizard == 130) or (taskDruid == 130) then
                state = 1
                subState = 0
            elseif (taskKnight == 132) or (taskWizard == 132) or (taskDruid == 132) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 130) or (taskWizard == 130) or (taskDruid == 130) then
                state = 1
                subState = 1
            elseif (taskKnight == 132) or (taskWizard == 132) or (taskDruid == 132) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 18
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local task = GetTaskByte(grassrenwu, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskBit(grass_npcDialog, 3) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskBit(grass_npcDialog, 3) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 1
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

function main()
    if (plant() == 0) then
        local tasks = {
            { "BÊt Kú Nhi Ngé", "renwu15"; show = 0 },
            { "Song Sinh BØ Ng¹n", "DoubleBank"; show = 0 },
            { "Huû nhiÖm vô", "CancelTask"; show = 0 }
        }

        local UTask_Wizard = GetTask(1)
        local UTask_Knight = GetTask(3)
        local UTask_Druid = GetTask(2)
        if (UTask_Knight == 130) or (UTask_Wizard == 130) or (UTask_Druid == 130) then
            if (GetPlayerExtLevel() >= 15) then
                tasks[1].show = 1
            end
        elseif (UTask_Knight == 132) or (UTask_Wizard == 132) or (UTask_Druid == 132) then
            tasks[1].show = 1
        end

        if (GetPlayerExtLevel() >= 3) then
            if (GetTaskByte(task_gather, 1) > 0) then
                tasks[2].show = 1
                tasks[3].show = 1
            else
                tasks[2].show = 1
            end
        end

        SayTask("§¼ng cÊp Nh©n giíi cña ng­¬i sÏ ¶nh h­ëng tíi viÖc tu luyÖn Tiªn Ma giíi, chØ khi ®¼ng cÊp Nh©n giíi cao h¬n Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi nhËn ®­îc hiÖu qu¶ tu luyÖn.", tasks)
    end
end;

function renwu15()
    local credit = GetJusticEvilCredit()
    if (credit >= 0) then
        Talk(1, "no", "Danh väng Ma giíi cña ng­¬i ch­a ®ñ, sau nµy h·y quay l¹i nhÐ!")
        return 0
    end

    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (UTask_Knight == 130) or (UTask_Wizard == 130) or (UTask_Druid == 130) then
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 131)
            TaskNote(86, 1)
            TaskNote(27, -1)
        elseif (pt == 1) then
            SetTask(1, 131)
            TaskNote(87, 1)
            TaskNote(28, -1)
        else
            SetTask(2, 131)
            TaskNote(88, 1)
            TaskNote(29, -1)
        end ;

        refreshNpcTaskState()

        Talk(1, "no", "B¹n trÎ ®Õn BÊt Chu Thiªn quan còng ®· l©u råi, ®· ®Õn lóc kh¶o nghiÖm n¨ng lùc cña m×nh. Nghe nãi ë <c=g>phÝa b¾c<c> gÇn ®©y xuÊt hiÖn nhiÒu ng­êi l¹ mÆt, h·y ®Õn ®ã th¸m thÝnh thö!")
    elseif (UTask_Knight == 132) or (UTask_Wizard == 132) or (UTask_Druid == 132) then
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 133)
            TaskNote(86, 3)
        elseif (pt == 1) then
            SetTask(1, 133)
            TaskNote(87, 3)
        else
            SetTask(2, 133)
            TaskNote(88, 3)
        end ;

        AddNormalItem(6, 1, 439, 0, 0, 0)
        Talk(3, "no", "Sao quay l¹i sím vËy! Sao thÇn s¾c ho¶ng lo¹n vËy?", "§¹i s­! T¹i h¹ tu©n lÖnh ®Õn ®©y th¸m thÝnh t×nh h×nh nhiÒu ng­êi l¹ xuÊt hiÖn n¬i ®©y. Ph¸t hiÖn cã 1 ng­êi tr­íc ®©y lµ cõu nh©n cña t¹i h¹! HiÖn t¹i c« ta ®ang tróng kÞch ®éc! Ph¶i lµm sao ®©y?", "GÇn ®©y cã 1 Linh Xµ thô, v¶y Linh Xµ trªn c©y ®ã cã thÓ gi¶i ®éc. Giê ng­¬i ph¶i t×m c¸ch dô ®­îc Linh Xµ ®Õn chç cña ng­êi bÖnh, ®îi Linh Xµ ph¸t xuÊt ¸c tÝnh, lóc ®ã tiªu diÖt sÏ lÊy ®­îc V¶y r¾n.", "§©y lµ DiÖp Tö Tiªu, cã thÓ dïng nã ®Ó dô Linh Xµ xuÊt hiÖn. Chó ý: DiÖp Tö Tiªu nµy chØ cã thÓ mª hoÆc ®­îc Linh Xµ trong 15 phót. NÕu thÊt b¹i ph¶i quay l¹i chç Linh Xµ thô gäi l¹i Linh Xµ.")

        refreshNpcTaskState()


    end
end;

function no()
    CloseDialog()
end;

function getExp()
    local experience

    local lvl = GetPlayerExtLevel()
    local logstr = "]"
    if (lvl < 5) then
        experience = 2000
    elseif (lvl < 10) then
        experience = 4000
    else
        experience = 7000 + math.floor((lvl - 10) / 20) * 1000
    end

    if (GetWeekDay() == 6) then
        Msg2Player("NhiÖm vô chñ ®Ò ngµy h«m nay lµ Ë«Éú±Ë°¶, chóc m­õng ngµi, nhËn ®­îc th­ëng tu vi gÊp ®«i")
        logstr = logstr .. "Chñ ®Ò ngµy"
        local nDoubel = 1
        if (HaveIBBuff(2094) > 0) then
            nDoubel = nDoubel + 1
            CostIBBuff(2094, 1)
            Msg2Player("Do ngµi sö dông Phï nhiÖm vô Chñ ®Ò ngµy-Tiªn Ma, phÇn th­ëng lÇn nµy t¨ng 100%.")
            logstr = logstr .. "+ Phï Chñ ®Ò ngµy Tiªn Ma"
        end

        local nBuffLevel = GetIBBuffLevel(2095) + 1
        if (HaveIBBuff(2095) > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
            nDoubel = nDoubel + nBuffLevel
            Msg2Player("HiÖn trong thêi gian ho¹t ®éng gÊp ®«i chñ ®Ò ngµy Tiªn Ma, nhËn ®­îc phÇn th­ëng lín h¬n.")
            logstr = logstr .. "+2095buff" .. nBuffLevel
        end

        experience = experience + math.floor(experience * nDoubel)
    end

    local nFactExp = math.floor(AddOwnExtendExp(experience))
    if (nFactExp < experience) then
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("Ng­¬i ch­a hoµn thµnh §é KiÕp hoÆc cÊp ®é Nh©n gian qu¸ thÊp, kh«ng thÓ lÜnh héi ®ñ tu vi Tiªn Ma, chØ t¨ng lªn " .. nFactExp .. " ®iÓm")
    else
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
    end
    WriteLog("[Ë«Éú±Ë°¶][Kinh nghiÖm: " .. nFactExp .. "/" .. experience .. logstr)

    return nFactExp
end

function DoubleBank()
    if (GetJusticEvilCredit() < 0) then
        if (GetTaskByte(task_gather, 1) > 0) then
            MsgBox("S¾c mÆt cña ng­¬i cã nhiÒu h¾c khÝ. Gióp ta ®i t×m 8 <c=g>M¹n Ch©u Sa hoa<c>, ta sÏ gióp ng­¬i gi¶i n¹n!", "SubmitBead", "no")
        else
            MsgBox("M¹n Ch©u Sa hoa t­îng tr­ng cho ®iÒm lµnh, lµ b¶o vËt cña thÕ gian. NÕu ng­¬i t×m ®­îc <c=g>8 M¹n Ch©u Sa hoa<c>, ta cã thÓ gióp ng­¬i t¨ng n¨ng lùc tu hµnh!", "ReceiveTask", "no")
        end
    else
        Talk(1, "no", "ChØ cã ng­êi cña Ma ph¸i míi ®­îc nhËn nhiÖm vô nµy!")
    end
end

function SubmitBead()
    local today = math.floor(LocalSystemTime() / 86400)
    if (HaveNormalItem(3, 312, 0, 0) < beadCount_Must) then
        Talk(1, "no", "VÉn ch­a ®ñ 8 ®o¸! H·y cè g¾ng lªn!")
        return
    end

    local experience = getExp()
    if (today ~= GetTask(lastDate)) then

        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 2, 0)
        SetTaskByte(task_gather, 3, 1)
        SetTask(lastDate, today)

        for i = 1, beadCount_Must do
            DelNormalItem(3, 312, 0, 0)
        end

        Talk(1, "no", "§· ®ñ sè hoa, n¨ng lùc cña ng­¬i ®· t¨ng thªm " .. experience .. " ®iÓm. <c=g>M¹n Ch©u Sa hoa<c> lµ b¶o vËt cña thÕ gian, sè cßn l¹i nµy ng­¬i h·y cÊt gi÷ cÈn thËn, vÒ sau cã lóc dïng ®Õn!")
        TaskNote(1028, -1)
        TaskNote(1023, -1)
    else
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 3, 1)
        SetTask(lastDate, today)

        for i = 1, beadCount_Must do
            DelNormalItem(3, 312, 0, 0)
        end

        Talk(1, "no", "§· ®ñ sè hoa, n¨ng lùc cña ng­¬i ®· t¨ng thªm " .. experience .. " ®iÓm. <c=g>M¹n Ch©u Sa hoa<c> lµ b¶o vËt cña thÕ gian, sè cßn l¹i nµy ng­¬i h·y cÊt gi÷ cÈn thËn, vÒ sau cã lóc dïng ®Õn!")
        TaskNote(1028, -1)
        TaskNote(1023, -1)
    end
end

function ReceiveTask()
    local today = math.floor(LocalSystemTime() / 86400)
    local taskNumber = GetTaskByte(task_gather, 2)
    if (today ~= GetTask(lastDate)) then
        SetTaskByte(task_gather, 1, 1)
        SetTaskByte(task_gather, 2, 1)
        SetTaskByte(task_gather, 3, 0)
        SetTask(lastDate, today)
        AddNormalItem(8, 500, 0, 0, 0, 0)
        Talk(1, "Answer", "M¹n Ch©u Sa hoa rÊt khã në hoa. Ta tÆng ng­¬i <c=g>Cam Lé<c> nµy ®Ó t­íi cho chóng mau në. Chóng ë gÇn ®©y th«i! Mau ®i mau vÒ!")
        TaskNote(1028, 0, 8, "M¹n ch©u sa hoa")
        SyncBibleState(1023, 0, 1)
    else
        if (taskNumber >= 4) then
            Talk(1, "no", "Tu hµnh kh«ng ®­îc gÊp g¸p, mçi ngµy chØ cÇn t¨ng <c=r>4<c> lÇn lµ ®ñ!")
        else
            taskNumber = taskNumber + 1
            SetTaskByte(task_gather, 1, 1)
            SetTaskByte(task_gather, 2, taskNumber)
            SetTaskByte(task_gather, 3, 0)
            SetTask(lastDate, today)
            AddNormalItem(8, 500, 0, 0, 0, 0)
            Talk(1, "Answer", "H«m nay ®©y lµ nhiÖm vô thø" .. taskNumber .. ", ®©y lµ <c=g>Cam Lé<c>. H·y mau ®i t×m hoa!")
            TaskNote(1028, 0, 8, "M¹n ch©u sa hoa")
            TopMessage("NhËn ®­îc 1 <c=g>Cam Lé<c>!")
            if (taskNumber >= 4) then
                SyncBibleState(1028, 3, 1)
            end
        end
        SyncBibleState(1023, 0, 1)
    end
end

function Answer()
    Talk(1, "no", GetName() .. "Ta sÏ mau ®i mau vÒ!")
end

function CancelTask()
    if (GetJusticEvilCredit() < 0) then
        MsgBox("Ng­¬i kh«ng muèn ®i t×m M¹n Ch©u Sa hoa th× th«i vËy, ta sÏ thu l¹i Cam Lé. Mçi ngµy ta chØ cã thÓ tÆng cho ng­¬i 4 b×nh Cam Lé mµ th«i. VÉn quyÕt ®Þnh huû nhiÖm vô ­?", "yes_Cancel", "no")
    else
        Talk(1, "no", "ChØ cã ng­êi cña Ma ph¸i míi ®­îc nhËn nhiÖm vô nµy!")
    end
end

function yes_Cancel()
    local today = math.floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(lastDate)) then
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 2, 0)
        SetTaskByte(task_gather, 3, 2)
        SetTask(lastDate, today)
    else
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 3, 2)
        SetTask(lastDate, today)
    end

    ClearItem(8, 500, 0, 0)
    Talk(1, "no", "NhiÖm vô ®· hñy bá, sau nµy sÏ cßn c¬ héi!")
end

function plant()
    if (GetTaskByte(grass_renwu, 1) == 2) and (GetJusticEvilCredit() < 0) then
        if (GetTaskBit(grass_npcDialog, 3) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
            CloseDialog()
            Talk(1, "plantmotion", "Lo¹i Linh th¶o nµy cÇn linh lùc rÊt lín, Ph¸p lùc cña ta chØ cã h¹n, ng­¬i ®i t×m thªm ng­êi kh¸c gióp ®ì nhÐ!")
            return 1
        end
    end
    return 0
end

function plantmotion()
    CloseDialog()
    BeginMotion(grass_npcDialog + 3, 0, 3, "\\script\\motion\\¶Ô»°½ø¶ÈÏìÓ¦.lua", 0)
end

