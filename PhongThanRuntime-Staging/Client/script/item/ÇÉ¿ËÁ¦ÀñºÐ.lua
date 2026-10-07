Task_Plant = 1762

Task_TotalCount = 1763

function main()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy!")
        return
    end

    local nDegree = GetTaskByte(Task_Plant, 4)
    ClearItem(6, 1, 820, 0)
    if nDegree >= 40 and nDegree <= 50 then
        local count = math.random(2, 3)
        for i = 1, count do
            AddNormalItemPile(1, 6, 0, 1, 0, 0)
        end
        Msg2Player("B¹n nh©n ®­îc " .. count .. " S« c« la")
    elseif nDegree > 50 then
        local count = math.random(10, 15)
        for i = 1, count do
            AddNormalItemPile(1, 6, 0, 1, 0, 0)
        end
        Msg2Player("B¹n nh©n ®­îc " .. count .. " S« c« la")
    else
        Msg2Player("T×nh huèng nµy th«ng th­êng sÏ kh«ng x¶y ra, ®é tr­ëng thµnh ch­a ®Õn 40, sÏ kh«ng thÓ nhËn NguyÖn Väng Th¹ch. Nh­ng ®Ó phßng hê, nªn cã thªm mét c©u h­íng dÉn!")
    end
end

function no()
    CloseDialog()
end
