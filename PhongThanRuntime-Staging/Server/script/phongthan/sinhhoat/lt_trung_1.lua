-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61371 "Trung Linh Thu" (egg of pet 1, see sh_lib.lua PTLT_PET).
-- Right click: the pet hatches (consumed), kept when the pet is already owned.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function main(nItemIdx)
	return PTLT_UseEgg(nItemIdx, 1)
end
