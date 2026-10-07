--description: ÃÄ©±-ÃÄ¡¼¶P°â°Ó
--author: yichuan
--date: 2004/6/10

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
            if (GetTaskByte(Task_Variety_Process, 1) == 6 and GetLevel() >= 36) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_Variety_Process, 1) == 6 and GetLevel() >= 36) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(314) == 37 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 37 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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
    tasks = {
        { "§«ng H¶i ThÝ LuyÖn", "shitu"; show = 0 },
        { "Lo¹n tam ng­", "fishBane"; show = 0 }
    }
    if (GetTask(900) == 1) then
        tasks[1].show = 1;
        SayTask(11470, tasks)
    else
        if (GetTask(304) == 37) then
            Talk(1, "no", 11441)
            SetTask(304, 100)
            TaskNote(31, 0)
            refreshNpcTaskState()
        elseif (GetTask(314) == 37) then
            Talk(1, "no", 11471)
            SetTask(314, 100)
            TaskNote(33, 0)
            refreshNpcTaskState()
        else
            MsgBox(10322, "yes", "no")
        end ;
    end

    if (GetTaskByte(Task_Variety_Process, 1) == 6) then
        tasks[2].show = 1
        SayTask("GÇn ®©y vïng biÓn §«ng H¶i th­êng x¶y ra hiÖn t­îng Thñy sinh linh tÊn c«ng th­¬ng kh¸ch, nghe ®ån do 3 con Qu¸i Ng­ cÇm ®Çu, anh hïng h·y gióp ta t×m hiÓu sù t×nh!", tasks)
    end
end;
--------------Add by Gaojingwei at 2009/04/16 begin---------------------
function fishBane()
    CloseDialog()
    local linkPos = "<HyperLinkWorldPos=\"" .. Coordinate[1].link .. "\">"
    if (GetTaskByte(Task_Variety_Process, 1) == 6) then
        SetTaskByte(Task_Variety_Process, 1, 7)
        SetTask(Task_Time_Stemp, 0)                            --É±ËÀ´óÍ·ÓãµÄÊ±¼äÇåÁã
        Talk(1, "no", " Ta vèn chØ lµ th­¬ng gia buèn b¸n nhá, ®Õn §«ng H¶i H¶i C©u mua mét sè thñy s¶n, nµo ngê l¹i bÞ bän qu¸i nh­ ®ét kÝch, thËt lµ th¶m! Xin anh hïng gióp ta d¹y cho chóng mét bµi häc. Qu¸i ng­ thø nhÊt tªn lµ <c=g>§¹i §Çu Ng­<c>, h¾n ë <c=g>" .. Coordinate[1].desc)
        Msg2Player("§¹i §Çu Ng­ xuÊt hiÖn ë" .. linkPos)
        TaskNote(Task_Info_Second, 1, "Thñy Vùc" .. Coordinate[1].desc)
        --added by yangtao 2009.8.17
        AddIBBuff(769)
        --end of add
        Msg2Player("§¹i Phu §«ng H¶i tÆng b¹n mét lÇn chóc phóc, khuyªn b¹n ®i hµng phôc ng­ v­¬ng.")
        refreshNpcTaskState()
    end
end
--------------Add by Gaojingwei at 2009/04/16 end---------------------

function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = 0
    if (GetTeam() ~= 0) then
        -- ÓÐ¶ÓÎé
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            mark = IsMasterPRRelation(n)

            if (mark == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = 0
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function shitu()
    local mark = judge_relation()
    if (mark == 1) then
        if (HaveIBBuff(216) ~= 0) then
            RestoreLife()
            RestoreMana()
            SetTask(900, 2)
            TaskNote(44, 0)
            MsgBox(11472, "no")
        else
            MsgBox(11458, "no")
        end
    else
        MsgBox(11459, "no")
    end
end

function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;
