function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1995 then
        Msg2Player("P0 safety: wrong item for fsbook_box_high")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh danh sach Chu An Cao Cap; vat pham khong bi tru.")
end
