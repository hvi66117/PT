-- Phong Than 2026-10-05 (luawave #10): Thieu Hao (shao hao) (Vien Co 1064). VNG \script\yuan_gu\shao_hao.lua (script.pak) without its
-- permanent SetCamp(2) (the camp of the character would stay changed and make the bot party hostile) and
-- without SetRevPos(64,223) (VNG map id). Same dialog (string 10600) and the same jump to the camp (1397,3207).
-- ASCII only.

function main()
	MsgBox(10600, "renwu1", "no")
end

function renwu1()
	SetPos(1397, 3207)
	SetFightState(1)
	SetPunish(0)
	CloseDialog()
end

function no()
	CloseDialog()
end
