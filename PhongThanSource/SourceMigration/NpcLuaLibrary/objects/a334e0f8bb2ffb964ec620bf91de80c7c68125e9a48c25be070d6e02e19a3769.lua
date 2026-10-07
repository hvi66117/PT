Include("\\script\\gvn\\lib.lua");
--ºôÏÉ»½Ä§.lua
--author: GaoJingwei
--date:2009/2/5

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-17
task_renwu = 1309        --1byte£ºÊÇ·ñ½ÓÈÎÎñ£¬0±íÊ¾ÒÑ½Ó£¬1±íÊ¾Ã»½Ó£»2byte£ºÒÑ½ÓÈÎÎñµÄ´ÎÊı£»
--3byte:Ê£ÓàµÄ¹ÖÎï¸öÊı£»4£ºÊÇ·ñÍê³ÉÈÎÎñ
task_acceptDay = 1310    --½ÓÈÎÎñµÄÈÕÆÚ 
totleNumber = 1311       --Íæ¼ÒÀÛ¼ÆÍê³ÉÈÎÎñµÄ´ÎÊı
killTimes = 1325        --1byte:É±ËÀÊôÓÚ×Ô¼º¹ÖµÄ´ÎÊı;2byte:ÊÇ·ñÁìÈ¡¹ıÓñÊ¯;3byte¼ÇÂ¼ÊÇ·ñÁìÈ¡µÄË«±¶ÈÎÎñ£º0µ¥±»£¬1Ë«±¶£¨Ò»¶¨ÒªÔÚ½ÓÈÎÎñµÄÊ±ºòÖØÖÃ£©

BeadNumber = 15        --Ğè½ÉÄÉµÄÏÉÖé»òÄ§ÖéµÄ¸öÊı 

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

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --²»ÃğÉñµÆ
    startLevel = 22
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 9) == 1 and GetTaskBit(Task_NotDieLamp, 10) == 0) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 9) == 1 and GetTaskBit(Task_NotDieLamp, 10) == 0) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    -- Add By Zhang Jin for »¨ÎäÏàÉú at 2010-11-22 Begin
    if (GetPlayerExtLevel() >= 1 and IsPartyTime() == 1) then
        if (Is_HaveStone() > 0) then
            state = 3
            subState = 0
        end

        index = searchForIndex(state, subState, index)
    end
    -- Add By Zhang Jin for »¨ÎäÏàÉú at 2010-11-22 End

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
-- Added by luoyixuan 091228 end

function main()
    local str = "H« Tiªn Ho¸n Ma"
    local completenums = GetTask(totleNumber)
    if (completenums >= 420) then
        str = "<c=yel>H« tiªn ho¸n ma<c>"
    elseif (completenums >= 20) then
        str = "<c=g>H« tiªn ho¸n ma<c>"
    end
    tasks = {
        { str, "GetSign"; show = 0 },
        { "Hñy N.vô", "Cancel"; show = 0 },
        { "BÊt DiÖt §¨ng", "getShiZhongFire"; show = 0 },
        { "Th¸i Th¹ch LuyÖn S¬n", "PreGather_Stone"; show = 1 },
    }

    if (isViewNotDieLamp() == 1) then
        tasks[3].show = 1
    end

    if (GetPlayerExtLevel() >= 12) then
        --12¼¶¼°ÒÔÉÏµÄÍæ¼Ò²ÅÄÜ¿´µ½
        if (GetTaskByte(task_renwu, 1) == 0) then
            tasks[1].show = 1
        else
            tasks[1].show = 1
            tasks[2].show = 1
        end
        SayTask("Phong thÇn ®¹i chiÕn, nhiÒu ®¹o h÷u v× nghŞch ph¶n mµ bŞ biÕn thµnh Hung Tiªn Phi Thè Ma. V× vËy Tiªn Ma ®· x©y nªn Phong Tiªn To¶ Ma th¸p ®Ó trÊn ¸p c¸c linh hån, cµng khiÕn cho chóng muèn tho¸t ra quËy ph¸. Mong anh hïng gióp ®ì siªu ®é.", tasks)
    else
        -- Modify By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 Begin
        SayTask("Kh«ng biÕt ®Õn bao giê cuéc chiÕn Th­¬ng Chu nµy míi chÊm døt ®©y!", tasks)
        -- Modify By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 End
    end


end

-----------------------------------------------------------------------------------------------------
--²»ÃğÖ®µÆ  add by lisuhui  2009.02.23
Task_NotDieLamp = 1332     -- ²»ÃğÖ®µÆµÄÈÎÎñ±äÁ¿£ºµÚÒ»¸öByte£ºÈÎÎñ×´Ì¬¡£µÚ¶ş¸öByte£ºÈ¡»ğ±êÖ¾£¨1bit£º¿ÕÖĞ»ğ£»2bit£ºÊ¯ÖĞ»ğ£»3bit£ºÄ¾ÖĞ»ğ£»4bit£ºÈıÃÁ»ğ£»5bit£ºÈË¼ä»ğ£»£©

questions = {
    [1] = "Ta n¨m x­a lÊy ®¸ v¸ trêi, tù nhËn thÊy m×nh c«ng ®øc c¸i thÕ. Nµo ngê trong lóc v¸ trêi ta ®· lì tay lµm ®øt 4 ch©n cña mét sinh linh. Ng­¬i ®o¸n xem ®ã lµ g×?",
    [2] = "§¹o h÷u V¨n Thï Qu¶ng Ph¸p Thiªn T«n cña ta trong V¹n Tiªn trËn ®· sö dông Ph¸p khİ thu phôc ®­îc thó c­ìi Thanh S­, ®ã lµ Ph¸p khİ g×?",
    [3] = "§¹o h÷u th«ng minh nh­ vËy, th«i ta kh«ng d¸m lµm khã n÷a…1624 nh©n víi 627 b»ng bao nhiªu?",
    [4] = "Tİnh sai råi! Quay l¹i tr¶ lêi tõ ®Çu", --xiaoque
}

function isViewNotDieLamp()
    local nTaskState = GetByte(GetTask(Task_NotDieLamp), 1)
    local nKongFire = GetTaskBit(Task_NotDieLamp, 9)
    local nShiZhong = GetTaskBit(Task_NotDieLamp, 10)

    if (GetPlayerExtLevel() < 22) then
        return 0
    end

    if (nTaskState ~= 2) then
        return 0
    end

    if (nKongFire == 0) then
        return 0
    end

    if (nShiZhong == 1) then
        return 0
    end

    return 1
