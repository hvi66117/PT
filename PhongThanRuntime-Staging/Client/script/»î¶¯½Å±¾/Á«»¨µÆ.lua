Task_SeventhFestival = 1717

Task_BloomLamp = 1718

Task_Cenva = 1719

Task_Answers = 1720
Task_MateID = 1721
Task_QixiState = 1722

Task_QuestOrder = 140

Save_Seventh_Festival = "TheDoubleSeventhFestival"

function no()
    CloseDialog()
end

function main()

    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        Talk(1, "no", "§Ìn hoa sen chØ cã thÓ sö dông ë TriÒu Ca!")
        return
    end

    if (HaveNormalItem(6, 1, 843, 0) <= 0) then
        return
    end

    MsgBox("Th¾p s¸ng 1 §Ìn hoa sen, ­íc mong cho nh÷ng ng­êi yªu sÏ nªn mèi l­¬ng duyªn lu«n thµnh duyªn!", "Yes_Bloom", "no")

end

function Yes_Bloom()
    no()
    if (HaveNormalItem(6, 1, 843, 0) <= 0) then
        return
    end

    local w, x, y = GetWorldPos()
    local npcidx = AddNpc(1830, 1, SubWorld, x * 32, y * 32)
    if (npcidx > 0) then
        SetNpcName(npcidx, GetName() .. "-Liªn hoa ®¨ng")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 10 * 60)
        DelNormalItem(6, 1, 843, 0)
        TaskNote(1607, -1)
    else
        Talk(1, "no", "Liªn hoa ®¨ng ch­a s¸ng, h·y th¾p l¹i.")
    end
end
