-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61378 "Trung Linh Thu" (egg of pet 8, see sh_lib.lua PTLT_PET).
-- Right click: the pet hatches (consumed), kept when the pet is already owned.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function main(nItemIdx)
	return PTLT_UseEgg(nItemIdx, 8)
end
