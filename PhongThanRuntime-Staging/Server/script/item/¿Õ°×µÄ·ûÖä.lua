TASK_TorF = 1677;
TASKINFO_TorF = 1522;

QIAOKUN_TEMPLATE_ID = 1770;
BEAST_TEMPLATE_ID = 1771;
BEAST_LEVEL = 90;

TABLE_TorF_TaskStep = {
    NotGetTask = 0,
    LetterOpened = 1,
    KongbaifuOpened = 2,
    GetYouxianfu = 3,
    HelpQiaokun = 4,
    KillBeastSuccess = 5,
    FinishTask = 6,
}

function no()
    CloseDialog();
end

function main()

    local TaskStep = GetTaskByte(TASK_TorF, 1);

    if (TaskStep == TABLE_TorF_TaskStep.LetterOpened
            or TaskStep == TABLE_TorF_TaskStep.KongbaifuOpened
            or TaskStep == TABLE_TorF_TaskStep.GetYouxianfu
            or TaskStep == TABLE_TorF_TaskStep.HelpQiaokun) then

        Talk(1, "no", "TÊm phï nµy nghe nãi cã chøa Tam S¬n Hån Ph¸ch, nh­ng kh«ng hiÖn lªn 1 ch÷ nµo, ch¾c cã chøa Èn huyÒn c¬.");

        if (TaskStep == TABLE_TorF_TaskStep.LetterOpened) then
            SetTaskByte(TASK_TorF, 1, TABLE_TorF_TaskStep.KongbaifuOpened);
            TaskNote(TASKINFO_TorF, 2);
        end

    else

    end

    return 0;
end


