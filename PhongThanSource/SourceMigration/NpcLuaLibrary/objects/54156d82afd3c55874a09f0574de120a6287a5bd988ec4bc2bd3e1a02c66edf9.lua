---- yangtao 2009.9.1


function OnDeath(npcindex)
    if (IsHaveSpaceForTreasure(1) == 0) then
        return
    end
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local camp = GetCamp()

    if ((camp == 4) or ((camp == 8) and (GetJusticEvilCredit() < 0))) then
        -- Íæ¼ÒÎª»ÆÉ«ÕóÓª»òÕßºìÉ«ÕóÓªÄ§½ç½ÇÉ«
        local probability = random(1, 100)
        if (probability <= 25) then
            AddNormalItem(6, 1, 577, 1, 0, 0)
            ScrollMessage("B¹n nhËn ®­îc 1 Th­îng Cæ Long Ch©u!")
            Msg2Player("B¹n nhËn ®­îc 1 Th­îng Cæ Long Ch©u!")
        end
    end
end