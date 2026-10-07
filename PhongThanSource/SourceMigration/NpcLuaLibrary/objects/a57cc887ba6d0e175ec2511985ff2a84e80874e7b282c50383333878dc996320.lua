function OnDeath(c)
    local npcWSIdx = GetTask(1056)
    if (npcWSIdx == c) then
        SetTask(1056, 0)
        local oldplayIdx = PlayerIndex
        local MIdx = GetPlayerIndexByName(GetMateName())
        if (MIdx > 0) then
            PlayerIndex = MIdx
            SetTask(1056, 0)
            PlayerIndex = oldplayIdx
        end

        ThrowItem(c, PlayerIndex, 8, 161, 2, 0, 0, 0)
        local str = ""
        local w = math.random(1, 10)
        if (w <= 9) then
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = "Víi 1 Hoa Hång"
        else
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = "Víi 2 Hoa Hång"
        end

        Msg2Team("Cù Léc cña Ngò Th«ng ThÇn ®· bÞ hµn phôc råi, huyÒn hãa thµnh BiÕn Th©n Phï *Love*" .. str)
    end
    DelNpc(c)
end
