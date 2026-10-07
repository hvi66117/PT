function  main()
	if (GetGlobalValue(103)==(-1))then
		AddGlobalCountNews("<color=red>Kim Tr¹i<color> håi sinh ë §«ng H¶i Long Cung, mét trËn hµo kiÕp l¹i Ëp xuèng nh©n gian.",20)
		local id = SubWorldID2Idx(41)
		if  (id~=(-1))then
			local a=AddNpc(87,60,id,1795*32,3483*32)
			SetNpcName(a,"<color=yellow>Kim Tr¹i<color>")
			if(a~=0)then
				SetGlobalValue(103,0)
			end;
		end;
	end;
end;
