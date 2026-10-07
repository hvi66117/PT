--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

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
    local startLevel = 18

    --Ì½ÄÒÈ¡Îï
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(314) == 9 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 9 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    if (GetTask(304) == 9) then
        Talk(1, "no", 11441)
        SetTask(304, 100)
        TaskNote(31, 0)
    elseif (GetTask(314) == 9) then
        Talk(1, "no", 11474)
        SetTask(314, 100)
        TaskNote(33, 0)
        refreshNpcTaskState()
    elseif (GetTaskByte(Task_newer13, 2) == 3) and (GetPlayerType() == 1) then
        Talk(1, "no", "Bän ph¶n ®å ®ã ®· biÕn h×nh thµnh YÓm Háa, mang theo Tiªn C¬ Häa giÊu n¬i bän YÓm Háa phÝa B¾c")

        SetTaskByte(Task_newer13, 2, 4)
        Msg2Player("Bän ph¶n ®å ®ã ®· biÕn h×nh thµnh YÓm Háa råi, h·y lªn phÝa B¾c t×m trong ®¸m YÓm Háa ®ang chiÕm cø n¬i ®ã.")
        TaskNote(208, 3)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        MsgBox(10322, "yes", "no")
    end ;
end;

function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;
