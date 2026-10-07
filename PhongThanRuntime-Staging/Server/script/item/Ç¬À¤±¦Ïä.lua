Task_Time = 1505
Task_Process = 1506

Task_CoorDinate = 1507
Task_PartnerID = 1508
Task_Distance = 1509

taskInfoIndex = 1090

Crystal = {
    [1] = { id = 77, name = "M¶nh Hång thñy tinh" },
    [2] = { id = 78, name = "M¶nh Lam thñy tinh" },
    [3] = { id = 248, name = "M¶nh Lôc Thñy tinh" },
    [4] = { id = 77, name = "M¶nh Hoµng thñy tinh" },
    [5] = { id = 77, name = "Hoµng thñy tinh" },
}

function getPrize(idx)
    local level = GetLevel()

    local zhuogui_exp = level * 6000
    if (level <= 80) then
        zhuogui_exp = level * 4000
    end

    for i = 1, 3 do
        AddNormalItemPile(3, Crystal[idx].id, 0, 0, 0, 0)
    end
    Talk(1, "no", "Chóc mõng! B¹n nhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 3 " .. Crystal[idx].name)
    Msg2Player("NhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 3 " .. Crystal[idx].name)

end

function main()
    if (GetTaskByte(Task_Process, 1) ~= 5) then
        Talk(1, "no", "Ngäc H­ Cung LÔ Quan cã thÓ gióp b¹n më b¶o r­¬ng.")
        return
    end

    ClearItem(6, 1, 541, 0)
    SetTaskByte(Task_Process, 1, 6)
    local level = GetLevel()

    local zhuogui_exp = level * 6000
    if (level <= 80) then
        zhuogui_exp = level * 4000
    end
    AddOwnExp(zhuogui_exp)
    local r = math.random(1, 1000)

    if (level >= 40) and (level <= 80) then
        if (r <= 400) then
            getPrize(3)
        elseif (r >= 401) and (r <= 900) then
            getPrize(1)
        elseif (r >= 901) and (r <= 1000) then
            getPrize(2)
        end
    elseif (level > 80) then
        if (r <= 350) then
            getPrize(3)
        elseif (r >= 351) and (r <= 700) then
            getPrize(1)
        elseif (r >= 701) and (r <= 950) then
            getPrize(2)
        elseif (r >= 951) and (r <= 995) then
            AddNormalItemPile(3, 88, 0, 0, 0, 0)
            Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 1 m¶nh Hoµng thñy tinh")
            Msg2Player("B¹n nhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 1 m¶nh Hoµng thñy tinh")
            AddGlobalCountNews(GetName() .. " nhËn ®­îc Phong thÇn chiÕu cè, më Cµn Kh«n B¶o R­¬ng, nhËn ®­îc 1 m¶nh Hoµng thñy tinh.", 3)
            WriteLog("[Ç¬À¤±¦Ïä] 1 c¸i M¶nh Hoµng Thuû Tinh")
        elseif (r >= 996) and (r <= 1000) then
            AddNormalItemPile(3, 89, 0, 0, 0, 0)
            Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 1 Hoµng thñy tinh")
            Msg2Player("B¹n nhËn ®­îc " .. zhuogui_exp .. " kinh nghiÖm vµ 1 Hoµng thñy tinh")
            AddGlobalCountNews(GetName() .. " nhËn ®­îc Phong thÇn chiÕu cè, më Cµn Kh«n B¶o R­¬ng, nhËn ®­îc 1 Hoµng thñy tinh.", 3)
            WriteLog("[Ç¬À¤±¦Ïä] 1 c¸i Hoµng Thuû Tinh")
        end
    end

    TaskNote(taskInfoIndex, -1)
end

function no()
    CloseDialog()
end
