-- Phong Than 2026-10-01: level data of 1489 (VNG rebirth skill Lv.180, Di Nhan).
-- Called by KSkill::LoadSkillLevelData for each LvlSetting of the skills.txt row (ptfix).
-- Returns "value,time,0": time -1 = passive state, >0 = state length in frames.
PTSK_A = {
	["poisontimereduce_p"] = {5, 0},
	["stuntimereduce_p"] = {5, 0},
	["poisonres_p"] = {3, 0},
	["allres_p"] = {2, 0},
	["skill_cost_v"] = {10, 80},
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
