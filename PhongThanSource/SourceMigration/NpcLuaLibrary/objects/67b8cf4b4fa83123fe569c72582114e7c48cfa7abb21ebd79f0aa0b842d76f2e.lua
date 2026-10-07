--description:Ñîê¯-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/7/14
--902,1371±ù´¨Ì½ÏÕ
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
--53  1: Íê³Éµ±Ç°ĞÇĞÇµÄ×´Ì¬(0£½Î´½Ó£¬1£½½Ó£¬2£½´ò´íĞÇĞÇ»òÊ§°Ü£¬3£½Íê³É)£»2£ºÍê³ÉÁËµÚ¼¸²½£»3ÊÇ·ñ½»¹ı²®ÀÖÖ®ÑÛ(1£½µÚÒ»µµ£¬2£½µÚ¶şµµ£¬3£½µÚÈıµµ)£»4ÊÇ·ñÁì¹ı60»Æ½ğÎäÆ÷(0Î´Áì£¬1Áì¹ı)
instence_Task = 1606    --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø
--9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø 12=ÁìÈ¡ÁË³ı±©°²Á¼ÈÎÎñ 13=É±ËÀÔ¬Ìì¾ı 14=É±ËÀ½ğ¹âÊ¥Ä¸ 15=É±ËÀËïÌì¾ı 16=Íê³ÉÁË³ı±©°²Á¼ÈÎÎñ
--17=ÁìÈ¡ÁËË®ÂäÊ¯³öÈÎÎñ 18=É±ËÀ°ØÌì¾ı 19=»÷°ÜÒ¦Ìì¾ı 20=»÷°ÜÍõÌì¾ı£¬´ø»Ø²İÈË»êÆÇ  21= Íê³ÉÁËË®ÂäÊ¯³öÈÎÎñ

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin
Task_Lasttime = 1660  --2Word:×îºóÒ»´Î½ÓÒÂ²§Ïà´«Ñ­»·ÈÎÎñµÄÊ±¼ä

Task_Yibo = 1664    --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ

Task_Count = 1665    --1Byte: ÈÎÎñÀàĞÍ
--2Byte£ºÒÑÁÔÉ±ÊıÁ¿
--3Byte: 1´ú±íÊÇÍ½µÜ
--4byte: 3ÈÎÎñ³É¹¦ ÆäËûÊıÖµ°´ÕÕ²»Í¬ÈÎÎñ¸øÓè²»Í¬½âÊÍ

Create_Yibo_Time = 1659        -- 1Word:´´½¨ÒÂ²§¹ØÏµÊ±µÄ¹ØÏµ

YIBO_80_DESASTER_STATE = 1661  -- 1Byte:ÈÎÎñÇé¿ö 1¡¢ÒÑ¾­½ÓÈÎÎñ  2¡¢Íê³É  3¡¢Ê§°Ü
-- 2Byte:ÁÔÉ±¶ÔÏó 1ÇîÆæ 2—ƒè» 3÷Ò÷Ñ 4»ìãç
-- 3Byte:½ÇÉ« 1Ê¦¸¸ 2Í½µÜ£¨×ö´Ë±ê¼ÇµÄÔ­ÒòÊÇ£¬ÔÚÍê³ÉÈÎÎñÒÔºó£¬Èç¹û½Ó´¥Ê¦Í½¹ØÏµ£¬¿ÉÒÔÒÀÈ»ÁìÈ¡½±Àø£©
-- 4Byte:ÒÑÊÕµ½ÓÊ¼şÌáĞÑ
YIBO_90_DESASTER_STATE = 1662  -- 1Byte:ÈÎÎñÇé¿ö 1¡¢ÒÑ¾­½ÓÈÎÎñ  2¡¢Íê³É  3¡¢Ê§°Ü
-- 2Byte:½ÇÉ« 1Ê¦¸¸ 2Í½µÜ£¨×ö´Ë±ê¼ÇµÄÔ­ÒòÊÇ£¬ÔÚÍê³ÉÈÎÎñÒÔºó£¬Èç¹û½Ó´¥Ê¦Í½¹ØÏµ£¬¿ÉÒÔÒÀÈ»ÁìÈ¡½±Àø£©
-- 4Byte:ÒÑÊÕµ½ÓÊ¼şÌáĞÑ
YIBO_110_DESASTER_STATE = 1663  -- 1Byte:ÈÎÎñÇé¿ö 1¡¢ÒÑ¾­½ÓÈÎÎñ  2¡¢Íê³É  3¡¢Ê§°Ü
-- 2Byte:½ÇÉ« 1Ê¦¸¸ 2Í½µÜ£¨×ö´Ë±ê¼ÇµÄÔ­ÒòÊÇ£¬ÔÚÍê³ÉÈÎÎñÒÔºó£¬Èç¹û½Ó´¥Ê¦Í½¹ØÏµ£¬¿ÉÒÔÒÀÈ»ÁìÈ¡½±Àø£©
-- 4Byte:ÒÑÊÕµ½ÓÊ¼şÌáĞÑ
IBBuff_Boss = 1245    --15·ÖÖÓµÄbuff
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end

Task_CopyTask = 1591 -- ¸±±¾±äÁ¿£¬ÓÃÀ´¼ÇÂ¼Ã¿Ìì¿É½ø¸±±¾µÄ´ÎÊı1 word Ê±¼ä£¬3byteÖØÖÃ´ÎÊı


-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
TaskInfo_cbal = 1514
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end
-- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 begin
TaskInfo_slsch = 1602
-- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 end

IBItemIndex = {
    { name = "Ma Lôc", IBItemIndex = 28 }
}

YiboTasks = {
    [1] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Chiªu ThÇn", id = 30 }, apprentice = { name = "L¹c C¬", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 }, didian = "TuyÖt Long lÜnh" },
    [2] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Lam qu¸i", id = 38 }, apprentice = { name = "§¨ng Hån", id = 40 }, boss = { name = "Quû L©n §¨ng", id = 30 }, didian = "Bİch Du tÇng 1" },
    [3] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "L«i Tr¹ch thÇn", id = 40 }, apprentice = { name = "Lam qu¸i", id = 42 }, boss = { name = "L«i Tr¹ch Yªu", id = 30 }, didian = "Bİch Du tÇng 2" },
    [4] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Lam Cèt", id = 44 }, apprentice = { name = "Th¹ch thÇn", id = 45 }, boss = { name = "Vò La Tö ThÇn", id = 30 }, didian = "Khæn Tiªn tÇng 1" },
    [5] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Th¹ch thÇn", id = 42 }, apprentice = { name = "L«i Tr¹ch thÇn", id = 44 }, boss = { name = "Vò Tr¹ch ThÇn La", id = 30 }, didian = "Bİch Du tÇng 3" },
    [6] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Bè ThÇn", id = 30 }, apprentice = { name = "Lam Cèt", id = 24 }, boss = { name = "T­¬ng LiÔu Tö ThÇn", id = 30 }, didian = "Khæn Tiªn tÇng 2" },
    [7] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "Thó kh«ng tªn", id = 30 }, apprentice = { name = "S¬n Tiªu", id = 24 }, boss = { name = "H¹ Quang Kh¶i", id = 30 }, didian = "Ph­¬ng Tr­îng ®¶o" },
    [8] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "L·o §ång", id = 30 }, apprentice = { name = "Quang Quû", id = 24 }, boss = { name = "Kú n÷ tÕ", id = 30 }, didian = "§«ng Doanh ®¶o" },
    [9] = { taskname = "Phôc Ma TÕ ThÕ", master = { name = "N÷ TÕ", id = 30 }, apprentice = { name = "H¹ HËu Khëi", id = 24 }, boss = { name = "Kú H¹ Qu©n", id = 1737 }, didian = "Bång Lai ®¶o" },
    [10] = { taskname = "Ph¸ TrËn ThÕ ThÕ" },
    [11] = { taskname = "Ph¸ TrËn ThÕ ThÕ" },
    [12] = { taskname = "Ph¸ TrËn ThÕ ThÕ" },
    [13] = { taskname = "TÇm B¶o TÕ ThÕ", pos = { mapid = 19, x = 1647, y = 3136 }, didian = "TuyÖt Long lÜnh" },
    [14] = { taskname = "TÇm B¶o TÕ ThÕ", pos = { mapid = 19, x = 1647, y = 3138 }, didian = "TuyÖt Long lÜnh" },
    [15] = { taskname = "TÇm B¶o TÕ ThÕ", pos = { mapid = 47, x = 1600, y = 3136 }, didian = "Khæn Tiªn tÇng 1" },
    [16] = { taskname = "TÇm B¶o TÕ ThÕ", pos = { mapid = 49, x = 1560, y = 3136 }, didian = "Khæn Tiªn tÇng 3" },
    [17] = { taskname = "TÇm B¶o TÕ ThÕ", pos = { mapid = 51, x = 1504, y = 3152 }, didian = "Khæn Tiªn tÇng 5" },
}

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

Shien = { name = "S­ ¢n LÖnh", Item = { 3, 1088, 0, 0, 0, 0 } }


--added by hongliang for ºìÉ°Õó 10/10/29 begin
--------------------------------------
TASK_Instance_HSZ = 601 --1st byte: Òıµ¼ÈÎÎñ²½Öè 0-Î´½Ó;1-ÒÑ½Ó;2-ÒÑºÍµÀÈË¶Ô»°;3-ÒÑ´ğÓ¦ÎäÍõ;4-ÒÑÉ±ËÀboss;5-ÒÑÍê³ÉÈÎÎñ;

--------------------------------------
--added by hongliang for ºìÉ°Õó 10/10/29 end

_g_nDongThauCost = 100

function GetCostIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex[nIndex].IBItemIndex)
    return costIBNum
end

function GetCostDisIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex[nIndex].IBItemIndex)
    return costDisNum
end

function RealCostIB(nIndex)
    local ret = CostCoinByIdx(IBItemIndex[nIndex].IBItemIndex)
    return ret