end

function getShiZhongFire()

    --debug
    --	local ret = isViewNotDieLamp()
    --	Msg2Player(ret)
    --debug

    local nIBBuff = HaveIBBuff(534)

    if (nIBBuff == 0) then
        Talk(1, "no", "Thêi gian ®· hÕt, Liªn täa ®· hĞo óa, ta còng bã tay th«i! Hay lµ ®i t×m <c=g>Liªn §¨ng Hé sø<c> hái xem cã c¸ch g× kh«ng?")
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end
    MsgBox("<c=g>Th¹ch Trung Háa<c> ta ®­¬ng nhiªn cã, nh­ng kh«ng dÔ tÆng nh­ vËy. §¸p ®óng ®­îc mÊy c©u hái cña ta råi h·y tİnh!", "yesNotDieLamp", "no")
end

function yesNotDieLamp()
    Say(questions[1], 4, "A.Voi/no1", "B.Ngao/yes_1", "C.Bß/no1", "D.Tª gi¸c/no1")
end

function yes_1()
    Say(questions[2], 4, "A.Th¸i Cùc ®å/no1", "B.Phiªn Thiªn Ên/no1", "C.Ph­îc Yªu S¸ch/no1", "D.Bµn Cæ Ph­ín/yes_2")
end;

function yes_2()
    Say(questions[3], 4, "A.1018248/yes_3", "B.1217248/no1", "C.2345678/no1", "D.1120587/no1")
end;

function yes_3()

    local nShiFire = GetTaskBit(Task_NotDieLamp, 10)
    if (nShiFire == 1) then
        Talk(1, "no", "§· cã ®­îc Th¹ch Trung Háa råi, giê h·y ®i gÆp <c=g>Thî §ång<c> ë <c=g>BÊt Chu Thiªn quan<c> ®i!")

        return
    end

    if (isViewNotDieLamp() ~= 1) then
        Talk(1, "no", "LÏ ra ng­¬i kh«ng nªn ®Õn t×m ta!")     --xiaoque
        return
    end

    AddNormalItem(3, 344, 0, 0, 0, 0)                        --"Ê¯ÖĞ»ğ"
    TopMessage("NhËn ®­îc <c=g>Th¹ch Trung Háa<c>")
    Msg2Player("NhËn ®­îc Th¹ch Trung Háa, cã thÓ ®Õn Thî §ång nhËn Méc Trung Háa.")
    SetTaskBit(Task_NotDieLamp, 10, 1)
    Talk(1, "no", " Häc vÊn cña ng­¬i rÊt uyªn th©m, <c=g>Th¹ch Trung Háa<c> ng­¬i xøng ®¸ng ®­îc nhËn. <c=g>Méc Trung Háa<c> ng­¬i cã thÓ ®Õn gÆp <c=g>Thî §ång<c> ®Ó hái!")
    TaskNote(96, 3)                                    --»ñÈ¡ÁËÄ¾ÖĞ»ğ
    -- Added by luoyixuan 091228 begin
    refreshNpcTaskState()
    -- Added by luoyixuan 091228 end
end

function no1()
    MsgBox(questions[4], "yesNotDieLamp", "no")
end;

-----------------------------------------------------------------------------------------------------

function no()
    CloseDialog()
end

function GetSign()
    CloseDialog()
    if (GetTaskByte(task_renwu, 1) ~= 0) then
        --ÈôÁìÈ¡ÁËÈÎÎñ
        if (HaveEventItem(210) == 0 and HaveEventItem(211) == 0) then
            --Èô¼¤»îÁË·âËş
            if (HaveIBBuff(515) > 0) then
                Talk(1, "no", "Ng­¬i vÉn ch­a siªu ®é hoµn thµnh Hung Tiªn Phi Thè Ma, ao l¹i quay vÒ?")
                --			Msg2Player("ÈÎÎñ»¹ÔÚ½øĞĞÖĞ")
            else
                if (GetTaskByte(task_renwu, 4) == 1) then
                    MsgBox("Anh hïng ®· siªu ®é thµnh c«ng, thµnh qu¶ kh«ng nhá! Ta sÏ gióp t¨ng n¨ng lùc tu luyÖn cho anh hïng!", "Bonus", "no")       --¼¤»î·âËş£¬¸ù¾İÉ±¹ÖÊıÁ¿»ñÈ¡½±Àø
                else
                    SetTaskByte(task_renwu, 1, 0)
                    SetTaskByte(task_renwu, 3, 0)
                    SetTaskByte(task_renwu, 4, 0)
                    Talk(1, "no", "Ng­¬i ch­a siªu ®é hµn tÊt cho Hung Tiªn Phi Thè Ma! Ph¶i nç lùc thªm n÷a!")
                    TaskNote(1026, -1)
                    --				Msg2Player("ÈÎÎñÊ§°Ü")
                end
            end
        else
            Talk(1, "no", "Thêi gian gÊp rót! Xin h·y mau ®i siªu ®é c¸c vong linh!")
        end
    else
        tasks = {
            { "M¹n ®µ lµ hoa", "SuperBead"; show = 1 },
            { "M¹n ch©u sa hoa", "EvilBead"; show = 1 }
        }
        SayTask("Lùa chän-<enter>Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c><enter>Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>", tasks)

    end
end

function Cancel()
    MsgBox("Hung Tiªn Phi Thè Ma mÆc dï bŞ nhèt trong th¸p nh­ng ph¸p lùc vÉn cßn rÊt cao c­êng! NÕu anh hïng muèn rót lui th× vÉn cßn kŞp!", "yes", "no")
    --	TaskNote(1026, -1)
end

function yes()
    if (HaveEventItem(210) == 0 and HaveEventItem(211) == 0 and HaveIBBuff(515) == 0) then
        --ÈôÒÑ¾­¼¤»îÁËËş
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 3, 0)
        Msg2Player("B¹n ®· huû nhiÖm vô H« Tiªn Ho¸n Ma!")
        TaskNote(1026, -1)
        no()
    else
        --	Msg2Player("Ö»ÓĞ¼¤»îÁËËş²ÅÄÜÈ¡ÏûÈÎÎñ")
        Talk(1, "no", "Thêi gian gÊp rót! Xin h·y mau ®i siªu ®é c¸c vong linh!")
    end
