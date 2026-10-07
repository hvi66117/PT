-- yangyankun£»2010-1-6£»¸±±¾º®±ùÕó

--hongliang 2010-1-18 Õæ¼ÙÄÑ±æ


--------------------Õæ¼ÙÄÑ±æ---------------------------

TASK_TorF = 1677;  --1st byte: ÈÎÎñ²½Öè
TASKINFO_TorF = 1522;

QIAOKUN_TEMPLATE_ID = 1770;
BEAST_TEMPLATE_ID = 1771;
BEAST_LEVEL = 90;

TABLE_TorF_TaskStep = {
    NotGetTask = 0, --Î´¿ªÆôÕæ¼ÙÄÑ±æÈÎÎñ
    LetterOpened = 1, --ÒÑ¿ªÆôÃÜÐÅ
    KongbaifuOpened = 2, --ÒÑ¿ªÆô¿Õ°×·ûÖä
    GetYouxianfu = 3, --ÒÑµÃµ½ÓÎÏÉ·û
    HelpQiaokun = 4, --ÒÑ½ÓÊÜ¾ÈÖúÇÇÀ¤µÄÈÎÎñ
    KillBeastSuccess = 5, --ÒÑ³É¹¦´ò°Ü»Ã»¯ÊÞ
    FinishTask = 6, --ÒÑÍê³ÉÕæ¼ÙÄÑ±æÈÎÎñ
}


--------------------Õæ¼ÙÄÑ±æ---------------------------

function OnDeath(npcIndex)
    if (PlayerIndex > 0) then
        -- ±»ÈË´òËÀ
        ThrowItem(npcIndex, PlayerIndex, 8, 987, 2, 0, 0, 0)        -- ¼²·çµ¤
        ThrowItem(npcIndex, PlayerIndex, 6, 1, 692, 0, 0, 0)        -- Á¶µ¤Åä·½£º¼²·çµ¤

        local randValue = random(1, 2)
        if (randValue == 1) then
            ThrowItem(npcIndex, PlayerIndex, 3, 1046, 0, 0, 0, 0)        -- ±ùÓñËè
        end

        --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 begin
        if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.NotGetTask and HaveNormalItem(6, 1, 804, 0) == 0) then
            --ÆÆËðµÄÃÜÐÅ

            local rand = random(1, 5);
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
        --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 end

    else

    end

end
