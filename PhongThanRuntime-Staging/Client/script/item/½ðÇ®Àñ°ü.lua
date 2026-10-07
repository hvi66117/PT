function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local nGen = GetItemGen(itemID)
    local nDetail = GetItemDetail(itemID)
    local nParticular = GetItemPartByID(itemID)
    local item = {
        [1315] = { money = 100, bind = 0, name = " 100 v¹n b¹c" },
        [1316] = { money = 200, bind = 0, name = "200 v¹n " },
        [1317] = { money = 400, bind = 0, name = "400 v¹n b¹c" },
        [1318] = { money = 5000, bind = 0, name = "5000 v¹n b¹c" },
        [1319] = { money = 8000, bind = 0, name = "8000 v¹n b¹c" },
        [1320] = { money = 10000, bind = 0, name = "1 øc" },
        [1321] = { money = 100, bind = 1, name = "100 v¹n l­îng" },
        [1322] = { money = 200, bind = 1, name = "200 v¹n b¹c khãa" },
        [1323] = { money = 400, bind = 1, name = "400 v¹n b¹c khãa" },
        [1324] = { money = 5000, bind = 1, name = "5000 v¹n b¹c khãa" },
        [1325] = { money = 8000, bind = 1, name = "8000 v¹n b¹c khãa" },
    }

    if (nGen ~= 6 or item[nParticular] == nil) then
        return
    end

    DelItemByID(itemID)
    if (item[nParticular].bind == 1) then
        EarnBind(item[nParticular].money * 10000)
    else
        Earn(item[nParticular].money * 10000)
    end

    Msg2Player("B¹n nh©n ®­îc " .. item[nParticular].name .. ".")
end
function no()
    CloseDialog()
end
