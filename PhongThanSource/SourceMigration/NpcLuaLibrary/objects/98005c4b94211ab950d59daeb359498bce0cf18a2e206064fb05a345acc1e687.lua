--description: ³çÓ¦±ë-³ç³Ç9¼¶?Îñ
--author: rongjiangfei
--date: 2004/5/14
--321~323ÊÇ·ñÁìÈ¡ÁË½½Ë®£¬Ê©·Ê£¬×½³æÈÎÎñ£»324~326½½Ë®£¬Ê©·Ê£¬×½³æÊ§°Ü¸ÅÂÊ£»327£º³É³¤¶È¡£
Task_Improve = 1351        --1bit´ÌÌ½Çé±¨ÊÇ·ñÁì¹ýÈçÒâÒ°Íâ´«ËÍ·û£»2byte:ÉñÃØ»¨»ÜÊ§°ÜµÄ´ÎÊý


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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÌìÍ¥ÉñÊ÷ luoyixuan
    startLevel = 35
    if (GetLevel() >= startLevel and GetTask(997) == 0 and GetTaskByte(813, 2) == 0 and GetTask(815) ~= 0) then
        local j = 1
        local i = 0
        for j = 1, 6, 1 do
            if (GetItemLevel2(0, 4, j - 1) > 0) and (GetCash() >= 1000) then
                i = 1
            end
        end
        if (GetLevel() - startLevel <= 5) then
            if ((i == 1 and GetTask(323) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 0
            elseif (GetTask(323) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if ((i == 1 and GetTask(323) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 1
            elseif (GetTask(323) ~= 0) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end


function main(sel)
    local treeStr = "B¾t s©u"

    if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
        treeStr = "<c=pk>B¾t s©u<c>"
    elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
        treeStr = "<c=g>B¾t s©u<c>"
    end
    tasks = {
        { "T©n Thøc", "renwu1"; show = 0 },
        { "Phôc håi n.vô", "taskid"; show = 0 },
        { treeStr, "renwu"; show = 0 },
        { "T­íi n­íc", "chuansong1"; show = 0 },
        { "Bãn ph©n", "chuansong2"; show = 0 }
    }
    --	UTask_11=GetTask(21);
    --	if (UTask_11==2)  then
    --				tasks[1].show=1;
    --	end;
    --	if(GetPlayerType()==0)then
    --				tasks[2].show=1;
    --	end;
    if (GetLevel() >= 35) and (HaveEventItem(49) >= 1) and (GetTask(321) == 0) and (GetTask(322) == 0) and (GetTask(804) == 1) then
        tasks[3].show = 1
        tasks[4].show = 1
        tasks[5].show = 1
        SayTask(11168, tasks)
    elseif (GetLevel() >= 35) and (HaveEventItem(164) >= 1) and (GetTask(321) == 0) and (GetTask(322) == 0) and (GetTask(804) == 2) then
        tasks[3].show = 1
        tasks[4].show = 1
        tasks[5].show = 1
        SayTask(11168, tasks)
    else
        SayTask(10249, tasks)
    end ;
end;

function chuansong1()
    MsgBox("C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Linh B¶o §¹i Ph¸p S­<c> Ngäc H­ Cung lo viÖc <c=r>t­íi n­íc<c>. Muèn t×m ph¸p s­ kh«ng?", "cs_1", "no")
end

function chuansong2()
    MsgBox("C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Cao Gi¸c<c> Xi V­u Mé lo viÖc <c=r>bãn ph©n<c>. Muèn t×m ph¸p s­ kh«ng?", "cs_2", "no")
end

function cs_1()
    CloseDialog()
    local cost = gettranscost()
    if (GetCash() >= cost) then
        NewWorld(3, 1664, 3142)
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
    Talk(1, "no", 10250)
    Msg2Player("Tiªu diÖt KiÕm Nh©n, thu thËp 10 §o¶n kiÕm giao cho ¢u Thiªn Hãa.")
    TaskNote(8, 2)
    SetTask(21, 3)
end;

function taskid()
    MsgBox(11169, "yes_1", "no")
end;

function yes_1()
    RepairTaskValue()
    Talk(1, "no", 12598)
end;

function yes()
    local i = GetTask(0)
    local j = floor((GetLevel() + 5) / 10) * 10
    if (i ~= 0) then
        if (i <= j) then
            SetTask(3, i)
            SetTask(4, 1)
            Talk(1, "no", 11170)
        else
            SetTask(3, 0)
            SetTask(4, 1)
            Talk(1, "no", 11171)
            TaskNote(27, 34)
        end ;
    else
        Talk(1, "no", 11172)
    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    CloseDialog()                --ÈÎÎñ´ÎÊý´óÓÚ5£¬ÔòÖØÐÂ½ÓÈÎÎñ
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
        SetTask(321, 0)--¼å¤ô©Ò»Ý§÷®Æ
        SetTask(322, 0)--¬IªÎ©Ò»Ý§÷®Æ
        SetTask(323, 0)--§ìÂÎ©Ò»ÝªkÄ_
        SetTask(324, 0)--¼å¤ô¥¢±Ñ²v
        SetTask(325, 0)--¬IªÎ¥¢±Ñ²v
        SetTask(326, 0)--§ìÂÎ¥¢±Ñ²v
        SetTask(327, 0)--¦¨ªø«×
        SetTask(815, 0)--»¡©úºØ¾ðµ²§ô
        SetTaskWord(813, 2, 0)
        SetTask(804, 0)
        TaskNote(60, -1)
        return
    end

    if (GetTask(320) >= 10) then
        Talk(1, "no", 11173)
        TaskNote(60, 6)
        return
    end ;

    local j = GetTask(323)
    local failNum = GetTaskByte(Task_Improve, 2)
    if (j == 0) then
        local i = random(1, 6);
        --		local  w=""
        --					if (i==1) then
        --							w="Îå¹âÊ¯"
        --					elseif(i==2)then
        --							w="ÐÎÌìÓ¡"
        --					elseif(i==3)then
        --							w="Ç¬À¤³ß"
        --					elseif(i==4)then
        --							w="»ìÌìÁè"
        --					elseif(i==5)then
        --							w="ÁðÁ§Æ¿"
        --					elseif(i==6)then
        --							w="»ðÁúïÚ"
        --					end;

        local w = "Ngò quang th¹ch, H×nh Thiªn Ên, Cµn Kh«n XÝch, Hçn Thiªn L¨ng, B×nh L­u Ly, Háa Long tiªu"
        Talk(2, "no", "Sïng øng B­u: LÇn nµy ta cÇn 1 lo¹i nguyªn liÖu bÊt kú trong sè <color=yel>" .. w .. "<c>.", GetName() .. ": Ta ®ang t×m Ph¸p b¶o nµy.")
        SetTask(323, i)
        TaskNote(60, 4, w)
        --luoyixuan
        refreshNpcTaskState()
        --luoyixuan
        Msg2Player("Gióp Sïng øng B­u t×m vËt liÖu" .. w .. "1 lo¹i bÊt kú.")
        SetTask(320, GetTask(320) + 1)
    else
        local j = 1

        for j = 1, 6, 1 do
            if (GetItemLevel2(0, 4, j - 1) > 0) and (GetCash() >= 1000) then
                DelItem2(0, 4, j - 1, GetItemLevel2(0, 4, j - 1))
                Pay(1000)
                TaskNote(60, 2)
                local k = GetTask(326)
                if (k < 0) then
                    k = 0
                end
                local l = random(1, 100)
                if (failNum >= 2) then
                    --Èç¹ûÊ§°Ü´ÎÊý´óÓÚ2£¬Ôò²»ÄÜÔÚÊ§°Ü
                    l = 100
                    -- modified by yaoxin for  2011-3 begin
                elseif (GetTask(320) >= 8) and (failNum >= 1) then
                    --Èç¹û×îºóÒ»´ÎÊ§°Ü´ÎÊý´óÓÚ1£¬ÔòÊ§°ÜºóÔÙ¸øÒ»´Î»ú»á
                    if (l <= k) then
                        l = random(1, 100)
                    end
                end

                local times = floor((GetTask(320) + 1) / 2)
                if (l > k) and ((GetGlobalValue(6) == 0) or (GetTask(327) <= 45)) then
                    --				local chengzhang=random(6,12)
                    local rate = random(1, 16)
                    if (rate == 1) then
                        chengzhang = 6
                    elseif (rate == 2) or (rate == 3) then
                        chengzhang = 7
                    elseif (rate > 3) and (rate < 7) then
                        chengzhang = 8
                    elseif (rate > 6) and (rate < 11) then
                        chengzhang = 9
                    elseif (rate > 10) and (rate < 14) then
                        chengzhang = 10
                    elseif (rate == 14) or (rate == 15) then
                        chengzhang = 11
                    else
                        chengzhang = 12
                    end
                    if (GetTask(323) == 1) then
                        --Îå¹âÊ¯
                        --						chengzhang=random(8,12)
                        local n = random(1, 16)
                        if (n < 5) then
                            chengzhang = 8
                        elseif (n > 4) and (n < 9) then
                            chengzhang = 9
                        elseif (n > 8) and (n < 13) then
                            chengzhang = 10
                        elseif (n == 13) or (n == 14) then
                            chengzhang = 11
                        elseif (n == 15) or (n == 16) then
                            chengzhang = 12
                        end
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
                    Talk(1, "no", "MÇm c©y cña ng­¬i ®· trång ®­îc <c=g>" .. times .. "<c> lÇn. LÇn nµy ®· nhËn ®­îc <color=green>" .. chengzhang .. "<c> ®iÓm tr­ëng thµnh, ®é tr­ëng thµnh hiÖn t¹i lµ <c=g>" .. GetTask(327) .. "<color>. Lo¹i mÇm c©y nµy chØ cã thÓ ch¨m sãc 5 lÇn, nÕu nh­ b¾t s©u mµ ph¸t hiÖn kh«ng cã s©u, th× xem nh­ l·ng phÝ hÕt 1 lÇn.")
                else
                    failNum = failNum + 1
                    SetTaskByte(Task_Improve, 2, failNum)
                    SetTask(327, GetTask(327) + 2)
                    SetTask(320, GetTask(320) + 1)
                    Talk(1, "no", "MÇm cña ng­¬i kh«ng cÇn ph¶i b¾t s©u n÷a. MÇm nµy ®· trång ®­îc <c=g>" .. times .. "<c> lÇn, lÇn nµy nã thu ®­îc <color=green>2 ®iÓm<color> ®é thµnh tr­ëng, ®é thµnh tr­ëng hiÖn nay lµ <color=green>" .. GetTask(327) .. "<c>.")
                end ;
                SetTask(323, 0)
                --luoyixuan
                refreshNpcTaskState()
                --luoyixuan

                local m = GetTask(326) + 13
                if m > 100 then
                    m = 100
                end ;
                SetTask(326, m)

                local n = GetTask(324) - 7
                if n <= 0 then
                    n = 7
                end ;
                SetTask(324, n)

                local o = GetTask(325) - 7
                if o <= 0 then
                    o = 7
                end ;
                SetTask(325, o)
                return
            elseif (GetCash() < 1000) then
                Talk(1, "no", 12599)
                return
            end ;
        end

        local w = "1 lo¹i bÊt kú trong c¸c nguyªn liÖu <color=Red>Ngò quang th¹ch, H×nh Thiªn Ên, Cµn Kh«n XÝch, Hçn Thiªn L¨ng, B×nh L­u Ly, Háa Long tiªu<color>"
        Talk(1, "no", "Sïng øng B­u: LÇn nµy b¾t s©u, ng­¬i cÇn t×m" .. w .. "Ng­¬i h·y nhanh chãng t×m vÒ, nÕu kh«ng sÏ bá lì thêi c¬ tèt nhÊt ®Ó b¾t s©u.")

    end ;
end;
