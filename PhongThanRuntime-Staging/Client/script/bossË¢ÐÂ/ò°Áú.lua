function  main()
	if (GetGlobalValue(111)==(-1))then
		AddGlobalCountNews("<color=red>Di Long<color> c t ti’ng rËng ch n ÆÈng nh©n gian, li÷t di÷m lπi bÔng ch∏y l«n n˜a.",20)
		local id = SubWorldID2Idx(54)
		if  (id~=(-1))then
			local a=AddNpc(99,100,id,1624*32,2985*32)
			SetNpcName(a,"<color=yellow>Di Long<color>")
			if(a~=0)then
				SetGlobalValue(111,0)
			end;
		end;
	end;
end;
