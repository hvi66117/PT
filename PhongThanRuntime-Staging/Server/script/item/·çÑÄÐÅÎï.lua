Task_ItemNum = 1853
Task_KillItemNum = 1864

g_BigTotalNum = 2
g_SuccessionNum = 5
g_DressNum = 5

require("¼ÀÔ¨¹È.luax")

function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    local logStr = ""

    DelItemByID(itemID)

    local nRnd1 = math.random(1, 1000)
    local nTotalFaBaoNum = 0
    if (nRnd1 <= 50) then
        logStr = logStr .. "1 m¶nh Ph¸p B¶o, "
        nTotalFaBaoNum = 1
    elseif (nRnd1 <= 85) then
        logStr = logStr .. "2 m¶nh Ph¸p B¶o, "
        nTotalFaBaoNum = 2
    elseif (nRnd1 <= 110) then
        logStr = logStr .. "3 m¶nh Ph¸p B¶o, "
        nTotalFaBaoNum = 3
    end
    if (nTotalFaBaoNum > 0) then
        for i = 1, nTotalFaBaoNum do
            AddNormalItemBind(6, 1, 1074, 1, 0, 0, 0)
        end
    end

    local tbl_Item2 = {
        { 700, { 3, 115, 0, 0, 0, 0 }, 1, "Tø T­îng Tinh Hoa", 0, },
        { 200, { 3, 115, 0, 0, 0, 0 }, 2, "Tø T­îng Tinh Hoa", 0, },
        { 20, { 3, 115, 0, 0, 0, 0 }, 5, "Tø T­îng Tinh Hoa", 0, },
        { 1300, { 3, 114, 0, 0, 0, 0 }, 1, "Lôc §¹o Tinh Hoa", 0, },
        { 400, { 3, 114, 0, 0, 0, 0 }, 2, "Lôc §¹o Tinh Hoa", 0, },
        { 10, { 3, 114, 0, 0, 0, 0 }, 5, "Lôc §¹o Tinh Hoa", 0, },
        { 950, { 6, 1, 587, 1, 0, 0 }, 1, "Thiªn Linh Th¹ch", 0, },
        { 200, { 6, 1, 587, 1, 0, 0 }, 2, "Thiªn Linh Th¹ch", 0, },
        { 10, { 6, 1, 587, 1, 0, 0 }, 5, "Thiªn Linh Th¹ch", 0, },
        { 750, { 1, 2, 0, 0, 0, 0 }, 1, "§¹i Hång ®¬n", 0, },
        { 300, { 1, 2, 0, 0, 0, 0 }, 2, "§¹i Hång ®¬n", 0, },
        { 200, { 1, 2, 0, 0, 0, 0 }, 5, "§¹i Hång ®¬n", 0, },
        { 2900, { 6, 1, 941, 1, 0, 0 }, 2, "M¶nh trang bÞ tr¾ng", 0, },
        { 1030, { 6, 1, 941, 1, 0, 0 }, 5, "M¶nh trang bÞ tr¾ng", 0, },
        { 250, { 6, 1, 941, 1, 0, 0 }, 10, "M¶nh trang bÞ tr¾ng", 0, },
        { 0, { 3, 116, 0, 0, 0, 0 }, 1, "§¹i ®Þa nh·n", 0, },
        { 0, { 3, 117, 0, 0, 0, 0 }, 1, "Hoµn Quan nh·n", 0, },
        { 0, { 3, 118, 0, 0, 0, 0 }, 1, "LiÖt DiÖm nh·n", 0, },
        { 0, { 3, 119, 0, 0, 0, 0 }, 1, "Phong B¹o nh·n", 0, },
        { 700, { 3, { 253, 260, 267 }, 0, 0, 0, 0 }, 1, "To¸i ngäc", 1, },
        { 80, { 3, { 253, 260, 267 }, 0, 0, 0, 0 }, 5, "To¸i ngäc", 1, },
    }
    local strIdx = 0
    local strStr = ""
    for i = 1, 2 do
        local nRnd2 = RndProbabilityTable(tbl_Item2)
        if (nRnd2 >= 1 and nRnd2 <= table.getn(tbl_Item2)) then
            local nKind = tbl_Item2[nRnd2][5]
            if (nKind == 1) then
                local nItem = tbl_Item2[nRnd2][2]
                local nIdx = math.random(1, table.getn(nItem[2]))
                for i = 1, tbl_Item2[nRnd2][3] do
                    AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
                end
            else
                local nItem = tbl_Item2[nRnd2][2]
                for j = 1, tbl_Item2[nRnd2][3] do
                    AddNormalItemPile(nItem[1], nItem[2], nItem[3], nItem[4], nItem[5], nItem[6])
                end
            end
            if (i == 1) then
                strIdx = nRnd2
                strStr = tbl_Item2[nRnd2][3] .. "." .. tbl_Item2[nRnd2][4] .. ","
            elseif (i == 2) then
                if (nRnd2 == strIdx) then
                    strStr = (tbl_Item2[nRnd2][3] + tbl_Item2[strIdx][3]) .. "." .. tbl_Item2[nRnd2][4]
                else
                    strStr = strStr .. tbl_Item2[nRnd2][3] .. "." .. tbl_Item2[nRnd2][4]
                end
            end
        end
    end
    logStr = logStr .. strStr

    for i = 1, 4 do
        local nRnd4 = math.random(1, 100)
        if (nRnd4 <= 90) then
            AddNormalItemPile(3, 1182, 0, 0, 0, 0)
        else
            AddNormalItemPile(3, 1183, 0, 0, 0, 0)
        end
    end

    local tbl_Item3 = {}
    local tbl_Item31 = {}

    local tbl_Item3_old = {
        [1] = { 2500, { 3, 100, 0, 0, 0, 0 }, 1, "T­íng Qu©n LÖnh", 0, 1, },
        [2] = { 200, { 3, 100, 0, 0, 0, 0 }, 5, "T­íng Qu©n LÖnh", 0, 1, },
        [3] = { 50, { 3, 100, 0, 0, 0, 0 }, 10, "T­íng Qu©n LÖnh", 0, 1, },
        [4] = { 400, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [5] = { 100, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [6] = { 1420, { 3, 46, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 10", 0, 0, },
        [7] = { 357, { 3, 48, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 12", 0, 0, },
        [8] = { 5040, { 3, 138, 0, 0, 0, 0 }, 1, "ThiÖp nh­ ý", 0, 0, },
        [9] = { 400, { 3, 138, 0, 0, 0, 0 }, 10, "ThiÖp nh­ ý", 0, 1, },
        [10] = { 40, { 3, 138, 0, 0, 0, 0 }, 100, "ThiÖp nh­ ý", 0, 1, },
        [11] = { 500, { 8, 1454, 2, 0, 0, 0 }, 1, "Tói Nh­ ý", 0, 0, },
        [12] = { 200, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 1, },
        [13] = { 10, { 8, 1454, 2, 0, 0, 0 }, 50, "Tói Nh­ ý", 0, 1, },
        [14] = { 400, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [15] = { 50, { 8, 1775, 2, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 1, },
        [16] = { 18, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 5, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [17] = { 400, { 3, 1183, 0, 0, 0, 0 }, 100, " Th«ng B¶o", 0, 1, },
        [18] = { 100, { 3, 1183, 0, 0, 0, 0 }, 200, " Th«ng B¶o", 0, 1, },
        [19] = { 200, { 8, 1412, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [20] = { 800, { 8, 1411, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [21] = { 1000, { 8, 1410, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [22] = { 100, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [23] = { 200, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [24] = { 400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [25] = { 10, { 8, 1412, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [26] = { 20, { 8, 1411, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [27] = { 40, { 8, 1410, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [28] = { 10, { 8, 1499, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [29] = { 20, { 8, 1498, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [30] = { 40, { 8, 1497, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [31] = { 900, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [32] = { 1600, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [33] = { 550, { 3, 555, 0, 0, 0, 0 }, 1, "Néi §¬n (trung)", 0, 0, },
        [34] = { 250, { 8, 1567, 2, 0, 0, 0 }, 1, "»ðÉñ½µÁÙ¡¤ÁÇÈÕÁèÔÆ", 0, 1, },
        [35] = { 250, { 8, 1569, 2, 0, 0, 0 }, 1, "½ðÖÓ»¤Ìå¡¤ÓÎÁú½ð·ï", 0, 1, },
        [36] = { 500, { 8, { 1505, 1506 }, 0, 0, 0, 0 }, 1, "Trang bÞ ThuÇn Xu©n Lé trang", 2, 1, },
        [37] = { 80, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [38] = { 150, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 3, 1, },
        [39] = { 100, { 6, 1, 587, 1, 0, 0 }, 50, "Thiªn Linh Th¹ch", 0, 1, },
        [40] = { 500, { 6, 1, 1048, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: Tham Lan T¸n", 0, 1, },
        [41] = { 250, { 6, 1, 1049, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: ThÊt Tinh ThÇn §an", 0, 1, },
        [42] = { 250, { 6, 1, 1050, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Kim Ti Thiªu M¹ch", 0, 1, },
        [43] = { 250, { 6, 1, 1051, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Uyªn ¦¬ng H­¬ng T« L¹c", 0, 1, },
        [44] = { 35, { 3, 374, 0, 0, 0, 0 }, 1, "Vi Quang Qu¸i Phï (ch­a mµi)", 0, 1, },
        [45] = { 1000, { 6, 1, 1062, 1, 0, 0 }, 1, "Kinh nghiÖm ®¬n", 0, 1, },
        [46] = { 1800, { 8, 1681, 2, 0, 0, 0 }, 1, "ViÔn Cæ Tiªn Th¶o", 0, 1, },
        [47] = { 1300, { 8, 1682, 2, 0, 0, 0 }, 1, "Nguyªn Linh Ngäc Lé", 0, 1, },

        [48] = { 8, { 3, 100, 0, 0, 0, 0 }, 50, "T­íng Qu©n LÖnh", 0, 1, },
        [49] = { 70, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 1, 1, },
        [50] = { 8, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [51] = { 20, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 5, 1, },
        [52] = { 55, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [53] = { 9, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [54] = { 40, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
    }
    local tbl_Item31_old = {
        [1] = { 2500, { 3, 100, 0, 0, 0, 0 }, 1, "T­íng Qu©n LÖnh", 0, 1, },
        [2] = { 200, { 3, 100, 0, 0, 0, 0 }, 5, "T­íng Qu©n LÖnh", 0, 1, },
        [3] = { 50, { 3, 100, 0, 0, 0, 0 }, 10, "T­íng Qu©n LÖnh", 0, 1, },
        [4] = { 400, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [5] = { 100, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [6] = { 1420, { 3, 46, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 10", 0, 0, },
        [7] = { 357, { 3, 48, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 12", 0, 0, },
        [8] = { 5040, { 3, 138, 0, 0, 0, 0 }, 1, "ThiÖp nh­ ý", 0, 0, },
        [9] = { 400, { 3, 138, 0, 0, 0, 0 }, 10, "ThiÖp nh­ ý", 0, 1, },
        [10] = { 40, { 3, 138, 0, 0, 0, 0 }, 100, "ThiÖp nh­ ý", 0, 1, },
        [11] = { 500, { 8, 1454, 2, 0, 0, 0 }, 1, "Tói Nh­ ý", 0, 0, },
        [12] = { 200, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 1, },
        [13] = { 10, { 8, 1454, 2, 0, 0, 0 }, 50, "Tói Nh­ ý", 0, 1, },
        [14] = { 400, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [15] = { 50, { 8, 1775, 2, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 1, },
        [16] = { 18, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 5, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [17] = { 400, { 3, 1183, 0, 0, 0, 0 }, 100, " Th«ng B¶o", 0, 1, },
        [18] = { 100, { 3, 1183, 0, 0, 0, 0 }, 200, " Th«ng B¶o", 0, 1, },
        [19] = { 200, { 8, 1412, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [20] = { 800, { 8, 1411, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [21] = { 1000, { 8, 1410, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [22] = { 100, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [23] = { 200, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [24] = { 400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [25] = { 10, { 8, 1412, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [26] = { 20, { 8, 1411, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [27] = { 40, { 8, 1410, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [28] = { 10, { 8, 1499, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [29] = { 20, { 8, 1498, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [30] = { 40, { 8, 1497, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [31] = { 900, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [32] = { 1600, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [33] = { 550, { 3, 555, 0, 0, 0, 0 }, 1, "Néi §¬n (trung)", 0, 0, },
        [34] = { 250, { 8, 1567, 2, 0, 0, 0 }, 1, "»ðÉñ½µÁÙ¡¤ÁÇÈÕÁèÔÆ", 0, 1, },
        [35] = { 250, { 8, 1569, 2, 0, 0, 0 }, 1, "½ðÖÓ»¤Ìå¡¤ÓÎÁú½ð·ï", 0, 1, },
        [36] = { 500, { 8, { 1505, 1506 }, 0, 0, 0, 0 }, 1, "Trang bÞ ThuÇn Xu©n Lé trang", 2, 1, },
        [37] = { 80, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [38] = { 150, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 3, 1, },
        [39] = { 100, { 6, 1, 587, 1, 0, 0 }, 50, "Thiªn Linh Th¹ch", 0, 1, },
        [40] = { 500, { 6, 1, 1048, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: Tham Lan T¸n", 0, 1, },
        [41] = { 250, { 6, 1, 1049, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: ThÊt Tinh ThÇn §an", 0, 1, },
        [42] = { 250, { 6, 1, 1050, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Kim Ti Thiªu M¹ch", 0, 1, },
        [43] = { 250, { 6, 1, 1051, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Uyªn ¦¬ng H­¬ng T« L¹c", 0, 1, },
        [44] = { 54, { 3, 374, 0, 0, 0, 0 }, 1, "Vi Quang Qu¸i Phï (ch­a mµi)", 0, 1, },
        [45] = { 1000, { 6, 1, 1062, 1, 0, 0 }, 1, "Kinh nghiÖm ®¬n", 0, 1, },
        [46] = { 1800, { 8, 1681, 2, 0, 0, 0 }, 1, "ViÔn Cæ Tiªn Th¶o", 0, 1, },
        [47] = { 1300, { 8, 1682, 2, 0, 0, 0 }, 1, "Nguyªn Linh Ngäc Lé", 0, 1, },

        [48] = { 8, { 3, 100, 0, 0, 0, 0 }, 50, "T­íng Qu©n LÖnh", 0, 1, },
        [49] = { 70, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 1, 1, },
        [50] = { 8, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [51] = { 20, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 5, 1, },
        [52] = { 50, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [53] = { 10, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [54] = { 40, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
    }
    local tbl_Item3_new = {
        [1] = { 2500, { 3, 100, 0, 0, 0, 0 }, 1, "T­íng Qu©n LÖnh", 0, 1, },
        [2] = { 200, { 3, 100, 0, 0, 0, 0 }, 5, "T­íng Qu©n LÖnh", 0, 1, },
        [3] = { 50, { 3, 100, 0, 0, 0, 0 }, 10, "T­íng Qu©n LÖnh", 0, 1, },
        [4] = { 400, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [5] = { 100, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [6] = { 1420, { 3, 46, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 10", 0, 0, },
        [7] = { 357, { 3, 48, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 12", 0, 0, },
        [8] = { 5040, { 3, 138, 0, 0, 0, 0 }, 1, "ThiÖp nh­ ý", 0, 0, },
        [9] = { 400, { 3, 138, 0, 0, 0, 0 }, 10, "ThiÖp nh­ ý", 0, 1, },
        [10] = { 40, { 3, 138, 0, 0, 0, 0 }, 100, "ThiÖp nh­ ý", 0, 1, },
        [11] = { 1000, { 8, 1454, 2, 0, 0, 0 }, 1, "Tói Nh­ ý", 0, 0, },
        [12] = { 200, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 1, },
        [13] = { 10, { 8, 1454, 2, 0, 0, 0 }, 50, "Tói Nh­ ý", 0, 1, },
        [14] = { 220, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [15] = { 30, { 8, 1775, 0, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 1, },
        [16] = { 8, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 5, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [17] = { 400, { 3, 1183, 0, 0, 0, 0 }, 100, " Th«ng B¶o", 0, 1, },
        [18] = { 100, { 3, 1183, 0, 0, 0, 0 }, 200, " Th«ng B¶o", 0, 1, },
        [19] = { 200, { 8, 1412, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [20] = { 800, { 8, 1411, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [21] = { 1000, { 8, 1410, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [22] = { 100, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [23] = { 200, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [24] = { 400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [25] = { 10, { 8, 1412, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [26] = { 20, { 8, 1411, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [27] = { 40, { 8, 1410, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [28] = { 10, { 8, 1499, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [29] = { 20, { 8, 1498, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [30] = { 40, { 8, 1497, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [31] = { 2130, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [32] = { 2500, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [33] = { 800, { 3, 555, 0, 0, 0, 0 }, 1, "Néi §¬n (trung)", 0, 0, },
        [34] = { 250, { 8, 1567, 2, 0, 0, 0 }, 1, "»ðÉñ½µÁÙ¡¤ÁÇÈÕÁèÔÆ", 0, 1, },
        [35] = { 250, { 8, 1569, 2, 0, 0, 0 }, 1, "½ðÖÓ»¤Ìå¡¤ÓÎÁú½ð·ï", 0, 1, },
        [36] = { 500, { 8, { 1505, 1506 }, 0, 0, 0, 0 }, 1, "Trang bÞ ThuÇn Xu©n Lé trang", 2, 1, },
        [37] = { 20, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [38] = { 80, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 3, 1, },
        [39] = { 100, { 6, 1, 587, 1, 0, 0 }, 50, "Thiªn Linh Th¹ch", 0, 1, },
        [40] = { 600, { 6, 1, 1048, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: Tham Lan T¸n", 0, 1, },
        [41] = { 350, { 6, 1, 1049, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: ThÊt Tinh ThÇn §an", 0, 1, },
        [42] = { 350, { 6, 1, 1050, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Kim Ti Thiªu M¹ch", 0, 1, },
        [43] = { 350, { 6, 1, 1051, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Uyªn ¦¬ng H­¬ng T« L¹c", 0, 1, },
        [44] = { 50, { 3, 374, 0, 0, 0, 0 }, 1, "Vi Quang Qu¸i Phï (ch­a mµi)", 0, 1, },
        [45] = { 1200, { 6, 1, 1062, 1, 0, 0 }, 1, "Kinh nghiÖm ®¬n", 0, 1, },
        [46] = { 0, { 8, 1681, 2, 0, 0, 0 }, 1, "ViÔn Cæ Tiªn Th¶o", 0, 1, },
        [47] = { 0, { 8, 1682, 2, 0, 0, 0 }, 1, "Nguyªn Linh Ngäc Lé", 0, 1, },

        [48] = { 8, { 3, 100, 0, 0, 0, 0 }, 50, "T­íng Qu©n LÖnh", 0, 1, },
        [49] = { 40, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 1, 1, },
        [50] = { 8, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [51] = { 10, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 5, 1, },
        [52] = { 40, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [53] = { 9, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [54] = { 40, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
    }
    local tbl_Item31_new = {
        [1] = { 2500, { 3, 100, 0, 0, 0, 0 }, 1, "T­íng Qu©n LÖnh", 0, 1, },
        [2] = { 200, { 3, 100, 0, 0, 0, 0 }, 5, "T­íng Qu©n LÖnh", 0, 1, },
        [3] = { 50, { 3, 100, 0, 0, 0, 0 }, 10, "T­íng Qu©n LÖnh", 0, 1, },
        [4] = { 400, { 8, 509, 2, 0, 0, 0 }, 1, "Di Quang kÝnh", 0, 1, },
        [5] = { 100, { 8, 509, 2, 0, 0, 0 }, 2, "Di Quang kÝnh", 0, 1, },
        [6] = { 1420, { 3, 46, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 10", 0, 0, },
        [7] = { 357, { 3, 48, 0, 0, 0, 0 }, 1, "B¸ L¹c Nh·n cÊp 12", 0, 0, },
        [8] = { 5040, { 3, 138, 0, 0, 0, 0 }, 1, "ThiÖp nh­ ý", 0, 0, },
        [9] = { 400, { 3, 138, 0, 0, 0, 0 }, 10, "ThiÖp nh­ ý", 0, 1, },
        [10] = { 40, { 3, 138, 0, 0, 0, 0 }, 100, "ThiÖp nh­ ý", 0, 1, },
        [11] = { 1000, { 8, 1454, 2, 0, 0, 0 }, 1, "Tói Nh­ ý", 0, 0, },
        [12] = { 200, { 8, 1775, 2, 0, 0, 0 }, 1, "LÔ hép Phï Th¹ch", 0, 1, },
        [13] = { 10, { 8, 1454, 2, 0, 0, 0 }, 50, "Tói Nh­ ý", 0, 1, },
        [14] = { 220, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 1, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [15] = { 30, { 8, 1775, 0, 0, 0, 0 }, 5, "LÔ hép Phï Th¹ch", 0, 1, },
        [16] = { 8, { 3, { 256, 263, 270 }, 0, 0, 0, 0 }, 5, "Danh Ngäc (ngÉu nhiªn)", 4, 1, },
        [17] = { 400, { 3, 1183, 0, 0, 0, 0 }, 100, " Th«ng B¶o", 0, 1, },
        [18] = { 100, { 3, 1183, 0, 0, 0, 0 }, 200, " Th«ng B¶o", 0, 1, },
        [19] = { 200, { 8, 1412, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [20] = { 800, { 8, 1411, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [21] = { 1000, { 8, 1410, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [22] = { 100, { 8, 1499, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [23] = { 200, { 8, 1498, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [24] = { 400, { 8, 1497, 2, 0, 0, 0 }, 1, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [25] = { 10, { 8, 1412, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 1", 0, 1, },
        [26] = { 20, { 8, 1411, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 1", 0, 1, },
        [27] = { 40, { 8, 1410, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 1", 0, 1, },
        [28] = { 10, { 8, 1499, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó cao-cÊp 2", 0, 1, },
        [29] = { 20, { 8, 1498, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó trung-cÊp 2", 0, 1, },
        [30] = { 40, { 8, 1497, 2, 0, 0, 0 }, 2, "Tói quµ Hån Chó s¬-cÊp 2", 0, 1, },
        [31] = { 2130, { 6, 1, 987, 1, 0, 0 }, 1, "M¶nh B¸ L¹c Tinh Kim", 0, 1, },
        [32] = { 2500, { 6, 1, 959, 1, 0, 0 }, 1, "M¶nh Ph¸p B¶o Tiªn Ma", 0, 0, },
        [33] = { 800, { 3, 555, 0, 0, 0, 0 }, 1, "Néi §¬n (trung)", 0, 0, },
        [34] = { 250, { 8, 1567, 2, 0, 0, 0 }, 1, "»ðÉñ½µÁÙ¡¤ÁÇÈÕÁèÔÆ", 0, 1, },
        [35] = { 250, { 8, 1569, 2, 0, 0, 0 }, 1, "½ðÖÓ»¤Ìå¡¤ÓÎÁú½ð·ï", 0, 1, },
        [36] = { 500, { 8, { 1505, 1506 }, 0, 0, 0, 0 }, 1, "Trang bÞ ThuÇn Xu©n Lé trang", 2, 1, },
        [37] = { 20, { 8, 1456, 2, 0, 0, 0 }, 1, "LÔ bao §å phæ Ph¸ Qu©n-LiÖt", 0, 1, },
        [38] = { 80, { 6, 1, { 278, 292 }, 0, 0, 0 }, 1, "§å phæ Ph¸ Qu©n cÊp 3", 3, 1, },
        [39] = { 100, { 6, 1, 587, 1, 0, 0 }, 50, "Thiªn Linh Th¹ch", 0, 1, },
        [40] = { 600, { 6, 1, 1048, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: Tham Lan T¸n", 0, 1, },
        [41] = { 350, { 6, 1, 1049, 1, 0, 0 }, 1, "C«ng thøc luyÖn ®¬n: ThÊt Tinh ThÇn §an", 0, 1, },
        [42] = { 350, { 6, 1, 1050, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Kim Ti Thiªu M¹ch", 0, 1, },
        [43] = { 350, { 6, 1, 1051, 1, 0, 0 }, 1, "C«ng thøc nÊu n­íng: Uyªn ¦¬ng H­¬ng T« L¹c", 0, 1, },
        [44] = { 54, { 3, 374, 0, 0, 0, 0 }, 1, "Vi Quang Qu¸i Phï (ch­a mµi)", 0, 1, },
        [45] = { 1200, { 6, 1, 1062, 1, 0, 0 }, 1, "Kinh nghiÖm ®¬n", 0, 1, },
        [46] = { 0, { 8, 1681, 2, 0, 0, 0 }, 1, "ViÔn Cæ Tiªn Th¶o", 0, 1, },
        [47] = { 0, { 8, 1682, 2, 0, 0, 0 }, 1, "Nguyªn Linh Ngäc Lé", 0, 1, },

        [48] = { 8, { 3, 100, 0, 0, 0, 0 }, 50, "T­íng Qu©n LÖnh", 0, 1, },
        [49] = { 40, { 3, { 257, 264, 271 }, 0, 0, 0, 0 }, 1, "Ngäc Tinh (ngÉu nhiªn)", 1, 1, },
        [50] = { 8, { 3, 1181, 0, 0, 0, 0 }, 1, "B¸ L¹c Tinh Kim", 0, 1, },
        [51] = { 5, { 3, { 258, 265, 272 }, 0, 0, 0, 0 }, 1, "Ngäc T©m (ngÉu nhiªn)", 5, 1, },
        [52] = { 40, { 3, 383, 0, 0, 0, 0 }, 1, "Tinh Th¸i Qu¸i Phï (ch­a mµi)", 0, 1, },
        [53] = { 10, { 8, 373, 2, 0, 0, 0 }, 1, "Trang Tinh (cao cÊp)", 0, 1, },
        [54] = { 40, { 8, 284, 2, 0, 0, 0 }, 1, "Trang Nguyªn (cao cÊp)", 0, 1, },
    }
    tbl_Item3 = tbl_Item3_old
    tbl_Item31 = tbl_Item31_old
    if (JIYUANGU.IsUseNewRandom() == 1) then
        tbl_Item3 = tbl_Item3_new
        tbl_Item31 = tbl_Item31_new
    end

    local nGlobalNum = GetWorldEventValue(8, 2)
    local nRnd3 = 0
    if (nGlobalNum >= 3) then
        nRnd3 = RndProbability100000(tbl_Item31)
    else
        nRnd3 = RndProbability100000(tbl_Item3)
    end
    local nBigItem = GetTask(1871) + 1
    local nNormalItem = GetTaskByte(Task_ItemNum, 1) + 1
    local nItemNum = GetTaskByte(Task_ItemNum, 3)
    local nDressNum = GetTaskByte(Task_ItemNum, 2)
    local nKillNum = GetTask(Task_KillItemNum) + 1

    local G_Big_BonoursBegin = 48
    local G_Big_BonoursEnd = 54
    local G_Dress_BonoursBegin = 34
    local G_Dress_BonoursEnd = 36

    SetTask(Task_KillItemNum, nKillNum)
    if (nRnd3 >= G_Big_BonoursBegin and (nItemNum >= g_BigTotalNum or nKillNum <= 20)) then
        nRnd3 = 2
    elseif (nRnd3 >= G_Big_BonoursBegin and nItemNum < g_BigTotalNum) then
        SetTaskByte(Task_ItemNum, 4, 0)
        SetTaskByte(Task_ItemNum, 3, nItemNum + 1)
    elseif (nRnd3 < 1 and nNormalItem >= g_SuccessionNum) then
        local nR = math.random(1, 1000)
        if (nR <= 175) then
            nRnd3 = 1
        elseif (nR <= 375) then
            nRnd3 = 8
        elseif (nR <= 495) then
            nRnd3 = 11
        elseif (nR <= 695) then
            nRnd3 = 33
        elseif (nR <= 755) then
            nRnd3 = 6
        elseif (nR <= 880) then
            if (GetWorldEventProgress(1) < 6) then
                nRnd3 = 33
            else
                nRnd3 = 32
            end
        elseif (nR <= 905) then
            if (GetWorldEventProgress(1) < 6) then
                nRnd3 = 8
            else
                nRnd3 = 31
            end
        elseif (nR <= 965) then
            nRnd3 = 21
        else
            nRnd3 = 20
        end
        SetTask(1871, nBigItem)
        local nMap, nX, nY = GetWorldPos()
        if (nMap == 83) then
            TaskNote(1631, 0, nBigItem)
        end
    elseif (nRnd3 >= G_Dress_BonoursBegin and nRnd3 <= G_Dress_BonoursEnd and nDressNum >= g_DressNum) then
        nRnd3 = 1
        SetTask(1871, nBigItem)
        local nMap, nX, nY = GetWorldPos()
        if (nMap == 83) then
            TaskNote(1631, 0, nBigItem)
        end
    elseif (nRnd3 < 1 and nNormalItem < g_SuccessionNum) then
        SetTaskByte(Task_ItemNum, 1, nNormalItem)
        SetTask(1871, nBigItem)
        local nMap, nX, nY = GetWorldPos()
        if (nMap == 83) then
            TaskNote(1631, 0, nBigItem)
        end
    else
        SetTask(1871, nBigItem)
        TaskNote(1631, 0, nBigItem)
    end

    if ((nRnd3 == 48 or nRnd3 == 31 or nRnd3 == 32) and (GetWorldEventProgress(1) < 6)) then
        if (nRnd3 == 48) then
            nRnd3 = 14
        elseif (nRnd3 == 31) then
            nRnd3 = 8
        elseif (nRnd3 == 32) then
            nRnd3 = 33
        end
    end

    if (GetTask(Task_KillItemNum) < 20 and nRnd3 == 31) then
        nRnd3 = 33
    end

    local strFlag = ""
    if (nBigItem >= 288) then
        AddNormalItem(6, 1, 992, 1, 0, 0)
        SetTask(1871, 0)
        local nMap, nX, nY = GetWorldPos()
        if (nMap == 83) then
            TaskNote(1631, 0, 0)
        end
        SetTaskByte(Task_ItemNum, 3, nItemNum + 1)
        nItemName = "R­¬ng Lu©n Håi"
        Msg2CurMapAnnounce("<c=g> U TÞch trong TÕ Uyªn Cèc <c> tr­íc khi lu©n håi tÆng <RoleName=\"" .. GetName() .. "\"><c>®Ó l¹i 1 <c=yel>R­¬ng Lu©n Håi<c>. ")
        AddGlobalNews("<c=g> U TÞch trong TÕ Uyªn Cèc <c> tr­íc khi lu©n håi tÆng <RoleName=\"" .. GetName() .. "\"><c>®Ó l¹i 1 <c=yel>R­¬ng Lu©n Håi<c>. ")
        ScrollMessage("NhËn Tói quµ Lu©n Håi: §iÓm Lu©n Håi tÝch lòy 288 ®iÓm, nhËn ®­îc Tói quµ Lu©n Håi")
        logStr = logStr .. "1" .. nItemName
        nRnd3 = G_Big_BonoursBegin
    elseif (nRnd3 >= 1 and nRnd3 <= table.getn(tbl_Item3)) then
        SetTaskByte(Task_ItemNum, 1, 0)
        if (nRnd3 >= G_Dress_BonoursBegin and nRnd3 <= G_Dress_BonoursEnd) then
            SetTaskByte(Task_ItemNum, 2, GetTaskByte(Task_ItemNum, 2) + 1)
        end
        local nItem = tbl_Item3[nRnd3][2]
        local nItemName = tbl_Item3[nRnd3][4]
        local nKind = tbl_Item3[nRnd3][5]
        if (nKind == 1) then
            local name_list = { "XÝch Viªm Ngäc Tinh (ch­a mµi)", "Thanh Minh Ngäc Tinh (ch­a mµi)", "Tö Hµ Ngäc Tinh (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
        elseif (nKind == 2) then
            local name_list = { "D­¬ng Xu©n Thanh Lé-L©m Phong", "D­¬ng Xu©n Thanh Lé-§µo Nghiªn Trang" }
            local nIdx = GetSex() + 1
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
        elseif (nKind == 3) then
            local nPlayer = GetPlayerType()
            local nIdx = math.random(0, 4)
            local nItem2 = 278 + nPlayer + nIdx * 3
            AddNormalItemPile(nItem[1], nItem[2], nItem2, nItem[4], nItem[5], nItem[6])
        elseif (nKind == 4) then
            local name_list = { "XÝch Viªm Danh Ngäc (ch­a mµi)", "Thanh Minh Danh Ngäc (ch­a mµi)", "Tö Hµ Danh Ngäc (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            for i = 1, tbl_Item3[nRnd3][3] do
                AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
            end
        elseif (nKind == 5) then
            local name_list = { "XÝch Viªm Ngäc T©m (ch­a mµi)", "Thanh Minh Ngäc T©m (ch­a mµi)", "Tö Hµ Ngäc T©m (ch­a mµi)" }
            local nIdx = math.random(1, table.getn(nItem[2]))
            nItemName = name_list[nIdx]
            AddNormalItemPile(nItem[1], nItem[2][nIdx], nItem[3], nItem[4], nItem[5], nItem[6])
            SetWorldEventValue(8, 2, nGlobalNum + 1)
        else
            for i = 1, tbl_Item3[nRnd3][3] do
                AddNormalItemPile(nItem[1], nItem[2], nItem[3], nItem[4], nItem[5], nItem[6])
            end
        end
        if (tbl_Item3[nRnd3][6] == 1) then
            Msg2CurMapAnnounce("<c=g> U TÞch trong TÕ Uyªn Cèc <c> tr­íc khi lu©n håi tÆng <RoleName=\"" .. GetName() .. "\"><c> ®Ó l¹i" .. tbl_Item3[nRnd3][3] .. " <c=yel>" .. nItemName .. "<c>.")
            AddGlobalNews("<c=g> U TÞch trong TÕ Uyªn Cèc <c> tr­íc khi lu©n håi tÆng <RoleName=\"" .. GetName() .. "\"><c> ®Ó l¹i" .. tbl_Item3[nRnd3][3] .. " <c=yel>" .. nItemName .. "<c>.")
        end
        if (nRnd3 >= G_Big_BonoursBegin) then
            strFlag = "PhÇn th­ëng lín"
            SetTask(1871, 0)
            PlayerCastSkill(1, 850, 1)
            local nMap, nX, nY = GetWorldPos()
            if (nMap == 83) then
                TaskNote(1631, 0, 0)
            end
            ScrollMessage("ThiÕt lËp l¹i ®iÓm Lu©n Håi: nhËn ®­îc phÇn th­ëng hiÕm, ®iÓm Lu©n Håi thiÕt lËp l¹i")
        end
        logStr = logStr .. "," .. tbl_Item3[nRnd3][3] .. "." .. nItemName
    end
    Msg2Player("B¹n nh©n ®­îc " .. logStr .. " vµ v« sè tiÒn.")

    if (nRnd3 < G_Big_BonoursBegin) then
        ScrollMessage("NhËn ®iÓm Lu©n Håi: §iÓm Lu©n Håi ®· t¨ng, ®iÓm Lu©n Håi hiÖn t¹i <c=g>" .. nBigItem .. "<c>")
    end

    WriteLog("U TÞch Di VËt[" .. nKillNum .. " lÇn]: nhËn ®­îc " .. strFlag .. logStr)
end

function RndProbability100000(t)
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
        return 0
    else
        return nil
    end
end

function RndProbabilityTable(t)
    if type(t) == "table" then
        local count = table.getn(t)
        local sum = 0
        local rnd = math.random(1, 10000)
        for i = 1, count do
            local probability = t[i][1]
            sum = sum + probability
            if rnd <= sum then
                return i
            end
        end
        return 0
    else
        return nil
    end
end
