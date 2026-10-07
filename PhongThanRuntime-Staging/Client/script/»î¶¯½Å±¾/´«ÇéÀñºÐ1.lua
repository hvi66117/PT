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

    if (HaveNormalItem(6, 1, 837, 0) <= 0) then
        return
    end

    local Year, Mon, Dat = GetYMD()
    local num = GetTaskByte(Task_ChildrensDayReceiveNum, 4)

    if Year == 2010 and ((Mon == 5 and Dat >= 28 and Dat <= 31) or (Mon == 6 and Dat >= 1 and Dat <= 4)) then
        ChildrenGift()

    else
        Talk(1, "no", "Hép quµ chØ cã thÓ më trong thêi gian diÔn ra ho¹t ®éng, b¹n ®· bá lì thêi c¬.")
    end

end

function ChildrenGift()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ nhËn phÇn th­ëng.")
        return
    end

    if (GetLevel() < 30) then
        Talk(1, "no", "B¹n ch­a ®ñ cÊp, kh«ng thÓ tÆng quµ.")
        return
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 21) then
        Talk(1, "no", "ë t¹i TriÒu Ca míi cã thÓ tÆng quµ.")
        return
    end

    local playerid = PlayerIndex
    local TeamState, Playeridx = CheakTeam(playerid)
    PlayerIndex = Playeridx
    local name = GetName()
    PlayerIndex = playerid

    if (TeamState == 2) then
        Talk(1, "no", "Kh«ng thÓ tù më hép quµ, chØ cã thÓ tÆng cho ng­êi kh¸c.")
        return
    elseif (TeamState == 3) then
        Talk(1, "no", "Muèn tÆng quµ ph¶i cã 2 ng­êi kÕt tæ ®éi!")
        return
    elseif (TeamState == 4) then
        Talk(1, "no", "§ång ®éi ch­a ®¹t cÊp 30, kh«ng thÓ nhËn hoÆc tÆng quµ.")
        local oldplayer = PlayerIndex
        PlayerIndex = Playeridx
        Msg2Player("Quµ tÆng tuy quý, nh­ng cßn qu¸ Ýt tuæi th× kh«ng thÓ nhËn.")
        PlayerIndex = oldplayer
        return
    elseif (TeamState == 5) then
        Talk(1, "no", name .. "§· nhËn ®ñ quµ tÆng, kh«ng thÓ tÆng n÷a.")
        local oldplayer = PlayerIndex
        PlayerIndex = Playeridx
        Msg2Player("B¹n ®· nhËn ®ñ Hép quµ t×nh c¶m.")
        PlayerIndex = oldplayer
        return
    elseif (TeamState == 6) then
        Talk(1, "no", name .. "-hµnh trang ®· ®Çy, kh«ng thÓ nhËn Hép quµ t×nh c¶m.")
        local oldplayer = PlayerIndex
        PlayerIndex = Playeridx
        Msg2Player("Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ nhËn Hép quµ t×nh c¶m.")
        PlayerIndex = oldplayer
        return
    elseif (TeamState == 1) then
        MsgBox("B¹n x¸c nhËn tÆng Hép quµ t×nh c¶m cho <c=g>" .. name .. "<c> kh«ng?", "yesGift", "no")
    end
end

function CheakTeam(playerid)

    if (GetTeam() == 0) then
        return 2, 0
    else
        if (GetTeamSize() ~= 2) then
            return 3, 0
        else
            local oldPlayer = PlayerIndex
            local w, x, y = GetWorldPos()
            for i = 1, 2 do
                PlayerIndex = GetTeamMember(i)
                local mapid, x, y = GetWorldPos()

                if oldPlayer ~= PlayerIndex then
                    PlayerIndex = GetTeamMember(i)

                    if (GetLevel() < 30) then
                        return 4, GetTeamMember(i)

                    elseif GetTaskByte(Task_ChildrensDayReceiveNum, 4) >= 20 then
                        return 5, GetTeamMember(i)

                    elseif (IsHaveSpaceForTreasure(1) == 0) then
                        return 6, GetTeamMember(i)
                    else
                        return 1, GetTeamMember(i)
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

function yesGift()
    no()

    if (HaveNormalItem(6, 1, 837, 0) <= 0) then
        WriteLog("§¸nh lÊy hép quµ")
        return
    end

    DelNormalItem(6, 1, 837, 0)
    local playerid = PlayerIndex
    local TeamState, Playeridx = CheakTeam(playerid)

    PlayerIndex = Playeridx
    local name = GetName()
    PlayerIndex = playerid

    Talk(1, "no", "B¹n tÆng cho <c=g>" .. name .. "<c> 1 Hép quµ t×nh c¶m.")
    Msg2Player("B¹n tÆng cho ®ång ®éi 1 Hép quµ t×nh c¶m.")
    local oldnum = GetTaskByte(Task_ChildrensDayReceiveNum, 4)

    local PlayerID = GetPlayerID()
    local oldname = GetName()
    local playerid = PlayerIndex
    PlayerIndex = Playeridx
    AddNormalItem(6, 1, 838, 0, 0, 0)
    InfoBox("<c=g>" .. oldname .. "<c> tÆng cho b¹n 1 Hép quµ t×nh c¶m.")
    Msg2Player("B¹n nhËn ®­îc 1 Hép quµ t×nh c¶m.")
    local num = GetTaskByte(Task_ChildrensDayReceiveNum, 4)
    local playernum = GetTaskByte(Task_ChildrensDay, 3) + 1
    SetTaskByte(Task_ChildrensDayReceiveNum, 4, num + 1)
    if oldnum == playernum then
        SetTaskByte(Task_ChildrensDay, 3, playernum + 1)
        SetNpcTask(PlayerIndex, playernum + 1, PlayerID)
    else
        SetTaskByte(Task_ChildrensDay, 3, playernum)
        SetNpcTask(PlayerIndex, playernum, PlayerID)
    end
    PlayerIndex = playerid

end
