--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/9


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


-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--Add by guoqun 2009-11-20 begin--
Task_Xitie = 1628      --1Bit 0Ã»ÓÐ½ÓÏ²ÌûÈÎÎñ 1ÒÑ¾­½ÓÏ²ÌûÈÎÎñ
--3Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæ§¼º£¬²¢ÇÒµÃµ½ÌØÐ§


Task_MarryState = 800   --1Byte¼ÇÂ¼Íæ¼Ò½á»é×´Ì¬ 0ÎÞ²Ù×÷,1½øÈëÇó»é×´Ì¬£¬2½øÈë¶©»é×´Ì¬
--2Byte¼ÇÂ¼»éÀñÀàÐÍ 1ÆÕÍ¨ÐÍ 2¾«Æ·ÐÍ(°ÙÄêºÃºÏ) 3ºÀ»ªÐÍ£¨Áú·ï³ÊÏé£©
--3Byte±ê¼ÇÍæ¼ÒÊÇ·ñ¾Ù°ìÁË»éÀñ,ÒÔ¼°»éÀñ½ø¶È 0Ã»ÓÐÁìÈ¡¾Ù°ì»éÀñÈÎÎñ 1´ÓÎ÷ÍõÄ¸´¦¿ªÆô¾Ù°ì»éÀñ(¿ªÊ¼ÓÎ½Ö) 2Íê³ÉÓÎ½Ö£¨¿ÉÒÔÖÖÊ÷ÁË£© 3ÒÑ¾­ÖÖÊ÷ 4ÄÐ·½Çìµä¿ªÊ¼ 5Å®·½Çìµä¿ªÊ¼(Ò»°ÝÌìµØ) 6¶þ°Ý¸ßÌÃ 7·òÆÞ¶Ô°Ý 8Íê³É»éÀñ
Task_Partner = 801      --°éÂÂÍæ¼ÒÃû×ÖID
JiehunItem = {
    [1] = { name = "ThiÖp mõng", Item = { 3, 1068, 0, 0, 0, 0 } }, --¼ÓÒ»¸öÐ¡ÉúÃüÇåÂ¶
    [2] = { name = "Tói quµ 10 ThiÖp mõng", Item = { 6, 1, 777, 0, 0, 0 } },
    [3] = { name = "ThiÖp mêi", Item = { 3, 1067, 0, 0, 0, 0 } }, --¼ÓÒ»¸öÖÐ¼¶¾«Ê¯
}

NpcName = { "Trô V­¬ng", "§¾c Kû", "NguyÖt L·o", "Vâ V­¬ng", "ThÓ V©n" }
--Add by guoqun 2009-11-20 end--

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

    --Æ½°²ÀÖÍÁ
    startLevel = 65
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 40) or (taskWizard == 40) or (taskDruid == 40) then
                state = 1
                subState = 0
            end
        else
            if (taskKnight == 40) or (taskWizard == 40) or (taskDruid == 40) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Èý²ßÆ½ÌìÏÂ
    startLevel = 75
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 60) and (HaveEventItem(13) >= 1)) or ((taskWizard == 60) and (HaveEventItem(2) >= 1)) or ((taskDruid == 60) and (HaveEventItem(19) >= 1)) then
                state = 1
                subState = 0
            end
        else
            if ((taskKnight == 60) and (HaveEventItem(13) >= 1)) or ((taskWizard == 60) and (HaveEventItem(2) >= 1)) or ((taskDruid == 60) and (HaveEventItem(19) >= 1)) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

Task_Get_Fragment = 1520 --1byte: Ê°È¡ÖÐËéÆ¬³É¹¦±ê¼Ç 2byte:Ê°È¡´óËéÆ¬³É¹¦±ê¼Ç 3byte:¼ÇÂ¼Íæ¼Ò½»ËéÆ¬¸öÊý 4byte:¼ÇÂ¼µ±Ç°»î¶¯³¡´Î
Task_Get_Fragment1 = 1524 --¼ÇÂ¼ÉÏ´Î²Î¼Ó»î¶¯Ê±¼ä
Task_Tong_Fragment = 11 --¼ÇÂ¼¹ú¼Ò»ñµÃ·ÖÊý
Task_Tong_Fragment1 = 12 --¼ÇÂ¼¹ú¼Ò»ñµÃ·ÖÊý
Task_Tong_Fragment2 = 13 --¼ÇÂ¼¹ú¼Ò»ñµÃ·ÖÊý
Global_Fragment = 245 -- 1word:½»µÄËéÆ¬×ÜÊý£»2word:Ê°µÄËéÆ¬×ÜÊý
Global_Fragment_Num = 246 --»î¶¯´ÎÊý£¨ÅÐ¶ÏÍæ¼ÒÊÇ·ñ²Î¼Ó¹ý¸Ã»î¶¯£©

