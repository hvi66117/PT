function OnDeath(npcindex)
    ThrowItem(npcindex, PlayerIndex, 3, 1006, 0, 0, 0, 0)
    ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
    ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)

    DelNpc(npcindex)
end
