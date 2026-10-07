--description:»Æ·É»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11
--³öÊ¦ÈÎÎñ±äÁ¿905,È¨Öµ ÉñÅ©1£¬ò¿ÓÈ2£¬ÐùÔ¯5
--903±ê¼ÇÁìÈ¡¹ýÌØÊâ·¨±¦
--1372¼ÇÂ¼µ±ÌìÊÇ·ñÊ¥ÏÍ³öÊ¦¹ý(0µãË¢ÐÂ)
--1368-1371 ¼ÇÂ¼Íê³ÉÊÔÁ¶Ê±µÄÊ¦¸¸µÄplayerid

-- AS GaoJingwei at 090728


-------------added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ÐòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ðÍê£©; 4th byte µÚ¶þ¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈý¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ðÌâÊýÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ----------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼þÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØÐ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end------------------


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

    --æäÂ·³ÁÏã
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

    --Æú°µÍ¶Ã÷
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

    --´óÊÆËùÇ÷
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

--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
Task_State = 1710    -- ¼ÇÂ¼ÈÎÎñ×´Ì¬
-- 1Byte£ºÈÎÎñ±àºÅ (1-3)
-- 2Byte:  ÈÎÎñ²½Öè
-- 3Byte:  ½ÓÈÎÎñÊ±¼ä
--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 End

