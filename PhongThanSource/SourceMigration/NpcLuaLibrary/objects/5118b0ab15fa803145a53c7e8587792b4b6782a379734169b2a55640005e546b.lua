Include("\\script\\gvn\\lib.lua");
Include("\\script\\gvn\\events\\top_consumecoin\\event_topconsume.lua")
--description: »ÆÌì»¯-µÀÊ¿Ö÷Ïß?Îñ
--description: »ÆÌì»¯-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-14

--901,1370Ê¦ÃÅĞùÔ¯ÊÔÁ¶
--1026 ´ÌÌ½Çé±¨Ã¿ÈÕÈÎÎñ´ÎÊı¼ÇÂ¼
--314£ºÊÇ·ñ½ÓÁËÈÎÎñ£»315£ºÉÏÒ»´Î½ÓÈÎÎñµÄÈÕÆÚ£»
--317£º1byteÒÑÍê³ÉÈÎÎñµÄ»·Êı£»2byte ÄÉ²Æ´ÎÊıÖÃ×Ü´ÎÊı£¬3byteÖÃÄÉ²Æµ±Ç°Ğ¡»·Êı 4byteµ¥±¶»¹ÊÇË«±¶¸¶·Ñ
--916£ºµ±Ìì¸¶·Ñ×öÈÎÎñµÄ´ÎÊı
TASK_lateral = 1200 --30-50Ö§Ïß, 1bitÊÇ·ñÁì¹ı¹ê¹ÇÇ©
CitanAddress = 995
Task_Improve = 1351        --1bitÊÇ·ñÁì¹ıÈçÒâÒ°Íâ´«ËÍ·û£»2byte:ÉñÃØ»¨»ÜÊ§°ÜµÄ´ÎÊı
---------Àë¼äÖ®¼Æ-----------
Task_Mischief = 1357  --1byte:0Ã»ÁìÈÎÎñ£»1£ºÁìÈ¡ÁË²¶×½ÈÎÎñ£»2£ºÍê³É²¶×½£¬ÁìÈ¡ÁË½±Àø£»3£ºÁìÈ¡ÁËÁÔÉ±ºµ¹êÊ×ÁìµÄÈÎÎñ£»4:ÒÑ±ä³Éºµ¹ê×´Ì¬£»5£ºÍê³ÉÈÎÎñ
--2byte:²¶×½ºµ¹êµÄ¸öÊı;3byte:²¶×½ÌìÎâµÄ¸öÊı£»4£ºÁÔÉ±ÌìÎâµÄ¸öÊı
hanguiID = 24        --ºµ¹êID
tianwuID = 16        --ÌìÎâID
---------Àë¼äÖ®¼Æ-----------
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

---------------------±³ºóÖ÷Ä±-----------------
PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex
---------------------±³ºóÖ÷Ä±------------------

---------------------Áé³èÖ®Ô¸-----------------
Task_lingchong = 1395 -- 1byte: 1:½ÓÁé³èÖ®Ô¸ÈÎÎñ£»2:³èÎïĞéÈõ×´Ì¬ 3£ºÍê³ÉÈÎÎñ
-- 2byte: 1£ºÁé³èÖ®Ô¸Ö®³èÎïĞéÈõ£»2£ºÁé³èÖ®Ô¸Ö®³èÎï»Ö¸´
-- 3byte: 1:½Ó¹ıÁé³èÖ®Ô¸ÈÎÎñ£»2£ºÂòÁËµ°£»3£º´øµ°Íæ¹»24Ğ¡Ê±£»
---------------------Áé³èÖ®Ô¸-----------------

--Add by guoqun for ÒÂ²§Ïà´« at 2009/11/26 begin --

Task_Partner = 1657 -- »ï°éÍæ¼ÒµÄNameID
Task_YiboProcess = 1658 -- 1Byte:1Ñ°ÕÒÊ¦¾­ÉÏÏÂÆª 2ÕÒµ½Ê¦¾­ÉÏÏÂÆª 3ÒÑ°ÑÊé½»¸øÁË»ÆÌì»¯ 4½Óµ½ÁÔÉ±Êé»êÈÎÎñ 5Êé»êÒÑ¾­ÊÍ·Å 6ÁÔÉ±³É¹¦ 7ÈÎÎñÍê³É 8ÈÎÎñÊ§°Ü
-- 2Byte:Ê¦¾­ÀàĞÍ/°çÑİ½ÇÉ« 1ÉÏÆª(Ê¦) 2ÏÂÆª(Í½)
-- 3Byte:1µ±Íæ¼Òµ½ÁË¿ªÆôËÄ¼¶Ê¦ÃÅÈÎÎñÌõ¼şÊ±£¬ÒÑ¾­¸øÍæ¼Ò·¢ÁËÌáĞÑÓÊ¼ş

Hunt_Buff = 1243       --´Ëbuff´æÔÚÊ±¼äÍ¬¹ÖÎï´æÔÚÊ±¼äÏàÍ¬ ,buffÏûÊ§ÒÔºó£¬ÔòÈÎÎñÊ§°Ü
Debuff_ID = 1244

Task_ChushiState = 1008 --±ê¼ÇÊÇ·ñÒÑ¾­³öÊ¦£¬´ËÈÎÎñ±äÁ¿ÔçÒÑ±»Ê¹ÓÃ~²»ÓÃÖØĞÂÉêÇë

Task_FourShimen = 1660  --1Byte:ÔİÇÒÓÃÀ´±ê¼ÇËÄ¼¶Ê¦ÃÅÊÇ·ñ¿ªÆô 0£ºÎ´¿ªÆô 1£ºÒÑ¿ªÆô

Betrayal_Master_Time = 1659 --2Word:±³ÅÑÊ¦ÃÅµÄÊ±¼ä
--1Word:´´½¨ÒÂ²§¹ØÏµÊ±µÄÊ±¼ä£¨ÌìÊı£©

YiboItem = {
    [1] = { name = "S­ Kinh th­îng-TÇm Phï", Item = { 4, 310, 0, 1, 0, 0 } },
    [2] = { name = "S­ Kinh h¹-TÇm Phï", Item = { 4, 311, 0, 1, 0, 0 } },
    [3] = { name = "S­ Kinh th­îng", Item = { 4, 301, 0, 1, 0, 0 } },
    [4] = { name = "S­ Kinh h¹", Item = { 4, 302, 0, 1, 0, 0 } },
    [5] = { name = "S­ Kinh", Item = { 6, 1, 798, 1, 0, 0 } },
    [6] = { name = "D©y Khæn Tiªn", Item = { 6, 1, 792, 0, 0, 0 } },
    [7] = { name = "S­ ¢n LÖnh", Item = { 3, 1088, 0, 0, 0, 0 } }
}

--Add by guoqun for ÒÂ²§Ïà´« at 2009/11/26 end --

-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
Card_Item = {
    [1] = { 8, 1316, 6, "ThÎ Kim DËt" },
    [2] = { 8, 1317, 2, "ThÎ Cµo" },
}
-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End

IBItemIndex = {
    { name = "Thiªn Tiªn thñy", IBItemIndex = 26 }
}


