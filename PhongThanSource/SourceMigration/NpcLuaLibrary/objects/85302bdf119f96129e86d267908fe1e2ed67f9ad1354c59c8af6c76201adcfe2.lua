require("common.luax")

require("Éñ½«ÏµÍ³.luax")
G_SUPERMANTASK_TYPE = 1
G_SUPERMANTASK_ID = 7

g_Horse = {
    [1] = { srcItem = { 0, 10, 0, 1 }, needItem = { 3, 29, 0, 0 }, showLevel = 10, eyeLevel = 1 },
    [2] = { srcItem = { 0, 10, 0, 2 }, needItem = { 3, 30, 0, 0 }, showLevel = 15, eyeLevel = 2 },
    [3] = { srcItem = { 0, 10, 0, 3 }, needItem = { 3, 31, 0, 0 }, showLevel = 20, eyeLevel = 3 },
    [4] = { srcItem = { 0, 10, 0, 4 }, needItem = { 3, 32, 0, 0 }, showLevel = 25, eyeLevel = 4 },
    [5] = { srcItem = { 0, 10, 0, 5 }, needItem = { 3, 33, 0, 0 }, showLevel = 30, eyeLevel = 5 },
    [6] = { srcItem = { 0, 10, 0, 6 }, needItem = { 3, 42, 0, 0 }, showLevel = 35, eyeLevel = 6 },
    [7] = { srcItem = { 0, 10, 0, 7 }, needItem = { 3, 43, 0, 0 }, showLevel = 40, eyeLevel = 7 },
    [8] = { srcItem = { 0, 10, 0, 8 }, needItem = { 3, 44, 0, 0 }, showLevel = 45, eyeLevel = 8 },
    [9] = { srcItem = { 0, 10, 0, 9 }, needItem = { 3, 45, 0, 0 }, showLevel = 50, eyeLevel = 9 },
    [10] = { srcItem = { 0, 10, 0, 10 }, needItem = { 3, 46, 0, 0 }, showLevel = 55, eyeLevel = 10 },
    [11] = { srcItem = { 0, 10, 3, 10 }, needItem = { 3, 47, 0, 0 }, showLevel = 60, eyeLevel = 11 },
    [12] = { srcItem = { 0, 10, 4, 10 }, needItem = { 3, 48, 0, 0 }, showLevel = 70, eyeLevel = 12 },
    [13] = { srcItem = { 0, 10, 5, 10 }, needItem = { 3, 49, 0, 0 }, showLevel = 80, eyeLevel = 13 },


    [14] = { srcItem = { 0, 10, 1, 1 }, needItem = { 3, 29, 0, 0 }, showLevel = 10, eyeLevel = 1 },
    [15] = { srcItem = { 0, 10, 1, 2 }, needItem = { 3, 30, 0, 0 }, showLevel = 15, eyeLevel = 2 },
    [16] = { srcItem = { 0, 10, 1, 3 }, needItem = { 3, 31, 0, 0 }, showLevel = 20, eyeLevel = 3 },
    [17] = { srcItem = { 0, 10, 1, 4 }, needItem = { 3, 32, 0, 0 }, showLevel = 25, eyeLevel = 4 },
    [18] = { srcItem = { 0, 10, 1, 5 }, needItem = { 3, 33, 0, 0 }, showLevel = 30, eyeLevel = 5 },
    [19] = { srcItem = { 0, 10, 1, 6 }, needItem = { 3, 42, 0, 0 }, showLevel = 35, eyeLevel = 6 },
    [20] = { srcItem = { 0, 10, 1, 7 }, needItem = { 3, 43, 0, 0 }, showLevel = 40, eyeLevel = 7 },
    [21] = { srcItem = { 0, 10, 1, 8 }, needItem = { 3, 44, 0, 0 }, showLevel = 45, eyeLevel = 8 },
    [22] = { srcItem = { 0, 10, 1, 9 }, needItem = { 3, 45, 0, 0 }, showLevel = 50, eyeLevel = 9 },
    [23] = { srcItem = { 0, 10, 1, 10 }, needItem = { 3, 46, 0, 0 }, showLevel = 55, eyeLevel = 10 },
    [24] = { srcItem = { 0, 10, 6, 10 }, needItem = { 3, 47, 0, 0 }, showLevel = 60, eyeLevel = 11 },
    [25] = { srcItem = { 0, 10, 7, 10 }, needItem = { 3, 48, 0, 0 }, showLevel = 70, eyeLevel = 12 },
    [26] = { srcItem = { 0, 10, 8, 10 }, needItem = { 3, 49, 0, 0 }, showLevel = 80, eyeLevel = 13 },


    [27] = { srcItem = { 0, 10, 2, 1 }, needItem = { 3, 29, 0, 0 }, showLevel = 10, eyeLevel = 1 },
    [28] = { srcItem = { 0, 10, 2, 2 }, needItem = { 3, 30, 0, 0 }, showLevel = 15, eyeLevel = 2 },
    [29] = { srcItem = { 0, 10, 2, 3 }, needItem = { 3, 31, 0, 0 }, showLevel = 20, eyeLevel = 3 },
    [30] = { srcItem = { 0, 10, 2, 4 }, needItem = { 3, 32, 0, 0 }, showLevel = 25, eyeLevel = 4 },
    [31] = { srcItem = { 0, 10, 2, 5 }, needItem = { 3, 33, 0, 0 }, showLevel = 30, eyeLevel = 5 },
    [32] = { srcItem = { 0, 10, 2, 6 }, needItem = { 3, 42, 0, 0 }, showLevel = 35, eyeLevel = 6 },
    [33] = { srcItem = { 0, 10, 2, 7 }, needItem = { 3, 43, 0, 0 }, showLevel = 40, eyeLevel = 7 },
    [34] = { srcItem = { 0, 10, 2, 8 }, needItem = { 3, 44, 0, 0 }, showLevel = 45, eyeLevel = 8 },
    [35] = { srcItem = { 0, 10, 2, 9 }, needItem = { 3, 45, 0, 0 }, showLevel = 50, eyeLevel = 9 },
    [36] = { srcItem = { 0, 10, 2, 10 }, needItem = { 3, 46, 0, 0 }, showLevel = 55, eyeLevel = 10 },
    [37] = { srcItem = { 0, 10, 9, 10 }, needItem = { 3, 47, 0, 0 }, showLevel = 60, eyeLevel = 11 },
    [38] = { srcItem = { 0, 10, 10, 10 }, needItem = { 3, 48, 0, 0 }, showLevel = 70, eyeLevel = 12 },
    [39] = { srcItem = { 0, 10, 11, 10 }, needItem = { 3, 49, 0, 0 }, showLevel = 80, eyeLevel = 13 },
}

