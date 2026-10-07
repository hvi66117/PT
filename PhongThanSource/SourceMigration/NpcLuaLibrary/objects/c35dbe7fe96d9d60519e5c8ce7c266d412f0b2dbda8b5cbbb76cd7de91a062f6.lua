star_dream = 1419

function OnDeath(npcindex)

    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then
            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng, ®Ó xem h¾n muèn nãi g×.")
                ScrollMessage("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng")
                RemoveIBBuff(659)
                SetTaskByte(star_dream, 1, 10)
                refreshNpcTaskState()
                TaskNote(1052, 13)
                PlayerIndex = tempidx
            end
        else
            Msg2Player("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng, ®Ó xem h¾n muèn nãi g×.")
            ScrollMessage("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng")
            RemoveIBBuff(659)
            SetTaskByte(star_dream, 1, 10)
            refreshNpcTaskState()
            TaskNote(1052, 13)
            AddOwnExp(100)
            TopMessage("B¹n nhËn ®­îc <c=g>100<c> kinh nghiÖm")
            Msg2Player("B¹n nhËn ®­îc 100 kinh nghiÖm")
        end
    end
    DelNpc(npcindex)
end;

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 10

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end


