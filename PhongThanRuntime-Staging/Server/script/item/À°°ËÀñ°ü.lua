taskLaBa = 1673
taskPorridgeItem = 1674
taskLaBaOther = 1675
globalLaBa = 278

function GetPlayerTaskState()
    return 0, 0
end

function no()
    CloseDialog()
end

function main()

    local mapId, playerX, playerY = GetWorldPos()

    if (mapId ~= 21) then
        Msg2Player("H·y më lÔ bao L¹p B¸t t¹i TriÒu Ca")
        return
    end

    if (GetTaskByte(taskLaBaOther, 3) == 1) then
        SetTaskByte(taskLaBaOther, 3, 0)
        AddNormalItem(3, 90, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Hoµng b¶o th¹ch!")
        TopMessage("NhËn ®­îc 1 Hoµng b¶o th¹ch")
        SetGlobalValueByte(globalLaBa, 2, 1)
        WriteLog(GetName() .. "NÕu lµ ng­êi thø 100 trong ho¹t ®éng L¹p B¸t th× sÏ nhËn ®­îc mét Hoµng B¶o Th¹ch")
        local nSubWorldIdx = SubWorldID2Idx(21)
        if (nSubWorldIdx ~= -1) then
            AddGlobalCountNews(GetName() .. "Më Tói quµ L¹p B¸t nhËn ®­îc 1 viªn Hoµng b¶o th¹ch, thËt lµ may m¾n!", 1)
        end
        return
    end

    GetRandAward()
end

function GetRandAward()
    local randAward = 0
    local randMin = 1
    local randMax = 1000
    local nSubWorldIdx = SubWorldID2Idx(21)

    if (nSubWorldIdx == -1 or GetGlobalValueByte(globalLaBa, 2) >= 1) then
        randMax = 999
    end

    if (nSubWorldIdx == -1 or GetGlobalValueByte(globalLaBa, 3) >= 3) then
        randMin = 16
    end

    randAward = math.random(randMin, randMax)

    if (nSubWorldIdx ~= -1 and randAward >= 1 and randAward <= 15 and GetLevel() >= 50) then
        AddNormalItem(3, 88, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 m¶nh Hoµng thñy tinh!")
        TopMessage("NhËn ®­îc m¶nh Hoµng thñy tinh")
        local huangSuiNum = GetGlobalValueByte(globalLaBa, 3) + 1
        SetGlobalValueByte(globalLaBa, 3, huangSuiNum)
        AddGlobalCountNews(GetName() .. "Khi b¹n më lÔ bao L¹p B¸t sÏ nhËn ®­îc mét M¶nh Hoµng thuû tinh. Chóc phóc trong tÕt L¹p B¸t ®· mang l¹i rÊt nhiÒu may m¾n.", 1)
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn ®­îc M¶nh Hoµng thuû tinh")
    elseif (randAward > 15 and randAward <= 119) then
        AddNormalItem(3, 77, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 m¶nh Hång Thñy tinh!")
        TopMessage("NhËn ®­îc m¶nh Hång Thñy tinh")
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn ®­îc M¶nh Hång thñy tinh")
    elseif (randAward > 119 and randAward <= 209) then
        AddNormalItem(3, 78, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 m¶nh Lam Thñy tinh!")
        TopMessage("NhËn ®­îc m¶nh Lam Thñy tinh")
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn ®­îc M¶nh Lam thuû tinh")
    elseif (randAward > 209 and randAward <= 299) then
        AddNormalItem(3, 248, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 m¶nh Lôc Thñy tinh!")
        TopMessage("NhËn ®­îc m¶nh Lôc Thñy tinh")
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn ®­îc M¶nh Lôc thuû tinh")
    elseif (randAward > 299 and randAward <= 399) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Ph¸o hoa!")
        TopMessage("NhËn ®­îc 1 Ph¸o hoa")
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn ®­îc 1 Ph¸o hoa")
    elseif (randAward > 399 and randAward <= 699) then
        AddNormalItem(6, 1, 801, 0, 0, 0)
        local getExp = GetLevel() * 1000
        AddOwnExp(getExp)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Ph¸o L¹p B¸t (nhá) vµ " .. getExp .. " ®iÓm kinh nghiÖm!")
        TopMessage("NhËn ®­îc Ph¸o L¹p B¸t (nhá)")
        WriteLog(GetName() .. "Më Ph¸o L¹p B¸t, sÏ nhËn mét Ph¸o L¹p B¸t (nhá)")
    elseif (randAward > 699 and randAward <= 899) then
        AddNormalItem(6, 1, 802, 0, 0, 0)
        local getExp = GetLevel() * 1000
        AddOwnExp(getExp)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Ph¸o L¹p B¸t (trung) vµ " .. getExp .. " ®iÓm kinh nghiÖm!")
        TopMessage("NhËn ®­îc Ph¸o L¹p B¸t (trung)")
        WriteLog(GetName() .. "Më lÔ bao tÕt L¹p B¸t, sÏ nhËn mét Ph¸o L¹p B¸t (trung)")
    elseif (randAward > 899 and randAward <= 999) then
        AddNormalItem(6, 1, 803, 0, 0, 0)
        local getExp = GetLevel() * 1000
        AddOwnExp(getExp)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Ph¸o L¹p B¸t (lín) vµ " .. getExp .. " ®iÓm kinh nghiÖm!")
        TopMessage("NhËn ®­îc Ph¸o L¹p B¸t (lín)")
        WriteLog(GetName() .. "Më lÔ bao tÕt L¹p B¸t, sÏ nhËn mét Ph¸o L¹p B¸t (lín)")
    elseif (nSubWorldIdx ~= -1 and randAward == 1000 and GetLevel() >= 80) then
        AddNormalItem(3, 90, 0, 0, 0, 0)
        Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Hoµng b¶o th¹ch!")
        TopMessage("NhËn ®­îc 1 Hoµng b¶o th¹ch")
        SetGlobalValueByte(globalLaBa, 2, 1)
        local nSubWorldIdx = SubWorldID2Idx(21)
        if (nSubWorldIdx ~= -1) then
            AddGlobalCountNews(GetName() .. "Më Tói quµ L¹p B¸t nhËn ®­îc 1 viªn Hoµng b¶o th¹ch, thËt lµ may m¾n!", 1)
        end
        WriteLog(GetName() .. "Më lÔ bao trong tÕt L¹p B¸t, sÏ nhËn mét Hoµng B¶o Th¹ch")
    else
        GetRandAward()
    end
end
