function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(352) == 1) then
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
    SetTask(352, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(352)
    if (count < 3) then
        SetGlobalValue(352, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(352, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1647, y = 3162 },
            { x = 1707, y = 3232 },
            { x = 1554, y = 3339 },
            { x = 1440, y = 3216 },
            { x = 1559, y = 3216 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-蚩尤墓.lua")
        SetGlobalValue(17, pos[sel].x)
        SetGlobalValue(18, pos[sel].y)
    end ;

    CloseDialog()
end;















