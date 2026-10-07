ZHUI = 1592
NOTE = 1500

Task_ibyq = 1613
Task_yq = 1614

Task_szxh = 1615

Task_szbzxy = 1616
Task_szbzdis = 1617
Family_szxh = 21

TaskNote_szxh = 1503

gTaskGlobalRand = 269
gTaskItem = { 3, 1061, 0, 0, 0, 0 }
gTotemInfo = {
    [1] = { name = "X¸c vËt tæ-Kim", x = 215, y = 212, res = "Th­íc Kim Sa" },
    [2] = { name = "X¸c vËt tæ-Méc", x = 280, y = 232, res = "UÊt Méc Chi" },
    [3] = { name = "X¸c vËt tæ-Háa", x = 258, y = 249, res = "XÝch Háa Th¹ch" },
    [4] = { name = "X¸c vËt tæ-Thñy", x = 248, y = 210, res = "ThiÖn Thñy Tinh" },
    [5] = { name = "X¸c vËt tæ-Thæ", x = 221, y = 250, res = "Kh«i Thæ Nham" },
}

Task_qz = 24

Task_rw = 1619
task_lingxi = { 10, 5 }
Task_snzxy = 1620
Task_snjuli = 1621

POSTERIRY_TYPE = {
    FUXI = 1, SHENNONG = 2, XUANYUAN = 3, SHAOHAO = 4, ZHUANXU = 5
}

function GetPlayerTaskState()
    return 0, 0
end

function main()

    local tasks = {
        { "Truy C¨n Tè Nguyªn", "zhuigen"; show = 0 },

        { "§¹o B¶o Tú H­u", "shizuxh_show"; show = 1 },


        { "VËt tæ T©m Linh", "aboutGensRenwu"; show = 1 },


        { "§o¹t tµi nguyªn", "RobRes"; show = 0 },


        { "VÒ DuÖ téc", "introduction"; show = 1 },


        { "VÒ chiÕn tranh", "readiness"; show = 0 },

    }
    if (GetTaskByte(ZHUI, 3) == 1) then
        tasks[1].show = 1
    end

    local H, M, S = GetHMS()
    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) and (IsTongMember(2) > 0) then
        tasks[6].show = 1
        if (H >= 20) and (H <= 21) or (H == 22 and M <= 30) then
            tasks[4].show = 1
        end
    end

    if ((GetTaskByte(ZHUI, 3) == 6) and IsTongMember(1) <= 0) then
        SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Þa t¹o sù nghiÖp, tèt nhÊt nªn lËp ®éi ngò hoÆc gia nhËp gia téc.", tasks)
    elseif (GetTaskByte(ZHUI, 3) == 0) then
        Talk(1, "no", "TiÓu anh hïng h·y mau ®i t×m <c=g>H·n Thanh Th­ Gi¶<c> ®Ó t×m hiÓu vÒ duÖ téc cña m×nh.")
    else
        SayTask("Theo truyÒn thuyÕt, ThÇn N«ng hä Kh­¬ng, th­êng nÕm b¸ch th¶o ®Ó t×m d­îc liÖu cøu ng­êi.", tasks)
    end
end;

function introduction()
    CloseDialog()
    local tasks = {
        { "Qu¶n lý gia téc", "aboutFamily"; show = 0 },
        { "Qu¶n lý thÞ téc", "aboutGens"; show = 0 },
        { "ChØnh lý m«n ®×nh", "changeGens"; show = 0 },
    }

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) then
        tasks[1].show = 1
    end

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO and IsTongMaster(1) > 0) then
        tasks[2].show = 1
    end

    if (GetPosterityType() > 0 and GetPosterityType() ~= POSTERIRY_TYPE.SHAOHAO) then
        tasks[3].show = 1
    end
    SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Þa t¹o sù nghiÖp, gia téc vµ thÞ téc chÝnh lµ bÝ quyÕt ®Ó sinh tån ë §éng Thiªn Phóc §Þa.", tasks)
end

function readiness()
    local taskin = {
        { "Mua ChiÕn kú", "zhanqi"; show = 1 },


        { "S¶n xuÊt chiÕn bÞ", "build"; show = 1 },
    }
    SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Þa t¹o sù nghiÖp, gia téc vµ thÞ téc chÝnh lµ bÝ quyÕt ®Ó sinh tån ë §éng Thiªn Phóc §Þa.", taskin)
end

function aboutGensRenwu()

    local tasks = {
        { "Trïng t¹o VËt tæ", "hearttotem"; show = 1 },
        { "Trõng gian diÖt ¸c", "renwu1"; show = 1 },

    }
    SayTask("Theo truyÒn thuyÕt, ThÇn N«ng hä Kh­¬ng, th­êng nÕm b¸ch th¶o ®Ó t×m d­îc liÖu cøu ng­êi.", tasks)
end

function renwu1()


    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng ph¶i ng­êi cña duÖ téc ta, ta kh«ng thÓ gióp ng­¬i.")
        return
    end

    if (IsTongMember(2) < 1) then
        Talk(1, "no", "Ng­¬i ch­a gia nhËp thÞ téc nµy, kh«ng cã t­ c¸ch ®¶m ®­¬ng nhiÖm vô khã kh¨n nh­ vËy.")
        return
    end

    local today_szxh = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local lastday_szxh = GetTaskByte(Task_rw, 3)
    if (today_szxh ~= lastday_szxh) then
        local progress_last = GetTaskByte(Task_rw, 1)
        if ((progress_last ~= 0)) then

            SetTaskWord(Task_snzxy, 1, 0)
            SetTaskWord(Task_snzxy, 2, 0)
            SetTaskByte(Task_rw, 1, 0)
            SetTaskByte(Task_snjuli, -1)
            ClearItem(6, 1, 759, 0)
            TaskNote(1505, -1)

            ScrollMessage("NhiÖm vô h«m qua cña ng­¬i ch­a hoµn thµnh ®· quay l¹i tõ ®Çu")
        end
        SetTaskByte(Task_rw, 3, today_szxh)
    end

    resetyqz()

    no()

    renwupangd()
end

function renwupangd()


    no()

    local qztime = GetByte(GetTongTask(Task_qz, 2), 1)

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1

    if ((qztime ~= today) or (GetByte(GetTongTask(Task_qz, 2), 2) ~= 1)) then
        Talk(1, "no", "Ch­a tu söa xong VËt tæ T©m Linh, ThÞ téc sÏ ch­a ®­îc khai më t©m linh. Lßng ng­êi khã ®o¸n, lµm sao biÕt ®­îc ai lµ b»ng h÷u, ai kÎ gian tµ?")
        Msg2Player("ThÞ téc cña b¹n vÉn ch­a hoµn thµnh nhiÖm vô trïng t¹o VËt tæ, kh«ng thÓ t×m ®­îc n¬i Èn th©n cña bän gian tÆc")
        return

    end

    local yqz_xiaohao = GetTaskByte(Task_yq, 2)
    if (yqz_xiaohao >= yqz_chongzhi() * 2) then
        Talk(1, "no", "H«m nay tiªu hao qu¸ nhiÒu nguyªn khÝ, ngµy mai h·y ®Õn nhÐ")
        return
    end

    if (GetTaskByte(Task_rw, 1) == 0) then

        local yqz = GetTransWarTaskPower()
        if (yqz >= 3) then

            MsgBox("HiÖn t¹i ng­¬i cã <c=g>" .. yqz .. "<c> ®iÓm nguyªn khÝ, mçi lÇn nhËn nhiÖm vô Trõng gian diÖt ¸c sÏ khÊu trõ=g>3<c> ®iÓm nguyªn khÝ. §ång ý chø?", "renwubegin", "no")
        else
            Talk(1, "no", "NhiÖm vô nµy sÏ hao tæn nguyªn khÝ, nguyªn khÝ cña ng­¬i kh«ng ®ñ 3 ®iÓm, h·y ®i tÜnh luyÖn thªm.")
            return
        end


    elseif (GetTaskByte(Task_rw, 1) == 1 or GetTaskByte(Task_rw, 1) == 2) then
        MsgBox("Gian tÕ Èn trèn rÊt tinh vi, ng­¬i h·y theo h­íng dÉn cña ChØ DÉn §å t×m n¬i Èn cña chóng. Nh­ng nÕu nh­ ng­êi phe ®Þch cøu ®­îc Gi¸n §iÖp mang ®i, th× ng­¬i ph¶i hñy bá nhiÖm vô. Muèn hñy bá nhiÖm vô sao?", "yes_quxiao", "no")

    elseif (GetTaskByte(Task_rw, 1) == 3) then
        local Exploit = GetExploit()
        local ExploitV = GetExploitV()
        SetExploit(Exploit + 20)
        SetExploitV(ExploitV + 20)
        Talk(1, "no", "Chóc mõng ng­¬i hoµn thµnh nhiÖm vô, xøng ®¸ng nhËn ®­îc 20 ®iÓm tÝch lòy C«ng tr¹ng vµ 20 §iÓm c«ng tr¹ng.")
        Msg2Player("B¹n nhËn ®­îc 20 ®iÓm tÝch lòy C«ng tr¹ng vµ 20 §iÓm c«ng tr¹ng.")
        SetTaskWord(Task_snzxy, 1, 0)
        SetTaskWord(Task_snzxy, 2, 0)
        SetTaskByte(Task_rw, 1, 0)
        SetTaskByte(Task_snjuli, -1)
        TaskNote(1505, -1)
        local nLuckyNum = GetTaskByte(Task_rw, 2)
        local rluck = math.random(1, 1000)
        if (nLuckyNum == 0) then
            nLuckyNum = task_lingxi[1]
            SetTaskByte(Task_rw, 2, nLuckyNum)
        end

        local str1 = ""
        if (rluck <= nLuckyNum) then
            AddNormalItem(3, 1058, 0, 0, 0, 0)
            SetTaskByte(Task_rw, 2, task_lingxi[1])
            Msg2Player("Chóc mõng b¹n may m¾n nhËn ®­îc 1 m¶nh Lam Thñy tinh ThÇn Hùu.")
            TopMessage("NhËn ®­îc 1 m¶nh Lam Thñy tinh ThÇn Hùu")
            str1 = "Ngoµi ra cßn tÆng thªm 1 <c=yel>m¶nh Lam Thñy tinh ThÇn Hùu<c>, nã sÏ gióp ng­¬i th¨ng cÊp trang bÞ, "
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> hoµn thµnh nhiÖm vô t×m Gi¸n §iÖp, ®­îc hËu duÖ thÞ téc tÆng <c=r>1 m¶nh Lam Thñy tinh ThÇn Hùu<c>. Xin chóc mõng!", 20)
        else
            SetTaskByte(Task_rw, 2, (nLuckyNum + task_lingxi[2]))
        end
    end
