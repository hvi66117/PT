-- Phong Than 2026-10-02 (tutuong_b): item script of Chia khoa Linh Te (ibitem 8/329/2). ptfix
-- (extra_tutuong_b.py) points the NONE script column of that ibitem.txt row here. Right click:
-- +1 Tu Linh run today (at most PTTL_EXTRA_MAX a day); the key is consumed (PTCompat_UseCharge).
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\tutuong\\tl_lib.lua")

function main(idx)
	if idx == nil or idx <= 0 then return end
	PTTL_Sync()
	if GetTask(PTTT_T_TL_EXTRA) >= PTTL_EXTRA_MAX then
		Msg2Player("H«m nay ng­¬i ®· dïng ®ñ " .. PTTL_EXTRA_MAX .. " Ch×a khãa Linh Tª, ngµy mai h·y dïng tiÕp.")
		return
	end
	local ok = 0
	if PTCompat_UseCharge then ok = PTCompat_UseCharge(idx) else ok = RemoveItem(idx, 1, 0) end
	if ok ~= 1 then return end
	SetTask(PTTT_T_TL_EXTRA, GetTask(PTTT_T_TL_EXTRA) + 1)
	Msg2Player("<color=green>Ch×a khãa Linh Tª:<color> h«m nay ng­¬i ®­îc nhËn thªm 1 l­ît Tø Linh (cßn " .. PTTL_Left() .. " l­ît). H·y gÆp ThÇy t­íng sè ë TriÒu Ca hoÆc T©y Kú.")
end
