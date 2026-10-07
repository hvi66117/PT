Item_Glory = {
    [1] = { 200, 1 },
    [2] = { 300, 2 },
    [3] = { 500, 3 },
    [4] = { 700, 4 },
    [5] = { 1000, 5 },
    [6] = { 1500, 6 },
    [7] = { 2000, 7 },
    [8] = { 2500, 8 },
    [9] = { 3000, 9 },
    [10] = { 4000, 10 },
}
Task_Tong_today = 3
Task_Tong_count = 2
Task_time = 1
Task_Istrue = 2
res_money = 500000
res_bronze = 1000
Task_false_m = 30000

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local tasks = {
        { "Tiªu Xa l·nh ®Þa", "renwu"; show = 0 },
        { "Tiªu Xa ngôy trang", "renwu1"; show = 0 },
        { "QuyT¾cVËnTiªu", "intro"; show = 1 },
    }

    if (GetCamp() == 0) then
        Talk(1, "no", 11406)
    elseif (GetTask(60) ~= 0) then
        Talk(1, "no", 11407)
    elseif (GetLevel() < 30) then
        Talk(1, "no", 11408)
    elseif (GetTGuardIndexByPlayerName(GetName()) > 0) then
        if (GetTaskByte(959, 1) == 1) then
            Talk(1, "no", 13082)
        elseif (GetByte(GetTask(1238), 1) == 1 and HaveIBBuff(463) > 0) then
            Talk(1, "no", 14746)
        else
            Talk(1, "no", 11409)
        end
    elseif (GetFreeNpcCount() < 200) then
        Talk(1, "no", 14747)
    else
        local h, m, s = GetHMS()
        if (h >= 19) and (h < 23) then
            if (GetTongMemberDuty() == 2) or (GetTongMemberDuty() == 1) then
                tasks[1].show = 1
            end
            tasks[2].show = 1
        end

        SetTask(142, GetNpcID(DialogNpcIdx))

        SayTask(14748, tasks)
    end
end

function intro()
    Talk(1, "no", 14749)
end

function renwu()
    CloseDialog()

    local h, m, s = GetHMS()
    if (h < 19) or (h >= 23) then
        Talk(1, "no", 14750)
        return
    end

    local today = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTongTask(Task_Tong_today)
    if (today ~= lastday) then
        SetTongTask(Task_Tong_today, today)
        SetTongTask(Task_Tong_count, 0)
    end

    if (GetTongGlory() >= Item_Glory[1][1]) then
        local key, cha = IsReceive()
        if (key == 1) then
            MsgBox(14751, "yes", "no")
        elseif (key == 2) then
            MsgBox("L·nh ®Þa ng­¬i h«m nay ®· chuyÓn 1 lÇnTiªu Xa. H«m nµy cßn nhËn thªm ®­îc <c=g>" .. cha .. "<c> lÇn. LÇn tiÕp theo sÏ tiªu hao" .. res_bronze .. "§ång thau," .. res_money .. " l­îng! §ång ý chø?", "yes1", "no")
        else
            Talk(1, "no", "L·nh ®Þa cña ng­¬i ®· chuyÓn tiªu <c=g>" .. cha .. "<c> lÇn! Giê kh«ng thÓ nhËn thªm n÷a!")
        end
    else
        Talk(1, "no", 14752)
    end
end

function IsReceive()
    local count = GetTongTask(Task_Tong_count)
    if (count == 0) then
        return 1
    end

    local lvl = 10
    local attr = GetTongGlory()

    for i = 2, table.getn(Item_Glory) do
        if (attr < Item_Glory[i][1]) then
            lvl = i - 1
            break ;
        end
    end

    if (count < Item_Glory[lvl][2]) then
        return 2, (Item_Glory[lvl][2] - count)
    end

    return 0, Item_Glory[lvl][2]
end