end
function renwubegin()
    no()
    local maps = {
        { mapid = 92, x = 1880, y = 3478, r = 20 },
        { mapid = 92, x = 1979, y = 3526, r = 20 },
        { mapid = 92, x = 1894, y = 3408, r = 20 },
        { mapid = 92, x = 1864, y = 3846, r = 20 },
        { mapid = 92, x = 2122, y = 3552, r = 20 },
        { mapid = 92, x = 1917, y = 3937, r = 20 },
        { mapid = 92, x = 2244, y = 3513, r = 20 },
        { mapid = 92, x = 1760, y = 3507, r = 20 },

    }

    local yqz = GetTransWarTaskPower()
    if (HaveNormalItem(3, 1020, 0, 0) >= 1) and (yqz >= 3) then


        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Ng­¬i ph¶i dïng ChØ DÉn §å cña ta míi cã thÓ t×m thÊy Gi¸n §iÖp. Hµnh trang cña ng­¬i ®Çy råi, kh«ng thÓ nhËn ChØ DÉn §å.")
            return
        end

        DelNormalItem(3, 1020, 0, 0)

        ModifyTransWarTaskPower(-3)

        AddNormalItem(6, 1, 759, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc ChØ DÉn §å.")
        local num = math.random(1, 8)
        SetTaskWord(Task_snzxy, 1, maps[num].x)
        SetTaskWord(Task_snzxy, 2, maps[num].y)
        SetTaskByte(Task_rw, 1, 1)
        SetTaskByte(Task_snjuli, -1)

        Talk(1, "no", "Ng­¬i ®· nhËn nhiÖm vô, nhËn ®­îc ChØ DÉn §å. ChØ DÉn §å cã thÓ chØ ng­¬i ®Õn n¬i Èn n¸u cña bän Gi¸n §iÖp! Nh­ng chØ khi ng­¬i hoÆc ®ång ®éi cña ng­¬i b¾t ®­îc chóng, th× míi th¾ng lîi hoµn thµnh nhiÖm vô. Chó ý: Gi¸n §iÖp chØ xuÊt hiÖn trong thêi gian ng¾n.")
        TaskNote(1504, 0)
        TaskNote(1504, -1)
        return

    elseif (HaveNormalItem(3, 1020, 0, 0) == 0) then
        Talk(1, "no", " Gian tÕ Èn trèn rÊt tinh vi, cÇn cã 1 Tinh Hoa Nh©n Hån míi cã thÓ dô chóng xuÊt hiÖn, tiÕc qu¸ ng­¬i kh«ng cã ®ñ nguyªn liÖu, kh«ng thÓ nhËn nhiÖm vô.")
        return
    elseif (yqz < 3) then
        Talk(1, "no", "NhiÖm vô nµy sÏ hao tæn nguyªn khÝ, nguyªn khÝ cña ng­¬i kh«ng ®ñ 3 ®iÓm, h·y ®i tÜnh luyÖn thªm.")
        return
    end
end

function yes_quxiao()
    no()
    Talk(1, "no", "Ng­¬i ®· hñy bá nhiÖm vô")
    Msg2Player("Ng­¬i ®· hñy nhiÖm vô")
    SetTaskWord(Task_snzxy, 1, 0)
    SetTaskWord(Task_snzxy, 2, 0)
    SetTaskByte(Task_rw, 1, 0)
    SetTaskByte(Task_snjuli, -1)
    ClearItem(6, 1, 759, 0)
    TaskNote(1505, -1)
    local MstIdx = GetTask(1636)
    local OwnID = GetNpcTask(MstIdx, 1)
    if (OwnID == GetPlayerID()) then
        DelNpc(MstIdx)
    end
end

function yuanqizhi()
    local yqz = GetTask(Task_ibyq) + GetTaskByte(Task_yq, 3)

    return yqz
end

function hearttotem()
    no()
    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng ph¶i ng­êi cña duÖ téc ta, ta kh«ng thÓ gióp ng­¬i.")
        return
    end

    if (IsTongMember(2) < 1) then
        Talk(1, "no", "Ng­¬i ch­a gia nhËp thÞ téc nµy, kh«ng cã t­ c¸ch ®¶m ®­¬ng nhiÖm vô khã kh¨n nh­ vËy.")
        return
    end

    if (IsHaveTongRight(14, 2) < 1) then
        Talk(1, "no", " Ng­¬i kh«ng cã quyÒn h¹n néi chÝnh cña ThÞ téc, ch­a cã t­ c¸ch ®Ó ®¶m nhËn nhiÖm vô.")
        return
    end

    local H, M, S = GetHMS()
    if (H >= 19) then
        Talk(1, "no", " HiÖn giê ch­a ph¶i lóc ph¸t huy tèi ®· søc m¹nh cña VËt tæ T©m Linh, tr­íc <c=g>19h<c> h·y ®Õn nhÐ.")
        return
    end

    local taskInfo = GetGlobalValue(gTaskGlobalRand)
    local taskday = GetByte(taskInfo, 1)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255)

    if (taskday ~= today) then
        taskInfo = SetByte(taskInfo, 1, today)
        SetGlobalValue(gTaskGlobalRand, taskInfo)
        local randPos = math.random(1, 5)
        taskInfo = SetByte(taskInfo, 2, randPos)
        SetGlobalValue(gTaskGlobalRand, taskInfo)
    end
    local idx = GetByte(GetGlobalValue(gTaskGlobalRand), 2)

    MsgBox(" X¸c ®Þnh nhËn nhiÖm vô <c=g>Trïng t¹o VËt tæ<c> chø? H«m nay cÇn <c=g>100<c> ®iÓm Tµi nguyªn thÞ téc <c=g>" .. gTotemInfo[idx].res .. "<c><enter><c=r>Chó ý: mçi ngµy chØ cÇn thµnh c«ng hoµn thµnh 1 lÇn nhiÖm vô lµ ®­îc<c>", "accepttask", "no")
end

function accepttask()
    no()
    local H, M, S = GetHMS()
    if (H >= 19) then
        Talk(1, "no", "HiÖn giê ch­a ph¶i lóc ph¸t huy tèi ®· søc m¹nh cña VËt tæ T©m Linh, tr­íc <c=g>19h<c> h·y ®Õn nhÐ.")
        return
    end

    local idx = GetByte(GetGlobalValue(gTaskGlobalRand), 2)

    local rescount = GetTongRes((idx + 1), 2)
    if (rescount < 100) then
        Talk(1, "no", " ThÞ téc kh«ng cã ®ñ <c=g>" .. gTotemInfo[idx].res .. "<c>")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", " <c=r>Xin thu xÕp Ýt nhÊt 1 « trèng trong hµnh trang tr­íc!<c>")
        return 0
    end

    WasteTongRes((idx + 1), 100, 2)
    Msg2Player("B¹n tiªu hao Tµi nguyªn thÞ téc " .. gTotemInfo[idx].res .. "100 ®iÓm")
    AddNormalItem(gTaskItem[1], gTaskItem[2], gTaskItem[3], gTaskItem[4], gTaskItem[5], gTaskItem[6])
    Talk(1, "no", " Ng­¬i ®· tiÕp nhËn thµnh c«ng nhiÖm vô <c=g>Trïng t¹o VËt tæ<c>, h·y ®Õn <c=g>" .. gTotemInfo[idx].name .. "[" .. gTotemInfo[idx].x .. "," .. gTotemInfo[idx].y .. "]<c> hoµn thµnh nhiÖm vô")
    Msg2Player("B¹n nhËn ®­îc 1 <c=g>Ký øc VËt Tæ<c>")
    TaskNote(1504, 0, gTotemInfo[idx].name, gTotemInfo[idx].x, gTotemInfo[idx].y)
end

