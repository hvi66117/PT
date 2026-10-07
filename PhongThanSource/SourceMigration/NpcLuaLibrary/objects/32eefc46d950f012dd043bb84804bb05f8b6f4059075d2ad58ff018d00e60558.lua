Include("\\script\\gvn\\lib.lua")
--description: ·çÁÖ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13
--modify:Ò¦ê¿
--data:2007.3.28

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-14

--958  1byte½ñÌì½ÓµÄÈÎÎñÊı 2byte ÄÉ²Æ´ÎÊıÖÃ×Ü´ÎÊı£¬3byteÖÃÄÉ²Æµ±Ç°Ğ¡»·Êı 4byteµ¥±¶»¹ÊÇË«±¶¸¶·Ñ
--959:  1jie, 2wan,
--1010	1money, 2qingtong, 3renqi,4suipian
--957:  1£¬½ÓÁ¸³µµÄÊ±¼ä£¬ 2 ½ÙÁ¸³µµÄÊ±¼ä£¬ Ê±¼ä¶¼ÊÇmod(£¬256), 3Î±×°³µÊ±¼ä
--1032 ÔËËÍÁ¸âÃÃ¿ÈÕÈÎÎñ´ÎÊı¼ÇÂ¼
--1052 Î±×°µÄÁ¸âÃ³µ,1 =jie,
Task_Lucky = 1228 -- »ñµÃÂÌÉ«±êÇ©µÄĞÒÔËÖµÀÛ¼ÆÖµ,0ÎªµÚÒ»´Î,ÒÔºó¶¼ÊÇ·ÇÁã(1,1000)
Task_LuckyTime = 1230 -- »ñµÃÂÌÉ«±êÇ©µÄĞÒÔËÖµÀÛ¼ÆÖµ´ÎÊı
Global_Lucky = 161 -- È«ÇøÀÛ¼ÆÔË³µÊı
Global_fakeCarlimit = 170--¼Ù³µÈ«Çø×ÜÊı£¬
Global_fakeCarday = 171  -- ¼Ù³µÊ±¼ä´Á
--add by wingber 2009.10.8¹ú¼Ò¾ü×Ê³µ
Task_junzijingsai = 1567    --1byteÎª×ÊÔ´ÀàĞÍ£¨1=Ä¾²Ä¡¢2=ĞşÌú¡¢3=ÏãÁÏ¡¢4=»Æ½ğ¡¢5=ÇàÍ­£©;2byte ÁÙÊ±¼ÇÂ¼ÀàĞÍ£¬Ò»´ÎÖ»ÄÜÁìÒ»Á¾³µ£¬ËùÒÔÁìÈ¡³µµÄÊ±¼ä¹«ÓÃ

resource_kind = { { "H­¬ng liÖu", "Hinh H­¬ng Lam" }, { "Gç", "ThÇn Méc" }, { "ThiÕt", "HuyÒn ThiÕt §Ønh" }, { "vµng", "Hoµng Kim Chung" }, { "§ång thau", "" } }    --add by wingber 2009.10.8¹ú¼Ò¾ü×Ê³µ
car_maps = {
    { mapid = 15, x = 1555, y = 3378, r = 4 },
    { mapid = 15, x = 1548, y = 3369, r = 6 },
    { mapid = 15, x = 1560, y = 3379, r = 4 },
}

-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
Card_Item = {
    [1] = { 8, 1316, 6, "ThÎ Kim DËt" },
    [2] = { 8, 1317, 2, "ThÎ Cµo" },
}
-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End

-- AS GaoJingwei at 090728
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

    --Î×¹ÆÖ®¶¾
    startLevel = 28
    if (GetLevel() >= startLevel) then
        local wg2 = GetTask(1353)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
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

    --¾Æ²»×íÈË
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
-- AE GaoJingwei at 090728 end

function main()
    local liangxiangStr = "VËn l­¬ng"

    if (GetLevel() >= 130) and (GetTask(1032) >= 500) then
        liangxiangStr = "<c=pk>VËn l­¬ng<c>"
    elseif (GetLevel() >= 85) and (GetTask(1032) >= 180) then
        liangxiangStr = "<c=g>VËn l­¬ng<c>"
    end
    tasks = {
        { "BÊt Tóy", "renwu1"; show = 0 },
        { liangxiangStr, "renwu2"; show = 0 },
        { "Xe l­¬ng gi¶", "renwu3"; show = 0 },
        { "Vµo s¬n cèc", "come"; show = 1 },
        { "§éc Cæ", "wugu2"; show = 0 },
        { "Qu©n nhu", "armyresource"; show = 0 }, --add by wingbear 2009.10.8
    }
    --add by wingbear 2009.10.8
    local H, M, S = GetHMS()
    local lvl = GetOwnCityLevel() + 1
    if H >= 18 and H < 23 and lvl > 0 then
        tasks[6].show = 1
    end

    UTask_Druid = GetTask(2);
    if (GetPlayerType() == 2) and (GetLevel() >= 35) and (UTask_Druid == 10) then
        tasks[1].show = 1
    end ;

    if (GetTask(1052) ~= 0) then
        tasks[3].show = 1
    elseif (GetTask(959) ~= 0) then
        tasks[2].show = 1
    else
        tasks[2].show = 1
        tasks[3].show = 1
    end

    if (GetTask(1353) == 1) then
        tasks[5].show = 1
    end

    SetTask(142, GetNpcID(DialogNpcIdx)) --±£´æÍæ¼Ò¶Ô»°µÄnpcId
    SayTask(10348, tasks)
end;

function wugu2()
    if (GetTask(1353) == 1) then
        Talk(2, "no", ",<c=r>B¸ch Niªn Gi¸p Cèt<c> ®­îc <c=r>Gi¸p Cèt<c> t«n lµ thñ lÜnh, liªn tôc tiªu diÖt <c=r>Gi¸p Cèt<c>, h¾n sÏ hiÖn th©n.", GetName() .. " §a t¹ ®· t­¬ng trî!")
        SetTask(1353, 2)
        TaskNote(201, 1)
        AddOwnExp(3000)
        TopMessage("NhËn ®­îc 3000 ®iÓm kinh nghiÖm")
        refreshNpcTaskState()
    end
end

