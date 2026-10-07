module("NEWMONSTERTASK", package.seeall)

CITY_VAR_1 = 37;
CITY_VAR_2 = 38;
NEW_TASK_1 = 1954
NEW_TASK_2 = 1955
NEW_TASK_3 = 1956
NEW_TASK_Time = 1957

NEW_eggs = {
    [1] = { info = 1958, index = 1959, id = 1960, tim = 1961 },
    [2] = { info = 1962, index = 1963, id = 1964, tim = 1965 },
    [3] = { info = 1966, index = 1967, id = 1968, tim = 1969 }
}

NEW_TASK_KILL_Count = 1200
NEW_TASK_TIMES_Max = 2

NEW_TableTask = {
    [1] = { mapID = 26, mapName = "Hoang M¹c ChÕt", monID = 33, monName = "Thi V­¬ng", },
    [2] = { mapID = 26, mapName = "Hoang M¹c ChÕt", monID = 30, monName = "Cù Th¹ch", },
    [3] = { mapID = 36, mapName = "B¨ng Xuyªn Cùc", monID = 42, monName = "D· Mao thÇn", },
    [4] = { mapID = 36, mapName = "B¨ng Xuyªn Cùc", monID = 43, monName = "Vò La ThÇn", },
    [5] = { mapID = 41, mapName = "Long Uyªn", monID = 34, monName = "Ngäc N÷", },
    [6] = { mapID = 41, mapName = "Long Uyªn", monID = 38, monName = "Khai Minh ThÇn", },
    [7] = { mapID = 31, mapName = "Hiªn Viªn tÇng 5", monID = 40, monName = "Tr­êng Thõa ThÇn", },
    [8] = { mapID = 31, mapName = "Hiªn Viªn tÇng 5", monID = 41, monName = "L«i Tr¹ch thÇn", },
}
NEW_TABLE_CAMP = {
    [1] = "<c=earth>Phe N©u<c>",
    [2] = "<c=pk>Phe TÝm<c>",
    [3] = "<c=blue>Phe Xanh<c>",
    [4] = "<c=yellow>Phe Vµng<c>",
}

IB_LINGXINGSHI = {
    name = "Linh Tinh Th¹ch",
    IdTable = { 8, 359, 2 },
    ItemID = 63,
}
function New_MonsterTask ()

    local today = math.floor(LocalSystemTime() / 86400)

    if (GetCityTask(CITY_VAR_1) ~= today) then
        NEW_city_var_reset(today)
    end
    if (today ~= GetTask(NEW_TASK_1)) then
        NEW_player_task_reset(today)
    end

    local tasks = {
        { "Trõ ma VÖ thµnh cao cÊp", "NEW_mission_Kill"; show = 0 },
        { "Hoµn thµnh nhiÖm vô", "NEW_mission_Kill_end"; show = 0 },
        { "Hñy nhiÖm vô", "NEW_mission_Kill_cancel"; show = 0 },
        { "NhËn Ma T­íng Chi Linh", "NEW_RenewEgg"; show = 0 },
        { "Giíi thiÖu nhiÖm vô", "NEW_mission_Kill_intro"; show = 1 }
    }

    if (GetLevel() >= 40) and (GetTask(NEW_TASK_3) == 0) then
        if (GetTask(NEW_TASK_2) == 0) then
            tasks[1].show = 1;
        else
            tasks[2].show = 1
        end
    elseif (GetLevel() >= 40) and (GetTask(NEW_TASK_2) ~= 0) and (GetTask(NEW_TASK_3) ~= 0) then
        tasks[3].show = 1;
    end

    if (NEW_IsOneDis() > 0) then
        tasks[4].show = 1;
    end
    SayTask("Theo bÊm quÎ, nh÷ng qu¸i vËt cao cÊp ë s©u trong Mª cung sÏ tiÕn c«ng vµo Thµnh thÞ, nh÷ng ng­êi trÎ tuæi nh­ ng­¬i nªn chung tay b¶o vÖ Thµnh, cµng ®«ng ng­êi tham gia cµng dÔ dµng v­ît qua, ng­¬i muèn gia nhËp nhãm hé vÖ tham gia nhiÖm vô trõ ma hµng ngµy sao?", tasks)
end
function NEW_city_var_reset(today)
    SetCityTask(CITY_VAR_1, today)
    SetCityTask(CITY_VAR_2, math.random(2147483647))
end

