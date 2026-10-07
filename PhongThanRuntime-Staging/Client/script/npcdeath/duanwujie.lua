--¶ËÎç»î¶¯ÁÔÉ±¶ñ¹í

function OnDeath(npcidx)
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
	DelNpc(npcidx)
end;

function calc_task(w1)
	if(GetTask(728)==3)then	--ÓĞÉ±¸ÃbossµÄÈÎÎñ
		SetTask(728,9)		--ÒÑÉ±ËÀ±ê¼Ç
		TopMessage("NhËn ®­îc Táa Hån ch©u, sö dông cã thÓ chuyÓn ®Õn bªn c¹nh KhuÊt Nguyªn.")
		AddNormalItem(6,1,177,1,0,0,0)		--ÇüÔ­µÄ»êÆÇ
	end
end;