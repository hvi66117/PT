--description: 崇军铜匠
--author: yichuan
--date: 2004/5/14

--AS GaoJingwei 2009/08/02 
--取得npc的状态
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main(sel)
    tasks = {
        --		{"新式武器","renwu1";show=0},
        --		{"兼爱非攻","renwu2";show=0},
        --		{"勇士之刃","renwu3";show=0}
    }
    --	UTask_11 = GetTask(21);
    UTask_14 = GetTask(24);
    UTask_15 = GetTask(25);
    --	if (UTask_11 == 7)  then		
    --			tasks[1].show=1;
    --	end;
    --	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
    --			tasks[1].show=1;
    --	end;
    --	if(UTask_11 == 1)  then
    --			tasks[1].show=1;
    --	end;

    --	if(UTask_14 ==1)then		
    --			tasks[1].show=1;
    --	end;

    --	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==2)then
    --			tasks[2].show=1;
    --	end;
    --	SayTask(10276,tasks)
    Talk(1, "no", 10276)
end;

--function   renwu1()
--	UTask_11 = GetTask(21);
--	if (UTask_11 == 7)  then		
--				Talk(1,"no",10277)
--				Msg2Player("武器材料已经更换，去找鲁雄覆命。")
--				TaskNote(8,7)
--				SetTask(21,8)
--	end;
--	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
--				Talk(1,"no",10278)
--				for i=1,10 do 
--						DelNormalItem(3,10,0,0)
--				end;
--				Msg2Player("去找崇侯虎批准更换材料。")
--				TaskNote(8,3)
--				SetTask(21,4)
--	end;
--	if(UTask_11 == 1)  then
--				Talk(1,"no",10279)
--				Msg2Player("向崇应彪询问姜文焕部队的武器的材质。")
--				TaskNote(8,1)
--				SetTask(21,2)	
--	end;
--end;

function renwu2()
    Talk(1, "no", 10280)
    Msg2Player("Ti猽 di謙 Ho祅 C萿 tinh, nh薾 頲 Cu鑓.")
    TaskNote(10, 1)
    SetTask(24, 2)
end;

--function   renwu3()
--
--				Talk(1,"no",10281)
--				DelEventItem(21)
--				DelEventItem(22)
--				DelEventItem(23)
--				AddEventItem(24)
--				Msg2Player("勇士之刃重现江湖！")
--				TaskNote(11,9)
--				SetTask(25,3)
--end;

function no()
    CloseDialog()
end;
