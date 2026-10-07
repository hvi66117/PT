Task_CompassMagic = 1465
Global_NpcBehemoth_ID = 205
Global_NpcBehemoth_Index = 206
Global_CompassState = 207
Task_CompassMagicPwdNum = 1466

function main()
    local task = GetTaskByte(Task_CompassMagic, 1)
    local idx, x, y = GetWorldPos()

    if (task == 2 and HaveNormalItem(6, 1, 518, 0) > 0) then

        if (isinarea(idx, x, y) == 0) then
            Talk(1, "no", "Bèn la bµn v©y l¹i thµnh La Bµn TrËn Ph¸p, ta chØ cã thÓ sö dông trong trËn ph¸p ®ã! H·y mau ®Õn khu trËn ph¸p ®Ó bµy trËn!")
            return
        end

        SetTaskByte(Task_CompassMagic, 1, 3)
        Talk(1, "no", "La Bµn TrËn Ph¸p phøc t¹p qu¸i dÞ, ph¸p lùc kiªn cè, kh«ng thÓ ph¸ gi¶i!")
        local pt = GetPlayerType()
        if (pt == 0) then
            TaskNote(86, 30)
        elseif (pt == 1) then
            TaskNote(87, 30)
        else
            TaskNote(88, 30)
        end ;

        return
    end

    if (task == 6 and HaveNormalItem(6, 1, 518, 0) > 0) then

        local oldnpcidx = GetGlobalValue(Global_NpcBehemoth_Index)
        if (oldnpcidx ~= 0) then
            local oldnpcid = GetGlobalValue(Global_NpcBehemoth_ID)
            if (GetNpcID(oldnpcidx) == oldnpcid) then
                Msg2Player("Cù Thó ®· xuÊt hiÖn, anh hïng h·y mau chãng thu phôc!")
            end
            return
        end

        if (isinarea(idx, x, y) == 0) then
            Talk(1, "no", "Bèn la bµn v©y l¹i thµnh La Bµn TrËn Ph¸p, ta chØ cã thÓ sö dông trong trËn ph¸p ®ã! H·y mau ®Õn khu trËn ph¸p ®Ó bµy trËn!")
            return
        end

        if (checkCompassState() == 0) then
            SetTaskByte(Task_CompassMagic, 1, 5)
            Talk(1, "no", "H­íng la bµn kh«ng ®óng víi mËt m·, ph¶i xoay la bµn theo h­íng mËt m· thÓ hiÖn míi më ®­îc La Bµn TrËn Ph¸p!")
            return
        end

        local pt = GetPlayerType()
        if (pt == 0) then
            TaskNote(86, 35)
        elseif (pt == 1) then
            TaskNote(87, 35)
        else
            TaskNote(88, 35)
        end ;

        local newnpcidx = AddNpc(1046, 55, SubWorldID2Idx(idx), x * 32, y * 32 + 20)
        SetNpcScript(newnpcidx, "\\script\\npcdeath\\ÏÉÄ§\\¾ÞÊÞ.lua")
        local newnpcid = GetNpcID(newnpcidx)
        SetGlobalValue(Global_NpcBehemoth_Index, newnpcidx)
        SetGlobalValue(Global_NpcBehemoth_ID, newnpcid)
        SetNpcTimer(newnpcidx, "\\script\\ontimer\\¾ÞÊÞÉ¾µô×Ô¼º.lua", 300)

        SetNpcTask(newnpcidx, 1, PlayerIndex)
        SetNpcTask(newnpcidx, 2, GetPlayerID())
        local luopan_password = GetTaskWord(Task_CompassMagic, 2)
        SetNpcTask(newnpcidx, 3, luopan_password)

        if (GetTeam() ~= 0) then
            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                if (GetTaskWord(Task_CompassMagic, 2) == luopan_password) then
                    SetTaskByte(Task_CompassMagic, 1, 7)
                    Msg2Player("Cù Thó ®· xuÊt hiÖn, anh hïng h·y mau chãng thu phôc!")
                    TopMessage("TriÖu håi Cù Thó thµnh c«ng.")
                end
            end
            PlayerIndex = oldPlayer
        else
            SetTaskByte(Task_CompassMagic, 1, 7)
            Msg2Player("Cù Thó ®· xuÊt hiÖn, anh hïng h·y mau chãng thu phôc!")
            TopMessage("TriÖu håi Cù Thó thµnh c«ng.")
        end

        setCompassState()

    elseif (task == 7 and HaveNormalItem(6, 1, 518, 0) > 0) then
        local oldnpcidx = GetGlobalValue(Global_NpcBehemoth_Index)

        if (oldnpcidx ~= 0) then
            local oldnpcid = GetGlobalValue(Global_NpcBehemoth_ID)
            if (GetNpcID(oldnpcidx) == oldnpcid) then
                Talk(1, "no", "Gi¶i chó phï: Cù Thó ®· xuÊt hiÖn, anh hïng h·y mau chãng thu phôc!!")
                return
            end
        end

        SetTaskWord(Task_CompassMagic, 2, 0)
        SetTaskByte(Task_CompassMagic, 2, 0)
        SetTaskByte(Task_CompassMagic, 1, 4)
        SetTask(Task_CompassMagicPwdNum, 0)
        Talk(1, "no", "B¹n thu phôc Cù thó kh«ng thµnh c«ng, mËt m· 4 h­íng ®· mÊt hiÖu lùc, h·y ®Õn 4 ph¸p trô nhËn mËt m· ®Ó xoay la bµn më l¹i trËn ph¸p!")
        local pt = GetPlayerType()
        if (pt == 0) then
            TaskNote(86, 37)
        elseif (pt == 1) then
            TaskNote(87, 37)
        else
            TaskNote(88, 37)
        end ;
        return

    elseif (task == 5 and HaveNormalItem(6, 1, 518, 0) > 0) then

        Talk(1, "no", "H­íng la bµn kh«ng ®óng víi mËt m·, ph¶i xoay la bµn theo h­íng mËt m· thÓ hiÖn míi më ®­îc La Bµn TrËn Ph¸p!")
        local nPassword = GetTaskWord(Task_CompassMagic, 2)
        local nNorth = math.floor(nPassword / 1000)
        local nEast = math.floor(math.mod(nPassword / 100, 10))
        local nSouth = math.floor(math.mod(nPassword / 10, 10))
        local nWest = math.floor(math.mod(nPassword, 10))
        local pt = GetPlayerType()
        if (pt == 0) then
            TaskNote(86, 33, GetPwdString(nNorth), GetPwdString(nEast), GetPwdString(nSouth), GetPwdString(nWest))
        elseif (pt == 1) then
            TaskNote(87, 33, GetPwdString(nNorth), GetPwdString(nEast), GetPwdString(nSouth), GetPwdString(nWest))
        else
            TaskNote(88, 33, GetPwdString(nNorth), GetPwdString(nEast), GetPwdString(nSouth), GetPwdString(nWest))
        end ;

    end
