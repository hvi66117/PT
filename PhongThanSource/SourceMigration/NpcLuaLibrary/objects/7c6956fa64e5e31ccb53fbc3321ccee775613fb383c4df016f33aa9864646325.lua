--description: Î÷ÓòÉñÃØ?
--author: yichuan
--date: 2004/7/13
--Add By GaoJingwei 2010125 for ÓñÊ¯¿ª¹â»¹Ô­  begin
Include("\\script\\gvn\\events\\top_consumecoin\\event_topconsume.lua")
g_Horse = {    --¼×Ê¿
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

    --µÀÊ¿
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

    --ÒìÈË
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

--Add By GaoJingwei 2010125 for ×°±¸ÖØÖı  end

-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
TaskTimes = {
    [1] = { totalTimes = 630, awardsTimes = 5, },
    [2] = { totalTimes = 390, awardsTimes = 4, },
    [3] = { totalTimes = 270, awardsTimes = 3, },
    [4] = { totalTimes = 210, awardsTimes = 2, },
    [5] = { totalTimes = 180, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1699 -- Ë«±¶¾­ÑéÓÅ»¯ 1Byte£ºÒÑ¾­ÁìÈ¡µÄË«±¶¾­Ñé´ÎÊı 2Byte£º¿ÉÁìÈ¡µÄË«±¶¾­Ñé×Ü´ÎÊı
G_Double = 370 -- È«¾Ö±äÁ¿
-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÌìÍâ·ÉÏÉ
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



    --°ÙÄê³ÂÄğ
    startLevel = 95
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end


function main()
    tasks = {
        { "Tèng Töu", "renwu95"; show = 0 }, --95¼¶Ñ­»·ÈÎÎñ
        { "Phi Tiªn", "renwu1"; show = 0 },
        { "B¸ L¹c Nh·n", "yan"; show = 0 },
        { "Trïng Méc", "renwu2"; show = 0 }, --ÁÙÊ±¹Ø±Õ
        { "Trïng sinh", "renwu0_HM"; show = 1 }, --ÒÆÖ²»ÆÃ÷¹¦ÄÜ
        { "T©n Thñ tÇm b¶o", "renwu4"; show = 0 },
    }

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

    SayTask("Xin chµo, nÕu ng­¬i gióp ta hoµn thµnh nhiÖm vô <c=g>Tèng Töu<c>, ta sÏ cã phÇn th­ëng hËu hÜnh ®ång thêi nhê MËt Th¸m ë Bİch Du cung tÇng 5 ban phóc cho ng­¬i!", tasks)
end;
---------------------ÒÆÖ²»ÆÃ÷¹¦ÄÜ
IBItemIndex2_HM = {
    { name = "B¸ L¹c Kİnh cÊp 10", ItemIndex = 17 },
    { name = "B¸ L¹c Kİnh cÊp 11", ItemIndex = 18 },
    { name = "B¸ L¹c Kİnh cÊp 12", ItemIndex = 19 },
    { name = "B¸ L¹c Kİnh cÊp 13", ItemIndex = 20 },
    { name = "B¸ L¹c Minh Kİnh", ItemIndex = 133 },
    { name = "B¸ L¹c Linh Kİnh", ItemIndex = 134 },
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

--Add By Gaojingwei 20100126 for ÓñÊ¯¿ª¹â»¹Ô­ÓÅ»¯ begin
function renwu0_HM()
    CloseDialog()
    Talk(2, "Select_Hourse", ":NÕu ng­¬i cã thÓ c­ìi xanh cÊp 55 hoÆc cao h¬n vµ cã <color=green>B¸ L¹c Kİnh<color> cÊp t­¬ng ®­¬ng, hoÆc <color=green>tiÒn ®ång<color>, ta cã thÓ gióp ng­¬i trïng sinh B¸ L¹c Nh·n cÊp t­¬ng ®­¬ng, nh­ng dï thÕ nµo th× thó c­ìi còng kh«ng thÓ tiÕp tôc tån t¹i.", "H·y chän thó c­ìi b¹n muèn hoµn nguyªn.")
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
    for i = 1, getn(g_Horse) do
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
        --ĞÂ½Ó¿Ú
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
    MsgBox("Trïng sinh B¸ L¹c Nh·n cÊp " .. g_Horse[nLine].eyeLevel .. " cÇn 1 <color=green>B¸ L¹c Minh Kİnh hoÆc " .. realIBCount .. " TiÒn ®ång<color>, nguyªn liÖu chuÈn bŞ ®ñ ch­a?", "hecheng3_HM", "no")

end;

function hecheng3_HM()
    local nItemID = GetTask(141)
    local nLine = GetTaskByte(142, 1)

    local nGen = GetItemGen(nItemID)
    local nDetail = GetItemDetail(nItemID)
    local nPart = GetItemPartByID(nItemID)
    local nLevel = GetLevelByID(nItemID)

    if (nLine <= 0 or nLine > getn(g_Horse)) then
        Msg2Player("Sè hµng v­ît qu¸ ph¹m vi")
        return
    end

    local arrySrcItem = g_Horse[nLine].srcItem;
    if (nGen ~= arrySrcItem[1] or nDetail ~= arrySrcItem[2] or nPart ~= arrySrcItem[3] or nLevel ~= arrySrcItem[4]) then
        Msg2Player("Sè liÖu dŞ th­êng khi thao t¸c kh«ng ®ång bé.")
        return
    end

    if (GetEquipMagicType(nItemID) ~= 1) then
        --ĞÂ½Ó¿Ú
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
            Talk(1, "no", "KhÊu trõ tiÒn ®ång thÊt b¹i, ch­a thÓ trïng sinh B¸ L¹c!")
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
--Add By Gaojingwei 20100126 for ÓñÊ¯¿ª¹â»¹Ô­ÓÅ»¯ begin

-----------------ÒÆÖ²»ÆÃ÷¹¦ÄÜend

-------------ÒÔÏÂÄÚÈİÒÑ¾­²»ÉúĞ§ÁË----------------------------
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

-------------ÒÔÉÏÄÚÈİÒÑ¾­²»ÉúĞ§ÁË----------------------------
--Add By GaoJingwei 2010125 for ÓñÊ¯¿ª¹â»¹Ô­  begin

function renwu2()
    MsgBox("GÇn ®©y ta rÊt nhí nhµ, l·nh ®Şa cña ta cã 1 lo¹i <color=red>LiÔu méc<color>. NÕu ng­¬i cã thÓ t×m ®­îc 3 c¸i, ta sÏ gióp ng­¬i dung hîp thó c­ìi tr¾ng trong hµnh trang víi B¸ L¹c Nh·n cÊp t­¬ng øng. H·y chän thó c­ìi muèn dung hîp.", "hecheng2", "no")
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

    --Add By Guoqun for Bug:×°±¸ÔÚÉíÉÏµÄ×øÆïºÏ³ÉÒÔºó²»É¾³ı at 2010-04-13 begin
    if GetItemPosByID(nItemID) ~= 3 then
        Talk(1, "no", "ChØ thó c­ìi ®Æt trong hµnh trang míi cã thÓ hîp thµnh!")
        return
    end
    --Add By Guoqun for Bug:×°±¸ÔÚÉíÉÏµÄ×øÆïºÏ³ÉÒÔºó²»É¾³ı at 2010-04-13 End

    for i = 1, getn(g_Horse) do
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
        Talk(1, "no", "ChØ trang bŞ tr¾ng míi cã thÓ hîp thµnh.")
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
        Talk(1, "no", "Hîp thµnh <c=g>Thó c­ìi xanh cÊp " .. g_Horse[nLine].showLevel .. "<c> thµnh c«ng! Thuéc tİnh hiÖn t¹i lµ: <\\n><c=wat>" .. szMagic .. "<c><\\n>.")
    end
end

function Go_On()
    CloseDialog()
    local realIBCount = GetCostDisIB_HM(5)
    local nLine = GetTaskByte(142, 1)
    local nItemID = GetTask(141)
    local nLevel = GetLevelByID(nItemID)

    if (nLevel >= 10) then
        MsgBox("Trïng sinh B¸ L¹c Nh·n cÊp " .. g_Horse[nLine].eyeLevel .. "-B¸ L¹c Nh·n cÇn 1 <color=green>B¸ L¹c Minh Kİnh hoÆc " .. realIBCount .. " TiÒn ®ång<color>, nguyªn liÖu chuÈn bŞ ®ñ ch­a?", "hecheng3_HM", "no")
    end
end

--Add By GaoJingwei 2010125 for ×°±¸ÖØÖı  begin

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
    Msg2Player("§Õn gÆp thÇy t­íng sè xem vËt g× lµ quı nhÊt.")
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
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 0, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 0, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 0, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 3, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 3, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 3, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 4, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 4, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 4, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 5, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 5, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 5, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 1) >= 1) and (HaveNormalItem(3, 29, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 1)
        DelNormalItem(3, 29, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 1, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 1, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 1, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 1, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 6, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 6, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 6, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 7, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 7, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 7, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 8, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 8, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 8, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 1) >= 1) and (HaveNormalItem(3, 29, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 1)
        DelNormalItem(3, 29, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 1, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 2) >= 1) and (HaveNormalItem(3, 30, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 2)
        DelNormalItem(3, 30, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 2, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 3) >= 1) and (HaveNormalItem(3, 31, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 3)
        DelNormalItem(3, 31, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 3, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 4)
        DelNormalItem(3, 32, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 4, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 5) >= 1) and (HaveNormalItem(3, 33, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 5)
        DelNormalItem(3, 33, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 5, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 6) >= 1) and (HaveNormalItem(3, 42, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 6)
        DelNormalItem(3, 42, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 6, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 7) >= 1) and (HaveNormalItem(3, 43, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 7)
        DelNormalItem(3, 43, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 7, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 8) >= 1) and (HaveNormalItem(3, 44, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 8)
        DelNormalItem(3, 44, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 8, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 9) >= 1) and (HaveNormalItem(3, 45, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 9)
        DelNormalItem(3, 45, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 9, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 2, 10) >= 1) and (HaveNormalItem(3, 46, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 2, 10)
        DelNormalItem(3, 46, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 2, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 9, 10) >= 1) and (HaveNormalItem(3, 47, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 9, 10)
        DelNormalItem(3, 47, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 9, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 10, 10) >= 1) and (HaveNormalItem(3, 48, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 10, 10)
        DelNormalItem(3, 48, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 10, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    elseif ((HaveNormalItem(0, 10, 11, 10) >= 1) and (HaveNormalItem(3, 49, 0, 0) >= 1) and (GetCredit() >= 10)) then
        Talk(1, "no", 10497)
        DelNormalItem(0, 10, 11, 10)
        DelNormalItem(3, 49, 0, 0)
        DecCredit(10)
        AddNormalItem2(0, 10, 11, 10, 0)
        SetTask(51, 3)
        Msg2Player("Cã thÓ tiÕp tôc diÖt trõ Hoa Tr­, t×m thªm nhiÒu M¶nh L­u Tinh cho Ng­êi T©y Vùc.")
        TaskNote(22, 5)
        refreshNpcTaskState()
    else
        Talk(1, "no", 10498)
    end ;
end;
-----------------ÏÂÃæÄÚÈİÒÑ¾­Ê§Ğ§
function hecheng3()
    if (HaveNormalItem(3, 77, 0, 0) >= 3) and (HaveNormalItem(3, 78, 0, 0) >= 3) and (HaveItem2(0, 10, 0, 1) >= 1) and (GetCash() >= 300) then
        Talk(1, "no", 11233)
        DelItem2(0, 10, 0, 1)
        for a = 1, 3 do
            DelNormalItem(3, 77, 0, 0)
            DelNormalItem(3, 78, 0, 0)
        end ;
        Pay(300)
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
        local i = random(1, 4)
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
-----------------ÉÏÃæÄÚÈİÒÑ¾­Ê§Ğ§

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
        Msg2Player("B¹n nhËn ®­îc §éc Gi¸c Thó t¨ng thuéc tİnh.")
    elseif (HaveNormalItem(0, 10, 1, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) then
        Talk(1, "no", 11733)
        DelNormalItem(0, 10, 1, 4)
        DelNormalItem(3, 32, 0, 0)
        AddNormalItem(0, 10, 1, 4, 0, 0)
        SetTask(344, 3)
        Msg2Player("B¹n nhËn ®­îc Th­¬ng ¦ng t¨ng thuéc tİnh.")
    elseif (HaveNormalItem(0, 10, 2, 4) >= 1) and (HaveNormalItem(3, 32, 0, 0) >= 1) then
        Talk(1, "no", 11733)
        DelNormalItem(0, 10, 2, 4)
        DelNormalItem(3, 32, 0, 0)
        AddNormalItem(0, 10, 2, 4, 0, 0)
        SetTask(344, 3)
        Msg2Player("B¹n nhËn ®­îc 1 B¹ch V©n Hå §iÖp t¨ng thuéc tİnh.")
    else
        Talk(1, "no", 11734)
    end ;
end;

----------------95Ñ­»·ÈÎÎñ-------------------------------------------------------
--1139 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı, 3, µ±Ç°µÃ»·½Ú,(1½Ó,2Áì,3Íê³É),4,ÊÇ·ñÁì¹ı¶îÍâµÄ½õºÏ
--1166	1£½±Ì¶Ò»»¾­ÑéµÄÊ±¼ä£¬ 2£½´ÎÊı
--AS Gaojingwei 091009
Task_Yiqi = 1532        --1byte:ÊÇ·ñÊ¹ÓÃÒåÆøÖµ 2byte:ÊÇ·ñÔÚÉñÃØµÀÈË´¦½»¹ı½ğÇ®
TASK_renwu = 1139 --1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı (6,7,8bit¼ÇÂ¼Ê¹ÓÃ¶îÍâ´ÎÊı), 3, µ±Ç°µÃ»·½Ú,(1½Ó,2Áì,3Íê³É),4,ÊÇ·ñÁì¹ı¶îÍâµÄ½õºÏ
TASK_Npcindex = 1140 --Í¬Ê±ÔÚ½ÓÇ°×öÊÇ·ñÌåËÙµÄ±êÊ¶(1=ÆÕÍ¨£¬2=¸ÄÁ¼)
TASK_Lucky = 1141 --É±¹ÖµÃ½õºÏµÄĞÒÔËÖµ,´æ¸öÊı,(³õÊ¼Îª4/1000£¬Ã¿¶àÉ±40Ö»£¬Ôö¼Ó4/1000£¬×î´ó¸ÅÂÊÎª20/1000)
--1142 Ã¿ÈÕÈÎÎñ´ÎÊı¼ÇÂ¼
TASK_TIMES_Max = 4    --½ÓÈÎÎñµÄÉÏÏŞ£¬º¬Ãâ·ÑµÄ£¬

item_guard = {
    [1] = { BoxNums = 3, ibnumber = 1, moneynumber = 1 },
    [2] = { BoxNums = 4, ibnumber = 1, moneynumber = 1 },
    [3] = { BoxNums = 9, ibnumber = 2, moneynumber = 2 },
    [4] = { BoxNums = 18, ibnumber = 4, moneynumber = 3 }
}

--AE Gaojingwei 091009
function renwu95()
    if (GetTask(1139) == 0) then
        MsgBox("Huynh tr­ëng ta l­u l¹c tËn Bİch Du Cung t×m kho b¸u göi vÒ quª nhµ. Huynh Êy rÊt nghiÖn r­îu, ta th­êng nhê Chñ töu qu¸n göi r­îu cho huynh ta nhÊm nh­ng gÇn ®©y hay bŞ qu¸i vËt ®¸nh c­íp! Anh hïng cã thÓ gióp ta kh«ng?", "yes_95", "no")
    else
        local tasks1 = {
            { "Tèng Töu", "Acdept_taskVino"; show = 1 },
            { "§æi Phong Ma Bİch", "BiToExp"; show = 1 },
        }

        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
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
        SayTask("Ta nhê <c=g>Chñ töu qu¸n ë Bİch Du tÇng 3<c> chuyÓn İt r­îu cho huynh tr­ëng, ng­¬i cã thÓ ®Õn <c=g>chç ta<c> hoÆc trùc tiÕp ®Õn <c=g>Bİch Du tÇng 3 gÆp Chñ töu qu¸n<c> nhËn nhiÖm vô <c=g>Tèng Töu<c>. NÕu ng­¬i cã <c=yel>Phong Ma Bİch<c>, cã thÓ ®æi  kinh nghiÖm ë chç ta!" .. str, tasks1)
        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End
    end
end

function yes_95()
    Msg2Player("§Õn Bİch Du Cung tÇng 3 t×m Chñ töu qu¸n T©y Vùc.")
    SetTask(1139, SetByte(0, 3, 1))
    renwu95()
    --Talk(1,"no","Î÷ÓòÉñÃØÈË£ºÎÒÍĞµÄ¾Æ±£ºÍÎÒÊÇÀÏÏç£¬ºÍÎÒ³¤µÄºÜÏñ£¬·Ç³£ºÃ±æÈÏ£¬ËûÏÖÔÚÓ¦¸Ã¾ÍÔÚ<c=g>±ÌÓÎ¹¬3²ãµÄÒ½Éú´¦<c>°É¡£")
end

function BiToExp()
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1166, 1)
    if (thisday ~= lastday) then
        SetTask(1166, SetByte(0, 1, thisday))
    end
    local duihuanN = GetTaskByte(1166, 2)

    if (duihuanN < 2) then
        if (HaveNormalItem(3, 176, 0, 0) >= 1) then
            MsgBox("1 Phong Ma Bİch ®æi ®­îc <c=g>" .. (GetLevel() * 30000) .. "<c> kinh nghiÖm, muèn ®æi ngay?", "BiToExp1", "no")
        else
            Talk(1, "no", "Ng­¬i kh«ng cã <c=r>Phong Ma Bİch<c>! H·y dïng 20 m¶nh Phong Ma Bİch ®Õn Xİch Tïng Tö ghĞp l¹i sÏ cã h¬ héi nhËn ®­îc Phong Ma Bİch.")
        end
    else
        Talk(1, "no", "PhÇn th­ëng cña ta cã h¹n, mçi ngµy mçi ng­êi chØ ®­îc ®æi Phong Ma Bİch <c=g>2 lÇn<c>. H«m nay ng­¬i ®· ®æi hÕt råi, mai h·y ®Õn n÷a nhĞ!")
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
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. exp1 .. "§iÓm kinh nghiÖm.")
        Talk(1, "no", "H·y nhËn lÊy <c=g>®iÓm kinh nghiÖm" .. exp1 .. "<c>, ®©y lµ thï lao cña ng­¬i, h·y nhËn lÊy.")
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=r>Phong Ma Bİch<c>! H·y dïng 20 m¶nh Phong Ma Bİch ®Õn Xİch Tïng Tö ghĞp l¹i sÏ cã h¬ héi nhËn ®­îc Phong Ma Bİch.")
    end
end

-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
function Yes_AcceptDouble()
    local nTimes = GetTaskByte(Double_Optimization, 1)
    local taskDay = GetWeekDay()

    SetTaskByte(Double_Optimization, 1, nTimes + 1)
    SetTaskByte(Double_Optimization, 3, taskDay) -- ÁìÈ¡ÁËË«±¶½±ÀøÈÎÎñ
    taskVino()
    AddGlobalCountNews(GetName() .. " cã c«ng hé tèng, dòng m·nh gan d¹, ®­îc Ng­êi T©y Vùc tÆng phÇn th­ëng nh©n ®«i kinh nghiÖm.", 1)
end

function No_AcceptDouble()
    Talk(1, "taskVino", "NÕu trong tuÇn kh«ng ®Õn nhËn, phÇn th­ëng nh©n ®«i sÏ bŞ mÊt.")
end

function Acdept_taskVino()
    local taskDay = GetWeekDay()
    if (GetGlobalValueByte(G_Double, 4) == 0) then
        -- ·ÇÈÎÎñÖÜ½«ÈÎÎñ±äÁ¿ÇåÁã
        SetTask(Double_Optimization, 0)
    end
    if (GetGlobalValueByte(G_Double, 4) == 1 and taskDay > GetTaskByte(Double_Optimization, 3)) then
        SetTaskByte(Double_Optimization, 3, 0) -- ÈÎÎñÖÜ£ºÃ¿Ìì½ÓÈÎÎñÊ±±£Ö¤½«¸Ã×Ö½ÚÇåÁã
    end

    if (GetGlobalValueByte(G_Double, 4) == 1 and GetTaskByte(Double_Optimization, 4) ~= taskDay and GetTaskByte(Double_Optimization, 1) < GetTaskByte(Double_Optimization, 2)) then
        MsgBox("TuÇn nµy b¹n sÏ cã <c=g>" .. GetTaskByte(Double_Optimization, 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· hÕt <c=g>" .. GetTaskByte(Double_Optimization, 1) .. "<c> ngµy. <c=r>H«m nay b¹n cã muèn nhËn phÇn th­ëng nh©n ®«i kh«ng?<c>", "Yes_AcceptDouble", "No_AcceptDouble")
        return 0
    end

    taskVino()
end
-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

--AS GaoJingwei 091009
function taskVino()
    CloseDialog()
    local huanshu = GetTaskByte(TASK_renwu, 3)
    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()

    local taskDay = GetWeekDay()
    SetTaskByte(Double_Optimization, 4, taskDay) -- ÁìÈ¡ÁËË«±¶½±ÀøÈÎÎñ
    ------------------Add by liuzhiqiang at 2009/8/17 begin-------------------------Ö÷ÏßÈÎÎñ°ïÖú»ı·Ö
    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end
    ------------------Add by liuzhiqiang at 2009/8/17 end  -------------------------Ö÷ÏßÈÎÎñ°ïÖú»ı·Ö

    local LastTime = GetTaskByte(957, 1)--×îºóÒ»´Î½ÓÁ¸ÈÎÎñµÄÏµÍ³Ê±¼ä
    local playername = GetName()
    local guardindex = GetTGuardIndexByPlayerName(playername)

    if ((thisday > (LastTime + 1830)) or (guardindex == 0)) and (GetTask(959) == 1) then
        SetTask(959, 0)
        TaskNote(64, -1)
    end

    if (guardindex > 0) then
        if (GetTask(959) >= 1) then
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
    if (thisday ~= lastday) then
        if (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
            MsgBox("C¸i ng­¬i cÇn ®Òu lµ r­îu th­îng h¹ng! GÇn ®©y qu¸i vËt c­íp bãc nhiÒu, hµng tån cßn rÊt İt, nªn gi¸ h¬i cao. CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. lastMoney .. "tB¹c, ng­¬i tr¶ næi kh«ng? NÕu x¸c nhËn, ta sÏ khÊu trõ Hång B¶o Th¹ch vµ b¹c, ®ång thêi chuyÓn ng­¬i ®Õn chç <c=g>Chñ töu qu¸n ë Bİch Du tÇng 3<c>.", "yesVino", "no")
        else
            Talk(1, "no", "C¸i ng­¬i cÇn ®Òu lµ r­îu th­îng h¹ng! GÇn ®©y qu¸i vËt c­íp bãc nhiÒu, hµng tån cßn rÊt İt, nªn gi¸ h¬i cao. CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. lastMoney .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhĞ!")
        end
    elseif (times < TASK_TIMES_Max or alltimes >= addtimes) and (huanshu == 0) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹pTµiTuLuyÖn", "yes_fsb"; show = 0 },
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
        SayTask("Tİch lòy hiÖn t¹i " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. " TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó chÕ t¹o xe r­îu <c=g>Hång B¶o Th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
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
        { "<c=g>ThÇn ThuËt", "yiqiBuff_4"; show = 1 }, --modify by liuzhiqiang
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>tiÒn ®ång, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

--ÔË¾Æ³µ
function yesVino_1()
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    SetTask(TASK_Npcindex, 1)
    if (thisday ~= lastday) then
        yiqiBuff_1() --modify by liuzhiqiang
    else
        yiqiBuff_2() --modify by liuzhiqiang
    end
end

--Ñ¡Ôñ¸ß¼¶¾Æ³µ
function yiqiBuff_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_4", "yesVino_2")
    else
        yesVino_2()
    end
end

--Ñ¡Ôñ¸ß¼¶¾Æ³µ£¬ÓÃÈÊÒåÖµµÖÑº
function costYiqi_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yesVino_2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

--Ãâ·ÑÔË³µ
function yiqiBuff_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_1", "yes1")
    else
        yes1()
    end
end

--¸¶·ÑÔË¾Æ
function yiqiBuff_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_2", "yes2")
    else
        yes2()
    end
end

--ÓÃÃâ·ÑÔË¾Æ£¬ÓÃÒåÆø×´Ì¬µÖÑº
function costYiqi_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes1()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

--¸¶·ÑÔË¾Æ£¬ÓÃÒåÆø×´Ì¬µÖÑº
function costYiqi_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

--Ñ¡Ôñ¸ß¼¶¾Æ³µ£¬¿Û³ı½ğÇ®¼ÓÔË¾Æ¼ÆÊ±buff
function yesVino_2()
    CloseDialog()
    SetTask(TASK_Npcindex, 2)
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local ib379 = FindAValidIBItem(8, 379, 2, 0)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    if (ib379 ~= 0) then
        if (thisday ~= lastday) then
            if (yes1() ~= 1) then
                return 0
            end
        else
            if (yes2() ~= 1) then
                return 0
            end
        end

        CostIBItem(ib379)
        Msg2Player("B¹n nép ThÇn ThuËt cho Ng­êi T©y Vùc, cã thÓ nhËn ®­îc Xe chuyÓn r­îu cao cÊp ë chç Chñ töu qu¸n Bİch Du tÇng 3.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    elseif (GetCoin() >= Cv) then
        if (thisday ~= lastday) then
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
                Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> tiÒn ®ång. ChuÈn bŞ ®ñ h·y ®Õn t×m ta.")
                return 0
            end
        end

        CostCoinByIdx(67)
        EventTopConsume:AddConsumeValue(Cfs, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n ®· ®­a" .. Cfs .. "tiÒn ®ång, nhËn ®­îc Xe chuyÓn r­îu cao cÊp ë chç Chñ töu qu¸n Bİch Du tÇng 3.")
        SetFightState(1)
        NewWorld(44, 1894, 3084)

    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> tiÒn ®ång. ChuÈn bŞ ®ñ h·y ®Õn t×m ta.")
    end
end

--Ñ¡ÔñÆÕÍ¨¾Æ³µ£¬¿Û³ı½ğÇ®¼ÓÔË¾Æ¼ÆÊ±buff
function yes1()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)--Ì«¶àµÄ×´Ì¬
        return 0
    end

    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()
    if (thisday ~= lastday) then
        times = 1
    else
        pm = pm * item_guard[times].moneynumber
    end

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local scores = GetHelpScore()
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (GetLevel() >= 95) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then

        if (thisday ~= lastday) then
            SetTask(TASK_renwu, SetByte(0, 1, thisday))
            offlineTotimes()
            temp = 1
        end

        SetTaskByte(TASK_renwu, 2, temp)
        SetTaskWord(TASK_renwu, 2, 2)--log¸Ä°æ

        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        local scores = GetHelpScore()
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Dïng Tr¹ng th¸i nghÜa khİ hñy nhiÖm vô Tèng Töu" .. change .. ".")
            Msg2Player("Dïng Tr¹ng th¸i nghÜa khİ hñy nhiÖm vô Tèng Töu" .. change .. ".")
        elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
            Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

        Pay(pm)
        DelNormalItem(3, 79, 0, 0)

        SetTask(TASK_Lucky, 0)
        SetTaskByte(Task_Yiqi, 2, 1)        --±íÊ¾ÒÑ¾­½»¹ı½ğÇ®ºÍºì±¦Ê¯
        SetTaskByte(Task_Yiqi, 3, 1)        --±íÊ¾ÆÕÍ¨ÈÎÎñ

        RemoveIBBuff(376)
        RemoveIBBuff(377)
        AddIBBuff(376)

        local exp1 = GetLevel() * 1000
        AddOwnExp(exp1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

        Msg2Player("H«m nay lµ lÇn thø" .. times .. " hé tèng Tèng Töu, nhËn Xe chuyÓn r­îu tõ Ng­êi T©y Vùc ë T©y Kú hoÆc ë chç Chñ töu qu¸n Bİch Du tÇng 3.")            --????
        TaskNote(55, 0)

        if (times < TASK_TIMES_Max) then
            SyncBibleState(55, 2, 1)
        else
            SyncBibleState(55, 3, 1)
        end ;
        Msg2Player("H«m nay lµ lÇn thø " .. times .. " anh hïng hé tèng r­îu, nhËn Xe chuyÓn r­îu ë chç ta hoÆc ë chç Chñ töu qu¸n Bİch Du tÇng 3.")    --????

        if (GetTaskByte(TASK_renwu, 2) == 1) and (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    else
        Talk(1, "no", " CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhĞ!")
        return 0
    end
end

function yes2()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(66)
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

        Cfs = (costtimes - j) * Cfs
        EventTopConsume:AddConsumeValue(Cfs, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n giao cho chñ qu¸n L­u Ly B«i" .. j .. " C¸i vµ" .. Cfs .. "tiÒn ®ång, nhËn nhiÖm vô Tèng Töu míi!")

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
            CostCoinByIdx(66)
        end

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        EventTopConsume:AddConsumeValue(Cfs, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n ®· ®­a" .. Cfs .. "tiÒn ®ång, nhËn nhiÖm vô Tèng Töu míi!")
        return 1
    else
        Talk(1, "no", " CÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c>®ñ tiÒn ®ång h·y ®Õn t×m ta.")
    end
    return 0
end

--¸¶·ÑÈÎÎñ
function coin_renwu()
    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(66)
    TaskNote(55, -1)
    local costtimes = item_guard[times].ibnumber
    local pm = payMoney() * item_guard[times].moneynumber
    Cv = (costtimes - HaveNormalItem(8, 378, 2, 0)) * Cv
    Cfs = costtimes * Cfs

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (HaveNormalItem(8, 378, 2, 0) >= costtimes) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox(" Mçi ngµy mçi ng­êi chØ ®­îc cung cÊp nguyªn liÖu h¹n chÕ. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. " C¸i, ng­¬i cã muèn chuyÓn thªm lÇn n÷a kh«ng?", "yesVino", "no")
    elseif (GetCoin() >= Cv) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox(" Mçi ngµy mçi ng­êi chØ ®­îc cung cÊp nguyªn liÖu h¹n chÕ. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c>tiÒn ®ång, ng­¬i b»ng lßng kh«ng?", "yesVino", "no")
    else
        Talk(1, "no", " R­îu quı cã giíi h¹n, kh«ng ph¶i ai còng cã ®­îc! Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ " .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c>®ñ tiÒn ®ång h·y ®Õn t×m ta.")
    end
end

--ÄÉ²ÆĞŞÁ¶
function yes_fsb()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local tasks = {
        { "Xe chuyÓn r­îu", "yes_freefsb1"; show = 1 },
        { "<c=g>ThÇn ThuËt", "yiqiBuff_5"; show = 1 },
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>tiÒn ®ång, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

--ÄÉ²ÆÈÎÎñ£¬ÔË¾Æ³µ
function yes_freefsb1()
    SetTask(TASK_Npcindex, 1)
    yiqiBuff_3()  --modify by liuzhiqiang
end

--ÄÉ²ÆÈÎÎñ£¬ÊÇ·ñÊ¹ÓÃÈÊÒåÖµµÖÑº
function yiqiBuff_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

--ÄÉ²ÆÈÎÎñ£¬Ê¹ÓÃÈÊÒåÖµµÖÑº
function costYiqi_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

--ÄÉ²ÆÈÎÎñ£¬»»È¡¸ß¼¶¾Æ³µ
function yiqiBuff_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_5", "yes_freefsb2")
    else
        yes_freefsb2()
    end
end

--ÄÉ²Æ£¬»»È¡¸ß¼¶¾Æ³µ£¬ÓÃÈÊÒåÖµµÖÑº
function costYiqi_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb2()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

--ÄÉ²Æ£¬¸ß¼¶¾Æ³µ
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
        Msg2Player("TÆng ThÇn ThuËt cho ta, ta sÏ ®­a ng­¬i ®Õn Chñ Töu qu¸n ë tÇng 3 Bİch Du cung, t¹i ®ã ng­¬i cã thÓ nhËn Xe chuyÓn r­îu cao cÊp, vµ cã thÓ b¾t ®Çu nhiÖm vô VËn chuyÓn.")        --
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    elseif (GetCoin() >= Cv) then
        if (yes_freefsb() ~= 1) then
            return 0
        end
        CostCoinByIdx(67)
        EventTopConsume:AddConsumeValue(Cfs, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n ®· ®­a" .. Cfs .. "tiÒn ®ång cho ta, ta sÏ ®­a ng­¬i ®Õn Chñ Töu qu¸n ë tÇng 3 Bİch Du cung, t¹i ®ã ng­¬i cã thÓ nhËn Xe chuyÓn r­îu cao cÊp, vµ cã thÓ b¾t ®Çu nhiÖm vô VËn chuyÓn.")        --
        SetFightState(1)
        NewWorld(44, 1894, 3084)
    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> tiÒn ®ång. ChuÈn bŞ ®ñ h·y ®Õn t×m ta.")
    end
end

--ÄÉ²ÆÈÎÎñ£¬¿ÛÇ®µÃïÚ³µ
function yes_freefsb()
    CloseDialog()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)--Ì«¶àµÄ×´Ì¬
        return 0
    end

    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local scores = GetHelpScore()
    local pm = payMoney()
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
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
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        local scores = GetHelpScore()
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = payMoney() + apm - pm
            WriteLog(GetName() .. "Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
            Msg2Player("Dïng Tr¹ng th¸i nghÜa khİ hñy nhiÖm vô Tèng Töu" .. change .. ".")
        elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = payMoney() + apm - pm
            WriteLog(GetName() .. "Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
            Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

        Pay(pm)
        DelNormalItem(3, 79, 0, 0)

        SetTask(TASK_Lucky, 0)
        SetTaskByte(Task_Yiqi, 2, 1)
        SetTaskByte(Task_Yiqi, 3, 2)        --±íÊ¾ÄÉ²Æ£¬Ó°Ïì¾ÆÌ³µÄ¸öÊı

        RemoveIBBuff(376)
        RemoveIBBuff(377)
        AddIBBuff(376)

        local exp1 = GetLevel() * 1000
        AddOwnExp(exp1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

        -- Add By Zhang Jin for ¾­ÑéË«±¶ÓÅ»¯ at 2010/04/21 Begin
        local nTemp = GetTaskByte(Double_Optimization, 3)
        nTemp = SetBit(nTemp, 6, 1)
        SetTaskByte(Double_Optimization, 3, nTemp)
        -- Add By Zhang Jin for ¾­ÑéË«±¶ÓÅ»¯ at 2010/04/21 End

        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")                                                    --????
        Msg2Player("§©y lµ lÇn tæng kÕt ­u ®·i khi b¹n rêi m¹ng h«m nay thø" .. addtimes .. " (lÇn) vËn chuyÓn Tèng Töu, cã thÓ nép İt phİ cho ta, sau ®ã ®Õn chç Chñ Töu qu¸n ë tÇng 3 Bİch Du cung nhËn Xe chuyÓn r­îu")
        TaskNote(55, 0)

        -- Msg2Player("Î÷áªÉñÃØÈË£º½ñÌìÊÇÓ¢ĞÛµÚ"..times.."´Î»¤ËÍ°ÙÄê³ÂÄğ£¬ÔÚÎÒÕâÀï½»Óè·ÑÓÃ£¬È»ºó¿ÉÒÔÈ¥±ÌÓÎ¹¬3²ãµÄ¾Æ±£´¦ÁìÈ¡ÔË¾Æ³µ¡£")

        if (GetTask(TASK_Npcindex) == 1) then
            SetFightState(1)
            NewWorld(44, 1894, 3084)
        end

        return 1
    else
        Talk(1, "no", " CÇn <c=g>1 Hång B¶o Th¹ch<c> vµ " .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhĞ!")
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
        --ÁìÈ¡ÈÎÎñÊ±½ÉÄÉ½ğÇ®=30+floor[(lv-95)/10]*20
        m = m + floor((GetLevel() - 95) / 10) * 200000
        --	m = min(m,1500000)
    end
    return m
end

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊı»ıÔÜ,ÓÃÆäÊıÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ıÀÛ´ÎÊı
function offlineTotimes()
    -- modified by yaoxin for 2010-10
    local localday = floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1-- modified by yaoxin for 2010-12

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
    local m = 60 * n_times[nums] * GetLevel() --»ùÊı6000*lv
    return m
end
--AE GaoJingwei 091009

-- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
--function twoyearcel()
--	local ran = 1
--	if( IsHaveSpaceForTreasure (1) == 0 ) then
--		ran = 30
--	end
--	local Npcs_xiqi =
--		{
--			"ĞÇ¹Ù",
--			"ÈÎ´óÉ©",
--			"Î÷ÓòÉñÃØÈË",
--			"Îä¼ª",
--			"²ÉÒ©ÀÏÈË"
--		}
--	local task_process	= GetTaskByte(Task_stage, 2)
--	SetTaskBit(Task_stage, 19, 0)
--	SetTaskBit(Task_stage, 3, 1)
--	local j = random(ran, 100)
--	if(j > 20) then
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ß
--			Talk(2,"no","Î÷ÓòÉñÃØÈË£ºÔÚÎÒµÄ¼ÒÏç£¬Ã¿·êÕâÃ´ÖØ´óµÄ½ÚÇì±Øµ±ºÃºÃÇì×£Ò»·¬¡£·âÉñ¹ú¼ÊÁ½ÖÜÄêµÄÇìµäÏë±ØÒ²ÊÇ·Ç³£Ê¢´óµÄ°É£¡ÎÒÖªµÀÁË£¬ÕâÃ´¶àÄêÎÒ¿ÉÊÇ»ıÔÜÁËºÜ¶àµÄÁ÷ĞÇËéÆ¬£¬µ½Ê±ºòÄúÃÇ¾ÍµÈ×Å¿´ºÃ°É£¡","Î÷ÓòÉñÃØÈË£ºßí£¬ÎÒºÜÏë¿´¿´±ğÈË¶¼ÊÇÔõÃ´×¼±¸ÇìµäµÄ£¬¾ÍÈÃÎÒÀ´ÌæÓ¢ĞÛ·¢ËÍºØ¿¨°É¡£")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end
--			end
--			Talk(2,"no","Î÷ÓòÉñÃØÈË£ºÔÚÎÒµÄ¼ÒÏç£¬Ã¿·êÕâÃ´ÖØ´óµÄ½ÚÇì±Øµ±ºÃºÃÇì×£Ò»·¬¡£·âÉñ¹ú¼ÊÁ½ÖÜÄêµÄÇìµäÏë±ØÒ²ÊÇ·Ç³£Ê¢´óµÄ°É£¡ÎÒÖªµÀÁË£¬ÕâÃ´¶àÄêÎÒ¿ÉÊÇ»ıÔÜÁËºÜ¶àµÄÁ÷ĞÇËéÆ¬£¬µ½Ê±ºòÄúÃÇ¾ÍµÈ×Å¿´ºÃ°É£¡","Î÷ÓòÉñÃØÈË£º²»¹ıÕâ³ÇÀïÓ¦¸Ã»¹ÓĞ²»ÉÙÈË²»ÖªµÀÕâ¼şÊÂÇé£¬±ÈÈç<c=g>"..Npcs_xiqi[i].."<c>£¬ÄúÓ¦¸Ã¿ìµã¸æËßËûÃÇ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)
--			TaskNote(1094, 0, Npcs_xiqi[i])
--		end
--	else
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ß
--			Talk(3,"no","Î÷ÓòÉñÃØÈË£ºÔÚÎÒµÄ¼ÒÏç£¬Ã¿·êÕâÃ´ÖØ´óµÄ½ÚÇì±Øµ±ºÃºÃÇì×£Ò»·¬¡£·âÉñ¹ú¼ÊÁ½ÖÜÄêµÄÇìµäÏë±ØÒ²ÊÇ·Ç³£Ê¢´óµÄ°É£¡ÎÒÖªµÀÁË£¬ÕâÃ´¶àÄêÎÒ¿ÉÊÇ»ıÔÜÁËºÜ¶àµÄÁ÷ĞÇËéÆ¬£¬µ½Ê±ºòÄúÃÇ¾ÍµÈ×Å¿´ºÃ°É£¡","Î÷ÓòÉñÃØÈË£ºÕâÊÇÎÒĞÖ³¤ËÍÎÒµÄ£¬Ó¢ĞÛÊÕÏÂËü£¬¾Íµ±×öÇìµäµÄÀñÆ·°É£¡","Î÷ÓòÉñÃØÈË£ºßí£¬ÎÒºÜÏë¿´¿´±ğÈË¶¼ÊÇÔõÃ´×¼±¸ÇìµäµÄ£¬¾ÍÈÃÎÒÀ´ÌæÓ¢ĞÛ·¢ËÍºØ¿¨°É¡£")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end
--			end
--			Talk(3,"no","Î÷ÓòÉñÃØÈË£ºÔÚÎÒµÄ¼ÒÏç£¬Ã¿·êÕâÃ´ÖØ´óµÄ½ÚÇì±Øµ±ºÃºÃÇì×£Ò»·¬¡£·âÉñ¹ú¼ÊÁ½ÖÜÄêµÄÇìµäÏë±ØÒ²ÊÇ·Ç³£Ê¢´óµÄ°É£¡ÎÒÖªµÀÁË£¬ÕâÃ´¶àÄêÎÒ¿ÉÊÇ»ıÔÜÁËºÜ¶àµÄÁ÷ĞÇËéÆ¬£¬µ½Ê±ºòÄúÃÇ¾ÍµÈ×Å¿´ºÃ°É£¡","Î÷ÓòÉñÃØÈË£ºÕâÊÇÎÒĞÖ³¤ËÍÎÒµÄ£¬Ó¢ĞÛÊÕÏÂËü£¬¾Íµ±×öÇìµäµÄÀñÆ·°É£¡","Î÷ÓòÉñÃØÈË£º²»¹ıÕâ³ÇÀïÓ¦¸Ã»¹ÓĞ²»ÉÙÈË²»ÖªµÀÕâ¼şÊÂÇé£¬±ÈÈç<c=g>"..Npcs_xiqi[i].."<c>£¬ÄúÓ¦¸Ã¿ìµã¸æËßËûÃÇ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)
--			TaskNote(1094, 0, Npcs_xiqi[i])
--		end

--		local k = random(1,100)
--		if(k <= 5) then
--			AddNormalItem(8, 733, 2, 1, 0, 0)
--			Msg2Player("Äú»ñµÃÁËÃÔÄú³¬¼¶»Ø³Ç·û¡£")
--			WriteLog("»ñµÃÃÔÄú³¬¼¶»Ø³Ç·û¡£")
--		elseif(k <= 17) then
--			AddNormalItem(8, 567, 2, 1, 0, 0)
--			Msg2Player("Äú»ñµÃÁËÈçÒâÒ°Íâ´«ËÍ·û¡£")
--			WriteLog("»ñµÃÈçÒâÒ°Íâ´«ËÍ·û¡£")
--		elseif(k <= 30) then
--			AddNormalItem(8, 781, 2, 1, 0, 0)
--			Msg2Player("Äú»ñµÃÁËÈçÒâ»Ø¹ú·û¡£")
--			WriteLog("»ñµÃÈçÒâ»Ø¹ú·û¡£")
--		elseif(k <= 65) then
--			AddNormalItem(8, 780, 4, 1, 0, 0)
--			Msg2Player("Äú»ñµÃÁËÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--		else
--			AddNormalItem(8, 779, 3, 1, 0, 0)
--			Msg2Player("Äú»ñµÃÁËÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--		end
--	end

--end
-- end of add yangtao 2009.8.19
