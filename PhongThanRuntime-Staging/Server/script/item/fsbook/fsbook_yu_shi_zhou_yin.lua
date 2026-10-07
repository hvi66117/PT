function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1994 then
        Msg2Player("P0 safety: wrong item for fsbook_yu_shi_zhou_yin")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh bang thuong Chu An Ngoc Thach; vat pham khong bi tru.")
end
