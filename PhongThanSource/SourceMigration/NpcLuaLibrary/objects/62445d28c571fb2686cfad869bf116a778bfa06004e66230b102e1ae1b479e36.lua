function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(364) == 1) then
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
    SetTask(364, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(364)
    if (count < 3) then
        SetGlobalValue(364, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(364, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1552, y = 3310 },
            { x = 1410, y = 2808 },
            { x = 1866, y = 2791 },
            { x = 1719, y = 3190 },
            { x = 1610, y = 2913 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-陈塘关.lua")
        SetGlobalValue(39, pos[sel].x)
        SetGlobalValue(40, pos[sel].y)
    end ;

    CloseDialog()
end;
















