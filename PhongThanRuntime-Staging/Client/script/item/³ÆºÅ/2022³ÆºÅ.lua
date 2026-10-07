-- LUA-0106 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [1911] = 1, [1912] = 1, [1913] = 1, [1914] = 1, [1915] = 1, [1916] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0106")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0106/P1: VNG reward/effect is not verified; item was not consumed.")
end
