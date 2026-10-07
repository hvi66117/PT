--description:ĞŞĞĞÊ¦ Ä§
--author: yaoxin
--date:2009/1/12
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-17
task_gather = 1289            -- 1byte:ÊÇ·ñ½ÓÊÜÈÎÎñ£»2byte£ºÒÑÁìÈ¡µÄÈÎÎñ´ÎÊı£»3byte£ºÒÑ²É¼¯µ½µÄÂüÍÓÂŞ»ªµÄ¸öÊı(ÒÑ¾­·ÏÆú£¬¸Ä×ö×´Ì¬±êÖ¾ £¬1Íê³É£¬2È¡Ïû£¬0ÊÇ½Ó)
lastDate = 1290              -- ÉÏÒ»´ÎÁìÈ¡ÈÎÎñµÄÈÕÆÚ

beadCount_Must = 8            --ĞèÒª²É¼¯µÄÂüÍÓÂŞ»ªµÄ¸öÊı


--ÖíÁıÖ®²İÈÎÎñËµÃ÷
grass_renwu = 1322 --1byte ÈÎÎñ×´Ì¬(µ¥ÊıÏÉ£¬Ë«ÊıÄ§) 2byte ²¶×½¸öÊı 3byte ³æ¹í³öÏÖÉÏÏŞ
grass_npcDialog = 1323 --1-9bit npcÊÇ·ñ¶Ô»°
---

