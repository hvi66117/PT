g_Item = {
    [1] = { 6, 1, 749, 0, "Hång Nh¹n Tèng Phóc" },
    [2] = { 6, 1, 816, 1, "Hoa lµi" },
    [3] = { 6, 1, 814, 1, "Quµ T×nh Yªu" },
    [4] = { 6, 1, 817, 1, "Hoa Hång" },
    [5] = { 8, 1284, 3, 0, "Yªn Hång Hoa MËt" },
    [6] = { 8, 1285, 3, 0, "Minh Lam Hoa MËt" },
    [7] = { 8, 1286, 3, 0, "XÝch DiÖm Tiªn Lé" },
    [8] = { 8, 1287, 3, 0, "L¨ng B¨ng Tiªn Lé" },
    [9] = { 6, 1, 815, 1, "L¨ng Tiªu Hoa" },
    [10] = { 3, 89, 0, 0, "Hoµng thñy tinh" },
}

function main()
    local nTarget = GetPlayerTarget()
    local idx2 = NpcIdx2PIdx(nTarget)

    if (IsPlayer(nTarget) == 1) and (idx2 ~= PlayerIndex) then
        local nOldPlayer = PlayerIndex

        PlayerIndex = idx2
        local nSex = GetSex()
        local szName = GetName()

        PlayerIndex = nOldPlayer

        if (nSex == 0) then
            Talk(1, "no", "Hoa lµi ph¶i tÆng cho mü n÷ míi thÝch hîp!")
            return
        end

        DelNormalItem(g_Item[2][1], g_Item[2][2], g_Item[2][3], g_Item[2][4])
        Msg2CurMapAnnounce(GetName() .. " nãi víi " .. szName .. "Trong m¾t anh em lµ v× sao s¸ng nhÊt ®ªm nay!")
    else
        Talk(1, "no", "Xin chän mü n÷ ®Ó chóc phóc!")
    end
end

function no()
    CloseDialog()
end
