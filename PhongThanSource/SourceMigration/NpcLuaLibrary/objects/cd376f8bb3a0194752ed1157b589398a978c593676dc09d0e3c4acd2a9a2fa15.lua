Task_renwu = 1303
Task_NpcIndex = 1312
Task_NpcId = 1313

function OnDeath(c)

    local nOwnPlayerIndex = SearchPlayerById(GetNpcTask(c, 1))
    local nJECamp = GetNpcTask(c, 2)

    if (nOwnPlayerIndex == PlayerIndex) then

        local npcindex = GetTask(Task_NpcIndex)
        local credit = GetJusticEvilCredit()
        local bCorrectCamp = 0

        if (credit > 0) and (nJECamp == 1) then
            bCorrectCamp = 1
        elseif (credit < 0) and (nJECamp == 2) then
            bCorrectCamp = 1
        end

        if (GetTaskByte(Task_renwu, 1) == 4) and (npcindex == c) and (GetNpcID(npcindex) == GetNpcID(c)) and (bCorrectCamp == 1) then

            SetTask(Task_renwu, 5)
            TaskNote(89, 3)
            ScrollMessage("Tiªu diÖt thµnh c«ng Phong thó s¬n hån")

            if (credit > 0) then
                Msg2Player("B¹n ®· tiªu diÖt Phong thó s¬n hån, h·y t×m B¹ch H¹c ®¹o tr­ëng nhËn nhiÖm vô.")

            else
                Msg2Player("B¹n ®· tiªu diÖt Phong thó s¬n hån, h·y t×m Linh Nha KiÕm Tiªn nhËn nhiÖm vô.")

            end

        end

    elseif (nOwnPlayerIndex > 0) then

        local credit = GetJusticEvilCredit()
        local bCorrectAttackCamp = 0

        if (credit > 0) and (nJECamp == 1) then
            bCorrectAttackCamp = 1
        elseif (credit < 0) and (nJECamp == 2) then
            bCorrectAttackCamp = 1
        end

        local strName = GetName()

        local nOldPlayer = PlayerIndex
        PlayerIndex = nOwnPlayerIndex

        local npcindex = GetTask(Task_NpcIndex)
        credit = GetJusticEvilCredit()
        local bCorrectCamp = 0

        if (credit > 0) and (nJECamp == 1) then
            bCorrectCamp = 1
        elseif (credit < 0) and (nJECamp == 2) then
            bCorrectCamp = 1
        end

        if (bCorrectAttackCamp == 1) then

            if (GetTaskByte(Task_renwu, 1) == 4) and (npcindex == c) and (GetNpcID(npcindex) == GetNpcID(c)) and (bCorrectCamp == 1) then

                SetTask(Task_renwu, 5)
                TaskNote(89, 3)
                ScrollMessage("Tiªu diÖt thµnh c«ng Phong thó s¬n hån")

                if (credit > 0) then
                    Msg2Player("B¹n nhê cã Tiªn h÷u <RoleName=\"" .. strName .. "\"> ®· cïng b¹n tiªu diÖt Phong thó s¬n hån, ®Õn B¹ch H¹c ®¹o tr­ëng nhËn nhiÖm vô.")

                else
                    Msg2Player("B¹n nhê cã Tiªn h÷u <RoleName=\"" .. strName .. "\"> ®· cïng b¹n tiªu diÖt Phong thó s¬n hån, ®Õn Linh Nha KiÕm Tiªn nhËn nhiÖm vô.")

                end

            end

        else

            if (GetTaskByte(Task_renwu, 1) == 4) and (npcindex == c) and (GetNpcID(npcindex) == GetNpcID(c)) and (bCorrectCamp == 1) then

                if (credit > 0) then
                    Msg2Player("Ma ph¸i-<RoleName=\"" .. strName .. "\"> ng¨n b¹n tiªu diÖt Phong thó s¬n hån, h·y gäi l¹i.")

                else
                    Msg2Player("Tiªn ph¸i-<RoleName=\"" .. strName .. "\"> ng¨n b¹n tiªu diÖt Phong thó s¬n hån, h·y gäi l¹i.")

                end

            end

        end

        PlayerIndex = nOldPlayer

    end

    DelNpc(c)
end;
