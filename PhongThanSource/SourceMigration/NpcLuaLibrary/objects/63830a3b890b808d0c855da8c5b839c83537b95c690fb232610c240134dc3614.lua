require("common.luax")
require("newserver.luax")

require("×ÊÁÏÆ¬ÀÏÓÃ»§»ØÁ÷.luax")
require("king.luax")

Task_Lucky = 1228
Task_LuckyTime = 1230
Global_Lucky = 161
Global_fakeCarlimit = 170
Global_fakeCarday = 171

Task_junzijingsai = 1567

Escort_Food_CarTime = 957
Escrot_Food_Times = 958
Escrot_Food_Task = 959
Escrot_Food_libao = 1010
Escort_Food_Fake = 1052

Escort_Food_Record = 1972
Escort_Food_Item_Times = 1973
ESCORTFOOD_LASTTIME = 1800

ESCORTFOOD_list = {
    [1] = { ntype = 1, item = { 3, 100, 0, 0 }, nums = 1, name = "1 c¸i T­íng Qu©n LÖnh(Kho¸)", rand = 5 },
    [2] = { ntype = 2, item = { 10000 }, nums = 100, name = "100 v¹n l­îng", rand = 20 },
    [3] = { ntype = 3, item = { 1 }, nums = 1, name = "GÊp ®«i ®iÓm kinh nghiÖm", rand = 20 },
    [4] = { ntype = 1, item = { 4, 39, 0, 0 }, nums = 1, name = "1 c¸i LiÔu Méc(Kho¸)", rand = 20 },
    [5] = { ntype = 1, item = { 3, 115, 0, 0 }, nums = 1, name = "1 c¸i Tø T­îng Tinh Hoa(Kho¸)", rand = 20 },
    [6] = { ntype = 1, item = { 3, 114, 0, 0 }, nums = 1, name = "1 c¸i Lôc §¹o Tinh Hoa(Kho¸)", rand = 20 },
}

resource_kind = { { "H­¬ng liÖu", "Hinh H­¬ng Lam" }, { "Gç", "ThÇn Méc" }, { "ThiÕt", "HuyÒn ThiÕt §Ønh" }, { "Vµng", "Hoµng Kim Chung" }, { "§ång thau", "" } }
car_maps = {
    { mapid = 15, x = 1555, y = 3378, r = 4 },
    { mapid = 15, x = 1548, y = 3369, r = 6 },
    { mapid = 15, x = 1560, y = 3379, r = 4 },
}

Card_Item = {
    [1] = { 8, 1316, 6, "ThÎ Kim DËt" },
    [2] = { 8, 1317, 2, "ThÎ Cµo" },
}

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

BAIJINYAYUNFU = { 6, 1, 1126, 1 }
JINPAIYAYUNFU = { 6, 1, 1032, 1 }

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 28
    if (GetLevel() >= startLevel) then
        local wg2 = GetTask(1353)
        if (GetLevel() - startLevel <= 5) then
            if (wg2 == 1) then
                state = 3
                subState = 0
            end
        else
            if (wg2 == 1) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 10) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

require("themeday_human.luax")

function main()
    local liangxiangStr = "VËn l­¬ng"

    if (GetLevel() >= 130) and (GetTask(1032) >= 500) then
        liangxiangStr = "<c=pk>VËn l­¬ng<c>"
    elseif (GetLevel() >= 85) and (GetTask(1032) >= 180) then
        liangxiangStr = "<c=g>VËn l­¬ng<c>"
    end
    tasks = {
        { "BÊt Tóy", "renwu1"; show = 0 },
        { liangxiangStr, "EFTeamSel"; show = 0 },
        { "Xe l­¬ng gi¶", "GetFakeCar"; show = 0 },
        { "Vµo s¬n cèc", "come"; show = 1 },
        { "§éc Cæ", "wugu2"; show = 0 },
        { "Qu©n nhu", "armyresource"; show = 0 },
        { "LÖnh Bµi Qu©n L­¬ng", "change_item"; show = 1 },
    }

    local H, M, S = GetHMS()
    local lvl = GetOwnCityLevel() + 1
    if H >= 18 and H < 23 and lvl > 0 then
        tasks[6].show = 1
    end

    UTask_Druid = GetTask(2);
    if (GetPlayerType() == 2) and (GetLevel() >= 35) and (UTask_Druid == 10) then
        tasks[1].show = 1
    end ;

    if (GetTaskByte(Escort_Food_Fake, 1) ~= 0) then
        tasks[3].show = 1
    elseif (GetTaskByte(Escrot_Food_Task, 1) ~= 0) then
        tasks[2].show = 1
    else
        tasks[2].show = 1
        tasks[3].show = 1
    end

    if (GetTask(1353) == 1) then
        tasks[5].show = 1
    end

    SetTask(142, GetNpcID(DialogNpcIdx))
    SayTask(10348, tasks)
end;

