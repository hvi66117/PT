Task_xianguo = 1211;

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

TABLE_SoldierPos = {
    [1] = { 1558, 3176 },
    [2] = { 1560, 3185 },
    [3] = { 1550, 3192 },
    [4] = { 1550, 3171 },
    [5] = { 1542, 3187 },
    [6] = { 1542, 3176 },
}

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10

    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 3) == 0) or (GetTaskBit(Task_xianguo, 3) == 1 and (HaveNormalItem(3, 219, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 3) == 1) and (HaveNormalItem(3, 219, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 3) == 0) or (GetTaskBit(Task_xianguo, 3) == 1 and (HaveNormalItem(3, 219, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 3) == 1) and (HaveNormalItem(3, 219, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    tasks = {
        [1] = { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },


        [2] = { "NÊu n­íng", "Button_CookingRoad"; show = 0 },
        [3] = { "ViÖn trî", "Button_HelpingHand"; show = 0 },
        [4] = { "Huû nhiÖm vô", "Button_CancelHelpingHand"; show = 0 },


    }

    local ll = GetTask(Task_xianguo)

    if (GetBit(ll, 1) == 1 and GetBit(ll, 2) == 0 and GetBit(ll, 3) == 0) then
        tasks[1].show = 1

    elseif (GetBit(ll, 1) == 1 and GetBit(ll, 2) == 0 and GetBit(ll, 3) == 1 and IsExistItem(3, 219, 0, 0) == 0) then
        tasks[1].show = 1
    end

    local TaskStep = GetTaskByte(TASK_CookMaster, 1);

    if (TaskStep == TABLE_CookMaster_TaskStep.GetFood) then
        tasks[2].show = 1;
    end

    if (TaskStep == TABLE_CookMaster_TaskStep.GetFoodFinished

            or TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierCancelled
            or TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierSuccess) then

        tasks[3].show = 1;
    end

    if (TaskStep == TABLE_CookMaster_TaskStep.HelpSoldier
            or TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierFailed) then

        tasks[4].show = 1;
    end

    SayTask(11162, tasks);
end;

function no()
    CloseDialog()
end;

function xianguo()
    local str = "Ta ®ang cã 1 Tiªn qu¶, nh­ng c¸i ta thÝch nhÊt lµ Ch©u b¸u! NÕu ai cã mãn ch©u b¸u nµo quý l¹, ta sÏ ®æi cho Tiªn qu¶ nµy!"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "¤i! §Ñp qu¸! §óng lµ thø ta ®ang cÇn! C¶m ¬n nhÐ!")

        DelNormalItem(3, 218, 0, 0)

        AddNormalItem(3, 219, 0, 0, 0, 0)

        if (GetBit(GetTask(Task_xianguo), 3) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 3, 1))
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            TaskNote(73, 1)

        else
            local count = 0
            local tb = GetTask(Task_xianguo)
            local tmp_t = {
                "Sïng Thµnh ®¹i doanh-T« §¾c Kû (192,198)", "Ngäc H­ Cung-Nam Cùc Tiªn ¤ng (209,191)", "Xi V­u mé-VËt tæ Khoa phô (199,204)", "TriÒu Ca-Thæ Hµnh T«n (214,184)", "T©y Kú-B¸ Êp Kh¶o (168,195)"
            }
            local tmp_num = {}

            for i = 3, 7 do
                if (GetBit(tb, i) == 0) then
                    count = count + 1
                    tmp_num[count] = i - 2
                end
            end

            if (count == 1) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]])
            elseif (count == 2) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]])
            elseif (count == 3) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]])
            elseif (count == 4) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]], tmp_t[tmp_num[4]])
            else
                TaskNote(73, 1)
                SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            end


        end

        refreshNpcTaskState()


    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhÐ!")
    end
end;

function Button_CookingRoad()

    CloseDialog();
    if ((HaveNormalItem(8, 961, 0, 0) >= 1 or HaveNormalItemInQuick(8, 961, 0, 0) >= 1)
            and (HaveNormalItem(8, 962, 0, 0) >= 1 or HaveNormalItemInQuick(8, 962, 0, 0) >= 1)) then
        MsgBox("Xem ra ng­¬i lµ ng­êi thÝch hîp, h·y giao vËt ng­¬i mang ®Õn ®©y cho ta, ta sÏ gióp ng­¬i t¨ng kü n¨ng NÊu N­íng. TiÕp tôc nhiÖm vô sÏ khÊu trõ 1 V­ît Vò M«n vµ 1 Canh B¸ch Bæ, ng­¬i muèn tiÕp tôc kh«ng?", "Confirm_GetHelpingHandTask", "no");
    else
        Talk(1, "no", "Ng­¬i kh«ng cã vËt ta cÇn; muèn tiÕp tôc rÌn luyÖn, h·y mang t¸c phÈm ®Õn ®©y chøng minh thµnh qu¶ cña ng­¬i.");
    end

    return 0;
