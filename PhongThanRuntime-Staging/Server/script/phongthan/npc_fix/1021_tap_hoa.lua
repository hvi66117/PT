-- Phong Than npc_fix 2026-09-29: Tap Hoa (equipment shop), map 1021; original script.pak \script\ChaoGe\ZaHuoShang.lua (pinyin of GBK path); changes: none to the logic (copied so the spawned NPC can be bound by name). Sale 13.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ‘”ªıµÍ-‘”ªıœ˙ €…Ã
--author: yichuan
--date: 2004/6/10

function main(sel)
	if (songxin()==0)then
		MsgBox(10072,"yes","no")
	end
end;

function songxin()
	local task_id = 870
	local map_id = 4

	local task_val = GetTask(task_id)
	local type1 = GetByte(task_val,1) 
	local type2 = GetByte(task_val,2)
	local finish = GetByte(task_val,3)

	local setbit = 0
	if (type1 == map_id) then
		setbit = 7
	elseif (type2 == map_id)then
		setbit = 8
	end

	if (setbit ~= 0) then
	 	if (GetBit(finish, setbit) == 0)then
	 		Talk(1,"no","Ng≠¨i v t v∂ qu∏!")
			SetTask(task_id, SetByte(task_val,3,SetBit(finish, setbit, 1)))
	 		return 1
	 	end
	end
	return 0
end

function yes()
		CloseDialog()
		Sale(13);
end;

function no()
		CloseDialog()
end;