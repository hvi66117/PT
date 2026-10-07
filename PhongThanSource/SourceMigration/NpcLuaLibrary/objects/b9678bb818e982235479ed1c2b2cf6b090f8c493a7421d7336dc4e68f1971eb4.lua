--description: ²Ö¿â¹ÜÀí³¥
--author: yichuan
--date: 2004/6/28
--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
Task_Destroy = 1038;
Task_thatch = 1019;
Task_CallDuty = 984--´ÎÊý
--973Ê±¼ä

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --³õ³öÃ©Â®
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetTask(Task_thatch) == 2) then
                state = 3
                subState = 0
            elseif (GetTask(Task_thatch) == 3) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
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

    --±©ÓêÖ®ºó
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

    --Ê¹ÓÃ²Ö¿â
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

    --ÁùµÀÂÖ»Ø
    startLevel = 12
    if (GetLevel() >= startLevel) then
        local UTask_bianliang = GetTask(26)
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (UTask_bianliang == 0) and (GetLevel() >= 12) then
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
            if (UTask_bianliang == 0) and (GetLevel() >= 12) then
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

    --¿ªÆôÓÊÏä
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

    --Ê¹ÃüÕÙ»½ add by luoyixuan 091012
    startLevel = 1
    if ((GetLevel() >= startLevel) and (GetPlayerType() == 0)) then
        local today = floor(LocalSystemTime() / 86400)
        local taskProcess = GetByte(GetTask(993), 1)
        local L_nums = GetByte(GetTask(993), 2) * 10
        local nums = GetTask(994)
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
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
            --À¶É«
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        { "<c=yel>Mao L­<c>", "NewPlayer"; show = 0 },
        { "<c=yel>KÕ Tôc<c>", "renwu4_before"; show = 0 },
        { "<c=yel>Hép gÊm<c>", "renwu3"; show = 0 },
        { "<c=yel>Thñ khè<c>", "renwu1"; show = 0 },
        { "<c=yel>Thu thËp<c>", "renwu2"; show = 0 },
        { "<c=g>Hép th­<c>", "POpenMail"; show = 1 },
        { "Long Phông phï", "longfeng"; show = 0 }
    }

    if (GetTask(Task_thatch) == 2) then
        tasks[1].show = 1
    end
    --		if( GetTask(Task_Destroy) ==11 and GetLevel() >=12)then
    --			tasks[6].show = 1
    --		end
    if (GetPlayerType() == 0) then
        local today = floor(LocalSystemTime() / 86400)
        if (GetTask(973) ~= today) and (GetTask(993) == 0) then
            SetTask(Task_CallDuty, 0)
            SetTask(973, today)
            Msg2Player("Ngµy míi ®· b¾t ®Çu. B¹n cã thÓ tiÕp tôc nhËn nhiÖm vô KÕ Tôc")
        end
        local bianliang = GetByte(GetTask(993), 1)
        if (IsTGetCallDuty() == 1) or (bianliang ~= 0) then
            tasks[2].show = 1
        end
    end
    UTask_xiangzi = GetTask(23);
    UTask_bianliang = GetTask(26); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
    UTask_10 = GetTask(20);

    if (UTask_xiangzi == 1) and (HaveNormalItem(3, 11, 0, 0) >= 5) then
        tasks[4].show = 1;
    end ;
    if (UTask_xiangzi == 0 and GetLevel() >= 8) then
        tasks[4].show = 1;
    end ;
    if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
        tasks[5].show = 1;
    end ;
    if (UTask_bianliang == 0) and (GetLevel() >= 12) then
        --½Ó?ÎñÊ±µÄ¶Ô»°
        tasks[5].show = 1;
    end ;
    if (UTask_10 == 1) then
        tasks[3].show = 1;
    end ;
    if (UTask_10 == 13) then
        tasks[3].show = 1;
    end ;
    SayTask(10223, tasks)
