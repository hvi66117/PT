Task_Search_Status = 1260
Task_Search_LastDate = 1261
Task_Search_BindingNpc = 1262

Buff_Search_BuffA = 471
Buff_Search_BuffB = 472
Buff_Search_Sweet = 473

Task_Info_Search = 1019

Buff_Time_A = 180
Buff_Time_B = 60 * 15

Random_Maps = {
    [0] = {
        mapid = 0, name = "Khu vùc v« hiÖu",
    },
    [1] = {
        mapid = 21, name = "TriÒu Ca",
        [1] = { x = 238 * 8 + 4, y = 181 * 16 + 8, xr = 238, yr = 181, desc = "(238.181)" },
        [2] = { x = 192 * 8 + 4, y = 189 * 16 + 8, xr = 192, yr = 189, desc = "(192.189)" },
        [3] = { x = 204 * 8 + 4, y = 196 * 16 + 8, xr = 204, yr = 196, desc = "(204.196)" },
        [4] = { x = 219 * 8 + 4, y = 180 * 16 + 8, xr = 219, yr = 180, desc = "(219.180)" },
        [5] = { x = 229 * 8 + 4, y = 201 * 16 + 8, xr = 229, yr = 201, desc = "(229.201)" },
    },
    [2] = {
        mapid = 20, name = "T©y Kú",
        [1] = { x = 160 * 8 + 4, y = 188 * 16 + 8, xr = 160, yr = 188, desc = "(160.188)" },
        [2] = { x = 169 * 8 + 4, y = 198 * 16 + 8, xr = 169, yr = 198, desc = "(169.198)" },
        [3] = { x = 175 * 8 + 4, y = 193 * 16 + 8, xr = 175, yr = 193, desc = "(175.193)" },
        [4] = { x = 193 * 8 + 4, y = 201 * 16 + 8, xr = 193, yr = 201, desc = "(193.201)" },
        [5] = { x = 192 * 8 + 4, y = 187 * 16 + 8, xr = 192, yr = 187, desc = "(192.187)" },
    },
}

function getCoupleTeamStatus()
    if (IsMarried() ~= 1) then
        return 0
    elseif (GetTeamSize() ~= 2) then
        return 0
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local playerIndexCache = PlayerIndex
    PlayerIndex = teammateIndex
    local teammateID = math.mod(GetUUID(), 2 ^ 31)
    local teammateSpouseID = math.mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    PlayerIndex = playerIndexCache
    local selfID = math.mod(GetUUID(), 2 ^ 31)
    local selfSpouseID = math.mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    if (selfID == teammateSpouseID and selfSpouseID == teammateID) then
        return 1, teammateIndex
    else
        return 0
    end
end

