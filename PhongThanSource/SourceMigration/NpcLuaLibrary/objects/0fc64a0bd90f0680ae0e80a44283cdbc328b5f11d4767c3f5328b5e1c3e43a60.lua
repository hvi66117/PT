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

    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 11) and (HaveEventItem(45) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 11) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 11) and (HaveEventItem(45) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 11) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 20) then
                state = 1
                subState = 0
            elseif (taskProcess == 24) or ((taskProcess == 26) and (HaveEventItem(12) >= 1)) then
                state = 3
                subState = 0
            elseif (taskProcess == 27) then
                state = 0
                subState = 0
            elseif ((taskProcess >= 21) and (taskProcess <= 23)) or (taskProcess == 25) or (taskProcess == 26) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 20) then
                state = 1
                subState = 1
            elseif (taskProcess == 24) or ((taskProcess == 26) and (HaveEventItem(12) >= 1)) then
                state = 3
                subState = 1
            elseif (taskProcess == 27) then
                state = 0
                subState = 0
            elseif ((taskProcess >= 21) and (taskProcess <= 23)) or (taskProcess == 25) or (taskProcess == 26) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) or (taskProcess == 12) or (taskProcess == 14) or (taskProcess == 16) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 10) or (taskProcess == 12) or (taskProcess == 14) or (taskProcess == 16) then
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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

Task_State = 1710

function main()
    tasks = {
        { "TrÇm H­¬ng", "renwu1"; show = 0 },
        { "Khuyªn hµng", "renwu2"; show = 0 },
        { "ThÕ Së", "renwu3"; show = 0 },
        { "B¸i s­", "renwu4"; show = 0 },
        { "Nh.®iÓm s­ ®å", "renwu5"; show = 0 },
        { "§æi ®iÓm s­ ®å", "renwu6"; show = 0 },
        { "Th«ng hµnh lÖnh", "lingpai"; show = 0 },
        { "XuÊt s­", "chushi"; show = 1 },
        { "Quy Ch©n KÝnh", "guizhenjing"; show = 1 },
        { "B¸uvËtS­M«n", "mpsale"; show = 1 },
        { "Nh©n NghÜa HiÖp SÜ", "help"; show = 0 },

        { "§æi Nh©n NghÜa Th¹ch", "GetHelpStore"; show = 1 },


    }

    UTask_Knight = GetTask(3);
    UTask_Wizard = GetTask(1);
    UT_MPR = GetTask(333);

    if (GetPlayerType() == 0) and (GetLevel() >= 35) and (UTask_Knight == 11) and (HaveEventItem(45) >= 1) then
        tasks[1].show = 1;
    end ;
    if (UTask_Wizard == 10) or (UTask_Wizard == 12) or (UTask_Wizard == 14) or (UTask_Wizard == 16) then
        tasks[3].show = 1;
    end ;
    if (UTask_Knight == 26) and (HaveEventItem(12) >= 1) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() >= 45) and (UTask_Knight == 24) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() >= 45) and (UTask_Knight == 20) and (GetPlayerType() == 0) then
        tasks[2].show = 1;
    end ;

    if (GetTask(597) == 4) and (HaveEventItem(106) >= 1) then
        tasks[7].show = 1;
    end ;

    if (HaveNormalItem(3, 1066, 0, 0) ~= 0) then
        tasks[11].show = 1;
    end

    SayTask(10050, tasks)
end;

function Drop_Cool_Summer()
    no()
    MsgBox(" X¸c nhËn muèn hñy nhiÖm vô?", "Drop_Cool_Summer1", "no");
end

function Drop_Cool_Summer1()
    no()
    SetTaskByte(Task_State, 1, 19);
    RemoveIBBuff(1311);
    RemoveIBBuff(1312);
    TaskNote(1606, -1);
end

function Cool_Summer()
    no();
    MsgBox("Nghe nãi Trô V­¬ng ®ang thu thËp b¸u vËt tr¸nh nãng? Muèn cã <c=yel>Thanh L­¬ng T¸n<c>, chØ cÇn tr­íc khi tr¹ng th¸i <c=yel>Thanh Phong Chó<c> biÕn mÊt, ®Õn <c=g>§«ng H¶i Thñy Vùc<c> hµng phôc <c=fire>Háa Ng­<c> hoÆc <c=fire>Vâ Quy<c> lµ cã thÓ lÊy ®­îc. Thanh Phong Chó chØ duy tr× <c=yel>30 phót<c>, h·y cÊp tèc lªn ®­êng. NÕu muèn t×m <c=yel>Tþ Thö Ch©u<c> hoÆc <c=yel>TÈm ThÊp Hoµn<c> cã thÓ ®i t×m <c=g>Tinh Quan<c> hoÆc <c=g>Thiªn Hïng<c>. Mçi ngµy chØ cã thÓ tiÕn hµnh 1 trong 3 nhiÖm vô nµy. Mçi lÇn nhiÖm vô cÇn nép <c=yel>5 v¹n b¹c<c>. NhËn nhiÖm vô chø!", "Cool_Summer_1", "no")
end

