TASK_AlchemyMaster = 1648;
TASKINFO_AlchemyMaster = 1512;

NPCTASK_Tree_Mutex = 1;
NPCTASK_Tree_CurrentPlayer = 2;
NPCTASK_Tree_TrapIdx = 3;

X_Tree, Y_Tree = 1215, 2892;
TREE_TEMPLATE_ID = 1705;

TRAP_TEMPLATE_ID = 1703;
TRAP_LEVEL = 1;

TABLE_AlchemyMaster_MainTaskStep = {
    NotGetTask = 0,
    GetDanyao = 1,
    GetRenshenzhu = 2,
    GetRenshenzhuCancelled = 3,
    FinishTask = 4,
    Upgraded = 5,
}

TABLE_AlchemyMaster_RenshenzhuTaskStep = {
    NotGetTask = 0,
    SetTrap = 1,
    SetTrapOT = 2,
    TrapSettled = 3,
    TrigerWawaOT = 4,
    KillWawa = 5,
    KillWawaFailed = 6,
    FinishTask = 7,
}

TABLE_TaskMutex = {
    unlocked = 0,
    locked = 1,
}

function no()
    CloseDialog();
end

function main()

    local MainTaskStep = GetTaskByte(TASK_AlchemyMaster, 1);
    local RenshenzhuTaskStep = GetTaskByte(TASK_AlchemyMaster, 2);
    local MapID, x, y = GetWorldPos();

    if (MapID ~= 10) then
        Talk(1, "no", "Ph¶i ®Õn gÇn <c=g>Thñ D­¬ng ThÇn Méc<c> míi cã thÓ sö dông <c=g>D©y ®á<c> lËp bÉy.");
        return 0;
    end

    if (RenshenzhuTaskStep == TABLE_AlchemyMaster_RenshenzhuTaskStep.NotGetTask) then

        Talk(1, "no", "Muèn sö dông <c=g>BÉy<c> cÇn ph¶i kÝch ®éng <c=g>Thñ D­¬ng ThÇn Méc<c>.");
        return 0;

    elseif (RenshenzhuTaskStep == TABLE_AlchemyMaster_RenshenzhuTaskStep.SetTrap) then

        local TreeIdx = SearchNpcByNameAt("Thñ D­¬ng ThÇn Méc", SubWorld, X_Tree * 32, Y_Tree * 32, 3);

        if (GetNpcTemplateID(TreeIdx) ~= TREE_TEMPLATE_ID) then

            return 0;
        end
        local mutex = GetNpcTask(TreeIdx, NPCTASK_Tree_Mutex);
        local CurrentPlayer = GetNpcTask(TreeIdx, NPCTASK_Tree_CurrentPlayer);

        if (mutex ~= TABLE_TaskMutex.locked or CurrentPlayer ~= GetPlayerID()) then

            return 0;
        end

        local distance = (x - X_Tree) ^ 2 + (y - Y_Tree) ^ 2;
        if (distance > 500) then
            Talk(1, "no", "Xin ®Õn c¹nh <c=g>Thñ D­¬ng ThÇn Méc<c> ®Æt bÉy sÏ dô ®­îc H×nh Ném Nh©n S©m.");
            return 0;
        end

        local TrapIdx = AddNpc(TRAP_TEMPLATE_ID, TRAP_LEVEL, SubWorld, x * 32, y * 32, 0);
        SetNpcScript(TrapIdx, "\\script\\npctrap\\ºìÏßÏÝÚå.lua");

        SetGuardLevel(TrapIdx, 2);

        SetNpcTimer(TrapIdx, "\\script\\ontimer\\ºìÏßÏÝÚå³¬Ê±.lua", 13 * 60);

        SetNpcTask(TreeIdx, NPCTASK_Tree_TrapIdx, TrapIdx);

        SetTaskByte(TASK_AlchemyMaster, 2, TABLE_AlchemyMaster_RenshenzhuTaskStep.TrapSettled);

        ClearItem(6, 1, 786, 0);

        Talk(1, "no", "Xin kÝch ®éng <c=g>Thñ D­¬ng ThÇn Méc<c> lµm kinh ®éng <c=g>H×nh Ném Nh©n S©m<c> hiÖn th©n!");
        TaskNote(TASKINFO_AlchemyMaster, 3);

        return 0;

    elseif (RenshenzhuTaskStep == TABLE_AlchemyMaster_RenshenzhuTaskStep.SetTrapOT) then

        Talk(1, "no", "Thêi gian ®Æt bÉy ®· qua! Xin kÝch ®éng l¹i <c=g>Thñ D­¬ng ThÇn Méc<c>, ®Æt bÉy l¹i!");
        return 0;

    else

        ClearItem(6, 1, 786, 0);
        return 0;
    end

end

function GetPlayerTaskState()
    return 0, 0;
end



