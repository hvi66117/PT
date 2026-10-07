function main()

    local maps = {
        1, 2, 3, 4, 5,
        8, 11, 14, 15, 16,
        20, 21, 52, 57, 65
    }

    local mapid, x, y = GetWorldPos()
    local v = 11
    for i = 1, 15 do
        if (maps[i] == mapid) then
            local dirname = { "ChÝnh B¾c", "§«ng B¾c", "ChÝnh §«ng", "§«ng Nam", "ChÝnh Nam", "T©y Nam", "ChÝnh T©y", "T©y B¾c" }
            TopMessage("Hoa ThÇn Cöu Di ë <c=g>" .. dirname[GetDir(x, y, GetGlobalValue(v), GetGlobalValue(v + 1))] .. "<c> täa ®é cña Cöu Di")
            return
        end
        v = v + 2
    end
    TopMessage(13253)
end

function GetDir(x0, y0, x1, y1)
    local x = x1 - x0
    local y = y1 - y0

    if (x == 0 and y < 0) then
        return (1)
    elseif (x == 0 and y > 0) then
        return (5)
    end

    local tan = y / x
    if (tan >= -2 and tan <= -0.5 and x < 0 and y > 0) then
        return (6)
    elseif (tan >= -2 and tan <= -0.5 and x > 0 and y < 0) then
        return (2)
    elseif (tan >= 0.5 and tan <= 2 and x < 0 and y < 0) then
        return (8)
    elseif (tan >= 0.5 and tan <= 2 and x > 0 and y > 0) then
        return (4)
    elseif (tan > -0.5 and tan < 0.5 and x <= 0) then
        return (7)
    elseif (tan > -0.5 and tan < 0.5 and x >= 0) then
        return (3)
    elseif ((tan > 2 or tan < -2) and y < 0) then
        return (1)
    elseif ((tan > 2 or tan < -2) and y > 0) then
        return (5)
    end
    return (5)
end

function no()
    CloseDialog()
end;