end

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

    --Î×¹ÆÖ®¶¾
    startLevel = 26
    if (GetLevel() >= startLevel) then
        local wg = GetTask(Task_wugu1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (wg == 4 and HaveEventItem(222) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 0
            end
        else
            if (wg == 4 and HaveEventItem(222) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÈËÖ®½«ËÀ
    startLevel = 27
    if (GetLevel() >= startLevel) then
        local UTask_world_2 = GetTask(92)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (UTask_world_2 == 1) then
                state = 3
                subState = 0
            end
        else
            if (UTask_world_2 == 1) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end


    --¶«º£ÉñÁú
    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 30) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 30) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ììî¸¹éÎ»
    startLevel = 54
    local task_val = GetTask(53)
    local task_state = GetByte(task_val, 1)
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (task_state == 0) then
                state = 1
                subState = 0
            elseif ((task_state == 1) or (task_state == 2)) then
                state = 2
                subState = 0
            elseif (task_state == 3) then
                state = 3
                subState = 0
            end
        else
            if (task_state == 0) then
                state = 1
                subState = 1
            elseif ((task_state == 1) or (task_state == 2)) then
                state = 2
                subState = 0
            elseif (task_state == 3) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ê§»êÂäÆÇ
    startLevel = 71
    if (GetLevel() >= startLevel) then
        local hp = GetTaskByte(1606, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (hp == 0) then
                state = 1
                subState = 0
            elseif ((hp == 1) or (hp == 2) or (hp == 4)) then
                state = 2
                subState = 0
            elseif ((hp == 3) or (hp == 5)) then
                state = 3
                subState = 0
            end
        else
            if (hp == 0) then
                state = 1
                subState = 1
            elseif ((hp == 1) or (hp == 2) or (hp == 4)) then
                state = 2
                subState = 0
            elseif ((hp == 3) or (hp == 5)) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --¹ı¹ØÕ¶½«
    startLevel = 71
    if (GetLevel() >= startLevel) then
        local hp = GetTaskByte(1606, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (hp == 6) then
                state = 1
                subState = 0
            elseif ((hp >= 7) and (hp <= 10)) then
                state = 2
                subState = 0
            elseif (hp == 11) then
                state = 3
                subState = 0
            end
        else
            if (hp == 6) then
                state = 1
                subState = 1
            elseif ((hp >= 7) and (hp <= 10)) then
                state = 2
                subState = 0
            elseif (hp == 11) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
    -- ³ı±©°²Á¼
    startLevel = 91
    if (GetLevel() >= startLevel) then
        local hp = GetTaskByte(1606, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (hp == 11) then
                state = 1
                subState = 0
            elseif (((hp >= 12) and (hp <= 14)) or ((hp == 15) and (HaveNormalItem(3, 1089, 0, 0) == 0))) then
                state = 2
                subState = 0
            elseif ((hp == 15) and (HaveNormalItem(3, 1089, 0, 0) > 0)) then
                state = 3
                subState = 0
            end
        else
            if (hp == 11) then
                state = 1
                subState = 1
            elseif (((hp >= 12) and (hp <= 14)) or ((hp == 15) and (HaveNormalItem(3, 1089, 0, 0) == 0))) then
                state = 2
                subState = 0
            elseif ((hp == 15) and (HaveNormalItem(3, 1089, 0, 0) > 0)) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end
    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

    -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by by yaoxin at 2010/3/18 begin
    startLevel = 111
    if (GetLevel() >= startLevel) then
        local hp = GetTaskByte(1606, 1)
        if (hp >= 16) and (hp < 21) then
            if (GetLevel() - startLevel <= 5) then
                --½ğÉ«
                if (hp == 16) then
                    state = 1
                    subState = 0
                elseif (hp == 20) and (HaveEventItem(312) > 0) and (HaveEventItemCount(313) >= 2) and (HaveEventItemCount(314) >= 5) then
                    state = 3
                    subState = 0
                else
                    state = 2
                    subState = 0
                end
            else
                if (hp == 16) then
                    state = 1
                    subState = 1
                elseif (hp == 20) and (HaveEventItem(312) > 0) and (HaveEventItemCount(313) >= 2) and (HaveEventItemCount(314) >= 5) then
                    state = 3
                    subState = 1
                else
                    state = 2
                    subState = 0
                end
            end
        end

        index = searchForIndex(state, subState, index)
    end
    -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 end


    --added by hongliang for ºìÉ°Õó 10/10/29 begin
    --×îºóÒ»»÷
    if (GetLevel() >= 131 and GetTaskByte(1606, 1) >= 21) then

        local TaskStep = GetTaskByte(TASK_Instance_HSZ, 1)

        if (GetLevel() - 131 <= 5) then
            if (TaskStep == 0) then
                state = 1
                subState = 0
            end
        else
            if (TaskStep == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)

    end
    --added by hongliang for ºìÉ°Õó 10/10/29 end

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
    local tasks = {
        { "Quy Tinh", "renwu1"; show = 0 },
        { "Phu Thª", "renwu2"; show = 0 },
        { "ThÇn Long", "renwu3"; show = 0 },
        { "T×m hiÓu", "renwu4"; show = 0 },
        { "B¨ng Xuyªn Thİ LuyÖn", "shitu_1"; show = 0 },
        { "TriÖu hån", "duihuan"; show = 0 },
        { "Hñy bá nhiÖm vô B¨ng Xuyªn Thİ LuyÖn", "shitu_1_cancel"; show = 0 },
        { "Hoµn thµnh nhiÖm vô B¨ng Xuyªn Thİ LuyÖn", "shitu_1"; show = 0 },
        { "Hån ph¸ch thÊt l¹c", "instence_renwu"; show = 0 },
        { "Qu¸ Quan Tr¶m T­íng", "instence_renwu1"; show = 0 },
        { "S­ §å TÕ ThÕ", "Circle_Yibo"; show = 0 }, --add by guoqun at 2009.12.4
        -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
        { "Trõ B¹o An L­¬ng", "instence_renwu2"; show = 0 },
        -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end
        -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 begin
        { "Thñy L¹c Th¹ch XuÊt", "instence_renwu3"; show = 0 },
        -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 end
        --added by hongliang for ºìÉ°Õó 10/10/29 begin
        { "C«ng kİch lÇn cuèi", "Instance_HSZ_PreTask"; show = 0 },
        --added by hongliang for ºìÉ°Õó 10/10/29 end
    }
    UTask_Knight = GetTask(3);
    if (GetPlayerType() == 0) and (GetLevel() >= 55) and (UTask_Knight == 30) then
        tasks[3].show = 1
    end ;
    local task_step = GetByte(GetTask(53), 2)
    if (task_step < 36) and (GetLevel() >= 54) then
        tasks[1].show = 1
        tasks[4].show = 1
    elseif (task_step >= 36) then
        tasks[6].show = 1;
    end ;
    UTask_world_2 = GetTask(92);
    if (UTask_world_2 == 1) then
        tasks[2].show = 1
    end ;

    if (GetLevel() > 40) and (GetLevel() <= 50) and (GetTask(902) <= 7) then
        --®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
        tasks[5].show = 1;
    end ;
    if (GetLevel() > 50) then
        if (GetTask(902) ~= 0) and (GetTask(902) < 6) then
            tasks[7].show = 1;
        elseif (GetTask(902) == 6) then
            tasks[8].show = 1
        end
    end ;
    if (GetLevel() >= 71) and ((GetTaskByte(instence_Task, 1) == 0) or (GetTaskByte(instence_Task, 1) == 3) or (GetTaskByte(instence_Task, 1) == 5)) then
        tasks[9].show = 1
    end
    if (GetLevel() >= 71) and (GetTaskByte(instence_Task, 1) >= 6) and (GetTaskByte(instence_Task, 1) < 11) then
        tasks[10].show = 1
    end

    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®Ñ­»·ÈÎÎñ at 2009.12.4 begin
    local taskState = GetTaskByte(Task_Count, 4) --ÈÎÎñ×´Ì¬
    local taskType = GetTaskByte(Task_Count, 1) --ÈÎÎñÀàĞÍ
    -->>¹¦ÄÜ¿ªÆô¶ÔÏó£º1¡¢¶ÔÒÂ²§Ê¦¸¸, 2¡¢¶ÔÓÚÈÎÎñÃ»ÓĞÍê³ÉµÄÍæ¼Ò¿ª·Å£¬ÒÔÌá¹©·ÅÆúÈÎÎñ½Ó¿Ú
    if (IsMantleMaster(PlayerIndex) > 0 or (taskState ~= 3 and taskType ~= 0)) then
        tasks[11].show = 1
    end
    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®Ñ­»·ÈÎÎñ at 2009.12.4 end

    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
    if ((GetLevel() >= 91) and (GetTaskByte(instence_Task, 1) >= 11) and (GetTaskByte(instence_Task, 1) < 16)) then
        tasks[12].show = 1
    end
    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

    -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 begin
    if ((GetLevel() >= 111) and (GetTaskByte(instence_Task, 1) == 16 or GetTaskByte(instence_Task, 1) == 20)) then
        tasks[13].show = 1
    end
    -- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 end

    --added by hongliang for ºìÉ°Õó 10/10/29 begin
    --×îºóÒ»»÷
    if (GetLevel() >= 131 and GetTaskByte(1606, 1) >= 21 and GetTaskByte(TASK_Instance_HSZ, 1) == 0) then
        tasks[14].show = 1
    end
    --added by hongliang for ºìÉ°Õó 10/10/29 begin

    SayTask(10449, tasks)
end;

--Add By Guoqun at 2009.12.5 begin
function Circle_Yibo()
    CloseDialog()
    local tasks = {
        { "S­ §å TÕ ThÕ", "Begin_Circle"; show = 1 },
        { "Hñy N.vô", "Cancel_CircleTask"; show = 0 }
    }
    local taskState = GetTaskByte(Task_Count, 4) --ÈÎÎñ×´Ì¬
    local taskType = GetTaskByte(Task_Count, 1) --ÈÎÎñÀàĞÍ
    if (taskState ~= 3 and taskType ~= 0) then
        tasks[2].show = 1
    end
    if (IsMantleMaster(PlayerIndex) == 0) then
        tasks[1].show = 0
    end
    SayTask(" D¹o nµy yªu ma léng hµnh, khiÕn b¸ t¸nh lo sî. Anh hïng b¶n lÜnh cao c­êng, xin ®i diÖt trõ chóng ®Ó mang ®Õn an b×nh cho b¸ t¸nh!", tasks)
end

function Cancel_CircleTask()
    CloseDialog()
    for i = 1519, 1521 do
        TaskNote(i, -1)
    end

    SetTask(Task_Count, 0)
    SetTask(1666, 0)
    SetTask(1667, 0)

    for i = 303, 309 do
        ClearItem(4, i, 0, 1)
    end
    RemoveIBBuff(IBBuff_Boss)
    Msg2Player("B¹n ®· hñy nhiÖm vô S­ §å TÕ ThÕ")
end

function Begin_Circle()
    CloseDialog()

    local teamState = Team_State() -- ×é¶Ó×´Ì¬
    if (teamState == 2) then
        Talk(1, "no", " NhiÖm vô nµy hiÓm nguy trïng trïng, chØ cã Y B¸t s­ ®å míi cã thÓ nhËn träng tr¸ch nµy.")
    elseif (teamState == 3) then
        Talk(1, "no", " NhiÖm vô nµy hiÓm nguy trïng trïng, xin anh hïng h·y mêi Y B¸t ®Ö tö cña m×nh cïng ®Õn thùc hiÖn nhiÖm vô nµy.")
    elseif (teamState == 4) then
        Talk(1, "no", " Ng­¬i ch­a thu nhËn Y B¸t ®Ö tö, kh«ng thÓ nhËn nhiÖm vô nµy!")
    elseif (teamState == 5) then
        Talk(1, "no", " §å ®Ö cña ng­¬i ®· hñy nhiÖm vô, nhiÖm vô kh«ng thÓ tiÕp tôc!")
    elseif (teamState == 6) then
        Talk(1, "no", " Y B¸t ®Ö tö cña ng­¬i hiÖn kh«ng ë T©y Kú!")
    elseif (teamState == 7) then
        Talk(1, "no", " Y B¸t ®Ö tö cña ng­¬i vÉn ch­a hñy nhiÖm vô!")
    elseif (teamState == 1) then
        if (GetTaskByte(Task_Count, 4) == 3) then
            --ÈÎÎñÍê³É
            Msg2Team("Chóc mõng hai ng­êi hoµn thµnh nhiÖm vô S­ §å TÕ ThÕ!")
            TeamAction("Get_Rewards", 0, 0, 0)
            return
        end
        if (GetTaskByte(Task_Count, 1) ~= 0) then
            --ÒÑ¾­½ÓÁËÈÎÎñ
            if (GetMateTask(Task_Count) == 0) then
                --Èç¹û¶ÓÓÑÈ¡ÏûÁËÈÎÎñ£¬Ôòµ¯³öÌáÊ¾
                InfoBox(" ®ång ®éi cña ng­¬i ®· hñy nhiÖm vô!")
                return
            end
            Talk(1, "no", " NhiÖm vô nµy hiÓm nguy trïng trïng, xin anh hïng h·y mêi Y B¸t ®Ö tö cña m×nh cïng nhau hoµn thµnh.")
        else
            local bState = Judge_Times()  --ÅĞ¶Ï´ÎÊıÊÇ·ñÂú×ã
            if (bState == 1) then
                local morphState = Judge_MorphType()
                if (morphState == 0) then
                    InfoBox(" Trong ®éi hiÖn cã ng­êi cã tr¹ng th¸i kh«ng phï hîp yªu cÇu nhËn nhiÖm vô.")
                    return
                elseif (morphState == 2) then
                    InfoBox(" §å ®Ö cña ng­¬i ®ang trong nhiÖm vô VËn Tiªu, hiÖn thêi kh«ng thÓ nhËn nhiÖm vô.")
                    return
                end

                local b_getmission = Get_Mission()
                if (b_getmission == 0) then
                    Talk(1, "no", " Xin kiÓm tra tr¹ng th¸i tæ ®éi cña b¹n víi ®å ®Ö, ph¶i lµ S­ ®å tæ ®éi míi cã thÓ nhËn nhiÖm vô!")
                else
                    WriteLog(GetName() .. "TiÕp nhËn nhiÖm vô tuÇn hoµn Y B¸t S­ §å")
                    local taskIdx = GetTaskByte(Task_Count, 1) --ÈÎÎñĞòºÅ
                    if (b_getmission == 1) then
                        --ÁÔÉ±ÈÎÎñ
                        local task = YiboTasks[taskIdx]
                        local mTarget = task.master
                        local aTarget = task.apprentice
                        local bossInfo = task.boss
                        Get_ItemsNotes(taskIdx)
                        Msg2Team("NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. ", S­ phô ph¶i hµng phôc qu¸i vËt: " .. mTarget.name .. ",Y B¸t ®Ö tö ph¶i hµng phôc qu¸i vËt: " .. aTarget.name .. ", ®Ó dô ra vµ hµng phôc: " .. bossInfo.name)
                        Talk(4, "no", " GÇn ®©y <c=g>" .. task.didian .. "<c> xuÊt hiÖn nhiÒu yªu ma, ph¸p lùc cña chóng rÊt ®¸ng sî, th­êng xuyªn quÊy nhiÔu b¸ t¸nh. Hy väng anh hïng cã thÓ cïng víi ®å ®Ö cña m×nh tiªu diÖt ®¸m yªu ma nµy. Bän yªu ma nµy b×nh th­êng sÏ kh«ng lé diÖn, ph¶i dïng søc m¹nh ph¸p lùc cña Phôc Ma Gi¶n vµ Hµng Yªu Lôc míi khiÕn chóng ph¶i hiÖn th©n.", " Nh­ng hai thÇn khİ nµy ®Òu ph¶i dïng Tinh hån cña Ma vËt kİch ho¹t, sau khi kİch ho¹t ph¸p lùc còng chØ duy tr× trong thêi gian ng¾n, yªu cÇu anh hïng ph¶i ®i hµng phôc 50 tªn " .. mTarget.name .. ", ®Ö tö cña anh hïng ph¶i hµng phôc 30 tªn " .. aTarget.name .. " míi cã thÓ lÇn l­ît kİch ho¹t cho 2 ph¸p khİ nµy, mét khi 2 ph¸p khİ nµy ®ång thêi ®­îc kİch ho¹t, yªu ma biÕn dŞ sÏ hiÖn th©n.", " Ph¶i lu«n nhí, sau khi ®· kİch ho¹t 1 ph¸p khİ th× néi trong <c=g>20 gi©y<c> sau ph¶i kİch ho¹t ph¸p khİ tiÕp theo, tøc lµ ph¶i liªn tôc thu thËp Tinh hån cña Ma vËt ®Ó kİch ho¹t thÇn khİ.")
                    elseif (b_getmission == 2) then
                        local task = YiboTasks[taskIdx]
                        InfoBox(" NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. ", cÇn cã S­ ®å hai ng­êi tæ ®éi, c«ng ph¸ ThËp TuyÖt trËn do ThËp Thiªn Qu©n cña TriÖt Gi¸o lËp ra, ®Ó gióp ®¹i Chu diÖt Trô.")
                        TeamAction("Task_Note2Both", taskIdx, 0, 0)
                    else
                        local task = YiboTasks[taskIdx]
                        RemoveIBBuff(IBBuff_Boss)
                        SetTask(1666, 0)
                        SetTask(1667, 0)
                        TaskNote(1520, 0, YiboTasks[taskIdx].didian)
                        for i = 303, 309 do
                            ClearItem(4, i, 0, 1)
                        end
                        local mateIdx = Get_MatePlayerIndex()
                        local selfIdx = PlayerIndex
                        PlayerIndex = mateIdx
                        RemoveIBBuff(IBBuff_Boss)
                        SetTask(1666, 0)
                        SetTask(1667, 0)
                        TaskNote(1520, 0, YiboTasks[taskIdx].didian)
                        for i = 303, 309 do
                            ClearItem(4, i, 0, 1)
                        end
                        PlayerIndex = selfIdx

                        Msg2Team("NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. ", ®Şa ®iÓm nhiÖm vô: <c=yel>" .. YiboTasks[taskIdx].didian .. "<c>")
                        Talk(3, "Do_Gather", " Cuéc chiÕn Th­¬ng Chu ®· khiÕn cho b¸ t¸nh v« téi lÇm than, gia ®iÒn tan hoang, vî chång ly t¸n. T¹i h¹ hy väng anh hïng cã thÓ cïng víi Y B¸t ®Ö tö cña m×nh gióp b¸ t¸nh chia sÎ bít mét phÇn thèng khæ.", " Trong nh©n gian cã rÊt nhiÒu n¬i cã Linh ®¬n diÖu d­îc vµ Kho¸ng Th¹ch quı hiÕm, nÕu cã thÓ thu thËp ®­îc c¸c kho¸ng Th¹ch nµy, sÏ chÕ ra nhiÒu ®¬n d­îc trŞ th­¬ng cho b¸ t¸nh.", " LÇn nµy hy väng anh hïng cã thÓ ®Õn <c=yel>" .. YiboTasks[taskIdx].didian .. "<c> tiÕn hµnh thu thËp, §¹i phu ë ®ã sÏ nãi cho anh hïng biÕt cÇn ph¶i lµm nh÷ng g×.")
                    end
                end
            elseif (bState == 2) then
                MsgBox(" TuÇn nµy anh hïng ®· cøu gióp b¸ t¸nh nhiÒu lÇn, tinh lùc ®· hao tæn rÊt nhiÒu. NÕu anh hïng vÉn muèn tiÕp tôc cøu gióp thiªn h¹, t¹i h¹ còng cã thÓ dïng thÇn thuËt gióp anh hïng håi phôc thÓ lùc, nh­ng anh hïng ph¶i mang ®Õn <c=r>Lôc M¹ch C©n §¬n<c> hoÆc <c=r>1.5<c> Kim Nguyªn B¶o th× ta míi cã thÓ gióp ®­îc!", "Pay_TB", "no")
            elseif (bState == 3) then
                Talk(1, "no", " H«m nay anh hïng ®· cøu gióp b¸ t¸nh nhiÒu lÇn, tinh lùc ®· hao tæn rÊt nhiÒu, hay lµ ngµy mai h·y tiÕp tôc nhĞ!")
            elseif (bState == 4) then
                Talk(1, "no", " TuÇn nµy anh hïng ®· <c=g>12<c> lÇn cøu gióp b¸ t¸nh, c«ng ®øc v« biªn! Nh­ng tinh lùc cña s­ ®å hai ng­êi còng ®· hao tæn rÊt nhiÒu. Hay lµ tuÇn sau h·y tiÕp tôc nhĞ!")
            end
        end
    end
end

function Pay_TB()
    CloseDialog()
    local morphState = Judge_MorphType()
    if (morphState == 0) then
        InfoBox(" Trong ®éi hiÖn cã ng­êi cã tr¹ng th¸i kh«ng phï hîp yªu cÇu nhËn nhiÖm vô.")
        return
    elseif (morphState == 2) then
        InfoBox(" §å ®Ö cña ng­¬i ®ang trong nhiÖm vô VËn Tiªu, hiÖn thêi kh«ng thÓ nhËn nhiÖm vô.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(149)
    if (HaveNormalItem(8, 1249, 2, 0) > 0 or GetCoin() >= Cv) then
        Pay_TB2()
    else
        Talk(1, "no", " TuÇn nµy anh hïng ®· cøu gióp b¸ t¸nh nhiÒu lÇn, tinh lùc ®· hao tæn rÊt nhiÒu. NÕu anh hïng vÉn muèn tiÕp tôc cøu gióp thiªn h¹, t¹i h¹ còng cã thÓ dïng thÇn thuËt gióp anh hïng håi phôc thÓ lùc, nh­ng anh hïng ph¶i mang ®Õn 1 Lôc M¹ch C©n §¬n hoÆc <c=r>1.5<c> Kim Nguyªn B¶o.")
    end
end

function Pay_TB2()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(149)
    if (HaveNormalItem(8, 1249, 2, 0) == 0 and GetCoin() < Cv) then
        Talk(1, "no", " TuÇn nµy anh hïng ®· cøu gióp b¸ t¸nh nhiÒu lÇn, tinh lùc ®· hao tæn rÊt nhiÒu. NÕu anh hïng vÉn muèn tiÕp tôc cøu gióp thiªn h¹, t¹i h¹ còng cã thÓ dïng thÇn thuËt gióp anh hïng håi phôc thÓ lùc, nh­ng anh hïng ph¶i mang ®Õn 1 Lôc M¹ch C©n §¬n hoÆc <c=r>1.5<c> Kim Nguyªn B¶o.")
        return
    end

    local b_getmission = Get_Mission()
    if (b_getmission == 0) then
        Talk(1, "no", " Xin kiÓm tra tr¹ng th¸i tæ ®éi cña ng­¬i víi ®å ®Ö, ph¶i lµ S­ ®å tæ ®éi vµ cïng ë T©y Kú míi cã thÓ nhËn nhiÖm vô!")
    elseif (b_getmission > 0) then
        if (HaveNormalItem(8, 1249, 2, 0) > 0) then
            DelNormalItem(8, 1249, 2, 0)
        else
            CostCoinByIdx(149)
        end
        WriteLog(GetName() .. "TiÕp nhËn nhiÖm vô tuÇn hoµn Y B¸t S­ §å")
        local taskIdx = GetTaskByte(Task_Count, 1) --ÈÎÎñĞòºÅ
        if (b_getmission == 1) then
            --ÁÔÉ±ÈÎÎñ
            local task = YiboTasks[taskIdx]
            local mTarget = task.master
            local aTarget = task.apprentice
            local bossInfo = task.boss
            Get_ItemsNotes(taskIdx)
            Msg2Team("NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. ", S­ phô ph¶i hµng phôc qu¸i vËt: " .. mTarget.name .. ",Y B¸t ®Ö tö ph¶i hµng phôc qu¸i vËt: " .. aTarget.name .. ", ®Ó dô ra vµ hµng phôc: " .. bossInfo.name)
            Talk(4, "no", " GÇn ®©y <c=g>" .. task.didian .. "<c> xuÊt hiÖn nhiÒu yªu ma, ph¸p lùc cña chóng rÊt ®¸ng sî, th­êng xuyªn quÊy nhiÔu b¸ t¸nh. Hy väng anh hïng cã thÓ cïng víi ®å ®Ö cña m×nh tiªu diÖt ®¸m yªu ma nµy. Bän yªu ma nµy b×nh th­êng sÏ kh«ng lé diÖn, ph¶i dïng søc m¹nh ph¸p lùc cña Phôc Ma Gi¶n vµ Hµng Yªu Lôc míi khiÕn chóng ph¶i hiÖn th©n.", " Nh­ng hai thÇn khİ nµy ®Òu ph¶i dïng Tinh hån cña Ma vËt kİch ho¹t, sau khi kİch ho¹t ph¸p lùc còng chØ duy tr× trong thêi gian ng¾n, yªu cÇu anh hïng ph¶i ®i hµng phôc 50 tªn " .. mTarget.name .. ", ®Ö tö cña anh hïng ph¶i hµng phôc 30 tªn " .. aTarget.name .. " míi cã thÓ lÇn l­ît kİch ho¹t cho 2 ph¸p khİ nµy, mét khi 2 ph¸p khİ nµy ®ång thêi ®­îc kİch ho¹t, yªu ma biÕn dŞ sÏ hiÖn th©n.", " Ph¶i lu«n nhí, sau khi ®· kİch ho¹t 1 ph¸p khİ th× néi trong <c=g>20 gi©y<c> sau ph¶i kİch ho¹t ph¸p khİ tiÕp theo, tøc lµ ph¶i liªn tôc thu thËp Tinh hån cña Ma vËt ®Ó kİch ho¹t thÇn khİ.")
        elseif (b_getmission == 2) then
            local task = YiboTasks[taskIdx]
            InfoBox(" NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. "CÇn cã S­ ®å hai ng­êi tæ ®éi, c«ng ph¸ ThËp TuyÖt trËn do ThËp Thiªn Qu©n cña TriÖt Gi¸o lËp ra, ®Ó gióp ®¹i Chu diÖt Trô.")
            TeamAction("Task_Note2Both", taskIdx, 0, 0)
        elseif (b_getmission == 3) then
            RemoveIBBuff(IBBuff_Boss)
            SetTask(1666, 0)
            SetTask(1667, 0)
            TaskNote(1520, 0, YiboTasks[taskIdx].didian)
            for i = 303, 309 do
                ClearItem(4, i, 0, 1)
            end
            local mateIdx = Get_MatePlayerIndex()
            local selfIdx = PlayerIndex
            PlayerIndex = mateIdx
            RemoveIBBuff(IBBuff_Boss)
            SetTask(1666, 0)
            SetTask(1667, 0)
            TaskNote(1520, 0, YiboTasks[taskIdx].didian)
            for i = 303, 309 do
                ClearItem(4, i, 0, 1)
            end
            PlayerIndex = selfIdx
            local task = YiboTasks[taskIdx]
            Msg2Team("NhiÖm vô S­ §å TÕ ThÕ lÇn nµy lµ " .. task.taskname .. "§Şa ®iÓm nhiÖm vô: <c=yel>" .. YiboTasks[taskIdx].didian .. "<c>")
            Talk(2, "Do_Gather", " Cuéc chiÕn Th­¬ng Chu ®· khiÕn cho b¸ t¸nh v« téi lÇm than, gia ®iÒn tan hoang, vî chång ly t¸n. T¹i h¹ hy väng anh hïng cã thÓ cïng víi Y B¸t ®Ö tö cña m×nh gióp b¸ t¸nh chia sÎ bít mét phÇn thèng khæ. Trong nh©n gian cã rÊt nhiÒu n¬i cã Linh ®¬n diÖu d­îc vµ Kho¸ng Th¹ch quı hiÕm, nÕu cã thÓ thu thËp ®­îc c¸c kho¸ng Th¹ch nµy, sÏ chÕ ra nhiÒu ®¬n d­îc trŞ th­¬ng cho b¸ t¸nh.", " LÇn nµy hy väng anh hïng cã thÓ ®Õn <c=yel>" .. YiboTasks[taskIdx].didian .. "<c> tiÕn hµnh thu thËp, §¹i phu ë ®ã sÏ nãi cho anh hïng biÕt cÇn ph¶i lµm nh÷ng g×.")
        end
    end
end

function Get_Mission()
    --·µ»ØÖµËµÃ÷£º1¡¢³É¹¦ÁìÈ¡ÈÎÎñ  0ÁìÈ¡ÈÎÎñÊ§°Ü
    local nLevel = Get_ApprenticeLevel()
    if (nLevel == 0) then
        return 0
    else
        local tasktype = Get_RandomTask(nLevel)
        return tasktype
    end
end

function Get_ItemsNotes(taskIdx)
    CloseDialog()
    local task = YiboTasks[taskIdx]
    local mTarget = task.master
    local aTarget = task.apprentice
    local bossInfo = task.boss

    for i = 303, 309 do
        ClearItem(4, i, 0, 1)
    end

    local item = 0
    item = Baowu[1].Item
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6]) --¼ÓÒ»¸ö·üÄ§¼í
    TaskNote(1519, 0, task.didian, 50, mTarget.name)
    RemoveIBBuff(IBBuff_Boss)

    local oldPlayer = PlayerIndex
    local prindex = Get_MatePlayerIndex()

    PlayerIndex = prindex
    for i = 303, 309 do
        ClearItem(4, i, 0, 1)
    end
    item = Baowu[2].Item
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6]) --¼ÓÒ»¸ö½µÑıÂ¼
    TaskNote(1519, 0, task.didian, 30, aTarget.name)
    RemoveIBBuff(IBBuff_Boss)
    PlayerIndex = oldPlayer
end

function Get_RandomTask(level)
    local tasktype = 0
    local taskNum = Get_TaskNum(level)

    SetTaskByte(Task_Count, 1, taskNum)
    Set_MateTaskByte(Task_Count, 1, taskNum)

    if (taskNum <= 9) then
        --ÁÔÉ±ÈÎÎñ
        tasktype = 1
    elseif (taskNum > 9 and taskNum < 13) then
        tasktype = 2
    elseif (taskNum >= 13) then
        tasktype = 3
    end

    --Éè¶¨ÈÎÎñÊ±¼ä
    SetTaskByte(Task_Yibo, 3, GetWeekDay())
    SetTaskWord(Task_Lasttime, 2, floor(LocalSystemTime() / 86400))
    --Éè¶¨ÈÎÎñ´ÎÊı
    local nCount = GetTaskByte(Task_Yibo, 1)
    SetTaskByte(Task_Yibo, 1, nCount + 1)
    nCount = GetTaskByte(Task_Yibo, 2)
    SetTaskByte(Task_Yibo, 2, nCount + 1)
    return tasktype
end

function Get_TaskNum(level)
    local tasknum = 0
    local i = random(1, 100)
    local bEnterCopy = Check_BothCopyTimes()
    if (level <= 70) then
        if (i <= 45) then
            tasknum = 1
        elseif (i > 45 and i <= 70) then
            tasknum = 2
        elseif (i > 70 and i <= 85) then
            tasknum = 13
        elseif (i > 85) then
            tasknum = 14
        end
    elseif (level > 70 and level <= 90) then
        if (i <= 20) then
            tasknum = 2
        elseif (i > 20 and i <= 40) then
            tasknum = 3
        elseif (i > 40 and i <= 50) then
            tasknum = 4
        elseif (i > 50 and i <= 60) then
            tasknum = 5
        elseif (i > 60 and i <= 80) then
            if (bEnterCopy == 0) then
                --½øÈë¸±±¾´ÎÊı³¬¹ıÁ½´Î£¬Ôò½«¼¸ÂÊÆ½·Ö¸øÆäËû
                i = random(1, 8)
                if (i == 1) then
                    tasknum = 2
                elseif (i == 2) then
                    tasknum = 3
                elseif (i == 3) then
                    tasknum = 4
                elseif (i == 4) then
                    tasknum = 5
                elseif (i == 5) then
                    tasknum = 13
                elseif (i == 6) then
                    tasknum = 14
                elseif (i == 7) then
                    tasknum = 15
                elseif (i == 8) then
                    tasknum = 16
                end
            else
                tasknum = 10   --¸±±¾ÈÎÎñ
            end
        elseif (i > 80 and i <= 85) then
            tasknum = 13
        elseif (i > 85 and i <= 90) then
            tasknum = 14
        elseif (i > 90 and i <= 95) then
            tasknum = 15
        elseif (i > 95 and i <= 100) then
            tasknum = 16
        end
    elseif (level > 90 and level <= 110) then
        if (i <= 20) then
            tasknum = 4
        elseif (i > 20 and i <= 40) then
            tasknum = 5
        elseif (i > 40 and i <= 50) then
            tasknum = 6
        elseif (i > 50 and i <= 60) then
            tasknum = 7
        elseif (i > 60 and i <= 80) then
            if (bEnterCopy == 0) then
                --½øÈë¸±±¾´ÎÊı³¬¹ıÁ½´Î£¬Ôò½«¼¸ÂÊÆ½·Ö¸øÆäËû
                i = random(1, 6)
                if (i == 1) then
                    tasknum = 4
                elseif (i == 2) then
                    tasknum = 5
                elseif (i == 3) then
                    tasknum = 6
                elseif (i == 4) then
                    tasknum = 7
                elseif (i == 5) then
                    tasknum = 15
                elseif (i == 6) then
                    tasknum = 16
                end
            else
                tasknum = 11
            end
        elseif (i > 80 and i <= 90) then
            tasknum = 15
        elseif (i > 90 and i <= 100) then
            tasknum = 16
        end
    elseif (level > 110) then
        if (i <= 20) then
            tasknum = 5
        elseif (i > 20 and i <= 40) then
            tasknum = 6
        elseif (i > 40 and i <= 50) then
            tasknum = 8
        elseif (i > 50 and i <= 60) then
            tasknum = 9
        elseif (i > 60 and i <= 80) then
            if (bEnterCopy == 0) then
                --½øÈë¸±±¾´ÎÊı³¬¹ıÁ½´Î£¬Ôò½«¼¸ÂÊÆ½·Ö¸øÆäËû
                i = random(1, 7)
                if (i == 1) then
                    tasknum = 5
                elseif (i == 2) then
                    tasknum = 6
                elseif (i == 3) then
                    tasknum = 8
                elseif (i == 4) then
                    tasknum = 9
                elseif (i == 5) then
                    tasknum = 15
                elseif (i == 6) then
                    tasknum = 16
                elseif (i == 7) then
                    tasknum = 17
                end
            else
                --±¾Ó¦¸ÃÊÇ12¸±±¾ÈÎÎñ £¬ÓÉÓÚ»¹Ã»ÓĞÖÆ×÷Íê³É£¬ÔİÊ±½«Æä¸ÅÂÊ·ÖÅä¸øÆäËûÈÎÎñ
                i = random(1, 7)
                if (i == 1) then
                    tasknum = 5
                elseif (i == 2) then
                    tasknum = 6
                elseif (i == 3) then
                    tasknum = 8
                elseif (i == 4) then
                    tasknum = 9
                elseif (i == 5) then
                    tasknum = 15
                elseif (i == 6) then
                    tasknum = 16
                elseif (i == 7) then
                    tasknum = 17
                end
            end
        elseif (i > 80 and i <= 85) then
            tasknum = 15
        elseif (i > 85 and i <= 90) then
            tasknum = 16
        elseif (i > 90) then
            tasknum = 17
        end
    end
    return tasknum
end

function Check_BothCopyTimes()
    --¼ì²éÁ½ÈË½øÈë¸±±¾µÄ´ÎÊıÊÇ·ñ¶¼ÔÚ2´ÎÒÔÄÚ 0:Ê¦Í½¶şÈËÓĞÈËÒÑ¾­½øÈë2´Î£¬ 1£ºOK
    local today = mod(floor(LocalSystemTime() / 86400), 2 ^ 16)
    local lastday = GetTaskWord(Task_CopyTask, 1)
    local times = 0
    if (today == lastday) then
        times = GetTaskByte(Task_CopyTask, 3)
    end

    local selfIdx = PlayerIndex
    local mateIdx = Get_MatePlayerIndex()
    local lastday2 = GetTaskWord(Task_CopyTask, 1)

    local times2 = 0
    if (today == lastday2) then
        times2 = GetTaskByte(Task_CopyTask, 3)
    end

    PlayerIndex = selfIdx

    if (times >= 2 or times2 >= 2) then
        return 0
    else
        return 1
    end
end

function Set_MateTaskByte(taskid, byteid, value)
    local oldPlayer = PlayerIndex
    local prindex = 0 --È¡Í½µÜĞÅÏ¢,
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    PlayerIndex = prindex
    SetTaskByte(taskid, byteid, value)
    PlayerIndex = oldPlayer
end

function Get_ApprenticeLevel()
    --·µ»ØÖµËµÃ÷£ºp1:0£ºÎŞ·¨»ñÈ¡Í½µÜ¼¶±ğ£¬Çë¼ì²é×é¶Ó nLevel:Í½µÜ¼¶±ğ
    local teamstate = Team_State()
    local nLevel = 0
    if (teamstate == 1) then
        local oldPlayer = PlayerIndex
        local prIndex = Get_MatePlayerIndex()
        PlayerIndex = prIndex
        nLevel = GetLevel()
        PlayerIndex = oldPlayer
    end
    return nLevel
end

function Judge_Times()
    --´ÎÊıÏŞÖÆÎªÃ¿Ìì×î¶à3´Î Ã¿ÖÜ×î¶à10´Î£¬Ò»ÖÜÓĞ2´ÎÊÇÃâ·ÑµÄ£¡
    --·µ»ØÖµ£º1¿ÉÒÔ½ÓÃâ·ÑÈÎÎñ 2¿ÉÒÔ½ÓÈÎÎñ£¬µ«²»ÊÇÃâ·ÑµÄ£¬½ñÌìµÄ´ÎÊı»¹Ã»µ½3´Î 3µ±ÌìÈÎÎñÒÑ´ï3´Î 4±¾ÖÜÈÎÎñ´ÎÊıÒÑ´ï10´Î£¬²»ÄÜ¼ÌĞø×ö
    local mark = 0
    local weekcount = GetTaskByte(Task_Yibo, 2)
    local weekday = GetTaskByte(Task_Yibo, 3)
    local daycount = GetTaskByte(Task_Yibo, 1)
    local lasttime = GetTaskWord(Task_Lasttime, 2)
    local nowday = floor(LocalSystemTime() / 86400)

    if ((nowday - lasttime) > (7 - weekday)) then
        SetTaskByte(Task_Yibo, 1, 0)
        SetTaskByte(Task_Yibo, 2, 0)    --Õâ¸öĞÇÆÚ×öµÄÈÎÎñ´ÎÊıÇåÁã
        daycount = 0
        weekcount = 0
    end

    if (nowday ~= lasttime) then
        SetTaskByte(Task_Yibo, 1, 0)
        daycount = 0
    end

    if (weekcount >= 12) then
        --Ò»ÖÜ´ÎÊı´óÓÚ10´Î£¬²»ÄÜ¼ÌĞø
        return 4
    end

    if (daycount >= 3) then
        --½ñÌìÈÎÎñÒÑ¾­µ½3´ÎÁË
        return 3
    end

    if (weekcount < 3) then
        --±¾ÖÜÃâ·Ñ´ÎÊı»¹Ã»ÓĞÓÃÍê
        return 1
    end

    return 2                    --µ±Ìì´ÎÊı»¹Ã»ÓÃÍê£¬µ«ÊÇÒÑ¾­²»ÊÇÃâ·ÑµÄÁË

end

function Team_State()
    --·µ»ØÖµËµÃ÷£º1¡¢¶ÓÎéÎªÁ½ÈË¶Ó£¬ÇÒÎªÒÂ²§¹ØÏµ
    --2¡¢¶ÓÎé²»ÊÇÁ½ÈË¶Ó£¬Çë²é¿´×é¶Ó·½Ê½
    --3¡¢¶ÓÎéÊÇÁ½ÈË¶Ó£¬µ«¶ÓÓÑ²»ÊÇ×Ô¼ºµÄÒÂ²§µÜ×Ó
    --4¡¢×Ô¼ºÃ»ÓĞÊÕÒÂ²§µÜ×Ó
    --5¡¢×Ô¼º½ÓÁËÈÎÎñµ«ÊÇÍ½µÜÃ»ÓĞ½ÓÈÎÎñ
    --6¡¢Í½µÜ²»ÔÚµ±Ç°µØÍ¼
    --7¡¢Í½µÜ½ÓÁËÈÎÎñµ«ÊÇ×Ô¼ºÃ»ÓĞ½ÓÈÎÎñ
    if (GetTeamSize() ~= 2) then
        return 2
    end
    if (IsMantleMaster(PlayerIndex) == 0) then
        return 4
    end

    local strName = GetName()
    local mateIdx = 0
    local selfIdx = PlayerIndex
    if (IsCaptain() == 0) then
        mateIdx = GetTeamMember(1)
    else
        mateIdx = GetTeamMember(2)
    end

    PlayerIndex = mateIdx

    local strMasterName = GetMantleMasterName()
    local taskState = GetTaskByte(Task_Count, 1)
    local mapid, x, y = GetWorldPos()
    PlayerIndex = selfIdx

    if (strMasterName ~= strName) then
        return 3
    end

    if (GetTask(Task_Count) ~= 0 and taskState == 0) then
        return 5
    end

    if (mapid ~= 20) then
        return 6
    end

    if ((GetTask(Task_Count) == 0 and taskState ~= 0) or GetTaskByte(Task_Count, 1) ~= taskState) then
        return 7
    end

    return 1
end

function Do_Gather()
    --ÊÕ¼¯ÈÎÎñ
    CloseDialog()
    local ntype = GetTaskByte(Task_Count, 1)
    local teamState = Team_State() -- ×é¶Ó×´Ì¬
    if (teamState == 2) then
        Talk(1, "no", " Ph¶i lµ Y B¸t s­ ®å tæ ®éi víi nhau míi cã thÓ tiÕp nhËn nhiÖm vô nµy!")
    elseif (teamState == 3) then
        Talk(1, "no", " §ång ®éi kh«ng ph¶i lµ Y B¸t ®Ö tö cña ng­¬i!")
    elseif (teamState == 4) then
        Talk(1, "no", " Ng­¬i ch­a thu nhËn Y B¸t ®Ö tö, kh«ng thÓ nhËn nhiÖm vô nµy!")
    elseif (teamState == 5) then
        Talk(1, "no", " §å ®Ö cña ng­¬i ®· hñy nhiÖm vô, nhiÖm vô kh«ng thÓ tiÕp tôc!")
    elseif (teamState == 6) then
        Talk(1, "no", " Y B¸t ®Ö tö cña ng­¬i hiÖn kh«ng ë T©y Kú!")
    elseif (teamState == 7) then
        Talk(1, "no", " Y B¸t ®Ö tö cña ng­¬i ®· hñy nhiÖm vô!")
    elseif (teamState == 1) then
        TeamAction("Convey_Destination", ntype, 0, 0)
    end
end

function Convey_Destination(ntype)
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Tr¹ng th¸i hiÖn t¹i cña b¹n kh«ng thÓ truyÒn tèng.")
    else
        local temp = YiboTasks[ntype].pos
        NewWorld(temp.mapid, temp.x, temp.y)
        SetFightState(1)
    end
end

function Get_Rewards()
    local nType = GetTaskByte(Task_Count, 1)
    if (nType >= 13) then
        TaskNote(1520, -1)
    elseif (nType >= 10 and nType <= 12) then
        TaskNote(1521, -1)
    else
        TaskNote(1519, -1)
    end
    SetTask(Task_Count, 0)
    if (IsMantleMaster(PlayerIndex) > 0) then
        --Ê¦¸¸½±Àø
        WriteLog("Y B¸t S­ Phô" .. GetName() .. "§· nhËn phÇn th­ëng nhiÖm vô tuÇn hoµn")
        local addPRValue = AddMasterPRValue(2)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. "<c> ®iÓm S­ ®å")
        local i = random(1, 2)
        if (i == 1) then
            ModifyFactionGlory(1)
            Msg2Player("Danh väng s­ m«n cña b¹n t¨ng thªm ")
        end

        local item = Baowu[1].Item
        ClearItem(item[1], item[2], item[3], item[4])
        item = Baowu[2].Item
        ClearItem(item[1], item[2], item[3], item[4])

        local bGetshien = Get_ShienLing()

        if (bGetshien == -1) then
            Talk(1, "no", " Xin x¸c nhËn ng­¬i vµ Y B¸t ®Ö tö cña m×nh hiÖn ®ang trong tr¹ng th¸i tæ ®éi!")
            return
        elseif (bGetshien == 1) then
            local item = Shien.Item
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
            WriteLog("Y B¸t S­ Phô" .. GetName() .. " lóc tiÕn hµnh nhiÖm vô tuÇn hoµn nhËn ®­îc S­ ¢n LÖnh")
            TopMessage("Chóc mõng b¹n bÊt ngê nhËn ®­îc 1 <color=green>S­ ¢n LÖnh<c>")
        end
    else
        --Í½µÜ½±Àø
        WriteLog("Y B¸t ®Ö tö" .. GetName() .. "§· nhËn phÇn th­ëng nhiÖm vô tuÇn hoµn")
        local item = Baowu[1].Item
        ClearItem(item[1], item[2], item[3], item[4])
        item = Baowu[2].Item
        ClearItem(item[1], item[2], item[3], item[4])

        local nLevel = GetLevel()
        EarnBind(nLevel * 1000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc b¹c khãa" .. (nLevel * 1000) .. "TiÒn")
    end
end

function Get_RLDays()
    local lastDay = GetTaskWord(Create_Yibo_Time, 1)
    local curDay = floor(LocalSystemTime() / 86400)
    local nDays = curDay - lastDay
    return nDays
end

function Get_ApprenDesaster()
    --»ñÈ¡Í½µÜ½ÙÄÑÈÎÎñĞÅÏ¢ 1:Íê³ÉÁË¶ÔÓ¦µÄ½ÙÄÑÈÎÎñ»òÕßËµÍ½µÜĞ¡ÓÚ80¼¶ 0£º½ÙÄÑÈÎÎñÃ»ÓĞÍê³É
    local teamstate = Team_State()
    if (teamstate == 1) then
        local oldPlayer = PlayerIndex
        local prIndex = 0 --È¡Í½µÜĞÅÏ¢,
        if (IsCaptain() == 0) then
            prIndex = GetTeamMember(1)
        else
            prIndex = GetTeamMember(2)
        end
        PlayerIndex = prIndex
        local nLevel = GetLevel()

        if (nLevel >= 110) then
            if (GetTaskByte(YIBO_110_DESASTER_STATE, 1) ~= 2) then
                return 0
            end
        elseif (nLevel < 110 and nLevel >= 90) then
            if (GetTaskByte(YIBO_90_DESASTER_STATE, 1) ~= 2) then
                return 0
            end
        elseif (nLevel < 90 and nLevel >= 80) then
            if (GetTaskByte(YIBO_80_DESASTER_STATE, 1) ~= 2) then
                return 0
            end
        end

        PlayerIndex = oldPlayer

        return 1
    else
        return 0
    end
end

function Get_ShienLing()
    --·µ»ØÖµËµÃ÷£º-1£ºÍ½µÜ²»ÔÚ¶ÓÎéÖĞ 0:Ã»ÓĞ»ñµÃ 1»ñµÃÊ¦¶÷Áî
    local days = Get_RLDays()
    local nLevel = Get_ApprenticeLevel()
    local rdnum = random(1, 100)
    local decrease = 1  --Ã»ÓĞÍê³É½ÙÄÑÈÎÎñ£¬¸ÅÂÊ½µµÍ

    if (Get_ApprenDesaster() == 0) then
        decrease = 0.5
    end

    if (nLevel == 0) then
        return -1
    elseif (nLevel < 80) then
        if (days >= 30) then
            return 0
        elseif ((days >= 20 and days < 30) or (days >= 0 and days < 6)) then
            if (rdnum <= 3 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days >= 16 and days < 20) or (days >= 6 and days < 11)) then
            if (rdnum <= 6 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days >= 11 and days < 16) then
            if (rdnum <= 8 * decrease) then
                return 1
            else
                return 0
            end
        end
    elseif (nLevel >= 80 and nLevel < 90) then
        if (days >= 61 or days <= 5) then
            if (rdnum < 10 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 55 and days <= 60) or (days > 5 and days <= 10)) then
            if (rdnum < 12.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days >= 51 and days <= 55) or (days > 10 and days <= 15)) then
            if (rdnum < 15 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 45 and days <= 50) or (days > 15 and days <= 20)) then
            if (rdnum < 17.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 40 and days <= 45) or (days > 20 and days <= 25)) then
            if (rdnum < 20 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 35 and days <= 40) or (days > 25 and days <= 30)) then
            if (rdnum < 22.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 30 and days <= 35) then
            if (rdnum < 25 * decrease) then
                return 1
            else
                return 0
            end
        end
    elseif (nLevel >= 90 and nLevel < 110) then
        if (days >= 100) then
            if (rdnum < 12.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 90 and days < 100) then
            if (rdnum < 15 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 80 and days <= 90) then
            if (rdnum < 17.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 70 and days <= 80) then
            if (rdnum < 20 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 65 and days <= 70) then
            if (rdnum < 22.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days > 60 or days <= 65) then
            if (rdnum < 25 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 55 and days <= 60) or (days <= 20 and days > 15)) then
            if (rdnum < 32.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 50 and days <= 55) or (days <= 25 and days > 20)) then
            if (rdnum < 35 * decrease) then
                return 1
            else
                return 0
            end
        elseif ((days > 45 and days <= 50) or (days <= 30 and days >= 26)) then
            if (rdnum < 37.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days <= 45 and days > 30) then
            if (rdnum < 40 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days <= 10 and days > 5) then
            if (rdnum < 27.5 * decrease) then
                return 1
            else
                return 0
            end
        elseif (days <= 15 and days > 10) then
            if (rdnum < 30 * decrease) then
                return 1
            else
                return 0
            end
        end
    elseif (nLevel >= 110) then
        if (rdnum <= 50) then
            return 1
        else
            return 0
        end
    end
