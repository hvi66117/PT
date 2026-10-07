require("newserver.luax")
changvariable = 1941

TablePage1 = {
    { name = "Danh hiÖu Vinh DiÖu T¸i ChiÕn", type = "Title", ID = 105, count = -1, taskbit = 1, needlevel = 10, lasttaskid = -1 },
    { name = "Trang bÞ lôc cÊp 20", type = "Type20", ID = {}, count = 1, taskbit = 2, needlevel = 20, lasttaskid = 1 },
    { name = "Phï nhiÖm vô chñ ®Ò ngµy", type = "item", ID = { 6, 1, 1005, 0 }, count = 2, taskbit = 3, needlevel = 30, lasttaskid = 2 },
    { name = "Kinh NghiÖm §¬n-Siªu cÊp", type = "item", ID = { 6, 1, 1355, 1 }, count = 5, taskbit = 4, needlevel = 40, lasttaskid = 3 },
    { name = "Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ", type = "buff", ID = { 1480 }, count = 1, bufftime = 2 * 3600, taskbit = 5, needlevel = 50, lasttaskid = 4 },
    { name = "Tói Vò khÝ Hoµng Kim cÊp 60", type = "item", ID = { 6, 1, 1135, 1 }, count = 1, taskbit = 6, needlevel = 60, lasttaskid = 5 },

}
TablePage2 = {
    { name = "Trang bÞ lôc cÊp 80", type = "Type80", ID = {}, count = 1, taskbit = 7, needlevel = 70, lasttaskid = 6 },
    { name = "S¸ch Ch­ HÇu (M¶nh)", type = "item", ID = { 8, 193, 5, 0 }, count = 2, taskbit = 8, needlevel = 80, lasttaskid = 7 },
    { name = "Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ", type = "buff", ID = { 1480 }, count = 1, bufftime = 24 * 3600, taskbit = 9, needlevel = 90, lasttaskid = 8 },
    { name = "Ngäc Thanh ThÇn Tiªn T¸n", type = "item", ID = { 8, 375, 0, 0 }, count = 2, taskbit = 10, needlevel = 100, lasttaskid = 9 },
    { name = "Tói Quµ Danh Ngäc", type = "item", ID = { 8, 1447, 2, 0 }, count = 1, taskbit = 11, needlevel = 110, lasttaskid = 10 },
    { name = "Vi Quang Qu¸i Phï", type = "item", ID = { 3, 374, 0, 0 }, count = 2, taskbit = 12, needlevel = 120, lasttaskid = 11 },
}

BoxName = "Quµ M¸y chñ míi"
boxID = { 6, 1, 1546, 1 }

function main()


    if (jieshu() == 1) then
        Talk(1, "no", "B¹n ®· nhËn hÕt phÇn th­ëng trong tói quµ!")
        return 0
    end

    tasks = {
        { "Trang 1", "page1"; show = 1 },
        { "Trang 2", "page2"; show = 1 },
        { "Quay l¹i", "no"; show = 1 },
    }
    SayTask("LÔ bao m¸y chñ m¬i, kú tr©n dÞ b¶o lµ dµnh cho ngµi!<enter>CÊp ®é cµng cao, nhËn cµng nhiÒu phÇn th­ëng!<enter>H·y nhËn th­ëng theo thø tù!", tasks)
