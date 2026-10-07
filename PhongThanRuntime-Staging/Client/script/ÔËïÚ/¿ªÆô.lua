--description:ïÚ³µ
--author:ÈÙ½¯·É
--data:2004.7.27

function main()

	local id = SubWorldID2Idx(19)
	if(id ~= -1) then

	
		local pos = 
		{
			{x=1464,y=3239},
			{x=1462,y=3330},
			{x=1434,y=3210},
			{x=1500,y=3356},
			{x=1495,y=3416}
		}
	
		local sel=random(1,5)
		local npcidx=AddNpc(152, 1, id, pos[sel].x * 32, pos[sel].y * 32)
		SetGlobalValue(426,npcidx)
		SetNpcName(npcidx,"Tiªu ®Çu thÇn bÝ")
		SetNpcScript(npcidx, "\\script\\ÔËïÚ\\ÉñÃØïÚÍ·.lua")
	end;

	SetGlobalValue(422,1)
	SetGlobalValue(423,0)
	SetGlobalValue(424,0)
	AddGlobalCountNews("Theo truyÒn thuyÕt Tiªu ®Çu thÇn bÝ chØ tin t­ëng vµ tuyÓn chän nh÷ng dòng sÜ thiÖn chiÕn!",20)
	local d= GetGlobalValue(425)--Çå³ý±¦Ïä
	if (d > 0) then
		DelNpc(d)
		SetGlobalValue(425,0)
	end;
end;