function main()
    tasks = {
        { "TrÇm H­¬ng", "renwu1"; show = 0 },
        { "Khuyªn hµng", "renwu2"; show = 0 },
        { "ThÕ Së", "renwu3"; show = 0 },
        { "B¸i s­", "renwu4"; show = 0 }, --ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
        { "Nh.®iÓm s­ ®å", "renwu5"; show = 0 }, --ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
        { "§æi ®iÓm s­ ®å", "renwu6"; show = 0 }, --ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
        { "Th«ng hµnh lÖnh", "lingpai"; show = 0 },
        { "XuÊt s­", "chushi"; show = 1 },
        { "Quy Ch©n KÝnh", "guizhenjing"; show = 1 },
        { "B¸uvËtS­M«n", "mpsale"; show = 1 },
        { "Nh©n NghÜa HiÖp SÜ", "help"; show = 0 },
        --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
        -- {"ÇåÁ¹ÏÄ¼¾","Cool_Summer";show = 0},
        -- {"·ÅÆúÇåÁ¹ÏÄ¼¾","Drop_Cool_Summer";show = 0},
        --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin


        -- added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},--12
        -- added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end
    }

    UTask_Knight = GetTask(3);
    UTask_Wizard = GetTask(1);
    UT_MPR = GetTask(333);    --1ÇëÇó½¨Á¢Ê¦Í½¹ØÏµ

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
    --			if((CanMasterPR()==1)and(UT_MPR==0))then
    --					tasks[4].show=1;
    --			end;
    --			if(CanChangeMasterPRValue()==1)then
    --					tasks[5].show=1;
    --			end;
    --			if(GetMasterPRValue()>=1)then
    --					tasks[6].show=1;
    --			end;
    if (GetTask(597) == 4) and (HaveEventItem(106) >= 1) then
        tasks[7].show = 1;
    end ;

    if (HaveNormalItem(3, 1066, 0, 0) ~= 0) then
        tasks[11].show = 1;
    end

    --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
    --local nYear, nMonth, nDay = GetYMD();
    --if nYear == 2010 and nMonth == 7 and nDay >= 20 and nDay <= 26 and GetLevel() >= 50 then
    --	if GetTaskByte( Task_State, 1 ) > 0 and GetTaskByte( Task_State, 3 ) == nDay then
    --		tasks[12].show = 0;
    --	else
    --		tasks[12].show = 1;
    --	end

    --	if ( GetTaskByte( Task_State, 1 )>= 10 and GetTaskByte( Task_State, 1 ) < 19  and GetTaskByte( Task_State, 3 ) == nDay) then
    --		tasks[13].show = 1;
    --	end
    --end
    --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 End

    --added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin
    --~                     local year, month, day = GetYMD();
    --~                     local hour, min, second = GetHMS();
    --~                     local today = mod(floor(LocalSystemTime()/86400), 255) + 1;

    --~                     local TaskStep = GetTaskByte(TASK_ThreeYears_Fireworks, 1);
    --~                     local TaskTime = GetTaskByte(TASK_ThreeYears_Fireworks, 2);
    --~                     
    --~                     --Çå¿ÕÖ®Ç°µÄÈÎÎñ£¬ÒÔ·ÀbuffendÎ´Ö´ÐÐ
    --~                     if (TaskTime > 0 and TaskTime ~= today) then
    --~                         TaskStep = 0;
    --~                         TaskTime = 0;
    --~                         SetTask(TASK_ThreeYears_Fireworks, 0);
    --~                         SetTask(TASK_ThreeYears_Questions, 0);
    --~                     end
    --~                     
    --~                      if (year == 2010 and month == 8 and day == 28
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[12].show = 1;
    --~                     end
    --added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end

    SayTask(10050, tasks)
end;

--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
function Drop_Cool_Summer()
    no()
    MsgBox(" X¸c nhËn muèn hñy nhiÖm vô?", "Drop_Cool_Summer1", "no");
end

function Drop_Cool_Summer1()
    no()
    SetTaskByte(Task_State, 1, 19);        --ÈÎÎñ²½Öè1
    RemoveIBBuff(1311);
    RemoveIBBuff(1312);
    TaskNote(1606, -1);
end

function Cool_Summer()
    no();
    MsgBox("Nghe nãi Trô V­¬ng ®ang thu thËp b¸u vËt tr¸nh nãng? Muèn cã <c=yel>Thanh L­¬ng T¸n<c>, chØ cÇn tr­íc khi tr¹ng th¸i <c=yel>Thanh Phong Chó<c> biÕn mÊt, ®Õn <c=g>§«ng H¶i Thñy Vùc<c> hµng phôc <c=fire>Háa Ng­<c> hoÆc <c=fire>Lôc Quy<c> lµ cã thÓ lÊy ®­îc. Thanh Phong Chó chØ duy tr× <c=yel>30 phót<c>, h·y cÊp tèc lªn ®­êng. NÕu muèn t×m <c=yel>Tþ Thö Ch©u<c> hoÆc <c=yel>TÈm ThÊp Hoµn<c> cã thÓ ®i t×m <c=g>Tinh Quan<c> hoÆc <c=g>Thiªn Hïng<c>. Mçi ngµy chØ cã thÓ tiÕn hµnh 1 trong 3 nhiÖm vô nµy. Mçi lÇn nhiÖm vô cÇn nép <c=yel>5 v¹n b¹c<c>. NhËn nhiÖm vô chø!", "Cool_Summer_1", "no")
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
    SetTaskByte(Task_State, 1, 10);    --µÚ¶þ¸öÈÎÎñ
    --SetTaskByte(Task_State, 2, 1);		--ÈÎÎñ²½Öè1
    SetTaskByte(Task_State, 3, nDay);--ÈÎÎñ²½Öè1
    SetTaskByte(Task_State, 4, 1);        --´òµ½ÈÎÎñÎïÆ·µÄ¸ÅÂÊ~£¡
    ClearItem(6, 1, 841, 0);
    ClearItem(6, 1, 842, 0);

    RemoveIBBuff(1312);
    RemoveIBBuff(1311);
    RemoveIBBuff(1310);

    AddIBBuff(1311, 30 * 60);
    --AddIBBuff( 1312, 5*60);
    TaskNote(1606, 3);
    WriteLog(" chç Hoµng Phi Hæ nhËn nhiÖm vô Thanh l­¬ng h¹ quý")
    for i = 1711, 1715 do
        SetTask(i, 0);
    end
end
--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 End

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
    Talk(1, "fbsj2_5", "<c=g>V« Cùc Q.C.KÝnh<c>: <enter>VCQCK+Béc Ph¸c Th¹ch+HBTh¹ch+Lß tinh luyÖn S¬ cÊp=VCQCK (1,2,3 th¨ng)<enter>VCQCK+2 BPTh¹ch+HBTh¹ch+Lß tinh luyÖn tr.cÊp=VCQCK (4,5,6 th¨ng)<enter>VCQCK+3 BPTh¹ch+HBTh¹ch+Lß tinh luyÖn c.cÊp=VCQCK (7,8,9 th¨ng)<enter>100% thµnh c«ng")
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
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = 0
    if (GetTeam() ~= 0) then
        -- ÓÐ¶ÓÎé
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
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
    local mark = 0            -- ÓÐ¶ÓÎé
    local masterid = -1
    if (GetTeamSize() == 2) then
        --2ÈË¶Ó
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
    if (GetTask(1008) == 0) then
        if (GetLevel() >= 50) and (judge_relation() == 1) and (step_complete() >= 2) then
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
        elseif (GetLevel() > 50) and (judge_relation() == 1) and (IsMaster() == 0) then
            MsgBox(14196, "PM_wuming_end", "no")
        else
            Talk(2, "no", 14197, "§Ö tö lín h¬n cÊp 50 cã thÓ xuÊt s­, nÕu gÆp vÊn ®Ò trong nhiÖm vô s­ ®å ta cã thÓ lµm nghi thøc ®¬n gi¶n cho xuÊt s­.")
        end
    else
        Talk(1, "no", 14198)
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
    local local_day = floor(LocalSystemTime() / 86400)
    local lastday = GetTask(1372)
    PlayerIndex = oldPlayer
    if (local_day ~= lastday) then
        return 1
    elseif ((50 - GetTask(1196)) >= 10) then
        --Í½µÜÅàÑø¶È
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
            --local addPRValue = AddMasterPRValue(5)
            Msg2Player("Hoµn thµnh nghi thøc xuÊt s­!")
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

---------------¼ÓÈëÈÃÊ¦¸µÑ¡Ôñ------
function PM_shengxian_end_in10()
    CloseDialog()
    MsgBox(" Tr¶i qua v« sè kh¶o nghiÖm cuèi cïng ng­¬i còng ®· xuÊt s­! Rêi t©n thñ th«n còng ®· l©u råi ®ã, h·y vÒ th¨m l¹i chèn cò ®i! Sau nµy cÇn chØ dÉn g× h·y t×m Qu©n s­ ë T©n thñ th«n nhÐ!", "toXinShou", "no")
    --add by luoyixuan
end

function PM_shengxian_end_in11()
    CloseDialog()

    local mark = judge_relation()
    if (mark == 1) then
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó

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

-- add by luoyixuan
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

-----------------------------------

function PM_shengxian_end(kind)
    local mark = judge_relation()
    if (mark == 1) then
        --Âú×ãÊ¦Í½2ÈË¶Ó
        local checklv = 0
        local name = ""
        local oldPlayer = PlayerIndex
        local key = 0
        if (HaveNormalItem(6, 1, 361, 1) > 0) then
            key = 1
        end

        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
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
    --kard ÊÇ·ñÓÐÊ¦Í½¿¨
    RemoveIBBuff(217)
    local mname = getrateindex()
    if (kard == 2) then
        SetFriendFellowShipValue(mname, 100 * 100)
        Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    end
    UnMasterPREx(mname, 1, kind)
    local exp = 1000000
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
    --TaskNote(47,-1)
    if (IsTongMember() == 1) then
        AddIBBuff(221)
    end
    AddGlobalCountNews("<color=green>" .. GetName() .. "<c> thuËn lîi xuÊt s­, Hoµng Phi Hæ tÆng <c=g>L­ìng Nghi Quy Ch©n KÝnh<c> cho 2 s­ ®å.", 20)
    CloseDialog()
end

function shengxian_end_M(checklv, pname, kard)
    --kard ÊÇ·ñÓÐÊ¦Í½¿¨
    ModifyFactionGlory(5)
    Msg2Player("B¹n t¨ng thªm 5 ®iÓm Danh väng S­ m«n!")
    if (GetTask(903) == 0) then
        AddNormalItem(0, 4, 33, 1, 0, 0)
        SetTask(903, 1)
    end
    local addPRValue = 0
    if (GetTask(1196) == 0) then
        addPRValue = AddMasterPRValue(15)
    else
        if (GetTask(1196) ~= checklv) then
            addPRValue = AddMasterPRValue(5)
        else
            local value = 5 + floor(2 * (50 - checklv) / 3)
            local key = GetFriendFellowShipValue(pname)
            if (key >= 720 * 100) then
                value = value + 30
            elseif (key >= 84 * 100) then
                value = value + 5
            end
            addPRValue = AddMasterPRValue(value)
        end
    end
    TopMessage(" th¸nh hiÒn xuÊt s­, nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")

    local i
    for i = 895, 902 do
        SetTask(i, 0)
    end

    for i = 904, 907 do
        SetTask(i, 0)
    end
    SetTask(1196, 0)
    SetTask(1008, 1)
    SetTask(1372, floor(LocalSystemTime() / 86400))--¼ÇÂ¼Ê¥ÏÍ³öÊ¦Ê±¼ä
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
    AddEventItem(107)    --Í¨¹ØÁîÅÆ
    AddCredit(10)--ÉùÍû½±Àø
    AddOwnExp(4000) --¾­Ñé½±Àø
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
    TopMessage(13051)
    Msg2Player("NhËn ®­îc Th«ng hµnh lÖnh!")
    --TopMessage("»ñµÃ<color=green>Í¨¹ØÁîÅÆ<color>")
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
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

end;

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
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        end ;
        if (GetLevel() >= 45) and (UTask_Knight == 24) then
            Talk(3, "no", 10055, 10056, 10057)
            SetTask(3, 25)
            Msg2Player("Gióp Hoµng Phi Hæ ®o¹t Ên tÝn.")
            TaskNote(27, 9)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        end ;
        if (GetLevel() >= 45) and (UTask_Knight == 20) and (GetPlayerType() == 0) then
            Talk(1, "no", 10058)
            SetTask(3, 21)
            Msg2Player("§i th«ng b¸o cho §Æng Cöu C«ng vµ Lý TÞnh")
            TaskNote(27, 5)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
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

    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

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

-- Added by zhaoqingsong at 2008-10-29 Begin
-- Ê¦ÃÅ±¦ÎïÉÌµê

function mpsale()
    CloseDialog()
    OpenMPSale(30)
end
-- Added by zhaoqingsong at 2008-10-29 End

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



--added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ðÌâÊýÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "»Æ·É»¢£ºÓ¢ÐÛ±³°üÖÐÃ»ÓÐÐ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~     
--~     if (idx == 6) then
--~         Talk(1, "no", "»Æ·É»¢£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ýµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("»Æ·É»¢£ºÓ¢ÐÛÆ÷Óî²»·²£¬Ïë±ØÊÇÒ»Î»ºÃÊ¦¸µ¡£½ñÈÕÓ¢ÐÛÈôÄÜ»Ø´ðÎÒµÄÎÊÌâ£¬ÎÒ¾ÍËÍ¸øÓ¢ÐÛÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~     
--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     
--~     local TABLE_Ques = {
--~         [1] = { quest = "Ê®¾øÕóÖÐ£¬ÒÔÏÂÄÄ¸öÕóµôÂäÒìÈË140¼¶¼¼ÄÜÊé±©·çÖèÓê£¿", 
--~                     option = { [1]  = "ºìË®Õó", [2] = "º®±ùÕó", [3] = "»¯ÑªÕó", }, },
--~         [2] = { quest = "Íê³É¸ß¼¶Ê¦ÃÅÈÎÎñ¿ÉÒÔ»ñµÃÒÔÏÂÄÄ¸öÎïÆ·£¿", 
--~                     option = { [1]  = "Í½µÜ¿¨", [2] = "Á½ÒÇ¹éÕæ¾µ", [3] = "Ê¦¶÷Áî", }, },
--~         [3] = { quest = "Ò©²Ä¼Ó¹¤¼¼ÄÜ¿ÉÒÔÔÚÄÄÀïÑ§Ï°£¿", 
--~                     option = { [1]  = "ÓñÐé¹¬Éú»î¼¼Ê¦", [2] = "³¯¸èÉú»î¼¼Ê¦", [3] = "Î÷áªÉú»î¼¼Ê¦", }, },
--~         [4] = { quest = "ÁÙÏÉÂ¶¼ÆÊ±Ð§¹ûÈçºÎÔÝÍ££¿", 
--~                     option = { [1]  = "Ctrl+Êó±ê×ó¼ü", [2] = "Shift+Êó±ê×ó¼ü", [3] = "Alt+Êó±ê×ó¼ü", }, },
--~         [5] = { quest = "²ÎÓëÊ²Ã´»î¶¯¿ÉÒÔ»ñµÃ´ß·æÁî£¿", 
--~                     option = { [1]  = "ÉÌÖÜÕ½³¡", [2] = "¼´Ê±Õ½³¡", [3] = "Ô¶¹ÅÕ½³¡", }, },
--~     }
--~     
--~     local seq = {1,2,3};
--~     local i, j = 0, 0;
--~     local temp = 0;
--~     for i = 1, 2 do
--~         j = random(i, 3);
--~         temp = seq[i];
--~         seq[i] = seq[j];
--~         seq[j] = temp;
--~     end
--~     
--~     local opt1 = TABLE_Ques[idx].option[seq[1]].."/ThreeYears_FireWorks_Option"..seq[1];
--~     local opt2 = TABLE_Ques[idx].option[seq[2]].."/ThreeYears_FireWorks_Option"..seq[2];
--~     local opt3 = TABLE_Ques[idx].option[seq[3]].."/ThreeYears_FireWorks_Option"..seq[3];
--~     
--~     Say("»Æ·É»¢£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

--~ end


--~ function ThreeYears_FireWorks_Option1()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(1);
--~ end


--~ function ThreeYears_FireWorks_Option2()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(2);
--~ end


--~ function ThreeYears_FireWorks_Option3()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(3);
--~ end


--~ function ThreeYears_FireWorks_Judge(choice)
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 1, [2] = 3, [3] = 3, [4] = 1, [5] = 2,};
--~     
--~     if (TABLE_Key[idx] == choice) then
--~     
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "»Æ·É»¢£ºÓ¢ÐÛËäÈ»´ð¶ÔÁËÌâÄ¿£¬µ«±³°üÖÐÃ»ÓÐÐ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "»Æ·É»¢£ºÓ¢ÐÛ¹ûÈ»²ÅÖÇ¹ýÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ÐÛÁË¡£");
--~         
--~         SetTaskByte(TASK_ThreeYears_Questions, 2, 6); --µ±Ç°NPCµÄÌâÄ¿
--~         
--~         SetTaskByte(TASK_ThreeYears_Questions, 4, num + 1);

--~         DelNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0); 
--~         AddNormalItem(8, G_ThreeYears_1stFireworksId + num + 1, 2, 0, 0, 0);

--~         if (num + 1 < 5) then
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË"..(num + 1).."·Ý×£¸£");
--~         else
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË×ã¹»µÄ×£¸£");
--~             WriteLog("»ñµÃÒ»¸öÂúÔØ×£¸£µÄÀñ»¨¡£");
--~             TaskNote(1610, 1);
--~         end
--~         
--~     else
--~         Talk(1, "no", "»Æ·É»¢£ºÄãµÄ´ð°¸²»¶Ô£¬ÇëÖØÐÂ×÷´ð¡£");
--~     end

--~ end
--added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end



