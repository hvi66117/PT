--description: ËÎÒìÈË
--author: yichuan
--date: 2004/7/13
--task_AutumnFestival = 1131;task_AutumFes_time = 1132 ;task_AutumFes_info = 1133;task_AutumItem_info = 1134;
--task_Item = {
--		[1] = { id1 = 6, id2 = 1, id3 = 316, id4 = 0},
--		[2] = { id1 = 6, id2 = 1, id3 = 317, id4 = 0},
--		[3] = { id1 = 6, id2 = 1, id3 = 318, id4 = 0},
--		[4] = { id1 = 6, id2 = 1, id3 = 319, id4 = 0},
--		[5] = { id1 = 6, id2 = 1, id3 = 320, id4 = 0},
--		[6] = { id1 = 6, id2 = 1, id3 = 321, id4 = 0}
--		}
-- AS GaoJingwei at 090728 

-------------------- Á½ÖÜÄêÇìµä added by yangtao 2009.8.19 ----------------
Task_prepare = 1537    -- 1byte£º1£º¶Ô¼×Ê¿Íæ¼ÒÊ¹ÓÃ¹ı 2£º¶ÔµÀÊ¿Íæ¼ÒÊ¹ÓÃ¹ı 3£º¶ÔÒìÈËÍæ¼ÒÊ¹ÓÃ¹ı
-- 2byte£ºµÀ¾ß±»Ê¹ÓÃ´ÎÊı
-- 3byte: ÈÎÎñ½ø¶È
Task_anotherID = 1538    -- ¼ÇÂ¼Ê¹ÓÃ¡¾ÖÜÄêÇìÑûÇëº¯¡¿Ê±¶Ô·½µÄPlayerID
Task_item = 1539
Task_stage = 1540
--2009.8.28 - 2009.8.29		-- 1byte:1-5¼ÇÂ¼ÊÇ·ñÒÑ½«ºØ¿¨ËÍÍù¶ÔÓ¦NPC´¦
-- 2byte:¼ÇÂ¼ÈÎÎñ½ø¶È	1:ÒÑ¾­ÔÚÀñ¹Ù´¦ÁìÈ¡ÎïÆ·£¬¿ªÊ¼»î¶¯ 2-5:ÒÑ¾­ËÍºØ¿¨¸ø¼¸¸öNPC 6:Íê³ÉÈÎÎñ
-- 3byte:1-5¼ÇÂ¼ºØ¿¨Õâ´ÎÓ¦¸ÃËÍ¸øË­
--2009.8.30 - 2009.8.31		-- 1byte:ÓÃÓÚÅĞ¶ÏÊÇ·ñ²ÄÁÏÆëÈ«
-- 2byte:ÈÎÎñ½ø¶È		1:ÒÑ¾­¿ªÊ¼ÈÎÎñ 2:ÒÑ¾­ÁìÈ¡ÎïÆ· 3:ÒÑ¾­Íê³ÉÈÎÎñ
--2009.9.1 - 2009.9.3		-- 1byte:ÓÃÓÚ¼ÇÂ¼ÈÎÎñ½ø¶È 0:»¹Ã»ÓĞ½ÓÈÎÎñ 1: ÒÑ¾­¿ªÊ¼ÈÎÎñ£¬Î´²É¼¯×£¸£ 2:ÒÑ¾­²É¼¯ÁË×£¸£ 3:ÒÑ¾­Íê³ÉÈÎÎñ

----------------------------- Á½ÖÜÄêÇìµä end of add ------------------------


-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ĞòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ğÍê£©; 4th byte µÚ¶ş¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈı¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ğÌâÊıÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ----------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼şÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØĞ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end------------------

