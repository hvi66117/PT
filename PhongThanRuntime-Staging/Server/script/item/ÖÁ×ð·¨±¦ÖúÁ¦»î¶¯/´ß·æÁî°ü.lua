-- LUA-0160 P1: VNG item 1931 grants 5 Thoi Phong Lenh (material 3,174).
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1931 then
        Msg2Player("P1 safety: wrong item for LUA-0160")
        return
    end

    local rewardId = AddNormalItem(3, 174, 0, 0, 0, 0)
    if rewardId == nil or rewardId <= 0 then
        Msg2Player("Khong the them Thoi Phong Lenh; hop qua khong bi tru.")
        return
    end
    SetStackItem(rewardId, 5)
    if GetStackItem(rewardId) ~= 5 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tao chong 5 Thoi Phong Lenh; hop qua khong bi tru.")
        return
    end
    if DelItem(1, 0, 6, 1931) <= 0 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 5 Thoi Phong Lenh.")
end