end

--Ñ¡Ôñ½ÉÄÉÏÉÖé
function SuperBead()
    no()
    local today = floor(LocalSystemTime() / 86400)

    if (today ~= GetTask(task_acceptDay)) then
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 2, 0)
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        SetTask(task_acceptDay, today)
        offlineTotimes()

        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
        SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    end

    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)

    if (times == 0) then
        --µÚÒ»´Î½ÓÈÎÎñ
        if (HaveNormalItem(3, 311, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                --¼õµôÂüÍÓÂŞ»ª
                DelNormalItem(3, 311, 0, 0)
            end

            SetTaskByte(task_renwu, 1, 1)                      --±íÊ¾ÒÑ½ÓÈÎÎñ
            SetTaskByte(task_renwu, 2, 1)
            SetTaskByte(task_renwu, 3, 0)                        --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
            SetTaskByte(task_renwu, 4, 0)
            times = 1

            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
            SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

            SyncBibleState(1026, 2, 1)

            AddEventItem(210)                      --»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
            Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p më phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
            Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
            TaskNote(1026, 0, "TrÊn ma ph­ín")
        else
            Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        end

        --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    elseif (times < 5 or alltimes >= addtimes) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹pTµiTuLuyÖn", "yes_freefsb"; show = 0 },
            { "Tru Tµ KiÕm", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        end

        if (times < 5) then
            task[2].show = 1
        end
        if (alltimes - addtimes + 1 > 0) then
            SayTask(" Ng­¬i hiÖn ®· tİch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. " l­îng, cã thÓ nhËn thªm nhiÖm vô kh«ng tİnh vµo sè vßng nhiÖm vô thu phİ. NhÊp “N¹p tµi tu luyÖn“ ®Ó h­ëng ­u ®·i nµy! Nh­ng ®Ó chÕ t¹o TrÊn ma ph­ín, th× kh«ng thÓ thiÕu 15 M¹n §µ La hoa nhĞ!", task)
        else
            SayTask(" NÕu ng­¬i lo l¾ng v× bËn c«ng viÖc kh«ng thÓ th­êng xuyªn tham gia luyÖn c«ng, ta sÏ gióp ng­¬i c¬ héi <c=g>N¹p tµi tu luyÖn<c>, chØ cÇn bá ra rÊt İt b¹c!", task)
        end
        --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    else
        Talk(1, "no", " BÊt luËn thÕ nµo, H« Ma th¸p mçi ngµy chØ cã thÓ më 5 lÇn, nÕu kh«ng thÕ c©n b»ng Tiªn Ma ë BÊt Chu Thiªn Quan sÏ bŞ ph¸ vì! Ngµy mai h·y quay l¹i nhĞ!")    --Edit by gaojingwei 0715 ÈÎÎñ´ÎÊıÓÅ»¯
        --Msg2Player("²»ÄÜÔÚÁìÈ¡ÈÎÎñ")
    end
end

function coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "yes2"; show = 0 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "Yes_Double"; show = 0 }, --Ë«±¶ÊÕ·Ñ
    }
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    if (times < 5) then
        task[1].show = 1
    end

    if (times < 4) then
        task[2].show = 1
    end

    SayTask("H« Ma th¸p mçi ngµy chØ cã thÓ më 1 lÇn, nÕu muèn më thªm cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Kim Nguyªn B¶o <c>, ta sÏ gióp ng­¬i më thªm lÇn n÷a. NÕu ng­¬i muèn cã ®­îc nh©n ®«i phÇn th­ëng, chØ cÇn cung cÊp <c=yel>2 Tru Tµ KiÕm<c> hoÆc <c=yel>" .. (Cfs * 2) .. "<c> tiÒn ®ång.", task)
end

--Ñ¡Ôñ½ÉÄÉÄ§Öé
function EvilBead()
    no()
    local today = floor(LocalSystemTime() / 86400)

    if (today ~= GetTask(task_acceptDay)) then
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 2, 0)
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        SetTask(task_acceptDay, today)
        offlineTotimes()

        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
        SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    end

    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)

    if (times == 0) then
        --µÚÒ»´Î½ÓÈÎÎñ
        if (HaveNormalItem(3, 312, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                --¼õµôÂüÖéÉ³»ª
                DelNormalItem(3, 312, 0, 0)
            end

            SetTaskByte(task_renwu, 1, 1)                    --±íÊ¾ÒÑ½ÓÈÎÎñ
            SetTaskByte(task_renwu, 2, 1)
            SetTaskByte(task_renwu, 3, 0)                        --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
            SetTaskByte(task_renwu, 4, 0)
            times = 1

            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
            SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

            SyncBibleState(1026, 2, 1)

            AddEventItem(211)                --?»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
            Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p më phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
            Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
            TaskNote(1026, 1, "To¶ Tiªn bµi")
        else
            Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        end

        --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    elseif (times < 5 or alltimes >= addtimes) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹pTµiTuLuyÖn", "yes_freefsb1"; show = 0 },
            { "Tru Tµ KiÕm", "coin_renwu1"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        end

        if (times < 5) then
            task[2].show = 1
        end

        if (alltimes - addtimes + 1 > 0) then
            SayTask(" Ng­¬i hiÖn ®· tİch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. " l­îng, cã thÓ nhËn thªm nhiÖm vô kh«ng tİnh vµo sè vßng nhiÖm vô thu phİ. NhÊp “N¹p tµi tu luyÖn“ ®Ó h­ëng ­u ®·i nµy! Nh­ng ®Ó chÕ t¹o TrÊn ma ph­ín, th× kh«ng thÓ thiÕu 15 M¹n §µ La hoa nhĞ!", task)
        else
            SayTask(" NÕu ng­¬i lo l¾ng v× bËn c«ng viÖc kh«ng thÓ th­êng xuyªn tham gia luyÖn c«ng, ta sÏ gióp ng­¬i c¬ héi <c=g>N¹p tµi tu luyÖn<c>, chØ cÇn bá ra rÊt İt b¹c!", task)
        end
        --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    else
        Talk(1, "no", " BÊt luËn thÕ nµo, H« Tiªn th¸p mçi ngµy chØ cã thÓ më 5 lÇn, nÕu kh«ng thÕ c©n b»ng Tiªn Ma ë BÊt Chu Thiªn Quan sÏ bŞ ph¸ vì! Ngµy mai h·y quay l¹i nhĞ!")        --Edit by gaojingwei 0715 ÈÎÎñ´ÎÊıÓÅ»¯
        --	Msg2Player("²»ÄÜÔÚÁìÈ¡ÈÎÎñ")
    end
end

function coin_renwu1()
    --ÈôÁìÈ¡ÈÎÎñ´ÎÊı´óÓÚµÈÓÚ1
    local task = {
        { "Tu luyÖn th­êng", "yes3"; show = 0 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "Yes_Double1"; show = 0 }, --Ë«±¶ÊÕ·Ñ
    }
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    if (times < 5) then
        task[1].show = 1
    end

    if (times < 4) then
        task[2].show = 1
    end

    SayTask("H« Tiªn th¸p mçi ngµy chØ cã thÓ më 1 lÇn, nÕu muèn më thªm cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Kim Nguyªn B¶o <c>, ta sÏ gióp ng­¬i më thªm lÇn n÷a. NÕu ng­¬i muèn cã ®­îc nh©n ®«i phÇn th­ëng, chØ cÇn cung cÊp <c=yel>2 Tru Tµ KiÕm<c> hoÆc <c=yel>" .. (Cfs * 2) .. "<c> tiÒn ®ång.", task)
end

function yes2()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)                --Òª¿Û³ıµÄÍ­Ç®¸öÊı

    local temp = GetTaskByte(task_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 311, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) > 0) then
        DelNormalItem(8, 516, 2, 0)
        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 1 Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(95)
        Msg2Player("B¹n tÆng cho N÷ Oa " .. Cfs .. " TiÒn ®ång")

    else
        Talk(1, "no", "Muèn më thªm lÇn n÷a cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " tiÒn §ång<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return

    end

    for i = 1, BeadNumber do
        --¼õµôÂüÍÓÂŞ»ª
        DelNormalItem(3, 311, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)                    --±íÊ¾ÒÑ½ÓÈÎÎñ
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)                --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
    SetTaskByte(task_renwu, 4, 0)

    --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
    --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end
    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    AddEventItem(210)                            --?»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
    Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p më phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
    TaskNote(1026, 0, "TrÊn ma ph­ín")
end

function yes3()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)            --Òª¿Û³ıµÄÍ­Ç®¸öÊı

    local temp = GetTaskByte(task_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 312, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) > 0) then
        DelNormalItem(8, 516, 2, 0)
        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 1 Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(95)                                    --¿Û³ıÍ¨±¦
        Msg2Player("B¹n tÆng cho N÷ Oa" .. Cfs .. " TiÒn ®ång")

    else
        Talk(1, "no", "Muèn më thªm lÇn n÷a cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " tiÒn §ång<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return

    end

    for i = 1, BeadNumber do
        --¼õµôÂüÖéÉ³»ª
        DelNormalItem(3, 312, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)                    --±íÊ¾ÒÑ½ÓÈÎÎñ
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)                --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
    SetTaskByte(task_renwu, 4, 0)

    --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
    --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end
    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    AddEventItem(211)                            --»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
    Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p më phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
    TaskNote(1026, 1, "To¶ Tiªn bµi")