function zhuigen()
    if (GetTaskByte(ZHUI, 3) == 1) then
        CloseDialog()
        Talk(3, "no", " Phôc Hy, ThÇn N«ng, Hiªn Viªn, ThiÕu H¹o, Chuyªn Hóc cã nhiÒu c«ng lao víi thiªn h¹, ta rÊt vinh dù ®­îc thay Ngò §Õ duy tr× c¸c luËt lÖ", "<c=g>" .. GetName() .. "<c>: VËy tiªn sinh cã biÕt ta thuéc duÖ téc nµo kh«ng?", " ViÖc nµy h·y cho ta thêi gian, t¹m thêi ng­¬i cã thÓ t×m hiÓu Khe nøt ViÔn Cæ, gióp [H·n Thanh Th­ Gi¶] hoµn thiÖn “H·n Thanh Toµn Th­”, chØ lµ hiÖn t¹i ng­¬i ch­a râ duÖ téc, nªn ch­a thÓ ®i vµo phóc ®Þa!", " Ng­¬i cã thÓ ®Õn biªn giíi cña 5 vïng phóc ®Þa lÇn l­ît t×m [C«ng Th©u V·ng], [C«ng Th©u Kh¶i], [C«ng Th©u ViÔn], [C«ng Th©u T¨ng], [C«ng Th©u MiÔn] cña C«ng Th©u NhÊt M¹ch ®Ó t×m hiÓu t×nh h×nh phóc ®Þa, sau ®ã vÒ b¸o cho [H·n Thanh Th­ Gi¶]. Ph¶i lu«n nhí kü, C«ng Th©u NhÊt M¹ch tÝnh t×nh cæ qu¸i, lóc thØnh gi¸o ph¶i hÕt søc thËn träng vµ khiªm tèn!")
        SetTaskByte(ZHUI, 3, 2)
        TaskNote(NOTE, 1)
        Msg2Player("§i t×m C«ng Th©u NhÊt M¹ch thØnh gi¸o.")
        return
    elseif (GetTaskByte(ZHUI, 3) == 2) then
        Talk(1, "no", " VÉn ch­a t×m thÊy C«ng Th©u NhÊt M¹ch ­? Chóng th­êng ë gÇn 5 n¬i phóc ®Þa.")
        return
    end
end

function no()
    CloseDialog()
end;

function shizuxh_show()


    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", " Ng­¬i lµ ai? kh«ng ph¶i lµ ng­êi cña duÖ téc ta, th× ta kh«ng thÓ gióp ®­îc g×.")
        return
    end

    if (IsTongMember(2) == 0) then
        Talk(1, "no", " RÊt tiÕc, c¸c h¹ kh«ng ph¶i lµ thµnh viªn thÞ téc, kh«ng thÓ nhËn nhiÖm vô.")
        return
    end

    local today_szxh = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local lastday_szxh = GetTaskByte(Task_szxh, 3)
    if (today_szxh ~= lastday_szxh) then
        local progress_last = GetTaskByte(Task_szxh, 1)
        if ((progress_last ~= 0) and (progress_last ~= 3)) then
            SetTaskByte(Task_szxh, 1, 0)
            SetTaskByte(Task_szxh, 2, 0)
            ClearItem(6, 1, 757, 0)
            ClearItem(4, 292, 0, 1)
            TaskNote(TaskNote_szxh, -1)
            ScrollMessage("NhiÖm vô h«m qua cña ng­¬i ch­a hoµn thµnh ®· quay l¹i tõ ®Çu")
        end
        SetTaskByte(Task_szxh, 3, today_szxh)
    end

    local progress = GetTaskByte(Task_szxh, 1)
    local btn = "NhËn nhiÖm vô"
    if ((progress == 1) or (progress == 2)) then
        btn = "Hoµn tr¶ b¶o vËt"
    end
    local tasks = {

        { btn, "shizuxh"; show = 1 },
        { "Huû nhiÖm vô", "szxh_cancel"; show = 0 },

    }

    local shizu = GetPosterityType()
    if (shizu == 4) then
        local progress = GetTaskByte(Task_szxh, 1)
        if ((progress == 1) or (progress == 2)) then
            tasks[2].show = 1
        end
    end

    SayTask("Phóc ®Þa cã mét sinh linh, tªn Tú H­u, nã rÊt thÝch b¶o vËt, hÔ nh×n thÊy lµ nuèt ngay vµo bông. Nay b¶o vËt cña bé téc chóng t«i kh«ng may bÞ Tú H­u trém mÊt, v× thÕ ph¶i dïng Thiªn Tóy Lan dô b¾t Tú H­u tham ¨n ®ã, b¾t nã nh¶ tr¶ b¶o vËt.", tasks)
end

function shizuxh()
    resetyqz()

    local yqz = GetTransWarTaskPower()
    local progress = GetTaskByte(Task_szxh, 1)
    if ((progress == 0) or (progress == 3)) then
        MsgBox("Phóc ®Þa cã mét sinh linh, tªn Tú H­u, nã rÊt thÝch b¶o vËt, hÔ nh×n thÊy lµ nuèt ngay vµo bông. Nay b¶o vËt cña bé téc chóng t«i kh«ng may bÞ Tú H­u trém mÊt, v× thÕ ph¶i dïng Thiªn Tóy Lan dô b¾t Tú H­u tham ¨n ®ã, b¾t nã nh¶ tr¶ b¶o vËt. HiÖn t¹i ng­¬i cã <c=g>" .. yqz .. "<c> ®iÓm nguyªn khÝ, mçi lÇn nhËn nhiÖm vô ®Òu tèn 1 Tinh Hoa §Þa Hån vµ <c=g>5<c> ®iÓm nguyªn khÝ, giê ng­¬i cã muèn nhËn nhiÖm vô kh«ng?", "szxh_yes", "no")
    elseif (progress == 1) then
        Talk(1, "no", "Ng­¬i ch­a ®o¹t l¹i b¶o vËt bÞ trém, mau ®i dô b¾t Tú H­u tham ¨n ®ã! Ngµy mai nã sÏ mang b¶o vËt ®i giÊu, lóc ®ã ng­¬i sÏ kh«ng thÓ t×m ®­îc.")
    elseif (progress == 2) then
        szxhfulfill()
    end
end

function resetszidx()
    local timestamp = GetByte(GetTongTask(Family_szxh, 2), 1)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1

    if (today ~= timestamp) then
        local fudiidx = math.random(1, 5)
        SetTongTask(Family_szxh, SetByte(SetByte(0, 1, today), 2, fudiidx), 2)
    end
end

function resetyqz()
    local lastday = GetTaskByte(Task_yq, 1)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (lastday ~= today) then
        local yqz_chongzhi = yqz_chongzhi()

        SetTaskByte(Task_yq, 1, today)
        SetTaskByte(Task_yq, 2, 0)

        local t = GetTransWarTaskPower()
        ModifyTransWarTaskPower(-t)
        ModifyTransWarTaskPower(yqz_chongzhi)
    end
end

function yqz_chongzhi()
    local level = GetExploitLevel()
    local yzq = 0
    if (level == 1) then
        yqz = 5
    elseif (level == 2) then
        yqz = 8
    elseif (level == 3) then
        yqz = 13
    elseif (level == 4) then
        yqz = 20
    elseif ((level == 5) or (level == 6)) then
        yqz = 30
    end
    return yqz
end

function szxh_yes()
    local level = GetExploitLevel()
    if (level < 3) then
        Talk(1, "no", "Víi c«ng tr¹ng hiÖn t¹i, ng­¬i ch­a thÓ nhËn träng tr¸ch nµy, ®îi khi c«ng tr¹ng ®¹t cÊp 3 h·y quay l¹i.")
        return
    end

    local yqz_xiaohao = GetTaskByte(Task_yq, 2)
    if (yqz_xiaohao >= yqz_chongzhi() * 2) then
        Talk(1, "no", "Cèng hiÕn cho thÞ téc lµ viÖc nªn lµm, nh­ng ph¶i tù l­îng søc, nguyªn khÝ h«m nay cña ng­¬i ®· c¹n kiÖt, ®îi khi nµo ®ñ h·y quay l¹i.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Ng­¬i cÇn dïng Thiªn Tóy Lan mµ ta cho ng­¬i ®Ó ®èi phã víi Tú H­u, nh­ng hµnh trang cña ng­¬i ®· ®Çy, kh«ng thÓ bá vµo Thiªn Tóy Lan.")
        return
    end
    if (HaveNormalItem(3, 1024, 0, 0) <= 0) then
        Talk(1, "no", "Thiªn Tóy Lan kh«ng dÔ cã ®­îc, ph¶i ch¨m bãn b»ng Tinh Hoa §Þa Hån.")
        return
    end

    local yqz = GetTransWarTaskPower()
    if (yqz < 5) then
        Talk(1, "no", "NhiÖm vô nµy tèn nhiÒu nguyªn khÝ, ng­¬i kh«ng ®ñ 5 ®iÓm nguyªn khÝ, ta khuyªn ng­¬i nªn tu d­ìng nguyªn khÝ.")
        return
    else


        ModifyTransWarTaskPower(-5)
    end

    local fudi_info = {
        [1] = { name = "Th­íc Kim Phóc §Þa", pxid = 1507 },
        [2] = { name = "ThiÖn Thñy Phóc §Þa", pxid = 1558 },
        [3] = { name = "óc Méc Phóc §Þa", pxid = 1557 },
        [4] = { name = "XÝch Háa Phóc §Þa", pxid = 1559 },
        [5] = { name = "Kh«i Thæ Phóc §Þa", pxid = 1560 },
    }
    resetszidx()

    local fudiidx = GetByte(GetTongTask(Family_szxh, 2), 2)

    WriteLog(GetName() .. "§· nhËn nhiÖm vô §¹o B¶o Tú H­u.")

    SetTaskByte(Task_yq, 2, yqz_xiaohao + 5)
    SetTaskByte(Task_szxh, 1, 1)
    SetTaskByte(Task_szxh, 2, fudiidx)
    AddNormalItem(6, 1, 757, 0, 0, 0)
    DelNormalItem(3, 1024, 0, 0)
    TaskNote(TaskNote_szxh, 0, fudi_info[fudiidx].name)
    Talk(1, "no", "Theo ta ®­îc biÕt, th× <c=g>" .. fudi_info[fudiidx].name .. "<c>-Tú H­u ®· trém b¶o vËt cña thÞ téc chóng t«i, mau qua bªn ®ã ®i t×m Tú H­u tham ¨n ®ã!")
