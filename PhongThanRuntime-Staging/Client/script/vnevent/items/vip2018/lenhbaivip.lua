-- LUA-3248 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7308] = 1, [7309] = 1, [7310] = 1, [7311] = 1, [7312] = 1, [7313] = 1, [7314] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-3248")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-3248/P2: VNG reward/effect is not verified; item was not consumed.")
end
