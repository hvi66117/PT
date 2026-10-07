-- Phong Than 2026-10-01: level data of 1481 (VNG rebirth skill Lv.60, Giap Si).
-- Called by KSkill::LoadSkillLevelData for each LvlSetting of the skills.txt row (ptfix).
-- Returns "value,time,0": time -1 = passive state, >0 = state length in frames.
PTSK_A = {
	["attackspeed_v"] = {2, 0},
	["physicsenhance_p"] = {3, 0},
	["lifemax_p"] = {1, 0},
}
PTSK_TIME = -1

function GetSkillLevelData(levelname, data, level)
	local v = PTSK_A[levelname]
	if v == nil then return "" end
	if levelname == "skill_cost_v" then
		return (v[1] * level + v[2]) .. ",0,0"
	end
	return (v[1] * level + v[2]) .. "," .. PTSK_TIME .. ",0"
end
