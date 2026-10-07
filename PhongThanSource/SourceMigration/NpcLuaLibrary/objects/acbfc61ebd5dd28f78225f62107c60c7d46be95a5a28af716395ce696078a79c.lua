function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(350) == 1) then
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
    SetTask(350, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(350)
    if (count < 3) then
        SetGlobalValue(350, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(350, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1750, y = 3258 },
            { x = 1590, y = 3222 },
            { x = 1608, y = 3105 },
            { x = 1672, y = 3049 },
            { x = 1763, y = 3115 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-玉虚宫.lua")
        SetGlobalValue(15, pos[sel].x)
        SetGlobalValue(16, pos[sel].y)
    end ;

    CloseDialog()
end;
















