function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1982 then
        Msg2Player("P0 safety: wrong item for summonbeastmorph_bifang")
        return
    end
    if SetSummonBeastMorph(2654) <= 0 then
        Msg2Player("Hay trieu hoi thu truoc khi dung vat pham bien hinh.")
        return
    end
    SetTask(254, 2654)
    DelItem(1, 0, 6, 1982)
    Msg2Player("Da luu hinh tuong Tat Phuong. Trieu hoi lai thu neu hinh chua doi ngay.")
end
