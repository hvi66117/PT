G_GlobalValue_TianTian = 1

ThisActivity = 8

AddExpCount = { Type = 0, Value = 2000, ExtValue = 1000 }

ItemTableConst = {
    [1] = { name = "PhÔ nhi÷m vÙ chÒ Æ“ ngµy", ID = { 6, 1, 1005, 0 }, count = 1 },
}

NeedBageCount = 2
ItemTable1 = {
    [1] = { itemName = "S∏ch Ch≠ H«u (M∂nh)", itemID = { 8, 193, 5, 0 }, itemType = "item", itemCount = 1, itemPercent = 30, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [2] = { itemName = "Th«n C»u phÔ", itemID = { 8, 133, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 70, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [3] = { itemName = "HÂi thµnh phÔ (Si™u c p)", itemID = { 8, 291, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 180, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [4] = { itemName = "M∂nh Hoµng thÒy tinh", itemID = { 3, 88, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [5] = { itemName = "M∂nh LÙc ThÒy tinh", itemID = { 3, 248, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [6] = { itemName = "Chÿ nh©n", itemID = { 8, 135, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 200, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [7] = { itemName = "La H∏n hi÷u gi∏c", itemID = { 8, 233, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 120, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [8] = { itemName = "100 vπn l≠Óng", MoneyCount = 1000000, itemType = "bindmoney", itemCount = 1, itemPercent = 200, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
}
ItemTable2 = {
    [1] = { itemName = "S∏ch Ch≠ H«u (Tµn trang)", itemID = { 8, 1422, 5, 0 }, itemType = "item", itemCount = 1, itemPercent = 30, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [2] = { itemName = "Th«n C»u phÔ", itemID = { 8, 133, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 70, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [3] = { itemName = "HÂi thµnh phÔ (Si™u c p)", itemID = { 8, 291, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 180, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [4] = { itemName = "M∂nh Hoµng thÒy tinh", itemID = { 3, 88, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [5] = { itemName = "M∂nh LÙc ThÒy tinh", itemID = { 3, 248, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [6] = { itemName = "Chÿ nh©n", itemID = { 8, 135, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 200, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [7] = { itemName = "La H∏n hi÷u gi∏c", itemID = { 8, 233, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 120, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [8] = { itemName = "100 vπn l≠Óng", MoneyCount = 1000000, itemType = "bindmoney", itemCount = 1, itemPercent = 200, FakeCount = 0, FakeType = "global", TaskID = -1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
}
ItemTable = ItemTable1
BoxName = "‘∂’˜±∏’Ω∞¸∂˛"
boxID = { 6, 1, 1186, 1 }
function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)

    if (IsHaveSpaceForTreasure(NeedBageCount + 1) == 0) then
        InfoBox("TÛi kh´ng ÆÒ ´ trËng" .. NeedBageCount .. "h∑y sæp x’p lπi tÛi.")
        return
    end
    DelItemByID(itemID)

    if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
        ItemTable = ItemTable2
    end

    local str = ""
    local temp = 1

    for i = 1, table.getn(ItemTableConst) do
        for j = 1, ItemTableConst[i].count do
            AddNormalItemBind(ItemTableConst[i].ID[1], ItemTableConst[i].ID[2], ItemTableConst[i].ID[3], ItemTableConst[i].ID[4], 0, 0, 1)
        end
        str = str .. ItemTableConst[i].name .. ","
    end

    local nCount = 0
    local nRand = math.random(1, 1000)
    for i = 1, table.getn(ItemTable) do
        nCount = nCount + ItemTable[i].itemPercent
        if (nRand <= nCount) then
            if (ItemTable[i].itemType == "item") then
                if (ItemTable[i].FakeCount ~= 0) then
                    if (ItemTable[i].FakeType == "global") then

                        local nType = GetGlobalStoreValueByte(ItemTable[i].TaskID, 4)
                        local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
                        if (nType ~= nToday) then
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, 0, 1)
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, 4, nToday, 1)
                        end

                        local nCount = GetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue)
                        if (nCount < ItemTable[i].FakeCount) then
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, nCount + 1, 1)
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                        end
                    elseif (ItemTable[i].FakeType == "player") then

                        local nType = GetTaskByte(ItemTable[i].TaskID, 4)
                        if (nType ~= ThisActivity) then
                            SetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, 0)
                            SetTaskByte(ItemTable[i].TaskID, 4, ThisActivity)
                        end

                        local nCount = GetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue)
                        if (nCount < ItemTable[i].FakeCount) then
                            SetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, nCount + 1)
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                        end
                    end

                else
                    for j = 1, ItemTable[i].itemCount do
                        AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                    end
                end
                str = str .. ItemTable[i].itemName .. ","
            elseif (ItemTable[i].itemType == "bindmoney") then
                EarnBind(ItemTable[i].MoneyCount)
                str = str .. ItemTable[i].MoneyCount .. "Bπc,"
            elseif (ItemTable[i].itemType == "suit") then
                local nSex = GetSex() + 1
                if (ItemTable[i].FakeCount ~= 0) then
                    if (ItemTable[i].FakeType == "global") then

                        local nType = GetGlobalStoreValueByte(ItemTable[i].TaskID, 4)
                        if (nType ~= ThisActivity) then
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, 0, 1)
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, 4, ThisActivity, 1)
                        end

                        local nCount = GetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue)
                        if (nCount < ItemTable[i].FakeCount) then
                            SetGlobalStoreValueByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, nCount + 1, 1)
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2][nSex], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName[nSex] .. ","
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. ","
                        end
                    elseif (ItemTable[i].FakeType == "player") then

                        local nType = GetTaskByte(ItemTable[i].TaskID, 4)
                        if (nType ~= ThisActivity) then
                            SetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, 0)
                            SetTaskByte(ItemTable[i].TaskID, 4, ThisActivity)
                        end

                        local nCount = GetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue)
                        if (nCount < ItemTable[i].FakeCount) then
                            SetTaskByte(ItemTable[i].TaskID, ItemTable[i].TaskValue, nCount + 1)
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2][nSex], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName[nSex] .. ","
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. ","
                        end
                    end
                else
                    for j = 1, ItemTable[i].itemCount do
                        AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2][nSex], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                    end
                    str = str .. ItemTable[i].itemName[nSex] .. ","
                end
            end
            temp = i
            break
        end
    end

    if (AddExpCount ~= nil) then
        if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
            local Level = GetPlayerExtLevel()
            if (AddExpCount.Type == 0) then
                local TotalExp = AddExpCount.ExtValue * Level
                AddOwnExtendExp(TotalExp)
                str = str .. " vµ " .. TotalExp .. " Æi”m tu luy÷n!"
            elseif (AddExpCount.Type == 1) then
                AddOwnExtendExp(AddExpCount.ExtValue)
                str = str .. " vµ " .. AddExpCount.ExtValue .. " Æi”m tu luy÷n!"
            else
                str = str .. "."
            end
        else
            local Level = GetLevel()
            if (AddExpCount.Type == 0) then
                local TotalExp = AddExpCount.Value * Level
                AddOwnExp(TotalExp)
                str = str .. " vµ " .. TotalExp .. " kinh nghi÷m."
            elseif (AddExpCount.Type == 1) then
                AddOwnExp(AddExpCount.Value)
                str = str .. " vµ " .. AddExpCount.Value .. " kinh nghi÷m."
            else
                str = str .. "."
            end
        end
    end
    BrocateMessage(temp, str)

    if (ItemTable[temp].itemType == "suit") then
        WriteLog("[" .. BoxName .. "][øÁ∑˛‘∂’˜«∞ªÓ∂Ø][X∏c su t][" .. nRand .. "][MÎ vÀt ph»m][" .. ItemTable[temp].itemName[1] .. "]")
    else
        WriteLog("[" .. BoxName .. "][øÁ∑˛‘∂’˜«∞ªÓ∂Ø][X∏c su t][" .. nRand .. "][MÎ vÀt ph»m][" .. ItemTable[temp].itemName .. "]")
    end


end
function BrocateMessage(nMessageType, str)
    if (nMessageType < 1 or nMessageType > table.getn(ItemTable)) then
        return
    end
    if (ItemTable[nMessageType].MessageType >= 1) then
        Msg2Player("MÎ " .. BoxName .. " nhÀn Æ≠Óc " .. str)
    end
    if (ItemTable[nMessageType].MessageType >= 2) then
        AddGlobalCountNews(GetName() .. " mÎ " .. BoxName .. " nhÀn Æ≠Óc " .. str, ItemTable[nMessageType].MessageCount)
    end
    if (ItemTable[nMessageType].MessageType >= 3) then

    end
end
