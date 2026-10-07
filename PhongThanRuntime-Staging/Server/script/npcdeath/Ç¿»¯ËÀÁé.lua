--Ç¿»¯ËÀÁéµÄËÀÍö½Å±¾
--lixuewu 2005

function OnDeath(npcidx)
	w,x,y=GetWorldPos()
	if(GetTeam()~=0)then
		-- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- ±éÀú¶ÓÖĞ¶ÓÔ±
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			calc_task(w)
		end
		PlayerIndex=oldPlayer
	else
		-- ÎŞ¶ÓÎé
		calc_task(w)
	end;
end

function calc_task(w1)
	if(GetTask(408)==2)then
		w,x,y=GetWorldPos()
		if(w==w1)then
			local today=floor(SystemTime()/86400)
			if(today==GetTask(409))then
				local count=GetTask(407)
				if(count>0)then
					count=count-1
					SetTask(407,count)
					if(count==0)then
						Msg2Player("Hoµn thµnh nhiÖm vô trõ Lam Cèt")
						TopMessage("Hoµn thµnh nhiÖm vô trõ Lam Cèt")
						SetTask(408,100000)
					else
						Msg2Player("B¹n cßn ph¶i diÖt "..count.."Lam Cèt")
					end
				end
			else
				SetTask(407,0)
				SetTask(408,0)
				TopMessage("NhiÖm vô V¹n Tiªn trËn ®· qu¸ h¹n")		
				Msg2Player("NhiÖm vô V¹n Tiªn trËn ®· qu¸ h¹n")		
			end
		end
	end
end
