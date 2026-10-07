Task_ChildrensDayReceive = 1703
Task_ChildrensDayReceiveNum = 1704
Task_ChildrensDayReceiveTodayNum = 1705
Task_ChildrensDay = 1706

Task_ChildrensToday = 1707
Task_Childrens = 1708

Glocal_ChildrenGiftNum = 373
Save_ChilrensDayTree_Num = "Save_ChilrensDay_Tree_Num"

AwardList = {
    [1] = { 1500, 6100, 16100, 26100 },
    [2] = { 475200, 1932480, 5100480, 8268480 },
};

function main()

    local Y, M, D = GetYMD()
    local H1, M1, S1 = GetHMS()
    local mapid, x, y = GetWorldPos()

    if (GetLevel() < 30) then
        Talk(1, "no", "TrÎ con ®èt ph¸o rÊt nguy hiÓm, sau cÊp 30 h·y quay l¹i t×m ta nhÐ!")
        return
    elseif (mapid ~= 21) or H1 < 20 or H1 > 24 then
        Talk(1, "no", "Ph¸o hoa chØ sö dông trong thêi gian ho¹t ®éng, mçi tèi tõ 20h ®Õn 24h cã thÓ ®èt ë TriÒu Ca.")
        return
    end

    if Y ~= 2010 or M < 5 or M > 6 or (M == 5 and D < 28) or (M == 6 and D > 4) then
        Talk(1, "no", "§· hÕt thêi gian ho¹t ®éng, nghiªm cÊm ®èt ph¸o!")
        return
    end

    if (HaveNormalItem(6, 1, 839, 0) <= 0) then
        return
    end

    PlayerCastSkill(1, 150, 1)

    if GetTeam() == 0 or GetTeamSize() < 2 then


        local id = 1
        id = CheckLevel()
        local awardnum = GetTask(1708)
        if awardnum > AwardList[2][id] or GetLevel() >= 200 then
            InfoBox("B¹n ®· nhËn ®­îc ®ñ kinh nghiÖm trong ho¹t ®éng tiÕt Ph¸o hoa!")
            DelNormalItem(6, 1, 839, 0)
            return
        end

        SetTask(1708, awardnum + AwardList[1][id])

    else

        local mapid, x, y = GetWorldPos()
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local w, nX, nY = GetWorldPos()
            local award = TeamCheck()
            local awardNum = GetTaskByte(Task_ChildrensDayReceiveNum, 3)

            local id = 1
            local awardexp = GetTask(1708)
            id = CheckLevel()

            if GetLevel() >= 30 and GetLevel() < 200 and ((x - nX) ^ 2 + (y - nY) ^ 2) <= 1600 * 1200 and mapid == w and (awardNum <= 12) and awardexp <= AwardList[2][id] then


                SetTaskByte(Task_ChildrensDayReceiveNum, 3, awardNum + 1)
                SetTask(1708, awardexp + award)
            elseif ((x - nX) ^ 2 + (y - nY) ^ 2) > 1600 * 1200 or mapid ~= w then
                Msg2Player("B¹n kh«ng ®èt ph¸o hoa trong ph¹m vi cã hiÖu qu¶, kh«ng thÓ nhËn ®­îc phÇn th­ëng")
            elseif awardNum > 12 then
                Msg2Player("H«m nay b¹n ®· nhËn ®ñ ®iÓm kinh nghiÖm trong ho¹t ®éng tiÕt Ph¸o hoa!")
            elseif awardexp > AwardList[2][id] or GetLevel() >= 200 then
                Msg2Player("B¹n ®· nhËn ®­îc ®ñ kinh nghiÖm trong ho¹t ®éng tiÕt Ph¸o hoa!")
            end

            PlayerIndex = oldPlayer
        end
        PlayerIndex = oldPlayer
    end

    DelNormalItem(6, 1, 839, 0)
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

function TeamCheck()
    local friendNum = 0
    local teamNum = 0
    local totalAward = 0
    local id = CheckLevel()
    local Dis = 0

    local oldPlayer = PlayerIndex
    local membercount = GetTeamSize()

    for i = 1, membercount do
        PlayerIndex = GetTeamMember(i)
        local fname = GetName()
        local nLevel = GetLevel()

        PlayerIndex = oldPlayer
        if GetRelation(fname) == 1 and nLevel >= 30 and Dis <= 1600 * 1200 and (GetTaskByte(Task_ChildrensDayReceiveNum, 3) <= 12) then
            friendNum = friendNum + 1
            teamNum = teamNum + 1
        elseif nLevel >= 30 and Dis <= 1600 * 1200 and (GetTaskByte(Task_ChildrensDayReceiveNum, 3) <= 12) then
            teamNum = teamNum + 1
        end
    end
    PlayerIndex = oldPlayer
    totalAward = (1 + 0.1 * (friendNum + teamNum)) * AwardList[1][id]

    return totalAward
end

function no()
    CloseDialog()
end