-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
GetBack_Info = {
    { itemInfo = { 3, 1134, 0, 0 }, itemName = "HuyÒn Hoang Th¸p", npcName = "D­ Kh¸nh", mapName = "Hoang m¹c" },
    { itemInfo = { 3, 1135, 0, 0 }, itemName = "H¶i ThÇn Ch©m", npcName = "Hoµng Minh", mapName = "§«ng H¶i" },
    { itemInfo = { 3, 1136, 0, 0 }, itemName = "V¹n Viªm Ch©u", npcName = "Tèng DŞ Nh©n", mapName = "Hiªn Viªn" },
    { itemInfo = { 3, 1137, 0, 0 }, itemName = "Tö Yªu LÖnh", npcName = "Hå Hû MŞ", mapName = "B¨ng Xuyªn" },
}
nNpcIndex = 3
Task_GetBackItem = 1727 -- 1Byte£º¼ÇÂ¼½ÓÈÎÎñµÄÈÕÆÚ  2byte£º¼ÇÂ¼½»Ê²Ã´ÎïÆ· 3byte£º²½Öè 4byte£º¼ÇÂ¼ÊÇ·ñ·¢ÓÊ¼ş
-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

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

    --ÑÉÖª·Ç¸£
    startLevel = 23
    if (GetLevel() >= startLevel) then
        local taskProcess = GetTask(91)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 5) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) or (taskProcess == 5) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
    --local nYear, nMonth, nDay = GetYMD()
    --startLevel = 30
    --if ( nYear == 2010 and ( (nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7 ) ) and GetLevel() >= startLevel and GetTaskByte( Task_GetBackItem, 2) == nNpcIndex ) then
    --	local nStep = GetTaskByte( Task_GetBackItem, 3)
    --	local item = GetBack_Info[nNpcIndex].itemInfo
    --	if ( nStep == 1 ) then
    --		state = 3
    --		subState = 0
    --	elseif ( nStep == 2 and HaveNormalItem(item[1], item[2], item[3], item[4]) > 0 ) then
    --		state = 3
    --		subState = 0
    --	elseif ( nStep == 2 ) then
    --		state = 2
    --		subState = 0
    --	end

    --	index = searchForIndex(state, subState, index)
    --end
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

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
        { "Yªn Phóc", "renwu1"; show = 0 },
        --				 {"ÔÂ¹¬¼ÑÈË","AutumFes";show = 0}
        -- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
        --{"¶şÖÜÄêÇìµä","twoyearcel";show = 0},
        -- end of add yangtao 2009.8.19
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},--2
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end
        -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
        --{"Ñ°»Ø±¦Æ÷","Get_BackItem";show = 0},
        -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End
    }

    UTask_world_1 = GetTask(91);
    if (UTask_world_1 == 2) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_1 == 0) and (GetLevel() >= 23) then
        tasks[1].show = 1;
    end ;
    --			local nTasksData = GetTask(task_AutumnFestival)
    --			local nTaskStatus =  mod(nTasksData,2 )
    --			if( nTaskStatus ~=0 )then
    --					tasks[2].show = 1
    --			end

    -- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
    --local y1, m1, d1 = GetYMD()
    --local H,M,S = Time2LocalHMS(nSysTaskTime)
    --if(y1 == 2009) and (m1 == 8) and (d1 == 28) and (GetTaskByte(Task_stage, 2) >= 1) and (GetTaskBit(Task_stage, 3) == 0) and (GetTaskBit(Task_stage, 19) == 1)then 
    --	tasks[2].show = 1
    --end
    -- end of add yangtao 2009.8.19


    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
    --~                     local year, month, day = GetYMD();
    --~                     local hour, min, second = GetHMS();
    --~                     local today = mod(floor(LocalSystemTime()/86400), 255) + 1;

    --~                     local TaskStep = GetTaskByte(TASK_ThreeYears_Fireworks, 1);
    --~                     local TaskTime = GetTaskByte(TASK_ThreeYears_Fireworks, 2);
    --~                     
    --~                     --Çå¿ÕÖ®Ç°µÄÈÎÎñ£¬ÒÔ·ÀbuffendÎ´Ö´ĞĞ
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
    --~                         tasks[2].show = 1;
    --~                     end
    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
    --local nYear, nMonth, nDay = GetYMD()
    --if ( nYear == 2010 and ( (nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7 ) ) and GetTaskByte( Task_GetBackItem, 2) == nNpcIndex ) then
    --	local nStep = GetTaskByte( Task_GetBackItem, 3)
    --	if ( nStep == 1 or nStep == 2 ) then
    --		tasks[2].show = 1
    --	end
    --end
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

    SayTask(10065, tasks)
end;

