function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1992 then
        Msg2Player("P0 safety: wrong item for fsbook_qing_tong_zhou_yin")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh bang thuong Chu An Thanh Dong; vat pham khong bi tru.")
end