end;
npcname = {
    [1] = "KiÕm Nh©n",
    --[2]="TuyÕt qu¸i",
    --[3]="Háa DiÖn",
    [4] = "X¹ Nh©n",
    --[5]="B¨ng Lang",
    --[7]="Cuång §iªu"

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
        [1] = "KiÕm Nh©n",
        --[2]="TuyÕt qu¸i",
        --[3]="Háa DiÖn",
        [4] = "X¹ Nh©n",
        --[5]="B¨ng Lang",
        --[7]="Cuång §iªu"

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
    --AS GaoJingwei 090730
    SetSubTask(909, -1, 1)
    --AE GaoJingwei 090730
    TopMessage(12133)
    Msg2Player("nhËn ®­îc 50 ®iÓm kinh nghiÖm.")
    Talk(1, "no", 12556)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function renwu11()
    AddOwnExp(100)
    SetTask(Task_Destroy, 12)
    TopMessage(12130)
    Msg2Player("nhËn ®­îc 100 ®iÓm kinh nghiÖm")
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
        { "KiÕm Nh©n", "yes_g1"; show = 1 },
        { "X¹ Nh©n", "yes_g2"; show = 1 }
    }

    if (bianliang == 0) then
        if (GetTask(Task_CallDuty) == 0) and (GetLevel() < 6) then
            --½ÓÈÎÎñÊ±µÄ¶Ô»°
            MsgBox(12558, "yes_5", "no")
        elseif (GetTask(Task_CallDuty) == 0) and (GetLevel() >= 6) then
            --½ÓÈÎÎñÊ±µÄ¶Ô»°
            SayTask(12559, tasks1)
        elseif (GetLevel() < 6) then
            MsgBox("§Ó khiÕn ng­¬i trë thµnh anh hïng cña ThÇn N«ng, mçi ngµy ta ph¶i thóc giôc ng­¬i, ng­¬i x¸c ®Þnh muèn nhËn nhiÖm vô thø <c=g>" .. (GetTask(Task_CallDuty) + 1) .. "</c> cña h«m nay chø?", "yes_5", "no")
        elseif (IsTGetCallDuty() == 1) and (GetLevel() >= 6) then
            SayTask("§Ó khiÕn ng­¬i trë thµnh anh hïng cña ThÇn N«ng, mçi ngµy ta ph¶i thóc giôc ng­¬i, ng­¬i x¸c ®Þnh muèn nhËn nhiÖm vô thø <c=g>" .. (GetTask(Task_CallDuty) + 1) .. "</c> vßng sø m¹ng? NÕu ng­¬i chän tiªu diÖt KiÕm Nh©n sÏ cã c¬ héi nhËn §o¶n kiÕm, tiªu diÖt X¹ Nh©n cã thÓ nhËn To¸i gi¸p!", tasks1)
        else
            MsgBox(12202, "no")
        end
    else
        if (nums >= L_nums) and (bianliang >= 1) then
            SetTask(993, 0)
            Msg2Player("B¹n nhËn ®­îc 100 ®iÓm kinh nghiÖm!")
            TaskNote(51, -1)
            AddOwnExp(100)

            local today = floor(LocalSystemTime() / 86400)
            if (GetTask(973) ~= today) then
                SetTask(Task_CallDuty, 0)
                SetTask(973, today)
                --luoyixuan
                refreshNpcTaskState()
                --luoyixuan
                Msg2Player("Ngµy míi ®· b¾t ®Çu. B¹n cã thÓ tiÕp tôc nhËn nhiÖm vô KÕ Tôc")
            end
            if (GetLevel() <= 19) then
                Talk(1, "pre_renwu4", 12203)
            else
                if (IsTGetCallDuty() == 1) then
                    Talk(1, "pre_renwu4", 12204)
                else
                    Talk(2, "no", 12204, "H«m nay ng­¬i ®· rÊt mÖt råi! Xin h·y vÒ nghØ ng¬i d­ìng thÇn. Mai tiÕp tôc quay l¹i nhÐ!")    --by SongLei 08.7.14
                end
            end
        elseif (bianliang >= 1) and (nums < L_nums) then
            Talk(1, "no", "Ng­¬i cßn thiÕu <c=g>" .. (L_nums - nums) .. "." .. npcname[bianliang] .. "<c> th× sÏ th«ng qua lÇn kh¶o nghiÖm nµy! Cè lªn! (Chóng th­êng xuÊt hiÖn t¹i Sïng Thµnh, B¾c H¶i, YÕn S¬n)")
        end ;
        --add by luoyixuan
        refreshNpcTaskState()
        --end
    end ;
    --luoyixuan
    refreshNpcTaskState()
    --luoyixuan
end;

function yes_g1()
    SetTaskWord(993, 1, 1)--log¸Ä°æ
    yes_5()
end

function yes_g2()
    SetTaskWord(993, 1, 4)--log¸Ä°æ
    yes_5()
end

