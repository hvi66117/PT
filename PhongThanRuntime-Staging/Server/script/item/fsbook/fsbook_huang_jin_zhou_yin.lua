function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1993 then
        Msg2Player("P0 safety: wrong item for fsbook_huang_jin_zhou_yin")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh bang thuong Chu An Hoang Kim; vat pham khong bi tru.")
end
