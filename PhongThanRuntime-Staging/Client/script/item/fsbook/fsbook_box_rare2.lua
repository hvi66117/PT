function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 2078 then
        Msg2Player("P0 safety: wrong item for fsbook_box_rare2")
        return
    end
    if DelItem(1, 0, 6, particular) <= 0 then
        Msg2Player("Khong the tru vat pham, thao tac da huy.")
        return
    end
    local value = GetTask(251)
    SetTask(251, value + 250)
    Msg2Player("Nhan 250 diem Phong Than Du Luc. Thuong Dong Chu An dang BLOCKED_SPEC.")
end
