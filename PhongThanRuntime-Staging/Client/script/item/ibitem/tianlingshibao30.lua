-- LUA-0058 P1: VNG item 1922 grants 30 units of MagicScript item 587.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1922 then
        Msg2Player("P1 safety: wrong item for LUA-0058")
        return
    end

    local rewardId = AddNormalItem(6, 1, 587, 1, 0, 0)
    if rewardId == nil or rewardId <= 0 then
        Msg2Player("Khong the them Thien Linh Thach; hop qua khong bi tru.")
        return
    end
    SetStackItem(rewardId, 30)
    if GetStackItem(rewardId) ~= 30 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tao chong 30 Thien Linh Thach; hop qua khong bi tru.")
        return
    end
    if DelItem(1, 0, 6, 1922) <= 0 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 30 Thien Linh Thach.")
end
