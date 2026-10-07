-- LUA-0487 P3: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 7989 then
        Msg2Player("P3 safety: wrong item for LUA-0487")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0487/P3: VNG reward/effect is not verified; item was not consumed.")
end