function EFTeamSel()
    if (GetTaskByte(Escrot_Food_Task, 1) == 2) then
        local nTimes = GetIBBuffTimes(267)
        if (nTimes >= 80) then
            Talk(1, "no", 13569)
            WriteLog("[VËn L­¬ng] Tr¹ng th¸i Kim Bµi ¸p VËn Quan max 80 c¸i")
            return
        end

        local nb = 1
        local bdw = GetTaskByte(Escrot_Food_Times, 4)
        if (bdw >= 2) then
            nb = 2
        end
        if (GetTaskByte(Escrot_Food_Times, 3) == 0) and (GetWeekDay() == 4) and (math.mod(math.floor(LocalSystemTime() / 86400), 256) == GetTaskByte(Escort_Food_CarTime, 1)) then
            Msg2Player("Chñ ®Ò nhiÖm vô h«m nay lµ VËn l­¬ng, chóc mõng b¹n nhËn ®­îc phÇn th­ëng nh©n ®«i vµ Kim Bµi danh hiÖu ¸p VËn Quan!")
            local nDoubel = 2
            if (HaveIBBuff(1523) > 0) then
                nDoubel = nDoubel + 1
                CostIBBuff(1523, 1)
                Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
            end

            if (HaveIBBuff(1480) > 0) then
                nDoubel = nDoubel + GetIBBuffLevel(1480) + 1
                Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
            end
            nb = math.floor(nb * nDoubel)
        end

        nTimes = 100 - nb - nTimes
        if (nTimes <= 0) then
            Talk(1, "no", 13569)
            AddIBBuff(1523)
            WriteLog("[VËn L­¬ng][BÊt th­êng][ Thªm tr¹ng th¸i Kim Bµi ¸p VËn Quan  " .. nb .. " c¸i][CÊp ho¹t ®éng chñ ®Ò ngµy]1480bufflvl: " .. GetIBBuffLevel(1480))
            return
        end

        OLDROLEGOBACK.FinishTask(2, -1)
        Ksg:OnTaskFinish(Escrot_Food_Times)
        NewServerMonkeyActivity()

        if (GetTaskByte(Escrot_Food_Times, 1) == 1) then
            AddNormalItemBind(3, 1185, 0, 0, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn 1 LÖnh Bµi Qu©n L­¬ng. ")
            WriteLog("[VËn L­¬ng] nhËn ®­îc LÖnh Bµi Qu©n L­¬ng")
        end

        if (GetTaskByte(Escort_Food_Record, 1) > 10) then
            local nTaskDay = GetTaskByte(Escort_Food_Item_Times, 4)
            local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
            if (nToday ~= nTaskDay) then
                SetTaskByte(Escort_Food_Item_Times, 1, 0)
                SetTaskByte(Escort_Food_Item_Times, 4, nToday)
            end
            local nYITimes = GetTaskByte(Escort_Food_Item_Times, 1) + 1
            if (nYITimes <= 3) then
                local nCount = 1
                if (GetTaskByte(Escort_Food_Record, 2) > 0) then
                    nCount = 2
                end
                for i = 1, nCount do
                    AddNormalItemBind(6, 1, 1190, 1, 0, 0, 1)
                end
                SetTaskByte(Escort_Food_Item_Times, 1, nYITimes)
                Msg2Player("B¹n nh©n ®­îc " .. nCount .. " c¸i M¶nh Quang Dùc Chi Vò.")
                WriteLog("[VËn L­¬ng][VËn l­¬ng Cao cÊp] nhËn ®­îc M¶nh Quang Dùc Chi Vò" .. nCount .. " c¸i [nYITimes: " .. nYITimes)
            else
                Msg2Player("VËn l­¬ng Cao cÊp 3 lÇn ®Çu míi nhËn ®­îc M¶nh Quang Dùc Chi Vò, sau nµy kh«ng thÓ nhËn.")
            end
            TaskNote(64, -1)
            TaskNote(1947, 3)

        else
            TaskNote(1947, -1)
            TaskNote(64, 3)
        end

        for i = 1, nb do
            AddIBBuff(267)
        end
        WriteLog("[VËn L­¬ng][ Thªm tr¹ng th¸i Kim Bµi ¸p VËn Quan  " .. nb .. " c¸i]")
        SetTask(1032, GetTask(1032) + 1)
        Msg2Player("B¹n nhËn ®­îc " .. nb .. " Kim Bµi danh hiÖu ¸p VËn Quan!")
        Talk(1, "no", "C¶m ¬n ng­¬i ®· kÞp thêi hç trî, ta ®Æc biÖt ban cho ng­¬i <c=y>" .. nb .. " c¸i<c> danh hiÖu Kim Bµi ¸p VËn Quan. Nghe nãi Lý Thiªn V­¬ng ®ang ban khen th­ëng lÖnh, c¨n cø theo sè lÇn <c=g>Kim Bµi ¸p VËn Quan<c> sÏ nhËn ®­îc phÇn th­ëng t­¬ng øng.")
        SetTask(Escrot_Food_Task, 0)
        SetTaskByte(Escort_Food_Record, 1, 0)
        SetTaskByte(Escort_Food_Record, 2, 0)
        SetTaskWord(Escrot_Food_Times, 2, 0)
        return
    end

    if (GetTaskByte(Escrot_Food_Task, 2) == 2) then
        Talk(1, "no", "HiÖn ng­¬i ®ang trong tr¹ng th¸i hé tiªu, h·y tËp trung hé tèng tiªu ®i, sau khi hoµn thµnh l¹i ®Õn gÆp ta.")
    elseif (GetLevel() < 55) then
        Talk(1, "no", 13571)
    elseif (GetCamp() == 0) then
        Talk(1, "no", 13572)

    elseif (GetPK() >= 88) then
        Talk(1, "no", "Tr¹ng th¸i mµu hång kh«ng thÓ vËn l­¬ng.")

    elseif (IsTongMember() == 0) then
        Talk(1, "no", 13573)
    elseif (GetTask(60) ~= 0) then
        Talk(1, "no", 13576)
    elseif (GetFreeNpcCount() < 160) then
        Talk(1, "no", "HiÖn giê l­¬ng thùc ch­a ®ãng xe xong! L¸t n÷a h·y quay l¹i nhÐ!")
    else
        local guardindex = COMMON.reSetGuardIndex()
        if (guardindex > 0) then
            if (GetTaskByte(Escrot_Food_Task, 1) == 1) or (GetTaskByte(Escort_Food_Fake, 1) > 0) then
                Talk(1, "no", 13581)
            elseif (GetTaskByte(1238, 1) == 1 and HaveIBBuff(463) > 0) then
                Talk(1, "no", 14400)
            elseif (HaveIBBuff(376) > 0) then
                Talk(1, "no", "Ng­¬i ®ang vËn chuyÓn r­îu, rÊt nguy hiÓm, ta kh«ng thÓ giao xe l­¬ng cho ng­¬i.")
            elseif (GetTaskByte(Task_junzijingsai, 1) > 0) then
                Talk(1, "no", "Ng­¬i ®ang trong thi Qu©n nhu, rÊt nguy hiÓm, ta kh«ng thÓ giao xe l­¬ng cho ng­¬i.")
            else
                Talk(1, "no", 13582)
            end
        else
            local NowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
            local LastTime = GetTaskByte(Escort_Food_CarTime, 1)

            if (NowTime ~= LastTime) or (GetTask(Escrot_Food_Times) == 0) then
                SetTask(Escrot_Food_Times, 0)
                SetTaskByte(Escort_Food_CarTime, 1, NowTime)
                offlineTotimes()
                TaskNote(64, -1)
                TaskNote(1947, -1)
            end ;
            SetTaskByte(Escrot_Food_Task, 1, 0)
            SetTaskByte(Escort_Food_Fake, 1, 0)
            SetTaskByte(Escort_Food_Record, 1, 0)
            EscortFoodSelect()
        end
    end
end

function EscortFoodSelect()
    no()
    local liangxiangStr = "VËn l­¬ng"

    if (GetLevel() >= 130) and (GetTask(1032) >= 500) then
        liangxiangStr = "<c=pk>VËn l­¬ng<c>"
    elseif (GetLevel() >= 85) and (GetTask(1032) >= 180) then
        liangxiangStr = "<c=g>VËn l­¬ng<c>"
    end
    tasks = {
        { liangxiangStr, "renwu2"; show = 1 },
        { "VËn l­¬ng Cao cÊp", "Escrot_Food"; show = 1 },
    }

    SayTask("GÇn ®©y trong dÞ giíi ta t×m ®­îc kh«ng Ýt nguyªn liÖu quý, chØ cÇn ng­êi hoµn thµnh VËn l­¬ng Cao cÊp, ta sÏ th­ëng cho <c=g>M¶nh Quang Dùc Chi Vò<c>! Ng­¬i muèn vËn l­¬ng lo¹i nµo?", tasks)
end
function wugu2()
    if (GetTask(1353) == 1) then
        Talk(2, "no", "·çÁÖ: <c=r>B¸ch niªn Gi¸p Cèt<c> lµ thñ lÜnh cña <c=r>Gi¸p Cèt<c>, chØ cÇn ng­¬i kh«ng ngõng tiªu diÖt <c=r>Gi¸p Cèt<c> h¾n sÏ hiÖn th©n.", GetName() .. " §a t¹ ®· t­¬ng trî!")
        SetTask(1353, 2)
        TaskNote(201, 1)
        AddOwnExp(3000)
        TopMessage("NhËn ®­îc 3000 ®iÓm kinh nghiÖm")
        refreshNpcTaskState()
    end
end

function fangchenmi()
    local state
    local mark

    state = GetWeakState()

    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu1()
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(3, "func_leave", 10349, 10350, 10351)
    else
        Talk(1, "no", 11718)
    end
end;

function func_leave()
    MsgBox(10352, "yes", "no")
end;

function yes()
    CloseDialog()
    NewWorld(15, 1687, 3106)
    SetTask(2, 11)
    TaskNote(29, 3)
    Msg2Player("Vµo s¬n cèc, cøu bän DÞ nh©n say r­îu.")

    refreshNpcTaskState()

end;

function come()
    NewWorld(15, 1687, 3106)
    CloseDialog()
end;

function renwu2()
    local playerlevel = GetLevel()
    local ml = playerlevel * 1000
    if (IsTongMember() == 0) then
        Talk(1, "no", 13573)
    elseif (GetCash() < ml) then
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn b¶o hiÓm! Ph¶i cã" .. ml .. ".")
    else
        IfHaveTaskItem()
    end
end;

function AcceptTaskCar()
    local bb = GetTaskByte(Escrot_Food_Times, 1)
    local addtimes = GetTaskByte(Escrot_Food_Times, 2) + 1
    local alltimes = GetTaskByte(1477, 3)
    local ml = GetLevel() * 1000

    if (alltimes >= addtimes) or (bb < 6) then
        local task = {
            { "VËn l­¬ng", "yes_normalmission"; show = 0 },
            { "N¹p tµi tu luyÖn", "yes_freefsb"; show = 0 },
            { "Khao qu©n lÖnh", "coin_renwu"; show = 0 },
            { "ThÎ Kim DËt", "Task_MonthCard"; show = 0 },
        }
        if (bb == 0) then
            task[1].show = 1
        elseif (bb < 6) then
            task[3].show = 1
            task[4].show = 1
        end
        local retime = alltimes - addtimes + 1
        local str = "Hoan nghªnh ng­¬i sö dông <c=g>ThÎ Kim DËt<c> nhËn <c=y>nhiÖm vô chñ ®Ò trong ngµy<c>: <c=g>VËn l­¬ng<c>. <c=g>ThÎ Kim DËt<c> hµng ®Ñp gi¸ rÎ, Ých lîi v« cïng!"

        if (retime > 0) then
            task[2].show = 1
            local pm_free = payMoneyfree(addtimes)
            SayTask("HiÖn t¹i ng­¬i tÝch lòy <c=r>" .. retime .. "<c> lÇn, nhiÒu h¬n sè lÇn nhËn nhiÖm vô miÔn phÝ, nÕu cã" .. pm_free .. " b¹c, cã thÓ nhËn thªm nhiÖm vô, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ.NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy. §­¬ng nhiªn viÖc ®Æt cäc <c=g>" .. ml .. "<c>B¹c lµ rÊt cÇn thiÕt." .. str, task)
        else
            SayTask("NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>. C¸ch nµy kh«ng ®ßi hái nhiÒu, chØ thu 1 sè b¹c nhÊt ®Þnh!" .. str, task)
        end
    else
        MsgBox(13577, "no")
    end
end

function IfHaveTaskItem()
    SetTask(141, 0)

    if (HaveNormalItem(BAIJINYAYUNFU[1], BAIJINYAYUNFU[2], BAIJINYAYUNFU[3], BAIJINYAYUNFU[4]) > 0) then
        CloseDialog()
        MsgBox("Cã muèn sö dông B¹ch Kim ¸p vËn phï t¨ng 300% sinh lùc", "Yes_Use2", "AcceptTaskCar")
    elseif (HaveNormalItem(JINPAIYAYUNFU[1], JINPAIYAYUNFU[2], JINPAIYAYUNFU[3], JINPAIYAYUNFU[4]) > 0) then
        CloseDialog()
        MsgBox("Cã muèn sö dông Kim Bµi ¸p vËn phï t¨ng100% sinh lùc", "Yes_Use1", "AcceptTaskCar")
    else
        AcceptTaskCar()
    end
end
function Yes_Use2()
    CloseDialog()
    SetTask(141, 2)
    AcceptTaskCar()
end
function Yes_Use1()
    CloseDialog()
    SetTask(141, 1)
    AcceptTaskCar()
end

function yes_normalmission()
    local ml = GetLevel() * 1000
    MsgBox("Cã mét chuyÕn l­¬ng cÇn chuyÓn ®Õn TuyÖt Long LÜnh cho Tæng binh Tr­¬ng QuÕ Ph­¬ng. §­êng ®i cã nhiÒu phØ tÆc, vâ nghÖ cña qu©n ta n¬i ®ã l¹i kh«ng cao. NÕu ng­¬i gióp ta vËn l­¬ng thµnh c«ng vµ mang tÝn vËt vÒ, ta sÏ ®Ò b¹t ng­¬i lµm quan vËn l­¬ng. Nh­ng ng­¬i ph¶i ®¨t cäc tiÒn b¶o hiÓm hµng <color=green>" .. ml .. "<c> tiÒn! Nh­ng phÇn th­ëng sÏ cao kh«ng ngê ®Êy! QuyÕt ®Þnh ch­a?", "che", "no")
end

function Task_MonthCard()
    local task = {
        { "Tu luyÖn th­êng", "Single_Cost"; show = 1 },
        { "Tu luyÖn nh©n ®«i", "Double_Cost"; show = 1 },
    }
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local str = "<c=g>NhiÖm vô chñ ®Ò Ngµy<c> bao gåm nhiÖm vô Th¸m Qu©n, NhiÖm vô Hµng phôc, DÑp lo¹n V¹n Tiªn TrËn, Thu thËp §¹o cô, Siªu §é, NhiÖm vô Thu ThËp, VËn L­¬ng, Hoa ThÇn BÝ, Thiªn §×nh ThÇn Thô, NhiÖm vô TruyÒn Tin, VËn chuyÓn VËt liÖu, LuyÖn §an, ThÝ luyÖn ThÊt Qu¸i, B¨ng Ho¶ Long Ch©u."
    SayTask("Phong L©m: " .. str .. "NÕu ng­¬i cã <c=g>" .. Cfs .. "Th«ng B¶o (ThÎ Kim DËt)<c>, ta sÏ ph¸ lÖ cho ng­¬i vËn l­¬ng thªm lÇn n÷a. NÕu ng­¬i muèn ®­îc nh©n ®«i kinh nghiÖm tu luyÖn, chØ cÇn giao nép <c=g>" .. (Cfs * 2) .. "Th«ng B¶o (ThÎ Kim DËt)<c>. Sao h¶?", task)
end

function Single_Cost()
    CloseDialog()
    local key1 = 0
    local bb = GetTaskByte(Escrot_Food_Times, 1) + 1
    if (bb == 1) then
        key1 = ok()
        if (key1 == 1) then
            Talk(1, "no", 13578)
        elseif (key1 == 2) then
            Talk(1, "no", 14399)
        end
        return 0
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cv) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cv) == 0) then
            Talk(1, "no", "KhÊu trõ ®iÓm sè ThÎ Kim DËt thÊt b¹i.")
            return
        end
        SetTaskByte(Escrot_Food_Times, 4, 1)
        Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
        WriteLog("[VËn L­¬ng]tiªu phÝ " .. Cfs .. " Th«ng B¶o(ThÎ Kim DËt)")
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe TÝm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc xe l­¬ng " .. strcolor .. " ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>Ng­¬i chØ cã 30 phót, sau 30 phót xe l­¬ng sÏ biÕn mÊt</c>, mau ®i nhanh vÒ sím!")
    end