end

function Get_MatePlayerIndex()
    --»ñµÃ¶ÓÓÑµÄPlayerIndex£¬±ØĞëÊÇÁ½ÈË¶ÓÎé²Å¿ÉÒÔ
    local prindex = 0
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    return prindex
end

function Task_Note2Both(taskIdx)
    local str = ""
    if (taskIdx == 10) then
        str = "ngµy"
    elseif (taskIdx == 11) then
        str = "§Şa "
    elseif (taskIdx == 12) then
        str = " ng­êi"
    end
    RemoveIBBuff(IBBuff_Boss)
    TaskNote(1521, 0, str)

    for i = 303, 309 do
        ClearItem(4, i, 0, 1)
    end
end

function Judge_MorphType()
    --1£ºÁ½ÈË±äÉí×´Ì¬Âú×ã0£º²»Âú×ã 2£º¶ÓÓÑÔÚÔËïÚ×´Ì¬Ö®ÖĞ
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    local state1 = 1
    local state2 = 1
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        state1 = 0
    end
    PlayerIndex = mateIdx
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        state2 = 0
    end
    local guardindex = GetTGuardIndexByPlayerName(GetName())

    PlayerIndex = selfIdx

    if (guardindex > 0) then
        return 2
    end

    if (state1 == 0 or state2 == 0) then
        return 0
    else
        return 1
    end
