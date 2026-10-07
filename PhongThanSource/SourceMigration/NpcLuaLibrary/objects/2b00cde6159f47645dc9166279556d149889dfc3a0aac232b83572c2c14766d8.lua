--description: ¿ç·ş-×åÒá¹ÜÊÂ
--author: Huangbin
--date: 2009/10/21

ZHUI = 1592    --ÈÎÎñ±äÁ¿,3byteÈÎÎñ²½Öè£¬2byteÊÇ·ñÈ¥¹ıÎå+Èı¡£
NOTE = 1500        --TASKINFO

--> ÊÏ×åÑ­»· Add By yangtao Start 2009/11/5
Task_ibyq = 1613    -- ¼ÍÂ¼IBµÀ¾ß¹ºÂòµÄÔªÆøÖµ£¬²»ÄÜÖØÖÃ
Task_yq = 1614    -- 1byte:ÔªÆøÖµÊ±¼ä´Á
-- 2byte:Íæ¼Òµ±ÌìÒÑ¾­Ê¹ÓÃµÄÔªÆøÖµ
-- 3byte:ÏµÍ³Ã¿ÌìÖØÖÃµÄÔªÆøÖµ
Task_szxh = 1615    -- 1byte:ÈÎÎñ½ø¶È 0Î´ÁìÈÎÎñ 1ÒÑ¾­ÁìÈ¡ 2ÒÑ¾­»ñµÃÊÏ×å±¦²Ø 3ÈÎÎñ½áÊø
-- 2byte:Ó¦¸ÃÇ°ÍùµÄ¸£µØ±àºÅ
-- 3byte:Ê±¼ä´Á
-- 4byte:õùõ÷µÄ²Ø±¦Í¼ÈÎÎñ½ø¶È 0ÎŞÈÎÎñ 1ÒÑ¾­µÃµ½²Ø±¦Í¼ 2ÒÑ¾­ÍÚµ½±¦²Ø
Task_szbzxy = 1616    -- 1word:±¦²Øx×ø±ê 2word:±¦²Øy×ø±ê
Task_szbzdis = 1617    -- ´æ´¢ÉÏ´Î²é¿´Ê±Óë±¦²ØµØµãµÄ¾àÀë
Family_szxh = 21    -- 1byte:ÊÏ×åÊ±¼ä´Á
-- 2byte:¸£µØË÷Òı
TaskNote_szxh = 1503    -- ÊÏ×åÑ­»·ÈÎÎñtaskinfo±àºÅ
--< ÊÏ×åÑ­»· Add By yangtao End 2009/11/5

--> add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-6
gTaskGlobalRand = 269    -- 1byte: date 2byte:randvalue Ëæ»úÖµ  3byte:Í¨¹ıÉ±ËÀÏ¸×÷»ñµÃÊÏ×å×ÊÔ´µÄÊıÄ¿
gTaskItem = { 3, 1061, 0, 0, 0, 0 }
gTotemInfo = {
    [1] = { name = "X¸c vËt tæ-Kim", x = 215, y = 212, res = "Th­íc Kim Sa" },
    [2] = { name = "X¸c vËt tæ-Méc", x = 280, y = 232, res = "UÊt Méc Chi" },
    [3] = { name = "X¸c vËt tæ-Háa", x = 258, y = 249, res = "Xİch Háa Th¹ch" },
    [4] = { name = "X¸c vËt tæ-Thñy", x = 248, y = 210, res = "ThiÖn Thñy Tinh" },
    [5] = { name = "X¸c vËt tæ-Thæ", x = 221, y = 250, res = "Kh«i Thæ Nham" },
}


--Task_qz=1888   --Byte1 1£ºÇ°ÖÃÈÎÎñÊ±¼ä £¬  Byte2£º1 Íê³ÉÇ°ÖÃÈÎÎñ
Task_qz = 24   -- ÊÏ×å±äÁ¿ Byte1 1£ºÇ°ÖÃÈÎÎñÊ±¼ä £¬  Byte2£º1 Íê³ÉÇ°ÖÃÈÎÎñ

Task_rw = 1619    --Byte1 1£º½ÓÈÎÎñ£¬2£ºÈÎÎñÕÙ»½³öÏ¸×÷£¬3£ºÍê³ÉÈÎÎñ  Byte2 :¼ÇÂ¼½±ÀøÎïÆ·ĞÒÔËÖµ  3byte:Ê±¼ä´Á
task_lingxi = { 10, 5 }--³õÊ¼¸ÅÂÊÎª1%£¬Ã¿¶àÍê³ÉÒ»´ÎÈÎÎñ£¬Èç¹ûÃ»ÓĞ»ñµÃ¸ÃÎïÆ·£¬Ôò¸ÅÂÊÔö³¤0.5%
Task_snzxy = 1620    -- 1word :Ï¸×÷x×ø±ê 2word:Ï¸×÷y×ø±ê
Task_snjuli = 1621    -- ´æ´¢ÉÏ´Î²é¿´Ê±Óë Ï¸×÷ µØµãµÄ¾àÀë
--< add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-6

POSTERIRY_TYPE = {
    FUXI = 1, SHENNONG = 2, XUANYUAN = 3, SHAOHAO = 4, ZHUANXU = 5
}

function GetPlayerTaskState()
    return 0, 0
end

function main()

    local tasks = {
        { "Truy C¨n Tè Nguyªn", "zhuigen"; show = 0 },
        --> ÊÏ×åÑ­»· Add By yangtao Start 2009/11/5
        { "§¹o B¶o Tú H­u", "shizuxh_show"; show = 1 },
        --< ÊÏ×åÑ­»· Add By yangtao End 2009/11/5
        --> add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-6
        { "VËt tæ T©m Linh", "aboutGensRenwu"; show = 1 },
        --< add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-6
        --> add by longxian for ĞÄÁéÍ¼ÌÚ at 09-11-6
        --		{"³Í¼é³ı¶ñ","renwu1";show=1},
        --> add by longxian for ĞÄÁéÍ¼ÌÚ at 09-11-6
        { "§o¹t tµi nguyªn", "RobRes"; show = 0 },
        --< add by Gaojingwei end 2009/11/10
        --		{"¸Ä»»ÃÅÍ¥", "changeGens"; show = 0},
        --		{"¼Ò×åËµÃ÷", "aboutFamily"; show = 0},
        --		{"ÊÏ×åËµÃ÷", "aboutGens"; show = 0},
        { "VÒ DuÖ téc", "introduction"; show = 1 },
        --> ¶´ÌìÕù¶áÕ½ Add By yangtao Start 2009/11/17
        --		{"¹ºÂòÕ½Æì","zhanqi";show = 0},
        --< ¶´ÌìÕù¶áÕ½ Add By yangtao End 2009/11/17
        --> ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang Start 2009/12/9
        --		{"Õ½±¸Éú²ú","build";show = 0},
        --< ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang End 2009/12/9
        { "VÒ chiÕn tranh", "readiness"; show = 0 },

    }
    if (GetTaskByte(ZHUI, 3) == 1) then
        --¼ÓÈë×åÒá£¬²»ÏÔÊ¾
        tasks[1].show = 1
    end

    --> add by Gaojingwei start 2009/11/10
    --×ÊÔ´ÇÀ¶á
    local H, M, S = GetHMS()
    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) and (IsTongMember(2) > 0) then
        tasks[6].show = 1
        if (H >= 20) and (H <= 21) or (H == 22 and M <= 30) then
            tasks[4].show = 1
        end
    end

    --¸Ä»»ÃÅÍ¥
    --	if ( GetPosterityType() > 0 and GetPosterityType() ~= POSTERIRY_TYPE.SHAOHAO and IsTongMember(1) == 0) then
    --		tasks[6].show = 1
    --	end

    --¼Ò×åÊÏ×åËµÃ÷
    --	if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) then
    --		tasks[6].show = 1
    --	end

    --ÊÏ×åËµÃ÷
    --	if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO and IsTongMaster(1) > 0) then
    --		tasks[8].show = 1
    --	end
    --< add by Gaojingwei end 2009/11/10

    --> ¶´ÌìÕù¶áÕ½ Add By yangtao Start 2009/11/17
    --	local shizu = GetPosterityType()
    --	if(shizu == 4) then
    --		tasks[9].show = 1	Õ½Æì
    --	end
    --< ¶´ÌìÕù¶áÕ½ Add By yangtao End 2009/11/17

    --> ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang Start 2009/12/9
    --	if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) then
    --		tasks[7].show = 1
    --	end
    --< ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang End 2009/12/9


    if ((GetTaskByte(ZHUI, 3) == 6) and IsTongMember(1) <= 0) then
        SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Şa t¹o sù nghiÖp, tèt nhÊt nªn lËp ®éi ngò hoÆc gia nhËp gia téc.", tasks)
    elseif (GetTaskByte(ZHUI, 3) == 0) then
        Talk(1, "no", "TiÓu anh hïng h·y mau ®i t×m <c=g>H·n Thanh Th­ Gi¶<c> ®Ó t×m hiÓu vÒ duÖ téc cña m×nh.")
    else
        SayTask("Theo truyÒn thuyÕt, ThÇn N«ng hä Kh­¬ng, th­êng nÕm b¸ch th¶o ®Ó t×m d­îc liÖu cøu ng­êi.", tasks)
    end
end;

