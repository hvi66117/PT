require("³£ÓÃ»î¶¯.luax")

function no()
    CloseDialog()
end

gTbl_ItemList = {
    [1] = {
        { "Khai Thiªn Gi¸p", { 0, 2, 0, 8, }, },
        { "Tr¶m Long Gi¸p", { 0, 2, 0, 9, }, },
        { "Hoµng Kim ChÊn §¸n Gi¸p", { 0, 2, 0, 10, }, },
        { "<ChiÕn>Hoµng Kim ChÊn §¸n Gi¸p", { 0, 2, 42, 1, }, },
        { "Th«ng Thiªn §¹o Bµo", { 0, 2, 1, 8, }, },
        { "Nguyªn Thñy §¹o Bµo", { 0, 2, 1, 9, }, },
        { "Hång Qu©n §¹o Bµo", { 0, 2, 1, 10, }, },
        { "<ChiÕn>Hång Qu©n §¹o Bµo", { 0, 2, 43, 1, }, },
        { "Lam §iªu Hé Gi¸p", { 0, 2, 2, 8, }, },
        { "ThÇn ¦ng Hé Gi¸p", { 0, 2, 2, 9, }, },
        { "Kh¸ng Long Hé Gi¸p", { 0, 2, 2, 10, }, },
        { "<ChiÕn>Kh¸ng Long Hé Gi¸p", { 0, 2, 44, 1, }, },
    },
    [2] = {
        { "Khai Thiªn Yªu §¸i", { 0, 6, 0, 8, }, },
        { "Tr¶m Long Yªu §¸i", { 0, 6, 0, 9, }, },
        { "ChÊn §¸n Yªu §¸i", { 0, 6, 0, 10, }, },
        { "<ChiÕn>ChÊn §¸n Yªu §¸i", { 0, 6, 42, 1, }, },
        { "Th«ng Thiªn C©n", { 0, 6, 1, 8, }, },
        { "Nguyªn Thñy C©n", { 0, 6, 1, 9, }, },
        { "Hång Qu©n C©n", { 0, 6, 1, 10, }, },
        { "<Hång>Hång Qu©n C©n", { 0, 6, 43, 1, }, },
        { "Lam §iªu Yªu §¸i", { 0, 6, 2, 8, }, },
        { "ThÇn ¦ng Yªu §¸i", { 0, 6, 2, 9, }, },
        { "Kh¸ng Long Yªu §¸i", { 0, 6, 2, 10, }, },
        { "<ChiÕn>Cang Long Yªu §¸i", { 0, 6, 44, 1, }, },
    },
    [3] = {
        { "Khai Thiªn ChiÕn Ngoa", { 0, 5, 0, 8, }, },
        { "Tr¶m Long ChiÕn Ngoa", { 0, 5, 0, 9, }, },
        { "ChÊn §¸n ChiÕn Ngoa", { 0, 5, 0, 10, }, },
        { "<ChiÕn>ChÊn §¸n ChiÕn Ngoa", { 0, 5, 42, 1, }, },
        { "Th«ng Thiªn Lý", { 0, 5, 1, 8, }, },
        { "Nguyªn Thñy Lý", { 0, 5, 1, 9, }, },
        { "Hång Qu©n Lý", { 0, 5, 1, 10, }, },
        { "<ChiÕn>Hång Qu©n Lý", { 0, 5, 43, 1, }, },
        { "Lam §iªu Ngoa", { 0, 5, 2, 8, }, },
        { "ThÇn ¦ng Ngoa", { 0, 5, 2, 9, }, },
        { "Kh¸ng Long Ngoa", { 0, 5, 2, 10, }, },
        { "<ChiÕn>Cang Long Ngoa", { 0, 5, 44, 1, }, },
    },
    [4] = {
        { "Khai Thiªn Kh«i", { 0, 7, 0, 8, }, },
        { "Tr¶m Long Kh«i", { 0, 7, 0, 9, }, },
        { "ChÊn §¸n Kh«i", { 0, 7, 0, 10, }, },
        { "<ChiÕn>ChÊn §¸n Kh«i", { 0, 7, 42, 1, }, },
        { "Th«ng Thiªn Qu¸n", { 0, 7, 1, 8, }, },
        { "Nguyªn Thñy Qu¸n", { 0, 7, 1, 9, }, },
        { "Hång Qu©n Qu¸n", { 0, 7, 1, 10, }, },
        { "<ChiÕn>Hång Qu©n Qu¸n", { 0, 7, 43, 1, }, },
        { "Lam §iªu Trô", { 0, 7, 2, 8, }, },
        { "ThÇn ¦ng Trô", { 0, 7, 2, 9, }, },
        { "Kh¸ng Long Trô", { 0, 7, 2, 10, }, },
        { "<ChiÕn>Cang Long Trô", { 0, 7, 44, 1, }, },
    },
    [5] = {
        { "Khai Thiªn phi phong", { 0, 9, 0, 8, }, },
        { "Tr¶m Long phi phong", { 0, 9, 0, 9, }, },
        { "ChÊn §¸n phi phong", { 0, 9, 0, 10, }, },
        { "<ChiÕn>ChÊn §an Phi Phong", { 0, 9, 42, 1, }, },
        { "Th«ng Thiªn LÖnh", { 0, 9, 1, 8, }, },
        { "Nguyªn Thñy lÖnh", { 0, 9, 1, 9, }, },
        { "Hång Qu©n lÖnh", { 0, 9, 1, 10, }, },
        { "<ChiÕn>Hång Qu©n LÖnh", { 0, 9, 43, 1, }, },
        { "Lam §iªu KÕt", { 0, 9, 2, 8, }, },
        { "ThÇn ¦ng kÕt", { 0, 9, 2, 9, }, },
        { "Kh¸ng Long kÕt", { 0, 9, 2, 10, }, },
        { "<ChiÕn> Cang Long KÕt", { 0, 9, 44, 1, }, },
    },
}
function main()
    no()
    if (HaveNormalItem(6, 1, 941, 1) <= 0) then
        return
    end

    local tasks = {
        [1] = { "Trang bÞ tr¾ng cÊp 80", "item_1"; show = 1 },
        [2] = { "Trang bÞ tr¾ng cÊp 90", "item_2"; show = 1 },
        [3] = { "Trang bÞ tr¾ng cÊp 100", "item_3"; show = 1 },
        [4] = { "Trang bÞ tr¾ng cÊp 120", "item_4"; show = 1 },
    }
    SetTask(140, 0)
    SayTask("H·y chän lo¹i trang bÞ muèn ghÐp: \n trang bÞ tr¾ng ——2 m¶nh trang bÞ tr¾ng \n trang bÞ tr¾ng 90——5 m¶nh trang bÞ tr¾ng \n trang bÞ tr¾ng 100——10 m¶nh trang bÞ tr¾ng \n trang bÞ 120——50 m¶nh trang bÞ tr¾ng", tasks)
