function  main()
	if (GetGlobalValue(108)==(-1))then
		--AddGlobalCountNews("111",20)
		local id = SubWorldID2Idx(65)
		if  (id~=(-1))then
			local a=AddNpc(96,80,id,1756*32,3305*32)
			SetNpcName(a,"<color=yellow>Nhﬁ Lang Th«n<color>")
			if(a~=0)then
				SetGlobalValue(108,0)
			end;
		end;
	end;
end;
