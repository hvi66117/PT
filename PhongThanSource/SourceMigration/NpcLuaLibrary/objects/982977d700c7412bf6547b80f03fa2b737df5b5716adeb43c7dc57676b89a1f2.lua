--description: ³çÓ¦ð½
--author: yichuan
--date: 2004/6/28
Task_DefectorPlan = 1043;
Task_DefectNum = 1044;

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

    --¼æ°®·Ç¹¥
    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(24)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 5) and (HaveEventItemCount(189) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 5) and (HaveEventItemCount(189) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÅÑ¾ü¼Æ»®
    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) and (GetTask(24) == 20) then
        local taskProcess = GetTask(Task_DefectorPlan)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 9) and (HaveEventItemCount(190) >= 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 9) and (HaveEventItemCount(190) >= 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        --		{"±©ÓêÖ®ºó","renwu1";show=0},
        { "<c=yel>Kim ¸i<c>", "renwu2"; show = 0 },
        { "<c=yel>Ph¶n qu©n kÕ<c>", "DefectorPlan"; show = 0 }
    }
    --	UTask_10 = GetTask(20);
    UTask_14 = GetTask(24);
    --	if (UTask_10 == 10) or(UTask_10==12)or(UTask_10==14)or(UTask_10==16)then				
    --			tasks[1].show=1;
    --	end;
    --	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
    --			tasks[1].show=1;
    --	end;
    if (UTask_14 == 5 and HaveEventItemCount(189) >= 1) then
        tasks[1].show = 1;
    end
    if (UTask_14 == 0) and (GetPlayerType() == 0) and (GetLevel() >= 14) then
        tasks[1].show = 1;
    end ;
    local nDefectorPlan = GetTask(Task_DefectorPlan)
    if ((UTask_14 == 20 and nDefectorPlan == 0) or (nDefectorPlan == 9 and HaveEventItemCount(190) >= 3)) then
        tasks[2].show = 1
    end

    --	if (UTask_14 == 4)and (GetCamp()==0)then
    --						SetCamp(7)
    --						Talk(1,"no",11167)
    --						Msg2Player("ÄãÒÑ¾­µÃµ½¹ýÉú»î¼¼ÄÜÊé£¬Äã´Ó´ËÒ²²»ÔÙÊÇÐÂÊÖÁË¡£")
    --		end;

    --Add by gaojingwei for ÅÑ¾ü¼Æ»®bugÐÞ¸Ä begin
    if (GetTask(Task_DefectorPlan) == 10) then
        for i = 1, 3 do
            DelNormalItem(4, 190, 0, 1)
        end
    end
    --Add by gaojingwei for ÅÑ¾ü¼Æ»®bugÐÞ¸Ä end

    SayTask(10251, tasks)
end;
function DefectorPlan()
    local nDefectorPlan = GetTask(Task_DefectorPlan)
    if (nDefectorPlan == 0) then
        MsgBox(12588, "AcceptDefectorP", "no")
    else
        --	local nMenul = HaveEventItem( 190)
        --	local nRealCount = 0
        --	if( nDefectorPlan == 3 or nDefectorPlan == 4 or nDefectorPlan == 5)then
        --		nRealCount = 1
        ---    elseif( nDefectorPlan == 6 or nDefectorPlan==7 or nDefectorPlan ==8)then
        --		nRealCount =2
        --	elseif( nDefectorPlan == 9)then
        --		nRealCount = 3
        --	end
        --	local nCount = min( nRealCount,nMenul)
        local nExp = 5000
        AddOwnExp(nExp)
        TopMessage("NhËn ®­îc" .. nExp .. "kinh nghiÖm")
        Msg2Player("NhËn ®­îc" .. nExp .. "kinh nghiÖm.")
        SetTask(Task_DefectorPlan, 10)
        ----Íê³ÉÈÎÎñ
        for i = 1, 3 do
            DelNormalItem(4, 190, 0, 1)
        end
        --AS GaoJingwei 090730
        SetSubTask(902, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(902, -1)

        MsgBox(12589, "new")
        if (GetTask(Task_DefectorPlan) == 10) then
            SyncBibleState(902, 0, 1)
        end ;

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end;
function new()
    Talk(1, "no", 12590)
end;

function AcceptDefectorP()
    SetTask(Task_DefectorPlan, 1)
    SetTask(Task_DefectNum, 0)
    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 1, 7))
    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 2, 12))
    --AS GaoJingwei 090730
    SetSubTask(902, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(902, 0)
    Talk(1, "no", 12591)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728	
end

function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 10) then
        Talk(1, "no", 10252)
        Msg2Player("§· th«ng b¸o cho Sïng øng Loan.")
        TaskNote(7, 2)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 12) then
        Talk(1, "no", 10252)
        Msg2Player("§· th«ng b¸o cho Sïng øng Loan.")
        TaskNote(7, 5)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 14) then
        Talk(1, "no", 10252)
        Msg2Player("§· th«ng b¸o cho Sïng øng Loan.")
        TaskNote(7, 7)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 16) then
        Talk(1, "no", 10252)
        Msg2Player("§· th«ng b¸o cho Sïng øng Loan.")
        TaskNote(7, 8)
        SetTask(20, UTask_10 + 1)
    end ;
