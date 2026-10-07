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

function OnDeath(npcIndex)
    if (PlayerIndex > 0) then
        ThrowItem(npcIndex, PlayerIndex, 8, 987, 2, 0, 0, 0)
        ThrowItem(npcIndex, PlayerIndex, 6, 1, 692, 0, 0, 0)

        local randValue = math.random(1, 2)
        if (randValue == 1) then
            ThrowItem(npcIndex, PlayerIndex, 3, 1046, 0, 0, 0, 0)
        end

        if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.NotGetTask and HaveNormalItem(6, 1, 804, 0) == 0) then

            local rand = math.random(1, 5);
            if (rand <= 1) then
                if (IsHaveSpaceForTreasure(2) == 0) then
                    Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®¹o cô nhiÖm vô.");
                else
                    ClearItem(6, 1, 804, 0);
                    AddNormalItem(6, 1, 804, 0, 0, 0);
                    TopMessage("NhËn ®­îc <c=g>MËt Th­ R¸ch<c>");
                end
            end

        end


    else

    end

end
