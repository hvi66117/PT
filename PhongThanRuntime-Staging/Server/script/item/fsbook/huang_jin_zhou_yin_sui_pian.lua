function main(nItemId)
    if GetItemPartByID(nItemId) ~= 2076 then
        Msg2Player("P0 safety: wrong item for huang_jin_zhou_yin_sui_pian")
        return
    end
    Msg2Player("BLOCKED_SPEC: chua xac minh ID Chu An Vang khoa de ghep tu 100 manh; vat pham khong bi tru.")
end
