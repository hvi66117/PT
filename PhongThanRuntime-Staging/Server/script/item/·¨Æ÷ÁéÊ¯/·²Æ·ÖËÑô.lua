Task_Var_AuraStone = 1284
Task_Var_DuJie = 1285
Motin_Interrupt = 63

Conf_Index = 5

AuraStones = {
    [1] = { name = "Phµm phÈm Doanh tinh", file = "\\·²Æ·Ó¨ÐÇ", low = 0, high = 20, growth = 1, rand = 60, gen = { 6, 1, 404, 1 }, hstone = "H¹o NguyÖt, ChÝch d­¬ng cao cÊp" },
    [2] = { name = "Tinh phÈm Doanh tinh", file = "\\¾«Æ·Ó¨ÐÇ", low = 0, high = 20, growth = 2, rand = 60, gen = { 6, 1, 405, 1 }, hstone = "H¹o NguyÖt, ChÝch d­¬ng cao cÊp" },
    [3] = { name = "Phµm phÈm H¹o NguyÖt", file = "\\·²Æ·ð©ÔÂ", low = 20, high = 100, growth = 1, rand = 60, gen = { 6, 1, 406, 1 }, lstone = "Doanh tinh", hstone = "ChÝch d­¬ng" },
    [4] = { name = "Tinh phÈm H¹o NguyÖt", file = "\\¾«Æ·ð©ÔÂ", low = 20, high = 100, growth = 2, rand = 60, gen = { 6, 1, 407, 1 }, lstone = "Doanh tinh", hstone = "ChÝch d­¬ng" },
    [5] = { name = "Phµm phÈm ChÝch d­¬ng", file = "\\·²Æ·ÖËÑô", low = 100, high = 1000, growth = 1, rand = 60, gen = { 6, 1, 408, 1 }, lstone = "Doanh tinh, H¹o NguyÖt cÊp thÊp" },
    [6] = { name = "Tinh phÈm ChÝch d­¬ng", file = "\\¾«Æ·ÖËÑô", low = 100, high = 1000, growth = 2, rand = 60, gen = { 6, 1, 409, 1 }, lstone = "Doanh tinh,H¹o NguyÖt cÊp thÊp" },

    [7] = { name = "Cùc phÈm Doanh tinh", file = "\\¼«Æ·Ó¨ÐÇ", low = 0, high = 20, growth = 3, rand = 100, gen = { 8, 495, 2, 0 }, hstone = "H¹o NguyÖt, ChÝch d­¬ng cao cÊp" },
    [8] = { name = "Cùc phÈm H¹o NguyÖt", file = "\\¼«Æ·ð©ÔÂ", low = 20, high = 100, growth = 3, rand = 100, gen = { 8, 496, 2, 0 }, lstone = "Doanh tinh", hstone = "ChÝch d­¬ng" },
    [9] = { name = "Cùc phÈm ChÝch d­¬ng", file = "\\¼«Æ·ÖËÑô", low = 100, high = 1000, growth = 3, rand = 100, gen = { 8, 497, 2, 0 }, lstone = "Doanh tinh, H¹o NguyÖt cÊp thÊp" },
}