end

function Button_HelpingHand()

    CloseDialog();
    local TaskStep = GetTaskByte(TASK_CookMaster, 1);

    local mutex = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierMutex);
    local CurrentPlayer = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierPlayerID);
    local CuredNum = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_CuredSoldierNum);
    local DeadNum = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_DeadSoldierNum);

    if (TaskStep == TABLE_CookMaster_TaskStep.GetFoodFinished or TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierCancelled) then


        if (mutex == TABLE_TaskMutex.locked) then
            Talk(1, "no", "Ng­êi ch¬i kh¸c ®ang lµm nhiÖm vô, l¸t sau h·y b¾t ®Çu nhiÖm vô.");
            return 0;
        end

        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "no", "Hµnh trang cña ng­¬i kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i råi ®Õn nhËn nhiÖm vô.");
            return 0;
        end

        MsgBox("Ng­¬i muèn b¾t ®Çu nhiÖm vô ViÖn trî kh«ng?", "Start_HelpingHand", "Later_HelpingHand");

        return 0;


    elseif (TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierSuccess) then


        ClearItem(6, 1, 791, 0);

        SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.HelpSoldierFinished);

        Talk(1, "no", "Chóc mõng anh hïng ®· th«ng qua nhiÒu kh¶o nghiÖm, h·y ®Õn TriÒu Ca t×m Sinh Ho¹t S­ nhËn phÇn th­ëng nhiÖm vô, b¾t ®Çu häc kü n¨ng NÊu N­íng");
        TaskNote(TASKINFO_CookMaster, 6);

        return 0;


    else

        return 0;
    end

    return 0;
end

function Button_CancelHelpingHand()

    CloseDialog();
    local TaskStep = GetTaskByte(TASK_CookMaster, 1);

    local mutex = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierMutex);
    local CurrentPlayer = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierPlayerID);
    local CuredNum = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_CuredSoldierNum);
    local DeadNum = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_DeadSoldierNum);

    if (TaskStep == TABLE_CookMaster_TaskStep.HelpSoldierFailed) then


        ClearItem(6, 1, 791, 0);
        SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.HelpSoldierCancelled);

        Talk(1, "no", "Tuy ng­¬i ®· hñy bá nhiÖm vô, nh­ng ta biÕt ng­¬i lµ bËc tuÊn kiÖt kh«ng phô kú väng cña mäi ng­êi, cã thÓ khiªu chiÕn l¹i ®Ó chøng minh tÊm lßng cña ng­¬i");
        TaskNote(TASKINFO_CookMaster, 5);

        return 0;

    elseif (TaskStep == TABLE_CookMaster_TaskStep.HelpSoldier) then


        if (mutex == TABLE_TaskMutex.locked and CurrentPlayer == GetPlayerID()) then
            Talk(1, "no", "§ang tiÕn hµnh nhiÖm vô, l¸t sau h·y ®Õn hñy bá");


        else


            ClearItem(6, 1, 791, 0);
            SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.HelpSoldierCancelled);

            Talk(1, "no", " Tuy ng­¬i ®· hñy bá nhiÖm vô, nh­ng ta biÕt ng­¬i lµ bËc tuÊn kiÖt kh«ng phô kú väng cña mäi ng­êi, cã thÓ khiªu chiÕn l¹i ®Ó chøng minh tÊm lßng cña ng­¬i");
            TaskNote(TASKINFO_CookMaster, 5);

        end
        return 0;

    else

    end

    return 0;
end