function yes_5()
    SetTask(Task_CallDuty, GetTask(Task_CallDuty) + 1)
    --luoyixuan
    refreshNpcTaskState()
    --luoyixuan
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
        SetTaskWord(993, 1, 1)--log¸Ä°æ
        AddNormalItem(1, 0, 1, 1, 0, 0)
        TopMessage(12205)
        Msg2Player("TÆng ng­¬i 1 TiÓu Hång §¬n trÞ th­¬ng!")
        Talk(1, "no", 12560)
    elseif (l1 >= 6) and (l1 < 11) then
        l = 2
        Talk(1, "no", "Thñ khè: Sø mÖnh cña ng­¬i lÇn nµy lµ tiªu diÖt <c=g>20 " .. npcname[bianliang] .. "</c>. Chóng th­êng xuÊt hiÖn ë <c=yel>Sïng Thµnh, B¾c H¶i, YÕn S¬n</c>. NÕu bÞ träng th­¬ng h·y lËp tøc quay l¹i t×m ta! NhÊn <c=yel>F11</c> ®Ó xem tiÕn tr×nh nhiÖm vô!")
    elseif (l1 >= 11) and (mod(l1, 10) == 0) and (l1 <= 50) then
        l = floor(GetLevel() / 10) + 1
    elseif (l1 >= 11) and (l1 <= 50) then
        l = floor(GetLevel() / 10) + 2
    elseif (l1 >= 51) then
        l = 7
    end
    --luoyixuan
    refreshNpcTaskState()
    --luoyixuan
    local task_L_nums = { [1] = 1, [2] = 2, [3] = 3, [4] = 6, [5] = 10, [6] = 20, [7] = 30 }--¸öÊýÎªÆä10±¶
    w = npcname[bianliang]
    local wlink = npclink[bianliang]
    SetTaskByte(993, 2, task_L_nums[l])--log¸Ä°æ
    TaskNote(51, 0, wlink, (task_L_nums[l] * 10))
    Msg2Player("Sø mÖnh lÇn nµy lµ tiªu diÖt" .. (task_L_nums[l] * 10) .. "." .. w)
    if (l > 2) then
        Talk(1, "no", "Thñ khè: Sø mÖnh cña ng­¬i lÇn nµy lµ tiªu diÖt <c=g>" .. (task_L_nums[l] * 10) .. "." .. w .. "</c>! Hy väng ng­¬i sÏ thuËn lîi!")
    end
end;
function NewWeapon()
    UTask_11 = GetTask(21);
    if (UTask_11 == 2) then
        AddOwnExp(50)
        Talk(1, "no", 12561)
        Msg2Player("nhËn nhiÖm vô KÕ Tôc sÏ cã ®­îc §o¶n KiÕm nhanh h¬n, thu thËp ®ñ 5 §o¶n KiÕm cho Thî ®ång!")
        TaskNote(8, 2)
        SetTask(21, 3)
    end
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
        { "Thu thËp", "liujinghua"; show = 1 }
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
        --AS GaoJingwei 090730
        SetSubTask(9, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(3, -1)
        TaskNote(9, -1)
        TaskNote(15, -1)
        SetTask(23, 2)
        SetTask(33, 2)
        SetTask(13, 2)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_xiangzi == 0) then
        MsgBox(10224, "yes_1", "no")
    end ;
end;

function renwu2()
    local UTask_bianliang = GetTask(26); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
    local w = ""
    if (UTask_bianliang == 10) then
        w = "§o¶n KiÕm"
    elseif (UTask_bianliang == 11) then
        w = "M¶nh Gi¸p"
    end ;
    if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
        MsgBox("VÒ råi µ? Giao <c=yel>" .. w .. "<c> cho ta chø?", "huan", "no")
    end ;

    if (UTask_bianliang == 0) and (GetLevel() >= 12) then
        --½Ó?ÎñÊ±µÄ¶Ô»°
        Talk(1, "yes_2", 10225)
    end ;
end;

function yes_2()
    local i = random(1, 2);
    local w = ""
    if (i == 1) then
        w = "§o¶n KiÕm"
        MsgBox("Nguyªn liÖu ta cÇn lÇn nµy lµ <c=r>" .. w .. "<c> 10 c¸i, gióp ta thu thËp chø? NÕu nhËn nhiÖm vô <c=g>Chiªu hån<c> cã thÓ thu thËp nguyªn liÖu nhanh h¬n.", "qd1", "no")

    else
        w = "M¶nh Gi¸p"
        MsgBox("Nguyªn liÖu ta cÇn lÇn nµy lµ <c=r>" .. w .. "<c> 10 c¸i, gióp ta thu thËp chø? NÕu nhËn nhiÖm vô <c=g>Chiªu hån<c> cã thÓ thu thËp nguyªn liÖu nhanh h¬n.", "qd2", "no")

    end ;
end;

function qd1()
    SetTask(26, 10)
    ScrollMessage("NhËn nhiÖm vô thñ khè Sïng Thµnh ®i t×m 10 §o¶n kiÕm.")
    TaskNote(12, 0, "§o¶n KiÕm")
    CloseDialog()
    refreshNpcTaskState()

    if (HaveNormalItem(3, 10, 0, 0) >= 10) then
        renwu2()
    end
