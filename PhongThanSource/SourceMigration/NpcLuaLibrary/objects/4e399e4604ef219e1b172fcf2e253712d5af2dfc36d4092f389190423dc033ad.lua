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

function OnDeath(npcindex)
    if (GetTeam() == 0 and GetTaskByte(Task_Variety_Process, 1) == 25) then
        SetTaskByte(Task_Variety_Process, 1, 26)
        Msg2Player("§· diÖt trõ T«n L­¬ng, cã thÓ vÒ phôc mÖnh Hoµng Thiªn Hãa.")
        TaskNote(1047, 7)
    elseif (GetTeam() ~= 0) then
        local oldPlayerIndex = PlayerIndex
        local memberNum = GetTeamSize()
        for i = 1, memberNum do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Variety_Process, 1) == 25) then
                SetTaskByte(Task_Variety_Process, 1, 26)
                Msg2Player("§· diÖt trõ T«n L­¬ng, cã thÓ vÒ phôc mÖnh Hoµng Thiªn Hãa.")
                TaskNote(1047, 7)
            end
        end
        PlayerIndex = oldPlayerIndex
    end
end;

function no()
    CloseDialog()
end;