end

function GetPwdString(nPos)
    if (nPos == 0) then
        return "ChÝnh B¾c"
    elseif (nPos == 1) then
        return "§«ng B¾c"
    elseif (nPos == 2) then
        return "ChÝnh §«ng"
    elseif (nPos == 3) then
        return "§«ng Nam"
    elseif (nPos == 4) then
        return "ChÝnh Nam"
    elseif (nPos == 5) then
        return "T©y Nam"
    elseif (nPos == 6) then
        return "ChÝnh T©y"
    elseif (nPos == 7) then
        return "T©y B¾c"
    end
end

function isinarea(mapId, x, y)
    item = {
        [75] = { { 1804, 3514 }, { 1925, 3469 }, { 1930, 3362 }, { 1827, 3380 } },
    }
    local temp = {}
    local k, x1, key = 0, 0, 0

    temp = item[mapId]
    for j = 1, 4 do

        k = math.mod(j + 1, table.getn(temp) + 1)
        if (k == 0) then
            k = 1
        end
        if (temp[j][2] ~= temp[k][2]) then
            if (y >= math.min(temp[j][2], temp[k][2])) then
                if (y < math.max(temp[j][2], temp[k][2])) then


                    if (temp[k][2] - temp[j][2] == 0) then
                        return 0
                    end

                    x1 = (y - temp[j][2]) * (temp[k][1] - temp[j][1]) / (temp[k][2] - temp[j][2]) + temp[j][1]

                    if (x1 > x) then
                        key = key + 1
                    end
                end
            end
        end
    end

    if (math.mod(key, 2) == 1) then
        return 1
    end

    return 0
end

function checkCompassState()
    local nCompassIdx = GetGlobalValue(Global_CompassState)
    local nPassword = 0

    local nState1 = GetNpcTask(nCompassIdx, 2)
    local nState2 = GetNpcTask(GetNpcTask(nCompassIdx, 3), 2)
    local nState3 = GetNpcTask(GetNpcTask(nCompassIdx, 4), 2)
    local nState4 = GetNpcTask(GetNpcTask(nCompassIdx, 5), 2)

    nPassword = nState1 * 1000 + nState2 * 100 + nState3 * 10 + nState4

    if (nPassword == GetTaskWord(Task_CompassMagic, 2)) then
        return 1
    end

    return 0
end

function setCompassState()
    local nCompassIdx = GetGlobalValue(Global_CompassState)

    for i = 3, 5 do
        local nCompassNpcIdx = GetNpcTask(nCompassIdx, i)
        SetNpcTask(nCompassNpcIdx, 2, 0)
        NpcPolyMorph(nCompassNpcIdx, 1038)
    end
end

function no()
    CloseDialog()
end

