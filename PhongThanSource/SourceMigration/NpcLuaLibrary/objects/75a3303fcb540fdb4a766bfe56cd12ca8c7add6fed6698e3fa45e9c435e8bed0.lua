--description:npc
--author: zhujialiang
--date:2005/4/13

--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-09-1
Task_cold = 1212;
--º®ÊÒÐ§Ó¦ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ£¬3Bit±íÊ¾ÈÎÎñ´ý½»£¬4Bit±íÊ¾½«Æä½»¸øÆäËüNPC½áÊøÈÎÎñ

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓÐþ¶¼´ó·¨Ê¦ÕÒÏôÉý2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×ÈÝ³ÉÑ©Ô­¾ÞÊÞ5Ñ©Ô­¾ÞÊÞÏÖ³öÔ­ÐÎ6»ØÐþ¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 10

    --Ì½ÄÒÈ¡Îï
    startLevel = 18
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) and (HaveNormalItem(3, 9, 0, 0) >= 5) and (HaveNormalItem(3, 13, 0, 0) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess >= 3) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) and (HaveNormalItem(3, 9, 0, 0) >= 5) and (HaveNormalItem(3, 13, 0, 0) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess >= 3) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --º®ÊÒÐ§Ó¦
    startLevel = 21
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) >= 1)) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) < 1)) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 2) == 1) then
                state = 0
                subState = 0
            end
        else
            if (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) >= 1)) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) < 1)) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 2) == 1) then
                state = 0
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end
function main()

    tasks = {
        { "Hµn ThÊt hiÖu øng", "cold"; show = 0 },
        { "<c=yel>Th©m Nan §o¹t VËt<c>", "renwu18"; show = 0 },
    }

    if (GetPlayerType() == 1) then

        local valcold = GetTask(Task_cold)
        if (GetBit(valcold, 4) == 1 and GetBit(valcold, 2) == 0) then
            tasks[1].show = 1
        end

        local state18 = GetTaskByte(Task_newer13, 2)
        if (GetLevel() >= 18) and (state18 == 1 or state18 == 2 or state18 == 5) then
            tasks[2].show = 1
        end
    end

    SayTask(11381, tasks)
end;

function cold()

    if (HaveNormalItem(3, 224, 0, 0) >= 1) then
        Talk(1, "no", 14595)
        DelNormalItem(3, 224, 0, 0)
        AddOwnExp(10000)
        Earn(500)
        TopMessage(14447)
        Msg2Player("B¹n nhËn ®­îc 10000 kinh nghiÖm, 500 l­îng")
        SetTaskBit(Task_cold, 2, 1)--log¸Ä°æ
        --AS GaoJingwei 090730
        SetSubTask(74, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(74, -1)

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end

end;

function no()
    CloseDialog()
end;

----------------13,18ÐÂÊÖÈÎÎñ----yaoxin 09/04/28

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 1) then
        Talk(1, "renwu18", "B¸u vËt cña ta do sö dông qu¸ l©u,nªn linh lùc sãt l¹i kh«ng m¹nh, ta cã thÓ cho ng­¬i m­în <c=g>Thiªn C¬ Ch©u<c>, nh­ng ta ph¶i chó linh lùc vµo b¶o ch©u tr­íc, cÇn 1 sè vËt liÖu, ng­¬i chØ cÇn ®­a ta 5 <c=g>B¨ng C¬<c>, 5 <c=g>Ngäc Cèt<c> lµ ®­îc.")
        SetTaskByte(Task_newer13, 2, 2)
        Msg2Player("Thu thËp 5 B¨ng C¬, 5Ngäc Cèt ®Ó t¨ng ph¸p lùc cho Thiªn C¬ Ch©u.")
        TaskNote(208, 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (state18 == 2) then
        MsgBox("Ta cÇn 5 <c=g>B¨ng C¬<c>, 5 <c=g>Ngäc Cèt<c> ®Ó t¨ng ph¸p lùc cho <c=g>Thiªn C¬ Ch©u<c>. B©y giê ng­¬i muèn ®­a ta sao?", "yes_drug", "no")
    elseif (state18 == 5) then
        local key = GetTaskWord(Task_newer13, 2)
        local nowtime = mod(SystemTime(), 2 ^ 16)
        if (key + 3 * 60 >= nowtime) then
            Talk(1, "no", "Ta cÇn nghØ ng¬i 1 l¸t míi cã thÓ bæ sung ph¸p lùc tiÕp cho <c=g>Thiªn C¬ Ch©u<c>, anh hïng 1 l¸t h·y tíi.")
        else
            MsgBox("Ph¶n ®å TriÖt gi¸o ®· bá ®i, ng­¬i ph¶i lµm l¹i tõ ®Çu <c=g>Thiªn C¬ Ch©u<c>, lÇn nµy ta vÉn cÇn 5 <c=g>B¨ng C¬<c>, 5 <c=g>Ngäc Cèt<c> ®Ó t¨ng ph¸p lùc cho <c=g>Thiªn C¬ Ch©u<c>, b©y giê ng­¬i muèn ®­a ta sao?", "yes_drug1", "no")
        end
    end
end

function yes_drug()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ kho¶ng trèng!")
        return 0
    end

    if (HaveNormalItem(3, 9, 0, 0) >= 5) and (HaveNormalItem(3, 13, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 9, 0, 0)
            DelNormalItem(3, 13, 0, 0)
        end

        AddNormalItem(6, 1, 498, 0, 0, 0)--Ììí¶Öé
        SetTaskByte(Task_newer13, 2, 3)
        SetTaskWord(Task_newer13, 2, 0)
        Msg2Player("T×m §¹i phu ë T©y C«n L«n hái tung tÝch cña ph¶n ®å TriÖt gi¸o.")
        TaskNote(208, 2)
        Talk(1, "no", "Thiªn C¬ Ch©u ®· ®­îc bæ sung ph¸p lùc, nay ng­¬i cã thÓ ®Õn chç <c=r>§¹i phu ë T©y C«n L«n<c> ®Ó hái n¬i Èn n¸u cña ph¶n ®å TriÖt gi¸o.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", "Ta cÇn 5<c=g>B¨ng C¬<c>, <c=g>5 Ngäc Cèt<c>, vËt liÖu ng­¬i kh«ng ®ñ!")
    end
end

function yes_drug1()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ kho¶ng trèng!")
        return 0
    end

    if (HaveNormalItem(3, 9, 0, 0) >= 5) and (HaveNormalItem(3, 13, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 9, 0, 0)
            DelNormalItem(3, 13, 0, 0)
        end

        AddNormalItem(6, 1, 498, 0, 0, 0)--Ììí¶Öé
        SetTaskByte(Task_newer13, 2, 4)
        SetTaskWord(Task_newer13, 2, 0)
        Msg2Player("Thiªn C¬ Ch©u ®· bæ sung ph¸p lùc xong, h·y mau ®i thu phôc ph¶n ®å TriÖt gi¸o.")
        TaskNote(208, 3)
        Talk(1, "no", "Ph¸p lùc cña Thiªn C¬ Ch©u ®· bæ sung xong.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", "Ta cÇn 5 <c=g>B¨ng C¬<c>, 5 <c=g>Ngäc Cèt<c>, vËt liÖu ng­¬i kh«ng ®ñ!")
    end
end
---------end

