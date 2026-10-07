-- LUA-0016 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [2185] = 1, [2186] = 1, [2187] = 1, [2188] = 1, [2189] = 1, [2190] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0016")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0016/P1: VNG reward/effect is not verified; item was not consumed.")
end
