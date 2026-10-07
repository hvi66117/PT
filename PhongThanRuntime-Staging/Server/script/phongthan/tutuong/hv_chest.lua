-- Phong Than 2026-10-02 (tutuong_b): Huyen Vu Bao Ruong (chest NPC, tpl 1759) at the end of
-- Thu Thach Huyen Vu. Only the owner (NPC param 0 + run serial) can open it.
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\tutuong\\hv_lib.lua")

function main(npc)
	if npc == nil or npc <= 0 or GetNpcParam(npc, 0) ~= PlayerIndex or GetNpcParam(npc, 1) ~= GetTask(PTTT_T_HV_SERIAL) or GetTask(PTTT_T_HV_STATE) ~= 3 then
		PTTT_Say("B¶o R­¬ng nµy kh«ng thuéc vÒ ng­¬i.", {})
		return
	end
	PTTT_Say("HuyÒn Vò B¶o R­¬ng táa ¸nh s¸ng xanh thÉm. Më r­¬ng (cÇn 8 « trèng) vµ rêi ThÇn Vùc?", { "Më B¶o R­¬ng/PTHV_OpenChest" })
end

function PTHV_OpenChest()
	PTHV_Claim()
end

function Timeout(npc)
	if GetNpcParam(npc, 1) ~= 0 then
		SetNpcParam(npc, 1, 0)
		DelNpc(npc)
	end
end