end

function Double_Cost()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local key1 = 0
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cv * 2) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cv * 2) == 0) then
            Talk(1, "no", "KhÊu trõ ®iÓm sè ThÎ Kim DËt thÊt b¹i.")
            return 0
        end

        SetTaskByte(Escrot_Food_Times, 4, 2)
        Msg2Player("B¹n dïng " .. (Cfs * 2) .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
        WriteLog("[VËn L­¬ng]tiªu phÝ " .. (Cfs * 2) .. " Th«ng B¶o(ThÎ Kim DËt)")
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe TÝm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        local bb = GetTaskByte(Escrot_Food_Times, 1)
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc " .. strcolor .. " ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>Ng­¬i chØ cã 30 phót, sau 30 phót xe l­¬ng sÏ biÕn mÊt</c>, mau ®i nhanh vÒ sím!")
    end
end

function coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "che"; show = 1 },
        { "Tu luyÖn nh©n ®«i", "che2"; show = 1 },
    }

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("VËn l­¬ng")
    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName

    local strValue = "Quan phñ ban lÖnh:mçi ng­êi chØ cã thÓ vËn l­¬ng 1 lÇn trong ngµy. Nh­ng nÕu cã <c=g>Khao qu©n lÖnh</c> th× vÉn ®­îc rêi thµnh. NÕu ng­¬i cã <c=yel>1 Khao qu©n lÖnh</c> hoÆc tÆng ta <c=g>" .. PriceName .. "</c> Th«ng B¶o ta cã thÓ cho ng­¬i tiÕp tôc vËn l­¬ng, nÕu muèn gÊp ®«i tu vi lÞch luyÖn, chØ cÇn ®­a thªm <c=yel>2 Khao Qu©n LÖnh<c> hoÆc <c=yel>" .. (PriceName * 2) .. "<c> Th«ng B¶o. Sao h¶?"
    local n1, n2, strAdd = ThemeDayForHuman.PubFuncShowText("VËn l­¬ng")
    if (n1 > 0 and n2 > 0) then
        strValue = strValue .. strAdd
    elseif (n1 > 0 and n2 <= 0) then
        strValue = strValue .. strShow
    end
    SayTask(strValue, task)

end

function no()
    CloseDialog()
end;

function che()
    CloseDialog()

    local key1 = 0
    local bb = GetTaskByte(Escrot_Food_Times, 1) + 1
    if (bb == 1) then
        key1 = ok()
        if (key1 == 1) then
            Talk(1, "no", 13578)
        elseif (key1 == 2) then
            Talk(1, "no", 14399)
        end
        return 0
    end

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("VËn l­¬ng")
    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (i ~= 0) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        CostIBItem(i)
        SetTaskByte(Escrot_Food_Times, 4, 1)
        Msg2Player("B¹n ®æi 1 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng!")
        WriteLog("[VËn L­¬ng] Tiªu hao 1 Khao Qu©n LÖnh")
    elseif (GetCoin() >= Cv) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        CostCoinByIdx(CostId)
        SetTaskByte(Escrot_Food_Times, 4, 1)
        Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
        WriteLog("[VËn L­¬ng] Tiªu hao 1 Khao Qu©n LÖnh" .. Cfs .. " Th«ng B¶o")
    else
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
        return 0

    end

    if (key1 >= 1) then
        local strcolor = "Phe TÝm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc " .. strcolor .. " ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>Ng­¬i chØ cã 30 phót, sau 30 phót xe l­¬ng sÏ biÕn mÊt</c>, mau ®i nhanh vÒ sím!")
    end

end;

function che2()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByDouble("VËn l­¬ng")

    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local nums = HaveNormalItem(8, 268, 2, 0)
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (nums > 0) and (i == 0) then
        nums = 0
    end
    local mycoin = nums * Cv + GetCoin()
    local key1 = 0

    if (i ~= 0) then
        if (nums >= 2) then
            key1 = ok()
            if (key1 < 1) then
                return 0
            end

            CostIBItem(i)
            CostIBItem(FindAValidIBItem(8, 268, 2, 0))
            SetTaskByte(Escrot_Food_Times, 4, 2)
            Msg2Player("B¹n ®æi 2 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng")
            WriteLog("[VËn L­¬ng] Tiªu hao 2 Khao Qu©n LÖnh")
        elseif (nums == 1 and GetCoin() >= PriceCount) then
            key1 = ok()
            if (key1 < 1) then
                return 0
            end

            CostCoinByIdx(49)
            CostIBItem(i)
            SetTaskByte(Escrot_Food_Times, 4, 2)
            Msg2Player("B¹n dïng " .. PriceName .. " Th«ng B¶o vµ 1 Khao Qu©n lÖnh ®æi lÊy 1 lÇn vËn l­¬ng!")
            WriteLog("[VËn L­¬ng] Tiªu hao " .. PriceName .. " Th«ng B¶o vµ 1 Khao Qu©n LÖnh")
        else
            Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
            return 0
        end
    else
        if (GetCoin() >= (Cv * 2)) then
            key1 = ok()
            if (key1 < 1) then
                return 0
            end
            CostCoinByIdx(CostId)
            CostCoinByIdx(CostId)
            SetTaskByte(Escrot_Food_Times, 4, 2)
            Msg2Player("B¹n dïng " .. (Cfs * 2) .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
            WriteLog("[VËn L­¬ng] Tiªu hao " .. (Cfs * 2) .. " Th«ng B¶o-Khao Qu©n LÖnh")
        else
            Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
            return 0
        end
    end

    if (key1 >= 1) then
        local strcolor = "Phe TÝm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        local bb = GetTaskByte(Escrot_Food_Times, 1)
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc xe l­¬ng " .. strcolor .. " ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>Ng­¬i chØ cã 30 phót, sau 30 phót xe l­¬ng sÏ biÕn mÊt</c>, mau ®i nhanh vÒ sím!")
    end
end

function ok()
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", 13570)
        return 0
    end

    local nItemUse = GetTask(141)
    SetTask(141, 0)

    local cashmoney = GetLevel() * 1000
    if (GetCash() < cashmoney) then
        Talk(1, "no", "Ng©n l­îng cña ng­¬i kh«ng ®ñ, chÕ t¹o xe l­¬ng cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
        return 0
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 15) then
        Talk(1, "no", "Ng­¬i kh«ng ë gÇn, ta kh«ng c¸ch nµo giao xe l­¬ng cho ng­¬i.")
        WriteLog("[VËn L­¬ng][BÊt th­êng][Kh«ng ë m¹nh t©n " .. mapid)
        return 0
    end

    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13570)
        return 0
    end

    local num = math.random(1, 3)
    local x2, y2 = COMMON.reNewSetPos(car_maps[num].x, car_maps[num].y, car_maps[num].r)

    local camp = 2
    local str = "Phe TÝm"
    local key = 1
    local cartype = 556
    local playerlevel = GetLevel()
    if (fIsGreen(playerlevel) == 1) then
        cartype = 687
        camp = 7
        str = "<c=g>Phe Xanh<c>"
        key = 2
    end

    local carriageindex = NewSiegeWeapon(15, x2 * 32, y2 * 32, cartype)
    if (carriageindex <= 0) then
        carriageindex = NewSiegeWeapon(15, x * 32, y * 32, cartype)
        if (carriageindex > 0) then
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thµnh c«ng]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
        else
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thÊt b¹i]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
            Talk(1, "no", "HiÖn giê l­¬ng thùc ch­a ®ãng xe xong! L¸t n÷a h·y quay l¹i nhÐ!")
            return 0
        end
    end

    local playername = GetName()
    local carriagelevel = 1
    SendCarriage(carriageindex, playername, carriagelevel, ESCORTFOOD_LASTTIME)

    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        local pID = GetPlayerID()
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\Á¸âÃ³µ.lua")
        SetNpcTask(carriagenpcindex, 0, 0)
        SetNpcTask(carriagenpcindex, 1, pID)
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())
        SetNpcTask(carriagenpcindex, 4, 1)

        if (nItemUse == 1) then
            if (HaveNormalItem(JINPAIYAYUNFU[1], JINPAIYAYUNFU[2], JINPAIYAYUNFU[3], JINPAIYAYUNFU[4]) > 0) then
                if (DelNormalItem(JINPAIYAYUNFU[1], JINPAIYAYUNFU[2], JINPAIYAYUNFU[3], JINPAIYAYUNFU[4]) > 0) then
                    local nNpcIndex = GetSiegeWeaponNpcIndex(carriageindex)
                    if (nNpcIndex > 0) then
                        SetNpcLifeMax(nNpcIndex, GetNpcLifeMax(nNpcIndex) * 2)
                        NpcAddIBBuff(nNpcIndex, 1617)
                        Msg2Player("Sö dông Kim Bµi ¸p VËn Phï thµnh c«ng! Xe l­¬ng t¨ng rÊt nhiÒu sinh lùc!")
                        WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Sö dông thµnh c«ng]")
                    else
                        WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Sö dông thÊt b¹i][NpcIdx sai]")
                    end
                else
                    Msg2Player("Kim Bµi ¸p VËn Phï sö dông thÊt b¹i.")
                    WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Trõ ®¹o cô thÊt b¹i]")
                end
            else
                Msg2Player("Ngµi kh«ng cã Kim Bµi ¸p VËn Phï, kh«ng thÓ t¨ng sinh lùc xe l­¬ng.")
                WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Kh«ng cã ®¹o cô]")
            end
        elseif (nItemUse == 2) then
            if (HaveNormalItem(BAIJINYAYUNFU[1], BAIJINYAYUNFU[2], BAIJINYAYUNFU[3], BAIJINYAYUNFU[4]) > 0) then
                if (DelNormalItem(BAIJINYAYUNFU[1], BAIJINYAYUNFU[2], BAIJINYAYUNFU[3], BAIJINYAYUNFU[4]) > 0) then
                    local nNpcIndex = GetSiegeWeaponNpcIndex(carriageindex)
                    if (nNpcIndex > 0) then
                        SetNpcLifeMax(nNpcIndex, GetNpcLifeMax(nNpcIndex) * 4)
                        NpcAddIBBuff(nNpcIndex, 1617)
                        Msg2Player("Sö dông B¹ch Kim ¸p VËn Phï thµnh c«ng! Xe l­¬ng t¨ng rÊt nhiÒu sinh lùc!")
                        WriteLog("[B¹ch Kim ¸p VËn Phï][Sö dông thµnh c«ng]")
                    else
                        WriteLog("[B¹ch Kim ¸p VËn Phï][Sö dông thÊt b¹i][NpcIdx sai]")
                    end
                else
                    Msg2Player("B¹ch Kim ¸p VËn Phï sö dông thÊt b¹i.")
                    WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Trõ ®¹o cô thÊt b¹i]")
                end
            else
                Msg2Player("Ngµi kh«ng cã B¹ch Kim ¸p VËn Phï, kh«ng thÓ t¨ng sinh lùc xe l­¬ng.")
                WriteLog("[VËn L­¬ng][Kim Bµi ¸p VËn Phï][Kh«ng cã ®¹o cô]")
            end
        end

        Pay(playerlevel * 1000, 1)
        SetGlobalValue(Global_Lucky, GetGlobalValue(Global_Lucky) + 1)
        SetGlobalValue(Global_fakeCarlimit, GetGlobalValue(Global_fakeCarlimit) + 10)

        SetNpcCurCamp(carriagenpcindex, camp)
        SetCamp(camp)
        SetCurCamp(camp)

        TaskNote(64, 1)
        PlayerInOrOut(1, carriagenpcindex)

        if (GetTaskByte(Escrot_Food_Times, 3) == 0) then
            local bd = GetTaskByte(Escrot_Food_Times, 1) + 1
            Msg2Player("H«m nay lµ lÇn vËn l­¬ng thø " .. bd .. ". Xe l­¬ng ®· biÕn thµnh " .. str)

            if (bd >= 6) then
                SyncBibleState(64, 3, 1)
            else
                SyncBibleState(64, 2, 1)
            end
            SetTaskByte(Escrot_Food_Times, 1, bd)
        end
        SetTaskByte(Escrot_Food_Task, 1, 1)
        SetTask(Escort_Food_Fake, 0)
        local H, M, S = GetHMS()
        SetTaskByte(Escrot_Food_Task, 3, H)
        SetTaskByte(Escrot_Food_Task, 4, M)
        SetTaskByte(Escort_Food_Record, 1, 1)
        WriteLog("[VËn L­¬ng][Lªn xe l­¬ng thµnh c«ng]carriageindex:" .. carriageindex .. "carriagenpcindex:" .. carriagenpcindex .. "GetPlayerID():" .. GetPlayerID() .. "Tªn ng­êi ch¬i:" .. playername .. "Phe: " .. camp)
        return key
    else
        WriteLog("[VËn L­¬ng][BÊt th­êng][Thªm thµnh c«ng nh­ng carriagenpcindex<=0]carriageindex:" .. carriageindex .. "Tªn ng­êi ch¬i:" .. playername)
        Talk(1, "no", 13570)
        return 0
    end