function introduction()
    CloseDialog()
    local tasks = {
        { "Qu¶n lı gia téc", "aboutFamily"; show = 0 },
        { "Qu¶n lı thŞ téc", "aboutGens"; show = 0 },
        { "ChØnh lı m«n ®×nh", "changeGens"; show = 0 },
    }

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) then
        tasks[1].show = 1
    end

    if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO and IsTongMaster(1) > 0) then
        tasks[2].show = 1
    end
    --¸Ä»»ÃÅÍ¥
    if (GetPosterityType() > 0 and GetPosterityType() ~= POSTERIRY_TYPE.SHAOHAO) then
        tasks[3].show = 1
    end
    SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Şa t¹o sù nghiÖp, gia téc vµ thŞ téc chİnh lµ bİ quyÕt ®Ó sinh tån ë §éng Thiªn Phóc §Şa.", tasks)
end

function readiness()
    local taskin = {
        { "Mua ChiÕn kú", "zhanqi"; show = 1 },
        --< ¶´ÌìÕù¶áÕ½ Add By yangtao End 2009/11/17
        --> ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang Start 2009/12/9
        { "S¶n xuÊt chiÕn bŞ", "build"; show = 1 },
    }
    SayTask("Mét m×nh ®¬n ®éc, rÊt khã ®Õn §éng Thiªn Phóc §Şa t¹o sù nghiÖp, gia téc vµ thŞ téc chİnh lµ bİ quyÕt ®Ó sinh tån ë §éng Thiªn Phóc §Şa.", taskin)
end

--> add by longxian for ³Í¼é³ı¶ñ at 09-11-9
function aboutGensRenwu()

    local tasks = {
        { "Trïng t¹o VËt tæ", "hearttotem"; show = 1 },
        { "Trõng gian diÖt ¸c", "renwu1"; show = 1 },

    }
    SayTask("Theo truyÒn thuyÕt, ThÇn N«ng hä Kh­¬ng, th­êng nÕm b¸ch th¶o ®Ó t×m d­îc liÖu cøu ng­êi.", tasks)
end

function renwu1()
    -- if (IsTongMember() <= 0) then
    -- 	Talk(1,"no","Äú²¢Ã»ÓĞ¼ÓÈë±¾ÊÏ×å¡£")
    -- 	return
    -- end
    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng ph¶i ng­êi cña duÖ téc ta, ta kh«ng thÓ gióp ng­¬i.")
        return
    end
    --> add  by yangyankun at 09-11-11
    if (IsTongMember(2) < 1) then
        Talk(1, "no", "Ng­¬i ch­a gia nhËp thŞ téc nµy, kh«ng cã t­ c¸ch ®¶m ®­¬ng nhiÖm vô khã kh¨n nh­ vËy.")
        return
    end
    -- ÅĞ¶ÏÈÎÎñÊÇ·ñ¸ôÌìÖØÖÃÈÎÎñ
    local today_szxh = mod(floor(LocalSystemTime() / 86400), 255) + 1
    local lastday_szxh = GetTaskByte(Task_rw, 3)
    if (today_szxh ~= lastday_szxh) then
        local progress_last = GetTaskByte(Task_rw, 1)
        if ((progress_last ~= 0)) then

            SetTaskWord(Task_snzxy, 1, 0)   --X×ø±êÇå0
            SetTaskWord(Task_snzxy, 2, 0)   --Y×ø±êÇå0
            SetTaskByte(Task_rw, 1, 0)      --ÈÎÎñ±äÁ¿ÇåÁã
            SetTaskByte(Task_snjuli, -1)  --¼ÇÂ¼¾àÀë
            ClearItem(6, 1, 759, 0)  --É¾³ıÖ¸ÒıÍ¼ °üÀ¨ ¿ì½İÀ¸ºÍ²Ö¿âÖĞ
            TaskNote(1505, -1)

            ScrollMessage("NhiÖm vô h«m qua cña ng­¬i ch­a hoµn thµnh ®· quay l¹i tõ ®Çu")
        end
        SetTaskByte(Task_rw, 3, today_szxh)
    end

    resetyqz()                -- ÔªÆøÖµµÄ¹ıÌìÖØÖÃ

    no()
    --local lastday 	= GetTaskByte(Task_yq, 1)
    --local today	= mod(floor(LocalSystemTime()/86400), 255) + 1
    --if(lastday ~= today) then					-- ¹ıÌì£¬ĞèÒªÖØÖÃÔªÆøÖµ
    --local yqz_chongzhi = yqz_chongzhi()					-- ĞèÒªĞŞ¸ÄÏà¹Øº¯Êı

    --SetTaskByte(Task_yq, 1, today)
    --SetTaskByte(Task_yq, 2, 0)
    --SetTaskByte(Task_yq, 3, yqz_chongzhi)
    --end

    renwupangd()
end

function renwupangd()
    -- if (IsTongMember() <= 0) then
    -- 	Talk(1,"no","Äú²¢Ã»ÓĞ¼ÓÈë±¾ÊÏ×å¡£")
    -- 	return
    -- end
    no()
    --	local qztime=GetTaskByte(Task_qz,1)  --È¡ĞÄÁéÍ¼ÌÚµÄÍê³ÉÊ±¼ä		-- modify by yangyankun at 09-11-11
    local qztime = GetByte(GetTongTask(Task_qz, 2), 1)  --È¡ĞÄÁéÍ¼ÌÚµÄÍê³ÉÊ±¼ä

    local today = mod(floor(LocalSystemTime() / 86400), 255) + 1
    --	if ( (qztime~=today)or (GetTaskByte(Task_qz,2)~=1) ) then
    if ((qztime ~= today) or (GetByte(GetTongTask(Task_qz, 2), 2) ~= 1)) then
        -- modify by yangyankun at 09-11-11
        Talk(1, "no", "Ch­a tu söa xong VËt tæ T©m Linh, ThŞ téc sÏ ch­a ®­îc khai më t©m linh. Lßng ng­êi khã ®o¸n, lµm sao biÕt ®­îc ai lµ b»ng h÷u, ai kÎ gian tµ?")
        Msg2Player("ThŞ téc cña b¹n vÉn ch­a hoµn thµnh nhiÖm vô trïng t¹o VËt tæ, kh«ng thÓ t×m ®­îc n¬i Èn th©n cña bän gian tÆc")
        return

    end

    local yqz_xiaohao = GetTaskByte(Task_yq, 2)
    if (yqz_xiaohao >= yqz_chongzhi() * 2) then
        Talk(1, "no", "H«m nay tiªu hao qu¸ nhiÒu nguyªn khİ, ngµy mai h·y ®Õn nhĞ")
        return
    end

    -- ¸ù¾İÔªÆøÖµÇé¿ö¸ü¸ÄÏµÍ³·ÖÅäµÄÔªÆøÖµºÍibµÀ¾ß²úÉúµÄÔªÆøÖµ

    if (GetTaskByte(Task_rw, 1) == 0) then
        --local yqz = yuanqizhi()
        local yqz = GetTransWarTaskPower()
        if (yqz >= 3) then

            MsgBox("HiÖn t¹i ng­¬i cã <c=g>" .. yqz .. "<c> ®iÓm nguyªn khİ, mçi lÇn nhËn nhiÖm vô Trõng gian diÖt ¸c sÏ khÊu trõ=g>3<c> ®iÓm nguyªn khİ. §ång ı chø?", "renwubegin", "no")
        else
            Talk(1, "no", "NhiÖm vô nµy sÏ hao tæn nguyªn khİ, nguyªn khİ cña ng­¬i kh«ng ®ñ 3 ®iÓm, h·y ®i tÜnh luyÖn thªm.")
            return
        end


    elseif (GetTaskByte(Task_rw, 1) == 1 or GetTaskByte(Task_rw, 1) == 2) then
        MsgBox("Gian tÕ Èn trèn rÊt tinh vi, ng­¬i h·y theo h­íng dÉn cña ChØ DÉn §å t×m n¬i Èn cña chóng. Nh­ng nÕu nh­ ng­êi phe ®Şch cøu ®­îc Gi¸n §iÖp mang ®i, th× ng­¬i ph¶i hñy bá nhiÖm vô. Muèn hñy bá nhiÖm vô sao?", "yes_quxiao", "no")

    elseif (GetTaskByte(Task_rw, 1) == 3) then
        local Exploit = GetExploit()
        local ExploitV = GetExploitV()
        SetExploit(Exploit + 20)
        SetExploitV(ExploitV + 20)
        Talk(1, "no", "Chóc mõng ng­¬i hoµn thµnh nhiÖm vô, xøng ®¸ng nhËn ®­îc 20 ®iÓm tİch lòy C«ng tr¹ng vµ 20 §iÓm c«ng tr¹ng.")
        Msg2Player("B¹n nhËn ®­îc 20 ®iÓm tİch lòy C«ng tr¹ng vµ 20 §iÓm c«ng tr¹ng.")
        SetTaskWord(Task_snzxy, 1, 0)   --X×ø±êÇå0
        SetTaskWord(Task_snzxy, 2, 0)   --Y×ø±êÇå0
        SetTaskByte(Task_rw, 1, 0)      --ÈÎÎñ±äÁ¿ÇåÁã
        SetTaskByte(Task_snjuli, -1)  --¼ÇÂ¼¾àÀë
        TaskNote(1505, -1)
        local nLuckyNum = GetTaskByte(Task_rw, 2)
        local rluck = random(1, 1000)
        if (nLuckyNum == 0) then
            nLuckyNum = task_lingxi[1]
            SetTaskByte(Task_rw, 2, nLuckyNum)
        end

        local str1 = ""
        if (rluck <= nLuckyNum) then
            AddNormalItem(3, 1058, 0, 0, 0, 0) --»ñµÃ½±Àø
            SetTaskByte(Task_rw, 2, task_lingxi[1])
            Msg2Player("Chóc mõng b¹n may m¾n nhËn ®­îc 1 m¶nh Lam Thñy tinh ThÇn Hùu.")
            TopMessage("NhËn ®­îc 1 m¶nh Lam Thñy tinh ThÇn Hùu")
            str1 = "Ngoµi ra cßn tÆng thªm 1 <c=yel>m¶nh Lam Thñy tinh ThÇn Hùu<c>, nã sÏ gióp ng­¬i th¨ng cÊp trang bŞ, "
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> hoµn thµnh nhiÖm vô t×m Gi¸n §iÖp, ®­îc hËu duÖ thŞ téc tÆng <c=r>1 m¶nh Lam Thñy tinh ThÇn Hùu<c>. Xin chóc mõng!", 20)
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
    --local yqz = yuanqizhi()
    local yqz = GetTransWarTaskPower()
    if (HaveNormalItem(3, 1020, 0, 0) >= 1) and (yqz >= 3) then
        --ÅĞ¶ÏÔªÆøÖµ ºÍ ÉíÉÏÎïÆ·		-- useful info


        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Ng­¬i ph¶i dïng ChØ DÉn §å cña ta míi cã thÓ t×m thÊy Gi¸n §iÖp. Hµnh trang cña ng­¬i ®Çy råi, kh«ng thÓ nhËn ChØ DÉn §å.")
            return
        end
        --É¾³ıÔªÆøµãÊı
        DelNormalItem(3, 1020, 0, 0)
        --local yqz_xitong 	= GetTaskByte(Task_yq, 3)
        --local yqz_ib		= GetTask(Task_ibyq)

        --if(yqz_xitong >= 3) then
        --yqz_xitong = yqz_xitong - 3
        --SetTaskByte(Task_yq, 3, yqz_xitong)
        --else
        --SetTaskByte(Task_yq, 3, 0)
        --yqz_ib = yqz_ib - (3 - yqz_xitong)
        --SetTask(Task_ibyq, yqz_ib)
        --end
        ModifyTransWarTaskPower(-3)

        AddNormalItem(6, 1, 759, 0, 0, 0)  --»ñµÃÖ¸ÒıÍ¼
        Msg2Player("B¹n nhËn ®­îc ChØ DÉn §å.")
        local num = random(1, 8)
        SetTaskWord(Task_snzxy, 1, maps[num].x)   --¼ÇÂ¼X×ø±ê
        SetTaskWord(Task_snzxy, 2, maps[num].y)   --¼ÇÂ¼Y×ø±ê
        SetTaskByte(Task_rw, 1, 1)
        SetTaskByte(Task_snjuli, -1)  --¼ÇÂ¼¾àÀë

        Talk(1, "no", "Ng­¬i ®· nhËn nhiÖm vô, nhËn ®­îc ChØ DÉn §å. ChØ DÉn §å cã thÓ chØ ng­¬i ®Õn n¬i Èn n¸u cña bän Gi¸n §iÖp! Nh­ng chØ khi ng­¬i hoÆc ®ång ®éi cña ng­¬i b¾t ®­îc chóng, th× míi th¾ng lîi hoµn thµnh nhiÖm vô. Chó ı: Gi¸n §iÖp chØ xuÊt hiÖn trong thêi gian ng¾n.")
        TaskNote(1504, 0)        -- add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-10
        TaskNote(1504, -1)
        return

    elseif (HaveNormalItem(3, 1020, 0, 0) == 0) then
        Talk(1, "no", " Gian tÕ Èn trèn rÊt tinh vi, cÇn cã 1 Tinh Hoa Nh©n Hån míi cã thÓ dô chóng xuÊt hiÖn, tiÕc qu¸ ng­¬i kh«ng cã ®ñ nguyªn liÖu, kh«ng thÓ nhËn nhiÖm vô.")
        return
    elseif (yqz < 3) then
        Talk(1, "no", "NhiÖm vô nµy sÏ hao tæn nguyªn khİ, nguyªn khİ cña ng­¬i kh«ng ®ñ 3 ®iÓm, h·y ®i tÜnh luyÖn thªm.")
        return
    end
