-- LUA-2069 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7406] = 1, [7479] = 1, [7496] = 1, [7508] = 1, [7520] = 1, [7571] = 1, [7587] = 1, [7859] = 1, [7922] = 1, [8037] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2069")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2069/P2: VNG reward/effect is not verified; item was not consumed.")
end