end
--Add By Guoqun at 2009.12.5 end

function duihuan()
    MsgBox("Ng­¬i ®· vÒ råi! H·y ®­a <c=g>Thiªn C­¬ng Phôc Ma lôc hoÆc" .. GetCostDisIB(1) .. " TiÒn ®ång<c> ta sÏ giao cho ng­¬i B¸ch Linh ph­ín ®Ó chiªu hån Thiªn C­¬ng tinh thªm  lÇn n÷a!", "duihuan_1", "no")
end

function duihuan_1()
    if (HaveNormalItem(8, 208, 5, 0) >= 1) then
        CostIBItem(FindAValidIBItem(8, 208, 5, 0))
        AddNormalItem(6, 1, 186, 0, 0, 0)
        TopMessage(11755)
        Talk(1, "no", 11756)
    elseif (GetCoin() >= GetCostIB(1)) then
        if (RealCostIB(1) == 0) then
            Talk(1, "no", 11736)
            return
        end
        AddNormalItem(6, 1, 186, 0, 0, 0)
        TopMessage(11755)
        Talk(1, "no", 11756)

    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=g>Thiªn C­¬ng Phôc Ma lôc hoÆc" .. GetCostDisIB(1) .. " TiÒn ®ång<c> nµo! Ng­¬i kĞm cái qu¸!")
    end