function fangchenmi()
    --if  it return 0, the 5-hour limit rules executed
    local state
    local mark
    --	if  you don't want this function executed then	you can set state equal to zero
    --		state=0
    --	else
    state = GetWeakState()    --state=0, not in limited time; state=1, in 3 hours-limit; state=2, in 5 hours limit
    --	end
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
    NewWorld(15, 1687, 3106)--´«ËÍ½ø?É½¹È
    SetTask(2, 11)
    TaskNote(29, 3)
    Msg2Player("Vµo s¬n cèc, cøu bän DŞ nh©n say r­îu.")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

function come()
    NewWorld(15, 1687, 3106)--´«ËÍ½ø?É½¹È
    CloseDialog()
end;

function renwu2()
    if (GetTask(959) == 2) then
        local nb = GetIBBuffTimes(267) + 1
        local bdw = GetTaskByte(958, 4)
        if (bdw >= 2) then
            nb = nb + 1
        end
        nb = min(nb, 100)
        local nTimes = nb - GetIBBuffTimes(267)
        if (GetTaskByte(958, 3) == 0) and (GetWeekDay() == 4) and (mod(floor(LocalSystemTime() / 86400), 256) == GetTaskByte(957, 1)) then
            nTimes = nTimes * 2
            Msg2Player("Chñ ®Ò nhiÖm vô h«m nay lµ VËn l­¬ng, chóc mõng b¹n nhËn ®­îc phÇn th­ëng nh©n ®«i vµ Kim Bµi danh hiÖu Gi¸p VËn Quan!")
        end
        if (nTimes <= 0) then
            Talk(1, "no", 13569)
        else
            for i = 1, nTimes do
                AddIBBuff(267)
            end

            SetTask(1032, GetTask(1032) + 1)
            Msg2Player("B¹n nhËn ®­îc" .. nTimes .. "Kim Bµi danh hiÖu Gi¸p VËn Quan!")
            Talk(1, "no", "Phong L©m:§a t¹ ng­¬i ®· gióp ®ì kŞp thêi! Ta ®Æc biÖt th­ëng cho ng­¬i <color=yellow>" .. nTimes .. "<c>danh hiÖu Kim Bµi Gi¸p VËn Quan. Nghe nãi Th¸c Th¸p Lı Thiªn V­¬ng_Lı TŞnh ®ang ban th­ëng c¸c t­íng lÜnh, ngµi sÏ dùa vµo sè lÇn tİch lòy <c=g>Kim Bµi Gi¸p VËn Quan<c> cña ng­¬i mµ ban th­ëng nhiÒu phÇn th­ëng phong phó!")
            SetTask(959, 0)
            TaskNote(64, 3)

            KsgTask:OnFinish(958)
        end
        SetTaskWord(958, 2, 0)--ÄÉ²ÆÇåÁã
    elseif (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13570)
    elseif (GetFreeNpcCount() >= 160) then
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        local LastTime = GetTaskByte(957, 1)--×îºóÒ»´Î½ÓÁ¸ÈÎÎñµÄÏµÍ³Ê±¼ä
        local playerlevel, playername, guardindex, ml
        playerlevel = GetLevel()
        playername = GetName()
        guardindex = GetTGuardIndexByPlayerName(playername)
        ml = playerlevel * 1000
        if (NowTime > (LastTime + 1830)) and (guardindex > 0) and (GetTask(959) == 1) then
            CancleCarriage(guardindex)
            guardindex = 0
        end
        if (NowTime ~= LastTime) then
            SetTask(958, 0) --d´ÎÊı
            offlineTotimes()
        end ;

        if (playerlevel < 55) then
            Talk(1, "no", 13571)
        elseif (GetCamp() == 0) then
            --¼ì²âÊÇ·ñÎªĞÂÊÖ
            Talk(1, "no", 13572)
        elseif (IsTongMember() == 0) then
            --¼ì²âÊÇ·ñÒÑ¼ÓÈë¹ú¼ÒµÄÍæ¼Ò
            Talk(1, "no", 13573)
            --elseif ( GetTeam()~=0) then				     --¼ì²âÊÇ·ñÔÚ¶ÓÎéÀï
            --		Talk(1,"no","·çÁÖ£ºÇëÀë¿ª¶ÓÎéºóÔÙÑºÁ¸âÃ°É¡£")
        elseif (guardindex > 0) then
            if (GetTask(959) == 1) then
                Talk(1, "no", 13574)
            elseif (GetTaskByte(1238, 1) == 1 and HaveIBBuff(463) > 0) then
                Talk(1, "no", 14398)
            else
                Talk(1, "no", 13575)
            end
        elseif (GetTask(60) ~= 0) then
            --¼ì²âÊÇ·ñÎªÅÜÉÌ×´Ì¬
            Talk(1, "no", 13576)
        elseif (GetCash() < ml) then
            --±íÊ¾ÊÇ·ñÒÑ¾­·¢ËÍÁËÒ»ÌËïÚ³µ
            Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn b¶o hiÓm! Ph¶i cã" .. ml .. ".")
        else
            local bb = GetTaskByte(958, 1)
            local addtimes = GetTaskByte(958, 2) + 1
            local alltimes = GetTaskByte(1477, 3)

            SetTask(959, 0)
            SetTask(1010, 0)
            TaskNote(64, -1)
            SetTaskWord(958, 2, 0)--ÄÉ²ÆÇåÁã
            --			if (bb==0)then
            --				MsgBox("·çÁÖ£ºÓĞÒ»ÌËÁ¸âÃĞèÒªÔËµ½¾øÁúÁë¸ø×Ü±øÕÅ¹ğ·¼£¬¿ÉÊÇÕâÒ»Â·¾­³£ÓĞ·ËÀà³öÃ»£¬ÇÒÎÒÕâÀïÈËÊÖÎäÒÕ²»¸ß£¬Èç¹ûÄã¿Ï°ïÎÒ³É¹¦ÔËµ½²¢ÄÃ×ÅĞÅÎï»ØÀ´£¬ÎÒ¾Í¾Ù¼öÄãÎªÔËÁ¸¹Ù¡£µ±È»£¬ÄãĞèÒª¸¶Ñº½ğ<color=green>"..ml.."<color>½ğÇ®£¬²»¹ı³ê½ğÊÇºÜ·áºñµÄÅ¶¡£ÄãÈ·¶¨ÒªÈ¥ÑºÁ¸âÃÂğ£¿","che", "no")
            --			elseif (bb < 6) or (alltimes >= addtimes)then
            local pm_free = payMoneyfree(addtimes)
            --				local task = {
            --						{"ÄÉ²ÆĞŞÁ¶","yes_freefsb";show=0},
            --						{"êûÉÍ¾üÁî", "coin_renwu"; show=0},
            --					}
            if (alltimes >= addtimes) or (bb < 6) then
                local task = {
                    { "VËn l­¬ng", "yes_normalmission"; show = 0 },
                    { "N¹pTµiTuLuyÖn", "yes_freefsb"; show = 1 },
                    { "Khao qu©n lÖnh", "coin_renwu"; show = 0 },
                    -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
                    { "ThÎ Kim DËt", "Task_MonthCard"; show = 0 },
                    -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End
                }
                if (bb == 0) then
                    task[1].show = 1
                elseif (bb < 6) then
                    task[3].show = 1
                    task[4].show = 1    -- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12
                end
                --				if (alltimes >= addtimes) then
                --					task[2].show = 1
                --				else
                --					coin_renwu()
                --					return 0
                --				end
                local retime = alltimes - addtimes + 1
                local str = "Hoan nghªnh ng­¬i sö dông <c=g>ThÎ Kim DËt<c> nhËn <c=y>nhiÖm vô chñ ®Ò trong ngµy<c>: <c=g>VËn l­¬ng<c>. <c=g>ThÎ Kim DËt<c> hµng ®Ñp gi¸ rÎ, İch lîi v« cïng!"
                if (retime > 0) then
                    SayTask("HiÖn t¹i ng­¬i tİch luü <c=r>" .. (alltimes - addtimes + 1) .. "<c> lÇn, nhiÒu h¬n sè lÇn nhËn nhiÖm vô miÔn phİ, nÕu cã" .. pm_free .. " b¹c, cã thÓ nhËn thªm nhiÖm vô, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ.NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy. §­¬ng nhiªn viÖc ®Æt cäc <c=g>" .. ml .. "<c>B¹c lµ rÊt cÇn thiÕt." .. str, task)
                else
                    SayTask("NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>. C¸ch nµy kh«ng ®ßi hái nhiÒu, chØ thu 1 sè b¹c nhÊt ®Şnh!" .. str, task)
                end
            else
                MsgBox(13577, "no")
            end
        end
    end