end

function szxhfulfill()
    if (HaveEventItem(292) > 0) then
        SetTaskByte(Task_szxh, 1, 3)
        ClearItem(6, 1, 757, 0)
        ClearItem(4, 292, 0, 1)
        TaskNote(TaskNote_szxh, -1)
        local Exploit = GetExploit()
        local ExploitV = GetExploitV()
        SetExploit(Exploit + 50)
        SetExploitV(ExploitV + 50)

        WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô §¹o B¶o Tú H­u.")

        local tongName = GetTongName(2)
        local resourceNum = GetUnionTongTechCustomPointByName(tongName) + 1
        if (resourceNum > 2000) then
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· ®o¹t l¹i b¶o vËt, ®óng lµ kh«ng thÓ xem th­êng!")
            Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng c«ng tr¹ng")
        else
            SetUnionTongTechCustomPointByName(tongName, resourceNum)
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· ®o¹t l¹i b¶o vËt, ®óng lµ kh«ng thÓ xem th­êng! Ng­¬i ®· khiÕn thÞ téc cña chóng t«i t¨ng 1 ®iÓm Tµi nguyªn thÞ téc!")
            Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng c«ng tr¹ng vµ tµi nguyªn thÞ téc")
        end
    else
        Talk(1, "no", "<c=g>B¶o vËt bÞ trém<c> ®©u?")
    end
end

function szxh_cancel()
    MsgBox("Tuy b¶o vËt bÞ Tú H­u trém kh«ng nhiÒu, nh­ng ®ã còng lµ må h«i n­íc m¾t cña d©n chóng, ng­¬i x¸c nhËn hñy gióp ®ì kh«ng?", "szxh_can_yes", "no")
end

function szxh_can_yes()

    if (IsTongMember(2) == 0) then
        Talk(1, "no", "RÊt tiÕc, c¸c h¹ kh«ng ph¶i thµnh viªn cña thÞ téc, th«ng c¶m nhÐ, ta kh«ng thÓ gióp ng­¬i.")
        return
    end

    SetTaskByte(Task_szxh, 1, 3)
    ClearItem(6, 1, 757, 0)
    ClearItem(4, 292, 0, 1)
    TaskNote(TaskNote_szxh, -1)
    Talk(1, "no", "Ng­¬i ®· hñy nhiÖm vô lÇn nµy.")
end

Gens_Tramcer_Number = 25
Gens_Tramcer_Time = 26

Task_Exploit_Today = 1638

Gens_ID = 0
Res_Type = 1
Res_Count = 2
Death_Times = 3

TramcarLocation = {
    [1] = { x = 1929, y = 3747, link = "[92,241,234]" },
    [2] = { x = 1923, y = 3726, link = "[92,240,232]" },
    [3] = { x = 1937, y = 3733, link = "[92,242,233]" }
}

TramcarTempalte = {
    [1] = { template = 1588, name = "Kho¸ng xa" },
    [2] = { template = 1589, name = "Kho¸ng xa háng" },
    [3] = { template = 1590, name = "Kho¸ng xa ®æ n¸t " }
}

function RobRes()
    local tasks = {
        { "NhËn Kho¸ng xa", "getTramcar"; show = 0 },
        { "Nép tµi nguyªn", "turnInRes"; show = 0 },
    }

    local H, M, S = GetHMS()
    if (H == 20) or (H == 21 and M < 50) then
        if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) and (IsTongMember(2) > 0) and (IsHaveTongRight(13, 2) == 1) then
            tasks[1].show = 1
        end
    end

    if (H >= 20) and (H <= 21) or (H == 22 and M <= 30) then
        if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) and (IsTongMember(2) > 0) then
            tasks[2].show = 1
        end
    end

    SayTask("20:00 mçi ngµy, nh÷ng ng­êi cã quyÒn qu©n chÝnh trong thÞ téc cã thÓ ®Õn chç ta nhËn Kho¸ng xa.", tasks)
end

function getTramcar()
    local H, M, S = GetHMS()
    if (H < 20) or (H > 21) or (H == 21 and M > 50) then
        Talk(1, "§· hÕt thêi gian, kh«ng thÓ nhËn Kho¸ng Xa.")
        return
    end

    if (IsHaveTongRight(13, 2) == 0) then
        Talk(1, "no", "Ng­êi cã quyÒn qu©n chÝnh míi ®­îc nhËn nhËn Kho¸ng Xa.")
        return
    end

    local today = math.floor(LocalSystemTime() / 86400)
    local lastDay = GetTongTask(Gens_Tramcer_Time, 2)
    local nNum = GetTongTask(Gens_Tramcer_Number, 2)
    local nfamily = GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO)

    if (today == lastDay) and (nNum >= nfamily) then
        Talk(1, "no", "ThÞ téc cña ng­¬i do gia téc " .. nfamily .. " t¹o thµnh, thÞ téc cña ng­¬i ®· nhËn ë ®©y" .. nNum .. " Kho¸ng xa, h«m nay ®· nhËn ®Õn møc tèi ®a.")
        return
    end

    if (today ~= lastDay) then
        SetTongTask(Gens_Tramcer_Time, today, 2)
        SetTongTask(Gens_Tramcer_Number, 0, 2)
    end

    nNum = GetTongTask(Gens_Tramcer_Number, 2)

    if (nNum < nfamily) then
        MsgBox("ThÞ téc cña ng­¬i do gia téc " .. nfamily .. " gia téc t¹o thµnh, nªn thÞ téc cña ng­¬i cã thÓ ®Õn chç ta nhËn " .. nfamily .. " Kho¸ng xa, hiÖn ®· nhËn " .. nNum .. ", ng­¬i muèn nhËn kh«ng?", "yes_GetTramcer", "no")
    end
end

function yes_GetTramcer()
    CloseDialog()
    local H, M, S = GetHMS()
    if (H < 20) or (H > 21) or (H == 21 and M > 50) then
        Talk(1, "HiÖn kh«ng ph¶i lµ thêi gian thu thËp m¹ch kho¸ng, nhËn Kho¸ng xa lóc nµy phÝ l¾m, h·y chê c¬ héi lÇn sau.")
        return
    end

    if (IsHaveTongRight(13, 2) == 0) then
        Talk(1, "no", "Kho¸ng xa kh«ng ph¶i ai còng ®­îc nhËn, chØ nh÷ng ng­êi cã quyÒn qu©n chÝnh míi cã t­ c¸ch nµy.")
        return
    end

    local today = math.floor(LocalSystemTime() / 86400)
    local lastDay = GetTongTask(Gens_Tramcer_Time, 2)
    local nNum = GetTongTask(Gens_Tramcer_Number, 2)
    local nfamily = GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO)

    if (today == lastDay) and (nNum >= nfamily) then
        Talk(1, "no", "ThÞ téc cña ng­¬i do gia téc " .. nfamily .. " t¹o thµnh, thÞ téc cña ng­¬i ®· nhËn ë ®©y" .. nNum .. " Kho¸ng xa, h«m nay ®· nhËn ®Õn møc tèi ®a.")
        return
    end

    if (today ~= lastDay) then
        SetTongTask(Gens_Tramcer_Time, today, 2)
        SetTongTask(Gens_Tramcer_Number, 0, 2)
    end

    nNum = GetTongTask(Gens_Tramcer_Number, 2)

    if (nNum < nfamily) then
        local map, x, y = GetNpcWorldPos(DialogNpcIdx)

        if (map ~= 92) then
            return
        end

        local nRand = math.random(1, table.getn(TramcarLocation))
        x = TramcarLocation[nRand].x * 32
        y = TramcarLocation[nRand].y * 32
        local carriageindex = NewSiegeWeapon(map, x, y, TramcarTempalte[1].template, 3)

        if (carriageindex > 0) then
            local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
            local gensName = GetTongName(2)
            SetNpcScript(carriagenpcindex, "\\script\\¿ç·þÕ½³¡\\¿ó³µ.lua")
            SetNpcName(carriagenpcindex, "[" .. gensName .. "]" .. "Kho¸ng xa")
            local npcId = GetNpcID(carriagenpcindex)
            local nLeftTime = (22 - H) * 3600 + (29 - M) * 60 + (60 - S)
            local guardindex = SendCarriage(carriageindex, GetName(), 1, nLeftTime, npcId, gensName, 3)

            SetTGuardTaskValue(guardindex, Res_Type, 0)
            SetTGuardTaskValue(guardindex, Res_Count, 0)
            SetTGuardTaskValue(guardindex, Death_Times, 0)

            nNum = nNum + 1
            SetTongTask(Gens_Tramcer_Number, nNum, 2)

            local sUnionName = GetTongName(2)
            SetNpcUnionCamp(carriagenpcindex, sUnionName)

            local linkPos = "<HyperLinkWorldPos=\"" .. TramcarLocation[nRand].link .. "\">"
            Msg2Player("Kho¸ng xa cña ng­¬i ®­îc ®Æt t¹i täa ®é " .. linkPos)
            Msg2TongMemberByTongName(gensName, "[<RoleName=\"" .. GetName() .. "\">] ®· gÆp [ThiÕu H¹o HËu DuÖ] nhËn 1 [Kho¸ng Xa], mäi ng­êi h·y nhanh chãng ®i b¶o hé")
        end
    end
