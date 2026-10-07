Rewards_Item = {
    [1] = { name = "Tö Thñy tinh", ID = { 3, 1150, 0 }, Possible = 1, Max = 3, perNum = 1 },
    [2] = { name = "Thiªn Tiªn Qu¶", ID = { 8, 1027, 2 }, Possible = 3, Max = -1, perNum = 1 },
    [3] = { name = "Di Quang kÝnh", ID = { 8, 509, 2 }, Possible = 7, Max = -1, perNum = 1 },
    [4] = { name = { "Háa Ngäc Tñy", "B¨ng Ngäc Tñy", "Thæ Ngäc Tñy", "L«i Ngäc Tñy", "Kim Ngäc Tñy", }, ID = { { 3, 1045, 0 }, { 3, 1046, 0 }, { 3, 1047, 0 }, { 3, 1048, 0 }, { 3, 1049, 0 }, }, Possible = 16, Max = 0, perNum = 5 },
    [5] = { name = "Ch©n KhÝ", ID = { 8, 163, 4 }, Possible = 34, Max = -1, perNum = 1 },
    [6] = { name = "Thanh Lé", ID = { 8, 162, 3 }, Possible = 52, Max = -1, perNum = 1 },
    [7] = { name = "Di ngo¹i phï", ID = { 8, 35, 2 }, Possible = 70, Max = -1, perNum = 1 },
    [8] = { name = "Thiªn Tiªn thñy", ID = { 8, 206, 5 }, Possible = 80, Max = -1, perNum = 1 },
    [9] = { name = "Tö Kim hå l«", ID = { 8, 257, 2 }, Possible = 90, Max = -1, perNum = 1 },
    [10] = { name = "Hµnh Qu©n LÖnh", ID = { 8, 214, 2 }, Possible = 100, Max = -1, perNum = 1 },
}

function main()
    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        InfoBox("Hép nguyÖn väng chØ cã thÓ më ë TriÒu Ca.")
        return
    end

    if IsHaveSpaceForTreasure(2) == 0 then
        InfoBox("¤ tói kh«ng ®ñ, h·y s¾p xÕp l¹i tói råi më hép!")
        return
    end

    local nRolResult = -1

    local nYear, nMonth, nCurDay = GetYMD()
    local nLogDay = LoadIniInteger("2011_PLANTTREE_DAY", 1)
    if nLogDay == nil then
        nLogDay = 0
    end

    if nLogDay ~= nCurDay then
        SaveIniInteger("2011_PLANTTREE_DAY", 1, nCurDay)
        SaveIniInteger("2011_PLANTTREE_DAY", 2, 0)
    end

    local i = math.random(1, 100)
    local szNotice = ""
    if i <= 1 then
        local nCount = LoadIniInteger("2011_PLANTTREE_DAY", 2)
        if nCount == nil then
            nCount = 0
        end

        nCount = nCount + 1;
        SaveIniInteger("2011_PLANTTREE_DAY", 2, nCount)
        if nCount <= 3 then
            AddGlobalNews("<c=g>" .. GetName() .. "<c> më Hép nguyÖn väng cña ho¹t ®éng TÕt trång c©y, bªn trong cã 1 <c=y>Tö Thñy Tinh<c>, thËt may m¾n!", 3)
            AddNormalItemBind(3, 1150, 0, 0, 0, 0, 1)
            szNotice = "1 Tö Thñy Tinh"
        else
            AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
            szNotice = "1 D· Ngo¹i Phï"
        end
    elseif i <= 3 then
        AddNormalItemBind(8, 1027, 2, 0, 0, 0, 1)
        szNotice = "1 Thiªn Tiªn Qu¶"
        AddGlobalNews("<c=g>" .. GetName() .. "<c> më Hép nguyÖn väng cña ho¹t ®éng TÕt trång c©y, bªn trong cã 1 <c=y>Thiªn Tiªn Qu¶<c>, thËt may m¾n!", 3)
    elseif i <= 7 then
        AddNormalItemBind(8, 509, 2, 0, 0, 0, 1)
        szNotice = "1 Di Quang KÝnh"
        AddGlobalNews("<c=g>" .. GetName() .. "<c> më Hép nguyÖn väng cña ho¹t ®éng TÕt trång c©y, bªn trong cã 1 <c=y>Di Quang KÝnh<c>, thËt may m¾n!", 3)
    elseif i <= 16 then
        local Item = Rewards_Item[4].ID
        local Name = Rewards_Item[4].name
        local nRand = math.random(1, 5)
        for i = 1, 5 do
            AddNormalItemBind(Item[nRand][1], Item[nRand][2], Item[nRand][3], 0, 0, 0, 1)
        end
        szNotice = "5 " .. Name[nRand]
        AddGlobalNews("<c=g>" .. GetName() .. "<c> më Hép nguyÖn väng cña ho¹t ®éng TÕt trång c©y, bªn trong cã 5 <c=y>" .. Name[nRand] .. "<c>, thËt may m¾n!", 3)
    elseif i <= 34 then
        AddNormalItemBind(8, 163, 4, 0, 0, 0, 1)
        szNotice = "1 Ch©n KhÝ"
    elseif i <= 52 then
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1)
        szNotice = "1 Thanh Lé"
    elseif i <= 70 then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        szNotice = "1 D· Ngo¹i Phï"
    elseif i <= 80 then
        AddNormalItemBind(8, 206, 5, 0, 0, 0, 1)
        szNotice = "1 Thiªn Tiªn Thñy"
    elseif i <= 90 then
        AddNormalItemBind(8, 257, 2, 0, 0, 0, 1)
        szNotice = "1 Tö Kim Hå L«"
    elseif i <= 100 then
        AddNormalItemBind(8, 214, 2, 0, 0, 0, 1)
        szNotice = "1 Hµnh Qu©n LÖnh"
    end

    DelNormalItem(6, 1, 874, 0)
    Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> më Hép NguyÖn Väng, nhËn ®­îc <c=y>" .. szNotice .. "<c>, mäi ng­êi mau ®Õn chóc mõng.")
    ScrollMessage("Chóc mõng b¹n nhËn ®­îc " .. szNotice)
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. szNotice)
    WriteLog(GetName() .. "Më Hép NguyÖn Väng nhËn ®­îc " .. szNotice)
end
