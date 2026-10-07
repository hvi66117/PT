-- LUA-0150 P1: read-only clue; the VNG description defines the displayed clue.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 741 then
        Msg2Player("P1 safety: wrong item for LUA-0150")
        return
    end
    Msg2Player("Manh moi thu hai: Chien hoa da lan den Van Long Dao, Vat to Dinh Hai da bi ton hai. Hay den do kiem tra.")
end
