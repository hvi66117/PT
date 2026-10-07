Global_Woman_Day = 624
Global_Woman_Day_Num = 625
g_Item = {
    [1] = { 6, 1, 749, 0, "Hång Nh¹n Tèng Phóc" },
    [2] = { 6, 1, 816, 1, "Hoa lµi" },
    [3] = { 6, 1, 814, 1, "Quµ T×nh Yªu" },
    [4] = { 6, 1, 817, 1, "Hoa Hång" },
    [5] = { 8, 1284, 3, 0, "Yªn Hång Hoa MËt" },
    [6] = { 8, 1285, 3, 0, "Minh Lam Hoa MËt" },
    [7] = { 8, 1027, 2, 0, "Thiªn Tiªn Qu¶" },
    [8] = { 3, 1149, 0, 0, "M¶nh Tö thuû tinh" },
    [9] = { 6, 1, 815, 1, "L¨ng Tiªu Hoa" },
    [10] = { 3, 89, 0, 0, "Hoµng thñy tinh" },
}

function main()
    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        InfoBox("ë TriÒu Ca míi cã thÓ më Quµ T×nh Yªu")
        return 0
    end
    DelNormalItem(g_Item[3][1], g_Item[3][2], g_Item[3][3], g_Item[3][4])

    local nRand = math.random(1, 100)
    local szItemName = ""

    if (nRand <= 14) then
        AddNormalItem(g_Item[5][1], g_Item[5][2], g_Item[5][3], g_Item[5][4], 0, 0)
        szItemName = g_Item[5][5]

    elseif (nRand <= 29) then
        AddNormalItem(g_Item[6][1], g_Item[6][2], g_Item[6][3], g_Item[6][4], 0, 0)
        szItemName = g_Item[6][5]

    elseif (nRand <= 39) then
        AddNormalItem(g_Item[7][1], g_Item[7][2], g_Item[7][3], g_Item[7][4], 0, 0)
        szItemName = g_Item[7][5]

    elseif (nRand <= 49) then
        local today = math.floor(LocalSystemTime() / 86400)
        local lastday = GetGlobalValue(Global_Woman_Day)

        if (today ~= lastday) then
            SetGlobalValue(Global_Woman_Day, today)
            SetGlobalValue(Global_Woman_Day_Num, 0)
        end

        local nNum = GetGlobalValue(Global_Woman_Day_Num)
        if (nNum < 20) then
            nNum = nNum + 1

            SetGlobalValue(Global_Woman_Day_Num, nNum)
            AddNormalItem(g_Item[8][1], g_Item[8][2], g_Item[8][3], g_Item[8][4], 0, 0)
            szItemName = g_Item[8][5]
        else
            AddNormalItem(g_Item[9][1], g_Item[9][2], g_Item[9][3], g_Item[9][4], 0, 0)
            szItemName = g_Item[9][5]
        end

    elseif (nRand <= 99) then
        AddNormalItem(g_Item[9][1], g_Item[9][2], g_Item[9][3], g_Item[9][4], 0, 0)
        szItemName = g_Item[9][5]
    else
        AddNormalItem(g_Item[10][1], g_Item[10][2], g_Item[10][3], g_Item[10][4], 0, 0)
        szItemName = g_Item[10][5]
    end

    TopMessage("NhËn ®­îc " .. szItemName)
    Msg2Player("NhËn ®­îc " .. szItemName)
    WriteLog(GetName() .. " nhËn ®­îc " .. szItemName)
end
