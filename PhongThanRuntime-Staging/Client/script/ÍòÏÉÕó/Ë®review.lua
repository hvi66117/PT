--description: »ğreview
--author: zhujialiang
--date: 2005/4/12

function main()
		local id = SubWorldID2Idx(4)
		local npcidx=AddNpc(247, 1, id, 1548 * 32, 3232 * 32)
		SetGlobalValue(428,npcidx)
		SetNpcName(npcidx,"<color=yellow>V¹n Tiªn trËn [thñy]<color>")
		SetNpcScript(npcidx, "\\script\\ò¿ÓÈÄ¹\\´«ËÍÃÅ.lua")
		AddGlobalCountNews("<color=green>Cöa V¹n Tiªn trËn (thñy)<color> ®· më.", 20);--ÌáÊ¾½øÈëÍòÏÉÕóµÄÍæ¼Ò¼´½«¿ª·Å¡£

end;
