NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

Task_Catch_Wolf = 1346  --1byte: 0:Ã»ÓĞÁìÈ¡ÈÎÎñ£»1:ÁìÈ¡ÁËÈÎÎñ£»2£ºÍê³É²½Öè1ÇÒÁìÈ¡ÁË½±Àø£»3£ºÁìÈ¡ÁË²½Öè2µÄÈÎÎñ£¬4£ºÍê³É²½Öè2
--2byte:Í³¼Æ²¶×½ÊÉÀÇµÄ¸öÊı£»3byte£º²¶×½ÊÉÀÇÊ×ÁìµÄ¸öÊı£»4byte:ÁÔÉ±ÊÉÀÇµÄ¸öÊı
Wolf_TemplateID = 746    --ÊÉÀÇµÄtemplateID
Wolf_Boss_TemplateID = 885

JECT_TASK_STATE = 1291 -- byte1:type byte2:state

--ÎåÉ«»ê
Task_colorrenwu = 1355 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó 2-6(×½µ½¼¸Ö»ÍÁ»ê(½ğÄ¾Ë®»ğÍÁ)) 4byte Ö¸¶¨¹ÖÎï

--ÖØ¹éÏÉÄ§Î»
back_cele = 1379 --1byte ÈÎÎñµÄ×´Ì¬£¬2byteÈÎÎñÍê³ÉµÄ´ÎÊı
--ÈÎÎñµÄ×´Ì¬£º
--0Î´½ÓÊÜÈÎÎñ
--1½ÓÊÜÁËÈÎÎñ£¬ÌáÊ¾È¥ÕÒ¼³ÑªÑıÈ¡µÃ»ê
--2È¡µÃÁË»ê£¬ĞèÒªÈ¥É±ÊÉÀÇÈ¡µÃÆÇ
--3µÃµ½ÁËÆÇ£¬¿ÉÒÔÌá½»ÈÎÎñÁË
back_numbers = 1381 --1,2byte¼ÇÂ¼Íæ¼ÒÍê³ÉµÄÈÎÎñµÄ´ÎÊı£¬3£¬4Byte¼ÇÂ¼Íæ¼ÒÉ±ËÀÊÉÀÇµÄÊıÄ¿
--Add by gaojingwei 2009/5/20 for Á¶ÖÆµ¤Ò© start------------------
Task_Process = 1458   --1byte:1½ÓÈÎÎñ£¬2µÃµ½ÙÈ²®ÒæµÄ½±Àø£¬3ÁìÈ¡ÁÔÉ±³Ë»ÆµÄÈÎÎñ£¬4ÊÍ·Å³Ë»ÆNpc£¬5ÊÍ·ÅÕ½¶·³Ë»Æ£¬ 6Õ½Ê¤³Ë»Æ´óÍõ
--2byte:µ±Ìì½ÓÈÎÎñ´ÎÊı£»3byte:1µ¥±¶£¬2Ë«±¶£»4byte:É±ËÀ³Ë»ÆµÄ¸öÊı
Task_Type = 1459      --1byte:1½ÓµÄÊÇÃîÊÖÉñÒ½µÄÈÎÎñ£¬2½ÓµÄÊÇÁ¶ÖÆÃÔÒ©µÄÈÎÎñ
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊı
Task_Accept_Day = 1461  --½ÓÈÎÎñµÄÈÕÆÚ
Task_Coordinate = 1462  --1word:ËøÑıÕòx×ø±ê£»2word£ºy×ø±ê
Task_MonsterID = 1463    --³Ë»Æ(ÀçÁéÊ¬µÄID)
Task_Free_Time = 1464    --³Ë»Æ´óÍõ(×çÖäÖ®ÀçÁéÊ¬)µÄindex

chenghuangNpcID = 1005    --³Ë»Æ´óÍõNpcµÄtemplateID
chenghuangID = 1003        --³Ë»Æ´óÍõµÄtemplateID
lilingNpcID = 1006        --ÏÄÁéÊ¬´óÍõNpcµÄtemplateID
lilingID = 1004            --ÏÄÁéÊ¬´óÍõµÄtemplateID
amberNum = 3            --ĞèÒª½ÉÄÉµÄçúçêÖ®ĞÄµÄ¸öÊı
blastID = 1007            --ËøÑıÕòµÄID
buffID = 682            --ËøÑıÕòbuffµÄID

--add by lisuhui 2009.06.12 for TwelveIdol
Task_TwelveIdol = 1484                --1Byte:Ê®¶şÈËÅ¼ÈÎÎñ×´Ì¬ 1=½ÓÁËÈÎÎñ £¬×ª¶¯ÁËÌ«Ëê£» 2=¶ÁÈ¡15sµÄ½ø¶ÈÌõ£» 3=Ë¢¹Ö£» 4=Õ½¶·NPCËÀÍö
--2Byte:ĞÇ¾ıµÄID(0-11)
--3Byte:ÆĞÌá¾µµÄ³É³¤¶È
--4Byte:ĞÇ¾ıÃÜ¼×ÈÎÎñ×´Ì¬ 1=½ÓÈÎÎñ£»2=»½ĞÑÁËÒ»¸ö£»3=»½ĞÑÁËÁ½¸ö£»4=¡­¡­£»7=»½ĞÑÁË6¸ö£»10=µ±Ç°ÊÇÔÚ×öÊ®¶şÈËÅ¼µÄÈÎÎñ
Task_FightStarManNpcID = 1487        --Õ½¶·ĞÇ¾ıµÄid
Task_FightStarManNpcIdx = 1488        --Õ½¶·ĞÇ¾ıµÄË÷Òı
--end