end

function turnInRes()
    CloseDialog()
    local carriageindex = IsPlayerInsideWeapon(PlayerIndex)

    if (carriageindex <= 0) then
        Talk(1, "no", "Ng­¬i ph¶i mang Kho¸ng xa ®Õn míi cã thÓ nép tµi nguyªn vµo kho thÞ téc.")
        return
    end

    local guardindex = GetTGuardIndexByCarriageIndex(carriageindex)
    if (guardindex <= 0) then
        Talk(1, "no", "Kh«ng t×m thÊy Kho¸ng xa.")
        return
    end

    local nResType = GetTGuardTaskValue(guardindex, Res_Type)
    local nResCount = GetTGuardTaskValue(guardindex, Res_Count)

    if (nResCount <= 0) then
        Talk(1, "no", "§õng lõa ta, trªn Kho¸ng xa cña ng­¬i kh«ng cã tµi nguyªn.")
        return
    end

    local nExploit = 0
    if (nResCount >= 150) then
        nExploit = 5
    elseif (nResCount >= 100 and nResCount < 150) then
        nExploit = 4
    elseif (nResCount >= 50 and nResCount < 100) then
        nExploit = 3
    end

    local nThisDay = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local nDay = GetTaskByte(Task_Exploit_Today, 1)
    local nMyExploit = GetTaskByte(Task_Exploit_Today, 2)

    if (nDay ~= nThisDay) then
        SetTaskByte(Task_Exploit_Today, 1, nThisDay)
        SetTaskByte(Task_Exploit_Today, 2, nExploit)
        SetTaskByte(Task_Exploit_Today, 3, 0)
    else
        if (nExploit + nMyExploit > 20) then
            nMyExploit = 20
            nExploit = 20 - nMyExploit
        else
            nMyExploit = nExploit + nMyExploit
        end

        SetTaskByte(Task_Exploit_Today, 2, nMyExploit)
    end

    if (nExploit > 0) then
        local nOldExp = GetExploit()
        local nOldExpV = GetExploitV()
        nOldExp = nOldExp + nExploit
        nOldExpV = nOldExpV + nExploit

        SetExploit(nOldExp)
        SetExploitV(nOldExpV)
    end

    AddTongRes(nResType + 1, nResCount, 2)

    SetTGuardTaskValue(guardindex, Res_Type, 0)
    SetTGuardTaskValue(guardindex, Res_Count, 0)
    if (nExploit > 0) then
        Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· nép " .. nResCount .. " tµi nguyªn, ®©y" .. nExploit .. " ®iÓm c«ng tr¹ng mµ ng­¬i xøng ®¸ng cã.")
        Msg2Player("Chóc mõng ng­¬i ®· nép " .. nResCount .. " tµi nguyªn, nhËn ®­îc " .. nExploit .. " ®iÓm c«ng tr¹ng")
        Msg2TongMemberByTongName(GetTongName(2), "<RoleName=\"" .. GetName() .. "\">nép thµnh c«ng " .. nResCount .. " tµi nguyªn, nhËn ®­îc " .. nExploit .. " ®iÓm c«ng tr¹ng.")
    else
        if (nResCount >= 50) then
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· nép " .. nResCount .. " tµi nguyªn, nh­ng h«m nay ®iÓm c«ng tr¹ng cña ng­¬i ®· ®¹t 20 ®iÓm th«ng qua nép tµi nguyªn, kh«ng thÓ t¨ng n÷a.")
            Msg2Player("Chóc mõng ng­¬i ®· nép " .. nResCount .. " tµi nguyªn.")
            Msg2TongMemberByTongName(GetTongName(2), "<RoleName=\"" .. GetName() .. "\">nép thµnh c«ng " .. nResCount .. " tµi nguyªn.")
        else
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· nép " .. nResCount .. " tµi nguyªn, ng¹i qu¸! Do kh«ng ®ñ 50, nªn kh«ng thÓ nhËn phÇn th­ëng ®iÓm c«ng tr¹ng.")
            Msg2Player("Chóc mõng ng­¬i ®· nép " .. nResCount .. " tµi nguyªn.")
            Msg2TongMemberByTongName(GetTongName(2), "<RoleName=\"" .. GetName() .. "\">nép thµnh c«ng " .. nResCount .. " tµi nguyªn.")
        end
    end
end

BUFF_FORBID_CHANGE_GENGS = 1097
BUFF_CONDEMN = 1098
BUFF_COWER = 1101
BUFF_SELECT = 1102
BUFF_CAREER = 1100
TASK_CHANGE_GENS = 1634

function changeGens()
    CloseDialog()
    if (IsTongMember(1) > 0) then
        Talk(1, "no", "Giê ng­¬i lµ mét thµnh viªn trong gia téc, ph¶i tho¸t khái gia téc míi cã thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (IsRegMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®· ®¨ng ký gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang ë tr¹ng th¸i æn ®Þnh, kh«ng thÓ tiÕn hµnh thao t¸c chuyÓn ®æi duÖ téc.")
        return
    end

    local thisNum = LoadIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num")
    local mixNum = 12
    for i = 1, 5 do
        local everyNum = LoadIniInteger("Postity" .. i, "Num")
        mixNum = math.min(everyNum, mixNum)
    end

    local nDiff = thisNum - mixNum
    if (nDiff >= 10) then
        Talk(1, "no", "DuÖ téc nµy qu¸ ®«ng, hiÖn kh«ng thÓ nhËn thªm thµnh viªn kh¸c.")
        return
    end

    local sName, Cv, Cfs = GetCostCoinInfoByIdx(147)
    if (GetTaskBit(TASK_CHANGE_GENS, 1) == 0) then
        MsgBox(" §©y lµ lÇn ®Çu tiªn ng­¬i chuyÓn ®æi duÖ téc, ng­¬i muèn chuyÓn ®æi kh«ng?", "confirmChange", "no")
    else
        MsgBox("Ng­¬i ®· chuyÓn ®æi duÖ téc, nh­ng nÕu ng­¬i cho ta 1 <c=yel>Ph¸t hoµng ®å phæ<c> hoÆc " .. Cfs .. " Th«ng B¶o, ta sÏ chuyÓn ®æi duÖ téc cho ng­¬i.", "confirmChange", "no")
    end
end

function confirmChange()
    CloseDialog()
    if (IsTongMember(1) > 0) then
        Talk(1, "no", "Giê ng­¬i lµ mét thµnh viªn trong gia téc, ph¶i tho¸t khái gia téc míi cã thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (IsRegMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®· ®¨ng ký gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang æn ®Þnh víi hiÖn tr¹ng, kh«ng thÓ tiÕn hµnh thao t¸c chuyÓn ®æi.")
        return
    end

    local thisNum = LoadIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num")
    local mixNum = 12
    for i = 1, 5 do
        local everyNum = LoadIniInteger("Postity" .. i, "Num")
        mixNum = math.min(everyNum, mixNum)
    end

    local nDiff = thisNum - mixNum
    if (nDiff >= 10) then
        Talk(1, "no", "DuÖ téc nµy qu¸ ®«ng, hiÖn kh«ng thÓ nhËn thªm thµnh viªn kh¸c.")
        return
    end

    local oldPoster = GetPosterityType()
    local sName, Cv, Cfs = GetCostCoinInfoByIdx(147)

    if (GetTaskBit(TASK_CHANGE_GENS, 1) == 0) then
        SetPosterityType(POSTERIRY_TYPE.SHAOHAO)
        SetTaskBit(TASK_CHANGE_GENS, 1, 1)
        AddIBBuff(BUFF_FORBID_CHANGE_GENGS)
    elseif (FindAValidIBItem(8, 1099, 2, 0) > 0) then
        CostIBItem(FindAValidIBItem(8, 1099, 2, 0))
        SetPosterityType(POSTERIRY_TYPE.SHAOHAO)
        AddIBBuff(BUFF_FORBID_CHANGE_GENGS)
    elseif (GetCoin() > Cv) then
        CostCoinByIdx(147)
        SetPosterityType(POSTERIRY_TYPE.SHAOHAO)
        AddIBBuff(BUFF_FORBID_CHANGE_GENGS)
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>Ph¸t hoµng ®å phæ<c> vµ kh«ng ®ñ Th«ng B¶o.")
        return
    end

    local oldNum = LoadIniInteger("Postity" .. oldPoster, "Num")
    local newNum = LoadIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num")
    oldNum = oldNum - 1
    if (oldNum < 0) then
        oldNum = 0
    end
    newNum = newNum + 1
    SaveIniInteger("Postity" .. oldPoster, "Num", oldNum)
    SaveIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num", newNum)
end