function Cool_Summer_1()
    no();

    if GetCash() < 50000 then
        Talk(1, "no", " Mçi lÇn tham gia ®Òu cÇn nép 5 v¹n b¹c! Ng­¬i kh«ng ®ñ tiÒn! Kh«ng thÓ tham gia ho¹t ®éng!")
        return
    end

    if IsHaveSpaceForTreasure(1) == 0 then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ trèng! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end
    Pay(50000)

    local nYear, nMonth, nDay = GetYMD();
    SetTaskByte(Task_State, 1, 10);

    SetTaskByte(Task_State, 3, nDay);
    SetTaskByte(Task_State, 4, 1);
    ClearItem(6, 1, 841, 0);
    ClearItem(6, 1, 842, 0);

    RemoveIBBuff(1312);
    RemoveIBBuff(1311);
    RemoveIBBuff(1310);

    AddIBBuff(1311, 30 * 60);

    TaskNote(1606, 3);
    WriteLog(" chç Hoµng Phi Hæ nhËn nhiÖm vô Thanh l­¬ng h¹ quý")
    for i = 1711, 1715 do
        SetTask(i, 0);
    end
end

function guizhenjing()
    tasks = {
        { "Quy Ch©n KÝnh", "enhance"; show = 0 },
        { "Ph¸p M«n", "intro"; show = 1 },
        { "Ph¸pM«nV«Cùc", "intro1"; show = 1 },

    }
    if (GetItemLevel2(0, 4, 33) >= 1) then
        tasks[1].show = 1;
    end
    SayTask(14187, tasks)
end

function intro()
    Talk(4, "no", 14188, "70 ®iÓm s­ ®å cã thÓ lµm t¨ng kh¸ng tÊt c¶ cho Quy Ch©n KÝnh cÊp 2.", "Sau khi ng­¬i tiªu hao 100 ®iÓm s­ ®å vµ Danh väng S­ m«n ®¹t ®Õn 'S­ Danh T­íc Khëi', th× cã thÓ c­êng hãa Quy Ch©n KÝnh cÊp 3 trë thµnh Th¸i Cùc Quy Ch©n KÝnh tèi cao", "Sau khi ng­¬i tiªu hao 80 ®iÓm s­ ®å vµ Danh väng S­ m«n ®¹t ®Õn 'Danh §éng NhÊt Ph­¬ng' th× cã thÓ c­êng hãa Quy Ch©n KÝnh trë thµnh V« Cùc Quy Ch©n KÝnh chÝ t«n")
end

function intro1()
    Talk(1, "fbsj2_5", "<c=g>V« Cùc Q.C.KÝnh<c>: <enter>VCQCK+Béc Ph¸c Th¹ch+Hång B¶o Th¹ch+Lß tinh luyÖn S¬ cÊp=VCQCK (1,2,3 th¨ng)<enter>VCQCK+2 BPTh¹ch+Hång B¶o Th¹ch+Lß tinh luyÖn tr.cÊp=VCQCK (4,5,6 th¨ng)<enter>VCQCK+3 BPTh¹ch+Hång B¶o Th¹ch+Lß tinh luyÖn c.cÊp=VCQCK (7,8,9 th¨ng)<enter>100% thµnh c«ng")
end
function fbsj2_5()
    CloseDialog()
    Talk(1, "no", "<c=g>V« Cùc Quy Ch©n KÝnh<c>: <enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*15+Tinh ChÝ Béc Ph¸c Th¹ch*3+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 10)<enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*30+Tinh ChÝ Béc Ph¸c Th¹ch*6+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 11)<enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*60+Tinh ChÝ Béc Ph¸c Th¹ch*9+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 12)<enter>Chó ý: nhÊt ®Þnh thµnh c«ng")
end

function enhance()
    local lv = GetItemLevel2(0, 4, 33)
    local costvalue = { 70, 70, { 100, 30, "S­ Danh T­íc Khëi" }, { 80, 90, "Danh §éng NhÊt Ph­¬ng" } }
    if (lv > 0) and (lv < 3) then
        if (GetMasterPRValue() >= costvalue[lv]) then
            MsgBox("<c=yel>Quy Ch©n KÝnh<c> lµm m¹nh thªm cÇn tèn <c=g>" .. costvalue[lv] .. "<color>®iÓm s­ ®å. X¸c ®Þnh c­êng hãa Quy Ch©n KÝnh chø?", "enhance_confirm", "no")
        else
            Talk(1, "no", "Quy Ch©n KÝnh lµm m¹nh thªm cÇn tèn <c=g>" .. costvalue[lv] .. "<c> ®iÓm s­ ®å, ng­¬i kh«ng ®ñ ®iÓm th× ph¶i!")
        end
    elseif (lv >= 3) and (lv < 5) then
        local prcost = costvalue[lv][1]
        local str = costvalue[lv][3]
        if (GetMasterPRValue() >= prcost) then
            if (GetFactionGlory() >= costvalue[lv][2]) then
                MsgBox("C­êng hãa <c=yel>Quy Ch©n KÝnh<c> sÏ tiªu hao <c=g>" .. prcost .. "<c> ®iÓm s­ ®å. §ång ý chø?", "enhance_confirm", "no")
            else
                Talk(1, "no", "C­êng hãa Quy Ch©n KÝnh nµy cÇn Danh väng S­ m«n ®¹t ®Õn <c=g>" .. str .. "<c>, ng­¬i hiÖn ch­a ®ñ yªu cÇu!")
            end
        else
            Talk(1, "no", "Quy Ch©n KÝnh lµm m¹nh thªm cÇn tèn <c=g>" .. prcost .. "<color> ®iÓm s­ ®å, ng­¬i hiÖn ch­a ®ñ. Vµ Danh väng S­ m«n ph¶i ®¹t <c=g>" .. str .. "<c>.")
        end
    elseif (lv == 0) then
        Talk(1, "no", 14189)
    else
        Talk(1, "no", 14190)
    end
