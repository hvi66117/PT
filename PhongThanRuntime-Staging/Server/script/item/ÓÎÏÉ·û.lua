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

    if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.HelpQiaokun) then

        local TargetIdx = GetPlayerTarget();
        if (GetNpcTemplateID(TargetIdx) ~= QIAOKUN_TEMPLATE_ID) then
            Msg2Player("Du Tiªn Phï chØ cã thÓ sö dông víi KiÒu Kh«n");
            return 0;
        end

        local QiaokunIdx = TargetIdx;

        local nInterrupt = 0;
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 1)
        nInterrupt = SetBit(nInterrupt, 4, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)

        BeginMotion(QiaokunIdx, 0, 10, "\\script\\motion\\¾È³ö¼ÙÇÇÀ¤.lua", nInterrupt);

    else

    end

    return 0;
end



