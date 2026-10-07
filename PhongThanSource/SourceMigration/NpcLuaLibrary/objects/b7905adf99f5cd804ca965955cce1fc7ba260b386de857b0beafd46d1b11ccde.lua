--description: ´Èº½µÀÈË-À¥ÂØÉ½2¼¶ÈÎÎñ
--author:  yichuan
--date: 2004/6/27
Task_NewPlayer = 1069;

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
    --³õ³öÃ©Â®
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess >= 2) and (taskProcess < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess >= 2) and (taskProcess < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --°ÙÀïÌôÒ»
    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(10)
            if (taskProcess == 0) and (GetTask(Task_NewPlayer) == 6) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 4) then
                state = 3
                subState = 0
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(10)
            if (taskProcess == 0) and (GetTask(Task_NewPlayer) == 6) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 4) then
                state = 3
                subState = 1
            elseif (taskProcess == 20) then
                state = 0
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
    tasks = {
        { "<c=yel>Mao L­<c>", "renwuNewPlayer"; show = 0 },
        { "<c=yel>B¸ch Lý<c>", "renwu1"; show = 0 },
        { "V¹n Tiªn", "renwu2"; show = 0 },
        { "T©n Thñ tÇm b¶o", "renwu"; show = 0 }
    }
    UTask_00 = GetTask(10);
    local nTask_NewPlayer = GetTask(Task_NewPlayer)
    if (nTask_NewPlayer == 1 or nTask_NewPlayer == 5) then
        tasks[1].show = 1;
    end
    if (UTask_00 == 4) then
        tasks[2].show = 1;
    end ;
    if (UTask_00 == 0 and nTask_NewPlayer == 6) then
        tasks[2].show = 1;
    end ;
    SayTask(10566, tasks)
end;
function Wanli()
    UTask_00 = GetTask(10);
    local Tasks2 = {
        { "<c=yel>B¸ch Lý<c>", "renwu1"; show = 0 }
    }
    if (UTask_00 == 0 and GetTask(Task_NewPlayer) == 6) then
        Tasks2[1].show = 1;
    end ;
    SayTask(10566, Tasks2)