end;

function qd2()
    SetTask(26, 11)
    ScrollMessage("NhËn nhiÖm vô thñ khè Sïng Thµnh ®i t×m 10 M¶nh Gi¸p.")
    TaskNote(12, 0, "M¶nh Gi¸p")
    CloseDialog()
    refreshNpcTaskState()

    if (HaveNormalItem(3, 11, 0, 0) >= 10) then
        renwu2()
    end
end;

function huan()
    --Íê³É?Îñ£¬¸øÓè½±Àø¡£
    local UTask_bianliang = GetTask(26); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
    if (HaveNormalItem(3, UTask_bianliang, 0, 0) >= 10) then
        local k = random(1, 100000)
        local green20 = GetTask(810)--°O¿ý20¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
        local PlayerLevel = GetLevel()
        local strh = "Tèt qu¸! §©y lµ chót quµ män, xin nhËn lÊy!"
        if (PlayerLevel > 50) then
            PlayerLevel = 50
        end
        if (k <= 8000) then
            --Talk(1,"no",10077)
            strh = strh .. "Ng­¬i ®· gióp ta rÊt nhiÒu! Xin h·y gi÷ cµnh LiÔu Méc nµy, vÒ sau sÏ dïng ®Õn!"
            AddEventItem(39)
        elseif (k > 10000) and (k <= 20000) and (PlayerLevel <= 25) and (green20 == 0) then
            GreenEquipment()
        elseif (k > 20000) and (k <= 21000) and (PlayerLevel <= 25) and (green20 >= 1) and (green20 <= 2) then
            GreenEquipment()
        elseif (k > 21000) and (k <= 21500) and (PlayerLevel <= 25) and (green20 >= 3) then
            GreenEquipment()
        elseif (k > 21500) and (k < 21900 - PlayerLevel * PlayerLevel * 7 / 50) and (PlayerLevel > 25) then
            GreenEquipment()
            --		elseif (k>30000)  and(k<=40000) then
            --			strh = strh.."ÄãÒÑ¾­°ïÁËÎÒÒ»Ð©Ã¦ÁË£¬ÕâÀïÓÐ¸ù²»ÓÃµÄÁøÄ¾£¬Äã¾ÍÄÃÈ¥°É£¬Ò²ÐíÒÔºóÄÜÅÉÉÏÊ²Ã´ÓÃ³¡¡£"
            --			AddEventItem(39)--ÁøÄ¾ÔÙ¼Ó10%
            --else
            --Talk(1,"no",10086)
        end
        for i = 1, 10 do
            DelNormalItem(3, UTask_bianliang, 0, 0)
        end ;

        if (GetLevel() <= 25) and (HaveIBBuff(271) == 0) and (HaveIBBuff(272) == 0) and (HaveIBBuff(273) == 0) and (HaveIBBuff(274) == 0) then
            local rbuff = random(1, 4)
            AddIBBuff(270 + rbuff)

            local exp1 = GetLevel() * 200
            AddOwnExp(exp1)

            TopMessage("Hoµn thµnh Thu thËp: nhËn ®­îc" .. exp1 .. "§iÓm kinh nghiÖm vµ Chóc phóc")
            Msg2Player("Thñ Khè tÆng b¹n mét phÇn quµ chóc phóc vµ" .. exp1 .. "§iÓm kinh nghiÖm.")
            strh = strh .. "Ng­¬i cßn yÕu ®uèi qu¸! Ta tÆng ng­¬i <c=g> 1 mãn quµ chóc phóc vµ" .. exp1 .. " ®iÓm kinh nghiÖm<c>."
        elseif (GetLevel() <= 25) and ((HaveIBBuff(271) == 1) or (HaveIBBuff(272) == 1) or (HaveIBBuff(273) == 1) or (HaveIBBuff(274) == 1)) then
            strh = strh .. "Ng­¬i hoµn thµnh nhiÖm vô trong thêi gian ng¾n nh­ vËy, ch¾c lµ ®· sö dông sù trî gióp cña ta råi."
        end

        Earn(600)
        ScrollMessage("Hoµn thµnh Thu thËp: nhËn ®­îc 600 l­îng, Danh väng t¨ng lªn.")
        TaskNote(12, -1)
        AddCredit(1)
        SetTask(26, 0)
        MsgBox(strh .. "B¹n muèn <c=g>tiÕp tôc<c> nhËn nhiÖm vô kh«ng?", "yes_2", "no")
        refreshNpcTaskState()
    end
end;