end
function shitu_1()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        if (GetTask(902) == 0) then
            --±µ¥ô°È
            MsgBox(11757, "shitu_1_begin", "no")
        elseif (GetTask(902) == 6) then
            --§¹¦¨¥ô°È
            MsgBox(11758, "shitu_1_end", "no")
        elseif (GetTask(902) >= 7) then
            Talk(1, "no", 11759)
        else
            --©ñ±ó¥ô°È
            MsgBox(11760, "shitu_1_cancel", "no")
        end
    else
        if (GetTask(902) == 0) then
            Talk(1, "no", 11761)
        elseif (GetTask(902) == 6) then
            Talk(1, "no", 11762)
        elseif (GetTask(902) >= 7) then
            Talk(1, "no", 11759)
        else
            MsgBox(11760, "shitu_1_cancel", "no")
        end
    end
end

function shitu_1_begin()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        RemoveIBBuff(216)
        local done = AddIBBuff(216)    --¼Ğ»xbuff
        if (done == 1) then
            SetTask(902, 1)
            TaskNote(46, 5)
            if (GetTask(900) < 7) then
                SetTask(900, 0)
                TaskNote(44, -1)
            end
            if (GetTask(901) < 7) then
                SetTask(901, 0)
                TaskNote(45, -1)
            end
            if (GetTask(899) < 7) then
                SetTask(899, 0)
                TaskNote(43, -1)
            end
            Talk(2, "no", 11763, "BÊt cø tæn th­¬ng nµo còng cã thÓ khiÕn vßng trßn cña ng­¬i mÊt ®i. C¶ qu¸ tr×nh nµy ng­¬i ph¶i cïng víi s­ phô thùc hiÖn. §¹i phu cña mçi tÇng sÏ trŞ th­¬ng gióp ng­¬i.")
        else
            Talk(1, "no", 11764)
        end
    else
        Talk(1, "no", 11762)
    end
end

function shitu_1_end()
    if (step_complete() == 0) and (GetTask(907) == 0) then
        Say("Chóc mõng ng­êi ®· hoµn thµnh luyÖn tËp th¸m hiÓm lµn nµy, hiÖn giê ma vËt hoµnh hµnh, ta tÆng ng­¬i 1 ThÇn Gi¸p hé thÓ, ng­¬i xin chän ®i.", 3, "§Çu kh«i/shitu_1_end_yes", "Yªu ®¸i/shitu_1_end_yes", "Giµy/shitu_1_end_yes")
    else
        shitu_1_end_yes(10)
    end
end

function shitu_1_end_yes(nums)
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        local name = GetName()
        local masterid = -1
        local oldPlayer = PlayerIndex
        if (GetTeamSize() == 2) then
            --2¤H¶¤
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            PlayerIndex = n
            shitu_1_end_M(name)
            masterid = GetPlayerID()
        end
        PlayerIndex = oldPlayer
        shitu_1_end_P(nums, masterid)
    else
        Talk(1, "no", 11762)
    end
end

function step_complete()
    local mark = 0
    for i = 1, 4 do
        if (GetTask(898 + i) > 6) then
            mark = mark + 1
        end
    end
    return mark
end

