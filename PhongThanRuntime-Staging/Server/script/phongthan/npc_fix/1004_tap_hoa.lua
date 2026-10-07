-- Phong Than npc_fix 2026-09-28: Tap Hoa (general store, map 1004); original script.pak \script\ChiYouMu\ZaHuoShang.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: none to the logic (no SayTask menu; MsgBox yes/no already has an exit), copied to npc_fix so the spawned NPC can be bound by name.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ‘”ªı…Ã
--author: yichuan
--date: 2004/5/12

function main(sel)
	if (songxin()== 0)then
		MsgBox(10217,"yes_1","no")
	end
end;

function songxin()
	local task_id = 870
	local map_id = 3

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


function yes_1()
		CloseDialog()
		Sale(7);
end;

function no()
		CloseDialog()
end;