function main()
    local coupleTeamStatus, teammateIndex = getCoupleTeamStatus()
    if (coupleTeamStatus ~= 1) then
        Talk(1, "no", "ChØ ®­îc sö dông trong <c=g>Tæ ®éi phu thª<c>!")
    elseif (GetSex() ~= 1) then
        Talk(1, "no", "ChØ cã <c=g>Thª tö<c> míi ®­îc sö dông!")
    else
        local selfTaskStatus = GetTaskByte(Task_Search_Status, 1)
        local selfRandMap = GetTaskByte(Task_Search_Status, 2)
        local selfBuffA = HaveIBBuff(Buff_Search_BuffA)
        local mapid, x, y = GetWorldPos()

        local playerIndexCache = PlayerIndex
        PlayerIndex = teammateIndex
        local teammateTaskStatus = GetTaskByte(Task_Search_Status, 1)
        local teammateBuffCount = GetIBBuffCount()
        local teammateBuffA = HaveIBBuff(Buff_Search_BuffA)
        local mapid2, x2, y2 = GetWorldPos()
        PlayerIndex = playerIndexCache

        if (selfTaskStatus == 9 or teammateTaskStatus == 9) then
            Talk(1, "no", "NhiÖm vô <c=g>TÇm Di <c> thÊt b¹i! Ch©n t×nh ®µnh ph¶i chÞu vïi ch«n!")
        elseif (selfTaskStatus == 0 or selfTaskStatus > 3) then
            Talk(1, "no", "VËt nµy chØ sö dông khi ®ang thùc hiÖn nhiÖm vô <c=g>TÇm Di <c>!")
        elseif (mapid ~= Random_Maps[selfRandMap].mapid) then
            local mapName = Random_Maps[selfRandMap].name
            Talk(1, "no", "VËt nµy chØ khi ®ang thùc hiÖn nhiÖm vô <c=g>" .. mapName .. "<c> míi ®­îc sö dông")
        elseif (mapid2 ~= Random_Maps[selfRandMap].mapid) then
            local mapName = Random_Maps[selfRandMap].name
            Talk(1, "no", "VËt nµy ph¶i cã phu thª ®ång thêi ®Òu ®ang tiÕn hµnh nhiÖm vô <c=g>" .. mapName .. "<c> míi ®­îc sö dông")
        elseif (selfTaskStatus == 1) then
            if (GetIBBuffCount() >= 31) then
                Talk(1, "no", "B¹n ®ang cã qu¸ nhiÒu trang th¸i trªn ng­êi, kh«ng thÓ khai më T×nh Tø kÕt")
                return
            elseif (teammateBuffCount >= 31) then
                Talk(1, "no", "T­íng c«ng cña b¹n ®ang cã qu¸ nhiÒu trang th¸i trªn ng­êi, kh«ng thÓ gióp b¹n khai më T×nh Tø kÕt")
                return
            end
            local randomCoordinate1 = math.random(1, 5)
            local randomCoordinate2 = math.random(1, 5)
            local wifeCoordinate = Random_Maps[selfRandMap][randomCoordinate1]
            local husbandCoordinate = Random_Maps[selfRandMap][randomCoordinate2]
            SetTaskByte(Task_Search_Status, 1, 2)
            SetTaskByte(Task_Search_Status, 3, randomCoordinate1)
            SetTaskByte(Task_Search_Status, 4, randomCoordinate2)
            AddIBBuff(Buff_Search_BuffA, Buff_Time_A)
            TaskNote(Task_Info_Search, 1, husbandCoordinate.xr, husbandCoordinate.yr, wifeCoordinate.xr, wifeCoordinate.yr)
            Msg2Player("NhiÖm vô TÇm Di b¾t ®Çu. Hai ng­êi cÇn ph¶i t©m ®ång ý hîp víi nhau. B­íc 1: ®Õn" .. wifeCoordinate.desc .. ", ®îi T­íng c«ng ®Õn ®Þa ®iÓm chÝnh x¸c sÏ sö dông T×nh Tø kÕt!")
            TopMessage("TÇm Di: mau ®Õn ®Þa ®iÓm" .. wifeCoordinate.desc)

            local playerIndexCache = PlayerIndex
            PlayerIndex = teammateIndex
            SetTaskByte(Task_Search_Status, 1, 2)
            SetTaskByte(Task_Search_Status, 3, randomCoordinate1)
            SetTaskByte(Task_Search_Status, 4, randomCoordinate2)
            AddIBBuff(Buff_Search_BuffA, Buff_Time_A)
            TaskNote(Task_Info_Search, 1, husbandCoordinate.xr, husbandCoordinate.yr, wifeCoordinate.xr, wifeCoordinate.yr)
            Msg2Player("NhiÖm vô TÇm Di b¾t ®Çu. Hai ng­êi cÇn ph¶i t©m ®ång ý hîp víi nhau. B­íc 1: ®Õn" .. husbandCoordinate.desc .. ", sau ®ã ®îi Thª tö sö dông T×nh Tø kÕt")
            TopMessage("mau ®Õn" .. husbandCoordinate.desc)
            PlayerIndex = playerIndexCache

            Talk(1, "no", "Trong thêi gian quy ®Þnh, phu thª hai ng­êi cÇn t×m ra c¸c khu vùc liªn quan T×nh Tø! Thª tö t×m thÊy ®Þa ®iÓm<c=g>" .. wifeCoordinate.desc .. "<c>, T­íng c«ng t×m thÊy ®Þa ®iÓm <c=g>" .. husbandCoordinate.desc .. "<c>, lËp tøc ®Õn vÞ trÝ chØ ®Þnh sö dông T×nh Tø kÕt ®Ó b¾t ®Çu b­íc tiÕp theo!")
        elseif (selfBuffA == 0) then
            Talk(1, "no", "TiÕc qu¸! Hai ng­êi phèi hîp kh«ng t©m ®ång ý hîp! NhiÖm vô ®· kÕt thóc, xin ®Õn b¸o kÕt qu¶ cho NguyÖt L·o!")
        elseif (selfTaskStatus == 2) then
            local randomMap = GetTaskByte(Task_Search_Status, 2)
            local wifeCoordinate = Random_Maps[randomMap][GetTaskByte(Task_Search_Status, 3)]
            local husbandCoordinate = Random_Maps[randomMap][GetTaskByte(Task_Search_Status, 4)]
            local wifeDistance = (wifeCoordinate.x - x) ^ 2 + (wifeCoordinate.y - y) ^ 2
            local husbandDistance = (husbandCoordinate.x - x2) ^ 2 + (husbandCoordinate.y - y2) ^ 2

            if (wifeDistance > 100) then
                Msg2Player("B¹n ch­a ®Õn ®óng ®¹i ®iÓm chØ ®Þnh!" .. wifeCoordinate.desc .. ".")
                TopMessage("§Õn ®Þa ®iÓm" .. wifeCoordinate.desc)
            else
                if (husbandDistance > 100) then
                    Msg2Player("B¹n ®· ®Õn khu vùc cÇn ®Õn, ®îi T­íng c«ng ®Õn ®iÓm ®Ých sÏ sö dông T×nh Tø kÕt më b­íc tiÕp theo")
                    TopMessage("B¹n ®· ®Õn ®óng ®¹i ®iÓm chØ ®Þnh!")
                    local playerIndexCache = PlayerIndex
                    PlayerIndex = teammateIndex
                    Msg2Player("Thª tö cña b¹n ®· ®Õn khu vùc chØ ®Þnh, xin lËp tøc t×m ®Þa ®iÓm!" .. husbandCoordinate.desc .. ".")
                    TopMessage("§Õn ®Þa ®iÓm" .. husbandCoordinate.desc)
                    PlayerIndex = playerIndexCache
                else
                    local randomCoordinate1 = math.random(1, 5)
                    local randomCoordinate2 = math.random(1, 5)
                    local wifeCoordinate = Random_Maps[selfRandMap][randomCoordinate1]
                    local husbandCoordinate = Random_Maps[selfRandMap][randomCoordinate2]
                    SetTaskByte(Task_Search_Status, 1, 3)
                    SetTaskByte(Task_Search_Status, 3, randomCoordinate1)
                    SetTaskByte(Task_Search_Status, 4, randomCoordinate2)
                    TaskNote(Task_Info_Search, 2, husbandCoordinate.xr, husbandCoordinate.yr, wifeCoordinate.xr, wifeCoordinate.yr)
                    Msg2Player("B­íc 2: Néi trong thêi gian quy ®Þnh lËp tøc ®Õn ®Þa ®iÓm" .. wifeCoordinate.desc .. ", ®îi T­íng c«ng ®Õn ®Þa ®iÓm chÝnh x¸c sÏ sö dông T×nh Tø kÕt!")
                    TopMessage("§Õn ®Þa ®iÓm" .. wifeCoordinate.desc)

                    local playerIndexCache = PlayerIndex
                    PlayerIndex = teammateIndex
                    SetTaskByte(Task_Search_Status, 1, 3)
                    SetTaskByte(Task_Search_Status, 3, randomCoordinate1)
                    SetTaskByte(Task_Search_Status, 4, randomCoordinate2)
                    TaskNote(Task_Info_Search, 2, husbandCoordinate.xr, husbandCoordinate.yr, wifeCoordinate.xr, wifeCoordinate.yr)
                    Msg2Player("B­íc 2: Néi trong thêi gian quy ®Þnh lËp tøc ®Õn ®Þa ®iÓm" .. husbandCoordinate.desc .. ", sau ®ã ®îi Thª tö sö dông T×nh Tø kÕt")
                    TopMessage("§Õn ®Þa ®iÓm" .. husbandCoordinate.desc)
                    PlayerIndex = playerIndexCache
                end
            end
        elseif (selfTaskStatus == 3) then
            local randomMap = GetTaskByte(Task_Search_Status, 2)
            local wifeCoordinate = Random_Maps[randomMap][GetTaskByte(Task_Search_Status, 3)]
            local husbandCoordinate = Random_Maps[randomMap][GetTaskByte(Task_Search_Status, 4)]
            local wifeDistance = (wifeCoordinate.x - x) ^ 2 + (wifeCoordinate.y - y) ^ 2
            local husbandDistance = (husbandCoordinate.x - x2) ^ 2 + (husbandCoordinate.y - y2) ^ 2

            if (wifeDistance > 100) then
                Msg2Player("B¹n ch­a ®Õn ®óng ®¹i ®iÓm chØ ®Þnh!" .. wifeCoordinate.desc .. ".")
                TopMessage("§Õn ®Þa ®iÓm" .. wifeCoordinate.desc)
            else
                if (husbandDistance > 100) then
                    Msg2Player("B¹n ®· ®Õn khu vùc cÇn ®Õn, ®îi T­íng c«ng ®Õn ®iÓm ®Ých sÏ sö dông T×nh Tø kÕt më b­íc tiÕp theo")
                    TopMessage("B¹n ®· ®Õn ®óng ®¹i ®iÓm chØ ®Þnh!")
                    local playerIndexCache = PlayerIndex
                    PlayerIndex = teammateIndex
                    Msg2Player("Thª tö cña b¹n ®· ®Õn khu vùc chØ ®Þnh, xin lËp tøc t×m ®Þa ®iÓm!" .. husbandCoordinate.desc .. ".")
                    TopMessage("§Õn ®Þa ®iÓm" .. husbandCoordinate.desc)
                    PlayerIndex = playerIndexCache
                else
                    SetTaskByte(Task_Search_Status, 1, 4)
                    DelNormalItem(6, 1, 390, 1)
                    DelNormalItemInQuick(6, 1, 390, 1)
                    RemoveIBBuff(Buff_Search_BuffA)
                    AddIBBuff(Buff_Search_BuffB, Buff_Time_B)
                    TaskNote(Task_Info_Search, 3)
                    Msg2Player("B­íc 3: néi trong thêi gian quy ®Þnh, tæ ®éi víi t­íng c«ng, sau ®ã ®Õn gÆp Sø gi¶ torng thµnh thÞ hiÖn t¹i ®Ó b¾t ®Çu b­íc tiÕp theo!")
                    TopMessage("Mau ®Õn gÆp Sø gi¶ ®Ó b¾t ®Çu b­íc tiÕp theo")

                    local playerIndexCache = PlayerIndex
                    PlayerIndex = teammateIndex
                    SetTaskByte(Task_Search_Status, 1, 4)
                    RemoveIBBuff(Buff_Search_BuffA)
                    AddIBBuff(Buff_Search_BuffB, Buff_Time_B)
                    TaskNote(Task_Info_Search, 3)
                    Msg2Player("B­íc 3: néi trong thêi gian quy ®Þnh, tæ ®éi víi Thª tö, sau ®ã ®Õn gÆp Sø gi¶ torng thµnh thÞ hiÖn t¹i ®Ó b¾t ®Çu b­íc tiÕp theo!")
                    TopMessage("Mau ®Õn gÆp Sø gi¶ ®Ó b¾t ®Çu b­íc tiÕp theo")
                    PlayerIndex = playerIndexCache
                end
            end
        end
    end
end

function no()
    CloseDialog()
end
