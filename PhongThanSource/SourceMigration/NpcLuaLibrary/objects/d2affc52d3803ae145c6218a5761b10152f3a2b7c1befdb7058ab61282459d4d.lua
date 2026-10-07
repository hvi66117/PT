function  OnDeath(npcidx)
		SetGlobalValue(111,-1)
		DelNpc(npcidx)
		local  i=GetName()
		AddGlobalCountNews("LiÖt diÖm cña <color=green>Di Long<color> ®· bŞ dËp t¾t, trªn vò khİ cña <color=green>"..i.."<color> cßn dİnh ®Çy m¸u t­¬i nãng hæi cña ThÇn Long.",20)
end;