end;

function yes_normalmission()
    local bb = GetTaskByte(958, 1)
    local ml = GetLevel() * 1000
    if (bb == 0) then
        MsgBox("Cã mét chuyÕn l­¬ng cÇn chuyÓn ®Õn TuyÖt Long LÜnh cho Tæng binh Tr­¬ng QuÕ Ph­¬ng. §­êng ®i cã nhiÒu phØ tÆc, vâ nghÖ cña qu©n ta n¬i ®ã l¹i kh«ng cao. NÕu ng­¬i gióp ta vËn l­¬ng thµnh c«ng vµ mang tİn vËt vÒ, ta sÏ ®Ò b¹t ng­¬i lµm quan vËn l­¬ng. Nh­ng ng­¬i ph¶i ®¨t cäc tiÒn b¶o hiÓm hµng <color=green>" .. ml .. "<c> tiÒn! Nh­ng phÇn th­ëng sÏ cao kh«ng ngê ®Êy! QuyÕt ®Şnh ch­a?", "che", "no")
    end
end

-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 Begin
function Task_MonthCard()
    local task = {
        { "Tu luyÖn th­êng", "Single_Cost"; show = 1 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "Double_Cost"; show = 1 }, --Ë«±¶ÊÕ·Ñ
    }
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local str = "<c=g>NhiÖm vô chñ ®Ò trong ngµy<c> bao gåm Th¸m qu©n, NhiÖm vô S¸t thñ, Ph¸ V¹n Tiªn TrËn, §¹o cô, Siªu ®é, Thu thËp, VËn l­¬ng, Hoa thÇn bİ, Thiªn Thô, §­a th­, VËn chuyÓn, LuyÖn Tiªn ®¬n, ThÊt Qu¶i, B¨ng Háa Long Ch©u."
    SayTask("Phong L©m: " .. str .. "NÕu ng­¬i cã <c=g>" .. Cfs .. " TiÒn ®ång  (ThÎ Kim DËt)<c>, ta sÏ ph¸ lÖ cho ng­¬i vËn l­¬ng thªm lÇn n÷a. NÕu ng­¬i muèn ®­îc nh©n ®«i kinh nghiÖm tu luyÖn, chØ cÇn giao nép <c=g>" .. (Cfs * 2) .. "TiÒn ®ång  (ThÎ Kim DËt)<c>. Sao h¶?", task)
end

function Single_Cost()
    CloseDialog()
    local key1 = 0
    local bb = GetTaskByte(958, 1) + 1
    if (bb == 1) then
        key1 = ok()
        if (key1 == 1) then
            Talk(1, "no", 13578)
        elseif (key1 == 2) then
            Talk(1, "no", 14399)--ÂÌÉ«
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
        SetTaskByte(958, 4, 1)
        Msg2Player("B¹n dïng" .. Cfs .. "TiÒn ®ång , c¬ héi vËn l­¬ng")
        WriteLog(GetName() .. "Sö dông " .. Cfs .. "TiÒn ®ång  (ThÎ Kim DËt), c¬ héi vËn l­¬ng")
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe Tİm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc" .. strcolor .. " ®· <c=yel>xuÊt hiÖn</c>, <c=g>Ng­¬i chØ cã 30 ®Ó hoµn thµnh nhiÖm vô</c>!")
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

        SetTaskByte(958, 4, 2)
        Msg2Player("B¹n dïng" .. (Cfs * 2) .. "TiÒn ®ång , c¬ héi vËn l­¬ng")
        WriteLog(GetName() .. "Sö dông " .. (Cfs * 2) .. "TiÒn ®ång  (ThÎ Kim DËt), nhËn nhiÖm vô vËn l­¬ng")
    else
        MsgBox("RÊt tiÕc, ng­¬i kh«ng cã ThÎ Kim DËt hoÆc sè d­ ThÎ Kim DËt kh«ng ®ñ..", "no")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe Tİm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        local bb = GetTaskByte(958, 1)
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc" .. strcolor .. " ®· <c=yel>xuÊt hiÖn</c>, <c=g>Ng­¬i chØ cã 30 ®Ó hoµn thµnh nhiÖm vô</c>!")
    end
