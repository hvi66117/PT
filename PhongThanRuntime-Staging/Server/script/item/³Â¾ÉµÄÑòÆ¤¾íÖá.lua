function main()
    local maptask = GetTaskByte(921, 1)
    mapid, x1, y1 = GetWorldPos()
    UTask_Wizard = GetTask(1)
    UTask_Knight = GetTask(3)
    UTask_Druid = GetTask(2)
    if ((UTask_Knight == 84) or (UTask_Wizard == 84) or (UTask_Druid == 84)) and (IsExistItem(4, 178, 0, 1) == 0) and ((maptask ~= 0) and (GetTask(918) ~= 0) and (GetTask(919) ~= 0)) then

        if (maptask ~= mapid) then
            Talk(1, "no", 13167)
        else
            local px = GetTask(918)
            local py = GetTask(919)
            local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))
            local screen = math.floor(distance / 25)
            local msg = "MÀt ÆÂ da d™ hi”n thﬁ <color=green>Tµn Nh…n<color> chÿ cﬂn c∏ch bπn <color=red>" .. screen .. "<c>"
            local lastdist = GetTask(920)
            if (distance < 25) and (lastdist ~= 0) then
                msg = msg .. "Hung kh› <c=g>Tµn Nh…n<c> Æang Î g«n Æ©y, bπn chÛ ˝ nh–!"
                MsgBox(msg, "wabao", "no")
            else
                if (lastdist == 0) then
                    msg = msg .. "Hung kh› <c=g>Tµn Nh…n<c> Î Æ©y!"

                end ;
                Talk(1, "no", msg)
            end ;
            SetTask(920, distance)
        end ;
    elseif (GetTaskByte(921, 1) == 0) and (GetTask(918) == 0) and (GetTask(919) == 0) then
        if (DelNormalItem(6, 1, 142, 0) == 0) then
            DelNormalItemInQuick(6, 1, 142, 0)
        end
        Talk(1, "no", 13168)
    else
        if (DelNormalItem(6, 1, 142, 0) == 0) then
            DelNormalItemInQuick(6, 1, 142, 0)
        end
        Talk(1, "no", 13169)

    end ;
end;

function wabao()
    if ((UTask_Knight == 84) or (UTask_Wizard == 84) or (UTask_Druid == 84)) then
        if ((HaveNormalItem(6, 1, 142, 0) >= 1) or (HaveNormalItemInQuick(6, 1, 142, 0) >= 1)) then
            if (DelNormalItem(6, 1, 142, 0) == 0) then
                DelNormalItemInQuick(6, 1, 142, 0)
            end

            TopMessage(13170)
            Talk(1, "no", 13170)
            AddEventItem(178)
            SetTaskByte(921, 1, 0)
            SetTaskBit(921, 9, 1)
            SetTask(918, 0)
            SetTask(919, 0)

        end

    end
end

function no()
    CloseDialog()
end