--------------------Task_OutoftreeÎªÓü·¨É½Ö§ÏßÈÎÎñÈı---½ÚÍâÉúÖ¦--------------------------------------------
--------------------------Author£ºlitao  date:09/06/09------------------------------------------------------
Task_Outoftree = 1478 --1Byte£º1½ÓÈÎÎñ£¬2¶Ô»°Ğ¥À×£¬3Ê¹ÓÃ·âÓ¡Ö®¾³²¢ÇÒ¶Ô»°¶¡»Õ£¬4ÁÔÉ±Ä§ÎïÖ®»ê£¬5·âÓ¡Ö®¾³¶Ô»°²¢ÁìÈ¡½±Àø£¬6Íê³É½ÚÍâÉúÖ¦£¬6·âÓ¡Ğ¥À×£¬7¶Ô»°¶¡»Õ£¬
--8Ê¹ÓÃ·âÓ¡Ö®¾µ²¢É±Ğ¥À×£¬9¶Ô»°ÏÉÄ§ÃÜÌ½²¢Íê³É·âÓ¡Ö®¾µÈÎÎñ
--2Byte£º0Î´²¶É±µ½³Ë»ÆµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±³Ë»ÆµÄÄ§ÎïÖ®»ê
--3Byte£º0Î´²¶É±µ½ÀæÁéµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±ÀæÁéµÄÄ§ÎïÖ®»ê
--4Byte£º0Î´²¶É±µ½É½ ûµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±É½ ûµÄÄ§ÎïÖ®»ê
ID_SoulofDevil = 1113  --Ä§ÎïÖ®»êµÄID£¬
------------------------------------------------------------------------------------------------------------
------------------------------------ËÑÑ°×åÈË--------------------------------------------------
g_SearchClansMan = 1483  --   1byte  0Ã»½Ó  1½ÓÁË  2ÕĞ³öÏÉÄ§½ç³àºò 3Íê³ÉÈÎÎñ 4Ê§°Ü  5½áÊø  7ÕÙ»½³öÁË×åÈË  3byteµôÂäÁèÔªÖé¸ÅÂÊ    2byteËæ»úµÄÎ»ÖÃx 4byteËæ»úµÄÎ»ÖÃy

g_Distance = 222

g_ClansMan = 223

questyKey = {
    [1] = { name = "Canh Håi Hån", key = 250 },
    [2] = { name = "Ng­ H×nh th¶o", key = 251 },
    [3] = { name = "Long Ng¹n th¶o", key = 252 }
}

