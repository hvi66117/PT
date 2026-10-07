Task_hengcai = 1214;

function main()
    if (GetLevel() < 27) then
        Talk(1, "no", 14341)
        return 0
    end
    if (GetBit(GetTask(Task_hengcai), 1) == 0) then
        MsgBox(14342, "yesl", "no")
    else
        if (GetBit(GetTask(Task_hengcai), 3) == 0) then
            Talk(1, "no", GetName() .. ": §em nã ®Õn ThÇy bãi ë TriÒu Ca ®i!")
        else
            Talk(1, "no", GetName() .. ":Thø nµy ®· kh«ng thÓ dïng ®­îc n÷a råi!")
            DelNormalItem(6, 1, 358, 1)
        end
    end
end

function yesl()
    SetTaskBit(Task_hengcai, 1, 1)
    TaskNote(75, 0)
    Msg2Player("B¹n ®· nhËn nhiÖm vô ThÇn tµi")
    Talk(1, "no", GetName() .. "§i t×m ThÇy bãi hái thö!")
end

function no()
    CloseDialog()
end 
