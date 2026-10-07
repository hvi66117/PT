Task_rw = 1619

Task_snzxy = 1620
Task_snjuli = 1621

function main()


    local today_szxh = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local lastday_szxh = GetTaskByte(Task_rw, 3)
    if (today_szxh ~= lastday_szxh) then
        Talk(1, "no", "Chÿ D…n ßÂ kh´ng t◊m th y vﬁ tr› cÒa Gi∏n ßi÷p h´m qua, Chÿ D…n ßÂ Æ∑ bi’n m t")
        SetTaskWord(Task_snzxy, 1, 0)
        SetTaskWord(Task_snzxy, 2, 0)
        SetTaskByte(Task_snjuli, -1)
        ClearItem(6, 1, 759, 0)
        TaskNote(1505, -1)
        ScrollMessage("Chÿ D…n ßÂ Æ∑ bi’n m t")
    end

    local lightname = {
        [1] = "<color=Earth>∏nh s∏ng y’u<c>",
        [2] = "<color=Pink>∏nh s∏ng mÍ ∂o<c>",
        [3] = "<color=Fire>∏nh s∏ng mπnh<c>",
        [4] = "<c=yel>∏nh s∏ng ch„i chang<c>",
    }
    local mapid, x1, y1 = GetWorldPos()
    local px = GetTaskWord(Task_snzxy, 1)
    local py = GetTaskWord(Task_snzxy, 2)
    local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))

    local light = 1;
    if (distance <= 25) then
        light = 4;
    elseif (distance <= 400) then
        light = 3;
    elseif (distance <= 2500) then
        light = 2;
    end ;
    local msg = "Chÿ D…n ßÂ xu t hi÷n" .. lightname[light]
    local lastdist = GetTask(Task_snjuli)

    if ((light == 4) and (lastdist >= 0)) then
        msg = msg .. ", d≠Íng nh≠ Gi∏n ßi÷p Æang »n n∏u Î xung quanh, bπn h∑y thˆ vÀn may xem sao!"
        MsgBox(msg, "xizuowb", "no")
    else
        if (lastdist == -1) then
            msg = msg .. ", d≠Íng nh≠ Gi∏n ßi÷p Æang »n n∏u Æ©u Æ©y!"
        elseif (lastdist < distance) then
            msg = msg .. ", d≠Íng nh≠ bπn Æ∑ <color=red>rÍi xa<color> Gi∏n ßi÷p h¨n."
        else
            msg = msg .. ", d≠Íng nh≠ bπn Æ∑ <color=green>Æ’n g«n<color> Gi∏n ßi÷p h¨n."
        end
        Talk(1, "no", msg)
    end ;
    SetTask(Task_snjuli, distance)
end

function xizuowb()
    if ((HaveNormalItemInQuick(6, 1, 759, 0) >= 1) or (HaveNormalItem(6, 1, 759, 0) >= 1)) then
        if (HaveNormalItem(6, 1, 759, 0) >= 1) then
            DelNormalItem(6, 1, 759, 0)
        elseif (HaveNormalItemInQuick(6, 1, 759, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 759, 0)
        end ;
        Msg2Player("Gi∏n ßi÷p Æ∑ xu t hi÷n!")
        Talk(1, "no", "Bπn Æ∑ t◊m Æ≠Óc Gi∏n ßi÷p!")
        TaskNote(1505, 1)
        SetTaskByte(Task_rw, 1, 2)
        local mapid, x1, y1 = GetWorldPos()
        local xingbie = GetSex()
        local zhiyan = GetPlayerType()
        if (xingbie == 0) then

            local npcTGIdx = AddNpc(1565 + zhiyan, 100, SubWorld, x1 * 32, y1 * 32)
            SetNpcTask(npcTGIdx, 1, GetPlayerID())
            SetNpcTask(npcTGIdx, 2, GetPosterityType())
            SetTask(1636, npcTGIdx)

        else
            local npcTGIdx = AddNpc(1568 + zhiyan, 100, SubWorld, x1 * 32, y1 * 32)
            SetNpcTask(npcTGIdx, 1, GetPlayerID())
            SetNpcTask(npcTGIdx, 2, GetPosterityType())
            SetTask(1636, npcTGIdx)
        end
    end
end

function no()
    CloseDialog()
end;