function main()
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);

    tasks = {
        { "B×nh An", "renwu1"; show = 0 },
        { "Tam s¸ch", "renwu2"; show = 0 },
        { "Nghe", "listen"; show = 1 },
        { "§Õn Diªu Tr×", "go"; show = 0 },
        { "Thu thËp", "fragment"; show = 1 }, --Add by liuzhiqiang at 2009/7/29
        { "Ph¸t ThiÖp mêi", "shouxitie"; show = 0 }, --Added By guoqun at 2009.11.20

        -- added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},
        -- added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end

    }
    if (UTask_Knight == 40) or (UTask_Druid == 40) or (UTask_Wizard == 40) then
        if (GetLevel() >= 65) then
            tasks[1].show = 1;
        end ;
    end ;
    if (UTask_Knight > 40) or (UTask_Druid > 40) or (UTask_Wizard > 40) then
        tasks[4].show = 1;
    end ;
    if (UTask_Knight == 60) or (UTask_Druid == 60) or (UTask_Wizard == 60) then
        if (GetLevel() >= 75) then
            tasks[2].show = 1;
        end ;
    end ;


    -- Ë¢ÐÂÅÅÐÐ°ñ
    local H, M, S = GetHMS()
    local sortDate = LoadIniInteger(Save_Section_Ring_Date, 1)

    if ((IsEightDays() == 1) and (H >= 21) and (sortDate ~= GetGlobalValue(Global_Fragment_Num))) then
        freshSortList()
    end

    if (IsEightDays() == 1) and (IsTongMember() == 1) and (H > 8) then
        local nLastTongTaskTime = GetTongTask(Task_Tong_Fragment1)
        local nLastTongTaskDay = floor(nLastTongTaskTime / 86400)
        local nNowDay = floor(LocalSystemTime() / 86400)
        if (nLastTongTaskDay ~= nNowDay) then
            SetTongTask(Task_Tong_Fragment, 0)
            SetTongTask(Task_Tong_Fragment2, 0)
            SetTongTask(Task_Tong_Fragment1, LocalSystemTime())
        end
    end

    --Add by guoqun 2009-11-20 begin--
    if (GetTaskBit(Task_Xitie, 1) == 1 and GetTaskBit(Task_Xitie, 2) == 0 and GetSex() == 0) then
        tasks[6].show = 1
    end
    --Added by guoqun 2009-11-20 end --

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
    --~                      if (year == 2010 and month == 8 and day == 30
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[7].show = 1;
    --~                     end
    --added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end



    SayTask(10013, tasks)
    -- end

end;

--Add by guoqun 2009-11-20 begin--
function shouxitie()
    CloseDialog()
    if (GetTaskBit(Task_Xitie, 3) == 1) then
        Talk(1, "no", "§¾c Kû:Chóc hai ng­¬i b¸ch niªn hßa hîp!")
        return
    end
    local b_pos = pos_ok(500)  -- NoticeHere Õâ¸öÖµÓ¦¸ÃµÃµ÷Õû
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>30£©
        Talk(1, "no", "§¾c Kû:T©n n­¬ng c¸ch ng­¬i qu¸ xa, h·y ®­a c« Êy ®Õn c¹nh ng­¬i!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "§¾c Kû:T©n n­¬ng kh«ng ë khu vùc nµy, h·y ®­a c« ta ®Õn ®©y!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "§¾c Kû:H«n lÔ lµ chuyÖn cña c¶ hai ng­êi!")
        return
    elseif (b_pos == 1) then
        local qingtie = JiehunItem[3].Item
        if (HaveNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4]) == 0) then
            Talk(1, "no", "§¾c Kû:Ng­¬i kh«ng mang ThiÖp mêi ®Õn lµm sao ®­îc?")
            return
        end
        DelNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4])

        SetTaskBit(Task_Xitie, 3, 1)
        local str = ""

        if (GetTaskBit(Task_Xitie, 4) == 0) then
            if (str == "") then
                str = NpcName[1]
            else
                local tep = str
                str = tep .. "," .. NpcName[1]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 0) then
            if (str == "") then
                str = NpcName[2]
            else
                local tep = str
                str = tep .. "," .. NpcName[2]
            end
        end

        if (GetTaskBit(Task_Xitie, 5) == 0) then
            if (str == "") then
                str = NpcName[3]
            else
                local tep = str
                str = tep .. "," .. NpcName[3]
            end
        end

        if (GetTaskBit(Task_Xitie, 6) == 0 and GetTaskByte(Task_MarryState, 2) == 3) then
            if (str == "") then
                str = NpcName[5]
            else
                local tep = str
                str = tep .. "," .. NpcName[5]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskBit(Task_Xitie, 6) == 1 and GetTaskByte(Task_MarryState, 2) == 3) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        elseif (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskByte(Task_MarryState, 2) == 2) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        else
            TaskNote(1507, 0, str, "")
        end
        TeamAction("showtalk", 0, 0, 0)
    end
