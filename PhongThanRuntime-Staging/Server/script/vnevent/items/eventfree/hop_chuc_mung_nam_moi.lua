-- LUA-2027 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [8719] = 1, [8867] = 1, [8884] = 1, [8912] = 1, [8920] = 1, [8931] = 1, [8939] = 1, [8947] = 1, [8971] = 1, [8983] = 1, [9000] = 1, [9016] = 1, [9032] = 1, [9064] = 1, [9074] = 1, [9106] = 1, [9113] = 1, [9127] = 1, [9146] = 1, [9172] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2027")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2027/P2: VNG reward/effect is not verified; item was not consumed.")
end