TaskTimes = {
    [1] = { totalTimes = 630, awardsTimes = 5, },
    [2] = { totalTimes = 390, awardsTimes = 4, },
    [3] = { totalTimes = 270, awardsTimes = 3, },
    [4] = { totalTimes = 210, awardsTimes = 2, },
    [5] = { totalTimes = 180, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1699
G_Double = 370

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 39
    if (GetLevel() >= startLevel) then
        local UTask_xq_1 = GetTask(51)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_xq_1 == 0) then
                state = 1
                subState = 0
            elseif (UTask_xq_1 == 4) and (HaveEventItem(37) >= 1) then
                state = 3
                subState = 0
            elseif (UTask_xq_1 >= 1 and UTask_xq_1 <= 4) then
                state = 2
                subState = 0
            end
        else
            if (UTask_xq_1 == 0) then
                state = 1
                subState = 1
            elseif (UTask_xq_1 == 4) and (HaveEventItem(37) >= 1) then
                state = 3
                subState = 1
            elseif (UTask_xq_1 >= 1 and UTask_xq_1 <= 4) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 95
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1139, 1)
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if ((GetTaskByte(1139, 3) == 0) and (thisday ~= lastday)) then
                state = 1
                subState = 0
            end
        else
            if ((GetTaskByte(1139, 3) == 0) and (thisday ~= lastday)) then
                state = 1
                subState = 1
            end
        end
        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

require("themeday_human.luax")

function main()
    tasks = {
        { "Tèng Töu", "renwu95"; show = 0 },
        { "Phi Tiªn", "renwu1"; show = 0 },
        { "B¸ L¹c Nh·n", "yan"; show = 0 },
        { "Trïng Méc", "renwu2"; show = 0 },
        { "Trïng sinh", "renwu0_HM"; show = 1 },
        { "T©n Thñ tÇm b¶o", "renwu4"; show = 0 },

        { "Ho¹t ®éng 1-5", "Acctive51"; show = 0 },

    }

    if (IsAcctive51Open() > 0) then
        tasks[7].show = 1
    end

    if (GetLevel() >= 95) then
        tasks[1].show = 1
    end

    UTask_xq_1 = GetTask(51);
    if (UTask_xq_1 == 4) and (HaveEventItem(37) >= 1) then
        tasks[2].show = 1;
    end ;
    if (UTask_xq_1 == 0) and (GetLevel() >= 39) then
        tasks[2].show = 1;
    end ;
    if (UTask_xq_1 == 5) then
        tasks[3].show = 1;
    end ;
    if (GetLevel() >= 19) then
        tasks[4].show = 1;
    end ;
    if (GetTask(344) == 2) then
        tasks[6].show = 1;
    end ;

    SayTask("Xin chµo, nÕu ng­¬i gióp ta hoµn thµnh nhiÖm vô <c=g>Tèng Töu<c>, ta sÏ cã phÇn th­ëng hËu hÜnh ®ång thêi nhê MËt Th¸m ë BÝch Du cung tÇng 5 ban phóc cho ng­¬i!", tasks)
end;

IBItemIndex2_HM = {
    { name = "B¸ L¹c KÝnh cÊp 10", ItemIndex = 17 },
    { name = "B¸ L¹c KÝnh cÊp 11", ItemIndex = 18 },
    { name = "B¸ L¹c KÝnh cÊp 12", ItemIndex = 19 },
    { name = "B¸ L¹c KÝnh cÊp 13", ItemIndex = 20 },
    { name = "B¸ L¹c Minh KÝnh", ItemIndex = 133 },
    { name = "B¸ L¹c Linh KÝnh", ItemIndex = 134 },
}

function GetCostIB_HM(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex2_HM[nIndex].ItemIndex)
    return costIBNum
end

function GetCostDisIB_HM(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex2_HM[nIndex].ItemIndex)
    return costDisNum
end

function RealCostIB_HM(nIndex)
    local ret = CostCoinByIdx(IBItemIndex2_HM[nIndex].ItemIndex)
    return ret
end

function renwu0_HM()
    CloseDialog()
    Talk(2, "Select_Hourse", "NÕu ng­¬i cã thó c­ìi xanh cÊp 55 hoÆc cao h¬n vµ cã <color=green>B¸ L¹c KÝnh<color> cÊp t­¬ng ®­¬ng, hoÆc <color=green>Th«ng B¶o<color>, ta cã thÓ gióp ng­¬i trïng sinh B¸ L¹c Nh·n cÊp t­¬ng ®­¬ng, nh­ng dï thÕ nµo th× thó c­ìi còng kh«ng thÓ tiÕp tôc tån t¹i.", "H·y chän thó c­ìi b¹n muèn hoµn nguyªn.")
end

function Select_Hourse()
    CloseDialog()
    MouseSelect(1, 26, "renwu1_HM", "no")
end

function renwu1_HM(nItemID)

    local nGen = GetItemGen(nItemID)
    local nDetail = GetItemDetail(nItemID)
    local nPart = GetItemPartByID(nItemID)
    local nLevel = GetLevelByID(nItemID)
    local nLine = 0
    for i = 1, table.getn(g_Horse) do
        local arrySrcItem = g_Horse[i].srcItem
        if (nGen == arrySrcItem[1]) and (nDetail == arrySrcItem[2]) and (nPart == arrySrcItem[3]) and (nLevel == arrySrcItem[4]) then
            nLine = i
            break ;
        end
    end

    if (nLine <= 0) then
        Talk(1, "no", "VËt nµy kh«ng thÓ trïng sinh thµnh B¸ L¹c Nh·n.")
        return
    end

    if (GetEquipMagicType(nItemID) ~= 1) then
        Talk(1, "no", "ChØ thó c­ìi xanh míi cã thÓ trïng sinh thµnh B¸ L¹c Nh·n.")
        return
    end

    if (nLevel < 10) then
        Talk(1, "no", "HiÖn t¹i thó c­ìi cÊp " .. g_Horse[nLine].showLevel .. " kh«ng thÓ trïng sinh.")
        return
    end

    SetTask(141, nItemID)
    SetTaskByte(142, 1, nLine)
    local realIBCount = GetCostDisIB_HM(5)
    MsgBox("Trïng sinh B¸ L¹c Nh·n cÊp " .. g_Horse[nLine].eyeLevel .. " cÇn 1 <color=green>B¸ L¹c Minh KÝnh hoÆc " .. realIBCount .. " Th«ng B¶o<color>, ng­¬i ®· chuÈn bÞ hÕt ch­a?", "hecheng3_HM", "no")

end;

