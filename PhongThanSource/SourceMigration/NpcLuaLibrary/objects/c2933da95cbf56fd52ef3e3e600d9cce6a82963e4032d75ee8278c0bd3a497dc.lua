--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ¡¢»ğÀëĞ¡Ñı¡¢±³ºóÖ÷Ä±-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½»ê²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿

---------------------±³ºóÖ÷Ä±-----------------
PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex
---------------------±³ºóÖ÷Ä±------------------

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

    --±³ºóÖ÷Ä±
    startLevel = 46
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        if (GetLevel() - startLevel <= 5) then
            if (step == 21) then
                state = 3
                subState = 0
            end
        else
            if (step == 21) then
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
            if (GetTask(314) == 32 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 32 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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


function main(sel)

    tasks = {
        { "B¨ng Xuyªn Thİ LuyÖn", "shitu"; show = 0 }
    }
    if (GetTask(902) == 1) then
        tasks[1].show = 1;
        SayTask(11470, tasks)
    else
        if (GetTask(304) == 32) then
            Talk(1, "no", 11441)
            SetTask(304, 100)
            TaskNote(31, 0)
            refreshNpcTaskState()
        elseif (GetTask(314) == 32) then
            Talk(1, "no", 11581)
            SetTask(314, 100)
            TaskNote(33, 0)
            refreshNpcTaskState()
        elseif (GetTaskByte(Task_Variety_Process, 1) == 21) then
            conspiracy()
        else
            MsgBox(10322, "yes", "no")
        end ;
    end
end;
---------------------------------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-4-21 begin-----------------
function conspiracy()
    Talk(1, "no", "B¨ng Linh ë cuèi B¨ng Xuyªn còng ®­îc Ng­êi T©y Vùc ban cho <c=yel>Phong LÖ<c> trî giïp tu luyÖn, nªn B¨ng Linh míi m¹nh nh­ vËy. Chñ m­u ®øng phİa  sau h¼n cßn lîi h¹i h¬n. Cuèi B¨ng Xuyªn hung hiÓm dŞ th­êng, ng­¬i h·y vÒ b¸o víi Hoµng Thiªn Hãa.")
    SetTaskByte(Task_Variety_Process, 1, 22)
    TaskNote(1047, 4)
    ClearItem(6, 1, 489, 1)
    ScrollMessage("§­a B¨ng Linh gia th­ cho §¹i phu")
    RemoveIBBuff(645)
    ---É¾³ıÍæ¼ÒÉíÉÏµÄ×´Ì¬
    ClearLighting()        --Ï¨ÃğÀ×µçÖ®Ëş£¬Ê¹µÃÆäËûÍæ¼Ò¿ÉÒÔ¼ÌĞøÊ¹ÓÃ
    refreshNpcTaskState()
end

function ClearLighting()
    ----Çå³ıÍæ¼ÒµãÁÁµÄËş
    local TargetNpcidx = GetTask(PlayerLightIndex) --Íæ¼ÒÉíÉÏ°ó¶¨µÄËş
    if (TargetNpcidx == 0 or GetNpcTask(TargetNpcidx, 4) ~= GetPlayerID() or GetNpcTask(TargetNpcidx, 1) < 10) then
        --Ã»ÓĞ°ó¶¨npc»òÕßnpcÉíÉÏÃ»ÓĞ°ó¶¨Íæ¼Ò£¬ÓÖ»òÕßµÆËşÒÑ¾­Ï¨Ãğ
        return
    end
    -----------------------------------Ï¨ÃğÀ×µçÖ®Ëş----------------------
    local group = mod(GetNpcTask(TargetNpcidx, 1), 10) --npcËùÊôµÄ·Ö×é£¬±»µãÁÁºó·Ö×é¼ÓÉÏ10,ÕâÀï×ª»¯Îª×éºÅ
    --Ï¨ÃğËùÓĞµÄµÆ
    local temp_index = TargetNpcidx --µÚÒ»¸önpc
    repeat
        SetNpcTask(temp_index, 1, group) --Çå³ınpcµÄµãÁÁ×´Ì¬
        SetNpcTask(temp_index, 4, 0)
        ---Çå³ı°ó¶¨µÄPlayerIDºÅ
        NpcRemoveIBBuff(temp_index, 646)
        -----------------------Ï¨ÃğµãÁÁ×´Ì¬
        DelNpcTimer(temp_index)
        ---É¾³ıÆäÉíÉÏµÄ¶¨Ê±Æ÷
        local otheridx = GetNpcTask(temp_index, 5)
        if (otheridx ~= 0) then
            DelNpc(otheridx)
            SetNpcTask(temp_index, 5, 0)
        end
        temp_index = GetNpcTask(temp_index, 2)
    until (temp_index == TargetNpcidx or temp_index == 0) --Íê³ÉÒ»¸öÑ­»·ºó½áÊø

    Msg2Player("§iÖn L«i Th¸p b¹n th¾p ®· t¾t!")
end
------------------------------------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-4-21 end---------------------

function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = 0
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé
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
            SetTask(902, 2)
            TaskNote(46, 0)
            MsgBox(11582, "no")
            refreshNpcTaskState()
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