function NEW_player_task_reset(today)
    local showmsg = 0
    SetTask(NEW_TASK_1, today)

    if (GetTask(NEW_TASK_2) ~= 0) or (NEW_isHaveTask() > 0) then
        showmsg = 1
    end
    TaskNote(1946, -1)
    SetTask(NEW_TASK_2, 0)
    SetTask(NEW_TASK_3, 0)
    SetTask(NEW_TASK_Time, 0)
    local lvl = GetOwnCityLevel()
    if (lvl ~= -1) then
        for i = 1, 3, 1 do
            SetTask(NEW_eggs[i].info, lvl + 3)
            SetTask(NEW_eggs[i].index, 0)
            SetTask(NEW_eggs[i].id, 0)
            SetTask(NEW_eggs[i].tim, 0)
        end
        SetTaskByte(NEW_eggs[2].info, 3, lvl + 1)
    end

    if (showmsg == 1) then
        Msg2Player("§· sang ngµy míi, nhiÖm vô thµnh thÞ ®­îc lµm míi. NhiÖm vô Trõ ma VÖ thµnh cao cÊp ®· hÕt h¹n.")
        TopMessage("T¸i lËp nhiÖm vô, tù ®éng xãa nhiÖm vô tr­íc kia!")
        SyncBibleState(1946, 1, 1)
    end
end

function NEW_isHaveTask()
    local taskNum = 0
    for i = 1, 3, 1 do
        if (GetTask(NEW_eggs[i].index) ~= 0) then
            taskNum = i
            break
        end
    end
    return taskNum
end
function NEW_IsOneDis()
    local taskNum = 0
    for i = 1, 3, 1 do
        local npcindex = GetTask(NEW_eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 587) or (GetTask(NEW_eggs[i].id) ~= GetNpcID(npcindex))) then
            if (GetTaskByte(NEW_eggs[i].info, 4) == 0) then
                taskNum = i
                break
            end
        end
    end
    return taskNum
end

function NEW_mission_Kill()
    CloseDialog()
    if (GetIBBuffCount() > 31) then
        Talk(1, "no", "Ng­¬i ®ang mang qu¸ nhiÒu tr¹ng th¸i torng ng­êi, kh«ng thÓ nhËn nhiÖm vô Trõ ma.")
        return 0
    end

    local rand, camp, kill_id, kill_name, _, kill_map = NEW_SetKillrenwu()
    local accept_times = GetTask(NEW_TASK_Time)
    if (kill_name ~= nil) then
        if (accept_times == 0) then
            MsgBox("Ta tÆng ng­¬i 1 Hµng yªu chó ®Ó hé th©n! H«m nay cÇn ®i <c=g>" .. kill_map .. "<c> hµng phôc <c=g>" .. kill_name .. "<c><c=g>" .. NEW_TASK_KILL_Count .. "<c> trong thêi gian chØ ®Þnh cÇn hoµn thµnh trong tr¹ng th¸i " .. NEW_TABLE_CAMP[camp] .. ", ng­¬i cã muèn ®i kh«ng?", "NEW_mission_check", "no")
        elseif (accept_times < NEW_TASK_TIMES_Max) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(IB_LINGXINGSHI.ItemID)
            MsgBox("Ta tÆng ng­¬i 1 Hµng yªu chó ®Ó hé th©n! H«m nay cÇn ®i <c=g>" .. kill_map .. "<c> hµng phôc <c=g>" .. kill_name .. "<c><c=g>" .. NEW_TASK_KILL_Count .. "<c> trong thêi gian chØ ®Þnh cÇn hoµn thµnh trong tr¹ng th¸i " .. NEW_TABLE_CAMP[camp] .. ", h«m nay tiÕp tôc nhËn trõ ma vÖ thµnh cÇn tiªu hao 2 <c=g>" .. IB_LINGXINGSHI.name .. "<c> hoÆc " .. (Cfs * 2) .. " Th«ng B¶o<c>, ng­¬i b»ng lßng kh«ng?", "NEW_mission_coin_check", "no")
        else
            Talk(1, "no", "Ng­¬i h«m nay ®· hoµn thµnh 2 lÇn nhiÖm vô Trõ ma, tuy viÖc trõ ma lµ quan träng, nh­ng còng cÇn gi÷ g×n søc khoÎ. Ngµy mai h·y tíi nhÐ!!")
        end
    else
        Talk(1, "no", "HÖ thèng b¸o lçi! Xin thö l¹i!")
    end
end

function NEW_SetKillrenwu()
    local _, _, _, _, lvl, _, CityTongName = GetCityInfo()
    lvl = lvl + 1

    math.randomseed(GetCityTask(CITY_VAR_2) + lvl)
    local rand = math.random(1, table.getn(NEW_TableTask))
    local nItem = NEW_TableTask[rand]
    local camp = math.random(1, table.getn(NEW_TABLE_CAMP))

    return rand, camp, nItem.monID, nItem.monName, nItem.mapID, nItem.mapName, CityTongName
