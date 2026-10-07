-- Phong Than 2026-10-05 (luawave #10): Khoa Phu (kua fu) (Vien Co 1064). VNG \script\yuan_gu\kua_fu.lua (script.pak) without its
-- permanent SetCamp(4) (the camp of the character would stay changed and make the bot party hostile) and
-- without SetRevPos(64,224) (VNG map id). Same dialog (string 10594) and the same jump to the camp (1802,3232).
-- ASCII only.

function main()
	MsgBox(10594, "renwu1", "no")
end

function renwu1()
	SetPos(1802, 3232)
	SetFightState(1)
	SetPunish(0)
	CloseDialog()
end

function no()
	CloseDialog()
end
