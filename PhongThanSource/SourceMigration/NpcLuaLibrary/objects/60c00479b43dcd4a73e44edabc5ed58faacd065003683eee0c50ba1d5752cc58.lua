--³Ë»ÆµÄËÀÍö½Å±¾
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

--Add by gaojingwei at 2009/05/20 start-----
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
g_SearchClansMan = 1483  --   1byte  0Ã»½Ó  1½ÓÁË  2ÕĞ³öÏÉÄ§½ç³àºò 3Íê³ÉÈÎÎñ 4Ê§°Ü  5½áÊø  7ÕÙ»½³öÁË×åÈË  3byteµôÂäÁèÔªÖé¸ÅÂÊ    2byte x 4byte y

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
--Add by gaojingwei at 2009/05/20 end-----

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
Task_epistle = 1651  --1byte È¾ÑªµÄÒÅÊé (´ÎÊıÊÇ10µÄ±¶Êı£¬Àı10¡¢20¡¢30...100²½ÖèÊÇ¸÷Î»1µÃµ½²¢´ò¿ª2²É²İ3Íê³É)£»
--2byte ÓÂÕßµÄÅäÊÎ 3byte²ĞÈ±µÄÓñÅå4byte¹Å¾ÉµÄÊé¾í ¶¼ (´ÎÊıÊÇ10µÄ±¶Êı) 
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

    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end

    --Add by gaojingwei at 2009/05/20 for ÃîÊÖÉñÒ½start-----
    --Modified By Guoqun for ³Ë»Æ´óÍõBugĞŞÕı at 2010-12-06 Begin
    if GetTaskByte(Task_Type, 1) == 1 then
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
    --Modified By Guoqun for ³Ë»Æ´óÍõBugĞŞÕı at 2010-12-06 End
    --Add by gaojingwei at 2009/05/20 for ÃîÊÖÉñÒ½ end-----

    -- add by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·
    soulBackhome(npcindex)
    -- end by mayining 2009.6.16 for ÏÉÄ§ÉùÍûÑ­»·

    --add by lisuhui 2009.06.14 for Ê®¶şÈËÅ¼
    TwelveIdol(npcindex)
    --add by lisuhui 2009.06.14

    --Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ strat---
    if (GetTaskByte(Task_Outoftree, 1) == 3) then
        local RandofSoul = random(1, 5)--20%µÄ¸ÅÂÊË¢³öÄ§ÎïÖ®»ê--¸ÅÂÊĞèÒªĞŞ¸Ä
        --Ö»ÓĞµ±Íæ¼Ò»¹Ã»ÓĞÕÙ»½ÕâÖÖ¹ÖÎïµÄÄ§ÎïÖ®»êÊ±
        if (GetTaskByte(Task_Outoftree, 2) == 0) then
            if RandofSoul == 1 then
                AddSoulofDevil(npcindex)
            end
        else
            Msg2Player("Hån ThiÕt Tinh ®· bŞ khèng chÕ, xin tranh thñ thêi gian khèng chÕ c¸c hån ph¸ch Ma vËt kh¸c")
            TopMessage("Hån ThiÕt Tinh ®· bŞ b¾t")
        end
    end
    --Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ end---

    -- Added by Zhaoqingsong at 2009-6-23 begin
    processYinGuoLunHui(npcindex)
    -- Added by Zhaoqingsong at 2009-6-23 end

    -- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 begin
    if (GetPlayerExtLevel() > 50) and (GetTaskByte(Task_epistle, 1) < 100) then
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

--ÃîÊÖÉñÒ½ÈÎÎñ start----------
function superDoctor(npcindex)
    local monsterNum = GetTaskByte(Task_Process, 4)
    local totalTimes = GetTask(Task_Total_Times)
    local pro = 3 + floor(totalTimes / 100)
    local rand = random(1, 100)
    local amberItem = taskItem[2].Item

    if (pro > 100) then
        pro = 100
    end

    if (rand < pro) then
        AddNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4], 0, 0)
        ScrollMessage("§­îc 1 tim Hæ Ph¸ch")
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