end

function item_1()
    item_Part(1)
end

function item_2()
    item_Part(2)
end

function item_3()
    item_Part(3)
end

function item_4()
    item_Part(4)
end

function item_Part(nLvl)
    CloseDialog()
    SetTask(141, nLvl)
    local nNum = {
        { 2, "Trang bÞ tr¾ng cÊp 80", },
        { 5, "Trang bÞ tr¾ng cÊp 90", },
        { 10, "Trang bÞ tr¾ng cÊp 100", },
        { 50, "Trang bÞ tr¾ng cÊp 120", },
    }
    if (nLvl <= 0 or nLvl > table.getn(nNum)) then
        Talk(1, "no", "Xin lçi, b¹n ®· chän sai, h·y chän l¹i.")
        return
    end

    if (HaveNormalItem(6, 1, 941, 1) < nNum[nLvl][1]) then
        Talk(1, "no", "Xin lçi, chÕ t¹o <c=g>" .. nNum[nLvl][2] .. "<c> cÇn <c=g>" .. nNum[nLvl][1] .. "<c> m¶nh trang bÞ tr¾ng.")
        return
    end

    local tasks = {
        [1] = { "Kh¶i gi¸p", "item_Part_1"; show = 1 },
        [2] = { "Yªu §¸i", "item_Part_2"; show = 1 },
        [3] = { "Giµy", "item_Part_3"; show = 1 },
        [4] = { "§Çu kh«i", "item_Part_4"; show = 1 },
        [5] = { "Phi Phong", "item_Part_5"; show = 1 },
    }
    SetTaskByte(140, 1, nLvl)
    SayTask("H·y chän trang bÞ cÇn ghÐp:", tasks)
end

function item_Part_1()
    item_select(1)
end

function item_Part_2()
    item_select(2)
end

function item_Part_3()
    item_select(3)
end

function item_Part_4()
    item_select(4)
end

function item_Part_5()
    item_select(5)
end

