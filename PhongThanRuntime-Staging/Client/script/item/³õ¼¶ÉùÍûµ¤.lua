-- LUA-0111 P1: verified fixed-effect item from the VNG MagicScript row.
-- Effect: add exactly 50 Repute, then consume one matching item.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1400 then
        Msg2Player("P1 safety: wrong item for LUA-0111")
        return
    end

    local before = GetRepute()
    if before == nil then
        Msg2Player("Khong doc duoc Danh Vong; vat pham khong bi tru.")
        return
    end

    AddRepute(50)
    local after = GetRepute()
    if after ~= before + 50 then
        SetRepute(before)
        Msg2Player("Khong the cong 50 Danh Vong; vat pham khong bi tru.")
        return
    end

    if DelItem(1, 0, 6, 1400) <= 0 then
        SetRepute(before)
        Msg2Player("Khong the tru vat pham; da hoan lai Danh Vong.")
        return
    end

    Msg2Player("Da nhan 50 diem Danh Vong.")
end
