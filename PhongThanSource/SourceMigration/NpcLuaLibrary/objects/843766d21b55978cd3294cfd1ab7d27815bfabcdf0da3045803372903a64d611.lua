function GetPlayerTaskState()
    return 0, 0
end

function main()
    tasks = {
        { "Gióp ®ì", "help"; show = 0 },
        { "Di Tiªn T¸n", "yixs"; show = 0 },
        { "Gi¶i nguy", "xiongdi"; show = 0 }
    }
    if (GetTask(597) == 299) then
        tasks[1].show = 1;
    end ;
    if (GetTask(597) >= 17) and (GetTask(597) <= 21) then
        tasks[2].show = 1;
    end ;
    if (GetTask(597) == 22) then
        tasks[3].show = 1;
    end ;
    SayTask(13841, tasks)
end;

function help()
    MsgBox(13842, "yes", "no")
end;

function yixs()
    if (GetTask(597) < 21) then
        Talk(1, "no", 13843)
    else
        if (HaveEventItem(111) >= 1) and (HaveEventItem(112) >= 1) and (HaveNormalItem(3, 22, 0, 0) >= 100) and (HaveNormalItem(3, 23, 0, 0) >= 100) and (HaveNormalItem(3, 24, 0, 0) >= 100) and (HaveNormalItem(3, 25, 0, 0) >= 100) then
            hecheng()
        else
            Talk(1, "no", 13843)
        end ;
    end ;
end;

function yes()
    SetTask(597, 17)
    SetTask(588, 1)
    TaskNote(35, 19)
    Talk(1, "no", 13844)
    AddCredit(15)
    AddOwnExp(4000)
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
    TopMessage(13071)
    Msg2Player("GÆp LiÔu Nh©n vµ YÓn Phong t×m d­îc liÖu")
end;

function hecheng()
    if (HaveEventItem(111) >= 1) and (HaveEventItem(112) >= 1) and (HaveNormalItem(3, 22, 0, 0) >= 100) and (HaveNormalItem(3, 23, 0, 0) >= 100) and (HaveNormalItem(3, 24, 0, 0) >= 100) and (HaveNormalItem(3, 25, 0, 0) >= 100) then
        SetTask(597, 22)
        SetTask(589, 1)
        SetTask(590, 1)
        SetTask(591, 1)
        TaskNote(35, 23)
        Talk(2, "no", 13845, "Ng­¬i h·y ®em Di Tiªn T¸n ®Õn cho 3 vÞ huynh ®Ö cña ta <c=g>YÓn Long, YÓn Hæ, YÓn Lang<c>, h·y nhanh ch©n lªn!")
        for i = 1, 100 do
            DelNormalItem(3, 22, 0, 0)
            DelNormalItem(3, 23, 0, 0)
            DelNormalItem(3, 24, 0, 0)
            DelNormalItem(3, 25, 0, 0)
        end ;
        DelEventItem(111)
        DelEventItem(112)
        for i = 1, 3 do
            AddEventItem(113)
        end ;
        Msg2Player("T×m huynh ®Ö YÓn thÞ")
        AddCredit(5)
        local exp = GetNextExp() - GetExp()
        if (exp >= 100000) then
            AddOwnExp(100000)
        else
            AddOwnExp(exp)
            AddOwnExp(100000 - exp)
        end ;
        Msg2Player("NhËn ®­îc 10 v¹n ®iÓm kinh nghiÖm vµ 5 ®iÓm danh väng!")
        TopMessage(13846)
    else
        Talk(1, "no", 13843)
    end ;
end;

function xiongdi()
    if (GetTask(589) == 31) and (GetTask(590) == 31) and (GetTask(591) == 31) then
        Talk(1, "no", 13847)
        SetTask(597, 23)
        TaskNote(35, 27)
        AddCredit(5)
        local exp = GetNextExp() - GetExp()
        if (exp >= 20000) then
            AddOwnExp(20000)
        else
            AddOwnExp(exp)
            AddOwnExp(20000 - exp)
        end ;
        Msg2Player("NhËn ®­îc 20000 ®iÓm kinh nghiÖm vµ 5 ®iÓm danh väng!")
        TopMessage(13080)
        Msg2Player("§èi tho¹i víi YÓn B¸ Ých!")
    else
        Talk(1, "no", 13848)
    end ;
end;

function no()
    CloseDialog()
end;
