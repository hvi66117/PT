Task_State = 1710

Pos_TaskValue = { 1711, 1712, 1713, }

Fazhen_Item = { 6, 1, 841, 0 }

Ninety_SecondBuff = 1310

Task_MapID = 37

Fazhen_Index = 1714
Fazhen_ID = 1715

Fazhen_TemplateID = 1112

function main()
    local nYear, nMonth, nDay = GetYMD();
    if nYear == 2010 and nMonth == 7 and nDay >= 20 and nDay <= 26 then

        local mapid, _, _ = GetWorldPos()

        if mapid ~= Task_MapID then
            InfoBox("H·y ®Õn §«ng H¶i Thñy Vùc thi triÓn ph¸p trËn!")
            return
        end

        if (IsCaptain() == 1) then
            local nReturnValue, szProblemPlayerName = Check_MateState()
            if nReturnValue == 0 then
                Release_Fazhen(1)
            elseif nReturnValue == 1 then
                Talk(1, "no", "Ng­êi ch¬i nhËn nhiÖm vô cÇn kÕt thµnh ®éi ngò 3 ng­êi míi ®­îc tiÕp tôc nhiÖm vô!")
            elseif nReturnValue == 2 then
                Talk(1, "no", "Ng­êi ch¬i nhËn nhiÖm vô cÇn kÕt thµnh ®éi ngò 3 ng­êi míi ®­îc tiÕp tôc nhiÖm vô!")
            elseif nReturnValue == 3 then
                Talk(1, "no", "B¹n ®· tham gia 1 lÇn nhiÖm vô víi ®éi ngò kh¸c, lÇn nµy kh«ng thÓ lµm ®éi tr­ëng tiÕp tôc nhiÖm vô!")
            elseif nReturnValue == 4 then
                Talk(1, "no", "Trong ®éi ngò cã ng­êi ®· tham gia bµy trËn víi ®éi ngò kh¸c, kh«ng thÓ tiÕp tôc nhiÖm vô víi ®éi nµy!")
            elseif nReturnValue == 5 then
                Talk(1, "no", "H·y x¸c nhËn tÊt c¶ thµnh viªn ®éi ngò ®Òu ë §«ng H¶i Thñy Vùc, nÕu ë khu vùc kh¸c sÏ kh«ng thÓ tiÕp tôc nhiÖm vô!")
            end
        else
            if GetTaskByte(Task_State, 4) == 1 then
                local nTeamState = Check_MateState2()
                if nTeamState == 0 then
                    if PlayerIndex == GetTeamMember(2) then
                        Release_Fazhen(2)
                    else
                        Release_Fazhen(3)
                    end
                elseif nTeamState == 1 or nTeamState == 2 then
                    Talk(1, "no", "Ng­êi ch¬i nhËn nhiÖm vô cÇn kÕt thµnh ®éi ngò 3 ng­êi míi ®­îc tiÕp tôc nhiÖm vô!")
                elseif nTeamState == 3 then
                    Talk(1, "no", "Ng­êi ch¬i nhËn nhiÖm vô ph¶i lËp ®éi ngò 3 ng­êi míi cã thÓ hoµn thµnh nhiÖm vô, sau khi ®éi tr­ëng thi triÓn ph¸p trËn ®Çu tiªn, nÕu ®éi ngò ph¸t sinh thay ®æi, sÏ kh«ng thÓ tiÕp tôc nhiÖm vô!")
                elseif nTeamState == 4 then
                    Talk(1, "no", "Ph¸p trËn cña ®éi viªn tr­íc ®· mÊt h¼n! Kh«ng thÓ tiÕp tôc nhiÖm vô!")
                elseif nTeamState == 5 then
                    Talk(1, "no", "§éi viªn thø 3 kh«ng ë tr¹ng th¸i ®îi lÖnh! H·y kiÓm tra xem b¹n cã gi÷ nguyªn ®éi h×nh lóc ®Çu hay kh«ng!")
                elseif nTeamState == 6 or nTeamState == 7 then
                    Talk(1, "no", "Ph¸p trËn cña ®ång ®éi ®· biÕn mÊt! Kh«ng thÓ tiÕp tôc nhiÖm vô! B¹n cã thÓ hñy nhiÖm vô!")
                end

            else
                Msg2Player("Xin chê chØ thÞ, sau ®ã h·y thi triÓn Phi Hån TrËn!")
            end
        end
    else
        ClearItem(Fazhen_Item[1], Fazhen_Item[2], Fazhen_Item[3], Fazhen_Item[4])
        Msg2Player("Ho¹t ®éng Thanh l­¬ng h¹ quý ®· kÕt thóc, vËt phÈm thu håi!")
    end
