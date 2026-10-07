function OnDeath(npcindex)
	-- À¶¹Ö´¦Àí
	local npcchr=GetHardNpcAttrib(npcindex)
	if(npcchr>=0)then
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
	end;
	-- ¶ËÎç½Ú»î¶¯
	if(GetTask(396)==5)then
		if(GetTask(397)==5)then
			local killed=GetTask(398)+1;
			SetTask(398,killed)
			if(killed>=49)then
				Msg2Player("Chóc mõng! B¹n ®· hoµn thµnh nhiÖm vô cña KhuÊt Nguyªn")
				SetTask(396,6)
			else
				Msg2Player("B¹n cßn ph¶i diÖt "..(49-killed).."Ngäc N÷.")
			end;
		end;
	end;
end;
