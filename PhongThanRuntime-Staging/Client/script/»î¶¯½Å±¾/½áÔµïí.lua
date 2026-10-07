Task_SeventhFestival = 1717

Task_BloomLamp = 1718

Task_Cenva = 1719

Task_Answers = 1720
Task_MateID = 1721
Task_QixiState = 1722

Task_QuestOrder = 140

Save_Seventh_Festival = "TheDoubleSeventhFestival"

function GetPlayerTaskState()
    return 0, 0
end

function main()

    if (HaveNormalItem(6, 1, 845, 0) <= 0) then
        return
    end

    local Y, M1, D = GetYMD()
    local H, M, S = GetHMS()
    if (Y == 2010 and (D > 16 or (D == 16 and H >= 22))) then
        Talk(1, "no", "Ho¹t ®éng ®· kÕt thóc, Vßng kÕt duyªn ®· biÕn mÊt!")
        DelNormalItem(6, 1, 845, 0)
        return
    end

    local nProcess = GetTaskByte(Task_Cenva, 1)
    if (GetSex() == 1 and nProcess == 1) then
        Talk(1, "no", "H·y mang nã ®Õn cho mét nam nh©n mµ b¹n t©m ý nhÊt, nhê ng­êi ®ã tù tay ®eo Vßng kÕt duyªn nµy cho b¹n. B¹n sÏ c¶m nhËn ®­îc tÊm ch©n t×nh cña ng­êi Êy!")
        return
    elseif (GetSex() == 0) then
        local player = GetPlayerTarget()
        if (player > 0) then
            MsgBox("§­a Vßng kÕt duyªn nµy cho c« Êy ®eo lªn chø?", "Yes_Cenva", "no")
        else
            Talk(1, "no", "Xin chän mét ng­êi ch¬i n÷ mµ b¹n t©m ý, ®eo Vßng kÕt duyªn nµy cho c« Êy!")
            return
        end
    else
        Talk(1, "no", "Vßng kÕt duyªn chØ cã thÓ do ng­êi nam ®eo cho ng­êi n÷!")
        return
    end
end

function Yes_Cenva()
    no()
    if (HaveNormalItem(6, 1, 845, 0) <= 0) then
        return
    end

    local thisName = GetName()
    local tempidx = GetPlayerTarget()
    local playeridx = NpcIdx2PIdx(tempidx)
    local oldplayer = PlayerIndex
    local thatName = ""

    PlayerIndex = playeridx
    if (PlayerIndex > 0) then
        if (GetTaskByte(Task_Cenva, 1) ~= 3 and GetTaskByte(Task_Cenva, 1) > 0) then
            if (GetSex() == 0) then
                PlayerIndex = oldplayer
                Msg2Player("Vßng kÕt duyªn chØ cã thÓ ®eo cho ng­êi ch¬i n÷!!")
                PlayerIndex = playeridx
                Msg2Player("Vßng kÕt duyªn chØ cã n÷ míi ®eo ®­îc!")
                PlayerIndex = oldplayer
                return
            end

            SetTaskByte(Task_Cenva, 1, 2)
            thatName = GetName()
            Msg2Player(thisName .. " ®· ®eo Vßng kÕt duyªn cho b¹n!")
            TaskNote(1608, 2)
            PlayerCastSkill(1, 212, 1)
            AddEmoteBalloon(PlayerIndex, 40)
            PlayerIndex = oldplayer
        elseif (GetTaskByte(Task_Cenva, 1) == 3 or GetTaskByte(Task_Cenva, 1) == 2) then
            PlayerIndex = oldplayer
            Msg2Player("Ng¹i qu¸! Ng­êi ch¬i nµy ®· cã Vßng kÕt duyªn!")
            PlayerIndex = playeridx
            Msg2Player("H«m nay ®· cã ng­êi ®eo Vßng kÕt duyªn cho b¹n råi!")
            PlayerIndex = oldplayer
            return
        elseif (GetTaskByte(Task_Cenva, 1) == 0) then
            PlayerIndex = oldplayer
            Msg2Player("Ng­êi ch¬i nµy kh«ng cã nhiÖm vô Tam Sinh Duyªn, kh«ng thÓ ®eo Vßng kÕt duyªn.")
            PlayerIndex = playeridx
            Msg2Player("B¹n kh«ng cã nhiÖm vô Tam Sinh Duyªn, kh«ng thÓ ®eo Vßng kÕt duyªn.")
            PlayerIndex = oldplayer
            return
        end
    end

    PlayerIndex = oldplayer
    DelNormalItem(6, 1, 845, 0)
    Msg2Player("B¹n ®eo cho" .. thatName .. "§· ®eo Vßng kÕt duyªn.")
    PlayerCastSkill(1, 212, 1)
    AddEmoteBalloon(PlayerIndex, 40)
end

function no()
    CloseDialog()
end