--Modified By Guoqun for ³Ë»Æ´óÍõÉ¾³ı bug ĞŞÕı at 2010-12-06 Begin
function callBoss(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local monsterIndex = AddNpc(chenghuangNpcID, 55, SubWorldID2Idx(id), x * 32, y * 32)
    if monsterIndex > 0 then
        SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\npc³Ë»Æ´óÍõ.lua")
        SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        SetNpcName(monsterIndex, "ThiÕt Tinh ®¹i v­¬ng")

        SetTaskByte(Task_Process, 1, 4)            --ÊÍ·Å³ö³Ë»ÆNpc
        SetTask(Task_MonsterID, GetNpcID(monsterIndex))
        SetTask(Task_Free_Time, monsterIndex)
        Msg2Player("Dô thµnh c«ng ThiÕt Tinh ®¹i v­¬ng")
        TopMessage("Dô thµnh c«ng ThiÕt Tinh ®¹i v­¬ng")
        TaskNote(1077, 4)
    end
end
--Modified By Guoqun for ³Ë»Æ´óÍõÉ¾³ı bug ĞŞÕı at 2010-12-06 End
--ÃîÊÖÉñÒ½ÈÎÎñ end----------

--Add by litao at 2009/6/10 for ½ÚÍâÉúÖ¦ strat---
function AddSoulofDevil(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local SoulofDevilIndex = AddNpc(ID_SoulofDevil, 55, SubWorld, x * 32, y * 32)
    SetGuardLevel(SoulofDevilIndex, 2)
    SetNpcTask(SoulofDevilIndex, 1, 1)
    SetNpcScript(SoulofDevilIndex, "\\script\\¹ÖÎï\\death.lua")
    SetNpcTimer(SoulofDevilIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 10)
    SetNpcName(SoulofDevilIndex, "Hån ThiÕt Tinh")
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
    local temp = GetTaskByte(Task_epistle, 1) -- È¾ÑªµÄÒÅÊé ÁÙÊ±ÈÎÎñ±äÁ¿
    local times = floor(temp / 10) -- ×öµÄÀÛ¼Æ´ÎÊı
    local state = mod(temp, 10) --ÈÎÎñ²½Öè×´Ì¬

    if (times >= 10) then
        --×î¶à10´Î
        return 0
    end

    local rluck = random(1, 100)--10%µÄ¸ÅÂÊ
    if (state == 0) then
        if (IsExistItem(6, 1, 790, 0) == 0) and (HaveNormalItemInQuick(6, 1, 790, 0) == 0) and (rluck <= 10) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                --ÂúÁË²»¼Ó
                return 0
            end

            AddNormalItem(6, 1, 790, 0, 0, 0)
            ScrollMessage("NhÆt ®­îc 1 bøc <c=r>Th­ dİnh m¸u")
            Msg2Player("ThiÕt Tinh lµm r¬i ra 1 bøc Th­ dİnh m¸u")
        end
        return 0
    elseif (state == 1) then
        if (rluck <= 15) then
            if (IsHaveSpaceForTreasure(1) == 1) then
                --ÂúÁË²»¼Ó
                AddEventItem(300)
            end

            ScrollMessage("NhËn ®­îc 1 bã <c=g>Long Xµ Th¶o")
            Msg2Player("NhÆt ®­îc trªn m×nh cña ThiÕt Tinh 1 bã Long Xµ Th¶o, mang vÒ cho Ph¸p S­ YÓn V©n cña bé l¹c.")
            TaskNote(118, 1)
            SetTaskByte(Task_epistle, 1, 2)
        end
    elseif (state == 3 or state == 4) then
        local luckyValue = 1 --Ê×´Î10%£¬ÆäÓà1%
        if (times == 0) then
            luckyValue = 10
        end

        if (rluck <= luckyValue) and (HaveEventItem(296) == 0) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                --ÂúÁË²»¼Ó
                return 0
            end

            AddEventItem(296)
            ScrollMessage("NhËn ®­îc <c=r>Di Th­ dİnh m¸u")
            Msg2Player("ThiÕt Tinh r¬i ra mét bøc Di Th­ dİnh m¸u")
        end
    end
end
-- Add by yaoxin for ¶ÃÎïÉúÇé  at 2009/12 end