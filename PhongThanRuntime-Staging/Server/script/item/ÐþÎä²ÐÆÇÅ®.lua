g_name = "HuyÒn Vò Tµn Ph¸ch-N÷"
g_id = { 6, 1, 1285, 1 }
g_taskindex = 2

function main()
    if (HaveNormalItem(g_id[1], g_id[2], g_id[3], g_id[4]) <= 0) then
        return
    end
    if (GetTaskBit(2028, g_taskindex) > 0) then
        InfoBox("ÄúÒÑ¾­ÊÕ¼¯µ½ÁË<c=g>" .. g_name .. "<c>.")
        return
    end

    if (DelNormalItem(g_id[1], g_id[2], g_id[3], g_id[4]) > 0) then
        SetTaskBit(2028, g_taskindex, 1)
        WriteLog("ÊÕ¼¯µ½ " .. g_name)
        InfoBox("¹§Ï²ÄúÊÕ¼¯µ½ÁË<c=g>" .. g_name .. "<c>.")
        Msg2Player("¹§Ï²ÄúÊÕ¼¯µ½ÁË" .. g_name .. ".")
    end

end

function no()
    CloseDialog()
end
