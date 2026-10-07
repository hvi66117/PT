-- Phong Than 2026-10-03 (tienma45): Ha Do Lac Thu (magicscript 6/1/529). The VNG original (task 1489/1490,
-- Lua 5 calls) is backed up in _backup\20261002-tienma45; the same stub is also in ptfix (extra_tienma45.py).
Include("\\script\\phongthan\\tienma45\\tm45_item.lua")
function main(idx)
	return PT45_ItemHaDo(idx)
end

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
