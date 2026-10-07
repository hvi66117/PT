-- LUA-2064 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [8717] = 1, [8865] = 1, [8882] = 1, [8910] = 1, [8918] = 1, [8929] = 1, [8937] = 1, [8945] = 1, [8969] = 1, [8981] = 1, [8998] = 1, [9014] = 1, [9030] = 1, [9062] = 1, [9072] = 1, [9104] = 1, [9111] = 1, [9125] = 1, [9144] = 1, [9170] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2064")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2064/P2: VNG reward/effect is not verified; item was not consumed.")
end
