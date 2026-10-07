function  main()
	if (GetGlobalValue(109)==(-1))then
		AddGlobalCountNews("<color=red>Giao Long<color> ph∏t ra ti’ng hËng khi’n m‰i ng≠Íi ta run r»y.",20)
		local id = SubWorldID2Idx(55)
		if  (id~=(-1))then
			local a=AddNpc(97,100,id,1706*32,2953*32)
			SetNpcName(a,"<color=yellow>Giao Long<color>")
			if(a~=0)then
				SetGlobalValue(109,0)
			end;
		end;
	end;
end;
