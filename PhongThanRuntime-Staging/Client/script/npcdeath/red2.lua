function OnDeath(npcidx)
	do_sershu()
	if(random(100)<50)then
		SetPK(GetPK()-3)
		Msg2Player("S¸t khÝ cña b¹n ®· gi¶m ")
	end
end;

--Ä§ÀñÊÙÈÎÎñ
function do_sershu()
	if(GetTask(586)>1)then
		local count=GetTask(586)-1;
		Msg2Player("B¹n cßn ph¶i h¹ "..count.."Phi Thè.")
		SetTask(586,count)
	elseif(GetTask(586)==1)then
		Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô cña Ma LÔ Thä")
		SetTask(586,0)
	--	TaskNote(35,¡£)
	end;
end;
