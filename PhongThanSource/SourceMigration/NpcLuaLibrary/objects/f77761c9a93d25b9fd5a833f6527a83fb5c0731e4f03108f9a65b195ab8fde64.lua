--description: 任务-崇城野外
--author: yangfeng
--date: 2005/6/14

--AS GaoJingwei 2009/08/02 
--取得npc的状态
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (GetTask(359) == 1) then
        SetTask(142, GetNpcID(DialogNpcIdx)) --保存玩家对话的npcId
        MsgBox(11205, "renwu")
    else
        MsgBox(11206, "no")
    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    SetTask(359, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(359)
    if (count < 3) then
        SetGlobalValue(359, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(359, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1560, y = 3234 },
            { x = 1785, y = 3194 },
            { x = 1838, y = 2965 },
            { x = 1653, y = 2785 },
            { x = 1565, y = 2970 }
        }
        local sel = random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-崇城野外.lua")
        SetGlobalValue(19, pos[sel].x)
        SetGlobalValue(20, pos[sel].y)
    end ;
    --	ranaddition()
    CloseDialog()
end;
--
--function ranaddition()
--		local i=random(1,20)
--		if(i==1)then
--			AddNormalItem(6,1,22,0,0,0)		--豪
--			AddGlobalCountNews("<color=green>"..GetName().."<color>在完成了一轮花卉任务后意外获得了<color=yellow>玫瑰花<color>，真是受到了花神的庇佑啊！","no")
--			Msg2Player("恭喜你获得了玫瑰花！")
--			TopMessage("恭喜你获得了<color=green>玫瑰花")
--		elseif(i==10)then
--			AddEventItem(39)		--琱れ
--			
--			Msg2Player("恭喜你获得了柳木！")
--			TopMessage("恭喜你获得了<color=green>柳木")
--		end
--			CloseDialog()
--end