end

function showtalk()
    CloseDialog()
    SetTaskBit(Task_Xitie, 3, 1)
    Talk(2, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· göi ThiÖp mêi, nh­ng ta kh«ng thÓ tham gia h«n lÔ cña c¸c ng­¬i, ®Ó chóc phóc cho hai ng­¬i, lóc cö hµnh h«n lÔ, ta sÏ tÆng c¸c ng­¬i mét kiÖu hoa thËt ®Ñp.", "§¾c Kû:Th©n b»ng h¶o h÷u cña c¸c ng­¬i chØ cÇn mang theo ThiÖp mõng vµ 1 Hång Thñy Tinh lµ cã thÓ ®Õn chç C©y l­¬ng duyªn ®Ó chóc phóc. §­îc chóc phóccµng nhiÒu, phÇn th­ëng cµng cao.")
end

function teamTaskNote(taskid, index)
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    TaskNote(taskid, index)
    PlayerIndex = n
    TaskNote(taskid, index)
    PlayerIndex = i
end

function pos_ok(distance)
    -- ·µ»ØÖµ£º1 OK  2Á½ÈËÔÚÍ¬Ò»ÕÅµØÍ¼£¬µ«ÊÇ¾àÀëÌ«Ô¶ 3Á½ÈË²»ÔÚÍ¬Ò»ÕÅµØÍ¼ 4Á½ÈËµÄ×é¶Ô·½Ê½´íÎó
    if (GetMateTask(Task_Partner) ~= GetNameID() or GetMateNameID() ~= GetTask(Task_Partner)) then
        --×é¶Ó·½Ê½´íÎó
        return 4
    end

    local mapid_male, x_male, y_male = GetWorldPos()
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    PlayerIndex = n
    local mapid_female, x_female, y_female = GetWorldPos()
    local w = GetName()
    PlayerIndex = i                --»¹Ô­PlayerIndex

    if (mapid_female == mapid_male) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>distance£©
        if (((x_male * 32 - x_female * 32) ^ 2 + (y_male * 32 - y_female * 32) ^ 2) > distance * distance) then
            -- ¸Ã²»¸Ã³ËÒÔ32ÄØ£¿£¿£¿NoticeHere
            return 2
        end
    else
        -- °éÂÂ²»ÔÚµ±Ç°µØÍ¼
        return 3
    end
    return 1
end

function set_xitiebit(bit)
    if (bit == 0) then
        SetTask(Task_Xitie, 0)
    else
        SetTaskBit(Task_Xitie, bit, 1)
    end
end

--Add by guoqun 2009-11-20 end--


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
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(4, "func_leave1", 10014, 10015, 10016, 10017)
        if (UTask_Wizard == 40) then
            SetTask(1, 41)
            TaskNote(28, 20)
        end ;
        if (UTask_Knight == 40) then
            SetTask(3, 41)
            TaskNote(27, 16)
        end ;
        if (UTask_Druid == 40) then
            SetTask(2, 41)
            TaskNote(29, 15)
        end ;

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", 11718)
    end
end;

function renwu2()
    local mark = fangchenmi()
    if (mark == 1) then
        if (GetPlayerType() == 0) and (UTask_Knight == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(13) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14211)
            end ;
        elseif (GetPlayerType() == 1) and (UTask_Wizard == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(2) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14212)
            end ;
        elseif (GetPlayerType() == 2) and (UTask_Druid == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(19) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14213)
            end ;
        end ;

    else
        Talk(1, "no", 11718)
    end
end;

function listen()
    Talk(1, "func_leave3", 10019)
end;

function go()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        --Éæ¼°?Îñ£¬ÓÐµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿?Îñ½â³ý£¬¹ý³ÌÖÐ²»¿ÉÊ¹ÓÃ´«ËÍ
        Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
    else
        local i = random(1, 3)
        if (i == 1) then
            NewWorld(52, 1541, 3190)
        end ;
        if (i == 2) then
            NewWorld(52, 1556, 3202)
        end ;
        if (i == 3) then
            NewWorld(52, 1540, 3205)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function func_leave1()
    Talk(1, "main", 10020)
end;

function func_leave2()
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    Talk(2, "no", 10021, 10022)
    if (UTask_Wizard == 60) and (HaveEventItem(2) >= 1) and (GetPlayerType() == 1) and (GetLevel() >= 75) then
        DelEventItem(2)
        AddEventItem(9)
        SetTask(1, 61)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao ThÇn Méc cho §¾c Kû.")
        TaskNote(28, 27)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Knight == 60) and (HaveEventItem(13) >= 1) and (GetPlayerType() == 0) and (GetLevel() >= 75) then
        SetTask(3, 61)
        DelEventItem(13)
        AddEventItem(9)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao r©u ThÇn Long cho §¾c Kû.")
        TaskNote(27, 23)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Druid == 60) and (HaveEventItem(19) >= 1) and (GetPlayerType() == 2) and (GetLevel() >= 75) then
        SetTask(2, 61)
        DelEventItem(19)
        AddEventItem(9)
        TaskNote(29, 22)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao Ma HuyÕt cho §¾c Kû.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function func_leave3()
    Talk(1, "func_leave4", 10023)
