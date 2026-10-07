-- Phong Than npc_fix 2026-09-29: Tho Dong (weapon shop), map 1003; original script.pak \script\YuXuGong\TongJiang.lua (pinyin of GBK path); changes: egg(): own SayTask menu (was nil global tasks) + exit row. Sale 3.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: Õ≠Ω≥-”Ò–Èπ¨
--author: yujin
--date: 2005/3/21

function main(sel)
	if(songxin()==0)then
		local tasks = 
		{
			{"ßÀp tr¯ng","zadan";show=0}
		}
		if (HaveNormalItem(3,70,0,0)>=10)and(GetCash()>=1000)then
			tasks[1].show=1
			Talk(2,"egg",11151,11152)
		elseif (HaveNormalItem(3,71,0,0)>=10)and(GetCash()>=2000)then
			tasks[1].show=1
			Talk(2,"egg",11151,11153)
		elseif (HaveNormalItem(3,72,0,0)>=10)and(GetCash()>=10000)then
			tasks[1].show=1
			Talk(2,"egg",11151,11154)
		else
			MsgBox(10275,"yes_1","no")
		end;
	end
end;

function songxin()
	local task_id = 874
	local map_id = 2

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
		Sale(3);
end;

function no()
		CloseDialog()
end;

function egg()
	local tasks =
	{
		{"ßÀp tr¯ng","zadan";show=1},
		{"K’t thÛc ÆËi thoπi","no";show=1}
	}
	SayTask(11424,tasks)
end;

function  zadan()
	if (HaveNormalItem(3,70,0,0)>=10)and(GetCash()>=1000)then
			for a=1,10 do
				DelNormalItem(3,70,0,0)
			end;
		Pay(1000)
		local   k=random(1,10)
			if(k==1)then
				AddNormalItem(6,1,89,1,0,0)
			elseif(k==2)then
				AddNormalItem(6,1,95,1,0,0)
			elseif(k==3)then
				AddNormalItem(6,1,51,1,0,0)
			elseif(k==4)then
				AddNormalItem(6,1,93,1,0,0)
			elseif(k==5)then
				AddNormalItem(6,1,80,1,0,0)
			elseif(k==6)then
				AddNormalItem(6,1,82,1,0,0)
			elseif(k==7)then
				AddNormalItem(6,1,79,1,0,0)
			elseif(k==8)then
				AddNormalItem(6,1,65,1,0,0)
			elseif(k==9)then
				AddNormalItem(6,1,52,1,0,0)
			elseif(k==10)then
				AddNormalItem(6,1,70,1,0,0)
			end;
		Msg2Player("NhÀn Æ≠Óc Vi‘n CÊ phÔ s¨ c p")
	elseif (HaveNormalItem(3,71,0,0)>=10)and(GetCash()>=2000)then
			for a=1,10 do
				DelNormalItem(3,71,0,0)
			end;
		Pay(2000)
		local   j=random(1,5)
			if(j==1)then
				AddNormalItem(6,1,73,1,0,0)
			elseif(j==2)then
				AddNormalItem(6,1,53,1,0,0)
			elseif(j==3)then
				AddNormalItem(6,1,75,1,0,0)
			elseif(j==4)then
				AddNormalItem(6,1,63,1,0,0)
			elseif(j==5)then
				AddNormalItem(6,1,66,1,0,0)
			end;
		Msg2Player("NhÀn Æ≠Óc Vi‘n CÊ phÔ trung c p")
	elseif (HaveNormalItem(3,72,0,0)>=10)and(GetCash()>=10000)then
			for a=1,10 do
				DelNormalItem(3,72,0,0)
			end;
		Pay(10000)
		local   i=random(1,5)
			if(i==1)then
				AddNormalItem(6,1,46,1,0,0)
			elseif(i==2)then
				AddNormalItem(6,1,62,1,0,0)
			elseif(i==3)then
				AddNormalItem(6,1,64,1,0,0)
			elseif(i==4)then
				AddNormalItem(6,1,50,1,0,0)
			elseif(i==5)then
				AddNormalItem(6,1,98,1,0,0)
			end;
		Msg2Player("NhÀn Æ≠Óc Vi‘n CÊ phÔ cao c p")
	end;
	CloseDialog()
end;
