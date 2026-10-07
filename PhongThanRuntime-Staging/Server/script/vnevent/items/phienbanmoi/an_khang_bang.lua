-- LUA-2638 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7230] = 1, [7231] = 1, [7232] = 1, [7234] = 1, [7238] = 1, [7239] = 1, [7240] = 1, [7241] = 1, [7243] = 1, [7244] = 1, [7245] = 1, [7246] = 1, [7248] = 1, [7249] = 1, [7250] = 1, [7251] = 1, [7252] = 1, [7253] = 1, [7254] = 1, [7255] = 1, [7256] = 1, [7257] = 1, [7258] = 1, [7259] = 1, [7260] = 1, [7261] = 1, [7262] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2638")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2638/P2: VNG reward/effect is not verified; item was not consumed.")
end
