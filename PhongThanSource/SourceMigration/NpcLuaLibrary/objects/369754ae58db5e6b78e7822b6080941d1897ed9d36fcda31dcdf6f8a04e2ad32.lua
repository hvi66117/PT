Include("\\script\\gvn\\lib.lua");
--description:ÎŞ÷±×Ó
--author: yaoxin
--date:2009/1/12

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-17
Task_Process = 1345      --1byte: 1:ÒÑÓÚĞŞĞĞÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑıµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø
--ÎåÉ«»ê
Task_colorrenwu = 1355 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó 2-6(×½µ½¼¸Ö»Ê¯»ê) 4byte Ö¸¶¨¹ÖÎï
Task_colortimes = 1356 --ÎåÉ«»êÍê³ÉµÄ´ÎÊı

fivecolor_UPtimes = 5 --((Ãâ·Ñ+ÊÕ·Ñ))
fivecolor_item = {--µÈ¼¶ Ãû³Æ, ĞòºÅ, Íê³É´ÎÊı, ¾­Ñé1µµ ,¾­Ñé2µµ, ¾­Ñé3µµ
    [1] = { 36, "Phong Yªu", 1, 0, 6000, 6500, 7000 },
    [2] = { 41, "Sãi", 2, 40, 7000, 7500, 8000 },
    [3] = { 46, "Phong thó s¬n hån", 3, 100, 8000, 8600, 9200 },
    [4] = { 81, "HuyÕt Yªu", 4, 300, 9200, 10600, 12000 },
}

--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/30 begin
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÁìÃü¹éÕæ µÚÒ»²½
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 3) then
                state = 3
                subState = 0
            end
        else
            if (process == 3) then
                state = 3
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/30 end 

------Add by liuzhiqiang at 2009/8/14---------ÒåÆø
Task_Yiqi = 1532