end

function getExp()
    --?È¡µÃ¾­ÑéµÄº¯Êı
    local experience
    local monsterNum = GetTaskByte(task_renwu, 3)
    local level = GetPlayerExtLevel()
    local completenums = GetTask(totleNumber)
    local exp1 = 0--¶îÍâ½±Àø
    if (completenums >= 420) then
        exp1 = 5000 * level
    elseif (completenums >= 20) then
        exp1 = floor(floor(completenums / 20) ^ 0.75 * 5) * 100 * level
    end

    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    if (monsterNum == 0) then
        experience = level * 4800        --¸øÓèĞŞÎªÓÃyel±êÇ©
    elseif (monsterNum <= 4) then
        experience = level * 3600        --¸øÓèĞŞÎªÓÃred±êÇ©
    elseif (monsterNum <= 8) then
        experience = level * 3000        --¸øÓèĞŞÎªÓÃgreen±êÇ©
    else
        experience = level * 2500
    end

    --½±Àø·­±¶
    if (GetTaskByte(killTimes, 3) == 1) then
        return (experience + exp1) * 2
    else
        return experience + exp1
    end
    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end
end

function Bonus()
    CloseDialog()
    if (GetTaskByte(task_renwu, 4) == 1) then
        local today = floor(LocalSystemTime() / 86400)
        local acceptDay = GetTask(task_acceptDay)
        local experience = getExp()
        local monsterNum = GetTaskByte(task_renwu, 3)        --Ê£Óà¹ÖÎïµÄ¸öÊı
        if (today ~= acceptDay) then
            SetTaskByte(task_renwu, 2, 0)                      --½»ÍêÈÎÎñ£¬ÈÎÎñ´ÎÊıÇåÁã   
            SetTask(task_acceptDay, today)
            offlineTotimes()
        end
        SetTaskByte(task_renwu, 1, 0)                       --Í¬Ò»ÌìÄÚ£¬ÈÎÎñ´ÎÊı²»ÓÃÇåÁã
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        local completenums = GetTask(totleNumber) + 1

        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
        if (GetTaskByte(killTimes, 3) == 1) then
            completenums = completenums + 1
        end
        --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

        SetTask(totleNumber, completenums) --ÀÛ¼ÆÍê³É´ÎÊı

        local nFactExp = AddOwnExtendExp(experience)      --¸ù¾İËùÊ£¹ÖÎï¸öÊı¼Ó¾­Ñé
        if (monsterNum == 0) then
            Talk(1, "no", "Lµm tèt l¾m! §©y lµ phÇn th­ëng <c=yel>" .. nFactExp .. "<c> tu luyÖn")    --ÏÔÊ¾µÄÊ±ºò¸øÓèÒ»¸öÌáÊ¾£¬ÌáÊ¾Íæ¼Ò»¹ÓĞ¶àÉÙÖ»Ã»ÓĞ³¬¶È
            KsgTask:OnFinish(task_renwu)
        elseif (monsterNum <= 4) then
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng <c=r>" .. nFactExp .. "<c> tu luyÖn")    --ÏÔÊ¾µÄÊ±ºò¸øÓèÒ»¸öÌáÊ¾£¬ÌáÊ¾Íæ¼Ò»¹ÓĞ¶àÉÙÖ»Ã»ÓĞ³¬¶È
        elseif (monsterNum <= 8) then
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng <c=g>" .. nFactExp .. "<c> tu luyÖn")    --ÏÔÊ¾µÄÊ±ºò¸øÓèÒ»¸öÌáÊ¾£¬ÌáÊ¾Íæ¼Ò»¹ÓĞ¶àÉÙÖ»Ã»ÓĞ³¬¶È
        else
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng" .. nFactExp .. " tu luyÖn")            --ÏÔÊ¾µÄÊ±ºò¸øÓèÒ»¸öÌáÊ¾£¬ÌáÊ¾Íæ¼Ò»¹ÓĞ¶àÉÙÖ»Ã»ÓĞ³¬¶È
        end
        Msg2Player("NhËn ®­îc" .. nFactExp .. " tu luyÖn")
        TaskNote(1026, -1)
    end
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
    local m = 2000 * GetPlayerExtLevel() --»ùÊı2000*lv
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) then
        --µÚÒ»´Î½ÓÈÎÎñ
        if (HaveNormalItem(3, 311, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                --¼õµôÂüÍÓÂŞ»ª
                DelNormalItem(3, 311, 0, 0)
            end

            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end

            Pay(apm)
            SetTaskByte(task_renwu, 1, 1)                      --±íÊ¾ÒÑ½ÓÈÎÎñ
            SetTaskByte(task_renwu, 2, temp)
            SetTaskWord(task_renwu, 2, 0)--log¼ÇÂ¼¸Ä°æ--Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã

            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
            SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

            AddEventItem(210)                      --»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
            Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p më phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
            Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
            Msg2Player("B¹n nhËn ®­îc TrÊn ma ph­ín, h«m nay b¹n ®· tİch lòy ­u ®·i rêi m¹ng lÇn thø " .. addtimes .. ".")
            TaskNote(1026, 0, "TrÊn ma ph­ín")
        else
            Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        end
    else
        Talk(1, "no", " Ng­¬i kh«ng ®ñ b¹c!")
    end
end

function yes_freefsb1()
    CloseDialog()
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) then
        --µÚÒ»´Î½ÓÈÎÎñ	
        if (HaveNormalItem(3, 312, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                --¼õµôÂüÖéÉ³»ª
                DelNormalItem(3, 312, 0, 0)
            end

            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end

            SetTaskByte(task_renwu, 1, 1)                      --±íÊ¾ÒÑ½ÓÈÎÎñ
            SetTaskByte(task_renwu, 2, temp)
            SetTaskWord(task_renwu, 2, 0)--log¼ÇÂ¼¸Ä°æ--Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã

            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
            SetTaskByte(killTimes, 3, 0)                    --±íÊ¾ÁìÈ¡µ¥±¶ÈÎÎñ
            --Add by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

            Pay(apm)

            AddEventItem(211)                --?»ñµÃ¿ªÆô·âËşµÄµÀ¾ß
            Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p më phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
            Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
            Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, h«m nay b¹n ®· tİch lòy ­u ®·i rêi m¹ng lÇn thø " .. addtimes .. ".")
            TaskNote(1026, 1, "To¶ Tiªn bµi")
        else
            Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        end
    else
        Talk(1, "no", " Ng­¬i kh«ng ®ñ b¹c!")
    end
end

-- Add By gaojingwei for ÈÎÎñ´ÎÊıÓÅ»¯ begin
function Yes_Double()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    local temp = GetTaskByte(task_renwu, 2) + 2
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 311, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) >= 2) then
        DelNormalItem(8, 516, 2, 0)
        DelNormalItem(8, 516, 2, 0)

        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 2 thanh Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) and (HaveNormalItem(8, 516, 2, 0) >= 1) then
        DelNormalItem(8, 516, 2, 0)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa 1 Tru Tµ KiÕm vµ " .. Cfs .. " TiÒn ®ång")

    elseif (GetCoin() >= 2 * Cv) then
        CostCoinByIdx(95)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa" .. (Cfs * 2) .. " TiÒn ®ång")

    else
        Talk(1, "no", " Muèn më tiÕp cÇn cã 2 <c=g>Tru Tµ KiÕm hoÆc " .. (Cfs * 2) .. " tiÒn §ång<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return
    end

    for i = 1, BeadNumber do
        --¼õµôÂüÍÓÂŞ»ª
        DelNormalItem(3, 311, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)                    --±íÊ¾ÒÑ½ÓÈÎÎñ
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)                    --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 1)                    --±íÊ¾ÁìÈ¡Ë«±¶ÈÎÎñ

    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end
    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    AddEventItem(210)
    Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p më phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
    TaskNote(1026, 0, "TrÊn ma ph­ín")
