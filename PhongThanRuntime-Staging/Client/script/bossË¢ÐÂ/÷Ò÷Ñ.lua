function  main()
	if (GetGlobalValue(104)==(-1))then
		AddGlobalCountNews("<color=red>C«n Bèi<color> håi sinh ë ®Çu nguån T­¬ng Nham, mét trËn hµo kiÕp l¹i Ëp xuèng nh©n gian.",20)
		local id = SubWorldID2Idx(31)
		if  (id~=(-1))then
			local a=AddNpc(89,60,id,1990*32,3076*32)
			SetNpcName(a,"<color=yellow>C«n Bèi<color>")
			if(a~=0)then
				SetGlobalValue(104,0)
			end;
		end;
	end;
end;
