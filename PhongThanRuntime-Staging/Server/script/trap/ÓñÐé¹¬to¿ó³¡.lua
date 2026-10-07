-- Phong Than 2026-09-28: authored replacement for the missing VNG trap script
-- \script\trap\[GBK yuxugong]to[GBK kuangchang].lua (trap id 0xCA147D6C, 42 cells in map 1003
-- regions 99,95 and 99,96). Absent from all server/client PAKs. To take effect it must live at
-- exactly that path (GBK bytes) so g_FileName2Id(lowercase path) == trap id; see report.
-- Target: map 57 (1057 Khoang truong) at 1608,3094, same point as the VNG SuperTrap entry.

function main(sel)
	Msg2Player("§Õn Kho¸ng tr­êng")
	NewWorld(57,1608,3094);
	SetFightState(1)
end;
