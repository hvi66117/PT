-- Phong Than 2026-10-01: level data of 1488 (VNG rebirth skill Lv.120, Di Nhan).
-- Called by KSkill::LoadSkillLevelData for each LvlSetting of the skills.txt row (ptfix).
-- Returns "value,time,0": time -1 = passive state, >0 = state length in frames.
PTSK_A = {
	["fatallystrikeenhance_p"] = {2, 0},
	["fastwalkrun_p"] = {2, 0},
	["skill_cost_v"] = {10, 50},
}
PTSK_TIME = 3240

function GetSkillLevelData(levelname, data, level)
	local v = PTSK_A[levelname]
	if v == nil then return "" end
	if levelname == "skill_cost_v" then
		return (v[1] * level + v[2]) .. ",0,0"
	end
	return (v[1] * level + v[2]) .. "," .. PTSK_TIME .. ",0"
end
