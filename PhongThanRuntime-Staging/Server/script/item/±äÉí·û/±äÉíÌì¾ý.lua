instence_Task = 1606

instence_Item_Task = 1690

function main()
    local y, m, d = GetYMD()
    local h, f, s = GetHMS()
    if ((y - 2000) ~= GetTaskByte(instence_Task, 3)) then
        UseItem()
    elseif (m ~= GetTaskByte(instence_Task, 4)) then
        if (((3600 * 24) + (3600 * h) + (60 * f) + s) - ((GetTaskByte(instence_Item_Task, 2) * 3600) + (GetTaskByte(instence_Item_Task, 3) * 60) + (GetTaskByte(instence_Item_Task, 4))) >= 60 * 60) then
            UseItem()
        else
            Msg2Player("VËt phÈm ®ang trong thêi gian chê.")
        end
    elseif (d ~= GetTaskByte(instence_Item_Task, 1)) then
        if (((3600 * 24) + (3600 * h) + (60 * f) + s) - ((GetTaskByte(instence_Item_Task, 2) * 3600) + (GetTaskByte(instence_Item_Task, 3) * 60) + (GetTaskByte(instence_Item_Task, 4))) >= 60 * 60) then
            UseItem()
        else
            Msg2Player("VËt phÈm ®ang trong thêi gian chê.")
        end
    elseif (((3600 * h) + (60 * f) + s) - ((GetTaskByte(instence_Item_Task, 2) * 3600) + (GetTaskByte(instence_Item_Task, 3) * 60) + (GetTaskByte(instence_Item_Task, 4))) >= 60 * 60) then
        UseItem()
    else
        Msg2Player("VËt phÈm ®ang trong thêi gian chê.")
    end
end

function UseItem()
    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) or (GetMorphType() == 29) or (GetMorphType() == 420) or (GetMorphType() == 419) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
        else
            local ran = math.random(1, 3)
            local y, m, d = GetYMD()
            local h, f, s = GetHMS()
            SetTaskByte(instence_Task, 3, (y - 2000))
            SetTaskByte(instence_Task, 4, m)
            SetTaskByte(instence_Item_Task, 1, d)
            SetTaskByte(instence_Item_Task, 2, h)
            SetTaskByte(instence_Item_Task, 3, f)
            SetTaskByte(instence_Item_Task, 4, s)
            if (ran == 1) then
                PolyMorph(1328, 1, 0, -1, 600)
                CostIBItem(FindAValidIBItem(8, 1096, 2, 0))
            elseif (ran == 2) then
                PolyMorph(1327, 1, 0, -1, 600)
                CostIBItem(FindAValidIBItem(8, 1096, 2, 0))
            elseif (ran == 3) then
                PolyMorph(1321, 1, 0, -1, 600)
                CostIBItem(FindAValidIBItem(8, 1096, 2, 0))
            end
        end ;

        CloseDialog()
    end
end;

function no()
    CloseDialog()
end;