-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --²»ÆÚ¶øÓö
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

    --ÖíÁıÖ®²İ
    startLevel = 18
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local task = GetTaskByte(grassrenwu, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(grass_npcDialog, 3) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    if (plant() == 0) then
        local tasks = {
            { "BÊt Kú Nhi Ngé", "renwu15"; show = 0 },
            { "Song Sinh BØ Ng¹n", "DoubleBank"; show = 0 },
            { "Hñy N.vô", "CancelTask"; show = 0 }
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

        --------------------Ë«Éú±Ë°¶---------
        if (GetPlayerExtLevel() >= 3) then
            --ÈôÏÉÄ§µÈ¼¶´óÓÚ3¼¶
            if (GetTaskByte(task_gather, 1) > 0) then
                --ÈôÁìÈ¡ÁËÈÎÎñ
                tasks[2].show = 1
                tasks[3].show = 1
            else
                tasks[2].show = 1
            end
        end
        ----------------Ë«Éú±Ë°¶------------
        SayTask("§¼ng cÊp Nh©n giíi cña ng­¬i sÏ ¶nh h­ëng tíi viÖc tu luyÖn Tiªn Ma giíi, chØ khi ®¼ng cÊp Nh©n giíi cao h¬n Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi nhËn ®­îc hiÖu qu¶ tu luyÖn.", tasks)
    end
end;

function renwu15()
    local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
    if (credit >= 0) then
        Talk(1, "no", "Danh väng Ma giíi cña ng­¬i ch­a ®ñ, sau nµy h·y quay l¹i nhĞ!")
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
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

        Talk(1, "no", "B¹n trÎ ®Õn BÊt Chu Thiªn quan còng ®· l©u råi, ®· ®Õn lóc kh¶o nghiÖm n¨ng lùc cña m×nh. Nghe nãi ë <c=g>phİa b¾c<c> gÇn ®©y xuÊt hiÖn nhiÒu ng­êi l¹ mÆt, h·y ®Õn ®ã th¸m thİnh thö!")
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

        AddNormalItem(6, 1, 439, 0, 0, 0)--Ò¶×ÓÉÚ
        Talk(3, "no", "Sao quay l¹i sím vËy! Sao thÇn s¾c ho¶ng lo¹n vËy?", "§¹i s­! T¹i h¹ tu©n lÖnh ®Õn ®©y th¸m thİnh t×nh h×nh nhiÒu ng­êi l¹ xuÊt hiÖn n¬i ®©y. Ph¸t hiÖn cã 1 ng­êi tr­íc ®©y lµ cõu nh©n cña t¹i h¹! HiÖn t¹i c« ta ®ang tróng kŞch ®éc! Ph¶i lµm sao ®©y?", "GÇn ®©y cã 1 Linh Xµ thô, v¶y Linh Xµ trªn c©y ®ã cã thÓ gi¶i ®éc. Giê ng­¬i ph¶i t×m c¸ch dô ®­îc Linh Xµ ®Õn chç cña ng­êi bÖnh, ®îi Linh Xµ ph¸t xuÊt ¸c tİnh, lóc ®ã tiªu diÖt sÏ lÊy ®­îc V¶y r¾n.", "§©y lµ DiÖp Tö Tiªu, cã thÓ dïng nã ®Ó dô Linh Xµ xuÊt hiÖn. Chó ı: DiÖp Tö Tiªu nµy chØ cã thÓ mª hoÆc ®­îc Linh Xµ trong 15 phót. NÕu thÊt b¹i ph¶i quay l¹i chç Linh Xµ thô gäi l¹i Linh Xµ.")

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end
end;

function no()
    CloseDialog()
end;

-----------------Ë«Éú±Ë°¶----------------------------------
function getExp()
    --È¡µÃ¾­ÑéµÄº¯Êı
    local experience
    if (GetPlayerExtLevel() < 5) then
        experience = 2000
    elseif (GetPlayerExtLevel() < 10) then
        experience = 4000
    else
        experience = 7000
    end
    return experience
end

function DoubleBank()
    if (GetJusticEvilCredit() < 0) then
        --Íæ¼ÒÎªÄ§
        if (GetTaskByte(task_gather, 1) > 0) then
            MsgBox("S¾c mÆt cña ng­¬i cã nhiÒu h¾c khİ. Gióp ta ®i t×m 8 <c=g>M¹n Ch©u Sa hoa<c>, ta sÏ gióp ng­¬i gi¶i n¹n!", "SubmitBead", "no")
        else
            --Ã»ÓĞÁìÈ¡ÈÎÎñ	
            MsgBox("M¹n Ch©u Sa hoa t­îng tr­ng cho ®iÒm lµnh, lµ b¶o vËt cña thÕ gian. NÕu ng­¬i t×m ®­îc <c=g>8 M¹n Ch©u Sa hoa<c>, ta cã thÓ gióp ng­¬i t¨ng n¨ng lùc tu hµnh!", "ReceiveTask", "no")
        end
    else
        Talk(1, "no", "ChØ cã ng­êi cña Ma ph¸i míi ®­îc nhËn nhiÖm vô nµy!")
    end
end

function SubmitBead()
    local experience = getExp()
    local today = floor(LocalSystemTime() / 86400)
    if (HaveNormalItem(3, 312, 0, 0) < beadCount_Must) then
        --ÊıÁ¿²»×ã 
        Talk(1, "no", "VÉn ch­a ®ñ 8 ®o¸! H·y cè g¾ng lªn!")
    elseif (today ~= GetTask(lastDate)) then
        --ÁìÈ¡ÈÎÎñÓë½»ÈÎÎñ²»ÔÚÍ¬Ò»Ìì£¬Ôò¿ªÊ¼ĞÂµÄÒ»Ìì

        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 2, 0)                            --ÒÑ½ÓÈÎÎñ´ÎÊıÇåÁã
        SetTaskByte(task_gather, 3, 1)
        SetTask(lastDate, today)

        --´Ó±³°üÖĞ¼õÈ¥8¸öÂüÍÓÉ³»ª
        for i = 1, beadCount_Must do
            DelNormalItem(3, 312, 0, 0)
        end

        local nFactExp = AddOwnExtendExp(experience)                        --Ôö¼Ó¾­Ñé
        Talk(1, "no", "§· ®ñ sè hoa, n¨ng lùc cña ng­¬i ®· t¨ng thªm" .. floor(nFactExp) .. " ®iÓm. <c=g>M¹n Ch©u Sa hoa<c> lµ b¶o vËt cña thÕ gian, sè cßn l¹i nµy ng­¬i h·y cÊt gi÷ cÈn thËn, vÒ sau cã lóc dïng ®Õn!")
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm" .. floor(nFactExp) .. "§iÓm")
        TaskNote(1028, -1)
        TaskNote(1023, -1)
    else
        --Í¬Ò»ÌìÄÚ£¬ÈÎÎñ´ÎÊı²»ÓÃÇåÁã
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 3, 1)
        SetTask(lastDate, today)

        --´Ó±³°üÖĞ¼õÈ¥ÂüÖéÉ³»ª
        for i = 1, beadCount_Must do
            DelNormalItem(3, 312, 0, 0)
        end

        local nFactExp = AddOwnExtendExp(experience)                                --Ôö¼Ó¾­Ñé
        Talk(1, "no", "§· ®ñ sè hoa, n¨ng lùc cña ng­¬i ®· t¨ng thªm" .. floor(nFactExp) .. " ®iÓm. <c=g>M¹n Ch©u Sa hoa<c> lµ b¶o vËt cña thÕ gian, sè cßn l¹i nµy ng­¬i h·y cÊt gi÷ cÈn thËn, vÒ sau cã lóc dïng ®Õn!")
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm" .. floor(nFactExp) .. "§iÓm")
        TaskNote(1028, -1)
        TaskNote(1023, -1)
    end
