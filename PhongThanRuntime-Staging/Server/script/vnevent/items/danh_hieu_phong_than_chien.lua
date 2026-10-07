-- LUA-1686 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [8956] = 1, [8957] = 1, [8958] = 1, [8959] = 1, [8960] = 1, [8961] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-1686")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-1686/P2: VNG reward/effect is not verified; item was not consumed.")
end
