--818,Â~»í¬±•jª¤¡¼¢uúJüR­p
--819,Â~»íÅ÷ÇP±t»Ö¡¼
--895Ây±þ¥ô°È¨C¶g¦¸¼Æ¡A896³Ì«á¤@¦¸±µ¥ô°È®É¶¡¡A897Ây±þ¹ï¶H¡A898Ây±þ¼Æ¶q
object={
		{name="Ng­u S¸t",id=13},
		{name="D¹ Xoa",id=16},
		{name="Thiªn H¹o",id=17},
		{name="Sa Hån",id=18},
		{name="Lôc Quy",id=20},
		{name="L·o Hå l«",id=23},
		{name="B¨ng Linh",id=28},
		{name="Anh Chiªu ThÇn",id=30},
	}

npc_name=
{
"KiÕm Nh©n",
"TuyÕt qu¸i",
"Háa DiÖn",
"X¹ ThÇn",
"B¨ng Lang",
"Lôc Qu¸i",
"Cuång §iªu",
"Hoµn CÈu",
"YÕm Háa",
"Th¶o Tiªn",
"Cæ §iªu",
"Cèt Tinh",
"Ng­u S¸t",
"Gi¸p Cèt",
"ThiÕt Trïng",
"D¹ Xoa",
"Thiªn H¹o",
"Sa Hån",
"H¾c Phong",
"Lôc Quy",
"§ao CÇm",
"Háa Ng­",
"L·o Hå l«",
"L¹c C¬",
"Giang Quy",
"Tr­ Tinh",
"ThiÕt Ng­",
"B¨ng Linh",
"Háa Ma",
"Anh Chiªu ThÇn",
"Cù Th¹ch",
"H¶i S©m",
"Phi Gi¸p",
"Cèt Tinh V­¬ng",
"Ngäc N÷",
"Háa Tµ",
"Hµ Cèt",
"Thanh Hång §¨ng",
"TiÔn §ao thÇn",
"L©n vò s­",
"S¬n D­¬ng yªu",
"L«i Tr¹ch thÇn",
"D· Mao thÇn",
"Th¹ch thÇn",
"Lam Cèt",
"Bè ThÇn",
"Ma N÷",
"Lam Cèt",
"§íi Tr¹i",
"Lôc Ng« ThÇn",
"Phi Thö",
"H­¬ng d©n",
"¶i Nh©n",
"ThiÕt trïng",
"Phi Gi¸p",
"Ngäc N÷",
"D· Mao",
"Lam Cèt",
"Ma N÷",
"§íi Tr¹i",
"Lôc Ng« ThÇn",
}

function OnDeath(npcindex)
	local npcchr=GetHardNpcAttrib(npcindex)
	local mob_lvl = GetNpcLevel(npcindex)
	local	kindID=GetTask(897)-1
	local	npcID=GetNpcTemplateID(npcindex)
	local	count=GetTask(898)
	if(npcchr>=0)then
		local i=GetLevel()-mob_lvl
		if(i<=10)then
			if(npcchr==0)then
				ThrowItem(npcindex, PlayerIndex,3,15,0,1,0,0)
			elseif(npcchr==1)then	
				ThrowItem(npcindex, PlayerIndex,3,17,0,1,0,0)
			elseif(npcchr==2)then	
				ThrowItem(npcindex, PlayerIndex,3,16,0,1,0,0)
			elseif(npcchr==3)then	
				ThrowItem(npcindex, PlayerIndex,3,21,0,1,0,0)
			elseif(npcchr==4)then	
				ThrowItem(npcindex, PlayerIndex,3,18,0,1,0,0)
			elseif(npcchr==5)then	
				ThrowItem(npcindex, PlayerIndex,3,20,0,1,0,0)
			elseif(npcchr==6)then	
				ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
			elseif(npcchr==7)then	
				ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
			end;
		end;
	end;

	local templateID = GetNpcTemplateID(npcindex)+1
	--¦UÃþ«ö¦a¹Ï²Õ¶¤¦@¨É¦¨ªGªº¥ô°È
	local w,x,y=GetWorldPos()
	local lvl = GetNpcLevel(npcindex)
	if(GetTeam()~=0)then
		-- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- ¹M¾ú¶¤¤¤¶¤­û
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			--¶Ä§LÀçÂy±þ¥ô°È
			liesha_city(templateID,w,lvl)
			--¶}±Òªá¥c¥ô°È¥ÎªºÂy±þ¥ô°È
			huahui_open_task(templateID,w)
			if(kindID==npcID)and(judge_relation()==1)then
				mission_PR()
				--®v®{Ây±þ¥ô°È
			end
		end
		PlayerIndex=oldPlayer
	else
		-- µL¶¤¥î
		--¶Ä§LÀçÂy±þ¥ô°È
		liesha_city(templateID,w,lvl)
			--¶}±Òªá¥c¥ô°È¥ÎªºÂy±þ¥ô°È
		huahui_open_task(templateID,w)
	end;
	--Ê¦Í½ÁÔÉ±?Îñ
