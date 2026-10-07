SoulParticulars = {
    2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035,
    2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045,
    2046, 2047, 2048, 2049, 2050, 2051, 2052, 2053, 2054, 2055,
    2056, 2057, 2058, 2151, 2152, 2153, 2154, 2155, 2156, 2157,
    2158, 2159, 2160, 2161, 2197, 2198, 2199, 2200, 2201, 2202,
    2203, 2204,
}

function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local soulIndex = 0
    for i = 1, table.getn(SoulParticulars) do
        if SoulParticulars[i] == particular then
            soulIndex = i
            break
        end
    end
    if soulIndex == 0 then
        Msg2Player("P0 safety: hon phach khong co trong danh sach 52 vat pham.")
        return
    end

    local taskId = 252
    local bitIndex = soulIndex
    if soulIndex > 26 then
        taskId = 253
        bitIndex = soulIndex - 26
    end
    local value = GetTask(taskId)
    if GetBit(value, bitIndex) > 0 then
        Msg2Player("Hon phach nay da duoc thu thap; vat pham khong bi tru.")
        return
    end
    if DelItem(1, 0, 6, particular) <= 0 then
        Msg2Player("Khong the tru hon phach, thao tac da huy.")
        return
    end
    SetTask(taskId, SetBit(value, bitIndex, 1))
    Msg2Player("Thu thap hon phach thanh cong: " .. soulIndex .. "/52.")
end
