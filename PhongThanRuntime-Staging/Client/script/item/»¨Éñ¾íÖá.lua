function main()
    for i = 350, 364 do
        if (GetTask(i) == 1) then
            MsgBox(10675 + i, "no")
            return
        end
    end
    MsgBox(13293, "no")
end;

function no()
    CloseDialog()
end;
