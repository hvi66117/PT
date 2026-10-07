--description: ²»Òåºî-½¨³ÇµÀ¾ß³ö´¦
--author: yichuan
--date:2004/8/2

function OnDeath(npcidx)
		SetGlobalValue(112,-1)
		DelNpc(npcidx)
	
		local	prop = {
									{44,"<<M¶nh s¸ch ch­ hÇu>>",{8,193,5,0}},
									{25,"<<S¸ch ch­ hÇu (khëi)>>",{3,58,0,0}},
									{25,"<<S¸ch ch­ hÇu (thõa)>>",{3,59,0,0}},
									{5,"<<S¸ch ch­ hÇu (chuyÓn)>>",{3,60,0,0}},
									{1,"<<S¸ch ch­ hÇu (hîp)>>",{3,61,0,0}}
								}
		local r = random(1,100)
		for i = 1,getn(prop) do
			r = r - prop[i][1] 
			if (r <= 0 ) then
				local itemid=prop[i][3]
				AddNormalItem(itemid[1],itemid[2],itemid[3],itemid[4],0,0)
				if (i == 1) then
					AddGlobalCountNews("Anh hïng c¸i thÕ <color=green>"..GetName().."<color> mét chiªu lÊy ®Çu BÊt NghÜa HÇu, nhËn ®­îc <color=green>"..prop[i][2].."<color>.",20)
					if(GetTeam()~=0)then
						local oldPlayer=PlayerIndex
						local membercount=GetTeamSize()
						for i=1,membercount do
							PlayerIndex=GetTeamMember(i)
							if (PlayerIndex ~= oldPlayer) and (random(1,100) <= 25) then
								AddNormalItem(itemid[1],itemid[2],itemid[3],itemid[4],0,0)
								Msg2Player("B¹n may m¾n nhËn ®­îc <color=green>"..prop[i][2].."<color>")
							end
						end	
						PlayerIndex=oldPlayer
					end
				else
					AddGlobalCountNews("Anh hïng c¸i thÕ <color=green>"..GetName().."<color> mét chiªu lÊy ®Çu cña BÊt NghÜa HÇu, nhËn ®­îc <color=green>"..prop[i][2].."<color>.",20)
				end
				return
			end
		end
end;
