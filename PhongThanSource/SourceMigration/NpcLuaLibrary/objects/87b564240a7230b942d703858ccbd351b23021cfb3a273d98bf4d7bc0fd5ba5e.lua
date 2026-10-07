--description:npc
--author: huyuzhang
--date:2009/7/14

--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-28
TASK_BANQUAN = 1502        --1byte:ÈÎÎñÊÇ·ñ¿ªÆô 2byte:ÈÎÎñ²½Öè
TASK_BANQUAN_NOTE = 1088

-- Added by luoyixuan at 0901228 begin
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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÚæÈªÌ½ÃØ
    startLevel = 75
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetTaskByte(TASK_BANQUAN, 1) == 0) then
                state = 1
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(TASK_BANQUAN, 1) == 0) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- Added by luoyixuan 091228 end

--³ÁÃßÖ®ÑÛ
Task_eye_renwu = 1530 --1byte Ê±¼ä 2byte ´ÎÊý 3byteÈÎÎñ×´Ì¬1½Ó2Ñ°µã4·ÅÁú»ê5·Å£¬Ê§°Ü 4byte ÅàÑø¶È£¨µØµãÐòºÅ1-5£©
Task_eyelight_renwu = 1531 --1byte µãÑÛ¾¦Ê±¼ä 2byte µãÑÛ¾¦´ÎÊý 2word ÉÏ´ÎÑ°µãÓëÏÖÔÚÑ°µãµÄ¾àÀë
eye_UPtimes = 4

