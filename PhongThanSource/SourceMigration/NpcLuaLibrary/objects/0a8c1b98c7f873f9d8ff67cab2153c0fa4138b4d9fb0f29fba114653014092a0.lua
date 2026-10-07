--description:?´óÁr
--author: yichuan
--date: 2004/7/19

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

    --ÈËÖ®½«ËÀ
    startLevel = 27
    if (GetLevel() >= startLevel) then
        local UTask_world_2 = GetTask(92)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (UTask_world_2 == 0) then
                state = 1
                subState = 0
            elseif (UTask_world_2 == 5 and GetMorphType() == 249) then
                state = 3
                subState = 0
            elseif (UTask_world_2 >= 1 and UTask_world_2 <= 5) then
                state = 2
                subState = 0

            end
        else
            --À¶É«
            if (UTask_world_2 == 0) then
                state = 1
                subState = 1
            elseif (UTask_world_2 == 5 and GetMorphType() == 249) then
                state = 3
                subState = 1
            elseif (UTask_world_2 >= 1 and UTask_world_2 <= 5) then
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
        { "Phu Thª", "renwu1"; show = 0 },
        { "Hñy bá nhiÖm vô Phu Thª", "renwu2"; show = 0 },
        --{"¶şÖÜÄêÇìµä","twoyearcel";show = 0},
    }
    UTask_world_2 = GetTask(92);
    if (UTask_world_2 == 5) and (GetMorphType() == 249) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_2 == 0) and (GetLevel() >= 27) then
        tasks[1].show = 1;
    end ;
    --added by yangtao 2009.8.17 ÏÔÊ¾È¡ÏûÈËÖ®½«ËÀÈÎÎñ
    if (UTask_world_2 ~= 0) and (UTask_world_2 ~= 6) then
        tasks[2].show = 1;
    end
    --end of add

    -- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
    --local y1, m1, d1 = GetYMD()
    --local H,M,S = Time2LocalHMS(nSysTaskTime)
    --if(y1 == 2009) and (m1 == 8) and (d1 == 29) and (GetTaskByte(Task_stage, 2) >= 1) and (GetTaskBit(Task_stage, 2) == 0) and (GetTaskBit(Task_stage, 18) == 1)then 
    --	tasks[3].show = 1
    --end
    -- end of add yangtao 2009.8.19
    SayTask(10436, tasks)
end;

function renwu1()
    UTask_world_2 = GetTask(92);
    if (UTask_world_2 == 5) then
        if (GetMorphType() == 249) then
            Talk(1, "no", 10437)
            AddWeightMax(20)
            AddOwnExp(50000)
            Msg2Player("Gióp v¬ chång NhËm §¹i Ca, nhËn ®­îc 50000 ®iÓm kinh nghiÖm vµ 20 ®iÓm søc lùc!")
            TopMessage(11926)
            --TaskNote(26,5)
            SetSubTask(26, -1, 1)
            TaskNote(26, -1)
            SetTask(92, 6)
            refreshNpcTaskState()
        end ;
    end ;
    if (UTask_world_2 == 0) and (GetLevel() >= 17) then
        --edited by yangtao 2009.8.17
        Talk(3, "func_check", 10438, GetName() .. ":§¹i tÈu cã viÖc xin cø nãi. ChØ cÇn lµm ®­îc, ta nhÊt ®Şnh kh«ng chèi tõ.", 10440)
        --end of edit
    end ;
end;

--added by yangtao 2009.8.17 È¡ÏûÈËÖ®½«ËÀÈÎÎñ
function renwu2()
    Msg2Player("§· hñy bá nhiÖm vô Phu Thª")
    TaskNote(26, -1)
    SetTask(92, 0)
    CloseDialog()
    refreshNpcTaskState()
end
--end of add

function func_check()
    --edited by yangtao 2009.8.17
    Talk(2, "func_check1", GetName() .. ":§¹i tÈu, víi n¨ng lùc cña ta hiÖn t¹i kh«ng thÓ ch÷a khái cho ®¹i ca.", 10442)
    --end of edit