end

function ReceiveTask()
    local today = floor(LocalSystemTime() / 86400)
    local taskNumber = GetTaskByte(task_gather, 2)
    if (today ~= GetTask(lastDate)) then
        SetTaskByte(task_gather, 1, 1)
        SetTaskByte(task_gather, 2, 1)                      --Ò»ÌìÖĞµÚÒ»´Î½ÓÈÎÎñ         
        SetTaskByte(task_gather, 3, 0)
        SetTask(lastDate, today)
        AddNormalItem(8, 500, 0, 0, 0, 0)                     --Ôö¼Ó¸ÊÂ¶
        Talk(1, "Answer", "M¹n Ch©u Sa hoa rÊt khã në hoa. Ta tÆng ng­¬i <c=g>Cam Lé<c> nµy ®Ó t­íi cho chóng mau në. Chóng ë gÇn ®©y th«i! Mau ®i mau vÒ!")
        TaskNote(1028, 0, 8, "M¹n ch©u sa hoa")
        SyncBibleState(1023, 0, 1)
    else
        if (taskNumber >= 4) then
            Talk(1, "no", "Tu hµnh kh«ng ®­îc gÊp g¸p, mçi ngµy chØ cÇn t¨ng <c=r>4<c> lÇn lµ ®ñ!")
        else
            taskNumber = taskNumber + 1
            SetTaskByte(task_gather, 1, 1)
            SetTaskByte(task_gather, 2, taskNumber)         --ÒÑ½ÓÈÎÎñ´ÎÊı¼Ó1
            SetTaskByte(task_gather, 3, 0)
            SetTask(lastDate, today)
            AddNormalItem(8, 500, 0, 0, 0, 0)               --Ôö¼Ó¸ÊÂ¶
            Talk(1, "Answer", "H«m nay ®©y lµ nhiÖm vô thø" .. taskNumber .. ",®©y lµ <c=g>Cam Lé<c>. H·y mau ®i t×m hoa!")
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
        MsgBox("Ng­¬i kh«ng muèn ®i t×m M¹n Ch©u Sa hoa th× th«i vËy, ta sÏ thu l¹i Cam Lé. Mçi ngµy ta chØ cã thÓ tÆng cho ng­¬i 4 b×nh Cam Lé mµ th«i. VÉn quyÕt ®Şnh huû nhiÖm vô ­?", "yes_Cancel", "no")
    else
        Talk(1, "no", "ChØ cã ng­êi cña Ma ph¸i míi ®­îc nhËn nhiÖm vô nµy!")
    end
end

function yes_Cancel()
    local today = floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(lastDate)) then
        --ĞÂµÄÒ»Ìì¿ªÊ¼
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 2, 0)              --ÒÑ½ÓÈÎÎñ´ÎÊıÇåÁã
        SetTaskByte(task_gather, 3, 2)
        SetTask(lastDate, today)
    else
        --Í¬Ò»ÌìÄÚ£¬ÈÎÎñ´ÎÊı²»ÓÃÇåÁã
        SetTaskByte(task_gather, 1, 0)
        SetTaskByte(task_gather, 3, 2)
        SetTask(lastDate, today)
    end

    ClearItem(8, 500, 0, 0)                       --Çå³ı±³°üÖĞµÄ¸ÊÂ¶
    Talk(1, "no", "NhiÖm vô ®· hñy bá, sau nµy sÏ cßn c¬ héi!")
end
-----------------Ë«Éú±Ë°¶----------------------------------

-------------------------------------------ÖíÁıÖ®²İ------------------------------
function plant()
    if (GetTaskByte(grass_renwu, 1) == 2) and (GetJusticEvilCredit() < 0) then
        if (GetTaskBit(grass_npcDialog, 3) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
            CloseDialog()
            Talk(1, "plantmotion", "Lo¹i Linh th¶o nµy cÇn linh lùc rÊt lín, Ph¸p lùc cña ta chØ cã h¹n, ng­¬i ®i t×m thªm ng­êi kh¸c gióp ®ì nhĞ!")
            return 1
        end
    end
    return 0
end

function plantmotion()
    CloseDialog()
    BeginMotion(grass_npcDialog + 3, 0, 3, "\\script\\motion\\¶Ô»°½ø¶ÈÏìÓ¦.lua", 0)
end
------------------------------------------------------