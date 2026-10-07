function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1986 then
        Msg2Player("P0 safety: wrong item for summonbeastmorph_zhushen")
        return
    end
    if SetSummonBeastMorph(2653) <= 0 then
        Msg2Player("Hay trieu hoi thu truoc khi dung vat pham bien hinh.")
        return
    end
    SetTask(254, 2653)
    DelItem(1, 0, 6, 1986)
    Msg2Player("Da luu hinh tuong Chuc Than Vang. Trieu hoi lai thu neu hinh chua doi ngay.")
end
