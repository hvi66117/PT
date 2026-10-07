--description: ĞÌÌì
--author: yichuan
--date: 2004/6/29

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-09-1
Task_cold = 1212;
--º®ÊÒĞ§Ó¦ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ£¬3Bit±íÊ¾ÈÎÎñ´ı½»£¬4Bit±íÊ¾½«Æä½»¸øÆäËüNPC½áÊøÈÎÎñ

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

    --º®ÊÒĞ§Ó¦
    startLevel = 21
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) >= 1)) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) < 1)) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 2) == 1) then
                state = 0
                subState = 0
            end
        else
            if (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) >= 1)) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_cold, 4) == 1) and (GetTaskBit(Task_cold, 2) == 0) and ((HaveNormalItem(3, 224, 0, 0) < 1)) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 2) == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ñç»áÑûÇë
    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 2) and (HaveEventItem(15) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 2) and (HaveEventItem(15) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
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
    tasks = {
        --		{"ĞÂÊ½×°±¸","renwu1";show=0},
        --		{"Óª¾È×åÈË","renwu2";show=0},
        { "Mêi yÕn héi", "renwu3"; show = 0 },
        { "T©n Thñ tÇm b¶o", "renwu"; show = 0 },
        { "Hµn ThÊt hiÖu øng", "cold"; show = 0 },
    }
    --	UTask_21 = GetTask(31);
    --	UTask_24 = GetTask(34);
    UTask_Druid = GetTask(2);
    --	if (UTask_21==3) and(HaveEventItem(29)>=1)then
    --				tasks[1].show=1;
    --	end;

    --	if (UTask_24==5)and(HaveEventItem(30)>=1) then
    --				tasks[1].show=1;
    --	end;
    --	if (UTask_24==1) then
    --				tasks[1].show=1;
    --	end;
    if (UTask_Druid == 2) and (HaveEventItem(15) >= 1) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 25) and (GetPlayerType() == 2) and (UTask_Druid == 0) then
        tasks[1].show = 1;
    end ;

    if (GetPlayerType() == 2) then

        local valcold = GetTask(Task_cold)
        if (GetBit(valcold, 4) == 1 and GetBit(valcold, 2) == 0) then
            tasks[3].show = 1
        end

    end

    SayTask(10178, tasks)
end;

--function  renwu1()
--
--			Talk(1,"no",10179)
--			DelEventItem(29)
--			Msg2Player("Çé±¨ÒÑ¾­ËÍµ½£¬»ØÈ¥Ïò¸ßÃ÷¸²Ãü¡£")
--			TaskNote(14,3)
--			SetTask(31,4)
--
--end;

--function   renwu2()
--	UTask_24 = GetTask(34);
--	if (UTask_24==5)and(HaveEventItem(30)>=1) then
--			Talk(1,"no",10180)
--			DelEventItem(30)
--			Msg2Player("ÕÒ»ØÒìÈËµÄÊ³Îï£¬È¥ÕÒ·ç²®Ñ§Ï°Éú»î¼¼ÄÜ¡£")
--			TaskNote(16,5)
--			SetTask(34,6)
--	end;
--
--	if (UTask_24==1) then
--			MsgBox(10181,"yes_1","no")
--	end;
--end;

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

function renwu3()
    UTask_Druid = GetTask(2);
    local mark = fangchenmi()
    if (UTask_Druid == 2) and (HaveEventItem(15) >= 1) then
        Talk(1, "no", 10182)
        DelEventItem(15)
        AddOwnExp(20000)
        Earn(30000)
        Msg2Player("§em thiÕp mêi vÒ H×nh Thiªn, nhËn ®­îc 20000 kinh nghiÖm vµ 30000 l­îng.")
        TopMessage(11719)
        SetTask(2, 10)
        TaskNote(29, 2)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (GetLevel() >= 25) and (GetPlayerType() == 2) and (UTask_Druid == 0) then
        if (mark == 1) then
            MsgBox(10183, "yes", "no")
        else
            Talk(1, "no", 11718)
        end
    end ;
