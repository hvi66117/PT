--description: ÏàÁøÉñ
--author: yaoxin
--date: 2008/07/23

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒı»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊı;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊıÎªÏÉ,Å¼ÊıÎªÄ§
Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊı 2=³õÊ¼ÏµÊıx 3=µ±Ç°Ôö³¤ÏµÊı(Y)
Task_xianmo_npcIndex = 1299    -- °ó¶¨µÄNpcIndex
Task_xianmo_npcID = 1300    -- °ó¶¨µÄNpcID
Task_faery = 1301 --1word  x×ø±ê   2word y×ø±ê

TASK_JIANGSHAN = 1426
TASK_JIANGSHAN_THIRD_NOTE = 1439

--AS by hyz 090730 for ÖØÈëÂÖ»Ø
TASK_CRLH = 1513
TASK_GET_PROBABILITY = 2
--AE by hyz 090730 for ÖØÈëÂÖ»Ø

npc_name = {
    [45] = "Lam Cèt",
    [46] = "Bè ThÇn",
    [47] = "Ma N÷",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--2Byte£ºÒÑÁÔÉ±ÊıÁ¿
--3Byte: 1´ú±íÊÇÍ½µÜ 2´ú±íÊ¦¸µ
--4byte: 1ÒÑ¾­ÕĞ³öboss 2ÈÎÎñÊ§°Ü 3ÈÎÎñ³É¹¦
Boss_Index = 1670
Boss_ID = 1671
IBBuff_Kill = 1246
IBBuff_Boss = 1245    --15·ÖÖÓµÄbuff

Forbidden_Buff = 1242  --ÓĞ´ËBuff²»ÄÜ½øÈë³µÄÚ
Task_CarID = 1667  --²É¼¯³µµÄNpcID
Task_Carriagenpcidx = 1666  --²É¼¯³µµÄNpcIndex

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

YiboTasks = {
    [6] = { taskname = "NhiÖm vô Tæ ®éi s¸t thñ Khæn Tiªn cung tÇng 2", master = { name = "Bè ThÇn", id = 30 }, apprentice = { name = "Lam Cèt", id = 24 }, boss = { name = "T­¬ng LiÔu Tö ThÇn", id = 1734 } },
}
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end

function OnDeath(npcindex)
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØĞÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 85
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(858) > 0) then
                liesha_city(w)
            end

            --¹ÖÎïÄÁ³¡
            if (HaveIBBuff(360) >= 1) and (w == 48) then
                ogre_field(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(858) > 0) then
            liesha_city(w)
        end

        --¹ÖÎïÄÁ³¡
        if (HaveIBBuff(360) >= 1) and (w == 48) then
            ogre_field(w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 46)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (GetByte(GetTask(1014), 1) == 46) then
        if (GetByte(GetTask(1013), 3) == 1) and (w >= 42) and (w <= 51) then
            Frenwu75(x, y)--Òó½¼ --Ììî¸ĞÇÖ®»ê   75¼¶Ñ­»·ÈÎÎñ
            GetBookNote3()            --¸ÅÂÊ»ñµÃ²ĞÆÆµÄ¾íÖá3
        end

    end

    if (mapgid == 46) then
        if (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
            Frenwu95()--   95¼¶Ñ­»·ÈÎÎñ
        end
    end

    if (HaveIBBuff(493) > 0) then
        local xianmo_m = GetByte(GetTask(Task_xianmo_renwu), 3)
        if (xianmo_m == 48) or (xianmo_m == 49) then
            Frenwu110(mapgid, px, py)--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
        end
    end

    --AS by hyz 090730 for ÖØÈëÂÖ»Ø
    if (GetLevel() >= 96) and (w >= 42) and (w <= 46) then
        if (IsHaveSpaceForTreasure(1) == 0 or GetTaskByte(TASK_CRLH, 1) > 0) then


        else
            if (HaveItemInAllRoom(6, 1, 557, 0, 0, 0, 0) == 0 and GetTaskByte(TASK_CRLH, 4) < 2) then
                local t = random(1, 100)

                if (t <= TASK_GET_PROBABILITY) then
                    SetTaskByte(TASK_CRLH, 4, 2)        --±ê¼ÇÔø¾­»ñµÃ¹ı
                    AddNormalItem(6, 1, 557, 0, 0, 0)        --»ñµÃ·û½Ú
                    Msg2Player("B¹n may m¾n nhËn ®­îc ThÎ phï.")
                    TopMessage("B¹n may m¾n nhËn ®­îc ThÎ phï.")

                end

            end

        end

    end
    --AS by hyz 090730 for ÖØÈëÂÖ»Ø

    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin
    if (mapgid == 49 and GetTaskByte(Task_Count, 1) == 16 and IsMantlePrentice(PlayerIndex) > 0 and GetNpcID(GetTask(Task_Carriagenpcidx)) == GetTask(Task_CarID) and GetTask(Task_CarID) ~= 0 and GetTaskByte(Task_Count, 1) == 16) then
        if (HaveIBBuff(Forbidden_Buff) == 0) then
            AddIBBuff(Forbidden_Buff)
        end
    end
    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end


    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin --
    if (mapgid == 48 and GetTaskByte(Task_Count, 1) == 6 and IsMantleMaster(PlayerIndex) > 0 and GetTaskByte(Task_Count, 4) <= 1) then
        -- Ê¦¸¸ÔÚÀ¦ÏÉ2²ã
        local teamstate = Team_State()
        if (teamstate == 1) then
            if (GetTaskByte(Task_Count, 4) == 1) then
                local bossindex = GetTask(Boss_Index)
                local bossid = GetTask(Boss_ID)
                if (GetNpcID(bossindex) == bossid and bossindex ~= 0) then
                    local bInArea = Check_BossDistance(bossindex)
                    if (bInArea == 1) then
                        Msg2Player("Xin anh hïng h·y cÊp tèc ®i tiªu diÖt T­¬ng LiÔu Tö ThÇn")
                    end
                else
                    Msg2Team("T­¬ng LiÔu Tö ThÇn b¹n gäi ra ®· biÕn mÊt, nhiÖm vô thÊt b¹i!")
                    SetTaskByte(Task_Count, 4, 2)
                    Set_MateTaskByte(Task_Count, 4, 2)
                end
            else
                local bHave1, bHave2, mateIdx = Have_Baowu()
                if (bHave1 == 0 or bHave2 == 0) then
                    if (IsMantlePrentice(PlayerIndex) == 0) then
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                            PlayerIndex = selfIdx
                        end
                    else
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o<c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
                            PlayerIndex = selfIdx
                        end
                    end
                    return
                end

                local count = GetTaskByte(Task_Count, 2)
                if (count < 50) then
                    count = count + 1
                    SetTaskByte(Task_Count, 2, count)

                    if (count == 50) then
                        if (Get_MateTaskByte(Task_Count, 2) == 30 and HaveIBBuff(IBBuff_Kill) > 0) then
                            --BÍê³É AÓĞ20Ãëbuff ÔòÕÙ»½ÉñÊŞ
                            --ÕĞ³öBoss£¬È»ºóÌí¼ÓÒ»¸ö10·ÖÖÓBuff, ÒÆ³ı20ÃëµÄBuff
                            callBoss(npcindex)
                        elseif (Get_MateTaskByte(Task_Count, 2) < 30) then
                            --¸øA¡¢BÌí¼ÓBuff AÍê³ÉÁË¶øBÃ»Íê³É
                            --¸øË«·½Ìí¼Ó20ÃëBuff
                            ScrollMessage("Phôc Ma Gi¶n ®· kİch ho¹t, h·y mau ®i thu phôc T­¬ng LiÔu Tö ThÇn")
                            TeamAction("Team_AddBuff", 0, 0, 0)
                        end
                    else
                        ScrollMessage("Phôc Ma TÕ ThÕ: Cßn ph¶i tiªu diÖt Bè ThÇn" .. (50 - count) .. ".")
                    end
                else
                    ScrollMessage("Phôc Ma Gi¶n ®· ®­îc kİch ho¹t, h·y mau ®i thu phôc T­¬ng LiÔu Tö ThÇn")
                end
            end
        elseif (teamstate == 5) then
            Msg2Player("§ång ®éi cña b¹n ®· hñy NhiÖm vô S¸t thñ! Xin vÒ gÆp D­¬ng TiÔn ®Ó huû nhiÖm vô nµy!")
        end
    end
    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end
end

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin
function callBoss()
    --ÕÙ»½boss
    local id, x, y = GetWorldPos()
    local monsterIndex = AddNpc(1734, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 15)
    SetNpcName(monsterIndex, "T­¬ng LiÔu Tö ThÇn")
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)        --ÈÎÎñ±äÁ¿¼ÇÂ¼¹ÖÎïindex
    SetTask(Boss_ID, GetNpcID(monsterIndex)) --ÈÎÎñ±äÁ¿¼ÇÂ¼¹ÖÎïID
    SetMateTask(Boss_Index, monsterIndex)
    SetMateTask(Boss_ID, GetNpcID(monsterIndex))
    SetTaskByte(Task_Count, 4, 1)
    Set_MateTaskByte(Task_Count, 4, 1)
    Msg2Player("§· dô ra T­¬ng LiÔu Tö ThÇn")
    TopMessage("§· dô ra T­¬ng LiÔu Tö ThÇn")
    TeamAction("Team_AddBuff", IBBuff_Kill, 0, 0)