end
function renwuNewPlayer()
    local nTask_NewPlayer = GetTask(Task_NewPlayer)
    if (nTask_NewPlayer == 1) then
        SetTask(Task_NewPlayer, 2)
        AddOwnExp(45)
        TaskNote(897, 1)
        TopMessage(12151)
        Msg2Player("NhËn ®­îc 45 ®iÓm kinh nghiÖm.")
        MsgBox(12152, "new")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (nTask_NewPlayer == 5) then
        AddOwnExp(100)
        --AS GaoJingwei 090730
        SetSubTask(897, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(897, -1)
        SetTask(Task_NewPlayer, 6)
        TopMessage(12130)
        Msg2Player("nhËn ®­îc 100 ®iÓm kinh nghiÖm.")
        Talk(1, "Wanli", 12153)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

function new()
    Talk(1, "no", 12154)
end;

function AcceptNewN()
    SetTask(Task_NewPlayer, 3)
end
function renwu1()
    UTask_00 = GetTask(10);
    if (UTask_00 == 4) then
        Talk(1, "no", 10567)
        AddOwnExp(300)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        TopMessage(12155)
        Msg2Player("NhËn ®­îc 300 ®iÓm kinh nghiÖm, 5 TiÓu Hång §¬n vµ 5 TiÓu Hoµn §¬n!")
        --AS GaoJingwei 090730
        SetSubTask(1, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(1, -1)
        Msg2Player("NhËn ®­îc 5 TiÓu Hång §¬n vµ 5 TiÓu Hoµn §¬n!")
        SetTask(10, 20)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_00 == 0) then
        MsgBox(10568, "yes_5", "no")
    end ;
end;

function yes_5()
    Talk(1, "no", 12156)
    Msg2Player("ThØnh gi¸o XÝch Tinh Tö, V©n Trung Tö chän ®Ö tö h¹ s¬n!")
    --AS GaoJingwei 090730
    SetSubTask(1, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(1, 0)
    SetTask(10, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

---------------------
function renwu2()
    idx = SubWorldID2Idx(69); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
    if (idx == -1) then
        return
    end ;
    SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
    if (GetLevel() <= 70) or (GetLevel() >= 91) then
        Talk(1, "no", 12157)
    elseif (HaveNormalItem(3, 64, 0, 0) >= 1) or (GetTask(421) == GetMissionV(3, 1)) then
        MsgBox(12158, "yes_wxz", "no")
    else
        Talk(1, "no", 12159)
    end ;
end;

function yes_wxz()
    local idx = SubWorldID2Idx(69); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
    if (idx == -1) then
        return
    end ;
    SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿

    if (GetGlobalValue(3) == 1) and (GetMSPlayerCount(3, 1) < 50) and (GetTask(421) ~= GetMissionV(3, 1)) then
        DelNormalItem(3, 64, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(0)
        AddMSPlayer(3, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(3, 1))
        NewWorld(69, 1650, 3400)
        CloseDialog()
    elseif (GetGlobalValue(3) == 1) and (GetMSPlayerCount(3, 1) < 55) and (GetTask(421) == GetMissionV(3, 1)) then

        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;
        SetFightState(0)
        AddMSPlayer(3, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(3, 1))
        NewWorld(69, 1650, 3400)
        CloseDialog()
    elseif (GetGlobalValue(3) == 2) and (GetMSPlayerCount(3, 1) < 55) and (GetTask(421) == GetMissionV(3, 1)) then

        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;
        SetFightState(1)
        AddMSPlayer(3, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(3, 1))
        NewWorld(69, 1650, 3400)
        CloseDialog()
    elseif (GetGlobalValue(3) == 2) then
        Talk(1, "no", 12160)
    elseif (GetMSPlayerCount(3, 1) >= 50) then
        Talk(1, "no", 12161)
    else
        Talk(1, "no", 12162)
    end ;
end;

function renwu()
    if (GetLevel() < 6) then
        if (GetTask(340) == 0) then
            Talk(1, "no", 12163)
        else
            Talk(2, "no", 12164, "Cã thÓ nhÊn <c=r>F1<c> ®Ó xem c¸c phÇn h­íng dÉn")
        end ;
    elseif (GetLevel() >= 6) and (GetLevel() < 10) then
        Talk(2, "no", 12165, "Nghe nãi <c=r>Thñ khè<c> cã thÓ gióp ng­¬i lµm <c=r>r­¬ng ch­a ®å<c>. §¹t <c=r>cÊp 10<c> ®Õn ®©y ta sÏ h­íng dÉn b­íc kÕ tiÕp")
        Msg2Player("Giao nguyªn liÖu cho Thñ khè, nhËn ®­îc r­¬ng chøa ®å.")
        SetTask(338, 1)                            --338ÎªÌìÈôÓÐÇé×ÊÁÏÆ¬¸üÐÂºóÁìÈ¡´óÀñºÐµÄÅÐ¶Ï±äÁ¿
    elseif (GetLevel() >= 10) and (GetLevel() < 12) then
        if (GetTask(341) == 0) then
            --339~345ÎªÅÐ¶Ïµ±Ç°²½Öè²»ÄÜÖØ¸´½øÐÐµÄÈÎÎñ±äÁ¿
            Talk(1, "no", 12166)
            if (GetSeries() == 0) then
                AddNormalItem(7, 25, 28, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - L¨ng Ba Vi Bé.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 4, 7, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Tinh Th«ng L«i HÖ.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 50, 451, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dÞ nh©n - Tr­êng Cung tÕ.")
            end ;
            SetTask(338, 1)
            SetTask(341, 1)
        else
            Talk(1, "no", 12167)
        end ;
    elseif (GetLevel() >= 12) and (GetLevel() < 15) then
        Talk(1, "shenghuo", 12168)
    elseif (GetLevel() >= 15) and (GetLevel() < 20) then
        if (GetTask(339) == 0) then
            MsgBox(12169, "song", "no")
        elseif (GetTask(339) == 1) then
            Talk(2, "chutou", 12170, "Ng­¬i cã thÓ ®Õn ®¹i phu mua <c=r>biÕn th©n phï<c>, biÕn thµnh c¸c qu¸i ®Ó chóng kh«ng thÓ tÊn c«ng, ng­¬i còng kh«ng thÓ ®¸nh chóng")
        elseif (GetTask(339) == 2) then
            Talk(1, "chutou", 12171)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 3)
        elseif (GetTask(339) == 3) and (GetLevel() >= 16) and (GetLevel() < 20) then
            Talk(1, "chutou", 12172)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 4)
        elseif (GetTask(339) == 4) and (GetLevel() >= 17) and (GetLevel() < 20) then
            Talk(1, "chutou", 12172)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 5)
        elseif (GetTask(339) == 5) and (GetLevel() >= 18) and (GetLevel() < 20) then
            Talk(1, "chutou", 12172)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 6)
        elseif (GetTask(339) == 6) and (GetLevel() == 19) then
            Talk(2, "chutou", 12173, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(339, 7)
            SetTask(338, 1)
        elseif (GetTask(339) == 7) then
            Talk(2, "chutou", 12173, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12174)
        end ;
    elseif (GetLevel() >= 20) and (GetLevel() < 25) then
        if (GetTask(343) == 0) then
            Talk(2, "chutou", 12175, "<color=red>S¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i ®¸nh b¹i Ma thó cÊp cao h¬n. Khi ng­¬i ®¹t ®Õn <color=red>cÊp 25<color> h·y ®Õn t×m ta, ta sÏ h­íng dÉn mét sè c¸ch kiÕm tiÒn kh¸c, gióp ng­¬i sèng tho¶i m¸i h¬n trong thÕ giíi “Phong ThÇn“.")
            if (GetSeries() == 0) then
                AddNormalItem(7, 27, 30, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - Håi Phong Tr¶m.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 6, 9, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - B¨ng C¬ TuyÕt Cèt.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 51, 452, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dÞ nh©n - Thiªn Vò TÕ.")
            end ;
            SetTask(343, 1)
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12176)
        end ;
    elseif (GetLevel() >= 25) and (GetLevel() < 30) then
        if (GetTask(344) == 0) then
            Talk(1, "chutou", 12177)
            SetTask(344, 1)
        elseif (GetTask(344) == 1) then
            if (GetMorphType() == 364) then
                Talk(1, "chutou", 12178)
                if (GetSeries() == 0) then
                    AddNormalItem(0, 10, 0, 4, 0, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc §éc Gi¸c Thó vµ 1 B¸ L¹c nh·n cÊp 4.")
                elseif (GetSeries() == 1) then
                    AddNormalItem(0, 10, 1, 4, 0, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc Th­¬ng ¦ng vµ 1 B¸ L¹c nh·n cÊp 4.")
                elseif (GetSeries() == 2) then
                    AddNormalItem(0, 10, 2, 4, 0, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc B¹ch V©n hå ®iÖp vµ 1 B¸ L¹c nh·n cÊp 4.")
                end ;
                AddNormalItem(3, 32, 0, 0, 0, 0)
                SetTask(344, 2)
                SetTask(338, 1)
            else
                Talk(1, "chutou", 12179)
            end ;
        else
            Talk(1, "chutou", 12180)
        end ;
    elseif (GetLevel() >= 30) and (GetLevel() < 35) then
        if (GetTask(345) == 0) then
            Talk(1, "lihe", 12181)
            if (GetSeries() == 0) then
                AddNormalItem(7, 28, 31, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - §iÖn Quang Tr¶m.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 8, 11, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - H¹n §Þa L«i.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 42, 45, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dÞ nh©n - Bæ T©m Chó.")
            end ;
            SetTask(345, 1)
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12182)
        end ;
    elseif (GetLevel() >= 35) then
        if (GetTask(338) == 1) then
            Talk(1, "chutou", 12183)
        else
            Talk(1, "no", 12184)
        end ;
    end ;
end;

function canjia()
    Talk(2, "no", 12185, "Tõ ®©y ®i <c=r>Ch©n nói C«n L«n, Thñ D­¬ng s¬n, T©y C«n L«n<c> cã nhiÒu ma qu¸i s¬ cÊp, ng­¬i cã thÓ tiªu diÖt chóng ®Ó tu luyÖn ®ång thêi nhÆt mét sè trang bÞ. §¹t <c=r>cÊp 6<c> ®Õn ®©y ta sÏ h­íng dÉn tiÕp cho ng­¬i.")
    if (GetSeries() == 0) then
        AddNormalItem(7, 24, 27, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - TÕ HuyÕt Tr¶m.")
    elseif (GetSeries() == 1) then
        AddNormalItem(7, 0, 3, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Ch­ëng T©m L«i.")
    elseif (GetSeries() == 2) then
        AddNormalItem(7, 49, 450, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dÞ nh©n - Lùc SÜ TÕ.")
    end ;
    SetTask(338, 1)
    SetTask(340, 1)
end;

function song()
    Talk(1, "chutou", 12186)
    Msg2Player("Gióp Tõ Hµng ®¹o nh©n ®em th­ cho §¹i phu ë §«ng H¶i H¶i C©u.")
    SetTask(339, 1)
end;

function shenghuo()
    if (GetSeries() == 0) then
        Talk(1, "chutou", 12187)
        Msg2Player("T×m Sïng øng Loan häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 1) then
        Talk(1, "chutou", 12188)
        Msg2Player("T×m Nhiªn §¨ng ®¹o nh©n häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 2) then
        Talk(1, "chutou", 12189)
        Msg2Player("T×m Phong B¸ häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    end ;
    SetTask(346, 1)
    SetTask(338, 1)
end;

function chutou()
    if (GetExtPoint(0) == 1) and (GetTask(342) == 0) then
        AddNormalItem(0, 0, 8, 1, 0, 0)
        Talk(1, "no", 12190)
        SetTask(342, 1)
    else
        CloseDialog()
    end ;
end;

function lihe()
    Talk(2, "chutou", 12191, "<c=r>Phiªn b¶n míi<c> s¾p ra m¾t, tr­íc ®ã nÕu nh­ ng­¬i ®¹t <c=r>cÊp 35<c> ta sÏ tÆng riªng 1 <c=r>phÇn quµ bÊt ngê<c>. Xin xem thªm th«ng tin trªn trang chñ.")
end;
