function  main()
	if (GetGlobalValue(106)==(-1))then
		AddGlobalCountNews("Khæn Tiªn cung ph¸t ra mét tiÕng ®éng rÊt lín, <color=red>Bµn Cæ<color> ®· tØnh l¹i.",20)
		local id = SubWorldID2Idx(51)
		if  (id~=(-1))then
			local a=AddNpc(82,80,id,1587*32,3400*32)
			SetNpcName(a,"<color=yellow>Bµn Cæ<color>")
			if(a~=0)then
				SetGlobalValue(106,0)
			end;
		end;
	end;
end;