--function AutumFes()
--	local nTaskInfo = GetTask(task_AutumFes_info)
--	local nTaskCome = GetBit(nTaskInfo,12)
--	if( nTaskCome == 1 )then
--		SetTask( task_AutumFes_info,SetBit( GetTask(task_AutumFes_info),12,0))
--		if( GetBit( nTaskInfo ,6) == 1)then
--			local nItemStatus = GetTask(task_AutumItem_info)
--			for i = 1,4 do
--				local nItemID = GetByte( nItemStatus, i )
--				if( nItemID ~= 0 )then
--					AddNormalItem( task_Item[nItemID].id1,task_Item[nItemID].id2,task_Item[nItemID].id3,task_Item[nItemID].id4,0,0)
--					SetTask( task_AutumItem_info,SetByte( GetTask( task_AutumItem_info ),i,0))
--					break
--				end
--			end
--			SetTask(task_AutumFes_info,SetBit( GetTask(task_AutumFes_info),6,0))
--			Talk(1,"no","ËÎÒìÈË£º»­Æ¬£¿ÎÒÃ»¼û¹ı°¡¡£¡£¡£Å¶¡£¡£¡£ÊÇ²»ÊÇÕâ¿é²¼Í·£¿ÄãÒªÕâ¿éÆÆ²¼×öÊ²Ã´£¿ÕæÊÇÆæ¹Ö¡£¡£¡£ÄãÄÃÈ¥°É¡£Èç¹ûÏÂ´Î¿´µ½ÎÒĞÖµÜ½ª×ÓÑÀ¼ÇµÃ°ïÎÒÎÊËûºÃ°¡£¡")
--		else
--			Talk(1,"no","ËÎÒìÈË£ºÎÒÕâÃ»ÓĞËéÆ¬¡£")
--		end
--	else
--		Talk(1,"no","ËÎÒìÈË£ºÄãÒÑ¾­À´¹ıÁË£¬ÎÒÕâÃ»ÓĞÄãĞèÒªµÄ¶«Î÷ÁË¡£")
--	end
--end

function renwu1()
    UTask_world_1 = GetTask(91);
    if (UTask_world_1 == 2) then
        Talk(2, "func_dafu", 10066, 10067)
    end ;

    if (UTask_world_1 == 0) and (GetLevel() >= 13) then
        Talk(2, "func_ask", 10068, 10087)
    end ;
end;

function func_ask()
    MsgBox(10088, "yes_1", "no")
end;

function func_dafu()
    MsgBox(10076, "fault", "real")
end;

function real()
    Talk(2, "no", 10089, 10090)
    Earn(5000)
    SetTask(91, 5)
    Msg2Player("§em tin tèt lµnh ®Õn cho Tèng DŞ nh©n, nhËn ®­îc phÇn th­ëng.")
    TopMessage(14151)
    --AS GaoJingwei 090730
    SetSubTask(25, -1, 1)
    --AE GaoJingwei 090730
    TaskNote(25, -1)

    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function fault()
    if (GetCash() >= 500) then
        Talk(5, "no", 10091, 10092, 10093, 10094, 10095)
        Pay(500)
        AddNormalItem(6, 1, 12, 1, 0, 0)
        SetTask(91, 3)
        Msg2Player("G¹t ®­îc Tèng DŞ nh©n, lÊy ®­îc l¸ th¨m.")
        TaskNote(25, 2)

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(5, "no", 10091, 10092, 10093, 10094, 10096)
    end ;
end;

