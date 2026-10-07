-- LUA-2001 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [8718] = 1, [8866] = 1, [8883] = 1, [8911] = 1, [8919] = 1, [8930] = 1, [8938] = 1, [8946] = 1, [8970] = 1, [8982] = 1, [8999] = 1, [9015] = 1, [9031] = 1, [9063] = 1, [9073] = 1, [9105] = 1, [9112] = 1, [9126] = 1, [9145] = 1, [9171] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2001")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2001/P2: VNG reward/effect is not verified; item was not consumed.")
end