end;

function func_leave4()
    Talk(2, "func_leave5", 10024, 10025)
end;

function func_leave5()
    Talk(1, "func_leave6", 10026)
end;

function func_leave6()
    Talk(1, "func_leave7", 10027)
end;

function func_leave7()
    Talk(1, "no", 10028)

end;

function no()
    CloseDialog()
end;

-----------------------------------add by liuzhiqiang at 2009/7/29 begin-------------------------²É¼¯ËéÆ¬
function fragment()
    CloseDialog()

    local task1 = {
        { "Nép To¸i phiÕn", "giveBack"; show = 0 },
        { "L·nh nhËn phÇn th­ëng", "getExp"; show = 0 },
        { "ThuyÕt minh", "introduction"; show = 1 },
        { "B¶ng xÕp h¹ng", "ranking"; show = 1 },
    }

    if (isViewMatchTask() == 1) then
        task1[1].show = 1
    end

    local nNowDay = floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = floor(nLastTaskTime / 86400)
    local jianGe = nNowDay - nLastTaskDay

    if (GetGlobalValueWord(Global_Fragment, 1) >= 2840 and GetTaskByte(Task_Get_Fragment, 3) > 0 and jianGe < 8) then
        task1[2].show = 1
    end

    SayTask("§¾c Kû:To¸i phiÕn Ngäc Hoa B×nh trªn th­îng giíi ®· r¬i xuèng nh©n gian, mäi ng­êi mau thu thËp, l·nh ®Þa nµo thu thËp nhiÒu nhÊt, ta sÏ tÆng phÇn th­ëng hËu hÜ.", task1)
end

function isViewMatchTask()
    if (GetLevel() < 30) then
        return 0
    end

    if (IsTongMember() ~= 1) then
        return 0
    end

    local H, M, S = GetHMS()
    if (IsEightDays() ~= 1 or H < 21 or (H == 23 and M > 58)) then
        return 0
    end

    if (HaveNormalItem(3, 458, 0, 0) <= 0 and HaveNormalItem(3, 459, 0, 0) <= 0 and HaveNormalItem(3, 460, 0, 0) <= 0 and HaveNormalItem(3, 461, 0, 0) <= 0) then
        return 0
    end

    return 1
