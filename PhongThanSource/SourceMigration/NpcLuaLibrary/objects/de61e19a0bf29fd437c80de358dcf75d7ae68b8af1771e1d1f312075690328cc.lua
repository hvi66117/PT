Task_cold = 1212;

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main(sel)
    tasks = {


        { "Mêi yÕn héi", "renwu3"; show = 0 },
        { "T©n Thñ tÇm b¶o", "renwu"; show = 0 },
        { "Hµn ThÊt hiÖu øng", "cold"; show = 0 },

        { "KÝch ho¹t Ph¸p B¶o ChÝ T«n", "ControlAmulet"; show = 0 },
        { "Hîp thµnh Ph¸p B¶o Tinh Hoa", "DecomposeAmulet"; show = 1 },
        { "VÒ Ph¸p B¶o Tinh Hoa", "AmuletEssence"; show = 1 }

    }

    UTask_Druid = GetTask(2);

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

    if (GetLevel() >= 60 and GetUseWithBit(1) == 0) then
        tasks[4].show = 1
    end

    SayTask(10178, tasks)
end;

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

        refreshNpcTaskState()

    end ;

    if (GetLevel() >= 25) and (GetPlayerType() == 2) and (UTask_Druid == 0) then
        if (mark == 1) then
            MsgBox(10183, "yes", "no")
        else
            Talk(1, "no", 11718)
        end
    end ;
end;