-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä;
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ĞòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ğÍê£©; 4th byte µÚ¶ş¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈı¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ğÌâÊıÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ----------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼şÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØĞ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end------------------


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

    --³õÏÖ¶ËÄß
    startLevel = 30
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        local info = GetTaskByte(Task_Variety_Process, 2)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (step == 0 and info == 1) then
                state = 1
                subState = 0
            elseif (step == 2 and GetLevel() >= 31 and info == 1) then
                state = 3
                subState = 0
            elseif (step == 4 and GetLevel() >= 31 and info == 1) then
                state = 3
                subState = 0
            elseif (step >= 1 and step < 2) and (info == 1) then
                state = 2
                subState = 0
            elseif (step >= 3 and step < 4) and (info == 1) then
                state = 2
                subState = 0
            end
        else
            if (step == 0 and info == 1) then
                state = 1
                subState = 1
            elseif (step == 2 and GetLevel() >= 31 and info == 1) then
                state = 3
                subState = 1
            elseif (step == 4 and GetLevel() >= 31 and info == 1) then
                state = 3
                subState = 1
            elseif (step >= 1 and step < 2) and (info == 1) then
                state = 2
                subState = 0
            elseif (step >= 3 and step < 4) and (info == 1) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Àë¼äÖ®¼Æ
    startLevel = 33
    if (GetLevel() >= startLevel) then
        local process = GetTaskByte(Task_Mischief, 1)
        local hanguiNum = GetTaskByte(Task_Mischief, 2)
        local tianwuNum = GetTaskByte(Task_Mischief, 3)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (process == 0) then
                state = 1
                subState = 0
            elseif (process == 2) then
                state = 3
                subState = 0
            elseif (process == 1 and hanguiNum == 5 and tianwuNum == 5) then
                state = 3
                subState = 0
            elseif (process == 4 and GetTaskByte(Task_Mischief, 4) == 30) then
                state = 3
                subState = 0
            elseif (process == 3 and GetMorphType() == 16) then
                state = 2
                subState = 0
            elseif (process == 1) then
                state = 2
                subState = 0
            end
        else
            if (process == 0) then
                state = 1
                subState = 1
            elseif (process == 2) then
                state = 3
                subState = 1
            elseif (process == 1 and hanguiNum == 5 and tianwuNum == 5) then
                state = 3
                subState = 1
            elseif (process == 4 and GetTaskByte(Task_Mischief, 4) == 30) then
                state = 3
                subState = 1
            elseif (process == 3 and GetMorphType() == 16) then
                state = 2
                subState = 0
            elseif (process == 1) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÈıÓãÖ®ÂÒ
    startLevel = 36
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        local info = GetTaskByte(Task_Variety_Process, 2)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (step == 5 and info == 2 and GetLevel() >= 36) then
                state = 1
                subState = 0
            elseif (step == 10 and info == 2 and GetLevel() >= 36) then
                state = 3
                subState = 0
            elseif (step >= 6 and step <= 9 and GetLevel() >= 36 and info == 2) then
                state = 2
                subState = 0
            end
        else
            if (step == 5 and info == 2 and GetLevel() >= 36) then
                state = 1
                subState = 1
            elseif (step == 10 and info == 2 and GetLevel() >= 36) then
                state = 3
                subState = 1
            elseif (step >= 6 and step <= 9 and GetLevel() >= 36 and info == 2) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --»ğÀë¾«ÆÇ
    startLevel = 41
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        local info = GetTaskByte(Task_Variety_Process, 2)
        if (GetLevel() - startLevel <= 5) then
            if (info == 3 and step == 11) then
                state = 1
                subState = 0
            elseif (info == 3 and step == 15) then
                state = 3
                subState = 0
            elseif ((info == 3) and ((step > 11 and step <= 14) or (step == 30))) then
                state = 2
                subState = 0

            end
        else
            if (info == 3 and step == 11) then
                state = 1
                subState = 1
            elseif (info == 3 and step == 15) then
                state = 3
                subState = 1
            elseif ((info == 3) and ((step > 11 and step <= 14) or (step == 30))) then
                state = 2
                subState = 0

            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ğÑÛÉñİº
    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 21) then
                state = 3
                subState = 0
            elseif (taskProcess == 24) then
                state = 3
                subState = 0
            elseif (taskProcess >= 23) and (taskProcess < 24) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 21) then
                state = 3
                subState = 1
            elseif (taskProcess == 24) then
                state = 3
                subState = 1
            elseif (taskProcess >= 23) and (taskProcess < 24) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --±³ºóÖ÷Ä±
    startLevel = 46
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        local info = GetTaskByte(Task_Variety_Process, 2)
        if (GetLevel() - startLevel <= 5) then
            if (info == 4 and step == 16) then
                state = 1
                subState = 0
            elseif (info == 4 and step == 22) then
                state = 3
                subState = 0
            elseif (info == 4 and step >= 17 and step <= 21) then
                state = 2
                subState = 0
            end
        else
            if (info == 4 and step == 16) then
                state = 1
                subState = 1
            elseif (info == 4 and step == 22) then
                state = 3
                subState = 1
            elseif (info == 4 and step >= 17 and step <= 21) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --±³ºóÖ÷Ä±
    startLevel = 47
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        local info = GetTaskByte(Task_Variety_Process, 2)
        if (GetLevel() - startLevel <= 5) then
            if (info == 4 and step == 23 and GetLevel() >= 47) then
                state = 1
                subState = 0
            elseif (info == 4 and step == 26 and GetLevel() >= 47) then
                state = 3
                subState = 0
            elseif (GetLevel() >= 47 and step >= 24 and step < 26) then
                state = 2
                subState = 0
            end
        else
            if (info == 4 and step == 23 and GetLevel() >= 47) then
                state = 1
                subState = 1
            elseif (info == 4 and step == 26 and GetLevel() >= 47) then
                state = 3
                subState = 1
            elseif (GetLevel() >= 47 and step >= 24 and step < 26) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30

    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (((floor(LocalSystemTime() / 86400) > GetTask(315) and GetTask(314) == 0) or (GetTask(916) == 0 and GetTaskByte(317, 2) == 0 and GetTaskByte(317, 1) < 3)) and GetTask(314) == 0) then
                state = 1
                subState = 0
            elseif (GetTask(314) == 100 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            elseif (GetTask(916) == 0 and GetTaskByte(317, 2) == 0 and GetTask(314) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if (((floor(LocalSystemTime() / 86400) > GetTask(315) and GetTask(314) == 0) or (GetTask(916) == 0 and GetTaskByte(317, 2) == 0 and GetTaskByte(317, 1) < 3)) and GetTask(314) == 0) then
                state = 1
                subState = 1
            elseif (GetTask(314) == 100 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 1
            elseif (GetTask(916) == 0 and GetTaskByte(317, 2) == 0 and GetTask(314) ~= 0) then
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    local citanStr = "Th¸m qu©n"

    if (GetLevel() >= 100) and (GetTask(1026) >= 400) then
        citanStr = "<c=pk>NhiÖm vô Th¸m qu©n<c>"
    elseif (GetLevel() >= 70) and (GetTask(1026) >= 150) then
        citanStr = "<c=g>NhiÖm vô Th¸m qu©n<c>"
    end
    tasks = {
        { "ThÇn Oanh", "renwu1"; show = 0 },
        { citanStr, "renwu2"; show = 0 },
        { "Hiªn Viªn Thİ luyÖn", "shitu_1"; show = 0 },
        { "Hñy bá nhiÖm vô Hiªn Viªn Thİ luyÖn", "shitu_1_cancel"; show = 0 },
        { "Hoµn thµnh nhiÖm vô Hiªn Viªn Thİ LuyÖn", "shitu_1"; show = 0 },
        { "KÕ Ly Gi¸n", "misChief"; show = 0 },
        { "S¬ HiÖn §oan Nghª", "detectClue"; show = 0 },
        { "Lo¹n tam ng­", "fishBane"; show = 0 },
        { "Háa Ly Tinh Ph¸ch", "fireSoul"; show = 0 },
        { "KÎ Chñ m­u", "conspiracy"; show = 0 },
        { "Y B¸t T TruyÒn", "Do_HighShimen"; show = 1 },

        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end
    }
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (GetLevel() >= 45) and (UTask_Wizard == 24) then
        tasks[1].show = 1
    end ;
    if (GetLevel() >= 45) and (UTask_Wizard == 21) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 30) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() > 35) and (GetLevel() <= 50) and (GetTask(901) <= 7) then
        --®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
        tasks[3].show = 1;
    end ;
    if (GetLevel() > 50) then
        if (GetTask(901) ~= 0) and (GetTask(901) < 6) then
            tasks[4].show = 1
        elseif (GetTask(901) == 6) then
            tasks[5].show = 1
        end
    end ;
    if (GetLevel() >= 33 and GetTaskByte(Task_Mischief, 1) < 5) then
        tasks[6].show = 1
    end
    -------------Add by Gaojingwei at 2009/04/16 begin---------------
    local taskStep = GetTaskByte(Task_Variety_Process, 1)
    local info = GetTaskByte(Task_Variety_Process, 2)
    if (info == 1) then
        if (taskStep >= 0 and taskStep <= 1 and GetLevel() >= 30) or (taskStep >= 2 and taskStep <= 4 and GetLevel() >= 31) then
            tasks[7].show = 1
        end
    elseif (info == 2) then
        if (taskStep >= 5 and taskStep <= 10 and GetLevel() >= 36) then
            tasks[8].show = 1
        end
        if (taskStep > 11 and taskStep < 16 and GetLevel() >= 41) then
            SetTaskByte(Task_Variety_Process, 2, 3)
            tasks[9].show = 1
        end
    elseif (info == 3) then
        if (taskStep >= 11 and taskStep < 16 and GetLevel() >= 41) then
            tasks[9].show = 1
        end
    elseif (info == 4) then
        if (taskStep >= 16 and GetLevel() >= 46 and taskStep < 23) or (taskStep >= 23 and taskStep <= 26 and GetLevel() >= 47) then
            tasks[10].show = 1
        end
    end
    -------------Add by Gaojingwei at 2009/04/16 end----------------

    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
    --~                     local year, month, day = GetYMD();
    --~                     local hour, min, second = GetHMS();
    --~                     local today = mod(floor(LocalSystemTime()/86400), 255) + 1;

    --~                     local TaskStep = GetTaskByte(TASK_ThreeYears_Fireworks, 1);
    --~                     local TaskTime = GetTaskByte(TASK_ThreeYears_Fireworks, 2);
    --~
    --~                     --Çå¿ÕÖ®Ç°µÄÈÎÎñ£¬ÒÔ·ÀbuffendÎ´Ö´ĞĞ
    --~                     if (TaskTime > 0 and TaskTime ~= today) then
    --~                         TaskStep = 0;
    --~                         TaskTime = 0;
    --~                         SetTask(TASK_ThreeYears_Fireworks, 0);
    --~                         SetTask(TASK_ThreeYears_Questions, 0);
    --~                     end
    --~
    --~                      if (year == 2010 and month == 8 and day == 30
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[12].show = 1;
    --~                     end
    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    SayTask(10061, tasks)
end;

-- Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 begin --
function Do_HighShimen()
    tasks = {
        { "Y B¸t T TruyÒn", "Do_Yibo"; show = 0 },
        { "Hñy nhiÖm vô", "Cancel_Yibo"; show = 0 },
    }

    if (GetLevel() >= 90) then
        tasks[1].show = 1
    end

    local nStep = GetTaskByte(Task_YiboProcess, 1)
    local teamState = Match_TeamMember()

    local str = " Anh hïng ®· huÊn luyÖn v« sè ®Ö tö tµi ba! Ngoµi nh÷ng ®Ö tö th«ng th­êng, anh hïng cã nghÜ ®Õn viÖc tiÕp nhËn 1 ng­êi Y B¸t ®Ö tö tiÕp nèi sù nghiÖp cña m×nh ch­a?"
    if (nStep > 0 and nStep ~= 6 or (teamState ~= 1 and nStep == 6)) then
        --ÈÎÎñÍê³É£¬µ«ÊÇ×é¶Ó²»ÕıÈ·£¬Íæ¼Ò¿ÉÒÔ·ÅÆúÈÎÎñ£¬ÓëÁíÒ»¸öÍæ¼ÒÈ¥×öÈÎÎñ
        if (teamState == 11 and nStep == 6) then
            str = " §ång ®éi cña ng­¬i kh«ng trong khu vùc nµy, hai ng­êi ph¶i trong cïng 1 khu vùc míi cã thÓ tiÕn hµnh nhiÖm vô!"
        else
            tasks[2].show = 1
        end
    end

    if GetTaskByte(Task_YiboProcess, 2) == 2 then
        --¶ÔÍ½µÜÆÁ±Î°´Å¥,¶ÔÈÎÎñÊ§°ÜµÄÈËÒ²ÆÁ±Î
        tasks[1].show = 0
    end

    if GetTaskByte(Task_YiboProcess, 1) == 8 then
        tasks[1].show = 0
        str = " NhiÖm vô Y B¸t T­¬ng TruyÒn thÊt b¹i, xin hñy nhiÖm vô nµy ®i sau ®ã nhËn l¹i!"
    end

    SayTask(str, tasks)
end

function Do_Yibo()
    CloseDialog()
    local nProcess = GetTaskByte(Task_YiboProcess, 1)

    if (IsMantleMaster(PlayerIndex) == 0 and IsMantlePrentice(PlayerIndex) == 0) then
        --Íæ¼ÒÉíÉÏÃ»ÓĞÒÂ²§¹ØÏµ
        if (nProcess == 0) then
            if ((floor(LocalSystemTime() / 86400) - GetTaskWord(Betrayal_Master_Time, 1)) >= 1) then
                if (GetLevel() >= 90 and GetFactionGlory() >= 230) then
                    -- Âú90¼¶²¢ÇÒ Ê¦Í½µãµ½´ï230ÒÔÉÏµÄ »òÕßÒÑ¾­½ÓÁËÕâ¸öÈÎÎñ »òÕß Íæ¼ÒÒÑ¾­¿ªÆôÁËËÄ¼¶Ê¦ÃÅ
                    local teamState = Get_TeamState()
                    if (teamState == 1) then
                        MsgBox(" S­ phô ta trong thêi gian h¹ giíi ®· viÕt ra hai quyÓn <c=yel>S­ Kinh<c>, gåm quyÓn th­îng vµ h¹, ®· thÊt l¹c t¹i 2 n¬i ë nh©n gian. Muèn thu nhËn Y B¸t ®Ö tö, nhÊt ®Şnh ph¶i t×m l¹i gióp ta S­ Kinh tr­íc!", "Yes_DoFindShijing", "no")
                    elseif (teamState == 2) then
                        InfoBox(" NÕu ng­¬i muèn thu nhËn Y B¸t ®Ö tö, xin cïng víi ®Ö tö ®­îc chän tæ ®éi cïng ®Õn gÆp ta. Sau khi th«ng qua kh¶o nghiÖm cña ta th× míi cã thÓ hoµn tÊt t©m nguyÖn. Chó ı: ChØ cã ®Ö tö xuÊt s­ ®¼ng cÊp trong kho¶ng <c=g>50-80<c> míi cã thÓ ®­îc thu nhËn lµ Y B¸t ®Ö tö.")
                    elseif (teamState == 5) then
                        InfoBox(" §ång ®éi cña ng­¬i kh«ng hîp ®iÒu kiÖn! Ph¶i lµ ®Ö tö trong kho¶ng ®¼ng cÊp 50-cÊp 80 vµ ch­a ph¶i lµ Y B¸t ®Ö tö cña ng­êi kh¸c, míi cã thÓ cïng ng­¬i hoµn thµnh nhiÖm vô nµy.")
                    elseif (teamState == 6) then
                        InfoBox(" §ång ®éi cña ng­¬i ®· cã Y B¸t S­ Phô råi!")
                    elseif (teamState == 7) then
                        InfoBox(" Ng­¬i ®· cã Y B¸t ®Ö tö råi, nÕu muèn thu nhËn ng­êi ch¬i nµy lµ Y B¸t ®Ö tö, ph¶i gi¶i trõ quan hÖ Y B¸t víi ®Ö tö tr­íc!")
                    elseif (teamState == 8) then
                        InfoBox(" §ång ®éi cña ng­¬i ®ang cïng ng­êi kh¸c tiÕn hµnh nhiÖm vô Y B¸t T­¬ng TruyÒn! NÕu muèn b¸i ng­¬i lµ Y B¸t S­ Phô, ng­êi nµy cÇn ph¶i hñy bá nhiÖm vô ®ang tiÕn hµnh!")
                    elseif (teamState == 9) then
                        InfoBox(" §ång ®éi cña ng­¬i ch­a xuÊt s­, ph¶i xuÊt s­ råi míi cã thÓ cïng ng­¬i thùc hiÖn nhiÖm vô nµy!")
                    elseif (teamState == 10) then
                        InfoBox(" §ång ®éi cña ng­¬i míi ph¶n s­ m«n ch­a ®ñ 7 ngµy, ch­a thÓ b¸i ng­¬i lµm s­ phô míi!")
                    elseif (teamState == 11) then
                        InfoBox(" §ång ®éi cña ng­¬i kh«ng ë TriÒu Ca!")
                    elseif (teamState == 12) then
                        InfoBox(" §ång ®éi cña ng­¬i h«m nay ®· b¸i 1 Y B¸t S­ Phô råi. §©y lµ viÖc ®¹i sù, h«m nay t¹m thêi ch­a thÓ gióp hai ng­êi cö hµnh nghi thøc b¸i s­ ®­îc!")
                    elseif (teamState == 13) then
                        InfoBox(" Tù m×nh sao cã thÓ b¸i m×nh lµm s­ phô ®­îc chø!")
                        Msg2Player("Hai ng­êi ch¬i trªn cïng mét IP kh«ng thÓ kÕt thµnh quan hÖ Y B¸t")
                    end
                else
                    InfoBox(" Ng­¬i mÆc dï ®· cã danh tiÕng trong thiªn h¹, nh­ng danh väng s­ m«n vÉn ch­a ®ñ ®Ó cã thÓ thu nhËn Y B¸t ®Ö tö. §îi khi danh väng s­ m«n v­ît h¬n 95% Danh §éng NhÊt Ph­¬ng råi quay l¹i gÆp ta nhĞ!")
                end
            else
                InfoBox(" Ng­¬i h«m nay ®· thu nhËn 1 Y B¸t ®Ö tö råi. Thu nhËn Y B¸t ®Ö tö lµ chuyÖn ®¹i sù, h«m nay kh«ng nªn thu nhËn thªm Y B¸t ®Ö tö kh¸c n÷a!")
            end
        else
            local teamState = Match_TeamMember()
            if (teamState == 1) then
                if (nProcess == 1) then
                    InfoBox(" Mau ®i t×m 2 phÇn cña S­ Kinh ®i!")
                elseif (nProcess == 2) then
                    local bMaster, bApperen, mateIdx = Have_BookBoth()
                    if (bMaster > 0 and bApperen > 0) then
                        MsgBox(" S­ Kinh ®· bŞ s­ gia §¹o §øc Ch©n Qu©n chó nhËp mét lo¹i ph¸p lùc, cÇn cã c¸c ng­¬i gióp ta gi¶i trõ ph¸p lùc nµy th× míi xem ®­îc nh÷ng néi dung ¶o diÖu trong ®ã. Gia s­ tõng nãi trong S­ Kinh cã phong Ên 1 Th­ Hån rÊt hung d÷. Anh hïng xin gióp ta ®¸nh b¹i Th­ Hån nµy tr­íc!", "Yes_HelpHim", "no")
                    elseif (bMaster == 0 and bApperen == 0) then
                        InfoBox("Ph¶i t×m ®ñ hai quyÓn Th­îng vµ h¹, míi cã thÓ hîp thµnh S­ Kinh hoµn chØnh.")
                    elseif (bMaster == 0) then
                        InfoBox(" Ng­¬i kh«ng cã S­ Kinh-Th­îng! Ph¶i cã ®ñ 2 quyÓn th­îng h¹ míi cã thÓ hîp thµnh S­ Kinh hoµn chØnh.")
                    else
                        InfoBox("§ång ®éi ng­¬i ch­a lÊy ®­îc S­ Kinh-H¹! Ph¶i cã ®ñ 2 quyÓn th­îng h¹ míi cã thÓ hîp thµnh S­ Kinh hoµn chØnh.")
                    end
                elseif (nProcess == 4) then
                    InfoBox(" Xin mau chãng ®Õn Môc D· ®¸nh b¹i Th­ Hån bŞ S­ Kinh phong Ên!")
                elseif (nProcess == 5) then
                    if (HaveIBBuff(Hunt_Buff) ~= 0) then
                        --¹ÖÎïÃ»ÓĞÏûÊ§
                        InfoBox(" Th­ Hån ®· ®­îc th¶ ra, anh hïng h·y tranh thñ thêi gian.")
                    else
                        Msg2Player("NhiÖm vô Y B¸t T­¬ng TruyÒn thÊt b¹i, b¹n cã thÓ ®Õn gÆp Hoµng Thiªn Hãa nhËn l¹i nhiÖm vô!")
                        TeamAction("Cancel_Yibo", 0, 0, 0)
                    end
                elseif (nProcess == 6) then
                    Finish_YiboTask()
                end
            elseif (teamState == 2) then
                InfoBox(" Ph¶i cã 2 ng­êi tæ ®éi míi cã thÓ tiÕn hµnh nhiÖm vô nµy!")
            elseif (teamState == 3) then
                InfoBox(" §ång ®éi cña ng­¬i ®· hñy nhiÖm vô, nÕu ng­¬i vÉn muèn tiÕp tôc, xin hñy nhiÖm vô sau ®ã lËp tæ ®éi míi råi ®Õn t×m ta!")
            elseif (teamState == 4) then
                InfoBox(" H·y mêi ng­êi ®· cïng ng­¬i tæ ®éi nhËn nhiÖm vô ®Õn ®©y gÆp ta.")
            elseif (teamState == 5) then
                InfoBox(" §ång ®éi cña ng­¬i kh«ng ë trong TriÒu Ca!")
            elseif (teamState == 6) then
                InfoBox(" Tù m×nh sao cã thÓ b¸i m×nh lµm s­ phô ®­îc chø!")
                Msg2Player("Hai ng­êi ch¬i trªn cïng mét IP kh«ng thÓ kÕt thµnh quan hÖ Y B¸t")
            end
        end
    else
        InfoBox(" Ng­¬i ®· cã quan hÖ Y B¸t!")
    end
end

function Have_BookBoth()
    --ÅĞ¶ÏÁ½ÈËÊÇ·ñ¶¼ÓĞÊé ·µ»ØÖµËµÃ÷£ºp1:Ê¦¸¸ÊÇ·ñÓĞÊé p2£ºÍ½µÜÊÇ·ñÓĞÊé£¬p3:mateIdx

    local firstBook = YiboItem[3].Item
    local secondBook = YiboItem[4].Item

    local bMaster = HaveNormalItem(firstBook[1], firstBook[2], firstBook[3], firstBook[4])

    local mateIdx = 0
    local selfIdx = PlayerIndex
    if (IsCaptain() == 0) then
        mateIdx = GetTeamMember(1)
    else
        mateIdx = GetTeamMember(2)
    end
    PlayerIndex = mateIdx
    local bApperen = HaveNormalItem(secondBook[1], secondBook[2], secondBook[3], secondBook[4])
    PlayerIndex = selfIdx
    return bMaster, bApperen, mateIdx
end

function Match_TeamMember()
    --·µ»ØÖµ£º1OK 2×é¶ÓÈËÊı²»¶Ô 3¶ÓÓÑ·ÅÆúÁËÈÎÎñ 4Á½ÈË¶ÓÎéÈË²»¶Ô 5Í½µÜ²»ÔÚ³¯¸è 6Í¬Ì¨»úÆ÷Á½¸öÕËºÅ
    if (GetTeamSize() ~= 2) then
        return 2
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) == Get_MateUUID()) then
        -- ¶Ô·½ÒÑ¾­·ÅÆúÈÎÎñ
        return 3
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) ~= Get_MateUUID()) then
        -- ´íÎóµÄÁ½¸öÈË×é¶Ó
        return 4
    end

    local mateIdx = 0
    local selfIdx = PlayerIndex
    if (IsCaptain() == 0) then
        mateIdx = GetTeamMember(1)
    else
        mateIdx = GetTeamMember(2)
    end
    PlayerIndex = mateIdx
    local mapid, x, y = GetWorldPos()
    local mateIP = GetIP()
    local mateMac = GetMAC()
    PlayerIndex = selfIdx

    if (mapid ~= 21) then
        return 5
    end

    if (mateIP == GetIP() and mateMac == GetMAC()) then
        return 6
    end

    return 1