end;

function func_check1()
    --edited by yangtao 2009.8.17
    MsgBox(GetName() .. "T×m 1 <color=yellow>Phi Thè<color> vµ 1 <color=yellow>Ngäc N÷<color> kh«ng ph¶i chuyÖn dÔ. Cã thËt ®ång ı gióp NhËm ®¹i tÈu kh«ng?", "yes_1", "no")
    --end of edit
end;

function yes_1()
    --edited by yangtao 2009.8.17
    Talk(1, "no", GetName() .. ":§¹i tÈu yªn t©m, ta ®i t×m D­¬ng TiÔn huynh ®Ö, nhÊt ®Şnh nhanh chãng t×m ®­îc <color=yellow>Phi Thè<color> vµ <color=yellow>Ngäc N÷<color>.")
    --end of edit
    Msg2Player("Lµm sao ®Ó b¾t Phi Thè vµ Ngäc N÷? Ph¶i ®i thØnh gi¸o D­¬ng TiÔn th«i.")
    TaskNote(26, 0)
    SetTask(92, 1)
    SetSubTask(26, 1, 1)
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
--	local Npcs_xiqi = 
--		{
--			"ĞÇ¹Ù",
--			"ÈÎ´óÉ©",
--			"Î÷ÓòÉñÃØÈË",
--			"Îä¼ª",
--			"²ÉÒ©ÀÏÈË"
--		}
--	local task_process	= GetTaskByte(Task_stage, 2)
--	SetTaskBit(Task_stage, 18, 0)
--	SetTaskBit(Task_stage, 2, 1)
--	local j = random(ran, 100)
--	if(j > 20) then
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(2,"no","ÈÎ´óÉ©£ºÓ¢ĞÛ»¹¼ÇµÃÅ«¼Ò·ò¸¾£¬Å«¼Ò·Ç³£¸ßĞË¡£ÎÒ¼ÒÏà¹«Ò»¶¨Ò²ÊÇÕâÃ´ÏëµÄ¡£Á½ÖÜÄêÇìµäÅ«¼Ò·ò¸¾¶şÈË¶¨µ±È«Á¦²¼ÖÃ£¬ÎÒ¼ÒÏà¹«ËäÈ»ÉíÌåĞéÈõ£¬µ«ÊÇÒ²Ò»¶¨ÀÖÒâ°ïµãĞ¡Ã¦µÄ¡£Ó¢ĞÛµ±ÄêÂú×ãÏà¹«µÄĞÄÔ¸£¬Å«¼ÒÔÙ´ÎĞ»¹ıÁË¡£","ÈÎ´óÉ©£º³¯¸è³ÇÖĞµÄÆäËûÈË¾ÍÓÉÅ«¼ÒÀ´Í¨¸æ°É£¬Ó¢ĞÛ¿É×ª´ïÀñ¹Ù´óÈË£¬´ó¼Ò»áÅ¬Á¦³ï±¸µÄ¡£")
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
--			Talk(2,"no","ÈÎ´óÉ©£ºÓ¢ĞÛ»¹¼ÇµÃÅ«¼Ò·ò¸¾£¬Å«¼Ò·Ç³£¸ßĞË¡£ÎÒ¼ÒÏà¹«Ò»¶¨Ò²ÊÇÕâÃ´ÏëµÄ¡£Á½ÖÜÄêÇìµäÅ«¼Ò·ò¸¾¶şÈË¶¨µ±È«Á¦²¼ÖÃ£¬ÎÒ¼ÒÏà¹«ËäÈ»ÉíÌåĞéÈõ£¬µ«ÊÇÒ²Ò»¶¨ÀÖÒâ°ïµãĞ¡Ã¦µÄ¡£Ó¢ĞÛµ±ÄêÂú×ãÏà¹«µÄĞÄÔ¸£¬Å«¼ÒÔÙ´ÎĞ»¹ıÁË¡£","ÈÎ´óÉ©£º¶ÔÁË£¬ÎÒ¼ÒµÄÁÚ¾Ó<c=g>"..Npcs_xiqi[i].."<c>Ò²²»ÖªµÀÕâ¼şÊÂÇé£¬Ó¢ĞÛÒ²Ó¦¸ÃÈ¥Í¨ÖªËûÒ»ÏÂ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)	
--			TaskNote(1094, 0, Npcs_xiqi[i])
--		end
--	else
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(3,"no","ÈÎ´óÉ©£ºÓ¢ĞÛ»¹¼ÇµÃÅ«¼Ò·ò¸¾£¬Å«¼Ò·Ç³£¸ßĞË¡£ÎÒ¼ÒÏà¹«Ò»¶¨Ò²ÊÇÕâÃ´ÏëµÄ¡£Á½ÖÜÄêÇìµäÅ«¼Ò·ò¸¾¶şÈË¶¨µ±È«Á¦²¼ÖÃ£¬ÎÒ¼ÒÏà¹«ËäÈ»ÉíÌåĞéÈõ£¬µ«ÊÇÒ²Ò»¶¨ÀÖÒâ°ïµãĞ¡Ã¦µÄ¡£Ó¢ĞÛµ±ÄêÂú×ãÏà¹«µÄĞÄÔ¸£¬Å«¼ÒÔÙ´ÎĞ»¹ıÁË¡£","ÈÎ´óÉ©£ºÕâÊÇÅ«¼ÒÅ¼È»»ñµÃµÄ¶«Î÷£¬»òĞíÓ¢ĞÛ»¹ÄÜÓĞµãÓÃ´¦£¬ÇëÊÕÏÂ°É£¡","ÈÎ´óÉ©£º³¯¸è³ÇÖĞµÄÆäËûÈË¾ÍÓÉÅ«¼ÒÀ´Í¨¸æ°É£¬Ó¢ĞÛ¿É×ª´ïÀñ¹Ù´óÈË£¬´ó¼Ò»áÅ¬Á¦³ï±¸µÄ¡£")
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
--			Talk(3,"no","ÈÎ´óÉ©£ºÓ¢ĞÛ»¹¼ÇµÃÅ«¼Ò·ò¸¾£¬Å«¼Ò·Ç³£¸ßĞË¡£ÎÒ¼ÒÏà¹«Ò»¶¨Ò²ÊÇÕâÃ´ÏëµÄ¡£Á½ÖÜÄêÇìµäÅ«¼Ò·ò¸¾¶şÈË¶¨µ±È«Á¦²¼ÖÃ£¬ÎÒ¼ÒÏà¹«ËäÈ»ÉíÌåĞéÈõ£¬µ«ÊÇÒ²Ò»¶¨ÀÖÒâ°ïµãĞ¡Ã¦µÄ¡£Ó¢ĞÛµ±ÄêÂú×ãÏà¹«µÄĞÄÔ¸£¬Å«¼ÒÔÙ´ÎĞ»¹ıÁË¡£","ÈÎ´óÉ©£ºÕâÊÇÅ«¼ÒÅ¼È»»ñµÃµÄ¶«Î÷£¬»òĞíÓ¢ĞÛ»¹ÄÜÓĞµãÓÃ´¦£¬ÇëÊÕÏÂ°É£¡","ÈÎ´óÉ©£º¶ÔÁË£¬ÎÒ¼ÒµÄÁÚ¾Ó<c=g>"..Npcs_xiqi[i].."<c>Ò²²»ÖªµÀÕâ¼şÊÂÇé£¬Ó¢ĞÛÒ²Ó¦¸ÃÈ¥Í¨ÖªËûÒ»ÏÂ¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)
--			TaskNote(1094, 0, Npcs_xiqi[i])
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