end;

function renwu3()
    local cashmoney = pMoney()
    if (GetCash() < cashmoney) then
        Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
        return 0
    end

    MsgBox("Cã mét chuyÕn xe l­¬ng cÇn chuyÓn ®Õn <c=g>TuyÖt Long LÜnh cho Tæng binh Tr­¬ng QuÕ Ph­¬ng<c>, trªn ®­êng ®¹o tÆc v« sè, v× vËy nªn lµm xe gi¶ ®Ó ®¸nh l¹c h­íng chóng. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=g>" .. cashmoney .. "<c> l­îng! Ng­¬i muèn chÕ t¹o Xe l­¬ng gi¶ kh«ng? Xe gi¶ sÏ kh«ng ¶nh h­ëng ®Õn sè lÇn nhËn nhiÖm vô ChuyÓn l­¬ng", "made", "no")
end;

function made()
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", 13580)
        return 0
    end

    local cashmoney = pMoney()
    if (GetCash() < cashmoney) then
        Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
        return 0
    end

    local playerlevel = GetLevel()
    if (playerlevel < 50) then
        Talk(1, "no", "VËn l­¬ng ®Õn TuyÖt Long LÜnh v« cïng khã kh¨n, nÕu ch­a ®ñ ®¼ng cÊp, sÏ rÊt nguy hiÓm. §îi ng­¬i ®¹t cÊp 50 råi h·y ®Õn ®©y!")
        return 0
    end

    local limit = GetGlobalValue(Global_fakeCarlimit) - 1
    if (limit < 0) then
        Talk(1, "no", "§· l©u råi kh«ng cã ai ®Õn gióp ta chuyÓn l­¬ng, nªn ch¾c còng kh«ng cÇn giao xe gi¶ cho ng­¬i ®©u!")
        return 0
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 15) then
        WriteLog("[VËn L­¬ng][BÊt th­êng][Kh«ng ph¶i b¶n ®å M¹nh t©n " .. mapid)
        return 0
    end

    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13580)
        return
    end

    local num = math.random(1, 3)
    local x2, y2 = COMMON.reNewSetPos(car_maps[num].x, car_maps[num].y, car_maps[num].r)

    local carriageindex = NewSiegeWeapon(15, x2 * 32, y2 * 32, 556)
    if (carriageindex <= 0) then
        carriageindex = NewSiegeWeapon(15, x * 32, y * 32, 556)
        if (carriageindex > 0) then
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thµnh c«ng]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
        else
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thÊt b¹i]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
            Talk(1, "no", "Xe l­¬ng gi¶ lµ ®Ó ®¸nh lõa bän c­êng ®¹o c­íp l­¬ng. 1 xe thËt chØ ®­îc tèi tèi ®a 10 xe gi¶ hé tèng. Cã ®iÒu hiÖn t¹i gç ®ang rÊt hiÕm, nªn ta kh«ng cã nhiÒu xe gi¶ ®Ó tÆng cho ng­¬i!")
            return 0
        end
    end

    local playername = GetName()
    local carriagelevel = 1
    SendCarriage(carriageindex, playername, carriagelevel, ESCORTFOOD_LASTTIME)

    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\Î±×°µÄÁ¸âÃ³µ.lua")
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())

        Pay(cashmoney, 1)

        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)
        SetCurCamp(2)
        TaskNote(64, 4)
        Msg2Player("Ng­¬i vµ xe l­¬ng thuéc phe TÝm. CÇn b¶o vÖ xe l­¬ng vµ chë tíi TuyÖt Long LÜnh t×m tæng binh Tr­¬ng QuÕ Ph­¬ng, nÕu giao xe l­¬ng trong vßng 30 phót, ta sÏ hoµn l¹i " .. cashmoney .. " b¹c cho ng­¬i.")

        SetTaskByte(Escort_Food_Fake, 1, 1)
        SetTaskByte(Escrot_Food_Task, 1, 1)
        local H, M, S = GetHMS()
        SetTaskByte(Escrot_Food_Task, 3, H)
        SetTaskByte(Escrot_Food_Task, 4, M)
        local NowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        SetTaskByte(Escort_Food_CarTime, 3, NowTime)
        SetGlobalValue(Global_fakeCarlimit, limit)
        PlayerInOrOut(1, carriagenpcindex)
        WriteLog("[VËn L­¬ng][Î±×°Lªn xe l­¬ng thµnh c«ng]carriageindex:" .. carriageindex .. "carriagenpcindex:" .. carriagenpcindex .. "GetPlayerID():" .. GetPlayerID() .. "Tªn ng­êi ch¬i:" .. playername)
        MsgBox("H·y chë xe l­¬ng ®Õn <c=g>TuyÖt Long LÜnh<c> cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng<c>, nÕu nh­ an toµn chë ®Õn, ta sÏ ®em phÝ chÕ t¹o <c=g>" .. cashmoney .. "<c> b¹c tr¶ l¹i cho ng­¬i.\nChó ý ph¶i chuyÓn ®Õn trong 30 phót, nÕu kh«ng xe l­¬ng sÏ biÕn mÊt", "no")
    else
        WriteLog("[VËn L­¬ng][BÊt th­êng][Thªm thµnh c«ng nh­ng carriagenpcindex<=0]carriageindex:" .. carriageindex .. "Tªn ng­êi ch¬i:" .. playername)
        Talk(1, "no", 13580)
    end
end;

function fIsGreen(playerlevel)

    local Item_data = {
        [1] = { 55, 20, 10 },
        [2] = { 80, 20, 10 },
        [3] = { 100, 20, 10 },
        [4] = { 120, 20, 10 },
    }

    local lucy = GetTask(Task_Lucky)
    local times = GetTask(Task_LuckyTime)
    SetTask(Task_LuckyTime, times + 1)

    for i = 4, 1, -1 do
        if (playerlevel >= Item_data[i][1]) then
            if (times < Item_data[i][3]) then
                SetTask(Task_Lucky, lucy + Item_data[i][2])
            end
            break
        end
    end

    if (lucy == 0) then
        return 1
    elseif (math.mod(GetGlobalValue(Global_Lucky), 20) == 0) then
        return 1
    else
        local r = math.random(1, 1000)
        if (r <= lucy) then
            SetTask(Task_Lucky, 1)
            SetTask(Task_LuckyTime, 0)
            return 1
        end
    end
    return 0
end

function ishavefakeCar()
    local lastday = GetGlobalValue(Global_fakeCarday)
    local today = math.floor(LocalSystemTime() / 86400)
    local limit = GetGlobalValue(Global_fakeCarlimit)

    if (lastday ~= today) then
        SetGlobalValue(Global_fakeCarday, today)
        limit = limit + 50
        SetGlobalValue(Global_fakeCarlimit, limit)
    end

    if (limit > 0) then
        return 1
    end
    return 0
end

function pMoney()
    local cashmoney = 5000
    if (GetLevel() >= 81) then
        local quotiety = 2 ^ math.floor((GetLevel() - 61) / 20)
        cashmoney = cashmoney * quotiety
        if (cashmoney > 80000) then
            cashmoney = 80000
        end
    end
    return cashmoney
end

