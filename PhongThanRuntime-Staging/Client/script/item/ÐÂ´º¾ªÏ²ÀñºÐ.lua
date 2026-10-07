require("common.luax")

g_Item = { 8, 1828, 2, 0 }

g_Name = "LÔ bao Kinh HØ T©n Xu©n"

g_NeedSpace = 1

g_ItemList = {
    [1] = { name = "T­íng Qu©n LÖnh*2", ID = { 3, 100, 0, 0, 0, 0 }, count = 2, needSpace = 1, isnotice = 1, },
    [2] = { name = "Vi Quang Qu¸i Phï", ID = { 3, 374, 0, 0, 0, 0 }, count = 1, needSpace = 1, isnotice = 1, },
    [3] = { name = "LÔ hép Phï Th¹ch", ID = { 8, 1775, 2, 0, 0, 0 }, count = 1, needSpace = 1, isnotice = 1, },
    [4] = { name = "Thiªn Ngo¹i Phi Tiªn Trang", ID = { 8, 1500, 2, 0, 0, 0 }, count = 1, needSpace = 1, isnotice = 1, },
    [5] = { name = "T­íng Qu©n LÖnh*5", ID = { 3, 100, 0, 0, 0, 0 }, count = 5, needSpace = 1, isnotice = 1, },
}

G_OpenDay = { "2017-02-06 10:00:00", "2017-02-28 23:59:59" }

function main(itemId)
    CloseDialog()

    if not (HaveNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) > 0) then
        return 0
    end

    if not (COMMON.IsInDateTimeRange(G_OpenDay[1], G_OpenDay[2])) then
        Talk(1, "no", "LÔ bao Kinh HØ T©n Xu©n¿ªÆôÊ±¼äÎª2ÔÂ6ÈÕ10µãÖÁ2ÔÂ28ÈÕ24µã!")
        return 0
    end

    local nYear, nMon, nDay = GetYMD()
    if (GetTaskByte(2086, 1) == nDay) then
        Talk(1, "no", "ThËt xin lçi, LÔ bao Kinh HØ T©n Xu©n mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    local nLeftTimes = GetIBItemPoint(g_Item[1], g_Item[2], g_Item[3], g_Item[4])
    local t1 = { 1, 1, 1, 2, 3, 3, 3, 3, 4, 5 }
    local MyTable = COMMON.GetRandTable(t1)
    local itemNum = 11 - nLeftTimes
    if (itemNum >= 1 and itemNum <= table.getn(t1)) then
        local nIndex = MyTable[itemNum]
        if (nIndex >= 1 and nIndex <= table.getn(g_ItemList)) then

            if (IsHaveSpaceForTreasure(g_ItemList[nIndex].needSpace) == 0) then
                Talk(1, "no", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
                return
            end

            SetTaskByte(2086, 1, nDay)
            CostIBItem(itemId)

            for i = 1, g_ItemList[nIndex].count do

                AddNormalItemBind(g_ItemList[nIndex].ID[1], g_ItemList[nIndex].ID[2], g_ItemList[nIndex].ID[3], g_ItemList[nIndex].ID[4], g_ItemList[nIndex].ID[5], g_ItemList[nIndex].ID[6], 1)
            end

            local strMust = ","
            if (nLeftTimes == 1) then
                AddItemMust()
            end

            local strShow = "Chóc mõng ngµi më " .. g_Name .. " nhËn ®­îc " .. g_ItemList[nIndex].name .. "½±Àø."

            if (g_ItemList[nIndex].isnotice >= 1) then

                local str = "Chóc mõng " .. GetName() .. " më " .. g_Name .. " nhËn ®­îc " .. g_ItemList[nIndex].name .. "½±Àø."
                Msg2CurMapAnnounce(str)

                if (g_ItemList[nIndex].isnotice >= 2) then

                    AddGlobalNews(str)
                end
            end

            Msg2Player(strShow)

            strShow = "[" .. GetName() .. strShow .. "]"
            WriteLog(strShow)
        end
    end
end

function AddItemMust()
    for i = 1, 5 do
        AddNormalItemPile(3, 100, 0, 0, 0, 0)
    end

    local str = "Chóc mõng anh hïng ÀÛ¼ÆµÚ10´Î¿ªÆô, NhËn ®­îc thªm T­íng Qu©n LÖnh*5!"
    return str
end

function no()
    CloseDialog()
end;