end

function yes_quxiao()
    no()
    Talk(1, "no", "Ng­¬i ®· hñy bá nhiÖm vô")
    Msg2Player("Ng­¬i ®· hñy nhiÖm vô")
    SetTaskWord(Task_snzxy, 1, 0)   --X×ø±êÇå0
    SetTaskWord(Task_snzxy, 2, 0)   --Y×ø±êÇå0
    SetTaskByte(Task_rw, 1, 0)      --ÈÎÎñ±äÁ¿ÇåÁã
    SetTaskByte(Task_snjuli, -1)  --¼ÇÂ¼¾àÀë
    ClearItem(6, 1, 759, 0)  --É¾³ıÖ¸ÒıÍ¼ °üÀ¨ ¿ì½İÀ¸ºÍ²Ö¿âÖĞ
    TaskNote(1505, -1)
    local MstIdx = GetTask(1636) --Ï¸×÷IDX
    local OwnID = GetNpcTask(MstIdx, 1)
    if (OwnID == GetPlayerID()) then
        DelNpc(MstIdx)
    end
end

function yuanqizhi()
    local yqz = GetTask(Task_ibyq) + GetTaskByte(Task_yq, 3)

    return yqz
end



--< add by longxian for ³Í¼é³ı¶ñ at 09-11-9

--> add by yangyankun for ĞÄÁéÍ¼ÌÚ  at 09-11-6
function hearttotem()
    no()
    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", "RÊt tiÕc, ng­¬i kh«ng ph¶i ng­êi cña duÖ téc ta, ta kh«ng thÓ gióp ng­¬i.")
        return
    end

    --> add  by yangyankun at 09-11-11
    if (IsTongMember(2) < 1) then
        Talk(1, "no", "Ng­¬i ch­a gia nhËp thŞ téc nµy, kh«ng cã t­ c¸ch ®¶m ®­¬ng nhiÖm vô khã kh¨n nh­ vËy.")
        return
    end

    if (IsHaveTongRight(14, 2) < 1) then
        Talk(1, "no", " Ng­¬i kh«ng cã quyÒn h¹n néi chİnh cña ThŞ téc, ch­a cã t­ c¸ch ®Ó ®¶m nhËn nhiÖm vô.")
        return
    end
    --< add  by yangyankun at 09-11-11

    local H, M, S = GetHMS()
    if (H >= 19) then
        Talk(1, "no", " HiÖn giê ch­a ph¶i lóc ph¸t huy tèi ®· søc m¹nh cña VËt tæ T©m Linh, tr­íc <c=g>19h<c> h·y ®Õn nhĞ.")
        return
    end

    --> modify by yangyankun at 09-11-11
    local taskInfo = GetGlobalValue(gTaskGlobalRand)
    local taskday = GetByte(taskInfo, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 255)

    if (taskday ~= today) then
        taskInfo = SetByte(taskInfo, 1, today)
        SetGlobalValue(gTaskGlobalRand, taskInfo)
        local randPos = random(1, 5)
        taskInfo = SetByte(taskInfo, 2, randPos)
        SetGlobalValue(gTaskGlobalRand, taskInfo)
    end
    local idx = GetByte(GetGlobalValue(gTaskGlobalRand), 2)
    --< modify by yangyankun at 09-11-11


    MsgBox(" X¸c ®Şnh nhËn nhiÖm vô <c=g>Trïng t¹o VËt tæ<c> chø? H«m nay cÇn <c=g>100<c> ®iÓm Tµi nguyªn thŞ téc <c=g>" .. gTotemInfo[idx].res .. "<c><enter><c=r>Chó ı: mçi ngµy chØ cÇn thµnh c«ng hoµn thµnh 1 lÇn nhiÖm vô lµ ®­îc<c>", "accepttask", "no")
end

function accepttask()
    no()
    local H, M, S = GetHMS()
    if (H >= 19) then
        Talk(1, "no", "HiÖn giê ch­a ph¶i lóc ph¸t huy tèi ®· søc m¹nh cña VËt tæ T©m Linh, tr­íc <c=g>19h<c> h·y ®Õn nhĞ.")
        return
    end

    local idx = GetByte(GetGlobalValue(gTaskGlobalRand), 2)
    --> ÅĞ¶Ï×ÊÔ´
    local rescount = GetTongRes((idx + 1), 2)
    if (rescount < 100) then
        Talk(1, "no", " ThŞ téc kh«ng cã ®ñ <c=g>" .. gTotemInfo[idx].res .. "<c>")
        return
    end
    --< ÅĞ¶Ï×ÊÔ´

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", " <c=r>Xin thu xÕp İt nhÊt 1 « trèng trong hµnh trang tr­íc!<c>")
        return 0
    end

    WasteTongRes((idx + 1), 100, 2)    -- ÏûºÄ×ÊÁÏ
    Msg2Player("B¹n tiªu hao Tµi nguyªn thŞ téc " .. gTotemInfo[idx].res .. "100 ®iÓm")
    AddNormalItem(gTaskItem[1], gTaskItem[2], gTaskItem[3], gTaskItem[4], gTaskItem[5], gTaskItem[6])
    Talk(1, "no", " Ng­¬i ®· tiÕp nhËn thµnh c«ng nhiÖm vô <c=g>Trïng t¹o VËt tæ<c>, h·y ®Õn <c=g>" .. gTotemInfo[idx].name .. "[" .. gTotemInfo[idx].x .. "," .. gTotemInfo[idx].y .. "]<c> hoµn thµnh nhiÖm vô")
    Msg2Player("B¹n nhËn ®­îc 1 <c=g>Kı øc VËt Tæ<c>")
    TaskNote(1504, 0, gTotemInfo[idx].name, gTotemInfo[idx].x, gTotemInfo[idx].y)        -- add by yangyankun for ĞÄÁéÍ¼ÌÚ at 09-11-10
