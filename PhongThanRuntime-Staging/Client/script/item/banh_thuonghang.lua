-- LUA-0004 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 312 then
        Msg2Player("P1 safety: wrong item for LUA-0004")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0004/P1: VNG reward/effect is not verified; item was not consumed.")
end
