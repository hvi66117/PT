function  OnDeath(npcidx)
		AddGlobalCountNews("Anh hïng c¸i thÕ <color=green>"..GetName().."<color>1 chiªu lÊy <color=blue> Thñ cÊp BOSS Hoµng Kim---NhŞ Lang ThÇn<color>.",20)
		-- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı
		DelNpc(npcidx)
end;
