function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1985 then
        Msg2Player("P0 safety: wrong item for summonbeastmorph_tuzi")
        return
    end
    if SetSummonBeastMorph(2651) <= 0 then
        Msg2Player("Hay trieu hoi thu truoc khi dung vat pham bien hinh.")
        return
    end
    SetTask(254, 2651)
    DelItem(1, 0, 6, 1985)
    Msg2Player("Da luu hinh tuong Tho Vang. Trieu hoi lai thu neu hinh chua doi ngay.")
end
