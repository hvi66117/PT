--description: ¶ÄÍ½-Ã÷Öé°µÍ¶ÈÎÎñ
--author: chensong
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
--------------------------- ÖĞÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ıÏÚ 
--                    3:È¥ÈıÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ı´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊı
-- 3byte:Ê±¼ä´Á
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·şÎñÆ÷ËùÓĞÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊı
TaskNote_zhongqiu = 1103
--------------------------- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------
-- AS yangshuang at 091026
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

    --Ã÷Öé°µÍ¶
    startLevel = 43
    if (GetLevel() >= startLevel) then
        local UTask_cg_1 = GetTask(41)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (UTask_cg_1 == 0 and GetLevel() >= 43) then
                state = 1
                subState = 0
            end

        else
            if (UTask_cg_1 == 0 and GetLevel() >= 43) then
                --À¶É«
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE yangshuang at 091026 end 

function main(sel)
    tasks = {
        { "Minh Ch©u", "renwu1"; show = 0 },
        --			 {"ÔÂ¹¬¼ÑÈË","AutumFes";show = 0 }
        -- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
        --{"ÖĞÇï»î¶¯", "zhongqiu"; show = 0},
        -- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
    }

    UTask_cg_1 = GetTask(41);
    if (UTask_cg_1 == 0) and (GetLevel() >= 43) then
        tasks[1].show = 1;
    end ;

    --	local nTasksData = GetTask(task_AutumnFestival)
    --	local nTaskStatus = mod(nTasksData,2 )
    --	if( nTaskStatus ~=0 )then
    --					tasks[2].show = 1
    --	end
    -- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
    --if(GetTaskByte(Task_zhongqiu, 1) == 1) then
    --	 tasks[2].show=1;
    --end
    -- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
    SayTask(10036, tasks)
end;
--function AutumFes()
--	local nTaskInfo = GetTask(task_AutumFes_info)
--	local nTaskCome = GetBit(nTaskInfo,8)
--	if( nTaskCome == 1 )then
--		if( GetBit( nTaskInfo ,2) == 1)then
--			MsgBox("¶ÄÍ½£ºÄãÊÇÎÊ×ÅÁË£¬Ç°ÈÕ¹ı½Ö£¬Ê°µÃÒ»±¦£¬½ğË¿ÒøÏßµÄÄÃÁËµ±È¥¶¨ÄÜ¹»ÎÒ·­»Ø±¾Ç®£¬ºÙºÙ£¬ÈçÄãÏëÒª£¬Ò²ºÃ°ì£¬¸øÎÒ5Íò½ğÇ®£¬Ã»Ç®ÃâÌ¸¡£","PayForPic","no")
--			return
--			
--		else
--			SetTask( task_AutumFes_info,SetBit( GetTask(task_AutumFes_info),8,0))
--			Talk(1,"no","¶ÄÍ½£ºÎÒÕâÃ»ÓĞËéÆ¬¡£")
--		end
--	else
--		Talk(1,"no","¶ÄÍ½£ºÄãÒÑ¾­À´¹ıÁË£¬ÎÒÕâÃ»ÓĞÄãĞèÒªµÄ¶«Î÷ÁË¡£")
--	end
--end

--function PayForPic()
--	if(GetCash() >= 50000)then
--		Pay(50000)
--		local nItemStatus = GetTask(task_AutumItem_info)
--		for i = 1,4 do
--			local nItemID = GetByte( nItemStatus, i )
--			if( nItemID ~= 0 )then
--				AddNormalItem( task_Item[nItemID].id1,task_Item[nItemID].id2,task_Item[nItemID].id3,task_Item[nItemID].id4,0,0)
--				SetTask( task_AutumItem_info,SetByte( GetTask( task_AutumItem_info ),i,0))
--				break
--			end
--		end
--		SetTask( task_AutumFes_info,SetBit( GetTask(task_AutumFes_info),2,0))
--		SetTask( task_AutumFes_info,SetBit( GetTask(task_AutumFes_info),8,0))
--		Talk(1,"no","¶ÄÍ½£º¸øÄã»­Æ¬£¬ºÃºÃÄÃºÃ¡£")
--	else
--		Talk(1,"no","¶ÄÍ½£ºÄãÇ®²»¹»¡£")
--	end
--end
function renwu1()
    Talk(2, "bujie", 10037, 10038)

end;

function bujie()
    Talk(2, "no", 10039, 10040)
    Msg2Player("T×m chñ tiÖm cÇm ®å dß la tin tøc §Şnh H¶i B¶o Ch©u.")
    TaskNote(20, 0)
    SetTask(41, 1)
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;

-- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
--function zhongqiu()
--	if(IsHaveSpaceForTreasure(1) == 0) then	
--		Talk(1, "no", "Ã»ÓĞ×ã¹»µÄ¿Õ¼ä,ÎŞ·¨¼ÌĞøÈÎÎñ¡£")
--		return
--	end
--	Talk(1, "no", "¶ÄÍ½£ºÄãËãÕÒ¶ÔÈËÁË£¬¸øÄãÔÂ±ıÄ£¾ß£¬¿ìµ½<c=r>ÈıÉ½¹Ø¡¢Ê×ÑôÉ½¡¢ÓÎ»ê¹Ø<c>ÖÜ±ßÑ°ÕÒ<c=r>»ÆÖĞÀî¡¢Óñºì²İ¡¢³¤´ºÊ÷<c>Ã¿ÑùÒ»¸ö£¬È»ºó»ØÀñ¹ÙÄÇÀïºÏ³ÉÔÂ±ıÏÚÁÏ°É£¡")
--	SetTaskByte(Task_zhongqiu, 1, 2)
--	TaskNote(TaskNote_zhongqiu, 1)
--	AddNormalItemPile(4, 274, 0, 1, 0, 0)
--end
-- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