end
function page1()
    local opra = {}
    local tmpstr = ""
    local nLevel = GetLevel()
    local tmpItem = {}
    for i = 1, table.getn(TablePage1) do
        tmpItem = TablePage1[i]
        if (tmpItem.type == "Title" or tmpItem.type == "Money") then
            tmpstr = tmpItem.name .. "(cÊp yªu cÇu: " .. tmpItem.needlevel
        else
            tmpstr = tmpItem.name .. 'x' .. tmpItem.count .. "(cÊp yªu cÇu: " .. tmpItem.needlevel
        end

        if (GetTaskBit(changvariable, tmpItem.taskbit) == 0) then
            tmpstr = tmpstr .. ", <c=g>Ch­a nhËn<c>)"
        else
            tmpstr = tmpstr .. ", <c=r>§· nhËn<c>)"
        end

        opra[table.getn(opra) + 1] = tmpstr .. "/selectItem1"
    end
    opra[table.getn(opra) + 1] = "Trang tr­íc/main"
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function page2()
    local opra = {}
    local tmpstr = ""
    local nLevel = GetLevel()
    local tmpItem = {}
    for i = 1, table.getn(TablePage2) do
        tmpItem = TablePage2[i]
        if (tmpItem.type == "Title" or tmpItem.type == "Money") then
            tmpstr = tmpItem.name .. "(cÊp yªu cÇu: " .. tmpItem.needlevel
        else
            tmpstr = tmpItem.name .. 'x' .. tmpItem.count .. "(cÊp yªu cÇu: " .. tmpItem.needlevel
        end

        if (GetTaskBit(changvariable, tmpItem.taskbit) == 0) then
            tmpstr = tmpstr .. ", <c=g>Ch­a nhËn<c>)"
        else
            tmpstr = tmpstr .. ", <c=r>§· nhËn<c>)"
        end

        opra[table.getn(opra) + 1] = tmpstr .. "/selectItem2"
    end
    opra[table.getn(opra) + 1] = "Trang tr­íc/main"
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function selectItem1(nIndex)
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > table.getn(TablePage1)) then
        Talk(1, "no", "Xin lçi, chän sai h·y chän l¹i.")
        return
    end

    local tmpItem = TablePage1[nIndex]

    if (tmpItem.lasttaskid ~= -1 and GetTaskBit(changvariable, tmpItem.lasttaskid) ~= 1) then
        Talk(1, "no", "Xin lçi, h·y nhËn th­ëng theo thø tù. ")
        return
    end

    if (GetLevel() < tmpItem.needlevel) then
        Talk(1, "no", "Xin lçi, cÊp kh«ng tháa ®iÒu kiÖn, kh«ng thÓ nhËn. ")
        return
    end

    if (GetTaskBit(changvariable, tmpItem.taskbit) == 1) then
        Talk(1, "no", "Xin lçi, anh hïng ®· nhËn th­ëng, kh«ng thÓ nhËn thªm. ")
        return
    end

    if (tmpItem.count ~= -1 and IsHaveSpaceForTreasure(1 + tmpItem.count) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng " .. tmpItem.count .. " h·y s¾p xÕp l¹i tói.")
        return
    end

    SetTaskBit(changvariable, tmpItem.taskbit, 1)
    str = ""
    if (tmpItem.type == "Title") then
        ActiveTitleFunc(1)
        ActiveTitleQualify(tmpItem.ID)
        SetCurTitle(tmpItem.ID)
        str = tmpItem.name
    elseif (tmpItem.type == "Money") then
        Earn(tmpItem.ID)
        str = tmpItem.name
    elseif (tmpItem.type == "Type20") then
        local nRandType = math.random(5, 7)
        local nType = GetPlayerType() + 1
        if (nType == 1) then
            AddNormalItemBind(0, nRandType, 9, 1, 0, 0, 1)
        elseif (nType == 2) then
            AddNormalItemBind(0, nRandType, 10, 1, 0, 0, 1)
        else
            AddNormalItemBind(0, nRandType, 11, 1, 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    elseif (tmpItem.type == "Type80") then
        local nRandType = math.random(5, 7)
        local nType = GetPlayerType() + 1
        if (nType == 1) then
            AddNormalItemBind(0, nRandType, 9, 8, 0, 0, 1)
        elseif (nType == 2) then
            AddNormalItemBind(0, nRandType, 10, 8, 0, 0, 1)
        else
            AddNormalItemBind(0, nRandType, 11, 8, 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    elseif (tmpItem.type == "buff") then
        local lefttime = GetIBBuffLeftTimes(tmpItem.ID[1])
        local alltime = lefttime + tmpItem.bufftime
        RemoveIBBuff(tmpItem.ID[1])
        AddIBBuff(tmpItem.ID[1], alltime)
        str = "2 giê Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ."
    else
        for i = 1, tmpItem.count do
            AddNormalItemBind(tmpItem.ID[1], tmpItem.ID[2], tmpItem.ID[3], tmpItem.ID[4], 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    end
    Talk(1, "jieshu", "Ng­¬i ®· nhËn ®­îc " .. str)
end

function selectItem2(nIndex)
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > table.getn(TablePage2)) then
        Talk(1, "no", "Xin lçi, chän sai h·y chän l¹i.")
        return
    end

    local tmpItem = TablePage2[nIndex]

    if (tmpItem.lasttaskid ~= -1 and GetTaskBit(changvariable, tmpItem.lasttaskid) ~= 1) then
        Talk(1, "no", "Xin lçi, h·y nhËn th­ëng theo thø tù. ")
        return
    end

    if (GetLevel() < tmpItem.needlevel) then
        Talk(1, "no", "Xin lçi, cÊp kh«ng tháa ®iÒu kiÖn, kh«ng thÓ nhËn. ")
        return
    end

    if (GetTaskBit(changvariable, tmpItem.taskbit) == 1) then
        Talk(1, "no", "Xin lçi, anh hïng ®· nhËn th­ëng, kh«ng thÓ nhËn thªm. ")
        return
    end

    if (tmpItem.count ~= -1 and IsHaveSpaceForTreasure(1 + tmpItem.count) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng " .. tmpItem.count .. " h·y s¾p xÕp l¹i tói.")
        return
    end

    SetTaskBit(changvariable, tmpItem.taskbit, 1)
    str = ""
    if (tmpItem.type == "Title") then
        ActiveTitleFunc(1)
        ActiveTitleQualify(tmpItem.ID)
        SetCurTitle(tmpItem.ID)
        str = tmpItem.name
    elseif (tmpItem.type == "Money") then
        Earn(tmpItem.ID)
        str = tmpItem.name
    elseif (tmpItem.type == "Type20") then
        local nRandType = math.random(5, 7)
        local nType = GetPlayerType() + 1
        if (nType == 1) then
            AddNormalItemBind(0, nRandType, 9, 1, 0, 0, 1)
        elseif (nType == 2) then
            AddNormalItemBind(0, nRandType, 10, 1, 0, 0, 1)
        else
            AddNormalItemBind(0, nRandType, 11, 1, 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    elseif (tmpItem.type == "Type80") then
        local nRandType = math.random(5, 7)
        local nType = GetPlayerType() + 1
        if (nType == 1) then
            AddNormalItemBind(0, nRandType, 9, 8, 0, 0, 1)
        elseif (nType == 2) then
            AddNormalItemBind(0, nRandType, 10, 8, 0, 0, 1)
        else
            AddNormalItemBind(0, nRandType, 11, 8, 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    elseif (tmpItem.type == "buff") then
        local lefttime = GetIBBuffLeftTimes(tmpItem.ID[1])
        local alltime = lefttime + tmpItem.bufftime
        RemoveIBBuff(tmpItem.ID[1])
        AddIBBuff(tmpItem.ID[1], alltime)
        str = "1 ngµy Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ."
    else
        for i = 1, tmpItem.count do
            AddNormalItemBind(tmpItem.ID[1], tmpItem.ID[2], tmpItem.ID[3], tmpItem.ID[4], 0, 0, 1)
        end
        str = tmpItem.count .. " c¸i " .. tmpItem.name
    end
    Talk(1, "jieshu", "Ng­¬i ®· nhËn ®­îc " .. str)
end

function jieshu()
    CloseDialog()
    for i = 1, 12 do
        if (GetTaskBit(changvariable, i) == 0) then
            return 0
        end
    end
    DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])
    ClearItem(boxID[1], boxID[2], boxID[3], 0)
    Talk(1, "no", "Anh hïng ®· nhËn hÕt phÇn th­ëng, con ®­êng <c=g>X­ng B¸ Phong ThÇn<c> l¹i tiÕn thªm 1 b­íc n÷a råi!")
    return 1
end

function no()
    CloseDialog()
end
