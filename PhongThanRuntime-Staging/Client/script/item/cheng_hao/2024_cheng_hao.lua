-- LUA-0015 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [2065] = 1, [2066] = 1, [2067] = 1, [2068] = 1, [2069] = 1, [2070] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0015")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0015/P1: VNG reward/effect is not verified; item was not consumed.")
end
