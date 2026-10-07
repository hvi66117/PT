-- LUA-3230 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [8329] = 1, [8330] = 1, [8331] = 1, [8332] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-3230")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-3230/P2: VNG reward/effect is not verified; item was not consumed.")
end
