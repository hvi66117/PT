-- LUA-2476 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7895] = 1, [7962] = 1, [7963] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2476")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2476/P2: VNG reward/effect is not verified; item was not consumed.")
end