end

function Release_Fazhen(i)
    no()
    Call_Fazhen(i)
end

function Call_Fazhen(i)
    local nPlyIndex = PlayerIndex
    local nMapId, nX, nY = GetWorldPos()
    if i > 1 then
        PlayerIndex = GetTeamMember(i - 1)
        local nFrontMap, nFrontX, nFrontY = GetNpcWorldPos(GetTask(Fazhen_Index))
        PlayerIndex = nPlyIndex

        local nDist = math.sqrt(((nFrontX - nX) ^ 2) * 32 * 32 + ((nFrontY - nY) ^ 2) * 32 * 32)

        if nDist > 600 then
            InfoBox("C¸ch ph¸p trËn tr­íc qu¸ xa! H·y ®Õn gÇn h¬n!")
            return
        elseif nDist < 300 then
            InfoBox("C¸ch ph¸p trËn tr­íc qu¸ gÇn! H·y ®i xa h¬n chót n÷a!")
            return
        end
    end

    local nNpcIdx = AddNpc(Fazhen_TemplateID, 1, SubWorld, nX * 32, nY * 32)

    if nNpcIdx > 0 then
        SetTask(Fazhen_Index, nNpcIdx)
        SetTask(Fazhen_ID, GetNpcID(nNpcIdx))
        SetTaskByte(Task_State, 4, 3)

        ClearItem(Fazhen_Item[1], Fazhen_Item[2], Fazhen_Item[3], Fazhen_Item[4])
        SetNpcTimer(nNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 3 * 60)
        SetNpcName(nNpcIdx, "<c=g>Phi Hån ph¸p trËn<c>")

        SetTaskWord(Pos_TaskValue[1], 1, nX)
        SetTaskWord(Pos_TaskValue[1], 2, nY)
        TaskNote(1606, 2)
        Save_PosInfo(i, nX, nY)
    else
        InfoBox("Thi triÓn Phi Hån TrËn thÊt b¹i!")
    end

end

function Save_PosInfo(n, x, y)
    local nOldPlyIdx = PlayerIndex

    if n > 1 then
        local nSeconds = 3 * 60;
        if n == 3 then
            nSeconds = 120;
        end

        for i = 1, n do
            PlayerIndex = GetTeamMember(i)
            DelNpcTimer(GetTask(Fazhen_Index))
            SetNpcTimer(GetTask(Fazhen_Index), "\\script\\ontimer\\É¾µô×Ô¼º.lua", nSeconds)
        end
    end

    local szName = ""
    if n == 1 then
        PlayerIndex = GetTeamMember(2)
        SetTaskByte(Task_State, 4, 1)
        szName = GetName()
        Msg2Player("Ng­¬i h·y thi triÓn ph¸p trËn!")
        TaskNote(1606, 1)

        InfoBox("H·y thi triÓn ph¸p trËn! CÇn gi÷ cù ly nhÊt ®Þnh ®èi víi ph¸p trËn tr­íc!")

        PlayerIndex = GetTeamMember(3)
        SetTaskByte(Task_State, 4, 2)
        Msg2Player("HiÖn t¹i <c=g>" .. szName .. "<c> thi triÓn ph¸p trËn! H·y ®îi mét l¸t!")

    end

    if n == 2 then
        PlayerIndex = GetTeamMember(3)
        SetTaskByte(Task_State, 4, 1)
        Msg2Player("Ng­¬i h·y thi triÓn ph¸p trËn!")
        TaskNote(1606, 1)
        InfoBox("H·y thi triÓn ph¸p trËn! CÇn gi÷ cù ly nhÊt ®Þnh ®èi víi ph¸p trËn tr­íc!")
    end

    if n == 3 then

        local x1, y1, x2, y2, x3, y3 = 0, 0, 0, 0, 0, 0
        PlayerIndex = GetTeamMember(1)
        x1 = GetTaskWord(Pos_TaskValue[1], 1)
        y1 = GetTaskWord(Pos_TaskValue[1], 2)

        PlayerIndex = GetTeamMember(2)
        x2 = GetTaskWord(Pos_TaskValue[1], 1)
        y2 = GetTaskWord(Pos_TaskValue[1], 2)

        PlayerIndex = GetTeamMember(3)
        x3 = GetTaskWord(Pos_TaskValue[1], 1)
        y3 = GetTaskWord(Pos_TaskValue[1], 2)

        for i = 1, 3 do
            PlayerIndex = GetTeamMember(i)
            SetTaskByte(Task_State, 4, 4)
            AddIBBuff(Ninety_SecondBuff, 120)

            SetTaskWord(Pos_TaskValue[1], 1, x1)
            SetTaskWord(Pos_TaskValue[1], 2, y1)

            SetTaskWord(Pos_TaskValue[2], 1, x2)
            SetTaskWord(Pos_TaskValue[2], 2, y2)

            SetTaskWord(Pos_TaskValue[3], 1, x3)
            SetTaskWord(Pos_TaskValue[3], 2, y3)

            InfoBox("Bµy trËn hoµn tÊt! Dïng ph¸p trËn h×nh tam gi¸c hµng phôc §«ng H¶i qu¸i vËt nhËn ®­îc Tþ Thö Ch©u!")
        end

    end

    PlayerIndex = nOldPlyIdx
