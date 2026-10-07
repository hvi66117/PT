--hongliang 2010-1-18 Õæ¼ÙÄÑ±æ

--------------------Õæ¼ÙÄÑ±æ---------------------------

TASK_TorF = 1677;  --1st byte: ÈÎÎñ²½Öè
TASKINFO_TorF = 1522;

QIAOKUN_TEMPLATE_ID = 1770;
BEAST_TEMPLATE_ID = 1771;
BEAST_LEVEL = 90;

TABLE_TorF_TaskStep = {
    NotGetTask = 0, --Î´¿ªÆôÕæ¼ÙÄÑ±æÈÎÎñ
    LetterOpened = 1, --ÒÑ¿ªÆôÃÜĞÅ
    KongbaifuOpened = 2, --ÒÑ¿ªÆô¿Õ°×·ûÖä
    GetYouxianfu = 3, --ÒÑµÃµ½ÓÎÏÉ·û
    HelpQiaokun = 4, --ÒÑ½ÓÊÜ¾ÈÖúÇÇÀ¤µÄÈÎÎñ
    KillBeastSuccess = 5, --ÒÑ³É¹¦´ò°Ü»Ã»¯ÊŞ
    FinishTask = 6, --ÒÑÍê³ÉÕæ¼ÙÄÑ±æÈÎÎñ
}


--------------------Õæ¼ÙÄÑ±æ---------------------------

function OnDeath(BeastIdx)

    if (GetTeam() ~= 0) then

        local MapID1, xBeast, yBeast = GetNpcWorldPos(BeastIdx);
        local MapID2, x, y = 0, 0, 0;
        local distance = 0;
        local NameList = "";

        local num = GetTeamSize();
        local TmpIdx = PlayerIndex;

        for i = 1, num do

            PlayerIndex = GetTeamMember(i);

            if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.HelpQiaokun) then

                MapID2, x, y = GetWorldPos();
                distance = (x - xBeast) ^ 2 + (y - yBeast) ^ 2;
                if (distance <= 400) then

                    SetTaskByte(TASK_TorF, 1, TABLE_TorF_TaskStep.KillBeastSuccess);
                    TaskNote(TASKINFO_TorF, 7);

                    ClearItem(6, 1, 804, 0);
                    ClearItem(6, 1, 805, 0);
                    ClearItem(6, 1, 806, 0);
                    ClearItem(6, 1, 807, 0);

                    if (NameList == "") then
                        NameList = GetName();
                    else
                        NameList = NameList .. "," .. GetName();
                    end

                end

            end

        end

        PlayerIndex = TmpIdx;

        if (NameList ~= "") then
            AddGlobalCountNews(NameList .. "§èi ®Çu Cæ Hoan Thó trong Hãa HuyÕt TrËn, chÕ phôc nã sau trËn kŞch chiÕn!", 3);
        end

    else

    end

    DelNpc(BeastIdx);

    return 0;
end
