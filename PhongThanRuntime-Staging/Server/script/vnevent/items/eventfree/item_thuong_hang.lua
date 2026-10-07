-- LUA-2074 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7284] = 1, [7286] = 1, [7378] = 1, [7401] = 1, [8304] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2074")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2074/P2: VNG reward/effect is not verified; item was not consumed.")
end
