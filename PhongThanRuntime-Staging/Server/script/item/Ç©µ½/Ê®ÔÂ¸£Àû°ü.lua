function main(leve, t, npcidx, id)


    if (IsHaveSpaceForTreasure(8) < 1) then
        Msg2Player("Hµnh trang kh«ng cã ®ñ 8 « trèng, kh«ng thÓ më lÔ bao")
        return
    end

    if (DelItemByID(id) == 0) then
        return
    end

    AddNormalItemBind(8, 2107, 2, 1, 0, 0, 1)

    AddNormalItemBind(6, 1, 1773, 1, 0, 0, 1)

    AddNormalItemBind(6, 1, 901, 1, 0, 0, 1)

    for i = 1, 4 do
        AddNormalItemBind(8, 1775, 2, 1, 0, 0, 1)
    end

    local str = "Më tói phóc lîi th¸ng 10, nhËn ®­îc LÔ bao H»ng ngµy (®Æc biÖt), LÔ hép 7 ngµy*1, Ngo¹i trang 7 ngµy*1, LÔ hép Phï Th¹ch*4"
    Msg2Player(str)
    WriteLog(str)
end
