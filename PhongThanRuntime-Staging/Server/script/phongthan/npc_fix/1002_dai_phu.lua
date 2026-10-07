-- Phong Than npc_fix 2026-09-29: Dai Phu (medicine shop), map 1002; original script.pak \script\ChongChengDaYing\YiSheng.lua (pinyin of GBK path); changes: exit row on SayTask. Sale 11.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: Ò½Éú
--author: yichuan
--date: 2004/5/12

function main(sel)
	if (songxin()==0)then
		local tasks = 
		{
			{"TrÞ th­¬ng","yes_1";show=1},
			{"D­îc phÈm","yes_2";show=1},
			{"KÕt thóc ®èi tho¹i","no";show=1}
		}
		if (GetPlayerType() == 0) then
				SayTask(10186,tasks)
		else
				MsgBox(10282,"yes_2","no")
		end;
	end
end;

function songxin()
	local task_id = 868
	local map_id = 1

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
	 		Talk(1,"no","Ng­¬i vÊt v¶ qu¸!")
			SetTask(task_id, SetByte(task_val,3,SetBit(finish, setbit, 1)))
	 		return 1
	 	end
	end
	return 0
end

function yes_1()
	local  life=GetLife(0)
	local  mana=GetMana(0)
	local  lifemax=GetLife(1)
	local  manamax=GetMana(1)
	if (GetLevel()>=10)then
			if(life~=lifemax)or(mana~=manamax)then
					local  k=floor((1-(life+mana)/(lifemax+manamax))*GetLevel()*10)
					MsgBox("VÕt th­¬ng kh«ng ®¸ng ng¹i, ta chØ lÊy "..k.." l­îng. TiÕn hµnh chø?","yes_4","no")
			else
					Talk(1,"no",10188)
			end;
	else
		Talk(1,"yes_3",10189)
	end;
end;

function yes_2()
		CloseDialog()
		Sale(11);  			--µ¯³ö½»Ò×¿ò
end;

function yes_3()
	RestoreLife()
	RestoreMana()
	Msg2Player("Sinh lùc vµ néi lùc cña b¹n ®· hoµn toµn håi phôc.")
	CloseDialog()
end;

function yes_4()
	local  life=GetLife(0)
	local  mana=GetMana(0)
	local  lifemax=GetLife(1)
	local  manamax=GetMana(1)
	local  k=floor((1-(life+mana)/(lifemax+manamax))*GetLevel()*10)
	if(GetCash()>=k)then
		RestoreLife()
		RestoreMana()
		Pay(k)
		Msg2Player("Sinh lùc vµ néi lùc cña b¹n ®· hoµn toµn håi phôc.")
		CloseDialog()
	else
		Talk(1,"no",10190)
	end;
end;

function no()
		CloseDialog()
end;