function aboutFamily()
    CloseDialog()

    local tasks = {
        { "LËp gia téc", "establishFamily"; show = 0 },
        { "Gia nhËp gia téc", "joinFamily"; show = 0 },
        { "Tho¸t khái gia téc", "quitFamily"; show = 0 },
        { "Hñy xin phÐp", "cancelRegister"; show = 0 },
        { "Téc tr­ëng nh­êng ng«i", "demise"; show = 0 },
        { "H­íng dÉn lËp gia téc", "shuoming"; show = 1 }
    }

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO and GetTaskByte(ZHUI, 3) == 6 and (IsTongMember(1) == 0)) then
        tasks[1].show = 1
        tasks[2].show = 1
    end

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO and IsTongMember(1) > 0) then
        tasks[3].show = 1
    end

    if (IsRegMember(1) > 0) then
        tasks[4].show = 1
    end

    if (IsTongMaster(1) > 0) then
        tasks[5].show = 1
    end

    SayTask("T¹i §éng Thiªn Phóc §Þa, mét th©n mét m×nh khã mµ tån t¹i, theo lý nªn mau chãng lËp gia téc.", tasks)
end

function isAllFit(nType)
    if (GetTeamSize() < 6) then
        Msg2Team("Thµnh viªn Ýt h¬n 6 ng­êi, kh«ng thÓ lËp gia téc.")
        return 0
    end

    local oldPlayer = PlayerIndex
    local nTeamSize = GetTeamSize()

    for i = 1, nTeamSize do
        PlayerIndex = GetTeamMember(i)
        if (GetTaskByte(ZHUI, 3) ~= 6) then
            Msg2Team(GetName() .. "VÉn ch­a hoµn thµnh nhiÖm vô Truy C¨n Tè Nguyªn.")
            PlayerIndex = oldPlayer
            return 0
        elseif (GetPosterityType() ~= nType) then
            Msg2Team(GetName() .. "Kh«ng ph¶i thµnh viªn cña DuÖ téc nµy.")
            PlayerIndex = oldPlayer
            return 0
        elseif (HaveIBBuff(BUFF_CAREER) > 0) then
            Msg2Team(GetName() .. "§ang trong tr¹ng th¸i §å M­u §¹i NghiÖp.")
            PlayerIndex = oldPlayer
            return 0
        elseif (HaveIBBuff(BUFF_COWER) > 0) then
            Msg2Team(GetName() .. "§ang trong tr¹ng th¸i tÊn tho¸i tïy c¬.")
            PlayerIndex = oldPlayer
            return 0
        elseif (IsTongMember(1) > 0) then
            Msg2Team(GetName() .. " ®· lµ thµnh viªn cña gia téc kh¸c")
            PlayerIndex = oldPlayer
            return 0
        elseif (IsRegMember(1) > 0) then
            Msg2Team(GetName() .. " ®· göi xin phÐp gia nhËp vµo gia téc kh¸c")
            PlayerIndex = oldPlayer
            return 0
        end
    end

    PlayerIndex = oldPlayer
    return 1
end

function establishFamily()
    CloseDialog()

    if (GetFamilyCountByPosterityType(POSTERIRY_TYPE.SHAOHAO) >= 10) then
        Talk(1, "no", "HiÖn t¹i ®· cã 10 gia téc trong duÖ téc, kh«ng thÓ lËp thªm gia téc.")
        return
    end

    if (IsCaptain() ~= 1) then
        Talk(1, "no", "LËp gia téc cÇn 6 thµnh viªn trong duÖ téc tæ ®éi, ®éi tr­ëng ®èi tho¹i víi ta.")
        return
    end

    if (isAllFit(POSTERIRY_TYPE.SHAOHAO) == 1) then
        MsgBox("B¹n muèn lËp gia téc?", "yes_establish", "no")
    end
end

function yes_establish()
    CloseDialog()
    if (GetFamilyCountByPosterityType(POSTERIRY_TYPE.SHAOHAO) >= 10) then
        Talk(1, "no", "HiÖn t¹i ®· cã 10 gia téc trong duÖ téc, kh«ng thÓ lËp thªm gia téc.")
        return
    end

    if (IsCaptain() ~= 1) then
        Talk(1, "no", "Mêi ®éi tr­ëng ®Õn ®èi tho¹i.")
        return
    end

    if (isAllFit(POSTERIRY_TYPE.SHAOHAO) == 1) then
        CreateTongDialog()
    end
end

