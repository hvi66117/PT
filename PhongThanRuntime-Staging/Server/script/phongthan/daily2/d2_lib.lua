-- Phong Than 2026-10-03 (daily2): dialog-side library of the newer-era daily quests (NPC scripts and
-- the field-monster script). F11 records go through the VNG taskinfo texts (vng_tasknote.lua), ids
-- 56 Thien Cong, 53 Thien Cuong Hon, 48 Sieu Do Linh Hon, 70 Hap Hon Am Sat, 61 Nhiem vu van chuyen.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
Include("\\script\\phongthan\\daily2\\d2_core.lua")

-- runtime map id -> Vietnamese name (VNG ÕÐ»êá¦.lua mapname table, map N = runtime 1000 + N)
PTD2_MAPNAMES = {
	[1001] = "Phong ThÇn §µi", [1002] = "Sïng Thµnh §¹i Doanh", [1003] = "Ngäc H­ Cung", [1004] = "Xi V­u Mé",
	[1005] = "Sïng Thµnh", [1006] = "B¾c H¶i", [1007] = "YÕn S¬n", [1008] = "Ch©n nói C«n L«n",
	[1009] = "T©y C«n L«n", [1010] = "Thñ D­¬ng S¬n", [1011] = "Du Hån", [1012] = "Miªu C­¬ng",
	[1013] = "Cù Léc", [1014] = "§ång Quan", [1015] = "M¹nh T©n", [1016] = "Tam S¬n", [1017] = "Kú S¬n",
	[1018] = "Môc D·", [1019] = "TuyÖt Long LÜnh", [1020] = "T©y Kú", [1021] = "TriÒu Ca",
	[1022] = "Hoang M¹c", [1023] = "Thæ Thµnh", [1024] = "Phong ThÇn", [1025] = "Lôc Ch©u",
	[1026] = "Sa M¹c ChÕt", [1027] = "Hiªn Viªn tÇng 1", [1028] = "Hiªn Viªn tÇng 2",
	[1029] = "Hiªn Viªn tÇng 3", [1030] = "Hiªn Viªn tÇng 4", [1031] = "Hiªn Viªn tÇng 5",
	[1032] = "Ngäc TuyÒn", [1033] = "TuyÕt Cèc", [1034] = "§¹i Phong", [1035] = "§¹i Th¹ch",
	[1036] = "B¨ng Xuyªn Cùc", [1037] = "Thñy Vùc", [1038] = "Long Cung", [1039] = "H¶i C©u",
	[1040] = "Long Vùc", [1041] = "Long Uyªn", [1042] = "BÝch Du Cung tÇng 1", [1043] = "BÝch Du Cung tÇng 2",
	[1044] = "BÝch Du Cung tÇng 3", [1045] = "BÝch Du Cung tÇng 4", [1046] = "BÝch Du Cung tÇng 5",
	[1047] = "Khæn Tiªn Cung tÇng 1", [1048] = "Khæn Tiªn Cung tÇng 2", [1049] = "Khæn Tiªn Cung tÇng 3",
	[1050] = "Khæn Tiªn Cung tÇng 4", [1051] = "Khæn Tiªn Cung tÇng 5", [1052] = "Diªu Tr×",
	[1055] = "§«ng Doanh", [1056] = "Ph­¬ng Tr­îng", [1065] = "TrÇn §­êng" }

function PTD2_MapName(m)
	return PTD2_MAPNAMES[m] or ("b¶n ®å " .. m)
end

-- "(x/y)" as the minimap shows it (NewWorld x / 8, y / 16)
function PTD2_PosText(x, y)
	return "(" .. floor(x / 8) .. "/" .. floor(y / 16) .. ")"
end

function PTD2_Exp(n)
	AddOwnExp(n)
	return n
end

-- items { genre, detail, particular, level, series, luck, count } through QuestExchange (guarded by
-- the task value from -> to); 1 when given, nil when the bag has no room (nothing changes then)
function PTD2_GiveGuarded(task, from, to, need, items)
	return QuestExchange(task, from, to, need, items) == 1
end

PTD2_ColG = "<color=green>"
PTD2_ColY = "<color=yellow>"
PTD2_ColR = "<color=red>"
PTD2_ColE = "<color>"