function main()
    tasks = {
        { "<c=yel>Th¸m hiÓm B¶n TuyÒn<c>", "banquantanmi"; show = 0 },
        { "TrÇm Miªn Nh·n", "sleepeye"; show = 0 },
        { "Hoµn thµnh TrÇm Miªn Nh·n", "complete_sleepeye"; show = 0 },
        { "Hñy TrÇm Miªn Nh·n", "cancel_sleepeye"; show = 0 },
        --Added by lisuhui 2009.08.18 begin
        --75Ö÷ÏßÈÎÎñ
        { "Mª muéi", "GoAstray"; show = 0 },
        --Addec by lisuhui end
    }

    if (GetPlayerExtLevel() >= 75 and GetTaskByte(TASK_BANQUAN, 1) == 0 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    if (GetPlayerExtLevel() >= 75 and GetTaskByte(TASK_BANQUAN, 1) == 5 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    if (GetPlayerExtLevel() >= 72) and (GetJusticEvilCredit() > 0) then
        local state = GetTaskByte(Task_eye_renwu, 3)
        if (state == 0) then
            tasks[2].show = 1
        elseif (HaveEventItem(270) > 0) and (HaveNormalItem(6, 1, 563, 0) > 0 or HaveNormalItemInQuick(6, 1, 563, 0)) then
            tasks[3].show = 1
        else
            tasks[4].show = 1
        end
    end

    --Added by lisuhui 2009.08.18 begin
    if (IsViewGoAstray() == 1) then
        tasks[5].show = 1
    end
    --Added by lisuhui end
    SayTask("Nh©n giíi cïng Tiªn Ma giíi tuy kh«ng gièng nhau nh­ng l¹i cã quan hÖ phøc t¹p mËt thiÕt, ®¼ng cÊp nh©n giíi cña ng­¬i còng sÏ ¶nh h­ëng ®Õn tu hµnh cña Tiªn Ma giíi, ®¼ng cÊp Nh©n giíi kh«ng ®ñ còng sÏ gi¶m thiÓu tu luyÖn cña Tiªn Ma giíi. §¼ng cÊp Nh©n giíi cÇn cao h¬n cÊp ®é Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi cã thÓ nhËn ®­îc tu luyÖn.", tasks)    --Ä¬ÈÏÌáÊ¾ÐÅÏ¢
end;

---------------------------------------------Added by lisuhui 75Ö÷ÏßÈÎÎñ ÎóÈëÆçÍ¾ 2009.08.18----------------------------------------------------------------
Task_YinGuoLunHui = 1489
Task_GoAstray = 1541
--1Byte:	0=Î´½Ó£»1=½ÓÈÎÎñµÃµÀ¾ßÒýÈªÕë£»2=É±ËÀÍò×¦ÊÞ£»3=Íê³É

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --???
    [1] = { task = 1, note = 87 }, --???
    [2] = { task = 2, note = 88 }, --???
}

function IsViewGoAstray()

    local mainTaskStatus = GetTask(MainTask_GD_Conf[GetPlayerType()].task)
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    local taskGoAstray = GetTaskByte(Task_GoAstray, 1)
    if (GetPlayerExtLevel() >= 75 and mainTaskStatus == 165 and taskYinGuoLunHui == 10 and (taskGoAstray == 0 or taskGoAstray == 2)) then
        return 1
    else
        return 0
    end
end

function GoAstray()
    CloseDialog()

    if (GetJusticEvilCredit() < 0) then
        Talk(1, "no", "Tiªn Ma hai giíi x­a nay vèn kh«ng ®éi trêi chung")
        return
    end

    local taskGoAstray = GetTaskByte(Task_GoAstray, 1)
    if (taskGoAstray == 0) then
        Talk(7, "no", GetName() .. ": Xin hái §¹i s­, kh«ng biÕt quanh ®©y d¹o nµy cã thÊy vËt g× ®¸ng nghi ngê kh«ng?", " Ng­¬i ®Õn v× B¶ng Phong ThÇn ph¶i kh«ng? GÇn ®©y thÊy Ninh Miªu V­¬ng vµ Sãi chóa ë BÊt Chu Thiªn Quan vµ BÊt Chu S¬n th­êng xuyªn lai v·ng ®Õn B¶n TuyÒn Th¸nh §Þa, h×nh nh­ chóng ®i gÆp ai ®ã ë Th¸nh TuyÒn TuyÒn Nh·n. Cã thÓ th«ng qua bän nµy ®Ó biÕt ai ®ang lµ kÎ chñ m­u.", GetName() .. ": Xin ®¹i s­ chØ ®iÓm, lµm sao ®Ó khiÕn kÎ chñ m­u lé diÖn.", " §©y lµ 1 DÉn TuyÒn Ch©m, ®­îc trén lÉn tinh huyÕt cña Sãi chóa vµ Ninh Miªu V­¬ng. Mang theo nã vµo TuyÒn Nh·n, sÏ khiÕn kÎ chñ m­u xuÊt hiÖn. Nh­ng ph¶i chó ý, tinh huyÕt cña chóng rÊt dÔ bÞ ®«ng, ph¶i hµnh ®éng thËt nhanh míi ®­îc.", GetName() .. ": §a t¹ ®¹i s­! T¹i h¹ ®i ngay.", " Khoan ®·! Hai tªn thñ lÜnh kia ph¸p lùc rÊt cao c­êng. Ng­¬i ph¶i nhí dô ra tõng tªn míi cã thÓ tiªu diÖt, nÕu ®Ó chóng liªn thñ víi nhau th× ng­¬i rÊt khã toµn m¹ng!", GetName() .. ": §a t¹ ®¹i s­ chØ gi¸o!")

        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", " Xin thu xÕp hµnh trang cßn d­ 1 « trèng, nÕu kh«ng sÏ kh«ng thÓ nhËn DÉn TuyÒn Ch©m.")
            return
        end

        AddNormalItem(6, 1, 575, 0, 0, 0)
        SetTaskByte(Task_GoAstray, 1, 1)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 47)
        return
    elseif (taskGoAstray == 2) then
        GetAward()
        Talk(2, "no", GetName() .. ": T×m thÊy V¹n Tr¶o Thó, nh­ng vÉn ch­a cã ®­îc manh mèi B¶ng Phong ThÇn, chØ cã 1 miÕng Ngäc Béi. LÏ nµo ë B¶n TuyÒn Th¸nh §Þa còng kh«ng cã manh mèi cña B¶ng Phong ThÇn.", " Cho ta xem thö!...MiÕng Ngäc Béi nµy kh«ng ®¬n gi¶n, xem ra ta ph¶i hao tæn thªm chót tinh lùc ®Ó nghiªn cøu nã, bao giê ng­¬i ®Õn cÊp 80 h·y quay l¹i nhÐ.")
        SetTaskByte(Task_GoAstray, 1, 3)
        SetTask(MainTask_GD_Conf[GetPlayerType()].task, 166)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 49)
    end

end

function GetAward()
    if (HaveEventItemCount(271) < 1) then
        Talk(1, "no", "Ng­¬i kh«ng cã Ngäc Béi ta cÇn, cã thÓ ®Õn chç Nhµ kh¶o cæ ®Ó mua.")
        return
    end

    ClearItem(6, 1, 575, 0)
    ClearItem(4, 271, 0, 1)
    AddOwnExtendExp(40000000)
    Msg2Player("NhËn ®­îc tu luyÖn 4000 v¹n")