end
-- Add By Zhang Jin for ÈÎÎñÔÂ¿¨ at 2010-08-12 End

function coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "che"; show = 1 }, --µ¥±¶ÊÕ·Ñ
        { "Tu luyÖn nh©n ®«i", "che2"; show = 1 }, --Ë«±¶ÊÕ·Ñ
    }
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    SayTask("Quan phñ ban lÖnh:mçi ng­êi chØ cã thÓ vËn l­¬ng 1 lÇn trong ngµy. Nh­ng nÕu cã <c=g>Khao qu©n lÖnh</c> th× vÉn ®­îc rêi thµnh. NÕu ng­¬i cã <c=yel>1 Khao qu©n lÖnh</c> hoÆc tÆng ta <c=g>" .. Cfs .. "</c>tiÒn ®ång , ta sÏ ph¸ lÖ cho ng­¬i vËn l­¬ng thªm lÇn n÷a. NÕu ng­¬i muèn ®­îc nh©n ®«i kinh nghiÖm tu luyÖn, chØ cÇn giao nép <c=yel>2 Khao qu©n lÖnh<c> hoÆc <c=yel>" .. (Cfs * 2) .. "<c> TiÒn ®ång . Sao h¶?", task)
end

function no()
    CloseDialog()
end;

function che()
    CloseDialog()
    local key1 = 0
    local bb = GetTaskByte(958, 1) + 1
    if (bb == 1) then
        key1 = ok()
        if (key1 == 1) then
            Talk(1, "no", 13578)
        elseif (key1 == 2) then
            Talk(1, "no", 14399)--ÂÌÉ«
        end
        return 0
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (i ~= 0) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        CostIBItem(i)
        SetTaskByte(958, 4, 1)
        Msg2Player("B¹n ®æi 1 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng!")
    elseif (GetCoin() >= Cv) then
        key1 = ok()
        if (key1 < 1) then
            return 0
        end

        CostCoinByIdx(49)
        SetTaskByte(958, 4, 1)
        Msg2Player("B¹n dïng" .. Cfs .. "TiÒn ®ång , c¬ héi vËn l­¬ng")
    else
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ tiÒn ®ång ! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhĞ!")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe Tİm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc" .. strcolor .. " ®· <c=yel>xuÊt hiÖn</c>, <c=g>Ng­¬i chØ cã 30 ®Ó hoµn thµnh nhiÖm vô</c>!")
    end
end;

function che2()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(49)
    local nums = HaveNormalItem(8, 268, 2, 0)
    local i = FindAValidIBItem(8, 268, 2, 0)
    if (nums > 0) and (i == 0) then
        nums = 0
    end
    local mycoin = nums * Cv + GetCoin() --ÓµÓĞ×Ê²ú
    local key1 = 0

    if (mycoin >= Cv * 2) then
        if (i ~= 0) then
            if (nums >= 2) then
                key1 = ok()
                if (key1 < 1) then
                    return 0
                end

                CostIBItem(i)
                CostIBItem(FindAValidIBItem(8, 268, 2, 0))
                SetTaskByte(958, 4, 2)
                Msg2Player("B¹n ®æi 2 Khao Qu©n lÖnh lÊy 1 lÇn VËn l­¬ng")
            elseif (nums == 1) then
                key1 = ok()
                if (key1 < 1) then
                    return 0
                end

                CostCoinByIdx(49)
                CostIBItem(i)
                SetTaskByte(958, 4, 2)
                Msg2Player("B¹n dïng" .. Cfs .. "TiÒn ®ång  vµ 1 Khao Qu©n lÖnh ®æi lÊy 1 lÇn vËn l­¬ng!")
            end
        else
            key1 = ok()
            if (key1 < 1) then
                return 0
            end

            CostCoinByIdx(49)
            CostCoinByIdx(49)
            SetTaskByte(958, 4, 2)
            Msg2Player("B¹n dïng" .. (Cfs * 2) .. "TiÒn ®ång , c¬ héi vËn l­¬ng")
        end
    else
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng cã Khao qu©n lÖnh hoÆc kh«ng ®ñ tiÒn ®ång ! Ta kh«ng thÓ cho ng­¬i vËn l­¬ng, l¸t sau h·y quay l¹i nhĞ!")
        return 0
    end

    if (key1 >= 1) then
        local strcolor = "Phe Tİm"
        if (key1 == 2) then
            strcolor = "<c=g>Phe Xanh<c>"
        end
        local bb = GetTaskByte(958, 1)
        Talk(1, "no", "§©y lµ nhiÖm vô vËn l­¬ng lÇn thø <c=g>" .. bb .. "</c>. Xin h·y giao xe l­¬ng nµy cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc" .. strcolor .. " ®· <c=yel>xuÊt hiÖn</c>, <c=g>Ng­¬i chØ cã 30 ®Ó hoµn thµnh nhiÖm vô</c>!")
    end
end

