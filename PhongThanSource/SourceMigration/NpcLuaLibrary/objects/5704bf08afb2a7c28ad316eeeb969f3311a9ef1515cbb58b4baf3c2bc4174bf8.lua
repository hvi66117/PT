--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10
--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-09-1
Task_DeliverCarbon = 1045;
Task_DriveOutNum = 1046;
Task_HelpDoctor = 1099;
Task_cold = 1212;
--º®ÊÒÐ§Ó¦ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ£¬3Bit±íÊ¾ÈÎÎñ´ý½»£¬4Bit±íÊ¾½«Æä½»¸øÆäËüNPC½áÊøÈÎÎñfunction main(sel)

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

    --Çý³ýÒþ»¼(¼×Ê¿µÀÊ¿)
    startLevel = 21
    if (GetLevel() >= startLevel) and ((GetPlayerType() == 0) or (GetPlayerType() == 1)) then
        local taskProcess = GetTask(Task_DeliverCarbon)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 3) and (HaveEventItemCount(191) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) and (HaveEventItemCount(191) < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 3) and (HaveEventItemCount(191) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) and (HaveEventItemCount(191) < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) then
                state = 1
                subState = 1
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ñ©ÖÐËÍÌ¿(ÒìÈË)
    startLevel = 21
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTaskByte(Task_HelpDoctor, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 1
                subState = 0
            elseif (taskProcess == 5) and (HaveEventItemCount(191) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 5) and (HaveEventItemCount(191) < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 6) then
                state = 1
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 1
                subState = 1
            elseif (taskProcess == 5) and (HaveEventItemCount(191) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 5) and (HaveEventItemCount(191) < 5) then
                state = 2
                subState = 0
            elseif (taskProcess == 6) then
                state = 1
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --º®ÊÒÐ§Ó¦
    startLevel = 21
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 0) then
                state = 1
                subState = 0
            elseif ((GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 1)) and (HaveNormalItem(3, 217, 0, 0) >= 10 and HaveEventItemCount(193) >= 10) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 1) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 4) == 1) then
                state = 0
                subState = 0
            end
        else
            if (GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 0) then
                state = 1
                subState = 1
            elseif ((GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 1)) and (HaveNormalItem(3, 217, 0, 0) >= 10 and HaveEventItemCount(193) >= 10) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_cold, 4) ~= 1) and (GetTaskBit(Task_cold, 1) == 1) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_cold, 4) == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(314) == 15 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 15 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 1
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

    if (GetTask(304) == 15) then
        Talk(1, "no", 11441)
        SetTask(304, 100)
        TaskNote(31, 0)
    elseif (GetTask(314) == 15) then
        Talk(1, "no", 11550)
        SetTask(314, 100)
        TaskNote(33, 0)
        refreshNpcTaskState()
    else
        local tasks = {
            { "<c=yel>Gi¶i nguy<c>", "DeliverCarbon"; show = 0 },
            { "<c=yel>Lo¹i trõ hiÓm häa<c>", "DriveOut"; show = 0 },
            { "<c=yel>Hµn ThÊt hiÖu øng<c>", "cold"; show = 0 },
            { "D­îc phÈm", "yes"; show = 1 }
        }
        local nTaskStatus = GetTask(Task_DeliverCarbon)
        local L_HelpDoctor = GetTask(Task_HelpDoctor)
        local lc = GetTask(Task_cold)
        if (nTaskStatus == 1 or GetByte(L_HelpDoctor, 1) == 2) then
            tasks[1].show = 1
        end

        if (GetLevel() >= 21) and (GetBit(lc, 4) ~= 1) then
            tasks[3].show = 1
        elseif (GetBit(lc, 2) == 1) then
            TaskNote(74, -1)
        end

        if (GetByte(L_HelpDoctor, 1) == 4 or GetByte(L_HelpDoctor, 1) == 6) then
            tasks[2].show = 1
        end

        if ((nTaskStatus == 3 or GetByte(L_HelpDoctor, 1) == 5) and HaveEventItemCount(191) >= 5) then
            tasks[2].show = 1
        end

        if (nTaskStatus == 5) then
            tasks[2].show = 1
        end
        if (nTaskStatus == 2 or (nTaskStatus == 3 and HaveEventItemCount(191) >= 5) or nTaskStatus == 5) then
            tasks[2].show = 1
        end
        SayTask(10322, tasks)
    end ;
end;

