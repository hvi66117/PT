function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 2059 and particular ~= 2064 then
        Msg2Player("P0 safety: wrong item for fsbook_huang_jin_zhou_yin_piece")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh ID ruong ghep tu 5 manh va thuoc tinh khoa; vat pham khong bi tru.")
end
