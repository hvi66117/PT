-- LUA-0148 P1: VNG item 1928 grants 2 units of MagicScript item 1929.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1928 then
        Msg2Player("P1 safety: wrong item for LUA-0148")
        return
    end

    local rewardId = AddNormalItem(6, 1, 1929, 1, 0, 0)
    if rewardId == nil or rewardId <= 0 then
        Msg2Player("Khong the them Manh Tinh Hoa Tien Sung; hop qua khong bi tru.")
        return
    end
    SetStackItem(rewardId, 2)
    if GetStackItem(rewardId) ~= 2 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tao chong 2 Manh Tinh Hoa Tien Sung; hop qua khong bi tru.")
        return
    end
    if DelItem(1, 0, 6, 1928) <= 0 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 2 Manh Tinh Hoa Tien Sung.")
end
