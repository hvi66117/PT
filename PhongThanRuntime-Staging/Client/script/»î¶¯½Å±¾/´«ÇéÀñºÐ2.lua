Task_ChildrensDayReceive = 1703
Task_ChildrensDayReceiveNum = 1704
Task_ChildrensDayReceiveTodayNum = 1705
Task_ChildrensDay = 1706

Task_ChildrensToday = 1707

Glocal_ChildrenGiftNum = 373
Save_ChilrensDayTree_Num = "Save_ChilrensDay_Tree_Num"

function no()
    CloseDialog()
end

function main()

    if (HaveNormalItem(6, 1, 838, 0) == 0) then
        return
    end

    local Year, Mon, Dat = GetYMD()

    if Year == 2010 and ((Mon == 5 and Dat >= 28 and Dat <= 31) or (Mon == 6 and Dat >= 1 and Dat <= 4)) then
        OpenGift()
    else
        Talk(1, "no", "Hép quµ chØ cã thÓ më trong thêi gian diÔn ra ho¹t ®éng, b¹n ®· bá lì thêi c¬.")
    end

end

function OpenGift()
    no()
    local mapid, x, y = GetWorldPos()
    if mapid ~= 21 then
        Talk(1, "no", "TriÒu Ca lµ n¬i ®Şa linh nh©n kiÖt, Hép quµ t×nh c¶m chØ cã thÓ më t¹i TriÒu Ca .")
        return
    end

    MsgBox("B¹n x¸c nhËn muèn më Hép quµ?", "YesGift", "no")
end

function YesGift()
    no()

    if (HaveNormalItem(6, 1, 838, 0) <= 0) then
        return
    end

    local itemlist = {
        { itemid = { 8, 174, 2 }, itemname = "Méc nh©n", num = 1, r = 50 },
        { itemid = { 3, 100, 0 }, itemname = "T­íng Qu©n LÖnh", num = 1, r = 35 },
        { itemid = { 3, 100, 0 }, itemname = "T­íng Qu©n LÖnh", num = 2, r = 15 },
    }

    local giftnum = GetTaskByte(Task_ChildrensDayReceiveNum, 4) + 1
    local rb = math.random(1, 100)
    local i = 1
    local j = 1
    if (rb <= 15) then
        j = 1
    elseif (rb > 15 and rb <= 50) then
        j = 2
    else
        j = 3
    end

    SetTaskByte(Task_ChildrensDayReceiveNum, 4, giftnum)

    for i = 1, itemlist[j].num do
        local temp = itemlist[j].itemid

    end

    local num = GetTaskByte(Task_ChildrensDayReceiveNum, 4)
    SetTaskByte(Task_ChildrensDayReceiveNum, 4, giftnum)
    local playernum = GetTaskByte(Task_ChildrensDay, 3)
    local playerid = SearchPlayerById(GetNpcTask(PlayerIndex, playernum))
    local oldplayer = PlayerIndex
    PlayerIndex = playerid
    local playername = GetName()
    PlayerIndex = oldplayer
    SetTaskByte(Task_ChildrensDay, 3, giftnum)

    DelNormalItem(6, 1, 838, 0)
end
