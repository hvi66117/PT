-- LUA-0055 P1: VNG item 2290 grants item 8923 and material 3,374.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 2290 then
        Msg2Player("P1 safety: wrong item for LUA-0055")
        return
    end

    local bagId = AddNormalItem(6, 1, 8923, 1, 0, 0)
    if bagId == nil or bagId <= 0 then
        Msg2Player("Khong the them Tui Danh Ngoc; hop qua khong bi tru.")
        return
    end

    local charmId = AddNormalItem(3, 374, 0, 0, 0, 0)
    if charmId == nil or charmId <= 0 then
        DelItemByID(bagId, 0)
        Msg2Player("Khong the them Vi Quang Quai Phu; hop qua khong bi tru.")
        return
    end

    if DelItem(1, 0, 6, 2290) <= 0 then
        DelItemByID(charmId, 0)
        DelItemByID(bagId, 0)
        Msg2Player("Khong the tru hop qua; phan thuong da duoc thu hoi.")
        return
    end
    Msg2Player("Da nhan 1 Tui Danh Ngoc va 1 Vi Quang Quai Phu.")
end
