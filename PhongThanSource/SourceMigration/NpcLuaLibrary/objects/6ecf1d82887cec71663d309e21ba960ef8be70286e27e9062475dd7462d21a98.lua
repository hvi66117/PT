--description: Áé±¦´ó·¨Ê¦
--author: yichuan
--date: 2004/6/27
--321~323ÊÇ·ñÁìÈ¡ÁË½½Ë®£¬Ê©·Ê£¬×½³æÈÎÎñ£»324~326½½Ë®£¬Ê©·Ê£¬×½³æÊ§°Ü¸ÅÂÊ£»327£º³É³¤¶È¡£
--321       --1byte ²ÄÁÏÀàĞÍ   2byte ÊÕÈ¡ËÄÏóÁùµÀ²ÄÁÏµÄÊıÄ¿
Task_Improve = 1351        --1bit´ÌÌ½Çé±¨ÊÇ·ñÁì¹ıÈçÒâÒ°Íâ´«ËÍ·û£»2byte:ÉñÃØ»¨»ÜÊ§°ÜµÄ´ÎÊı


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

    --ÎÄÎäË«È«
    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(15)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(15)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÌìÍ¥ÉñÊ÷ luoyixuan
    startLevel = 35
    if (GetLevel() >= startLevel and GetTask(997) == 0 and GetTaskByte(813, 2) == 0 and GetTask(815) ~= 0 and (HaveEventItem(49) >= 1 or HaveEventItem(164) >= 1)) then
        if (GetLevel() - startLevel <= 5) then
            if ((HaveNormalItem(3, GetTaskByte(321, 1), 0, 0) >= GetTaskByte(321, 2) and GetCash() >= 1000 and GetTask(321) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 0
            elseif (GetTask(321) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if ((HaveNormalItem(3, GetTaskByte(321, 1), 0, 0) >= GetTaskByte(321, 2) and GetCash() >= 1000 and GetTask(321) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 1
            elseif (GetTask(321) ~= 0) then
                state = 2
                subState = 0
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


function main(sel)
    local treeStr = "T­íi n­íc"

    if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
        treeStr = "<c=pk>T­íi n­íc<c>"
    elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
        treeStr = "<c=g>T­íi n­íc<c>"
    end
    tasks = {
        { "<c=yel>Kh¶o nghiÖm<c>", "renwu2"; show = 0 },
        --		{"°ÙÀïÌôÒ»","renwu1";show=0},
        --		{"<c=yel>×Î×Î²»¾ë<c>","zizibujuan";show = 0},
        { treeStr, "renwu"; show = 0 },
        { "B¾t s©u", "chuansong1"; show = 0 },
        { "Bãn ph©n", "chuansong2"; show = 0 }
    }
    --	UTask_00=GetTask(10);
    --	if (UTask_00 == 1) or (UTask_00 == 5)or (UTask_00 == 9)or (UTask_00 == 13) then
    --			tasks[2].show=1;
    --	end;
    UTask_05 = GetTask(15);
    if (UTask_05 == 1) then
        tasks[1].show = 1;
    end ;

    if (GetLevel() >= 35) and (HaveEventItem(49) >= 1) and (GetTask(322) == 0) and (GetTask(323) == 0) and (GetTask(804) == 1) then
        tasks[2].show = 1
        tasks[3].show = 1
        tasks[4].show = 1
        SayTask(11383, tasks)
    elseif (GetLevel() >= 35) and (HaveEventItem(164) >= 1) and (GetTask(322) == 0) and (GetTask(323) == 0) and (GetTask(804) == 2) then
        tasks[2].show = 1
        tasks[3].show = 1
        tasks[4].show = 1
        SayTask(11383, tasks)
    else
        SayTask(10538, tasks)
    end ;
end;

function chuansong1()
    MsgBox("Linh B¶o ®¹i ph¸p s­:C©y thÇn bİ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Sïng øng B­u<c> ë Sïng Thµnh phô tr¸ch viÖc <c=r>b¾t s©u<c>. Ta cã thÓ giíi thiÖu ng­¬i, cã muèn t×m h¾n kh«ng?", "cs_1", "no")
end

function chuansong2()
    MsgBox("Linh B¶o ®¹i ph¸p s­:C©y thÇn bİ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Cao Gi¸c<c> ë Xi V­u Mé phô tr¸ch viÖc <c=r>bãn ph©n<c>. Ta cã thÓ giíi thiÖu ng­¬i, cã muèn t×m h¾n kh«ng?", "cs_2", "no")
end

function cs_1()
    CloseDialog()
    local cost = gettranscost()
    if (GetCash() >= cost) then
        NewWorld(2, 1690, 3120)
        PrePay(cost)
    else
        Msg2Player("B¹n kh«ng ®ñ tiÒn!")
    end
end

function cs_2()
    CloseDialog()
    local cost = gettranscost()
    if (GetCash() >= cost) then
        NewWorld(4, 1648, 3172)
        PrePay(cost)
    else
        Msg2Player("B¹n kh«ng ®ñ tiÒn!")
    end
end

function gettranscost()
    local penny
    if (GetLevel() <= 30) then
        penny = 200
    elseif (GetLevel() > 30) and (GetLevel() <= 50) then
        penny = 500
    elseif (GetLevel() > 50) and (GetLevel() <= 70) then
        penny = 1000
    elseif (GetLevel() > 70) and (GetLevel() <= 90) then
        penny = 2000
    else
        penny = 5000
    end ;
    return penny
end

function renwu1()
    UTask_00 = GetTask(10);
    if (UTask_00 == 1) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 3)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 5) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 4)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 9) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 6)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 13) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 7)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
