-- LUA-1991 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7148] = 1, [7183] = 1, [7347] = 1, [7358] = 1, [7361] = 1, [7362] = 1, [7363] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-1991")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-1991/P2: VNG reward/effect is not verified; item was not consumed.")
end