taskItem = {
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

--Add by gaojingwei 2009/5/20 for Á¶ÖÆµ¤Ò© end------------------

-- add by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·
Global_War_Event_State = 212            -- |1byte:0=ÖĞÁ¢ 1=ÏÉ 2=Ä§|2byte:0=ÎŞÊÂ¼ş 1=ÊÂ¼şÖĞ 2=ÊÂ¼şÆô¶¯|

TASK_SOUL = 1476            -- Byte1:state Byte2:accept count Byte3:accept time Byte4 kill monster type

SOUL_NPC_TEMPLETE = 47
SOUL_MAX_ACC_TIMES = 3
SOUL_TASK_CAMP_JUSTICE = 1
SOUL_TASK_CAMP_EVIL = 2
SOUL_TASK_BUFF = 702
SOUL_TASK_ITEM_1 = 708
SOUL_TASK_ITEM_2 = 707
CREDIT_LIMIT_MAX = 180000
CREDIT_LIMIT_MIN = 45000
SOUL_ACC_ITEM_J = 428
SOUL_ACC_ITEM_E = 427
ACC_ITEM_COUNT = 5
SOUL_TASK_IB_ITEM = 706
SOUL_TASK_IB_INDEX = 116

PLAYER_RELEASE_SOUL_BUFF = 704
NPC_RELEASE_SOUL_BUFF = 703
PLAYER_CONFUSE_BUFF = 705

aryMonsterType = {
    { name = "ThiÕt Tinh", id = 930 },
    { name = "KhØ nói", id = 933 },
    { name = "Tiªn - Lª Linh Thi", id = 931 },
    { name = "Ma - Lª Linh Thi", id = 932 },
}
-- end by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·

-- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 begin
Task_epistle = 1651  --1byte È¾ÑªµÄÒÅÊé (´ÎÊıÊÇ10µÄ±¶Êı£¬Àı10¡¢20¡¢30...100²½ÖèÊÇ¸÷Î»1µÃµ½²¢´ò¿ª2²É²İ3Íê³É4µÃµ½ÒÅÎï)£»
--2byte ÓÂÕßµÄÅäÊÎ 3byte²ĞÈ±µÄÓñÅå4byte¹Å¾ÉµÄÊé¾í ¶¼ (´ÎÊıÊÇ10µÄ±¶Êı) £¬4µÃµ½ÒÅÎï
--ÓÀ¾øºó»¼ 1byte 5ÎªÈ¥ÕÒµ½Ñß²®Òæ 6ÎªÈ¥»÷°ÜÓü·¨É½Éñ 7»÷°Ü»ØÀ´½»ÈÎÎñ£¬ 8ÎªÍê³ÉÁì½±
-- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 end

function OnDeath(npcindex)
    if (PlayerIndex <= 0) then
        return
    end

    --Added by Fengce at 2009-6-11--
    -----´ò¹ÖµôÁèÔªÖé-------
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    if (GetTaskByte(g_SearchClansMan, 1) == 1 and IsExistItem(6, 1, 526, 0) == 0) then
        --
        local growth = GetTaskByte(g_SearchClansMan, 3)
        if random(1, 100) <= growth then
            ClearItem(6, 1, 526, 0)

            AddNormalItem(6, 1, 526, 0, 0, 0)
            TopMessage("NhËn 1 <c=yel>L¨ng Nguyªn Ch©u<c>")
            Msg2Player("B¹n nhËn ®­îc 1 L¨ng Nguyªn Ch©u")
            SetTaskByte(g_SearchClansMan, 3, 3)
            --SetTask(378,-1) --µØÍ¼×ø±ê ÉèÖÃdistance
            TaskNote(109, 1)
        else
            growth = growth + 3
            SetTaskByte(g_SearchClansMan, 3, growth)
        end
    end

    --end ---

    -- Added by Zhaoqingsong at 2009-3-11 Begin
    processSpiritRay(npcindex)
    -- Added by Zhaoqingsong at 2009-3-11 End
    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end ;

    -- Added by Gaojignwei at 2009-3-16 Begin
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    local bossNum = GetTaskByte(Task_Catch_Wolf, 3)
    local id, x, y = GetNpcWorldPos(npcindex)
    if (step == 3 and bossNum < 3) then
        local monsterNum = GetTaskByte(Task_Catch_Wolf, 4)
        monsterNum = monsterNum + 1
        SetTaskByte(Task_Catch_Wolf, 4, monsterNum)
        Msg2Player(" ®· tiªu diÖt " .. monsterNum .. "Sãi")
        if (monsterNum == 20) then
            SetTaskByte(Task_Catch_Wolf, 4, 0)
            local monsterNpcIdx = AddNpc(885, 60, SubWorldID2Idx(id), x * 32, y * 32)        --Ôö¼ÓÒ»Ö»¹Ö
            SetNpcScript(monsterNpcIdx, "\\script\\¹ÖÎï\\ÊÉÀÇÍ·Áì.lua")
            SetNpcTimer(monsterNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)
            TopMessage("<c=g>Sãi chóa<c> xuÊt hiÖn")
            Msg2Player("Sãi chóa xuÊt hiÖn")
        end
    end
    -- Added by Gaojingwei at 2009-3-16 end

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 8) then
        jeCreditTask()--ÏÉÄ§ÉùÍûÈÎÎñ
    end
    -- Added by Zhaoqingsong at 2009-3-18 Begin
    processTopTower(npcindex)
    -- Added by Zhaoqingsong at 2009-3-18 End

    -- Added by LaiYongcong at 2009-4-14 Begin
    --	if (HaveIBBuff(641) ~= 0 and GetTaskByte(back_cele,1) ~=0) then
    --		processBack_celestial(npcindex)
    --	end
    -- Added by LaiYongcong at 2009-4-14 end

    --ÎåÉ«»ê
    if (GetTaskByte(Task_colorrenwu, 4) == 2) and (GetTaskByte(Task_colorrenwu, 3) < 6) and (HaveIBBuff(569) > 0) then
        renwu31_fivecolor(x, y, mob_lvl)
    end

    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 begin
    if GetTaskByte(Task_Type, 1) == 2 then
        --Ö»ÄÜÕĞ³öÀ´Ò»´Î
        local nStep = GetTaskByte(Task_Process, 1)
        if nStep == 3 then
            superDoctor(npcindex)
        elseif nStep == 4 or nStep == 5 then
            if GetTask(Task_MonsterID) == GetNpcID(GetTask(Task_Free_Time)) and GetTask(Task_Free_Time) > 0 then

            else
                superDoctor(npcindex)
            end
        end
    end
    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 end

    -- add by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·
    soulBackhome(npcindex)
    -- end by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·

    --add by lisuhui 2009.06.14 for Ê®¶şÈËÅ¼
    TwelveIdol(npcindex)
    --add by lisuhui 2009.06.14

    --Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ strat---
    if (GetTaskByte(Task_Outoftree, 1) == 3) then
        local RandofSoul = random(1, 5)--20%µÄ¸ÅÂÊË¢³öÄ§ÎïÖ®»ê
        --Ö»ÓĞµ±Íæ¼Ò»¹Ã»ÓĞÕÙ»½ÕâÖÖ¹ÖÎïµÄÄ§ÎïÖ®»êÊ±
        if (GetTaskByte(Task_Outoftree, 3) == 0) then
            if RandofSoul == 1 then
                AddSoulofDevil(npcindex)
            end
        else
            Msg2Player("Hån Lª Linh Thi ®· bŞ khèng chÕ, xin tranh thñ thêi gian khèng chÕ c¸c hån ph¸ch Ma vËt kh¸c")
            TopMessage("Hån Lª Linh Thi ®· bŞ b¾t")
        end
    end
    --Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ end---

    -- Added by Zhaoqingsong at 2009-6-23 begin
    processYinGuoLunHui(npcindex)
    -- Added by Zhaoqingsong at 2009-6-23 end

    -- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 begin
    if (GetPlayerExtLevel() > 55) and (GetTaskByte(Task_epistle, 3) < 100) then
        yufashan_renwu()
    end
    -- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 end
end;

---------------------------------------------------------------------------------------------------------
--add by lisuhui 2009.06.12 for TwelveIdol (Ê®¶şÈËÅ¼)
function TwelveIdol(npcindex)
    local nTask = GetTaskByte(Task_TwelveIdol, 1)
    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    if (nGrowth >= 100) then
        SetTaskByte(Task_TwelveIdol, 3, 100)
        return
    end

    if (nTask == 3 and HaveIBBuff(713) > 0 and IsExistItem(6, 1, 528, 0) > 0 and IsInScope(npcindex) == 1) then
        AddGrowth()
    end
end

