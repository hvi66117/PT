-- LUA-0151 P1: read-only clue; the VNG description defines the displayed clue.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 742 then
        Msg2Player("P1 safety: wrong item for LUA-0151")
        return
    end
    Msg2Player("Manh moi thu ba: Gan ben tau Bong Lai Tien Dao co mot dong lua ky la. Hay den do tim them dau vet.")
end
