--description: ĞÂÊÖÖ¸µ¼-³ç³Ç°ïÖúNPC
--author: yichuan
--date: 2004/5/14
Task_NewPlayer = 1069;

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
    local startLevel = 1

    --³õ³öÃ©Â®
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
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
    --	MsgBox("¡¡¡¡»¶Ó­ÄãÀ´µ½·âÉñ°ñÊÀ½ç£¬ÏÖÔÚµÄÄã¿ÉÒÔÁ¢¿ÌÈ¥ÕÒ<c=yel>Ò½Éú</c>½ÓÊÜ<c=g>Ê¹ÃüµÄÕÙ»½</c>£¬ÕÒÒ½ÉúÇë°´<c=r>Tab</c>¿´ÓÒÉÏ½ÇµØÍ¼¡£Ñ°Çó¸ü¶à°ïÖúÇë<color=green>°´F1²ì¿´Ïà¹ØĞÅÏ¢<color>¡£","no")
    --	MsgBox("<c=g>»¶Ó­ÄãÀ´µ½·âÉñ°ñÊÀ½ç!<c>\n\n<c=yel>³õ³öÃ©Â®<c>:×÷ÎªÓñĞé¹¬µÄĞÂÊÖÄã¿ÉÒª¶àÑ§Ï°ºÃºÃÀúÁ·Ò»·¬°¡£¬ÏÖÔÚÄã¿ÉÒÔÈ¥ÕÒ<c=r>´Èº½µÀÈË<c>,È¥¿´¿´ËûÓĞÊ²Ã´ÊÂÇé¡£","AcceptTask","no")
    local tasks = {
        { "NhiÖmVô§ÇuTiªn", "renwu"; show = 0 },
        { "Mao L­", "Chuchu"; show = 0 }
    }

    if (GetPlayerType() == 1) then
        tasks[1].show = 1
        if (GetTask(Task_NewPlayer) == 0) then
            tasks[2].show = 1
        end
    end
    SayTask(12150, tasks)
end;
function renwu()
    local nTaskStatus = GetTask(10);
    if (nTaskStatus > 4 and nTaskStatus < 16) then
        SetTask(10, 4)
        TaskNote(1, 3)
    elseif (nTaskStatus == 4) then
        TaskNote(1, 3)
    elseif (nTaskStatus == 3) then
        TaskNote(1, 2)
    elseif (nTaskStatus == 2) then
        TaskNote(1, 1)
    elseif (nTaskStatus == 16) then
        TaskNote(1, -1)
    end
    nTaskStatus = GetTask(11)
    if (nTaskStatus == 2) then
        TaskNote(2, 2)
    elseif (nTaskStatus == 3) then
        TaskNote(2, 1)
    end

    nTaskStatus = GetTask(14)
    if (nTaskStatus == 2) then
        TaskNote(4, -1)
    end
    CloseDialog()

end
function Chuchu()
    MsgBox(11693, "AcceptTask", "no")
end

function AcceptTask()
    SetTask(Task_NewPlayer, 1)
    --AS GaoJingwei 090730
    SetSubTask(897, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(897, 0)
    --	CloseDialog()
    Talk(1, "no", 11694)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
function no()
    CloseDialog()
end;
