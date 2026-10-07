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
    if (HaveNormalItem(6, 1, 844, 0) <= 0) then
        return
    end

    local Y, M1, D = GetYMD()
    local H, M, S = GetHMS()
    if (Y == 2010 and (D > 16 or (D == 16 and H >= 22))) then
        Talk(1, "no", "Thêi gian diÔn ra ho¹t ®éng ®· kÕt thóc, TÝch Duyªn Liªn biÕn mÊt.")
        DelNormalItem(6, 1, 844, 0)
        return
    end

    local nProcess = GetTaskByte(Task_Cenva, 1)
    if (GetSex() == 0 and nProcess == 1) then
        Talk(1, "no", "§­a cho mét ng­êi ch¬i n÷ mµ b¹n thÝch, chÝnh tay ng­êi ®ã ®eo TÝch Duyªn Liªn cho b¹n sÏ c¶m nhËn ®­îc tÊm lßng cña c« Êy.")
        return
    elseif (GetSex() == 1) then
        local player = GetPlayerTarget()
        if (player > 0) then
            MsgBox("Cã muèn ®eo TÝch Duyªn Liªn cho ng­êi Êy kh«ng?", "Yes_Cenva", "no")
        else
            Talk(1, "no", "H·y ®eo TÝch Duyªn Liªn nµy cho mét ng­êi ch¬i nam.")
            return
        end
    else
        Talk(1, "no", "TÝch Duyªn Liªn chØ ®Ó cho ng­êi ch¬i n÷ ®eo cho ng­êi ch¬i nam.")
        return
    end
end

function Yes_Cenva()
    no()
    if (HaveNormalItem(6, 1, 844, 0) <= 0) then
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
            if (GetSex() == 1) then
                PlayerIndex = oldplayer
                Msg2Player("TÝch Duyªn Liªn chØ ®eo cho ng­êi ch¬i nam.")
                PlayerIndex = playeridx
                Msg2Player("TÝch Duyªn Liªn chØ ®eo cho nam.")
                PlayerIndex = oldplayer
                return
            end
            SetTaskByte(Task_Cenva, 1, 2)
            thatName = GetName()
            Msg2Player(thisName .. "§eo TÝch Duyªn Liªn cho b¹n.")
            TaskNote(1608, 2)
            PlayerCastSkill(1, 212, 1)
            AddEmoteBalloon(PlayerIndex, 40)
        elseif (GetTaskByte(Task_Cenva, 1) == 3 or GetTaskByte(Task_Cenva, 1) == 2) then
            PlayerIndex = oldplayer
            Msg2Player("Ng¹i qu¸! Ng­êi ch¬i nµy ®· cã TÝch Duyªn Liªn.")
            PlayerIndex = playeridx
            Msg2Player("H«m nay ®· cã ng­êi ®eo TÝch Duyªn Liªn cho b¹n.")
            PlayerIndex = oldplayer
            return
        elseif (GetTaskByte(Task_Cenva, 1) == 0) then
            PlayerIndex = oldplayer
            Msg2Player("Ng­êi ch¬i nµy kh«ng cã nhiÖm vô Duyªn §Þnh Tam Sinh, kh«ng thÓ ®eo TÝch Duyªn Liªn.")
            PlayerIndex = playeridx
            Msg2Player("B¹n kh«ng cã nhiÖm vô Duyªn §Þnh Tam Sinh, kh«ng thÓ ®eo TÝch Duyªn Liªn.")
            PlayerIndex = oldplayer
            return
        end
    end

    PlayerIndex = oldplayer
    Msg2Player("B¹n ®eo cho" .. thatName .. "TÝch Duyªn Liªn.")
    PlayerCastSkill(1, 212, 1)
    AddEmoteBalloon(PlayerIndex, 40)
    DelNormalItem(6, 1, 844, 0)
end

function no()
    CloseDialog()
end