function joinFamily()
    CloseDialog()
    if (IsTongMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®ang lµ thµnh viªn cña gia téc, kh«ng thÓ tham gia vµo gia téc kh¸c.")
        return
    end

    if (IsRegMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®· ®¨ng ký gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ gia nhËp vµo gia téc kh¸c.")
        return
    end

    if (HaveIBBuff(BUFF_COWER) > 0) then
        Talk(1, "no", "Thêi gian rêi khái gia téc tr­íc ch­a ®ñ 6 giê, kh«ng thÓ gia nhËp gia téc kh¸c.")
        return
    end

    AddTongDialog(POSTERIRY_TYPE.SHAOHAO, 1)
end

function quitFamily()
    CloseDialog()
    if (IsTongMaster(1) > 0) then
        Talk(1, "no", "Víi vai trß lµ mét téc tr­ëng kh«ng thÓ cã nh÷ng hµnh ®éng tïy tiÖn nh­ vËy.")
        return
    end

    if (IsTongMember(1) == 0) then
        Talk(1, "no", "Ng­¬i kh«ng ph¶i lµ thµnh viªn cña gia téc nµy.")
        return
    end

    MsgBox("Ng­¬i cã thËt sù muèn rêi khái gia téc nµy hay kh«ng?", "yes_quitFamily", "no")
end

function yes_quitFamily()
    CloseDialog()
    if (IsTongMaster(1) > 0) then
        Talk(1, "no", "Víi vai trß lµ mét téc tr­ëng kh«ng thÓ cã nh÷ng hµnh ®éng tïy tiÖn nh­ vËy.")
        return
    end

    if (IsTongMember(1) == 0) then
        Talk(1, "no", "Ng­¬i kh«ng ph¶i lµ thµnh viªn cña gia téc nµy.")
        return
    end

    Msg2Player("Ng­¬i ®· tho¸t khái gia téc.")
    Msg2TongMemberByTongName(GetTongName(1), GetName() .. "Tho¸t khái gia téc.")

    AddIBBuff(BUFF_COWER)
    LeaveTong(1)
end

function cancelRegister()
    MsgBox("Ng­¬i cã thËt muèn hñy ®¨ng ký gia nhËp gia téc?", "yes_cancel", "no")
end

function yes_cancel()
    CloseDialog()
    LeaveTong(1)
end

function isCanDemise()
    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "NÕu muèn thùc hiÖn viÖc nh­êng ng«i téc tr­ëng, 2 ng­êi ph¶i tæ ®éi ®Õn ®©y.")
        return 0
    end

    local oldPlayer = PlayerIndex
    PlayerIndex = GetTeamMember(1)
    local w1, x1, y1 = GetWorldPos()
    local familyName1 = GetTongName(1)
    local isMaster1 = IsTongMaster(1)

    PlayerIndex = GetTeamMember(2)
    local w2, x2, y2 = GetWorldPos()
    local familyName2 = GetTongName(1)
    local isMaster2 = IsTongMaster(1)
    PlayerIndex = oldPlayer

    if (familyName1 ~= familyName2) or (familyName1 == "") or (familyName2 == "") then
        Msg2Team("2 ng­êi ph¶i cïng mét gia téc.")
        return 0
    end

    if (w1 ~= w2) then
        Msg2Team("§ång ®éi cña ng­¬i kh«ng ë gÇn ®©y, kh«ng thÓ nh­êng ng«i.")
        return 0
    end

    if (isMaster1 == 0) and (isMaster2 == 0) then
        Msg2Team("Ph¶i cã téc tr­ëng tham gia míi cã thÓ nh­êng ng«i.")
        return 0
    end

    return 1
end

function demise()
    CloseDialog()

    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Ng­¬i lµ tr­ëng thÞ téc, kh«ng thÓ tïy tiÖn nh­êng ng«i téc tr­ëng cho ng­êi kh¸c.")
        return
    end

    if (isCanDemise() > 0) then
        local name1 = ""
        local name2 = ""
        local oldPlayer = PlayerIndex

        for i = 1, 2 do
            PlayerIndex = GetTeamMember(i)
            if (PlayerIndex > 0) then
                if (IsTongMaster(1) > 0) then
                    SetTeamTask(1, GetPlayerID())
                    name1 = GetName()
                else
                    SetTeamTask(2, GetPlayerID())
                    name2 = GetName()
                end
            end
        end

        PlayerIndex = oldPlayer
        MsgBox(" Ng­¬i muèn nh­êng ng«i cho " .. name2 .. " kh«ng?", "askMaster", "no")
    end
end

function askMaster()
    CloseDialog()
    if (isCanDemise() <= 0) then
        return
    end

    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Ng­¬i lµ tr­ëng thÞ téc, kh«ng thÓ tïy tiÖn nh­êng ng«i téc tr­ëng cho ng­êi kh¸c.")
        return
    end

    if (GetPlayerID() ~= GetTeamTask(1)) then
        return
    end

    local name1 = GetName()
    local oldPlayer = PlayerIndex
    if (oldPlayer == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end

    local player2 = PlayerIndex
    local playerID2 = GetPlayerID()
    local name2 = GetName()

    if (playerID2 ~= GetTeamTask(2)) then
        Msg2Team("Thµnh viªn trong ®éi cã sù thay ®æi")
        PlayerIndex = oldPlayer
        return
    end

    PlayerIndex = oldPlayer
    TeamAction("askPartner", player2, 0, 0)
end

function askPartner(player)
    if (player == PlayerIndex) then
        local oldPlayer = PlayerIndex

        if (oldPlayer == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end

        local name1 = GetName()
        PlayerIndex = oldPlayer

        MsgBox("Ng­¬i cã ®ång ý nhËn sù phã th¸c cña " .. name1 .. ", nhËn chøc vÞ téc tr­ëng?", "acceptDemise", "no")
    end
end

function acceptDemise()
    CloseDialog()
    if (isCanDemise() <= 0) then
        return
    end

    if (GetPlayerID() ~= GetTeamTask(2)) then
        return
    end

    local playerID2 = GetPlayerID()
    local name2 = GetName()

    local oldPlayer = PlayerIndex
    local player1 = 0

    if (oldPlayer == GetTeamMember(1)) then
        player1 = GetTeamMember(2)
    else
        player1 = GetTeamMember(1)
    end

    PlayerIndex = player1
    local playerID1 = GetPlayerID()
    local name1 = GetName()

    if (playerID1 ~= GetTeamTask(1)) then
        Talk(1, "no", " Thµnh viªn trong ®éi cã thay ®æi.")
        PlayerIndex = oldPlayer
        return
    end

    TongMasterDemise(name2, 1)
    Msg2Player("Ng­¬i ®· mÊt chøc vÞ téc tr­ëng")

    RemoveIBBuff(BUFF_SELECT)
    for i = 287, 291 do
        DelEventItem(i)
    end

    PlayerIndex = oldPlayer
    Msg2Player("NhËn ®­îc chøc vÞ téc tr­ëng")
    WriteLog(GetTongName(1) .. "L·nh ®Þa-" .. name1 .. " nh­êng ng«i cho " .. name2)
end

function shuoming()
    Talk(2, "no", "Muèn t¹i hiÖn sù huy hoµng cña bæn téc, tr­íc hÕt ph¶i lËp gia téc, ®Ó lËp gia téc cÇn 6 ng­êi ch¬i cïng duÖ téc tæ ®éi ®Õn ®¨ng ký, chó ý mçi duÖ téc tèi ®a chØ cã thÓ ®ång thêi tån t¹i 10 gia téc.", "NÕu muèn gia nhËp gia téc, chØ cÇn ®Õn chç ta ®¨ng ký, chó ý mçi gia téc tèi ®a chØ cã 12 thµnh viªn.")
    return
end

function aboutGens()
    CloseDialog()
    local tasks = {
        { "Trïng t¹o huy hoµng", "reBount"; show = 0 },
        { "Hñy trïng t¹o huy hoµng", "cancelBount"; show = 0 },
        { "Gia nhËp thÞ téc", "joinGens"; show = 0 },
        { "Tho¸t khái thÞ téc", "quitGens"; show = 0 },
        { "Tr­ëng thÞ téc nh­êng ng«i", "demiseGens"; show = 0 },
        { "H­íng dÉn lËp thÞ téc", "shuomingGens"; show = 1 }
    }

    if (IsTongMaster(1) > 0) and (IsTongMember(2) == 0) then
        tasks[1].show = 1
    end

    if (isAccept() == 1) then
        tasks[2].show = 1
    end

    if (IsTongMaster(1) > 0) and (IsTongMember(2) == 0) and (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) > 0) then
        tasks[3].show = 1
    end

    if (IsTongMaster(1) > 0) and (IsTongMember(2) == 1) and (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) > 0) then
        tasks[4].show = 1
    end

    if (IsTongMaster(2) == 1) then
        tasks[5].show = 1
    end

    SayTask("Muèn sinh tån t¹i §éng Thiªn Phóc §Þa, b­íc ®Çu tiªn ph¶i lËp gia téc, chØ khi lËp thÞ téc thµnh c«ng, míi cã thÓ t¸i hiÖn sù huy hoµng cña bæn téc.", tasks)
end

function reBount()
    CloseDialog()

    if (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) > 0) then


        local nCount = 0
        for i = 287, 291 do
            if (HaveEventItem(i) > 0) then
                DelEventItem(i)
                nCount = nCount + 1
            end
        end

        RemoveIBBuff(BUFF_SELECT)

        if (nCount >= 5) then
            local nOldExp = GetExploit()
            local nOldExpV = GetExploitV()
            nOldExp = nOldExp + 50
            nOldExpV = nOldExpV + 50
            SetExploit(nOldExp)
            SetExploitV(nOldExpV)
        end

        Talk(1, "no", "C¸c h¹ nªn t¹m vøt bá nh÷ng ©n o¸n c¸ nh©n, tranh thñ ®­a nh÷ng ng­êi trong gia téc gia nhËp vµo, ®ång t©m hiÖp lùc ®Èy m¹nh thÞ téc cña chóng ta t¹i §éng Thiªn Phóc §Þa nµy, t¸i hiÖn b¸ nghiÖp huy hoµng cña tiªn ®Õ!")
        TaskNote(1508, -1)
        return
    end

    if (GetExploitLevel() < 3) then
        Talk(1, "no", "NhËn nhiÖm vô <c=g>trïng t¹o huy hoµng<c>, c«ng tr¹ng cña téc tr­ëng ph¶i tõ cÊp <c=g>3<c> trë lªn.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", "NhËn nhiÖm vô <c=g>trïng t¹o huy hoµng<c>, gia téc kh«ng ®­îc Ýt h¬n <c=g>6<c> thµnh viªn.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang trong thêi gian chê chuyÓn ®æi duÖ téc, kh«ng thÓ nhËn nhiÖm vô nµy.")
        return
    end

    local flag = 1
    for i = 287, 291 do
        if (HaveEventItem(i) <= 0) then
            flag = 0
            break ;
        end
    end

    if (flag == 1) then
        if (CreateUnionTong("ThiÕu H¹o ThÞ Téc", "") > 0) then
            for i = 287, 291 do
                DelEventItem(i)
            end
        end

        RemoveIBBuff(BUFF_SELECT)

        local nOldExp = GetExploit()
        local nOldExpV = GetExploitV()
        nOldExp = nOldExp + 100
        nOldExpV = nOldExpV + 100
        SetExploit(nOldExp)
        SetExploitV(nOldExpV)

        Msg2Player("X©y dùng thÞ téc thµnh c«ng")
        Msg2TongMemberByTongName(GetTongName(1), "B¹n ®· trë thµnh thµnh viªn cña ThiÕu H¹o ThÞ Téc.")
        AddGlobalCountNews("Dòng sÜ kiÖt xuÊt cña ThiÕu H¹o ThÞ Téc" .. GetName() .. "QuyÕt t©m tu©n theo di huÊn tiªn ®Õ, l·nh ®¹o téc nh©n ThiÕu H¹o ThÞ Téc, t¸i hiÖn sù huy hoµng cña ThiÕu H¹o ThÞ Téc!", 3)
        TaskNote(1508, -1)
        return
    end

    if (HaveIBBuff(BUFF_SELECT) > 0) then
        Talk(1, "no", " Ng­¬i ®ang ë tr¹ng th¸i Thiªn TuyÓn Chi Nh©n, h·y mau ®i hoµn thµnh träng tr¸ch.")
        return
    end

    for i = 287, 291 do
        DelEventItem(i)
    end
    AddIBBuff(BUFF_SELECT)
    Talk(1, "no", "ÉÙê»ºóÒá: Ngµi nhËn ®­îc ÌìÑ¡Ö®ÈË×´Ì¬, ÔÚ¸Ã×´Ì¬ÏÂ´ò°Ü5ÖÖÌìÂ»ÉñÊÞ, µÃµ½ 5 c¸i ÌìÂ»ÉñÊÞµÄÁÛÆ¬¾Í¿ÉÒÔ½¨Á¢ÊÏ×åÁË.")
    TaskNote(1508, 0, "ThiÕu H¹o HËu DuÖ")
end

function isAccept()
    if (HaveIBBuff(BUFF_SELECT) > 0) then
        return 1
    end

    for i = 287, 291 do
        if (HaveEventItem(i) > 0) then
            return 1
        end
    end

end

function cancelBount()
    MsgBox("Ng­¬i x¸c nhËn muèn hñy bá nhiÖm vô Trïng t¹o huy hoµng lÇn nµy chø? Nh­ng sau khi hñy bá ng­¬i cã thÓ ®Õn gÆp ta nhËn l¹i nhiÖm vô.", "Yes_Cancel", "no")
end

function Yes_Cancel()
    CloseDialog()
    RemoveIBBuff(BUFF_SELECT)

    for i = 287, 291 do
        DelEventItem(i)
    end
    Msg2Player("§· hñy bá nhiÖm vô Trïng t¹o huy hoµng.")
    TaskNote(1508, -1)
end

function joinGens()
    CloseDialog()

    if (IsRegMember(2) > 0) then
        Talk(1, "no", " Ng­¬i ®· ®Ò nghÞ gia nhËp 1 thÞ téc, ®ang chê nghiÖm chøng.")
        return
    end

    if (GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO) >= 8) then
        Talk(1, "no", "Sè gia téc trong thÞ téc nµy ®· ®¹t møc tèi ®a, kh«ng thÓ kÕt n¹p gia téc míi.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", " Gia téc ch­a ®ñ 6 ng­êi, kh«ng thÓ gia nhËp thÞ téc.")
        return
    end

    MsgBox(" Ng­¬i muèn gia nhËp gia téc vµo thÞ téc nµy chø?", "yes_joinGens", "no")