function main()
    local tasks = {
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 },
        { "Ngò S¾c Hån", "fivecolor"; show = 0 },
        { "§· t¹o Ngò S¾c Hån", "complete_fivecolor"; show = 0 },
        { "Bá Ngò S¾c Hån", "cancel_renwu31"; show = 0 },
    }

    local credit = GetJusticEvilCredit()
    if (GetTaskByte(Task_Process, 1) == 3 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    if (GetPlayerExtLevel() >= 31) and (credit > 0) then
        local state = GetTaskByte(Task_colorrenwu, 3)
        if (state == 0) then
            tasks[2].show = 1
        elseif (state >= 2) then
            tasks[3].show = 1
        else
            tasks[4].show = 1
        end
    end

    SayTask("Thiªn ®Şa v« ­¬ng, nh©n trô hÖ chi, ®¹i ®¹o v« ­¬ng, nh©n hµ sö chi?", tasks)
end;

function listenTask()
    CloseDialog()
    if (GetTaskByte(Task_Process, 1) == 3 and HaveIBBuff(548) > 0) then
        Talk(1, "no", "Ng­¬i t¹i nh©n gian ®· c«ng thµnh danh to¹i, hµ cí g× l¹i ®Õn n¬i nµy? Ta kh«ng cßn g× ®Ó hái n÷a! Giê ng­¬i h·y ®i gÆp <c=g>Nam Minh Tö<c> ®i!")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 7, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        TopMessage("Nghe V« ¦¬ng Tö gi¶ng ph¸p")
        BeginMotion(Task_Process, 0, 30, "\\script\\motion\\½²·¨½ø¶ÈÏìÓ¦.lua", nInterrupt)
    else
        Talk(1, "no", "Thêi gian ®· hÕt. TiÕc qu¸, ng­¬i thÊt b¹i råi! VÒ gÆp Tu Hµnh S­ ®i, cã thÓ vÉn cßn c¬ héi!")
    end
end

function no()
    CloseDialog()
end;

-------------------------------ÎåÉ«»ê
function fivecolor()
    local lastday = GetTaskByte(Task_colorrenwu, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local temp = GetTaskByte(Task_colorrenwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)
    local pm = paymoney()

    ------------------Add by liuzhiqiang at 2009/8/17 begin-------------------------Ö÷ÏßÈÎÎñ°ïÖú»ı·Ö
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        pm = pm * 0.9
    end
    ------------------Add by liuzhiqiang at 2009/8/17 end  -------------------------Ö÷ÏßÈÎÎñ°ïÖú»ı·Ö

    if (lastday ~= today) then
        if (GetCash() >= pm) and (HaveNormalItem(3, 248, 0, 0) >= 1) then
            MsgBox(" B¾t hung thó trªn BÊt Chu S¬n cÇn dïng <c=yel>Ngò S¾c Kú<c>, chÕ luyÖn 1 bé S¾c Kú cÇn dïng 1 <c=g>M¶nh lôc thñy tinh<c> vµ " .. lastMoney .. ".", "yiqiBuff_1", "no")
        else
            Talk(1, "no", " B¾t hung thó trªn BÊt Chu S¬n cÇn dïng <c=yel>Ngò S¾c Kú<c>, chÕ luyÖn 1 bé S¾c Kú cÇn dïng 1 <c=g>M¶nh lôc thñy tinh<c> vµ " .. lastMoney .. " TiÒn ®ång,chuÈn bŞ ®Çy ®ñ råi ®Õn!")
        end
    elseif (times < fivecolor_UPtimes or alltimes >= addtimes) then
        if (GetCash() >= pm) and (HaveNormalItem(3, 248, 0, 0) >= 1) then
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹pTµiTuLuyÖn", "yiqiBuff_3"; show = 0 },
                { "DiÖm Quang Phæ", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end

            if (times < fivecolor_UPtimes) then
                task[2].show = 1
            end
            SayTask(" Ng­¬i hiÖn ®· tİch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. " b¹c, cã thÓ nhËn thªm nhiÖm vô kh«ng tİnh vµo sè vßng nhiÖm vô thu phİ. NhÊp “N¹p tµi tu luyÖn“ ®Ó h­ëng ­u ®·i nµy! §­¬ng nhiªn ®Ó chÕ Ngò S¾c Kú " .. lastMoney .. " b¹c vµ <c=g>m¶nh Lôc Thñy tinh<c> lµ kh«ng thÓ thiÕu ®­îc!", task)
        else
            Talk(1, "no", "ChÕ luyÖn <c=yel>Ngò S¾c Kú<c> cÇn sö dông <c=g>M¶nh Lôc Thuy Tinh<c> 1 m¶nh cïng víi" .. lastMoney .. " l­îng, ng­¬i h·y chuÈn bŞ ®Çy ®ñ h·y ®Õn!")
        end
    else
        Talk(1, "no", " Dï cho lµ bËc thÇy tinh luyÖn s­ th× mét ngµy chØ cã thÓ tinh luyÖn cho ng­¬i" .. fivecolor_UPtimes .. " lÇn <c=yel>Ngò S¾c Kú<c>, h«m sau quay l¹i nhĞ!")
    end
end

function coin_renwu()
    local pm = paymoney()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(110)
    if (HaveNormalItem(8, 568, 2, 0) >= 1) then
        MsgBox("ChÕ luyÖn <c=yel>Ngò s¾c kú<c> lÇn n÷a, ngoµi <c=g>M¶nh Lôc Thñy Tinh<c> ra cßn cÇn ®Õn <c=yel>DiÖm Quang Phæ<c> vµ" .. pm .. ".", "yiqiBuff_2", "no")
    elseif (GetCoin() >= Cv) then
        MsgBox(" TiÕp tôc chÕ luyÖn <c=yel>Ngò S¾c Kú<c>, ngoµi <c=g>m¶nh Lôc Thñy tinh<c> vµ " .. pm .. " b¹c ra, cßn cÇn <c=yel>DiÖm Quang Phæ<c>, ®­¬ng nhiªn ng­¬i cã thÓ sö dông " .. Cfs .. " TiÒn ®ång thay thÕ.", "yiqiBuff_2", "no")
    else
        Talk(1, "no", "ChÕ luyÖn <c=yel>Ngò s¾c kú<c> lÇn n÷a, cßn cÇn ®Õn <c=yel>DiÖm Quang Phæ<c> hoÆc" .. Cfs .. " TiÒn ®ång, ng­¬i cã thÓ t×m vÒ cho ta chø?")
    end
end

----------------------------------Add by liuzhiqiang at 2009/8/14 begin ----------------------------ÒåÆøÖµ½»»»
function yiqiBuff_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_1", "five_yes")
    else
        five_yes()
    end
end

function costYiqi_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        five_yes()
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm Nh©n NghÜa.")
    end
end

function yiqiBuff_2()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_2", "five_coin_yes")
    else
        five_coin_yes()
    end
end

function costYiqi_2()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        five_coin_yes()
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm Nh©n NghÜa.")
    end
end

function yiqiBuff_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb()
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm Nh©n NghÜa.")
    end
end
----------------------------------Add by liuzhiqiang at 2009/8/14 end ------------------------------ÒåÆøÖµ½»»»

function five_yes()
    local pm = paymoney()

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (GetCash() >= pm) and (HaveNormalItem(3, 248, 0, 0) >= 1) then
        if (IsHaveSpaceForTreasure(5) == 0) then
            Talk(1, "no", "<c=yel>Ngò S¾c Kú<c> tæng céng cã 5 m¶nh, <c=r>h·y s¾p xÕp 5 « trèng trong hµnh trang!")
            return 0
        end

        local lastday = GetTaskByte(Task_colorrenwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local temp = GetTaskByte(Task_colorrenwu, 2) + 1
        local times, addtimes = todayfreetimes(temp)

        if (lastday ~= today) then
            times = 1
            SetTask(Task_colorrenwu, today)
            offlineTotimes()
            SetTaskByte(Task_colorrenwu, 2, times)
        else
            SetTaskByte(Task_colorrenwu, 2, temp)
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = paymoney() - pm
            WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = paymoney() - pm
            WriteLog(GetName() .. "Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)
        SetTaskByte(Task_colorrenwu, 3, 1)--½ÓÈÎÎñ
        SetTaskByte(Task_colorrenwu, 4, 0)

        DelNormalItem(3, 248, 0, 0)
        for i = 1, 5 do
            AddNormalItem(6, 1, 464 + i, 0, 0, 0)
        end
        RemoveIBBuff(569)
        AddIBBuff(569)

        local key = five_set(times) --Ö¸¶¨¹ÖÎï
        Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. times .. "LÇn nhËn nhiÖm vô Ngò S¾c Hån!")
        TaskNote(99, 0, fivecolor_item[key][2])

        if (times < fivecolor_UPtimes) then
            SyncBibleState(99, 2, 0)
        else
            SyncBibleState(99, 3, 0)
        end ;
        SyncBibleState(100, 0, 1)
        Talk(1, "no", "§i thu phôc <c=g>" .. fivecolor_item[key][2] .. "<c>, dÉn dô hung thó tham ¨n Th¹ch hån ra, sau ®ã dïng <c=yel>Ngò S¾c Kú<c> t­¬ng øng b¾t chóng! Ta sÏ cã thï lao xøng ®¸ng cho ng­¬i!")
        return 1
    else
        Talk(1, "no", " B¾t hung thó trªn BÊt Chu S¬n cÇn dïng <c=yel>Ngò S¾c Kú<c>, chÕ luyÖn 1 bé S¾c Kú cÇn dïng 1 M¶nh lôc thñy tinh vµ " .. pm .. " TiÒn ®ång,chuÈn bŞ ®Çy ®ñ råi ®Õn!")
    end
    return 0
end

function five_coin_yes()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(110)
    local i = FindAValidIBItem(8, 568, 2, 0)
    if (i ~= 0) then
        if (five_yes() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Ng­¬i mang 1 DiÖm Quang Phæ giao cho V« ¦¬ng Tö, l·nh nhËn nhiÖm vô")
    elseif (GetCoin() >= Cv) then
        if (five_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(110)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. " TiÒn ®ång cho V« ¦¬ng Tö, l·nh nhËn nhiÖm vô")
    else
        Talk(1, "no", "ChÕ luyÖn <c=yel>Ngò s¾c kú<c> lÇn n÷a, cßn cÇn ®Õn <c=yel>DiÖm Quang Phæ<c>, ng­¬i chuÈn bŞ ®ñ h·y ®Õn.")
    end
end

function five_set(ntimes)
    local plvl = GetPlayerExtLevel()
    local key = 1

    for i = 1, 4 do
        if (GetTask(Task_colortimes) >= fivecolor_item[i][4]) then
            if (plvl < fivecolor_item[i][1]) then
                key = i
                break
            end
        else
            key = i - 1
            break
        end
    end
    if (key < 1) then
        key = 1
    elseif (key >= 5) then
        key = 4
    end

    local temp = fivecolor_item[key]

    SetTaskByte(Task_colorrenwu, 4, temp[3])--Ö¸¶¨¹ÖÎï
    return key
end

function paymoney()
    local money = 500000
    local plvl = GetPlayerExtLevel()
    if (plvl >= 36) then
        money = money + floor((plvl - 31) / 5) * 500000
    end
    if (money > 250 * 10000) then
        money = 2500000
    end
    return money
end

function complete_fivecolor()
    if (HaveIBBuff(569) >= 1) and (GetTaskByte(Task_colorrenwu, 3) < 6) then
        local nums = 0
        for i = 224, 228 do
            if (HaveEventItem(i) >= 1) then
                nums = nums + 1
            end
        end
        MsgBox("Ng­¬i ®· thu thËp <c=g>" .. nums .. "<c> Th¹ch Hån, Hµo quang ngò s¾c vÉn cßn, ng­¬i quyÕt ®Şnh kh«ng thu thËp n÷a muèn giao cho ta? Ng­¬i chØ cã thÓ thu thËp nhiÒu nhÊt <c=yel>5 qu¶<c>", "complete_fivecolor_yes", "no")
    else
        complete_fivecolor_yes()
    end
end

function complete_fivecolor_yes()
    CloseDialog()
    if (GetTaskByte(Task_colorrenwu, 3) >= 2) then
        local nums = 0
        for i = 224, 228 do
            if (HaveEventItem(i) >= 1) then
                nums = nums + 1
            end
        end

        local key = 5
        if (nums >= 5) then
            key = 7
        elseif (nums == 4) then
            key = 6
        end

        local temp = fivecolor_item[GetTaskByte(Task_colorrenwu, 4)][key]
        SetTaskByte(Task_colorrenwu, 3, 0)
        SetTaskByte(Task_colorrenwu, 4, 0)
        RemoveIBBuff(569)
        for i = 1, 5 do
            ClearItem(6, 1, 464 + i, 0)
            ClearItem(4, 223 + i, 1, 1)
        end
        TaskNote(99, -1)
        TaskNote(100, -1)

        local nFactExp = temp * GetPlayerExtLevel()
        nFactExp = AddOwnExtendExp(nFactExp)--¾­Ñé
        if (random(5) == 3) then
            local donetime = GetTask(Task_colortimes) + 1
            local needmoretime = 0
            local lv = 36
            if (donetime < 40) then
                needmoretime = 40 - donetime
            elseif (donetime < 100) then
                needmoretime = 100 - donetime
                lv = 41
            elseif (donetime < 300) then
                needmoretime = 300 - donetime
                lv = 46
            end
            if (needmoretime ~= 0) then
                Talk(1, "no", "Ng­¬i ®· thu thËp <c=g>" .. nums .. "<c> Th¹ch Hån, ta th­ëng cho ng­¬i tu hµnh " .. nFactExp .. ".\n\tNÕu ng­¬i tiÕp tôc hoµn thµnh <c=r>" .. needmoretime .. "<c> lÇn nhiÖm vô, vµ ®¼ng cÊp ®¹t ®Õn <c=g>" .. lv .. "<c> cã thÓ tham gia kh¶o nghiÖm kÕ tiÕp, mçi lÇn phÇn th­ëng tu hµnh sÏ t¨ng thªm.")
            else
                Talk(1, "no", "Ng­¬i ®· thu thËp <c=g>" .. nums .. "<c> Th¹ch Hån, ta th­ëng cho ng­¬i tu hµnh " .. nFactExp)
            end
        else
            Talk(1, "no", "Ng­¬i ®· thu thËp <c=g>" .. nums .. "<c> Th¹ch Hån, ta th­ëng cho ng­¬i tu hµnh " .. nFactExp)
        end
        Msg2Player("NhËn ®­îc ®iÓm tu luyÖn" .. nFactExp)
        KsgTask:OnFinish(Task_colorrenwu);
        SetTask(Task_colortimes, GetTask(Task_colortimes) + 1)--ÀÛ¼ÆÍê³É´ÎÊı

        if (IsWorldEventExist(3) == 1) then
            local prog = GetWorldEventProgress(3) + 1
            if (prog >= 2) and (prog <= 7) then
                --1Ê±,Ë¢Ö÷ÏßÈÎÎñ
                local times = GetWorldEventValue(3, 20) + 1
                -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-07 begin
                local nLine = { 25, 50, 75, 75, 100, 125 }
                local nkey = nLine[prog - 1]
                if (times >= nkey) then
                    SetWorldEventValue(3, 20, (times - nkey))
                    SetWorldEventValue(3, prog + 7, 1049)-- ÏÉµÄĞÎÏóid
                    SetWorldEventProgress(3, prog)
                    WriteLog("[B¹ch Hæ §iªu T­îng] ®­îc kİch ho¹t")
                    AddGlobalCountNews("C¸c anh hïng tiªn ph¸i ®· ®ång t©m hiÖp lùc, hoµn thµnh " .. nkey .. " lÇn nhiÖm vô [Ngò S¾c Hån], [B¹ch Hæ §iªu T­îng] bªn c¹nh Léc ThÇn ®· ®­îc kİch ho¹t råi!", 3)
                    -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-07 end
                else
                    SetWorldEventValue(3, 20, times)
                end
            end
        end
    end
end

function cancel_renwu31()
    MsgBox("NÕu nh­ ng­¬i ®· lµm mÊt Ngò S¾c Cê th× kh«ng thÓ b¾t hung thó, lÇn sau h·y thö l¹i vËy!", "renwu31_cancel", "no")
end

function renwu31_cancel()
    CloseDialog()
    SetTaskWord(Task_colorrenwu, 2, 0)--log¼ÇÂ¼¸Ä°æ
    RemoveIBBuff(569)
    for i = 1, 5 do
        ClearItem(6, 1, 464 + i, 0)
        ClearItem(4, 223 + i, 1, 1)
    end
    TaskNote(99, -1)
    TaskNote(100, -1)
    Talk(1, "no", " Ngò S¾c Thæ Hån ®· bŞ hung thó chiÕm cø, thu phôc hung thó kh«ng ph¶i dÔ dµng. Nh­ng còng lµ t¹o phóc cho d©n, ng­¬i lÇn sau h·y thö l¹i vËy!")
    Msg2Player("Ng­¬i ®· tõ bá nhiÖm vô Ngò S¾c Hån.")
end

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊı»ıÔÜ,ÓÃÆäÊıÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ıÀÛ´ÎÊı
function offlineTotimes()
    -- modified by yaoxin for 2010-10 
    local localday = floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1-- modified by yaoxin for 2010-12

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)
    --	if (nums > 7) then
    --		nums = 7
    --	end
    --	local n_times = {50,50,50,100,100,100,100}
    local m = 3000 * GetPlayerExtLevel() --»ùÊı3000*lv
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(Task_colorrenwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = paymoney()
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
    if (GetCash() >= pm) and (HaveNormalItem(3, 248, 0, 0) >= 1) then
        if (IsHaveSpaceForTreasure(5) == 0) then
            Talk(1, "no", "<c=yel>Ngò S¾c Kú<c> tæng céng cã 5 m¶nh, <c=r>h·y s¾p xÕp 5 « trèng trong hµnh trang!")
            return 0
        end

        local lastday = GetTaskByte(Task_colorrenwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)

        if (lastday ~= today) then
            five_yes()
            return 1
        else
            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = paymoney() + apm - pm
            WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = paymoney() + apm - pm
            WriteLog(GetName() .. "Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Ngò S¾c Hån" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)
        SetTaskByte(Task_colorrenwu, 2, temp)
        SetTaskWord(Task_colorrenwu, 2, 1)--log½ÓÈÎÎñ

        DelNormalItem(3, 248, 0, 0)
        for i = 1, 5 do
            AddNormalItem(6, 1, 464 + i, 0, 0, 0)
        end
        RemoveIBBuff(569)
        AddIBBuff(569)

        local key = five_set(1) --Ö¸¶¨¹ÖÎï
        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
        Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø" .. addtimes .. " lÇn nhËn thªm nhiÖm vô Ngò S¾c Hån.")
        TaskNote(99, 0, fivecolor_item[key][2])

        SyncBibleState(100, 0, 1)
        Talk(1, "no", "§i thu phôc <c=g>" .. fivecolor_item[key][2] .. "<c>, dÉn dô hung thó tham ¨n Th¹ch hån ra, sau ®ã dïng <c=yel>Ngò S¾c Kú<c> t­¬ng øng b¾t chóng! Ta sÏ cã thï lao xøng ®¸ng cho ng­¬i!")
    else
        Talk(1, "no", " B¾t hung thó trªn BÊt Chu S¬n cÇn dïng <c=yel>Ngò S¾c Kú<c>, chÕ luyÖn 1 bé S¾c Kú cÇn dïng 1 M¶nh lôc thñy tinh vµ " .. pm .. " TiÒn ®ång,chuÈn bŞ ®Çy ®ñ råi ®Õn!")
    end
end
