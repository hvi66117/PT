-- LUA-0109 P1: VNG item 1961 grants items 1966 and 2219.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1961 then
        Msg2Player("P1 safety: wrong item for LUA-0109")
        return
    end

    local stoneBagId = AddNormalItem(6, 1, 1966, 1, 0, 0)
    if stoneBagId == nil or stoneBagId <= 0 then
        Msg2Player("Khong the them Goi Thien Linh Thach Lon; hop qua khong bi tru.")
        return
    end

    local orderBagId = AddNormalItem(6, 1, 2219, 1, 0, 0)
    if orderBagId == nil or orderBagId <= 0 then
        DelItemByID(stoneBagId, 0)
        Msg2Player("Khong the them Goi Than Tuong Du Lenh Lon; hop qua khong bi tru.")
        return
    end

    if DelItem(1, 0, 6, 1961) <= 0 then
        DelItemByID(orderBagId, 0)
        DelItemByID(stoneBagId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan Goi Thien Linh Thach Lon va Goi Than Tuong Du Lenh Lon.")
end