end

function Yes_Double1()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)            --Òª¿Û³ıµÄÍ­Ç®¸öÊı

    local temp = GetTaskByte(task_renwu, 2) + 2
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 312, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) >= 2) then
        DelNormalItem(8, 516, 2, 0)
        DelNormalItem(8, 516, 2, 0)

        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 2 thanh Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) and (HaveNormalItem(8, 516, 2, 0) >= 1) then
        DelNormalItem(8, 516, 2, 0)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa 1 Tru Tµ KiÕm vµ " .. Cfs .. " TiÒn ®ång")

    elseif (GetCoin() >= 2 * Cv) then
        CostCoinByIdx(95)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa" .. (Cfs * 2) .. " TiÒn ®ång")

    else
        Talk(1, "no", " Muèn më tiÕp cÇn cã 2 <c=g>Tru Tµ KiÕm hoÆc " .. (Cfs * 2) .. " tiÒn §ång<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return
    end

    for i = 1, BeadNumber do
        --¼õµôÂüÖéÉ³»ª
        DelNormalItem(3, 312, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)                    --±íÊ¾ÒÑ½ÓÈÎÎñ
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)                    --Ê£Óà¹ÖÎïµÄ¸öÊıÇåÁã
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 1)                    --±íÊ¾ÁìÈ¡Ë«±¶ÈÎÎñ

    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ begin
    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end
    --Edit by gaojingwei 0715 for ÈÎÎñ´ÎÊıÓÅ»¯ end

    AddEventItem(211)                            --»ñµÃ¿ªÆô·âËşµÄµÀ¾ß

    Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p më phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø" .. times .. ".")
    TaskNote(1026, 1, "To¶ Tiªn bµi")