end

function Team_AddBuff(buffid)
    if (buffid == IBBuff_Kill) then
        Msg2Player("H·y lËp tøc ®i tiªu diÖt T­¬ng LiÔu Tö ThÇn! B¹n chØ cã 15 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, "T­¬ng LiÔu Tö ThÇn")
        return
    end
    AddIBBuff(IBBuff_Kill)
end

function Team_State()
    --·µ»ØÖµËµÃ÷£º1¡¢¶ÓÎéÎªÁ½ÈË¶Ó£¬ÇÒÎªÒÂ²§¹ØÏµ
    --2¡¢¶ÓÎé²»ÊÇÁ½ÈË¶Ó£¬Çë²é¿´×é¶Ó·½Ê½
    --3¡¢¶ÓÎéÊÇÁ½ÈË¶Ó£¬µ«¶ÓÓÑ²»ÊÇ×Ô¼ºµÄÒÂ²§µÜ×Ó
    --4¡¢×Ô¼ºÃ»ÓĞÊÕÒÂ²§µÜ×Ó
    --5¡¢¶ÔÓÑÈ¡ÏûÁËÈÎÎñ
    if (GetTeamSize() ~= 2) then
        return 2
    end

    if (IsMantleMaster(PlayerIndex) == 0) then
        return 4
    end

    local strName = GetName()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex

    PlayerIndex = mateIdx

    local strMasterName = GetMantleMasterName()
    local taskState = GetTask(Task_Count)

    PlayerIndex = selfIdx

    if (strMasterName ~= strName) then
        return 3
    end

    if (GetTask(Task_Count) ~= 0 and taskState == 0) then
        return 5
    end

    return 1
end

function Get_MateTaskByte(taskid, nByte)
    local oldplayer = PlayerIndex
    local otherindex = Get_MatePlayerIndex()
    PlayerIndex = otherindex
    local value = GetTaskByte(Task_Count, 2)
    PlayerIndex = oldplayer
    return value
end

function Set_MateTaskByte(taskid, nByte, value)
    local oldplayer = PlayerIndex
    local otherindex = Get_MatePlayerIndex()

    PlayerIndex = otherindex
    SetTaskByte(taskid, nByte, value)
    PlayerIndex = oldplayer
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

function Have_Baowu()
    --·µ»ØÖµ 1£º×Ô¼ºÊÇ·ñÓĞ±¦Îï 2£ºÍ½µÜÊÇ·ñÓĞ±¦Îï 3:¶ÓÓÑµÄidx 4:selfidx
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    local item1 = 0
    local item2 = 0
    if (IsMantlePrentice(PlayerIndex) > 0) then
        item1 = Baowu[2].Item
        item2 = Baowu[1].Item
    else
        item1 = Baowu[1].Item
        item2 = Baowu[2].Item
    end

    local bHaveItem1 = HaveNormalItem(item1[1], item1[2], item1[3], item1[4])
    PlayerIndex = mateIdx
    local bHaveItem2 = HaveNormalItem(item2[1], item2[2], item2[3], item2[4])
    PlayerIndex = selfIdx
    return bHaveItem1, bHaveItem2, mateIdx
end

function Check_BossDistance(bossIdx)
    --1£ºÍæ¼ÒÔÚboss 800ÏñËØ·¶Î§Ö®ÄÚ 0£º²»ÔÚ´Ë·¶Î§Ö®ÄÚ
    local nMap, nX, nY = GetNpcWorldPos(bossIdx)
    local pMap, pX, pY = GetWorldPos()

    if (nMap == pMap) then
        if ((nX - pX) ^ 2 + (nY - pY) ^ 2) <= 800 then
            return 1
        end
    end

    return 0
end
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 858
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 46 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    elseif (type2 == 46 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    end
end

--¹ÖÎïÄÁ³¡
function ogre_field(WorldID)
    local mapid = GetByte(GetTask(1077), 2)
    local w, x, y = GetWorldPos()
    if (WorldID == mapid) and (w == WorldID) then
        local kind = GetByte(GetTask(1077), 1)
        if (46 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " Bè ThÇn")
                TaskNote(69, 0, "Khæn Tiªn tÇng 2", "Bè ThÇn", count)
            else
                RemoveIBBuff(360)
                SetTask(1078, 0)
                TaskNote(69, 1)
                ScrollMessage("Trõ ma: Hoµn thµnh")
            end
        end
    end
end

function no()
    CloseDialog()
end;

--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
--964 ¹ÖÎï1±êºÅ
--965 ¹ÖÎï2±êºÅ
--966 ÕĞ»ê·«ËùÔÚµØÍ¼id
--967 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃx
--968 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃy
--969 ÕĞ»ê·«µÄÉèÖÃÆğÊ¼Ê±¼ä
--970 ¹ÖÎï1µÄÁé»ê¸öÊı
--971 ¹ÖÎï2µÄÁé»ê¸öÊı
function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = random(1, 3) --µôÂäÁé»ê¸ÅÂÊ33%
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                SetTask(971, dd2 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Bè ThÇn")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Bè ThÇn ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Bè ThÇn", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Bè ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Bè ThÇn")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Bè ThÇn ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Bè ThÇn", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Bè ThÇn ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
            end
        end

        if (GetTask(971) >= 3) and (GetTask(970) >= 3) then
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            TaskNote(48, 2)
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
end

-------------------------------ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶-----------------------------
function Frenwu42()
    --991	»ñµÃ¼ÓÕòÔ­ÉùÍûbuffµÄÊ±¼ä,¾«È·µ½Ìì
    local rand_buff = random(1, 1000)--
    local today_buff = floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

------------------------Òó½¼ --Ììî¸ĞÇÖ®»ê   75¼¶Ñ­»·ÈÎÎñ-----------------------------
--1013 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı 3 = µ±Ç°½øĞĞµÄ»·½Ú,(5:60 + 1:80) 4 £½  ½ñÌì¶Ò»»½±Àø´ÎÊı
--1014 1=¹ÖÎïĞòºÅ 2=´ò¹Ö¸öÊı 3=µ±Ç°Ôö³¤ÏµÊı(Y) 4= ³õÊ¼ÏµÊıx
--1017 Ììî¸ĞÇnpc, µÄindex
function Frenwu75(x, y)
    local circle1 = GetByte(GetTask(1013), 3)
    local tgrand = random(1, 1000)
    local tgcan1 = GetByte(GetTask(1014), 4)
    local tgadd1 = GetByte(GetTask(1014), 3)
    local tgtime1 = GetByte(GetTask(1014), 2) + 1
    local tglucy = tgcan1 + tgadd1 * (tgtime1 - 1)

    if (tgrand <= tglucy) then
        SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
        SetTask(1014, 0)
        Msg2Player("Thiªn C­¬ng ¶nh thø 1 ®· xuÊt hiÖn!")
        TopMessage(11648)
        TaskNote(53, 1, 1)
        local npcTGIdx = AddNpc(571, 60, SubWorld, x * 32, y * 32)
        SetTask(1017, npcTGIdx)
    else
        SetTask(1014, SetByte(GetTask(1014), 2, tgtime1))
        Msg2Player("Thiªn C­¬ng Tinh t¹m thêi ch­a xuÊt hiÖn, xin tiÕp tôc tiªu diÖt qu¸i vËt ®Ó dô ra Thiªn C­¬ng Tinh.")
    end
end

--95¼¶Ñ­»·ÈÎÎñ---------------------------------------------------------------
--1139 --1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı, 3, µ±Ç°µÃ»·½Ú,(1½Ó,2Áì,3Íê³É),4,ÊÇ·ñÁì¹ı¶îÍâµÄ½õºÏ
--TASK_Npcindex =1140 --Í¬Ê±ÔÚ½ÓÇ°×öÊÇ·ñÌåËÙµÄ±êÊ¶(1=ÆÕÍ¨£¬2=¸ÄÁ¼)
--TASK_Lucky =1141 ----É±¹ÖµÃ½õºÏµÄĞÒÔËÖµ,´æÉ±¹ÖÊı,(³õÊ¼Îª4/1000£¬Ã¿¶àÉ±40Ö»£¬Ôö¼Ó4/1000£¬×î´ó¸ÅÂÊÎª20/1000)
--A.	Èôµ¥¶ÀÊ¹ÓÃÓñÁğÁ§±­£¬Ôò³õÊ¼Îª10/1000£¬Ã¿¶àÉ±40Ö»Ôö¼Ó4/1000£¬×î´ó¿ÉÒÔÔö³¤µ½50/1000
--B.	Èôµ¥¶ÀÊ¹ÓÃ»ú¹ØÉñÊõ£¬Ôò³õÊ¼Îª4/1000£¬Ã¿¶àÉ±20´ÎÔö¼Ó4/1000£¬×î´ó¿ÉÒÔÔö³¤µ½20/1000
--C.	ÈôÍ¬Ê±Ê¹ÓÃÓñÁğÁ§±­+»ú¹ØÉñÊõ£¬Ôò³õÊ¼Îª10/1000£¬Ã¿¶àÉ±20´ÎÔö¼Ó4/1000£¬×î´ó¿ÉÒÔÔö³¤µ½50/1000

function Frenwu95()
    local key = GetByte(GetTask(1139), 4)
    if (key == 0) then
        local Lucky_r = random(35000001, 35001000) - 35000000
        local line95 = floor(GetTask(1141) / 40) * 8 + 8
        local up95 = 30

        if (GetTask(1140) == 2) then
            line95 = floor(GetTask(1141) / 20) * 8 + 8
        end

        if (GetTaskByte(1139, 2) > 1) then
            line95 = line95 + 7
            up95 = 60
        end

        if (Lucky_r <= line95) then
            AddIBBuff(377)
            SetTask(1139, SetByte(GetTask(1139), 4, 1))
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 b×nh r­îu quı!")
            TopMessage("BÊt ngê nhËn ®­îc 1 b×nh <c=g>r­îu quı<c>")
            AddGlobalCountNews("Anh hïng thiÕu niªn <c=g>" .. GetName() .. "<c> khi chuyÓn r­îu quı, ®¸nh yªu ma vµ ®o¹t vÒ 1 b×nh <c=r>r­îu quı<c> bŞ chóng lÊy c¾p!", 1)
        elseif (line95 < up95) then
            local kill95 = GetTask(1141) + 1
            SetTask(1141, kill95)
        end
    end
end

--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒı»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
--Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊı;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊıÎªÏÉ,Å¼ÊıÎªÄ§
--Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊı 2=³õÊ¼ÏµÊıx 3=µ±Ç°Ôö³¤ÏµÊı(Y)
--Task_xianmo_npcIndex	= 1299	-- °ó¶¨µÄNpcIndex
--Task_xianmo_npcID = 1300	-- °ó¶¨µÄNpcID
--Task_faery = 1301 --1word  x×ø±ê   2word y×ø±ê
function Frenwu110(nm, nx, ny)
    local nums = GetTaskByte(Task_xianmo_npc, 1) + 1
    if (nums > 50) then
        RemoveIBBuff(493)
        return 0
    end

    local px1, py1 = GetTaskWord(Task_faery, 1), GetTaskWord(Task_faery, 2)
    local rv = (nx - px1) ^ 2 + (ny - py1) ^ 2
    if (rv > 400) then
        Msg2Player("C¸c qu¸i vËt bŞ tiªu diÖt kh«ng ë trong ph¹m vi Chó TrËn, kh«ng thÓ thu ®­îc hå ph¸ch.")
        return 0
    end

    local growth = nums * GetTaskByte(Task_xianmo_npc, 3) + GetTaskByte(Task_xianmo_npc, 2)
    local ty = GetTaskByte(Task_xianmo_renwu, 4)
    if (random(1, 1000) <= growth) then
        --¸ÅÂÊ´¥·¢(Ç§·ÖÖ®)
        local newNpcName = GetName()
        local npcIdx = 0
        local Newindex = 0
        if (ty == 3) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 756)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=water>" .. newNpcName .. "_Tiªn hån<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                TaskNote(90, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        elseif (ty == 4) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 782)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=yel>" .. newNpcName .. "_Ma ph¸ch<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                TaskNote(91, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        else
            return 0
        end
        SetNpcScript(npcIdx, "\\script\\item\\worldevent\\ÏÉ»êÄ§ÆÇ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\ÏÉ»êÄ§ÆÇ.lua", 300)
        SetNpcName(npcIdx, newNpcName)
        SetTask(Task_xianmo_npcIndex, npcIdx)
        SetTask(Task_xianmo_npcID, mod(GetNpcID(npcIdx), 2 ^ 31))
        SetCamp(ty)--ÏÉÀ¶3,Ä§»Æ4
        SetNpcCurCamp(npcIdx, ty)--ÏÉÀ¶3,Ä§»Æ4

        SetTaskByte(Task_xianmo_renwu, 4, (ty + 2))
        RemoveIBBuff(493)
        AddIBBuff(494)
        SetTaskByte(Task_xianmo_npc, 1, 51)
    else
        SetTaskByte(Task_xianmo_npc, 1, nums)
        growth = floor(growth / 10) --°Ù·ÖÖÆ¸ÅÂÊ
        if (mod(growth, 10) == 0) then
            Msg2Player("Chó trËn ch­a tô hîp ®ñ c¸c hån ph¸ch, h·y tranh thñ thêi gian!")
        end
        TaskNote(87 + ty, 1)
    end
end

--added by hyz 090507 for ½­É½ÒÀ¾É»ñµÃ²ĞÆÆµÄ±Ê¼Ç3
RAND_JS_NOTE = {
    { total = 100, ratio = 3 },
    { total = 100, ratio = 3 },
}
RAND_JS_NOTE_INDEX = 2

function GetBookNote3()

    if (IsHaveSpaceForTreasure(1) > 0) then

        local rand = random(1, 100)

        if (GetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1) ~= 1 and GetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1) ~= 2 and GetTaskByte(TASK_JIANGSHAN, 1) == 2) then

            if (rand <= RAND_JS_NOTE[RAND_JS_NOTE_INDEX].ratio) then
                local mapid, x, y = GetWorldPos()

                if (mapid < 47 or mapid > 51) then
                    return
                end

                SetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1, 1)         --±êÖ¾¸ÃÍæ¼ÒÒÑ¾­»ñµÃ ²ĞÆÆµÄ±Ê¼Ç3 µ±Ç°Á½¾íÒÑ¾­Íê³Éºó
                AddNormalItem(4, 245, 0, 0, 0, 0)  -- ²ĞÆÆµÄ±Ê¼Ç3

                Msg2Player("Xin chóc mõng, nhËn ®­îc 1 quyÓn Bót Kı 3.")
                TopMessage("NhËn 1 quyÓn <c=yel>Bót Kı 3")
            end

        end

    end

end

--end by hyz
