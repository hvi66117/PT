g_Item = { 6, 1, 1437, 1 }

g_Name = ""

g_ItemList = {
    [1] = { name = "200 v¹n ", ID = { 2000000, 0, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 100, needSpace = 0, addtype = "Earn", isnotice = 0, IsPseudo = 1 },
    [2] = { name = "Méc nh©n", ID = { 8, 174, 2, 0, 0, 0 }, count = 1, isband = 1, probability = 100, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [3] = { name = "ChØ nh©n", ID = { 8, 135, 2, 0, 0, 0 }, count = 1, isband = 1, probability = 500, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [4] = { name = "Thanh Lé (tiÓu)", ID = { 8, 28, 3, 0, 0, 0 }, count = 1, isband = 1, probability = 1000, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [5] = { name = "Ch©n KhÝ (tiÓu)", ID = { 8, 29, 4, 0, 0, 0 }, count = 1, isband = 1, probability = 1000, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [6] = { name = "B¹ch Kh«ng th­", ID = { 8, 139, 2, 0, 0, 0 }, count = 1, isband = 1, probability = 1000, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [7] = { name = "M¶nh Hång thñy tinh", ID = { 3, 77, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 2000, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [8] = { name = "M¶nh Hoµng thñy tinh", ID = { 3, 88, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 1690, needSpace = 3, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [9] = { name = "10 v¹n b¹c khãa", ID = { 100000, 0, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 1000, needSpace = 0, addtype = "EarnBind", isnotice = 0, IsPseudo = 1 },
    [10] = { name = "ThÇn CÈu phï", ID = { 8, 133, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 500, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [11] = { name = "Kinh nghiÖm ®¬n", ID = { 6, 1, 1062, 1, 0, 0 }, count = 1, isband = 1, probability = 800, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [12] = { name = "S¸ch Ch­ HÇu (M¶nh)", ID = { 8, 193, 5, 0, 0, 0 }, count = 1, isband = 1, probability = 100, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [13] = { name = "LÔ bao ChÝ T«n", ID = { 8, 289, 2, 0, 0, 0 }, count = 1, isband = 1, probability = 100, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [14] = { name = "Tói quµ §å phæ Ph¸ Qu©n", ID = { 6, 1, 1046, 1, 0, 0 }, count = 1, isband = 1, probability = 10, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
    [15] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0, 0, 0 }, count = 1, isband = 1, probability = 100, needSpace = 1, addtype = "AddNormalItem", isnotice = 0, IsPseudo = 1 },
}
MostSpace = 2

function main()

    if (IsHaveSpaceForTreasure(MostSpace) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. MostSpace .. "¸ñ, ÇëÕûÀíºóÔÙ´ò¿ª.")
        return
    end
    g_Name = GetNormalItemName(g_Item[1], g_Item[2], g_Item[3], g_Item[4])
    local YY, MM, DD = GetYMD()
    local result = DelNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4])
    if (result == 0) then
        Talk(1, "no", "Më lÔ bao thÊt b¹i.")
        return
    else

        if (GetGlobalStoreValueWord(44, 1) ~= DD) then
            SetGlobalStoreValueWord(44, 1, DD, 1)
            SetGlobalStoreValueWord(44, 2, 0, 1)
        end

        local num = GetGlobalStoreValueWord(44, 2)
        num = num + 1
        if (num < 1500) then
            SetGlobalStoreValueWord(44, 2, num, 1)
        end
        if (num == 200 or num == 1200) then
            AddNormalItemBind(6, 1, 1047, 1, 0, 0, 1)
            Msg2Player("Chóc mõng ngµi më " .. g_Name .. " nhËn ®­îc LÔ bao Thñ CÊp Hung Thó.")
            WriteLog("[LÔ bao H­ng Quèc][NhËn ®­îc LÔ bao Thñ CÊp Hung Thó]")
            return
        end

        local nRand = math.random(1, 10000)
        local nRandSum = 0

        local nlenth = table.getn(g_ItemList)

        for i = 1, nlenth do
            nRandSum = nRandSum + g_ItemList[i].probability
            if (nRand <= nRandSum) then
                for j = 1, g_ItemList[i].count do
                    if (g_ItemList[i].addtype == "Earn") then
                        Earn(g_ItemList[i].ID[1])
                    elseif (g_ItemList[i].addtype == "EarnBind") then
                        EarnBind(g_ItemList[i].ID[1])
                    elseif (g_ItemList[i].addtype == "Buff") then
                        AddIBBuff(g_ItemList[i].ID[1], g_ItemList[i].ID[2])
                    elseif (g_ItemList[i].addtype == "AddNormalItem") then

                        nItem = AddNormalItem(g_ItemList[i].ID[1], g_ItemList[i].ID[2], g_ItemList[i].ID[3], g_ItemList[i].ID[4], g_ItemList[i].ID[5], g_ItemList[i].ID[6])

                        if (nItem > 0 and g_ItemList[i].isband > 0) then
                            SetItemBind(nItem, 1)
                        end
                    end
                end
                Msg2Player("Më LÔ bao H­ng Quèc, nhËn ®­îc " .. g_ItemList[i].name)
                WriteLog("[LÔ bao H­ng Quèc][NhËn ®­îc " .. g_ItemList[i].name .. "]")
                break
            end
        end
    end
end

function no()
    CloseDialog()
end;
