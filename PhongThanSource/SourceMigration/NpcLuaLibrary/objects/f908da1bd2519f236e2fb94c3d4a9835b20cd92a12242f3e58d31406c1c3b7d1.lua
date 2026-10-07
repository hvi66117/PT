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




-- 副本Session定时器到时触发函数，自动调用
function OnTimer()

    StopSessionTimer(Timer_Check);
    StopSessionTimer(Timer_End);

    ReleaseInstance(InstanceID);
end


