function main()
    DelNormalItem(6, 1, 762, 0)

    local lastday = LoadIniInteger("Save_fsling_Open_Check", 1)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (lastday ~= today) then
        SaveIniInteger("Save_fsling_Open_Check", 1, today)
        SaveIniInteger("Save_fsling_Open_Check", 2, 0)
    end

    local num = LoadIniInteger("Save_fsling_Open_Check", 2)
    local kind = GetTaskByte(Task_FSling, 1)

    local consumePoints = GetCostExtPointStat()
    local possibility = math.random(1, 1000)
    local bindcoin = 0
    if (consumePoints >= 300000) then
        if (possibility <= 800) then
            bindcoin = 5
        elseif (possibility <= 900) then
            bindcoin = 20
        elseif (possibility <= 999) then
            bindcoin = 50
        else
            local mapid, x, y = GetWorldPos()
            if ((num == 0) and (mapid == 21)) then
                bindcoin = 500
                SaveIniInteger("Save_fsling_Open_Check", 2, 1)
            else
                bindcoin = 50
            end
        end
    elseif (consumePoints >= 10000) then
        if (possibility <= 800) then
            bindcoin = 5
        elseif (possibility <= 900) then
            bindcoin = 20
        else
            bindcoin = 50
        end
    else
        if (possibility <= 850) then
            bindcoin = 5
        else
            bindcoin = 20
        end
    end

    Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> ®· sö dông Thµnh tùu lÖnh.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. bindcoin .. " Linh B¶o!")
    AddBindCoin(bindcoin * 100)
end;

function no()
    CloseDialog()
end;