end
--<add by yangyankun for ĞÄÁéÍ¼ÌÚ  at 09-11-6

function zhuigen()
    if (GetTaskByte(ZHUI, 3) == 1) then
        CloseDialog()
        Talk(3, "no", " Phôc Hy, ThÇn N«ng, Hiªn Viªn, ThiÕu H¹o, Chuyªn Hóc cã nhiÒu c«ng lao víi thiªn h¹, ta rÊt vinh dù ®­îc thay Ngò §Õ duy tr× c¸c luËt lÖ", "<c=g>" .. GetName() .. "<c>: VËy tiªn sinh cã biÕt ta thuéc duÖ téc nµo kh«ng?", " ViÖc nµy h·y cho ta thêi gian, t¹m thêi ng­¬i cã thÓ t×m hiÓu ViÔn Cæ LiÖt Khİch, gióp [H·n Thanh Th­ Gi¶] hoµn thiÖn “H·n Thanh Toµn Th­“, chØ lµ hiÖn t¹i ng­¬i ch­a râ duÖ téc, nªn ch­a thÓ ®i vµo phóc ®Şa!", " Ng­¬i cã thÓ ®Õn biªn giíi cña 5 vïng phóc ®Şa lÇn l­ît t×m [C«ng Th©u V·ng], [C«ng Th©u Kh¶i], [C«ng Th©u ViÔn], [C«ng Th©u T¨ng], [C«ng Th©u MiÔn] cña C«ng Th©u NhÊt M¹ch ®Ó t×m hiÓu t×nh h×nh phóc ®Şa, sau ®ã vÒ b¸o cho [H·n Thanh Th­ Gi¶]. Ph¶i lu«n nhí kü, C«ng Th©u NhÊt M¹ch tİnh t×nh cæ qu¸i, lóc thØnh gi¸o ph¶i hÕt søc thËn träng vµ khiªm tèn!")
        SetTaskByte(ZHUI, 3, 2)
        TaskNote(NOTE, 1)
        Msg2Player("§i t×m C«ng Th©u NhÊt M¹ch thØnh gi¸o.")
        return
    elseif (GetTaskByte(ZHUI, 3) == 2) then
        Talk(1, "no", " VÉn ch­a t×m thÊy C«ng Th©u NhÊt M¹ch ­? Chóng th­êng ë gÇn 5 n¬i phóc ®Şa.")
        return
    end
end

function no()
    CloseDialog()
end;

--> ºÆÈ»ÕıÆø Add By yangtao Start 2009/11/5
--> ºÆÈ»ÕıÆø Add By yangtao Start 2009/11/5
function shizuxh_show()
    -- 1,     // ·üôË×åÒá
    -- 2,     // ÉñÅ©×åÒá
    -- 3,     // ĞùÔ¯×åÒá
    -- 4,     // ÉÙê»×åÒá
    -- 5,     // ò§çï×åÒá
    -- ÅĞ¶ÏÊÇ·ñÊÇ±¾×åÒá³ÉÔ±
    local shizu = GetPosterityType()
    if (shizu ~= 4) then
        Talk(1, "no", " Ng­¬i lµ ai? kh«ng ph¶i lµ ng­êi cña duÖ téc ta, th× ta kh«ng thÓ gióp ®­îc g×.")
        return
    end

    -- ÅĞ¶ÏÊÇ·ñÊÇÒÑ¾­¼ÓÈëÁËÊÏ×å
    if (IsTongMember(2) == 0) then
        Talk(1, "no", " RÊt tiÕc, c¸c h¹ kh«ng ph¶i lµ thµnh viªn thŞ téc, kh«ng thÓ nhËn nhiÖm vô.")
        return
    end

    -- ÅĞ¶ÏÈÎÎñÊÇ·ñ¸ôÌìÖØÖÃÈÎÎñ
    local today_szxh = mod(floor(LocalSystemTime() / 86400), 255) + 1
    local lastday_szxh = GetTaskByte(Task_szxh, 3)
    if (today_szxh ~= lastday_szxh) then
        local progress_last = GetTaskByte(Task_szxh, 1)
        if ((progress_last ~= 0) and (progress_last ~= 3)) then
            SetTaskByte(Task_szxh, 1, 0)
            SetTaskByte(Task_szxh, 2, 0)
            ClearItem(6, 1, 757, 0)        -- Çå³ıÇ§×íÀ¼
            ClearItem(4, 292, 0, 1)        -- ±»ÍµµÄ²Æ±¦
            TaskNote(TaskNote_szxh, -1)
            ScrollMessage("NhiÖm vô h«m qua cña ng­¬i ch­a hoµn thµnh ®· quay l¹i tõ ®Çu")
        end
        SetTaskByte(Task_szxh, 3, today_szxh)
    end

    -- ÅĞ¶ÏÏÔÊ¾°´Å¥
    local progress = GetTaskByte(Task_szxh, 1)
    local btn = "NhËn nhiÖm vô"
    if ((progress == 1) or (progress == 2)) then
        btn = "Hoµn tr¶ b¶o vËt"
    end
    local tasks = {
        --> ÊÏ×åÑ­»· Add By yangtao Start 2009/12/3
        { btn, "shizuxh"; show = 1 },
        { "Hñy N.vô", "szxh_cancel"; show = 0 },
        --< ÊÏ×åÑ­»· Add By yangtao End 2009/12/3
    }

    --> ÊÏ×åÑ­»· Add By yangtao Start 2009/11/5
    -- ÏÔÊ¾ÊÏ×åÑ­»·ÈÎÎñÈ¡Ïû°´Å¥
    local shizu = GetPosterityType()
    if (shizu == 4) then
        local progress = GetTaskByte(Task_szxh, 1)
        if ((progress == 1) or (progress == 2)) then
            tasks[2].show = 1
        end
    end
    --< ÊÏ×åÑ­»· Add By yangtao End 2009/11/5
    SayTask("Phóc ®Şa cã mét sinh linh, tªn Tú H­u, nã rÊt thİch b¶o vËt, hÔ nh×n thÊy lµ nuèt ngay vµo bông. Nay b¶o vËt cña bé téc chóng t«i kh«ng may bŞ Tú H­u trém mÊt, v× thÕ ph¶i dïng Thiªn Tóy Lan dô b¾t Tú H­u tham ¨n ®ã, b¾t nã nh¶ tr¶ b¶o vËt.", tasks)
end

function shizuxh()
    resetyqz()                -- ÔªÆøÖµµÄ¹ıÌìÖØÖÃ
    -- local yqz 		= yuanqizhi()
    local yqz = GetTransWarTaskPower()
    local progress = GetTaskByte(Task_szxh, 1)
    if ((progress == 0) or (progress == 3)) then
        MsgBox("Phóc ®Şa cã mét sinh linh, tªn Tú H­u, nã rÊt thİch b¶o vËt, hÔ nh×n thÊy lµ nuèt ngay vµo bông. Nay b¶o vËt cña bé téc chóng t«i kh«ng may bŞ Tú H­u trém mÊt, v× thÕ ph¶i dïng Thiªn Tóy Lan dô b¾t Tú H­u tham ¨n ®ã, b¾t nã nh¶ tr¶ b¶o vËt. HiÖn t¹i ng­¬i cã <c=g>" .. yqz .. "<c> ®iÓm nguyªn khİ, mçi lÇn nhËn nhiÖm vô ®Òu tèn 1 Tinh Hoa §Şa Hån vµ <c=g>5<c> ®iÓm nguyªn khİ, giê ng­¬i cã muèn nhËn nhiÖm vô kh«ng?", "szxh_yes", "no")
    elseif (progress == 1) then
        Talk(1, "no", "Ng­¬i ch­a ®o¹t l¹i b¶o vËt bŞ trém, mau ®i dô b¾t Tú H­u tham ¨n ®ã! Ngµy mai nã sÏ mang b¶o vËt ®i giÊu, lóc ®ã ng­¬i sÏ kh«ng thÓ t×m ®­îc.")
    elseif (progress == 2) then
        szxhfulfill()
    end
end

-- ÅĞ¶ÏÊÇ·ñÖØÖÃÊÏ×åÈÎÎñ±äÁ¿
function resetszidx()
    local timestamp = GetByte(GetTongTask(Family_szxh, 2), 1)
    local today = mod(floor(LocalSystemTime() / 86400), 255) + 1

    if (today ~= timestamp) then
        local fudiidx = random(1, 5)
        SetTongTask(Family_szxh, SetByte(SetByte(0, 1, today), 2, fudiidx), 2)
    end
end

-- ÔªÆøÖµµÄ¹ıÌìÖØÖÃ
function resetyqz()
    local lastday = GetTaskByte(Task_yq, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 255) + 1
    if (lastday ~= today) then
        -- ¹ıÌì£¬ĞèÒªÖØÖÃÔªÆøÖµ
        local yqz_chongzhi = yqz_chongzhi()                    -- ĞèÒªĞŞ¸ÄÏà¹Øº¯Êı

        SetTaskByte(Task_yq, 1, today)
        SetTaskByte(Task_yq, 2, 0)
        -- SetTaskByte(Task_yq, 3, yqz_chongzhi)
        local t = GetTransWarTaskPower()
        ModifyTransWarTaskPower(-t)
        ModifyTransWarTaskPower(yqz_chongzhi)
    end
end

