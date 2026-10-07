function  main()
	if (GetGlobalValue(101)==(-1))then
		--AddGlobalCountNews("111",20)
		local id = SubWorldID2Idx(16)
		if  (id~=(-1))then
			local a=AddNpc(86,40,id,1590*32,3336*32)
			SetNpcName(a,"<color=yellow>Cöu Linh<color>")
			if(a~=0)then
				SetGlobalValue(101,0)
			end;
		end;
	end;
end;