end
-- Add By gaojingwei for ÈÎÎñ´ÎÊıÓÅ»¯ end

-- Add By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 Begin
Task_GatherStone = {
    taskID = 1740,
    taskGlobalV = { 602 },
    npcInfo = {
        { name = "§iÓm th¨m dß", templateID = 1870, script = "\\script\\»î¶¯½Å±¾\\¿±²âµã.lua", existTime = 5400 },
        { name = "§¬n S¾c ThÇn Th¹ch", templateID = 1871, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "Song S¾c ThÇn Th¹ch", templateID = 1872, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "Tam S¾c ThÇn Th¹ch", templateID = 1873, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "V« Dông Ngoan Th¹ch", templateID = 1874, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 30 },
    },
    globalName = { "Stone_Number", "Total_PerCamp", "Score_PerCamp", "God_CampName", "God_CampScore", "Magic_CampName", "Magic_CampScore" },
    itemInfo = {
        { 3, 1144, 0, "§¬n S¾c ThÇn Th¹ch", 1008, 1 },
        { 3, 1145, 0, "Song S¾c ThÇn Th¹ch", 189, 3 },
        { 3, 1146, 0, "Tam S¾c ThÇn Th¹ch", 63, 15 },
    },
    rewards_Info = {
        { 1, 30, 15 },
        { 31, 45, 45 },
        { 46, 60, 167 },
        { 61, 80, 167 },
    },
}

God_CampPlayer = {}
Magic_CampPlayer = {}

function PreGather_Stone()
    local tasks = {
        { "Nép thÇn th¹ch", "Gather_Stone"; show = 0 },
        { "KiÓm tra thÇn th¹ch t¹o ra ", "Gather_StoneNumber"; show = 0 },
        { "Giíi thiÖu ho¹t ®éng", "Gather_Introduction"; show = 1 },
        { "B¶ng xÕp h¹ng", "Gather_Top"; show = 1 },
    }

    -- Add By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 Begin
    if (GetPlayerExtLevel() >= 1 and IsPartyTime() == 1) then
        if (Is_HaveStone() > 0) then
            tasks[1].show = 1
        end
        tasks[2].show = 1
    end
    if (Is_HaveStone() == 0) then
        TaskNote(1624, -1)
    end
    -- Add By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 End

    SayTask("Kh«ng biÕt ®Õn bao giê cuéc chiÕn Th­¬ng Chu nµy míi chÊm døt ®©y!", tasks)
end

function Gather_Stone()
    CloseDialog()
    local itemInfo = Task_GatherStone.itemInfo
    local nIndex = Is_HaveStone()
    if (nIndex > 0 and IsPartyTime() == 1) then
        local nStone = IsExistItem(itemInfo[nIndex][1], itemInfo[nIndex][2], itemInfo[nIndex][3], 0)
        MsgBox("Ch¾c ng­¬i biÕt r»ng n¬i nµy lµ m¶nh vì cña BÊt Chu S¬n nªn cã mét İt thÇn th¹ch, nh­ng kh«ng ph¶i lµ bÊt tËn, ta còng ph¶i tíi tr­íc ®Ó thu nhÆt, ng­¬i nªn tranh thñ thêi gian ®Õn thu nhÆt thªm lÇn n÷a, ®ång ı giao nép thÇn th¹ch?", "Yes_GatherStone", "no")
    end
    refreshNpcTaskState()
end

function Yes_GatherStone()
    CloseDialog()
    local itemInfo = Task_GatherStone.itemInfo
    local nIndex = Is_HaveStone()
    if (nIndex > 0 and IsPartyTime() == 1) then
        local nStone = IsExistItem(itemInfo[nIndex][1], itemInfo[nIndex][2], itemInfo[nIndex][3], 0)
        local rewards_Info = Task_GatherStone.rewards_Info
        local nExtExp = 0
        local nLevel = GetPlayerExtLevel()
        for i = 1, getn(rewards_Info) do
            if (nLevel >= rewards_Info[i][1] and nLevel <= rewards_Info[i][2]) then
                if (nLevel > 60) then
                    nLevel = 60
                end
                nExtExp = nLevel * rewards_Info[i][3] * nStone * itemInfo[nIndex][6]
            end
        end
        for i = 1, nStone do
            ClearItem(itemInfo[nIndex][1], itemInfo[nIndex][2], itemInfo[nIndex][3], 0)
        end

        AddOwnExtendExp(nExtExp)
        ScrollMessage("B¹n nh©n ®­îc" .. nExtExp .. " tu luyÖn")
        Msg2Player("B¹n nh©n ®­îc" .. nExtExp .. " tu luyÖn")
        TaskNote(1624, -1)
        WriteLog(GetName() .. "§· giao " .. nStone .. "." .. itemInfo[nIndex][4])
        Talk(1, "no", "Ng­¬i ®· giao <c=y>" .. nStone .. "<c> <c=g>" .. itemInfo[nIndex][4] .. "<c>, nhËn ®­îc <c=y>" .. nExtExp .. "<c> tu luyÖn")

        local H, M, S = GetHMS()
        if (H == 21) or (H == 22 and M <= 30) then
            -- ¼ÇÂ¼»î¶¯ĞÅÏ¢
            local nScore = nStone * itemInfo[nIndex][6]
            Load_PlayerTop()
            Insert_PlayerTop(nScore)
            Save_PlayerTop()

            -- ¼ÇÂ¼¸÷ÕóÓªµÄ×Ü·ÖÊı
            local nCampType = GetJusticEvilCredit()
            if (nCampType > 0) then
                local nTotal_Score = LoadIniInteger(Task_GatherStone.globalName[3], 1) + nScore
                SaveIniInteger(Task_GatherStone.globalName[3], 1, nTotal_Score)
            elseif (nCampType < 0) then
                local nTotal_Score = LoadIniInteger(Task_GatherStone.globalName[3], 2) + nScore
                SaveIniInteger(Task_GatherStone.globalName[3], 2, nTotal_Score)
            end
        end
    end
    refreshNpcTaskState()
