function main()
    local maptask = GetTask(381)
    mapid, x1, y1 = GetWorldPos()
    if (GetTask(561) ~= 8) then
        DelNormalItem(6, 1, 179, 0)
        Talk(1, "no", 13247)
    else
        if (GetTask(381) ~= mapid) then
            Talk(1, "no", 13248)
        else
            local px = GetTask(382)
            local py = GetTask(383)
            local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))
            local screen = math.floor(distance / 25)
            local msg = "V∂y RÂng cho bi’t <c=g>Long HÂn Thπch<c> c∏ch bπn <c=r>" .. screen .. "<c>"
            local lastdist = GetTask(378)
            if (distance < 25) and (lastdist ~= 0) then
                msg = msg .. "<c=g>Long HÂn Thπch<c> Æang Î g«n Æ©y! H∑y c»n thÀn!"
                MsgBox(msg, "wabao", "no")
            else
                if (lastdist == 0) then
                    msg = msg .. "<c=g>Long HÂn Thπch<c> Î Æ©y!"
                    SetTask(380, SystemTime())
                end ;
                Talk(1, "no", msg)
            end ;
            SetTask(378, distance)
        end ;
    end ;
end;

function wabao()
    if (GetTask(561) == 8) then
        if ((HaveNormalItem(6, 1, 179, 0) >= 1) or (HaveNormalItemInQuick(6, 1, 179, 0) >= 1)) then
            if (DelNormalItem(6, 1, 179, 0) == 0) then
                DelNormalItemInQuick(6, 1, 179, 0)
            end
            AddEventItem(165)
            SetTask(381, 0)
            SetTask(382, 0)
            SetTask(383, 0)
            SetTask(561, 9)
            Talk(1, "no", 13249)
        end
    end
end

function no()
    CloseDialog()
end
