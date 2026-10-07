--¶È½ÙÈÎÎñÊ±¼äºÍÈÎÎñ±äÁ¿
Task_DuJie_Value = 1326   -- 1 byte ÈÎÎñ²½Öè±äÁ¿2 byteÊ±¼ä 3ÒªÉ±ËÀ¹ÖµÄ¸öÊý

Global_Lamp_LightCount = 167 -- 1byteÈ«¾Ö±äÁ¿£¬ÁÁµÆÊýÁ¿ 2byte ÉÏ´ÎÁÁµÆ·½,1ÏÉ,2Ä§

--yaoxin 09/06/22
function OnDeath(npcindex)
    local oldplayerid = GetNpcTask(npcindex, 1)
    local playId = GetPlayerID()
    if (oldplayerid == playId) then
        setnextnpc(npcindex, playId, PlayerIndex)
    else
        local membercount = GetTeamSize()
        local key = 0 --1ÊÇ¶ÓÓÑÉ±,2ÊÇÍâ¶ÓÉ±,0ÊÇÒì³£×´Ì¬
        local oldPlayer = PlayerIndex

        if (membercount > 1) then
            -- ±éÀú¶ÓÖÐ¶ÓÔ±	
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                playId = GetPlayerID()
                if (oldplayerid == playId) then
                    key = 1
                    if (getLuck(key, 1) == 1) then
                        setnextnpc(npcindex, oldplayerid, PlayerIndex)
                    end
                    break
                end
            end
        end

        if (key == 0) then
            PlayerIndex = SearchPlayerById(oldplayerid)
            if (PlayerIndex > 0) then
                key = 2
                if (getLuck(key, 1) == 1) then
                    setnextnpc(npcindex, oldplayerid, PlayerIndex)
                end
            end
        end
        PlayerIndex = oldPlayer
    end
    DelNpc(npcindex)
end

function setnextnpc(npcidx, pID, pIdx)
    if (pIdx > 0) then
        local oldplayer = PlayerIndex
        PlayerIndex = pIdx
        if (HaveIBBuff(524) == 0) then
            Msg2Player("Thêi gian Thiªn KiÕp ®· qua, kh«ng thÓ hoµn thµnh ®é kiÕp!")
            return 0
        end
        SetTaskByte(Task_DuJie_Value, 1, 2)
        SetTaskByte(Task_DuJie_Value, 3, 0)

        local rand = random(1, 100)
        if (rand <= 90) then
            ThrowItem(npcidx, pIdx, 8, 503, 2, 1, 0, 0)
            Msg2Player("Rít DÞch Kinh §¬n")
            TopMessage("Rít DÞch Kinh §¬n")
        else
            ThrowItem(npcidx, pIdx, 8, 504, 2, 1, 0, 0)
            Msg2Player("Rít DÞch Kinh Lé")
            TopMessage("Rít DÞch Kinh Lé")
        end
        TaskNote(1027, 4) --¿ÉÒÔÈ¥½»ÈÎÎñÁË
        PlayerIndex = oldplayer
    end
end

function getLuck(n, leftkill)
    local r = random(1, 100)
    local item = {
        [1] = { 5, 10, 10, 10, 10, 10, 10 },
        [2] = { 6, 12, 25, 40, 40, 50, 50 },
    }
    if (r > item[n][leftkill]) then
        return 1
    end
    return 0
end

--ÐÞ¸ÄÇ°,
--function OnDeath(npcindex)
--	
--	local npcid = GetTask(Task_DuJie_NpcID)
--	local npcidx= GetTask(Task_DuJie_NpcIndex)
--	
--	local deathnpcid = GetNpcID(npcindex)
--	local w,x,y = GetWorldPos()
--	
--	if(npcid == deathnpcid and npcidx == npcindex)then
--	
--		if(HaveIBBuff(524) == 0)then
--			Msg2Player("Ìì½ÙÊ±¼äÒÑ¹ý£¬ÎÞ·¨Íê³É¶É½Ù£¡")
--		else
--			SetTask(Task_DuJie_Value, SetByte(GetTask(Task_DuJie_Value),1, 2))
--			SetTask(Task_DuJie_Value, SetByte(GetTask(Task_DuJie_Value),3, 0))
--	
--			SetTask(Task_DuJie_NpcID, 0)
--			SetTask(Task_DuJie_NpcIndex, 0)
--			local rand = random(1,100)
--			if(rand <= 90)then
--				ThrowItem(npcindex,PlayerIndex,8,503,2,1,0,0)
--				Msg2Player("µôÂäÁËÒ×¾­µ¤")
--				TopMessage("µôÂäÁËÒ×¾­µ¤")
--			else
--				ThrowItem(npcindex,PlayerIndex,8,504,2,1,0,0)
--	   			Msg2Player("µôÂäÁËÒ×¾­Â¶")
--				TopMessage("µôÂäÁËÒ×¾­Â¶")
--			end
--			TaskNote(1027,4) --¿ÉÒÔÈ¥½»ÈÎÎñÁË
--		end
--	end
--	DelNpc(npcindex)
--end

function no()
    CloseDialog()
end;