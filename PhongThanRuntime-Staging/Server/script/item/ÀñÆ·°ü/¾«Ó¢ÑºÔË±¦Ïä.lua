Crystal = {
    [1] = { id = 77, name = "3 M¶nh Hång Thuû Tinh", num = 3 },
    [2] = { id = 78, name = "3 M¶nh Lam Thuû Tinh", num = 3 },
    [3] = { id = 248, name = "3 M¶nh Lôc Thuû Tinh", num = 3 },
    [4] = { id = 88, name = "1 c¸i M¶nh Hoµng Thuû Tinh", num = 1 },
    [5] = { id = 89, name = "1 c¸i Hoµng Thuû Tinh", num = 1 },
}

function getPrize(idx)
    for i = 1, Crystal[idx].num do
        AddNormalItemBind(3, Crystal[idx].id, 0, 0, 0, 0, 1)
    end
    ScrollMessage("NhËn ®­îc <c=y>" .. Crystal[idx].name .. "<c>")
end

NeedBageCount = 1
BoxName = "B¶o r­¬ng vËn l­¬ng Tinh Anh"
boxID = { 6, 1, 1540, 0 }
function no()
    CloseDialog()
end

function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBageCount) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng " .. NeedBageCount .. " h·y s¾p xÕp l¹i tói.")
        return
    end

    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local nExp = GetLevel() * 8000
    local str = "B¹n nhËn ®­îc " .. nExp .. " kinh nghiÖm, 200 ®iÓm tinh lùc"
    AddOwnExp(nExp)
    AddVigour(200)

    local r = math.random(1, 1000)
    if (r <= 340) then
        getPrize(3)
        str = str .. " vµ " .. Crystal[3].name
        Msg2Player(str)
        Talk(1, "no", "Chóc mõng " .. str)
    elseif (r >= 341) and (r <= 350) then

        if (HaveQualify(18) == 0) then
            ActiveTitleFunc(1)
            ActiveTitleQualify(18)
        end
        SetCurTitle(18)
        Talk(1, "no", "Chóc mõng " .. str .. " vµ <c=g>B¾t Quû Th¾ng Gi¶<c> danh hiÖu, hiÖu lùc 7 ngµy ")
        Msg2Player(str .. " vµ B¾t Quû Th¾ng Gi¶ danh hiÖu, hiÖu lùc 7 ngµy ")
        ScrollMessage("NhËn ®­îc <c=g>B¾t Quû Th¾ng Gi¶<c> danh hiÖu")
        str = str .. "B¾t Quû Th¾ng Gi¶"
    elseif (r >= 401) and (r <= 410) then

        if (HaveQualify(13) == 0) then
            ActiveTitleFunc(1)
            ActiveTitleQualify(13)
        end
        SetCurTitle(13)
        ScrollMessage("NhËn ®­îc <c=g>Hoµn Mü Th¾ng Gi¶<c> danh hiÖu")
        Talk(1, "no", "Chóc mõng " .. str .. " vµ <c=g>Hoµn Mü Th¾ng Gi¶<c> danh hiÖu, hiÖu lùc 7 ngµy ")
        Msg2Player(str .. " vµ Hoµn Mü Th¾ng Gi¶ danh hiÖu, hiÖu lùc 7 ngµy ")
        str = str .. "Hoµn Mü Th¾ng Gi¶"
    elseif (r >= 691) and (r <= 700) then

        if (HaveQualify(19) == 0) then
            ActiveTitleFunc(1)
            ActiveTitleQualify(19)
        end
        SetCurTitle(19)
        ScrollMessage("NhËn ®­îc <c=g>Quû KiÕn SÇu<c> danh hiÖu")
        Talk(1, "no", "Chóc mõng " .. str .. " vµ <c=g>Quû KiÕn SÇu<c> danh hiÖu, hiÖu lùc 7 ngµy ")
        Msg2Player(str .. " vµ Quû KiÕn SÇu danh hiÖu, hiÖu lùc 7 ngµy ")
        str = str .. "Quû KiÕn SÇu"
    elseif (r >= 701) and (r <= 950) then
        getPrize(2)
        str = str .. " vµ " .. Crystal[2].name
        Msg2Player(str)
        Talk(1, "no", "Chóc mõng " .. str)
    elseif (r >= 951) and (r <= 959) then
        getPrize(4)
        str = str .. " vµ " .. Crystal[4].name
        Msg2Player(str)
        Talk(1, "no", "Chóc mõng " .. str)
        AddGlobalCountNews(GetName() .. " ®­îc Phong ThÇn ban ph­íc, më B¶o r­¬ng vËn l­¬ng Tinh Anh, nhËn ®­îc 1 c¸i M¶nh Hoµng Thuû Tinh.", 3)
    elseif (r >= 999) and (r < 1000) then
        getPrize(5)
        str = str .. " vµ " .. Crystal[5].name
        Msg2Player(str)
        Talk(1, "no", "Chóc mõng " .. str)
        AddGlobalCountNews(GetName() .. " ®­îc Phong ThÇn ban ph­íc, më B¶o r­¬ng vËn l­¬ng Tinh Anh, nhËn ®­îc Hoµng Thuû Tinh 1 viªn .", 3)
    else
        getPrize(1)
        str = str .. " vµ " .. Crystal[1].name
        Msg2Player(str)
        Talk(1, "no", "Chóc mõng " .. str)
    end
    WriteLog("[B¶o r­¬ng vËn l­¬ng Tinh Anh]" .. str)
end

function no()
    CloseDialog()
end
