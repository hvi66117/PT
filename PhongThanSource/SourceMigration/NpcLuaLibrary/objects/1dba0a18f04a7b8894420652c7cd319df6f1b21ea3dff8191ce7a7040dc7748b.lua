function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(362) == 1) then
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
    SetTask(362, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(362)
    if (count < 3) then
        SetGlobalValue(362, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(362, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1715, y = 3668 },
            { x = 1553, y = 3702 },
            { x = 1283, y = 3661 },
            { x = 1267, y = 3097 },
            { x = 1713, y = 3172 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-潼关.lua")
        SetGlobalValue(25, pos[sel].x)
        SetGlobalValue(26, pos[sel].y)
    end ;

    CloseDialog()
end;















