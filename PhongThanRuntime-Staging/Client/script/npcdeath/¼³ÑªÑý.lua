--¼³ÑªÑıµÄËÀÍö½Å±¾

CREATURE_NAME="HuyÕt Yªu"

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
		do_yhutask()
	end;
end;

--¶«ÒÄÈÎÎñ--ÙÈÁúÈÎÎñ
function do_yhutask()
	if(GetTask(590)>=2)and(GetTask(590)<=21)and(GetTask(590)~=30)then
		local count=21-GetTask(590);
		if(count > 0)then
			Msg2Player("B¹n cßn ph¶i h¹ "..count.."HuyÕt Yªu.")
			SetTask(590,GetTask(590)+1)
		else
			Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô cña YÓn Hæ")
			TaskNote(40,1)
			SetTask(590,30)
		end;
	end;
end;
