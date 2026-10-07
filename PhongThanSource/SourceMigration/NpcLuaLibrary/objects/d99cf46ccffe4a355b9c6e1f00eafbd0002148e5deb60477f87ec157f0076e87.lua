--description: ×£ÈÚ
--author: yaoxin
--date:2009/1/12

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊý 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàÐÍ(Ç¬1,¶Ò2,Àë3,Õð4,Ùã5,¿²6,ôÞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåÐÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ÐèÉ±(ÊÕ)¸öÊý 2byte Êµ¼Ê¸öÊý
--ôÞ,Ùã ÎªÕÐ³ö¹ÖÎïµÄnpcidx
boss_task = 1342 -- 1word x×ø±ê 2word ÊÇy ×ø±ê
boss_distance = 1343 --ÉÏ´ÎÑ°µãÓëÏÖÔÚÑ°µãµÄ¾àÀë
boss_task_extend = 1344 --½Ó»Æ½ð±¦²ØµÄ´ÎÊý¿ØÖÆ
TOTAL_ACC_TIME = 4

-- Íò¾°Ö®Ô°
TASK_WANJING = 1384  --1byte:ÈÎÎñ×´Ì¬; 2~4byteÖÐ£¬Ç°5Î»±íÊ¾µ±Ç°ËùÒªÈ¥µÄµØÍ¼idx£¬ºó18Î»±íÊ¾µØÍ¼ÊÇ·ñÒÑ¾­È¥¹ý¡£2byteÖÐµÄµÚ5Î»Îª¿Õ¡£
TASKNOTE_WANJING = 1042

eightgua_UPtimes = 2 --(2Ãâ·Ñ)
item_gua = {--ÈÎÎñ¾íÎ»,Ïó£¬»ñµÃ¸ÅÂÊ
    [1] = { "Cµn", "Thiªn qu¸i quyÓn", 0 },
    [2] = { "§oµi", "Tr¹ch qu¸i quyÓn", 40 },
    [3] = { "Ly", "Háa qu¸i quyÓn", 0 },
    [4] = { "ChÊn", "L«i qu¸i quyÓn", 30 },
    [5] = { "Tèn", "Phong qu¸i quyÓn", 10 },
    [6] = { "Kh¶m", "Thñy qu¸i quyÓn", 0 },
    [7] = { "CÊn", "S¬n qu¸i quyÓn", 20 },
    [8] = { "Kh«n", "§Þa qu¸i quyÓn", 0 },
}


-- AS yangshuang at 091229
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


    --Íò¾°Ö®Ô°
    startLevel = 23
    if (GetPlayerExtLevel() >= startLevel) then
        local status = GetTaskByte(TASK_WANJING, 1)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (status == 0) then
                state = 1
                subState = 0
            elseif (status == 8) then
                state = 3
                subState = 0
            elseif ((status >= 1) and (status <= 7)) then
                state = 2
                subState = 0
            end
        else
            if (status == 0) then
                state = 1
                subState = 1
            elseif (status == 8) then
                state = 3
                subState = 1
            elseif ((status >= 1) and (status <= 7)) then
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
-- AE yangshuang at 091229 end


function main()
    local tasks = {
        { "B¸t Qu¸i Lu©n Håi", "search_8gua"; show = 0 },
        { "Hoµn thµnh B¸t Qu¸i Lu©n Håi", "complete_8gua"; show = 0 },
        --		{"È¡Ïû°ËØÔÂÖ»Ø","cancel_8gua";show=0},
        { "Hoµng Kim Tµng b¶o ®å", "treasure"; show = 0 },
        { "Hñy t×m b¶o", "cancel_treasure"; show = 0 },
        { "V¹n C¶nh Viªn", "wanjing"; show = 0 },
    }

    if (GetPlayerExtLevel() >= 15) then
        local state = GetTaskByte(gua8_renwu, 3)
        if (state == 0) then
            tasks[1].show = 1
        else
            tasks[2].show = 1
            --else
            --	tasks[3].show = 1
        end

        if (GetTaskWord(boss_task, 1) > 0 and GetTaskWord(boss_task, 2) > 0) then
            tasks[4].show = 1
        else
            tasks[3].show = 1
        end

    end

    ------------------- Íò¾°Ö®Ô° add by gongpeng at 2009.04.13 begin
    if (GetPlayerExtLevel() >= 23) then
        local status = GetTaskByte(TASK_WANJING, 1)
        if (status <= 8) then
            tasks[5].show = 1
        end
    end
    ------------------- Íò¾°Ö®Ô° add by gongpeng at 2009.04.13 end
    SayTask("ChiÕn tranh liªn miªn, bÊt kÓ lµ Th­¬ng Chu hay Tiªn Ma còng ®Òu bÞ cuèn vµo vßng xo¸y nµy…HÇy!…Nhí n¨m x­a ta víi Céng C«ng cã chót bÊt hßa, ®Õn giê vÉn ch­a hµo gi¶i ®­îc…", tasks)
end;

function no()
    CloseDialog()
end;
-------------------------by lijing 09-9-24
function search_8gua()
    Say("Ta thÊy b¹n trÎ khÝ chÊt phi phµm, ®Ó ta bãi cho 1 quÎ nhÐ!", "2", " Bãi 1 quÎ/gua1", " Bãi 2 quÎ/gua2")
end;

function gua1()
    local lastday = GetTaskByte(gua8_renwu, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local times = GetTaskByte(gua8_renwu, 2)
    local pm = 600000
    if (lastday ~= today) then
        if (GetCash() >= pm) then
            MsgBox("ChØ cÇn bá ra " .. pm .. " b¹c lµ cã thÓ bãi 1 quÎ, trong mçi quÎ ®Òu Èn chøa huyÒn c¬!", "gua8_yes_1", "no")
        else
            Talk(1, "no", "ChØ cÇn" .. pm .. "l­îng th«i! Ng­¬i h×nh nh­ kh«ng ®ñ tiÒn!")
        end ;
    elseif (times < eightgua_UPtimes) then
        if (GetCash() >= pm) then
            MsgBox("ChØ cÇn bá ra " .. pm .. " b¹c lµ cã thÓ bãi 1 quÎ, trong mçi quÎ ®Òu Èn chøa huyÒn c¬!", "gua8_yes_1", "no")
        else
            Talk(1, "no", "ChØ cÇn" .. pm .. "l­îng th«i! Ng­¬i h×nh nh­ kh«ng ®ñ tiÒn!")
        end ;
    else
        Talk(1, "no", "Ta h«m nay chØ gióp ng­¬i bãi" .. eightgua_UPtimes .. " lÇn th«i, nÕu kh«ng sÏ tæn th­¬ng ®Õn nguyªn khÝ!")
    end ;
end;

function gua2()
    local lastday = GetTaskByte(gua8_renwu, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local times = GetTaskByte(gua8_renwu, 2)
    local pm = 600000 * 2
    if (lastday ~= today) or (times < (eightgua_UPtimes - 1)) then
        if (GetCash() >= pm) then
            MsgBox("ChØ cÇn bá ra " .. pm .. " b¹c lµ cã thÓ bãi 1 quÎ, trong mçi quÎ ®Òu Èn chøa huyÒn c¬!", "gua8_yes_2", "no")
        else
            Talk(1, "no", "ChØ cÇn" .. pm .. "l­îng th«i! Ng­¬i h×nh nh­ kh«ng ®ñ tiÒn!")
        end ;
    else
        Talk(1, "no", "Ta h«m nay chØ gióp ng­¬i bãi" .. eightgua_UPtimes .. " lÇn th«i, nÕu kh«ng sÏ tæn th­¬ng ®Õn nguyªn khÝ!")
    end ;
end;
------------------------------------------------------------
function complete_8gua()
    CloseDialog()
    if (GetTaskByte(gua8_renwu, 3) == 3) then
        local type = GetTaskByte(gua8_renwu, 4)
        if (type >= 1) and (type <= 8) then
            AddNormalItem(3, 347 + type, 0, 0, 0, 0)
            SetTaskByte(gua8_renwu, 3, 0)
            SetTaskByte(gua8_renwu, 4, 0)
            SetTask(gua8_task, 0)
            TaskNote(97, -1)
            Msg2Player("NhËn ®­îc 1" .. item_gua[type][2])
            TopMessage("NhËn ®­îc 1 <c=g>" .. item_gua[type][2])
            Talk(1, "no", "Qu¶ thËt ®a tµi! Mí ®ã mµ ®· gi¶i ®­îc quÎ råi! Mãn" .. item_gua[type][2] .. " nµy tÆng cho ng­¬i ®ã!")
        else
            SetTaskByte(gua8_renwu, 3, 0)
            SetTaskByte(gua8_renwu, 4, 0)
            SetTask(gua8_task, 0)
            TaskNote(97, -1)
        end
    else
        Talk(1, "no", "QuÎ t­îng h×nh nh­ vÉn ch­a më!")
    end
end

function cancel_8gua()
    MsgBox("QuÎ chØ hiÓn linh víi ng­êi cã duyªn phËn! LÏ nµo ng­¬i muèn bá qua c¬ héi nµy?", "gua8_cancel", "no")
end

function gua8_cancel()
    CloseDialog()
    SetTaskByte(gua8_renwu, 3, 0)
    SetTaskByte(gua8_renwu, 4, 0)
    SetTask(gua8_task, 0)
    TaskNote(97, -1)
    Talk(1, "no", "Ng­¬i ®· mÊt ®i 1 c¬ héi bãi quÎ!")
    Msg2Player("B¹n huû nhiÖm vô B¸t Qu¸i Lu©n Håi")
end

function gua8_yes_1()
    CloseDialog()
    local pm = 600000
    if (GetCash() >= pm) then
        local lastday = GetTaskByte(gua8_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(gua8_renwu, 2) + 1

        if (lastday ~= today) then
            times = 1
            SetTaskByte(gua8_renwu, 1, today)
        end
        SetTaskByte(gua8_renwu, 2, times)
        Pay(pm)
        SetTaskByte(gua8_renwu, 3, 1)

        local key = gua_set() --Ö¸¶¨¹ÖÎï
        local rlock = random(1, 100)
        if (rlock <= 5) then
            AddNormalItem(6, 1, 446 + key, 0, 0, 0)--·Ç°ó¶¨
        else
            AddNormalItem(6, 1, 454 + key, 0, 0, 0)
        end
        Msg2Player("QuÎ cña b¹n h«m nay " .. times .. "lÇn!")
        TaskNote(97, 0)

        if (times >= eightgua_UPtimes) then
            SyncBibleState(97, 3, 1)
        end ;
        Talk(1, "no", "Nguyªn khÝ kh«ng tÖ! Ng­¬i nhËn ®­îc 1 <c=yel>" .. item_gua[key][1] .. " quÎ<c>!")
    else
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn råi!")
    end ;
end;

function gua8_yes_2()
    CloseDialog()
    local pm = 600000 * 2
    if (GetCash() >= pm) then
        local lastday = GetTaskByte(gua8_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(gua8_renwu, 2) + 2

        if (lastday ~= today) then
            times = 2
            SetTask(gua8_renwu, today)
        end
        SetTaskByte(gua8_renwu, 2, times)
        Pay(pm)
        SetTaskByte(gua8_renwu, 3, 1)

        local key1 = gua_set() --Ö¸¶¨¹ÖÎï
        local key2 = gua_set() --Ö¸¶¨¹ÖÎï
        local rlock = random(1, 10)
        if (rlock <= 5) then
            AddNormalItem(6, 1, 446 + key1, 0, 0, 0)--·Ç°ó¶¨
            AddNormalItem(6, 1, 446 + key2, 0, 0, 0)--·Ç°ó¶¨
        else
            AddNormalItem(6, 1, 454 + key1, 0, 0, 0)
            AddNormalItem(6, 1, 454 + key2, 0, 0, 0)
        end
        Msg2Player("QuÎ cña b¹n h«m nay " .. times .. "lÇn!")
        TaskNote(97, 0)

        if (times >= eightgua_UPtimes) then
            SyncBibleState(97, 3, 1)
        end ;
        if (key1 == key2) then
            Talk(1, "no", "VËn khÝ rÊt tèt! Ng­¬i nhËn ®­îc 2 <c=yel>" .. item_gua[key1][1] .. " quÎ<c>!")
        else
            Talk(1, "no", "VËn khÝ rÊt tèt! Ng­¬i nhËn ®­îc <c=yel>" .. item_gua[key1][1] .. " quÎ <c> vµ <c=yel>" .. item_gua[key2][1] .. " quÎ<c>!")
        end
    else
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn råi!")
    end
end

function gua_set()
    local r = random(1, 100)
    local tempLuck = 0

    for i = 1, 8 do
        if (item_gua[i][3] > 0) then
            tempLuck = tempLuck + item_gua[i][3]
            if (r <= tempLuck) then
                return i
            end
        end
    end
    return 2
end

function treasure()
    CloseDialog()
    if (GetTaskWord(boss_task, 1) > 0 and GetTaskWord(boss_task, 2) > 0) then
        Talk(1, "no", "Ng­¬i ®· b¾t ®Çu nhiÖm vô tÇm b¶o")
        return 0
    end

    local lastday = GetTaskByte(boss_task_extend, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    if (lastday ~= today) then
        SetTaskByte(boss_task_extend, 1, today)
        SetTaskByte(boss_task_extend, 2, 0)
    end

    local times = GetTaskByte(boss_task_extend, 2)
    if (times >= TOTAL_ACC_TIME) then
        Talk(1, "no", "H«m nay ng­¬i ®· nhËn ®ñ råi!")
        return 0
    end

    local list = {}
    local nums = 1

    for i = 1, 8 do
        if (item_gua[i][3] > 0) then
            list[nums] = item_gua[i][2] .. "/book_treasure"
            nums = nums + 1
        end
    end
    list[nums] = "Quay l¹i/main"

    Say("ë ®©y ta cã 1 <c=g>Hoµng Kim Tµng b¶o ®å<c>, nÕu ng­¬i cã 2 qu¸i quyÓn t­¬ng ®ång th× cã thÓ ®æi. Sao h¶?", nums, list)
end

function cancel_treasure()

    CloseDialog()

    MsgBox("NÕu huû bá nhiÖm vô, ta sÏ thu l¹i <c=g>Hoµng Kim Tµng b¶o ®å<c>. X¸c ®Þnh ch­a?", "cancel_treasure_yes", "no")

end

function cancel_treasure_yes()

    ClearItem(6, 1, 463, 0)
    SetTask(boss_task, 0)
    TaskNote(98, -1)
    Talk(1, "no", "Ng­¬i ®· bá ®i c¬ héi t×m hiÓu huyÒn c¬ cña <c=g>Hoµng Kim Tµng b¶o ®å<c>!")

end

function book_treasure(bookidx)
    --½ÓÈÎÎñ

    if (GetTaskWord(boss_task, 1) > 0 and GetTaskWord(boss_task, 2) > 0) then
        return 0
    end

    local times = GetTaskByte(boss_task_extend, 2)
    if (times >= TOTAL_ACC_TIME) then
        return 0
    end

    local ty = 348 + bookidx
    --Ä¿Ç°Ö»ÉÏ4¸ö£¬×ö¸öÐÞÕý
    if (bookidx == 0) then
        ty = ty + 1
    elseif (bookidx == 1) then
        ty = ty + 2
    elseif (bookidx == 2) then
        ty = ty + 2
    elseif (bookidx == 3) then
        ty = ty + 3
    end
    -----------

    if (HaveNormalItem(3, ty, 0, 0) >= 2) then
        local maps = {
            [1] = { x = 1787, y = 3735, r = 5 },
            [2] = { x = 1849, y = 3622, r = 5 },
            [3] = { x = 1803, y = 3598, r = 5 },
            [4] = { x = 1643, y = 3482, r = 5 },
            [5] = { x = 1683, y = 3561, r = 5 },
            [6] = { x = 1724, y = 3295, r = 5 },
            [7] = { x = 1808, y = 3554, r = 5 },
            [8] = { x = 1890, y = 3384, r = 5 },
            [9] = { x = 1842, y = 3332, r = 5 },
            [10] = { x = 1964, y = 3299, r = 5 },
        }
        DelNormalItem(3, ty, 0, 0)
        DelNormalItem(3, ty, 0, 0)
        AddNormalItem(6, 1, 463, 0, 0, 0)
        local num = random(1, 10)
        local px = maps[num].x
        local py = maps[num].y
        local r = random(0, 3)
        if (r == 0) then
            px = px + random(maps[num].r)
            py = py + random(maps[num].r)
        elseif (r == 1) then
            px = px - random(maps[num].r)
            py = py - random(maps[num].r)
        elseif (r == 2) then
            px = px + random(maps[num].r)
            py = py - random(maps[num].r)
        else
            px = px - random(maps[num].r)
            py = py + random(maps[num].r)
        end ;

        SetTaskWord(boss_task, 1, px)
        SetTaskWord(boss_task, 2, py)
        SetTask(boss_distance, -1)
        Msg2Player("B¹n nhËn ®­îc 1 Hoµng Kim Tµng b¶o ®å")
        SetTaskByte(boss_task_extend, 2, times + 1)
        TopMessage("NhËn ®­îc 1 <c=yel>Hoµng Kim Tµng b¶o ®å<c>")
        TaskNote(98, 0)
        Talk(1, "no", "Ta cã 1 <c=yel>Hoµng Kim Tµng b¶o ®å<c>, ng­¬i h·y mang theo thö vËn sè cña m×nh ®i!")
    else
        Talk(1, "no", "Ng­¬i kh«ng cã 2 qu¸i quyÓn t­¬ng ®ång!")
    end
end

------------------- Íò¾°Ö®Ô° add by gongpeng at 2009.04.13 begin
function wanjing()
    CloseDialog()

    local status = GetTaskByte(TASK_WANJING, 1)
    if (status == 0) then
        -- ÊÇ·ñ½ÓÈÎÎñ
        MsgBox("Ta muèn t¹o mét tßa nguyªn l©m trªn trêi, mang c¶nh vËt nh©n gian tËn n¹p vµo, nh­ng mµ ta l¹i c«ng viÖc phiÒn muén, kh«ng thÓ thùc hiÖn, cã thÓ nhê ng­¬i gióp ta kh«ng?", "lingquwj", "no")
    elseif ((status >= 1) and (status <= 7)) then
        -- ¼ì²éµÀ¾ß ²¢ÌáÊ¾Òª¼ÌÐøÈ¥ÅÄÕÕ
        tishi_wj()
    elseif (status == 8) then
        -- Íê³ÉÈÎÎñ
        wanchengwj()
    else
        -- ´íÎóµÄ×´Ì¬£¬ÌáÊ¾ÐÅÏ¢
        Talk(1, "no", "Nh­ thÕ cã thÓ lµm dÞu ®i c¬n buån nhí quª h­¬ng cña mäi ng­êi.")
    end
end

-- ÁìÈ¡ Íò¾°Ö®Ô° ÈÎÎñ
function lingquwj()
    CloseDialog()

    -- ±³°üÖÐÊÇ·ñÓÐ×ã¹»µÄ¿Õ¼ä
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Nh»m tr¸nh lµm mÊt <c=yel>HuyÒn Quang KÝnh<c>, xin h·y dµnh s½n 1 « trèng trong hµnh trang!")
        return
    end
    AddNormalItem(6, 1, 483, 1, 0, 0)
    -- Çå¿ÕTASK_WANJING
    SetTask(TASK_WANJING, 0)
    -- ÉèÖÃ×´Ì¬
    SetTaskByte(TASK_WANJING, 1, 1)
    local i = random(1, 18)
    SetTaskByte(TASK_WANJING, 2, i)
    Msg2Player("Sö dông HuyÒn Quang KÝnh lËp tøc cã thÓ xuÊt hiÖn h×nh ®Þa ®Øa môc tiªu, t×m ®Õn n¬i ®ã, sö dông HuyÒn Quang KÝnh 1 lÇn n÷a lµ ®­îc")
    Talk(2, "no", "Ta tuy cã C¶nh ®å nh©n giíi, nh­ng kh«ng chi tiÕt, cÇn cã ng­êi gióp ta thu thËp, kú c¶nh rÊt nhiÒu, còng kh«ng thÓ nhê ng­¬i thu thËp vÒ hÕt chØ cÇn t×m ®ñ <c=g>7<c> n¬i lµ ®­îc.", "Nh©n gian ta kh«ng rµnh l¾m. §©y lµ <c=g>HuyÒn Quang KÝnh<c> trong ®ã cã nh÷ng c¶nh t­îng sãt l¹i cña nh©n gian, c¨n cø vµo ®ã cã thÓ t×m thÊy nh÷ng c¶nh quang mµ ta cÇn, t×m ®Õn ®ã sö dông HuyÒn Quang KÝnh lµ cã thÓ l­u l¹i c¶nh quang khu vùc ®ã.")
    SetSubTask(1042, 1, 1)
    TaskNote(TASKNOTE_WANJING, 0, 0)
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
end

-- Íê³ÉÍò¾°Ö®Ô° ÈÎÎñ
function wanchengwj()
    SetTaskByte(TASK_WANJING, 1, 9)
    ClearItem(6, 1, 483, 1)
    DelNormalItemInQuick(6, 1, 483, 1)
    local addExp = AddOwnExtendExp(300000)
    TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> tu luyÖn")
    Msg2Player("Hoµn thµnh nhiÖm vô V¹n ChØ Viªn, nhËn ®­îc" .. addExp .. " ®iÓm tu luyÖn!")
    Talk(1, "no", "Nh­ thÕ cã thÓ lµm dÞu ®i c¬n buån nhí quª h­¬ng cña mäi ng­êi.. TÆng ng­¬i <c=g>" .. addExp .. "<c> tu luyÖn")
    SetSubTask(1042, -1, 1)
    TaskNote(TASKNOTE_WANJING, -1)
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
end

-- ¼ì²éµÀ¾ß ²¢ÌáÊ¾Òª¼ÌÐøÈ¥ÅÄÕÕ
function tishi_wj()
    if ((HaveNormalItem(6, 1, 483, 1) <= 0) and (IsExistItem(6, 1, 483, 1) <= 0) and HaveNormalItemInQuick(6, 1, 483, 1) <= 0) then
        -- ÖØÐÂÁìÈ¡»Ã¹â¾µ
        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Hµnh trang cña ng­¬i ®· ®Çy.")
        else
            ClearItem(6, 1, 483, 1)
            AddNormalItem(6, 1, 483, 1, 0, 0)
            Talk(1, "no", "H·y cÈn thËn, ®õng ®Ó mÊt <c=g>HuyÒn Quang KÝnh<c> nµy n÷a.")
        end
    else
        Talk(1, "no", "§i nhanh vÒ nhanh.")
    end
end
------------------- Íò¾°Ö®Ô° add by gongpeng at 2009.04.13 end
