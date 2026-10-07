--³Ë»ÆµÄËÀÍö½Å±¾

CREATURE_NAME="ThiÕt Tinh"

function OnDeath(npcidx)
	-- À¶¹Ö´¦Àí
	local npcchr=GetHardNpcAttrib(npcindex)
	if(npcchr>=0)then
		--À¶¹Ö
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
	else
		--ÆÕÍ¨¹Ö
		do_ylangtask()
		do_suipian()
	end;
end;

--¶«ÒÄÈÎÎñ--ÙÈÀÇÈÎÎñ
function do_ylangtask()
	if(GetTask(591)>=2)and(GetTask(591)<=21)and(GetTask(591)~=30)then
		local count=21-GetTask(591);
		if(count > 0)then
			Msg2Player("B¹n cßn ph¶i h¹ "..count.."ThiÕt Tinh.")
			SetTask(591,GetTask(591)+1)
		else
			Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô cña YÓn Lang")
			TaskNote(41,1)
			SetTask(591,30)
		end;
	end;
end;

--·¨Æ÷ËéÆ¬ÈÎÎñ
function do_suipian()
	local mapid,x,y=GetWorldPos()
	if(mapid==76)and(GetTask(597)==30)then	--ÔÚÚæÈªµØÍ¼ÉÏ
		local i=random(1,4)
		if(i==4)then
			AddEventItem(114)
			Msg2Player("NhËn ®­îc 1 m¶nh Ph¸p Khİ!")
		end;
	end;
end;
