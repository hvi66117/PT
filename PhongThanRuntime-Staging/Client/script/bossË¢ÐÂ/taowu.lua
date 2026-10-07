function  main()
	if (GetGlobalValue(105)==(-1))then
		AddGlobalCountNews("<color=red>Lam B¸<color> håi sinh ë tËn cïng cña B¨ng Xuyªn, mét trËn hµo kiÕp l¹i Ëp xuèng nh©n gian.",20)
		local id = SubWorldID2Idx(36)
		if  (id~=(-1))then
			local a=AddNpc(88,60,id,1291*32,3276*32)
			SetNpcName(a,"<color=yellow>Lam B¸<color> ")
			if(a~=0)then
				SetGlobalValue(105,0)
			end;
		end;
	end;
end;
