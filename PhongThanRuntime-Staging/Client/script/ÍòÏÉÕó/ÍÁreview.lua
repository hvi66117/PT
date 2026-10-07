--description: »ğreview
--author: zhujialiang
--date: 2005/4/12

function main()
		local id = SubWorldID2Idx(2)
		local npcidx=AddNpc(247, 1, id, 1650 * 32, 3159 * 32)
		SetGlobalValue(427,npcidx)
		SetNpcName(npcidx,"<color=yellow>V¹n Tiªn trËn [thæ]<color>")
		SetNpcScript(npcidx, "\\script\\³ç³Ç´óÓª\\´«ËÍÃÅ.lua")
		AddGlobalCountNews("<color=green>Cöa V¹n Tiªn trËn (thæ)<color> ®· më.", 20);--ÌáÊ¾½øÈëÍòÏÉÕóµÄÍæ¼Ò¼´½«¿ª·Å¡£

end;
