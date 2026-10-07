function main()
    local maptask = GetTask(381)
    mapid, x1, y1 = GetWorldPos()
    if (GetTask(849) == 0) then
        ClearItem(6, 1, 149, 0)
        Talk(1, "no", 13149)
    else
        if (GetTask(381) ~= mapid) then
            Talk(1, "no", 13150)
        else
            local px = GetTask(382)
            local py = GetTask(383)
            local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))
            local screen = math.floor(distance / 25)
            local msg = "<color=green>魔神密令<color>距离离你还有<color=red>" .. screen .. "<c>"
            local lastdist = GetTask(378)
            if (distance < 25) and (lastdist ~= 0) then
                msg = msg .. "<color=green>魔神密令<color>似乎就在附近, 你要仔细寻找一下吗?"
                MsgBox(msg, "wabao", "no")
            else
                if (lastdist == 0) then
                    msg = msg .. "<color=green>魔神密令<color>似乎就在此地某处!"
                    SetTask(380, SystemTime())
                end ;
                TopMessage(msg)
            end ;
            SetTask(378, distance)
        end ;
    end ;
end;

function wabao()
    no()
    if (GetTask(849) == 1) then
        if ((HaveNormalItem(6, 1, 149, 0) >= 1) or (HaveNormalItemInQuick(6, 1, 149, 0) >= 1)) then
            if (DelNormalItem(6, 1, 149, 0) == 0) then
                DelNormalItemInQuick(6, 1, 149, 0)
            end
            AddNormalItem(8, math.random(187, 188), 2, 0, 1, 0)
            AddNormalItemBind(6, 1, 1439, 0, 0, 0, 1)
            SetTask(849, 0)

            SetTask(381, 0)
            SetTask(382, 0)
            SetTask(383, 0)

            Talk(1, "no", "Nh薾 頲 La S竧 Ma Th莕 M藅 L謓h, 请使用密令召唤罗刹魔神.")
            Msg2Player("Nh薾 頲 La S竧 Ma Th莕 M藅 L謓h, 请使用密令召唤罗刹魔神.")
            WriteLog("[Nh薾 頲 La S竧 Ma Th莕 M藅 L謓h]")
        end
    end
end

function no()
    CloseDialog()
end
