--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓð£¬3µÃµ½ÐÅ£¬4´òÃºÓÍ£¬5ÉÕÍêËþ£¬6Íê³É£©
--2byte ÓÀ³ýºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²ÝÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©

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
    local startLevel = 14

    --ÓÀ³ýºó»¼
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
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
            if (GetTask(314) == 6 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 6 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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
    if (GetTask(304) == 6) then
        Talk(1, "no", 11441)
        SetTask(304, 100)
        TaskNote(31, 0)
    elseif (GetTask(314) == 6) then
        Talk(1, "no", 11561)
        SetTask(314, 100)
        TaskNote(33, 0)
        refreshNpcTaskState()
    elseif (GetPlayerType() == 0) and (GetTaskByte(Task_newer13, 2) == 3) then
        tasks = {
            { "<c=yel>VÜnh Trõ HËu Ho¹n<c>", "renwu18"; show = 1 },
            { "D­îc phÈm", "yes"; show = 1 },
        }
        SayTask("Ng­¬i mÆt mµy nh¨n nhã d­êng nh­ cã viÖc quan träng, kh«ng biÕt l·o phu cã gióp ®­îc g× kh«ng?", tasks)
    else
        MsgBox(10322, "yes", "no")
    end ;
end;

function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;

function renwu18()
    Talk(2, "no", GetName() .. " Kh«ng giÊu g× «ng, t¹i h¹ phông lÖnh Sïng HÇu Hæ t­íng qu©n ®Õn b¾t néi gi¸n, muèn hiÓu th¨m vÒ tung tÝch cña nã.", "õm, l·o qua tõng gÆp 1 <c=r>Hoµn CÈu ®¸ng nghi<c> véi vµng ch¹y vÒ h­íng §ång Quan, ch¾c lµ do tªn néi gi¸n hãa th©n. Anh hïng h·y mau ®Õn ®ã, ®õng ®Ó nã ch¹y tho¸t.")
    SetTaskByte(Task_newer13, 2, 4)
    TaskNote(210, 3)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
