-- LUA-0057 P1: VNG item 1921 grants 20 units of MagicScript item 587.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1921 then
        Msg2Player("P1 safety: wrong item for LUA-0057")
        return
    end

    local rewardId = AddNormalItem(6, 1, 587, 1, 0, 0)
    if rewardId == nil or rewardId <= 0 then
        Msg2Player("Khong the them Thien Linh Thach; hop qua khong bi tru.")
        return
    end
    SetStackItem(rewardId, 20)
    if GetStackItem(rewardId) ~= 20 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tao chong 20 Thien Linh Thach; hop qua khong bi tru.")
        return
    end
    if DelItem(1, 0, 6, 1921) <= 0 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 20 Thien Linh Thach.")
end
