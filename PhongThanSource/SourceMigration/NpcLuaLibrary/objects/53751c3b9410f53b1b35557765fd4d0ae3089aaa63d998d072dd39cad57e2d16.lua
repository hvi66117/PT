function  OnDeath(npcidx)
		SetGlobalValue(110,-1)
		DelNpc(npcidx)
		local  i=GetName()
		AddGlobalCountNews("H¬i thë cña <color=green>Ly Long<color> ®· t¾t, c¸nh cña nã treo trªn <color=green>"..i.."<color>.",20)
end;