function yes_1()
    CloseDialog()
    SetTask(91, 1)
    Msg2Player("T×m ThÇy t­íng sè, kÓ l¹i l¸ th¨m cña Tèng DŞ nh©n.")
    --AS GaoJingwei 090730
    SetSubTask(25, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(25, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

-- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
--function twoyearcel()
--	local ran = 1
--	if( IsHaveSpaceForTreasure (1) == 0 ) then
--		ran = 30
--	end
--	local Npcs_zhaoge = 
--	{
--		"ÍÁĞĞËï",
--		"ºúÏ²ÃÄ",
--		"ËÎÒìÈË",
--		"ÓàÇì",
--		"ĞÇ¹Ù"
--	}
--	local task_process	= GetTaskByte(Task_stage, 2)
--	SetTaskBit(Task_stage, 19, 0)
--	SetTaskBit(Task_stage, 3, 1)
--	local j = random(ran, 100)
--	if(j > 20) then
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(2,"no","ËÎÒìÈË£º·³ÀÍÓ¢ĞÛ£¬·³ÀÍÓ¢ĞÛÁË£¬Ó¢ĞÛ²»´ÇĞÁ¿àÀ´¸æËßÀÏ·ò·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµäµÄÊÂÇé£¬ÀÏ·òÕæ²»ÖªµÀÔõÃ´¸ĞĞ»Äã°¡¡£ËµÊµ»°£¬×Ô´òÉÏ´ÎÓ¢ĞÛÌæÀÏ·òÑ¯ÎÊØÔÏó£¬ÀÏ·ò¾Í¾õµÃÓ¢ĞÛÕæÊÇÒ»Î»ÈÊÒåÖ®ÈË£¬¹ûÈ»Èç´Ë°¡¡£ºÃ£¬ÀÏ·ò¶¨µ±ºÃºÃ³ï±¸£¬¶¼ÒÑ¾­Á½ÄêÁË£¬ÕæÊÇ·á¸»¶à²ÊµÄÁ½Äê°¡¡­¡­","ËÎÒìÈË£ºÓ¢ĞÛ¶¨È»»¹ÓĞÒªÊÂÔÚÉí£¬´«µİÏûÏ¢¾ÍÓÉÀÏ·ò´úÀÍ°É£¬Çë×ª¸æÀñ¹Ù£¬Çìµä¶¨È»»áÈÈÄÖ·Ç³££¡")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do 
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end			
--			end
--			Talk(2,"no","ËÎÒìÈË£º·³ÀÍÓ¢ĞÛ£¬·³ÀÍÓ¢ĞÛÁË£¬Ó¢ĞÛ²»´ÇĞÁ¿àÀ´¸æËßÀÏ·ò·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµäµÄÊÂÇé£¬ÀÏ·òÕæ²»ÖªµÀÔõÃ´¸ĞĞ»Äã°¡¡£ËµÊµ»°£¬×Ô´òÉÏ´ÎÓ¢ĞÛÌæÀÏ·òÑ¯ÎÊØÔÏó£¬ÀÏ·ò¾Í¾õµÃÓ¢ĞÛÕæÊÇÒ»Î»ÈÊÒåÖ®ÈË£¬¹ûÈ»Èç´Ë°¡¡£ºÃ£¬ÀÏ·ò¶¨µ±ºÃºÃ³ï±¸£¬¶¼ÒÑ¾­Á½ÄêÁË£¬ÕæÊÇ·á¸»¶à²ÊµÄÁ½Äê°¡¡­¡­","ËÎÒìÈË£ºàŞ£¬Ó¢ĞÛ¿ìÈ¥½«Õâ¸öÏûÏ¢¸æËß<c=g>"..Npcs_zhaoge[i].."<c>°É£¬Ëû×î½ü»¹ÎÊ¹ıÕâÊÂÇéÄØ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)
--			TaskNote(1094, 0, Npcs_zhaoge[i])
--		end
--	else
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(3,"no","ËÎÒìÈË£º·³ÀÍÓ¢ĞÛ£¬·³ÀÍÓ¢ĞÛÁË£¬Ó¢ĞÛ²»´ÇĞÁ¿àÀ´¸æËßÀÏ·ò·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµäµÄÊÂÇé£¬ÀÏ·òÕæ²»ÖªµÀÔõÃ´¸ĞĞ»Äã°¡¡£ËµÊµ»°£¬×Ô´òÉÏ´ÎÓ¢ĞÛÌæÀÏ·òÑ¯ÎÊØÔÏó£¬ÀÏ·ò¾Í¾õµÃÓ¢ĞÛÕæÊÇÒ»Î»ÈÊÒåÖ®ÈË£¬¹ûÈ»Èç´Ë°¡¡£ºÃ£¬ÀÏ·ò¶¨µ±ºÃºÃ³ï±¸£¬¶¼ÒÑ¾­Á½ÄêÁË£¬ÕæÊÇ·á¸»¶à²ÊµÄÁ½Äê°¡¡­¡­","ËÎÒìÈË£ºÕâÒ²ÊÇÎÒÂ·±ßËù»ñ£¬Ó¦¸ÃÄÜÅÉÉÏ´óÓÃ³¡£¬Ó¢ĞÛÇëÊÕÏÂ°É¡£","ËÎÒìÈË£ºÓ¢ĞÛ¶¨È»»¹ÓĞÒªÊÂÔÚÉí£¬´«µİÏûÏ¢¾ÍÓÉÀÏ·ò´úÀÍ°É¡£Çë×ª¸æÀñ¹Ù£¬Çìµä¶¨È»»áÈÈÄÖ·Ç³££¡")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do 
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end			
--			end
--			Talk(3,"no","ËÎÒìÈË£º·³ÀÍÓ¢ĞÛ£¬·³ÀÍÓ¢ĞÛÁË£¬Ó¢ĞÛ²»´ÇĞÁ¿àÀ´¸æËßÀÏ·ò·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµäµÄÊÂÇé£¬ÀÏ·òÕæ²»ÖªµÀÔõÃ´¸ĞĞ»Äã°¡¡£ËµÊµ»°£¬×Ô´òÉÏ´ÎÓ¢ĞÛÌæÀÏ·òÑ¯ÎÊØÔÏó£¬ÀÏ·ò¾Í¾õµÃÓ¢ĞÛÕæÊÇÒ»Î»ÈÊÒåÖ®ÈË£¬¹ûÈ»Èç´Ë°¡¡£ºÃ£¬ÀÏ·ò¶¨µ±ºÃºÃ³ï±¸£¬¶¼ÒÑ¾­Á½ÄêÁË£¬ÕæÊÇ·á¸»¶à²ÊµÄÁ½Äê°¡¡­¡­","ËÎÒìÈË£ºÕâÒ²ÊÇÎÒÂ·±ßËù»ñ£¬Ó¦¸ÃÄÜÅÉÉÏ´óÓÃ³¡£¬Ó¢ĞÛÇëÊÕÏÂ°É¡£","ËÎÒìÈË£ºàŞ£¬Ó¢ĞÛ¿ìÈ¥½«Õâ¸öÏûÏ¢¸æËß<c=g>"..Npcs_zhaoge[i].."<c>°É£¬Ëû×î½ü»¹ÎÊ¹ıÕâÊÂÇéÄØ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)
--			TaskNote(1094, 0, Npcs_zhaoge[i])
--		end

--		local k = random(1,100)
--		if(k <= 5) then
--			AddNormalItem(8, 733, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÃÔÄã³¬¼¶»Ø³Ç·û¡£")
--			WriteLog("»ñµÃÃÔÄã³¬¼¶»Ø³Ç·û¡£")
--		elseif(k <= 17) then
--			AddNormalItem(8, 567, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâÒ°Íâ´«ËÍ·û¡£")
--			WriteLog("»ñµÃÈçÒâÒ°Íâ´«ËÍ·û¡£")
--		elseif(k <= 30) then
--			AddNormalItem(8, 781, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâ»Ø¹ú·û¡£")
--			WriteLog("»ñµÃÈçÒâ»Ø¹ú·û¡£")
--		elseif(k <= 65) then
--			AddNormalItem(8, 780, 4, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--		else
--			AddNormalItem(8, 779, 3, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--		end
--	end
--end
-- end of add yangtao 2009.8.19


--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 1); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ğÌâÊıÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "ËÎÒìÈË£ºÓ¢ĞÛ±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~     
--~     if (idx == 6) then
--~         Talk(1, "no", "ËÎÒìÈË£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ıµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("ËÎÒìÈË£ºÒÔÇ°ÇëÓ¢ĞÛ°ïÀÏ·ò´òÌıØÔÏóÒ»ÊÂ£¬Ó¢ĞÛ²»´ÇÀÍ¿à¸øÎÒ°ïÃ¦£¬½ñÈÕÈçÈôÓ¢ĞÛÄÜ»Ø´ğÀÏ·òµÄÎÊÌâ£¬ÀÏ·ò¿ÉÒÔËÍ¸øÓ¢ĞÛÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~     
--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 1); --µ±Ç°NPCµÄÌâÄ¿
--~     
--~     local TABLE_Ques = {
--~         [1] = { quest = "Ê®¾øÕóÖĞ£¬ÒÔÏÂÄÄ¸öÕóµôÂäÒìÈË140¼¶¼¼ÄÜÊé±©·çÖèÓê£¿", 
--~                     option = { [1]  = "ºìË®Õó", [2] = "º®±ùÕó", [3] = "»¯ÑªÕó", }, },
--~         [2] = { quest = "Íê³É¸ß¼¶Ê¦ÃÅÈÎÎñ¿ÉÒÔ»ñµÃÒÔÏÂÄÄ¸öÎïÆ·£¿", 
--~                     option = { [1]  = "Í½µÜ¿¨", [2] = "Á½ÒÇ¹éÕæ¾µ", [3] = "Ê¦¶÷Áî", }, },
--~         [3] = { quest = "Ò©²Ä¼Ó¹¤¼¼ÄÜ¿ÉÒÔÔÚÄÄÀïÑ§Ï°£¿", 
--~                     option = { [1]  = "ÓñĞé¹¬Éú»î¼¼Ê¦", [2] = "³¯¸èÉú»î¼¼Ê¦", [3] = "Î÷áªÉú»î¼¼Ê¦", }, },
--~         [4] = { quest = "ÁÙÏÉÂ¶¼ÆÊ±Ğ§¹ûÈçºÎÔİÍ££¿", 
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
--~     Say("ËÎÒìÈË£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

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

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 1); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 1, [2] = 3, [3] = 3, [4] = 1, [5] = 2,};
--~     
--~     if (TABLE_Key[idx] == choice) then
--~     
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "ËÎÒìÈË£ºÓ¢ĞÛËäÈ»´ğ¶ÔÁËÌâÄ¿£¬µ«±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "ËÎÒìÈË£ºÓ¢ĞÛ¹ûÈ»²ÅÖÇ¹ıÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ĞÛÁË¡£");
--~         
--~         SetTaskByte(TASK_ThreeYears_Questions, 1, 6); --µ±Ç°NPCµÄÌâÄ¿
--~         
--~         SetTaskByte(TASK_ThreeYears_Questions, 4, num + 1);

--~         DelNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0); 
--~         AddNormalItem(8, G_ThreeYears_1stFireworksId + num + 1, 2, 0, 0, 0);

--~         if (num + 1 < 5) then
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË"..(num + 1).."·İ×£¸£");
--~         else
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË×ã¹»µÄ×£¸£");
--~             WriteLog("»ñµÃÒ»¸öÂúÔØ×£¸£µÄÀñ»¨¡£");
--~             TaskNote(1610, 1);
--~         end
--~         
--~     else
--~         Talk(1, "no", "ËÎÒìÈË£ºÄãµÄ´ğ°¸²»¶Ô£¬ÇëÖØĞÂ×÷´ğ¡£");
--~     end

--~ end
--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
function Get_BackItem()
    CloseDialog()
    local nStep = GetTaskByte(Task_GetBackItem, 3)
    local nYear, nMonth, nDay = GetYMD()
    local item = GetBack_Info[nNpcIndex].itemInfo

    if (nYear == 2010 and ((nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7)) and GetTaskByte(Task_GetBackItem, 2) == nNpcIndex) then
        if (nStep == 1) then
            TaskNote(1612, 1, GetBack_Info[nNpcIndex].itemName, "Tèng DŞ Nh©n")
            SetTaskByte(Task_GetBackItem, 3, 2)
            Talk(2, "no", "Nghe nãi " .. GetBack_Info[nNpcIndex].mapName .. " bŞ c­íp mÊt råi" .. GetBack_Info[nNpcIndex].itemName .. ", h·y gióp t«i ®o¹t l¹i b¶o khİ tõ tay cña chóng!", "Nghe nãi ®· ®¸nh b¹i " .. GetBack_Info[nNpcIndex].mapName .. " cµng s©u trong ®éng th× x¸c suÊt nhËn ®­îc b¶o khİ cµng lín, tuy nhiªn b¹n còng cã thÓ mua tõ ng­êi ch¬i kh¸c.")
        elseif (nStep == 2) then
            if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
                TaskNote(1612, -1)
                SetTaskByte(Task_GetBackItem, 3, 0)
                DelNormalItem(item[1], item[2], item[3], item[4])

                local lv = GetLevel()
                local nExp = 0
                if (lv >= 30 and lv <= 50) then
                    nExp = lv * 1000
                elseif (lv >= 51 and lv <= 90) then
                    nExp = lv * 2000
                elseif (lv >= 91 and lv <= 150) then
                    nExp = lv * 3000
                elseif (lv >= 151 and lv <= 200) then
                    nExp = lv * 4000
                end

                AddOwnExp(nExp) -- ¸ø¾­Ñé
                ScrollMessage("B¹n nh©n ®­îc" .. nExp .. "kinh nghiÖm")
                Msg2Player("B¹n nh©n ®­îc" .. nExp .. "kinh nghiÖm")
                WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô T×m b¶o khİ")
                Talk(1, "no", "T×m ®­îc nhanh thÕ µ, c¶m ¬n ®¹i hiÖp, h·y nhËn lÊy phÇn th­ëng kinh nghiÖm!")
            else
                Talk(1, "no", "§¹i hiÖp vÉn ch­a gióp ta " .. GetBack_Info[nNpcIndex].itemName .. " tõ tay cña yªu ma, h·y ®i mau, thêi gian kh«ng cßn nhiÒu!")
            end
        end
    end
    refreshNpcTaskState()
end
-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

