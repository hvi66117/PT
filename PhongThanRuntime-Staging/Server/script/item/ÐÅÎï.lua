Task_Variety_Process = 1389

Task_Time_Stemp = 1390
Task_NpcID = 1391
puteGhost = 956
bigHeadFish = 952
foldFish = 952
greatTongueFish = 952

Coordinate = {
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045

function main()
    if (GetTaskByte(Task_Variety_Process, 1) == 24) then
        local linkPos = "<HyperLinkWorldPos=\"TuyÖt Long LÜnh[19,201,183]\">"
        ClearItem(6, 1, 490, 0)
        SetTaskByte(Task_Variety_Process, 1, 25)
        Talk(1, "no", "<c=r>T«n L­¬ng<c> chñ nh©n, tiÓu nh©n ®· liªn l¹c Chiªu ThÇn gióp ta tÊn c«ng Tam S¬n. Chóng ta tËp kÕt binh m·, chê hiÖu lÖnh cña ®¹i nh©n!")
        Msg2Player("KÎ Chñ m­u lµ T«n L­¬ng, h¾n ë" .. linkPos)
        TaskNote(1047, 6)
    end
end

function no()
    CloseDialog()
end
