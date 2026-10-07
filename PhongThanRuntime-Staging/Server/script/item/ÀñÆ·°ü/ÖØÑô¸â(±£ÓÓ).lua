-- VNG source entry is byte-corrupt and cannot be executed safely.
-- MagicScript evidence: genre=6, detail=1, particular=731.
-- Do not consume or grant anything until an intact VNG source is recovered.
function main(nLevel, nTime, nTNpcIdx, nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 731 then
        Msg2Player("VNG source safety: wrong item for particular 731")
        return
    end
    Msg2Player("BLOCKED_SOURCE_CORRUPT: intact VNG Lua is required; item was not consumed.")
end
