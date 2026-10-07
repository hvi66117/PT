--description: ËãÃüÏÈÉú-×°±¸Á¶»¯ÈÎÎñ
--author: chensong
--date: 2004/7/12

function main(sel)
			tasks = 
			{
				{"Yªn Phóc","renwu1";show=0},
				{"gäi Thó BiÕn Th©n","bs";show=0}
			}
			UTask_world_1 = GetTask(91)
			UTask_cg_0 = GetTask(40);

			if(UTask_world_1==3)and(HaveNormalItem(6,1,12,0)>=1)then
				tasks[1].show=1;
			end;
			if(UTask_world_1 ==1)then
				tasks[1].show=1;
			end;
			if(GetPlayerType()==2)then
				tasks[2].show=1;
			end;			
			SayTask(10097,tasks)
end;


function   renwu1()
	UTask_world_1 = GetTask(91)
	if(UTask_world_1==3)and(HaveNormalItem(6,1,12,0)>=1)then
		Talk(5,"no",10098,10099,10100,10101,10102)
		SetTask(91,4)
		DecCredit(1)
		Msg2Player("BÞ ThÇy t­íng sè ®uæi ®i, ®iÓm danh väng gi¶m xuèng.")
		TaskNote(25,3)
	end;
	if(UTask_world_1 ==1)then
		Talk(3,"no",10103,10104,10105)
		SetTask(91,2)
		Msg2Player("Th× ra Tèng DÞ nh©n ®ang ®­îc vËn may nµy, nãi cho «ng ta biÕt? Hay lµ......")
		TaskNote(25,1)
	end;
end;

function no()
		CloseDialog()
end;

function  bs()
		Say(10106,3,"Hoµng Kim Cù Nh©n/m1","ThiÕt Thè/m2","Anh Vò/m3")
end;

function  m1()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,359)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;

function  m2()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,408)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;

function  m3()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,409)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;