function offlineTotimes()
    local localday = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = math.mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = math.floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (math.mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function payMoneyfree(nums)


    local m = 2000 * GetLevel()
    return m
end

function yes_freefsb()
    CloseDialog()
    if (GetTaskByte(Escrot_Food_Times, 1) == 0) then
        Talk(1, "yes_normalmission", "Ng­¬i ch­a nhËn nhiÖm vô nµo cho ngµy h«m nay, kh«ng cÇn n¹p tµi ®Ó tu luyÖn.")
        return 0
    end
    local addtimes = GetTaskByte(Escrot_Food_Times, 2) + 1
    if (GetTaskByte(1477, 3) < addtimes) then
        Talk(1, "no", "N¹p tµi tu luyÖn tr­íc ®©y cña ng­¬i kh«ng ®ñ. NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>, h·y n¾m b¾t nhÐ!")
        return 0
    end

    local apm = payMoneyfree(addtimes)
    local pm = GetLevel() * 1000 + apm
    if (GetCash() >= pm) then
        SetTaskWord(Escrot_Food_Times, 2, 1)
        local key1 = ok()

        if (key1 >= 1) then
            local strcolor = "Phe TÝm"
            if (key1 == 2) then
                strcolor = "<c=g>Phe Xanh<c>"
            end
            Pay(apm)
            SetTaskByte(Escrot_Food_Times, 2, addtimes)
            Msg2Player("N¹p tµi " .. apm .. " h­ëng tÝch lòy rêi m¹ng h«m nay " .. addtimes .. " lÇn nhËn thªm nhiÖm vô vËn l­¬ng.")
            WriteLog("[VËn L­¬ng] N¹p tµi " .. apm .. " h­ëng thô lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
            Talk(1, "no", "Ng­¬i rêi m¹ng vµ tÝch lòy ­u ®·i lÇn thø <c=g>" .. addtimes .. "<c>, h·y giao l­¬ng ®Õn cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc xe l­¬ng " .. strcolor .. " ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>Ng­¬i chØ cã 30 phót, sau 30 phót xe l­¬ng sÏ biÕn mÊt</c>, mau ®i nhanh vÒ sím!")
        else
            SetTaskByte(Escrot_Food_Times, 3, 0)
        end
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ b¹c. NÕu ng­¬i muèn vËn l­¬ng cÇn cã " .. pm .. " b¹c")
    end
end

function armyresource()
    local tasks1 = {
        { "H­¬ng liÖu", "rs1"; show = 1 },
        { "Gç", "rs2"; show = 0 },
        { "ThiÕt", "rs3"; show = 0 },
        { "Vµng", "rs4"; show = 0 },

    }
    local playername = GetName()
    local hadche = GetTGuardIndexByPlayerName(playername)
    if hadche ~= 0 then
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i ph¶i hé tèng xe l­¬ng kh¸c, lµm xong viÖc h·y quay l¹i.")
        return
    end
    if (HaveNormalItem(3, 1013, 0, 0) == 0) and (HaveNormalItem(3, 1014, 0, 0) == 0) and (HaveNormalItem(3, 1015, 0, 0) == 0) and (HaveNormalItem(3, 1016, 0, 0) == 0) then
        local st = "<c=yel>Hinh H­¬ng Lam<c>"
        for n = 2, 4 do
            st = st .. " hoÆc <c=yel>" .. resource_kind[n][2] .. "<c>"
        end
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã " .. st .. ", kh«ng thÓ vËn chuyÓn Qu©n nhu cho l·nh ®Þa cña ng­¬i!")
        return
    end
    local lvl = GetOwnCityLevel() + 1
    if lvl >= 4 then
        tasks1[4].show = 1
    end
    if lvl >= 3 then
        tasks1[3].show = 1
    end
    if lvl >= 2 then
        tasks1[2].show = 1
    end
    SayTask("Thµnh thÞ cÊp 1 chØ cã thÓ vËn chuyÓn h­¬ng liÖu, thµnh thÞ cÊp 2 míi cã thÓ vËn chuyÓn gç...", tasks1)
end

function mission_resource(n)
    local cantakem = 0
    if HaveNormalItem(3, 1012 + n, 0, 0) > 0 then
        cantakem = 1012 + n
    end
    local TongMoney = GetTongRes(0)
    if (cantakem > 0) and (TongMoney >= 100000) then
        SetTaskByte(Task_junzijingsai, 2, n)
        MsgBox("Ng­¬i chän ¸p t¶i <c=g>" .. resource_kind[n][1] .. "<c>, cÇn cã b¶o vËt <c=yel>" .. resource_kind[n][2] .. "<c>, ®ång thêi tiªu hao 10 v¹n b¹c, ng­¬i cã x¸c nhËn muèn hé tèng xe Qu©n nhu cho l·nh ®Þa kh«ng?", "yes_msres", "no")
    else
        MsgBox("B¹c kh«ng ®ñ hoÆc ng­¬i kh«ng cã b¶o vËt <c=yel>" .. resource_kind[n][2] .. "<c>.", "no")
    end
end

function yes_msres()
    local H, m, s = GetHMS()
    if (H < 18) or (H >= 23) then
        MsgBox("Tõ 18:00-23:00 mçi ngµy sÏ tæ chøc ho¹t ®éng Qu©n nhu, vËn chuyÓn b¶o vËt <c=yel>Hinh H­¬ng Lam, ThÇn Méc Chi, HuyÒn ThiÕt §Ønh, Hoµng Kim Chung<c>, vËt liÖu thµnh thÞ sÏ t¨ng nhanh chãng.", "no")
        return
    end
    local n = GetTaskByte(Task_junzijingsai, 2)
    local TongMoney = GetTongRes(0)
    local cantakem = 0
    if HaveNormalItem(3, 1012 + n, 0, 0) > 0 then
        cantakem = 1012 + n
    end
    if (TongMoney < 100000) or (cantakem == 0) then
        MsgBox("B¹c kh«ng ®ñ hoÆc ng­¬i kh«ng cã b¶o vËt <c=yel>Hinh H­¬ng Lam, ThÇn Méc Chi, HuyÒn ThiÕt §Ønh, Hoµng Kim Chung<c>.", "no")
        return
    end

    okres(n)
end

function okres(n)
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", "RÊt tiÕc, hiÖn Qu©n nhu ch­a ®­îc chÊt lªn xe, l¸t sau h·y quay l¹i nhÐ!")
        return 0
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 15) then
        WriteLog("[VËn L­¬ng][Thi ®ua Qu©n nhu][BÊt th­êng][Kh«ng ph¶i b¶n ®å M¹nh t©n " .. mapid)
        return 0
    end

    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13570)
        return 0
    end

    local num = math.random(1, 3)
    local x2, y2 = COMMON.reNewSetPos(car_maps[num].x, car_maps[num].y, car_maps[num].r)

    local carriageindex = NewSiegeWeapon(15, x2 * 32, y2 * 32, 556)
    if (carriageindex <= 0) then
        carriageindex = NewSiegeWeapon(15, x * 32, y * 32, 556)
        if (carriageindex > 0) then
            WriteLog("[VËn L­¬ng][Thi ®ua Qu©n nhu][BÊt th­êng][LÇn thø 2 thªm xe thµnh c«ng]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
        else
            WriteLog("[VËn L­¬ng][Thi ®ua Qu©n nhu][BÊt th­êng][LÇn thø 2 thªm xe thÊt b¹i]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
            Talk(1, "no", "RÊt tiÕc, hiÖn Qu©n nhu ch­a ®­îc chÊt lªn xe, l¸t sau h·y quay l¹i nhÐ!")
            return 0
        end
    end

    local playername = GetName()
    local carriagelevel = 1
    SendCarriage(carriageindex, playername, carriagelevel, ESCORTFOOD_LASTTIME)

    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\¾ü×ÊÁ¸âÃ³µ.lua")

        SetNpcTask(carriagenpcindex, 0, 0)
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())

        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)
        SetCurCamp(2)
        Msg2Player("Ng­¬i cïng xe l­¬ng Qu©n nhu thuéc phe TÝm")

        TaskNote(300, 0, resource_kind[n][1])
        DelNormalItem(3, 1012 + n, 0, 0)
        WasteTongRes(0, 100000)
        SetTaskByte(Task_junzijingsai, 1, n)
        Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> ®ang gióp quèc gia vËn chuyÓn </bc><bc=blk>" .. resource_kind[n][1] .. " Qu©n nhu</bc><bc=r>, mêi nghÜa sÜ trong n­íc mau ®i tiÕp viÖn</bc>")
        local CityLevel_log = GetOwnCityLevel() + 1
        local st = GetLevel() .. "CÊp dòng sÜ" .. playername .. " NhËn xe l­¬ng, l·nh ®Þa " .. GetTongName() .. " §¼ng cÊp thµnh thÞ " .. CityLevel_log .. " Lo¹i vËt liÖu " .. resource_kind[n][1]
        WriteLog(st)
        WriteLog("[VËn L­¬ng][Thi ®ua Qu©n nhu thµnh c«ng]carriageindex:" .. carriageindex .. "carriagenpcindex:" .. carriagenpcindex .. "GetPlayerID():" .. GetPlayerID())
        Talk(1, "no", "Xe l­¬ng Qu©n nhu cña ng­¬i ®· dõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, h·y ®­a xe l­¬ng tíi giao cho Tæng binh Tr­¬ng QuÕ Ph­¬ng t¹i TuyÖt Long LÜnh, <c=g>ng­¬i chØ cã 30 phót, 30 phót sau xe l­¬ng sÏ tù biÕn mÊt</c>, nhanh ®i råi trë vÒ.")
        return 1
    else
        WriteLog("[VËn L­¬ng][Thi ®ua Qu©n nhu][BÊt th­êng][Thªm thµnh c«ng nh­ng carriagenpcindex<=0]carriageindex:" .. carriageindex)
        Talk(1, "no", "RÊt tiÕc, hiÖn Qu©n nhu ch­a ®­îc chÊt lªn xe, l¸t sau h·y quay l¹i nhÐ!")
    end
end;

function rs1()
    mission_resource(1)
end

function rs2()
    mission_resource(2)
end

function rs3()
    mission_resource(3)
end

function rs4()
    mission_resource(4)
end

function rs5()
    mission_resource(0)
end

function change_item()
    no()
    if (HaveNormalItem(3, 1185, 0, 0) >= 10) then
        MsgBox("Phong L©m: Thu thËp <c=g>10 LÖnh Bµi Qu©n L­¬ng<c> cã thÓ ®Õn ®©y ®æi 1 <c=g>T­íng Qu©n LÖnh<c>, ®ång ý ®æi kh«ng?", "Yes_Item", "no")
    else
        Talk(1, "no", "Phong L©m: Thu thËp <c=g>10 LÖnh Bµi Qu©n L­¬ng<c> cã thÓ ®Õn ®©y ®æi 1 <c=g>T­íng Qu©n LÖnh<c>, mçi ngµy lÇn ®Çu hoµn thµnh vËn l­¬ng nhËn ®­îc LÖnh Bµi Qu©n L­¬ng. ")
    end
end