function IsInScope(npcindex)
    local NpcIdx = 0
    if (GetJusticEvilCredit() > 0) then
        NpcIdx = 1127
    else
        NpcIdx = 1128
    end

    local oldnpcidx = GetTask(Task_FightStarManNpcIdx)
    if (oldnpcidx ~= 0) then
        local oldnpcid = GetTask(Task_FightStarManNpcID)
        if (GetNpcID(oldnpcidx) == oldnpcid and GetNpcTemplateID(oldnpcidx) == NpcIdx) then

            local mapid, x, y = GetNpcWorldPos(npcindex)
            local mapidnpc, xnpc, ynpc = GetNpcWorldPos(oldnpcidx)

            if (mapid == mapidnpc) then
                local nDis = sqrt((x * 32 - xnpc * 32) ^ 2 + (y * 32 - ynpc * 32) ^ 2)
                if (nDis <= 600) then
                    return 1
                end

            end

        end
    end

    return 0
end

--¸ù¾İ¸ÅÂÊÔö¼Ó³É³¤¶È
function AddGrowth()
    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    local nAddPoint = random(1, 20)

    if (nAddPoint < 4) then
        nAddPoint = 2
    elseif (nAddPoint < 13) then
        nAddPoint = 5
    elseif (nAddPoint > 6) then
        nAddPoint = 10
    end

    SetTaskByte(Task_TwelveIdol, 3, nGrowth + nAddPoint)
    TopMessage("Kİnh Bå §Ò ®· tr­ëng thµnh" .. nAddPoint .. "%")

    local nTwelveStar = GetTaskByte(Task_TwelveIdol, 4)
    if (nTwelveStar == 10) then
        TaskNote(1084, 4, (nGrowth + nAddPoint))
    else
        TaskNote(1085, 7, (nGrowth + nAddPoint))
    end

    if (nGrowth + nAddPoint >= 100) then
        Talk(1, "no", "Kİnh Bå §Ò cho biÕt, Tinh qu©n ®· håi phôc ph¸p lùc, tØnh l¹i hoµn toµn, mau ®Õn b¸o cho YÓn Thóc Di.")
        SetTaskByte(Task_TwelveIdol, 3, 100)

        if (nTwelveStar == 10) then
            TaskNote(1084, 3)
        else
            if (nTwelveStar == 7) then
                TaskNote(1085, 6)
            else
                TaskNote(1085, 5)
            end
        end
    end

    local nDragonHorn = random(1, 1000)
    if (nDragonHorn == 1) then
        AddNormalItem(3, 448, 0, 0, 0, 0)                                    --»ñµÃ²ÔÁú½Ç
        TopMessage("NhËn 1 <c=yel>Th­¬ng Long Gi¸c")
    end
end

function no()
    CloseDialog()
end
--end
--------------------------------------------------------------------------------------------------------------------


-- add by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·
function soulBackhome(npcindex)

    local nState = GetTaskByte(TASK_SOUL, 1)
    if (nState == 0) then
        return
    end

    local nType = GetTaskByte(TASK_SOUL, 4)
    if (npcindex <= 0) or (GetNpcTemplateID(npcindex) ~= aryMonsterType[nType].id) then
        Msg2Player("Ma vËt b¹n thu phôc kh«ng ph¶i do téc nh©n Di Ph­¬ng mª muéi hãa thµnh, kh«ng cÇn gi¶i cøu hån ph¸ch.")
        return
    end

    local nCurCamp = GetCurCamp()
    if ((nState == SOUL_TASK_CAMP_JUSTICE) and (nCurCamp ~= 3)) or ((nState == SOUL_TASK_CAMP_EVIL) and (nCurCamp ~= 4)) then
        Msg2Player("Phe PK hiÖn t¹i kh«ng phï hîp víi yªu cÇu nhiÖm vô, kh«ng thÓ gióp hån ph¸ch téc nh©n ®­îc siªu tho¸t.")
        return
    end

    local nSoulCount = HaveEffectNpc(SOUL_NPC_TEMPLETE)
    if (nSoulCount >= 5) then
        Msg2Player("Sè hån ph¸ch téc nh©n ®­îc gi¶i cøu ®· ®¹t tèi ®a, kh«ng thÓ gi¶i cøu thªm.")
        return
    end

    if (HaveIBBuff(PLAYER_RELEASE_SOUL_BUFF) <= 0) then
        Msg2Player("B¹n ch­a dïng TØnh ThÇn §¬n víi ma vËt ®­îc thu phôc, nªn ch­a thÓ siªu tho¸t hån ph¸ch téc nh©n.")
        return
    end

    if (NpcHaveIBBuff(npcindex, NPC_RELEASE_SOUL_BUFF) <= 0) then
        Msg2Player("Ma vËt b¹n thu phôc ch­a ®­îc tŞnh hãa, nªn kh«ng thÓ gi¶i tho¸t cho hån ph¸ch téc nh©n.")
        return
    end

    local nRank = random(1, 100)
    if (nRank <= 60) then
        if (nSoulCount <= 0) then
            if (nState == SOUL_TASK_CAMP_JUSTICE) then
                SetEffectNpc("<c=water>Hån ph¸ch téc nh©n<c>", SOUL_NPC_TEMPLETE, 0)
            else
                SetEffectNpc("<c=yel>Hån ph¸ch téc nh©n<c>", SOUL_NPC_TEMPLETE, 0)
            end
        else
            SetEffectNpcCount(nSoulCount + 1)
        end

        Msg2Player("B¹n ®· gi¶i cøu thµnh c«ng hån ph¸ch 1 téc nh©n Di Ph­¬ng, h¾n sÏ theo b¹n ®Õn khi vÒ ®­îc bé téc.")
        ScrollMessage("NhËn 1 Hån ph¸ch téc nh©n")
    else
        if (HaveIBBuff(PLAYER_CONFUSE_BUFF) > 0) then
            RemoveIBBuff(PLAYER_CONFUSE_BUFF)
        end

        if (GetMorphType() == aryMonsterType[nType].id) then
            PolyMorph(-1, 0, 0, 0, 0)
        end

        if (GetMorphType() <= 0) then
            PolyMorph(aryMonsterType[nType].id, 1, 0, -1, 10)
        end

        AddIBBuff(PLAYER_CONFUSE_BUFF)

        Msg2Player("Ma vËt kh«ng ph¶i do téc nh©n mÊt trİ hãa thµnh, TØnh ThÇn §¬n v« hiÖu, nh­ng t©m trİ cña b¹n bŞ ¶nh h­ëng bëi Tµ Ma Cæ cña chóng, c¬ thÓ t¹m thêi mÊt kiÓm so¸t.")
        TopMessage("BŞ ¶nh h­ëng bëi Tµ Ma Cæ, t©m trİ bŞ mª muéi")
    end

    NpcRemoveIBBuff(npcindex, NPC_RELEASE_SOUL_BUFF)

