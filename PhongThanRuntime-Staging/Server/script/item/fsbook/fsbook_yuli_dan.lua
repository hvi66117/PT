function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1988 then
        Msg2Player("P0 safety: wrong item for fsbook_yuli_dan")
        return
    end
    if DelItem(1, 0, 6, particular) <= 0 then
        Msg2Player("Khong the tru vat pham, thao tac da huy.")
        return
    end
    local value = GetTask(251)
    SetTask(251, value + 100)
    Msg2Player("Nhan 100 diem Phong Than Du Luc. Tong: " .. (value + 100))
end