end

function Get_TeamState()
    --·µ»ØÖµ 1ÕıÈ·  2×é¶ÓÈËÊı²»¶Ô
    --3¶ÓÓÑ·ÅÆúÁËÈÎÎñ 4Á½ÈË¶ÓÎéÈË²»¶Ô
    --5¶ÓÓÑµÄ¼¶±ğ²»Âú×ãÌõ¼ş 6¶ÓÓÑÒÑ¾­°İÁËÒÂ²§Ê¦¸¸
    --7ÒÑ¾­ÊÕÁËÒÂ²§µÜ×Ó 8¶ÓÓÑÒÑ¾­ÔÚ±ğÈËÈÎÎñµ±ÖĞ
    --9¶ÓÓÑ»¹Ã»ÓĞ³öÊ¦ 10ÅÑÀëÊ¦ÃÅÊ±¼äÎ´¹ıÆßÌì
    --11¶ÓÓÑ²»ÔÚµ±Ç°µØÍ¼ 12¶ÓÓÑÔÚÒ»ÌìÖ®ÄÚÒÑ¾­Íê³É¹ıÒ»´ÎÒÂ²§Ïà´«ÈÎÎñ
    --13Í¬Ò»Ì¨»úÆ÷ÉÏÃæ2¸öÕËºÅ

    if (GetTeamSize() ~= 2) then
        return 2
    end

    local process = GetTaskByte(Task_YiboProcess, 1)

    if (process == 0) then
        local mateIdx = Get_MatePlayerIndex()
        local selfIdx = PlayerIndex

        PlayerIndex = mateIdx
        local nLevel = GetLevel()
        PlayerIndex = selfIdx

        if (nLevel > 80 or nLevel <= 50) then
            return 5
        end

        PlayerIndex = mateIdx
        if (IsMantleMaster(PlayerIndex) == 1 or IsMantlePrentice(PlayerIndex) == 1) then
            --Íæ¼ÒÉíÉÏÓĞÒÂ²§¹ØÏµ
            PlayerIndex = selfIdx
            return 6
        end

        PlayerIndex = selfIdx
        if (GetMateTask(Task_Partner) ~= 0) then
            return 8
        end

        if (GetMateTask(Task_ChushiState) == 0) then
            return 9
        end

        PlayerIndex = mateIdx
        local nDays = floor(LocalSystemTime() / 86400) - GetTaskWord(Betrayal_Master_Time, 2)
        local mapid, x, y = GetWorldPos()
        local nDays2 = floor(LocalSystemTime() / 86400) - GetTaskWord(Betrayal_Master_Time, 1)
        local mateIP = GetIP()
        local mateMac = GetMAC()
        PlayerIndex = selfIdx

        if (nDays <= 7) then
            return 10
        end

        if mapid ~= 21 then
            return 11
        end

        if nDays2 == 0 then
            return 12
        end

        if (mateIP == GetIP() and mateMac == GetMAC()) then
            return 13
        end

    else
        if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) == Get_MateUUID()) then
            -- ¶Ô·½ÒÑ¾­·ÅÆúÈÎÎñ
            return 3
        end
        if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) ~= Get_MateUUID()) then
            -- ´íÎóµÄÁ½¸öÈË×é¶Ó
            return 4
        end
    end

    return 1
end

function Yes_DoFindShijing()
    CloseDialog()
    if (GetTeamSize() == 2) then
        local mateIdx = Get_MatePlayerIndex()
        local self = PlayerIndex
        PlayerIndex = mateIdx
        local nLevel = GetLevel()

        PlayerIndex = self
        if (nLevel > 50 and nLevel < 80) then
            Clear_TaskValue()

            SetTask(Task_Partner, Get_MateUUID())
            local item = YiboItem[1].Item
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
            CloseDialog()
            InfoBox(" §©y lµ <c=g>S­ Kinh-Th­îng TÇm Phï<c>, h·y ®Õn <c=yel>T©y Kú<c> t×m <c=g>NhËm ®¹i ca<c> cã thÓ cã manh mèi! Ng­¬i cã thÓ tù ®i mét m×nh, ®îi ®ång ®éi t×m ®­îc quyÓn h¹ råi giao cho ta mét thÓ!")
            Msg2Player("B¹n nhËn ®­îc S­ Kinh-Th­îng TÇm Phï")
            SetTaskByte(Task_YiboProcess, 1, 1)
            SetTaskByte(Task_YiboProcess, 2, 1)
            TaskNote(1515, 0, "NhËm §¹i Ca", "S­ Kinh th­îng")

            PlayerIndex = mateIdx
            CloseDialog()

            local task1 = GetTaskWord(1660)
            local task2 = GetTask(1664)
            Clear_TaskValue()
            SetTaskWord(1660, 2, task1)
            SetTask(1664, task2)

            SetTask(Task_Partner, Get_MateUUID())
            InfoBox(" §©y lµ <c=g>S­ Kinh-H¹ TÇm Phï<c>, h·y ®Õn <c=yel>Diªu Tr×<c> t×m <c=g>TrÊn Nguyªn §¹i Tiªn<c> cã thÓ cã manh mèi! Ng­¬i cã thÓ tù ®i mét m×nh, ®îi ®ång ®éi t×m ®­îc quyÓn th­îng råi giao cho ta mét thÓ!")
            item = YiboItem[2].Item
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
            Msg2Player("B¹n nhËn ®­îc S­ Kinh-H¹ TÇm Phï")
            SetTaskByte(Task_YiboProcess, 1, 1)
            SetTaskByte(Task_YiboProcess, 2, 2)
            TaskNote(1515, 0, "TrÊn Nguyªn", "S­ Kinh h¹")
            PlayerIndex = self
        else
            Talk(1, "no", " Ng­¬i chØ cã thÓ thu nhËn ng­êi ch¬i tõ cÊp 50- 80 lµm Y B¸t ®Ö tö, ®ång ®éi hiÖn t¹i cña ng­¬i kh«ng phï hîp yªu cÇu.")
        end
    else
        Talk(1, "no", " Mét ng­êi kh«ng thÓ nµo t×m ®­îc S­ Kinh, h·y mêi ng­êi ng­¬i hy väng trë thµnh Y B¸t ®Ö tö cïng ®Õn ®©y.")
    end
end

function Clear_TaskValue()
    --Çå¿ÕËùÓĞÓëÒÂ²§¹ØÏµÏà¹ØµÄÈÎÎñ±äÁ¿ÒÔ¼°ÈÎÎñÌáÊ¾
    local forthShimen = GetTaskByte(1660, 1)
    for i = 1657, 1668 do
        SetTask(i, 0)
    end

    for i = 1516, 1521 do
        TaskNote(i, -1)
    end

    for i = 1239, 1246 do
        RemoveIBBuff(i)
    end

    SetTask(1670, 0)
    SetTask(1671, 0)

    SetTaskByte(1660, 1, forthShimen)
end

function Yes_HelpHim()
    CloseDialog()

    local newIndex = Get_MatePlayerIndex()
    local oldIndex = PlayerIndex
    local item = YiboItem[5].Item
    SetTaskByte(Task_YiboProcess, 1, 4)
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])

    local firstBook = YiboItem[3].Item
    ClearItem(firstBook[1], firstBook[2], firstBook[3], firstBook[4])
    Talk(1, "no", " §©y lµ S­ Kinh cña gia s­ ta! Gia s­ tõng nãi ph¶i ®Õn Môc D· míi cã thÓ th¶ ra Yªu Hån trong S­ Kinh. Cßn n÷a, ta ®· giao cho ®ång ®éi cña ng­¬i 1 D©y Khæn Tiªn, khi bŞ o¸n khİ cña Th­ Hån khèng chÕ, ®ång ®éi cã thÓ dïng d©y nµy ®Ó gi¶i trõ tr¹ng th¸i!")

    Msg2Player("NhËn ®­îc S­ Kinh, cã thÓ ®Õn Môc D· th¶ Th­ Hån!")
    TaskNote(1515, 2)

    PlayerIndex = newIndex
    item = YiboItem[6].Item
    SetTaskByte(Task_YiboProcess, 1, 4)
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])

    local secondBook = YiboItem[4].Item
    ClearItem(secondBook[1], secondBook[2], secondBook[3], secondBook[4])
    Talk(1, "no", " S­ Kinh ®· giao cho ®ång ®éi cña ng­¬i råi! Gia s­ tõng nãi ph¶i ®Õn Môc D· míi cã thÓ th¶ ra Yªu Hån trong S­ Kinh. §©y lµ D©y Khæn Tiªn, khi bŞ o¸n khİ cña Th­ Hån khèng chÕ, cã thÓ dïng d©y nµy ®Ó gi¶i trõ tr¹ng th¸i!")

    Msg2Player("NhËn ®­îc D©y Khæn Tiªn, mau hiÖp trî ®ång ®éi cña b¹n hoµn thµnh nhiÖm vô!")
    TaskNote(1515, 2)
    PlayerIndex = oldIndex
end

function Get_YiboTask_T()
    Talk(1, "no", " Gia s­ §¹o §øc Ch©n Qu©n trong thêi gian h¹ giíi l­u l¹i ë T©y Kú vµ Diªu Tr× l©u nhÊt, nghe nãi NhËm ®¹i ca ë T©y Kú vµ TrÊn Nguyªn §¹i Tiªn ë Diªu Tr× biÕt ®­îc n¬i S­ gia lµm thÊt l¹c S­ Kinh.")
end

function Finish_YiboTask()
    local newIndex = Get_MatePlayerIndex()
    local oldIndex = PlayerIndex

    CheckMakeMantleMaster(newIndex)
end

function Cancel_Yibo()
    CloseDialog()
    Msg2Player(" §· hñy nhiÖm vô Y B¸t T­¬ng TruyÒn ")
    TaskNote(1515, -1)
    local tep = GetTaskByte(Task_YiboProcess, 3)
    SetTask(Task_YiboProcess, 0)
    SetTaskByte(Task_YiboProcess, 3, tep)
    SetTask(Task_Partner, 0)
    RemoveIBBuff(Hunt_Buff)
    local item = 0
    for i = 1, 6 do
        item = YiboItem[i].Item
        ClearItem(item[1], item[2], item[3], item[4])
    end
end

function Get_MateUUID()
    --»ñµÃ¶ÔÓĞµÄUUID¡£µ÷ÓÃÇ°±ØĞëÏÈÅĞ¶ÏÊÇ²»ÊÇÁ½ÈË¶ÓÎé
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    PlayerIndex = mateIdx
    local mateUUID = GetPlayerID()
    PlayerIndex = selfIdx
    return mateUUID
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

function Get_TeamBuffState()
    --·µ»ØÖµ1£ºOK 2×Ô¼ºbuffÊıÄ¿Ì«¶à 3¶ÓÓÑbuffÊıÄ¿Ì«¶à 4Á½ÈËbuffÊıÄ¿Ì«¶à
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    local selfCount = GetIBBuffCount()
    PlayerIndex = mateIdx
    local mateCount = GetIBBuffCount()
    PlayerIndex = selfIdx
    if (selfCount < 32 and mateCount < 32) then
        return 1
    elseif (selfCount == 32 and mateCount == 32) then
        return 4
    elseif (selfCount == 32) then
        return 2
    else
        return 3
    end
end


-- Add By guoqun at 2009.11.26 end  --

-------------------±³ºóÖ÷Ä± Added by Laiyongcong at 2009/04/20 begin ---------

function conspiracy_yes()
    SetTaskByte(Task_Variety_Process, 1, 17)
    SetSubTask(1047, 1, 1)
    TaskNote(1046, -1)
    TaskNote(1047, 0)
    CloseDialog()
    refreshNpcTaskState()
end

function conspiracy()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step == 16) then
        MsgBox("B¨ng Linh ë ngoµi T©y Kú Nam thµnh vèn hiÒn lµnh, nh­ng gÇn ®©y l¹i xuÊt hiÖn kh¸c th­êng, ng­¬i gióp ta ®iÒu tra viÖc nµy.", "conspiracy_yes", "no")
        --Talk(1,"no","»ÆÌì»¯£ºÎ÷áªÄÏ³ÇÍâµÄ±ùÁéÔ­±¾µ¥´¿ÉÆÁ¼£¬×î½ü¾¹È»Ò²³öÏÖÁËÒì¶Ë£¬ÄãÈ¥°ïÎÒµ÷²éÒ»ÏÂ´ËÊÂ°É¡£")
        --SetTaskByte(Task_Variety_Process,1,17)
        --TaskNote(1046, -1)
        --TaskNote(1047,0)
        refreshNpcTaskState()
        return
    elseif (step == 17) then
        Talk(1, "no", "B¨ng Linh gÇn ®©y l¹i xuÊt hiÖn kh¸c th­êng, ng­¬i ®i ®iÒu tra viÖc nµy.")
        return
    elseif (step >= 18 and step < 20) then
        Talk(1, "no", "Nh÷ng B¨ng Linh nµy khã ®èi phã h¬n b×nh th­êng. §i mêi s­ thóc ta <c=g>Kh­¬ng Tö Nha<c> gióp ®ì, cã lÏ «ng cã c¸ch ph¸ gi¶i! ¤ng ®ang ë trong Phñ Vò V­¬ng ë T©y Kú.")
        return
    elseif (step == 20) then
        Talk(1, "no", "Ng­êi cã ®­îc <c=yel>B¨ng Linh gia th­<c>? Mau më xem!")
        return
    elseif (step == 21) then
        Talk(1, "no", "§i t×m Ngäc TuyÒn B¨ng Xuyªn §¹i phu cã lÏ «ng ®äc ®­îc <c=yel>B¨ng Linh gia th­<c>.")
    elseif (step == 22) then
        Talk(1, "no", "Th«ng tin ng­¬i ®em ®Õn rÊt h÷u İch, ®Ó ®a t¹ ng­¬i, ta sÏ gióp ng­¬i n©ng cao 1 phÇn n¨ng lùc. Nh­ng chuyÖn nµy l¹i liªn quan ®Õn ng­êi thÇn bİ, h¾n lµ thÇn th¸nh ph­¬ng nµo? lµm chÊn ®éng 4 ph­¬ng! ®îi ng­¬i ®Õn <c=r>cÊp 47<c> h·y ®Õn t×m ta, nhÊt ®Şnh ph¶i gióp ta t×m ra kÎ chñ m­u!")
        Msg2Player("NhËn ®­îc phÇn th­ëng 36000 kinh nghiÖm.")
        TopMessage("NhËn ®­îc phÇn th­ëng 36000 kinh nghiÖm.")

        ClearItem(6, 1, 487, 1) --É¾³ıËùÓĞµÄ±ÜÀ×·û
        ClearItem(6, 1, 488, 1) --É¾³ıËùÓĞµÄÒıÀ×·û

        AddOwnExp(36000)
        SetTaskByte(Task_Variety_Process, 1, 23)
        TaskNote(1047, 9) -- É¾³ıÈÎÎñÌáÊ¾
        ClearItem(6, 1, 489, 1)--Çå³ı±ùÁé¼ÒÊé
        RemoveIBBuff(645)
        ---É¾³ıÍæ¼ÒÉíÉÏµÄ×´Ì¬
        refreshNpcTaskState()
        return
    elseif (step == 23 and GetLevel() >= 47) then
        MsgBox("Nghe ®©u ng­êi thÇn bİ xuÊt hiÖn ë TuyÖt Long LÜnh, L¹c C¬ ë ®ã còng b¾t ®Çu g©y sù.  Sù viÖc träng ®¹i, cã lÏ lµ 1 ©m m­u kinh thiªn ®ã!", "yes_killSun", "no")
        return
    elseif (step == 24) then
        Talk(1, "no", "Xem ra ng­¬i ch­a t×m ra kÎ chñ m­u, cã lÏ L¹c C¬ biÕt chuyÖn.")
        return
    elseif (step == 25) then
        Talk(1, "no", "Th× ra kÎ chñ m­u lµ T«n L­¬ng, h¾n ®· tÈu háa nhËp ma, xe, ra chØ cã thÓ trõ khö h¾n, míi cã thÓ tr¶ cho thÕ giíi sù b×nh an.")
        return
    elseif (step == 26) then
        SetTaskByte(Task_Variety_Process, 1, 27)
        AddOwnExp(80000)
        local r = random(11, 14)
        AddNormalItem(0, 4, r, 0, 1, 0)
        Talk(1, "no", "Anh hïng ®· gióp ta ®iÒu tra ra ©m m­u ®éng trêi nµy, tr¸nh cho nh©n gian 1 kiÕp n¹n. Ta ngoµi gióp ng­êi n©ng cao chót n¨ng lùc, cßn tÆng ng­¬i Ph¸p B¶o cÊp 50 ®Ó phßng th©n!")
        Msg2Player("NhËn ®­îc 80000 kinh nghiÖm vµ Ph¸p B¶o cÊp 50")
        TopMessage("NhËn ®­îc 80000 kinh nghiÖm vµ Ph¸p B¶o cÊp 50")
        SetSubTask(1047, -1, 1)
        TaskNote(1047, -1)
        refreshNpcTaskState()
        return
    end