function yes()
    Talk(1, "no", 10185)
    Msg2Player("TiÕp nhËn sù ñy th¸c cña H×nh Thiªn, ®Õn TriÒu Ca gÆp Hå Hû MÞ lÊy thiÕp mêi dù yÕn")
    SetTask(2, 1)
    TaskNote(29, 0)

    refreshNpcTaskState()

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
        SetTask(338, 1)
    elseif (GetLevel() >= 10) and (GetLevel() < 12) then
        if (GetTask(341) == 0) then
            Talk(1, "no", 12279)
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
            Talk(1, "no", 12280)
        end ;
    elseif (GetLevel() >= 12) and (GetLevel() < 15) then
        Talk(1, "shenghuo", 12281)
    elseif (GetLevel() >= 15) and (GetLevel() < 20) then
        if (GetTask(339) == 0) then
            MsgBox(12282, "song", "no")
        elseif (GetTask(339) == 1) then
            Talk(2, "chutou", 12283, "Ng­¬i cã thÓ ®Õn chç ®¹i phu mua <c=r>BiÕn th©n phï<c>, ®Ó kh«ng bÞ qu¸i thó tÊn c«ng, ng­îc l¹i còng kh«ng thÓ ®¸nh chóng!")
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
            Talk(2, "chutou", 12288, "QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i ®¸nh b¹i Ma thó cao cÊp h¬n. Khi ®¹t <color=red>cÊp 25<color> h·y ®Õn t×m ta, ta sÏ chØ ng­¬i c¸ch kiÕm tiÒn, gióp cho cuéc sèng ng­¬i trong *Phong ThÇn B¶ng* thËt sung tóc.")
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
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - H¹n §Þa L«i.")
            elseif (GetSeries() == 2) then
                AddNormalItem(7, 42, 45, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dÞ nh©n - Bæ T©m Chó.")
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
    Talk(2, "no", 12298, "Tõ ®©y ®i <color=red>Du Hån, Cù Léc, Miªu C­¬ng<color> cã rÊt nhiÒu Ma thó s¬ cÊp, ®¸nh b¹i chóng cã thÓ tu luyÖn n¨ng lùc b¶n th©n. 1 sè Ma thó sau khi chÕt, sÏ r¬i ra nhiÒu nguyªn liÖu thÇn bÝ, thu thËp nh÷ng vËt liÖu ®ã, khi ®¹t <color=red>cÊp 6<color> h·y ®Õn t×m ta, ta sÏ cho ng­¬i biÕt b­íc tiÕp theo nªn lµm g×.")
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
    if (GetTask(342) == 0) then
        AddNormalItem(0, 0, 8, 1, 0, 0)
        Talk(1, "no", 12303)
        SetTask(342, 1)
    else
        CloseDialog()
    end ;
end;

function lihe()
    Talk(2, "chutou", 12304, "Th«ng tin sù kiÖn liªn quan, xem t¹i trang chñ https://phongthan.online.")
end;

function cold()

    if (HaveNormalItem(3, 224, 0, 0) >= 1) then
        Talk(1, "no", 14668)
        DelNormalItem(3, 224, 0, 0)
        AddOwnExp(10000)
        Earn(500)
        TopMessage(14447)
        Msg2Player("B¹n nhËn ®­îc 10000 kinh nghiÖm, 500 l­îng")
        SetTaskBit(Task_cold, 2, 1)

        SetSubTask(74, -1, 1)

        TaskNote(74, -1)

        refreshNpcTaskState()


    end

end;

TableDecompose = {
    { name = "Ph¸p B¶o cÊp 10", Id = { 0, 1, 2, 3, 4, 5 }, GetItem = { 3, 1261, 0, 0 } },
    { name = "Ph¸p B¶o cÊp 30", Id = { 6, 7, 8, 9 }, GetItem = { 3, 1262, 0, 0 } },
    { name = "Ph¸p B¶o cÊp 50", Id = { 10, 11, 12, 13 }, GetItem = { 3, 1263, 0, 0 } },
    { name = "Ph¸p B¶o cÊp 70", Id = { 14, 15, 16, 17 }, GetItem = { 3, 1264, 0, 0 } },
}
function DecomposeAmulet()
    no()
    MsgBox("Ta cã thÓ ®em ph¸p b¶o cÊp 10, 30, 50, 70 mçi lo¹i 1 c¸i tõ trªn ng­êi ng­¬i hîp thµnh <c=g>Ph¸p B¶o Tinh Hoa<c>, x¸c ®Þnh muèn hîp thµnh?", "AdmuletDecomposeSure", "no")
end
function AdmuletDecomposeSure()
    no()
    local tAmuletID = { -1, -1, -1, -1 }
    local tAmuletLevel = { -1, -1, -1, -1 }
    local nEnough = 1
    local nTemp = 0
    local nTempLevel = 0

    for i = 1, table.getn(TableDecompose) do
        for j = 1, table.getn(TableDecompose[i].Id) do
            nTempLevel = GetItemLevel2(0, 4, TableDecompose[i].Id[j])
            if (nTempLevel > 0) then
                tAmuletID[i] = TableDecompose[i].Id[j]
                tAmuletLevel[i] = nTempLevel
                break
            end
        end
    end

    for i = 1, table.getn(tAmuletID) do
        if (tAmuletID[i] < 0) then
            nEnough = 0
            nTemp = i
            break
        end
    end

    if (nEnough == 0) then
        Talk(1, "no", "ThËt xin lçi, ch­a ®ñ " .. TableDecompose[nTemp].name .. ", kh«ng thÓ ®æi.")
        return
    end

    for i = 1, table.getn(tAmuletID) do
        DelItem2(0, 4, tAmuletID[i], tAmuletLevel[i])
    end

    AddNormalItem(3, 1265, 0, 0, 0, 0, 1)
    MsgBox("Chóc mõng ngµi thµnh c«ng hîp thµnh 1 c¸i <c=g>Ph¸p B¶o Tinh Hoa<c>, ngµi cã muèn tiÕp tôc hîp thµnh kh«ng?", "AdmuletDecomposeSure", "no")
    WriteLog("[Ph©n gi¶i ph¸p b¶o][NhËn ®­îc][1 c¸i][Ph¸p B¶o Tinh Hoa]")
end
function ControlAmulet()
    no()
    local nLevel = GetLevel()
    if (nLevel < 60) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t cÊp 60, kh«ng thÓ nhËn nhiÖm vô")
        return
    end
    if (GetUseWithBit(1) > 0) then
        Talk(1, "no", "ThËt xin lçi <c=g>Ph¸p b¶o ChÝ T«n<c> ®· kÝch ho¹t, kh«ng cÇn kÝch ho¹t l¹i!")
        return
    end
    MsgBox("<c=g>Ph¸p b¶o ChÝ T«n<c> lµ lo¹i Ph¸p B¶o cã søc m¹nh lín nhÊt trong Thiªn §Þa, do vËy kh«ng thÓ dÔ dµng mang trªn m×nh ph¸p b¶o m¹nh nh­ vËy, ®Ó kÝch ho¹t <c=g>Ph¸p b¶o ChÝ T«n<c> cÇn <c=g>10 Ph¸p B¶o Tinh Hoa vµ 100 v¹n b¹c<c> lµ cã thÓ kÝch ho¹t Ph¸p b¶o ChÝ T«n, x¸c nhËn chø?", "ControlAmuletYes", "no")
end
function ControlAmuletYes()
    no()
    local nLevel = GetLevel()
    if (nLevel < 60) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t cÊp 60, kh«ng thÓ nhËn nhiÖm vô")
        return
    end
    if (GetUseWithBit(1) > 0) then
        Talk(1, "no", "ThËt xin lçi, Ph¸p b¶o ChÝ T«n ®· ®­îc kÝch ho¹t, kh«ng thÓ nhËn nhiÖm vô")
        return
    end
    if (HaveNormalItem(3, 1265, 0, 0) < 10) then
        Talk(1, "no", "Ngµi ch­a cã ®ñ 10 <c=g>Ph¸p B¶o Tinh Hoa<c>.")
        return
    end
    if (GetCash() < 1000000) then
        Talk(1, "no", "Xin lçi, ng©n l­îng ngµi mang theo ch­a ®ñ 100 v¹n b¹c.")
        return
    end

    for i = 1, 10 do
        DelNormalItem(3, 1265, 0, 0)
    end
    Pay(1000000, 1)
    SetUseWithBit(1, 1)
    Talk(1, "no", "§· thµnh c«ng kÝch ho¹t <c=g>Ph¸p b¶o ChÝ T«n<c>, ®Ó t×m hiÓu thªm vÒ Ph¸p b¶o ChÝ T«n, h·y t×m <c=g>Linh B¶o §¹i Ph¸p S­<c> t¹i Ngäc H­ Cung.")
    WriteLog("[Ph¸p b¶o ChÝ T«n][KÝch ho¹t « Ph¸p b¶o ChÝ T«n sè 1]")
end

function AmuletEssence()
    no()
    Talk(1, "no", "Ph¸p b¶o trong thÕ gian ®Òu cã chøa Tinh Hoa, ta cã thÓ gióp ng­¬i lÊy ra Tinh hoa tõ trong ph¸p b¶o, ®em theo ph¸p b¶o cÊp 10, 30, 50, 70 tuú ý, mçi lo¹i 1 c¸i lµ cã thÓ hîp thµnh <c=g>Ph¸p B¶o Tinh Hoa<c>.")
end
