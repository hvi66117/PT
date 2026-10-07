-- LUA-0014 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [1968] = 1, [1969] = 1, [1970] = 1, [1971] = 1, [1972] = 1, [1973] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0014")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0014/P1: VNG reward/effect is not verified; item was not consumed.")
end