end

function yes_killSun()
    CloseDialog()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step == 23) then
        SetTaskByte(Task_Variety_Process, 1, 24)
        Talk(1, "no", "Thu phôc 1 sè L¹c C¬, cã lÏ sÏ t×m ra chót manh mèi.")
        Msg2Player("Hµng phôc L¹c C¬, ®iÒu tra sù viÖc ng­êi thÇn bİ TuyÖt Long LÜnh.")
        TaskNote(1047, 5)
        refreshNpcTaskState()
    end
end


-------------------±³ºóÖ÷Ä± Added by Laiyongcong at 2009/04/20 end ---------

-------------------»ğÀë¾«ÆÇ Added by Laiyongcong at 2009/04/20 begin ---------
function zhurong_yes()
    --	NewWorld(4,1550,3264) --ÅÉµ½×£ÈÚÅÔ±ß
    --	Msg2Player("Äã±»ÅÉµ½ò¿ÓÈÄ¹×£ÈÚÉíÅÔ£¬ÎÊÎÊËû°É¡£")
    TaskNote(1046, 0)
    SetSubTask(1046, 1, 1)
    TaskNote(Task_Info_Second, -1)
    SetTaskByte(Task_Variety_Process, 1, 30)
    refreshNpcTaskState()
    CloseDialog()
end

function fireSoul()
    TaskNote(Task_Info_Second, -1)
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step == 11) then
        MsgBox("<c=g>Chóc Dung<c> gÇn ®©y cã chuyÖn t×m ta, cã lÏ b¶o bèi cña h¾n mÊt råi, ng­¬i gióp ta hái h¾n thö xem.", "zhurong_yes", "no")
        return
    elseif (step == 12) then
        Talk(1, "no", " L·o Hå L« trong Hiªn Viªn ®éng cã thÓ biÕt tung tİch cña <c=yel>Háa Linh<c>! H·y thö vµo ®ã mét chuyÕn!")
        return
    elseif (step == 13) then
        Talk(1, "no", "Ly Háa tiÓu yªu kh«ng chŞu nhËn? VËy ng­¬i ®i Hiªn Viªn ®éng tÇng 1 t×m §¹i phu hái xem cã c¸ch nµo kh«ng!")
        return
    elseif (step == 14) then
        --ÉíÉÏÓĞ»ê²¯»òÕß»ğÀë¾«ÆÇ
        if (HaveNormalItem(6, 1, 486, 0) > 0) then
            Talk(1, "no", "Sö dông <c=yel>Hån B¹ch<c>, cã thÓ t×m manh mèi trªn ng­êi L·o Hå l«, ph¶i chó ı kho¶ng c¸ch víi L·o Hå l«, ®õng ®Ó chóng ph¸t hiÖn.")
        elseif (HaveNormalItem(4, 234, 1, 1) > 0) then
            Talk(1, "no", "Háa thÇn <c=g>Chóc Dung<c> cã lÏ biÕt t¸c dông cña Háa Ly Tinh Ph¸ch.")
        else
            Talk(1, "no", "§i tiÕp Hiªn Viªn ®éng tÇng 1 t×m §¹i phu hái xem, cã lÏ «ng ta sÏ gióp ng­¬i lµm 1 <c=yel>Hån B¹ch<c>.") --²»Ì«¿ÉÄÜµ½ÕâÒ»²½°É
            SetTaskByte(Task_Variety_Process, 1, 13)
            refreshNpcTaskState()--È·±£ÍòÎŞÒ»Ê§
        end
        return
    elseif (step == 15) then
        Talk(1, "no", "Th× ra ng­êi thÇn bİ ®· b¾t ®Çu ho¹t ®éng trong Hiªn Viªn ®éng, ngay c¶ Háa thÇn còng bŞ h¾n g¹t. Ta gióp ng­¬i n©ng cao vµi n¨ng lùc, nh­ng ®¹o h¹nh ng­¬i cßn kĞm, cßn ph¶i luyÖn thªm. §îi ®Õn <c=r> cÊp 46<c> h·y ®Õn gióp ta t×m hiÓu thùc h­.")
        Msg2Player("NhËn ®­îc phÇn th­ëng 32000 kinh nghiÖm.")
        TopMessage("NhËn ®­îc phÇn th­ëng 32000 kinh nghiÖm.")
        AddOwnExp(32000)
        SetTaskByte(Task_Variety_Process, 1, 16)
        ClearItem(6, 1, 486, 1) --É¾³ı»ê²¯
        ClearItem(4, 234, 1, 1) --É¾³ı»ğÀë¾«ÆÇ
        SetSubTask(1046, -1, 1)
        TaskNote(1046, 6)
        refreshNpcTaskState()
        return
    end
end
-------------------»ğÀë¾«ÆÇ Added by Laiyongcong at 2009/04/20 end ---------


-------------------³õ¼û¶ËÄß Add by Gaojingwei at 2009/04/16 begin--------------
function detectClue()
    CloseDialog()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step == 1) then
        SetSubTask(1044, 1, 1)
        Talk(1, "no", "Mau t×m Tinh Quan. ¤ng ta ®o¸n ®­îc T©y Kú cã biÕn ®éng, b©y giê nhÊt ®Şnh chiªu mé ng­êi gióp ®ì.")
        return
    end

    if (step == 0) then
        MsgBox("Tinh Quan ®ªm quan s¸t  tinh t­îng, ph¸t hiÖn cã ng«i sao bÊt th­êng xuÊt hiÖn ë T©y Kú, gÇn nh­ cã ph¸t sinh biÕn ®éng, anh hïng h·y gióp ta t×m hiÓu xem.", "yes_acceptClue", "no")
        return
    end

    if (step == 2) then
        MsgBox("Phİa B¾c T©y Kú Sa Hån ®ang lµm lo¹n, anh hïng cã thÓ gióp ta t×m hiÓu thùc h­?", "yes_snoop", "no")
        return
    end

    if (step == 3) then
        Talk(1, "no", "Xem ra ng­¬i ch­a ®iÒu tra ®­îc nguyªn nh©n Sa Hån n©ng cao linh lùc, thêi gian cÊp b¸ch, anh hïng h·y ®i t×m hiÓu xem!")
        return
    end

    if (step == 4) then
        AddOwnExp(8500)
        SetTaskByte(Task_Variety_Process, 1, 5)
        Talk(1, "no", "Th× ra ng­êi thÇn bİ ©m thÇm xói giôc Sa Hån s¸t h¹i lª d©n! §a t¹ ng­¬i b¸o cho ta tin nµy, ®Ó tá lßng biÕt ¬n, ta gióp ng­êi n©ng <c=g>8500<c> kinh nghiÖm. Anh hïng <c=r>®Õn cÊp 36<c> cã lÏ sÏ cßn cã thÓ gióp ta t×m th«ng tin quİ gi¸!")
        Msg2Player("NhËn ®­îc phÇn th­ëng 8500 kinh nghiÖm.")
        TopMessage("NhËn ®­îc phÇn th­ëng 8500 kinh nghiÖm.")
        SetSubTask(1044, -1, 1)
        TaskNote(Task_Info_First, 4)
        refreshNpcTaskState()
        return
    end
end

function yes_acceptClue()
    CloseDialog()
    if (GetTaskByte(Task_Variety_Process, 1) == 0) then
        SetTaskByte(Task_Variety_Process, 1, 1)
        Talk(1, "no", GetName() .. "Cøu gióp b¸ t¸nh lµ nghÜa cña ng­êi tu ®¹o, t¹i h¹ kh«ng tõ chèi, nhÊt ®Şnh dèc toµn lùc gióp ®ì!")
        Msg2Player("T×m Tinh Quan hái nguyªn nh©n tinh t­îng kh¸c th­êng.")
        SetSubTask(1044, 1, 1)
        TaskNote(Task_Info_First, 0)
        refreshNpcTaskState()
    end
end

function yes_snoop()
    CloseDialog()
    if (GetTaskByte(Task_Variety_Process, 1) == 2) then
        SetTaskByte(Task_Variety_Process, 1, 3)
        Talk(1, "no", GetName() .. "Th× ra Sa Hån tËp kİch ng­êi ë T©y Kú, sù viÖc ®¸ng ngê, t¹i h¹ mau ®i t×m hiÓu!")
        Msg2Player("§Õn phİa B¾c T©y Kú t×m hiÓu nguyªn nh©n Sa Hån trë nªn kh¸c th­êng.")
        TaskNote(Task_Info_First, 2)
        refreshNpcTaskState()
    end
end
-------------------³õ¼û¶ËÄß Add by Gaojingwei at 2009/04/16 end--------------
-------------------ÈıÓãÖ®ÂÒ Add by Gaojingwei at 2009/04/16 begin--------------
function fishBane()
    CloseDialog()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step == 5) then
        MsgBox("§«ng h¶i xuÊt hiÖn 3 Ng­ qu¸i, hïng b¸ 1 ph­¬ng, th­êng tÊn c«ng th­¬ng nh©n qua l¹i, anh hïng cã thÓ gióp ta ®Õn chç §¹i phu ë §«ng h¶i t×m hiÓu thùc h­ ra sao?", "yes_fishBane", "no")
        return
    end

    if (step >= 6 and step <= 9) then
        Talk(1, "no", "Anh hïng vÉn ch­a t×m ®­îc nguyªn nh©n µ? C¸c Ng­ qu¸i nµy lµ häa cho §«ng h¶i, ®· ¶nh h­ën ®Õn th­¬ng nh©n cña TriÒu Ca!")
        return
    end

    if (step == 10) then
        AddOwnExp(28000)
        SetTaskByte(Task_Variety_Process, 1, 11)
        Talk(1, "no", "Th× ra ng­êi thÇn bİ ©m thÇm xói giôc Háa Ng­ s¸t h¹i lª d©n! §a t¹ ng­¬i b¸o cho ta tin nµy, ®Ó tá lßng biÕt ¬n, ta gióp ng­êi n©ng <c=g>28000<c> kinh nghiÖm. Anh hïng <c=r>®Õn cÊp 41<c> cã lÏ sÏ cßn cã thÓ gióp ta t×m th«ng tin quİ gi¸!")
        Msg2Player("NhËn ®­îc phÇn th­ëng 28000 kinh nghiÖm.")
        TopMessage("NhËn ®­îc phÇn th­ëng 28000 kinh nghiÖm")
        SetSubTask(1045, -1, 1)
        TaskNote(Task_Info_Second, 5)
        refreshNpcTaskState()
    end
end

function yes_fishBane()
    CloseDialog()
    if (GetTaskByte(Task_Variety_Process, 1) == 5) then
        SetTaskByte(Task_Variety_Process, 1, 6)
        Talk(1, "no", GetName() .. "Th× ra Háa Ng­ tËp kİch ng­êi TriÒu Ca qua l¹i, sù viÖc ®¸ng ngê, t¹i h¹ mau ®i t×m hiÓu!")
        Msg2Player("§i §«ng h¶i t×m hiÓu th«ng tin 3 Ng­ qu¸i.")
        TaskNote(Task_Info_Second, 0)
        TaskNote(Task_Info_First, -1)
        SetSubTask(1045, 1, 1)
        refreshNpcTaskState()
    end
end
-------------------ÈıÓãÖ®ÂÒ Add by Gaojingwei at 2009/04/16 end--------------
----------------Àë¼äÖ®¼Æ-------------------------
function misChief()
    CloseDialog()
    local process = GetTaskByte(Task_Mischief, 1)
    local hanguiNum = GetTaskByte(Task_Mischief, 2)
    local tianwuNum = GetTaskByte(Task_Mischief, 3)
    if (process == 0) then
        MsgBox("Môc D· hiÖn t¹i t×nh thÕ nguy cÊp, <c=r>Giang Quy<c>, <c=r>Thiªn H¹o<c> ®ang hîp lùc, ph¶i kh«ng chÕ toµn côc diÖn cßn cÇn b¾t 5 <c=r>Giang Quy<c> vµ 5 <c=r>Thiªn H¹o<c> ®Ó hái chuyÖn, ng­¬i cã gióp ®­îc kh«ng?", "yes_misChief", "no")
        return
    end

    if (process == 1 and hanguiNum == 5 and tianwuNum == 5) then
        ClearItem(6, 1, 470, 0)                    --É¾³ıÈÎÎñµÀ¾ß²¶ÊŞ¼Ğ
        SetTaskByte(Task_Mischief, 1, 2)
        AddOwnExp(15000)            --Íê³ÉÈÎÎñµÚÒ»²½£¬½±Àø15000¾­Ñé½±Àø
        Msg2Player("NhËn ®­îc phÇn th­ëng cña Hoµng Thiªn Hãa 15000 kinh nghiÖm")
        TopMessage("NhËn ®­îc phÇn th­ëng 15000 kinh nghiÖm")
        Talk(3, "killTortoise", "Anh hïng vÊt v¶ råi, xin h·y ®îi ë ®©y, ta ®i hái chuyÖn.", "T­íng qu©n cø tù nhiªn, ta ®îi ë ®©y.", "<c=r>Thiªn H¹o<c>, <c=r>Giang Quy<c> qu¶ nhiªn c©u kÕt víi nhau. T×nh thÕ rÊt bÊt lîi. Kh«ng biÕt anh hïng cã muèn gióp ta mét tay diÖt trõ yªu ho¹n kh«ng?")
        TaskNote(1035, 5)
        refreshNpcTaskState()
        return
    elseif (process == 1 and HaveNormalItem(6, 1, 470, 0) <= 0 and HaveNormalItemInQuick(6, 1, 470, 0) <= 0) then
        MsgBox("Xem ra Bæ Thó Gi¸p cña ng­¬i ®· mÊt, nÕu ng­¬i ®­a cho ta <c=yel>500 l­îng<c>, ta cã thÓ cho ng­¬i thªm 1 Bæ Thó Gi¸p.", "yes_tool", "no")
        return
    elseif (process == 1) then
        Talk(1, "no", "Ng­¬i cßn ch­a b¾t ®ñ <c=r>Thiªn H¹o<c> vµ <c=r>Giang Quy<c>, lµm phiÒn anh hïng.")
        return
    end

    if (process == 2) then
        MsgBox("<c=r>Thiªn H¹o<c>, <c=r>Giang Quy<c> qu¶ nhiªn c©u kÕt víi nhau. T×nh thÕ rÊt bÊt lîi. Kh«ng biÕt anh hïng cã muèn gióp ta mét tay diÖt trõ yªu ho¹n kh«ng?", "killTortoise", "no")
        return
    end

    if (process == 3 and GetMorphType() == 16) then
        Talk(1, "no", "Ta ®· hãa trang ng­¬i thµnh <c=r>Thiªn H¹o<c>, ngôy trang nµy chØ cã thÓ duy tr× trong thêi gian ng¾n, anh hïng mau ®i mau vÒ!")
        return
    elseif (process == 3 and GetMorphType() == -1) then
        MsgBox("NhiÖm vô thÊt b¹i, ng­¬i vÉn cã thÓ ngôy trang 1 lÇn n÷a, ng­¬i x¸c nhËn muèn ngôy trang thµnh <c=r>Thiªn H¹o<c> kh«ng?", "becomeChilopod", "no")
        return
    end

    if (process == 4 and GetTaskByte(Task_Mischief, 4) == 30) then
        SetTaskByte(Task_Mischief, 1, 5)
        PolyMorph(-1, 0, 0, 0, 0)            --±ä»ØÔ­À´µÄ×´Ì¬
        AddOwnExp(30000)
        Talk(1, "no", "Ng­¬i ®· hãa gi¶i nguy cÊp ë Môc D·, li gi¸n Giang Quy vµ Thiªn H¹o. Nh÷ng kinh nghiÖm lµ phÇn th­ëng cho ng­¬i.")
        TopMessage("NhËn ®­îc phÇn th­ëng 30000 kinh nghiÖm")
        Msg2Player("NhËn ®­îc phÇn th­ëng Hoµng Thiªn Hãa 30000 kinh nghiÖm")
        SetSubTask(1035, -1, 1)
        TaskNote(1035, -1)
        refreshNpcTaskState()
        return
    elseif (process == 4 and GetTaskByte(Task_Mischief, 4) < 30 and GetMorphType() == 24) then
        Talk(1, "no", " Ng­¬i ch­a thu phôc ®ñ <c=r>Thiªn H¹o<c>, cè g¾ng lªn!")
        return
    elseif (process == 4 and GetTaskByte(Task_Mischief, 4) < 30 and GetMorphType() == -1) then
        MsgBox("NhiÖm vô thÊt b¹i, ng­¬i vÉn cã thÓ ngôy trang 1 lÇn n÷a, ng­¬i x¸c nhËn muèn ngôy trang thµnh <c=r>Giang Quy<c> kh«ng?", "becomeTortoise", "no")
        return
    end
