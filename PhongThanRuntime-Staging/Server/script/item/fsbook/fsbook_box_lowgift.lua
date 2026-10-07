function main(nItemId)
    if GetItemPartByID(nItemId) ~= 2010 then
        Msg2Player("P0 safety: wrong item for fsbook_box_lowgift")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh danh sach bua Trung Cap; vat pham khong bi tru.")
end
