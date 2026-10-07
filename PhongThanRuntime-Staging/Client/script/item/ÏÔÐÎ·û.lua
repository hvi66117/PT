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

    if (TaskStep == TABLE_TorF_TaskStep.KongbaifuOpened
            or TaskStep == TABLE_TorF_TaskStep.GetYouxianfu
            or TaskStep == TABLE_TorF_TaskStep.HelpQiaokun) then

        if (HaveNormalItem(6, 1, 805, 0) ~= 0) then

            Talk(1, "no", GetName() .. "Trªn Tam S¬n Hån Ph¸ch phï h×nh nh­ ®· hiÖn lªn c¸c ký tù.");

            ClearItem(6, 1, 805, 0);
            ClearItem(6, 1, 806, 0);
            AddNormalItem(6, 1, 807, 0, 0, 0);

            if (TaskStep == TABLE_TorF_TaskStep.KongbaifuOpened) then
                SetTaskByte(TASK_TorF, 1, TABLE_TorF_TaskStep.GetYouxianfu);
                TaskNote(TASKINFO_TorF, 4);
            end

        else
            Msg2Player("B¹n kh«ng mang theo Bïa kh«ng ch÷");
        end

    else

    end

    return 0;
end


