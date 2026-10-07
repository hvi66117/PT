-- LUA-0153 P1: read-only clue; the VNG description defines the displayed clue.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 740 then
        Msg2Player("P1 safety: wrong item for LUA-0153")
        return
    end
    Msg2Player("Manh moi thu nhat: Tren Dong Doanh Dao vua xay ra mot tran kich chien. Hay den kiem tra cac dau vet con lai.")
end