-- »ñµÃÓ¦¸ÃÖØÖÃµÄÏµÍ³ÔªÆøÖµ
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

-- function yuanqizhi()
--	local yqz = GetTask(Task_ibyq) + GetTaskByte(Task_yq, 3)

--	return yqz
-- end

function szxh_yes()
    local level = GetExploitLevel()
    if (level < 3) then
        Talk(1, "no", "Víi c«ng tr¹ng hiÖn t¹i, ng­¬i ch­a thÓ nhËn träng tr¸ch nµy, ®îi khi c«ng tr¹ng ®¹t cÊp 3 h·y quay l¹i.")
        return
    end
    -- ÅĞ¶ÏÏûºÄµÄÔªÆøÖµ
    local yqz_xiaohao = GetTaskByte(Task_yq, 2)
    if (yqz_xiaohao >= yqz_chongzhi() * 2) then
        Talk(1, "no", "Cèng hiÕn cho thŞ téc lµ viÖc nªn lµm, nh­ng ph¶i tù l­îng søc, nguyªn khİ h«m nay cña ng­¬i ®· c¹n kiÖt, ®îi khi nµo ®ñ h·y quay l¹i.")
        return
    end
    --- ±³°üÂú
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Ng­¬i cÇn dïng Thiªn Tóy Lan mµ ta cho ng­¬i ®Ó ®èi phã víi Tú H­u, nh­ng hµnh trang cña ng­¬i ®· ®Çy, kh«ng thÓ bá vµo Thiªn Tóy Lan.")
        return
    end
    if (HaveNormalItem(3, 1024, 0, 0) <= 0) then
        Talk(1, "no", "Thiªn Tóy Lan kh«ng dÔ cã ®­îc, ph¶i ch¨m bãn b»ng Tinh Hoa §Şa Hån.")
        return
    end
    -- ¸ù¾İÔªÆøÖµÇé¿ö¸ü¸ÄÏµÍ³·ÖÅäµÄÔªÆøÖµºÍibµÀ¾ß²úÉúµÄÔªÆøÖµ
    -- local yqz 		= yuanqizhi()
    local yqz = GetTransWarTaskPower()
    if (yqz < 5) then
        Talk(1, "no", "NhiÖm vô nµy tèn nhiÒu nguyªn khİ, ng­¬i kh«ng ®ñ 5 ®iÓm nguyªn khİ, ta khuyªn ng­¬i nªn tu d­ìng nguyªn khİ.")
        return
    else
        -- local yqz_xitong 	= GetTaskByte(Task_yq, 3)
        -- local yqz_ib		= GetTask(Task_ibyq)

        -- if(yqz_xitong >= 5) then
        -- 	yqz_xitong = yqz_xitong - 5
        -- 	SetTaskByte(Task_yq, 3, yqz_xitong)
        -- else
        -- 	SetTaskByte(Task_yq, 3, 0)
        -- 	yqz_ib = yqz_ib - (5 - yqz_xitong)
        -- 	SetTask(Task_ibyq, yqz_ib)
        -- end
        ModifyTransWarTaskPower(-5)
    end

    -- ¸£µØĞÅÏ¢
    local fudi_info = {
        [1] = { name = "Th­íc Kim Phóc §Şa", pxid = 1507 },
        [2] = { name = "ThiÖn Thñy Phóc §Şa", pxid = 1558 },
        [3] = { name = "óc Méc Phóc §Şa", pxid = 1557 },
        [4] = { name = "Xİch Háa Phóc §Şa", pxid = 1559 },
        [5] = { name = "Kh«i Thæ Phóc §Şa", pxid = 1560 },
    }
    resetszidx()            -- »ñµÃ¼Ò×åÈÎÎñ±äÁ¿

    local fudiidx = GetByte(GetTongTask(Family_szxh, 2), 2)

    -- Modify by yangtao for µÁ±¦õùõ÷¼Ólog 2009/12/25 start
    WriteLog(GetName() .. "§· nhËn nhiÖm vô §¹o B¶o Tú H­u.")
    -- Modify by yangtao for µÁ±¦õùõ÷¼Ólog 2009/12/25 end

    SetTaskByte(Task_yq, 2, yqz_xiaohao + 5)
    SetTaskByte(Task_szxh, 1, 1)
    SetTaskByte(Task_szxh, 2, fudiidx)
    AddNormalItem(6, 1, 757, 0, 0, 0)    -- Ç§×íÀ¼
    DelNormalItem(3, 1024, 0, 0)    -- É¾³ıÒ»¸öµØ»ê¾«»ª
    TaskNote(TaskNote_szxh, 0, fudi_info[fudiidx].name)
    Talk(1, "no", "Theo ta ®­îc biÕt, th× <c=g>" .. fudi_info[fudiidx].name .. "<c>-Tú H­u ®· trém b¶o vËt cña thŞ téc chóng t«i, mau qua bªn ®ã ®i t×m Tú H­u tham ¨n ®ã!")
end

function szxhfulfill()
    if (HaveEventItem(292) > 0) then
        SetTaskByte(Task_szxh, 1, 3)
        ClearItem(6, 1, 757, 0)        -- Çå³ıÇ§×íÀ¼
        ClearItem(4, 292, 0, 1)        -- ±»ÍµµÄ²Æ±¦
        TaskNote(TaskNote_szxh, -1)
        local Exploit = GetExploit()
        local ExploitV = GetExploitV()
        SetExploit(Exploit + 50)
        SetExploitV(ExploitV + 50)

        -- Modify by yangtao for µÁ±¦õùõ÷¼Ólog 2009/12/25 start
        WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô §¹o B¶o Tú H­u.")
        -- Modify by yangtao for µÁ±¦õùõ÷¼Ólog 2009/12/25 end

        local tongName = GetTongName(2)
        local resourceNum = GetUnionTongTechCustomPointByName(tongName) + 1
        if (resourceNum > 2000) then
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· ®o¹t l¹i b¶o vËt, ®óng lµ kh«ng thÓ xem th­êng!")
            Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng c«ng tr¹ng")
        else
            SetUnionTongTechCustomPointByName(tongName, resourceNum)
            Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· ®o¹t l¹i b¶o vËt, ®óng lµ kh«ng thÓ xem th­êng! Ng­¬i ®· khiÕn thŞ téc cña chóng t«i t¨ng 1 ®iÓm Tµi nguyªn thŞ téc!")
            Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng c«ng tr¹ng vµ tµi nguyªn thŞ téc")
        end
    else
        Talk(1, "no", "<c=g>B¶o vËt bŞ trém<c> ®©u?")
    end
end

function szxh_cancel()
    MsgBox("Tuy b¶o vËt bŞ Tú H­u trém kh«ng nhiÒu, nh­ng ®ã còng lµ må h«i n­íc m¾t cña d©n chóng, ng­¬i x¸c nhËn hñy gióp ®ì kh«ng?", "szxh_can_yes", "no")
end

function szxh_can_yes()
    -- ÅĞ¶ÏÊÇ·ñÊÇÒÑ¾­¼ÓÈëÁËÊÏ×å
    if (IsTongMember(2) == 0) then
        Talk(1, "no", "RÊt tiÕc, c¸c h¹ kh«ng ph¶i thµnh viªn cña thŞ téc, th«ng c¶m nhĞ, ta kh«ng thÓ gióp ng­¬i.")
        return
    end

    SetTaskByte(Task_szxh, 1, 3)
    ClearItem(6, 1, 757, 0)        -- Çå³ıÇ§×íÀ¼
    ClearItem(4, 292, 0, 1)        -- ±»ÍµµÄ²Æ±¦
    TaskNote(TaskNote_szxh, -1)
    Talk(1, "no", "Ng­¬i ®· hñy nhiÖm vô lÇn nµy.")
end
--< ºÆÈ»ÕıÆø Add By yangtao End 2009/11/5

--> add by Gaojingwei start 2009/11/10
--ÁìÈ¡¿ó³µ
Gens_Tramcer_Number = 25 --ÊÏ×åÈÎÎñ±äÁ¿,¼ÇÂ¼ÒÑÁìÈ¡µÄ¿ó³µÊıÁ¿
Gens_Tramcer_Time = 26   --ÉÏÒ»´ÎÁìÈ¡¿ó³µµÄÊ±¼ä

Task_Exploit_Today = 1638    --1byte:ÈÕÆÚ 2byte£ºÉÏ½É×ÊÔ´»ñµÃµÄ»ı·Ö 3byte:É±¿ó³µµÃµ½µÄ¹¦Ñ«»ı·Ö

Gens_ID = 0                --¼ÇÂ¼ÊÏ×åID
Res_Type = 1            --¿ó²úÀàĞÍ
Res_Count = 2            --¿ó²úÊıÁ¿
Death_Times = 3            --´İ»Ù´ÎÊı

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
            --ÓµÓĞ¾üÕşÈ¨ÏŞ
            tasks[1].show = 1
        end
    end

    if (H >= 20) and (H <= 21) or (H == 22 and M <= 30) then
        if (GetPosterityType() == POSTERIRY_TYPE.SHAOHAO) and (IsTongMember(2) > 0) then
            tasks[2].show = 1
        end
    end

    SayTask("20:00 mçi ngµy, nh÷ng ng­êi cã quyÒn qu©n chİnh trong thŞ téc cã thÓ ®Õn chç ta nhËn Kho¸ng xa.", tasks)
end