end

function introduction()
    CloseDialog()

    Talk(2, "introduction1", "§¾c Kû:<c=g>Cø 8 ngµy<c> ®Õn <c=g>9h tèi<c>, Ngäc Hoa B×nh ë th­îng giíi vì tan, To¸i phiÕn sÏ r¬i xuèng nh©n gian, h·y tËp hîp lùc l­îng l·nh ®Þa gióp ta thu thËp, sÏ cã phÇn th­ëng xøng ®¸ng.", "§¾c Kû:T¹p hãa th­¬ng ®ang thu mua Cuèc, h·y thu thËp To¸i phiÕn r¬i ë nh©n gian. To¸i phiÕn nhá chØ do 1 ng­êi nhÆt, To¸i phiÕn trung cÇn <c=g>2 ng­êi cïng l·nh ®Þa<c> kÕt tæ ®éi thu thËp, To¸i phiÕn lín cÇn <c=g>4 ng­êi cïng l·nh ®Þa kÕt tæ ®éi <c> thu thËp, cßn cã c¬ héi nhËn ®­îc To¸i phiÕn cùc lín.")
end

function introduction1()
    CloseDialog()

    Talk(2, "no", "§¾c Kû:6 To¸i phiÕn ®Çu tiªn giao nép míi cã phÇn th­ëng kinh nghiÖm, vÒ sau chØ cã ®iÓm l·nh ®Þa. To¸i phiÕn thu thËp cµng lín, phÇn th­ëng cµng cao. Mçi ng­êi chØ ®­îc mang 1 To¸i phiÕn mçi lo¹i.", "§¾c Kû:Cã thÓ nép To¸i phiÕn tr­íc 12h, sau khi thu thËp ®ñ To¸i phiÕn, ta sÏ tÆng ng­êi ch¬i phÇn th­ëng hËu hÜ. L·nh ®Þa n»m trong 3 vÞ trÝ ®Çu tiªn sÏ t¨ng H­ng thÞnh l·nh ®Þa.")
end