end

function enhance_confirm()
    local lv = GetItemLevel2(0, 4, 33)
    local costvalue = { 70, 70, 100, 80 }
    if (lv == 0) then
        Talk(1, "no", 14189)
    elseif (lv == 3) then
        DelItem2(0, 4, 33, lv)
        AddNormalItem(0, 4, 33, lv + 1, 0, 0)
        DecMasterPRValue(costvalue[lv])
        Talk(1, "no", 14191)
        AddGlobalCountNews("ChØ thÊy Hoµng Phi Hæ ph¸t ra 1 luång s¸ng, <c=g>" .. GetName() .. "<c> nhËn ®­îc <c=g>Th¸i Cùc Quy Ch©n KÝnh<c>", 20)
    elseif (lv == 4) then
        DelItem2(0, 4, 33, lv)
        AddNormalItem(0, 4, 33, lv + 1, 0, 0)
        DecMasterPRValue(costvalue[lv])
        Talk(1, "no", "Chóc mõng! Quy Ch©n KÝnh ®· trë thµnh <color=yellow>V« Cùc Quy Ch©n KÝnh<color>!")
        AddGlobalCountNews("ChØ thÊy Hoµng Phi Hæ ph¸t ra 1 luång s¸ng, <c=g>" .. GetName() .. "<color>nhËn ®­îc ChÝ T«n Ph¸p b¶o<color=green>V« Cùc Quy Ch©n KÝnh<color>", 20)
    else
        DelItem2(0, 4, 33, lv)
        AddNormalItem(0, 4, 33, lv + 1, 0, 0)
        DecMasterPRValue(costvalue[lv])
        Talk(1, "no", 14192)
    end
end