-----------------Á½ÖÖ³µÖ±½Ó¸¶Í­Ç®
--function selcar()
--	local	 Cname1 , Cv1,Cfs1 =GetCostCoinInfoByIdx(55)
--	if (GetTaskByte(958,1) < 1) then
--		Say("·çÁÖ£ºÇëÌôÑ¡ÄúÒªÑºÁ¸âÃµÄ³µ×Ó£º",2,"ÆÕÍ¨Á¸âÃ³µ/putong","Ìú¼×Á¸âÃ³µ(ÉúÃüÊÇÆÕÍ¨µÄ10±¶£¬Ö±½Ó×Ô¶¯ÏûºÄÍ­Ç®"..Cfs1.."Ôª)/koutb")
--	else
--		Say("·çÁÖ£ºÇëÌôÑ¡ÄúÒªÑºÁ¸âÃµÄ³µ×Ó£º(<c=r>¸åÉÍ¾üÁî»òÍ­Ç®ÒÑ¿Û³ı£¬Çë²»Òª°´ÈÎºÎ·½Ê½µÄÈ¡Ïû¼ü£¬É÷ÖØ</c>)",2,"ÆÕÍ¨Á¸âÃ³µ/putong","Ìú¼×Á¸âÃ³µ(ÉúÃüÊÇÆÕÍ¨µÄ10±¶£¬Ö±½Ó×Ô¶¯ÏûºÄÍ­Ç®"..Cfs1.."Ôª)/koutb")
--	end
--end
--function putong()
--	Talk(1,"no", "·çÁÖ£ºÇëÄú°ÑÁ¸âÃ´ÓÃÏ½òÔË¸ø¾øÁúÁëµÄ<c=g>×Ü±øÕÅ¹ğ·¼</c>£¬Á¸âÃ³µÒÑÍ£ÔÚ<c=yel>ÄãÓÒÉÏ·½¿ÕµØÉÏ</c>£¬<c=g>ÄãÖ»ÓĞ30·ÖÖÓ£¬30·ÖÖÓºóÁ¸âÃ³µ»á×Ô¶¯ÏûÊ§</c>£¬ËÙÈ¥ËÙ»Ø¡£")
--	Msg2Player("Äã»ñµÃÆÕÍ¨Á¸âÃ³µ£¡")
--	ok(1)
--end
--function koutb()
---    local     Cname1 , Cv1,Cfs1 =GetCostCoinInfoByIdx(55)
--	if (GetCoin()>= Cv1) then
--		CostCoinByIdx(55)
--		Msg2Player("ÄãÏûºÄÁË"..Cfs1.."Í­Ç®£¬»ñµÃÌú¼×Á¸âÃ³µ£¡")
--		Talk(1,"no", "·çÁÖ£ºÇëÄú°ÑÁ¸âÃ´ÓÃÏ½òÔË¸ø¾øÁúÁëµÄ<c=g>×Ü±øÕÅ¹ğ·¼</c>£¬Ìú¼×Á¸âÃ³µÒÑÍ£ÔÚ<c=yel>ÄãÓÒÉÏ·½¿ÕµØÉÏ</c>£¬<c=g>ÄãÖ»ÓĞ30·ÖÖÓ£¬30·ÖÖÓºóÁ¸âÃ³µ»á×Ô¶¯ÏûÊ§</c>£¬ËÙÈ¥ËÙ»Ø¡£")
--		ok(2)
--	else
--		Talk(1,"no","ÕòÔª´óÏÉ£º¶Ô²»Æğ£¬ÄãµÄÍ­Ç®ÊıÁ¿<c=r>²»¹»"..Cfs1.."</c>Í­Ç®£¬ÎÒÖ»ÄÜ¸øÄã<c=g>ÆÕÍ¨Á¸Á¸âÃ³µ</c>£¡ÇëÄú°ÑÁ¸âÃ´ÓÃÏ½òÔË¸ø¾øÁúÁëµÄ<c=g>×Ü±øÕÅ¹ğ·¼</c>£¬Á¸âÃ³µÒÑÍ£ÔÚ<c=yel>ÄãÓÒÉÏ·½¿ÕµØÉÏ</c>£¬<c=g>ÄãÖ»ÓĞ30·ÖÖÓ£¬30·ÖÖÓºóÁ¸âÃ³µ»á×Ô¶¯ÏûÊ§</c>£¬ËÙÈ¥ËÙ»Ø¡£")
--		Msg2Player("ÄãµÄÓà¶î²»×ã"..Cfs1.."Í­Ç®£¬»ñµÃÆÕÍ¨Á¸âÃ³µ£¡")
--		ok(1)
--	end
--end
-------------------------------------------------------------------

function ok()
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", 13570)
        return 0
    end

    local mapid, x, y, carriageindex, playername, carriagelevel, lasttime, playerlevel
    mapid, x, y = GetWorldPos()
    x = 32 * x
    y = 32 * y

    -- add by mayining 2008.5.7
    -- ×öÁìÈ¡ïÚ³µµÄµØÍ¼À¹µ²
    if (mapid ~= 15) then
        CloseDialog()
        return 0
    end
    -- end by mayining
    local mapid2 = GetNpcWorldPos(DialogNpcIdx)
    local x2, y2 = fmapset_xy()--ĞŞ¸Äby yaoxin 2008-08-11 °ÑÂí³µÖ±½ÓÉú³Éµ½ÈËÉíÉÏ
    x2 = 32 * x2
    y2 = 32 * y2

    playerlevel = GetLevel()
    playername = GetName()
    lasttime = 1800

    local camp = 2
    local str = "Phe Tİm"
    local key = 1
    if (playerlevel >= 55) then
        local cartype = 556
        SetGlobalValue(Global_Lucky, GetGlobalValue(Global_Lucky) + 1)
        SetGlobalValue(Global_fakeCarlimit, GetGlobalValue(Global_fakeCarlimit) + 10)--ÔËÒ»´ÎÕæ³µÔö¼Ó10´Î¼Ù³µÉÏÏŞ

        if (fIsGreen(playerlevel) == 1) then
            cartype = 687
            camp = 7
            str = "<c=g>Phe Xanh<c>"
            key = 2
        end

        if (mapid2 == 0) then
            carriageindex = NewSiegeWeapon(mapid, x, y, cartype)
        else
            carriageindex = NewSiegeWeapon(mapid, x2, y2, cartype)
        end ;
    end

    carriagelevel = 1
    --ÉèÖÃïÚ³µ½Å±¾
    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\Á¸âÃ³µ.lua")
        SendCarriage(carriageindex, playername, carriagelevel, lasttime)

        --±äÕóÓª
        --Modify By GaoJingwei 20090106 for ¿Û³ı½ğÇ®ÓÅ»¯ Start
        Pay(playerlevel * 1000, 1)
        --Modify By GaoJingwei 20090106 for ¿Û³ı½ğÇ®ÓÅ»¯ End

        SetNpcCurCamp(carriagenpcindex, camp)
        SetCamp(camp)   --Rocker ĞŞ¸Ä³ÉÓÀ¾ÃÕóÓª2004-9-4 17:37
        SetCurCamp(camp)
        TaskNote(64, 1)
        if (GetTaskByte(958, 3) == 0) then
            local bd = GetTaskByte(958, 1) + 1
            Msg2Player("H«m nay lµ lÇn vËn l­¬ng thø" .. bd .. "  vËn chuyÓn xe l­¬ng. Xe l­¬ng ®· biÕn thµnh" .. str)

            if (bd >= 6) then
                SyncBibleState(64, 3, 1)
            else
                SyncBibleState(64, 2, 1)
            end
            SetTaskByte(958, 1, bd)
        end
        SetTaskByte(959, 1, 1)
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        SetTaskByte(957, 1, NowTime)
        return key
    else
        Talk(1, "no", 13570)
        return 0
    end