function shitu_1_end_P(nums, masterid)
    local exp1 = GetNextExp() - GetExp()
    local exp2 = 400000
    if (exp1 < exp2) then
        AddOwnExp(exp1)
        AddOwnExp(exp2 - exp1)
    else
        AddOwnExp(exp2)
    end
    RemoveIBBuff(216)
    SetTask(902, 7)
    SetTask(1371, masterid)
    TaskNote(46, 6)
    TopMessage(11765)
    Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    local mark = step_complete()
    if (mark == 1) and (GetTask(907) == 0) and (nums ~= 10) then
        --§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
        local ty = GetPlayerType()
        AddNormalItem(0, 7 - nums, ty + 6, 4, 0, 0)
        SetTask(907, 1)
        Talk(1, "no", 11766)
        local item_name = { [0] = { "Vò Khóc Kh«i", "Vò Khóc Yªu §¸i", "Vò Khóc ChiÕn Ngoa" },
                            [1] = { "Xİch Tïng Qu¸n", "Xİch Tïng C©n", "Xİch Tïng Lı" },
                            [2] = { "B¸o ThÇn Trô", "B¸o ThÇn Yªu §¸i", "B¸o ThÇn Ngoa" },
        }
        TopMessage("NhËn ®­îc <c=g>" .. item_name[ty][nums + 1] .. "<c>")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>cïng s­ phô hiÖp lùc hoµn thµnh nhiÖm vô s­ ®å th¸m hiÓm, nhËn ®­îc vËt quİ b¸u <c=g>" .. item_name[ty][nums + 1] .. "<c>", 20)
        --	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
        --		AddNormalItem(3,14,0,0,0,0)
        --		SetTask(903,1)
        --		Talk(1,"no","·¨áÖ¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
    elseif (mark == 4) and (GetTask(904) == 0) then
        --§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
        AddNormalItem2(0, 10, GetPlayerType() + 15, 9, 0, 0)
        SetTask(904, 1)
        Talk(1, "no", 11767)
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <c=g>thó c­ìi cÊp 50<c>", 20)
    else
        Talk(1, "no", 11768)
    end
end

function shitu_1_end_M(pname)
    local step = GetTask(902)
    local key = GetFriendFellowShipValue(pname)
    if (step < 100) or (key >= 720 * 100) then
        local addPRValue = AddMasterPRValue(10)
        SetTask(902, 100)
        --TopMessage(11769)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
    else
        local addPRValue = AddMasterPRValue(5)
        --TopMessage(11770)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
        Talk(1, "no", 11771)
    end
    SetFriendFellowShipValue(pname, 50 * 100)
    Msg2Player("§é th©n mËt gi÷a b¹n vµ §å ®Ö t¨ng thªm")
end

function shitu_1_cancel()
    RemoveIBBuff(216)
    SetTask(902, 0)
    TaskNote(46, -1)
    Talk(1, "no", 11772)
end

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

function fangchenmi()
    --if  it return 0, the 5-hour limit rules executed
    local state
    local mark
    --	if  you don't want this function executed then	you can set state equal to zero
    --		state=0
    --	else
    state = GetWeakState()    --state=0, not in limited time; state=1, in 3 hours-limit; state=2, in 5 hours limit
    --	end
    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu3()
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(1, "no", 10450)
        Msg2Player("Hµng phôc ThÇn Long, nhËn ®­îc R©u ThÇn long, h·y mang cho Hå Hû MŞ!")
        SetTask(3, 31)
        TaskNote(27, 13)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", 11718)
    end

end;

map_names = {
    "B¾c H¶i",
    "YÕn S¬n",
    "Miªu C­¬ng",
    "Cù Léc",
    "Thñ D­¬ng s¬n",
    "T©y C«n L«n",
}

function renwu1()
    local task_val = GetTask(53)
    local task_step = GetByte(task_val, 2)
    local task_state = GetByte(task_val, 1)
    local task_open = GetByte(task_val, 3)
    local task_lvl = GetLevel()
    if (task_state == 0) then
        if (task_step < 12) and (task_open < 1) then
            --Ã»ÓĞ¿ªÆô
            if (task_lvl >= 54) then
                if (HaveNormalItem(3, 44, 0, 0) >= 1) then
                    yes_1()
                else
                    Talk(1, "no", "§Ó më Phong Ên M«n, ta cÇn <c=g>B¸ L¹c Nh·n cÊp 8<c>! Anh hïng h·y gióp ta t×m vÒ!")
                end
            else
                Talk(1, "no", "Thiªn C­¬ng Tinh chiÕm cø B¾c H¶i, YÕn S¬n b¶n tİnh hung tîn. Anh hïnh cÊp 54 míi ®ñ søc thu phôc!")
            end
        elseif (task_step >= 12) and (task_step < 24) and (task_open < 2) then
            --Ã»ÓĞ¿ªÆô
            if (task_lvl >= 59) then
                if (HaveNormalItem(3, 45, 0, 0) >= 1) then
                    yes_1()
                else
                    Talk(1, "no", "§Ó më Phong Ên M«n, ta cÇn <c=g>B¸ L¹c Nh·n cÊp 9<c>! Anh hïng h·y gióp ta t×m vÒ!")
                end
            else
                Talk(1, "no", "Thiªn C­¬ng Tinh chiÕm cø Miªu C­¬ng, Cù Léc b¶n tİnh hung tîn. Anh hïng cÊp 59 anh hïng míi ®ñ søc thu phôc!")
            end
        elseif (task_step >= 24) and (task_open < 3) then
            --Ã»ÓĞ¿ªÆô
            if (task_lvl >= 64) then
                if (HaveNormalItem(3, 46, 0, 0) >= 1) then
                    yes_1()
                else
                    Talk(1, "no", "§Ó më Phong Ên M«n, ta cÇn <c=g>B¸ L¹c Nh·n cÊp 10<c>! Anh hïng h·y gióp ta t×m vÒ!")
                end
            else
                Talk(1, "no", "Thiªn C­¬ng Tinh chiÕm cø T©y C«n L«n, Thñ D­¬ng S¬n b¶n tİnh hung tîn. Anh hïng cÊp 64 míi ®ñ søc thu phôc!")
            end
        elseif (HaveNormalItem(3, 6, 0, 0) >= _g_nDongThauCost) then
            MsgBox(format("Trong Phong ThÇn b¶ng cã 36 Thiªn C­¬ng Ma Tinh, ng­¬i cã thÓ gióp ta thu phôc chóng vÒ kh«ng? ChØ cÇn cã <c=g>B¸ch Linh Ph­ín<c> lµ cã thÓ gäi Thiªn C­¬ng Tinh ra, chÕ t¹o B¸ch Linh Ph­ín cÇn %d ®ång thau!", _g_nDongThauCost), "yes_1", "no")
        else
            Talk(1, "no", format("Muèn chÕ t¹o B¸ch Linh Ph­ín cÇn cã <c=g>%d ®ång thau<c>, chuÈn bŞ ®ñ h·y ®Õn t×m ta!", _g_nDongThauCost))
        end
    elseif (task_state == 1) then
        if (HaveEventItem(42) >= 1) then
            Talk(1, "no", "T¹i <c=g>" .. map_names[floor(task_step / 6) + 1] .. "<c> cã thÓ t×m thÊy <c=g>Phong Ên th¸p<c>, dïng <c=g>B¸ch Linh Ph­ín<c> th¶ <c=g>Thiªn C­¬ng Ma Tinh<c> ra. Sau khi thu phôc nã sÏ nhËn ®­îc <c=g>Thiªn C­¬ng ch©n khİ<c>.")
        else
            Talk(1, "no", 11773)
        end
    elseif (task_state == 2) then
        if HaveEventItem(43) >= 1 then
          if GetCash() < 60 * 10000 then
            Talk(1, "no", "Xem ra c¸c h¹ ®· thÊt b¹i, chØ cÇn ®em theo 60 v¹n l­îng, ta sÏ gióp c¸c h¹ tiÕp tôc phong Ên B¸ch Linh Ph­ín")
            return
          end
          Pay(60 * 10000)
          DelEventItem(43)
          AddEventItem(42)
          Msg2Player("VÉn ch­a diÖt trõ ®­îc Thiªn C­¬ng Tinh, B¸ch Linh Ph­ín tiÕp tôc phong Ên")
          SetTask(53, SetByte(task_val, 1, 1))
          refreshNpcTaskState()
          Talk(1, "no", 10453)
        else
            Talk(1, "no", 11774)
        end
    elseif (task_state == 3) then
        if HaveEventItem(44) >= 1 then
            if (task_step == 35) then
                DelEventItem(44)
                AddNormalItem(8, 208, 5, 0, 0, 0)
                AddOwnExp(900000)
                ----½±Àø90000µã¾­Ñé
                Msg2Player("B¹n nhËn ®­îc ®iÓm danh väng")
                SetSubTask(23, -1, 1)
                TaskNote(23, -1)
                AddCredit(108)----½±Àø108µãÉùÍû

                if (GetByte(task_val, 4) == 0) then
                    local playertype = GetPlayerType()
                    if (playertype == 0) then
                        if (random(1, 200) < 100) then
                            AddNormalItem(0, 0, 31, 6, 0, 0, 0)
                        else
                            AddNormalItem(0, 0, 32, 6, 0, 0, 0)
                        end
                    elseif (playertype == 1) then
                        AddNormalItem(0, 0, 33, 6, 0, 0, 0)
                    elseif (playertype == 2) then
                        AddNormalItem(0, 0, 34, 6, 0, 0, 0)
                    end
                    SetTask(53, SetByte(task_val, 4, 1))
                    task_val = GetTask(53)
                    refreshNpcTaskState()
                end
                SetTaskByte(53, 1, 0)--log¸Ä°æ
                SetTaskByte(53, 2, task_step + 1)--log¸Ä°æ
                Talk(1, "no", 11775)
                refreshNpcTaskState()
            else
                if (task_step <= 11) then
                    AddOwnExp(50000)
                    TopMessage("NhËn ®­îc <c=g>50000<c> ®iÓm kinh nghiÖm.")
                    if (task_step == 11) then
                        Msg2Player("Hoµn thµnh giai ®o¹n 1, bÊt ngê nhËn ®­îc tr¹ng th¸i TiÓu Thiªn H­¬ng Tôc MÖnh.")
                        AddIBBuff(334)
                    end
                elseif (task_step <= 23) then
                    if (task_step == 23) then
                        local playertype = GetPlayerType()
                        if (playertype == 0) then
                            if (random(1, 200) < 100) then
                                AddNormalItem(0, 0, 31, 6, 0, 0, 0)
                            else
                                AddNormalItem(0, 0, 32, 6, 0, 0, 0)
                            end
                            Msg2Player("Hoµn thµnh giai ®o¹n 2, nhËn ®­îc Vò khİ hoµng kim cÊp 60 (Khãa).")
                        elseif (playertype == 1) then
                            Msg2Player("Hoµn thµnh giai ®o¹n 2, nhËn ®­îc Vò khİ hoµng kim cÊp 60 (Khãa).")
                            AddNormalItem(0, 0, 33, 6, 0, 0, 0)
                        elseif (playertype == 2) then
                            Msg2Player("Hoµn thµnh giai ®o¹n 2, nhËn ®­îc Vò khİ hoµng kim cÊp 60 (Khãa).")
                            AddNormalItem(0, 0, 34, 6, 0, 0, 0)
                        end
                        SetTask(53, SetByte(task_val, 4, 1))
                        task_val = GetTask(53)
                        refreshNpcTaskState()
                    end
                    AddOwnExp(70000)
                    TopMessage("NhËn ®­îc <c=g>70000<c> ®iÓm kinh nghiÖm.")
                else
                    AddOwnExp(90000)
                    TopMessage("NhËn ®­îc <c=g>90000<c> ®iÓm kinh nghiÖm.")
                end

                DelEventItem(44)
                Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng!")
                TaskNote(23, -1)
                SetTaskByte(53, 1, 0)--log¸Ä°æ
                SetTaskByte(53, 2, task_step + 1)--log¸Ä°æ
                Talk(1, "no", 10452)
            end
            refreshNpcTaskState()
        else
            Talk(1, "no", 11777)
        end
        refreshNpcTaskState()
    end
end;

function yes_1()
    CloseDialog()
    local task_val = GetTask(53)
    local task_step = GetByte(task_val, 2)
    local task_state = GetByte(task_val, 1)
    if (task_state == 0) then
        local task_level = floor(task_step / 6) + 1
        local task_lvl = GetLevel()
        if (task_lvl >= 64) or (task_lvl >= 59 and task_step <= 23) or (task_lvl >= 54 and task_step <= 11) then
            local task_open = GetByte(task_val, 3)
            if ((task_step < 12) and (task_open < 1)) or ((task_step >= 12) and (task_step < 24) and (task_open < 2)) or ((task_step >= 24) and (task_open < 3)) then
                local eye_name = { [0] = "B¸ L¹c Nh·n cÊp 8", [1] = "B¸ L¹c Nh·n cÊp 9", [2] = "B¸ L¹c Nh·n cÊp 10" }
                MsgBox("Muèn më Phong Ên Th¸p cÇn cã 1 <c=g>" .. eye_name[(floor(task_step / 12))] .. "<c>. NÕu t×m ®ñ, sÏ gióp Kh­¬ng S­ Thóc thu phôc 12 vŞ trong sè 36 Thiªn C­¬ng Tinh.", "yes_1_1", "no")
            else
                yes_1_2(task_level, task_val)
            end
        elseif (task_lvl < 59) then
            Talk(1, "no", "Thiªn C­¬ng Tinh chiÕm cø Miªu C­¬ng, Cù Léc hung tîn h¬n B¾c H¶i, YÕn S¬n rÊt nhiÒu! <c=g> CÊp 59<c> h·y ®Õn thu phôc chóng!")
        else
            Talk(1, "no", "Thiªn C­¬ng Tinh chiÕm cø Thñ D­¬ng S¬n, T©y C«n L«n m¹nh nhÊt trong c¸c Thiªn C­¬ng Tinh. <c=g>CÊp 64<c> h·y ®i thu phôc chóng!")
        end
    end
    refreshNpcTaskState()
end;

function yes_1_1()
    local eye_data = { [0] = { "B¸ L¹c Nh·n cÊp 8", 44 }, [1] = { "B¸ L¹c Nh·n cÊp 9", 45 }, [2] = { "B¸ L¹c Nh·n cÊp 10", 46 } }
    local task_val = GetTask(53)
    local task_step = GetByte(task_val, 2)
    local lvl = floor(task_step / 12)
    if (HaveNormalItem(3, eye_data[lvl][2], 0, 0) >= 1) then
        DelNormalItem(3, eye_data[lvl][2], 0, 0)
        SetTaskByte(53, 1, 1)--log¸Ä°æ
        SetTaskByte(53, 3, (lvl + 1))--log¸Ä°æ
        SetSubTask(23, 1, 1)
        refreshNpcTaskState()

        local task_level = floor(task_step / 6) + 1
        AddEventItem(42)
        Msg2Player("NhËn ®­îc B¸ch Linh ph­ín, ®i th¶ Thiªn C­¬ng Tinh")
        TaskNote(23, task_level)
        Talk(1, "no", "GÇn <c=g>" .. map_names[task_level] .. "<c> cã thÓ t×m ®­îc <c=g>Phong Ên Th¸p<c>. <c=g>B¸ch Linh Ph­ín Phong Ên<c> cã thÓ th¶ ra <c=g>Thiªn C­¬ng Ma Tinh<c>. Tiªu diÖt nã, cã thÓ thu thËp ®­îc <c=g>Thiªn C­¬ng ch©n khİ<c>!")
    else
        Talk(1, "no", "§Ó më Phong Ên M«n, ta cÇn <c=r>" .. eye_data[lvl][1] .. "<c>! Anh hïng h·y gióp ta t×m vÒ!")
    end
    refreshNpcTaskState()
end

function yes_1_2(level, val)
    if (HaveNormalItem(3, 6, 0, 0) >= _g_nDongThauCost) then
        for i = 1, _g_nDongThauCost do
            DelNormalItem(3, 6, 0, 0)
        end
        AddEventItem(42)
        Msg2Player("NhËn ®­îc B¸ch Linh ph­ín, ®i th¶ Thiªn C­¬ng Tinh")
        TaskNote(23, level)
        SetTaskByte(53, 1, 1)--log¸Ä°æ
        refreshNpcTaskState()
        Talk(1, "no", "GÇn <c=g>" .. map_names[level] .. "<c> cã thÓ t×m ®­îc <c=g>Phong Ên Th¸p<c>. <c=g>B¸ch Linh Ph­ín Phong Ên<c> cã thÓ th¶ ra <c=g>Thiªn C­¬ng Ma Tinh<c>. Tiªu diÖt nã, cã thÓ thu thËp ®­îc <c=g>Thiªn C­¬ng ch©n khİ<c>!")
    else
        Talk(1, "no", format("Dô Thiªn C­¬ng Ma Tinh xuÊt hiÖn cÇn cã 1 <c=yel>B¸ch Linh Ph­ín<c>, chÕ t¹o B¸ch Linh Ph­ín cÇn cã <c=r>%d ®ång thau<c>, chuÈn bŞ ®ñ råi h·y ®Õn!", _g_nDongThauCost))
    end
    refreshNpcTaskState()
end

function renwu2()
    --edited by yangtao 2009.8.17
    --ÈËÖ®½«ËÀÈÎÎñĞŞ¸ÄÎªÑîê¯Ê¹Íæ¼Ò±äÉíÎª·ÉÊó
    local f = GetCompeteFlag()
    if (f == 1) then
        CloseDialog()
        Talk(1, "no", "Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ tiÕp nhËn! Xin ®îi tr¹ng th¸i chiÕn ®Êu kÕt thóc míi cã thÓ tiÕp tôc nhiÖm vô.")
        return
    else
        if (GetMorphType() == 364) or (GetMorphType() == 50) or (GetMorphType() == 420) or (GetMorphType() == 419 or (GetMorphType() == 411)) then
            CloseDialog()
            Talk(1, "no", "Trong tr¹ng th¸i nµy kh«ng thÓ tiÕp nhËn! Xin ®îi tr¹ng th¸i chiÕn ®Êu kÕt thóc míi cã thÓ tiÕp tôc nhiÖm vô.")
            return
        else
            if (GetTaskByte(1357, 1) == 3 and GetMorphType() == 16) then
                Talk(1, "no", "§ang ë tr¹ng th¸i ngôy trang Thiªn H¹o, h·y ®i thu phôc <c=r>Thñ lÜnh Giang Quy<c>!")
                return
            elseif (GetTaskByte(1357, 1) == 4 and GetMorphType() == 24) then
                Talk(1, "no", "Ng­¬i ®ang trong tr¹ng th¸i nguş trang thñ lÜnh Giang Quy, h·y ®i diÖt trõ <c=r>30 Thiªn H¹o<c>!")
                return
            end
            PolyMorph(50, 1, 0, -1, 300)
        end ;
    end
    Talk(3, "next", 10455, GetName() .. ": C¸ch g× vËy?", 10457)
    --end of edit
end;

function next()
    --edited by yangtao 2009.8.17
    Talk(2, "no", GetName() .. ": Hay l¾m! Hay l¾m!", 10460)
    --end of edit
    Msg2Player("D­¬ng TiÔn tÆng b¹n 1 Kim phï, biÕn th©n thµnh Phi Thè")
    TaskNote(26, 1)
    SetTask(92, 2)
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;

function renwu4()
    local task_step = GetByte(GetTask(53), 2)
    if task_step > 35 then
        Talk(1, "no", 10119)
    else
        Talk(1, "one", 10120)
    end ;
end;

function one()
    local p = {}
    local n = 0
    for n = 250, 261 do
        if (GetTask(n) == 0) then
            p[n - 249] = "green"
        elseif (GetTask(n) == 1) then
            p[n - 249] = "red"
        end ;
    end ;
    Talk(1, "two", "<color=" .. p[1] .. ">Thiªn Kh«i <c>--<color=" .. p[2] .. ">Thiªn C­¬ng <c>--<color=" .. p[3] .. ">Thiªn C¬ <c>--<color=" .. p[4] .. ">Thiªn Nhµn <c>--<color=" .. p[5] .. ">Thiªn Dòng <c>--<color=" .. p[6] .. ">Thiªn Hïng <c>--<color=" .. p[7] .. ">Thiªn M·nh <c>--<color=" .. p[8] .. ">Thiªn Uy <c>--<color=" .. p[9] .. ">Thiªn Anh <c>--<color=" .. p[10] .. ">Thiªn Quı <c>--<color=" .. p[11] .. ">Thiªn Phóc <c>--<color=" .. p[12] .. ">Thiªn M·n <c>")
end;

function two()
    local p = {}
    local n = 0
    for n = 262, 273 do
        if (GetTask(n) == 0) then
            p[n - 249] = "green"
        elseif (GetTask(n) == 1) then
            p[n - 249] = "red"
        end ;
    end ;
    Talk(1, "three", "<color=" .. p[13] .. ">Thiªn C« <c>--<color=" .. p[14] .. ">Thiªn S¬n <c>--<color=" .. p[15] .. ">Thiªn VŞ <c>--<color=" .. p[16] .. ">Thiªn TiÖp <c>--<color=" .. p[17] .. ">Thiªn ¸m <c>--<color=" .. p[18] .. ">Thiªn H÷u <c>--<color=" .. p[19] .. ">Thiªn Kh«ng <c>--<color=" .. p[20] .. ">Thiªn Tèc <c>--<color=" .. p[21] .. ">Thiªn DŞ <c>--<color=" .. p[22] .. ">Thiªn S¸t <c>--<color=" .. p[23] .. ">Thiªn Vi <c>--<color=" .. p[24] .. ">Thiªn Cøu Tinh<c>")
end;

function three()
    local p = {}
    local n = 0
    for n = 274, 285 do
        if (GetTask(n) == 0) then
            p[n - 249] = "green"
        elseif (GetTask(n) == 1) then
            p[n - 249] = "red"
        end ;
    end ;
    Talk(1, "no", "<color=" .. p[25] .. ">Thiªn Thèi <c>--<color=" .. p[26] .. ">Thiªn Thä <c>--<color=" .. p[27] .. ">Thiªn KiÕm <c>--<color=" .. p[28] .. ">Thiªn B×nh <c>--<color=" .. p[29] .. ">Thiªn Téi <c>--<color=" .. p[30] .. ">Thiªn Tæn <c>--<color=" .. p[31] .. ">Thiªn B¹i <c>--<color=" .. p[32] .. ">Thiªn Lao <c>--<color=" .. p[33] .. ">Thiªn TuÖ <c>--<color=" .. p[34] .. ">Thiªn B¹o <c>--<color=" .. p[35] .. ">Thiªn Chó <c>--<color=" .. p[36] .. ">Thiªn X¶o <c>")
end;

function instence_renwu()
    CloseDialog()
    if (GetLevel() >= 70) and (GetTaskByte(instence_Task, 1) == 0) then
        Talk(4, "no", " Anh hïng ®Õn ®óng lóc l¾m. MÊy h«m nay Kh­¬ng s­ thóc bçng nhiªn nh­ ng­êi mÊt hån, ch¾c ch¾n ®· cã sù viÖc träng ®¹i x¶y ra.", " Ta nghe nãi gÇn ®©y V¨n Th¸i S­ ®· mêi ®Ö tö TriÖt Gi¸o lËp nªn ThËp TuyÖt trËn, ®Ó ng¨n c¶n §¹i Chu tÊn c«ng Th­¬ng qu©n. Cã thÓ Kh­¬ng Thóc ®ang lo l¾ng vÒ viÖc nµy!", " Nam Cùc Tiªn ¤ng ë Ngäc H­ Cung lµ cao nh©n cña XiÓn gi¸o ta, cã thÓ «ng Êy biÕt ®­îc thiªn c¬, kh«ng biÕt anh hïng cã thÓ thay ta ®Õn ®ã thØnh vÊn «ng Êy kh«ng?", GetName() .. ": ChuyÖn nµy xin t­íng qu©n cø an t©m, t¹i h¹ sÏ toµn t©m!!")
        Msg2Player("§Õn Ngäc H­ Cung t×m Nam Cùc Tiªn ¤ng thØnh gi¸o!")
        SetTaskByte(instence_Task, 1, 1)
        TaskNote(1204, 0)
    elseif (GetLevel() >= 70) and (GetTaskByte(instence_Task, 1) == 3) then
        --if(HaveEventItem(285)>0)then
        Talk(3, "info_1", " Anh hïng ®· vÒ råi! Kh«ng biÕt cã thØnh vÊn ®­îc Tiªn ¤ng g× ch¨ng?", GetName() .. ": Kh­¬ng Thõa t­íng hån x¸c ph©n ly, ®Òu lµ do ng­êi cña TriÖt Gi¸o lµm, Tiªn ¤ng b¶o t¹i h¹ giao Hå L« Hån Ph¸ch nµy cho t­íng qu©n, vµ nãi cho t¹i h¹ biÕt, ph¶i lÊy ®­îc H×nh Nh©n cã viÕt tªn Thõa t­íng trong ThËp TuyÖt trËn, míi cã thÓ cøu ®­îc Thõa t­íng!", " Th× ra lµ vËy! Ta hiÖn kh«ng thÓ rêi khái ®©y, hay lµ anh hïng h·y gióp ta vµo ®ã dß th¸m mét chuyÕn.Ta nghe nãi trong Thiªn TuyÖt TrËn cã 3 ng­êi hé ph­ín, cã thÓ chóng biÕt chç giÊu h×nh nh©n.")
        Msg2Player("§ét nhËp ThËp TuyÖt trËn t×m chç giÊu H×nh Nh©n.")
        SetTaskByte(instence_Task, 1, 4)
        ClearItem(4, 285, 0, 1)
        TaskNote(1204, 2)
        --else
        --Talk(1,"no","Ñîê¯£º²»ÖªÓ¢ĞÛ¿ÉÔøÌ½Ìıµ½Ê²Ã´¹ØÓÚÊ¦Êå²¡¿öµÄÏûÏ¢£¿")
        --end
    elseif (GetLevel() >= 70) and (GetTaskByte(instence_Task, 1) == 5) then
        Talk(2, "no", " MËt LÖnh nµy rèt cuéc cã t¸c dông g×, ta còng ch­a biÕt! Anh hïng ®îi ta ®i thØnh gi¸o c¸c vŞ s­ thóc, xem cã diÖu kÕ g× kh«ng?", GetName() .. ": Hy väng vËt nµy cã thÓ gióp ®o¹t l¹i linh hån cña Thõa t­íng!")
        Msg2Player("NhËn ®­îc 100000 ®iÓm kinh nghiÖm")
        SetTaskByte(instence_Task, 1, 6)
        ClearItem(4, 286, 0, 1)
        AddOwnExp(100000)
        TaskNote(1204, -1)
        --
    end
end

function info_1()
    Talk(2, "no", GetName() .. ": T¹i h¹ sÏ tËn lùc, D­¬ng t­íng qu©n kh«ng cÇn lo l¾ng! Cã ®iÒu, lµm sao ®Ó vµo ThËp TuyÖt trËn, xin t­íng qu©n chØ gi¸o!", " ChØ cÇn anh hïng ®¼ng cÊp ®¹t 71, cã thÓ ®Õn T©y Kú t×m <c=g>ChuÈn §Ò §¹o Nh©n<c>, mçi ngµy tõ <c=g>8: 00-22: 00<c> cã thÓ vµo ThËp TuyÖt trËn! Trong trËn hiÓm nguy trïng trïng, anh hïng ph¶i cã thªm nhiÒu ng­êi hç trî míi an toµn!")
end

function instence_renwu1()
    CloseDialog()
    if (HaveNormalItem(3, 1050, 0, 0) > 0) and (GetTaskByte(instence_Task, 1) == 10) then
        Talk(2, "no", " Anh hïng qu¶ nhiªn trİ dòng song toµn, vµo ra trËn ®Şa nh­ chç kh«ng ng­êi, khiÕn nhuÖ khİ Th­¬ng qu©n gi¶m thÊy râ, tr­íc m¾t ®Ó ta mang thñ dô nµy vÒ phôc mÖnh Vâ V­¬ng, ®îi anh hïng ®¹t cÊp 90, sÏ nhê t­¬ng trî. Cã ®iÒu ThËp TuyÖt trËn biÕn hãa huyÒn ¶o, dùa theo ph­¬ng vŞ ©m d­¬ng thiªn ®Şa mµ ®ãng hoÆc më, anh hïng nªn th­êng xuyªn vµo ®ã ®Ó t×m hiÓu c¸ch hãa gi¶i, ®ång thêi lùa thêi c¬ tiÕp tôc truy t×m tung tİch H×nh Nh©n!", GetName() .. ": T¹i h¹ sÏ tËn lùc!")
        DelNormalItem(3, 1050, 0, 0)
        TaskNote(1205, -1)
        SetTaskByte(instence_Task, 1, 11)
        Msg2Player("NhËn ®­îc 120000 ®iÓm kinh nghiÖm")
        AddOwnExp(120000)
    elseif (GetTaskByte(instence_Task, 1) == 10) then
        Talk(3, "no", " Ta cã nghe anh hïng ®· c«ng ph¸ Thiªn Tù TrËn, kh«ng biÕt ®· thu ho¹ch ®­îc g×??", GetName() .. ": mÆc dï ®· c«ng ph¸ trËn nµy, nh­ng vÉn ch­a nh×n thÊy c¸c MËt LÖnh kh¸c.", " NÕu qu¶ nh­ cã lo¹i MËt lÖnh nµy, ch¾c ch¾n sÏ do §æng Thiªn Qu©n trong Phong Hèng TrËn qu¶n lı. §æng Thiªn Qu©n kh«ng thÓ lóc nµy còng mang theo vËt nµy trong ng­êi, anh hïng xin h·y th­êng xuyªn vµo trong ®ã, t×m c¬ héi ®Ó ®o¹t lÊy!")
    elseif (GetTaskByte(instence_Task, 1) == 6) then
        Talk(2, "no", " Thñ dô anh hïng giao cho ta chİnh lµ MËt lÖnh truyÒn tin cña ThËp §¹i Thiªn Qu©n, nghe nãi chóng ®· chuyÓn H×nh Nh©n cã hån cña Thõa t­íng sang trËn kh¸c. Nh­ng vµo trËn nµo th× vÉn ch­a biÕt ®­îc, v× vËy xin anh hïng h·y tiÕp tôc vµo “Thiªn Tù TrËn“ ®Ó th¸m thİnh, biÕt ®©u cã thÓ t×m thÊy c¸c Thñ dô kh¸c.", GetName() .. ": T¹i h¹ sÏ tËn lùc, tiªu trõ bän yªu ma nµy!")
        TaskNote(1205, 0)
        Msg2Player("C«ng ph¸ Thiªn TuyÖt TrËn, truy t×m tung tİch c¸c MËt LÖnh kh¸c!")
        SetTaskByte(instence_Task, 1, 7)
    elseif (GetTaskByte(instence_Task, 1) < 11) then
        Talk(1, "no", " Anh hïng vÉn ch­a vµo ThËp TuyÖt trËn sao? ChØ cÇn ®Õn T©y Kú t×m <c=g>ChuÈn §Ò §¹o Nh©n<c>, mçi ngµy tõ <c=g>8: 00-22: 00<c> cã thÓ vµo ThËp TuyÖt trËn!")
        --
    end
end

-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
function instence_renwu2()
    CloseDialog()
    local progress = GetTaskByte(instence_Task, 1)
    if (progress == 11) then
        SetTaskByte(instence_Task, 1, 12)
        TaskNote(TaskInfo_cbal, 0)
        refreshNpcTaskState()
        Talk(2, "no", " Ta ®· t×m hiÓu ®­îc, bän ThËp §¹i Thiªn Qu©n rÊt gi¶o ho¹t, chóng ®· chia MËt LÖnh thµnh 3 phÇn, trªn mçi phÇn sÏ ghi chĞp mét sè tin tøc, nÕu t×m ®­îc 2 Thñ lÖnh th× cã thÓ biÕt ®­îc n¬i chóng giÊu H×nh Nh©n yÕm hån ph¸ch Thõa t­íng.", " V× vËy lÇn nµy xin anh hïng l¹i gióp, t×m n¬i chóng cÊt giÊu Thñ lÖnh trong §Şa Tù TrËn, cøu Thõa t­íng! HiÖn §Şa Tù TrËn ®· më, anh hïng xin h·y cÊp tèc lªn ®­êng!")
    elseif (progress == 12) then
        Talk(1, "no", " Thñ lÖnh cã thÓ cøu ®­îc Thõa t­íng ®ang trong §Şa Tù TrËn cña ThËp TuyÖt trËn, xin anh hïng cÊp tèc vµo ®ã!")
    elseif (progress == 13) then
        Talk(1, "no", " Xem ra Thñ lÖnh kh«ng ë chç Viªn Thiªn Qu©n, ph¶i ®i t×m Kim Quang Th¸nh MÉu hoÆc T«n Thiªn Qu©n míi ®­îc.")
    elseif (progress == 14) then
        Talk(1, "no", " Xem ra Thñ lÖnh nhÊt ®Şnh ë chç T«n Thiªn Qu©n!")
    elseif (progress == 15) then
        if (HaveNormalItem(3, 1089, 0, 0) > 0) then
            TaskNote(TaskInfo_cbal, -1)
            Msg2Player("NhËn ®­îc 120000 ®iÓm kinh nghiÖm")
            AddOwnExp(120000)
            SetTaskByte(instence_Task, 1, 16)
            DelNormalItem(3, 1089, 0, 0)
            refreshNpcTaskState()
            Talk(3, "no", " Ta ph¶i mang nã ®Õn cho S­ thóc Xİch Tinh Tö, ®Ó ®èi chiÕu ch÷ trªn 2 Thñ lÖnh, nhÊt ®Şnh sÏ biÕt ®­îc vŞ trİ cña H×nh Nh©n. Anh hïng sau khi ®¹t cÊp 110 xin quay l¹i gÆp t¹i h¹!", GetName() .. ": T¹ h¹ sÏ tËn lùc gióp søc.", " Cã ®iÒu Nh©n Tù TrËn biÕn hãa huyÒn ¶o, dùa theo ph­¬ng vŞ ©m d­¬ng thiªn ®Şa mµ ®ãng hoÆc më, mong anh hïng h·y chän thêi c¬ lóc trËn më ®Ó vµo ®ã gióp m¹c t­íng mét tay!")
        else
            Talk(1, "no", " Thñ lÖnh nhÊt ®Şnh ®· bŞ T«n Thiªn Qu©n cÊt giÊu, nÕu anh hïng ®¸nh b¹i T«n Thiªn Qu©n vµi lÇn th× cã thÓ t×m ®­îc Thñ lÖnh.")
        end
    end
end
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

-- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 begin
function instence_renwu3()
    CloseDialog()
    local progress = GetTaskByte(instence_Task, 1)
    if (progress == 16) then
        SetTaskByte(instence_Task, 1, 17)
        TaskNote(TaskInfo_slsch, 0)
        refreshNpcTaskState()
        Talk(2, "no", " S­ thóc ®· ®iÒu tra ®­îc, trªn H×nh Nh©n chØ cã 1 ph¸ch cña Thõa t­íng, 2 hån 5 ph¸ch cßn l¹i ®· bŞ phô thÓ trªn m×nh c¸c qu¸i vËt trong L¹c Hån TrËn, cßn H×nh Nh©n ®ang do Diªu Thiªn Qu©n trÊn gi÷. Anh hïng chØ cÇn hµng phôc c¸c qu¸i vËt cã phô thÓ hån ph¸ch cña Thõa t­íng vµ Diªu Thiªn Qu©n lµ cã thÓ thu ®­îc 2 hån 5 ph¸ch vµ H×nh Nh©n.", " LiÖt DiÖm TrËn hiÖn ®· më! Anh hïng ph¶i th«ng qua khiªu chiÕn B¸ch Thiªn Qu©n míi cã thÓ vµo L¹c Hån TrËn quyÕt ®Êu víi Diªu Thiªn Qu©n, cuèi cïng tiªu diÖt V­¬ng Thiªn Qu©n trong Hång Thñy TrËn! Xin cÊp tèc lªn ®­êng!")
    elseif (progress == 20) then
        if (HaveNormalItem(4, 312, 0, 1) > 0) and (HaveNormalItem(4, 313, 0, 1) >= 2) and (HaveNormalItem(4, 314, 0, 1) >= 5) then
            for i = 312, 314 do
                ClearItem(4, i, 0, 1)
            end
            TaskNote(TaskInfo_slsch, -1)
            Msg2Player("NhËn ®­îc 120000 ®iÓm kinh nghiÖm")
            AddOwnExp(120000)
            SetTaskByte(instence_Task, 1, 21)
            refreshNpcTaskState()
            Talk(2, "no", " Anh hïng qu¶ nhiªn lµ kú tµi cña ®¹i Chu, h«m nay ®· thu håi ®ñ hån ph¸ch, Thõa t­íng tÊt ®­îc cøu. Cã ®iÒu Vâ V­¬ng v× lo l¾ng cho Thõa t­íng, ®· ®· thèng lÜnh binh t­íng vµo Hång Sa TrËn, tÊt c¶ ®Òu ®· bŞ Tr­¬ng Thiªn Qu©n dïng yªu thuËt nhèt trong trËn. ChØ cã anh hïng míi cã thÓ ph¸ ®­îc ph¸p thuËt cña Tr­¬ng Thiªn Qu©n, cøu Vâ V­¬ng vµ chóng t­íng, ", " Cã ®iÒu ThËp TuyÖt trËn biÕn hãa huyÒn ¶o, dùa theo ph­¬ng vŞ ©m d­¬ng thiªn ®Şa mµ ®ãng hoÆc më, mong anh hïng h·y chän thêi c¬ lóc trËn më ®Ó vµo ®ã gióp m¹c t­íng mét tay. Nh­ng anh hïng ph¶i ®¹t cÊp 130 th× míi cã thÓ vµo ®ã ®Ó gi¶i cøu Vâ V­¬ng!")
        else
            Talk(1, "no", " 2 hån 5 ph¸ch cña Thõa t­íng vµ H×nh Nh©n ®©u? Anh hïng ch­a lÊy ®­îc ­?")
        end
    end
end
-- ¸±±¾ÈÎÎñË®ÂäÊ¯³ö Add by yaoxin at 2010/3/18 end

--added by hongliang for ºìÉ°Õó 10/10/29 begin
function Instance_HSZ_PreTask()
    CloseDialog()

    if (GetLevel() >= 131 and GetTaskByte(1606, 1) >= 21 and GetTaskByte(TASK_Instance_HSZ, 1) == 0) then
        Talk(2, "no", "NÕu c¸c anh hïng ®· c«ng ph¸ ®­îc 9 trËn cña ThËp TuyÖt trËn th× Hång Sa trËn chİnh lµ trËn cuèi cïng, bªn trong cã Thiªn, §Şa, Nh©n tam tµi, tam khİ vµ tam ®Êu--Th­îng bÊt tri thiªn, h¹ bÊt tri ®Şa, trung bÊt tri nh©n. NÕu ng­êi, tiªn x«ng vµo trËn nµy th× gi«ng tè næi lªn, bôi ®Êt mï trêi, x­¬ng cèt tan n¸t.", "Khi ®ã Vâ V­¬ng lo cho sù an nguy cña Tö Nha nªn dÉn qu©n tiÕn vµo trËn, kh«ng may bŞ nhèt trong trËn nµy, may mµ cã Tö Vi Tiªn Y hé thÓ nªn gi÷ ®­îc m¹ng sèng. §ã lµ sè kiÕp nªn khã tr¸nh khái. Cöa trËn rÊt huyÒn diÖu, cÇn thu thËp Thñ dô cña Thiªn Tù TrËn, §Şa Tù TrËn vµ Nh©n Tù TrËn míi cã thÓ më cöa x«ng vµo trong trËn.")

        SetTaskByte(TASK_Instance_HSZ, 1, 1)
        TaskNote(1623, 0)
        SetSubTask(1623, 1, 1)
        refreshNpcTaskState()
        WriteLog(GetName() .. "NhËn nhiÖm vô h­íng dÉn Hång Sa trËn")
    end

end
--added by hongliang for ºìÉ°Õó 10/10/29 end