function judge_relation()
    local mark = 0
    if (GetTeam() ~= 0) then
        if (GetTeamSize() == 2) then
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            mark = IsMasterPRRelation(n)

            if (mark == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = 0
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function step_complete()
    local mark = 0
    local masterid = -1
    if (GetTeamSize() == 2) then
        local n = 0
        if (IsCaptain() == 0) then
            n = GetTeamMember(1)
        else
            n = GetTeamMember(2)
        end ;
        mark = IsMasterPRRelation(n)

        if (mark == 1) then
            local oldPlayer = PlayerIndex
            PlayerIndex = n
            masterid = GetPlayerID()
            PlayerIndex = oldPlayer
        end
    end
    mark = 0
    for i = 1, 4 do
        if (GetTask(1367 + i) == masterid) or ((GetTask(898 + i) == 7) and (GetTask(1367 + i) == 0)) then
            mark = mark + 1
        end
    end
    return mark
end

function chushi()

    if (GetLevel() >= 50) and (judge_relation() == 1) and (step_complete() >= 2) then
        if (GetTask(1008) == 0) then
            if (iscan_shengxian() == 1) then
                if (GetTask(905) < 9) and (HaveIBBuff(217) == 0) then
                    MsgBox(14193, "PM_shengxian", "no")
                elseif (GetTask(905) == 9) then
                    MsgBox(14194, "PM_shengxian_end_in10", "no")
                else
                    Talk(1, "no", 14195)
                end
            else
                Talk(1, "no", "HuÊn luyÖn ®Ö tö ®©u thÓ qua loa, ®Ö tö xuÊt s­ cµng lµ chuyÖn träng ®¹i. H«m nay s­ phô ng­¬i ®· d¹y cho ®Ö tö ngé ®­îc ®¹o th¸nh hiÒn, nh­ng thêi gian ng­¬i gia nhËp s­ m«n ch­a l©u, kh«ng thÓ l·nh ngé sù diÖu kú cña th¸nh hiÒn, vµi ngµy sau h·y ®Õn!")
            end
        else
            Talk(1, "no", 14198)
        end
    elseif (GetLevel() > 50) and (judge_relation() == 1) and (IsMaster() == 0) then
        if (GetTask(1008) == 0) then
            MsgBox(14196, "PM_wuming_end", "no")
        else
            MsgBox("Hoµng Phi Hæ: ÄãÃÇÊÇ·ñÒªÇ¿ÖÆ½â³ýÊ¦Í½¹ØÏµ, Õâ¸öÃ»ÓÐÈÎºÎ½±Àø, Ò²Ã»ÓÐÈÎºÎ´¦·£, ÏÖÔÚÒª½â³ý sao?", "PM_jiechu_end", "no")
        end
    else
        Talk(2, "no", 14197, "§Ö tö lín h¬n cÊp 50 cã thÓ xuÊt s­, nÕu gÆp vÊn ®Ò trong nhiÖm vô s­ ®å ta cã thÓ lµm nghi thøc ®¬n gi¶n cho xuÊt s­.")
    end

end

function iscan_shengxian()
    local oldPlayer = PlayerIndex
    local master = -1
    if (GetTeamSize() == 2) then
        if (IsCaptain() == 0) then
            master = GetTeamMember(1)
        else
            master = GetTeamMember(2)
        end ;
        PlayerIndex = master
    else
        return 0
    end
    local local_day = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTask(1372)
    PlayerIndex = oldPlayer
    if (local_day ~= lastday) then
        return 1
    elseif ((50 - GetTask(1196)) >= 10) then
        return 1
    end
    return 0
end

function getrateindex()
    local name
    local oldPlayer = PlayerIndex
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    PlayerIndex = n
    name = GetName()
    PlayerIndex = oldPlayer
    return name
end

function PM_jiechu_end()
    CloseDialog()
    local mark = judge_relation()
    if (mark == 1) then
        TaskNote(42, -1)
        TaskNote(43, -1)
        TaskNote(44, -1)
        TaskNote(45, -1)
        TaskNote(46, -1)
        local PRExname = getrateindex()
        local v, prv = 0, 0
        UnMasterPREx(PRExname, 1, 0)
        local oldPlayer = PlayerIndex
        for i = 1, 2 do
            PlayerIndex = GetTeamMember(i)
            SetTask(895, 0)
            SetTask(896, 0)
            SetTask(897, 0)
            SetTask(898, 0)
            SetTask(899, 0)
            SetTask(900, 0)
            SetTask(901, 0)
            SetTask(902, 0)
            SetTask(904, 0)
            SetTask(905, 0)
            SetTask(906, 0)
            SetTask(907, 0)
            SetTask(1196, 0)
            SetTask(1008, 1)
            Msg2Player("Ê¦Í½¹ØÏµ½â³ýÍê³É!")
            v = GetFactionGlory()
            prv = GetMasterPRValue()
            WriteLog("[Ê¦Í½][Ç¿ÖÆ½â³ý³öÊ¦][Ô­ÓÐÍþÍû" .. v .. "][Ô­ÓÐ®iÓm s­ ®å" .. prv .. "]¹ØÏµÈË: " .. PRExname)
        end
        PlayerIndex = oldPlayer
    else
        Talk(1, "no", "±ØÐëÁ½¸öÈËÒ»ÆðÀ´²ÅÄÜ½â³ýÊ¦Í½¹ØÏµ!")
    end
end

function PM_wuming_end()
    CloseDialog()
    local mark = judge_relation()
    if (mark == 1) then
        TaskNote(42, -1)
        TaskNote(43, -1)
        TaskNote(44, -1)
        TaskNote(45, -1)
        TaskNote(46, -1)
        UnMasterPREx(getrateindex(), 1, 0)
        local oldPlayer = PlayerIndex
        for i = 1, 2 do
            PlayerIndex = GetTeamMember(i)
            SetTask(895, 0)
            SetTask(896, 0)
            SetTask(897, 0)
            SetTask(898, 0)
            SetTask(899, 0)
            SetTask(900, 0)
            SetTask(901, 0)
            SetTask(902, 0)
            SetTask(904, 0)
            SetTask(905, 0)
            SetTask(906, 0)
            SetTask(907, 0)
            SetTask(1196, 0)
            SetTask(1008, 1)

            Msg2Player("Hoµn thµnh nghi thøc xuÊt s­!")
            WriteLog("[Ê¦Í½][ÎÞÃû³öÊ¦]")
        end
        PlayerIndex = oldPlayer
    else
        Talk(1, "no", 14199)
    end
end

function PM_shengxian()
    RemoveIBBuff(217)
    local done = AddIBBuff(217)
    if (done == 1) then
        SetTask(905, 1)
        TaskNote(47, GetTask(905) - 1)
        CloseDialog()
    else
        Talk(1, "no", 14200)
    end
end

function PM_shengxian_end_in10()
    CloseDialog()
    MsgBox(" Tr¶i qua v« sè kh¶o nghiÖm cuèi cïng ng­¬i còng ®· xuÊt s­! Rêi t©n thñ th«n còng ®· l©u råi ®ã, h·y vÒ th¨m l¹i chèn cò ®i! Sau nµy cÇn chØ dÉn g× h·y t×m Qu©n s­ ë T©n thñ th«n nhÐ!", "toXinShou", "no")

end

function PM_shengxian_end_in11()
    CloseDialog()

    local mark = judge_relation()
    if (mark == 1) then
        if (GetTeamSize() == 2) then

            local n = 0

            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            TeamAction("askMaster", n, 0, 0)
        end
    else
        Talk(1, "no", 14199)
    end
end

function askMaster(nParam)

    if (nParam == PlayerIndex) then
        MsgBox("B¹n ®· cã thÓ ®­a ®å ®Ö nµy thµnh XuÊt s¬n §Ö tö, <c=r>hai ng­êi sÏ vÉn b¶o l­u quan hÖ S­ m«n<c>. Mét s­ phô nhËn ®­îc 10 XuÊt s¬n §Ö tö. B¹n cã muèn ®­a hÕt ®Ö tö vµo danh s¸ch <c=g>XuÊt s¬n §Ö tö<c>?", "yes_in10", "no_in10")
    else
        CloseDialog()
    end

end

function toXinShou()
    CloseDialog()
    if (GetTask(907) ~= 100) then
        SetTask(907, 10)
        if (GetPlayerType() == 0) then
            TaskNote(47, 10)
        elseif (GetPlayerType() == 1) then
            TaskNote(47, 11)
        elseif (GetPlayerType() == 2) then
            TaskNote(47, 12)
        else
            TaskNote(47, -1)
            SetTask(907, 0)
        end
    end
    PM_shengxian_end_in11()
end

function yes_in10()
    CloseDialog()
    local num = GetHistoryPrenticeCount()
    if (num < 10) then
        PM_shengxian_end(1)
    else
        Talk(1, "no", "B¹n ®· cã ®ñ 10 ®Ö tö t©m ®¾c råi, kh«ng thÓ thu thªm XuÊt s¬n §Ö tö")
    end
end

function no_in10()
    CloseDialog()
    PM_shengxian_end(0)
end

function PM_shengxian_end(kind)
    local mark = judge_relation()
    if (mark == 1) then
        local checklv = 0
        local name = ""
        local oldPlayer = PlayerIndex
        local key = 0
        if (HaveNormalItem(6, 1, 361, 1) > 0) then
            key = 1
        end

        if (GetTeamSize() == 2) then
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            PlayerIndex = n
            checklv = GetTask(1196)
            name = GetName()
            if (key == 1) and (HaveNormalItem(6, 1, 362, 1) > 0) then
                key = 2
            end
            shengxian_end_P(kind, key)
        end
        PlayerIndex = oldPlayer
        shengxian_end_M(checklv, name, key)

    else
        Talk(1, "no", 14199)
    end
end

function shengxian_end_P(kind, kard)
    RemoveIBBuff(217)
    local mname = getrateindex()
    if (kard == 2) then
        SetFriendFellowShipValue(mname, 100 * 100)
        Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    end
    UnMasterPREx(mname, 1, kind)
    local exp = 1000000

    local y, m, d = GetYMD()
    local expStr = "Chóc mõng hoµn thµnh nghi thøc xuÊt s­ sau cïng vµ nhËn " .. exp .. " ®iÓm kinh nghiÖm"
    if (y == 2014) and ((m == 5 and d >= 23) or (m == 6 and d <= 22) and (GetGameServerName() == "Trôc Léc Trung Nguyªn")) then
        exp = math.floor(exp * 2)
        expStr = "Chóc mõng hoµn thµnh nghi thøc xuÊt s­ sau cïng vµ nhËn " .. exp .. " ®iÓm kinh nghiÖm (thêi gian ho¹t ®éng nhËn thªm" .. (exp - 1000000) .. " ®iÓm kinh nghiÖm)"

        AddNormalItemBind(8, 162, 3, 1, 0, 0, 1)
        AddNormalItemBind(8, 163, 4, 1, 0, 0, 1)
        Msg2Player("Thêi gian ho¹t ®éng hoµn thµnh nghi thøc xuÊt s­ sau cïng, nhËn thªm Sinh MÖnh Thanh Lé vµ Ch©n KhÝ.")
    end
    Msg2Player(expStr)
    WriteLog("[Th¸nh HiÒn XuÊt S­][S­ §å][NhËn" .. exp .. " ®iÓm kinh nghiÖm][S­: " .. mname .. "]")

    AddOwnExp(exp)
    if (GetTask(903) == 0) then
        AddNormalItem(0, 4, 33, 1, 0, 0)
        SetTask(903, 1)
    end
    local i
    for i = 895, 902 do
        SetTask(i, 0)
    end

    for i = 904, 906 do
        SetTask(i, 0)
    end
    SetTask(1196, 0)
    SetTask(1008, 1)
    TaskNote(42, -1)
    TaskNote(43, -1)
    TaskNote(44, -1)
    TaskNote(45, -1)
    TaskNote(46, -1)

    if (IsTongMember() == 1) then
        AddIBBuff(221)
    end
    Msg2CurMapAnnounce("<color=green>" .. GetName() .. "<c> thuËn lîi xuÊt s­, Hoµng Phi Hæ tÆng <c=g>L­ìng Nghi Quy Ch©n KÝnh<c> cho 2 s­ ®å.")
    CloseDialog()
end

function shengxian_end_M(checklv, pname, kard)
    ModifyFactionGlory(5)
    Msg2Player("B¹n t¨ng thªm 5 ®iÓm Danh väng S­ m«n!")
    if (GetTask(903) == 0) then
        AddNormalItem(0, 4, 33, 1, 0, 0)
        SetTask(903, 1)
    end
    local prValue = 0
    local addPRValue = 0
    if (GetTask(1196) == 0) then
        prValue = 15
    else
        if (GetTask(1196) ~= checklv) then
            prValue = 5
        else
            local value = 5 + math.floor(2 * (50 - checklv) / 3)
            local key = GetFriendFellowShipValue(pname)
            if (key >= 720 * 100) then
                value = value + 30
            elseif (key >= 84 * 100) then
                value = value + 5
            end
            prValue = value
        end
    end
    local y, m, d = GetYMD()
    local prValueStr = ""

    if (y == 2014) and ((m == 5 and d >= 23) or (m == 6 and d <= 22) and (GetGameServerName() == "Trôc Léc Trung Nguyªn")) then
        addPRValue = AddMasterPRValue(prValue * 2)
        if (addPRValue > prValue) then
            prValueStr = "Th¸nh HiÒn XuÊt S­, nhËn" .. prValue .. " ®iÓm s­ ®å (thêi gian ho¹t ®éng nhËn thªm" .. (addPRValue - prValue) .. " ®iÓm s­ ®å)"
        else
            prValueStr = "Th¸nh HiÒn XuÊt S­, nhËn" .. addPRValue .. " ®iÓm s­ ®å"
        end
    else
        addPRValue = AddMasterPRValue(prValue)
        prValueStr = "Th¸nh HiÒn XuÊt S­, nhËn" .. addPRValue .. " ®iÓm s­ ®å"
    end
    TopMessage("Th¸nh HiÒn XuÊt S­, nhËn" .. addPRValue .. " ®iÓm s­ ®å")
    WriteLog("[Th¸nh HiÒn XuÊt S­][S­ Phô][NhËn" .. addPRValue .. " ®iÓm s­ ®å][§Ö Tö" .. pname .. "]")

    Msg2Player(prValueStr)

    local i
    for i = 895, 902 do
        SetTask(i, 0)
    end

    for i = 904, 907 do
        SetTask(i, 0)
    end
    SetTask(1196, 0)
    SetTask(1008, 1)
    SetTask(1372, math.floor(LocalSystemTime() / 86400))
    TaskNote(47, -1)
    if (IsTongMember() == 1) then
        AddIBBuff(221)
    end

    if (kard == 2) then
        Msg2Player("§é th©n mËt gi÷a b¹n vµ §å ®Ö t¨ng thªm")
    end
end

function lingpai()
    Talk(2, "no", "<color=green>" .. GetName() .. "<color>: Kh¶i bÈm ®¹i nh©n! Cöu C«ng lÖnh cho t¹i h¹ ®Õn BÊt Chu Thiªn quan dß th¸m t×nh h×nh. T¹i h¹ ®Õn ®©y ®Ó nhËn <color=yellow>Th«ng quan lÖnh bµi<color>. §©y lµ Binh phï cña Cöu C«ng", "Ng­¬i mau ®Õn <c=r>TrÇn §­êng<c> t×m <c=g>Lý TÞnh<c>. ¤ng ta sÏ ®­a ®Õn <c=r>¶i Giai Méng<c>.")
    SetTask(597, 5)
    TaskNote(35, 5)
    DelEventItem(106)
    AddEventItem(107)
    AddCredit(10)
    AddOwnExp(4000)
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
    TopMessage(13051)
    Msg2Player("NhËn ®­îc Th«ng hµnh lÖnh!")

    Msg2Player("§Õn TrÇn §­êng t×m Lý TÞnh.")
end;

function renwu1()
    Talk(3, "no", 10051, 10052, 10053)
    DelEventItem(45)
    AddNormalItem(7, 59, 128, 1, 0, 0)

    AddOwnExp(80000)
    Msg2Player("Giao gç trÇm h­¬ng cho Hoµng Phi Hæ, nhËn s¸ch Ban M«n Léng Phñ vµ 80000 kinh nghiÖm.")
    TopMessage(11939)
    SetTask(3, 20)
    TaskNote(27, 4)

    refreshNpcTaskState()


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

function renwu2()
    local mark = fangchenmi()
    if (mark == 1) then
        UTask_Knight = GetTask(3);
        if (UTask_Knight == 26) and (HaveEventItem(12) >= 1) then
            Talk(1, "no", 10054)
            Msg2Player("B¸o cho Kh­¬ng Tö Nha viÖc Hoµng Phi Hæ muèn vÒ ®Çu qu©n.")
            DelEventItem(12)
            SetTask(3, 27)
            TaskNote(27, 11)

            refreshNpcTaskState()

        end ;
        if (GetLevel() >= 45) and (UTask_Knight == 24) then
            Talk(3, "no", 10055, 10056, 10057)
            SetTask(3, 25)
            Msg2Player("Gióp Hoµng Phi Hæ ®o¹t Ên tÝn.")
            TaskNote(27, 9)

            refreshNpcTaskState()

        end ;
        if (GetLevel() >= 45) and (UTask_Knight == 20) and (GetPlayerType() == 0) then
            Talk(1, "no", 10058)
            SetTask(3, 21)
            Msg2Player("§i th«ng b¸o cho §Æng Cöu C«ng vµ Lý TÞnh")
            TaskNote(27, 5)

            refreshNpcTaskState()

        end ;
    else
        Talk(1, "no", 11718)
    end
end;

function renwu3()
    UTask_Wizard = GetTask(1);
    if (UTask_Wizard == 10) then
        Talk(3, "no", 10059, 10060, 10168)
        SetTask(1, UTask_Wizard + 1)
        Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
        TaskNote(28, 4)
    elseif (UTask_Wizard == 12) then
        Talk(3, "no", 10059, 10060, 10168)
        SetTask(1, UTask_Wizard + 1)
        Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
        TaskNote(28, 6)
    elseif (UTask_Wizard == 14) then
        Talk(3, "no", 10059, 10060, 10168)
        SetTask(1, UTask_Wizard + 1)
        Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
        TaskNote(28, 8)
    elseif (UTask_Wizard == 16) then
        Talk(3, "no", 10059, 10060, 10168)
        SetTask(1, UTask_Wizard + 1)
        Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
        TaskNote(28, 9)
    end ;

    refreshNpcTaskState()


end;

function renwu4()
    if (CanMasterPR() == 1) then
        if (GetLevel() < 30) then
            SetTask(333, 1)
            local i = PlayerIndex
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            PlayerIndex = n
            Msg2Player("Thµnh viªn trong nhãm muèn b¸i b¹n lµm su phô")
            PlayerIndex = i
            MsgBox(10698, "no")
        elseif ((GetLevel() >= 50) and (GetMateTask(333) == 0)) then
            MsgBox(10699, "no")
        elseif ((GetLevel() >= 50) and (GetMateTask(333) == 1)) then
            MsgBox(10700, "yes_PR", "no_PR")
        end ;
    else
        MsgBox(10701, "no")
    end ;
end;

function yes_PR()
    if (CanMasterPR() == 1) then
        DoMasterPR()
        CloseDialog()
    else
        MsgBox(10701, "no")
    end ;
end;

function no_PR()
    if (CanMasterPR() == 1) then
        SetMateTask(333, 0)
        local i = PlayerIndex
        local n = 0
        if (IsCaptain() == 0) then
            n = GetTeamMember(1)
        else
            n = GetTeamMember(2)
        end ;
        PlayerIndex = n
        Msg2Player("B¹n kh«ng ®­îc chÊp thuËn lµm ®å ®Ö!")
        PlayerIndex = i
        Msg2Player("B¹n tõ chèi nhËn s­ ®å")
        CloseDialog()
    else
        Msg2Player("§èi ph­¬ng ®· rêi khái ®éi ngò!")
        CloseDialog()
    end ;
end;

function renwu5()
    if (GetExtPoint(0) <= 0) then
        MsgBox(11421, "no")
    else
        if (CanChangeMasterPRValue() == 1) then
            if (GetLevel() < 50) then
                ChangeMasterPRValue()
                MsgBox(10702, "no")
            else
                Msg2Player("S­ phô kh«ng thÓ nhËn ®iÓm s­ ®å!")
                CloseDialog()
            end ;
        else
            Msg2Player("Kh«ng ®ñ ®iÒu kiÖn nhËn, lÇn sau quay l¹i!")
        end ;
    end ;
end;

function no()
    CloseDialog()
end;

function renwu6()
    Say(10703, 6, "§æi Lam b¶o th¹ch (tèn 50 ®iÓm)/lbs", "§æi Hång b¶o th¹ch (tèn 20 ®iÓm)/hbs", "§æi m¶nh Hoµng thñy tinh (tèn 5 ®iÓm)/hsj", "§æi tiÒn/jq", "§æi kinh nghiÖm/jy", "Th«i! LÇn sau quay l¹i/no")
end;

function hsj()
    if (GetMasterPRValue() >= 10) then
        DecMasterPRValue(5)
        AddNormalItem(3, 88, 0, 0, 1, 0)
        MsgBox(14201, "no")
    else
        MsgBox(14202, "no")
    end ;
end;

function lbs()
    if (GetMasterPRValue() >= 50) then
        DecMasterPRValue(50)
        AddNormalItem(3, 41, 0, 0, 1, 0)
        MsgBox(10704, "no")
    else
        MsgBox(10705, "no")
    end ;
end;

function hbs()
    if (GetMasterPRValue() >= 20) then
        DecMasterPRValue(20)
        AddNormalItem(3, 79, 0, 0, 1, 0)
        MsgBox(10706, "no")
    else
        MsgBox(10707, "no")
    end ;
end;

function jq()
    local money = 1000 * GetMasterPRValue()
    DecMasterPRValue(GetMasterPRValue())
    Earn(money)
    MsgBox("Ng­¬i nhËn ®­îc <c=r>" .. money .. "<c>!", "no")
end;

function jy()
    local exp = 1000 * GetMasterPRValue()
    DecMasterPRValue(GetMasterPRValue())
    AddOwnExp(exp)
    MsgBox("Ng­¬i nhËn ®­îc <c=r>" .. exp .. "<c> ®iÓm kinh nghiÖm!", "no")
end;

function mpsale()
    CloseDialog()
    OpenMPSale(30)
end

function help()
    CloseDialog()
    MsgBox(" Mang theo <c=g>Nh©n NghÜa ThiÕp<c>, mêi theo nh÷ng ng­êi ®· tõng gióp ng­¬i, cã t­ c¸ch nhËn §iÓm nh©n nghÜa cïng ®Õn ®©y. X¸c nhËn ®ång ®éi nµy chÝnh lµ ng­êi ng­¬i muèn tÆng §iÓm nh©n nghÜa?", "Yes_help", "no")
end

function Yes_help()
    CloseDialog()
    if (iscanhelp() == 1) then
        local oldPlayer = PlayerIndex
        local playername = GetName()
        if (PlayerIndex == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end
        if (GetFriendFellowShipValue(playername) < 72000) then
            Msg2Team("Quan hÖ gi÷a hai ng­êi ch­a ®¹t ®Õn Th©n MËt V« Gian")
            return
        end
        PlayerIndex = oldPlayer
        if (HaveNormalItem(3, 1066, 0, 0) ~= 0) then
            DelNormalItem(3, 1066, 0, 0)
            if (PlayerIndex == GetTeamMember(1)) then
                PlayerIndex = GetTeamMember(2)
            else
                PlayerIndex = GetTeamMember(1)
            end
            AddHelpScore(10)
            Msg2Player("B¹n nhËn ®­îc 10 §iÓm nh©n nghÜa")
            Talk(1, "no", " §©y lµ phÇn th­ëng <c=g>10<c> §iÓm nh©n nghÜa tÆng ng­¬i, cã thÓ miÔn gi¶m khi nhËn vµi nhiÖm vô cã thu phÝ, cã thÓ ®æi b¹c ë Qu©n s­ t¹i t©n thñ th«n. Hy väng ng­¬i sÏ tiÕp tôc gióp ®ì ng­êi kh¸c.")
            PlayerIndex = oldPlayer
            Msg2Player("TÆng Nh©n NghÜa ThiÕp")
            Talk(1, "no", " §· thµnh c«ng t¨ng §iÓm nh©n nghÜa cho b»ng h÷u cña ng­¬i. Hy väng c¸c ng­¬i sÏ tiÕp tôc gióp ®ì ng­êi kh¸c.")
        end
    end
end

function iscanhelp()
    local nTeam = GetTeamSize()
    if (nTeam ~= 2) then
        Talk(1, "no", "Ph¶i cã hai ng­êi tæ ®éi víi nhau míi cã thÓ ®æi §iÓm nh©n nghÜa.")
        return 0
    end

    local oldPlayer = PlayerIndex
    for i = 1, nTeam do
        PlayerIndex = GetTeamMember(i)
        local w1, x1, y1 = GetWorldPos()

        if (w1 ~= 21 or CheckDis(x1, y1) == 0) then
            Msg2Team(GetName() .. "C¸ch Hoµng Phi Hæ qu¸ xa!")
            return 0
        end

        if (GetLevel() < 60) then
            Msg2Team(GetName() .. "§¼ng cÊp ch­a ®¹t ®¹t 60")
            return 0
        end
    end
    PlayerIndex = oldPlayer
    return 1
end

function CheckDis(nX, nY)
    if ((nX - 1854) ^ 2 + (nY - 2964) ^ 2 < 300 * 300) then
        return 1
    end

    return 0
end

function GetHelpStore()
    if (GetHelpScore() < 30) then
        local str = "Xin lçi, kh«ng ®ñ <c=g>30<c> ®iÓm Nh©n NghÜa, kh«ng thÓ ®æi Nh©n NghÜa Th¹ch. Nh©n NghÜa Th¹ch cã thÓ tÈy ®iÓm PK trªn 7 ®iÓm vÒ 7 ®iÓm. "
        str = str .. "<enter><enter>(hiÖn t¹i cã" .. GetHelpScore() .. " ®iÓm Nh©n NghÜa)"
        Talk(1, "no", str)
        return
    end
    local str = "Khi ®iÓm PK<c=g>trªn 7 ®iÓm<c>, sö dông Nh©n NghÜa Th¹ch gi¶m 7 ®iÓm PK, nh­ng tèi ®a chØ gi¶m vÒ 7 ®iÓm. <enter><enter>§ång ý  tiªu hao <c=g>30<c> ®iÓm Nh©n NghÜa ®èi 1 Nh©n NghÜa Th¹ch? "
    str = str .. "<enter><enter>(hiÖn t¹i cã" .. GetHelpScore() .. " ®iÓm Nh©n NghÜa)"
    MsgBox(str, "YesGetHelpStore", "no")
end
function YesGetHelpStore()
    if (GetHelpScore() < 30) then
        Talk(1, "no", "Xin lçi, kh«ng ®ñ <c=g>30<c> ®iÓm Nh©n NghÜa, kh«ng thÓ ®æi Nh©n NghÜa Th¹ch. Nh©n NghÜa Th¹ch cã thÓ tÈy ®iÓm PK trªn 7 ®iÓm vÒ 7 ®iÓm. ")
        return
    end
    PayHelpScore(30)
    AddNormalItemBind(8, 1629, 2, 1, 0, 0, 1)
    Talk(1, "main", "NhËn ®­îc 1 <c=g>Nh©n NghÜa Th¹ch<c>. ")
end