end
------------------------------------------------------------------------------------------------------------------------------------------------------------

function no()
    CloseDialog()
end;

function StepOne()
    CloseDialog()
    --SetTaskByte(TASK_BANQUAN, 1, 1)		--ÉèÖÃÈÎÎñ½ÓÊÜ
    SetTaskByte(TASK_BANQUAN, 2, 1)            --ÉèÖÃÈÎÎñ²½Öè
    SetSubTask(1088, 1, 1)
    Msg2Player("§Õn gÇn Th¸nh TuyÒn t×m V« Danh L·o Nh©n")
    TaskNote(TASK_BANQUAN_NOTE, 0)

end

function banquantanmi()
    CloseDialog()

    if (GetTaskByte(TASK_BANQUAN, 1) == 0 and GetPlayerExtLevel() >= 75 and GetTaskByte(TASK_BANQUAN, 2) == 0) then
        SetTaskByte(TASK_BANQUAN, 1, 5)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        Talk(2, "banquantanmi1", " §¹o h÷u ch¾c cã nghe qua truyÒn thuyÕt vÒ 2 ThÇn Binh ë Th¸nh TuyÒn? KÓ vÒ hai dòng sÜ Kh­¬ng Giai Minh vµ C¬ Th­¬ng HuyÒn, hai ng­êi v× tranh giµnh Th¸nh TuyÒn mµ quyÕt chiÕn víi nhau suèt 3 ngµy 3 ®ªm, cuèi cïng c¶ hai ®Òu kiÖt søc tö vong.", " HiÖn giê c¸c ®Ö tö Ma giíi ®ang vµo Th¸nh TuyÒn truy t×m ThÇn Binh, Ma giíi nÕu cã ®­îc ThÇn Binh th× nh©n gian sÏ lÇm than. C¸c h¹ ®Õn ®©y còng l©u råi, kh«ng biÕt cã ®iÒu tra ®­îc g× kh«ng?")

    elseif (GetTaskByte(TASK_BANQUAN, 1) == 5) then
        Talk(1, "no", " Cã manh mèi g× vÒ ThÇn Binh ë Th¸nh TuyÒn kh«ng? Nh©n vËt thÇn bÝ ë <c=g>gÇn Th¸nh TuyÒn<c> cã ph¶i lµ V« Danh L·o Nh©n?")

    end

end

function banquantanmi1()
    CloseDialog()
    Talk(3, "StepOne", GetName() .. ": Nãi míi nhí! Ta ®· tõng siªu ®é cho mét vong hån, cã nghe nã nãi ®Õn n¬i ®©y cã mét V« Danh L·o Nh©n biÕt chuyÖn vÒ ThÇn binh.", " Ta còng nghe nãi gÇn Th¸nh TuyÒn cã mét ng­êi thÇn bÝ sèng ë ®ã ®· l©u, hay ®¹o h÷u thö ®Õn ®ã mét chuyÕn xem sao?", GetName() .. ": Kh«ng thµnh vÊn ®Ò! T¹i h¹ ®i ngay!")

end

