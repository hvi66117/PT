function OnDeath(npcidx)
    -- 死亡之后不让它重生需要从世界中删除
    DelNpc(npcidx)
end;
