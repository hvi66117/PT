function  main()
	if (GetGlobalValue(110)==(-1))then
		AddGlobalCountNews("<color=red>Ly Long<color> ®· s¶i ®«i c¸nh khiÕn ng­êi ta khiÕp sî.",20)
		local id = SubWorldID2Idx(56)
		if  (id~=(-1))then
			local a=AddNpc(98,100,id,1750*32,3056*32)
			SetNpcName(a,"<color=yellow>Ly Long<color>")
			if(a~=0)then
				SetGlobalValue(110,0)
			end;
		end;
	end;
end;
