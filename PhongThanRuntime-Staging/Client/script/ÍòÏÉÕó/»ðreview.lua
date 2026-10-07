--description: »ğreview
--author: zhujialiang
--date: 2005/4/12

function main()
		local id = SubWorldID2Idx(3)
		local npcidx=AddNpc(247, 1, id, 1709 * 32, 3105 * 32)
		SetGlobalValue(429,npcidx)
		SetNpcName(npcidx,"<color=yellow>V¹n Tiªn trËn [Háa]<color>")
		SetNpcScript(npcidx, "\\script\\ÓñĞé¹¬\\´«ËÍÃÅ.lua")
		AddGlobalCountNews("<color=green>Cöa V¹n Tiªn trËn (Háa)<color> ®· më.", 20);--ÌáÊ¾½øÈëÍòÏÉÕóµÄÍæ¼Ò¼´½«¿ª·Å¡£

end;
