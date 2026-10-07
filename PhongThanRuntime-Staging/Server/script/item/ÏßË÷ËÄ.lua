-- LUA-0152 P1: read-only clue; the VNG description defines the displayed clue.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 743 then
        Msg2Player("P1 safety: wrong item for LUA-0152")
        return
    end
    Msg2Player("Manh moi thu tu: Thu thap 10 Thach Moc tu Nu Te, dot lai lua trai va dua den canh Tinh Ve de giai cuu.")
end
