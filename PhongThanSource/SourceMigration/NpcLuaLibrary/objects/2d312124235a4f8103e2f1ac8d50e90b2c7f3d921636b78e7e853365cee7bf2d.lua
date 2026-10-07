function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(355) == 1) then
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
    SetTask(355, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(355)
    if (count < 3) then
        SetGlobalValue(355, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(355, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1464, y = 3177 },
            { x = 1635, y = 3221 },
            { x = 1584, y = 3019 },
            { x = 1566, y = 2967 },
            { x = 1721, y = 3001 }
        }
        local sel = math.random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-瑶池.lua")
        SetGlobalValue(35, pos[sel].x)
        SetGlobalValue(36, pos[sel].y)
    end ;

    CloseDialog()
end;