end
-- end by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·

--Á¶ÖÆµ¤Ò©ÈÎÎñ start----------
function superDoctor(npcindex)
    local monsterNum = GetTaskByte(Task_Process, 4)
    local rand = random(1, 100)
    local amberItem = taskItem[3].Item
    local pro = 0
    if (GetJusticEvilCredit() > 0) then
        pro = 8
    else
        pro = 2
    end
    if (rand < pro) then
        AddNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4], 0, 0)
        ScrollMessage("§­îc 1 hån Hæ Ph¸ch")
    end

    monsterNum = monsterNum + 1
    if (monsterNum >= 255) then
        --·ÀÖ¹Òç³ö
        monsterNum = 16
    end
    SetTaskByte(Task_Process, 4, monsterNum)

    local r = random(1, 100)
    if (monsterNum <= 7) then
        --???¸ù¾İÉ±¹ÖµÄ¸öÊıÀ´¾ö¶¨¸ÅÂÊ
        if (r < 0) then
            callBoss(npcindex)
        end
    elseif (monsterNum <= 15) then
        if (r < 5) then
            callBoss(npcindex)
        end
    else
        if (r < 10) then
            callBoss(npcindex)
        end
    end
end

function callBoss(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local monsterIndex = AddNpc(lilingNpcID, 1, SubWorldID2Idx(id), x * 32, y * 32)
    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 begin
    if (monsterIndex > 0) then
        SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\npc×çÖäÖ®ÀçÁéÊ¬.lua")
        SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        SetNpcName(monsterIndex, "Lª Linh Thi phï chó")

        SetTaskByte(Task_Process, 1, 4)
        SetTask(Task_MonsterID, GetNpcID(monsterIndex))
        SetTask(Task_Free_Time, monsterIndex)
        Msg2Player("§· dô ra Lª Linh Thi")
        TopMessage("§· dô ra Lª Linh Thi")
        TaskNote(1078, 4)
        WriteLog(GetName() .. "Lª Linh Thi Chó (Ma) xuÊt hiÖn, b¶n ®å:" .. id .. ", täa ®é:" .. x .. "," .. y .. ".")
    end
    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 end
end
--Á¶ÖÆµ¤Ò©ÈÎÎñ end----------

--ÖØ¹éÏÉÄ§Î»ÈÎÎñ
function processBack_celestial(npcindex)

    local nNpcidx = GetTask(1382)
    local nNpcId = GetNpcID(nNpcidx)
    if (nNpcId == GetTask(1383)) and (nNpcId ~= 0) then
        return
    end

    local zhenying = GetJusticEvilCredit()--»ñµÃÍæ¼ÒÕóÓª
    if (zhenying == 0) then
        return
    end

    local shilang_num = min(GetTaskByte(back_numbers, 4), 100)--É±ËÀÊıÄ¿£¬Ö»ÓÃ¼ÇÂ¼µ½100¼´¿É
    SetTaskByte(back_numbers, 4, shilang_num + 1)        --É±ËÀÊıÄ¿¼ÓÒ»
    local finishtimes = GetTaskByte(back_cele, 2)--½ñÌìÊÇÍæ¼ÒµÚ¼¸´ÎÈÎÎñ
    local id, x, y = GetNpcWorldPos(npcindex)

    --¼ÆËã¸ÅÂÊ
    local rate = 0
    if (finishtimes > 4) then
        rate = 8 + shilang_num    --³õÊ¼8%£¬É±Ò»¸öÔö¼Ó1£¬ÉÏÏŞ20%
        rate = (rate < 20) and rate or 20
    else
        rate = 6 + shilang_num    --³õÊ¼6%£¬É±Ò»¸öÔö¼Ó1£¬ÉÏÏŞ15%
        rate = (rate < 15) and rate or 15
    end

    if (random(1, 100) <= rate) then
        local m_npcIdx = 861
        local npcType = -1    ---ÓëÕóÓªÏà¶ÔÓ¦£¬1±íÊ¾ÏÉ½ç£¬-1±íÊ¾Ä§½ç
        local msg = "Du hån D­¬ng S©m"
        if (zhenying > 0) then
            m_npcIdx = 862
            msg = "Du hån Kim Tra"
            TaskNote(1040, 4)
            npcType = 1
        else
            TaskNote(1041, 4)
        end

        local monsterNpcIdx = AddNpc(m_npcIdx, 40, SubWorldID2Idx(id), x * 32, y * 32)        --Ìí¼ÓÄ¾ß¸»òÕßÑîÉ­
        SetNpcScript(monsterNpcIdx, "\\script\\²»ÖÜÉ½\\ÓÎÀëÖ®ÆÇ.lua")
        SetNpcTimer(monsterNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)
        SetNpcName(monsterNpcIdx, msg)
        TopMessage("<c=g>" .. msg .. "<c> xuÊt hiÖn")
        Msg2Player(msg .. " XuÊt hiÖn, ®èi tho¹i víi h¾n ®Ó ®æi Hån Ph¸ch Tinh")
        SetTask(1382, monsterNpcIdx)                    --°ó¶¨NPCindexµ½ÈÎÎñ±äÁ¿1382
        SetTask(1383, GetNpcID(monsterNpcIdx))        --°ó¶¨NPCIDµ½ÈÎÎñ±äÁ¿1383
        SetNpcTask(monsterNpcIdx, 1, npcType)            --°ó¶¨npcµÄÀàĞÍ
    end
end


--ÏÉÄ§ÉùÍûÈÎÎñ
function jeCreditTask()

    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    if (nType == 1) then

        local nLimite = 0

        if (GetCamp() ~= 3) then
            Msg2Player("Phe PK l·nh ®Şa cña b¹n ph¶i lµ mµu xanh míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Tiªn).")
        else
            if (HaveIBBuff(565) == 1) then
                nLimite = 80
            elseif (HaveIBBuff(564) == 1) then
                nLimite = 40
            elseif (HaveIBBuff(563) == 1) then
                nLimite = 20
            else
                Msg2Player("B¹n ph¶i cã ®­îc tr¹ng th¸i Chóc Dung míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Tiªn).")
            end
        end

        local nRand = random(1, 100)
        if (nRand <= nLimite) then
            AddNormalItem(6, 1, 433, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 433, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1021, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (hoµn thµnh)")
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Tiªn giíi ChiÕn kú.")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (" .. nCount .. "/ 5 )")

            if (nRand <= nLimite) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Tiªn), cÇn cã 5 m¶nh míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")
            end

        end

    elseif (nType == 2) then

        local nLimite = 0

        if (GetCamp() ~= 4) then
            Msg2Player("Phe PK l·nh ®Şa cña b¹n ph¶i lµ mµu vµng míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Ma).")
        else
            if (HaveIBBuff(565) == 1) then
                nLimite = 80
            elseif (HaveIBBuff(564) == 1) then
                nLimite = 40
            elseif (HaveIBBuff(563) == 1) then
                nLimite = 20
            else
                Msg2Player("B¹n ph¶i cã ®­îc tr¹ng th¸i Chóc Dung míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Ma).")
            end
        end

        local nRand = random(1, 100)
        if (nRand <= nLimite) then
            AddNormalItem(6, 1, 434, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 434, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1022, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (hoµn thµnh)")
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Ma giíi ChiÕn kú.")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/ 5 )")

            if (nRand <= nLimite) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end

        end

    end

