--hongliang 红砂阵 10/10/29


--------------------------------------
--副本临时变量
--1 ~ 4: TABLE_Npc中Npc的Idx
--5 ~ 8: TABLE_Npc中Npc的ID

TASK_Instance_HSZ = 601 --1st byte: 引导任务步骤 0-未接;1-已接;2-已和道人对话;3-已答应武王;4-已杀死boss;5-已完成任务;

NPCTVID_InstanceIdx = 0;
NPCTVID_InstanceId = 1;

INSTANCE_TYPE_HSZ = 10

BUFF_InstanceTime = 1344
Timer_Check = 68
Timer_End = 69
--------------------------------------


-- 副本Session初始化，创建副本时自动调用
function InitSession()

    StartSessionTimer(Timer_Check, 18 * 1 * 60);
    StartSessionTimer(Timer_End, 18 * 1 * 60 * 60 * 2);
    --		StartSessionTimer(Timer_End, 18*1*60*10); --mark
end

-- 副本Session运行函数
function RunSession()
end

-- 副本Session结束函数，结束副本时自动调用
function EndSession()
end

-- 副本Session玩家进入函数，玩家进入时自动调用
-- RoleIndex 进入玩家Index
function OnEnter(RoleIndex)

    local oldPlayer = PlayerIndex
    PlayerIndex = RoleIndex

    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(InstanceID)

    SetInstanceEnterFlag(INSTANCE_TYPE_HSZ, 1);

    LeaveTeam();
    SetFightState(1)
    SetCamp(7)
    LockCamp(1)--锁定阵营

    local lefttime = 2 * 60 * 60
    --		local lefttime = 10*60 --mark
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
    end

    --副本计时buff	
    RemoveIBBuff(BUFF_InstanceTime);
    AddIBBuff(BUFF_InstanceTime, lefttime);

    Msg2Player("Ti課 v祇 H錸g Sa Tr薾")
    ScrollMessage("Ti課 v祇 H錸g Sa Tr薾")
    --	Msg2Player("nSubWorldIdx="..nSubWorldIdx.."InstanceID="..InstanceID.."InstanceIndex="..InstanceIndex)	--debug
    WriteLog(GetName() .. "Ti課 v祇 H錸g Sa Tr薾, id: " .. InstanceID)

    --add by liujifang for 红砂阵优化 at 2010-12-09 begin
    SetTask(1741, InstanceID)
    --add by liujifang for 红砂阵优化 at 2010-12-09 end

    if (nCurrentEnterCount <= 1) then
        CreateTeam(1, 2)
    else
        local idx, nextPlayerIdx = 0, 0
        local isAddTeam = 0
        while 1 do
            idx, nextPlayerIdx = GetSessionNextPlayer(idx, 0)
            if (idx == 0) then
                break
            end

            PlayerIndex = nextPlayerIdx
            if (IsCaptain() == 1) then
                AddTeamMember(RoleIndex)
                isAddTeam = 1
                break
            end
        end

        if (isAddTeam == 0) then
            PlayerIndex = RoleIndex
            CreateTeam(1, 2)
        end
    end
    PlayerIndex = RoleIndex
    SetTeamFreezeFlag(1)--限制组队

    --	      --进入时在玩家身上记录副本的id和idx
    --		SetTask(TASKID_Instance, TVID_Instane_BHLH_InstanceIdx, InstanceIndex);
    --		SetTask(TASKID_Instance, TVID_Instane_BHLH_InstanceId, InstanceID);

    InstanceMsg2All(InstanceIndex, "Th玭g b竜", GetName() .. "Ti課 v祇 H錸g Sa Tr薾")
    PlayerIndex = oldPlayer
end


-- 副本Session玩家离开函数，玩家离开时自动调用
-- RoleIndex 离开玩家Index
function OnLeave(RoleIndex)

    local oldPlayer = PlayerIndex
    PlayerIndex = RoleIndex
    local nflag = GetInstanceEnterFlag(INSTANCE_TYPE_HSZ)

    LockCamp(0) --解冻阵营切换功能
    LeaveTeam()
    Msg2Player("B筺 tho竧 kh醝 H錸g Sa Tr薾")
    InstanceMsg2All(InstanceIndex, "Th玭g b竜", GetName() .. "Tho竧 kh醝 H錸g Sa Tr薾")
    WriteLog(GetName() .. "Tho竧 kh醝 H錸g Sa Tr薾")

    if (nflag ~= 3) then
        SetInstanceEnterFlag(INSTANCE_TYPE_HSZ, 2)
    end

    SetTeamFreezeFlag(0) --解除限制组队

    --	       --清空玩家身上记录的副本id和idx
    --		SetTask(TASKID_Instance, TVID_Instane_BHLH_InstanceIdx, 0);
    --		SetTask(TASKID_Instance, TVID_Instane_BHLH_InstanceId, 0);

    RemoveIBBuff(BUFF_InstanceTime);

    PlayerIndex = oldPlayer
end

function no()
    CloseDialog()
end
