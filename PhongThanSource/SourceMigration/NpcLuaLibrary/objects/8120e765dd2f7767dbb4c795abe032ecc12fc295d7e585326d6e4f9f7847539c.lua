--description:³çºÚ»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11
--task 3 Îª¼×Ê¿Ö÷ÏßÈÎÎñ±äÁ¿

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

    --æäÂ·³ÁÏã
    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 10) then
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

function main()
    tasks = {
        { "TrÇm H­¬ng", "renwu1"; show = 0 },
        --		{"ÐÂÊ½ÎäÆ÷","renwu2";show=0},
        { "V¹n Tiªn", "renwu3"; show = 0 }
    }

    UTask_Knight = GetTask(3);
    --		UTask_11 = GetTask(21);
    if (GetPlayerType() == 0) and (GetLevel() >= 35) and (UTask_Knight == 10) then
        --¼×Ê¿15¼¶?Îñ
        tasks[1].show = 1;
    end ;
    --		if (UTask_11 == 6)  then
    --				tasks[2].show=1;
    --		end;
    SayTask(10238, tasks)
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

function renwu1()
    local mark = fangchenmi()
    if (mark == 1) then
        MsgBox(10239, "yes", "no")
    else
        Talk(1, "no", 11718)
    end
end;

--function   renwu2()
--				Talk(1,"no",10240)
--				Msg2Player("³çºÚ»¢µÄÈ°ËµÒ»¶¨»á³É¹¦µÄ£¬È¥ÚùÎÄ»¯ÄÇÀï¾²ºò¼ÑÒô°É¡£")
--				TaskNote(8,6)
--				SetTask(21,7)
--end;

function yes()
    Talk(1, "no", 10241)
    Msg2Player("NhËn lÖnh Sïng H¾c Hæ ®em 10 xe TrÇm H­¬ng Méc ®Õn TriÒu Ca cho Hoµng Phi Hæ.")
    AddEventItem(45)
    SetTask(3, 11)
    TaskNote(27, 3)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;
--------------------------
function renwu3()
    idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
    if (idx == -1) then
        return
    end ;
    SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", 12510)
    elseif (GetLevel() <= 29) or (GetLevel() >= 51) then
        Talk(1, "no", 12511)
    elseif (HaveNormalItem(3, 62, 0, 0) >= 1) or (GetTask(421) == GetMissionV(1, 1)) then
        MsgBox(12512, "yes_wxz", "no")
    else
        Talk(1, "no", 12513)
    end ;
end;

function yes_wxz()
    idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
    if (idx == -1) then
        return
    end ;
    SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
    if (GetGlobalValue(1) == 1) and (GetMSPlayerCount(1, 1) < 50) and (GetTask(421) ~= GetMissionV(1, 1)) then

        DelNormalItem(3, 62, 0, 0)
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(0)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 1) and (GetMSPlayerCount(1, 1) < 55) and (GetTask(421) == GetMissionV(1, 1)) then
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(0)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 2) and (GetMSPlayerCount(1, 1) < 55) and (GetTask(421) == GetMissionV(1, 1)) then
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(1)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 2) then
        Talk(1, "no", 12514)
    elseif (GetMSPlayerCount(1, 1) >= 50) then
        Talk(1, "no", 12515)
    else
        Talk(1, "no", 12516)
    end ;
end;
