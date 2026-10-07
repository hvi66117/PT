--npcÕÜÂÞÓã.lua
--author: gaojingwei 
--date: 2009/04/16

-----------³õÏÖ¶ËÄß ÈýÓãÖ®ÂÒ-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚÐÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈýÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂÞÓã¶Ô»° 10Óë¾Þ¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø
--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ðÀëÐ¡Ñý£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ðÀë¾«ÆÇ
--2byte: 1½Óµ½¹ý³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ýÈýÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ý»ðÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ý±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ðÀëÐ¡ÑýµÄÊýÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊýÄ¿
Task_Time_Stemp = 1390        --¼ÇÂ¼É±µ¥´¿É³»ê£¬ºÍÈý¸öÓãµÄÊ±¼ä
Task_NpcID = 1391            --¼ÇÂ¼µ¥´¿É³»êºÍÈý¸öÓãµÄÊ±¼ä
puteGhost = 956                --µ¥´¿É³»êµÄtemplateID
bigHeadFish = 952            --´óÍ·ÓãµÄµÄtemplateID
foldFish = 952                --ÕÛÂáÓãµÄtemplateID
greatTongueFish = 952        --¾Þ¹ÇÉàÓãµÄtemplateID

Coordinate = --Èý¸öÓãµÄ×ø±ê
{
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045
-----------³õÏÖ¶ËÄß ÈýÓãÖ®ÂÒ-----------------

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
    local startLevel = 1

    --ÈýÓãÖ®ÂÒ
    startLevel = 36
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetTaskByte(Task_Variety_Process, 1) == 9 and GetLevel() >= 36) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_Variety_Process, 1) == 9 and GetLevel() >= 36) then
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

function main()
    if (GetTask(Task_NpcID) ~= GetNpcID(DialogNpcIdx)) then
        --Ã»½ÓÈÎÎñ
        Talk(1, "no", " $%$^%&^&#@--, t×m ta cã viÖc g×?")
        return
    end

    if (GetTaskByte(Task_Variety_Process, 1) == 10) then
        Talk(1, "no", "Thêi gian cÊp b¸ch, mau vÒ phôc mÖnh Hoµng Thiªn Hãa.")
        return
    end

    if (GetTask(Task_NpcID) == GetNpcID(DialogNpcIdx) and GetTaskByte(Task_Variety_Process, 1) == 9) then
        SetTaskByte(Task_Variety_Process, 1, 10)
        Talk(2, "no", " Kh«ng ngê ta l¹i bÞ huynh ®Ö b¸n ®øng! 1 <c=g>Ng­êi T©y Vùc<c> ®Õn tõ cuèi §«ng H¶i, ®· ban <c=yel>Thñy Hån<c> cho bän ta, nªn viÖc tu luyÖn t¨ng lªn rÊt nhiÒu, kh«ng ngê l¹i bÞ anh hïng ph¸ gi¶i!", GetName() .. " …… Ta vÒ b¸o cho Hoµng Thiªn Hãa.")
        Msg2Player("NhiÖm vô hoµn thµnh,  cã thÓ t×m Hoµng Thiªn Hãa phôc mÖnh.")
        TaskNote(Task_Info_Second, 4)
        refreshNpcTaskState()
        --added by yangtao 2009.8.18 Íê³ÉÈÎÎñÊ±Èç¹û769Buff»¹´æÔÚ£¬Ôò½«ÆäÉ¾³ý
        if (HaveIBBuff(769) > 0) then
            RemoveIBBuff(769)
        end
        --end of add 
    end
end

function no()
    CloseDialog()
end