function getTramcar()
    local H, M, S = GetHMS()
    if (H < 20) or (H > 21) or (H == 21 and M > 50) then
        Talk(1, "§· hÕt thêi gian, kh«ng thÓ nhËn Kho¸ng Xa.")
        return
    end

    if (IsHaveTongRight(13, 2) == 0) then
        --±»½â³ıÁË¾üÕşÈ¨ÏŞ
        Talk(1, "no", "Ng­êi cã quyÒn qu©n chİnh míi ®­îc nhËn nhËn Kho¸ng Xa.")
        return
    end

    local today = floor(LocalSystemTime() / 86400)
    local lastDay = GetTongTask(Gens_Tramcer_Time, 2)
    local nNum = GetTongTask(Gens_Tramcer_Number, 2)                    --ÒÑÁìÈ¡µÄ¿ó³µÊı
    local nfamily = GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO)        --µÃµ½¼Ò×åÊıÁ¿

    if (today == lastDay) and (nNum >= nfamily) then
        Talk(1, "no", "ThŞ téc cña ng­¬i do gia téc " .. nfamily .. " t¹o thµnh, thŞ téc cña ng­¬i ®· nhËn ë ®©y" .. nNum .. " Kho¸ng xa, h«m nay ®· nhËn ®Õn møc tèi ®a.")
        return
    end

    if (today ~= lastDay) then
        SetTongTask(Gens_Tramcer_Time, today, 2)
        SetTongTask(Gens_Tramcer_Number, 0, 2)
    end

    nNum = GetTongTask(Gens_Tramcer_Number, 2)

    if (nNum < nfamily) then
        --ÔÙ¶ÈÈ·ÈÏ
        MsgBox("ThŞ téc cña ng­¬i do gia téc " .. nfamily .. " gia téc t¹o thµnh, nªn thŞ téc cña ng­¬i cã thÓ ®Õn chç ta nhËn " .. nfamily .. " Kho¸ng xa, hiÖn ®· nhËn " .. nNum .. ", ng­¬i muèn nhËn kh«ng?", "yes_GetTramcer", "no")
    end
end

function yes_GetTramcer()
    CloseDialog()
    local H, M, S = GetHMS()
    if (H < 20) or (H > 21) or (H == 21 and M > 50) then
        Talk(1, "HiÖn kh«ng ph¶i lµ thêi gian thu thËp m¹ch kho¸ng, nhËn Kho¸ng xa lóc nµy phİ l¾m, h·y chê c¬ héi lÇn sau.")
        return
    end

    if (IsHaveTongRight(13, 2) == 0) then
        --±»½â³ıÁË¾üÕşÈ¨ÏŞ
        Talk(1, "no", "Kho¸ng xa kh«ng ph¶i ai còng ®­îc nhËn, chØ nh÷ng ng­êi cã quyÒn qu©n chİnh míi cã t­ c¸ch nµy.")
        return
    end

    local today = floor(LocalSystemTime() / 86400)
    local lastDay = GetTongTask(Gens_Tramcer_Time, 2)
    local nNum = GetTongTask(Gens_Tramcer_Number, 2)
    local nfamily = GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO)  --µÃµ½¼Ò×åÊıÁ¿

    if (today == lastDay) and (nNum >= nfamily) then
        Talk(1, "no", "ThŞ téc cña ng­¬i do gia téc " .. nfamily .. " t¹o thµnh, thŞ téc cña ng­¬i ®· nhËn ë ®©y" .. nNum .. " Kho¸ng xa, h«m nay ®· nhËn ®Õn møc tèi ®a.")
        return
    end

    if (today ~= lastDay) then
        SetTongTask(Gens_Tramcer_Time, today, 2)
        SetTongTask(Gens_Tramcer_Number, 0, 2)
    end

    nNum = GetTongTask(Gens_Tramcer_Number, 2)

    if (nNum < nfamily) then
        --ÔÙ¶ÈÈ·ÈÏ
        local map, x, y = GetNpcWorldPos(DialogNpcIdx)

        if (map ~= 92) then
            return
        end

        local nRand = random(1, getn(TramcarLocation))
        x = TramcarLocation[nRand].x * 32
        y = TramcarLocation[nRand].y * 32
        local carriageindex = NewSiegeWeapon(map, x, y, TramcarTempalte[1].template, 3)

        if (carriageindex > 0) then
            local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
            local gensName = GetTongName(2)
            SetNpcScript(carriagenpcindex, "\\script\\¿ç·şÕ½³¡\\¿ó³µ.lua")
            SetNpcName(carriagenpcindex, "[" .. gensName .. "]" .. "Kho¸ng xa")
            local npcId = GetNpcID(carriagenpcindex)
            local nLeftTime = (22 - H) * 3600 + (29 - M) * 60 + (60 - S)
            local guardindex = SendCarriage(carriageindex, GetName(), 1, nLeftTime, npcId, gensName, 3)

            SetTGuardTaskValue(guardindex, Res_Type, 0)                --¿ó²úÀàĞÍ
            SetTGuardTaskValue(guardindex, Res_Count, 0)            --ÒÑ²É¼¯¿ó²úÊıÁ¿
            SetTGuardTaskValue(guardindex, Death_Times, 0)            --±»ÆÆ»µ´ÎÊı


            nNum = nNum + 1
            SetTongTask(Gens_Tramcer_Number, nNum, 2)

            --±äÕóÓª
            local sUnionName = GetTongName(2)
            SetNpcUnionCamp(carriagenpcindex, sUnionName)
            --±äÕóÓª
            local linkPos = "<HyperLinkWorldPos=\"" .. TramcarLocation[nRand].link .. "\">"
            Msg2Player("Kho¸ng xa cña ng­¬i ®­îc ®Æt t¹i täa ®é " .. linkPos)
            Msg2TongMemberByTongName(gensName, "[<RoleName=\"" .. GetName() .. "\">] ®· gÆp [ThiÕu H¹o HËu DuÖ] nhËn 1 [Kho¸ng Xa], mäi ng­êi h·y nhanh chãng ®i b¶o hé")
        end
    end
end

--ÉÏ½É×ÊÔ´
function turnInRes()
    CloseDialog()
    local carriageindex = IsPlayerInsideWeapon(PlayerIndex)

    if (carriageindex <= 0) then
        Talk(1, "no", "Ng­¬i ph¶i mang Kho¸ng xa ®Õn míi cã thÓ nép tµi nguyªn vµo kho thŞ téc.")
        return
    end

    local guardindex = GetTGuardIndexByCarriageIndex(carriageindex)
    if (guardindex <= 0) then
        Talk(1, "no", "Kh«ng t×m thÊy Kho¸ng xa.")            --debugÓÃ
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

    local nThisDay = mod(floor(LocalSystemTime() / 86400), 256)
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
        local nOldExp = GetExploit()    --»ñµÃ¹¦Ñ«»ı·Ö
        local nOldExpV = GetExploitV()    --»ñµÃ¹¦Ñ«Öµ
        nOldExp = nOldExp + nExploit
        nOldExpV = nOldExpV + nExploit
        --ÉèÖÃ¹¦Ñ«»ı·Ö
        SetExploit(nOldExp)
        SetExploitV(nOldExpV)
    end

    AddTongRes(nResType + 1, nResCount, 2)

    --¿ó³µ×ÊÔ´ÀàĞÍºÍÊıÁ¿Çå¿Õ£¬µ«±»´İ»Ù´ÎÊı²»±ä
    SetTGuardTaskValue(guardindex, Res_Type, 0)                --¿ó²úÀàĞÍ
    SetTGuardTaskValue(guardindex, Res_Count, 0)            --ÒÑ²É¼¯¿ó²úÊıÁ¿
    if (nExploit > 0) then
        Talk(1, "no", "Ng­¬i qu¶ nhiªn kh«ng phô lßng mong mái cña mäi ng­êi, ®· nép " .. nResCount .. " tµi nguyªn, ®©y" .. nExploit .. "®iÓm c«ng tr¹ng mµ ng­¬i xøng ®¸ng cã.")
        Msg2Player("Chóc mõng ng­¬i ®· nép " .. nResCount .. " tµi nguyªn, nhËn ®­îc" .. nExploit .. " ®iÓm c«ng tr¹ng")
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
--< add by Gaojingwei end 2009/11/10

--AS GaoJingwei 091130
BUFF_FORBID_CHANGE_GENGS = 1097            --°²ÓÚÏÖ×´
BUFF_CONDEMN = 1098                        --×åÒáÇ´Ôğ
BUFF_COWER = 1101                        --ÖªÄÑ¶øÍË
BUFF_SELECT = 1102                        --ÌìÑ¡Ö®ÈË
BUFF_CAREER = 1100                        --Í¼Ä±´óÒµ
TASK_CHANGE_GENS = 1634                    --1bit:ÊÇ·ñ×ª»»¹ı×åÒá

function changeGens()
    CloseDialog()
    if (IsTongMember(1) > 0) then
        Talk(1, "no", "Giê ng­¬i lµ mét thµnh viªn trong gia téc, ph¶i tho¸t khái gia téc míi cã thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (IsRegMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®· ®¨ng kı gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang ë tr¹ng th¸i æn ®Şnh, kh«ng thÓ tiÕn hµnh thao t¸c chuyÓn ®æi duÖ téc.")
        return
    end

    --µÃµ½×åÒáÈËÊı×¢Òâ×åÒáÇø±ğ
    local thisNum = LoadIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num")
    local mixNum = 12
    for i = 1, 5 do
        local everyNum = LoadIniInteger("Postity" .. i, "Num")
        mixNum = min(everyNum, mixNum)
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
        MsgBox("Ng­¬i ®· chuyÓn ®æi duÖ téc, nh­ng nÕu ng­¬i cho ta 1 <c=yel>Ph¸t hoµng ®å phæ<c> hoÆc " .. Cfs .. " Kim Nguyªn B¶o, ta sÏ chuyÓn ®æi duÖ téc cho ng­¬i.", "confirmChange", "no")
    end