end;

function renwu2()
    UTask_14 = GetTask(24);

    --	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
    --					Talk(1,"no",10253)
    --					DelEventItem(25)
    --					AddNormalItem(7,58,62,1,0,0)      --Éú»î¼¼ÄÜÊé
    --				Msg2Player("µÃµ½²É¿óÉú»î¼¼ÄÜÊé¡¶ÅÌ¹Å¿ªÌì¡·£¬¶øÇÒÄã´Ó´ËÒ²²»ÔÙÊÇÐÂÊÖÁË¡£")
    --				SetCamp(7)
    --					TaskNote(10,3)
    --					SetTask(24,4)
    --	end;
    --	if(UTask_14 ==0)  and (GetPlayerType()==0)and(GetLevel()>=12) then		
    --					Talk(3,"no",10254,10255,10256)
    --					Msg2Player("ÏòÚùÎÄ»¯½èÒ»°Ñ³úÍ·À´Ñ§Ï°²É¿ó¼¼ÄÜ¡£")
    --					TaskNote(10,0)
    --					SetTask(24,1)		
    --	end;
    if (UTask_14 == 0) then
        if ((GetMorphType() == 364 or GetMorphType() == 420 or GetMorphType() == 419)) then
            Talk(1, "no", 14279)
        else
            PolyMorph(3, 1, 0, -1, 1800)
            Talk(1, "no", 12592)
            TopMessage(12593)
        end

        SetTask(24, 1)
        --AS GaoJingwei 090730
        SetSubTask(10, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(10, 0)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_14 == 5 and HaveEventItemCount(189) >= 1) then
        DelEventItem(189)
        if (GetMorphType() == 3) then
            PolyMorph(-1, 0, 0, 0, 0)
        end
        SetTask(24, 20)
        --AS GaoJingwei 090730
        SetSubTask(10, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(10, -1)
        local prop = random(39, 59)
        --		local prop1 = random(1,2)
        AddNormalItem(6, 1, prop, 1, 0, 0, 0)
        AddOwnExp(3000)
        --for i = 1,5 do
        --AddNormalItemPile(5,0,0,1,0,0)
        --end
        AddItemPileNum(5, 0, 0, 1, 10)        --added by hyz for ÓÅ»¯ 090709
        TopMessage(12594)
        --Msg2Player("»ñµÃ3000¾­Ñé£¬5ÕÅ»Ø³Ç·û¡£")
        Msg2Player("NhËn ®­îc 3000 kinh nghiÖm, 10 Håi thµnh phï.")

        --		if( prop1 == 1)then
        --			AddNormalItem(0,2,0,2,0,0)
        --			TopMessage( "»ñµÃ2000¾­Ñé£¬<c=g>¾Þ¶·¼×<c>")
        --			Msg2Player("»ñµÃ2000¾­Ñé£¬<c=g>¾Þ¶·¼×<c>¡£")
        --		else
        --			AddNormalItem(0,9,0,2,0,0)
        --			TopMessage( "»ñµÃ2000¾­Ñé,<c=g>¾Þ¶·Åû·ç<c>")
        --			Msg2Player("»ñµÃ2000¾­Ñé£¬<c=g>¾Þ¶·Åû·ç<c>¡£")
        --		end

        Talk(1, "no", 12595)
        if (GetTask(24) == 5) then
            SyncBibleState(10, 0, 1)
        end ;

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end
end;

function no()
    CloseDialog()
end;