end;

function renwu3()
    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 13580)
    elseif (GetFreeNpcCount() >= 160) then
        local playerlevel, playername, guardindex, ml
        playerlevel = GetLevel()
        playername = GetName()
        guardindex = GetTGuardIndexByPlayerName(playername)
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        local LastTime = GetTaskByte(957, 3)--×îºóÒ»´Î½ÓÎ±×°Á¸âÃ³µÈÎÎñµÄÏµÍ³Ê±¼ä

        if (NowTime > (LastTime + 1830)) and (guardindex > 0) and (GetTask(959) == 1) then
            CancleCarriage(guardindex)
            guardindex = 0
        end

        if (guardindex > 0) then
            if (GetTask(959) == 1) then
                Talk(1, "no", 13581)
            elseif (GetTaskByte(1238, 1) == 1 and HaveIBBuff(463) > 0) then
                Talk(1, "no", 14400)
            else
                Talk(1, "no", 13582)
            end
        elseif (GetTask(60) ~= 0) then
            --¼ì²âÊÇ·ñÎªÅÜÉÌ×´Ì¬
            Talk(1, "no", 13576)
        elseif (GetCamp() == 0) then
            --¼ì²âÊÇ·ñÎªĞÂÊÖ
            Talk(1, "no", 13572)
        elseif (ishavefakeCar() == 0) then
            --±íÊ¾ÊÇ·ñ´ïµ½¼Ù³µÉÏÏŞ
            Talk(1, "no", "Xe l­¬ng gi¶ lµ ®Ó ®¸nh lõa bän c­êng ®¹o c­íp l­¬ng. 1 xe thËt chØ ®­îc tèi tèi ®a 10 xe gi¶ hé tèng. Cã ®iÒu hiÖn t¹i gç ®ang rÊt hiÕm, nªn ta kh«ng cã nhiÒu xe gi¶ ®Ó tÆng cho ng­¬i!")
        elseif (playerlevel < 50) then
            Talk(1, "no", "VËn l­¬ng ®Õn TuyÖt Long LÜnh v« cïng khã kh¨n, nÕu ch­a ®ñ ®¼ng cÊp, sÏ rÊt nguy hiÓm. §îi ng­¬i ®¹t cÊp 50 råi h·y ®Õn ®©y!")
        else
            local cashmoney = pMoney()
            if (GetCash() < cashmoney) then
                --ÅĞ¶Ï½ğÇ®
                Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
                return 0
            end
            TaskNote(64, -1)
            SetTask(959, 0)
            SetTask(1052, 0)

            MsgBox("Cã mét chuyÕn xe l­¬ng cÇn chuyÓn ®Õn <c=g>TuyÖt Long LÜnh cho Tæng binh Tr­¬ng QuÕ Ph­¬ng<c>, trªn ®­êng ®¹o tÆc v« sè, v× vËy nªn lµm xe gi¶ ®Ó ®¸nh l¹c h­íng chóng. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=g>" .. cashmoney .. "<c> l­îng! Ng­¬i muèn chÕ t¹o Xe l­¬ng gi¶ kh«ng? Xe gi¶ sÏ kh«ng ¶nh h­ëng ®Õn sè lÇn nhËn nhiÖm vô ChuyÓn l­¬ng", "made", "no")
        end
    end
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

    local limit = GetGlobalValue(Global_fakeCarlimit) - 1
    if (limit < 0) then
        --±íÊ¾ÊÇ·ñ´ïµ½¼Ù³µÉÏÏŞ
        Talk(1, "no", "§· l©u råi kh«ng cã ai ®Õn gióp ta chuyÓn l­¬ng, nªn ch¾c còng kh«ng cÇn giao xe gi¶ cho ng­¬i ®©u!")
        return 0
    end

    local cashmoney = pMoney()
    if (GetCash() < cashmoney) then
        --ÅĞ¶Ï½ğÇ®
        Talk(1, "no", "TiÒn cña ng­¬i kh«ng ®ñ. ChÕ t¹o Xe l­¬ng gi¶ cÇn <c=r>" .. cashmoney .. "<c> l­îng.")
        return 0
    end

    local playerlevel = GetLevel()
    if (playerlevel < 50) then
        Talk(1, "no", "VËn l­¬ng ®Õn TuyÖt Long LÜnh v« cïng khã kh¨n, nÕu ch­a ®ñ ®¼ng cÊp, sÏ rÊt nguy hiÓm. §îi ng­¬i ®¹t cÊp 50 råi h·y ®Õn ®©y!")
        return 0
    end

    local mapid, x, y, carriageindex, playername, carriagelevel, lasttime, playerlevel, bd
    mapid, x, y = GetWorldPos()
    x = 32 * x
    y = 32 * y

    -- add by mayining 2008.5.7
    -- ×öÁìÈ¡ïÚ³µµÄµØÍ¼À¹µ²
    if (mapid ~= 15) then
        CloseDialog()
        return 0
    end
    -- end by mayining
    local mapid2 = GetNpcWorldPos(DialogNpcIdx)
    local x2, y2 = fmapset_xy()--ĞŞ¸Äby yaoxin 2008-08-11 °ÑÂí³µÖ±½ÓÉú³Éµ½ÈËÉíÉÏ
    x2 = 32 * x2
    y2 = 32 * y2

    playerlevel = GetLevel()
    playername = GetName()
    lasttime = 1800

    if (mapid2 == 0) then
        carriageindex = NewSiegeWeapon(mapid, x, y, 556)
    else
        carriageindex = NewSiegeWeapon(mapid2, x2, y2, 556)
    end ;

    carriagelevel = 1
    --ÉèÖÃïÚ³µ½Å±¾
    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\Î±×°µÄÁ¸âÃ³µ.lua")
        SendCarriage(carriageindex, playername, carriagelevel, lasttime)

        --±äÕóÓª

        --Modify By GaoJingwei 20090106 for ¿Û³ı½ğÇ®ÓÅ»¯ Start
        Pay(cashmoney, 1)
        --Modify By GaoJingwei 20090106 for ¿Û³ı½ğÇ®ÓÅ»¯ End

        SetNpcCurCamp(carriagenpcindex, 2)
        SetCamp(2)   --Rocker ĞŞ¸Ä³ÉÓÀ¾ÃÕóÓª2004-9-4 17:37
        SetCurCamp(2)
        TaskNote(64, 4)
        Msg2Player("Xe l­¬ng gi¶ biÕn thµnh phe mµu tİm.")
        SetTask(1052, 1)
        SetTask(959, 1)
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        SetTaskByte(957, 3, NowTime)
        SetGlobalValue(Global_fakeCarlimit, limit)
        MsgBox(13585, "no")
    else
        Talk(1, "no", 13580)
    end
