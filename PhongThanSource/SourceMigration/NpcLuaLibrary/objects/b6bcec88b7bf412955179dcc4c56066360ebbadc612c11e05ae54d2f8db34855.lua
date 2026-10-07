--¶È½ÙÈÎÎñÊ±¼äºÍÈÎÎñ±äÁ¿
Task_DuJie_Value = 1326   --1 byte ÈÎÎñ²½Öè±äÁ¿3ÒªÉ±ËÀ¹ÖµÄ¸öÊı

Global_Lamp_LightCount = 167 -- 1byteÈ«¾Ö±äÁ¿£¬ÁÁµÆÊıÁ¿ 2byte ÉÏ´ÎÁÁµÆ·½,1ÏÉ,2Ä§

--yaoxin 09/06/22

function OnDeath(npcindex)
    local oldplayerid = GetNpcTask(npcindex, 1)
    local playId = GetPlayerID()
    local npcname = GetNpcName(npcindex)
    local leftkill = GetTaskByte(Task_DuJie_Value, 3)
    if (oldplayerid == playId) then
        if (leftkill <= 7 and leftkill > 0) then
            setnextnpc(npcindex, playId, PlayerIndex, leftkill, npcname)
        end
    else
        local membercount = GetTeamSize()
        local key = 0 --1ÊÇ¶ÓÓÑÉ±,2ÊÇÍâ¶ÓÉ±,0ÊÇÒì³£×´Ì¬
        local oldPlayer = PlayerIndex

        if (membercount > 1) then
            -- ±éÀú¶ÓÖĞ¶ÓÔ±	
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                playId = GetPlayerID()
                if (oldplayerid == playId) then
                    leftkill = GetTaskByte(Task_DuJie_Value, 3)
                    key = 1
                    if (leftkill <= 7 and leftkill > 0) then
                        if (getLuck(key, leftkill) == 1) then
                            setnextnpc(npcindex, oldplayerid, PlayerIndex, leftkill, npcname)
                        end
                    end
                    break
                end
            end
        end

        if (key == 0) then
            PlayerIndex = SearchPlayerById(oldplayerid)
            if (PlayerIndex > 0) then
                leftkill = GetTaskByte(Task_DuJie_Value, 3)
                key = 2
                if (getLuck(key, leftkill) == 1) then
                    setnextnpc(npcindex, oldplayerid, PlayerIndex, leftkill, npcname)
                end
            end
        end
        PlayerIndex = oldPlayer
    end
    DelNpc(npcindex)
end

function setnextnpc(npcidx, pID, pIdx, leftkill, name)
    if (pIdx > 0) then
        local oldplayer = PlayerIndex
        PlayerIndex = pIdx

        if (HaveIBBuff(524) == 0) then
            Msg2Player("Thêi gian Thiªn KiÕp ®· qua, kh«ng thÓ hoµn thµnh ®é kiÕp!")
            return 0
        end

        local killnum = 7 - (leftkill - 1)
        local w, x, y = GetNpcWorldPos(npcidx)
        local newnpcidx = AddNpc(823 + killnum, 30, SubWorld, x * 32, y * 32)
        SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1200)
        SetNpcName(newnpcidx, name)
        SetNpcTask(newnpcidx, 1, pID)
        SetTaskByte(Task_DuJie_Value, 3, leftkill - 1)
        Msg2Player("Cßn cÇn hµng phôc" .. (leftkill - 1) .. " XuÊt KhiÕu Nguyªn ThÇn")
        ScrollMessage("Hµng phôc ®­îc" .. killnum .. " XuÊt KhiÕu Nguyªn ThÇn")
        TaskNote(1027, 2, (leftkill - 1))
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

--ĞŞ¸ÄÇ°,
--function OnDeath(npcindex)
--
--	if(HaveIBBuff(524) == 0)then
--	    Msg2Player("Ìì½ÙÊ±¼äÒÑ¹ı£¬ÎŞ·¨Íê³É¶É½Ù£¡")
--	    DelNpc(npcindex)
--	    return  0
--	end
--	
--	local npcid = GetTask(Task_DuJie_NpcID)
--	local npcidx= GetTask(Task_DuJie_NpcIndex)
--	
--	local deathnpcid = GetNpcID(npcindex)
--	local w,x,y = GetWorldPos()
--	local name = GetName()
--	local leftkill = GetByte(GetTask(Task_DuJie_Value),3)
--	if(npcid == deathnpcid and npcidx == npcindex and leftkill <= 7 and leftkill > 0)then
--	      	  SetTask(Task_DuJie_Value, SetByte(GetTask(Task_DuJie_Value),3,leftkill - 1))
--	     	  local killnum = 7 - (leftkill - 1)
--		  local newnpcidx = AddNpc(823+killnum,30,SubWorld,x*32,y*32)
--		  SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1200)
--		  local newnpcid  = GetNpcID(newnpcidx)
--		  SetTask(Task_DuJie_NpcID, newnpcid)
--		  SetTask(Task_DuJie_NpcIndex, newnpcidx)
--		  SetNpcName(newnpcidx,"<c=g>"..name.."<c>³öÇÏÔªÉñ")
--		  Msg2Player("»¹Ğè½µ·ü"..(leftkill - 1).."Ö»³öÇÏÔªÉñ")
--		  ScrollMessage("½µ·üÁËµÚ"..killnum.."Ö»³öÇÏÔªÉñ")
--		  TaskNote(1027,2,(leftkill - 1))
--	end
--	DelNpc(npcindex)
--end

function no()
    CloseDialog()
end;