end;
--®v®{Ây±þ¥ô°È
function judge_relation()		--º¡¨¬®v®{2¤H¶¤
	local mark=0
	local n=0
	if(GetTeamSize()>0)then			-- ¦³¶¤¥î	
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			mark=IsMasterPRRelation(n)
		end
	end
	return mark
end


function mission_PR()
	local	kindID=GetTask(897)
	local	count=GetTask(898)
	if count <= 0 then return end
	local	mark=HaveIBBuff(215)	--§PÂ_Ây±þ¥ô°Èªº¼Ð»xbuff
	if(mark~=0)then
		if(count>1)then
			SetTask(898,count-1)
			Msg2Player("Trõ Yªu: B¹n ph¶i giÕt"..(count-1)..". "..PTQuestNpcName(kindID).."!")
		else
			SetTask(898,0)
			TaskNote(42,8)
			Msg2Player("Trõ Yªu: B¹n ®· h¹ thµnh c«ng "..PTQuestNpcName(kindID).." ")
		end
	else
		if(count>0)then
			Msg2Player("Trõ Yªu: Vßng s¸ng ®· biÕn mÊt, nhiÖm vô cõu s¸t thÊt b¹i.")
		end
	end
end
--¶Ä§LÀçÂy±þ¥ô°È
function	liesha_city(templateID, world, lvl)
	local task_id = 852 
	if (lvl >= 75)then
		task_id = 858
	elseif(lvl >= 55)then
		task_id = 856
	elseif(lvl >= 35)then
		task_id = 854
	end
	local task_val = GetTask(task_id)
	if(task_val ~= 0) then
		local w,x,y=GetWorldPos()
		if (w == world) then
			local type1 = GetByte(task_val,1)
			local count1=	GetByte(task_val,2)
			local type2 = GetByte(task_val,3)
			local count2= GetByte(task_val,4)
			if count1 == 0 and count2 == 0 then return end
		
			if(type1 == templateID and count1 > 0) then
				count1 = count1 - 1
				if(count1>0)then
					Msg2Player("NhiÖm vô lÝnh ®¸nh thuª: h¹ s¸t thµnh c«ng "..PTQuestNpcName(type1).."("..(50-count1).."/50)")
				else
					count1 = 0
					Msg2Player("NhiÖm vô lÝnh ®¸nh thuª: h¹ s¸t thµnh c«ng "..PTQuestNpcName(type1).." ")
				end
				TaskNote(task_id,-1)
				TaskNote(task_id,0,PTQuestNpcName(type1),(50-count1),PTQuestNpcName(type2),(50-count2))
				SetTask(task_id, SetByte(task_val, 2, count1))
			elseif(type2 == templateID and count2 > 0)then	
				count2 = count2 - 1
				if(count2>0)then
					Msg2Player("NhiÖm vô lÝnh ®¸nh thuª: h¹ s¸t thµnh c«ng "..PTQuestNpcName(type2).."("..(50-count2).."/50)")
				else
					count2 = 0
					Msg2Player("NhiÖm vô lÝnh ®¸nh thuª: h¹ s¸t thµnh c«ng "..PTQuestNpcName(type2).." ")
				end
				TaskNote(task_id,-1)
				TaskNote(task_id,0,PTQuestNpcName(type1),(50-count1),PTQuestNpcName(type2),(50-count2))
				SetTask(task_id, SetByte(task_val, 4, count2))
			end
			if (type1 == templateID or type2 == templateID)and(count1 == 0 and count2 == 0) then
				TaskNote(task_id, 1)
			end
		end
	end
end



--¶}±Òªá¥c¥ô°È¥ÎªºÂy±þ¥ô°È
function huahui_open_task(templateID,world)
	local task_target = GetTask(894)
	if (task_target ~= 0) then
		local w,x,y=GetWorldPos()
		if (w == world) then
			local task_val = GetTask(889)
			local param = {894, floor(GetTask(888)/2) + 1}
			for i=1,4 do
				local t = GetByte(task_target, i)
				local c = GetByte(task_val, i)
				if(t ~= 0) then
					if (t == templateID and c < 50)then
						c = c+1
						if(c < 50)then
							Msg2Player("NhiÖm vô hoa cá: Cõu s¸t thµnh c«ng "..PTQuestNpcName(t).."("..c.."/50))")
						else
							Msg2Player("NhiÖm vô hoa cá: h¹ s¸t thµnh c«ng "..PTQuestNpcName(t).." ")
						end
						SetTask(889,SetByte(GetTask(889), i, c))
					end
					param[getn(param)+1] = c
				end
			end
			TaskNote(894, -1)
			call(TaskNote, param)
		end
	end
end 

function  no()
	CloseDialog()
end;
-- Project compatibility patch, appended to the hash-verified VNG normal.lua.
-- Quest IDs, targets, limits, messages and hard-monster drop tuples remain
-- those in the original source; this fixes execution context, not quest rules.

function PTQuestNpcName(templateID)
    local name = npc_name[templateID]
    if name then return name end
    name = GetNpcTempName(templateID - 1)
    if name and name ~= "" then return name end
    return tostring(templateID)
end

function OnDeath(npcindex)
    local killer = PlayerIndex
    if not killer or killer <= 0 then return end
    local world = GetNpcWorldPos(npcindex)
    local killerWorld = GetWorldPos()
    if not world or world <= 0 or killerWorld ~= world then return end

    local npcID = GetNpcTemplateID(npcindex)
    local lvl = GetNpcLevel(npcindex)
    local npcchr = GetHardNpcAttrib(npcindex)
    -- The eight original ThrowItem tuples, unchanged.
    if npcchr >= 0 and GetLevel() - lvl <= 10 then
        if npcchr == 0 then
            ThrowItem(npcindex, PlayerIndex,3,15,0,1,0,0)
        elseif npcchr == 1 then
            ThrowItem(npcindex, PlayerIndex,3,17,0,1,0,0)
        elseif npcchr == 2 then
            ThrowItem(npcindex, PlayerIndex,3,16,0,1,0,0)
        elseif npcchr == 3 then
            ThrowItem(npcindex, PlayerIndex,3,21,0,1,0,0)
        elseif npcchr == 4 then
            ThrowItem(npcindex, PlayerIndex,3,18,0,1,0,0)
        elseif npcchr == 5 then
            ThrowItem(npcindex, PlayerIndex,3,20,0,1,0,0)
        elseif npcchr == 6 then
            ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
        elseif npcchr == 7 then
            ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
        end
    end

    -- GetTeam() is nil for solo and 0 is a valid team ID in the server.
    -- Snapshot members before changing PlayerIndex; otherwise an invalid or
    -- offline member can change the team from which the next slot is read.
    local membercount = GetTeamSize()
    local members = {}
    if membercount > 0 then
        for i=1,membercount do
            local member = GetTeamMember(i)
            if member and member > 0 then
                members[getn(members)+1] = member
            end
        end
    else
        members[1] = killer
    end

    local credited = {}
    for i=1,getn(members) do
        local member = members[i]
        if not credited[member] then
            credited[member] = 1
            PlayerIndex = member
            local memberWorld = GetWorldPos()
            if memberWorld == world then
                liesha_city(npcID+1, world, lvl)
                huahui_open_task(npcID+1, world)
                -- Read each member's own target, not the killer's task 897.
                if membercount == 2 and GetTask(897) == npcID+1 and
                    GetTask(898) > 0 and judge_relation() == 1 then
                    mission_PR()
                end
            end
        end
    end
    PlayerIndex = killer
end

-- Phong Than 2026-10-03: KNpcTemplate redirects \script\npcdeath\normal.lua to this file, so the Tu Linh
-- kill hook (tutuong_b, tl_lib.lua PTTL_OnKill) must run here too. Errors there never stop the original.
Include("\\script\\phongthan\\tutuong\\tl_lib.lua")
function PTTL_QuestKillErr(m) end
PTTL_QuestOnDeath = OnDeath
function OnDeath(npcindex)
	local pi = PlayerIndex
	if PTTL_OnKill then call(PTTL_OnKill, { npcindex }, "x", PTTL_QuestKillErr) end
	PlayerIndex = pi
	PTTL_QuestOnDeath(npcindex)
end

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

-- 2026-10-03 petexp: Di Nhan pet level/exp (\script\phongthan\lib\petexp_lib.lua, task 2505/2506).
-- PlayerIndex is the player KNpcDeathCalcExp credited (the owner also when the pet killed). Appended
-- after the other hooks; the include and the hook are protected, so errors never stop the original.
function PTPE_QuestKillErr(m) end
if Include then call(Include, { "\\script\\phongthan\\lib\\petexp_lib.lua" }, "x", PTPE_QuestKillErr) end
PTPE_QuestOnDeath = OnDeath
function OnDeath(npcindex)
	local pi = PlayerIndex
	if PTPE_OnKill and pi ~= nil and pi > 0 then call(PTPE_OnKill, { npcindex }, "x", PTPE_QuestKillErr) end
	PlayerIndex = pi
	PTPE_QuestOnDeath(npcindex)
end

-- 2026-10-04 content E4: lifetime monster kill counter for the achievements board (task 2548, read by
-- script\phongthan\content\ac_lib.lua). PlayerIndex = credited killer (owner when the pet killed); protected,
-- errors never stop the original. Appended after the other hooks, the body above stays byte-identical.
function PTAC_QuestKillErr(m) end
function PTAC_QuestKill() SetTask(2548, GetTask(2548) + 1) end
PTAC_QuestOnDeath = OnDeath
function OnDeath(npcindex)
	local pi = PlayerIndex
	if pi ~= nil and pi > 0 then call(PTAC_QuestKill, {}, "x", PTAC_QuestKillErr) end
	PlayerIndex = pi
	PTAC_QuestOnDeath(npcindex)
end