function DeliverCarbon()
    local L_HelpDoctor = GetTask(Task_HelpDoctor)
    if (GetByte(L_HelpDoctor, 1) == 2) then
        SetTask(Task_HelpDoctor, SetByte(L_HelpDoctor, 1, 3))
    end

    AddOwnExp(1000)
    TopMessage(11517)
    Msg2Player("nhËn ®­îc 1000 ®iÓm kinh nghiÖm!")

    if (GetTask(Task_DeliverCarbon) == 1) then
        SetTask(Task_DeliverCarbon, 2)
        --AS GaoJingwei 090730
        SetSubTask(901, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(901, -1)
        Talk(1, "DriveOutTask", 11551)
    end ;

    if (GetByte(GetTask(Task_HelpDoctor), 1) == 3) then
        SetTaskByte(Task_HelpDoctor, 1, 4)--log¸Ä°æ
        --AS GaoJingwei 090730
        SetSubTask(901, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(901, -1)
        Talk(1, "DriveOutTask", 11551)
    end ;
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function DriveOutTask()
    task_DriveOut = {
        { "<c=yel>Lo¹i trõ hiÓm häa<c>", "DriveOut"; show = 1 },
    }
    SayTask(11552, task_DriveOut)
end

function DriveOut()
    local nTaskStatus = GetTask(Task_DeliverCarbon)
    local L_HelpDoctor = GetTask(Task_HelpDoctor)
    if (nTaskStatus == 2 or GetByte(L_HelpDoctor, 1) == 4) then
        MsgBox(11553, "AcceptDriveOut", "no")
    end

    if ((nTaskStatus == 3 or GetByte(L_HelpDoctor, 1) == 5) and HaveEventItemCount(191) >= 5) then
        for i = 1, 5 do
            DelEventItem(191)
        end
        AddOwnExp(6000)
        TopMessage(11554)
        Msg2Player("NhËn ®­îc 6000 kinh nghiÖm.")

        if (nTaskStatus == 3) then
            SetTask(Task_DriveOutNum, 0)
            SetTask(Task_DeliverCarbon, 5)
        end

        if (GetByte(L_HelpDoctor, 1) == 5) then
            SetTask(Task_HelpDoctor, 0)
            SetTask(Task_HelpDoctor, SetByte(GetTask(Task_HelpDoctor), 1, 6))
        end
        TaskNote(900, 3)
        Talk(1, "ThreeMonDoc", 11555)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end

    if (nTaskStatus == 5 or GetByte(GetTask(Task_HelpDoctor), 1) == 6) then
        AcceptThreeMonDoc()
    end
end

function AcceptDriveOut()
    local nTaskStatus = GetTask(Task_DeliverCarbon)
    if (nTaskStatus == 2) then
        SetTask(Task_DeliverCarbon, 3)
        SetTask(Task_DriveOutNum, 0)
        SetTask(Task_DriveOutNum, SetByte(GetTask(Task_DriveOutNum), 1, 7))
        SetTask(Task_DriveOutNum, SetByte(GetTask(Task_DriveOutNum), 2, 13))
        --AS GaoJingwei 090730
        SetSubTask(900, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(900, 0)
    end ;

    local L_HelpDoctor = GetTask(Task_HelpDoctor)
    if (GetByte(L_HelpDoctor, 1) == 4) then
        SetTaskByte(Task_HelpDoctor, 1, 5)--log¸Ä°æ
        SetTask(Task_HelpDoctor, SetByte(GetTask(Task_HelpDoctor), 2, 7))
        SetTask(Task_HelpDoctor, SetByte(GetTask(Task_HelpDoctor), 3, 13))
        --AS GaoJingwei 090730
        SetSubTask(900, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(900, 0)
    end ;
    Talk(1, "no", 11556)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function ThreeMonDoc()
    tasks2 = {
        { "<c=yel>Lo¹i trõ hiÓm häa<c>", "AcceptThreeMonDoc"; show = 1 }
    }
    SayTask(11557, tasks2)
end
function AcceptThreeMonDoc()
    MsgBox(11558, "Yes_ThrMon", "no")
end
function Yes_ThrMon()
    local nTaskStatus = GetTask(Task_DeliverCarbon)
    local L_HelpDoctor = GetTask(Task_HelpDoctor)
    if (nTaskStatus == 5) then
        SetTask(Task_DeliverCarbon, 6)
        TaskNote(900, 4)
    end

    if (GetByte(L_HelpDoctor, 1) == 6) then
        SetTask(Task_HelpDoctor, SetByte(GetTask(Task_HelpDoctor), 1, 7))
        TaskNote(900, 4)
    end
    Talk(1, "no", 11559)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;

function cold()
    local lc = GetTask(Task_cold)
    if (GetBit(lc, 1) == 0) then
        MsgBox(14593, "AcceptCold", "no")--´íÎó,msgbox¸ñÊ½²»¶Ô
        return 0
    else
        if (HaveNormalItem(3, 217, 0, 0) >= 10 and HaveEventItemCount(193) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, 217, 0, 0)
                DelEventItem(193)
            end
            if (GetPlayerType() == 1) then
                Talk(2, "no", 14439, "D­îc liÖu ®· cã ®Çy ®ñ, gióp ta mang ®Õn cho Tiªu Th¨ng nhÐ!")
                TaskNote(74, 2)
            elseif (GetPlayerType() == 0) then
                Talk(2, "no", 14439, "Thuèc ®· chÕ xong! Gióp ta mang ®Õn cho TrÇn Quý Trinh nhÐ!")
                TaskNote(74, 1)
            elseif (GetPlayerType() == 2) then
                Talk(2, "no", 14439, "Thuèc ®· chÕ xong råi! Xin gióp ta giao ®Õn cho H×nh Thiªn nhÐ!")
                TaskNote(74, 3)
            end
            AddNormalItem(3, 224, 0, 0, 0, 0)
            SetTaskBit(Task_cold, 4, 1)--log¸Ä°æ

            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        else
            local scl = 10 - HaveNormalItem(3, 217, 0, 0)
            local hzl = 10 - HaveEventItemCount(193)

            if (scl < 0) then
                scl = 0
            end
            if (hzl < 0) then
                hzl = 0
            end

            Talk(1, "no", "Ng­¬i cßn thiÕu" .. scl .. " l¸ S¬n Xuyªn liÔu vµ" .. hzl .. " Lý" .. "T×m ®ñ råi ®Õn t×m ta nhÐ!")
            return 0
        end
    end
end;

function AcceptCold()
    Talk(1, "no", 14440)
    AddNormalItem(5, 0, 0, 1, 0, 0)
    SetTaskBit(Task_cold, 1, 1)--log¸Ä°æ
    --AS GaoJingwei 090730
    SetSubTask(74, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(74, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;
