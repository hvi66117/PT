Task_hetu = 1387

Hetu_playerID = 1388
Global_longmashui = 185
Global_longmahuo = 186
Global_longmamu = 187
Global_longmajin = 188

function OnDeath(npcidx)

    local tempID = GetNpcTemplateID(npcidx)

    if (tempID == 944) then
        SetGlobalValue(Global_longmashui, 0)
    elseif (tempID == 945) then
        SetGlobalValue(Global_longmahuo, 0)
    elseif (tempID == 943) then
        SetGlobalValue(Global_longmamu, 0)
    elseif (tempID == 942) then
        SetGlobalValue(Global_longmajin, 0)
    end

    if (GetNpcTask(npcidx, 1) ~= GetPlayerID()) then

        if (GetTaskByte(Task_hetu, 3) == 1) then
            DelNpc(npcidx)
            return
        end

        local bindPlayerID = GetNpcTask(npcidx, 1)
        local playerIdx = SearchPlayerById(bindPlayerID)
        if (playerIdx > 0) then
            local playerIndexCache = PlayerIndex
            PlayerIndex = playerIdx

            if (tempID == 944) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (thñy), cã thÓ ®Õn Linh Th¹ch (thñy) triÖu gäi l¹i.")
            elseif (tempID == 945) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (háa), cã thÓ ®Õn Linh Th¹ch (háa) triÖu gäi l¹i.")
            elseif (tempID == 942) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (kim), cã thÓ ®Õn Linh Th¹ch (kim) triÖu gäi l¹i.")
            elseif (tempID == 943) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (méc), cã thÓ ®Õn Linh Th¹ch (méc) triÖu gäi l¹i.")
            end

            if (GetTeamSize() == 2 and checkRelation() == 1) then
                local oldPlayer = PlayerIndex
                for i = 1, GetTeamSize() do
                    PlayerIndex = GetTeamMember(i)
                    SetTaskByte(Task_hetu, 3, 1)
                    TopMessage("NhiÖm vô Hµn Phôc Long M· thÊt b¹i")
                end
                PlayerIndex = oldPlayer
            else
                SetTaskByte(Task_hetu, 3, 1)
                TopMessage("VÉn ch­a Hµn Phuc Long M·")
            end
            PlayerIndex = playerIndexCache
        end
        DelNpc(npcidx)
        return
    end

    if (GetTeamSize() ~= 2 or checkRelation() ~= 1) then
        Talk(1, "no", "ChØ cã 1 trong 2 ng­êi cïng nhËn nhiÖm vô cã thÓ hoµn thµnh.")
        SetTaskByte(Task_hetu, 3, 1)
        DelNpc(npcidx)
        return
    end

    if (HaveIBBuff(644) > 0) then
        if (GetNpcTask(npcidx, 1) == GetPlayerID()) then

            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                RemoveIBBuff(644)

                if (GetTaskByte(Task_hetu, 1) == 1) then
                    SetTaskByte(Task_hetu, 1, 2)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>3<c>")
                        Msg2Player("§· thu phôc Long M· 1 n¬i, ch÷ sè kÕ tiÕp lµ 3, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 2, "3")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>4<c>")
                        Msg2Player("§· thu phôc Long M· 2 n¬i, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 2, "4")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 2) then
                    SetTaskByte(Task_hetu, 1, 3)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>7<c>")
                        Msg2Player("§· thu phôc Long M· 3 n¬i, ch÷ sè kÕ tiÕp lµ 7, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 4, "7")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>6<c>")
                        Msg2Player("§· thu phôc Long M· 4 n¬i, ch÷ sè kÕ tiÕp lµ 6, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 4, "6")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 3) then
                    SetTaskByte(Task_hetu, 1, 4)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>9<c>")
                        Msg2Player("§· thu phôc Long M· 7 n¬i, ch÷ sè kÕ tiÕp lµ 9, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 6, "9")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>8<c>")
                        Msg2Player("§· thu phôc Long M· 6 n¬i, ch÷ sè kÕ tiÕp lµ 8, c¨n cø theo chØ thÞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 6, "8")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 4) then
                    SetTaskByte(Task_hetu, 1, 5)
                    TopMessage("Hoµn thµnh <c=g>Hµ §å HuyÒn C¶nh<c>")
                    Msg2Player("NhiÖm vô ®· hoµn thµnh, ®Õn<HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73, 227, 216]\"> tim ng­êi huynh ®Ö cña ng­êi h¸i thuèc.")
                    TaskNote(1043, 2)
                end

            end
            PlayerIndex = oldPlayer
        end
    else
        if (GetTaskByte(Task_hetu, 3) == 0) then

            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                AddIBBuff(644)
                SetTaskByte(Task_hetu, 3, 1)
                TopMessage("Thu phôc 1 con Long M· kh¸c")
            end
            PlayerIndex = oldPlayer
        else


            SetTaskByte(Task_hetu, 3, 0)
        end
    end

    DelNpc(npcidx)
end;

function checkRelation()
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID()
    PlayerIndex = oldPlayer
    if (GetTask(Hetu_playerID) == playerID_temp) then
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end;
