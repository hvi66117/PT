function GetPlayerTaskState()
    return 0, 0
end

function main()
    MsgBox(10600, "renwu1", "no")
end;

function renwu1()
    SetCamp(2)
    SetPos(1397, 3207)
    SetRevPos(64, 223)
    SetFightState(1)
    SetPunish(0)
    CloseDialog()
end;

function no()
    CloseDialog()
end;