end

function yes_tool()
    CloseDialog()
    if (GetCash() >= 500) then
        Pay(500)
        AddNormalItem(6, 1, 470, 0, 0, 0)
        Msg2Player("NhËn ®­îc Bæ Thó Gi¸p")
        refreshNpcTaskState()
    else
        Talk(1, "no", "B¹n kh«ng ®ñ tiÒn.")
        refreshNpcTaskState()
    end
end

function killTortoise()
    CloseDialog()
    if (GetTaskByte(Task_Mischief, 1) == 2) then
        MsgBox(" <c=r>§Çu lÜnh Thiªn H¹o<c> vµ <c=r>®Çu lÜnh Giang Quy<c>®ang mËt héi trªn Môc D·. Ta sÏ biÕn anh hïng thµnh <c=r>Thiªn H¹o<c>, vµo ®ã tiªu diÖt <c=r>®Çu lÜnh Giang Quy<c>, vµ sau ®ã c¶i trang thµnh h¾n diÖt 30 <c=r>Thiªn H¹o<c> ®Ó ly gi¸n liªn minh <c=r>Thiªn H¹o<c> vµ <c=r>Giang Quy<c>. ViÖc nµy hiÓm nguy trïng trïng. Kh«ng biÕt ı anh hïng thÕ nµo?", "yes_kill", "no")
    end
end
function yes_misChief()
    CloseDialog()
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 0) then
        SetTaskByte(Task_Mischief, 1, 1)
        SetTaskByte(Task_Mischief, 2, 0)
        SetTaskByte(Task_Mischief, 3, 0)
        AddNormalItem(6, 1, 470, 0, 0, 0)                        --Ôö¼ÓÒ»¸ö²¶ÊŞ¼Ğ
        SetSubTask(1035, 1, 1)
        Talk(1, "no", "Ta cho ng­¬i <c=yel>Bæ Thó Gi¸p<c>, mau ®i b¾t <c=r>Giang Quy<c> vµ <c=r>Thiªn H¹o<c> ®i.")
        Msg2Player("NhËn ®­îc Bæ Thó Gi¸p")
        TaskNote(1035, 0, "<c=r><NpcName=\"ºµ¹ê\",25><c>", "<c=r><NpcName=\"ÌìÎâ\",17><c>")
        refreshNpcTaskState()
    end
end

function yes_kill()
    CloseDialog()
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 2) then
        SetTaskByte(Task_Mischief, 1, 3)
        SetTaskByte(Task_Mischief, 4, 0)
        PolyMorph(16, 1, 0, -1, 900)
        Talk(1, "no", " Trong tr¹ng th¸i c¶i trang thµnh Thiªn H¹o diÖt trõ <c=r>thñ lÜnh Giang Quy<c> (duy tr× 15 phót), mau ®i ®i!")
        Msg2Player("Trong tr¹ng th¸i c¶i trang diÖt trõ <c=r>thñ lÜnh Giang Quy<c>")
        TaskNote(1035, 3)
        refreshNpcTaskState()
    end
end

function becomeChilopod()
    --±ä³ÉÌìÎâ
    CloseDialog()
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 3 and GetMorphType() == -1) then
        PolyMorph(16, 1, 0, -1, 900)
        Msg2Player("B¹n ®· ngôy trang thµnh <c=r>Thiªn H¹o<c>")
        refreshNpcTaskState()
    end
end

function becomeTortoise()
    CloseDialog()
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 4 and GetTaskByte(Task_Mischief, 4) < 30 and GetMorphType() == -1) then
        SetTaskByte(Task_Mischief, 4, 0)
        PolyMorph(24, 1, 0, -1, 900)
        refreshNpcTaskState()
    end
end
----------------Àë¼äÖ®¼Æ-------------------------

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

function shitu_1()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        if (GetTask(901) == 0) then
            --±µ¥ô°È
            MsgBox(14167, "shitu_1_begin", "no")
        elseif (GetTask(901) == 6) then
            --§¹¦¨¥ô°È
            MsgBox(14168, "shitu_1_end", "no")
        elseif (GetTask(901) >= 7) then
            Talk(1, "no", 14169)
        else
            --©ñ±ó¥ô°È
            MsgBox(14170, "shitu_1_cancel", "no")
        end
    else
        if (GetTask(901) == 0) then
            Talk(1, "no", 14171)
        elseif (GetTask(901) == 6) then
            Talk(1, "no", 14172)
        elseif (GetTask(901) >= 7) then
            Talk(1, "no", 14169)
        else
            MsgBox(14170, "shitu_1_cancel", "no")
        end
    end
end

function shitu_1_begin()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        RemoveIBBuff(216)
        local done = AddIBBuff(216)
        if (done == 1) then
            SetTask(901, 1)
            TaskNote(45, 5)
            if (GetTask(900) < 7) then
                SetTask(900, 0)
                TaskNote(44, -1)
            end
            if (GetTask(899) < 7) then
                SetTask(899, 0)
                TaskNote(43, -1)
            end
            if (GetTask(902) < 7) then
                SetTask(902, 0)
                TaskNote(46, -1)
            end
            Talk(2, "no", 14173, "§õng ®Ó vßng s¸ng biÕn mÊt vµ ph¶i cïng ®i víi s­ phô cña m×nh. §¹i phu mçi tÇng sÏ gióp ng­¬i trŞ liÖu vÕt th­¬ng.")
        else
            Talk(1, "no", 14174)
        end
    else
        Talk(1, "no", 14172)
    end
end

function shitu_1_end()
    if (step_complete() == 0) and (GetTask(907) == 0) then
        Say("Chóc mõng ng­¬i ®· hoµn thµnh cuéc luyÖn tËp th¸m hiÓm lÇn nµy, ®­¬ng thÕ ma vËt hoµnh hµnh, ta tÆng ng­¬i ThÇn Gi¸p hé thÓ, ng­¬i ®Õn chän xem.", 3, "§Çu kh«i/shitu_1_end_yes", "Yªu ®¸i/shitu_1_end_yes", "Giµy/shitu_1_end_yes")
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
        Talk(1, "no", 14172)
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
    local exp2 = 250000
    if (exp1 < exp2) then
        AddOwnExp(exp1)
        AddOwnExp(exp2 - exp1)
    else
        AddOwnExp(exp2)
    end
    RemoveIBBuff(216)
    SetTask(901, 7)
    SetTask(1370, masterid)
    TaskNote(45, 6)
    TopMessage(14175)
    Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    local mark = step_complete()
    if (mark == 1) and (GetTask(907) == 0) and (nums ~= 10) then
        --§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
        local ty = GetPlayerType()
        AddNormalItem(0, 7 - nums, ty + 6, 4, 0, 0)
        SetTask(907, 1)
        Talk(1, "no", 14176)
        local item_name = { [0] = { "Vò Khóc Kh«i", "Vò Khóc Yªu §¸i", "Vò Khóc ChiÕn Ngoa" },
                            [1] = { "Xİch Tïng Qu¸n", "Xİch Tïng C©n", "Xİch Tïng Lı" },
                            [2] = { "B¸o ThÇn Trô", "B¸o ThÇn Yªu §¸i", "B¸o ThÇn Ngoa" },
        }
        TopMessage("NhËn ®­îc <c=g>" .. item_name[ty][nums + 1] .. "<c>")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>cïng s­ phô hiÖp lùc hoµn thµnh nhiÖm vô s­ ®å th¸m hiÓm, nhËn ®­îc vËt quİ b¸u <c=g>" .. item_name[ty][nums + 1] .. "<c>", 20)
        --	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
        --		AddNormalItem(3,14,0,0,0,0)
        --		SetTask(903,1)
        --		Talk(1,"no","¶À¤Ñ¤Æ¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
    elseif (mark == 4) and (GetTask(904) == 0) then
        --§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
        AddNormalItem2(0, 10, GetPlayerType() + 15, 9, 0, 0)
        SetTask(904, 1)
        Talk(1, "no", 14177)
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <c=g>thó c­ìi cÊp 50<c>", 20)
    else
        Talk(1, "no", 14178)
    end
end

function shitu_1_end_M(pname)
    local step = GetTask(901)
    local key = GetFriendFellowShipValue(pname)
    if (step < 100) or (key >= 720 * 100) then
        local addPRValue = AddMasterPRValue(7)
        SetTask(901, 100)
        --TopMessage(11805)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
    else
        local addPRValue = AddMasterPRValue(3)
        --TopMessage(11806)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
        Talk(1, "no", 14179)
    end
    SetFriendFellowShipValue(pname, 50 * 100)
    Msg2Player("§é th©n mËt gi÷a b¹n vµ §å ®Ö t¨ng thªm")
end

function shitu_1_cancel()
    RemoveIBBuff(216)
    SetTask(901, 0)
    TaskNote(45, -1)
    Talk(1, "no", 14180)
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

function renwu1()
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (GetLevel() >= 45) and (UTask_Wizard == 24) then
        Talk(1, "no", 10062)
        Msg2Player("Dïng ThÇn Oanh tÊn c«ng §¾c Kû thÊt b¹i, ®­îc Hoµng Thiªn Hãa båi th­êng Tö D­¬ng kiÕm vµ 240000 kinh nghiÖm.")
        TopMessage(14181)
        AddNormalItem(0, 0, 33, 4, 1, 0)
        AddOwnExp(240000)
        SetTask(1, 30)
        TaskNote(28, 15)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
    if (GetLevel() >= 45) and (UTask_Wizard == 21) then
        Talk(1, "no", 10063)
        Msg2Player("§Õn B¾c H¶i t×m ThÇn Oanh vÒ b¾t §¾c Kû hiÖn h×nh.")
        SetTask(1, 22)
        TaskNote(28, 12)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function renwu2()
    local renwu = GetTask(314)
    local thistime = GetTask(315)
    local thisday = floor(LocalSystemTime() / 86400)
    local mark = fangchenmi()
    local times = GetTask(916)
    local cishu = GetTaskByte(317, 1)
    local addtimes = GetTaskByte(317, 2) + 1
    local alltimes = GetTaskByte(1477, 3)
    local cishufsb = GetTaskByte(317, 3)

    if (renwu > 0) then
        local tasks2 = {
            { "Th¸m qu©n", "wancheng_1"; show = 1 },
            { "Hñy N.vô", "esc_1"; show = 0 }
        }

        if (thisday > thistime) then
            --Ö»ÓĞµÚ¶şÌì²ÅÄÜÈ¡Ïû
            tasks2[2].show = 1
        end ;
        SayTask(14182, tasks2)
    elseif ((thisday <= thistime) and (cishu <= 3 or cishufsb > 0)) then
        --·ûºÏ½ÓÈÎÎñµÄÌõ¼ş
        if (mark == 1) then
            MsgBox(14183, "check_2", "no")                                --check_2(),½ÓÈÎÎñµÄº¯Êı
        else
            Talk(1, "no", 11718)
        end
        --		elseif (cishu>3)and(times <4 or alltimes >= addtimes)then
    elseif (((cishu > 3) and (times < 4 or alltimes >= addtimes)) or ((thisday <= thistime) and (cishu <= 3 or cishufsb > 0)) or (thisday > thistime)) then
        --		elseif ((thisday<=thistime)and (cishu<=3 or cishufsb > 0))or (thisday>thistime) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "Th¸m qu©n", "yes_normal"; show = 0 }, --Ãâ·ÑÈÎÎñ
            { "N¹pTµiTuLuyÖn", "yes_freefsb"; show = 1 }, --ÄÉ²Æ
            { "Thiªn Tiªn thñy", "coin_renwu"; show = 1 }, --¸¶·ÑÈÎÎñ
            -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
            { "ThÎ Kim DËt", "Task_MonthCard"; show = 1 },
            -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End
        }
        --			if (alltimes >= addtimes) then
        --				task[1].show = 1
        --			else
        --				coin_renwu()
        --				return 0
        --			end

        if (thisday > thistime) then
            task[1].show = 1
            task[3].show = 0
            task[4].show = 0    -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12
        elseif (times >= 4) then
            task[3].show = 0
            task[4].show = 0    -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12
        end

        local retime = alltimes - addtimes + 1
        local str = "Hoan nghªnh ng­¬i sö dông <c=g>ThÎ Kim DËt<c> nhËn <c=y>nhiÖm vô chñ ®Ò trong ngµy<c>: <c=g>Th¸m qu©n<c>.<c=g>ThÎ Kim DËt<c> hµng ®Ñp gi¸ rÎ, İch lîi v« cïng!"
        if (retime > 0) then
            SayTask("Ng­¬i hiÖn ®· tİch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn sè lÇn nhiÖm vô thªm, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ. NhÊp chän N¹p tµi tu luyÖn lµ cã thÓ h­ëng ­u ®·i nµy." .. str, task)
        else
            SayTask(" NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ gióp ng­¬i c¬ héi <c=g>N¹p tµi tu luyÖn<c>, chØ cÇn bá ra İt b¹c!" .. str, task)
        end
    else
        MsgBox(14184, "no")
    end ;
end;

function yes_normal()
    CloseDialog()
    local thisday = floor(LocalSystemTime() / 86400)
    local thistime = GetTask(315)
    local cishu = GetTaskByte(317, 1)
    if ((thisday <= thistime) and (cishu <= 3 or cishufsb > 0)) or (thisday > thistime) then
        MsgBox(14183, "check_2", "no")
    else
        Talk(1, "no", 11718)
    end
end

