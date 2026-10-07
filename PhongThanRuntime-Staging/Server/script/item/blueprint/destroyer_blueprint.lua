-- LUA-0012 P1: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [2080] = 1, [2081] = 1, [2082] = 1, [2083] = 1, [2084] = 1, [2085] = 1, [2086] = 1, [2087] = 1, [2088] = 1, [2089] = 1, [2090] = 1, [2091] = 1, [2092] = 1, [2093] = 1, [2094] = 1, [2095] = 1, [2096] = 1, [2097] = 1, [2098] = 1, [2099] = 1, [2100] = 1, [2101] = 1, [2102] = 1, [2103] = 1, [2104] = 1, [2105] = 1, [2106] = 1, [2107] = 1, [2108] = 1, [2109] = 1, [2110] = 1, [2111] = 1, [2112] = 1, [2113] = 1, [2114] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P1 safety: wrong item for LUA-0012")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-0012/P1: VNG reward/effect is not verified; item was not consumed.")
end
