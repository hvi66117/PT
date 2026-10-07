function OnDeath(npcIndex)
    if (PlayerIndex > 0) then
        ThrowItem(npcIndex, PlayerIndex, 8, 987, 2, 0, 0, 0)
        ThrowItem(npcIndex, PlayerIndex, 6, 1, 692, 0, 0, 0)

        local randValue = math.random(1, 2)
        if (randValue == 1) then
            ThrowItem(npcIndex, PlayerIndex, 3, 1046, 0, 0, 0, 0)
        end
    else

    end
end