function main()
    if (IsInstrumentEquip() == 0) then
        Talk(1, "no", "Ng­¬i kh«ng mang theo Ph¸p khÝ, kh«ng thÓ dïng Linh th¹ch nµy gióp ng­¬i tô hîp linh khÝ cho Ph¸p khÝ!")
        return
    end

    local currentDay = math.floor(LocalSystemTime() / 86400)
    local lastUseDay = GetTaskWord(Task_Var_AuraStone, 1)
    local useTime = GetTaskWord(Task_Var_AuraStone, 2)
    if (lastUseDay == currentDay and useTime >= 3) then
        Talk(1, "no", "Mçi ngµy chØ cã thÓ tô hîp linh khÝ cho Ph¸p khÝ 3 lÇn, nÕu kh«ng Ph¸p khÝ sÏ tæn h¹i nÆng nÒ!")
        return
    end

    local growthDegree = GetInstrumentGrowthDegree()
    if (growthDegree >= 200) then
        Talk(1, "no", "Ph¸p khÝ ng­¬i mang theo ®· ®ñ ®é tr­ëng thµnh råi!")
        return
    elseif (growthDegree < AuraStones[Conf_Index].low) then
        Talk(1, "no", AuraStones[Conf_Index].name .. "Linh Th¹ch t¨ng c­êng ®é tr­ëng thµnh cña ph¸p khÝ lµ [<c=g>" .. AuraStones[Conf_Index].low .. "-" .. AuraStones[Conf_Index].high .. "<c>], Ph¸p khÝ ng­¬i mang theo ®é tr­ëng thµnh lµ <c=g>" .. growthDegree .. "<c>, kh«ng thÓ sö dông Linh th¹ch nµy, xin sö dông <c=g>" .. AuraStones[Conf_Index].lstone .. "<c> Linh th¹ch t¨ng c­êng")
        return
    elseif (growthDegree >= AuraStones[Conf_Index].high) then
        Talk(1, "no", AuraStones[Conf_Index].name .. "Linh Th¹ch t¨ng c­êng ®é tr­ëng thµnh cña ph¸p khÝ lµ [<c=g>" .. AuraStones[Conf_Index].low .. "-" .. AuraStones[Conf_Index].high .. "<c>], Ph¸p khÝ ng­¬i mang theo ®é tr­ëng thµnh lµ <c=g>" .. growthDegree .. "<c>, ®· v­ît qu¸ giíi h¹n t¨ng c­êng cho Linh th¹ch nµy, xin sö dông <c=g>" .. AuraStones[Conf_Index].hstone .. "<c> Linh th¹ch t¨ng c­êng")
        return
    end

    local newBirth = IsNewBirthComplete()
    local crossDisaster = GetTaskByte(Task_Var_DuJie, 1)
    if (newBirth == 0 and growthDegree >= 20) then
        Talk(1, "no", "Ph¸p khÝ cña b¹n ®· tr­ëng thµnh ®Õn 20%, nh­ng b¹n vÉn ch­a th«ng qua ®é Tiªn Ma chuyÓn sinh, nªn kh«ng thÓ t¨ng cÊp cho nã!")
        return
    elseif (crossDisaster < 1 and growthDegree >= 60) then
        Talk(1, "no", "Ph¸p khÝ cña b¹n ®· tr­ëng thµnh ®Õn 60%, nh­ng b¹n vÉn ch­a th«ng qua ®é kiÕp cÊp 30, nªn kh«ng thÓ t¨ng cÊp cho nã!")
        return
    elseif (crossDisaster < 2 and growthDegree >= 80) then
        Talk(1, "no", "§é tr­ëng thµnh cña ph¸p khÝ ®· ®¹t 80%, nh­ng b¹n ch­a v­ît qua ®¹i kiÕp cÊp 50, ph¸p khÝ cña b¹n kh«ng thÓ t¨ng n¨ng lùc!")
        return
    end

    BeginMotion(Conf_Index, 0, 5, "\\script\\item\\·¨Æ÷ÁéÊ¯" .. AuraStones[Conf_Index].file .. ".lua", Motin_Interrupt)
end

