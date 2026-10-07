require("ÊôÐÔÁé³è.luax")
L_PETCOMBOS = Able_Pet.L_PETCOMBOS
NitemName = "Áé³è½±ÀøÀñºÐ"
NItemid = 1746

function main()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        if (HaveNormalItem(6, 1, NItemid, 0) > 0) then
            if (DelNormalItem(6, 1, NItemid, 0) > 0) then
                AddNormalItem(6, 1, NItemid, 1, 0, 0)
            end
        end

        if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
            Talk(1, "no", "Áé³è½±ÀøÀñºÐ´ò¿ªÊ§°Ü")
            return
        end
    elseif (GetLevel() < 140) and (GetNewBirthTimes() < 1) and (GetServerStartTime() < 90) then
        Talk(1, "no", "¸ÃÀñ°üµÄ¿ªÆôÌõ¼þÎª: Çø·þ¿ªÇø90 ngµy ¼°ÒÔÉÏ, »ò¸öÈËµÈ¼¶140¼¶¼°ÒÔÉÏ.µ±Ç°Äú²»·ûºÏÌõ¼þ, ÎÞ·¨¿ªÆô¸ÃÀñ°ü")
        return
    end

    local tSayTable = {}
    local nTask = {}
    local idx = 0
    tSayTable[1] = "<c=g>Tinh Hoa Tiªn Sñng*20<c>/item_2"
    for i = 1, 6 do
        tSayTable[i + 1] = L_PETCOMBOS[i].name .. "/item_1"
    end

    Say("ÇëÑ¡ÔñÄúÏëÒªµÄ½±Àø, ÈôÄúÑ¡ÔñÁé³è×éºÏ, ½«»ñµÃ×éºÏ×´Ì¬µÄÁé³èÒ»¶Ô.ÈôÄúÒÑÓÐ¸Ã×éºÏ, Äú½«ÎÞ·¨Ñ¡Ôñ¸ÃÑ¡Ïî.", getn(tSayTable), tSayTable)
end

function item_1(index)
    no()
    if (index <= 0) or (index > table.getn(L_PETCOMBOS)) then
        Talk(1, "main", "Lùa chän sai, xin h·y chän l¹i tæ hîp kü!")
        return 0
    end

    SetTask(140, index)
    MsgBox("Mang theo tæ hîp Linh Sñng <c=y>" .. L_PETCOMBOS[index].name .. "<c>, ngoµi 2 kü n¨ng cña linh sñng, cßn nhËn ®­îc thuéc tÝnh d­íi ®©y:\n" .. L_PETCOMBOS[index].info, "item_1yes", "main")
end

function item_1yes()
    no()
    local index = GetTask(140)
    if (index <= 0) or (index > table.getn(L_PETCOMBOS)) then
        Talk(1, "main", "Lùa chän sai, xin h·y chän l¹i tæ hîp kü!")
        return 0
    end

    if (GetTaskByte(L_PETCOMBOS[index].taskIdx[1], L_PETCOMBOS[index].taskIdx[2]) == L_PETCOMBOS[index].petID) then
        Talk(1, "main", "Xin lçi, ngµi <c=r>®· kÝch ho¹t<c> qua tæ hîp kü n¨ng nµy, xin h·y chän l¹i!")
        return 0
    end

    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        AddNormalItemBind(6, 1, L_PETCOMBOS[index].itemID, 1, 0, 0, 1)
        WriteLog("[" .. NitemName .. "][" .. L_PETCOMBOS[index].name .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn ®­îc 1 " .. L_PETCOMBOS[index].name .. "Tæ hîp Kü n¨ng Linh thó¾íÖá, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, 20 do
            AddNormalItemBind(3, 1634, 0, 0, 0, 0, 1)
        end
        WriteLog("[" .. NitemName .. "][Tinh Hoa Tiªn Sñng]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn ®­îc 20 c¸i Tinh Hoa Tiªn Sñng, xin nhËn lÊy!")
    end
end
function no()
    CloseDialog()
end
