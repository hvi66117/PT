function main(nItemId)
    if GetItemPartByID(nItemId) ~= 1991 then
        Msg2Player("P0 safety: wrong item for fsbook_mu_zhi_zhou_yin")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh bang thuong Chu An Moc; vat pham khong bi tru.")
end
