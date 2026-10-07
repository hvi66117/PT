-- Blaze game server startup script
-- Created in 2006-07-19
-- by zhujialiang

function main()
	AddGlobalCountNews("Trêi ®Êt hçn ®én, yªu ma quû qu¸i kh¾p n¬i dån vÒ <color=red>M¹nh T©n<color> g©y h¹i cho nh©n gian.", 20)
	SendGlobalMessage("Trêi ®Êt hçn ®én, yªu ma quû qu¸i kh¾p n¬i dån vÒ <color=red>M¹nh T©n<color> g©y h¹i cho nh©n gian.")

	local id = SubWorldID2Idx(15)
	if(id ~= -1) then


		local npcidx=AddNpc(444,60, id, 1579*32, 3206*32)		--ÂhËB
		local npcidx=AddNpc(442,40, id, 1584*32, 3206*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1574*32, 3206*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1579*32, 3201*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1579*32, 3211*32)		--¤EÀ¦

		local npcidx=AddNpc(443,60, id, 1615*32, 3367*32)		--½a©_
		local npcidx=AddNpc(442,40, id, 1610*32, 3367*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1620*32, 3367*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1615*32, 3362*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1615*32, 3372*32)		--¤EÀ¦

		local npcidx=AddNpc(445,60, id, 1714*32, 3284*32)		--Å¹ÃK
		local npcidx=AddNpc(442,40, id, 1709*32, 3284*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1719*32, 3284*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1714*32, 3279*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1714*32, 3289*32)		--¤EÀ¦

		local npcidx=AddNpc(446,60, id, 1569*32, 3315*32)		--²V¨P
		local npcidx=AddNpc(442,40, id, 1564*32, 3315*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1574*32, 3315*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1569*32, 3310*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1569*32, 3320*32)		--¤EÀ¦

		local npcidx=AddNpc(441,80, id, 1597*32, 3298*32)		--¤jÄP
		local npcidx=AddNpc(442,40, id, 1592*32, 3298*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1602*32, 3298*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1597*32, 3293*32)		--¤EÀ¦
		local npcidx=AddNpc(442,40, id, 1597*32, 3303*32)		--¤EÀ¦


	end;
end
