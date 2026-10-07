--description: »ğreview
--author: zhujialiang
--date: 2005/4/12

function main()
		local id = SubWorldID2Idx(1)
		local npcidx=AddNpc(247, 1, id, 1510 * 32, 3290 * 32)
		SetGlobalValue(430,npcidx)
		SetNpcName(npcidx,"<color=yellow>V¹n Tiªn trËn [Phong]<color>")
		SetNpcScript(npcidx, "\\script\\·âÉñÌ¨\\´«ËÍÃÅ.lua")
		AddGlobalCountNews("<color=green>Cöa V¹n Tiªn trËn (Phong)<color> ®· më.", 20);--ÌáÊ¾½øÈëÍòÏÉÕóµÄÍæ¼Ò¼´½«¿ª·Å¡£

end;
