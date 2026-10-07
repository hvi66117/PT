function main(nItemId)
    if GetItemPartByID(nItemId) ~= 2025 then
        Msg2Player("P0 safety: wrong item for parts_to_soul_2025")
        return
    end
    Msg2Player("BLOCKED_SPEC: can ID Hon Tinh Than Thu de doi 1000 manh + 7; vat pham khong bi tru.")
end
