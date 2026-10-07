-- LUA-1633 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    if particular ~= 5771 then
        Msg2Player("P2 safety: wrong item for LUA-1633")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-1633/P2: VNG reward/effect is not verified; item was not consumed.")
end
