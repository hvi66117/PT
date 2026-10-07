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
    DelNormalItem(g_Item[9][1], g_Item[9][2], g_Item[9][3], g_Item[9][4])
    local nExp = GetLevel() * 1500
    AddOwnExp(nExp)
    Msg2Player("NhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
end