function EndMotion(Num)

    if (HaveNormalItem(myunpack(AuraStones[Conf_Index].gen)) > 0) then
        DelNormalItem(myunpack(AuraStones[Conf_Index].gen))
    elseif (HaveNormalItemInQuick(myunpack(AuraStones[Conf_Index].gen)) > 0) then
        DelNormalItemInQuick(myunpack(AuraStones[Conf_Index].gen))
    else
        Talk(1, "no", "Ng­¬i kh«ng mang theo bÊt cø Linh th¹ch nµo! Sao tiÕn hµnh ®©y!")
        return
    end
    local currentDay = math.floor(LocalSystemTime() / 86400)
    local lastUseDay = GetTaskWord(Task_Var_AuraStone, 1)
    local useTime = GetTaskWord(Task_Var_AuraStone, 2)
    if (lastUseDay ~= currentDay) then
        useTime = 1
        SetTaskWord(Task_Var_AuraStone, 1, currentDay)
        SetTaskWord(Task_Var_AuraStone, 2, useTime)
    else
        useTime = useTime + 1
        SetTaskWord(Task_Var_AuraStone, 2, useTime)
    end
    if (IsInstrumentEquip() == 0) then
        Talk(1, "no", "Ng­¬i kh«ng mang theo Ph¸p khÝ, kh«ng thÓ dïng Linh th¹ch nµy gióp ng­¬i tô hîp linh khÝ cho Ph¸p khÝ!")
        return
    end
    if (lastUseDay == currentDay and useTime >= 4) then
        Talk(1, "no", "Mçi ngµy chØ cã thÓ tô hîp linh khÝ cho Ph¸p khÝ 3 lÇn, nÕu kh«ng Ph¸p khÝ sÏ tæn h¹i nÆng nÒ!")
        return
    end

    local growthDegree = GetInstrumentGrowthDegree()
    local newBirth = IsNewBirthComplete()
    local crossDisaster = GetTaskByte(Task_Var_DuJie, 1)
    if (growthDegree >= 200) then
        Talk(1, "no", "Ph¸p khÝ ng­¬i mang theo ®· ®ñ ®é tr­ëng thµnh råi!")
        return
    elseif (growthDegree < AuraStones[Conf_Index].low) then
        Talk(1, "no", AuraStones[Conf_Index].name .. "T¨ng c­êng thªm ®é tr­ëng thµnh cho Ph¸p khÝ lµ [<c=g>" .. AuraStones[Conf_Index].low .. "-" .. AuraStones[Conf_Index].high .. "<c>], Ph¸p khÝ ng­¬i mang theo ®é tr­ëng thµnh lµ <c=g>" .. growthDegree .. "<c>, kh«ng thÓ sö dông Linh th¹ch nµy, xin sö dông <c=g>" .. AuraStones[Conf_Index].lstone .. "<c> Linh th¹ch t¨ng c­êng")
        return
    elseif (growthDegree > AuraStones[Conf_Index].high) then
        Talk(1, "no", AuraStones[Conf_Index].name .. "T¨ng c­êng thªm ®é tr­ëng thµnh cho Ph¸p khÝ lµ [<c=g>" .. AuraStones[Conf_Index].low .. "-" .. AuraStones[Conf_Index].high .. "<c>], Ph¸p khÝ ng­¬i mang theo ®é tr­ëng thµnh lµ <c=g>" .. growthDegree .. "<c>, ®· v­ît qu¸ giíi h¹n t¨ng c­êng cho Linh th¹ch nµy, xin sö dông <c=g>" .. AuraStones[Conf_Index].hstone .. "<c> Linh th¹ch t¨ng c­êng")
        return
    elseif (newBirth == 0 and growthDegree >= 20) then
        Talk(1, "no", "Ph¸p khÝ cña b¹n ®· tr­ëng thµnh ®Õn 20%, nh­ng b¹n vÉn ch­a th«ng qua ®é Tiªn Ma chuyÓn sinh, nªn kh«ng thÓ t¨ng cÊp cho nã!")
        return
    elseif (crossDisaster < 1 and growthDegree >= 60) then
        Talk(1, "no", "Ph¸p khÝ cña b¹n ®· tr­ëng thµnh ®Õn 60%, nh­ng b¹n vÉn ch­a th«ng qua ®é kiÕp cÊp 30, nªn kh«ng thÓ t¨ng cÊp cho nã!")
        return
    elseif (crossDisaster < 2 and growthDegree >= 80) then
        Talk(1, "no", "§é tr­ëng thµnh cña ph¸p khÝ ®· ®¹t 80%, nh­ng b¹n ch­a v­ît qua ®¹i kiÕp cÊp 50, ph¸p khÝ cña b¹n kh«ng thÓ t¨ng n¨ng lùc!")
        return
    end

    if (AuraStones[Conf_Index].rand < 100) then
        local rand = math.random(1, 100)
        if (rand > AuraStones[Conf_Index].rand) then
            Talk(1, "no", "H«m nay lµ lÇn thø " .. useTime .. " tô hîp linh khÝ cho Ph¸p khÝ! Nh­ng ng¹i qu¸, lÇn nµy c­êng hãa thÊt b¹i råi!")
            return
        end
    end

    local growth = AddInstrumentPolyAura(AuraStones[Conf_Index].growth)
    Talk(1, "no", "§©y lµ lÇn thø " .. useTime .. " tô hîp linh khÝ cho Ph¸p khÝ. Ph¸p khÝ cña ng­¬i ®· ®­îc c­êng hãa!" .. growth .. " ®iÓm tô linh!")
    Msg2Player("B¹n ®· tô hîp linh khÝ cho Ph¸p khÝ thµnh c«ng!")
    TopMessage("B¹n ®· <color=green>tô hîp linh khÝ cho Ph¸p khÝ<color> thµnh c«ng!")

end

function no()
    CloseDialog()
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

