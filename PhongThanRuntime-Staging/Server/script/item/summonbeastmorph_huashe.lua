function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1984 then
        Msg2Player("P0 safety: wrong item for summonbeastmorph_huashe")
        return
    end
    if SetSummonBeastMorph(2656) <= 0 then
        Msg2Player("Hay trieu hoi thu truoc khi dung vat pham bien hinh.")
        return
    end
    SetTask(254, 2656)
    DelItem(1, 0, 6, 1984)
    Msg2Player("Da luu hinh tuong Hoa Xa. Trieu hoi lai thu neu hinh chua doi ngay.")
end