function hecheng3_HM()
    local nItemID = GetTask(141)
    local nLine = GetTaskByte(142, 1)

    local nGen = GetItemGen(nItemID)
    local nDetail = GetItemDetail(nItemID)
    local nPart = GetItemPartByID(nItemID)
    local nLevel = GetLevelByID(nItemID)

    if (nLine <= 0 or nLine > table.getn(g_Horse)) then
        Msg2Player("Sè hµng v­ît qu¸ ph¹m vi")
        return
    end

    local arrySrcItem = g_Horse[nLine].srcItem;
    if (nGen ~= arrySrcItem[1] or nDetail ~= arrySrcItem[2] or nPart ~= arrySrcItem[3] or nLevel ~= arrySrcItem[4]) then
        Msg2Player("Sè liÖu dÞ th­êng khi thao t¸c kh«ng ®ång bé.")
        return
    end

    if (GetEquipMagicType(nItemID) ~= 1) then
        Talk(1, "no", "ChØ thó c­ìi xanh míi cã thÓ trïng sinh thµnh B¸ L¹c Nh·n.")
        return
    end

    if (nLevel < 10) then
        Talk(1, "no", "HiÖn t¹i thó c­ìi cÊp " .. g_Horse[nLine].showLevel .. " kh«ng thÓ trïng sinh.")
        return
    end

    if (FindAValidIBItem(8, 167, 2, 0) >= 1) then
        CostIBItem(FindAValidIBItem(8, 167, 2, 0))
    elseif (FindAValidIBItem(8, 860, 2, 0) >= 1) then
        CostIBItem(FindAValidIBItem(8, 860, 2, 0))
    elseif (GetCoin() >= GetCostIB_HM(5)) then
        local nRet = RealCostIB_HM(5)
        if (nRet == 0) then
            Talk(1, "no", "KhÊu trõ Th«ng B¶o thÊt b¹i, ch­a thÓ trïng sinh B¸ L¹c!")
            return
        end
    else
        Talk(1, "no", "B¹n kh«ng ®ñ nguyªn liÖu, kh«ng thÓ trïng sinh.")
        return
    end

    DelItemByID(nItemID)
    local arryNeedItem = g_Horse[nLine].needItem
    AddNormalItemPile(arryNeedItem[1], arryNeedItem[2], arryNeedItem[3], arryNeedItem[4], 0, 0)
    Talk(1, "no", "§©y lµ B¸ L¹c Nh·n cña ng­¬i.")
    TopMessage("B¹n nhËn ®­îc <color=green>B¸ L¹c Nh·n cÊp " .. g_Horse[nLine].eyeLevel .. "<color>")
end;

function renwu3()
    if (HaveItem2(0, 10, 0, 1) >= 1) or (HaveItem2(0, 10, 1, 1) >= 1) or (HaveItem2(0, 10, 2, 1) >= 1) then
        MsgBox(11216, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 2) >= 1) or (HaveItem2(0, 10, 1, 2) >= 1) or (HaveItem2(0, 10, 2, 2) >= 1) then
        MsgBox(11217, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 3) >= 1) or (HaveItem2(0, 10, 1, 3) >= 1) or (HaveItem2(0, 10, 2, 3) >= 1) then
        MsgBox(11218, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 4) >= 1) or (HaveItem2(0, 10, 1, 4) >= 1) or (HaveItem2(0, 10, 2, 4) >= 1) then
        MsgBox(11219, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 5) >= 1) or (HaveItem2(0, 10, 1, 5) >= 1) or (HaveItem2(0, 10, 2, 5) >= 1) then
        MsgBox(11220, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 6) >= 1) or (HaveItem2(0, 10, 1, 6) >= 1) or (HaveItem2(0, 10, 2, 1) >= 6) then
        MsgBox(11221, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 7) >= 1) or (HaveItem2(0, 10, 1, 7) >= 1) or (HaveItem2(0, 10, 2, 7) >= 1) then
        MsgBox(11222, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 8) >= 1) or (HaveItem2(0, 10, 1, 8) >= 1) or (HaveItem2(0, 10, 2, 8) >= 1) then
        MsgBox(11223, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 9) >= 1) or (HaveItem2(0, 10, 1, 9) >= 1) or (HaveItem2(0, 10, 2, 9) >= 1) then
        MsgBox(11224, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 0, 10) >= 1) or (HaveItem2(0, 10, 1, 10) >= 1) or (HaveItem2(0, 10, 2, 10) >= 1) then
        MsgBox(11225, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 3, 10) >= 1) or (HaveItem2(0, 10, 4, 10) >= 1) or (HaveItem2(0, 10, 5, 10) >= 1) then
        MsgBox(11226, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 6, 10) >= 1) or (HaveItem2(0, 10, 7, 10) >= 1) or (HaveItem2(0, 10, 8, 10) >= 1) then
        MsgBox(11227, "hecheng3", "no")
    elseif (HaveItem2(0, 10, 9, 10) >= 1) or (HaveItem2(0, 10, 10, 10) >= 1) or (HaveItem2(0, 10, 11, 10) >= 1) then
        MsgBox(11228, "hecheng3", "no")
    else
        MsgBox(11229, "no")
    end ;
end;

function renwu2()
    MsgBox("GÇn ®©y ta rÊt nhí nhµ, l·nh ®Þa cña ta cã 1 lo¹i <color=red>LiÔu méc<color>. NÕu ng­¬i cã thÓ t×m ®­îc 3 c¸i, ta sÏ gióp ng­¬i dung hîp thó c­ìi tr¾ng trong hµnh trang víi B¸ L¹c Nh·n cÊp t­¬ng øng. H·y chän thó c­ìi muèn dung hîp.", "hecheng2", "no")
end;

function hecheng2()
    CloseDialog()
    MouseSelect(1, 26, "Select_Result", "no")
end

function Select_Result(nItemID)
    local nGen = GetItemGen(nItemID)
    local nDetail = GetItemDetail(nItemID)
    local nPart = GetItemPartByID(nItemID)
    local nLevel = GetLevelByID(nItemID)

    local nLine = 0

    if GetItemPosByID(nItemID) ~= 3 then
        Talk(1, "no", "ChØ thó c­ìi ®Æt trong hµnh trang míi cã thÓ hîp thµnh!")
        return
    end

    for i = 1, table.getn(g_Horse) do
        local srcItem = g_Horse[i].srcItem
        if (srcItem[1] == nGen) and (srcItem[2] == nDetail) and (srcItem[3] == nPart) and (srcItem[4] == nLevel) then
            nLine = i
            break ;
        end
    end

    if (nLine <= 0) then
        Talk(1, "no", "VËt nµy kh«ng thÓ hîp thµnh.")
        return
    end

    if (GetEquipMagicType(nItemID) ~= 0) then
        Talk(1, "no", "ChØ trang bÞ tr¾ng míi cã thÓ hîp thµnh.")
        return
    end

    if (GetItemCount(39) < 3) then
        Talk(1, "no", "Ng­¬i kh«ng cã ®ñ sè LiÔu méc cÇn thiÕt.")
        return
    end

    local arryNeedItem = g_Horse[nLine].needItem
    if (HaveNormalItem(arryNeedItem[1], arryNeedItem[2], arryNeedItem[3], arryNeedItem[4]) <= 0) then
        Talk(1, "no", "Ng­¬i kh«ng cã cÊp B¸ L¹c Nh·n t­¬ng øng.")
        return
    end

    local srcItem = g_Horse[nLine].srcItem
    DelNormalItem(arryNeedItem[1], arryNeedItem[2], arryNeedItem[3], arryNeedItem[4])
    DelNormalItem(srcItem[1], srcItem[2], srcItem[3], srcItem[4])

    for i = 1, 3 do
        DelEventItem(39)
    end

    local nNewItemID, szMagic = AddNormalItem2(srcItem[1], srcItem[2], srcItem[3], srcItem[4], 0)

    if (nNewItemID > 0) then
        SetTask(141, nNewItemID)
        SetTaskByte(142, 1, nLine)
        local realIBCount = GetCostDisIB_HM(5)
        Talk(1, "no", "Hîp thµnh <c=g>Thó c­ìi xanh cÊp " .. g_Horse[nLine].showLevel .. "<c> thµnh c«ng! Thuéc tÝnh hiÖn t¹i lµ: <\\n><c=wat>" .. szMagic .. "<c><\\n>.")
    end
