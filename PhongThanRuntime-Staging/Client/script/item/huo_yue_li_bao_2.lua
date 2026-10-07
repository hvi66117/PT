-- LUA-0056 P1: VNG item 2291 grants two materials 3,374 and item 1304.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 2291 then
        Msg2Player("P1 safety: wrong item for LUA-0056")
        return
    end

    local charmId1 = AddNormalItem(3, 374, 0, 0, 0, 0)
    if charmId1 == nil or charmId1 <= 0 then
        Msg2Player("Khong the them Vi Quang Quai Phu thu nhat; hop qua khong bi tru.")
        return
    end

    local charmId2 = AddNormalItem(3, 374, 0, 0, 0, 0)
    if charmId2 == nil or charmId2 <= 0 then
        DelItemByID(charmId1, 0)
        Msg2Player("Khong the them Vi Quang Quai Phu thu hai; hop qua khong bi tru.")
        return
    end

    local cardId = AddNormalItem(6, 1, 1304, 1, 0, 0)
    if cardId == nil or cardId <= 0 then
        DelItemByID(charmId2, 0)
        DelItemByID(charmId1, 0)
        Msg2Player("Khong the them The Trai Nghiem Bach Ho; hop qua khong bi tru.")
        return
    end

    if DelItem(1, 0, 6, 2291) <= 0 then
        DelItemByID(cardId, 0)
        DelItemByID(charmId2, 0)
        DelItemByID(charmId1, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 2 Vi Quang Quai Phu va 1 The Trai Nghiem Bach Ho 7 ngay.")
end
