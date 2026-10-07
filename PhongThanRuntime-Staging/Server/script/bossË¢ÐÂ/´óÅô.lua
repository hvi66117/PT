function  main()
	if (GetGlobalValue(107)==(-1))then
		AddGlobalCountNews("BÝch Du cung ph¸t ra mét tiÕng ®éng rÊt lín, <color=red>§¹i §iªu<color> ®· tØnh l¹i.",20)
		local id = SubWorldID2Idx(46)
		if  (id~=(-1))then
			local a=AddNpc(85,80,id,1603*32,2963*32)
			SetNpcName(a,"<color=yellow>§¹i §iªu<color>")
			if(a~=0)then
				SetGlobalValue(107,0)
			end;
		end;
	end;
end;