end

function Go_On()
    CloseDialog()
    local realIBCount = GetCostDisIB_HM(5)
    local nLine = GetTaskByte(142, 1)
    local nItemID = GetTask(141)
    local nLevel = GetLevelByID(nItemID)

    if (nLevel >= 10) then
        MsgBox("Trïng sinh B¸ L¹c Nh·n cÊp " .. g_Horse[nLine].eyeLevel .. "-B¸ L¹c Nh·n cÇn 1 <color=green>B¸ L¹c Minh KÝnh hoÆc " .. realIBCount .. " Th«ng B¶o<color>, ng­¬i ®· chuÈn bÞ hÕt ch­a?", "hecheng3_HM", "no")
    end
end

function renwu1()
    UTask_xq_1 = GetTask(51);
    if (UTask_xq_1 == 4) and (HaveEventItem(37) >= 1) then
        Talk(1, "no", 10493)
        DelEventItem(37)
        Msg2Player("T×m ®­îc M¶nh L­u Tinh, Ng­êi T©y Vùc gióp b¹n hîp thµnh B¸ L¹c Nh·n.")
        TaskNote(22, 4)
        SetTask(51, 5)
        refreshNpcTaskState()
    end ;

    if (UTask_xq_1 == 0) and (GetLevel() >= 19) then
        MsgBox(10494, "yes_1", "no")
    end ;
end;

function yes_1()
    Talk(1, "no", 10495)
    Msg2Player("§Õn gÆp thÇy t­íng sè xem vËt g× lµ quý nhÊt.")
    TaskNote(22, 0)
    SetTask(51, 1)
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;

function yan()
    MsgBox(10496, "hecheng")
end;

function hecheng()
    if ((HaveNormalItem(0, 10, 0, 1) >= 1) and (HaveNormalItem(3, 29, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 1)
        DelNormalItem(3, 29, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 1, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 3, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 3, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 3, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 4, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 4, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 4, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 5, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 5, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 5, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 1) >= 1) and (HaveNormalItem(3, 29, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 1)
        DelNormalItem(3, 29, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 1, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 6, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 6, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 6, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 7, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 7, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 7, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 8, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 8, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 8, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 1) >= 1) and (HaveNormalItem(3, 29, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 1)
        DelNormalItem(3, 29, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 1, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 9, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 9, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 9, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 10, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 10, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 10, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 11, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 11, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 11, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoang Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    else
        Talk(1, "no", 10498)
    end ;
end;

function hecheng3()
    if (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 1) >= 1) and (GetCash() >= 300) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 1)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 1) >= 1) and (GetCash() >= 300) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 1)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 1) >= 1) and (GetCash() >= 300) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 1)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 2) >= 1) and (GetCash() >= 600) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 2)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
        else
            AddNormalItem(3, 30, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 2) >= 1) and (GetCash() >= 600) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 2)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
        else
            AddNormalItem(3, 30, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 2) >= 1) and (GetCash() >= 600) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 2)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 29, 0, 0, 0, 0)
        else
            AddNormalItem(3, 30, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 3) >= 1) and (GetCash() >= 1000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 3)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 30, 0, 0, 0, 0)
        else
            AddNormalItem(3, 31, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 3) >= 1) and (GetCash() >= 1000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 3)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 30, 0, 0, 0, 0)
        else
            AddNormalItem(3, 31, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 3) >= 1) and (GetCash() >= 1000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 3)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 30, 0, 0, 0, 0)
        else
            AddNormalItem(3, 31, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 4) >= 1) and (GetCash() >= 3000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 4)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 31, 0, 0, 0, 0)
        else
            AddNormalItem(3, 32, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 4) >= 1) and (GetCash() >= 3000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 4)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 31, 0, 0, 0, 0)
        else
            AddNormalItem(3, 32, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 4) >= 1) and (GetCash() >= 3000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 4)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 31, 0, 0, 0, 0)
        else
            AddNormalItem(3, 32, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 5) >= 1) and (GetCash() >= 6000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 5)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(6000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 32, 0, 0, 0, 0)
        else
            AddNormalItem(3, 33, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 5) >= 1) and (GetCash() >= 6000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 5)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(6000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 32, 0, 0, 0, 0)
        else
            AddNormalItem(3, 33, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 5) >= 1) and (GetCash() >= 6000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 5)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(6000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 32, 0, 0, 0, 0)
        else
            AddNormalItem(3, 33, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 6) >= 1) and (GetCash() >= 10000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 6)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(10000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 33, 0, 0, 0, 0)
        else
            AddNormalItem(3, 42, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 6) >= 1) and (GetCash() >= 10000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 6)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(10000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 33, 0, 0, 0, 0)
        else
            AddNormalItem(3, 42, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 6) >= 1) and (GetCash() >= 10000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 6)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(10000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 33, 0, 0, 0, 0)
        else
            AddNormalItem(3, 42, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 7) >= 1) and (GetCash() >= 30000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 7)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(30000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 42, 0, 0, 0, 0)
        else
            AddNormalItem(3, 43, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 7) >= 1) and (GetCash() >= 30000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 7)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(30000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 42, 0, 0, 0, 0)
        else
            AddNormalItem(3, 43, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 7) >= 1) and (GetCash() >= 30000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 7)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(30000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 42, 0, 0, 0, 0)
        else
            AddNormalItem(3, 43, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 8) >= 1) and (GetCash() >= 60000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 8)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(60000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 43, 0, 0, 0, 0)
        else
            AddNormalItem(3, 44, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 8) >= 1) and (GetCash() >= 60000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 8)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(60000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 43, 0, 0, 0, 0)
        else
            AddNormalItem(3, 44, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 8) >= 1) and (GetCash() >= 60000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 8)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(60000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 43, 0, 0, 0, 0)
        else
            AddNormalItem(3, 44, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 9) >= 1) and (GetCash() >= 100000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 9)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(100000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 44, 0, 0, 0, 0)
        else
            AddNormalItem(3, 45, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 9) >= 1) and (GetCash() >= 100000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 9)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(100000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 44, 0, 0, 0, 0)
        else
            AddNormalItem(3, 45, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 9) >= 1) and (GetCash() >= 100000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 9)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(100000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 44, 0, 0, 0, 0)
        else
            AddNormalItem(3, 45, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 10) >= 1) and (GetCash() >= 300000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 45, 0, 0, 0, 0)
        else
            AddNormalItem(3, 46, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 1, 10) >= 1) and (GetCash() >= 300000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 1, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 45, 0, 0, 0, 0)
        else
            AddNormalItem(3, 46, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 2, 10) >= 1) and (GetCash() >= 300000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 2, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 45, 0, 0, 0, 0)
        else
            AddNormalItem(3, 46, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 3, 10) >= 1) and (GetCash() >= 600000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 3, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 46, 0, 0, 0, 0)
        else
            AddNormalItem(3, 47, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 4, 10) >= 1) and (GetCash() >= 600000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 4, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 46, 0, 0, 0, 0)
        else
            AddNormalItem(3, 47, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 5, 10) >= 1) and (GetCash() >= 600000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 5, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(600000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 46, 0, 0, 0, 0)
        else
            AddNormalItem(3, 47, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 6, 10) >= 1) and (GetCash() >= 1000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 6, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 47, 0, 0, 0, 0)
        else
            AddNormalItem(3, 48, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 7, 10) >= 1) and (GetCash() >= 1000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 7, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 47, 0, 0, 0, 0)
        else
            AddNormalItem(3, 48, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 8, 10) >= 1) and (GetCash() >= 1000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 8, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(1000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 47, 0, 0, 0, 0)
        else
            AddNormalItem(3, 48, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 9, 10) >= 1) and (GetCash() >= 3000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 9, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 48, 0, 0, 0, 0)
        else
            AddNormalItem(3, 49, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 10, 10) >= 1) and (GetCash() >= 3000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 10, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 48, 0, 0, 0, 0)
        else
            AddNormalItem(3, 49, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    elseif (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 11, 10) >= 1) and (GetCash() >= 3000000) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 11, 10)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(3000000)
        local i = math.random(1, 4)
        if (i == 1) then
            AddNormalItem(3, 48, 0, 0, 0, 0)
        else
            AddNormalItem(3, 49, 0, 0, 0, 0)
            Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
        end ;
    else
        Talk(1, "no", 11234)
    end ;