end

function NEW_mission_check()
    CloseDialog()
    local rand, camp, kill_type, kill_name, kill_mapid, kill_map_name, Relation_TongName = NEW_SetKillrenwu()
    if (kill_type ~= nil) then
        RemoveIBBuff(1696)
        local done = AddIBBuff(1696)
        if (done == 1) then
            if (IsOwnerCity() ~= 1) then
                local playername = GetName()
                Msg2TongMemberByTongName(Relation_TongName, "<bc=r>l·nh ®Þa §ång minh<bc=blk>" .. GetTongName() .. "<bc><bc=r>_thµnh viªn <RoleName=\"" .. playername .. "\"> T¹i s©n luyÖn thó nhËn nhiÖm vô Trõ Ma<bc>")
            end
            SetTask(NEW_TASK_Time, (GetTask(NEW_TASK_Time) + 1))
            SetTaskByte(NEW_TASK_2, 1, rand)
            SetTaskByte(NEW_TASK_2, 2, camp)
            SetTask(NEW_TASK_3, NEW_TASK_KILL_Count)
            TaskNote(1946, 0, kill_map_name, kill_name, NEW_TASK_KILL_Count, NEW_TABLE_CAMP[camp])
            WriteLog("[Trõ ma VÖ thµnh cao cÊp][NhËn nhiÖm vô]")
        else
            Talk(1, "no", "Khi mäi tr¹ng th¸i cña b¹n kÕt thóc míi cã thÓ ®Õn nhËn nhiÖm vô!")
        end
    end
end

function NEW_mission_coin_check()
    CloseDialog()
    local rand, camp, kill_type, kill_name, kill_mapid, kill_map_name, Relation_TongName = NEW_SetKillrenwu()
    if (kill_type ~= nil) then
        if (GetIBBuffCount() > 31) then
            Talk(1, "no", "Ng­¬i ®ang mang qu¸ nhiÒu tr¹ng th¸i torng ng­êi, kh«ng thÓ nhËn nhiÖm vô Trõ ma.")
            return
        end
        if (COMMON.Cost_IBItem_Num(IB_LINGXINGSHI.ItemID, IB_LINGXINGSHI.IdTable, 2, IB_LINGXINGSHI.name) ~= 1) then
            Talk(1, "no", "ThËt xin lçi, <c=r>" .. IB_LINGXINGSHI.name .. "<c> hoÆc Th«ng B¶o kh«ng ®ñ.")
            return
        end

        NEW_mission_check()
    else
        Talk(1, "no", "ThËt xin lçi, hÖ thèng cã lçi.")
    end
end

function NEW_mission_Kill_end()
    if (IsOwnerCity() ~= 1) then
        Talk(1, "no", "B¹n ph¶i quay vÒ l·nh ®Þa cña b¹n ®Ó giao nhiÖm vô!")
        return 0
    end

    TaskNote(1946, -1)
    SetTask(NEW_TASK_2, 0)
    SetTask(NEW_TASK_3, 0)
    RemoveIBBuff(1696)
    AddTongContri(1)
    local egg_r = math.random(1, 100)
    local playername = GetName()
    AddNormalItemPile(6, 1, 1180, 0, 0, 0)

    Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> hoµn thµnh nhiÖm vô Trõ ma VÖ thµnh cao cÊp, ®é cèng hiÕn l·nh ®Þa t¨ng 1</bc>")

    if (egg_r > 95) then
        AddNormalItemPile(6, 1, 1180, 0, 0, 0)
        TopMessage("Chóc mõng ng­¬i nhËn ®­îc thªm 1 <c=g>Ma T­íng Chi Linh<c>")
        Talk(1, "no", "Chóc mõng ng­¬i nhËn ®­îc <c=g>Ma T­íng Chi Linh<c> cïng <c=g>1 ®iÓm cèng hiÕn<c> t­¬ng truyÒn trong ®ã cã chøa ph¸p lùc cña Ma Gia Tø T­îng!")
    else
        Talk(1, "no", "Th­ëng cho ng­¬i <c=g>Ma T­íng Chi Linh<c> cïng <c=g>1 ®iÓm cèng hiÕn<c> t­¬ng truyÒn trong ®ã cã chøa ph¸p lùc cña Ma Gia Tø T­îng!")
    end
    WriteLog("[Trõ ma VÖ thµnh cao cÊp][Hoµn thµnh nhiÖm vô]")

    local nRank = math.random(1, 100)
    if (nRank <= 50) then
        AddIBBuff(1013)
        Msg2Player("Chóc mõng b¹n may m¾n nhËn ®­îc 1 lÇn tr¹ng th¸i [Dòng Vâ]!")
        TopMessage("Chóc mõng b¹n nhËn ®­îc tr¹ng th¸i [Dòng Vâ]")
    end

