function OnDeath(npcindex)
    ThrowItem(npcindex, PlayerIndex, 3, 1006, 0, 0, 0, 0)
    local p = math.random(1, 2)
    if (p == 1) then
        ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
    else
        ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
        ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
    end
    DelNpc(npcindex)
end
