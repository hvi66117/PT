function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(356) == 1) then
        SetTask(142, GetNpcID(DialogNpcIdx))
        MsgBox(11205, "renwu")
    else
        MsgBox(11206, "no")
    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    SetTask(356, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(356)
    if (count < 3) then
        SetGlobalValue(356, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(356, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1673, y = 3080 },
            { x = 1670, y = 3306 },
            { x = 1476, y = 3072 },
            { x = 1491, y = 3310 },
            { x = 1644, y = 3197 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-封神台.lua")
        SetGlobalValue(11, pos[sel].x)
        SetGlobalValue(12, pos[sel].y)
    end ;

    CloseDialog()
end;















