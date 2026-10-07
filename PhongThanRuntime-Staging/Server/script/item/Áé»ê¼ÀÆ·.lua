require("¼ÀÔ¨¹È.luax")

function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    local tbl_Item = {}
    local tbl_Item_new = {
        [1] = { 800, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [2] = { 300, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [3] = { 800, { 8, 289, 2, 0, 0, 0 }, 1, "LÔ bao ChÝ T«n", 0, 1, },
        [4] = { 300, { 8, 289, 2, 0, 0, 0 }, 2, "LÔ bao ChÝ T«n", 0, 1, },
        [5] = { 500, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [6] = { 1570, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [7] = { 2400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [8] = { 1200, { 8, 191, 2, 0, 0, 0 }, 1, "TrÇm §iÖn", 0, 0, },
        [9] = { 100, { 8, 1775, 2, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 0, },
        [10] = { 2000, { 8, 33, 2, 0, 0, 0 }, 1, "Quan ¢m Thñy", 0, 0, },
        [11] = { 2200, { 8, 1345, 2, 0, 0, 0 }, 1, "HuyÒn S¾c Thñy Ng©n", 0, 0, },
        [12] = { 500, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 0, },
        [13] = { 20400, { 3, { 1045, 1046, 1047, 1048, 1049 }, 0, 0, 0, 0 }, 1, "Ngäc Tñy", 1, 0, },
        [14] = { 1400, { 3, { 1045, 1046, 1047, 1048, 1049 }, 0, 0, 0, 0 }, 5, "Ngäc Tñy", 1, 0, },
        [15] = { 5000, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [16] = { 2500, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [17] = { 300, { 3, 90, 0, 0, 0, 0 }, 1, "Hoµng b¶o th¹ch", 0, 1, },
        [18] = { 400, { 3, 1151, 0, 0, 0, 0 }, 1, "Tö B¶o Th¹ch", 0, 1, },
        [19] = { 13000, { 3, 88, 0, 0, 0, 0 }, 1, "M¶nh Hoµng thñy tinh", 0, 0, },
        [20] = { 10000, { 3, 1149, 0, 0, 0, 0 }, 1, "M¶nh Tö thuû tinh", 0, 0, },
        [21] = { 5095, { 8, 135, 2, 0, 0, 0 }, 1, "ChØ nh©n", 0, 0, },
        [22] = { 10000, { 8, 330, 0, 0, 0, 0 }, 1, "L©m Tiªn Lé", 0, 0, },
        [23] = { 6569, { 3, 41, 0, 0, 0, 0 }, 1, "Lam b¶o th¹ch", 0, 1, },

        [24] = { 200, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [25] = { 110, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
        [26] = { 70, { 8, 283, 2, 0, 0, 0 }, 1, "KhÝ Nguyªn (cao cÊp)", 0, 1, },
        [27] = { 8, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [28] = { 7, { 8, 372, 2, 0, 0, 0 }, 1, "KhÝ Tinh (cao cÊp)", 0, 1, },
        [29] = { 60, { 8, 1346, 2, 0, 0, 0 }, 1, "Tinh chÕ HuyÒn S¾c Thñy Ng©n", 0, 1, },
        [30] = { 90, { 8, 1504, 2, 0, 0, 0 }, 1, "Cöu Ngò ChÝ T«n-Cñu Tiªu Long Ng©m", 0, 1, },
        [31] = { 30, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [32] = { 30, { 8, 1016, 2, 0, 0, 0 }, 1, "Hån Tinh cao cÊp", 0, 1, },
        [33] = { 300, { 8, 1015, 2, 0, 0, 0 }, 1, "Hån Tinh trung cÊp", 0, 1, },
        [34] = { 10, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [35] = { 50, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 2, 1, },

        [36] = { 0, { 8, { 145, 146, 147, 1404 }, 2, 0, 0, 0 }, 1, "Linh Th¹ch V¹n Tiªn TrËn", 5, 0, },
        [37] = { 400, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 3, 1, },
        [38] = { 300, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 4, 1, },
        [39] = { 11000, { 8, { 119, 120, 121, 122 }, 2, 0, 0, 0 }, 1, "Mª Cung TruyÒn Tèng Phï", 1, 0, },
        [40] = { 1, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 6, 1, },
        [41] = { 0, { 3, 1220, 0, 0, 0, 0 }, 1, "HuyÒn Th¸i HuyÒn Tinh", 0, 1, },
        [42] = { 0, { 3, 1205, 0, 0, 0, 0 }, 1, "HuyÔn Th¸i Danh Ngäc (ch­a khai quang)", 0, 1, },
    }
    local tbl_Item_old = {
        [1] = { 800, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [2] = { 300, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [3] = { 800, { 8, 289, 2, 0, 0, 0 }, 1, "LÔ bao ChÝ T«n", 0, 1, },
        [4] = { 300, { 8, 289, 2, 0, 0, 0 }, 2, "LÔ bao ChÝ T«n", 0, 1, },
        [5] = { 472, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [6] = { 1570, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [7] = { 2400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [8] = { 2020, { 8, 191, 2, 0, 0, 0 }, 1, "TrÇm §iÖn", 0, 0, },
        [9] = { 100, { 8, 1775, 2, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 0, },
        [10] = { 2000, { 8, 33, 2, 0, 0, 0 }, 1, "Quan ¢m Thñy", 0, 0, },
        [11] = { 2000, { 8, 1345, 2, 0, 0, 0 }, 1, "HuyÒn S¾c Thñy Ng©n", 0, 0, },
        [12] = { 500, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 0, },
        [13] = { 20400, { 3, { 1045, 1046, 1047, 1048, 1049 }, 0, 0, 0, 0 }, 1, "Ngäc Tñy", 1, 0, },
        [14] = { 1400, { 3, { 1045, 1046, 1047, 1048, 1049 }, 0, 0, 0, 0 }, 5, "Ngäc Tñy", 1, 0, },
        [15] = { 5000, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [16] = { 2500, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [17] = { 300, { 3, 90, 0, 0, 0, 0 }, 1, "Hoµng b¶o th¹ch", 0, 1, },
        [18] = { 400, { 3, 1151, 0, 0, 0, 0 }, 1, "Tö B¶o Th¹ch", 0, 1, },
        [19] = { 12000, { 3, 88, 0, 0, 0, 0 }, 1, "M¶nh Hoµng thñy tinh", 0, 0, },
        [20] = { 10000, { 3, 1149, 0, 0, 0, 0 }, 1, "M¶nh Tö thuû tinh", 0, 0, },
        [21] = { 5000, { 8, 135, 2, 0, 0, 0 }, 1, "ChØ nh©n", 0, 0, },
        [22] = { 10166, { 8, 330, 0, 0, 0, 0 }, 1, "L©m Tiªn Lé", 0, 0, },
        [23] = { 6378, { 3, 41, 0, 0, 0, 0 }, 1, "Lam b¶o th¹ch", 0, 1, },

        [24] = { 100, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [25] = { 80, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
        [26] = { 60, { 8, 283, 2, 0, 0, 0 }, 1, "KhÝ Nguyªn (cao cÊp)", 0, 1, },
        [27] = { 9, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [28] = { 7, { 8, 372, 2, 0, 0, 0 }, 1, "KhÝ Tinh (cao cÊp)", 0, 1, },
        [29] = { 40, { 8, 1346, 2, 0, 0, 0 }, 1, "Tinh chÕ HuyÒn S¾c Thñy Ng©n", 0, 1, },
        [30] = { 120, { 8, 1504, 2, 0, 0, 0 }, 1, "Cöu Ngò ChÝ T«n-Cñu Tiªu Long Ng©m", 0, 1, },
        [31] = { 30, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [32] = { 15, { 8, 1016, 2, 0, 0, 0 }, 1, "Hån Tinh cao cÊp", 0, 1, },
        [33] = { 300, { 8, 1015, 2, 0, 0, 0 }, 1, "Hån Tinh trung cÊp", 0, 1, },
        [34] = { 8, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [35] = { 40, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 2, 1, },

        [36] = { 0, { 8, { 145, 146, 147, 1404 }, 2, 0, 0, 0 }, 1, "Linh Th¹ch V¹n Tiªn TrËn", 5, 0, },
        [37] = { 600, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 3, 1, },
        [38] = { 600, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 4, 1, },
        [39] = { 11000, { 8, { 119, 120, 121, 122 }, 2, 0, 0, 0 }, 1, "Mª Cung TruyÒn Tèng Phï", 1, 0, },
        [40] = { 5, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 6, 1, },
        [41] = { 80, { 3, 1220, 0, 0, 0, 0 }, 1, "HuyÒn Th¸i HuyÒn Tinh", 0, 1, },
        [42] = { 100, { 3, 1205, 0, 0, 0, 0 }, 1, "HuyÔn Th¸i Danh Ngäc (ch­a khai quang)", 0, 1, },
    }
    tbl_Item = tbl_Item_old
    if (JIYUANGU.IsUseNewRandom() == 1) then
        tbl_Item = tbl_Item_new
    end
    DelItemByID(itemID)

    local strFlag = ""
    local nRnd = RndProbabilityTable(tbl_Item)
    if ((nRnd == 15 or nRnd == 16 or nRnd == 34) and (GetWorldEventProgress(1) < 6)) then
        if (nRnd == 34) then
            nRnd = 37
        elseif (nRnd == 16) then
            nRnd = 11
        elseif (nRnd == 15) then
            nRnd = 22
        end
    end

    if (nRnd >= 1 and nRnd <= table.getn(tbl_Item)) then
        local nItem = tbl_Item[nRnd][2]
        local nItemName = tbl_Item[nRnd][4]
        local nKind = tbl_Item[nRnd][5]
        if (nKind == 1) then
            local nIdx = math.random(1, table.getn(nItem[2]))
            for i = 1, tbl_Item[nRnd][3] do
                AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
            end
        elseif (nKind == 2) then
            local name_list = { "XÝch Viªm Ngäc Tinh (ch­a mµi)", "Thanh Minh Ngäc Tinh (ch­a mµi)", "Tö Hµ Ngäc Tinh (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
        elseif (nKind == 3) then
            local name_list = { "XÝch Viªm Danh Ngäc (ch­a mµi)", "Thanh Minh Danh Ngäc (ch­a mµi)", "Tö Hµ Danh Ngäc (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
        elseif (nKind == 4) then
            local nPlayer = GetPlayerType()
            local nIdx = math.random(0, 4)
            local nItem2 = 278 + nPlayer + nIdx * 3
            AddNormalItemPile(nItem[1], nItem[2], nItem2, nItem[4], nItem[5], nItem[6])
        elseif (nKind == 5) then
            local nLevel = GetLevel()
            local nIdx = 1
            if (nLevel <= 70) then
                nIdx = 1
            elseif (nLevel <= 90) then
                nIdx = 2
            elseif (nLevel <= 120) then
                nIdx = 3
            else
                nIdx = 4
            end
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem2, nItem[4], nItem[5], nItem[6])
        elseif (nKind == 6) then
            local name_list = { "XÝch Viªm Ngäc T©m (ch­a mµi)", "Thanh Minh Ngäc T©m (ch­a mµi)", "Tö Hµ Ngäc T©m (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
        else
            for i = 1, tbl_Item[nRnd][3] do
                AddNormalItemPile(nItem[1], nItem[2], nItem[3], nItem[4], nItem[5], nItem[6])
            end
        end
        if (tbl_Item[nRnd][6] == 1) then
            Msg2CurMapAnnounce("<c=g>Linh Hån trong TÕ Uyªn Cèc <c> cã t×nh c¶m víi <RoleName=\"" .. GetName() .. "\"><c> ®Òn ¬n gi¶i cøu, ban tÆng cho ng­êi ®ã trong <c=g>Linh Hån TÕ PhÈm <c>" .. tbl_Item[nRnd][3] .. " <c=yel>" .. nItemName .. "<c>.")
            AddGlobalNews("<c=g>Linh Hån trong TÕ Uyªn Cèc <c> cã t×nh c¶m víi <RoleName=\"" .. GetName() .. "\"><c> ®Òn ¬n gi¶i cøu, ban tÆng cho ng­êi ®ã trong <c=g>Linh Hån TÕ PhÈm <c>" .. tbl_Item[nRnd][3] .. " <c=yel>" .. nItemName .. "<c>.")
        end
        if (nRnd >= 24 and nRnd <= 35) or (nRnd >= 40 and nRnd <= 42) then
            strFlag = "PhÇn th­ëng lín"
        end

        logStr = tbl_Item[nRnd][3] .. "." .. nItemName
    end
    Msg2Player("Më Linh Hån TÕ PhÈm nhËn ®­îc " .. logStr .. ".")
    WriteLog("Linh Hån TÕ PhÈm: nhËn ®­îc " .. strFlag .. logStr)
end

function RndProbabilityTable(t)
    if type(t) == "table" then
        local count = table.getn(t)
        local sum = 0
        local rnd = math.random(1, 100000)
        for i = 1, count do
            local probability = t[i][1]
            sum = sum + probability
            if rnd <= sum then
                return i
            end
        end
        return count
    else
        return nil
    end
end
