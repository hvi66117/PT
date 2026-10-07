TaskYouChong = 1288
TaskMsg = {
    [1] = "cßn ph¶i tiªu diÖt",
    [2] = "¦u Trïng",
    [3] = "B¹n ®· hoµn thµnh nhiÖm vô ¦u Trïng Phô ThÓ",
}

function OnDeath(npcindex)
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lKillNum = GetByte(GetTask(TaskYouChong), 3)

    if (lTaskCtrl == 1) then
        lKillNum = lKillNum - 1
        SetTask(TaskYouChong, SetByte(GetTask(TaskYouChong), 3, lKillNum))
        if (lKillNum > 0) then
            Msg2Player(TaskMsg[1] .. lKillNum .. TaskMsg[2])
            TopMessage(TaskMsg[1] .. lKillNum .. TaskMsg[2])
            TaskNote(1024, 1, lKillNum)
            BorthYouChong()
        else
            Msg2Player(TaskMsg[3])
            TopMessage(TaskMsg[3])
            SetTaskWord(TaskYouChong, 1, 2)
            TaskNote(1024, 2)
        end

    end
    DelNpc(npcindex)
end

function BorthYouChong()
    local rate = math.random(1, 2)
    local num = GetByte(GetTask(TaskYouChong), 4)

    if (num <= 0) then
        return 0
    end

    if (rate == 1) then
        num = num - 1
        SetTask(TaskYouChong, SetByte(GetTask(TaskYouChong), 4, num))
        local w, x, y = GetWorldPos()
        local newnpcidx = AddNpc(808, 10, SubWorld, x * 32, y * 32)
        return 1
    end
    return 0
end
