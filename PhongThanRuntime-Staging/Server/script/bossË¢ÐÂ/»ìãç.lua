function  main()
	if (GetGlobalValue(102)==(-1))then
		AddGlobalCountNews("<color=red>ThiÕt Bè<color> håi sinh ë tËn cïng sa m¹c, mét trËn hµo kiÕp l¹i Ëp xuèng nh©n gian.",20)
		local id = SubWorldID2Idx(26)
		if  (id~=(-1))then
			local a=AddNpc(90,60,id,1763*32,2931*32)
			SetNpcName(a,"<color=yellow>ThiÕt Bè<color>")
			if(a~=0)then
				SetGlobalValue(102,0)
			end;
		end;
	end;
end;