function item_select(nPart)
    CloseDialog()
    local nLvl = GetTaskByte(140, 1)
    local nNum = {
        { 2, "Trang bÞ tr¾ng cÊp 80", },
        { 5, "Trang bÞ tr¾ng cÊp 90", },
        { 10, "Trang bÞ tr¾ng cÊp 100", },
        { 50, "Trang bÞ tr¾ng cÊp 120", },
    }
    if (nLvl <= 0 or nLvl > table.getn(nNum) or nPart <= 0 or nPart > 5) then
        Talk(1, "no", "Xin lçi, b¹n ®· chän sai, h·y chän l¹i.")
        return
    end

    if (HaveNormalItem(6, 1, 941, 1) < nNum[nLvl][1]) then
        Talk(1, "no", "Xin lçi, chÕ t¹o <c=g>" .. nNum[nLvl][2] .. "<c> cÇn <c=g>" .. nNum[nLvl][1] .. "<c> m¶nh trang bÞ tr¾ng.")
        return
    end

    local tasks = {}
    for i = 1, 3 do
        tasks[i] = gTbl_ItemList[nPart][(i - 1) * 4 + nLvl][1] .. "/item_Series"
    end

    SetTaskByte(140, 2, nPart)
    Say("H·y chän trang bÞ cÇn ghÐp:", table.getn(tasks), tasks)
end

function item_Series(nSeries)
    CloseDialog()
    local nLvl = GetTaskByte(140, 1)
    local nPart = GetTaskByte(140, 2)
    local nNum = {
        { 2, "Trang bÞ tr¾ng cÊp 80", },
        { 5, "Trang bÞ tr¾ng cÊp 90", },
        { 10, "Trang bÞ tr¾ng cÊp 100", },
        { 50, "Trang bÞ tr¾ng cÊp 120", },
    }
    if (nLvl <= 0 or nLvl > table.getn(nNum) or nPart <= 0 or nPart > 5 or nSeries < 0 or nSeries > 3) then
        Talk(1, "no", "Xin lçi, b¹n ®· chän sai, h·y chän l¹i.")
        return
    end

    if (HaveNormalItem(6, 1, 941, 1) < nNum[nLvl][1]) then
        Talk(1, "no", "Xin lçi, chÕ t¹o <c=g>" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1] .. "<c> cÇn <c=g>" .. nNum[nLvl][1] .. "<c> m¶nh trang bÞ tr¾ng.")
        return
    end
    SetTaskByte(140, 3, nSeries)
    MsgBox("Muèn dïng <c=g>" .. nNum[nLvl][1] .. "<c> m¶nh trang bÞ tr¾ng ghÐp 1 <c=g>" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1] .. "<c> kh«ng?", "Yes_Item", "no")
end

function Yes_Item()
    CloseDialog()
    local nLvl = GetTaskByte(140, 1)
    local nPart = GetTaskByte(140, 2)
    local nSeries = GetTaskByte(140, 3)
    local nNum = {
        { 2, "Trang bÞ tr¾ng cÊp 80", },
        { 5, "Trang bÞ tr¾ng cÊp 90", },
        { 10, "Trang bÞ tr¾ng cÊp 100", },
        { 50, "Trang bÞ tr¾ng cÊp 120", },
    }
    if (nLvl <= 0 or nLvl > table.getn(nNum) or nPart <= 0 or nPart > 5 or nSeries < 0 or nSeries > 3) then
        Talk(1, "no", "Xin lçi, b¹n ®· chän sai, h·y chän l¹i.")
        return
    end

    if (HaveNormalItem(6, 1, 941, 1) < nNum[nLvl][1]) then
        Talk(1, "no", "Xin lçi, chÕ t¹o <c=g>" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1] .. "<c> cÇn <c=g>" .. nNum[nLvl][1] .. "<c> m¶nh trang bÞ tr¾ng.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ «, h·y s¾p xÕp l¹i råi h·y ghÐp.")
        return
    end

    for i = 1, nNum[nLvl][1] do
        DelNormalItem(6, 1, 941, 1)
    end
    local nItemID = gTbl_ItemList[nPart][nSeries * 4 + nLvl][2]
    AddNormalItem(nItemID[1], nItemID[2], nItemID[3], nItemID[4], 0, 1)

    MsgBox("Chóc mõng anh hïng ®· ghÐp 1 <c=g>" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1] .. "<c>! §ång ý ghÐp tiÕp <c=g>" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1] .. "<c>?", "Yes_Item", "no")

    WriteLog("Sö dông" .. nNum[nLvl][1] .. "m¶nh trang bÞ tr¾ng, ghÐp" .. gTbl_ItemList[nPart][nSeries * 4 + nLvl][1])

    if (GetTask(141) == 4 and UActivitie.Pub_IsInDate(1) > 0) then
        TemporaryVersion()
    end

end

function TemporaryVersion()
    for i = 1, 10 do
        AddNormalItemPile(6, 1, 941, 1, 0, 0, 1)
    end
    Msg2Player("Chóc mõng ngµi nhËn ®­îc °×É«×°±¸ËéÆ¬*10.")
    WriteLog("[ÁÙÊ±°æ±¾ »ñµÃ°×É«×°±¸ËéÆ¬x10]")
end

