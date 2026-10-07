-- LUA-0866 P3: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 7067 then
        Msg2Player("P3 safety: wrong item for LUA-0866")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0866/P3: VNG reward/effect is not verified; item was not consumed.")
end
