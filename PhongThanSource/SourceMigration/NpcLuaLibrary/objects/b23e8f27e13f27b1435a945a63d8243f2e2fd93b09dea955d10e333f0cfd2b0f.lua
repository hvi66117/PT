--description:npc
--author: zhujialiang
--date:2005/4/13
--modify:liuying 2005/5/26
--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-28

--jiaruoting 13-18Ö§Ïß
Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓð£¬3µÃµ½ÐÅ£¬4ÉÕËþ£¬5Íê³É£©
--2byte ÓÀ³ýºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²ÝÏÉ£¬6Íê³É£©

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
    local startLevel = 10

    --ÓÂÊ¿Ö®ÈÐ
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(25)
            if (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) and (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(25)
            if (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) and (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    -- ·´¿ÍÎªÖ÷
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 4) then
                state = 3
                subState = 0
            elseif (taskProcess == 5) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 4) then
                state = 3
                subState = 1
            elseif (taskProcess == 5) then
                state = 0
                subState = 0
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

function main()
    tasks = {
        { "<c=yel>Dòng §ao<c>", "renwu"; show = 0 },
        { "<c=yel>Ph¶n Kh¸ch Vi Chñ<c>", "renwu13"; show = 0 }
    }
    UTask_15 = GetTask(25);
    if (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) and (UTask_15 == 2) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 10 and GetPlayerType() == 0) then
        local state13 = GetTaskByte(Task_newer13, 1)
        if (state13 == 0 or state13 == 4) then
            tasks[2].show = 1;
        end
    end
    SayTask(11161, tasks)
    --	Talk(1,"no","ËÕÈ«ÖÒ£º½ñÌì×ÓÎÞµÀ£¬ÇáÏÍÖØÉ«£¬²»Ë¼Á¿ÁôÐÄ°î±¾£¬Ìý²÷ØúÖ®ÑÔ£¬ÓûÇ¿ÄÉÎáÃÃÎªåú£¬»ÄÒù¾ÆÉ«£¬²»¾ÃÌìÏÂ±äÂÒ¡£¾ý»µ³¼¸Ù£¬ÓÐ°ÜÎå³££¬¼½ÖÝËÕÊÏ£¬ÓÀÏÂ³¯ÉÌ¡£")
end;
function renwu()

    Talk(1, "main", 10281)
    AddOwnExp(50)
    DelEventItem(21)
    DelEventItem(22)
    DelEventItem(23)
    AddEventItem(24)
    AddOwnExp(50)

    TopMessage(12504)
    Msg2Player("Dòng §ao t¸i xuÊt giang hå!")
    TaskNote(11, 9)
    SetTask(25, 3)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

function renwu13()
    CloseDialog()
    if (GetPlayerType() == 0) then
        local state13 = GetTaskByte(Task_newer13, 1)
        if (state13 == 0) then
            if (GetLevel() >= 13) then
                MsgBox("gÇn ®©y ph¶n qu©n lµm lo¹n, yªu ma hoµnh hµnh, mét thÕ lùc lín ®ang dÇn h×nh thµnh, ta nghi ngê cã néi gi¸n cÊu kÕt nªn ®· lÖnh cho thÞ vÖ <c=r>T«n Tö Vò<c> ©m thÇm ®iÒu tra, h«m nay <c=r>T«n Tö Vò<c> ph¸i ng­êi ®Õn b¸o r»ng cã ph¶n qu©n ©m m­u ®iÒu tra lùc l­îng qu©n sù Sïng Thµnh, anh hïng h·y ®i t×m <c=r>T«n Tö Vò<c> hiÓu râ thªm t×nh h×nh.", "yes_sea", "no")
            else
                Talk(1, "no", "anh hïng mét lßng v× n­íc, thËt ®¸ng khen ngîi, tuy nhiªn nhiÖm vô träng ®¹i anh hïng cÇn ph¶i rÌn luyÖn thªm míi cã thÓ ®¶m ®­¬ng. §¹t cÊp 13 h·y quay l¹i t×m ta.")
            end
        elseif (state13 == 4) then
            Talk(1, "no", "C¶m t¹ anh hïng kÞp thêi hñy diÖt Tiªu Th¸p bÞ ph¶n qu©n chiÕm lÜnh. Nh­ng néi gi¸n mét ngµy kh«ng trõ ®i bän ta vÉn kh«ng ®­îc an täa, anh hïng ®¹t cÊp 18 h·y ®i t×m <c=r>Sïng HÇu hæ<c> ®¹i nh©n, cã mét nhiÖm vô träng ®¹i h¬n cÇn nhê ngµi.")
            SetTaskWord(Task_newer13, 1, 5)--log¸Ä°æ
            --AddOwnExp(800)
            AddOwnExp(2500)
            Msg2Player("Khi ®¹t cÊp 18 ®i t×m Sïng HÇu Hæ truy hái t×nh h×nh ®iÒu tra néi gi¸n.")
            --AS GaoJingwei 090730
            SetSubTask(209, -1, 1)
            --AE GaoJingwei 090730
            TaskNote(209, -1)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        end
    end
end

function yes_sea()
    Talk(1, "no", GetName() .. " kh«ng ngê l¹i cã sù viÖc nµy, t¹i h¹ sÏ ®i t×m T«n hé vÖ.")
    SetTaskByte(Task_newer13, 1, 1)
    Msg2Player("T×m T«n Tö Vò hái th¨m t×nh h×nh.")
    --AS GaoJingwei 090730
    SetSubTask(209, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(209, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end