---³ÁÃßÖ®ÑÛ--add yao xin by 2009/08/11 ----------------------------------------
function sleepeye()
    local lastday = GetTaskByte(Task_eye_renwu, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local temp = GetTaskByte(Task_eye_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)

    if (lastday ~= today) then
        if (HaveNormalItem(3, 427, 0, 0) >= 10) and (HaveNormalItem(3, 428, 0, 0) >= 10) then
            MsgBox(" Cuèi cïng ng­¬i còng ®Õn, nh­ng hiÖn t¹i ng­¬i vÉn ch­a thÓ vµo Th¸nh ®Þa t×m HuyÒn Vò ThÇn Binh. Ng­¬i h·y ®i t×m <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi thø 10<c>, ta sÏ gióp ng­¬i ng­ng tô 1 <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c> vµ cho ng­¬i biÕt thªm mét bÝ mËt kh¸c!", "sleepeye_yes", "no")
        else
            Talk(1, "no", " cÇn <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c>, ta míi cã thÓ gióp ng­¬i ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c>!")
        end
    elseif (times < eye_UPtimes or alltimes >= addtimes) then
        if (HaveNormalItem(3, 427, 0, 0) >= 10) and (HaveNormalItem(3, 428, 0, 0) >= 10) then
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹pTµiTuLuyÖn", "yes_freefsb"; show = 0 },
                { "Di tÝch Long Hån", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end

            if (times < eye_UPtimes) then
                task[2].show = 1
            end
            SayTask(" Ph¸p lùc cña ta hiÖn t¹i cßn cã thÓ gióp ng­¬i ng­ng tô " .. (alltimes - addtimes + 1) .. " lÇn To¸i phiÕn, nÕu cã " .. pm_free .. " b¹c ®Ó tÕ trêi, ta cã thÓ gióp ng­¬i ng­ng tô thªm To¸i phiÕn. §­¬ng nhiªn, ®Ó ng­ng tô [M¶nh M¾t Rång ¶m §¹m] th× <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c> lµ kh«ng thÓ thiÕu.", task)
        else
            Talk(1, "no", " Ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c> cÇn dïng <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c>, h·y t×m ®ñ råi quay l¹i gÆp ta nhÐ.")
        end
    else
        Talk(1, "no", " Ph¸p lùc cña ta mçi ngµy chØ cã thÓ gióp ng­¬i ng­ng tô " .. eye_UPtimes .. " lÇn <c=yel>M¶nh M¾t Rång ¶m §¹m<c>, mai h·y tiÕp tôc nhÐ!")
    end
end

function coin_renwu()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(130)
    if (HaveNormalItem(8, 763, 2, 0) >= 1) then
        MsgBox(" TiÕp tôc ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c>, ngoµi cÇn <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c> ra ph¶i cã thªm<c=yel>Di tÝch Long Hån<c>.", "sleepeye_coin_yes", "no")
    elseif (GetCoin() >= Cv) then
        MsgBox("TiÕp tôc ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c>, ngoµi cÇn <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c> ra ph¶i cã thªm<c=yel>Di tÝch Long Hån<c>, hoÆc sö dông " .. Cfs .. "TiÒn ®ång thay thÕ.", "sleepeye_coin_yes", "no")
    else
        Talk(1, "no", " TiÕp tôc ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c>, cßn cÇn <c=yel>Di tÝch Long Hån<c> hoÆc " .. Cfs .. "TiÒn ®ång cã thÓ t×m gióp ta kh«ng?")
    end
end

function sleepeye_yes()
    if (HaveNormalItem(3, 427, 0, 0) >= 10) and (HaveNormalItem(3, 428, 0, 0) >= 10) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", " <c=r>Xin thu xÕp hµnh trang cßn d­ 1 « trèng!")
            return 0
        end

        local lastday = GetTaskByte(Task_eye_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local temp = GetTaskByte(Task_eye_renwu, 2) + 1
        local times, addtimes = todayfreetimes(temp)

        if (lastday ~= today) then
            offlineTotimes()
            times = 1
            SetTaskByte(Task_eye_renwu, 1, today)
            SetTaskByte(Task_eye_renwu, 2, times)
        else
            SetTaskByte(Task_eye_renwu, 2, temp)
        end

        SetTaskByte(Task_eye_renwu, 3, 1)--½ÓÈÎÎñ
        SetTaskByte(Task_eye_renwu, 4, 0)

        for i = 1, 10 do
            DelNormalItem(3, 427, 0, 0)
            DelNormalItem(3, 428, 0, 0)
        end
        AddNormalItem(6, 1, 563, 0, 0, 0)
        RemoveIBBuff(764)
        AddIBBuff(764)--Ê±ÏÞ

        Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. times .. " lÇn nhËn nhiÖm vô TrÇm Miªn Nh·n!")
        TaskNote(115, 0)
        TaskNote(116, -1)

        if (times < eye_UPtimes) then
            SyncBibleState(115, 2, 0)
        else
            SyncBibleState(115, 3, 0)
        end ;
        SyncBibleState(116, 0, 1)
        Talk(3, "no", " Th¸nh §Þa nµy cã rÊt nhiÒu truyÒn thuyÕt, sau khi hai vÞ dòng sÜ hai bé l¹c Viªm Huúnh kiÖt søc mµ chÕt, ThÇn binh bÞ ch×m xuèng Th¸nh TuyÒn hãa thµnh HuyÒn Vò. B¨ng Viªm Song Long v× o¸n hËn bé l¹c Viªm Huúnh, sau bÞ Phôc Hy ®µy ®Õn Ngôc Ph¸p S¬n, nh­ng vÉn ®Ó l¹i b¶n Th¸nh TuyÒn 1 con m¾t, ®Ó b¶o vÖ cho c¸c anh hån.", "Tr¶i qua thêi gian dµi, Tinh hån cña Long Nh·n ®­îc c¸c sinh linh ë B¶n TuyÒn hÊp thu, Hån HuyÒn Vò dÇn bÞ r¬i vµo tr¹ng th¸i trÇm mª. NÕu muèn t×m ®­îc HuyÒn Vò ThÇn Binh th× ph¶i t×m c¸ch ®¸nh thøc Long Nh·n tr­íc.", "Ta giao cho ng­¬i 1 <c=yel>M¶nh M¾t Rång ¶m §¹m<c>, h·y ®Õn B¶n TuyÒn thu phôc mét sè sinh linh, dïng m¸u cña chóng håi phôc linh khÝ cho To¸i phiÕn, sau ®ã dô ra <c=r>Long Hån <c> ®Ó thu phôc nã, gióp cho M¶nh M¾t Rång s¸ng lªn. Sau ®ã h·y quay vÒ gÆp ta!")
        return 1
    else
        Talk(1, "no", " Ph¶i cã <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c> míi cã c¬ héi ®¸nh thøc Long Nh·n, ng­ng tô [M¶nh M¾t Rång ¶m §¹m] cÇn cã <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c>, xin h·y mau ®i thu thËp!")
    end
    return 0
end

function sleepeye_coin_yes()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(130)
    local i = FindAValidIBItem(8, 763, 2, 0)
    if (i ~= 0) then
        if (sleepeye_yes() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("B¹n tÆng 1 Di tÝch Long Hån cho Tu Hµnh S­, nhËn ®­îc nhiÖm vô ")
    elseif (GetCoin() >= Cv) then
        if (sleepeye_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(130)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. "TiÒn ®ång cho Tu Hµnh S­, nhËn ®­îc nhiÖm vô ")
    else
        Talk(1, "no", " TiÕp tôc ng­ng tô <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c>, cßn cÇn <c=yel>Di tÝch Long Hån<c>, xin h·y mau ®i thu thËp.")
    end
end

function complete_sleepeye()
    CloseDialog()
    if (HaveEventItem(270) > 0) and (HaveNormalItem(6, 1, 563, 0) > 0 or HaveNormalItemInQuick(6, 1, 563, 0)) then
        SetTaskWord(Task_eye_renwu, 2, 0)--log¸Ä°æ
        RemoveIBBuff(764)
        RemoveIBBuff(765)

        ClearItem(6, 1, 563, 0)
        DelEventItem(270)
        AddEventItem(269)

        TaskNote(116, -1)
        TaskNote(115, 4)

        local nFactExp = 14000 * GetPlayerExtLevel()
        nFactExp = AddOwnExtendExp(nFactExp)--¾­Ñé
        Talk(1, "no", " Thu thËp ®­îc <c=g>Long Hån Tinh Ph¸ch<c> kh«ng dÔ. Ta tÆng ng­¬i phÇn th­ëng " .. nFactExp .. ". Nh­ vËy M¶nh M¾t Rång ®· cã hiÖu dông råi, h·y dïng nã ®¸nh thøc Long Nh·n, gióp Long Nh·n cã c¬ héi håi sinh. Tiªn giíi hîp m¹ng víi B¨ng Long, ng­¬i thuéc Tiªn giíi, h·y ®i ®¸nh thøc cho Háa Long Nh·n ®i")
        Msg2Player("NhËn ®­îc ®iÓm tu luyÖn" .. nFactExp)
    else
        Talk(1, "no", " <c=yel>M¶nh M¾t Rång ¶m §¹m<c> hoÆc <c=yel>Long Hån Tinh Ph¸ch<c> ®©u råi?")
    end
end

function cancel_sleepeye()
    MsgBox(" TiÕc qu¸! NhiÖm vô ®· thÊt b¹i! LÇn sau h·y quay l¹i thö nhÐ!", "sleepeye_cancel", "no")
end

function sleepeye_cancel()
    CloseDialog()
    SetTaskByte(Task_eye_renwu, 3, 0)
    SetTaskByte(Task_eye_renwu, 4, 0)
    RemoveIBBuff(764)
    RemoveIBBuff(765)
    ClearItem(6, 1, 563, 0)
    DelEventItem(270)

    TaskNote(115, -1)
    TaskNote(116, -1)
    Talk(1, "no", " Dô ra Long Hån kh«ng dÔ. Nh­ng v× an nguy cña b¸ t¸nh, xin ®¹o h÷u h·y thö thªm mét lÇn n÷a nhÐ!")
    Msg2Player("B¹n ®· hñy nhiÖm vô TrÇm Miªn Nh·n.")
end

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊý»ýÔÜ,ÓÃÆäÊýÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ýÀÛ´ÎÊý
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
    local m = 10000 * GetPlayerExtLevel() --»ùÊý10000*lv
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(Task_eye_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) and (HaveNormalItem(3, 427, 0, 0) >= 10) and (HaveNormalItem(3, 428, 0, 0) >= 10) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", " <c=r>Xin thu xÕp hµnh trang cßn d­ 1 « trèng!")
            return 0
        end

        local lastday = GetTaskByte(Task_eye_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)

        if (lastday ~= today) then
            sleepeye_yes()
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

        Pay(apm)
        SetTaskByte(Task_eye_renwu, 2, temp)
        SetTaskByte(Task_eye_renwu, 3, 1)--½ÓÈÎÎñ
        SetTaskByte(Task_eye_renwu, 4, 0)

        for i = 1, 10 do
            DelNormalItem(3, 427, 0, 0)
            DelNormalItem(3, 428, 0, 0)
        end
        AddNormalItem(6, 1, 563, 0, 0, 0)
        RemoveIBBuff(764)
        AddIBBuff(764)--Ê±ÏÞ

        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tÝch lòy")
        Msg2Player("§©y lµ ­u ®·i tÝch lòy rêi game lÇn thø" .. addtimes .. " lÇn nhËn thªm nhiÖm vô TrÇm Miªn Nh·n.")
        TaskNote(115, 0)
        TaskNote(116, -1)
        SyncBibleState(116, 0, 1)
        Talk(3, "no", " Th¸nh §Þa nµy cã rÊt nhiÒu truyÒn thuyÕt, sau khi hai vÞ dòng sÜ hai bé l¹c Viªm Huúnh kiÖt søc mµ chÕt, ThÇn binh bÞ ch×m xuèng Th¸nh TuyÒn hãa thµnh HuyÒn Vò. B¨ng Viªm Song Long v× o¸n hËn bé l¹c Viªm Huúnh, sau bÞ Phôc Hy ®µy ®Õn Ngôc Ph¸p S¬n, nh­ng vÉn ®Ó l¹i b¶n Th¸nh TuyÒn 1 con m¾t, ®Ó b¶o vÖ cho c¸c anh hån.", "Tr¶i qua thêi gian dµi, Tinh hån cña Long Nh·n ®­îc c¸c sinh linh ë B¶n TuyÒn hÊp thu, Hån HuyÒn Vò dÇn bÞ r¬i vµo tr¹ng th¸i trÇm mª. NÕu muèn t×m ®­îc HuyÒn Vò ThÇn Binh th× ph¶i t×m c¸ch ®¸nh thøc Long Nh·n tr­íc.", "Ta giao cho ng­¬i 1 <c=yel>M¶nh M¾t Rång ¶m §¹m<c>, h·y ®Õn B¶n TuyÒn thu phôc mét sè sinh linh, dïng m¸u cña chóng håi phôc linh khÝ cho To¸i phiÕn, sau ®ã dô ra <c=r>Long Hån <c> ®Ó thu phôc nã, gióp cho M¶nh M¾t Rång s¸ng lªn. Sau ®ã h·y quay vÒ gÆp ta!")
    else
        Talk(1, "no", " Ph¶i cã <c=yel>[M¶nh M¾t Rång ¶m §¹m]<c> míi cã c¬ héi ®¸nh thøc Long Nh·n, ng­ng tô [M¶nh M¾t Rång ¶m §¹m] cÇn cã <c=g>Dò Th­¬ng Th¶o, Tôc MÖnh Hoa mçi lo¹i 10<c>, cßn cÇn thªm " .. apm .. " TiÒn ®ång,chuÈn bÞ ®Çy ®ñ råi ®Õn!")
    end
end

-------------end yao xin by 2009/08/11 -----------------------------------
