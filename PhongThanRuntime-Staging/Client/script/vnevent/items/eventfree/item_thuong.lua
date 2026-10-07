-- LUA-2073 P2: generated safety adapter from the locked VNG backlog.
-- This file must not consume the item until its reward/effect specification is verified.
function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local allowed = { [7283] = 1, [7285] = 1, [7377] = 1, [7400] = 1, [7405] = 1, [7411] = 1, [7467] = 1, [7471] = 1, [7473] = 1, [7480] = 1, [7509] = 1, [7521] = 1, [7860] = 1, [7864] = 1, [7873] = 1, [7893] = 1, [7899] = 1, [7920] = 1, [7927] = 1, [7959] = 1, [8002] = 1, [8016] = 1, [8022] = 1, [8027] = 1, [8035] = 1, [8070] = 1, [8094] = 1, [8100] = 1, [8162] = 1, [8203] = 1, [8209] = 1, [8212] = 1, [8232] = 1, [8270] = 1, [8285] = 1, [8294] = 1, [8303] = 1, [8476] = 1, [8514] = 1, [8522] = 1, [8566] = 1, [8580] = 1, [8592] = 1, [8600] = 1, [8638] = 1, [8659] = 1, [8698] = 1, [8729] = 1, [8742] = 1, [8753] = 1, [8760] = 1, [8795] = 1, [8800] = 1, [8817] = 1, [8829] = 1, [8843] = 1, [8864] = 1, [8881] = 1, [8909] = 1, [8917] = 1, [8928] = 1, [8936] = 1, [8944] = 1, [8968] = 1, [8980] = 1, [8997] = 1, [9013] = 1, [9029] = 1, [9061] = 1, [9071] = 1, [9103] = 1, [9110] = 1, [9124] = 1, [9143] = 1, [9169] = 1 }
    if allowed[particular] ~= 1 then
        Msg2Player("P2 safety: wrong item for LUA-2073")
        return
    end
    Msg2Player("BLOCKED_SPEC LUA-2073/P2: VNG reward/effect is not verified; item was not consumed.")
end
