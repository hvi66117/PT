gFatFishItem = {
    [1] = { ratio = 33, [2] = { 3, 953, 0, 0, 0, 0 }, name = "Phi Ng©n TuyÕt Ng­" },
    [2] = { ratio = 33, [2] = { 3, 954, 0, 0, 0, 0 }, name = "Tinh Ban §iªu Ng­" },
    [3] = { ratio = 34, [2] = { 3, 955, 0, 0, 0, 0 }, name = "Cöu VÜ Long Ng­" },
    [4] = { ratio = 100, [2] = { 3, 952, 0, 0, 0, 0 }, name = "CÈm V©n Ng­" },
    [5] = { ratio = 100, [2] = { 3, 951, 0, 0, 0, 0 }, name = "Ng©n TuyÕt B¹ng" },
    [6] = { ratio = 100, [2] = { 3, 950, 0, 0, 0, 0 }, name = "Kim Bang Lý" },
    [7] = { ratio = 100, [2] = { 3, 949, 0, 0, 0, 0 }, name = "Bµn §Çu Liªn" },
    [8] = { ratio = 3000, [2] = { 3, 947, 0, 0, 0, 0 }, name = "Hång Lý" },
    [9] = { ratio = 3000, [2] = { 3, 946, 0, 0, 0, 0 }, name = "Ca diÕt" },
    [10] = { ratio = 3000, [2] = { 3, 945, 0, 0, 0, 0 }, name = "T«m hïm" },
    [11] = { ratio = 490, [2] = { 6, 1, 761, 0, 0, 0 }, name = "R©u Rång" },
    [12] = { ratio = 10, [2] = {                   }, name = "Cao thñ c©u c¸" },
}
gTotalValue = 10000

function main()
    local randnum = math.random(1, gTotalValue)
    local ratio = {}
    local ratiosum = 0
    local giftlevel = 0

    for i = 1, 11 do
        ratiosum = ratiosum + gFatFishItem[i].ratio
        ratio[i] = ratiosum
    end

    for i = 11, 1, -1 do
        if (randnum > ratio[i]) then
            giftlevel = i
            break
        end
    end

    giftlevel = giftlevel + 1

    if (IsHaveSpaceForTreasure(1) == 0) then
        TopMessage("Hµnh trang cña b¹n ®· ®Çy")
        Msg2Player("Hµnh trang cña b¹n ®· ®Çy")
        return
    end

    if (giftlevel <= 10) then
        local subitem = gFatFishItem[giftlevel]
        AddNormalItemPile(subitem[2][1], subitem[2][2], subitem[2][3], subitem[2][4], subitem[2][5], subitem[2][6])
        Msg2Player("B¹n nhËn ®­îc <c=g>1<c> <c=g>" .. gFatFishItem[giftlevel].name .. "<c>")
    elseif (giftlevel == 11) then
        local subitem = gFatFishItem[giftlevel]
        for i = 1, 3 do
            AddNormalItemPile(subitem[2][1], subitem[2][2], subitem[2][3], subitem[2][4], subitem[2][5], subitem[2][6])
        end
        Msg2Player("B¹n nhËn ®­îc <c=g>3<c> <c=g>" .. gFatFishItem[giftlevel].name .. "<c>")
    elseif (giftlevel == 12) then

        local titleID = 32
        if (HaveQualify(titleID) == 0) then
            ActiveTitleFunc(1)
            ActiveTitleQualify(titleID)
        end

        MsgBox("Chóc mõng b¹n nhËn ®­îc danh hiÖu <c=g>Cao thñ c©u c¸<c>! NhËn b©y giê chø?", "gettitle", "no")
    end
end

function gettitle()
    no()
    local titleID = 32
    SetCurTitle(titleID)
    Msg2Player("B¹n nhËn ®­îc <c=g>" .. gFatFishItem[giftlevel].name .. "<c> (danh hiÖu)")
    Talk(1, "no", "B¹n nhËn ®­îc <c=g>" .. gFatFishItem[giftlevel].name .. "<c> (danh hiÖu)")
end

function no()
    CloseDialog()
end;