end

function confirmChange()
    CloseDialog()
    if (IsTongMember(1) > 0) then
        Talk(1, "no", "Giê ng­¬i lµ mét thµnh viªn trong gia téc, ph¶i tho¸t khái gia téc míi cã thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (IsRegMember(1) > 0) then
        Talk(1, "no", "Ng­¬i ®· ®¨ng kı gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ chuyÓn ®æi duÖ téc.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang æn ®Şnh víi hiÖn tr¹ng, kh«ng thÓ tiÕn hµnh thao t¸c chuyÓn ®æi.")
        return
    end

    --µÃµ½×åÒáÈËÊıµÃµ½×åÒáÈËÊı×¢Òâ×åÒáÇø±ğ
    local thisNum = LoadIniInteger("Postity" .. POSTERIRY_TYPE.SHAOHAO, "Num")
    local mixNum = 12
    for i = 1, 5 do
        local everyNum = LoadIniInteger("Postity" .. i, "Num")
        mixNum = min(everyNum, mixNum)
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
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>Ph¸t hoµng ®å phæ<c> vµ kh«ng ®ñ Kim Nguyªn B¶o.")
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
--AE GaoJingwei 091130

function aboutFamily()
    CloseDialog()
    --> add by huangbin start 2009/11/25
    local tasks = {
        { "LËp gia téc", "establishFamily"; show = 0 },
        { "Gia nhËp gia téc", "joinFamily"; show = 0 },
        { "Tho¸t khái gia téc", "quitFamily"; show = 0 },
        { "Hñy xin phĞp", "cancelRegister"; show = 0 },
        { "Téc tr­ëng nh­êng ng«i", "demise"; show = 0 },
        { "H­íng dÉn lËp gia téc", "shuoming"; show = 1 }
    }

    --×åÒáÇø±ğ
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

    SayTask("T¹i §éng Thiªn Phóc §Şa, mét th©n mét m×nh khã mµ tån t¹i, theo lı nªn mau chãng lËp gia téc.", tasks)
end

function isAllFit(nType)
    if (GetTeamSize() < 6) then
        Msg2Team("Thµnh viªn İt h¬n 6 ng­êi, kh«ng thÓ lËp gia téc.")
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
            Msg2Team(GetName() .. " ®· göi xin phĞp gia nhËp vµo gia téc kh¸c")
            PlayerIndex = oldPlayer
            return 0
        end
    end

    PlayerIndex = oldPlayer
    return 1
end

function establishFamily()
    CloseDialog()
    --???×¢Òâ×åÒáÇø±ğ
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

    --´ò¿ª´´½¨¼Ò×åÃæ°å
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
        Talk(1, "no", "Ng­¬i ®· ®¨ng kı gia nhËp gia téc, ®ang chê nghiÖm chøng. Trong thêi gian nµy kh«ng thÓ gia nhËp vµo gia téc kh¸c.")
        return
    end

    if (HaveIBBuff(BUFF_COWER) > 0) then
        Talk(1, "no", "Thêi gian rêi khái gia téc tr­íc ch­a ®ñ 6 giê, kh«ng thÓ gia nhËp gia téc kh¸c.")
        return
    end

    --´ò¿ªÉêÇë¼ÓÈëÃæ°å×¢Òâ×åÒáµÄÇø±ğ
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

    --ÍÑÀë¼Ò×å
    AddIBBuff(BUFF_COWER)
    LeaveTong(1)
end

function cancelRegister()
    MsgBox("Ng­¬i cã thËt muèn hñy ®¨ng kı gia nhËp gia téc?", "yes_cancel", "no")
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
        Talk(1, "no", "Ng­¬i lµ tr­ëng thŞ téc, kh«ng thÓ tïy tiÖn nh­êng ng«i téc tr­ëng cho ng­êi kh¸c.")
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
        Talk(1, "no", "Ng­¬i lµ tr­ëng thŞ téc, kh«ng thÓ tïy tiÖn nh­êng ng«i téc tr­ëng cho ng­êi kh¸c.")
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

        MsgBox("Ng­¬i cã ®ång ı nhËn sù phã th¸c cña " .. name1 .. ", nhËn chøc vŞ téc tr­ëng?", "acceptDemise", "no")
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
    Msg2Player("Ng­¬i ®· mÊt chøc vŞ téc tr­ëng")

    --Ê§È¥ÖØÖı»Ô»ÍµÄÈÎÎñ
    RemoveIBBuff(BUFF_SELECT)
    for i = 287, 291 do
        DelEventItem(i)
    end

    PlayerIndex = oldPlayer
    Msg2Player("NhËn ®­îc chøc vŞ téc tr­ëng")
    WriteLog(GetTongName(1) .. "L·nh ®Şa-" .. name1 .. " nh­êng ng«i cho " .. name2)
end

function shuoming()
    Talk(2, "no", "Muèn t¹i hiÖn sù huy hoµng cña bæn téc, tr­íc hÕt ph¶i lËp gia téc, ®Ó lËp gia téc cÇn 6 ng­êi ch¬i cïng duÖ téc tæ ®éi ®Õn ®¨ng kı, chó ı mçi duÖ téc tèi ®a chØ cã thÓ ®ång thêi tån t¹i 10 gia téc.", "NÕu muèn gia nhËp gia téc, chØ cÇn ®Õn chç ta ®¨ng kı, chó ı mçi gia téc tèi ®a chØ cã 12 thµnh viªn.")
    return
end

function aboutGens()
    CloseDialog()
    local tasks = {
        { "Trïng t¹o huy hoµng", "reBount"; show = 0 },
        { "Hñy trïng t¹o huy hoµng", "cancelBount"; show = 0 },
        { "Gia nhËp thŞ téc", "joinGens"; show = 0 },
        { "Tho¸t khái thŞ téc", "quitGens"; show = 0 },
        { "Tr­ëng thŞ téc nh­êng ng«i", "demiseGens"; show = 0 },
        { "H­íng dÉn lËp thŞ téc", "shuomingGens"; show = 1 }
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

    SayTask("Muèn sinh tån t¹i §éng Thiªn Phóc §Şa, b­íc ®Çu tiªn ph¶i lËp gia téc, chØ khi lËp thŞ téc thµnh c«ng, míi cã thÓ t¸i hiÖn sù huy hoµng cña bæn téc.", tasks)
end

function reBount()
    CloseDialog()
    --×¢Òâ×åÒáµÄÇø±ğ
    if (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) > 0) then

        --É¾ÁÛÆ¬
        local nCount = 0
        for i = 287, 291 do
            if (HaveEventItem(i) > 0) then
                DelEventItem(i)
                nCount = nCount + 1
            end
        end

        --É¾buff
        RemoveIBBuff(BUFF_SELECT)

        --ËµÃ÷Íê³ÉÈÎÎñ
        if (nCount >= 5) then
            local nOldExp = GetExploit()    --»ñµÃ¹¦Ñ«»ı·Ö
            local nOldExpV = GetExploitV()    --»ñµÃ¹¦Ñ«Öµ
            nOldExp = nOldExp + 50
            nOldExpV = nOldExpV + 50
            SetExploit(nOldExp)
            SetExploitV(nOldExpV)
        end

        Talk(1, "no", "C¸c h¹ nªn t¹m vøt bá nh÷ng ©n o¸n c¸ nh©n, tranh thñ ®­a nh÷ng ng­êi trong gia téc gia nhËp vµo, ®ång t©m hiÖp lùc ®Èy m¹nh thŞ téc cña chóng ta t¹i §éng Thiªn Phóc §Şa nµy, t¸i hiÖn b¸ nghiÖp huy hoµng cña tiªn ®Õ!")
        TaskNote(1508, -1)
        return
    end

    --¹¦Ñ«µÈ¼¶µ½´ï3¼¶
    if (GetExploitLevel() < 3) then
        Talk(1, "no", "NhËn nhiÖm vô <c=g>trïng t¹o huy hoµng<c>, c«ng tr¹ng cña téc tr­ëng ph¶i tõ cÊp <c=g>3<c> trë lªn.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", "NhËn nhiÖm vô <c=g>trïng t¹o huy hoµng<c>, gia téc kh«ng ®­îc İt h¬n <c=g>6<c> thµnh viªn.")
        return
    end

    if (HaveIBBuff(BUFF_FORBID_CHANGE_GENGS) > 0) then
        Talk(1, "no", "§ang trong thêi gian chê chuyÓn ®æi duÖ téc, kh«ng thÓ nhËn nhiÖm vô nµy.")
        return
    end

    --ÓµÓĞ5¸öÁÛÆ¬
    local flag = 1
    for i = 287, 291 do
        if (HaveEventItem(i) <= 0) then
            flag = 0
            break ;
        end
    end

    if (flag == 1) then
        if (CreateUnionTong("ThiÕu H¹o ThŞ Téc", "") > 0) then
            for i = 287, 291 do
                DelEventItem(i)
            end
        end

        RemoveIBBuff(BUFF_SELECT)

        local nOldExp = GetExploit()    --»ñµÃ¹¦Ñ«»ı·Ö
        local nOldExpV = GetExploitV()    --»ñµÃ¹¦Ñ«Öµ
        nOldExp = nOldExp + 100
        nOldExpV = nOldExpV + 100
        SetExploit(nOldExp)
        SetExploitV(nOldExpV)

        Msg2Player("X©y dùng thŞ téc thµnh c«ng")
        Msg2TongMemberByTongName(GetTongName(1), "B¹n ®· trë thµnh thµnh viªn cña ThiÕu H¹o ThŞ Téc.")
        AddGlobalCountNews("Dòng sÜ kiÖt xuÊt cña ThiÕu H¹o ThŞ Téc" .. GetName() .. "QuyÕt t©m tu©n theo di huÊn tiªn ®Õ, l·nh ®¹o téc nh©n ThiÕu H¹o ThŞ Téc, t¸i hiÖn sù huy hoµng cña ThiÕu H¹o ThŞ Téc!", 3)
        TaskNote(1508, -1)
        return
    end

    if (HaveIBBuff(BUFF_SELECT) > 0) then
        Talk(1, "no", " Ng­¬i ®ang ë tr¹ng th¸i Thiªn TuyÓn Chi Nh©n, h·y mau ®i hoµn thµnh träng tr¸ch.")
        return
    end

    --É¾³ıÁÛÆ¬
    for i = 287, 291 do
        DelEventItem(i)
    end
    AddIBBuff(BUFF_SELECT)
    Talk(1, "no", " Ng­¬i nhËn ®­îc tr¹ng th¸i Thiªn TuyÓn Chi Nh©n, ë tr¹ng th¸i nµy ®¸nh b¹i 5 lo¹i Thiªn Léc ThÇn Thó, nhËn ®­îc 5 V¶y Thiªn Léc ThÇn Thó th× cã thÓ thµnh lËp thŞ téc.")
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
    --É¾³ıÁÛÆ¬
    for i = 287, 291 do
        DelEventItem(i)
    end
    Msg2Player("§· hñy bá nhiÖm vô Trïng t¹o huy hoµng.")
    TaskNote(1508, -1)
end

function joinGens()
    CloseDialog()

    if (IsRegMember(2) > 0) then
        Talk(1, "no", " Ng­¬i ®· ®Ò nghŞ gia nhËp 1 thŞ téc, ®ang chê nghiÖm chøng.")
        return
    end

    if (GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO) >= 8) then
        Talk(1, "no", "Sè gia téc trong thŞ téc nµy ®· ®¹t møc tèi ®a, kh«ng thÓ kÕt n¹p gia téc míi.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", " Gia téc ch­a ®ñ 6 ng­êi, kh«ng thÓ gia nhËp thŞ téc.")
        return
    end

    MsgBox(" Ng­¬i muèn gia nhËp gia téc vµo thŞ téc nµy chø?", "yes_joinGens", "no")