end

function NEW_mission_Kill_cancel()
    MsgBox("Ng­¬i cßn cÇn hµng phôc " .. GetTask(NEW_TASK_3) .. " qu¸i vËt, kiªn tr× thªm 1 chót n÷a sÏ cã thÓ hoµn thµnh, ch¾c ch¾n muèn tõ bá b©y giê sao?", "NEW_mission_cancel_yes", "no")
end

function NEW_mission_cancel_yes()
    TaskNote(1946, -1)
    SetTask(NEW_TASK_2, 0)
    SetTask(NEW_TASK_3, 0)
    RemoveIBBuff(1696)
    CloseDialog()
end

function NEW_RenewEgg()
    local nNum = 0
    local gongNum = 0
    local lvl = GetOwnCityLevel()

    for i = 1, 3, 1 do
        local npcindex = GetTask(NEW_eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 587) or (GetTask(NEW_eggs[i].id) ~= GetNpcID(npcindex))) then
            if (GetTaskByte(NEW_eggs[i].info, 4) == 0) then
                SetTask(NEW_eggs[i].index, -1)
                nNum = nNum + 1

                local nTimes = GetTaskByte(NEW_eggs[1].info, 3)
                if (nTimes - 1 <= 0) then
                    nTimes = 1
                end
                SetTaskByte(NEW_eggs[1].info, 3, nTimes - 1)
            else

                gongNum = gongNum + 1

            end
        end
    end

    if (nNum > 0) then
        for i = 1, nNum, 1 do
            AddNormalItemPile(6, 1, 1180, 0, 0, 0)
        end
        Talk(1, "no", "ThËt kh«ng may, Ma T­íng Chi Linh ng­¬i tu luyÖn ®· ®ét nhiªn biÕn mÊt, ta cã thÓ kh«i phôc l¹i cho ng­¬i 1 lÇn n÷a.")
    elseif (gongNum > 0) then
        Talk(1, "no", "ThËt kh«ng may, Ma T­íng Chi Linh ®· biÕn mÊt.")
    else
        Talk(1, "no", "Kh«ng ®ñ ®iÒu kiÖn, ta kh«ng thÓ cÊp l¹i Ma T­íng Chi Linh cho ng­¬i.")
    end
end

function NEW_mission_Kill_intro()
    Talk(1, "no", "Trõ ma VÖ thµnh cao cÊp cÇn ®i n¬i s©u cïng mª cung chÐm yªu trõ ma, h¬n n÷a cßn cÇn <c=r>ë phe PK chØ ®Þnh<c> míi cã thÓ hoµn thµnh; hoµn thµnh nhiÖm vô cã thÓ nhËn ®­îc Ma T­íng Chi Linh, tu luyÖn Ma T­íng Chi Linh cã thÓ gäi ra Ma Gia Tø T­íng, ®¸nh b¹i bän hä cã thÓ nhËn ®­îc <c=r>KhÝ Linh Tinh Tóy<c> dïng cho luyÖn ho¸ KhÝ Linh!")
end

function MonsterOnDeath(npcindex)
    if (GetLevel() < 60) or (IsTongMember() <= 0) then
        return
    end

    if (HaveIBBuff(1696) <= 0) then
        return
    end

    local nType = GetTaskByte(NEW_TASK_2, 1)
    if (nType < 1 or nType > table.getn(NEW_TableTask)) then
        return
    end
    local nFightMod = GetTaskByte(NEW_TASK_2, 2)

    local w, x, y = GetWorldPos()
    if (w == NEW_TableTask[nType].mapID) then
        local kind = GetNpcTemplateID(npcindex)
        if (kind == NEW_TableTask[nType].monID) then
            if (nFightMod == GetCamp()) then
                local count = GetTask(NEW_TASK_3) - 1
                if (count > 0) then
                    SetTask(NEW_TASK_3, count)
                    ScrollMessage("Trõ ma VÖ thµnh cao cÊp: Cßn cÇn hµng phôc " .. count .. " " .. NEW_TableTask[nType].monName)
                    TaskNote(1946, 0, NEW_TableTask[nType].mapName, NEW_TableTask[nType].monName, count, NEW_TABLE_CAMP[nFightMod])
                else
                    RemoveIBBuff(1696)
                    SetTask(NEW_TASK_3, 0)
                    TaskNote(1946, 1)
                    ScrollMessage("Trõ ma VÖ thµnh cao cÊp: Hoµn thµnh nhiÖm vô!")
                end
            end
        end
    end
end