function GreenEquipment()
    Talk(1, "no", 10007)
    local n = random(0, 2)--?¶¨»ñµÃ×°±¸µÄ¾ß·¥¯C±ð
    local p = random(3, 5)
    if (n == 0) then
        --?¶¨p£¬¼´×°±¸µÄÏêÏ¸¯C±ð
        n = 5
    elseif (n == 1) then
        n = 6
    elseif (n == 2) then
        n = 7
    end ;
    AddNormalItem2(0, n, p, 1, 1, 0)--µÀ¾ßÖÖ¯C0£¬¾ß·¥¯C±ðn£¬ÏêÏ¸¯C±ðp£¬µÈ¼¶1
    SetTask(810, GetTask(810) + 1)
    refreshNpcTaskState()
    l = GetName()
    if (GetLevel() < 30) then
        AddGlobalCountNews("<c=green>" .. l .. "<c>T×m vËt liÖu, Thñ khè Sïng Thµnh tÆng 1 bé trang bÞ cho <c=g>" .. l .. "<c>.", 20)
    end ;
end

function yes_1()
    SetTask(23, 1)
    Talk(1, "no", 10226)
    Msg2Player("B¹n nhËn nhiÖm vô thñ khè ®i t×m 5 M¶nh Gi¸p.")
    --AS GaoJingwei 090730
    SetSubTask(9, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(9, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

end;

function renwu3()
    UTask_10 = GetTask(20);
    if (UTask_10 == 1) then
        MsgBox(12563, "no")
        SetTask(20, 10)
        Msg2Player("B¸o Mai Vò, Kim Quú lÊy vËt phÈm cña m×nh vÒ!")
        TaskNote(7, 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
    --		if(UTask_10==13)then
    --						AddOwnExp(300)
    --						TaskNote(7,5)
    --						SetTask(20,18)
    --						Msg2Player("È¥Âò¼ÀÑªÕ¶¡£")
    --						TopMessage("»ñµÃ300¾­Ñé")
    --						Talk(1,"no","²Ö¿â¹ÜÀíÔ±£ºËûÃÇÈýÎ»µÄ¶«Î÷¶¼°á³öÀ´ÁËÌ«ºÃÁË£¬²»¹ýÎÒÌýËµ<c=g>½ÌÊ¦<c>ÄÇÓÐÒ»±¾½Ð<c=g>¡°¼ÀÑªÕ¶¡±<c>Îä¹¦ÃØ¼®Ïë½èÀ´¿´¿´£¬ÄãÈ¥°ïÎÒÂòÀ´°É£¿")
    --						AddEventItem(26)
    --
    --		end;
    if (UTask_10 == 13) then
        AddOwnExp(50)
        AddEventItem(26)
        TaskNote(7, 5)
        SetTask(20, 14)
        TopMessage(12564)
        Msg2Player("LÊy ®­îc hép gÊm, t×m T« Hé phôc mÖnh!")
        Talk(1, "no", 12565)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end
end;

function no()
    CloseDialog()
end;

function ma()
    tasks1 = {
        { "§o¶n KiÕm", "dj"; show = 1 },
        { "M¶nh Gi¸p", "sj"; show = 1 },
        { "B¨ng c¬", "bj"; show = 1 },
        { "Ngäc cèt", "yg"; show = 1 },
        { "MÆt Quû", "gm"; show = 1 },
        { "Háa vò", "hy"; show = 1 }
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
    ---Ã¿¸öµÈ¼¶½ÓÊ¹ÃüÕÙ»½ÏÞÖÆÌõ¼þ
    --1-15¼¶ÎªÃ¿Ìì¿É½ÓÎÞÏÞ´Î¸ÃÈÎÎñ£»16-60¼¶ÎªÃ¿Ìì×î¶à¿É½Ó5´Î¸ÃÈÎÎñ£»61-80¼¶ÎªÃ¿Ìì×î¶à¿É½Ó4´ÎÈÎÎñ£»81-100ÎªÃ¿Ìì×î¶à¿É½Ó3´ÎÈÎÎñ£¬101¼¶ÒÔÉÏÎªÃ¿Ìì×î¶à¿É½Ó2´ÎÈÎÎñ
    Task_CD_lvl = {
        [0] = { 1, 19, 10000 },
        [1] = { 20, 60, 5 },
        [2] = { 61, 80, 4 },
        [3] = { 81, 100, 3 },
        [4] = { 101, 300, 2 },
    }
    local plvl = GetLevel()
    local pTimes = GetTask(Task_CallDuty)
    if (plvl <= Task_CD_lvl[0][2]) then
        return 1
    end

    for i = 1, 4 do
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
