--npc´óÍ·Óã.lua
--author: gaojingwei 
--date: 2009/04/16

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø
--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ
--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿
Task_Time_Stemp = 1390        --¼ÇÂ¼É±µ¥´¿É³»ê£¬ºÍÈı¸öÓãµÄÊ±¼ä
Task_NpcID = 1391            --¼ÇÂ¼µ¥´¿É³»êºÍÈı¸öÓãµÄÊ±¼ä
puteGhost = 956                --µ¥´¿É³»êµÄtemplateID
bigHeadFish = 952            --´óÍ·ÓãµÄµÄtemplateID
foldFish = 952                --ÕÛÂáÓãµÄtemplateID
greatTongueFish = 952        --¾Ş¹ÇÉàÓãµÄtemplateID

Coordinate = --Èı¸öÓãµÄ×ø±ê
{
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045
-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ-----------------

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

    --ÈıÓãÖ®ÂÒ
    startLevel = 36
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_Variety_Process, 1) == 7 and GetLevel() >= 36) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_Variety_Process, 1) == 7 and GetLevel() >= 36) then
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
    if (GetTask(Task_NpcID) ~= GetNpcID(DialogNpcIdx)) then
        --Ã»½ÓÈÎÎñ
        Talk(1, "no", " $%$^%&^&#@--, t×m ta cã viÖc g×!")
        return
    end

    if (GetTaskByte(Task_Variety_Process, 1) == 8) then
        Talk(1, "no", "Thêi gian cÊp b¸ch, mau ®i t×m TriÕt La Ng­.")
        return
    end

    local linkPos = "<HyperLinkWorldPos=\"" .. Coordinate[2].link .. "\">"

    if (GetTask(Task_NpcID) == GetNpcID(DialogNpcIdx) and GetTaskByte(Task_Variety_Process, 1) == 7) then
        SetTaskByte(Task_Variety_Process, 1, 8)
        SetTask(Task_Time_Stemp, 0)                            --É±ËÀÕÜÂŞÓãµÄÊ±¼äÇåÁã
        Talk(1, "no", "TriÕt La Ng­ thİch tranh giµnh ®Şa bµn víi ta, h¾n rÊt sî bŞ ng­êi kh¸c chª l¾m lêi, ng­¬i cã thÓ ®Õn khiªu khİch h¾n, nhí lµ ph¶i ®¸nh vµo c¸i ®Çu ngu ngèc cña h¾n! Täa ®é cña h¾n lµ <c=g>" .. Coordinate[2].desc)
        Msg2Player("TriÕt La Ng­ ë" .. linkPos)
        TaskNote(Task_Info_Second, 2, "Thñy Vùc" .. Coordinate[2].desc)
        refreshNpcTaskState()
    end
end

function no()
    CloseDialog()
end