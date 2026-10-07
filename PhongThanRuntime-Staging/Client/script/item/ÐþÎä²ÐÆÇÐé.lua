g_name = "Huy“n VÚ Tµn Ph∏ch-H≠"
g_id = { 6, 1, 1286, 1 }
g_taskindex = 3

function main()
    if (HaveNormalItem(g_id[1], g_id[2], g_id[3], g_id[4]) <= 0) then
        return
    end
    if (GetTaskBit(2028, g_taskindex) > 0) then
        InfoBox("ƒ˙“—æ≠ ’ºØµΩ¡À<c=g>" .. g_name .. "<c>.")
        return
    end

    if (DelNormalItem(g_id[1], g_id[2], g_id[3], g_id[4]) > 0) then
        SetTaskBit(2028, g_taskindex, 1)
        WriteLog(" ’ºØµΩ " .. g_name)
        InfoBox("πßœ≤ƒ˙ ’ºØµΩ¡À<c=g>" .. g_name .. "<c>.")
        Msg2Player("πßœ≤ƒ˙ ’ºØµΩ¡À" .. g_name .. ".")
    end

end

function no()
    CloseDialog()
end
