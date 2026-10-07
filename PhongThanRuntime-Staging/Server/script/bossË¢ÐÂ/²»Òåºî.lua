function  main()
	if (GetGlobalValue(112)==(-1))then
		--AddGlobalCountNews("竜<color=red>ぃ竡獼<color>瞷祍窖獼瓣瓣ぇ腳",20) --建城功能未开放前不发公告
		local id = SubWorldID2Idx(62)
		if  (id~=(-1))then
			local a=AddNpc(125,60,id,1681*32,3246*32)
			SetNpcName(a,"<color=yellow>B蕋 Ngh躠 H莡<color> ")
			if(a~=0)then
				SetGlobalValue(112,0)
			end;
		end;
	end;
end;
