--description: 风林-主线任务
--author: yichuan
--date:2004/5/13

--AS GaoJingwei 2009/08/02 
--取得npc的状态
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    MsgBox(10353, "yes", "no")
end;

function yes()
    CloseDialog()
    NewWorld(15, 1539, 3399)--传送出山谷
end;

function no()
    CloseDialog()
end;