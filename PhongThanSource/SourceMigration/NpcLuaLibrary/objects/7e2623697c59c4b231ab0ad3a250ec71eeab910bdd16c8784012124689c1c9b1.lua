Task_rw = 1619
Task_qz = 24
gTaskGlobalRand = 269

gTotemInfo = {
    [1] = { name = "X¸c vËt tæ-Kim", x = 215, y = 212, res = "Th­íc Kim Sa" },
    [2] = { name = "X¸c vËt tæ-Méc", x = 280, y = 232, res = "UÊt Méc Chi" },
    [3] = { name = "X¸c vËt tæ-Háa", x = 258, y = 249, res = "XÝch Háa Th¹ch" },
    [4] = { name = "X¸c vËt tæ-Thñy", x = 248, y = 210, res = "ThiÖn Thñy Tinh" },
    [5] = { name = "X¸c vËt tæ-Thæ", x = 146, y = 250, res = "Kh«i Thæ Nham" },
}

function OnDeath(npcTGIdx)
    local OwnernpcId = GetNpcTask(npcTGIdx, 1)
    local OwnerId = GetNpcTask(npcTGIdx, 2)

    local KillernpcID = GetPlayerID()
    local KillerId = GetPosterityType()
    local ownerIndex = SearchPlayerById(OwnernpcId)

    if (KillerId ~= OwnerId) then

        local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
        local lastday = GetByte(GetTongTask(24, 2), 4)
        local idx = GetByte(GetGlobalValue(gTaskGlobalRand), 2)
        if (today ~= lastday) then
            SetTongTask(Task_qz, SetByte(GetTongTask(Task_qz, 2), 3, 2), 2)
            SetTongTask(Task_qz, SetByte(GetTongTask(Task_qz, 2), 4, today), 2)

            AddTongRes((idx + 1), 2, 2)
            Msg2Player("B¹n b¾t ®­îc mËt th¸m cña ng­êi kh¸c, nhËn thªm 2 ®iÓm Tµi nguyªn thÞ téc <c=g>" .. gTotemInfo[idx].res .. "<c>")
        else
            if (GetByte(GetTongTask(24, 2), 3) < 100) then
                local num = GetByte(GetTongTask(24, 2), 3)
                SetTongTask(Task_qz, SetByte(GetTongTask(Task_qz, 2), 3, num + 2), 2)
                AddTongRes((idx + 1), 2, 2)
                Msg2Player("B¹n b¾t ®­îc mËt th¸m cña ng­êi kh¸c, nhËn thªm 2 ®iÓm Tµi nguyªn thÞ téc <c=g>" .. gTotemInfo[idx].res .. "<c>")
            elseif (GetByte(GetTongTask(24, 2), 3) >= 100) then
                Msg2Player("B¹n b¾t ®­îc mËt th¸m cña ng­êi kh¸c, nh­ng sè tµi nguyªn mµ thÞ téc cña b¹n nhËn ®­îc ®· ®¹t møc tèi ®a, kh«ng thÓ nhËn thªm.")
            end
        end

        DelNpc(npcindex)
        return
    end

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (ownerIndex == PlayerIndex) then
                Msg2Player("§éi ngò gióp b¹n b¾t mËt th¸m, nhiÖm vô hoµn thµnh.")
                SetTaskByte(Task_rw, 1, 3)
                TaskNote(1505, 2)
                break
            end
        end
        PlayerIndex = oldPlayer
    else

        if (ownerIndex == PlayerIndex) then
            Msg2Player("B¹n b¾t ®­îc mËt th¸m, nhiÖm vô hoµn thµnh")
            SetTaskByte(Task_rw, 1, 3)
            TaskNote(1505, 2)
        else


            local oldPlayer = PlayerIndex
            PlayerIndex = ownerIndex
            PlayerIndex = oldPlayer
            TaskNote(1505, 3)
        end
    end
    DelNpc(npcindex)
end
