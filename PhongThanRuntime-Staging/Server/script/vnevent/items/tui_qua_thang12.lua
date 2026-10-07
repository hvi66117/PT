-- LUA-3198 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7477] = 1, [7512] = 1, [7516] = 1, [7522] = 1, [7569] = 1, [7585] = 1, [7589] = 1, [7861] = 1, [7868] = 1, [7897] = 1, [7901] = 1, [7916] = 1, [7957] = 1, [7961] = 1, [8199] = 1, [8200] = 1, [8214] = 1, [8234] = 1, [8246] = 1, [8284] = 1, [8293] = 1, [8302] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-3198")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-3198/P2: VNG reward/effect is not verified; item was not consumed.")
end