function Yes_Item()
    no()
    if (HaveNormalItem(3, 1185, 0, 0) < 10) then
        Talk(1, "no", "Xin lçi, trªn ng­êi kh«ng ®ñ 10 LÖnh Bµi Qu©n L­¬ng, kh«ng thÓ ®æi. ")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ chç, h·y s¾p xÕp l¹i. ")
        return
    end
    for i = 1, 10 do
        DelNormalItem(3, 1185, 0, 0)
    end
    AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    Msg2Player("NhËn 1 T­íng Qu©n LÖnh. ")

    local PetTyte = PetGetType()
    if (PetTyte == 78 or PetTyte == 105) then

        local rannum = math.random(1, 100)
        if (rannum <= 65) then
            AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
            Msg2Player("Th©n C«ng B¸o gióp ngµi mang vÒ thªm T­íng Qu©n LÖnh*1")
            WriteLog("[Linh Sñng Thuéc TÝnh][Th©n C«ng B¸o ®æi T­íng Qu©n LÖnh][nhËn ®­îc thªm 1 c¸i ]")
        elseif (rannum <= 95) then
            for i = 1, 2 do
                AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
            end
            Msg2Player("Th©n C«ng B¸o gióp ngµi mang vÒ thªm T­íng Qu©n LÖnh*2")
            WriteLog("[Linh Sñng Thuéc TÝnh][Th©n C«ng B¸o ®æi T­íng Qu©n LÖnh][nhËn ®­îc thªm  2 c¸i ]")
        else
            for i = 1, 5 do
                AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
            end
            Msg2Player("Th©n C«ng B¸o gióp ngµi mang vÒ thªm T­íng Qu©n LÖnh*5")
            WriteLog("[Linh Sñng Thuéc TÝnh][Th©n C«ng B¸o ®æi T­íng Qu©n LÖnh][nhËn ®­îc thªm  5 c¸i ]")
        end
    end

    TopMessage("NhËn 1 T­íng Qu©n LÖnh")
    WriteLog("LÖnh Bµi Qu©n L­¬ng ®æi thµnh c«ng 1 T­íng Qu©n LÖnh")
    MsgBox("§æi thµnh c«ng 1 <c=g>T­íng Qu©n LÖnh<c>, ®æi tiÕp n÷a kh«ng?", "Yes_Item", "no")
end

function COMMON_ActivityOpen0501()
    local YY, MM, DD = GetYMD()
    local hh, mm, ss = GetHMS()
    if (YY == 2014 and MM == 8 and (DD >= 5 and DD <= 10)) then
        if (hh >= 20 and hh < 22) then
            return 1
        end
        return 0
    end
    return 0
end

function Escrot_Food()
    no()
    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13570)
    else
        if (GetLevel() < 110) then
            Talk(1, "no", "VËn l­¬ng rÊt nguy hiÓm, h·y tu luyÖn ®Õn cÊp 110 råi tíi t×m ta.")
        elseif (IsTongMember() == 0) then
            Talk(1, "no", 13573)
        elseif (GetCash() < 300000) then
            Talk(1, "no", "Ng­¬i kh«ng cã ®ñ 30 v¹n b¹c.")
        else
            Escrot_Food_Next()
        end
    end
end

function Escrot_Food_Next()
    local bb = GetTaskByte(Escrot_Food_Times, 1)
    local addtimes = GetTaskByte(Escrot_Food_Times, 2) + 1
    local alltimes = GetTaskByte(1477, 3)

    local pm_free = payMoneyfree(addtimes)
    if (alltimes >= addtimes) or (bb < 6) then
        local task = {
            { "VËn l­¬ng Cao cÊp", "Escrot_Food_Accept"; show = 0 },
            { "N¹p tµi tu luyÖn", "Escrot_Food_yes_freefsb"; show = 0 },
            { "Khao qu©n lÖnh", "Escrot_Food_coin_renwu"; show = 0 },

            { "ThÎ Kim DËt", "Escrot_Food_Task_MonthCard"; show = 0 },

        }
        if (bb == 0) then
            task[1].show = 1
        elseif (bb < 6) then
            task[3].show = 1
            task[4].show = 1
        end
        local retime = alltimes - addtimes + 1
        local str = "Ngµi sö dông <c=g>ThÎ Kim DËt<c> nhËn: <c=g>VËn l­¬ng Cao cÊp<c>. <c=g>ThÎ Kim DËt<c> mang l¹i rÊt nhiÒu ­u ®·i!"

        if (retime > 0) then
            task[2].show = 1
            SayTask("HiÖn t¹i ng­¬i tÝch lòy <c=r>" .. (alltimes - addtimes + 1) .. "<c> lÇn, nhiÒu h¬n sè lÇn nhËn nhiÖm vô miÔn phÝ, nÕu ®­a cho ta " .. pm_free .. " b¹c, cã thÓ nhËn thªm nhiÖm vô, nhÊp vµo N¹p tµi tu luyÖn ®Ó h­ëng ­u ®·i nµy, ®õng quªn kh«ng thÓ thiÕu <c=g>30 v¹n<c> l­îng b¹c." .. str, task)
        else
            SayTask("NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>. C¸ch nµy kh«ng ®ßi hái nhiÒu, chØ thu 1 sè b¹c nhÊt ®Þnh!" .. str, task)
        end
    else
        MsgBox(13577, "no")
    end
end

function Escrot_Food_Accept()
    no()
    MsgBox("ThÊy anh hïng thùc lùc phi phµm, ta yªn t©m giao Xe L­¬ng Cao CÊp cho ng­¬i, vËn l­¬ng thµnh c«ng sÏ nhËn ®­îc ®¹o cô Thøc tØnh to¹ kþ-<c=g>M¶nh Quang Dùc Chi Vò<c> nhí r»ng sè lÇn VËn l­¬ng Cao cÊp vµ sè lÇn VËn l­¬ng th«ng th­êng dïng chung. Ng­¬i cÇn giao cho ta <c=g>30 v¹n b¹c vµ 3 c¸i B¸t Hoang Tinh Hoa<c>, x¸c ®Þnh tiÕn hµnh vËn l­¬ng cao cÊp sao?", "Escort_Food_Accept2", "no")
end
function Escort_Food_Accept2()
    CloseDialog()

    local key1 = 0
    local bb = GetTaskByte(Escrot_Food_Times, 1) + 1
    if (bb == 1) then
        Escort_Food_OK()
        return 0
    end

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("VËn l­¬ng")
    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (i ~= 0) then
        key1 = Escort_Food_OK()
        if (key1 < 1) then
            return 0
        end

        CostIBItem(i)
        SetTaskByte(Escrot_Food_Times, 4, 1)
        Msg2Player("B¹n ®æi 1 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng!")
        WriteLog("[VËn L­¬ng][Tu luyÖn th­êng] 1 c¸i Khao Qu©n LÖnh")
    elseif (GetCoin() >= Cv) then
        key1 = Escort_Food_OK()
        if (key1 < 1) then
            return 0
        end

        CostCoinByIdx(CostId)
        SetTaskByte(Escrot_Food_Times, 4, 1)
        Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
        WriteLog("[VËn L­¬ng][Tu luyÖn th­êng]" .. Cfs .. " Th«ng B¶o")
    else
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
        return 0

    end

end

function Escort_Food_OK()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", 13570)
        return 0
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 15) then
        Talk(1, "no", "Ngµi kh«ng ë gÇn, ta kh«ng thÓ giao xe l­¬ng cho ngµi.")
        CloseDialog()
        return 0
    end

    if (GetCash() < 300000) then
        Talk(1, "no", "ThËt xin lçi, <c=r>b¹c kh«ng ®ñ 30 v¹n<c>, kh«ng thÓ nhËn Xe L­¬ng Cao CÊp!")
        return 0
    end

    if (HaveNormalItem(3, 1229, 0, 0) < 3) then
        Talk(1, "no", "ThËt xin lçi, trªn ng­êi <c=r> kh«ng ®ñ 3 B¸t Hoang Tinh Hoa<c>, kh«ng thÓ nhËn Xe L­¬ng Cao CÊp!")
        return 0
    end

    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13570)
        return 0
    end

    local num = math.random(1, 3)
    local x2, y2 = COMMON.reNewSetPos(car_maps[num].x, car_maps[num].y, car_maps[num].r)

    local camp = 2
    local strcolor = "Phe TÝm"
    local key = 1
    local cartype = 2188
    local playerlevel = GetLevel()
    if (fIsGreen(playerlevel) == 1) then
        cartype = 687
        camp = 7
        strcolor = "<c=g>Phe Xanh<c>"
        key = 2
    end

    local carriageindex = NewSiegeWeapon(15, x2 * 32, y2 * 32, cartype)
    if (carriageindex <= 0) then
        carriageindex = NewSiegeWeapon(15, x * 32, y * 32, cartype)
        if (carriageindex > 0) then
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thµnh c«ng]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
        else
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thÊt b¹i]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
            Talk(1, "no", "HiÖn giê l­¬ng thùc ch­a ®ãng xe xong! L¸t n÷a h·y quay l¹i nhÐ!")
            return 0
        end
    end

    local playername = GetName()
    local carriagelevel = 1
    SendCarriage(carriageindex, playername, carriagelevel, ESCORTFOOD_LASTTIME)

    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\¸ß¼¶Á¸âÃ³µ.lua")
        SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\³µ±£»¤Ê±¼äµ½.lua", 30)
        SetGuardLevel(carriagenpcindex, 2)
        SetNpcLifeMax(carriagenpcindex, (playerlevel * 3500 + 300000))
        SetNpcTask(carriagenpcindex, 0, 0)
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())
        SetNpcTask(carriagenpcindex, 4, 1)
        if (key == 2) then
            SetNpcName(carriagenpcindex, "<c=g>Xe L­¬ng Cao CÊp<c>")
        end

        AddIBBuff(1932, 30)
        NpcAddIBBuff(carriagenpcindex, 1932, 30)
        for i = 1, 3 do
            DelNormalItem(3, 1229, 0, 0)
        end
        Pay(300000)
        SetGlobalValue(Global_Lucky, GetGlobalValue(Global_Lucky) + 1)
        SetGlobalValue(Global_fakeCarlimit, GetGlobalValue(Global_fakeCarlimit) + 10)

        SetNpcCurCamp(carriagenpcindex, camp)
        SetCamp(camp)
        SetCurCamp(camp)

        TaskNote(1947, 1)
        PlayerInOrOut(1, carriagenpcindex)
        local nRandom = math.random(1, 100)
        local rmin = 0
        local idx = 6
        for i = 1, #ESCORTFOOD_list do
            rmin = ESCORTFOOD_list[i].rand + rmin
            if (nRandom <= rmin) then
                idx = i
                break
            end
        end

        if (GetTaskByte(Escrot_Food_Times, 3) == 0) then
            local bd = GetTaskByte(Escrot_Food_Times, 1) + 1
            local randstr = ". LÇn nµy nÕu VËn L­¬ng thµnh c«ng, sÏ nhËn ®­îc thªm " .. ESCORTFOOD_list[idx].name
            Msg2Player("H«m nay lµ lÇn vËn l­¬ng thø" .. bd .. "  vËn chuyÓn xe l­¬ng. Xe l­¬ng ®· biÕn thµnh " .. strcolor .. "<c=r>" .. randstr)
            InfoBox("§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bd .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Xe l­¬ng " .. strcolor .. " cña ng­¬i ®· ngõng ë <c=yel>khu ®Êt trèng phÝa trªn bªn ph¶i</c>, <c=g>ng­¬i chØ cã 30 phót, 30 phót sau xe l­¬ng sÏ biÕn mÊt</c>, nhanh ®i råi trë vÒ" .. randstr)

            if (bd >= 6) then
                SyncBibleState(64, 3, 1)
            else
                SyncBibleState(64, 2, 1)
            end
            SetTaskByte(Escrot_Food_Times, 1, bd)
        end
        SetTaskByte(Escrot_Food_Task, 1, 1)
        SetTaskByte(Escort_Food_Record, 1, (idx + 10))
        SetTask(Escort_Food_Fake, 0)
        local H, M, S = GetHMS()
        SetTaskByte(Escrot_Food_Task, 3, H)
        SetTaskByte(Escrot_Food_Task, 4, M)
        SetTaskByte(Escort_Food_Record, 2, 0)
        WriteLog("[VËn L­¬ng][Xe L­¬ng Cao CÊp thµnh c«ng][Rót ®­îc ®¹o cô]:" .. ESCORTFOOD_list[idx].name .. "carriagenpcindex:" .. carriagenpcindex .. "GetPlayerID():" .. GetPlayerID() .. "Tªn ng­êi ch¬i:" .. playername .. "Phe: " .. camp)
        return key
    else
        WriteLog("[VËn L­¬ng][Xe L­¬ng Cao CÊp bÊt th­êng][Thªm thµnh c«ng nh­ng carriagenpcindex<=0]carriageindex:" .. carriageindex .. "Tªn ng­êi ch¬i:" .. playername)
        Talk(1, "no", 13570)
        return 0
    end
