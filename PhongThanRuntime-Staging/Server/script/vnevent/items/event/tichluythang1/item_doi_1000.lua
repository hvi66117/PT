-- LUA-1984 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7202] = 1, [7212] = 1, [7218] = 1, [7273] = 1, [7371] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-1984")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-1984/P2: VNG reward/effect is not verified; item was not consumed.")
end