-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
function Task_MonthCard()
    local task = {
        { "Tu luyÖn th­êng", "Single_Cost"; show = 1 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "Double_Cost"; show = 1 }, --Ë«±¶ÊÕ·Ñ
    }
    local cfs = GetCostDisIB(1)
    local str = "<c=g>NhiÖm vô chñ ®Ò trong ngµy<c> bao gåm Th¸m qu©n, NhiÖm vô S¸t thñ, Ph¸ V¹n Tiªn TrËn, §¹o cô, Siªu ®é, Thu thËp, VËn l­¬ng, Hoa thÇn bİ, Thiªn Thô, §­a th­, VËn chuyÓn, LuyÖn Tiªn ®¬n, ThÊt Qu¶i, B¨ng Háa Long Ch©u."
    SayTask("Hoµng Thiªn Hãa: " .. str .. "NÕu ng­¬i cã <c=g>" .. cfs .. "TiÒn ®ång (ThÎ Kim DËt)<c>, ta sÏ cho ng­¬i thªm mét c¬ héi nhËn nhiÖm vô Th¸m Qu©n. Muèn cã ®­îc nh©n ®«i, cÇn cã <c=g>" .. (cfs * 2) .. "TiÒn ®ång (ThÎ Kim DËt)<c>#", task)
end

function Single_Cost()
    CloseDialog()
    local nCostIB = GetCostDisIB(1)
    local Cost_TBPoint = GetCostIB(1)
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cost_TBPoint) then
        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cost_TBPoint) == 0) then
            Talk(1, "no", " KhÊu trõ ®iÓm sè ThÎ Kim DËt thÊt b¹i")
            return
        end
        SetTask(916, GetTask(916) + 1)
        SetTaskByte(317, 1, 0)
        SetTask(314, 0)
        SetTask(CitanAddress, 0)
        SetTaskByte(317, 4, 1)
        SetTask(316, 0)
        check_2()
        Msg2Player("B¹n ®· tÆng cho ¢n Hång" .. nCostIB .. "TiÒn ®ång cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
        WriteLog(GetName() .. "Sö dông " .. nCostIB .. "TiÒn ®ång (ThÎ Kim DËt) nhËn ®­îc nhiÖm vô Th¸m qu©n")
    else
        MsgBox(" RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
    end
end

function Double_Cost()
    CloseDialog()
    local nCostIB = GetCostDisIB(1) * 2
    local Cost_TBPoint = GetCostIB(1)
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cost_TBPoint * 2) then
        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cost_TBPoint * 2) == 0) then
            Talk(1, "no", " KhÊu trõ ®iÓm sè ThÎ Kim DËt thÊt b¹i")
            return
        end
        SetTask(916, GetTask(916) + 1)
        SetTaskByte(317, 4, 2)
        SetTaskByte(317, 1, 0)            --»·ÊıÇåÁã
        SetTask(314, 0)            --Ã»½ÓÈÎÎñ
        SetTask(CitanAddress, 0)--´ÌÌ½µØÖ·
        SetTask(316, 0)
        check_2()
        Msg2Player("B¹n ®· tÆng cho ¢n Hång" .. nCostIB .. "TiÒn ®ång cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
        WriteLog(GetName() .. "Sö dông " .. nCostIB .. "TiÒn ®ång (ThÎ Kim DËt) nhËn ®­îc nhiÖm vô Th¸m qu©n")
    else
        MsgBox(" RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
    end
end
-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End

function coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "queding"; show = 1 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "queding2"; show = 1 }, --Ë«±¶ÊÕ·Ñ
    }
    local cfs = GetCostDisIB(1)
    SayTask(" Ng­¬i ®· nhËn nhiÖm vô Th¸m Qu©n cña h«m nay råi. Giê nÕu ng­¬i cã <c=g>1 Thiªn Tiªn Thñy hoÆc " .. cfs .. "TiÒn ®ång<c>, ta sÏ cho ng­¬i thªm mét c¬ héi nhËn nhiÖm vô Th¸m Qu©n. Muèn cã ®­îc nh©n ®«i, cÇn cã <c=yel>2 Thiªn Tiªn Thñy<c> hoÆc <c=yel>" .. (cfs * 2) .. "<c>tiÒn ®ång. PhÇn th­ëng nµy lµ rÊt phong phó ®ã!", task)
end