end

function yes_joinGens()
    CloseDialog()

    if (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) <= 0) then
        Talk(1, "no", " DuÖ téc nµy kh«ng cã thÞ téc")
        return
    end

    if (IsTongMaster(1) == 0) then
        Talk(1, "no", " ChØ cã téc tr­ëng míi cã thÓ l·nh ®¹o gia téc gia nhËp thÞ téc")
        return
    end

    if (IsTongMember(2) == 1) then
        Talk(1, "no", " Ng­¬i ®· gia nhËp 1 thÞ téc, kh«ng thÓ gia nhËp thÞ téc kh¸c n÷a.")
        return
    end

    if (IsRegMember(2) > 0) then
        Talk(1, "no", " Ng­¬i ®· ®Ò nghÞ gia nhËp 1 thÞ téc, ®ang chê nghiÖm chøng.")
        return
    end

    if (GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO) >= 8) then
        Talk(1, "no", "Sè gia téc trong thÞ téc nµy ®· ®¹t møc tèi ®a, kh«ng thÓ kÕt n¹p gia téc míi.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", " Gia téc ch­a ®ñ 6 ng­êi, kh«ng thÓ gia nhËp thÞ téc.")
        return
    end

    JoinUnionTong(POSTERIRY_TYPE.SHAOHAO)
    Msg2Player("Ng­¬i ®· ®Ò nghÞ gia nhËp ThiÕu H¹o ThÞ Téc")
    Msg2TongMemberByTongName(GetTongName(1), "Téc tr­ëng ®· yªu cÇu gia nhËp thÞ téc")
end

function quitGens()
    CloseDialog()
    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Tr­ëng ThÞ téc kh«ng thÓ rêi khái thÞ téc")
        return
    end

    if (IsTongMember(2) == 0) then
        Talk(1, "no", "ThiÕu H¹o HËu DuÖ:Ng­¬i kh«ng ph¶i thµnh viªn thÞ téc nµy.")
        return
    end

    if (IsTongMaster(1) <= 0) then
        Talk(1, "no", "ChØ téc tr­ëng míi cã quyÒn h¹n l·nh ®¹o téc nh©n rêi khái thÞ téc")
        return
    end

    MsgBox("Ng­¬i muèn rêi khái thÞ téc nµy chø?", "yes_quitGens", "no")
end

function yes_quitGens()
    CloseDialog()
    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Tr­ëng ThÞ téc kh«ng thÓ rêi khái thÞ téc")
        return
    end

    if (IsTongMember(2) == 0) then
        Talk(1, "no", "ThiÕu H¹o HËu DuÖ:Ng­¬i kh«ng ph¶i thµnh viªn thÞ téc nµy.")
        return
    end

    if (IsTongMaster(1) <= 0) then
        Talk(1, "no", "ChØ téc tr­ëng míi cã quyÒn h¹n l·nh ®¹o téc nh©n rêi khái thÞ téc")
        return
    end

    LeaveUnionTong()
end

function isCanDemiseGens()
    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "NÕu muèn thùc hiÖn nh­êng ng«i Tr­ëng ThÞ téc, 2 ng­êi ph¶i tæ ®éi ®Õn ®©y.")
        return 0
    end

    local oldPlayer = PlayerIndex
    PlayerIndex = GetTeamMember(1)
    local w1, x1, y1 = GetWorldPos()
    local familyName1 = GetTongName(2)
    local isMasterGens1 = IsTongMaster(2)
    local isMasterFamily1 = IsTongMaster(1)

    PlayerIndex = GetTeamMember(2)
    local w2, x2, y2 = GetWorldPos()
    local familyName2 = GetTongName(2)
    local isMasterGens2 = IsTongMaster(2)
    local isMasterFamily2 = IsTongMaster(1)
    PlayerIndex = oldPlayer

    if (familyName1 ~= familyName2) or (familyName1 == "") or (familyName2 == "") then
        Msg2Team("2 ng­êi ph¶i cïng thÞ téc.")
        return 0
    end

    if (w1 ~= w2) then
        Msg2Team("§ång ®éi cña b¹n kh«ng ë gÇn ®©y, kh«ng thÓ tiÕn hµnh nh­êng ng«i Tr­ëng ThÞ téc.")
        return 0
    end

    if (isMasterGens1 == 0) and (isMasterGens2 == 0) then
        Msg2Team("Ph¶i cã Tr­ëng ThÞ téc tham gia míi cã thÓ nh­êng ng«i.")
        return 0
    end

    if ((isMasterGens1 == 1) and (isMasterFamily2 == 0)) or ((isMasterGens2 == 1) and (isMasterFamily1 == 0)) then
        Msg2Team("Ng­êi ®­îc nh­êng ng«i ph¶i lµ téc tr­ëng.")
        return 0
    end

    return 1
end

function demiseGens()
    CloseDialog()
    if (isCanDemiseGens() > 0) then
        local name1 = ""
        local name2 = ""
        local oldPlayer = PlayerIndex

        for i = 1, 2 do
            PlayerIndex = GetTeamMember(i)
            if (PlayerIndex > 0) then
                if (IsTongMaster(2) > 0) then
                    SetTeamTask(1, GetPlayerID())
                    name1 = GetName()
                else
                    SetTeamTask(2, GetPlayerID())
                    name2 = GetName()
                end
            end
        end

        PlayerIndex = oldPlayer
        MsgBox(" Ng­¬i muèn nh­êng ng«i cho " .. name2 .. " kh«ng?", "askMasterGens", "no")
    end
end

function askMasterGens()
    CloseDialog()
    if (isCanDemiseGens() <= 0) then
        return
    end

    if (GetPlayerID() ~= GetTeamTask(1)) then
        return
    end

    local name1 = GetName()
    local oldPlayer = PlayerIndex
    if (oldPlayer == GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(2)
    else
        PlayerIndex = GetTeamMember(1)
    end

    local player2 = PlayerIndex
    local playerID2 = GetPlayerID()
    local name2 = GetName()

    if (playerID2 ~= GetTeamTask(2)) then
        Msg2Team("Thµnh viªn trong ®éi cã sù thay ®æi")
        PlayerIndex = oldPlayer
        return
    end

    PlayerIndex = oldPlayer
    TeamAction("askPartnerGens", player2, 0, 0)
end

function askPartnerGens(player)
    if (player == PlayerIndex) then

        local oldPlayer = PlayerIndex
        if (oldPlayer == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end

        local name1 = GetName()
        PlayerIndex = oldPlayer
        MsgBox(" " .. name1 .. "QuyÕt ®Þnh ®em träng tr¸ch cña bæn thÞ téc ñy th¸c cho ng­¬i, ®ång ý tiÕp nhËn chø?", "acceptDemiseGens", "no")
    end
end

function acceptDemiseGens()
    CloseDialog()
    if (isCanDemiseGens() <= 0) then
        return
    end

    if (GetPlayerID() ~= GetTeamTask(2)) then
        return
    end

    local playerID2 = GetPlayerID()
    local name2 = GetName()

    local oldPlayer = PlayerIndex
    local player1 = 0

    if (oldPlayer == GetTeamMember(1)) then
        player1 = GetTeamMember(2)
    else
        player1 = GetTeamMember(1)
    end

    PlayerIndex = player1
    local playerID1 = GetPlayerID()
    local name1 = GetName()

    if (playerID1 ~= GetTeamTask(1)) then
        Talk(1, "no", " Thµnh viªn trong ®éi cã thay ®æi.")
        PlayerIndex = oldPlayer
        return
    end

    TongMasterDemise(name2, 2)
    Msg2Player("§· mÊt chøc vÞ Tr­ëng ThÞ téc")

    PlayerIndex = oldPlayer
    Msg2Player("NhËn ®­îc chøc vÞ Tr­ëng ThÞ téc")

    WriteLog(GetTongName(2) .. "L·nh ®Þa-" .. name1 .. " nh­êng ng«i cho " .. name2)

    local warPower = GetUnionTongWarPower()
    if (warPower > 200) then
        ModifyUnionTongWarPower(200)
    end
end

function shuomingGens()
    Talk(1, "no", "Muèn thµnh lËp thÞ téc, cÇn téc tr­ëng ®Õn, l·nh ®¹o téc nh©n hoµn thµnh nhiÖm vô Trïng t¹o huy hoµng, míi cã thÓ trïng kiÕn thÞ téc nµy.")
end

function zhanqi()
    MsgBox("Ng­¬i muèn mua ChiÕn Kú ThÞ Téc chø?", "zhanqi_yes", "no")
end

function zhanqi_yes()

    if (IsHaveTongRight(13, 2) < 1) then
        Talk(1, "no", "Ng­¬i kh«ng cã quyÒn h¹n qu©n sù cña thÞ téc, kh«ng thÓ mua ChiÕn Kú ThÞ Téc.")
        return
    end

    local num
    for i = 2, 6 do
        num = GetTongRes(i, 2)
        if (num < 300) then
            Talk(1, "no", "Tµi nguyªn thÞ téc kh«ng ®ñ, kh«ng thÓ mua ChiÕn kú.")
            return
        end
    end

    for i = 2, 6 do
        WasteTongRes(i, 300, 2)
    end

    AddNormalItem(3, 1069, 0, 0, 0, 0)

    Talk(1, "no", "Ng­¬i ®· mua 1 ChiÕn Kú ThÞ Téc.")
end

function build()
    CloseDialog()
    OpenCityTechDialog(2, 1)
end

