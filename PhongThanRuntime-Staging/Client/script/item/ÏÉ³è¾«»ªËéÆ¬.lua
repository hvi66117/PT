-- LUA-0149 P1: combine 10 item 1929 into VNG material 3,5740.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1929 then
        Msg2Player("P1 safety: wrong item for LUA-0149")
        return
    end

    if HaveNormalItem(6, 1, 1929, 1) < 10 then
        Msg2Player("Can du 10 Manh Tinh Hoa Tien Sung de ghep.")
        return
    end

    local rewardId = AddNormalItem(3, 5740, 0, 0, 0, 0)
    if rewardId == nil or rewardId <= 0 then
        Msg2Player("Khong the them Tinh Hoa Tien Sung; manh chua bi tru.")
        return
    end
    if DelItem(10, 0, 6, 1929) <= 0 then
        DelItemByID(rewardId, 0)
        Msg2Player("Khong the tru 10 manh; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da ghep thanh 1 Tinh Hoa Tien Sung.")
end