end

function no()
    CloseDialog()
end

function Check_MateState2()

    if GetTeam() == 0 then
        return 1
    end

    local nTeamSize = GetTeamSize()

    if nTeamSize ~= 3 then
        return 2
    end

    local nReturnValue = 0

    local nPlyIndex = PlayerIndex

    PlayerIndex = GetTeamMember(1)
    if GetTaskByte(Task_State, 4) ~= 3 then
        nReturnValue = 3
    else
        if nPlyIndex == GetTeamMember(2) then
            if GetNpcID(GetTask(Fazhen_Index)) ~= GetTask(Fazhen_ID) and GetTask(Fazhen_Index) > 0 then
                nReturnValue = 4
            else
                PlayerIndex = GetTeamMember(3)
                if GetTaskByte(Task_State, 4) ~= 2 then
                    nReturnValue = 5
                end
            end
        elseif nPlyIndex == GetTeamMember(3) then

            PlayerIndex = GetTeamMember(1)

            if GetNpcID(GetTask(Fazhen_Index)) ~= GetTask(Fazhen_ID) and GetTask(Fazhen_Index) > 0 then
                nReturnValue = 6
            else
                PlayerIndex = GetTeamMember(2)

                if GetNpcID(GetTask(Fazhen_Index)) ~= GetTask(Fazhen_ID) and GetTask(Fazhen_Index) > 0 then
                    nReturnValue = 7
                end
            end
        end
    end

    PlayerIndex = nPlyIndex

    return nReturnValue

end

function Check_MateState()

    if GetTeam() == 0 then
        return 1, 0
    end

    local nTeamSize = GetTeamSize()

    if nTeamSize ~= 3 then
        return 2, 0
    end

    local nPlyMid, nPlyx, nPlyy, nDist = 0, 0, 0

    local nPlyIndex = PlayerIndex

    local nReturnValue = 0

    local szProblemPlayerName = ""

    for i = 1, nTeamSize do

        PlayerIndex = GetTeamMember(i)

        if HaveNormalItem(6, 1, 841, 0) == 0 and HaveNormalItemInQuick(6, 1, 841, 0) == 0 then
            nReturnValue = 3
            szProblemPlayerName = GetName()
        end

        if GetTaskByte(Task_State, 4) ~= 0 then
            nReturnValue = 4
            szProblemPlayerName = GetName()
        end

        nPlyMid, nPlyx, nPlyy = GetWorldPos()

        if nPlyMid ~= Task_MapID then
            nReturnValue = 5
            szProblemPlayerName = GetName()
            break
        end

    end

    PlayerIndex = nPlyIndex

    return nReturnValue, szProblemPlayerName
end
