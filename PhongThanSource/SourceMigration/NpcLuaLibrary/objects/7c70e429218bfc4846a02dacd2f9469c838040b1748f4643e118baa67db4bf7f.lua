-- yangyankun；2010-1-6；副本寒冰阵

function OnDeath(npcIndex)
    if (PlayerIndex > 0) then
        -- 被人打死
        ThrowItem(npcIndex, PlayerIndex, 8, 987, 2, 0, 0, 0)        -- 疾风丹
        ThrowItem(npcIndex, PlayerIndex, 6, 1, 692, 0, 0, 0)        -- 炼丹配方：疾风丹

        local randValue = random(1, 2)
        if (randValue == 1) then
            ThrowItem(npcIndex, PlayerIndex, 3, 1046, 0, 0, 0, 0)        -- 冰玉髓
        end
    else

    end
end