end;

function fIsGreen(playerlevel)
    -- Modify By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 Begin
    local Item_data = {-- µÈ¼¶µ×Ïß , ·ÇibÔö·ù(Ç§·ÖÖÆ), ´ÎÊıÉÏÏŞ
        [1] = { 55, 20, 10 },
        [2] = { 80, 20, 10 },
        [3] = { 100, 20, 10 },
        [4] = { 120, 20, 10 },
    }
    -- Modify By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 End

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
    elseif (mod(GetGlobalValue(Global_Lucky), 20) == 0) then
        return 1
    else
        local r = random(1, 1000)
        if (r <= lucy) then
            SetTask(Task_Lucky, 1)
            SetTask(Task_LuckyTime, 0)
            return 1
        end
    end
    return 0
end

function fmapset_xy()
    local num = random(1, 3)
    local px = car_maps[num].x
    local py = car_maps[num].y
    local r = random(0, 3)
    if (r == 0) then
        px = px + random(car_maps[num].r)
        py = py + random(car_maps[num].r)
    elseif (r == 1) then
        px = px - random(car_maps[num].r)
        py = py - random(car_maps[num].r)
    elseif (r == 2) then
        px = px + random(car_maps[num].r)
        py = py - random(car_maps[num].r)
    else
        px = px - random(car_maps[num].r)
        py = py + random(car_maps[num].r)
    end
    return px, py
end

function ishavefakeCar()
    --±íÊ¾ÊÇ·ñ´ïµ½¼Ù³µÉÏÏŞ
    local lastday = GetGlobalValue(Global_fakeCarday)
    local today = floor(LocalSystemTime() / 86400)
    local limit = GetGlobalValue(Global_fakeCarlimit)

    if (lastday ~= today) then
        SetGlobalValue(Global_fakeCarday, today)
        limit = limit + 50 --Ôİ¶¨ÊÇÃ¿Ìì50»ùÊı
        SetGlobalValue(Global_fakeCarlimit, limit)
    end

    if (limit > 0) then
        return 1
    end
    return 0
end

function pMoney()
    --Î±×°
    local cashmoney = 5000
    if (GetLevel() >= 81) then
        local quotiety = 2 ^ floor((GetLevel() - 61) / 20) --½ğÇ®·­±¶ÏµÊı
        cashmoney = cashmoney * quotiety
        if (cashmoney > 80000) then
            cashmoney = 80000
        end
    end
    return cashmoney
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

function payMoneyfree(nums)
    --	if (nums > 7) then
    --		nums = 7
    --	end
    --	local n_times = {50,50,50,100,100,100,100}
    local m = 2000 * GetLevel() --»ùÊılv*2000
    return m
end

function yes_freefsb()
    CloseDialog()
    if (GetTaskByte(958, 1) == 0) then
        Talk(1, "no", "Ng­¬i ch­a nhËn nhiÖm vô nµo cho ngµy h«m nay, kh«ng cÇn n¹p tµi ®Ó tu luyÖn.")
        return 0
    end
    local addtimes = GetTaskByte(958, 2) + 1
    if (GetTaskByte(1477, 3) < addtimes) then
        Talk(1, "no", "N¹p tµi tu luyÖn tr­íc ®©y cña ng­¬i kh«ng ®ñ. NÕu ng­¬i cã viÖc t¹m thêi ph¶i rêi khái game vµ lo l¾ng bá lì thêi c¬ tu luyÖn, ta sÏ cho ng­¬i c¬ héi <c=g>n¹p tµi tu luyÖn<c>, h·y n¾m b¾t nhĞ!")
        return 0
    end

    local apm = payMoneyfree(addtimes)
    local pm = GetLevel() * 1000 + apm
    if (GetCash() >= pm) then
        if (GetTaskByte(958, 1) == 0) then
            che()
            return 1
        end

        SetTaskWord(958, 2, 1)--ÄÉ²ÆÖÃÎ»£¬ÇåÁã
        local key1 = ok()

        if (key1 >= 1) then
            local strcolor = "Phe Tİm"
            if (key1 == 2) then
                strcolor = "<c=g>Phe Xanh<c>"
            end
            Pay(apm)--Ñº½ğ²»¿Û,Ç°Ãæ¿ÛÁË
            SetTaskByte(958, 2, addtimes)
            Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
            Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø" .. addtimes .. "LÇn nhËn thªm nhiÖm vô vËn l­¬ng.")
            Talk(1, "no", "Ng­¬i rêi m¹ng vµ tİch luü ­u ®·i lÇn thø <c=g>" .. addtimes .. "<c>, h·y giao l­¬ng ®Õn cho <c=g>Tæng binh Tr­¬ng QuÕ Ph­¬ng ë TuyÖt Long LÜnh</c>! Ng­¬i nhËn ®­îc" .. strcolor .. " ®· <c=yel>xuÊt hiÖn</c>, <c=g>Ng­¬i chØ cã 30 ®Ó hoµn thµnh nhiÖm vô</c>!")
        else
            SetTaskByte(958, 3, 0)
        end
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ b¹c. NÕu ng­¬i muèn vËn l­¬ng cÇn cã" .. pm .. ".")
    end
end