function queding()
    local i = FindAValidIBItem(8, 206, 5, 0)
    local nCostIB = GetCostDisIB(1)
    if (i ~= 0) then
        SetTask(916, GetTask(916) + 1)
        CostIBItem(i)        --¼õµôÍ­Ç®ÎïÆ·
        SetTaskByte(317, 1, 0)            --»·ÊıÇåÁã
        SetTask(314, 0)            --Ã»½ÓÈÎÎñ
        SetTask(CitanAddress, 0)--´ÌÌ½µØÖ·
        SetTask(316, 0)
        SetTaskByte(317, 4, 1)
        Msg2Player("B¹n tÆng 1 Thiªn Tiªn Thñy cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
        check_2()
    elseif (GetCoin() >= GetCostIB(1)) then
        if (RealCostIB(1) == 0) then
            Talk(1, "no", 11736)
            return
        end
        SetTask(916, GetTask(916) + 1)
        SetTaskByte(317, 1, 0)
        SetTask(314, 0)
        SetTask(CitanAddress, 0)
        SetTaskByte(317, 4, 1)
        SetTask(316, 0)
        check_2()
        EventTopConsume:AddConsumeValue(nCostIB, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n ®· tÆng cho ¢n Hång" .. nCostIB .. "TiÒn ®ång cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=g>Thiªn Tiªn Thñy hoÆc" .. nCostIB .. "TiÒn ®ång<color> råi! Xin t×m <color=green>Thiªn Tiªn Thñy hoÆc" .. nCostIB .. "TiÒn ®ång<color>thªm n÷a!")
    end
end

function queding2()
    local cv = GetCostIB(1)
    local nums = HaveNormalItem(8, 206, 5, 0)
    local i = FindAValidIBItem(8, 206, 5, 0)
    if (nums > 0) and (i == 0) then
        nums = 0
    end
    local mycoin = nums * cv + GetCoin() --ÓµÓĞ×Ê²ú
    local nCostIB = GetCostDisIB(1)

    if (mycoin >= cv * 2) then
        if (i ~= 0) then
            if (nums >= 2) then
                CostIBItem(i)
                CostIBItem(FindAValidIBItem(8, 206, 5, 0))
                Msg2Player("B¹n tÆng 2 Thiªn Tiªn Thñy cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
            elseif (nums == 1) then
                if (RealCostIB(1) == 0) then
                    Talk(1, "no", 11736)
                    return
                end
                CostIBItem(i)
                EventTopConsume:AddConsumeValue(nCostIB , "NhiÖm Vô TuÇn Hoµn")
                Msg2Player("B¹n tÆng 1 Thiªn Tiªn Thñy vµ " .. nCostIB .. "TiÒn ®ång cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
            end
        else
            if (RealCostIB(1) == 0) then
                Talk(1, "no", 11736)
                return
            end
            RealCostIB(1)
            EventTopConsume:AddConsumeValue((nCostIB * 2), "NhiÖm Vô TuÇn Hoµn")
            Msg2Player("B¹n ®· tÆng cho ¢n Hång" .. (nCostIB * 2) .. "TiÒn ®ång cho Hoµng Thiªn Hãa, nhËn ®­îc nhiÖm vô Th¸m qu©n")
        end

        SetTask(916, GetTask(916) + 1)
        SetTaskByte(317, 4, 2)
        SetTaskByte(317, 1, 0)            --»·ÊıÇåÁã
        SetTask(314, 0)            --Ã»½ÓÈÎÎñ
        SetTask(CitanAddress, 0)--´ÌÌ½µØÖ·
        SetTask(316, 0)
        check_2()
    else
        nCostIB = nCostIB * 2
        Talk(1, "no", " Ng­¬i kh«ng cã 2 <color=green>Thiªn Tiªn Thñy hoÆc " .. nCostIB .. "TiÒn ®ång <color>! H·y chuÈn bŞ ®ñ 2 <color=green>Thiªn Tiªn Thñy hoÆc " .. nCostIB .. "TiÒn ®ång<color>thªm n÷a!")
    end
end

function esc_1()
    MsgBox(14185, "quxiao_1", "no")
end;

function String_Page(str)
    Talk(1, "no", str)
end

function wancheng_1()
    local renwu = GetTask(314)
    local thistime = GetTask(315)
    local cishu = GetTaskByte(317, 1)
    local shengyu = 3 - cishu
    local thisday = floor(LocalSystemTime() / 86400)

    local cishufree = GetTaskByte(317, 3)
    if (renwu == 100) then
        if (cishufree > 0) then
            cishu = 0
            shengyu = 3 - cishufree
        end

        if (cishu >= 3 or cishufree >= 3) and (GetTask(316) <= 0) then
            local nExp = GetLevel() * 1400
            local exp1 = nExp * 0.5
            local str = ""
            if ((GetTask(CitanAddress)) >= 22) then
                nExp = nExp * 1.5
                str = " Tin tøc ng­¬i ®­a rÊt kŞp thêi, kinh nghiÖm th­ëng còng sÏ t¨ng t­¬ng øng. NhiÖm vô Th¸m qu©n lÇn nµy ph¶i lÆn léi ®­êng xa, ®­¬ng nhiªn sÏ nhËn ®­îc <c=yel>phÇn th­ëng cao h¬n<c>. Mçi ngµy, sè lÇn ®­a tin cµng nhiÒu, ®iÓm kinh nghiÖm nhËn ®­îc sÏ cµng cao!"
            else
                str = 11374
            end
            if (cishufree == 0) then
                if (GetWeekDay() == 1) and (thisday == thistime) then
                    nExp = nExp * 2
                    Msg2Player("H«m nay lµ ngµy chñ ®Ò Th¸m qu©n! Chóc mõng b¹n, nhËn ®­îc phÇn th­ëng nh©n ®«i!")
                end

                SetTaskByte(317, 1, cishu + 1)
                if (GetTask(916) >= 4) and (thisday == thistime) then
                    SyncBibleState(33, 3, 1)
                elseif (thisday == thistime) then
                    SyncBibleState(33, 2, 1)
                end
            else
                SetTaskByte(317, 3, 0)
            end

            local str_p2 = ""
            local Newnums = GetTask(1026) + 1
            if (GetLevel() >= 100) and (GetTask(1026) >= 400) then
                nExp = nExp + exp1 * 2
                if (GetTaskByte(317, 4) == 2) then
                    nExp = nExp * 2
                end
                str_p2 = "Tİch lòy <c=g>" .. Newnums .. "<c> lÇn, h·y nhËn lÊy phÇn th­ëng <c=g>" .. nExp .. "<c> ®iÓm kinh nghiÖm!"
            elseif (GetLevel() >= 70) and (GetTask(1026) >= 150) then
                nExp = nExp + exp1
                if (GetTaskByte(317, 4) == 2) then
                    nExp = nExp * 2
                end
                str_p2 = "Tİch lòy <c=g>" .. Newnums .. "<c> lÇn, h·y nhËn lÊy phÇn th­ëng <c=g>" .. nExp .. "<c>PhÇn th­ëng ®iÓm kinh nghiÖm, nÕu tİch lòy 400 lÇn ë cÊp<c=g>100<c>, phÇn th­ëng lín h¬n!"
            else
                if (GetTaskByte(317, 4) == 2) then
                    nExp = nExp * 2
                end
                str_p2 = "Tİch lòy <c=g>" .. Newnums .. "<c>lÇn, nhËn ®­îc <c=g>" .. nExp .. "<c> ®iÓm kinh nghiÖm, nÕu tİch lòy 150 lÇn ë cÊp<c=g>70<c>, ta sÏ cã phÇn th­ëng hËu hÜnh!"
            end
            SetTaskByte(317, 4, 0)
            --luoyixuan
            refreshNpcTaskState()
            --luoyixuan

            ----------------------------------
            --³èÎï»î¶¯
            if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
                local pr = random(1, 5)
                if (pr == 5) then
                    AddIBBuff(418)
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 2) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc 2 <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc 2 Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                else
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 1) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                end

            end

            if (GetBit(GetTask(TASK_lateral), 1) == 0) then
                AddNormalItem(6, 1, 346, 0, 0, 0)
                TaskNote(700, 0)
                SetTaskBit(TASK_lateral, 1, 1)
                TopMessage("B¹n bÊt ngê nhËn ®­îc 1 <c=g>Quy Cèt Thiªm<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Quy Cèt Thiªm")
            end
            ------------------------------------
            AddOwnExp(nExp)

            SetTask(314, 0)
            SetTask(CitanAddress, 0)
            TaskNote(33, -1)
            TopMessage("B¹n nhËn ®­îc <c=g>" .. nExp .. "<c> kinh nghiÖm")
            Msg2Player("Tİch lòy ®ñ sè lÇn Th¸m qu©n!" .. Newnums .. "lÇn, nhËn ®­îc" .. nExp .. "phÇn th­ëng ®iÓm kinh nghiÖm")
            SetTask(1026, Newnums)
            -----------Add by Gaojingwei At 2009/3/19 end-----------------
            local a = random(1, 10)
            if (a == 1 and (GetTaskBit(Task_Improve, 1) == 1 or GetLevel() > 40)) then
                AddNormalItem(8, 35, 2, 0, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 Di Ngo¹i phï!")

                AddGlobalCountNews("Hoµn thµnh N.v th¸m qu©n, Hoµng Thiªn Hãa tÆng <c=g>" .. GetName() .. "<c> 1 tÊm <color=yellow>Di Ngo¹i phï<c>, xin chóc mõng!", 3)
            end

            if (a == 1 and GetTaskBit(Task_Improve, 1) == 0 and GetLevel() <= 40) then
                AddNormalItem(8, 567, 2, 0, 0, 0)
                SetTaskBit(Task_Improve, 1, 1)
                Msg2Player("B¹n nhËn ®­îc Nh­ ı Di ngo¹i phï, hy väng b¹n cã thÓ tiÕp tôc tr¶i nghiÖm!")
                AddGlobalCountNews("Hoµn thµnh N.v th¸m qu©n, Hoµng Thiªn Hãa tÆng <c=g>" .. GetName() .. "<color><color=yellow>Nh­ ı Di ngo¹i phï <color>, chóc mõng chóc mõng!", 3)
            end
            -----------Add by Gaojingwei At 2009/3/19 end-----------------

            if (thisday - 1 >= thistime) then
                offlineTotimes()
                SetTask(916, 0)
                SetTask(317, 0)--ÄÉ²ÆÇåÁã
                SetTask(315, thisday)
                SetTask(316, 0)
                Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê b¹n cã thÓ b¾t ®Çu nhiÖm vô míi.")
            else
                KsgTask:OnFinish(916);
                Msg2Player("B¹n ®· hoµn thµnh 1 lÇn nhiÖm vô th¸m qu©n.")
                SetTaskWord(317, 2, 0)--ÄÉ²ÆÇåÁã
            end ;
            ------Modify by Gaojingwei at 2009/04/16 begin--------------
            if (GetTaskByte(Task_Variety_Process, 2) == 0 and GetLevel() >= 30) then
                Talk(2, "detectClue", str, str_p2)
                SetTaskByte(Task_Variety_Process, 2, 1)
                refreshNpcTaskState()                    --±íÊ¾ÒÑ¾­ÊÕµ½³õ¼û¶ËÄßµ½Í¨Öª
            elseif (GetTaskByte(Task_Variety_Process, 2) == 1 and GetTaskByte(Task_Variety_Process, 1) == 5 and GetLevel() >= 36) then
                Talk(2, "fishBane", str, str_p2)
                SetTaskByte(Task_Variety_Process, 2, 2)                --±íÊ¾ÒÑ¾­ÊÕµ½ÈıÓãÖ®ÂÒµÄÍ¨Öª
                refreshNpcTaskState()
            elseif (GetTaskByte(Task_Variety_Process, 2) == 2 and GetLevel() >= 41 and GetTaskByte(Task_Variety_Process, 1) == 11) then
                Talk(2, "fireSoul", str, str_p2)
                SetTaskByte(Task_Variety_Process, 2, 3)
                refreshNpcTaskState()
            elseif (GetTaskByte(Task_Variety_Process, 2) == 3 and GetLevel() >= 46 and GetTaskByte(Task_Variety_Process, 1) == 16) then
                Talk(2, "conspiracy", str, str_p2)
                SetTaskByte(Task_Variety_Process, 2, 4)
                refreshNpcTaskState()
            else
                Talk(2, "no", str, str_p2)
            end
            ------Modify by Gaojingwei at 2009/04/16 end--------------
        else
            local key = GetTaskByte(317, 4)
            local str1 = "NhiÖm vô h«m nay cßn l¹i <c=g>" .. shengyu .. "<c> vßng."

            if (thisday - 1 >= thistime) then
                offlineTotimes()
                SetTask(916, 0)
                SetTask(317, 0)--ÄÉ²ÆÇåÁã
                SetTask(315, thisday)
                SetTask(316, 0)
                Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê b¹n cã thÓ b¾t ®Çu nhiÖm vô míi.")
                str1 = "NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê b¹n cã thÓ b¾t ®Çu nhiÖm vô míi."
            else
                Msg2Player("B¹n ®· hoµn thµnh 1 lÇn nhiÖm vô Th¸m qu©n, cã thÓ tiÕp tôc lµm thªm.")
            end ;
            local nExp = GetLevel() * 600
            local exp1 = nExp * 0.5
            if ((GetTask(CitanAddress)) >= 22) then
                nExp = nExp * 1.5
                MsgBox(" Tin tøc ng­¬i ®­a rÊt kŞp thêi, kinh nghiÖm th­ëng còng sÏ t¨ng t­¬ng øng. NhiÖm vô Th¸m qu©n lÇn nµy ph¶i lÆn léi ®­êng xa, ®­¬ng nhiªn sÏ nhËn ®­îc <c=yel>phÇn th­ëng cao h¬n<c>. Mçi ngµy sè vßng hoµn thµnh nhiÖm vô cµng nhiÒu ®iÓm kinh nghiÖm sÏ cµng cao." .. str1, "check_2", "no")
            else
                MsgBox("Tin tøc ng­¬i ®­a rÊt kŞp thêi, mçi ngµy tïy theo sè lÇn hoµn thµnh nhiÖm vô, ®iÓm kinh nghiÖm còng sÏ t¨ng lªn." .. str1, "check_2", "no")
            end
            if (cishufree == 0) and (GetWeekDay() == 1) and (thisday == thistime) then
                nExp = nExp * 2
                Msg2Player("H«m nay lµ ngµy chñ ®Ò Th¸m qu©n! Chóc mõng b¹n, nhËn ®­îc phÇn th­ëng nh©n ®«i!")
            end

            if (GetLevel() >= 100) and (GetTask(1026) >= 400) then
                nExp = nExp + exp1 * 2
            elseif (GetLevel() >= 70) and (GetTask(1026) >= 150) then
                nExp = nExp + exp1
            end
            if (key == 2) then
                nExp = nExp * 2
            end
            AddOwnExp(nExp)
            TaskNote(33, -1)

            TopMessage("B¹n nhËn ®­îc <c=g>" .. nExp .. "<c> kinh nghiÖm")
            Msg2Player("Tİch lòy ®ñ sè lÇn Th¸m qu©n!" .. GetTask(1026) .. "lÇn, nhËn ®­îc" .. nExp .. "phÇn th­ëng ®iÓm kinh nghiÖm")
            SetTask(314, 0)
            SetTask(CitanAddress, 0)
            --luoyixuan
            refreshNpcTaskState()
            --luoyixuan
        end ;
    else
        Talk(1, "no", 11376)
    end ;
end;

function quxiao_1()
    local thisday = floor(LocalSystemTime() / 86400)
    offlineTotimes()
    SetTask(916, 0)
    SetTask(317, 0)--ÄÉ²ÆÇåÁã
    SetTask(315, thisday)
    SetTask(316, 0)
    SetTask(314, 0)
    SetTask(CitanAddress, 0)
    TaskNote(33, -1)
    Msg2Player("B¹n ®· hñy nhiÖm vô Th¸m qu©n vÉn ch­a hoµn thµnh cña ngµy h«m qua")
    Talk(1, "no", 14186)
end;

function check_2()
    local cishufsb = GetTaskByte(317, 3)
    if (cishufsb > 0) then
        check_renwu()
        SetTaskByte(317, 3, cishufsb + 1)
        Msg2Player("Ng­¬i nhËn ®­îc nhiÖm vô Th¸m qu©n míi!")

        return 0
    end

    local thistime = GetTask(315)
    local cishu = GetTaskByte(317, 1)
    local thisday = floor(LocalSystemTime() / 86400)

    if (cishu >= 3) then
        if (thisday > thistime) then
            SetTask(314, 0)
            offlineTotimes()
            SetTask(CitanAddress, 0)
            SetTask(315, thisday)
            thistime = thisday
            SetTask(316, 0)
            SetTask(317, 0)--ÄÉ²ÆÇåÁã
            cishu = 0
            SetTask(916, 0)
            Msg2Player(" Ngµy míi ®· b¾t ®Çu, ®· cã thÓ b¾t ®Çu nhiÖm vô Th¸m qu©n míi.")
        else
            SetTask(314, 0)
            SetTask(CitanAddress, 0)

            SetTask(316, 0)
            SetTaskByte(317, 1, cishu + 1)
            Talk(1, "no", 11326)
            return 1
        end ;
    end

    if (cishu < 3) then
        check_renwu()
        if (thisday - 1 >= thistime) then
            offlineTotimes()
            SetTask(916, 0)
            SetTask(317, 0)--ÄÉ²ÆÇåÁã
            SetTaskByte(317, 1, 1)
            SetTask(316, 0)
            SetTask(315, thisday)
            if (thistime ~= 0) then
                Msg2Player("NhiÖm vô h«m qua cã ng­¬i ®· qu¸ thêi h¹n giao tr¶! Giê h·y b¾t ®Çu l¹i tõ ®Çu!")
            end
        else
            SetTaskByte(317, 1, cishu + 1)
            Msg2Player("Ng­¬i nhËn ®­îc nhiÖm vô Th¸m qu©n míi!")
        end ;

    end ;
    --luoyixuan
    refreshNpcTaskState()
    --luoyixuan
end;

function check_renwu()
    if (GetLevel() <= 30) then
        local i = random(1, 15)
        if (i <= 1) then
            Talk(1, "no", 11327)
            SetTask(314, 5)
            TaskNote(33, 5)
        elseif (i <= 2) then
            Talk(1, "no", 11328)
            SetTask(314, 6)
            TaskNote(33, 6)
        elseif (i <= 3) then
            Talk(1, "no", 11329)
            SetTask(314, 7)
            TaskNote(33, 7)
        elseif (i <= 4) then
            Talk(1, "no", 11330)
            SetTask(314, 8)
            TaskNote(33, 8)
        elseif (i <= 5) then
            Talk(1, "no", 11331)
            SetTask(314, 9)
            TaskNote(33, 9)
        elseif (i <= 6) then
            Talk(1, "no", 11332)
            SetTask(314, 10)
            TaskNote(33, 10)
        elseif (i <= 7) then
            Talk(1, "no", 11333)
            SetTask(314, 11)
            TaskNote(33, 11)
        elseif (i <= 8) then
            Talk(1, "no", 11334)
            SetTask(314, 12)
            TaskNote(33, 12)
        elseif (i <= 9) then
            Talk(1, "no", 11335)
            SetTask(314, 13)
            TaskNote(33, 13)
        elseif (i <= 10) then
            Talk(1, "no", 11336)
            SetTask(314, 14)
            TaskNote(33, 14)
        elseif (i <= 11) then
            Talk(1, "no", 11337)
            SetTask(314, 15)
            TaskNote(33, 15)
        elseif (i <= 12) then
            Talk(1, "no", 11338)
            SetTask(314, 16)
            TaskNote(33, 16)
        elseif (i <= 13) then
            Talk(1, "no", 11339)
            SetTask(314, 17)
            TaskNote(33, 17)
        elseif (i <= 14) then
            Talk(1, "no", 11340)
            SetTask(314, 18)
            TaskNote(33, 18)
        elseif (i <= 15) then
            Talk(1, "no", 11341)
            SetTask(314, 19)
            TaskNote(33, 19)
        end ;
    elseif (GetLevel() <= 40) then
        local i = random(1, 159)
        if (i <= 10) then
            Talk(1, "no", 11327)
            SetTask(314, 5)
            TaskNote(33, 5)
        elseif (i <= 20) then
            Talk(1, "no", 11328)
            SetTask(314, 6)
            TaskNote(33, 6)
        elseif (i <= 30) then
            Talk(1, "no", 11329)
            SetTask(314, 7)
            TaskNote(33, 7)
        elseif (i <= 40) then
            Talk(1, "no", 11330)
            SetTask(314, 8)
            TaskNote(33, 8)
        elseif (i <= 50) then
            Talk(1, "no", 11331)
            SetTask(314, 9)
            TaskNote(33, 9)
        elseif (i <= 60) then
            Talk(1, "no", 11332)
            SetTask(314, 10)
            TaskNote(33, 10)
        elseif (i <= 70) then
            Talk(1, "no", 11333)
            SetTask(314, 11)
            TaskNote(33, 11)
        elseif (i <= 80) then
            Talk(1, "no", 11334)
            SetTask(314, 12)
            TaskNote(33, 12)
        elseif (i <= 90) then
            Talk(1, "no", 11335)
            SetTask(314, 13)
            TaskNote(33, 13)
        elseif (i <= 100) then
            Talk(1, "no", 11336)
            SetTask(314, 14)
            TaskNote(33, 14)
        elseif (i <= 110) then
            Talk(1, "no", 11337)
            SetTask(314, 15)
            TaskNote(33, 15)
        elseif (i <= 120) then
            Talk(1, "no", 11338)
            SetTask(314, 16)
            TaskNote(33, 16)
        elseif (i <= 130) then
            Talk(1, "no", 11339)
            SetTask(314, 17)
            TaskNote(33, 17)
        elseif (i <= 140) then
            Talk(1, "no", 11340)
            SetTask(314, 18)
            TaskNote(33, 18)
        elseif (i <= 150) then
            Talk(1, "no", 11341)
            SetTask(314, 19)
            TaskNote(33, 19)
        elseif (i <= 155) then
            Talk(1, "no", 11342)
            SetTask(314, 22)
            TaskNote(33, 22)
        elseif (i <= 157) then
            Talk(1, "no", 11343)
            SetTask(314, 23)
            TaskNote(33, 23)
        elseif (i <= 159) then
            Talk(1, "no", 11351)
            SetTask(314, 37)
            TaskNote(33, 37)
        end ;
    elseif (GetLevel() <= 50) then
        local i = random(1, 168)
        if (i <= 10) then
            Talk(1, "no", 11327)
            SetTask(314, 5)
            TaskNote(33, 5)
        elseif (i <= 20) then
            Talk(1, "no", 11328)
            SetTask(314, 6)
            TaskNote(33, 6)
        elseif (i <= 30) then
            Talk(1, "no", 11329)
            SetTask(314, 7)
            TaskNote(33, 7)
        elseif (i <= 40) then
            Talk(1, "no", 11330)
            SetTask(314, 8)
            TaskNote(33, 8)
        elseif (i <= 50) then
            Talk(1, "no", 11331)
            SetTask(314, 9)
            TaskNote(33, 9)
        elseif (i <= 60) then
            Talk(1, "no", 11332)
            SetTask(314, 10)
            TaskNote(33, 10)
        elseif (i <= 70) then
            Talk(1, "no", 11333)
            SetTask(314, 11)
            TaskNote(33, 11)
        elseif (i <= 80) then
            Talk(1, "no", 11334)
            SetTask(314, 12)
            TaskNote(33, 12)
        elseif (i <= 90) then
            Talk(1, "no", 11335)
            SetTask(314, 13)
            TaskNote(33, 13)
        elseif (i <= 100) then
            Talk(1, "no", 11336)
            SetTask(314, 14)
            TaskNote(33, 14)
        elseif (i <= 110) then
            Talk(1, "no", 11337)
            SetTask(314, 15)
            TaskNote(33, 15)
        elseif (i <= 120) then
            Talk(1, "no", 11338)
            SetTask(314, 16)
            TaskNote(33, 16)
        elseif (i <= 130) then
            Talk(1, "no", 11339)
            SetTask(314, 17)
            TaskNote(33, 17)
        elseif (i <= 140) then
            Talk(1, "no", 11340)
            SetTask(314, 18)
            TaskNote(33, 18)
        elseif (i <= 150) then
            Talk(1, "no", 11341)
            SetTask(314, 19)
            TaskNote(33, 19)
        elseif (i <= 155) then
            Talk(1, "no", 11342)
            SetTask(314, 22)
            TaskNote(33, 22)
        elseif (i <= 156) then
            Talk(1, "no", 11343)
            SetTask(314, 23)
            TaskNote(33, 23)
        elseif (i <= 157) then
            Talk(1, "no", 11344)
            SetTask(314, 24)
            TaskNote(33, 24)
        elseif (i <= 162) then
            Talk(1, "no", 11345)
            SetTask(314, 27)
            TaskNote(33, 27)
        elseif (i <= 163) then
            Talk(1, "no", 11346)
            SetTask(314, 28)
            TaskNote(33, 28)
        elseif (i <= 165) then
            Talk(1, "no", 11348)
            SetTask(314, 32)
            TaskNote(33, 32)
        elseif (i <= 166) then
            Talk(1, "no", 11351)
            SetTask(314, 37)
            TaskNote(33, 37)
        elseif (i <= 167) then
            Talk(1, "no", 11352)
            SetTask(314, 38)
            TaskNote(33, 38)
        elseif (i <= 168) then
            Talk(1, "no", 11353)
            SetTask(314, 39)
            TaskNote(33, 39)
        end ;
    elseif (GetLevel() <= 70) then
        local i = random(1, 171)
        if (i <= 10) then
            Talk(1, "no", 11327)
            SetTask(314, 5)
            TaskNote(33, 5)
        elseif (i <= 20) then
            Talk(1, "no", 11328)
            SetTask(314, 6)
            TaskNote(33, 6)
        elseif (i <= 30) then
            Talk(1, "no", 11329)
            SetTask(314, 7)
            TaskNote(33, 7)
        elseif (i <= 40) then
            Talk(1, "no", 11330)
            SetTask(314, 8)
            TaskNote(33, 8)
        elseif (i <= 50) then
            Talk(1, "no", 11331)
            SetTask(314, 9)
            TaskNote(33, 9)
        elseif (i <= 60) then
            Talk(1, "no", 11332)
            SetTask(314, 10)
            TaskNote(33, 10)
        elseif (i <= 70) then
            Talk(1, "no", 11333)
            SetTask(314, 11)
            TaskNote(33, 11)
        elseif (i <= 80) then
            Talk(1, "no", 11334)
            SetTask(314, 12)
            TaskNote(33, 12)
        elseif (i <= 90) then
            Talk(1, "no", 11335)
            SetTask(314, 13)
            TaskNote(33, 13)
        elseif (i <= 100) then
            Talk(1, "no", 11336)
            SetTask(314, 14)
            TaskNote(33, 14)
        elseif (i <= 110) then
            Talk(1, "no", 11337)
            SetTask(314, 15)
            TaskNote(33, 15)
        elseif (i <= 120) then
            Talk(1, "no", 11338)
            SetTask(314, 16)
            TaskNote(33, 16)
        elseif (i <= 130) then
            Talk(1, "no", 11339)
            SetTask(314, 17)
            TaskNote(33, 17)
        elseif (i <= 140) then
            Talk(1, "no", 11340)
            SetTask(314, 18)
            TaskNote(33, 18)
        elseif (i <= 150) then
            Talk(1, "no", 11341)
            SetTask(314, 19)
            TaskNote(33, 19)
        elseif (i <= 151) then
            Talk(1, "no", 11342)
            SetTask(314, 22)
            TaskNote(33, 22)
        elseif (i <= 152) then
            Talk(1, "no", 11343)
            SetTask(314, 23)
            TaskNote(33, 23)
        elseif (i <= 153) then
            Talk(1, "no", 11344)
            SetTask(314, 24)
            TaskNote(33, 24)
        elseif (i <= 154) then
            Talk(1, "no", 11345)
            SetTask(314, 27)
            TaskNote(33, 27)
        elseif (i <= 155) then
            Talk(1, "no", 11346)
            SetTask(314, 28)
            TaskNote(33, 28)
        elseif (i <= 156) then
            Talk(1, "no", 11347)
            SetTask(314, 29)
            TaskNote(33, 29)
        elseif (i <= 157) then
            Talk(1, "no", 11348)
            SetTask(314, 32)
            TaskNote(33, 32)
        elseif (i <= 158) then
            Talk(1, "no", 11349)
            SetTask(314, 33)
            TaskNote(33, 33)
        elseif (i <= 159) then
            Talk(1, "no", 11350)
            SetTask(314, 34)
            TaskNote(33, 34)
        elseif (i <= 160) then
            Talk(1, "no", 11351)
            SetTask(314, 37)
            TaskNote(33, 37)
        elseif (i <= 161) then
            Talk(1, "no", 11352)
            SetTask(314, 38)
            TaskNote(33, 38)
        elseif (i <= 162) then
            Talk(1, "no", 11353)
            SetTask(314, 39)
            TaskNote(33, 39)
        elseif (i <= 163) then
            Talk(1, "no", 11354)
            SetTask(314, 21)
            TaskNote(33, 21)
        elseif (i <= 164) then
            Talk(1, "no", 11355)
            SetTask(314, 25)
            TaskNote(33, 25)
        elseif (i <= 165) then
            Talk(1, "no", 11356)
            SetTask(314, 26)
            TaskNote(33, 26)
        elseif (i <= 166) then
            Talk(1, "no", 11357)
            SetTask(314, 30)
            TaskNote(33, 30)
        elseif (i <= 167) then
            Talk(1, "no", 11358)
            SetTask(314, 31)
            TaskNote(33, 31)
        elseif (i <= 168) then
            Talk(1, "no", 11359)
            SetTask(314, 35)
            TaskNote(33, 35)
        elseif (i <= 169) then
            Talk(1, "no", 11360)
            SetTask(314, 36)
            TaskNote(33, 36)
        elseif (i <= 170) then
            Talk(1, "no", 11361)
            SetTask(314, 40)
            TaskNote(33, 40)
        elseif (i <= 171) then
            Talk(1, "no", 11362)
            SetTask(314, 41)
            TaskNote(33, 41)
        end ;
    else
        local i = random(1, 181)
        if (i <= 10) then
            Talk(1, "no", 11327)
            SetTask(314, 5)
            TaskNote(33, 5)
        elseif (i <= 20) then
            Talk(1, "no", 11328)
            SetTask(314, 6)
            TaskNote(33, 6)
        elseif (i <= 30) then
            Talk(1, "no", 11329)
            SetTask(314, 7)
            TaskNote(33, 7)
        elseif (i <= 40) then
            Talk(1, "no", 11330)
            SetTask(314, 8)
            TaskNote(33, 8)
        elseif (i <= 50) then
            Talk(1, "no", 11331)
            SetTask(314, 9)
            TaskNote(33, 9)
        elseif (i <= 60) then
            Talk(1, "no", 11332)
            SetTask(314, 10)
            TaskNote(33, 10)
        elseif (i <= 70) then
            Talk(1, "no", 11333)
            SetTask(314, 11)
            TaskNote(33, 11)
        elseif (i <= 80) then
            Talk(1, "no", 11334)
            SetTask(314, 12)
            TaskNote(33, 12)
        elseif (i <= 90) then
            Talk(1, "no", 11335)
            SetTask(314, 13)
            TaskNote(33, 13)
        elseif (i <= 100) then
            Talk(1, "no", 11336)
            SetTask(314, 14)
            TaskNote(33, 14)
        elseif (i <= 110) then
            Talk(1, "no", 11337)
            SetTask(314, 15)
            TaskNote(33, 15)
        elseif (i <= 120) then
            Talk(1, "no", 11338)
            SetTask(314, 16)
            TaskNote(33, 16)
        elseif (i <= 130) then
            Talk(1, "no", 11339)
            SetTask(314, 17)
            TaskNote(33, 17)
        elseif (i <= 140) then
            Talk(1, "no", 11340)
            SetTask(314, 18)
            TaskNote(33, 18)
        elseif (i <= 150) then
            Talk(1, "no", 11341)
            SetTask(314, 19)
            TaskNote(33, 19)
        elseif (i <= 151) then
            Talk(1, "no", 11342)
            SetTask(314, 22)
            TaskNote(33, 22)
        elseif (i <= 152) then
            Talk(1, "no", 11343)
            SetTask(314, 23)
            TaskNote(33, 23)
        elseif (i <= 153) then
            Talk(1, "no", 11344)
            SetTask(314, 24)
            TaskNote(33, 24)
        elseif (i <= 154) then
            Talk(1, "no", 11345)
            SetTask(314, 27)
            TaskNote(33, 27)
        elseif (i <= 155) then
            Talk(1, "no", 11346)
            SetTask(314, 28)
            TaskNote(33, 28)
        elseif (i <= 156) then
            Talk(1, "no", 11347)
            SetTask(314, 29)
            TaskNote(33, 29)
        elseif (i <= 157) then
            Talk(1, "no", 11348)
            SetTask(314, 32)
            TaskNote(33, 32)
        elseif (i <= 158) then
            Talk(1, "no", 11349)
            SetTask(314, 33)
            TaskNote(33, 33)
        elseif (i <= 159) then
            Talk(1, "no", 11350)
            SetTask(314, 34)
            TaskNote(33, 34)
        elseif (i <= 160) then
            Talk(1, "no", 11351)
            SetTask(314, 37)
            TaskNote(33, 37)
        elseif (i <= 161) then
            Talk(1, "no", 11352)
            SetTask(314, 38)
            TaskNote(33, 38)
        elseif (i <= 162) then
            Talk(1, "no", 11353)
            SetTask(314, 39)
            TaskNote(33, 39)
        elseif (i <= 163) then
            Talk(1, "no", 11354)
            SetTask(314, 21)
            TaskNote(33, 21)
        elseif (i <= 164) then
            Talk(1, "no", 11355)
            SetTask(314, 25)
            TaskNote(33, 25)
        elseif (i <= 165) then
            Talk(1, "no", 11356)
            SetTask(314, 26)
            TaskNote(33, 26)
        elseif (i <= 166) then
            Talk(1, "no", 11357)
            SetTask(314, 30)
            TaskNote(33, 30)
        elseif (i <= 167) then
            Talk(1, "no", 11358)
            SetTask(314, 31)
            TaskNote(33, 31)
        elseif (i <= 168) then
            Talk(1, "no", 11359)
            SetTask(314, 35)
            TaskNote(33, 35)
        elseif (i <= 169) then
            Talk(1, "no", 11360)
            SetTask(314, 36)
            TaskNote(33, 36)
        elseif (i <= 170) then
            Talk(1, "no", 11361)
            SetTask(314, 40)
            TaskNote(33, 40)
        elseif (i <= 171) then
            Talk(1, "no", 11362)
            SetTask(314, 41)
            TaskNote(33, 41)
        elseif (i <= 172) then
            Talk(1, "no", 11363)
            SetTask(314, 42)
            TaskNote(33, 42)
        elseif (i <= 173) then
            Talk(1, "no", 11364)
            SetTask(314, 43)
            TaskNote(33, 43)
        elseif (i <= 174) then
            Talk(1, "no", 11365)
            SetTask(314, 44)
            TaskNote(33, 44)
        elseif (i <= 175) then
            Talk(1, "no", 11366)
            SetTask(314, 45)
            TaskNote(33, 45)
        elseif (i <= 176) then
            Talk(1, "no", 11367)
            SetTask(314, 46)
            TaskNote(33, 46)
        elseif (i <= 177) then
            Talk(1, "no", 11368)
            SetTask(314, 47)
            TaskNote(33, 47)
        elseif (i <= 178) then
            Talk(1, "no", 11369)
            SetTask(314, 48)
            TaskNote(33, 48)
        elseif (i <= 179) then
            Talk(1, "no", 11370)
            SetTask(314, 49)
            TaskNote(33, 49)
        elseif (i <= 180) then
            Talk(1, "no", 11371)
            SetTask(314, 50)
            TaskNote(33, 50)
        elseif (i <= 181) then
            Talk(1, "no", 11372)
            SetTask(314, 51)
            TaskNote(33, 51)
        end ;
        --luoyixuan
        refreshNpcTaskState()
        --luoyixuan
    end ;
    SetTask(CitanAddress, GetTask(314))
end

function no()
    CloseDialog()
end;

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊı»ıÔÜ,ÓÃÆäÊıÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ıÀÛ´ÎÊı
function offlineTotimes()
    -- modified by yaoxin for 2010-10
    local localday = floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1-- modified by yaoxin for 2010-12

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function payMoneyfree(nums)
    --	if (nums > 7) then
    --		nums = 7
    --	end
    --	local n_times = {50,50,50,100,100,100,100}
    local m = 1500 * GetLevel() --»ùÊılv*1500
    return m
end

function yes_freefsb()
    CloseDialog()
    local thisday = floor(LocalSystemTime() / 86400)
    local thistime = GetTask(315)
    if (thisday ~= thistime) then
        Talk(1, "no", "Ng­¬i ch­a nhËn nhiÖm vô nµo cho ngµy h«m nay, kh«ng cÇn n¹p tµi ®Ó tu luyÖn.")
        return 0
    end
    local addtimes = GetTaskByte(317, 2) + 1
    if (GetTaskByte(1477, 3) < addtimes) then
        Talk(1, "no", " N¹p tµi tu luyÖn hiÖn t¹i cña ng­¬i kh«ng ®ñ. NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ gióp ng­¬i c¬ héi<c=g>n¹p tµi tu luyÖn<c>, h·y n¾m b¾t nhĞ!")
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) then
        if (GetTaskByte(317, 1) < 3) then
            check_2()
            return 1
        end

        check_renwu()
        SetTaskByte(317, 2, addtimes)
        SetTaskWord(317, 2, 1)--ÄÉ²ÆÖÃÎ»£¬ÇåÁã

        Pay(apm)
        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
        Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø" .. addtimes .. " lÇn nhËn thªm nhiÖm vô Th¸m Qu©n.")
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ b¹c. Muèn lµm nhiÖm vô Th¸m Qu©n cÇn cã " .. apm .. ".")
    end
end


--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 4); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ğÌâÊıÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "»ÆÌì»¯£ºÓ¢ĞÛ±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~
--~     if (idx == 6) then
--~         Talk(1, "no", "»ÆÌì»¯£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ıµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("»ÆÌì»¯£ºÈıÖÜÄêÇìµäÕâÃ´´óµÄÊÂ£¬ÎÒ×ÔÈ»Òª³öÒ»·İÁ¦£¬ÎÒºÍÍÁĞĞËïÔç¾ÍÉÌÁ¿ºÃÁËÒª¿¼¿¼ÄãÃÇ£¬ÎÒÒ²×¼±¸ÁË¼¸¸öÎÊÌâ£¬Ó¢ĞÛÈôÄÜ»Ø´ğÆäÖĞµÄÒ»¸ö£¬ÎÒ¿ÉÒÔËÍ¸øÓ¢ĞÛÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~
--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 4); --µ±Ç°NPCµÄÌâÄ¿
--~
--~     local TABLE_Ques = {
--~         [1] = { quest = "ÓñÅåÈ¡Ëè¿ÉÒÔÔÚÄÄÀï½øĞĞ£¿",
--~                     option = { [1]  = "Ñş³Ø³àËÉ×Ó", [2] = "Ñş³ØÕÔ¹«Ã÷", [3] = "Ñş³ØÀ×Õğ×Ó", }, },
--~         [2] = { quest = "¡¶·âÉñÑİÒå¡·ÖĞ¡°Ê®¶ş½ğÏÉ¡±²»°üÀ¨ÒÔÏÂÄÄÎ»£¿",
--~                     option = { [1]  = "µÀµÂÕæ¾ı", [2] = "ÄÏ¼«ÏÉÎÌ", [3] = "Ì«ÒÒÕæÈË", }, },
--~         [3] = { quest = "ÒÔÏÂÄÄÖÖ²ÄÁÏ¿ÉÒÔÎª»êÖä¼¼ÄÜÔö¼ÓÁéÆø£¿",
--~                     option = { [1]  = "·çÁéÊ¯", [2] = "Ë®ÁéÊ¯", [3] = "ÌìÁéÊ¯", }, },
--~         [4] = { quest = "°Ù¸£ÁÙÃÅÀñ°ü100¼¶ÀñÎïÊÇÊ²Ã´£¿",
--~                     option = { [1]  = "ÈçÒâÈ¯", [2] = "½«¾üÁî", [3] = "ÃûÓñÒ»¿Å", }, },
--~         [5] = { quest = "Ê¹ÓÃÊ²Ã´¹¤¾ß¿ÉÒÔÔÚ¹ú¼ÒÀïĞŞ½¨Ó¶±øÓª£¿",
--~                     option = { [1]  = "º××ì³ú", [2] = "Â³°à¸«", [3] = "³úÍ·", }, },
--~     }
--~
--~     local seq = {1,2,3};
--~     local i, j = 0, 0;
--~     local temp = 0;
--~     for i = 1, 2 do
--~         j = random(i, 3);
--~         temp = seq[i];
--~         seq[i] = seq[j];
--~         seq[j] = temp;
--~     end
--~
--~     local opt1 = TABLE_Ques[idx].option[seq[1]].."/ThreeYears_FireWorks_Option"..seq[1];
--~     local opt2 = TABLE_Ques[idx].option[seq[2]].."/ThreeYears_FireWorks_Option"..seq[2];
--~     local opt3 = TABLE_Ques[idx].option[seq[3]].."/ThreeYears_FireWorks_Option"..seq[3];
--~
--~     Say("»ÆÌì»¯£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

--~ end


--~ function ThreeYears_FireWorks_Option1()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(1);
--~ end


--~ function ThreeYears_FireWorks_Option2()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(2);
--~ end


--~ function ThreeYears_FireWorks_Option3()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(3);
--~ end


--~ function ThreeYears_FireWorks_Judge(choice)
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 4); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 3, [2] = 2, [3] = 3, [4] = 1, [5] = 2,};
--~
--~     if (TABLE_Key[idx] == choice) then
--~
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "»ÆÌì»¯£ºÓ¢ĞÛËäÈ»´ğ¶ÔÁËÌâÄ¿£¬µ«±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "»ÆÌì»¯£ºÓ¢ĞÛ¹ûÈ»²ÅÖÇ¹ıÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ĞÛÁË¡£");
--~
--~         SetTaskByte(TASK_ThreeYears_Fireworks, 4, 6); --µ±Ç°NPCµÄÌâÄ¿
--~
--~         SetTaskByte(TASK_ThreeYears_Questions, 4, num + 1);

--~         DelNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0);
--~         AddNormalItem(8, G_ThreeYears_1stFireworksId + num + 1, 2, 0, 0, 0);

--~         if (num + 1 < 5) then
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË"..(num + 1).."·İ×£¸£");
--~         else
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË×ã¹»µÄ×£¸£");
--~             WriteLog("»ñµÃÒ»¸öÂúÔØ×£¸£µÄÀñ»¨¡£");
--~             TaskNote(1610, 1);
--~         end
--~
--~     else
--~         Talk(1, "no", "»ÆÌì»¯£ºÄãµÄ´ğ°¸²»¶Ô£¬ÇëÖØĞÂ×÷´ğ¡£");
--~     end

--~ end
--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end




