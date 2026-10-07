--description: ×£ÈÚ
--author: yichuan
--date:2004/7/29

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

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