end;

function renwu2()
    Say(10540, 3, "Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1", "Thiªn h¹ chi chİ nhu, tr× s¸nh thiªn h¹ chi chİ kiªn/yes_1", "Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")

end;

function yes_1()
    Say(10541, 3, "§¹i ®¹o phÕ khİ liÔu, tµi hiÓn thŞ xuÊt nh©n nghÜa/yes_2", "§¹i ®¹o phÕ khİ liÔu, tµi s¶n sinh liÔu nh©n nghÜa/no1", "§¹i ®¹o phÕ khİ liÔu, hoµn h÷u nh©n nghÜa t¹i/no1")
end;

function yes_2()
    Say(10542, 3, "GiÕt kh«ng ®¸ng tiÕc/no1", "Dô chi ®Ò chuyÓn bÜ/no1", "tÜnh ®·i m¹c tu cÊp/yes_3")
end;

function yes_3()
    AddOwnExp(450)
    TopMessage(11950)
    Msg2Player("NhËn ®­îc 450 ®iÓm kinh nghiÖm.")
    Talk(1, "no", 10543)
    TaskNote(5, 1)
    Msg2Player("ThuËn lîi th«ng qua kh¶o v¨n, ®Õn cÊp 10 quay l¹i gÆp V©n Trung Tö!")
    SetTask(15, 2)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no1()
    Talk(1, "check", 10544)
end;

function check()
    Say(10545, 3, "Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1", "Thiªn h¹ chi chİ nhu, tr× s¸nh thiªn h¹ chi chİ kiªn/yes_1", "Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")
end;

function no()
    CloseDialog()
end;

