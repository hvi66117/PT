function GetPlayerTaskState()
    return 0, 0
end

function main()
    MsgBox(10353, "yes", "no")
end;

function yes()
    CloseDialog()
    NewWorld(15, 1539, 3399)
end;

function no()
    CloseDialog()
end;