end;

function renwu4()
    Talk(1, "xunbao", 11732)
end;

function xunbao()
    if (HaveNormalItem(0, 10, 0, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) then
        Talk(1, "no", 11733)
        DelNormalItem(0, 10, 0, 4)
        DelNormalItem(3, 32, 0, 0)
        AddNormalItem(0, 10, 0, 4, 0, 0)
        SetTask(344, 3)
        Msg2Player("B¹n nhËn ®­îc §éc Gi¸c Thó t¨ng thuéc tÝnh.")
    elseif (HaveNormalItem(0, 10, 1, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) then
        Talk(1, "no", 11733)
        DelNormalItem(0, 10, 1, 4)
        DelNormalItem(3, 32, 0, 0)
        AddNormalItem(0, 10, 1, 4, 0, 0)
        SetTask(344, 3)
        Msg2Player("B¹n nhËn ®­îc Th­¬ng ¦ng t¨ng thuéc tÝnh.")
    elseif (HaveNormalItem(0, 10, 2, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) then
        Talk(1, "no", 11733)
        DelNormalItem(0, 10, 2, 4)
        DelNormalItem(3, 32, 0, 0)
        AddNormalItem(0, 10, 2, 4, 0, 0)
        SetTask(344, 3)
        Msg2Player("B¹n nhËn ®­îc 1 B¹ch V©n Hå §iÖp t¨ng thuéc tÝnh.")
    else
        Talk(1, "no", 11734)
    end ;
end;

Task_Yiqi = 1532
TASK_renwu = 1139
TASK_Npcindex = 1140
TASK_Lucky = 1141

TASK_TIMES_Max = 4

item_guard = {
    [1] = { BoxNums = 3, ibnumber = 1, moneynumber = 1 },
    [2] = { BoxNums = 4, ibnumber = 1, moneynumber = 1 },
    [3] = { BoxNums = 9, ibnumber = 2, moneynumber = 2 },
    [4] = { BoxNums = 18, ibnumber = 4, moneynumber = 3 }
}

function renwu95()

    if (SUPERMAN.CheckTaskIsDoing(G_SUPERMANTASK_TYPE, G_SUPERMANTASK_ID) > 0) then
        Talk(1, "no", "Xin lçi, ®· cã ThÇn T­íng gióp ng­¬i lµm nhiÖm vô nµy råi, h·y ®Õn chç Sø Gi¶ ThÇn T­íng t¹i L·nh ®Þa nhËn th­ëng tr­íc.")
        return
    end

    if (GetTask(1139) == 0) then
        MsgBox("Huynh tr­ëng ta l­u l¹c tËn BÝch Du Cung t×m kho b¸u göi vÒ quª nhµ. Huynh Êy rÊt nghiÖn r­îu, ta th­êng nhê Chñ töu qu¸n göi r­îu cho huynh ta nhÊm nh­ng gÇn ®©y hay bÞ qu¸i vËt ®¸nh c­íp! Anh hïng cã thÓ gióp ta kh«ng?", "yes_95", "no")
    else
        local tasks1 = {
            { "Tèng Töu", "Acdept_taskVino"; show = 1 },
            { "§æi Phong Ma BÝch", "BiToExp"; show = 1 },
        }

        local index = 6
        for i = 1, 6 do
            if (GetTask(1142) >= TaskTimes[i].totalTimes) then
                SetTaskByte(Double_Optimization, 2, TaskTimes[i].awardsTimes)
                index = i
                break
            end
        end
        local str = ""
        if (GetGlobalValueByte(G_Double, 4) == 1) then
            if (index > 1) then
                str = "B¹n ®· hoµn thµnh nhiÖm vô thø <c=g>" .. GetTask(1142) .. "<c>, <c=r>nÕu sè nhiÖm vô hoµn thµnh ®¹t" .. TaskTimes[index - 1].totalTimes .. " lÇn, b¹n sÏ nhËn ®­îc phÇn th­ëng hÊp dÉn h¬n.<c>"
            else
                str = "<c=r>Mçi quyÓn b¹n cã 5 ngµy cã thÓ nh©n ®«i phÇn th­ëng!<c>"
            end
        end
        SayTask("Ta nhê <c=g>Chñ töu qu¸n ë BÝch Du tÇng 3<c> chuyÓn Ýt r­îu cho huynh tr­ëng, ng­¬i cã thÓ ®Õn <c=g>chç ta<c> hoÆc trùc tiÕp ®Õn <c=g>BÝch Du tÇng 3 gÆp Chñ töu qu¸n<c> nhËn nhiÖm vô <c=g>Tèng Töu<c>. NÕu ng­¬i cã <c=yel>Phong Ma BÝch<c>, cã thÓ ®æi  kinh nghiÖm ë chç ta!" .. str, tasks1)

    end
end

function yes_95()
    Msg2Player("§Õn BÝch Du Cung tÇng 3 t×m Chñ töu qu¸n T©y Vùc.")
    SetTask(1139, SetByte(0, 3, 1))
    renwu95()

end

function BiToExp()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1166, 1)
    if (thisday ~= lastday) then
        SetTask(1166, SetByte(0, 1, thisday))
    end
    local duihuanN = GetTaskByte(1166, 2)

    if (duihuanN < 2) then
        if (HaveNormalItem(3, 176, 0, 0) >= 1) then
            MsgBox("1 Phong Ma BÝch ®æi ®­îc <c=g>" .. (GetLevel() * 30000) .. "<c> kinh nghiÖm, muèn ®æi ngay?", "BiToExp1", "no")
        else
            Talk(1, "no", "Ng­¬i kh«ng cã <c=r>Phong Ma BÝch<c>! H·y dïng 20 m¶nh Phong Ma BÝch ®Õn XÝch Tïng Tö ghÐp l¹i sÏ cã h¬ héi nhËn ®­îc Phong Ma BÝch.")
        end
    else
        Talk(1, "no", "PhÇn th­ëng cña ta cã h¹n, mçi ngµy mçi ng­êi chØ ®­îc ®æi Phong Ma BÝch <c=g>2 lÇn<c>. H«m nay ng­¬i ®· ®æi hÕt råi, mai h·y ®Õn n÷a nhÐ!")
    end
end

function BiToExp1()
    if (HaveNormalItem(3, 176, 0, 0) >= 1) then
        DelNormalItem(3, 176, 0, 0)
        local exp1 = GetLevel() * 30000
        AddOwnExp(exp1)

        local duihuanN = GetTaskByte(1166, 2) + 1
        SetTaskByte(1166, 2, duihuanN)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. exp1 .. " ®iÓm kinh nghiÖm.")
        Talk(1, "no", "H·y nhËn lÊy <c=g>®iÓm kinh nghiÖm" .. exp1 .. "<c>, ®©y lµ thï lao cña ng­¬i, h·y nhËn lÊy.")
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=r>Phong Ma BÝch<c>! H·y dïng 20 m¶nh Phong Ma BÝch ®Õn XÝch Tïng Tö ghÐp l¹i sÏ cã h¬ héi nhËn ®­îc Phong Ma BÝch.")
    end
end

function Yes_AcceptDouble()
    local nTimes = GetTaskByte(Double_Optimization, 1)
    local taskDay = GetWeekDay()

    SetTaskByte(Double_Optimization, 1, nTimes + 1)
    SetTaskByte(Double_Optimization, 3, taskDay)
    taskVino()

end

function No_AcceptDouble()
    Talk(1, "taskVino", "NÕu trong tuÇn kh«ng ®Õn nhËn, phÇn th­ëng nh©n ®«i sÏ bÞ mÊt.")
end

function Acdept_taskVino()
    local taskDay = GetWeekDay()
    if (GetGlobalValueByte(G_Double, 4) == 0) then
        SetTask(Double_Optimization, 0)
    end
    if (GetGlobalValueByte(G_Double, 4) == 1 and taskDay > GetTaskByte(Double_Optimization, 3)) then
        SetTaskByte(Double_Optimization, 3, 0)
    end

    if (GetGlobalValueByte(G_Double, 4) == 1 and GetTaskByte(Double_Optimization, 4) ~= taskDay and GetTaskByte(Double_Optimization, 1) < GetTaskByte(Double_Optimization, 2)) then
        MsgBox("TuÇn nµy b¹n sÏ cã <c=g>" .. GetTaskByte(Double_Optimization, 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· hÕt <c=g>" .. GetTaskByte(Double_Optimization, 1) .. "<c> ngµy. <c=r>H«m nay b¹n cã muèn nhËn phÇn th­ëng nh©n ®«i kh«ng?<c>", "Yes_AcceptDouble", "No_AcceptDouble")
        return 0
    end

    taskVino()
end

function taskVino()
    CloseDialog()
    local huanshu = GetTaskByte(TASK_renwu, 3)
    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()

    local taskDay = GetWeekDay()
    SetTaskByte(Double_Optimization, 4, taskDay)

    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end

    local guardindex = COMMON.reSetGuardIndex()
    if (guardindex > 0) then
        if (GetTaskByte(959, 1) >= 1) then
            Talk(1, "no", 14657)
        elseif (GetByte(GetTask(1238), 1) == 1 and HaveIBBuff(463) > 0) then
            Talk(1, "no", 14658)
        elseif (huanshu > 0) then
            Talk(1, "no", "Töu xa ®· giao råi, sao ng­¬i cßn ch­a ®i?")
        else
            Talk(1, "no", 14660)
        end
        return 0
    end

    local alltimes = GetTaskByte(1477, 3)

    if (thisday ~= lastday or huanshu == 1) then

        if (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
            MsgBox("C¸i ng­¬i cÇn ®Òu lµ r­îu th­îng h¹ng! GÇn ®©y qu¸i vËt c­íp bãc nhiÒu, hµng tån cßn rÊt Ýt, nªn gi¸ h¬i cao. CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. lastMoney .. "tB¹c, ng­¬i tr¶ næi kh«ng? NÕu x¸c nhËn, ta sÏ khÊu trõ Hång B¶o Th¹ch vµ b¹c, ®ång thêi chuyÓn ng­¬i ®Õn chç <c=g>Chñ töu qu¸n ë BÝch Du tÇng 3<c>.", "yesVino", "no")
        else
            Talk(1, "no", "C¸i ng­¬i cÇn ®Òu lµ r­îu th­îng h¹ng! GÇn ®©y qu¸i vËt c­íp bãc nhiÒu, hµng tån cßn rÊt Ýt, nªn gi¸ h¬i cao. CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. lastMoney .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        end
    elseif (times < TASK_TIMES_Max or alltimes >= addtimes) and (huanshu == 0) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹p tµi tu luyÖn", "yes_fsb"; show = 0 },
            { "L­u Ly B«i", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        else
            coin_renwu()
            return 0
        end

        if (times < TASK_TIMES_Max) then
            task[2].show = 1
        end
        SayTask("TÝch lòy hiÖn t¹i " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. " TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó chÕ t¹o xe r­îu <c=g>Hång B¶o Th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
    elseif (GetLevel() >= 95) and (huanshu > 0) then
        if (huanshu == 2) then
            MsgBox(14661, "quxiao", "no")
        elseif (huanshu == 3) then
            Talk(1, "no", 14662)
        else
            Talk(1, "no", 14663)
        end
    elseif (times >= TASK_TIMES_Max) and (thisday == lastday) then
        Talk(1, "no", "H«m nay ®· hé tèng ®­îc " .. TASK_TIMES_Max .. "LÇn, do kho chøa cã h¹n, mçi ngµy mçi ng­êi chØ ®­îc chuyÓn r­îu" .. TASK_TIMES_Max .. " lÇn, cho nªn ngµy kh¸c anh hïng h·y ®Õn!")
        TaskNote(55, -1)
        SyncBibleState(55, 3, 1)
    end

end;

function yesVino()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local tasks = {
        { "Xe chuyÓn r­îu", "yesVino_1"; show = 1 },
        { "<c=g>ThÇn ThuËt", "yiqiBuff_4"; show = 1 },
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>Th«ng B¶o, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

function yesVino_1()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    SetTask(TASK_Npcindex, 1)
    if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
        yiqiBuff_1()
    else
        yiqiBuff_2()
    end
end

function yiqiBuff_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_4", "yesVino_2")
    else
        yesVino_2()
    end
end

function costYiqi_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yesVino_2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_1", "yes1")
    else
        yes1()
    end
end

function yiqiBuff_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_2", "yes2")
    else
        yes2()
    end
end

function costYiqi_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes1()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function costYiqi_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yesVino_2()
    CloseDialog()
    SetTask(TASK_Npcindex, 2)
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local ib379 = FindAValidIBItem(8, 379, 2, 0)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    if (ib379 ~= 0) then
        if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
            if (yes1() ~= 1) then
                return 0
            end
        else
            if (yes2() ~= 1) then
                return 0
            end
        end

        CostIBItem(ib379)
        Msg2Player("B¹n nép ThÇn ThuËt cho Ng­êi T©y Vùc, cã thÓ nhËn ®­îc Xe chuyÓn r­îu cao cÊp ë chç Chñ töu qu¸n BÝch Du tÇng 3.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    elseif (GetCoin() >= Cv) then
        if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
            if (yes1() ~= 1) then
                return 0
            end
        else
            local _, Cv1, Cfs1 = GetCostCoinInfoByIdx(66)
            local ib378 = FindAValidIBItem(8, 378, 2, 0)
            local itemib378 = HaveNormalItem(8, 378, 2, 0)
            local temp = GetTaskByte(TASK_renwu, 2) + 1
            local times, addtimes = todayfreetimes(temp)
            if (times >= TASK_TIMES_Max) then
                times = TASK_TIMES_Max
            end
            local costtimes = item_guard[times].ibnumber

            if (ib378 >= 1 and itemib378 >= costtimes) or (GetCoin() >= (Cv + Cv1 * costtimes)) or (ib378 >= 1 and GetCoin() >= (Cv + Cv1 * (costtimes - itemib378))) then
                if (yes2() ~= 1) then
                    return 0
                end
            else
                Msg2Player("Kh«ng ®ñ vËt liÖu!")
                Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
                return 0
            end
        end

        CostCoinByIdx(67)
        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o, nhËn ®­îc Xe chuyÓn r­îu cao cÊp ë chç Chñ töu qu¸n BÝch Du tÇng 3.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)

    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
    end
end

function yes1()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)
        return 0
    end

    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()
    if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
        times = 1
    else
        pm = pm * item_guard[times].moneynumber
    end

    local scores = GetHelpScore()
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end

    if (GetLevel() >= 95) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then

        if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
            SetTask(TASK_renwu, SetByte(0, 1, thisday))
            offlineTotimes()
            temp = 1
        end

        SetTaskByte(TASK_renwu, 2, temp)
        SetTaskWord(TASK_renwu, 2, 2)

        local scores = GetHelpScore()
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm

            Msg2Player("Dïng Tr¹ng th¸i nghÜa khÝ hñy nhiÖm vô Tèng Töu" .. change .. ".")
        elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm

            Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
        end

        Pay(pm)
        DelNormalItem(3, 79, 0, 0)

        SetTask(TASK_Lucky, 0)
        SetTaskByte(Task_Yiqi, 2, 1)
        SetTaskByte(Task_Yiqi, 3, 1)

        RemoveIBBuff(376)
        RemoveIBBuff(377)
        AddIBBuff(376)

        local exp1 = GetLevel() * 1000
        AddOwnExp(exp1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

        Msg2Player("H«m nay lµ lÇn thø " .. times .. " hé tèng Tèng Töu, nhËn Xe chuyÓn r­îu tõ Ng­êi T©y Vùc ë T©y Kú hoÆc ë chç Chñ töu qu¸n BÝch Du tÇng 3.")
        TaskNote(55, 0)

        if (times < TASK_TIMES_Max) then
            SyncBibleState(55, 2, 1)
        else
            SyncBibleState(55, 3, 1)
        end ;
        Msg2Player("H«m nay lµ lÇn thø " .. times .. " anh hïng hé tèng r­îu, nhËn Xe chuyÓn r­îu ë chç ta hoÆc ë chç Chñ töu qu¸n BÝch Du tÇng 3.")

        if (GetTaskByte(TASK_renwu, 2) == 1) and (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    else
        Talk(1, "no", " CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        return 0
    end
end

function yes2()
    CloseDialog()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("Tèng Töu")
    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local i = FindAValidIBItem(8, 378, 2, 0)
    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    if (times >= TASK_TIMES_Max) then
        times = TASK_TIMES_Max
    end

    local costtimes = item_guard[times].ibnumber
    local j = HaveNormalItem(8, 378, 2, 0)

    if (i ~= 0) and (j >= costtimes) then
        if (yes1() ~= 1) then
            return 0
        end
        for k = 1, costtimes do
            CostIBItem(FindAValidIBItem(8, 378, 2, 0))
        end
        Msg2Player("B¹n giao cho chñ qu¸n L­u Ly B«i" .. costtimes .. " C¸i, nhËn nhiÖm vô Tèng Töu míi.")

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    elseif (i ~= 0) and (GetCoin() >= Cv * (costtimes - j)) then
        if (yes1() ~= 1) then
            return 0
        end

        for k = 1, costtimes do
            i = FindAValidIBItem(8, 378, 2, 0)
            if (i ~= 0) then
                CostIBItem(i)
            else
                CostCoinByIdx(66)
            end
        end

        Cfs = (costtimes - j) * PriceName
        Msg2Player("B¹n giao cho chñ qu¸n L­u Ly B«i" .. j .. " C¸i vµ" .. Cfs .. " Th«ng B¶o, nhËn nhiÖm vô Tèng Töu míi!")

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    elseif (GetCoin() >= Cv * costtimes) then
        Cfs = costtimes * Cfs
        if (yes1() ~= 1) then
            return 0
        end

        for k = 1, costtimes do
            CostCoinByIdx(CostId)
        end

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o, nhËn nhiÖm vô Tèng Töu míi!")
        return 1
    else
        Talk(1, "no", " CÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, chuÈn bÞ ®ñ råi h·y ®Õn t×m ta!")
    end
    return 0

end

function coin_renwu()
    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("Tèng Töu")
    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName
    TaskNote(55, -1)
    local costtimes = item_guard[times].ibnumber
    local pm = payMoney() * item_guard[times].moneynumber
    Cv = (costtimes - HaveNormalItem(8, 378, 2, 0)) * Cv
    Cfs = costtimes * Cfs

    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end

    if (HaveNormalItem(8, 378, 2, 0) >= costtimes) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox(" Mçi ngµy mçi ng­êi chØ ®­îc cung cÊp nguyªn liÖu h¹n chÕ. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. " C¸i, ng­¬i cã muèn chuyÓn thªm lÇn n÷a kh«ng?", "yesVino", "no")
    elseif (GetCoin() >= Cv) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        local strValue = " Mçi ngµy mçi ng­êi chØ ®­îc cung cÊp nguyªn liÖu h¹n chÕ. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. (PriceName * costtimes) .. "<c>Th«ng B¶o, ng­¬i b»ng lßng kh«ng?"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        MsgBox(strValue, "yesVino", "no")

    else
        local strValue = " R­îu quý cã giíi h¹n, kh«ng ph¶i ai còng cã ®­îc! Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, chuÈn bÞ ®ñ råi h·y ®Õn t×m ta!"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        Talk(1, "no", strValue)
    end
end

function yes_fsb()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local tasks = {
        { "Xe chuyÓn r­îu", "yes_freefsb1"; show = 1 },
        { "<c=g>ThÇn ThuËt", "yiqiBuff_5"; show = 1 },
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>Th«ng B¶o, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

function yes_freefsb1()
    SetTask(TASK_Npcindex, 1)
    yiqiBuff_3()
end

function yiqiBuff_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ý chø?", "costYiqi_5", "yes_freefsb2")
    else
        yes_freefsb2()
    end
end

function costYiqi_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yes_freefsb2()
    CloseDialog()
    SetTask(TASK_Npcindex, 2)
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local ib379 = FindAValidIBItem(8, 379, 2, 0)
    if (ib379 ~= 0) then
        if (yes_freefsb() ~= 1) then
            return 0
        end

        CostIBItem(ib379)
        Msg2Player("TÆng ThÇn ThuËt cho ta, ta sÏ ®­a ng­¬i ®Õn Chñ Töu qu¸n ë tÇng 3 BÝch Du cung, t¹i ®ã ng­¬i cã thÓ nhËn Xe chuyÓn r­îu cao cÊp, vµ cã thÓ b¾t ®Çu nhiÖm vô VËn chuyÓn.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    elseif (GetCoin() >= Cv) then
        if (yes_freefsb() ~= 1) then
            return 0
        end
        CostCoinByIdx(67)
        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o cho ta, ta sÏ ®­a ng­¬i ®Õn Chñ Töu qu¸n ë tÇng 3 BÝch Du cung, t¹i ®ã ng­¬i cã thÓ nhËn Xe chuyÓn r­îu cao cÊp, vµ cã thÓ b¾t ®Çu nhiÖm vô VËn chuyÓn.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
    end
end

function yes_freefsb()
    CloseDialog()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)
        return 0
    end

    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)

    local scores = GetHelpScore()
    local pm = payMoney()
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm

    if (GetLevel() >= 95) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then

        for i = 1, 3 do
            if (GetBit(addtimes, i) == 1) then
                temp = SetBit(temp, 5 + i, 1)
            else
                temp = SetBit(temp, 5 + i, 0)
            end
        end

        SetTaskByte(TASK_renwu, 2, temp)
        SetTaskByte(TASK_renwu, 3, 2)
        SetTaskByte(TASK_renwu, 4, 0)

        local scores = GetHelpScore()
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = payMoney() + apm - pm

            Msg2Player("Dïng Tr¹ng th¸i nghÜa khÝ hñy nhiÖm vô Tèng Töu" .. change .. ".")
        elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = payMoney() + apm - pm

            Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
        end

        Pay(pm)
        DelNormalItem(3, 79, 0, 0)

        SetTask(TASK_Lucky, 0)
        SetTaskByte(Task_Yiqi, 2, 1)
        SetTaskByte(Task_Yiqi, 3, 2)

        RemoveIBBuff(376)
        RemoveIBBuff(377)
        AddIBBuff(376)

        local exp1 = GetLevel() * 1000
        AddOwnExp(exp1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

        local nTemp = GetTaskByte(Double_Optimization, 3)
        nTemp = SetBit(nTemp, 6, 1)
        SetTaskByte(Double_Optimization, 3, nTemp)

        Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
        Msg2Player("§©y lµ lÇn tæng kÕt ­u ®·i khi b¹n rêi m¹ng h«m nay thø" .. addtimes .. " (lÇn) vËn chuyÓn Tèng Töu, cã thÓ nép Ýt phÝ cho ta, sau ®ã ®Õn chç Chñ Töu qu¸n ë tÇng 3 BÝch Du cung nhËn Xe chuyÓn r­îu")
        TaskNote(55, 0)

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    else
        Talk(1, "no", " CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        return 0
    end
end

function quxiao()
    SetTaskByte(TASK_renwu, 3, 0)
    SetTaskByte(TASK_renwu, 4, 0)
    SetTask(TASK_Npcindex, 0)
    SetTask(TASK_Lucky, 0)
    SetTaskByte(Task_Yiqi, 2, 0)
    SetTaskByte(Task_Yiqi, 3, 0)

    TaskNote(55, -1)
    RemoveIBBuff(376)
    RemoveIBBuff(377)

    Talk(1, "no", 14665)
end

function payMoney()
    local m = 300000
    if (GetLevel() > 104) then
        m = m + math.floor((GetLevel() - 95) / 10) * 200000

    end
    return m
end

function offlineTotimes()
    local localday = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = math.mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = math.floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (math.mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)
    if (nums > 7) then
        nums = 7
    end
    local n_times = { 50, 50, 50, 100, 100, 100, 100 }
    local m = 60 * n_times[nums] * GetLevel()
    return m
end

function Acctive51()

    if (IsAcctive51Open() <= 0) then
        return
    end

    if (GetLevel() < 60) then
        InfoBox("ThËt xin lçi, ÐèÒª´ïµ½ cÊp 60²Å¿ÉÒÔÁìÈ¡¸Ã½±Àø.")
        return
    end

    if (IsGetGift() <= 0) then
        return
    end

    MsgBox("ÎåÒ»»î¶¯À´Ï®, 4ÔÂ28ÈÕ-5ÔÂ3ÈÕÃ¿Íí20-22µã, cÊp 60 ¼°ÒÔÉÏÍæ¼ÒCã thÓ nhËn<c=g>ÎåÒ»»¶ÀÖÀñ°ü<c>, Ã¿ÌìCã thÓ nhËnÒ»´Î, ×£Äú½ÚÈÕ¿ìÀÖ!", "Acctive51_Yes", "no")
end

function Acctive51_Yes()
    local y, m, d = GetYMD()
    SetTaskByte(2015, 1, d)
    AddNormalItemBind(6, 1, 1022, 1, 0, 0, 1)
    InfoBox("Chóc mõng ngµi nhËn ®­îc 1 c¸i <c=g>ÎåÒ»»¶ÀÖÀñ°ü<c>.")
    Msg2Player("Chóc mõng ngµi nhËn ®­îc 1 c¸i ÎåÒ»»¶ÀÖÀñ°ü.")
    WriteLog("NhËn ®­îc ÎåÒ»»¶ÀÖÀñ°ü")
end

function IsAcctive51Open()

    local y, m, d = GetYMD()
    local hh, mm, ss = GetHMS()
    if not (y == 2015 and ((m == 4 and d >= 28) or (m == 5 and d <= 3)) and hh >= 20 and hh <= 21) then
        return 0
    end

    return 1
end

function IsGetGift()
    local y, m, d = GetYMD()
    if (GetTaskByte(2015, 1) == d) then
        InfoBox("ThËt xin lçi,¸Ã½±ÀøÃ¿ÌìÖ»ÄÜÁìÈ¡Ò»´Î.")
        return 0
    end

    return 1
end

