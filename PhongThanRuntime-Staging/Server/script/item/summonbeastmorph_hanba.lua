function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1983 then
        Msg2Player("P0 safety: wrong item for summonbeastmorph_hanba")
        return
    end
    if SetSummonBeastMorph(2655) <= 0 then
        Msg2Player("Hay trieu hoi thu truoc khi dung vat pham bien hinh.")
        return
    end
    SetTask(254, 2655)
    DelItem(1, 0, 6, 1983)
    Msg2Player("Da luu hinh tuong Han Bat. Trieu hoi lai thu neu hinh chua doi ngay.")
end