function yes()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        CloseDialog()
        return 0
    end

    if (GetTaskByte(959, 1) == 1) then
        SetTaskByte(959, 1, 0)
        SetTaskByte(1972, 1, 0)
        TaskNote(64, -1)
        TaskNote(1947, -1)
    end

    local mapid, x, y = GetNpcWorldPos(DialogNpcIdx)
    x = x * 32 - math.random(100, 200)
    y = y * 32 + math.random(120, 150)

    local mapid1, _, _ = GetWorldPos()
    if (mapid1 ~= 19) then
        CloseDialog()
        return 0
    end

    local carriageindex = NewSiegeWeapon(mapid, x, y, 363, 3)

    if (carriageindex > 0) then
        CloseDialog()
        local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)

        if (carriagenpcindex <= 0) then
            Talk(1, "no", 14753)
            return 0
        end

        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\ïÚ³µ.lua")
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())
        WriteLog("[ÔËïÚ][ïÚ³µ]¼Ó³É¹¦")

        local tongName = GetTongName()
        local npcId = GetNpcID(carriagenpcindex)
        local guardindex = SendCarriage(carriageindex, GetName(), 1, 600, npcId, tongName, 3)
        SetTGuardTaskValue(guardindex, Task_time, 3)
        SetTGuardTaskValue(guardindex, Task_Istrue, 1)

        SetCurCamp(7)
        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)
        SetCurCamp(2)

        local count = GetTongTask(Task_Tong_count) + 1
        SetTongTask(Task_Tong_count, count)

        local playername = GetName()
        Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> t¹i TuyÖt Long LÜnh (lÇn thø) <bc><bc=blk>" .. count .. "<bc><bc=r> <bc>")
        AddGlobalCountNews("<c=g>" .. tongName .. "<c>L·nh ®Þa ®Õn TuyÖt Long LÜnh gÆp Tiªu ®Çu thÇn bÝ nhËn Tiªu Xa lÇn thø <c=r>" .. count .. "<c>", 3)
        return 1
    else
        Talk(1, "no", 14753)
    end ;
    return 0
end;

function yes1()
    local TongRes_m = GetTongRes(0)
    local TongRes_q = GetTongRes(1)

    if (TongRes_m >= res_money) and (TongRes_q >= res_bronze) then
        if (yes() >= 1) then
            WasteTongRes(0, res_money)
            WasteTongRes(1, res_bronze)
        end
    else
        Talk(1, "no", 14754)
    end
end;

function renwu1()
    CloseDialog()

    local h, m, s = GetHMS()
    if (h < 19) or (h >= 23) then
        Talk(1, "no", 14750)
        return
    end

    MsgBox("Ta hiÖn cã mé sè Tiªu xa ngôy trang, ng­¬i chØ cÇn tèn" .. Task_false_m .. " l­îng sÏ ®­îc nhËn mét chiÕc, cã thÓ yÓm hé cho Tiªu xa cña l·nh ®Þa! nhËn chø?", "made", "no")
end

function made()
    if (GetCash() < Task_false_m) then
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn. Tiªu Xa ngôy trang cÇn <c=r>" .. Task_false_m .. "<c> l­îng.")
        return 0
    end

    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        CloseDialog()
        return 0
    end

    if (GetTaskByte(959, 1) == 1) then
        SetTaskByte(959, 1, 0)
        SetTaskByte(1972, 1, 0)
        TaskNote(64, -1)
        TaskNote(1947, -1)
    end

    local mapid, x, y = GetNpcWorldPos(DialogNpcIdx)
    x = x * 32 - math.random(100, 200)
    y = y * 32 + math.random(120, 150)

    local carriageindex = NewSiegeWeapon(mapid, x, y, 363, 3)

    if (carriageindex > 0) then
        CloseDialog()
        local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)

        if (carriagenpcindex <= 0) then
            Talk(1, "no", 14753)
            return 0
        end

        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\¼ÙïÚ³µ.lua")
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())
        WriteLog("[ÔËïÚ][¼ÙïÚ³µ]¼Ó³É¹¦")

        local npcId = GetNpcID(carriagenpcindex)
        local guardindex = SendCarriage(carriageindex, GetName(), 1, 600, npcId, "", 3)
        SetTGuardTaskValue(guardindex, Task_Istrue, 2)

        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)
        Pay(Task_false_m)
    else
        Talk(1, "no", 14755)
    end ;
end

function no()
    CloseDialog()
end;
