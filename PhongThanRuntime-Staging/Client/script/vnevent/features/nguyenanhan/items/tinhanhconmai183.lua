-- LUA-1463 P3: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 7127 then
        Msg2Player("P3 safety: wrong item for LUA-1463")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-1463/P3: VNG reward/effect is not verified; item was not consumed.")
end