end

-- Added by zhaoqingsong at 2009-3-11 Begin
-- ·¨Æ÷¿ª¹â£¬Áé¹âÕ§ÏÖ

Task_SpiritRay = 1338 -- Áé¹âÕ§ÏÖ 1byte ÈÎÎñ×´Ì¬£»2byte ÌìµØÈËÈı»êÖé»ñµÃ±êÖ¾
F11_SpiritRay = 1030   -- Áé¹âÕ§ÏÖF11

Bead_Obtain_Idx = 3

Bead_Obtain = {
    { name = "Ninh Miªu", obtainBit = 8 + 1, total = 40, ratio = 1, gen = { 4, 215, 0, 0, 0, 0 }, item = "<c=yel>Nh©n Hån Ch©u<c>" },
    { name = "Phong Yªu", obtainBit = 8 + 2, total = 20, ratio = 1, gen = { 4, 216, 0, 0, 0, 0 }, item = "<c=yel>§Şa Hån Ch©u<c>" },
    { name = "Sãi", obtainBit = 8 + 3, total = 8, ratio = 1, gen = { 4, 217, 0, 0, 0, 0 }, item = "<c=yel>Thiªn Hån Ch©u<c>" },
}

function processSpiritRay(npcindex)
    local taskStatus = GetTaskByte(Task_SpiritRay, 1)
    local obtainFlag = GetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit)
    if (taskStatus ~= 1 or obtainFlag == 1) then
        return
    end
    local rand = random(1, Bead_Obtain[Bead_Obtain_Idx].total)
    if (rand <= Bead_Obtain[Bead_Obtain_Idx].ratio) then
        SetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit, 1)
        local obtainTotal = GetTaskByte(Task_SpiritRay, 2)
        TaskNote(F11_SpiritRay, obtainTotal)
        local p1, p2, p3, p4, p5, p6 = myunpack(Bead_Obtain[Bead_Obtain_Idx].gen)
        AddNormalItem(p1, p2, p3, p4, p5, p6)
        TopMessage("NhËn ®­îc" .. Bead_Obtain[Bead_Obtain_Idx].item .. "!")
        Msg2Player("NhËn ®­îc 1 viªn" .. Bead_Obtain[Bead_Obtain_Idx].item .. ".")
    end
end

-- ·µ»ØÊı×éµÄËùÓĞÔªËØ,×Ô¶¨Òåº¯Êı
function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

-- Added by zhaoqingsong at 2009-3-11 end

