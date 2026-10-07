Task_DuJie_Value = 1326

Global_Lamp_LightCount = 167

function OnDeath(npcindex)
    local oldplayerid = GetNpcTask(npcindex, 1)
    local playId = GetPlayerID()
    if (oldplayerid == playId) then
        setnextnpc(npcindex, playId, PlayerIndex)
    else
        local membercount = GetTeamSize()
        local key = 0
        local oldPlayer = PlayerIndex

        if (membercount > 1) then

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                playId = GetPlayerID()
                if (oldplayerid == playId) then
                    key = 1
                    if (getLuck(key, 1) == 1) then
                        setnextnpc(npcindex, oldplayerid, PlayerIndex)
                    end
                    break
                end
            end
        end

        if (key == 0) then
            PlayerIndex = SearchPlayerById(oldplayerid)
            if (PlayerIndex > 0) then
                key = 2
                if (getLuck(key, 1) == 1) then
                    setnextnpc(npcindex, oldplayerid, PlayerIndex)
                end
            end
        end
        PlayerIndex = oldPlayer
    end
    DelNpc(npcindex)
end

function setnextnpc(npcidx, pID, pIdx)
    if (pIdx > 0) then
        local oldplayer = PlayerIndex
        PlayerIndex = pIdx
        if (HaveIBBuff(524) == 0) then
            Msg2Player("Thêi gian Thiªn KiÕp ®· qua, kh«ng thÓ hoµn thµnh ®é kiÕp!")
            return 0
        end
        SetTaskByte(Task_DuJie_Value, 1, 2)
        SetTaskByte(Task_DuJie_Value, 3, 0)

        local rand = math.random(1, 100)
        if (rand <= 90) then
            ThrowItem(npcidx, pIdx, 8, 503, 2, 1, 0, 0)
            Msg2Player("Rít DÞch Kinh §¬n")
            TopMessage("Rít DÞch Kinh §¬n")
        else
            ThrowItem(npcidx, pIdx, 8, 504, 2, 1, 0, 0)
            Msg2Player("Rít DÞch Kinh Lé")
            TopMessage("Rít DÞch Kinh Lé")
        end
        TaskNote(1027, 4)
        PlayerIndex = oldplayer
    end
end

function getLuck(n, leftkill)
    local r = math.random(1, 100)
    local item = {
        [1] = { 5, 10, 10, 10, 10, 10, 10 },
        [2] = { 6, 12, 25, 40, 40, 50, 50 },
    }
    if (r > item[n][leftkill]) then
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end;