function renwu()
    CloseDialog()                --ÈÎÎñ´ÎÊı´óÓÚ5£¬ÔòÖØĞÂ½ÓÈÎÎñ
    if (GetTask(320) >= 11) then

        local ZZtype = GetTask(804)
        if ((ZZtype == 1) and (HaveEventItem(49) >= 1)) then
            DelEventItem(49)
        elseif ((ZZtype == 2) and (HaveEventItem(164) >= 1)) then
            DelEventItem(164)
        end

        local er = GetLevel() * 2800
        AddOwnExp(er)
        Talk(1, "no", "Th­ëng ng­¬i" .. er .. "kinh nghiÖm, h·y nhËn l¹i nhiÖm vô ®i")
        SetTask(320, 0)--Á`¦¸¼Æ
        SetTask(321, 0)--¼å¤ô©Ò»İ§÷®Æ
        SetTask(322, 0)--¬IªÎ©Ò»İ§÷®Æ
        SetTask(323, 0)--§ìÂÎ©Ò»İªkÄ_
        SetTask(324, 0)--¼å¤ô¥¢±Ñ²v
        SetTask(325, 0)--¬IªÎ¥¢±Ñ²v
        SetTask(326, 0)--§ìÂÎ¥¢±Ñ²v
        SetTask(327, 0)--¦¨ªø«×
        SetTask(815, 0)--»¡©úºØ¾ğµ²§ô
        SetTaskWord(813, 2, 0)
        SetTask(804, 0)
        TaskNote(60, -1)
        return
    end

    if (GetTask(320) >= 10) then
        Talk(1, "no", 11384)
        TaskNote(60, 6)
        return
    end ;

    local j = GetTaskByte(321, 1)
    local failNum = GetTaskByte(Task_Improve, 2)        --ÈÎÎñÊ§°ÜµÄ´ÎÊı
    if (j == 0) then
        local i = random(1, 6);
        local w = ""
        if (i == 1) then
            w = "Háa vò"
        elseif (i == 2) then
            w = "Ngäc cèt"
        elseif (i == 3) then
            w = "§o¶n KiÕm"
        elseif (i == 4) then
            w = "M¶nh Gi¸p"
        elseif (i == 5) then
            w = "MÆt Quû"
        elseif (i == 6) then
            w = "B¨ng c¬"
        end ;
        -- AS longxian at 090904 

        if (GetLevel() <= 90) then
            Talk(2, "no", "§­îc! LÇn nµy nguyªn liÖu ta cÇn lµ <color=r>" .. w .. "<c>.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(321, 1, i + 7)
            Msg2Player("Gióp Linh B¶o ®¹i ph¸p s­ t×m " .. w .. ".")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 3, w)
            SetTaskByte(321, 2, 10)
        else
            Talk(2, "no", "§­îc! LÇn nµy nguyªn liÖu ta cÇn lµ <color=r>" .. w .. "<color> 20.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(321, 1, i + 7)
            Msg2Player("Gióp Linh B¶o ®¹i ph¸p s­ t×m " .. w .. "20.")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 7, w)
            SetTaskByte(321, 2, 20)
        end
        --luoyixuan
        refreshNpcTaskState()
        --luoyixuan

        -- AS longxian at 090904 
    else
        local xuqiu = GetTaskByte(321, 2)
        if (HaveNormalItem(3, j, 0, 0) >= xuqiu) and (GetCash() >= 1000) then
            for a = 1, xuqiu do
                DelNormalItem(3, j, 0, 0)
            end ;
            Pay(1000)

            TaskNote(60, 2)
            local k = GetTask(324)--Ò²¾ÍÊÇÖ»ÓĞ×¥³æµÄÊ±ºò£¬½«Ê§°ÜÂÊ½µµÍ5%		--???
            --			if(k<0)then
            --				k=0
            --			end
            local l = random(1, 100)

            if (failNum >= 2) then
                --Èç¹ûÊ§°Ü´ÎÊı´óÓÚ2£¬Ôò²»ÄÜÔÚÊ§°Ü
                l = 100
                -- modified by yaoxin for  2011-3 begin
            elseif (GetTask(320) >= 8) and (failNum >= 1) then
                --Èç¹û×îºóÒ»´ÎÊ§°Ü´ÎÊı´óÓÚ1£¬ÔòÊ§°ÜºóÔÙ¸øÒ»´Î»ú»á
                if (l <= k) then
                    l = random(1, 100)
                end
            end

            local times = floor((GetTask(320) + 1) / 2)
            if (l > k) and ((GetGlobalValue(6) == 0) or (GetTask(327) <= 47)) then
                --				local chengzhang=random(6,8)
                local n1 = random(1, 4)
                if (n1 == 1) then
                    chengzhang = 6
                elseif (n1 == 2) or (n1 == 3) then
                    chengzhang = 7
                elseif (n1 == 4) then
                    chengzhang = 8
                end
                local jieguo = chengzhang + GetTask(327)
                if (jieguo >= 55) then
                    chengzhang = 54 - GetTask(327)
                end
                SetTask(327, GetTask(327) + chengzhang)

                local nExp = 500 * GetLevel()
                if (GetTask(320) >= 8) then
                    nExp = 1200 * GetLevel()
                end
                -- modified by yaoxin for  2011-3 end
                local nexp1 = nExp * 0.5
                if (GetTaskByte(813, 3) == 0) and (GetWeekDay() == 5) and (floor(LocalSystemTime() / 86400) == floor(GetTask(816) / 86400)) then
                    nExp = nExp * 2
                    Msg2Player("Chñ ®Ò nhiÖm vô h«m nay lµ Thiªn Thô! Chóc mõng b¹n nhËn ®­îc phÇn th­ëng nh©n ®«i!")
                end

                if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
                    nExp = nExp + nexp1 * 2
                elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
                    nExp = nExp + nexp1
                end

                if (GetTaskByte(813, 4) == 2) then
                    nExp = nExp * 2
                end
                AddOwnExp(nExp)
                Msg2Player("MÇm c©y cña ng­¬i ®· trång ®­îc" .. times .. "lÇn, nhËn ®­îc" .. nExp .. " kinh nghiÖm, ®é tr­ëng thµnh hiÖn t¹i: <c=g>" .. GetTask(327) .. "<c>.")
                TopMessage("nhËn ®­îc <color = green>" .. nExp .. "<c> kinh nghiÖm")
                SetTask(320, GetTask(320) + 1)
                Talk(1, "no", "MÇm c©y cña ng­¬i ®· ch¨m sãc ®­îc <c=g>" .. times .. "<c> lÇn. LÇn nµy nã nhËn ®­îc <c=g>" .. chengzhang .. " ®iÓm tr­ëng thµnh<c>. §é tr­ëng thµnh hiÖn t¹i lµ <c=g>" .. GetTask(327) .. "<c>. MÇn c©y nµy chØ cã thÓ nu«i d­ìng 5 lÇn, nÕu nh­ t­íi n­íc qu¸ nhiÒu sÏ ¶nh h­ëng xÊu ®Õn ®é t¬ëng thµnh cña mÇn non.")
            else
                failNum = failNum + 1
                SetTaskByte(Task_Improve, 2, failNum)
                SetTask(327, GetTask(327) + 2)        --ÈÎÎñÊ§°Ü£¬³É³¤¶È¼Ó2
                SetTask(320, GetTask(320) + 1)
                Talk(1, "no", "Do ng­¬i t­íi n­íc nhiÒu qu¸, mÇm c©y lÇn nµy tr­ëng thµnh kh«ng ®­îc lı t­ëng l¾m. LÇn nµy ng­¬i ch¨m sãc ®­îc <c=g>" .. times .. "<c> lÇn, lÇn nµy nã thu ®­îc <color=green>2 ®iÓm<color> ®é thµnh tr­ëng, ®é thµnh tr­ëng hiÖn nay lµ <color=green>" .. GetTask(327) .. "<c>.")
            end ;
            SetTask(321, 0)
            --luoyixuan
            refreshNpcTaskState()
            --luoyixuan

            local m = GetTask(324) + 13
            if m > 100 then
                m = 100
            end ;
            SetTask(324, m)

            local n = GetTask(325) - 7
            if n <= 0 then
                n = 7
            end ;
            SetTask(325, n)

            local o = GetTask(326) - 7
            if o <= 0 then
                o = 5
            end ;
            SetTask(326, o)
        elseif (HaveNormalItem(3, j, 0, 0) < xuqiu) then
            local w = ""
            if (j == 8) then
                w = "Háa vò"
            elseif (j == 9) then
                w = "Ngäc cèt"
            elseif (j == 10) then
                w = "§o¶n KiÕm"
            elseif (j == 11) then
                w = "M¶nh Gi¸p"
            elseif (j == 12) then
                w = "MÆt Quû"
            elseif (j == 13) then
                w = "B¨ng c¬"
            end ;
            Talk(1, "no", "LÇn t­íi n­íc nµy cÇn <color=green>" .. xuqiu .. "." .. w .. "<c>, ng­¬i mau ®i lÊy vÒ! NÕu kh«ng t­íi n­íc kŞp th× sÏ háng hÕt.")
        elseif (GetCash() < 1000) then
            Talk(1, "no", 11951)
        else
            Talk(1, "no", 11385)
        end ;
    end ;
end;
