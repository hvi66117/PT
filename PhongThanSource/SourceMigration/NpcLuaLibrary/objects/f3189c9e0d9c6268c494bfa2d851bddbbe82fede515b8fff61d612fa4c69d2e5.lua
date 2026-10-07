--description:npc
--author: zhujialiang
--date:2005/4/13

--hongliang 2010-1-18 Õæ¼ÙÄÑ±æ

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓĞş¶¼´ó·¨Ê¦ÕÒÏôÉı2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³ÉÑ©Ô­¾ŞÊŞ5Ñ©Ô­¾ŞÊŞÏÖ³öÔ­ĞÎ6»ØĞş¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)

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

-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 10

    -- ÇÙÆåÊé»­
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end


    -- Õæ¼ÙÄÑ±æ
    startLevel = 90;

    if (GetLevel() >= startLevel) then

        local TaskStep = GetTaskByte(TASK_TorF, 1);
        if (TaskStep == TABLE_TorF_TaskStep.KillBeastSuccess) then
            state = 3;
            subState = 0;
        else
            state = 0;
            subState = 0;
        end

        index = searchForIndex(state, subState, index);
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    local tasks = {
        [1] = { "<c=yel>CÇm Kú Th­ Häa<c>", "renwu13"; show = 0 },
        --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 begin
        [2] = { "<c=yel>Râ ch©n t­íng<c>", "Button_TheTruth"; show = 0 },
        --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 end
    }
    if (GetPlayerType() == 1) and (GetLevel() >= 13) and (GetTaskByte(Task_newer13, 1) == 1) then
        tasks[1].show = 1
    end ;

    --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 begin

    if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.KillBeastSuccess) then
        tasks[2].show = 1;
    end

    --added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 end

    SayTask(11382, tasks)
end;

function no()
    CloseDialog()
end;

----------------13,18ĞÂÊÖÈÎÎñ----yaoxin 09/04/28
function renwu13()
    CloseDialog()
    local state13 = GetTaskByte(Task_newer13, 1)
    if (GetTaskByte(Task_newer13, 1) == 1) then
        Talk(1, "no", "Phæ HiÒn:Ta ®· biÕt ı ng­¬i ®Õn ®©y, nh­ng ta chØ biÕt ®­îc tung tİch cña <c=g>Minh ¢m CÇm<c>, hiÖn ®ang ë trong ®éng B¨ng Lang trªn Thñ D­¬ng S¬n, ng­êi ph¶i t×m ®­îc B¨ng Lang vµ tiªu diÖt chóng, chóng sÏ tù ®éng hiÕn d©ng <c=g>Minh ¢m cÇm<c>")
        SetTaskByte(Task_newer13, 1, 2)
        Msg2Player("§Õn Thñ D­¬ng S¬n tiªu diÖt B¨ng Lang, ®o¹t lÊy Minh ¢m CÇm.")
        TaskNote(207, 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end
---------------------------------------



--added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 begin

function Button_TheTruth()

    CloseDialog();
    if (GetTaskByte(TASK_TorF, 1) == TABLE_TorF_TaskStep.KillBeastSuccess) then

        if (IsHaveSpaceForTreasure(3) == 0) then
            Talk(1, "no", "Kh«ng ®ñ chç trèng nhËn phÇn th­ëng nhiÖm vô, h·y s¾p xÕp İt nhÊt 2 « tói.");
            return 0;
        end

        Talk(1, "no", "§å nhi KiÒu Kh«n cña ta ®· bŞ tªn T«n Thiªn Qu©n h¹i chÕt tõ l©u, kh«ng ngê tiÓu anh hïng v× muèn cøu ®å nhi ta ®· gÆp HuyÔn Hãa Thó. TÊm lßng cña ng­¬i bÇn ®¹o rÊt c¶m kİch, xin tÆng 2 viªn ®¬n d­îc nµy, nÕu gÆp nguy hiÓm cã thÓ b¶o toµn tİnh m¹ng.");

        SetTaskByte(TASK_TorF, 1, TABLE_TorF_TaskStep.FinishTask);
        TaskNote(TASKINFO_TorF, -1);
        refreshNpcTaskState();

        ClearItem(6, 1, 804, 0);
        ClearItem(6, 1, 805, 0);
        ClearItem(6, 1, 806, 0);
        ClearItem(6, 1, 807, 0);

        --¸ø½±Àø
        AddNormalItem(8, 926, 1, 0, 0, 0);
        AddNormalItem(8, 927, 1, 0, 0, 0);
        TopMessage("NhËn ®­îc  Cöu ChuyÓn Hoµn MÖnh §¬n Cöu ChuyÓn Hoµn ThÇn §¬n");

        --¼Ó¾­Ñé
        AddOwnExp(1500000);
        Msg2Player("NhËn ®­îc 150 v¹n ®iÓm kinh nghiÖm th­ëng ");

    else

    end

    return 0;
end

--added by HongLiang for Õæ¼ÙÄÑ±æ 10/1/18 end

