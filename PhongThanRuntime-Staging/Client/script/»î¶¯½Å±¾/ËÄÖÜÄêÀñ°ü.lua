PackageOpenLimit = 1909
PackageOpenBit = 3

Task_4thAnniversary = 1889

ThisActivity = 102

G_GlobalValue_TianTian = 4

NeedBageCount = 2
ItemTable = {
    [1] = { itemName = "DÉn Lé Linh §¨ng", itemID = { 8, 1146, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 90, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [2] = { itemName = "100 v¹n l­îng", MoneyCount = 1000000, itemType = "bindmoney", itemCount = 1, itemPercent = 176, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 3, MessageCount = 1 },
    [3] = { itemName = " 100 v¹n b¹c", MoneyCount = 1000000, itemType = "money", itemCount = 1, itemPercent = 10, FakeCount = 100, FakeType = "global", TaskID = 4, TaskValue = 2, MessageType = 2, MessageCount = 1 },
    [4] = { itemName = "1000 v¹n ", MoneyCount = 10000000, itemType = "money", itemCount = 1, itemPercent = 5, FakeCount = 10, FakeType = "global", TaskID = 4, TaskValue = 1, MessageType = 3, MessageCount = 1 },
    [5] = { itemName = "ThiÖp nh­ ý", itemID = { 3, 138, 0, 0 }, itemType = "item", itemCount = 1, itemPercent = 20, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [6] = { itemName = "ThÇn CÈu phï", itemID = { 8, 133, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [7] = { itemName = "ChØ nh©n", itemID = { 8, 135, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 80, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [8] = { itemName = "ChØ Nam Ch©u (Nh­ ý)", itemID = { 8, 391, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [9] = { itemName = "Hµnh Qu©n LÖnh", itemID = { 8, 214, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [10] = { itemName = "Nh­ ý Di ngo¹i phï", itemID = { 8, 567, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [11] = { itemName = "Khao qu©n lÖnh", itemID = { 8, 268, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 100, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
    [12] = { itemName = "ThÎ Kim DËt", itemID = { 8, 1316, 6, 0 }, itemType = "item", itemCount = 1, itemPercent = 10, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 2, MessageCount = 1 },
    [13] = { itemName = "ThÇn ThuËt", itemID = { 8, 379, 2, 0 }, itemType = "item", itemCount = 1, itemPercent = 5, FakeCount = 0, FakeType = "global", TaskID = 4, TaskValue = 3, MessageType = 3, MessageCount = 1 },
    [14] = { itemName = { "Phiªu TuyÕt Nång T×nh-Long §«ng Th¸nh §¶n Trang", "Phiªu TuyÕt Nång T×nh-Long §«ng Th¸nh §¶n Trang" }, itemID = { 8, { 1703, 1703 }, 2, 0 }, itemType = "suit", itemCount = 1, itemPercent = 100, FakeCount = 1, FakeType = "player", TaskID = 1889, TaskValue = 1, MessageType = 2, MessageCount = 1 },
    [15] = { itemName = "ThiÖp nh­ ý", itemID = { 3, 138, 0, 0 }, itemType = "item", itemCount = 10, itemPercent = 4, FakeCount = 0, FakeType = "global", TaskID = 1, TaskValue = 1, MessageType = 1, MessageCount = 1 },
}

BoxName = "¿ç·þÔ¶Õ÷¼ªÇìÀñ°ü"
boxID = { 6, 1, 876, 1 }

function no()
    CloseDialog()
end

function main()
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local mapid, mapx, mapy = GetWorldPos()
    if (mapid ~= 21) then
        InfoBox("ThËt xin lçi, ¸ÃÀñ°üÖ»ÄÜÔÚTriÒu Ca míi cã thÓ më.")
        return
    end

    local nHour, nMinite, nSecond = GetHMS()
    if (nHour < 20 or nHour >= 23) then
        InfoBox("¸ÃÀñ°üÖ»ÄÜÔÚ»î¶¯ÆÚ¼äÃ¿Íí20ÖÁ23Ê±´ò¿ª.")
        return
    end

    local nYear, nMon, nDay = GetYMD()
    if (nYear ~= 2014 and nMon ~= 11) then
        InfoBox("¸ÃÀñ°üÒÑ¾­¹ýÆÚ, ÎÞ·¨Ê¹ÓÃ.")
        return
    end

    if (IsHaveSpaceForTreasure(NeedBageCount + 1) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng" .. NeedBageCount .. "h·y s¾p xÕp l¹i tói.")
        return
    end

    local nPackageUseTime = GetTaskByte(PackageOpenLimit, 4)
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    if (nPackageUseTime ~= nToday) then
        SetTask(PackageOpenLimit, 0)
        SetTaskByte(PackageOpenLimit, 4, nToday)
    else
        if (GetTaskBit(PackageOpenLimit, PackageOpenBit) == 1) then
            Talk(1, "CloseDialog", "Mçi ngµy chØ më Tói quµ 1 lÇn. ")
            return
        end
    end
    SetTaskBit(PackageOpenLimit, PackageOpenBit, 1)

    DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])

    local nRand = math.random(1, 1000)
    local str = ""
    local temp = 0
    local temppercent = 0

    local nRand = math.random(1, 1000)
    for i = 1, table.getn(ItemTable) do
        temppercent = temppercent + ItemTable[i].itemPercent
        if (nRand <= temppercent) then
            if (ItemTable[i].itemType == "item") then
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
                str = str .. ItemTable[i].itemName .. "."
            elseif (ItemTable[i].itemType == "money") then
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
                            Earn(ItemTable[i].MoneyCount)
                            str = str .. ItemTable[i].MoneyCount .. "."
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. "."
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
                            Earn(ItemTable[i].MoneyCount)
                            str = str .. ItemTable[i].MoneyCount .. "."
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. "."
                        end
                    end
                else
                    for j = 1, ItemTable[i].itemCount do
                        AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                    end
                    str = str .. ItemTable[i].itemName .. "."
                end
            elseif (ItemTable[i].itemType == "bindmoney") then
                EarnBind(ItemTable[i].MoneyCount)
                str = str .. ItemTable[i].MoneyCount .. " b¹c khãa."
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
                            str = str .. ItemTable[i].itemName[nSex] .. "."
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. "."
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
                            str = str .. ItemTable[i].itemName[nSex] .. "."
                        else
                            i = 1
                            for j = 1, ItemTable[i].itemCount do
                                AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                            end
                            str = str .. ItemTable[i].itemName .. "."
                        end
                    end
                else
                    for j = 1, ItemTable[i].itemCount do
                        AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2][nSex], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
                    end
                    str = str .. ItemTable[i].itemName[nSex] .. "."
                end
            end
            temp = i
            break
        end
    end
    BrocateMessage(temp, str)
end

function BrocateMessage(nMessageType, str)
    if (nMessageType < 1 or nMessageType > table.getn(ItemTable)) then
        return
    end
    if (ItemTable[nMessageType].MessageType >= 1) then
        Msg2Player("Më " .. BoxName .. " nhËn ®­îc " .. str)
    end
    if (ItemTable[nMessageType].MessageType >= 2) then
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>Më" .. BoxName .. "NhËn ®­îc " .. str)
    end
    if (ItemTable[nMessageType].MessageType >= 3) then
        AddGlobalCountNews("<c=g><RoleName=\"" .. GetName() .. "\"><c>Më" .. BoxName .. "NhËn ®­îc " .. str, ItemTable[nMessageType].MessageCount)
    end
end
