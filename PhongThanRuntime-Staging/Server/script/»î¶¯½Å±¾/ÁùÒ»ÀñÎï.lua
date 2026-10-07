Task_ChildrensDayReceive = 1703
Task_ChildrensDayReceiveNum = 1704
Task_ChildrensDayReceiveTodayNum = 1705
Task_ChildrensDay = 1706

Task_ChildrensToday = 1707

Glocal_ChildrenGiftNum = 373
Save_ChilrensDayTree_Num = "Save_ChilrensDay_Tree_Num"

AwardList = {
    { nExp = 3000, nCoin = 6100 },
    { nExp = 10000, nCoin = 10000 },
    { nExp = 50000, nCoin = 30000 },
    { nExp = 100000, nCoin = 61000 },
};

ItemList = {
    { name = "TiÒn", r = 35 },
    { name = " kinh nghiÖm", r = 30 },
    { name = "Nh­ ý Ch©n KhÝ (tiÓu)", r = 10, id = { 8, 780, 4 } },
    { name = "Nh­ ý Thanh Lé (tiÓu)", r = 10, id = { 8, 779, 3 } },
    { name = "Nh­ ý Di ngo¹i phï", r = 4, id = { 8, 567, 2 } },
};

function no()
    CloseDialog()
end

function main()

    local Year, Mon, Dat = GetYMD()

    if Year == 2010 and ((Mon == 5 and Dat >= 28 and Dat <= 31) or (Mon == 6 and Dat >= 1 and Dat <= 4)) then
        local openTodayNum = GetTaskByte(Task_ChildrensDayReceiveTodayNum, 1) + 1
        local openTotalNum = GetTaskByte(Task_ChildrensDayReceiveNum, 1) + 1

        local mapid, x, y = GetWorldPos()
        if (mapid ~= 21) then
            Talk(1, "no", "Quµ tÆng chØ cã thÓ më ë TriÒu Ca.")
            return
        end

        if openTodayNum > 16 then
            Talk(1, "no", "Mçi ngµy chØ nhËn tèi ®a 16 tói quµ, h«m nay ng­¬i ®· nhËn ®ñ råi, kh«ng thÓ më Tói quµ 1-6 n÷a.")
            return
        end

        if openTotalNum > 61 then
            Talk(1, "no", "Trong thêi gian ho¹t ®éng, mçi ng­êi cã thÓ më tèi ®a 61 Tói quµ 1-6, ng­¬i ®· nhËn ®ñ quµ tÆng råi.")
            return
        end

        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ nhËn phÇn th­ëng.")
            return
        end

        if (HaveNormalItem(6, 1, 836, 0) <= 0) then
            return
        end

        if (GetLevel() < 30) then
            Talk(1, "no", "Ng­¬i kh«ng ®ñ cÊp, kh«ng thÓ më Tói quµ 1-6, ®¹t cÊp 30 h·y quay l¹i.")
            return

        elseif (GetLevel() >= 30 and GetLevel() < 60) then

            Talk(2, "gift", "§©y lµ lÇn quyªn hiÕn thø <c=g>" .. openTodayNum .. "<c> Tói quµ 1-6, cßn cã thÓ më <c=g>" .. (16 - openTodayNum) .. "<c> Tói quµ 1-6.", "Trong thêi gian ho¹t ®éng, ng­¬i ®· nhËn ®­îc <c=g>" .. openTotalNum .. "<c> tói quµ, cßn cã thÓ më <c=g>" .. (61 - openTotalNum) .. "<c> tói quµ.")

            SetTaskByte(Task_ChildrensDayReceiveTodayNum, 1, openTodayNum)
            SetTaskByte(Task_ChildrensDayReceiveNum, 1, openTotalNum)
            DelNormalItem(6, 1, 836, 0)

        elseif (GetLevel() >= 60) then

            local rb = math.random(1, 100)
            local giftNum = GetGlobalValue(Glocal_ChildrenGiftNum)
            if (rb <= 3 and giftNum <= 25) then
                Talk(3, "gift", "Chóc mõng, trong Tói quµ 1-6 cã 1 <c=g>Hép quµ t×nh c¶m<c>, cã thÓ ®em ®æi víi b¹n h÷u.", "§©y lµ lÇn thø " .. openTodayNum .. " më Tói quµ 1-6, cßn cã thÓ më" .. (16 - openTodayNum) .. " Tói quµ 1-6.", "Trong thêi gian ho¹t ®éng, ng­¬i ®· nhËn" .. openTotalNum .. " Tói quµ, cßn cã thÓ më" .. (61 - openTotalNum) .. " Tói quµ.")

                SetGlobalValue(Glocal_ChildrenGiftNum, giftNum + 1)


            else
                Talk(2, "gift", "§©y lµ lÇn thø " .. openTodayNum .. " më Tói quµ 1-6, cßn cã thÓ më" .. (16 - openTodayNum) .. " Tói quµ 1-6.", "Trong thêi gian ho¹t ®éng, ng­¬i ®· nhËn" .. openTotalNum .. " Tói quµ, cßn cã thÓ më" .. (61 - openTotalNum) .. " Tói quµ.")
            end

            SetTaskByte(Task_ChildrensDayReceiveTodayNum, 1, openTodayNum)
            SetTaskByte(Task_ChildrensDayReceiveNum, 1, openTotalNum)
            DelNormalItem(6, 1, 836, 0)

        end

    else
        Talk(1, "no", "Tói quµ 1-6 chØ cã thÓ më trong thêi gian ho¹t ®éng TÕt thiÕu nhi. TiÕc qu¸! Ng­¬i ®· bá lì c¬ héi råi.")
        return
    end

end

function gift()
    no()
    local listId = CheckLevel()
    local rb = math.random(1, 100)
    local j = 1
    if (rb <= 4) then
        j = 5
    elseif (rb > 4 and rb <= 14) then
        j = 4
    elseif (rb > 14 and rb <= 24) then
        j = 3
    elseif (rb > 24 and rb <= 54) then
        j = 2

        return
    else
        j = 1

        return
    end

    local itemid = ItemList[j].id


end

function CheckLevel()
    local nlevel = GetLevel()
    if nlevel >= 30 and nlevel < 60 then
        return 1
    elseif nlevel >= 60 and nlevel < 90 then
        return 2
    elseif nlevel >= 90 and nlevel < 150 then
        return 3
    elseif nlevel >= 150 then
        return 4
    end
end
