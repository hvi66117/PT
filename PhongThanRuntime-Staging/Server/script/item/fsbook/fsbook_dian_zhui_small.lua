function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 2015 then
        Msg2Player("P0 safety: wrong item for fsbook_dian_zhui_small")
        return
    end
    if DelItem(1, 0, 6, particular) <= 0 then
        Msg2Player("Khong the tru vat pham, thao tac da huy.")
        return
    end
    local value = GetTask(251)
    SetTask(251, value + 1)
    Msg2Player("Nhan 1 diem Phong Than Du Luc. Tong: " .. (value + 1))
end