end

function Gather_Introduction()
    CloseDialog()
    refreshNpcTaskState()
    Talk(4, "Next_Introduction", "Mçi <c=y> thø 7, chñ nhËt<c> vµo lóc <c=g>21:00-22:30<c>, ng­êi ch¬i <c=y>Tiªn Ma Giíi<c> cã thÓ ®Õn <c=y>BÊt Chu Thiªn quan<c> thu thËp thÇn th¹ch, giao cho ta sÏ nhËn ®­îc phÇn th­ëng t­¬ng øng. Khi sè ng­êi tham gia vµo 2 phe Tiªn Ma v­ît qu¸ <c=y>10<c> ng­êi sÏ nhËn ®­îc phÇn th­ëng thªm.", "Kh«ng giíi h¹n sè lÇn thu thËp trong thêi gian ho¹t ®éng. Cïng mét lóc th× hµnh trang chØ cã thÓ chøa mét lo¹i thÇn th¹ch. ThÇn th¹ch gåm 3 lo¹i: <c=g>§¬n S¾c ThÇn Th¹ch<c>, <c=g>Song S¾c ThÇn Th¹ch<c>, <c=g>Tam S¾c ThÇn Th¹ch<c>.", "<c=g>§¬n S¾c ThÇn Th¹ch<c> cã thÓ tù thu thËp, <c=g>Song S¾c ThÇn Th¹ch<c> cÇn tæ ®éi <c=y>2<c> hoÆc <c=y>3<c> ng­êi thu thËp, <c=g>Tam S¾c ThÇn Th¹ch<c> cÇn ph¶i tæ ®éi <c=y>3<c>ng­êi míi cã thÓ thu thËp.")
end

-- Add By Zhang Jin for ÌáÊ¾ÓÅ»¯ at 2010-12-30 Begin
function Next_Introduction()
    CloseDialog()
    refreshNpcTaskState()
    local str_Success = "3 ng­êi ®Çu tiªn cña phe th¾ng sÏ nhËn ®­îc 1 <c=g>Tinh Th¸i Qu¸i Phï<c>, 3 <c=g>Vi Quang Qu¸i Phï<c>, 2 <c=g>Vi Quang Qu¸i Phï<c>, ng­êi ch¬i cßn l¹i sÏ nhËn ®­îc <c=y>20 v¹n<c> tiÒn vµng."
    local str_Fail = "3 ng­êi ®Çu tiªn cña phe thua (hoÆc khi ®iÓm tİch luü cña 2 phe b»ng nhau) nhËn ®­îc 3 <c=g>Vi Quang Qu¸i Phï<c>, 2 <c=g>Vi Quang Qu¸i Phï<c>, 1 <c=g>Vi Quang Qu¸i Phï<c>, ng­êi ch¬i cßn l¹i sÏ nhËn ®­îc <c=y>10 v¹n<c> tiÒn vµng."
    local str_tmp = "Ngoµi ra, ®Ó c¶m ¬n sù gióp ®ì cña c¸c vŞ h¶o h÷u, khi 2 phe Tiªn Ma <c=y>cã 10 ng­êi<c> trë lªn tham gia thu thËp hÇn th¹ch, ta sÏ dïng phe lµm ®¬n vŞ ghi chĞp 1 b¶ng xÕp h¹ng cèng hiÕn, ®Ó trao phÇn th­ëng."

    Talk(3, "no", str_tmp, str_Success, str_Fail)
end
-- Add By Zhang Jin for ÌáÊ¾ÓÅ»¯ at 2010-12-30 End

function Gather_StoneNumber()
    CloseDialog()
    local nSingle = 1008 - LoadIniInteger(Task_GatherStone.globalName[1], 1)
    local nDouble = 189 - LoadIniInteger(Task_GatherStone.globalName[1], 2)
    local nThree = 63 - LoadIniInteger(Task_GatherStone.globalName[1], 3)
    refreshNpcTaskState()
    Talk(1, "no", "S¶n l­îng c¸c lo¹i thÇn th¹ch d­ ra: \n<c=g>§¬n S¾c ThÇn Th¹ch<c>: <c=y>" .. nSingle .. "<c>; \n<c=g>Song S¾c ThÇn Th¹ch<c>: <c=y>" .. nDouble .. "<c>; \n<c=g>Tam S¾c ThÇn Th¹ch<c>: <c=y>" .. nThree .. "<c>; ")
end

function Is_HaveStone()
    local itemInfo = Task_GatherStone.itemInfo
    for i = 1, 3 do
        if (IsExistItem(itemInfo[i][1], itemInfo[i][2], itemInfo[i][3], 0) > 0) then
            return i
        end
    end
    return 0
end

function IsPartyTime()
    local H, M, S = GetHMS()
    if (GetWeekDay() == 6 or GetWeekDay() == 7) and (H >= 21 and H <= 23) then
        return 1
    end
    return 0
end

function Load_PlayerTop()
    local str_Name = ""
    local Interval = 0
    local tmp_Item = {}
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)

    if (nGod_CampTop > 0) then
        for i = 1, nGod_CampTop do
            str_Name = LoadIniString(Task_GatherStone.globalName[4], i)
            Interval = LoadIniInteger(Task_GatherStone.globalName[5], i)
            tmp_Item = { str_Name, Interval }
            God_CampPlayer[i] = tmp_Item
        end
    end

    if (nMagic_CampTop > 0) then
        for i = 1, nMagic_CampTop do
            str_Name = LoadIniString(Task_GatherStone.globalName[6], i)
            Interval = LoadIniInteger(Task_GatherStone.globalName[7], i)
            tmp_Item = { str_Name, Interval }
            Magic_CampPlayer[i] = tmp_Item
        end
    end
end

function Save_PlayerTop()
    local str_Name = ""
    local Interval = 0
    local tmp_Item = {}
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)

    if (nGod_CampTop > 0) then
        for i = 1, nGod_CampTop do
            SaveIniString(Task_GatherStone.globalName[4], i, God_CampPlayer[i][1])
            SaveIniInteger(Task_GatherStone.globalName[5], i, God_CampPlayer[i][2])
        end
    end

    if (nMagic_CampTop > 0) then
        for i = 1, nMagic_CampTop do
            SaveIniString(Task_GatherStone.globalName[6], i, Magic_CampPlayer[i][1])
            SaveIniInteger(Task_GatherStone.globalName[7], i, Magic_CampPlayer[i][2])
        end
    end
