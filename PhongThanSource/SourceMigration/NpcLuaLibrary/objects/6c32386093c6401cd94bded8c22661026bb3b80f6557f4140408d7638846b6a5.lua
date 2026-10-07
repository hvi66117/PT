--description£º Â³ĞÛ
--author£º yujin
--date£º 2004/6/28
Task_TrySkill = 1020;
Task_BeCare = 1025;

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
    local startLevel = 3

    --ĞÂÊ½ÎäÆ÷
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            local taskProcess = GetTask(21)
            if (taskProcess == 0) then
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
            --À¶É«
            local taskProcess = GetTask(21)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
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

    --Ğ¡ĞÄÒíÒí
    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(1025)
            if (GetTask(21) == 20) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(1025)
            if (GetTask(21) == 20) and (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end
function main(sel)
    tasks = {
        --		{"Íê³ÉĞÂÊÖÊÔÁ·","renwu2";show=0 },
        { "<c=yel>T©n Thøc<c>", "renwu1"; show = 0 },
        { "<c=yel>TÇm B¶o<c>", "renwu"; show = 0 },
        { "<c=yel>CÈn thËn<c>", "AcceptBeCare"; show = 0 }
    }
    UTask_11 = GetTask(21);
    --				if (UTask_11 == 8) then	
    --						tasks[1].show=1
    --				end;
    --				if (UTask_11 == 5)  then	
    --						tasks[1].show=1
    --				end;
    if ((UTask_11 == 0) and (GetLevel() >= 3 and GetPlayerType() == 0) or UTask_11 == 4) then
        tasks[1].show = 1
    elseif (UTask_11 == 20 and GetTask(Task_BeCare) == 0 and GetPlayerType() == 0) then
        tasks[3].show = 1
    end ;
    --				if( GetTask(Task_TrySkill) == 2)then
    --					tasks[1].show = 1
    --				end

    SayTask(10266, tasks)
end;

function renwu1()
    UTask_11 = GetTask(21);
    --				if (UTask_11 == 8) then		
    --						Talk(1,"no",10267)
    --						Earn(600)
    --						AddOwnExp(500)
    --						Msg2Player("³É¹¦¸ü»»ÎäÆ÷Ô­²ÄÁÏ£¬»ñµÃÂ³ĞÛ½±ÀøµÄ600Ç®ºÍ500¾­Ñé¡£")
    --						TaskNote(8,8)
    --						SetTask(21,9)
    --				end;
    --				if (UTask_11 == 5)  then		
    --						Talk(1,"no",10268)
    --						Msg2Player("È¥ÕÒ³çºÚ»¢ÏëÏë°ì·¨¡£")
    --						TaskNote(8,5)
    --						SetTask(21,6)
    --				end;

    if (UTask_11 == 0) and (GetLevel() >= 3) then
        MsgBox(12517, "yes_1", "no")
    elseif (UTask_11 == 4) then
        AddOwnExp(600)
        Earn(600)
        TopMessage(12518)
        --AS GaoJingwei 090730
        SetSubTask(8, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(8, -1)
        SetTask(21, 20)
        Talk(1, "BeCareful", 12519)
        if (GetTask(21) == 5) then
            SyncBibleState(8, 0, 1)
        end

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

end;
function BeCareful()
    Tasks1 = {
        { "ChuyÓn TuyÕt Lé", "AcceptBeCare"; show = 1 }
    }
    SayTask(12520, Tasks1)
end
function AcceptBeCare()
    MsgBox(12521, "AcceptSure", "no")

end
function AcceptSure()

    if (AddEventItem(188) == 1) then
        SetTask(Task_BeCare, 1)
        --AS GaoJingwei 090730
        SetSubTask(906, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(906, 0)
        TopMessage(12522)
        Talk(1, "no", 12523)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", 12524)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end
--function renwu2()
--	AddOwnExp(50)
--	TopMessage("»ñµÃ50¾­Ñé")
--	TaskNote(907,-1)
--	SetTask(Task_TrySkill,3)
--	if( GetTask(21)==0 and (GetLevel()>=3 ) )then
--		Talk(1,"NewWeapon","Â³ĞÛ£ºÄã¾¹È»ÕâÃ´¿ì¾ÍÍê³ÉÁËÊÔÁ·£¬»¶Ó­¼ÓÈëÎÒÃÇ£¬½ÓÏÂÀ´ÎÒÒª·ÖÅäÈÎÎñÁËÈÃÄã¸üÁË½âÎÒÃÇ´óÓª¡£")
--	else
--		Talk(1,"no","Â³ĞÛ£ºÄã¾¹È»ÕâÃ´¿ì¾ÍÍê³ÉÁËÊÔÁ·£¬»¶Ó­¼ÓÈëÎÒÃÇ¡£")
--	end
--end
function NewWeapon()
    Task1 = {
        { "T©n Thøc", "renwu1"; show = 1 }
    }
    SayTask(12525, Task1)
end
function yes_1()
    Talk(1, "no", 12526)
    Msg2Player("ThØnh gi¸o Thî ®ång bİ quyÕt ®óc t¹o vò khİ míi!")
    --AS GaoJingwei 090730
    SetSubTask(8, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(8, 0)
    SetTask(21, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetLevel() < 6) then
        if (GetTask(340) == 0) then
            Talk(1, "no", 12527)
        else
            Talk(2, "no", 12528, "Cã thÓ nhÊn <c=r>F1<c> ®Ó t×m hiÓu thªm vÒ trß ch¬i!")
        end ;
    elseif (GetLevel() >= 6) and (GetLevel() < 10) then
        Talk(2, "no", 12529, "<c=r>Thñ khè<c> cã thÓ gióp ng­¬i lµm <c=r>r­¬ng ch­a ®å<c>. Sau khi ®¹t <c=r>cÊp 10<c> ®Õn ®©y, ta sÏ h­íng dÉn c¸c b­íc kÕ tiÕp")
        Msg2Player("Giao nguyªn liÖu cho Thñ khè, nhËn ®­îc r­¬ng chøa ®å.")
        SetTask(338, 1)                            --338ÎªÌìÈôÓĞÇé×ÊÁÏÆ¬¸üĞÂºóÁìÈ¡´óÀñºĞµÄÅĞ¶Ï±äÁ¿
    elseif (GetLevel() >= 10) and (GetLevel() < 12) then
        if (GetTask(341) == 0) then
            --339~345ÎªÅĞ¶Ïµ±Ç°²½Öè²»ÄÜÖØ¸´½øĞĞµÄÈÎÎñ±äÁ¿
            Talk(1, "no", 12530)
            if (GetSeries() == 0) then
                AddNormalItem(7, 25, 28, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - L¨ng Ba Vi Bé.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 4, 7, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Tinh Th«ng L«i HÖ.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 50, 451, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Tr­êng Cung tÕ.")
            end ;
            SetTask(338, 1)
            SetTask(341, 1)
        else
            Talk(1, "no", 12531)
        end ;
    elseif (GetLevel() >= 12) and (GetLevel() < 15) then
        Talk(1, "shenghuo", 12532)
    elseif (GetLevel() >= 15) and (GetLevel() < 20) then
        if (GetTask(339) == 0) then
            MsgBox(12533, "song", "no")
        elseif (GetTask(339) == 1) then
            Talk(2, "chutou", 12534, "Ng­¬i cã thÓ ®Õn chç ®¹i phu mua <c=r>BiÕn th©n phï<c>, ®Ó kh«ng bŞ qu¸i thó tÊn c«ng, ng­îc l¹i còng kh«ng thÓ ®¸nh chóng!")
        elseif (GetTask(339) == 2) then
            Talk(1, "chutou", 12535)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 3)
        elseif (GetTask(339) == 3) and (GetLevel() >= 16) and (GetLevel() < 20) then
            Talk(1, "chutou", 12536)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 4)
        elseif (GetTask(339) == 4) and (GetLevel() >= 17) and (GetLevel() < 20) then
            Talk(1, "chutou", 12536)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 5)
        elseif (GetTask(339) == 5) and (GetLevel() >= 18) and (GetLevel() < 20) then
            Talk(1, "chutou", 12536)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 6)
        elseif (GetTask(339) == 6) and (GetLevel() == 19) then
            Talk(2, "chutou", 12537, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(339, 7)
            SetTask(338, 1)
        elseif (GetTask(339) == 7) then
            Talk(2, "chutou", 12537, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12538)
        end ;
    elseif (GetLevel() >= 20) and (GetLevel() < 25) then
        if (GetTask(343) == 0) then
            Talk(2, "chutou", 12539, "Lç Hïng: QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i ®¸nh b¹i Ma thó cao cÊp. Khi ®¹t ®Õn <color=red>cÊp 25<color> h·y ®Õn t×m ta, ta sÏ chØ ng­¬i c¸ch kiÕm tiÒn, gióp ng­¬i cã cuéc sèng sung tóc h¬n trong thÕ giíi Phong ThÇn.")
            if (GetSeries() == 0) then
                AddNormalItem(7, 27, 30, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - Håi Phong Tr¶m.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 6, 9, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - B¨ng C¬ TuyÕt Cèt.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 51, 452, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Thiªn Vò TÕ.")
            end ;
            SetTask(343, 1)
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12540)
        end ;
    elseif (GetLevel() >= 25) and (GetLevel() < 30) then
        if (GetTask(344) == 0) then
            Talk(1, "chutou", 12541)
            SetTask(344, 1)
        elseif (GetTask(344) == 1) then
            if (GetMorphType() == 364) then
                Talk(1, "chutou", 12542)
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
                Talk(1, "chutou", 12543)
            end ;
        else
            Talk(1, "chutou", 12544)
        end ;
    elseif (GetLevel() >= 30) and (GetLevel() < 35) then
        if (GetTask(345) == 0) then
            Talk(1, "lihe", 12545)
            if (GetSeries() == 0) then
                AddNormalItem(7, 28, 31, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - §iÖn Quang Tr¶m.")
            elseif (GetSeries() == 1) then
                AddNormalItem(7, 8, 11, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - H¹n §Şa L«i.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 42, 45, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Bæ T©m Chó.")
            end ;
            SetTask(345, 1)
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12546)
        end ;
    elseif (GetLevel() >= 35) then
        if (GetTask(338) == 1) then
            Talk(1, "chutou", 12547)
        else
            Talk(1, "no", 12548)
        end ;
    end ;
end;

function canjia()
    Talk(2, "no", 12549, "Lç Hïng: Tõ ®©y ®Õn <color=red>Sïng Thµnh, YÕn S¬n, B¾c H¶i<color> cã nhiÒu Ma thó s¬ cÊp, tiªu diÖt chóng cã thÓ gióp ng­¬i tu luyÖn n¨ng lùc b¶n th©n. 1 sè Ma thó sau khi chÕt sÏ r¬i ra nhiÒu nguyªn liÖu thÇn bİ, h·y thu thËp chóng. Khi nµo ®¹t <color=red>cÊp 6<color> h·y ®Õn t×m ta, ta sÏ chØ ng­¬i b­íc tiÕp theo nªn lµm g×.")
    if (GetSeries() == 0) then
        AddNormalItem(7, 24, 27, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - TÕ HuyÕt Tr¶m.")
    elseif (GetSeries() == 1) then
        AddNormalItem(7, 0, 3, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Ch­ëng T©m L«i.")
    elseif (GetSeries() == 2) then
        AddNormalItem(7, 49, 450, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Lùc SÜ TÕ.")
    end ;
    SetTask(338, 1)
    SetTask(340, 1)
end;

function song()
    Talk(1, "chutou", 12550)
    Msg2Player("Gióp Lç Hïng ®em th­ cho §¹i phu ë §«ng H¶i H¶i C©u.")
    SetTask(339, 1)
end;

function shenghuo()
    if (GetSeries() == 0) then
        Talk(1, "chutou", 12551)
        Msg2Player("T×m Sïng øng Loan häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 1) then
        Talk(1, "chutou", 12552)
        Msg2Player("T×m Nhiªn §¨ng ®¹o nh©n häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 2) then
        Talk(1, "chutou", 12553)
        Msg2Player("T×m Phong B¸ häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    end ;
    SetTask(346, 1)
    SetTask(338, 1)
end;

function chutou()
    if (GetExtPoint(0) == 1) and (GetTask(342) == 0) then
        AddNormalItem(0, 0, 8, 1, 0, 0)
        Talk(1, "no", 12554)
        SetTask(342, 1)
    else
        CloseDialog()
    end ;
end;

function lihe()
    Talk(2, "chutou", 12555, "<c=r>Phiªn b¶n míi<c> s¾p ra m¾t, tr­íc ®ã nÕu nh­ ng­¬i ®¹t <c=r>cÊp 35<c> ta sÏ tÆng riªng 1 <c=r>phÇn quµ bÊt ngê<c>. Xin xem thªm th«ng tin trªn trang chñ.")
end;
