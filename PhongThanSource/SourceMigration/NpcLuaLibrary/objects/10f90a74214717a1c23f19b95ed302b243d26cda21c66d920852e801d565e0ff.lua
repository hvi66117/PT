--description:¾åÁôËï-Ã÷Öé°µÍ¶?Îñ
--author: chensong
--date: 2004/7/13
--edit:yichuan

-- AS yangshuang at 091026
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

    --Ã÷Öé°µÍ¶
    startLevel = 43
    if (GetLevel() >= startLevel) then
        local UTask_cg_1 = GetTask(41)
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if ((UTask_cg_1 == 3) and (HaveEventItem(33) >= 1)) then
                state = 3
                subState = 0
            elseif ((UTask_cg_1 == 27) and (HaveEventItem(33) >= 1) and (HaveEventItem(34) >= 1) and (HaveEventItem(35) >= 1) and (HaveEventItem(36) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 3) and (HaveNormalItem(3, 6, 0, 0) >= 10)) then
                state = 3
                subState = 0
            elseif ((UTask_cg_1 >= 20) and (UTask_cg_1 <= 27)) then
                state = 2
                subState = 0
            end

        else
            if ((UTask_cg_1 == 3) and (HaveEventItem(33) >= 1)) then
                state = 3
                subState = 1
            elseif ((UTask_cg_1 == 27) and (HaveEventItem(33) >= 1) and (HaveEventItem(34) >= 1) and (HaveEventItem(35) >= 1) and (HaveEventItem(36) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 3) and (HaveNormalItem(3, 6, 0, 0) >= 10)) then
                state = 3
                subState = 1
            elseif (UTask_cg_1 >= 20 and UTask_cg_1 <= 27) then
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
-- AE yangshuang at 091026 end 


function main()
    tasks = {
        { "Minh Ch©u", "renwu1"; show = 0 },
        { "B¸o danh", "renwu"; show = 0 }
    }
    UTask_cg_1 = GetTask(41);
    if (UTask_cg_1 == 27) and (HaveEventItem(33) >= 1) and (HaveEventItem(34) >= 1) and (HaveEventItem(35) >= 1) and (HaveEventItem(36) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 3) and (HaveNormalItem(3, 6, 0, 0) >= 10) then
        tasks[1].show = 1;
    end ;
    if (UTask_cg_1 == 11) and (HaveEventItem(33) >= 1) then
        tasks[1].show = 1;
    end ;
    if (UTask_cg_1 == 3) and (HaveEventItem(33) >= 1) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() < 20) and (SystemTime() > 1111140000) and (SystemTime() < 1111226400) then
        tasks[2].show = 1;
        SayTask(11952, tasks)
    else
        SayTask(10546, tasks)
    end ;
end;

function renwu1()
    UTask_cg_1 = GetTask(41);
    if (UTask_cg_1 == 27) and (HaveEventItem(33) >= 1) and (HaveEventItem(34) >= 1) and (HaveEventItem(35) >= 1) and (HaveEventItem(36) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 3) and (HaveNormalItem(3, 6, 0, 0) >= 10) then
        Talk(1, "no", 10547)
        DelEventItem(33)
        DelEventItem(34)
        DelEventItem(35)
        DelEventItem(36)
        for i = 1, 3, 1 do
            DelNormalItem(3, 82, 0, 0)
        end

        for i = 1, 10, 1 do
            DelNormalItem(3, 6, 0, 0)
        end
        AddOwnExp(3000)
        AddNormalItem(3, 78, 0, 0, 0, 0)
        local i = random(0, 3)
        if (i == 0) then
            AddNormalItem(3, 80, 0, 0, 0, 0)
            TopMessage(11953)
        end ;
        SetTask(41, 10)
        Msg2Player("NhËn ®­îc 3000 ®iÓm kinh nghiÖm vµ 1 m¶nh Lam thñy tinh")
        TaskNote(20, -1)
        refreshNpcTaskState()
    elseif (UTask_cg_1 ~= 27) then
        MsgBox(11954, "no")
    else
        MsgBox(11955, "no")
    end ;

    if (UTask_cg_1 == 11) and (HaveEventItem(33) >= 1) then
        lingli();
    end ;

    if (UTask_cg_1 == 3) and (HaveEventItem(33) >= 1) then
        Talk(3, "lingli", 10548, 10549, 10550)
    end ;
end;

function lingli()
    MsgBox(11956, "yes_1", "no")
end;

function yes_1()
    Talk(1, "no", 11957)
    SetTask(41, 20)
    Msg2Player("§Õn §«ng H¶i t×m m¸u cña Chóc Ng­, Thè Ng­, ThÓ Ng­. ChuÈn bÞ Tha S¬n th¹ch vµ ®ång thau.")
    TaskNote(20, 3)
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetTask(330) == 0) then
        for a = 1, 3 do
            AddNormalItem(1, 0, 0, 0, 1, 0)
            AddNormalItem(1, 3, 0, 0, 1, 0)
        end ;
        SetTask(330, 1)
        refreshNpcTaskState()
        Talk(1, "no", 11958)
    else
        Talk(1, "no", 11959)
    end ;
end;
