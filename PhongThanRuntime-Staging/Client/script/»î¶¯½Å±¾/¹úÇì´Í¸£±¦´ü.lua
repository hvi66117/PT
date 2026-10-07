function main()
    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        InfoBox("Tói phóc Quèc Kh¸nh chØ cã thÓ më ë TriÒu Ca.")
        return
    end

    if IsHaveSpaceForTreasure(2) == 0 then
        InfoBox("¤ tói kh«ng ®ñ, h·y s¾p xÕp tói råi më l¹i!")
        return
    end

    if (HaveNormalItem(6, 1, 859, 0) <= 0) then
        return
    end
    DelNormalItem(6, 1, 859, 0)

    local i = math.random(1, 100)

    local nRolResult = -1;

    local nCurDay = math.floor(LocalSystemTime() / 86400)
    local nLogDay = LoadIniInteger("2011_NATIONAL_DAY", 1)
    if nLogDay == nil then
        nLogDay = 0
    end

    if nLogDay ~= nCurDay then
        SaveIniInteger("2011_NATIONAL_DAY", 1, nCurDay)
        SaveIniInteger("2011_NATIONAL_DAY", 2, 0)
        SaveIniInteger("2011_NATIONAL_DAY", 3, 0)
    end

    local nItemIdx = 0
    local szNotice = ""
    if i <= 3 then
        if (GetLevel() >= 60) then
            local nCount = LoadIniInteger("2011_NATIONAL_DAY", 2)
            if nCount == nil then
                nCount = 0
            end

            nCount = nCount + 1;
            SaveIniInteger("2011_NATIONAL_DAY", 2, nCount)
            if nCount <= 30 then

                AddItemPileNum(3, 138, 0, 1, 5)
                szNotice = "5 ThiÖp Nh­ ý"
                AddGlobalNews("<c=g>" .. GetName() .. "<c> NhËn ®­îc <c=g>5<c> ThiÖp Nh­ ý cña ho¹t ®éng Mõng Quèc Kh¸nh, ®­îc N÷ Oa ban phóc.", 3)

            else
                AddNormalItemBind(8, 198, 3, 0, 0, 0, 1)
                szNotice = "1 c¸i B¶o H÷u Thanh Lé"

            end
        else
            AddNormalItem(8, 28, 3, 1, 0, 0)
            szNotice = "1 Thanh Lé (nhá)"
        end
    elseif i <= 4 then
        if (GetLevel() >= 60) then
            local nCount = LoadIniInteger("2011_NATIONAL_DAY", 3)
            if nCount == nil then
                nCount = 0
            end

            nCount = nCount + 1;
            SaveIniInteger("2011_NATIONAL_DAY", 3, nCount)
            if nCount <= 10 then

                AddItemPileNum(3, 138, 0, 1, 10)
                szNotice = "10 c¸i ThiÖp Nh­ ý"
                AddGlobalNews("<c=g>" .. GetName() .. "<c>´Ó¹úÇì½Ú»î¶¯ÖÐ nhËn ®­îc <c=g>10<c> c¸i ThiÖp Nh­ ý, µÃµ½ÁËÅ®æ´µÄ´Í¸£.", 3)
            else
                AddNormalItemBind(8, 198, 3, 0, 0, 0, 1)
                szNotice = "1 c¸i B¶o H÷u Thanh Lé"

            end
        else
            AddNormalItem(8, 29, 4, 1, 0, 0)
            szNotice = "1 Ch©n KhÝ (tiÓu)"
        end
    elseif i <= 12 then
        local nLevel = GetLevel()
        if (nLevel >= 30 and nLevel <= 80) then
            EarnBind(100000)
            szNotice = "100000 b¹c khãa"
        elseif (nLevel >= 81 and nLevel <= 130) then
            EarnBind(200000)
            szNotice = "200000 b¹c khãa"
        elseif (nLevel >= 131 and nLevel <= 200) then
            EarnBind(500000)
            szNotice = "500000 b¹c khãa"
        end

    elseif i <= 37 then
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1)
        szNotice = "1 Thanh Lé"
    elseif i <= 62 then
        AddNormalItemBind(8, 163, 3, 0, 0, 0, 1)
        szNotice = "1NhËt NguyÖt Ch©n KhÝ"
    elseif i <= 67 then
        AddNormalItemBind(8, 198, 3, 0, 0, 0, 1)
        szNotice = "1 c¸i B¶o H÷u Thanh Lé"
    elseif i <= 72 then
        AddNormalItemBind(8, 199, 4, 0, 0, 0, 1)
        szNotice = "1 c¸i S¬n Thuû Ch©n KhÝ"
    elseif i <= 80 then
        local rd = math.random(119, 124)
        AddNormalItemBind(8, rd, 2, 0, 0, 0, 1)
        szNotice = "1 c¸i ÃÔ¹¬´«ËÍ·û"
    elseif i <= 85 then
        AddNormalItem(3, 1149, 0, 0, 0, 0)
        szNotice = "1 c¸i M¶nh Tö Thuû Tinh"
    elseif i <= 97 then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        szNotice = "1 D· Ngo¹i Phï"
    else
        AddNormalItemBind(8, 291, 2, 0, 0, 0, 1)
        szNotice = "1 Håi Thµnh Phï (cao cÊp)"
    end

    Msg2SubWorld(GetName() .. "Më Tói phóc mõng Quèc Kh¸nh nhËn ®­îc Chóc phóc cña N÷ Oa.")
    ScrollMessage("Chóc mõng b¹n nhËn ®­îc " .. szNotice)
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. szNotice)
    WriteLog(GetName() .. " Më Tói phóc mõng Quèc Kh¸nh nhËn ®­îc " .. szNotice)
end

