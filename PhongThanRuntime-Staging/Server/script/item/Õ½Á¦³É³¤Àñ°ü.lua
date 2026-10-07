-- LUA-0158 P1: VNG item 1960 grants 600 material 3,1319 and one 3,374.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1960 then
        Msg2Player("P1 safety: wrong item for LUA-0158")
        return
    end

    local qiId1 = AddNormalItem(3, 1319, 0, 0, 0, 0)
    if qiId1 == nil or qiId1 <= 0 then
        Msg2Player("Khong the them Nguyen Khi; hop qua khong bi tru.")
        return
    end
    SetStackItem(qiId1, 250)
    if GetStackItem(qiId1) ~= 250 then
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the tao chong 250 Nguyen Khi; hop qua khong bi tru.")
        return
    end

    local qiId2 = AddNormalItem(3, 1319, 0, 0, 0, 0)
    if qiId2 == nil or qiId2 <= 0 then
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the them chong Nguyen Khi thu hai; hop qua khong bi tru.")
        return
    end
    SetStackItem(qiId2, 250)
    if GetStackItem(qiId2) ~= 250 then
        DelItemByID(qiId2, 0)
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the tao chong 250 Nguyen Khi thu hai; hop qua khong bi tru.")
        return
    end

    local qiId3 = AddNormalItem(3, 1319, 0, 0, 0, 0)
    if qiId3 == nil or qiId3 <= 0 then
        DelItemByID(qiId2, 0)
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the them chong Nguyen Khi thu ba; hop qua khong bi tru.")
        return
    end
    SetStackItem(qiId3, 100)
    if GetStackItem(qiId3) ~= 100 then
        DelItemByID(qiId3, 0)
        DelItemByID(qiId2, 0)
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the tao chong 100 Nguyen Khi; hop qua khong bi tru.")
        return
    end

    local charmId = AddNormalItem(3, 374, 0, 0, 0, 0)
    if charmId == nil or charmId <= 0 then
        DelItemByID(qiId3, 0)
        DelItemByID(qiId2, 0)
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the them Vi Quang Quai Phu; hop qua khong bi tru.")
        return
    end

    if DelItem(1, 0, 6, 1960) <= 0 then
        DelItemByID(charmId, 0)
        DelItemByID(qiId3, 0)
        DelItemByID(qiId2, 0)
        DelItemByID(qiId1, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 600 Nguyen Khi va 1 Vi Quang Quai Phu.")
end
