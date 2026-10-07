function GetPlayerTaskState()
    return 0, 0
end

function main()
    MsgBox(10622, "renwu1", "no")
end;

function renwu1()
    SetCamp(3)
    SetPos(1565, 3056)
    SetRevPos(64, 225)
    SetFightState(1)
    SetPunish(0)
    CloseDialog()
end;

function no()
    CloseDialog()
end;