-- Added by zhaoqingsong at 2009-3-18 Begin
-- Ã¿ÈÕÑ­»·ÈÎÎñ£¬ÇæÌìÖ®Ëş

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ£¬2 ÈÎÎñÍê³É
-- 2 Byte ÈÎÎñÀàĞÍ£¬1 Õ½±¸Îï×Ê£¬2 À©³ä¾ü±¸
-- 3 Byte ÁÔÉ±¹ÖÎï±àºÅ
-- 4 Byte »ñµÃ²»ÖÜÉ½Ê¯ÊıÁ¿
Task_Tower_Status = 1347

Global_Tower = 177

Task_Info_Tower = 1032    -- F11

Tower_Boss_Idx = 3

Tower_Boss = {
    { name = "Tiªn Phong Yªu" }, --1
    { name = "Ma Phong Yªu" }, --2
    { name = "Sãi" }, --3
    { name = "Tiªn Phong thó s¬n hån" }, --4
    { name = "Ma Phong thó s¬n hån" }, --5
    { name = "HuyÕt Yªu" }, --6
}

Tower_Obtain = {
    { desc = "Khèng chÕ 1 th¸p", total = 100, ratio = 10 },
    { desc = "Khèng chÕ 2 th¸p", total = 100, ratio = 20 },
    { desc = "Khèng chÕ 3 th¸p", total = 100, ratio = 80 },
}

Tower_Rule = {
    { desc = "NhiÖm vô Tiªn giíi", name = "VËt t­ chiÕn bŞ", symbol = 1, gd = "Tiªn", npc = "Phï BËt §¹o Nh©n", camp = 3, campName = "Lam", award = "BÊt Chu HuyÒn ThiÕt", gen = { 3, 361 } },
    { desc = "NhiÖm vô Ma giíi", name = "T¨ng qu©n bŞ", symbol = -1, gd = "Ma", npc = "Lı H­ng B¸", camp = 4, campName = "Hoµng", award = "BÊt Chu Tinh Cang", gen = { 3, 362 } },
}

Tower_Buff_Rule = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177 },
    { desc = "Ma ph¸i", name = "", gtask = 178 },
}

function processTopTower(npcindex)
    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    local taskType = GetTaskByte(Task_Tower_Status, 2)
    local taskBossIdx = GetTaskByte(Task_Tower_Status, 3)
    local getStore = GetTaskByte(Task_Tower_Status, 4)
    if (taskStatus ~= 1 or taskBossIdx ~= Tower_Boss_Idx) then
        return
    end
    if (GetCamp() ~= Tower_Rule[taskType].camp) then
        Msg2Player("Phe PK l·nh ®Şa cña b¹n ph¶i thuéc" .. Tower_Rule[taskType].campName .. ", míi cã thÓ nhËn ®­îc BÊt Chu S¬n th¹ch")
        return
    end
    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    local controlTower = GetGlobalValue(Tower_Buff_Rule[gdCamp].gtask)
    if (controlTower == 0) then
        Msg2Player("B¹n ph¶i nhËn ®­îc tr¹ng th¸i cña Chóc Dung míi cã thÓ nhËn ®­îc BÊt Chu S¬n th¹ch")
        return
    end

    local rand = random(1, 100)
    controlTower = (controlTower > 3 and 3) or controlTower
    if (rand <= Tower_Obtain[controlTower].ratio) then
        getStore = getStore + 1
        SetTaskByte(Task_Tower_Status, 4, getStore)
        AddNormalItemPile(4, 218, 0, 0, 0, 0)
        if (getStore >= 10) then
            SetTaskByte(Task_Tower_Status, 1, 2)
            TaskNote(Task_Info_Tower + taskType, 1)
            ScrollMessage("BÊt Chu S¬n th¹ch ®· thu thËp ®Çy ®ñ!")
            Msg2Player("NhËn ®­îc1 BÊt Chu S¬n th¹ch, ®· nhËn ®­îc" .. getStore .. ", cã thÓ vÒ phôc mÖnh" .. Tower_Rule[taskType].npc .. "!")
        else
            TaskNote(Task_Info_Tower + taskType, 0, Tower_Boss[taskBossIdx].name, getStore)
            ScrollMessage("NhËn ®­îc 1 BÊt Chu S¬n th¹ch, tæng céng ®· cã" .. getStore .. " / 10 m¶nh")
        end
    end
end

-- Added by zhaoqingsong at 2009-3-18 end

--ÎåÉ«»ê
function renwu31_fivecolor(px, py, npclvl)
    local state = GetTaskByte(Task_colorrenwu, 3)
    if (state >= 6) or (state <= 0) then
        return 0
    end

    local r = random(1, 5)
    if (r <= 1) then
        --1/5 ĞèÒªÀÛ¼ÆÍê³É50´Î
        local list = {}
        local j = 0
        for i = 1, 5 do
            if (HaveEventItem(223 + i) == 0) then
                list[j] = i
                j = j + 1
            end
        end

        local rcolor = random(0, j - 1)
        local bossnpcidx = AddNpc(list[rcolor] + 902, npclvl, SubWorld, px * 32, py * 32)
        if (bossnpcidx > 0) then
            SetNpcScript(bossnpcidx, "\\script\\¹ÖÎï\\ÍÁ»ê.lua")
            SetNpcTask(bossnpcidx, 1, GetPlayerID())
            SetNpcName(bossnpcidx, "<c=g>Hung thó Sãi<c>")
            ScrollMessage("Phãng thİch 1 Hung thó.")
            Msg2Player("Phãng thİch 1 Hung thó, c¨n cø thuéc tİnh tÊn c«ng cña nã lùa chän c¸ch b¾t thİch hîp.")
        end
    end