function giveBack()
    CloseDialog()

    local H, M, S = GetHMS()
    if (GetLevel() >= 30 and IsTongMember() == 1 and IsEightDays() == 1 and H >= 21) then
        if (HaveNormalItem(3, 458, 0, 0) < 0 and HaveNormalItem(3, 459, 0, 0) < 0 and HaveNormalItem(3, 460, 0, 0) < 0 and HaveNormalItem(3, 461, 0, 0) < 0) then
            Talk(1, "no", "§¾c Kû:Ng­¬i kh«ng mang theo To¸i phiÕn.")
            return
        end

        qingLing()

        if (HaveNormalItem(3, 461, 0, 0) > 0) then
            --³¬´óËéÆ¬
            ClearItem(3, 461, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 2, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (cùc lín).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 5
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 1000
                AddOwnExp(addExp)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn cùc lín, nhËn ®­îc" .. addExp .. "kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 1000
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn cùc lín, nhËn ®­îc" .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 460, 0, 0) > 0) then
            --´óËéÆ¬
            ClearItem(3, 460, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 2, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (lín).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 3
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 600
                AddOwnExp(addExp)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn lín, nhËn ®­îc" .. addExp .. "kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            elseif (give_num == 5) then
                local addExp = GetLevel() * 600
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn lín, nhËn ®­îc" .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 459, 0, 0) > 0) then
            --ÖÐËéÆ¬
            ClearItem(3, 459, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 1, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (trung).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 2
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 400
                AddOwnExp(addExp)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn trung, nhËn ®­îc" .. addExp .. "kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 400
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn trung, nhËn ®­îc" .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 458, 0, 0) > 0) then
            --Ð¡ËéÆ¬
            ClearItem(3, 458, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 To¸i phiÕn nhá.")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 1
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 300
                AddOwnExp(addExp)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn nhá, nhËn ®­îc" .. addExp .. "kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 300
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn nhá, nhËn ®­îc" .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end
        end

        if (GetMorphType() == 23) then
            PolyMorph(-1, 0, 0, 0, 0)
        end

        if (GetGlobalValueWord(Global_Fragment, 1) > 0 and mod(GetGlobalValueWord(Global_Fragment, 1), 400) == 0) then
            local message = ""
            local rank_num = getn(arySortList)
            if (rank_num > 3) then
                rank_num = 3
            end
            for i = 1, rank_num do

                if (arySortList[i].name == "") then
                    break
                end

                local rankSec = arySortList[i].score
                local rankName = arySortList[i].name

                message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " phót"
            end
            if (getn(arySortList) >= 1) then
                AddGlobalCountNews("HiÖn t¹i ho¹t ®éng thu thËp To¸i phiÕn, cèng hiÕn tèi ®a " .. rank_num .. "Tªn l·nh ®Þa: " .. message, 1)
            end
        end

        if (GetGlobalValueWord(Global_Fragment, 1) >= 2840) then
            local message = ""
            local rank_num = getn(arySortList)
            if (rank_num > 3) then
                rank_num = 3
            end
            local rankscore = 0
            for i = 1, rank_num do
                if (arySortList[i].name == "") then
                    break
                end

                local rankSec = arySortList[i].score
                local rankName = arySortList[i].name
                --add by luoyixuan
                if (i == 1) then
                    rankscore = 100
                elseif (i == 2) then
                    rankscore = 50
                elseif (i == 3) then
                    rankscore = 30
                end

                local nTongID = GetTongIDByName(rankName)
                AddTongAttrByID(nTongID, 0, rankscore)
                --add by luoyixuan

                message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " ®iÓm, H­ng thÞnh l·nh ®Þa t¨ng" .. rankscore .. " ®iÓm" --add by luoyixuan
            end
            if (rank_num >= 1) then
                AddGlobalCountNews("Nhê mäi ng­êi gióp ®ì, tÊt c¶ To¸i phiÕn ®· thu thËp ®ñ, nh÷ng ng­êi ch¬i tham gia ho¹t ®éng sÏ nhËn ®­îc phÇn th­ëng hËu hÜ, vÞ trÝ cèng hiÕn nhiÒu nhÊt" .. rank_num .. "Tªn l·nh ®Þa: " .. message, 1)
            end

            WriteLog("Ho¹t ®éng thu thËp To¸i phiÕn lÇn nµy ®· t×m ra vµ giao nép tÊt c¶ To¸i phiÕn.")
        end
    end
end

function getExp()
    CloseDialog()

    local nNowDay = floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = floor(nLastTaskTime / 86400)
    local jianGe = nNowDay - nLastTaskDay

    if (GetGlobalValueWord(Global_Fragment, 1) >= 2840 and GetTaskByte(Task_Get_Fragment, 3) > 0 and jianGe < 8) then
        local addExp = GetLevel() * 1000
        AddOwnExp(addExp)
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
        Msg2Player("Toµn bé To¸i phiÕn ®· t×m ®ñ, §¾c Kû th­ëng cho b¹n" .. addExp .. "kinh nghiÖm.")
        Talk(1, "no", "§¾c Kû:Chóc mõng, ng­¬i ®· t×m ®ñ sè To¸i phiÕn, ta th­ëng cho ng­¬i <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
        SetTask(Task_Get_Fragment, 0)
    end
end

Save_Section_Ring_Date = "Save_Frag_Ranking_Data"
Save_Section_Ring_Score = "Save_Frag_Ranking_Score"
Save_Section_Ring_Playername = "Save_Frag_Ranking_Playername"
arySortList = {}

function ranking()
    CloseDialog()

    if (getn(arySortList) <= 0) then
        loadSortList()
    end

    if (getn(arySortList) <= 0) then

        Talk(1, "no", "§¾c Kû:T¹m thêi ch­a thÓ giao nép To¸i phiÕn, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!")

    else

        local message = ""
        local count = 0

        for i = 1, 10 do
            if (arySortList[i].name == "") then
                break
            end

            count = count + 1
        end

        for i = 1, 5 do

            if (arySortList[i].name == "") then
                break
            end

            local rankSec = arySortList[i].score
            local rankName = arySortList[i].name

            message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " Phót\n"

        end

        if (message == "") then
            message = "§¾c Kû:T¹m thêi ch­a thÓ giao nép To¸i phiÕn, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!"
        end

        if (count <= 5) then
            Talk(1, "no", message)
        else
            Talk(1, "lastFiveRanking", message)
        end

    end

end

function lastFiveRanking()
    CloseDialog()

    local message = ""
    for i = 6, 10 do
        if (arySortList[i].name == "") then
            break
        end

        local rankSec = arySortList[i].score
        local rankName = arySortList[i].name

        message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " Phót\n"
    end
    Talk(1, "no", message)
end

function loadSortList()
    local saveDate = LoadIniInteger(Save_Section_Ring_Date, 1)

    for i = 1, 10 do
        arySortList[i] = { name = "", score = 0 }
    end

    local topName = {}
    local topSec = {}

    if (saveDate ~= nil) and (saveDate ~= 0) then

        for i = 1, getn(arySortList), 1 do
            topName[i] = LoadIniString(Save_Section_Ring_Playername, i)
            topSec[i] = LoadIniInteger(Save_Section_Ring_Score, i)

            arySortList[i] = { name = topName[i], score = topSec[i] }
        end

    end
end

function freshSortList()

    for i = 1, 10 do
        arySortList[i] = { name = "", score = 0 }
    end

    SaveIniInteger(Save_Section_Ring_Date, 1, floor(LocalSystemTime() / 86400))

    for i = 1, getn(arySortList), 1 do
        SaveIniString(Save_Section_Ring_Playername, i, arySortList[i].name)
        SaveIniInteger(Save_Section_Ring_Score, i, arySortList[i].score)
    end

    local tongmember = GetTongCount() - 1
    for i = 0, tongmember do
        tongID = GetTongID(i)
        if (tongID ~= nil) then
            idx = GetTongTaskByID(tongID, Task_Tong_Fragment)

            if (idx > 0) then
                SetTongTaskByID(tongID, Task_Tong_Fragment, 0)
            end
        end
    end
end

function addSortList(Name, Score)

    if (getn(arySortList) <= 0) then
        loadSortList()
    end

    local isInList = 0
    isInList = isInSortList(Name, Score)

    local equal_mark = 0

    for i = getn(arySortList), 1, -1 do

        if (isInList == 0) then
            if (arySortList[i].score < Score) or (arySortList[i].name == "") then
                if (i < 10) then
                    arySortList[i + 1].score = arySortList[i].score
                    arySortList[i + 1].name = arySortList[i].name
                end

                if (i == 1) then
                    arySortList[i].score = Score
                    arySortList[i].name = Name
                end
            else
                if (i < 10) then
                    arySortList[i + 1].score = Score
                    arySortList[i + 1].name = Name
                    break

                elseif (i == 10) and (arySortList[i].score >= Score) and (arySortList[i].name ~= "") then
                    break
                end
            end
        else
            if (arySortList[i].score <= Score) then
                if (equal_mark == 1) then
                    if (i < 10) then
                        if (arySortList[i].score < Score) then
                            arySortList[i + 1].score = arySortList[i].score
                            arySortList[i + 1].name = arySortList[i].name
                        else
                            arySortList[i + 1].score = Score
                            arySortList[i + 1].name = Name
                            break
                        end
                    end
                end

                if (arySortList[i].name == Name) then
                    equal_mark = 1
                end

                if (i == 1) then
                    arySortList[i].score = Score
                    arySortList[i].name = Name
                end
            else
                if (i < 10) then
                    arySortList[i + 1].score = Score
                    arySortList[i + 1].name = Name
                    break

                elseif (i == 10) and (arySortList[i].score >= Score) and (arySortList[i].name ~= "") then
                    break
                end
            end
        end

    end

    saveSortList()

end

function isInSortList(Name, Score)

    if (getn(arySortList) <= 0) then
        return 0
    end

    for i = getn(arySortList), 1, -1 do
        if (Name == arySortList[i].name) then
            return 1
        end
    end

    return 0
end

function saveSortList()

    for i = 1, getn(arySortList), 1 do

        SaveIniString(Save_Section_Ring_Playername, i, arySortList[i].name)
        SaveIniInteger(Save_Section_Ring_Score, i, arySortList[i].score)

    end

end

function qingLing()
    local nNowDay = floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = floor(nLastTaskTime / 86400)
    if (nLastTaskDay ~= nNowDay) then
        SetTaskByte(Task_Get_Fragment, 1, 0)
        SetTaskByte(Task_Get_Fragment, 2, 0)
        SetTaskByte(Task_Get_Fragment, 3, 0)
        SetTask(Task_Get_Fragment1, LocalSystemTime())
    end
end

-----------------------------------add by liuzhiqiang at 2009/7/29 end---------------------------²É¼¯ËéÆ¬


--added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ðÌâÊýÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "æ§¼º£ºÓ¢ÐÛ±³°üÖÐÃ»ÓÐÐ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~     
--~     if (idx == 6) then
--~         Talk(1, "no", "æ§¼º£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ýµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("æ§¼º£ºÔÚÂ¹Ì¨Ö®ÉÏÐÀÉÍ·ç¾°£¬ÐÄÇéÒ²ºÃºÜ¶à£¬½ñÈÕÀ´ÕÒÎÒµÄÈËÂçÒï²»¾ø£¬ÄãÒ²ÊÇÎªÁË×£¸£À´ÕÒÎÒµÄ°É£¬Ö»ÒªÄãÄÜ´ð¶ÔÎÒµÄÎÊÌâ£¬ÎÒ¾Í»áËÍ¸øÄãÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~     
--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     
--~     local TABLE_Ques = {
--~         [1] = { quest = "ÓñÅåÈ¡Ëè¿ÉÒÔÔÚÄÄÀï½øÐÐ£¿", 
--~                     option = { [1]  = "Ñþ³Ø³àËÉ×Ó", [2] = "Ñþ³ØÕÔ¹«Ã÷", [3] = "Ñþ³ØÀ×Õð×Ó", }, },
--~         [2] = { quest = "¡¶·âÉñÑÝÒå¡·ÖÐ¡°Ê®¶þ½ðÏÉ¡±²»°üÀ¨ÒÔÏÂÄÄÎ»£¿", 
--~                     option = { [1]  = "µÀµÂÕæ¾ý", [2] = "ÄÏ¼«ÏÉÎÌ", [3] = "Ì«ÒÒÕæÈË", }, },
--~         [3] = { quest = "ÒÔÏÂÄÄÖÖ²ÄÁÏ¿ÉÒÔÎª»êÖä¼¼ÄÜÔö¼ÓÁéÆø£¿", 
--~                     option = { [1]  = "·çÁéÊ¯", [2] = "Ë®ÁéÊ¯", [3] = "ÌìÁéÊ¯", }, },
--~         [4] = { quest = "°Ù¸£ÁÙÃÅÀñ°ü100¼¶ÀñÎïÊÇÊ²Ã´£¿", 
--~                     option = { [1]  = "ÈçÒâÈ¯", [2] = "½«¾üÁî", [3] = "ÃûÓñÒ»¿Å", }, },
--~         [5] = { quest = "Ê¹ÓÃÊ²Ã´¹¤¾ß¿ÉÒÔÔÚ¹ú¼ÒÀïÐÞ½¨Ó¶±øÓª£¿", 
--~                     option = { [1]  = "º××ì³ú", [2] = "Â³°à¸«", [3] = "³úÍ·", }, },
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
--~     Say("æ§¼º£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

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

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 3, [2] = 2, [3] = 3, [4] = 1, [5] = 2,};
--~     
--~     if (TABLE_Key[idx] == choice) then
--~     
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "æ§¼º£ºÓ¢ÐÛËäÈ»´ð¶ÔÁËÌâÄ¿£¬µ«±³°üÖÐÃ»ÓÐÐ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "æ§¼º£ºÓ¢ÐÛ¹ûÈ»²ÅÖÇ¹ýÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ÐÛÁË¡£");
--~         
--~         SetTaskByte(TASK_ThreeYears_Fireworks, 3, 6); --µ±Ç°NPCµÄÌâÄ¿
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
--~         Talk(1, "no", "æ§¼º£ºÄãµÄ´ð°¸²»¶Ô£¬ÇëÖØÐÂ×÷´ð¡£");
--~     end

--~ end
--added by hongliang for ÈýÖÜÄê»î¶¯ 10/8/12 end




