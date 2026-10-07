function OnDeath(npcindex)
    if (IsHaveSpaceForTreasure(1) == 0) then
        return
    end

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local camp = GetCamp()

    if ((camp == 4) or ((camp == 8) and (GetJusticEvilCredit() < 0))) then
        local probability = math.random(1, 100)
        if (probability <= 25) then
            AddNormalItem(6, 1, 577, 1, 0, 0)
            ScrollMessage("B¹n nhËn ®­îc 1 Th­îng Cæ Long Ch©u!")
            Msg2Player("B¹n nhËn ®­îc 1 Th­îng Cæ Long Ch©u!")
        end
    end
end
