--ª√¢…ÒµƒÀ¿ÕˆΩ≈±æ

CREATURE_NAME="C»u Mang th«n"

function OnDeath(npcidx)
	-- ¿∂π÷¥¶¿Ì
	local npcchr=GetHardNpcAttrib(npcindex)
	if(npcchr>=0)then
		--¿∂π÷
		--∞Àÿ‘œµÕ≥¥¶¿Ì
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
		--∆’Õ®π÷
		do_suipian()
	end;
end;

--∑®∆˜ÀÈ∆¨»ŒŒÒ
function do_suipian()
	local mapid,x,y=GetWorldPos()
	if(mapid==76)and(GetTask(597)==30)then	--‘⁄⁄Ê»™µÿÕº…œ
		local i=random(1,4)
		if(i==4)then
			AddEventItem(114)
			Msg2Player("NhÀn Æ≠Óc 1 m∂nh Ph∏p Kh›!")
		end;
	end;
end;