end;

--function yes_1()
--		Talk(1,"no",10184)
--		Msg2Player("µ½¾ŞÂ¹Ò»´øÑ°ÕÒÊ§×ÙµÄ×åÈË¡£")
--		TaskNote(16,1)
--		SetTask(34,2)
--end;

function yes()
    Talk(1, "no", 10185)
    Msg2Player("TiÕp nhËn sù ñy th¸c cña H×nh Thiªn, ®Õn TriÒu Ca gÆp Hå Hû MŞ lÊy thiÕp mêi dù yÕn")
    SetTask(2, 1)
    TaskNote(29, 0)
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
            Talk(1, "no", 12276)
        else
            Talk(2, "no", 12277, "Cã g× kh«ng hiÓu, nhÊn <c=r>F1<c> ®Ó t×m hiÓu thªm!")
        end ;
    elseif (GetLevel() >= 6) and (GetLevel() < 10) then
        Talk(2, "no", 12278, "Nghe nãi <c=r>Thñ khè<c> cÇn mét sè nguyªn liÖu, ng­¬i thö ®Õn ®ã xem, kh«ng biÕt chõng «ng ta sÏ tÆng ng­¬i <c=r>r­¬ng ch­a ®å<c>. Sau khi ®¹t <c=r>cÊp 10<c> ®Õn ®©y ta sÏ h­íng dÉn b­íc kÕ tiÕp sÏ lµm g×.")
        Msg2Player("Giao nguyªn liÖu cho Thñ khè, nhËn ®­îc r­¬ng chøa ®å.")
        SetTask(338, 1)                            --338ÎªÌì?ÓĞÇé×ÊÁÏ¢±¸üĞÂºóÁì?´óÀñºĞµÄÅĞ¶Ï±äÁ¿
    elseif (GetLevel() >= 10) and (GetLevel() < 12) then
        if (GetTask(341) == 0) then
            --339~345ÎªÅĞ¶Ïµ±Ç°²½Öè²»ÄÜÖØ¸´½øĞĞµÄ?Îñ±äÁ¿
            Talk(1, "no", 12279)
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
            Talk(1, "no", 12280)
        end ;
    elseif (GetLevel() >= 12) and (GetLevel() < 15) then
        Talk(1, "shenghuo", 12281)
    elseif (GetLevel() >= 15) and (GetLevel() < 20) then
        if (GetTask(339) == 0) then
            MsgBox(12282, "song", "no")
        elseif (GetTask(339) == 1) then
            Talk(2, "chutou", 12283, "Ng­¬i cã thÓ ®Õn chç ®¹i phu mua <c=r>BiÕn th©n phï<c>, ®Ó kh«ng bŞ qu¸i thó tÊn c«ng, ng­îc l¹i còng kh«ng thÓ ®¸nh chóng!")
        elseif (GetTask(339) == 2) then
            Talk(1, "chutou", 12284)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 3)
        elseif (GetTask(339) == 3) and (GetLevel() >= 16) and (GetLevel() < 20) then
            Talk(1, "chutou", 12285)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 4)
        elseif (GetTask(339) == 4) and (GetLevel() >= 17) and (GetLevel() < 20) then
            Talk(1, "chutou", 12285)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 5)
        elseif (GetTask(339) == 5) and (GetLevel() >= 18) and (GetLevel() < 20) then
            Talk(1, "chutou", 12285)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            SetTask(339, 6)
        elseif (GetTask(339) == 6) and (GetLevel() == 19) then
            Talk(2, "chutou", 12286, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            AddNormalItem(3, 72, 0, 0, 0, 0)
            AddNormalItem(3, 72, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(339, 7)
            SetTask(338, 1)
        elseif (GetTask(339) == 7) then
            Talk(2, "chutou", 12286, "Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <c=r>cÊp 20<c> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")
            Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
            SetTask(338, 1)
        else
            Talk(1, "chutou", 12287)
        end ;
    elseif (GetLevel() >= 20) and (GetLevel() < 25) then
        if (GetTask(343) == 0) then
            Talk(2, "chutou", 12288, "QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i ®¸nh b¹i Ma thó cao cÊp h¬n. Khi ®¹t <color=red>cÊp 25<color> h·y ®Õn t×m ta, ta sÏ chØ ng­¬i c¸ch kiÕm tiÒn, gióp cho cuéc sèng ng­¬i trong “Phong ThÇn B¶ng“ thËt sung tóc.")
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
            Talk(1, "chutou", 12289)
        end ;
    elseif (GetLevel() >= 25) and (GetLevel() < 30) then
        if (GetTask(344) == 0) then
            Talk(1, "chutou", 12290)
            SetTask(344, 1)
        elseif (GetTask(344) == 1) then
            if (GetMorphType() == 364) then
                Talk(1, "chutou", 12291)
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
                Talk(1, "chutou", 12292)
            end ;
        else
            Talk(1, "chutou", 12293)
        end ;
    elseif (GetLevel() >= 30) and (GetLevel() < 35) then
        if (GetTask(345) == 0) then
            Talk(1, "lihe", 12294)
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
            Talk(1, "chutou", 12295)
        end ;
    elseif (GetLevel() >= 35) then
        if (GetTask(338) == 1) then
            Talk(1, "chutou", 12296)
        else
            Talk(1, "no", 12297)
        end ;
    end ;
end;

function canjia()
    Talk(2, "no", 12298, "Tõ ®©y ®i <color=red>Du Hån, Cù Léc, Miªu C­¬ng<color> cã rÊt nhiÒu Ma thó s¬ cÊp, ®¸nh b¹i chóng cã thÓ tu luyÖn n¨ng lùc b¶n th©n. 1 sè Ma thó sau khi chÕt, sÏ r¬i ra nhiÒu nguyªn liÖu thÇn bİ, thu thËp nh÷ng vËt liÖu ®ã, khi ®¹t <color=red>cÊp 6<color> h·y ®Õn t×m ta, ta sÏ cho ng­¬i biÕt b­íc tiÕp theo nªn lµm g×.")
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
    Talk(1, "chutou", 12299)
    Msg2Player("Gióp H×nh Thiªn ®em th­ cho §¹i phu ë §«ng H¶i H¶i C©u.")
    SetTask(339, 1)
end;

function shenghuo()
    if (GetSeries() == 0) then
        Talk(1, "chutou", 12300)
        Msg2Player("T×m Sïng øng Loan häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 1) then
        Talk(1, "chutou", 12301)
        Msg2Player("T×m Nhiªn §¨ng ®¹o nh©n häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    elseif (GetSeries() == 2) then
        Talk(1, "chutou", 12302)
        Msg2Player("T×m Phong B¸ häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
    end ;
    SetTask(346, 1)
    SetTask(338, 1)
end;

function chutou()
    if (GetExtPoint(0) == 1) and (GetTask(342) == 0) then
        AddNormalItem(0, 0, 8, 1, 0, 0)
        Talk(1, "no", 12303)
        SetTask(342, 1)
    else
        CloseDialog()
    end ;
end;

function lihe()
    Talk(2, "chutou", 12304, "<c=r>Phiªn b¶n míi<c> s¾p ra m¾t, tr­íc ®ã nÕu nh­ ng­¬i ®¹t <c=r>cÊp 35<c> ta sÏ tÆng riªng 1 <c=r>phÇn quµ bÊt ngê<c>. Xin xem thªm th«ng tin trªn trang chñ.")
end;

function cold()

    if (HaveNormalItem(3, 224, 0, 0) >= 1) then
        Talk(1, "no", 14668)
        DelNormalItem(3, 224, 0, 0)
        AddOwnExp(10000)
        Earn(500)
        TopMessage(14447)
        Msg2Player("B¹n nhËn ®­îc 10000 kinh nghiÖm, 500 l­îng")
        SetTaskBit(Task_cold, 2, 1)--log¸Ä°æ
        --AS GaoJingwei 090730
        SetSubTask(74, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(74, -1)

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end

end;