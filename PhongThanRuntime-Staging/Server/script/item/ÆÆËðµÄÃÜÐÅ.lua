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

    if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.NotGetTask) then

        SetTaskByte(TASK_TorF, 1, TABLE_TorF_TaskStep.LetterOpened);
        ClearItem(6, 1, 804, 0);

        Talk(1, "no", "Trªn giÊy h×nh nh­ viÕt: *...hån ph¸ch ®ang bÞ nhèt trong trËn...®ang ®îi Thiªn Qu©n ph¸t l¹c...*. RÊt nhiÒu ch÷ khã nhËn ra.");
        TaskNote(TASKINFO_TorF, 0);

    else

    end

    return 0;
end


