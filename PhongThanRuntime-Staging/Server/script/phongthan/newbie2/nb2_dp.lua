-- Phong Than 2026-10-03 (newbie2): "Dai phu Tam Son" (1016) and "Dai phu Dong Quan" (1014), the field doctors of
-- taskinfo 900 (Tru hoa) missing from the map data; spawned and bound by ext\newbie2.lua.
Include("\\script\\phongthan\\newbie2\\nb2_lib.lua")

function main(sel)
	PTNB2_ScanNpcs(PTNB2_MAX_NPC)
	PTNB2_Protected(PTNB2_PollPlayer, { GetGameTime() })
	local nm = GetNpcName(GetNpcIdx()) or ""
	Say(nm .. PTNB2_TXT.dp_hello, 2, PTNB2_TXT.dp_heal .. "/PTNB2_DpHeal", PTNB2_TXT.opt_exit .. "/no")
end

function PTNB2_DpHeal()
	RestoreLife()
	RestoreMana()
	Msg2Player(PTNB2_TXT.dp_healed)
	CloseDialog()
end

function no()
	CloseDialog()
end
