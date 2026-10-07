taskLaBa = 1673
taskPorridgeItem = 1674
taskTimeInterval = 1676
globalLaBa = 278

function GetPlayerTaskState()
    return 0, 0
end

function no()
    CloseDialog()
end

function main()
    local distanceArray = {
        [1] = { distance = { 835, 835, 835 }, rule = "3TiÓu Quû Trung ¦¬ng" },
        [2] = { distance = { 1180, 350, 1180 }, rule = "§Õn gÇn Lôc Quû, c¸ch xa vÞ trÝ Hång Quû vµ Lam Quû" },
        [3] = { distance = { 350, 1180, 1180 }, rule = "§Õn gÇn Hång Quû, c¸ch xa vÞ trÝ Lôc Quû vµ Lam Quû" },
        [4] = { distance = { 1280, 1280, 300 }, rule = "§Õn gÇn Lam Quû, c¸ch xa vÞ trÝ Hång Quû vµ Lôc Quû" },
        [5] = { distance = { 835, 835, 835 }, rule = "3TiÓu Quû Trung ¦¬ng" },
        [6] = { distance = { 1180, 350, 1180 }, rule = "§Õn gÇn Lôc Quû, c¸ch xa vÞ trÝ Hång Quû vµ Lam Quû" },
        [7] = { distance = { 1180, 1180, 350 }, rule = "§Õn gÇn Lam Quû, c¸ch xa vÞ trÝ Hång Quû vµ Lôc Quû" },
        [8] = { distance = { 350, 1180, 1180 }, rule = "§Õn gÇn Hång Quû, c¸ch xa vÞ trÝ Lôc Quû vµ Lam Quû" },
    }

    local randItemArray = {
        [1] = { name = "G¹o", percent = 34 },
        [2] = { name = "Kª", percent = 61 },
        [3] = { name = "G¹o nÕp", percent = 81 },
        [4] = { name = "§¹i t¸o", percent = 94 },
        [5] = { name = "L¹c", percent = 100 },
    }

    local ghostArray = { "Hång Quû", "Lôc Quû", "Lam Quû" }

    local mapId, playerX, playerY = GetWorldPos()

    if (mapId ~= 21) then
        Msg2Player("§Ëu ®á chØ cã thÓ sö dông gÇn chç 3 TiÓu Quû ë TriÒu Ca.")
        return
    end

    if (GetGlobalValueByte(globalLaBa, 4) ~= 1) then
        Msg2Player("TiÓu Quû hiÖn kh«ng ë TriÒu Ca, xin ®îi chóng xuÊt hiÖn råi míi sö dông §Ëu ®á.")
        return
    end

    local preTime = GetTask(taskTimeInterval)
    local timeInterval = LocalSystemTime() - preTime
    if (timeInterval < 20) then
        Msg2Player("H·y ®Õn " .. (20 - timeInterval) .. " gi©y sau míi dïng ®Ëu ®á ®­îc.")
        return
    end

    local distanceOfGhost = { 0, 0, 0 }
    distanceOfGhost[1] = math.floor(((1783 - playerX) ^ 2 + (3040 - playerY) ^ 2) ^ 0.5 * 32)
    distanceOfGhost[2] = math.floor(((1743 - playerX) ^ 2 + (3040 - playerY) ^ 2) ^ 0.5 * 32)
    distanceOfGhost[3] = math.floor(((1763 - playerX) ^ 2 + (3075 - playerY) ^ 2) ^ 0.5 * 32)

    local attackTimes = GetTaskByte(taskLaBa, 3) + 1
    local attackSuccess = 0
    local strItemName = ""
    local strAttackGhost = ""
    local randItemPercent = 0
    local itemIdx = 0
    local porridgeItem = 0

    if (attackTimes > 0 and attackTimes < 9) then
        for i = 1, 3 do
            if (distanceOfGhost[i] <= distanceArray[attackTimes].distance[i]) then
                attackSuccess = attackSuccess + 1
                randItemPercent = math.random(1, 100)
                for j = 1, 5 do
                    if (randItemPercent < randItemArray[j].percent) then
                        itemIdx = j
                        break
                    end
                end
                strItemName = strItemName .. randItemArray[itemIdx].name .. ","
                strAttackGhost = strAttackGhost .. ghostArray[i] .. ","

                if (itemIdx == 5) then
                    porridgeItem = GetTaskByte(taskLaBa, 4) + 1
                    SetTaskByte(taskLaBa, 4, porridgeItem)
                else
                    porridgeItem = GetTaskByte(taskPorridgeItem, itemIdx) + 1
                    SetTaskByte(taskPorridgeItem, itemIdx, porridgeItem)
                end
            end
        end
    end

    if (attackSuccess == 0) then
        Msg2Player("B¹n c¸ch TiÓu Quû qu¸ xa, kh«ng thÓ nÊu!")
    else
        AddEmoteBalloon(PlayerIndex, 42 + attackSuccess)
        SetTask(taskTimeInterval, LocalSystemTime())
        SetTaskByte(taskLaBa, 3, attackTimes)
        ScrollMessage("NÊu TiÓu Quû thµnh c«ng")
        if (attackTimes >= 1 and attackTimes <= 7) then

            Msg2Player("Chóc mõng! B¹n ®· nÊu thµnh c«ng <c=g>" .. strAttackGhost .. " <c=r>nhËn ®­îc<c=g> " .. strItemName .. "<c=r>B¹n cã thÓ t×m LÔ Quan bÊt kú lóc nµo ®Ó nhËn l­¬ng thùc. LÇn sau b¹n ph¶i chän vÞ trÝ " .. distanceArray[attackTimes + 1].rule .. ", nh­ vËy cã thÓ nhËn ®­îc cµng nhiÒu l­¬ng thùc h¬n!")
            Msg2Player("§Ëu ®á vÉn cã thÓ dïng" .. (8 - attackTimes) .. " lÇn")

        else
            ClearItem(6, 1, 799, 0)
            Msg2Player("Chóc mõng! B¹n ®· nÊu thµnh c«ng <c=g>" .. strAttackGhost .. " <c=r>nhËn ®­îc<c=g> " .. strItemName .. "<c=r>B¹n ®· hoµn thµnh XÝch §Ëu §¶ Quû, h·y mau t×m LÔ Quan ®Ó nhËn l­¬ng thùc!")
        end
    end
end