end
function Escrot_Food_yes_freefsb()
    CloseDialog()
    if (GetTaskByte(Escrot_Food_Times, 1) == 0) then
        Talk(1, "Escrot_Food_Accept", "Ng­¬i ch­a nhËn nhiÖm vô nµo cho ngµy h«m nay, kh«ng cÇn n¹p tµi ®Ó tu luyÖn.")
        return 0
    end
    local addtimes = GetTaskByte(Escrot_Food_Times, 2) + 1
    if (GetTaskByte(1477, 3) < addtimes) then
        Talk(1, "no", "N¹p tµi tu luyÖn tr­íc ®©y cña ng­¬i kh«ng ®ñ. NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>, h·y n¾m b¾t nhÐ!")
        return 0
    end

    local apm = payMoneyfree(addtimes)
    local pm = 300000 + apm
    if (GetCash() >= pm) then
        if (GetTaskByte(Escrot_Food_Times, 1) == 0) then
            Escort_Food_Accept2()
            return 1
        end

        SetTaskWord(Escrot_Food_Times, 2, 1)
        local key1 = Escort_Food_OK()

        if (key1 >= 1) then
            Pay(apm)
            SetTaskByte(Escrot_Food_Times, 2, addtimes)
            Msg2Player("N¹p tµi " .. apm .. " h­ëng ­u ®·i tÝch lòy rêi m¹ng " .. addtimes .. " lÇn nhËn thªm nhiÖm vô vËn l­¬ng.")
            WriteLog("[VËn L­¬ng] n¹p tµi " .. apm .. " h­ëng thô lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
        else
            SetTaskByte(Escrot_Food_Times, 3, 0)
        end
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ b¹c. NÕu ng­¬i muèn vËn l­¬ng cÇn cã " .. pm .. " b¹c")
    end
end
function Escrot_Food_coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "Escort_Food_Accept2"; show = 1 },
        { "Tu luyÖn nh©n ®«i", "Escort_Food_Accept3"; show = 1 },
    }

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("VËn l­¬ng")
    local Cname, Cv, Cfs = 1, SalePriceCount, SalePriceName

    local strValue = "Quan phñ ban lÖnh:mçi ng­êi chØ cã thÓ vËn l­¬ng 1 lÇn trong ngµy. Nh­ng nÕu cã <c=g>Khao qu©n lÖnh</c> th× vÉn ®­îc rêi thµnh. NÕu ng­¬i cã <c=yel>1 Khao qu©n lÖnh</c> hoÆc tÆng ta <c=g>" .. PriceName .. "</c> Th«ng B¶o ta cã thÓ cho ng­¬i tiÕp tôc vËn l­¬ng. NÕu muèn nhËn gÊp ®«i tu vi lÞch luyÖn, chØ cÇn ®­a <c=yel>2 Khao Qu©n LÖnh<c> hoÆc <c=yel>" .. (PriceName * 2) .. "<c> Th«ng B¶o. Sao h¶?"
    local n1, n2, strAdd = ThemeDayForHuman.PubFuncShowText("VËn l­¬ng")
    if (n1 > 0 and n2 > 0) then
        strValue = strValue .. strAdd
    elseif (n1 > 0 and n2 <= 0) then
        strValue = strValue .. strShow
    end
    SayTask(strValue, task)
end
function Escort_Food_Accept3()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByDouble("VËn l­¬ng")

    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    local nums = HaveNormalItem(8, 268, 2, 0)
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (nums > 0) and (i == 0) then
        nums = 0
    end
    local mycoin = nums * Cv + GetCoin()
    local key1 = 0

    if (i ~= 0) then
        if (nums >= 2) then
            key1 = Escort_Food_OK()
            if (key1 < 1) then
                return 0
            end

            local nTemp = CostIBItem(i)
            if (CostIBItem(FindAValidIBItem(8, 268, 2, 0)) == 0) then
                delCar()
                if (nTemp == 1) then
                    AddNormalItemBind(8, 268, 2, 0, 0, 0, 1)
                end

                Talk(1, "no", "KhÊu trõ Khao Qu©n LÖnh thÊt b¹i, xe l­¬ng bÞ thu håi")
                WriteLog("[VËn L­¬ng][Tu luyÖn nh©n ®«i][KhÊu trõ thÊt b¹i][2 Khao Qu©n LÖnh]1=0;2=" .. nTemp)
            else
                SetTaskByte(Escrot_Food_Times, 4, 2)
                Msg2Player("B¹n ®æi 2 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng")
                WriteLog("[VËn L­¬ng][Tu luyÖn nh©n ®«i]2 Khao Qu©n LÖnh")
            end
        elseif (nums == 1 and GetCoin() >= PriceCount) then
            key1 = Escort_Food_OK()
            if (key1 < 1) then
                return 0
            end

            if (CostIBItem(i) == 0) then
                delCar()
                Talk(1, "no", "KhÊu trõ Khao Qu©n LÖnh thÊt b¹i, xe l­¬ng bÞ thu håi")
                WriteLog("[VËn L­¬ng][Tu luyÖn nh©n ®«i][KhÊu trõ thÊt b¹i][Khao Qu©n LÖnh]")
            else
                CostCoinByIdx(49)
                SetTaskByte(Escrot_Food_Times, 4, 2)
                Msg2Player("B¹n dïng " .. PriceName .. " Th«ng B¶o vµ 1 Khao Qu©n lÖnh ®æi lÊy 1 lÇn vËn l­¬ng!")
                WriteLog("[VËn L­¬ng][Tu luyÖn nh©n ®«i]" .. PriceName .. " Th«ng B¶o vµ 1 Khao Qu©n LÖnh")
            end
        else
            Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
            return 0
        end
    else
        if (GetCoin() >= (Cv * 2)) then
            key1 = Escort_Food_OK()
            if (key1 < 1) then
                return 0
            end
            CostCoinByIdx(CostId)
            CostCoinByIdx(CostId)
            SetTaskByte(Escrot_Food_Times, 4, 2)
            Msg2Player("B¹n dïng " .. (Cfs * 2) .. " Th«ng B¶o ®æi lÊy 1 lÇn VËn l­¬ng")
            WriteLog("[VËn L­¬ng][Tu luyÖn nh©n ®«i]" .. (Cfs * 2) .. " Th«ng B¶o")
        else
            Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ Th«ng B¶o! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhÐ!")
            return 0
        end
    end

end
function Escrot_Food_Task_MonthCard()
    local task = {
        { "Tu luyÖn th­êng", "Escrot_Food_Single_Cost"; show = 1 },
        { "Tu luyÖn nh©n ®«i", "Escrot_Food_Double_Cost"; show = 1 },
    }
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local str = "<c=g>NhiÖm vô chñ ®Ò Ngµy<c> bao gåm nhiÖm vô Th¸m Qu©n, NhiÖm vô Hµng phôc, DÑp lo¹n V¹n Tiªn TrËn, Thu thËp §¹o cô, Siªu §é, NhiÖm vô Thu ThËp, VËn L­¬ng, Hoa ThÇn BÝ, Thiªn §×nh ThÇn Thô, NhiÖm vô TruyÒn Tin, VËn chuyÓn VËt liÖu, LuyÖn §an, ThÝ luyÖn ThÊt Qu¸i, B¨ng Ho¶ Long Ch©u."
    SayTask("Phong L©m: " .. str .. "NÕu ng­¬i cã <c=g>" .. Cfs .. "Th«ng B¶o (ThÎ Kim DËt)<c>, ta sÏ ph¸ lÖ cho ng­¬i vËn l­¬ng thªm lÇn n÷a. NÕu ng­¬i muèn ®­îc nh©n ®«i kinh nghiÖm tu luyÖn, chØ cÇn giao nép <c=g>" .. (Cfs * 2) .. "Th«ng B¶o (ThÎ Kim DËt)<c>. Sao h¶?", task)

end

function Escrot_Food_Single_Cost()
    CloseDialog()
    local key1 = 0
    local bb = GetTaskByte(Escrot_Food_Times, 1) + 1
    if (bb == 1) then
        Escort_Food_OK()
        return 0
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cv) then
        key1 = Escort_Food_OK()
        if (key1 < 1) then
            return 0
        end

        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cv) == 0) then
            delCar()
            Talk(1, "no", "KhÊu trõ ®iÓm ThÎ Kim DËt thÊt b¹i, xe l­¬ng bÞ thu håi")
            WriteLog("[VËn L­¬ng][KhÊu trõ thÊt b¹i][ThÎ Kim DËt][Tu luyÖn th­êng]" .. Cfs .. " Th«ng B¶o")
        else
            SetTaskByte(Escrot_Food_Times, 4, 1)
            Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o(ThÎ Kim DËt), nhËn ®­îc c¬ héi vËn l­¬ng!!")
            WriteLog("[VËn L­¬ng][ThÎ Kim DËt][Tu luyÖn th­êng]" .. Cfs .. " Th«ng B¶o")
        end
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end
end

