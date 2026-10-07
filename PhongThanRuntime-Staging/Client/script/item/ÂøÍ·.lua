TASK_CookMaster = 1650;
TASKINFO_CookMaster = 1513;

NPCTASK_SuDaJi_HelpSoldierMutex = 1;
NPCTASK_SuDaJi_HelpSoldierPlayerID = 2;
NPCTASK_SuDaJi_CuredSoldierNum = 3;
NPCTASK_SuDaJi_DeadSoldierNum = 4;
NPCTASK_TABLE_SuDaJi_SoldierIdx = {
    [1] = 11,
    [2] = 12,
    [3] = 13,
    [4] = 14,
    [5] = 15,
    [6] = 16,
}

NPCTASK_Soldier_Type = 1;
NPCTASK_Soldier_SuDaJiIdx = 2;
NPCTASK_Soldier_TimerFlag = 3;

SOLDIER_TEMPLATE_ID = 1726;

SOLDIER_LEVEL = 1;

TABLE_CookMaster_TaskStep = {
    NotGetTask = 0,
    GetFood = 1,
    GetFoodFinished = 2,
    HelpSoldier = 3,
    HelpSoldierCancelled = 4,
    HelpSoldierSuccess = 5,
    HelpSoldierFailed = 6,
    HelpSoldierFinished = 7,
    FinishTask = 8,
    Upgraded = 9,
}

TABLE_TaskMutex = {
    unlocked = 0,
    locked = 1,
}

TABLE_SoldierType = {
    hungry = 0,
    starving = 1,
    dying = 2,
}

function main()

    local TargetIdx = GetPlayerTarget();

    if (GetNpcTemplateID(TargetIdx) ~= SOLDIER_TEMPLATE_ID) then
        Msg2Player("Mµn thÇu chØ cã thÓ sö dông ®èi víi th­¬ng binh.");
        return 0;
    end

    local SoldierIdx = TargetIdx;

    local SuDaJiIdx = GetNpcTask(SoldierIdx, NPCTASK_Soldier_SuDaJiIdx);
    local HelpSoldierPlayerID = GetNpcTask(SuDaJiIdx, NPCTASK_SuDaJi_HelpSoldierPlayerID);

    if (HelpSoldierPlayerID ~= GetPlayerID()) then


        ClearItem(6, 1, 791, 0);

        SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.HelpSoldierFailed);
        Msg2Player("HiÖn nh÷ng ng­êi kh¸c ®ang lµm nhiÖm vô, xin ®Õn gÆp T« §¾c Kû hñy nhiÖm vô sau ®ã thùc hiÖn l¹i!");
        TaskNote(TASKINFO_CookMaster, 4);

        return 0;
    end

    local nInterrupt = 0;
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 1)

    BeginMotion(SoldierIdx, 0, 6, "\\script\\motion\\ÉË±ø¾ÈÖÎ³É¹¦.lua", nInterrupt);

end

function GetPlayerTaskState()
    return 0, 0;
end

