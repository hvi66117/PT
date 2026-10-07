Task_Destroy = 1038;
Task_thatch = 1019;
Task_CallDuty = 984

Task_thatch = 1019;
Task_TrySkill = 1020;
Task_Monster = { { name = "TÜnh Nh©n", id = 0, num = 8 } }

require("common.luax")

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
    local startLevel = 1

    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_TrySkill)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_TrySkill)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) then
                state = 0
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(Task_thatch) == 2) then
                state = 3
                subState = 0
            elseif (GetTask(Task_thatch) == 3) then
                state = 0
                subState = 0
            end
        else
            if (GetTask(Task_thatch) == 2) then
                state = 3
                subState = 1
            elseif (GetTask(Task_thatch) == 3) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(20)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 13) then
                state = 3
                subState = 0
            elseif (taskProcess == 14) then
                state = 0
                subState = 0
            elseif (taskProcess >= 10) and (taskProcess < 13) then
                state = 2
                subState = 0
            end
        else
            local taskProcess = GetTask(20)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 13) then
                state = 3
                subState = 1
            elseif (taskProcess == 14) then
                state = 0
                subState = 0
            elseif (taskProcess >= 10) and (taskProcess < 13) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 8
    if (GetLevel() >= 8) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            taskProcess = GetTask(23)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(3, 11, 0, 0) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            taskProcess = GetTask(23)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(3, 11, 0, 0) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 12
    if (GetLevel() >= startLevel) then
        local UTask_bianliang = GetTaskByte(26, 1)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_bianliang == 0) and (GetTaskByte(16, 3) < 10) then
                state = 1
                subState = 0
            elseif (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
                state = 3
                subState = 0
            elseif ((UTask_bianliang == 10) or (UTask_bianliang == 11)) then
                state = 2
                subState = 0
            end

        else
            if (UTask_bianliang == 0) and (Is6Times() >= 1) then
                state = 1
                subState = 1
            elseif (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
                state = 3
                subState = 1
            elseif ((UTask_bianliang == 10) or (UTask_bianliang == 11)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 36
    if (GetLevel() >= startLevel) then
        local nStatus = IsMailOpen()
        if (GetLevel() - startLevel <= 5) then
            if (GetLevel() >= 36 and nStatus == 0) then
                state = 1
                subState = 0
            end
        else
            if (GetLevel() >= 36 and nStatus == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 1
    if ((GetLevel() >= startLevel) and (GetPlayerType() == 0)) then
        local today = math.floor(LocalSystemTime() / 86400)
        local taskProcess = GetByte(GetTask(993), 1)
        local L_nums = GetByte(GetTask(993), 2) * 10
        local nums = GetTask(994)
        if (GetLevel() - startLevel <= 5) then
            if (((taskProcess == 0) and (IsTGetCallDuty() == 1)) or (GetTask(973) ~= today and taskProcess == 0)) then
                state = 1
                subState = 0
            elseif ((nums >= L_nums) and taskProcess ~= 0) then
                state = 3
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (((taskProcess == 0) and (IsTGetCallDuty() == 1)) or (GetTask(973) ~= today and taskProcess == 0)) then
                state = 1
                subState = 1
            elseif ((nums >= L_nums) and taskProcess ~= 0) then
                state = 3
                subState = 1
            else
                state = 2
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

function AcceptTry()
    if (GetTask(Task_TrySkill) == 0) then
        Talk(2, "no", "Chóc mõng hoµn thµnh nhiÖm vô Mao L­", "GÇn ®©y <c=r>Lç Hïng<c> ®ang huÊn luyÖn ®éi binh míi, nÕu anh hïng cã t­ chÊt tèt ta sÏ tiÕn cö, h·y ®Õn D· Ngo¹i tiªu diÖt <c=g>" .. Task_Monster[1].num .. "." .. Task_Monster[1].name .. "<c>, sau ®ã quay vÒ t×m ta phôc mÖnh!")
        AcceptTry1()
    else

        AddOwnExp(150)
        AddNormalItem(0, 7, 0, 1, 0, 0)
        for i = 1, 2 do
            AddNormalItemBind(3, 10, 0, 0, 0, 0, 1)
        end

        SetSubTask(907, -1, 1)
        SetTask(Task_TrySkill, 3)
        TopMessage(12605)
        TopMessage("Chóc mõng anh hïng nhËn 150 kinh nghiÖm, 1 HuyÒn Vò Kh«i vµ 2 §o¹n KiÕm")
        Msg2Player("Chóc mõng anh hïng nhËn 150 kinh nghiÖm, 1 HuyÒn Vò Kh«i vµ 2 §o¹n KiÕm")
        Msg2Player("§Õn gãc T©y B¾c cña b¶n ®å t×m Lç Hïng.")

        TaskNote(907, 4)
        if (GetTask(1020) == 3) then
            SyncBibleState(907, 0, 1)
        end ;
        refreshNpcTaskState()
        Talk(1, "no", "T¹p hãa th­¬ng:Muèn nhanh chãng ®¸nh b¹i kÎ ®Þch ngoµi vâ thuËt tinh th©m cßn cÇn ph¶i cã trang bÞ phßng vÖ tèt. Ta tÆng ng­¬i <c=g>HuyÒn Vò Kh«i<c>, h·y ®éi nã ®Õn gÆp <c=r>Lç Hïng<c>! Lç Hïng ®ang ë <c=g>phÝa T©y B¾c<c> khu vùc.")
    end
end

function AcceptTry1()
    SetTask(Task_TrySkill, 1)
    SetTask(Task_TryNum, 0)
    SetTask(Task_TryNum, SetByte(GetTask(Task_TryNum), 1, Task_Monster[1].id))
    MonsterName = "<c=r><NpcName=\"TÜnh Nh©n\",1><c>"

    SetSubTask(907, 1, 1)

    TaskNote(907, 0, MonsterName, Task_Monster[1].num)

    Talk(1, "no", 12606)

    refreshNpcTaskState()

end

function main(sel)
    tasks = {

        { "<c=yel>ThÝ luyÖn T©n Thñ<c>", "AcceptTry"; show = 0 },

        { "<c=yel>Mao L­<c>", "NewPlayer"; show = 0 },
        { "<c=yel>KÕ Tôc<c>", "renwu4_before"; show = 0 },
        { "<c=yel>Hép gÊm<c>", "renwu3"; show = 0 },
        { "<c=yel>Thñ khè<c>", "renwu1"; show = 0 },
        { "<c=yel>Danh väng Lôc §¹o Lu©n Håi<c>", "renwu2"; show = 0 },

        { "§ãng gãi vËt phÈm", "UnPackMain"; show = 1 },
        { "Nguyªn liÖu", "maMain"; show = 1 },


    }

    if (GetTask(Task_TrySkill) == 2 and GetTask(Task_thatch) == 1 or GetTask(Task_TrySkill) == 2) then

        tasks[1].show = 1
    end

    if (GetTask(Task_thatch) == 2) then

        tasks[2].show = 1
    end

    if (GetPlayerType() == 0) then
        local today = math.floor(LocalSystemTime() / 86400)
        if (GetTask(973) ~= today) and (GetTask(993) == 0) then
            SetTask(Task_CallDuty, 0)
            SetTask(973, today)
            Msg2Player("Ngµy míi ®· b¾t ®Çu. B¹n cã thÓ tiÕp tôc nhËn nhiÖm vô KÕ Tôc")
        end
        local bianliang = GetByte(GetTask(993), 1)
        if (IsTGetCallDuty() == 1) or (bianliang ~= 0) then

            tasks[3].show = 1
        end
    end
    UTask_xiangzi = GetTask(23);
    local UTask_bianliang = GetTaskByte(26, 1);
    UTask_10 = GetTask(20);

    if (UTask_xiangzi == 1) and (HaveNormalItem(3, 11, 0, 0) >= 5) then

        tasks[5].show = 1;
        tasks[8].show = 0;
    end ;
    if (UTask_xiangzi == 0 and GetLevel() >= 8) then

        tasks[5].show = 1;
        tasks[8].show = 0;
    end ;
    if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then

        tasks[6].show = 1;
    end ;
    if (UTask_bianliang == 0) and (GetLevel() >= 12) then

        tasks[6].show = 1;
    end ;
    if (UTask_10 == 1) then

        tasks[4].show = 1;
    end ;
    if (UTask_10 == 13) then

        tasks[4].show = 1;
    end ;
    SayTask(10223, tasks)

end;
npcname = {
    [1] = "TÜnh Nh©n",


    [4] = "B¾c H¶i Ph¶n Qu©n",


}
function POpenMail()
    local TaskTmp = {
        { "Göi b­u kiÖn", "POpenMailBox"; show = 0 },
        { "<c=g>Hép th­<c>", "POpenMailB"; show = 1 },
    }
    local nStatus = IsMailOpen()
    if (GetLevel() >= 36 and nStatus == 0) then
        TaskTmp[1].show = 1;
        SayTask("Ta phô tr¸ch qu¶n lý Hép Th­ cña thÕ giíi Phong ThÇn, khi ng­¬i cã b­u kiÖn nªn nhí ®Õn chç ta ®Ó xem.", TaskTmp)
    elseif (nStatus == 0) then
        OpenMailBox(0)
        CloseDialog()
    elseif (nStatus == 1) then
        OpenMailBox(1)
        CloseDialog()
    end
end
function POpenMailB()
    if (IsMailOpen() == 0) then
        OpenMailBox(0)
        CloseDialog()
    else
        OpenMailBox(1)
        CloseDialog()
    end
end
function POpenMailBox()
    MsgBox("Ng­¬i cã muèn göi th­ cho b»ng h÷u? Mang <color=green>5 cµnh LiÔu méc<color> ®Õn, ta sÏ gióp khai th«ng chøc n¨ng b­u kiÖn!", "Yes_OpenMail", "no")
end
function Yes_OpenMail()
    if (GetItemCount(39) >= 5) then
        for i = 1, 5 do
            DelEventItem(39)
        end
        OpenMail(1)
        refreshNpcTaskState()
        Talk(1, "no", "Xin chóc mõng! Tõ nay ng­¬i cã thÓ göi th­ ®­îc råi.")
    else
        Talk(1, "no", " H×nh nh­ ch­a ®ñ LiÔu méc, ta kh«ng thÓ gióp ®­îc!")
    end
end
function renwu4_before()
    npclink = {
        [1] = "<NpcName=\"TÜnh Nh©n\",1>",


        [4] = "<NpcName=\"B¾c H¶i Ph¶n Qu©n\",4>",


    }
    local Task_Tmp = {
        { "<c=yel>KÕ Tôc<c>", "renwu4"; show = 0 },
        { "T×m hiÓu", "ma"; show = 1 }
    }
    if (GetPlayerType() == 0) then
        local bianliang = GetByte(GetTask(993), 1)
        if (IsTGetCallDuty() == 1) or (bianliang ~= 0) then
            Task_Tmp[1].show = 1
        end
    end
    SayTask(10223, Task_Tmp)

end
function NewPlayer()
    AddOwnExp(50)
    SetTask(Task_thatch, 3)
    TaskNote(909, -1)

    SetSubTask(909, -1, 1)

    TopMessage(12133)
    Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm.")

    refreshNpcTaskState()

    CloseDialog()
    AcceptTry()
end

function renwu11()
    AddOwnExp(100)
    SetTask(Task_Destroy, 12)
    TopMessage(12130)
    Msg2Player("NhËn ®­îc 100 ®iÓm kinh nghiÖm")
    Talk(1, "no", 12557)
end
function pre_renwu4()
    local tasks_pre = {
        { "KÕ Tôc", "renwu4"; show = 1 }
    }
    SayTask(10223, tasks_pre)
end
function renwu4()
    local bianliang = GetByte(GetTask(993), 1)
    local L_nums = GetByte(GetTask(993), 2) * 10
    local nums = GetTask(994)

    local tasks1 = {
        { "TÜnh Nh©n", "yes_g1"; show = 1 },
        { "B¾c H¶i Ph¶n Qu©n", "yes_g2"; show = 1 }
    }

    if (bianliang == 0) then
        if (GetTask(Task_CallDuty) == 0) and (GetLevel() < 6) then
            MsgBox(12558, "yes_5", "no")
        elseif (GetTask(Task_CallDuty) == 0) and (GetLevel() >= 6) then
            SayTask(12559, tasks1)
        elseif (IsTGetCallDuty() == 1) then
            SayTask("§Ó khiÕn ng­¬i trë thµnh anh hïng cña ThÇn N«ng, mçi ngµy ta ph¶i thóc giôc ng­¬i, ng­¬i x¸c ®Þnh muèn nhËn nhiÖm vô thø <c=g>" .. (GetTask(Task_CallDuty) + 1) .. "</c> vßng sø m¹ng? NÕu ng­¬i chän tiªu diÖt TÜnh Nh©n sÏ cã c¬ héi nhËn §o¶n kiÕm, tiªu diÖt B¾c H¶i Ph¶n Qu©n cã thÓ nhËn To¸i gi¸p!", tasks1)
        else
            MsgBox(12202, "no")
        end
    else
        if (nums >= L_nums) and (bianliang >= 1) then
            SetTask(993, 0)
            Msg2Player("B¹n nhËn ®­îc 100 ®iÓm kinh nghiÖm!")
            TaskNote(51, -1)
            AddOwnExp(100)

            local today = math.floor(LocalSystemTime() / 86400)
            if (GetTask(973) ~= today) then
                SetTask(Task_CallDuty, 0)
                SetTask(973, today)

                refreshNpcTaskState()

                Msg2Player("Ngµy míi ®· b¾t ®Çu. B¹n cã thÓ tiÕp tôc nhËn nhiÖm vô KÕ Tôc")
            end

            if (IsTGetCallDuty() == 1) then
                Talk(1, "pre_renwu4", 12204)
            else
                Talk(2, "no", 12204, "H«m nay ng­¬i ®· rÊt mÖt råi! Xin h·y vÒ nghØ ng¬i d­ìng thÇn. Mai tiÕp tôc quay l¹i nhÐ!")
            end
        elseif (bianliang >= 1) and (nums < L_nums) then
            Talk(1, "no", "Ng­¬i cßn thiÕu <c=g>" .. (L_nums - nums) .. "." .. npcname[bianliang] .. "<c> th× sÏ th«ng qua lÇn kh¶o nghiÖm nµy! Cè lªn! (Chóng th­êng xuÊt hiÖn t¹i Sïng Thµnh, B¾c H¶i, YÕn S¬n)")
        end ;

        refreshNpcTaskState()

    end ;

    refreshNpcTaskState()

end;

function yes_g1()
    SetTaskWord(993, 1, 1)
    yes_5()
end

function yes_g2()
    SetTaskWord(993, 1, 4)
    yes_5()
end

function yes_5()
    SetTask(Task_CallDuty, GetTask(Task_CallDuty) + 1)

    refreshNpcTaskState()

    if (IsTGetCallDuty() == 0) then
        SyncBibleState(51, 3, 1)
    else
        SyncBibleState(51, 1, 1)
    end
    SetTask(994, 0)
    local w = ""
    local bianliang = GetByte(GetTask(993), 1)

    local l = 1
    local l1 = GetLevel()
    if (l1 <= 5) then
        bianliang = 1
        SetTaskWord(993, 1, 1)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        TopMessage(12205)
        Msg2Player("TÆng ng­¬i 1 TiÓu Hång §¬n trÞ th­¬ng!")
        Talk(1, "no", 12560)
    elseif (l1 >= 6) and (l1 < 11) then
        l = 2
        Talk(1, "no", "Thñ khè: Sø mÖnh cña ng­¬i lÇn nµy lµ tiªu diÖt <c=g>20 " .. npcname[bianliang] .. "</c>. Chóng th­êng xuÊt hiÖn ë <c=yel>Sïng Thµnh, B¾c H¶i, YÕn S¬n</c>. NÕu bÞ träng th­¬ng h·y lËp tøc quay l¹i t×m ta! NhÊn <c=yel>F11</c> ®Ó xem tiÕn tr×nh nhiÖm vô!")
    elseif (l1 >= 11) and (math.mod(l1, 10) == 0) and (l1 <= 50) then
        l = math.floor(GetLevel() / 10) + 1
    elseif (l1 >= 11) and (l1 <= 50) then
        l = math.floor(GetLevel() / 10) + 2
    elseif (l1 >= 51) then
        l = 7
    end

    refreshNpcTaskState()

    local task_L_nums = { [1] = 1, [2] = 2, [3] = 3, [4] = 6, [5] = 10, [6] = 20, [7] = 30 }
    w = npcname[bianliang]
    local wlink = npclink[bianliang]
    SetTaskByte(993, 2, task_L_nums[l])
    TaskNote(51, 0, wlink, (task_L_nums[l] * 10))
    Msg2Player("Sø mÖnh lÇn nµy lµ tiªu diÖt " .. (task_L_nums[l] * 10) .. "." .. w)
    if (GetTask(Task_CallDuty) <= 6) then
        AddIBBuff(2148)
        Msg2Player("Giao cho ngµi lùc cóng tÕ! Cã nã giÕt qu¸i vËt chØ ®Þnh cã thÓ nhanh chãng ®o¹t ®­îc vËt liÖu ®Æc biÖt.")
    end
    if (l > 2) then
        Talk(1, "no", "Thñ khè: Sø mÖnh cña ng­¬i lÇn nµy lµ tiªu diÖt <c=g>" .. (task_L_nums[l] * 10) .. "." .. w .. "</c>! Hy väng ng­¬i sÏ thuËn lîi!")
    end
end;
function NewWeapon()
    UTask_11 = GetTask(21);
    if (UTask_11 == 2) then
        AddOwnExp(50)
        Talk(1, "no", 12561)
        Msg2Player("NhËn nhiÖm vô KÕ Tôc sÏ cã ®­îc §o¹n KiÕm nhanh h¬n, thu thËp ®ñ 5 §o¹n KiÕm cho Thî ®ång!")
        TaskNote(8, 2)
        SetTask(21, 3)
    end
end

function UnPackMain()
    no()
    COMMON.UnPackMain()
    UnPackBag = COMMON.UnPackBag
    PotionBag = COMMON.PotionBag
    UnPackInfo = COMMON.UnPackInfo
    PotionBagYes = COMMON.PotionBagYes
    PotionBagYes1 = COMMON.PotionBagYes1
    PotionBagYes2 = COMMON.PotionBagYes2
    PotionBagYes3 = COMMON.PotionBagYes3
    PotionBag_Yes = COMMON.PotionBag_Yes
    PotionBag_Yes1 = COMMON.PotionBag_Yes1
    PotionBag_Yes2 = COMMON.PotionBag_Yes2
    PotionBag_Yes3 = COMMON.PotionBag_Yes3
    UnPackInfo1 = COMMON.UnPackInfo1
    Yes_UnPackBag = COMMON.Yes_UnPackBag
    UnPackBagYes = COMMON.UnPackBagYes
    UnPackBag_Yes = COMMON.UnPackBag_Yes
end

function maMain(sel)
    local tasks = {
        { "T×m hiÓu", "ma"; show = 1 },
        { "Nguyªn liÖu Tinh Hoa", "jinghua"; show = 1 },
        { "Nguyªn liÖu HiÕm", "xiyou"; show = 1 },
    }
    SayTask(10005, tasks)
end

function xiyou()

    Talk(1, "xiyou1", 12195)
end
function xiyou1()
    Talk(1, "no", 12196)
end
function jinghua()

    tasks = {
        { "§Þa T©m", "dijinghua"; show = 1 },
        { "Thñy Hån", "shuijinghua"; show = 1 },
        { "Háa Linh", "huojinghua"; show = 1 },
        { "Phong LÖ", "fengjinghua"; show = 1 },
        { "Tø Tinh", "sijinghua"; show = 1 },
        { "Lôc §¹o Tinh Hoa", "liujinghua"; show = 1 }
    }
    SayTask(11780, tasks)
end
function dijinghua()
    MsgBox(11781, "jinghua")
end
function shuijinghua()
    MsgBox(11782, "jinghua")
end
function huojinghua()
    MsgBox(11783, "jinghua")
end
function fengjinghua()
    MsgBox(11784, "jinghua")
end
function sijinghua()
    MsgBox(11785, "jinghua")
end
function liujinghua()
    MsgBox(11786, "jinghua")
end

function longfeng()
    if (GetExtPoint(6) == 1) then
        MsgBox(12197, "lf", "no")
    end ;
end;

function lf()
    PayExtPoint(6, 1)
    AddNormalItem(6, 1, 32, 1, 0, 0)
    CloseDialog()
    Msg2Player("B¹n nhËn ®­îc Long Phông phï.")
end;

function renwu1()
    UTask_xiangzi = GetTask(23);

    if (UTask_xiangzi == 1) and (HaveNormalItem(3, 11, 0, 0) >= 5) then
        Talk(1, "no", 10074)
        for i = 1, 5 do
            DelNormalItem(3, 11, 0, 0)
        end ;
        AddOwnExp(800)
        TopMessage(12562)
        Msg2Player("Cã thÓ sö dông r­¬ng chøa ®å ®Ó cÊt gi÷ vËt phÈm!")

        SetSubTask(9, -1, 1)

        TaskNote(3, -1)
        TaskNote(9, -1)
        TaskNote(15, -1)
        SetTask(23, 2)
        SetTask(33, 2)
        SetTask(13, 2)

        refreshNpcTaskState()

    end ;

    if (UTask_xiangzi == 0) then
        MsgBox(10224, "yes_1", "no")
    end ;
end;

function renwu2()
    local tasks = {
        { "<c=y>Lôc §¹o Lu©n Håi<c>", "yes_2"; show = 1 },
        { "<c=g>Hoµn thµnh<c> Lôc §¹o Lu©n Håi", "huan"; show = 0 },
        { "Nép 10 lÇn", "liudao10"; show = 1 },
        { "Nép §o¶n KiÕm", "liudaoT1"; show = 1 },
        { "Nép To¸i Gi¸p", "liudaoT2"; show = 1 },
    }

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local sth = "\nNép §o¶n KiÕm (hoÆc To¸i Gi¸p) mçi lo¹i 100 c¸i, ngoµi trang bÞ lôc, cßn nhËn ®­îc nhiÒu ®¹o cô kh¸c <c=r>Chó ý s¾p xÕp ®ñ chç trèng hµnh trang<c>"

    if (GetTaskByte(26, 1) > 0) then
        tasks[1].show = 0
        tasks[2].show = 1
    elseif (GetTaskByte(16, 2) ~= today) then
        SetTaskByte(16, 3, 0)
        SetTaskByte(16, 2, today)
        Msg2Player("Ngµy míi ®· b¾t ®Çu, ngµi cã thÓ tiÕp tôc nhËn 10 lÇn Lôc §¹o Lu©n Håi.")
    end

    if (GetLevel() <= 70) and (GetNewBirthTimes() < 1) or (Is6Times() < 10) then
        tasks[3].show = 0
        tasks[4].show = 0
        tasks[5].show = 0
        sth = "<c=r>Chó ý s¾p xÕp ®ñ chç trèng hµnh trang<c>"
    end

    SayTask("Ng­¬i cã thÓ gióp ta t×m vËt liÖu kh«ng?" .. sth, tasks)
end;

function Is6Times()
    local n = GetTaskByte(16, 3)
    local lvl = GetLevel()
    if (GetNewBirthTimes() >= 1) then
        return (200 - n)
    elseif (lvl <= 49) then
        return (10 - n)
    else
        return (math.floor((lvl - 40) / 10) * 10 + 10 - n)
    end
    return 0
end

function jiangli6(nIdx)
    local k = math.random(1, 100000)
    local m = math.random(1, 100)
    local lvl = GetLevel()
    local r1 = 8000
    local r2 = 0
    if (GetNewBirthTimes() >= 1) or (lvl >= 121) then
        r1 = 20000
        r2 = 5
    elseif (lvl >= 91) then
        r1 = 20000
        r2 = 3
    elseif (lvl >= 51) then
        r1 = 15000
        r2 = 2
    elseif (lvl >= 35) then
        r1 = 10000
        r2 = 1
    end

    if (nIdx == 1) then
        if (lvl > 50) then
            if (k <= r1) then
                AddNormalItemPile(4, 39, 0, 0, 0, 0)
                ScrollMessage("NhËn ®­îc thªm 1 LiÔu Méc")
                Msg2Player("NhËn ®­îc thªm 1 LiÔu Méc")
            elseif (k > 81500) and (k < 81550) then
                GreenEquipment()
            end
        else
            local green20 = GetTask(810)
            if (k <= r1) then
                AddNormalItemPile(4, 39, 0, 0, 0, 0)
                ScrollMessage("NhËn ®­îc thªm 1 LiÔu Méc")
                Msg2Player("NhËn ®­îc thªm 1 LiÔu Méc")
            elseif (k > 70000) and (k <= 80000) and (lvl <= 25) and (green20 == 0) then
                GreenEquipment()
            elseif (k > 80000) and (k <= 81000) and (lvl <= 25) and (green20 >= 1) and (green20 <= 2) then
                GreenEquipment()
            elseif (k > 81000) and (k <= 81500) and (lvl <= 25) and (green20 >= 3) then
                GreenEquipment()
            elseif (k > 81500) and (k < 81900 - lvl * lvl * 7 / 50) and (lvl > 25) then
                GreenEquipment()
            end
        end
    else
        if (k <= r1) then
            AddNormalItemPile(4, 39, 0, 0, 0, 0)
            ScrollMessage("NhËn ®­îc thªm 1 <c=g>LiÔu Méc")
            Msg2Player("NhËn ®­îc thªm 1 LiÔu Méc")
        end
    end

    if (m <= r2) then
        AddNormalItemPile(4, 48, 0, 0, 0, 0)
        ScrollMessage("NhËn ®­îc thªm 1 <c=r> h¹t gièng")
        Msg2Player("NhËn ®­îc thªm 1 h¹t gièng")
    end
end

function yes_2()
    local i = math.random(1, 2);
    local w = ""
    if (i == 1) then
        w = "§o¹n KiÕm"
        MsgBox("Nguyªn liÖu ta cÇn lÇn nµy lµ <c=r>" .. w .. "<c> 10 c¸i, gióp ta thu thËp chø? NÕu nhËn nhiÖm vô <c=g>Chiªu hån<c> cã thÓ thu thËp nguyªn liÖu nhanh h¬n.", "qd1", "no")

    else
        w = "To¸i Gi¸p"
        MsgBox("Nguyªn liÖu ta cÇn lÇn nµy lµ <c=r>" .. w .. "<c> 10 c¸i, gióp ta thu thËp chø? NÕu nhËn nhiÖm vô <c=g>Chiªu hån<c> cã thÓ thu thËp nguyªn liÖu nhanh h¬n.", "qd2", "no")

    end ;
end;

function qd1()
    if (Is6Times() <= 0) then
        Talk(1, "no", "VËt liÖu ta cÇn h«m nay ®· gom ®ñ, mêi ngµy mai l¹i tíi!")
        return 0
    end
    SetTaskByte(26, 1, 10)
    SetTaskByte(16, 3, GetTaskByte(16, 3) + 1)
    ScrollMessage("NhËn nhiÖm vô thñ khè Sïng Thµnh ®i t×m 10 §o¶n kiÕm.")
    TaskNote(12, 0, "§o¹n KiÕm")
    CloseDialog()
    refreshNpcTaskState()

    if (HaveNormalItem(3, 10, 0, 0) >= 10) then
        MsgBox("Ngµi x¸c nhËn nép <c=yel>§o¹n KiÕm<c> cho ta sao?", "huan", "no")
    end
end;

function qd2()
    if (Is6Times() <= 0) then
        Talk(1, "no", "VËt liÖu ta cÇn h«m nay ®· gom ®ñ, mêi ngµy mai l¹i tíi!")
        return 0
    end
    SetTaskByte(26, 1, 11)
    SetTaskByte(16, 3, GetTaskByte(16, 3) + 1)
    ScrollMessage("NhËn nhiÖm vô thñ khè Sïng Thµnh ®i t×m 10 To¸i Gi¸p.")
    TaskNote(12, 0, "To¸i Gi¸p")
    CloseDialog()
    refreshNpcTaskState()

    if (HaveNormalItem(3, 11, 0, 0) >= 10) then
        MsgBox("Ngµi x¸c nhËn nép <c=yel>To¸i Gi¸p<c> cho ta sao?", "huan", "no")
    end
end;

function huan()
    no()
    local UTask_bianliang = GetTaskByte(26, 1);
    if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
        for i = 1, 10 do
            DelNormalItem(3, UTask_bianliang, 0, 0)
        end ;
        jiangli6(1)

        local strh = "RÊt tèt, c¸m ¬n ngµi ®· hç trî, ®©y lµ thï lao xin nhËn lÊy. Ngµi cßn cã thÓ lµm <c=y>" .. Is6Times() .. "<c> lÇn."
        if (GetLevel() <= 25) and (HaveIBBuff(271) == 0) and (HaveIBBuff(272) == 0) and (HaveIBBuff(273) == 0) and (HaveIBBuff(274) == 0) then
            local rbuff = math.random(1, 4)
            AddIBBuff(270 + rbuff)

            local exp1 = GetLevel() * 200
            AddOwnExp(exp1)

            ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc " .. exp1 .. " ®iÓm kinh nghiÖm vµ Chóc phóc")
            Msg2Player("Thñ Khè tÆng b¹n mét phÇn quµ chóc phóc vµ" .. exp1 .. " ®iÓm kinh nghiÖm.")
            strh = strh .. "Ng­¬i cßn yÕu ®uèi qu¸! Ta tÆng ng­¬i <c=g> 1 mãn quµ chóc phóc vµ" .. exp1 .. " ®iÓm kinh nghiÖm<c>."
        elseif (GetLevel() <= 25) and ((HaveIBBuff(271) == 1) or (HaveIBBuff(272) == 1) or (HaveIBBuff(273) == 1) or (HaveIBBuff(274) == 1)) then
            strh = strh .. "Ng­¬i hoµn thµnh nhiÖm vô trong thêi gian ng¾n nh­ vËy, ch¾c lµ ®· sö dông sù trî gióp cña ta råi."
        end

        Earn(600)
        ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc 600 l­îng, Danh väng t¨ng lªn.")
        TaskNote(12, -1)
        AddCredit(1)
        SetTaskByte(26, 1, 0)
        MsgBox(strh .. "\nNgµi muèn <c=g>tiÕp tôc<c> nhËn nhiÖm vô sao? NhÊn X¸c nhËn ®Ó nhËn, Huû ®Ó trë l¹i", "yes_2", "renwu2")
        refreshNpcTaskState()
    end
end;

function liudaoT1()
    if (HaveNormalItem(3, 10, 0, 0) < 100) then
        Talk(1, "no", "Nguyªn liÖu ngµi mang tíi ch­a ®ñ! Nghe nãi chØ cÇn nhËn nhiÖm vô <c=g>KÕ Tôc<c>lµ cã thÓ nhanh chãng ®o¹t ®­îc vËt liÖu trªn ng­êi qu¸i vËt h¬n!")
        return 0
    end

    local nCount = Is6Times()
    if (nCount < 10) then
        Talk(1, "no", "Ta kh«ng cÇn nhiÒu vËt liÖu nh­ vËy, nÕu vÉn muèn h·y nép cho ta 10 c¸i ®i!")
        return 0
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng cã ®ñ 1 « trèng!")
        return 0
    end

    for i = 1, 100 do
        DelNormalItem(3, 10, 0, 0)
    end ;
    SetTaskByte(16, 3, GetTaskByte(16, 3) + 10)

    for i = 1, 10 do
        jiangli6(2)
    end

    local strh = "C¸m ¬n ngµi ®· hç trî, ®©y lµ thï lao xin nhËn lÊy. "
    if (GetLevel() <= 25) and (HaveIBBuff(271) == 0) and (HaveIBBuff(272) == 0) and (HaveIBBuff(273) == 0) and (HaveIBBuff(274) == 0) then
        local rbuff = math.random(1, 4)
        AddIBBuff(270 + rbuff)
        local exp1 = GetLevel() * 200
        AddOwnExp(exp1)

        ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc " .. exp1 .. " §iÓm kinh nghiÖm vµ Chóc phóc")
        Msg2Player("Thñ Khè tÆng b¹n mét phÇn quµ chóc phóc vµ " .. exp1 .. " §iÓm kinh nghiÖm.")
        strh = strh .. "Ng­¬i cßn yÕu ®uèi qu¸! Ta tÆng ng­¬i <c=g> 1 mãn quµ chóc phóc vµ " .. exp1 .. " ®iÓm kinh nghiÖm<c>."
    end

    Earn(6000)
    ScrollMessage("Danh väng t¨ng 10 ®iÓm, nhËn ®­îc 6000 b¹c.")
    TaskNote(12, -1)
    AddCredit(10)
    SetTaskByte(26, 1, 0)
    nCount = Is6Times()
    if (nCount <= 0) then
        MsgBox("Ngµi vÊt v¶ råi, h«m nay lµm ®Õn ®©y th«i, ngµy mai l¹i tíi." .. strh, "no")
    else
        MsgBox("." .. strh .. "\nNgµi cßn cã thÓ lµm <c=y>" .. Is6Times() .. "<c> lÇn, ngµi muèn <c=g>tiÕp tôc<c> nhËn nhiÖm vô sao?", "renwu2", "no")
    end
    refreshNpcTaskState()
end

function liudaoT2()
    if (HaveNormalItem(3, 11, 0, 0) < 100) then
        Talk(1, "no", "Nguyªn liÖu ngµi mang tíi ch­a ®ñ! Nghe nãi chØ cÇn nhËn nhiÖm vô <c=g>KÕ Tôc<c>lµ cã thÓ nhanh chãng ®o¹t ®­îc vËt liÖu trªn ng­êi qu¸i vËt h¬n!")
        return 0
    end

    local nCount = Is6Times()
    if (nCount < 10) then
        Talk(1, "no", "Ta kh«ng cÇn nhiÒu vËt liÖu nh­ vËy, nÕu vÉn muèn h·y nép cho ta 10 c¸i ®i!")
        return 0
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng cã ®ñ 1 « trèng!")
        return 0
    end

    for i = 1, 100 do
        DelNormalItem(3, 11, 0, 0)
    end ;
    SetTaskByte(16, 3, GetTaskByte(16, 3) + 10)

    for i = 1, 10 do
        jiangli6(2)
    end

    local strh = "C¸m ¬n ngµi ®· hç trî, ®©y lµ thï lao xin nhËn lÊy. "
    if (GetLevel() <= 25) and (HaveIBBuff(271) == 0) and (HaveIBBuff(272) == 0) and (HaveIBBuff(273) == 0) and (HaveIBBuff(274) == 0) then
        local rbuff = math.random(1, 4)
        AddIBBuff(270 + rbuff)
        local exp1 = GetLevel() * 200
        AddOwnExp(exp1)

        ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc " .. exp1 .. " ®iÓm kinh nghiÖm vµ Chóc phóc")
        Msg2Player("Thñ Khè tÆng b¹n mét phÇn quµ chóc phóc vµ" .. exp1 .. " ®iÓm kinh nghiÖm.")
        strh = strh .. "Ng­¬i cßn yÕu ®uèi qu¸! Ta tÆng ng­¬i <c=g> 1 mãn quµ chóc phóc vµ" .. exp1 .. " ®iÓm kinh nghiÖm<c>."
    end

    Earn(6000)
    ScrollMessage("Danh väng t¨ng 10 ®iÓm, nhËn ®­îc 6000 b¹c.")
    TaskNote(12, -1)
    AddCredit(10)
    SetTaskByte(26, 1, 0)
    nCount = Is6Times()
    if (nCount <= 0) then
        MsgBox("Ngµi vÊt v¶ råi, h«m nay lµm ®Õn ®©y th«i, ngµy mai l¹i tíi." .. strh, "no")
    else
        MsgBox("." .. strh .. "\nNgµi cßn cã thÓ lµm <c=y>" .. Is6Times() .. "<c> lÇn, ngµi muèn <c=g>tiÕp tôc<c> nhËn nhiÖm vô sao?", "renwu2", "no")
    end
    refreshNpcTaskState()
end

function liudao10()
    no()
    local UTask_bianliang = GetTaskByte(26, 1)
    local key = 0
    local PlayerLevel = GetLevel()
    local nCount = Is6Times()

    if (nCount <= 0) then
        Talk(1, "no", "VËt liÖu ta cÇn h«m nay ®· gom ®ñ, mêi ngµy mai l¹i tíi!")
        return 0
    end

    for i = 1, math.min(10, nCount) do
        if (UTask_bianliang == 0) then
            UTask_bianliang = math.random(10, 11)
            SetTaskByte(16, 3, GetTaskByte(16, 3) + 1)
        end

        if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, UTask_bianliang, 0, 0)
            end

            key = key + 1
            UTask_bianliang = 0

            jiangli6(1)
        else
            ScrollMessage("Ngµi ch­a <c=r>cã ®ñ vËt liÖu")
            Msg2Player("Ngµi ch­a <c>cã ®ñ vËt liÖu")
            break
        end
    end

    local strh = "C¸m ¬n ngµi ®· hç trî, ®©y lµ thï lao xin nhËn lÊy. "
    if (PlayerLevel <= 25) and (key > 0) and (HaveIBBuff(271) == 0) and (HaveIBBuff(272) == 0) and (HaveIBBuff(273) == 0) and (HaveIBBuff(274) == 0) then
        local rbuff = math.random(1, 4)
        AddIBBuff(270 + rbuff)

        local exp1 = PlayerLevel * 200
        AddOwnExp(exp1)

        ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc " .. exp1 .. " §iÓm kinh nghiÖm vµ Chóc phóc")
        Msg2Player("Thñ Khè tÆng b¹n mét phÇn quµ chóc phóc vµ " .. exp1 .. " §iÓm kinh nghiÖm.")
        strh = strh .. "Ng­¬i cßn yÕu ®uèi qu¸! Ta tÆng ng­¬i <c=g> 1 mãn quµ chóc phóc vµ " .. exp1 .. " ®iÓm kinh nghiÖm<c>."
    end

    if (key > 0) then
        Earn(600 * key)
        AddCredit(key)
        ScrollMessage("Lôc §¹o Lu©n Håi hoµn thµnh nhËn ®­îc <c=g>" .. key .. "<c> ®iÓm danh väng vµ <c=g>" .. (key * 600) .. "<c> b¹c")
    end

    if (key >= 10) then
        TaskNote(12, -1)
        SetTaskByte(26, 1, 0)

        nCount = Is6Times()
        if (nCount <= 0) then
            MsgBox("Ngµi vÊt v¶ råi, h«m nay lµm ®Õn ®©y th«i, ngµy mai l¹i tíi." .. strh, "no")
        else
            MsgBox("." .. strh .. "\nNgµi cßn cã thÓ lµm <c=y>" .. Is6Times() .. "<c> lÇn, ngµi muèn <c=g>tiÕp tôc<c> nhËn nhiÖm vô sao?", "renwu2", "no")
        end
    else
        SetTaskByte(26, 1, UTask_bianliang)
        local listname = { "§o¹n KiÕm", "To¸i Gi¸p" }
        TaskNote(12, 0, listname[UTask_bianliang - 9])
    end

    refreshNpcTaskState()
end

function GreenEquipment()
    Msg2Player("A, ®©y chÝnh lµ vËt phÈm ta cÇn! Ta ë ®©y cã mét trang bÞ cæ, xin tÆng cho ng­¬i!")
    local n = math.random(0, 2)
    local p = math.random(3, 5)
    if (n == 0) then
        n = 5
    elseif (n == 1) then
        n = 6
    elseif (n == 2) then
        n = 7
    end ;
    AddNormalItem2(0, n, p, 1, 1, 0)
    SetTask(810, GetTask(810) + 1)

    local l = GetName()
    if (GetLevel() < 30) then
        Msg2CurMapAnnounce("ThiÕu niªn anh hïng <c=green>" .. l .. "<c> gióp Thñ Khè Sïng Thµnh doanh t×m ®ñ vËt liÖu cÇn thiÕt, Thñ khè Sïng Thµnh tÆng 1 bé trang bÞ cho <c=g>" .. l .. "<c>.", 20)
    end ;
end

function yes_1()
    SetTask(23, 1)
    Talk(1, "no", 10226)
    Msg2Player("B¹n nhËn nhiÖm vô thñ khè ®i t×m 5 To¸i Gi¸p.")

    SetSubTask(9, 1, 1)

    TaskNote(9, 0)

    refreshNpcTaskState()


end;

function renwu3()
    UTask_10 = GetTask(20);
    if (UTask_10 == 1) then
        MsgBox(12563, "no")
        SetTask(20, 10)
        Msg2Player("B¸o Mai Vò, Kim Quú lÊy vËt phÈm cña m×nh vÒ!")
        TaskNote(7, 1)

        refreshNpcTaskState()

    end ;

    if (UTask_10 == 13) then
        AddOwnExp(50)
        AddEventItem(26)
        TaskNote(7, 5)
        SetTask(20, 14)
        TopMessage(12564)
        Msg2Player("LÊy ®­îc hép gÊm, t×m T« Hé phôc mÖnh!")
        Talk(1, "no", 12565)

        refreshNpcTaskState()


    end
end;

function no()
    CloseDialog()
end;

function ma()
    tasks1 = {
        { "§o¹n KiÕm", "dj"; show = 1 },
        { "To¸i Gi¸p", "sj"; show = 1 },
        { "B¨ng C¬", "bj"; show = 1 },
        { "Ngäc Cèt", "yg"; show = 1 },
        { "Quû DiÖn", "gm"; show = 1 },
        { "Ho¶ Vò", "hy"; show = 1 }
    }
    SayTask(10085, tasks1)
end;

function dj()
    MsgBox(10078, "ma")
end;

function sj()
    MsgBox(10079, "ma")
end;

function bj()
    MsgBox(10080, "ma")
end;

function yg()
    MsgBox(10081, "ma")
end;

function gm()
    MsgBox(10082, "ma")
end;

function hy()
    MsgBox(10083, "ma")
end;
function IsTGetCallDuty()

    Task_CD_lvl = {
        [1] = { 0, 60, 4 },
        [2] = { 61, 150, 5 },
        [3] = { 151, 1000, 6 },
    }
    local plvl = GetLevel() + GetNewBirthTimes() * 200
    local pTimes = GetTask(Task_CallDuty)

    for i = 1, 3 do
        if (plvl <= Task_CD_lvl[i][2]) then
            if (pTimes < Task_CD_lvl[i][3]) then
                return 1
            else
                return 0
            end
        end
    end
    return 0
end
