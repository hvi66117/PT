function main(nItemId)
    if GetItemPartByID(nItemId) ~= 2077 then
        Msg2Player("P0 safety: wrong item for fsbook_huang_jin_zhou_yin_sui_ji_box")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh tap Chu An Vang ngau nhien; vat pham khong bi tru.")
end