function Start_HelpingHand()

    CloseDialog();

    local mutex = GetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierMutex);

    if (mutex == TABLE_TaskMutex.locked) then
        Talk(1, "no", "Ng­êi ch¬i kh¸c ®ang lµm nhiÖm vô, l¸t sau h·y b¾t ®Çu nhiÖm vô.");
        return 0;
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Hµnh trang cña ng­¬i kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i råi ®Õn nhËn nhiÖm vô.");
        return 0;
    end

    TaskNote(TASKINFO_CookMaster, 2);

    SetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierMutex, TABLE_TaskMutex.locked);
    SetNpcTask(DialogNpcIdx, NPCTASK_SuDaJi_HelpSoldierPlayerID, GetPlayerID());
    SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.HelpSoldier);

    AddNormalItem(6, 1, 791, 0, 0, 0);

    local rand = math.random(1, 3);
    local x, y = 0, 0;
    local SoldierIdx = 0;
    for i = 1, 6 do

        x = TABLE_SoldierPos[i][1];
        y = TABLE_SoldierPos[i][2];

        SoldierIdx = AddNpc(SOLDIER_TEMPLATE_ID, SOLDIER_LEVEL, SubWorld, x * 32, y * 32, 0);

        SetNpcTask(DialogNpcIdx, NPCTASK_TABLE_SuDaJi_SoldierIdx[i], SoldierIdx);

        SetNpcTask(SoldierIdx, NPCTASK_Soldier_SuDaJiIdx, DialogNpcIdx);

        if (i <= rand) then
            SetNpcTask(SoldierIdx, NPCTASK_Soldier_Type, TABLE_SoldierType.dying);
            SetNpcTimer(SoldierIdx, "\\script\\ontimer\\ÉË±ø³¬Ê±.lua", 23);
            SetNpcName(SoldierIdx, "<c=red>Th­¬ng binh hÊp hèi<c>");
        elseif (i <= rand + 3) then
            SetNpcTask(SoldierIdx, NPCTASK_Soldier_Type, TABLE_SoldierType.hungry);
            SetNpcTimer(SoldierIdx, "\\script\\ontimer\\ÉË±ø³¬Ê±.lua", 68);
            SetNpcName(SoldierIdx, "<c=green>Th­¬ng binh ®ãi kh¸t<c>");
        else
            SetNpcTask(SoldierIdx, NPCTASK_Soldier_Type, TABLE_SoldierType.starving);
            SetNpcTimer(SoldierIdx, "\\script\\ontimer\\ÉË±ø³¬Ê±.lua", 38);
            SetNpcName(SoldierIdx, "<c=yellow>Th­¬ng binh ®ãi rÐt<c>");
        end
    end

    return 0;
end

function Later_HelpingHand()

    CloseDialog();
    TaskNote(TASKINFO_CookMaster, 1);

end

function Confirm_GetHelpingHandTask()

    CloseDialog();

    if ((HaveNormalItem(8, 961, 0, 0) >= 1 or HaveNormalItemInQuick(8, 961, 0, 0) >= 1)
            and (HaveNormalItem(8, 962, 0, 0) >= 1 or HaveNormalItemInQuick(8, 962, 0, 0) >= 1)) then


        if (HaveNormalItem(8, 961, 0, 0) >= 1) then
            DelNormalItem(8, 961, 0, 0);
        else
            DelNormalItemInQuick(8, 961, 0, 0);
        end

        if (HaveNormalItem(8, 962, 0, 0) >= 1) then
            DelNormalItem(8, 962, 0, 0);
        else
            DelNormalItemInQuick(8, 962, 0, 0);
        end

        SetTaskByte(TASK_CookMaster, 1, TABLE_CookMaster_TaskStep.GetFoodFinished);

        Talk(3, "Button_HelpingHand", " " .. GetName() .. ", hay l¾m, xem ra thµnh tÝch nÊu n­íng cña ng­¬i rÊt tèt, nh­ng nÊu n­íng kh«ng chØ cÇn cã tµi lµm bÕp, cßn cÇn c¶ tÊm lßng. ë Sïng Thµnh ®¹i doanh cã nhiÒu th­¬ng binh rÊt cÇn thøc ¨n, mau gióp hä ®Ó chøng minh tÊm lßng cña ng­¬i.", "§em sè Mµn thÇu nµy cho th­¬ng binh. Vµi ng­êi trong sè hä l©u råi kh«ng cã g× ®Ó ¨n, sè Mµn thÇu nµy cã thÓ cøu m¹ng hä. Ghi nhí, mçi 1 th­¬ng binh chÕt ®i ®Òu lµ tæn thÊt to lín cña chóng ta.", "Chó ý! Nh÷ng th­¬ng binh hÊp hèi cÇn ®­îc ­u tiªn cøu gióp, sau ®ã míi ®Õn nh÷ng th­¬ng binh qu¸ ®ãi rÐt, cuèi cïng lµ nh÷ng th­¬ng binh ®ãi bông cån cµo. Ng­¬i cÇn cøu Ýt nhÊt 15 th­¬ng binh míi cã thÓ th«ng qua lÇn thö th¸ch nµy. NÕu cã 6 th­¬ng binh tö vong, ng­¬i sÏ thÊt b¹i. Chóc may m¾n!" .. GetName() .. ".");

    else

    end

    return 0;
end










