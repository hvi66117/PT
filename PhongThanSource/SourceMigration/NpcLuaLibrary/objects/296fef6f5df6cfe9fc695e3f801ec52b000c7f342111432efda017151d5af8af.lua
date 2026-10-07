--description: ÉÙê»Í¼ÌÚ-Ò©Æ·ÏúÊÛÕß
--author:  chensong
--date: 2004/6/29
--³õ³öÃ©Â®ÈÎÎñ±äÁ¿
Task_NewPlayer = 1067

--    ×Î×Î²»¾ëÈÎÎñ×´Ì¬¿ØÖÆ±äÁ¿
Task_Book = 1090

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
    if (GetLevel() >= 1) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 3) then
                state = 2
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 3) then
                state = 2
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ç¿ÕßÖ®Â·
    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(30)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 1
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(30)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 1
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --×Î×Î²»¾ë
    startLevel = 4
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Book)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(7, 49, 450, 0) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Book)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(7, 49, 450, 0) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 2) then
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
        { "<c=yel>Mao L­<c>", "newplayer"; show = 0 },
        { "<c=yel>Khai TrÝ<c>", "renwu1"; show = 0 },
        { "<c=yel>CÇn mÉn<c>", "LikeBook"; show = 0 },
    }

    --ÊÇ·ñÏÔÊ¾³õ³öÃ©Â®°´Å¥
    local UTask_NewPlayer = GetTask(Task_NewPlayer);
    if ((UTask_NewPlayer == 1 or UTask_NewPlayer == 2 or UTask_NewPlayer == 6) and GetPlayerType() == 2) then
        tasks[1].show = 1
    end ;
    --30   Ç¿ÕßÖ®Â·µÄÈÎÎñ±äÁ¿
    local UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
    if ((UTask_20 == 0 or UTask_20 == 1) and GetPlayerType() == 2) then
        tasks[2].show = 1;
    end ;

    --    ×Î×Î²»¾ëÈÎÎñ×´Ì¬¿ØÖÆ±äÁ¿
    local L_LikeBook = GetTask(Task_Book)
    if (L_LikeBook == 0 and GetLevel() >= 4 and GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;

    if (L_LikeBook == 1 and HaveNormalItem(7, 49, 450, 0) >= 1) then
        tasks[3].show = 1;
    end ;
    SayTask(10162, tasks)
end;

--³õ³öÃ©Â®Ö´ÐÐº¯Êý
function newplayer()
    local UTask_NewPlayer = GetTask(Task_NewPlayer);
    if (UTask_NewPlayer == 1) then
        SetTask(Task_NewPlayer, 2)
        SetSubTask(1000, 1, 1)
        AddOwnExp(45)
        TopMessage(12151)
        Msg2Player("NhËn ®­îc 45 ®iÓm kinh nghiÖm.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
        MsgBox(12321, "yes_newplayer", "no")
    end ;

    if (UTask_NewPlayer == 2) then
        MsgBox(12321, "yes_newplayer", "no")
    end

    if (UTask_NewPlayer == 6) then
        SetTask(Task_NewPlayer, 7)
        AddOwnExp(100)
        TopMessage(12322)
        Msg2Player("nhËn ®­îc 100 ®iÓm kinh nghiÖm.")
        --AS GaoJingwei 090730
        SetSubTask(1000, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(1000, -1)
        Talk(1, "no", 12323)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;
--
function yes_newplayer()
    Talk(1, "no", 12324)
    SetTask(Task_NewPlayer, 3)
    TaskNote(1000, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function yes_strong()
    tasks_strong = {
        { "<c=yel>Khai TrÝ<c>", "renwu1"; show = 1 },
    }
    SayTask(12325, tasks_strong)
end;

function renwu1()
    --	UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
    --	if (UTask_20==4)then
    --		AddNormalItem(1,0,1,1,0,0)
    --		AddNormalItem(1,0,1,1,0,0)
    --		AddNormalItem(1,0,1,1,0,0)
    --		AddNormalItem(1,3,1,1,0,0)
    --		AddNormalItem(1,3,1,1,0,0)
    --		AddNormalItem(1,3,1,1,0,0)
    --        AddOwnExp(300)
    --        TopMessage("»ñµÃ300¾­Ñé")
    --		Msg2Player("Ñ°ÕÒÇ¿´óµÄÍ¾¾¶£¬µÃµ½ÉÙê»½±ÀøµÄ3¸öÐ¡ºìµ¤¡¢3¸öÐ¡»¹µ¤ºÍ300µã¾­Ñé¡£")
    --		TaskNote(13,-1)
    --		SetTask(30,5)
    --		Talk(1,"no",10163)
    --	end;
    local UTask_20 = GetTask(30)
    if (UTask_20 == 0 and GetPlayerType() == 2) then
        --		MsgBox("Ç°¼¸ÌìÎÒ×öÁËÒ»¸öÃÎ£¬ÃÎµ½ÎÒ×å±»»ÙÃðÁË£¬ÎÒÒ»Ö±Ë¼Ë÷ÕâÊÇÊ²Ã´Ô¤Õ×£¬Äã°ïÎÒÎÊÎÊ<c=r>¿ä¸¸<c>¡¢<c=r>ºóÍÁ<c>Á½Î»ÌýÌýËûÃÇµÄÒâ¼û£¡","no")
        SetTask(30, 1)
        Msg2Player("T×m Khoa Phô vµ HËu Thæ nhê chØ ®iÓm")
        MsgBox(12326, "yes_lookfor", "no");
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_20 == 1) then
        MsgBox(12326, "yes_lookfor", "no");
    end
end;

function yes_lookfor()
    Talk(1, "no", 12327)
    SetTask(30, 2)
    --AS GaoJingwei 090730
    SetSubTask(13, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(13, 10)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function no()
    CloseDialog()
end;
---------------------------
--function   renwu2()
--	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
--	if (idx == -1) then
--		return
--	end;
--	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
--		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
--				Talk(1,"no",12328)
--		elseif(GetLevel()<=50)or(GetLevel()>=71)then
--				Talk(1,"no",12329)
--		elseif(HaveNormalItem(3,63,0,0)>=1)or(GetTask(421)==GetMissionV(2,1))then
--				MsgBox(12330,"yes_wxz","no")
--		else
--				Talk(1,"no",12331)
--		end;
--end;
--
--function  yes_wxz()
--	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
--	if (idx == -1) then
--		return
--	end;
--	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
--	if(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<50)and(GetTask(421)~=GetMissionV(2,1))then
--
--		DelNormalItem(3,63,0,0)
--		DelHandItem(3,66,0,0)
--		DelHandItem(3,67,0,0)
--		DelHandItem(3,68,0,0)
--		DelHandItem(3,69,0,0)
--		for i=1,60 do
--				if(HaveNormalItem(3,66,0,0)>=1)then
--							DelNormalItem(3,66,0,0)
--				elseif(HaveNormalItem(3,67,0,0)>=1)then
--							DelNormalItem(3,67,0,0)
--				elseif(HaveNormalItem(3,68,0,0)>=1)then
--							DelNormalItem(3,68,0,0)
--				elseif(HaveNormalItem(3,69,0,0)>=1)then
--							DelNormalItem(3,69,0,0)
--				else
--							break;
--				end;
--		end;
--		SetFightState(0)
--		AddMSPlayer(2,1)
--		SetLogoutRV(1)
--		SetTask(421,GetMissionV(2,1))
--		NewWorld(68,1752,3567)
--		StopUsePills()
--		Msg2Player("ÐÞÁ¶×´Ì¬×Ô¶¯¹Ø±Õ£¡")
--		CloseDialog()
--	elseif(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(2,1))then
--		DelHandItem(3,66,0,0)
--		DelHandItem(3,67,0,0)
--		DelHandItem(3,68,0,0)
--		DelHandItem(3,69,0,0)
--			for i=1,60 do
--				if(HaveNormalItem(3,66,0,0)>=1)then
--							DelNormalItem(3,66,0,0)
--				elseif(HaveNormalItem(3,67,0,0)>=1)then
--							DelNormalItem(3,67,0,0)
--				elseif(HaveNormalItem(3,68,0,0)>=1)then
--							DelNormalItem(3,68,0,0)
--				elseif(HaveNormalItem(3,69,0,0)>=1)then
--							DelNormalItem(3,69,0,0)
--				else
--							break;
--				end;
--			end;
--
--		SetFightState(0)
--		AddMSPlayer(2,1)
--		SetLogoutRV(1)
--		SetTask(421,GetMissionV(2,1))
--		NewWorld(68,1752,3567)
--		StopUsePills()
--		Msg2Player("ÐÞÁ¶×´Ì¬×Ô¶¯¹Ø±Õ£¡")
--		CloseDialog()
--	elseif(GetGlobalValue(2)==2)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(2,1))then
--		DelHandItem(3,66,0,0)
--		DelHandItem(3,67,0,0)
--		DelHandItem(3,68,0,0)
--		DelHandItem(3,69,0,0)
--			for i=1,60 do
--				if(HaveNormalItem(3,66,0,0)>=1)then
--							DelNormalItem(3,66,0,0)
--				elseif(HaveNormalItem(3,67,0,0)>=1)then
--							DelNormalItem(3,67,0,0)
--				elseif(HaveNormalItem(3,68,0,0)>=1)then
--							DelNormalItem(3,68,0,0)
--				elseif(HaveNormalItem(3,69,0,0)>=1)then
--							DelNormalItem(3,69,0,0)
--				else
--							break;
--				end;
--			end;
--		SetFightState(1)
--		AddMSPlayer(2,1)
--		SetLogoutRV(1)
--		SetTask(421,GetMissionV(2,1))
--		NewWorld(68,1752,3567)
--		StopUsePills()
--		Msg2Player("ÐÞÁ¶×´Ì¬×Ô¶¯¹Ø±Õ£¡")
--		CloseDialog()
--	elseif(GetGlobalValue(2)==2)then
--	    Talk(1,"no",12332)
--	elseif(GetMSPlayerCount(2,1)>=50)then
--	    Talk(1,"no",12333)
--	else
--		Talk(1,"no",12334)
--	end;
--end;

function LikeBook()
    local L_LikeBook = GetTask(Task_Book)
    if (L_LikeBook == 0 and GetLevel() >= 4 and GetPlayerType() == 2) then
        MsgBox(12341, "yes_book", "no")
    elseif (L_LikeBook == 1 and HaveNormalItem(7, 49, 450, 0) >= 1) then
        Talk(1, "no", 12342)
        AddOwnExp(400)
        TopMessage(12343)
        Msg2Player("B¹n nhËn ®­îc 400 ®iÓm kinh nghiÖm!")
        SetTask(Task_Book, 2)
        --AS GaoJingwei 090730
        SetSubTask(1003, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(1003, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function yes_book()
    Talk(1, "no", 12344)
    SetTask(Task_Book, 1)
    Msg2Player("§Õn Vâ s­ mua 1 quyÓn Lùc SÜ TÕ cho ThiÕu H¹o xem thö!")
    --AS GaoJingwei 090730
    SetSubTask(1003, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(1003, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
