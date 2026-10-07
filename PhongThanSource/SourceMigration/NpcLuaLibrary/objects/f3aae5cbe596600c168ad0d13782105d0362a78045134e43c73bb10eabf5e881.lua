--Ç¿»¯Ê¬»ÈµÄËÀÍö½Å±¾--ÍÁÕó
--lixuewu 2005

function OnDeath(npcindex)
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
    if (w ~= w1) or (w ~= 67) then
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
                    ScrollMessage("Hoµn thµnh nhiÖm vô trõ ThiÕt Trïng")
                    SetTask(408, 100000)
                    TaskNote(65, 3)
                else
                    ScrollMessage("CÇn ph¶i tiªu diÖt" .. count .. "ThiÕt Trïng")
                    TaskNote(65, 0, count, "ThiÕt trïng")
                end
            end
        else
            SetTask(407, 0)
            SetTask(408, 0)
            TaskNote(65, -1)
            TopMessage(11610)
            Msg2Player("NhiÖm vô V¹n Tiªn trËn ®· qu¸ h¹n")
        end
    end
    local x1 = random(1, 10000)
    if ((x1 >= 1) and (x1 <= 20)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 3, 116, 0, 0, 0, 1)
        Msg2Player("Qu¸i ThiÕt Trïng ®· bŞ b¹n khuÊt phôc, r¬i ra 1 §¹i ®Şa nh·n")
        PlayerIndex = oldPlayer

    elseif ((x1 > 9990) and (x1 <= 10000)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 6, 1, 717, 0, 0, 1)
        Msg2Player("Qu¸i ThiÕt Trïng ®· bŞ b¹n khuÊt phôc, r¬i ra 1 Ng­ng ThÇn §¬n")
        PlayerIndex = oldPlayer

    end ;

    -- Annotate by Zhaoqingsong at 2009-2-3 Begin
    -- ×¢ÊÍµô´º½Ú»î¶¯ÎïÆ·µôÂä

    --	local x2 = random(1,100)
    --	if( x2 >= 1 and x2 <= 3) then
    --	    local oldPlayer = PlayerIndex
    --		PlayerIndex = killplayer 
    --		ThrowItem(npcindex, PlayerIndex,6,1,432,0,0,0)
    --		Msg2Player("Ç¿»¯Ê¬»È±»Äã³É¹¦Õ÷·şÁË£¬µôÂäÒ»¸öÔ­ÁÏºĞ")
    --		PlayerIndex = oldPlayer	
    --	end

    -- Annotate by Zhaoqingsong at 2009-2-3 End

    -- Add by yaoxin for ¶ËÎç½Ú»î¶¯  at 2010-06 begin
    --	local y1,m1,d1 = GetYMD()
    --	if (y1 == 2010) and (m1 == 6) and (d1 >= 12 and d1 <= 16) then
    --		local r= random(1,1000)
    --		if (r <= 20) and (GetTask(408) > 0) and (GetTask(408) < 100000) then
    --			local oldPlayer = PlayerIndex
    --			PlayerIndex = killplayer 
    --			ThrowItem(npcindex, PlayerIndex,3,128,0,0,0,1)
    --			Msg2Player("Ç¿»¯Ê¬»È±»Äã³É¹¦Õ÷·şÁË£¬µôÂäÒ»¸öÅ´Ã×")
    --			PlayerIndex = oldPlayer
    --		end
    --	end
    -- Add by yaoxin for ¶ËÎç½Ú»î¶¯  at 2010-06 end

end

--add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 begin
--function MoonDayDrop2011()
--	local nYear, nMonth, nDay = GetYMD()
--	local nRand = random(1, 1000)
--	if (nYear == 2011 and nMonth == 2 and nDay >= 17 and nDay <= 19) then
--		local itemNum = GetGlobalValueWord(619, 2)
--		if (nRand <= 1 and itemNum < 1 and IsHaveSpaceForTreasure(2) > 0) then
--			AddNormalItem(3, 1165, 0, 0, 0, 0)
--			SetGlobalValueWord(619, 2, itemNum+1)
--			Msg2Player("¹§Ï²Äã»ñµÃÁËÒ»¸ö´¼ÏãÃÀ¾Æ¡£")
--			WriteLog(GetName().."É±ËÀÊ¬»È£¬»ñµÃ´¼ÏãÃÀ¾Æ")
--		end
--	end
--end
--add by liujifang for ÔªÏü½Ú»î¶¯ at 2011-01-17 end