end

function Insert_PlayerTop(nScore)
    local nCampType = GetJusticEvilCredit()
    local name = GetName()
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    if (nCampType > 0) then
        if (nGod_CampTop > 0) then
            for i = 1, nGod_CampTop do
                local nOldScore = God_CampPlayer[i][2] + nScore
                if (name == God_CampPlayer[i][1]) then
                    God_CampPlayer[i] = { name, nOldScore }
                    return i
                end
            end
        end
        God_CampPlayer[nGod_CampTop + 1] = { name, nScore }
        SaveIniInteger(Task_GatherStone.globalName[2], 1, nGod_CampTop + 1)
    elseif (nCampType < 0) then
        if (nMagic_CampTop > 0) then
            for i = 1, nMagic_CampTop do
                local nOldScore = Magic_CampPlayer[i][2] + nScore
                if (name == Magic_CampPlayer[i][1]) then
                    Magic_CampPlayer[i] = { name, nOldScore }
                    return i
                end
            end
        end
        Magic_CampPlayer[nMagic_CampTop + 1] = { name, nScore }
        SaveIniInteger(Task_GatherStone.globalName[2], 2, nMagic_CampTop + 1)
    end
    return 0
end

function Gather_Top()
    CloseDialog()
    Load_PlayerTop()
    Sort_CampTop()
    local nTotal_GodScore = LoadIniInteger(Task_GatherStone.globalName[3], 1)
    local nTotal_MagicScore = LoadIniInteger(Task_GatherStone.globalName[3], 2)
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    local str_GodTop = ""
    local str_Success = "N÷ Oa n­¬ng n­¬ng: "
    local str_MagicTop = ""
    local str_Fail = "N÷ Oa n­¬ng n­¬ng: "
    local str_CampName = "Tiªn ph¸i"
    local str_tmp = "HiÖn t¹i, sè ng­êi tham gia cña <c=g>Tiªn ph¸i<c> lµ <c=y>" .. nGod_CampTop .. "<c> ng­êi, sè ng­êi cña <c=g>Ma ph¸i<c> lµ <c=y>" .. nMagic_CampTop .. "<c> ng­êi, ®iÓm tİch luü"

    if (nGod_CampTop > 0) then
        str_GodTop = "3 ng­êi ®øng ®Çu cña <c=g>Tiªn ph¸i<c> nh­ sau:\n"
        for i = 1, nGod_CampTop do
            if (i > 3) then
                break
            end
            str_GodTop = str_GodTop .. "Thiªn C­¬ng ¶nh thø" .. i .. "trong ngµy, ®¸nh b¹i ®èi thñ:" .. God_CampPlayer[i][1] .. " " .. "§iÓm sè:" .. God_CampPlayer[i][2] .. " Phót\n"
        end
    end
    if (nMagic_CampTop > 0) then
        str_MagicTop = "3 ng­êi ®øng ®Çu cña <c=g>Ma ph¸i<c>nh­ sau: \n"
        for i = 1, nMagic_CampTop do
            if (i > 3) then
                break
            end
            str_MagicTop = str_MagicTop .. "Thiªn C­¬ng ¶nh thø" .. i .. "trong ngµy, ®¸nh b¹i ®èi thñ:" .. Magic_CampPlayer[i][1] .. " " .. "§iÓm sè:" .. Magic_CampPlayer[i][2] .. " Phót\n"
        end
    end

    if nMagic_CampTop > 0 and nTotal_MagicScore > 0 and nTotal_GodScore <= nTotal_MagicScore then
        str_CampName = "Ma ph¸i"
        str_Success = str_Success .. str_MagicTop
        str_Fail = str_Fail .. str_GodTop
        str_tmp = str_tmp .. "<c=g>" .. str_CampName .. "<c> t¹m thêi dÉn tr­íc, tæng ®iÓm nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    elseif (nGod_CampTop > 0 and nTotal_GodScore > 0 and nTotal_GodScore > nTotal_MagicScore) then
        str_Success = str_Success .. str_GodTop
        str_Fail = str_Fail .. str_MagicTop
        str_tmp = str_tmp .. "<c=g>" .. str_CampName .. "<c> t¹m thêi dÉn tr­íc, tæng ®iÓm nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    elseif (nTotal_MagicScore == nTotal_GodScore) then
        str_Success = str_Success .. str_GodTop
        str_Fail = str_Fail .. str_MagicTop
        str_tmp = str_tmp .. "Hai phe thÕ lùc ngang b»ng nhau, ®iÓm sè nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    end

    if (nMagic_CampTop > 0) and (nGod_CampTop > 0) then
        Talk(3, "no", str_tmp, str_Success, str_Fail)
    elseif (nMagic_CampTop == 0) and (nGod_CampTop == 0) then
        Talk(1, "no", str_tmp)
    elseif (nMagic_CampTop > 0) and (nGod_CampTop == 0) then
        Talk(2, "no", str_tmp, str_Success)
    elseif (nMagic_CampTop == 0) and (nGod_CampTop >= 0) then
        Talk(2, "no", str_tmp, str_Success)
    end
end

function Sort_CampTop()
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    local nTmp = {}

    if (nGod_CampTop > 1) then
        for i = nGod_CampTop - 1, 1, -1 do
            for j = 1, i do
                if (God_CampPlayer[j][2] < God_CampPlayer[j + 1][2]) then
                    nTmp = God_CampPlayer[j]
                    God_CampPlayer[j] = God_CampPlayer[j + 1]
                    God_CampPlayer[j + 1] = nTmp
                end
            end
        end
    end

    if (nMagic_CampTop > 1) then
        for i = nMagic_CampTop - 1, 1, -1 do
            for j = 1, i do
                if (Magic_CampPlayer[j][2] < Magic_CampPlayer[j + 1][2]) then
                    nTmp = Magic_CampPlayer[j]
                    Magic_CampPlayer[j] = Magic_CampPlayer[j + 1]
                    Magic_CampPlayer[j + 1] = nTmp
                end
            end
        end
    end
end
-- Add By Zhang Jin for ²ÉÊ¯Á¶É½ at 2010-11-22 End