end

--Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ strat---
function AddSoulofDevil(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local SoulofDevilIndex = AddNpc(ID_SoulofDevil, 55, SubWorld, x * 32, y * 32)
    SetGuardLevel(SoulofDevilIndex, 2)
    SetNpcTask(SoulofDevilIndex, 1, 2)
    SetNpcScript(SoulofDevilIndex, "\\script\\¹ÖÎï\\death.lua")
    SetNpcTimer(SoulofDevilIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 10)
    SetNpcName(SoulofDevilIndex, "Hån Lª Linh Thi")
end
--Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ end---

-- Added by zhaoqingsong at 2009-6-22 Begin
-- 65¼¶Ö÷Ïß£¬Òò¹ûÂÖ»Ø

-- 1Byte£º0Î´½Ó¡¢1µÃµ½ĞŞĞĞÊ¦Ö¸Òı¡¢2´ò¿ª´«ËÍÃÅ¡¢3´«ËÍµ½½ª×ÓÑÀ´¦
--        4»ñµÃ½ª×ÓÑÀµÀ¾ßºÓÍ¼ÂåÊé¡¢5Ó¤Áé±äÉíÊ§Ğ§¡¢6»Ö¸´±¾Éí¡¢7¼¤»îÁË·¨Öù¡¢8Õ÷·ş·üôË¡¢10Íê³É
Task_YinGuoLunHui = 1489
Task_LunHui_Time = 1490

Conf_LH_Npc_Trap = 1146
Conf_LH_Npc_Soul = 468
Conf_LH_Npc_Penstock = 1144
Conf_LH_Npc_FXDialog = 1142
Conf_LH_Npc_FXFight = 1143

Conf_LH_Npc_Self = {
    [0] = { [0] = 1147, [1] = 1148 }, --¼×Ê¿
    [1] = { [0] = 1149, [1] = 1150 }, --µÀÊ¿
    [2] = { [0] = 1151, [1] = 1152 }, --ÒìÈË
}

Conf_LH_Buff_A = 717    -- ´«ËÍ
Conf_LH_Buff_B = 718    -- ±äÉí
Conf_LH_Buff_C = 719    -- ·üôË¶Ô»°
Conf_LH_Buff_D = 720    -- ·üôËÕ½¶·
Conf_LH_Buff_E = 721    -- ·¨Öù

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --¼×Ê¿
    [1] = { task = 1, note = 87 }, --µÀÊ¿
    [2] = { task = 2, note = 88 }, --ÒìÈË
}

function processYinGuoLunHui(npcindex)
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    if (taskYinGuoLunHui ~= 1 and taskYinGuoLunHui ~= 5) then
        return
    end
    if (GetFreeNpcCount() <= 200) then
        return
    end
    if (GetIBBuffCount() >= 31) then
        return
    end
    local id, x, y = GetNpcWorldPos(npcindex)
    if (id ~= 75) then
        return
    end

    local num = GetTaskByte(Task_YinGuoLunHui, 4) --by songlei 2009,11,6
    local rand = random(1, 100)
    if (rand <= num) then
        local w, x, y = GetWorldPos()
        local newidx = AddNpc(Conf_LH_Npc_Trap, 65, SubWorld, x * 32 + 32, y * 32 + 32)
        if (newidx > 0) then
            if (taskYinGuoLunHui == 1) then
                SetTaskByte(Task_YinGuoLunHui, 1, 2)
                TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 39)
            end
            AddIBBuff(Conf_LH_Buff_A, 60 * 1)
            SetNpcScript(newidx, "\\script\\Óü·¨É½\\Òò¹ûÂÖ»Ø´«ËÍÃÅ.lua")
            SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 1)
            SetNpcTask(newidx, 1, GetPlayerID())
            SetNpcName(newidx, "<c=g>Nh©n qu¶ lu©n håi truyÒn tèng m«n<c>")
            TopMessage("XuÊt hiÖn 1 Lu©n håi truyÒn tèng m«n")
            Msg2Player("XuÊt hiÖn 1 Lu©n håi truyÒn tèng m«n, cã thÓ truyÒn tèng ®Õn thÕ giíi kh¸c.")
            SetTaskByte(Task_YinGuoLunHui, 4, 0) --by songlei 2009,11,6
        end
    else
        --by songlei 2009,11,6
        num = num + 1
        SetTaskByte(Task_YinGuoLunHui, 4, num)
    end
end

-- Added by zhaoqingsong at 2009-6-22 end

-- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 begin
function yufashan_renwu()
    local temp = GetTaskByte(Task_epistle, 3) -- È¾ÑªµÄÒÅÊé ÁÙÊ±ÈÎÎñ±äÁ¿
    local times = floor(temp / 10) -- ×öµÄÀÛ¼Æ´ÎÊı
    local state = mod(temp, 10) --ÈÎÎñ²½Öè×´Ì¬

    if (times >= 10) then
        --×î¶à10´Î
        return 0
    end

    local rluck = random(1, 1000)--10%µÄ¸ÅÂÊ
    if (state == 3 or state == 4) then
        local luckyValue = 5 --Ê×´Î3%£¬ÆäÓà0.5%
        if (times == 0) then
            luckyValue = 30
        end

        if (rluck <= luckyValue) and (HaveEventItem(298) == 0) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                --ÂúÁË²»¼Ó
                return 0
            end

            AddEventItem(298)
            ScrollMessage("NhËn ®­îc <c=r>Ngäc Béi vì")
            Msg2Player("§¸nh b¹i Lª Linh Thi, may m¾n nhÆt ®­îc 1 Ngäc Béi vì")
        end
    end
end
-- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 end