--Ç¿»¯ÃÀÅ®°öµÄËÀÍö½Å±¾--Ë®Õó
--lixuewu 2005


function OnDeath(npcindex)
    processWashMarrow()
    local w, x, y = GetWorldPos()
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            calc_task(w, npcindex, oldPlayer)
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        calc_task(w, npcindex, PlayerIndex)
    end ;

    --add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 begin
    --	MoonDayDrop2011()
    --add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 end
end

function calc_task(w1, npcindex, killplayer)
    local w, x, y = GetWorldPos()
    if (w ~= w1) or (w ~= 68) then
        return 0
    end

    if (GetTask(408) == 2) then
        local today = floor(LocalSystemTime() / 86400)
        if (today == GetTask(409)) then
            local count = GetTask(407)
            if (count > 0) then
                count = count - 1
                SetTask(407, count)
                if (count == 0) then
                    ScrollMessage("Hoµn thµnh nhiÖm vô trõ Ngäc N÷")
                    SetTask(408, 100000)
                    TaskNote(65, 3)
                else
                    ScrollMessage("CÇn ph¶i tiªu diÖt" .. count .. "Ngäc N÷")
                    TaskNote(65, 0, count, "Ngäc N÷")
                end
            end
        else
            SetTask(407, 0)
            SetTask(408, 0)
            TaskNote(65, -1)
            TopMessage(11610)
            Msg2Player("NhiÖm vô V¹n Tiªn trËn ®· qu¸ h¹n")
            --			local z=random(1,1000)
            --			if ((z>=1) and (z<=15)) then
            --				ThrowItem(npcindex, PlayerIndex,3,128,0,0,0,1)
            --				Msg2Player("Äã»ñµÃÒ»¸öÅ´Ã×")
            --			end;
        end
        local y1 = random(1, 50000)
        if ((y1 >= 1) and (y1 <= 45)) then
            local idx = floor((y1 - 1) / 3) + 221
            local idx1 = floor((y1 - 1) / 9)
            idx = idx + idx1 * 6
            ThrowItem(npcindex, PlayerIndex, 6, 1, idx, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 ®å phæ mµu cam!")
        end ;
    end
    local x1 = random(1, 10000)
    if ((x1 >= 1) and (x1 <= 15)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 3, 117, 0, 0, 0, 1)
        Msg2Player("Qu¸i Ngäc N÷ ®· bŞ b¹n khuÊt phôc, r¬i ra 1 Hoµn Quan nh·n")
        PlayerIndex = oldPlayer
    elseif ((x1 > 9985) and (x1 <= 10000)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 6, 1, 717, 0, 0, 1)
        Msg2Player("Qu¸i Ngäc N÷ ®· bŞ b¹n khuÊt phôc, r¬i ra 1 Ng­ng ThÇn §¬n")
        PlayerIndex = oldPlayer

    end ;

    -- Annotate by Zhaoqingsong at 2009-2-3 Begin
    -- ×¢ÊÍµô´º½Ú»î¶¯ÎïÆ·µôÂä

    --	local x2 = random(1,100)
    --	if( x2 >= 1 and x2 <= 3) then
    --	    local oldPlayer = PlayerIndex
    --		PlayerIndex = killplayer 
    --		ThrowItem(npcindex, PlayerIndex,6,1,432,0,0,0)
    --		Msg2Player("Ç¿»¯ÃÀÅ®°ö±»Äã³É¹¦Õ÷·şÁË£¬µôÂäÒ»¸öÔ­ÁÏºĞ")
    --		PlayerIndex = oldPlayer	
    --	end

    -- Annotate by Zhaoqingsong at 2009-2-3 End

    -- Add by yaoxin for ¶ËÎç½Ú»î¶¯  at 2010-06 begin
    --	local y1,m1,d1 = GetYMD()
    --	if (y1 == 2010) and (m1 == 6) and (d1 >= 12 and d1 <= 16) then
    --		local r= random(1,1000)
    --		if (r <= 15) and (GetTask(408) > 0) and (GetTask(408) < 100000) then
    --			local oldPlayer = PlayerIndex
    --			PlayerIndex = killplayer 
    --			ThrowItem(npcindex, PlayerIndex,3,128,0,0,0,1)
    --			Msg2Player("Ç¿»¯ÃÀÅ®°ö±»Äã³É¹¦Õ÷·şÁË£¬µôÂäÒ»¸öÅ´Ã×")
    --			PlayerIndex = oldPlayer
    --		end
    --	end
    -- Add by yaoxin for ¶ËÎç½Ú»î¶¯  at 2010-06 end

end

-- Added by zhaoqingsong at 2008-8-22 begin
-- Ï´½î·¥ËèÈÎÎñ

-- ÈÎÎñ×´Ì¬±äÁ¿£¬
-- 1 Byte ÈÎÎñÖ´ĞĞ×´Ì¬£¬0 ³õÊ¼£¬1 ½ÓÈÎÎñ£¬2 É±Í­ÈË£¬3 É±ÍòÏÉÕóĞ¡¹Ö£¬4 ÈÎÎñÍê³É£»
-- 2 Byte Í½µÜÈÎÎñ×´Ì¬£¬0 Î´×ö¹ı£¬1 ÒÑ×ö¹ı£»
-- 3 Byte Í½µÜ£¨É±ËÀÍ­ÈËÊı£©£¬Ê¦¸µ£¨µ¤ÅßÊ¹ÓÃ´ÎÊı£©£»
-- 4 Byte »ñµÃÏ´Ëèµ¤Êı£»
Task_XJFS_Status = 1248
Task_XJFS_BindingID = 1249 -- Ê¦Í½°ó¶¨ID

Task_Info_XJFS = 1018

Boss_CopperMan_ID = 727     -- Í­ÈËID
Buff_XJFS = 466             -- µ¤ÅßBuff

-- È¡µÃ×é¶ÓÇé¿ö
function getTeamStatus()
    if (GetTeamSize() ~= 2) then
        return 0
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local masterIndex = GetMasterPlayerIndex(teammateIndex)
    if (masterIndex == PlayerIndex) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = teammateIndex
        local teammateID = GetPlayerID()
        local prenticeLevel = GetLevel()
        local prenticeStatus = GetByte(GetTask(Task_XJFS_Status), 2)
        PlayerIndex = playerIndexCache
        return 1, 1, teammateID, prenticeLevel, prenticeStatus
    elseif (masterIndex == teammateIndex) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = teammateIndex
        local teammateID = GetPlayerID()
        PlayerIndex = playerIndexCache
        local prenticeLevel = GetLevel()
        local prenticeStatus = GetByte(GetTask(Task_XJFS_Status), 2)
        return 1, 0, teammateID, prenticeLevel, prenticeStatus
    else
        return 0
    end
end

-- È¡µÃ¶ÓÓÑµÄ°ó¶¨ID
function getTeammateBindingID()
    local playerIndexCache = PlayerIndex
    PlayerIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local bindingID = GetTask(Task_XJFS_BindingID)
    PlayerIndex = playerIndexCache
    return bindingID
end

-- ´¦ÀíÏ´½î·¥ËèÈÎÎñ
function processWashMarrow()
    local taskStatus = GetByte(GetTask(Task_XJFS_Status), 1)
    if (taskStatus ~= 3) then
        return
    end
    local isSTTeam, masterFlag, teammateID, prenticeLevel, prenticeStatus = getTeamStatus()
    local selfID = GetPlayerID()
    if (taskStatus == 3 and isSTTeam == 1 and masterFlag == 1
            and teammateID == GetTask(Task_XJFS_BindingID) and selfID == getTeammateBindingID()) then
        local rand = random(1, 100)
        if (rand <= 5) then
            local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
            local redCount = GetByte(GetTask(Task_XJFS_Status), 4) + 1
            SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 4, redCount))
            local playerIndexCache = PlayerIndex
            if (redCount < 5) then
                PlayerIndex = teammateIndex
                AddNormalItemPile(6, 1, 385, 1, 0, 0)
                TaskNote(Task_Info_XJFS, 4, (5 - redCount))
                TopMessage(14378)
                PlayerIndex = playerIndexCache
            else
                PlayerIndex = teammateIndex
                AddNormalItemPile(6, 1, 385, 1, 0, 0)
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 4))
                TaskNote(Task_Info_XJFS, 6)
                Msg2Player("§· lÊy ®ñ 5 viªn TÈy Tñy ®¬n, cã thÓ cïng s­ phô vÒ gÆp L«i ChÊn Tö phôc mÖnh!")
                TopMessage(14379)
                PlayerIndex = playerIndexCache
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 4))
                RemoveIBBuff(Buff_XJFS)
                for i = 1, HaveNormalItem(6, 1, 384, 1) do
                    -- Èç¹ûÓĞµ¤Åß£¬É¾³ı£¬Ö»ÏŞ±³°ü
                    DelNormalItem(6, 1, 384, 1)
                end
                TaskNote(Task_Info_XJFS, 7)
            end
        end
    end
end

-- Added by zhaoqingsong at 2008-8-22 end

--add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 begin
--function MoonDayDrop2011()
--	local nYear, nMonth, nDay = GetYMD()
--	local nRand = random(1, 1000)
--	if (nYear == 2011 and nMonth == 2 and nDay >= 17 and nDay <= 19) then
--		local itemNum = GetGlobalValueWord(620, 2)
--		if (nRand <= 1 and itemNum < 1 and IsHaveSpaceForTreasure(2) > 0) then
--			AddNormalItem(3, 1165, 0, 0, 0, 0)
--			SetGlobalValueWord(620, 2, itemNum+1)
--			Msg2Player("¹§Ï²Äã»ñµÃÁËÒ»¸ö´¼ÏãÃÀ¾Æ¡£")
--			WriteLog(GetName().."É±ËÀÃÀÅ®£¬»ñµÃ´¼ÏãÃÀ¾Æ")
--		end
--	end
--end
--add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 end