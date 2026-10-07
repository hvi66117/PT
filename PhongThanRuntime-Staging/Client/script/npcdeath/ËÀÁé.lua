--ËÀÁéµÄËÀÍö½Å±¾

CREATURE_NAME="Lam Cèt"

function OnDeath(npcidx)
	-- À¶¹Ö´¦Àí
	local npcchr=GetHardNpcAttrib(npcindex)
	if(npcchr>=0)then
		--À¶¹Ö
		--³ÇÊĞÁÔÉ±À¶¹Ö´¦Àí
		do_lslan()
		--°ËØÔÏµÍ³´¦Àí
		local i=GetLevel()-GetNpcLevel(npcindex)
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
		-- ÓĞ½ÓÊÜ´ËÖÖ¹ÖÎïµÄÁÔÉ±ÈÎÎñ
		do_task_liesha(531)
	else
		--ÆÕÍ¨¹Ö
		do_task_liesha(530)
		do_task_huashen_liesha() -- »¨»ÜÁÔÉ±ÈÎÎñ
		--³ÇÊĞÁÔÉ±°×¹Ö´¦Àí
		do_lsbai()
		do_dcyls()--¶«ÒÄÈÎÎñÉ±ËÀ20Ö»
	end;
end;

--Ã¿¸öÁÔÉ±ÈÎÎñÍê³ÉÉ³¹ÕÊıÁ¿µÄÊ±ºòÖ´ĞĞ
function do_task_lieshafinish(finish_type)
	Msg2Player("Hoµn thµnh nhiÖm vô:"..finish_type)
end;

--×é¶ÓÁÔÉ±ÅĞ¶¨
function do_task_liesha(task_type)
	if(GetTeam()~=0)then
		-- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- ±éÀú¶ÓÖĞ¶ÓÔ±
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			local count=GetTask(task_type)
			if(count>0)then
				count=count-1
				SetTask(task_type,count)
				if(count<=0)then
					do_task_lieshafinish(task_type)
				else
					Msg2Player("B¹n cßn ph¶i diÖt "..count..".  "..CREATURE_NAME)
				end;
			end
		end;
		PlayerIndex=oldPlayer
	else
		-- ÎŞ¶ÓÎé
		local count=GetTask(task_type)
		if(count>0)then
			count=count-1
			SetTask(task_type,count)
			if(count<=0)then
				do_task_lieshafinish(task_type)
			else
				Msg2Player("Cßn ph¶i giÕt"..count..". "..CREATURE_NAME)
			end;
		end
	end;
end;

--»¨»ÜÁÔÉ±ÈÎÎñ
function do_task_huashen_liesha()
	if(GetTask(348)==1601)then
		local count=GetTask(346)-1;
		if(count > 0)then
			Msg2Player("B¹n cßn ph¶i h¹ "..count.."Lam Cèt.")
			SetTask(346,count)
		else
			Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô cña Cöu Di")
			SetTask(346,100000)
			SetTask(348,0)
		end;
	end;
end;

--ÁÔÉ±ÈÎÎñ°×¹Ö
function do_lsbai()
	if(GetTask(413)==24)then
		local mapid,x,y=GetWorldPos()
		local table_gailv={20,18,16,14,12,10,8,6,5,5,5,5}
		local membercount=1;
		if(GetTeam()~=0)then
			membercount=GetTeamSize()
		end;
		local gailv=table_gailv[membercount]
		if(random(1,100)<=gailv)then
			if(GetTeam()~=0)then
				-- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
				local oldPlayer=PlayerIndex
				local membercount=GetTeamSize()
				-- ±éÀú¶ÓÖĞ¶ÓÔ±
				for i=1,membercount do
					PlayerIndex=GetTeamMember(i)
					local m,x1,y1=GetWorldPos()
					if(m==mapid)then
						calc_task()
					end
				end
				PlayerIndex=oldPlayer
			else
				-- ÎŞ¶ÓÎé
				calc_task()
			end;
		end
	end
end;

function calc_task()
	if(GetTask(413)==24)then
		local count=GetItemCount()+1
		if(count<100)then
			AddEventItem()
			Msg2Player("B¹n ®· ®­îc "..count.."linh hån cña Lam Cèt.")
		else
			Msg2Player("Quay vÒ Tr¹i lİnh ®¸nh thuª phôc mÖnh.")
		end;
	end;
end;

--ÁÔÉ±ÈÎÎñÀ¶¹Ö
function do_lslan()
	if(GetTask(416)==24)then
		local count=GetTask(417)+1
		if(count<3)then
			Msg2Player("B¹n ®· h¹ ®­îc "..count.."Lam Cèt biÕn dŞ.")
			SetTask(417,count)
		else
			Msg2Player("Quay vÒ Tr¹i lİnh ®¸nh thuª phôc mÖnh.")
		end;
	end;
end;

--¶«ÒÄÈÎÎñ--µËæ¿Óñ
function do_dcyls()
	if(GetTask(597)==3)and(GetTask(598)~=100)then
		local count=GetTask(598)-1;
		if(count > 0)then
			Msg2Player("B¹n cßn ph¶i h¹ "..count.."Lam Cèt.")
			SetTask(598,count)
		else
			Msg2Player("Hoµn thµnh nhiÖm vô §Æng ThiÒn Ngäc.")
			TaskNote(35,3)
			SetTask(598,100)
		end;
	end;
end;
