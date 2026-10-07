Task_ks_Time = 83
Task_ks_Allday = 84
function main()
    local task = {
        { "BiÕn h×nh ¤ng giµ Noel", "spring1"; show = 1 },
        { "H¸i quµ Noel", "jiangli"; show = 1 },
    }
    local lastday = GetGlobalValue(Task_ks_Allday)
    local today = math.floor(SystemTime() / 86400)
    if (lastday ~= today) then
        SetGlobalValue(Task_ks_Allday, today)
        SetGlobalValue(Task_ks_Time, 0)
    end

    local today = math.floor(LocalSystemTime() / 86400)
    if (today == GetTask(1102)) then
        local l = GetOnlineTime()
        if (l < 3600) then
            local m = math.floor((3600 - l) / 60)
            local s = 3600 - l - m * 60
            SayTask("Gi¸ng sinh l¹i ®Õn råi!!! B¹n trÎ trong <c=r>" .. m .. "<c>phót <c=r>" .. s .. "<c> gi©y sau n÷a sÏ biÕn thµnh ¤ng giµ Noel! Haha!", task)
            return 0
        end
    else
        SetTask(1102, today)
        local t = GetOnlineTime()
        AddOnlineTime(-t)
        SetTask(1100, 0)
    end

    if (GetTask(1100) == 1) then
        task[1].show = 0
    end ;
    SayTask("Gi¸ng sinh l¹i ®Õn råi! Chóc c¸c b¹n trÎ trong thÕ giíi Phong thÇn vui vÎ!", task)
end

function no()
    CloseDialog()
end

function spring1()
    local l = GetOnlineTime()
    if (l < 3600) then
        local m = math.floor((3600 - l) / 60)
        local s = 3600 - l - m * 60
        Talk(1, "no", "B¹n trÎ Online ch­a ®ñ 1 toÕng! Cßn ph¶i sau <c=r>" .. m .. "<c>phót <c=r>" .. s .. "<c> míi nhËn ®­îc biÕn th©n ¤ng giµ Noel!")
        return 0
    end

    if (GetTask(1100) == 0) then
        local f = GetCompeteFlag()
        if (f == 1) then
            Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
        else
            if (GetMorphType() == 364) or (GetMorphType() == 357) or (GetMorphType() == 420) or (GetMorphType() == 419) then
                Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
            else
                PolyMorph(357, 1, 0, -1, 1800)
                SetTask(1100, 1)
            end ;
            CloseDialog()
        end
    else
        Talk(1, "no", "H«m nay ng­¬i ®· nhËn qua biÕn th©n råi! Mai l¹i ®Õn nhÐ!")
    end
end

function jiangli()
    MsgBox("Ng­¬i biÕn th©n thµnh ¤ng giµ Noel, mang theo <c=g>5<c> Kh¨n Gi¸ng sinh ®Õn gÆp ta sÏ nhËn ®­îc quµ! §· chuÈn bÞ l·nh quµ ch­a?", "jiangli_yes", "no")
end

function jiangli_yes()
    if (GetMorphType() ~= 357) then
        Talk(1, "no", "Ng­¬i kh«ng ë trong tr¹ng th¸i ¤ng giµ Noel, kh«ng thÓ h¸i quµ ®­îc!")
        return 1
    end

    if (HaveNormalItem(3, 243, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 243, 0, 0)
        end
        local nums = LoadIniInteger("christmas", 1)
        if (nums == nil) then
            nums = 0
        end
        nums = nums + 5

        if (nums == 100000) then
            SaveIniInteger("christmas", 1, 100000)
            local tongID = 0
            local tongmember = GetTongCount() - 1
            local MemberNum = 0
            for i = 0, tongmember do
                tongID = GetTongID(i)
                MemberNum = GetTongAttrByID(tongID)
                AddTongResByID(tongID, 1, MemberNum * 50)
                AddTongAttrByID(tongID, 0, MemberNum * 10)
            end
            NpcPolyMorph(DialogNpcIdx, 739)
            AddGlobalCountNews("Nhê cã nhiÒu ng­êi tËn t©m ch¨m sãc, c©y Th«ng Gi¸ng sinh ®· trë thµnh Th«ng Gi¸ng sinh cao cÊp! H­ng thÞnh vµ §ång thau cña thµnh thÞ sÏ t¨ng lªn ®¸ng kÓ!", 5)
            SetNpcName(DialogNpcIdx, "<c=g>Th«ng Gi¸ng sinh cao cÊp<c>")
        elseif (nums < 100000) then
            SaveIniInteger("christmas", 1, nums)
        end
        local sr = math.random(1, 100)

        if (sr <= 20) then
            AddNormalItemPile(6, 0, 20, 1, 0, 0)
            AddNormalItemPile(6, 0, 20, 1, 0, 0)
            TopMessage("B¹n nhËn ®­îc <c=g>2 LÔ hoa<c>")
            Talk(1, "jiangli", "B¹n nhËn ®­îc 2 LÔ hoa!")
        elseif (sr <= 40) then
            AddNormalItemPile(6, 1, 331, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc <c=g>1 TuyÕt CÇu<c>")
            Talk(1, "jiangli", "B¹n nhËn ®­îc 1 TuyÕt CÇu!")
        elseif (sr <= 60) then
            AddNormalItemPile(6, 1, 182, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc c¬ héi <c=g>ChÕ t¹o Ng­êi tuyÕt<c>")
            Talk(1, "jiangli", "B¹n nhËn ®­îc 1 ChÕ t¹o Ng­êi tuyÕt!")
        elseif (sr <= 77) then
            AddNormalItemPile(3, 247, 0, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc ch÷ <c=g>T©n<c>.")
            Talk(1, "jiangli", "B¹n nhËn ®­îc ch÷ T©n!")
        elseif (sr <= 85) then
            AddNormalItemPile(3, 245, 0, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc ch÷ <c=g>Cùu<c>.")
            Talk(1, "jiangli", "B¹n nhËn ®­îc ch÷ Cùu!")
        else
            local times = GetGlobalValue(Task_ks_Time) + 1
            if (sr <= 90) and (times <= 30) then
                AddNormalItemPile(3, 244, 0, 0, 0, 0)
                SetGlobalValue(Task_ks_Time, times)
                TopMessage("B¹n nhËn ®­îc ch÷ <c=g>Tõ<c>!")
                Talk(1, "jiangli", "TB¹n nhËn ®­îc ch÷ Tõ!")
            else
                AddNormalItemPile(3, 246, 0, 0, 0, 0)
                TopMessage("B¹n nhËn ®­îc ch÷ <c=g>Nghinh<c>!")
                Talk(1, "jiangli", "B¹n nhËn ®­îc ch÷:Nghinh!")
            end
        end
    else
        Talk(1, "no", "Ng­¬i ph¶i mang theo ®ñ 5 Kh¨n Gi¸ng sinh ®Õn míi ®­îc nhËn quµ!")
    end
end
