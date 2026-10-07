-- LUA-0025 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [2205] = 1, [2206] = 1, [2207] = 1, [2208] = 1, [2209] = 1, [2210] = 1, [2211] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0025")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0025/P1: VNG reward/effect is not verified; item was not consumed.")
end
