-- Phong Than 2026-10-05 (luawave #10): Chuc Dung (zhu rong) (Vien Co 1064). VNG \script\yuan_gu\zhu_rong.lua (script.pak) without its
-- permanent SetCamp(3) (the camp of the character would stay changed and make the bot party hostile) and
-- without SetRevPos(64,225) (VNG map id). Same dialog (string 10622) and the same jump to the camp (1565,3056).
-- ASCII only.

function main()
	MsgBox(10622, "renwu1", "no")
end

function renwu1()
	SetPos(1565, 3056)
	SetFightState(1)
	SetPunish(0)
	CloseDialog()
end

function no()
	CloseDialog()
end