end

function yes_joinGens()
    CloseDialog()

    --×¢Òâ×åÒáµÄÇø±ğ
    if (GetUnionTongIDByPosterityType(POSTERIRY_TYPE.SHAOHAO) <= 0) then
        Talk(1, "no", " DuÖ téc nµy kh«ng cã thŞ téc")
        return
    end

    if (IsTongMaster(1) == 0) then
        Talk(1, "no", " ChØ cã téc tr­ëng míi cã thÓ l·nh ®¹o gia téc gia nhËp thŞ téc")
        return
    end

    if (IsTongMember(2) == 1) then
        Talk(1, "no", " Ng­¬i ®· gia nhËp 1 thŞ téc, kh«ng thÓ gia nhËp thŞ téc kh¸c n÷a.")
        return
    end

    if (IsRegMember(2) > 0) then
        Talk(1, "no", " Ng­¬i ®· ®Ò nghŞ gia nhËp 1 thŞ téc, ®ang chê nghiÖm chøng.")
        return
    end

    if (GetUnionTongFamilyCount(POSTERIRY_TYPE.SHAOHAO) >= 8) then
        Talk(1, "no", "Sè gia téc trong thŞ téc nµy ®· ®¹t møc tèi ®a, kh«ng thÓ kÕt n¹p gia téc míi.")
        return
    end

    if (GetTongMemberCount(1) < 6) then
        Talk(1, "no", " Gia téc ch­a ®ñ 6 ng­êi, kh«ng thÓ gia nhËp thŞ téc.")
        return
    end

    --×åÒáÇø±ğ
    JoinUnionTong(POSTERIRY_TYPE.SHAOHAO)
    Msg2Player("Ng­¬i ®· ®Ò nghŞ gia nhËp ThiÕu H¹o ThŞ Téc")
    Msg2TongMemberByTongName(GetTongName(1), "Téc tr­ëng ®· yªu cÇu gia nhËp thŞ téc")
end

function quitGens()
    CloseDialog()
    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Tr­ëng ThŞ téc kh«ng thÓ rêi khái thŞ téc")
        return
    end

    if (IsTongMember(2) == 0) then
        Talk(1, "no", "ThiÕu H¹o HËu DuÖ:Ng­¬i kh«ng ph¶i thµnh viªn thŞ téc nµy.")
        return
    end

    if (IsTongMaster(1) <= 0) then
        Talk(1, "no", "ChØ téc tr­ëng míi cã quyÒn h¹n l·nh ®¹o téc nh©n rêi khái thŞ téc")
        return
    end

    MsgBox("Ng­¬i muèn rêi khái thŞ téc nµy chø?", "yes_quitGens", "no")
end

function yes_quitGens()
    CloseDialog()
    if (IsTongMaster(2) == 1) then
        Talk(1, "no", "Tr­ëng ThŞ téc kh«ng thÓ rêi khái thŞ téc")
        return
    end

    if (IsTongMember(2) == 0) then
        Talk(1, "no", "ThiÕu H¹o HËu DuÖ:Ng­¬i kh«ng ph¶i thµnh viªn thŞ téc nµy.")
        return
    end

    if (IsTongMaster(1) <= 0) then
        Talk(1, "no", "ChØ téc tr­ëng míi cã quyÒn h¹n l·nh ®¹o téc nh©n rêi khái thŞ téc")
        return
    end

    --ÍÑÀëÊÏ×å
    LeaveUnionTong()
end

function isCanDemiseGens()
    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "NÕu muèn thùc hiÖn nh­êng ng«i Tr­ëng ThŞ téc, 2 ng­êi ph¶i tæ ®éi ®Õn ®©y.")
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
        Msg2Team("2 ng­êi ph¶i cïng thŞ téc.")
        return 0
    end

    if (w1 ~= w2) then
        Msg2Team("§ång ®éi cña b¹n kh«ng ë gÇn ®©y, kh«ng thÓ tiÕn hµnh nh­êng ng«i Tr­ëng ThŞ téc.")
        return 0
    end

    if (isMasterGens1 == 0) and (isMasterGens2 == 0) then
        Msg2Team("Ph¶i cã Tr­ëng ThŞ téc tham gia míi cã thÓ nh­êng ng«i.")
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
        MsgBox(" " .. name1 .. "QuyÕt ®Şnh ®em träng tr¸ch cña bæn thŞ téc ñy th¸c cho ng­¬i, ®ång ı tiÕp nhËn chø?", "acceptDemiseGens", "no")
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
    Msg2Player("§· mÊt chøc vŞ Tr­ëng ThŞ téc")

    PlayerIndex = oldPlayer
    Msg2Player("NhËn ®­îc chøc vŞ Tr­ëng ThŞ téc")

    --ÉèÖÃÁ½¸öÈËµÄÖ°Î»
    WriteLog(GetTongName(2) .. "L·nh ®Şa-" .. name1 .. " nh­êng ng«i cho " .. name2)

    --ÉèÖÃ°ÔÖ÷»ı·Ö
    local warPower = GetUnionTongWarPower()
    if (warPower > 200) then
        ModifyUnionTongWarPower(200)
    end
end

function shuomingGens()
    Talk(1, "no", "Muèn thµnh lËp thŞ téc, cÇn téc tr­ëng ®Õn, l·nh ®¹o téc nh©n hoµn thµnh nhiÖm vô Trïng t¹o huy hoµng, míi cã thÓ trïng kiÕn thŞ téc nµy.")
end

--> ¶´ÌìÕù¶áÕ½ Add By yangtao Start 2009/11/17
function zhanqi()
    MsgBox("Ng­¬i muèn mua ChiÕn Kú ThŞ Téc chø?", "zhanqi_yes", "no")
end

function zhanqi_yes()
    -- ÓµÓĞÊÏ×å¾üÊÂÈ¨ÏŞ
    if (IsHaveTongRight(13, 2) < 1) then
        Talk(1, "no", "Ng­¬i kh«ng cã quyÒn h¹n qu©n sù cña thŞ téc, kh«ng thÓ mua ChiÕn Kú ThŞ Téc.")
        return
    end

    -- ÅĞ¶ÏÊÏ×å×ÊÔ´
    local num
    for i = 2, 6 do
        num = GetTongRes(i, 2)
        if (num < 300) then
            Talk(1, "no", "Tµi nguyªn thŞ téc kh«ng ®ñ, kh«ng thÓ mua ChiÕn kú.")
            return
        end
    end

    -- ĞŞ¸ÄÊÏ×å×ÊÔ´
    for i = 2, 6 do
        WasteTongRes(i, 300, 2)
    end

    -- ¼ÓÕ½Æì
    AddNormalItem(3, 1069, 0, 0, 0, 0)

    Talk(1, "no", "Ng­¬i ®· mua 1 ChiÕn Kú ThŞ Téc.")
end
--< ¶´ÌìÕù¶áÕ½ Add By yangtao End 2009/11/17

--> ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang Start 2009/12/9
function build()
    CloseDialog()
    OpenCityTechDialog(2, 1)
end
--< ¶´ÌìÕù¶áÕ½ Add By liuzhiqiang End 2009/12/9
