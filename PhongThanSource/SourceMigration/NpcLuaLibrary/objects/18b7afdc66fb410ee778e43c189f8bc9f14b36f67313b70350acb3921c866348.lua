--description:npc
--author: zhujialiang
--date:2005/4/13
--modify:liuying 2005/5/26

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓĞş¶¼´ó·¨Ê¦ÕÒÏôÉı2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³ÉÑ©Ô­¾ŞÊŞ5Ñ©Ô­¾ŞÊŞÏÖ³öÔ­ĞÎ6»ØĞş¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)

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
    local startLevel = 10

    -- ÇÙÆåÊé»­
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 4) then
                state = 3
                subState = 0
            elseif (taskProcess == 5) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 4) then
                state = 3
                subState = 1
            elseif (taskProcess == 5) then
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    if (GetPlayerType() == 1) and (GetLevel() >= 13) and (GetTaskByte(Task_newer13, 1) == 4) then
        MsgBox("§é ¸ch: <c=g>Nam Hoa Kinh<c> chİnh lµ cæ vËt ngh×n n¨m l­u truyÒn, ®· cã rÊt nhiÒu ch÷ kh«ng cßn râ rµng n÷a, nh­ng ta cã thÓ vËn phĞp kh«i phôc l¹i, vµ cÇn thêi gian thùc hiÖn, ng­êi cã ®ång ı ®îi kh«ng?", "yes_book", "no")
        TaskNote(207, 4)
    else
        Talk(1, "no", 12104)
    end
end;

function no()
    CloseDialog()
end;

function yes_book()
    CloseDialog()
    if (GetTaskByte(Task_newer13, 1) == 4) then
        Talk(1, "no", "§é ¸ch: QuyÓn <c=g>Nam Hoa Kinh<c> nµy ta ®µnh tÆng ng­¬i, nh­ng trong ®ã kh«ng hÒ ghi nhËn tung tİch <c=g>Tiªn C¬ Häa<c>, xin c¸c h¹ quay vÒ t×m <c=r>Nhiªn §¨ng §¹o Nh©n<c> t×m hiÓu l¹i.")
        SetTaskByte(Task_newer13, 1, 5)
        PlayerCastSkill(1, 224, 1)--?
        AddEventItem(240)--ÄÏ»ª¾­
        Msg2Player("Quay vÒ t×m Nhiªn §¨ng §¹o Nh©n.")
        TaskNote(207, 5)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end