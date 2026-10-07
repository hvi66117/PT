-- LUA-0117 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 1946 then
        Msg2Player("P1 safety: wrong item for LUA-0117")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0117/P1: VNG reward/effect is not verified; item was not consumed.")
end