function armyresource()
    local tasks1 = {
        { "H­¬ng liÖu", "rs1"; show = 1 },
        { "Gç", "rs2"; show = 0 },
        { "ThiÕt", "rs3"; show = 0 },
        { "vµng", "rs4"; show = 0 },
        --{"ÇàÍ­","rs5";show=0},
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
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã" .. st .. ", kh«ng thÓ vËn chuyÓn qu©n t­ cho l·nh ®Şa cña ng­¬i!")
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
    SayTask("Thµnh thŞ cÊp 1 chØ cã thÓ vËn chuyÓn h­¬ng liÖu, thµnh thŞ cÊp 2 míi cã thÓ vËn chuyÓn gç...", tasks1)--liuying
end

function mission_resource(n)
    local cantakem = 0
    if HaveNormalItem(3, 1012 + n, 0, 0) > 0 then
        cantakem = 1012 + n
    end
    local TongMoney = GetTongRes(0)
    if (cantakem > 0) and (TongMoney >= 100000) then
        SetTaskByte(Task_junzijingsai, 2, n)
        MsgBox("Ng­¬i chän ¸p t¶i <c=g>" .. resource_kind[n][1] .. "<c>, cÇn cã b¶o vËt <c=yel>" .. resource_kind[n][2] .. "<c>, ®ång thêi tiªu hao 10 v¹n b¹c, ng­¬i cã x¸c nhËn muèn hé tèng xe qu©n t­ cho l·nh ®Şa kh«ng?", "yes_msres", "no")    --liuying
    else
        MsgBox("B¹c kh«ng ®ñ hoÆc ng­¬i kh«ng cã b¶o vËt <c=yel>" .. resource_kind[n][2] .. "<c>.", "no")    --liuying
    end
end

function yes_msres()
    local H, m, s = GetHMS()
    if (H < 18) or (H >= 23) then
        MsgBox("Tõ 18:00-23:00 mçi ngµy sÏ tæ chøc ho¹t ®éng Qu©n nhu, vËn chuyÓn b¶o vËt <c=yel>Hinh H­¬ng Lam, ThÇn Méc Chi, HuyÒn ThiÕt §Ønh, Hoµng Kim Chung<c>, vËt liÖu thµnh thŞ sÏ t¨ng nhanh chãng.", "no")    --liuying
        return
    end
    local n = GetTaskByte(Task_junzijingsai, 2)
    local TongMoney = GetTongRes(0)
    local cantakem = 0
    if HaveNormalItem(3, 1012 + n, 0, 0) > 0 then
        cantakem = 1012 + n
    end
    if (TongMoney < 100000) or (cantakem == 0) then
        MsgBox("B¹c kh«ng ®ñ hoÆc ng­¬i kh«ng cã b¶o vËt <c=yel>Hinh H­¬ng Lam, ThÇn Méc Chi, HuyÒn ThiÕt §Ønh, Hoµng Kim Chung<c>.", "no")    --liuying
        return
    end
    --¸ø³µ
    okres(n)
end

function okres(n)
    CloseDialog()
    local DNpcId = GetTask(142)
    if (GetNpcID(DialogNpcIdx) == DNpcId) then
        SetTask(142, 0)
    else
        Talk(1, "no", "RÊt tiÕc, hiÖn Qu©n nhu ch­a ®­îc chÊt lªn xe, l¸t sau h·y quay l¹i nhĞ!")
        return 0
    end

    local mapid, x, y, carriageindex, playername, carriagelevel, lasttime, playerlevel
    mapid, x, y = GetWorldPos()
    x = 32 * x
    y = 32 * y

    -- add by mayining 2008.5.7
    -- ×öÁìÈ¡ïÚ³µµÄµØÍ¼À¹µ²
    if (mapid ~= 15) then
        CloseDialog()
        return 0
    end
    -- end by mayining
    local mapid2 = GetNpcWorldPos(DialogNpcIdx)
    local x2, y2 = fmapset_xy()--ĞŞ¸Äby yaoxin 2008-08-11 °ÑÂí³µÖ±½ÓÉú³Éµ½ÈËÉíÉÏ
    x2 = 32 * x2
    y2 = 32 * y2

    playername = GetName()
    lasttime = 1800

    local camp = 2
    local str = "Phe Tİm"
    local key = 1
    local cartype = 556

    if (mapid2 == 0) then
        carriageindex = NewSiegeWeapon(mapid, x, y, cartype)
    else
        carriageindex = NewSiegeWeapon(mapid, x2, y2, cartype)
    end ;

    carriagelevel = 1
    --ÉèÖÃïÚ³µ½Å±¾
    local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
    if (carriagenpcindex > 0) then
        SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\¾ü×ÊÁ¸âÃ³µ.lua")
        SendCarriage(carriageindex, playername, carriagelevel, lasttime)

        --±äÕóÓª
        SetNpcCurCamp(carriagenpcindex, camp)
        SetCamp(camp)   --Rocker ĞŞ¸Ä³ÉÓÀ¾ÃÕóÓª2004-9-4 17:37
        SetCurCamp(camp)
        TaskNote(300, 0, resource_kind[n][1])
        DelNormalItem(3, 1012 + n, 0, 0)
        WasteTongRes(0, 100000)
        SetTaskByte(Task_junzijingsai, 1, n)
        Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\">§ang gióp l·nh ®Şa vËn chuyÓn <c=yel>" .. resource_kind[n][1] .. "Qu©n nhu<c>, c¸c nghÜa sÜ trong l·nh ®Şa h·y nhanh chãng ®Õn chi viÖn!")
        Talk(1, "no", "Xe l­¬ng ng­¬i tiÕp nhËn <c=yel>®· xuÊt hiÖn</c>, <c=g>ng­¬i chØ cã 30 phót, sau 30 phót xe sÏ tù ®éng biÕn mÊt</c>, h·y nhanh lªn!")
        local CityLevel_log = GetOwnCityLevel() + 1
        local st = GetLevel() .. "CÊp dòng sÜ" .. playername .. "NhËn xe l­¬ng, l·nh ®Şa" .. GetTongName() .. "§¼ng cÊp thµnh thŞ" .. CityLevel_log .. "Lo¹i vËt liÖu" .. resource_kind[n][1]
        WriteLog(st)
        return 1
    else
        Talk(1, "no", "RÊt tiÕc, hiÖn Qu©n nhu ch­a ®­îc chÊt lªn xe, l¸t sau h·y quay l¹i nhĞ!")
        return 0
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


--add by wingbear 2009.10.8 end