function Escrot_Food_Double_Cost()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local key1 = 0
    if (GetIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3]) >= Cv * 2) then
        key1 = Escort_Food_OK()
        if (key1 < 1) then
            return 0
        end

        if (CostIBItemPoint(Card_Item[1][1], Card_Item[1][2], Card_Item[1][3], Cv * 2) == 0) then
            delCar()
            Talk(1, "no", "KhÊu trõ ®iÓm ThÎ Kim DËt thÊt b¹i, xe l­¬ng bÞ thu håi")
            WriteLog("[VËn L­¬ng][KhÊu trõ thÊt b¹i][ThÎ Kim DËt][Tu luyÖn nh©n ®«i]" .. (Cfs * 2) .. " Th«ng B¶o")
        else
            SetTaskByte(Escrot_Food_Times, 4, 2)
            Msg2Player("B¹n dïng " .. (Cfs * 2) .. " Th«ng B¶o(ThÎ Kim DËt), nhËn ®­îc c¬ héi vËn l­¬ng!!")
            WriteLog("[VËn L­¬ng][ThÎ Kim DËt][Tu luyÖn nh©n ®«i]" .. (Cfs * 2) .. " Th«ng B¶o")
        end
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end
end

function delCar()
    local guardindex = GetTGuardIndexByPlayerName(GetName())
    if (guardindex > 0) then
        local bounty, a, b, c, carriageindex = GetTGuardInfo(guardindex)
        WriteLog("[VËn L­¬ng][KhÊu trõ thÊt b¹i][Xo¸ xe]" .. DeleteSiegeWeapon(carriageindex))
    end
end

function GetFakeCar()
    no()
    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13580)
        return
    else
        local guardindex = COMMON.reSetGuardIndex()

        if (guardindex > 0) then
            if (GetTaskByte(Escrot_Food_Task, 1) == 1) then
                Talk(1, "no", 13581)
            elseif (GetTaskByte(1238, 1) == 1 and HaveIBBuff(463) > 0) then
                Talk(1, "no", 14400)
            elseif (GetTaskByte(Task_junzijingsai, 1) > 0) then
                Talk(1, "no", "Ng­¬i ®ang trong thi Qu©n nhu, rÊt nguy hiÓm, ta kh«ng thÓ giao xe l­¬ng cho ng­¬i.")
            else
                Talk(1, "no", 13582)
            end
        elseif (GetTask(60) ~= 0) then
            Talk(1, "no", 13576)
        elseif (GetCamp() == 0) then
            Talk(1, "no", 13572)
        elseif (GetPK() >= 88) then
            Talk(1, "no", "Tr¹ng th¸i tªn ®á kh«ng thÓ ¸p tiªu qu©n l­¬ng. ")
        elseif (ishavefakeCar() == 0) then
            Talk(1, "no", "Xe l­¬ng gi¶ lµ ®Ó ®¸nh lõa bän c­êng ®¹o c­íp l­¬ng. 1 xe thËt chØ ®­îc tèi tèi ®a 10 xe gi¶ hé tèng. Cã ®iÒu hiÖn t¹i gç ®ang rÊt hiÕm, nªn ta kh«ng cã nhiÒu xe gi¶ ®Ó tÆng cho ng­¬i!")
        elseif (GetLevel() < 50) then
            Talk(1, "no", "VËn l­¬ng ®Õn TuyÖt Long LÜnh v« cïng khã kh¨n, nÕu ch­a ®ñ ®¼ng cÊp, sÏ rÊt nguy hiÓm. §îi ng­¬i ®¹t cÊp 50 råi h·y ®Õn ®©y!")
        else
            SetTaskByte(Escrot_Food_Task, 1, 0)
            SetTaskByte(Escort_Food_Fake, 1, 0)
            local task = {
                { "Xe l­¬ng th­êng", "renwu3"; show = 1 },
                { "Xe L­¬ng Cao CÊp", "Escrot_Food_Fake_Car"; show = 1 },
            }
            SayTask("§­êng tõ ®©y tíi TuyÖt Long LÜnh còng kh«ng yªn æn, th­êng xuyªn cã giÆc c­íp qua l¹i, ng­¬i cã thÓ dïng xe l­¬ng gi¶ ®Ó ®¸nh l¹c h­íng chóng, mêi chän lo¹i <c=r>xe l­¬ng nguþ trang<c>: ", task)
        end
    end
end

function Escrot_Food_Fake_Car()
    if (GetLevel() < 110) then
        Talk(1, "no", "VËn L­¬ng ph¶i ®i qua hiÓm ®Þa TuyÖt Long LÜnh, nÕu cÊp ®é kh«ng ®ñ sÏ rÊt nguy hiÓm, h·y tu luyÖn tíi 110 råi trë l¹i t×m ta!")
    else
        local cashmoney = 100000
        if (GetCash() < cashmoney) then
            Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
            return 0
        end

        MsgBox("Cã mét chuyÕn xe l­¬ng cÇn chuyÓn ®Õn <c=g>TuyÖt Long LÜnh cho Tæng binh Tr­¬ng QuÕ Ph­¬ng<c>, trªn ®­êng ®¹o tÆc v« sè, v× vËy nªn lµm xe gi¶ ®Ó ®¸nh l¹c h­íng chóng. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=g>" .. cashmoney .. "<c> l­îng! Ng­¬i muèn chÕ t¹o Xe l­¬ng gi¶ kh«ng? Xe gi¶ sÏ kh«ng ¶nh h­ëng ®Õn sè lÇn nhËn nhiÖm vô ChuyÓn l­¬ng", "Escrot_Food_Fake_Car_Yes", "no")
    end
end;

function Escrot_Food_Fake_Car_Yes()
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", 13580)
        return 0
    end

    local limit = GetGlobalValue(Global_fakeCarlimit) - 1
    if (limit < 0) then
        Talk(1, "no", "§· l©u råi kh«ng cã ai ®Õn gióp ta chuyÓn l­¬ng, nªn ch¾c còng kh«ng cÇn giao xe gi¶ cho ng­¬i ®©u!")
        return 0
    end

    local cashmoney = 100000
    if (GetCash() < cashmoney) then
        Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
        return 0
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 15) then
        WriteLog("[VËn L­¬ng][BÊt th­êng][Kh«ng ph¶i b¶n ®å M¹nh t©n " .. mapid)
        return 0
    end

    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13580)
        return
    end

    local num = math.random(1, 3)
    local x2, y2 = COMMON.reNewSetPos(car_maps[num].x, car_maps[num].y, car_maps[num].r)

    local carriageindex = NewSiegeWeapon(15, x2 * 32, y2 * 32, 2188)
    if (carriageindex <= 0) then
        carriageindex = NewSiegeWeapon(15, x * 32, y * 32, 2188)
        if (carriageindex > 0) then
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thµnh c«ng]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
        else
            WriteLog("[VËn L­¬ng][BÊt th­êng][LÇn thø 2 thªm xe thÊt b¹i]" .. x .. "/" .. y .. "*" .. x2 .. "/" .. y2)
            Talk(1, "no", "Xe l­¬ng gi¶ lµ ®Ó ®¸nh lõa bän c­êng ®¹o c­íp l­¬ng. 1 xe thËt chØ ®­îc tèi tèi ®a 10 xe gi¶ hé tèng. Cã ®iÒu hiÖn t¹i gç ®ang rÊt hiÕm, nªn ta kh«ng cã nhiÒu xe gi¶ ®Ó tÆng cho ng­¬i!")
            return 0
        end
    end

    local playername = GetName()
    local carriagelevel = 1
    SendCarriage(carriageindex, playername, carriagelevel, ESCORTFOOD_LASTTIME)

    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\¸ß¼¶Î±×°µÄÁ¸âÃ³µ.lua")
        SetNpcTask(carriagenpcindex, 1, GetPlayerID())
        SetNpcTask(carriagenpcindex, 2, LocalSystemTime())

        Pay(cashmoney, 1)

        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)
        SetCurCamp(2)
        TaskNote(1947, 4)
        Msg2Player("Ng­¬i vµ xe l­¬ng gi¶ thuéc phe PK tÝm. CÇn b¶o vÖ xe l­¬ng tíi TuyÖt Long LÜnh giao cho Tæng binh Tr­¬ng QuÕ Ph­¬ng, nÕu trong 30 phót hoµn thµnh ta sÏ hoµn tr¶ l¹i phÝ chÕ t¹o " .. cashmoney .. " b¹c cho ng­¬i.")

        SetTaskByte(Escort_Food_Fake, 1, 2)
        SetTaskByte(Escrot_Food_Task, 1, 1)
        local H, M, S = GetHMS()
        SetTaskByte(Escrot_Food_Task, 3, H)
        SetTaskByte(Escrot_Food_Task, 4, M)
        local NowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        SetTaskByte(Escort_Food_CarTime, 3, NowTime)
        SetGlobalValue(Global_fakeCarlimit, limit)
        PlayerInOrOut(1, carriagenpcindex)
        WriteLog("[VËn L­¬ng][Nguþ trang Xe L­¬ng Cao CÊp thµnh c«ng]carriageindex:" .. carriageindex .. "carriagenpcindex:" .. carriagenpcindex .. "GetPlayerID():" .. GetPlayerID() .. "Tªn ng­êi ch¬i:" .. playername)
        MsgBox("H·y chë xe l­¬ng cao cÊp tíi <c=g>TuyÖt Long LÜnh<c> giao cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng<c>, nÕu nh­ an toµn chë ®Õn, ta sÏ ®em phÝ chÕ t¹o <c=g>" .. cashmoney .. "<c> b¹c tr¶ l¹i cho ng­¬i\nChó ý ph¶i chuyÓn ®Õn trong 30 phót, nÕu kh«ng xe l­¬ng sÏ biÕn mÊt", "no")
    else
        WriteLog("[VËn L­¬ng][BÊt th­êng][Thªm thµnh c«ng nh­ng carriagenpcindex<=0]carriageindex:" .. carriageindex .. "Tªn ng­êi ch¬i:" .. playername)
        Talk(1, "no", 13580)
    end
end;

function NewServerMonkeyActivity()
    if (NewServerEx.g_ServerName ~= GetGameServerName()) then
        return
    end
    if (GetLevel() < 45) then
        return
    end
    if (NewServerEx.Pub_IsTongMonkeyTime() > 0) then
        SetTaskBit(2097, 13, 1)
        WriteLog("[Ho¹t ®éng m¸y chñ míi][Quèc VËn Th¹ch HÇu][hoµn thµnh nhiÖm vô VËn L­¬ng]")
    end
end

