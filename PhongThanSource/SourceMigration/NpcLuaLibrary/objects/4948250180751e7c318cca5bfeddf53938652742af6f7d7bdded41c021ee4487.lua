--description:ÎåÍ¨Éñ--±±º£
--author: yaoxin
--date: 2007/8/6

function OnDeath(c)
    local npcWSIdx = GetTask(1056)
    if (npcWSIdx == c) then
        local r = random(1, 100)
        SetTask(1056, 0)
        local oldplayIdx = PlayerIndex
        local MIdx = GetPlayerIndexByName(GetMateName())
        if (MIdx > 0) then
            PlayerIndex = MIdx
            SetTask(1056, 0)
            PlayerIndex = oldplayIdx
        end
        local str = ""
        if (r <= 33) then
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            --TopMessage(11675)
            str = ", rít hoa hång"
        elseif (r <= 67) then
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            --TopMessage(11676)
            str = ", rít 2 Hoa hång"
        else
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            ThrowItem(c, PlayerIndex, 6, 1, 22, 0, 0, 0)
            --TopMessage(11677)
            str = ", rít 3 Hoa hång"
        end
        local w = random(1, 10)
        if (w <= 9) then
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = str .. "Víi 1 Hoa Hång"
        else
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = str .. "Víi 2 Hoa Hång"
        end

        Msg2Team("Ngò Th«ng ThÇn ë B¾c H¶i bÞ gi¸ng phôc" .. str)
    end
    DelNpc(c)
end