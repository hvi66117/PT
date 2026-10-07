function  OnDeath(npcidx)
	local w,x,y = GetWorldPos()
	if(GetTeam()~=0)then
		-- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- ±éÀú¶ÓÖĞ¶ÓÔ±
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			blessing(w)
		end
		PlayerIndex=oldPlayer
	else
		-- ÎŞ¶ÓÎé
		blessing(w)
	end;
end;

function blessing(world)
	local w,x,y = GetWorldPos()
	if (w == world) then
		AddIBBuff(203)
		TopMessage("NhËn ®­îc <color=green>Linh Thñ<color>, t¨ng toµn bé kh¸ng tİnh")
	end
end