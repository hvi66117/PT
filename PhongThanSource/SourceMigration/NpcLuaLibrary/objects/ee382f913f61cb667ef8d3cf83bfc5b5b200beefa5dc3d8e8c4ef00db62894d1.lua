--description: æûÍõ
--author: yichuan
--date: 2004/6/10

--author: yaoxin
--date:2008/10/21
-- 1268 Íæ¼ÒÀÛ¼ÆÕ½³¡Ê¤Àû»ı·Ö Õ½³¡µÈ¼¶´ïµ½9¼¶ÇÒµÈ¼¶>=90¼¶µÄÍæ¼Ò£¬²ÎÓëÉÌÖÜÕ½³¡²¢ÇÒÕ½¹ûÊÇ±¾·½Ê¤Àû£¬½«µÃµ½Õ½³¡Ê¤Àû»ı·Ö1·Ö
-- 1268 1byte Ê¤Àû»ı·Ö 2byte ¶Ò»»µÄÀÛ¼Æ´ÎÊı(ÔÜ¶¨ÉÏÏŞÎª4)

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-14

-- ÈÎÎñ±äÁ¿
Task_shangzhou = 1276-- ½Óµ½µÄÈÎÎñÀàĞÍ£¨1000-6000£©£¬¼°½×¶Î£¨1£¬2£©
--add by lisuhui 2009.05.19
Task_ChangeRoleName = 1457                    --µÚÒ»¸ö×Ö½ÚÊÇÈÎÎñ±äÁ¿0:Î´½ÓÈÎÎñ£¬1£ºĞÂÃû¿ÉÓÃ£¬2£ºµÚÒ»´Î¿Û³ıÍ­Ç®£¬3£º¶ş´ÎÈ·ÈÏ£¬4£º¶ş´Î¿ÛÍ­Ç®£¬5£º³É¹¦¡£µÚ¶ş×Ö¼ÇÂ¼µÈ´ıÊ±¼ä
IBBuff_ThreeDays = 293
IBBuff_TwoDays = 293
--end by lisuhui

--Add by guoqun 2009-11-20 begin--
Task_Xitie = 1628     --1Bit 0Ã»ÓĞ½ÓÏ²ÌûÈÎÎñ 1ÒÑ¾­½ÓÏ²ÌûÈÎÎñ
--2Bit 1·¢Ï²ÌûÈÎÎñÒÑ¾­Íê³É
--3Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæ§¼º£¬²¢ÇÒµÃµ½ÌØĞ§
--4Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæûÍõ£¬²¢ÇÒµÃµ½ÌØĞ§
--5Bit 1ÒÑ¾­ËÍÏ²Ìû¸øÔÂÀÏ£¬²¢ÇÒµÃµ½ÌØĞ§
--6Bit 1ÒÑ¾­ËÍÏ²Ìû¸ø²ÊÔÆÏÉ×Ó£¬²¢ÇÒµÃµ½ÌØĞ§
--7Bit 1ÒÑ¾­ËÍÏ²Ìû¸øÎäÍõ£¬²¢ÇÒµÃµ½ÌØĞ§
--8bit 1½ÓËã°Ë×ÖÈÎÎñ
--9Bit 1Íê³ÉËã°Ë×ÖÈÎÎñ
Task_MarryState = 800   --1Byte¼ÇÂ¼Íæ¼Ò½á»é×´Ì¬ 0ÎŞ²Ù×÷,1½øÈëÇó»é×´Ì¬£¬2½øÈë¶©»é×´Ì¬
--2Byte¼ÇÂ¼»éÀñÀàĞÍ 1ÆÕÍ¨ĞÍ 2¾«Æ·ĞÍ(°ÙÄêºÃºÏ) 3ºÀ»ªĞÍ£¨Áú·ï³ÊÏé£©
--3Byte±ê¼ÇÍæ¼ÒÊÇ·ñ¾Ù°ìÁË»éÀñ,ÒÔ¼°»éÀñ½ø¶È 0Ã»ÓĞÁìÈ¡¾Ù°ì»éÀñÈÎÎñ 1´ÓÎ÷ÍõÄ¸´¦¿ªÆô¾Ù°ì»éÀñ(¿ªÊ¼ÓÎ½Ö) 2Íê³ÉÓÎ½Ö£¨¿ÉÒÔÖÖÊ÷ÁË£© 3ÒÑ¾­ÖÖÊ÷(¿ÉÒÔ¾ÙĞĞµäÀñÁË) 4ÒÑ¾ÙĞĞµäÀñ
Task_Partner = 801      --°éÂÂÍæ¼ÒÃû×ÖID

JiehunItem = {
    [1] = { name = "ThiÖp mõng", Item = { 3, 1068, 0, 0, 0, 0 } }, --¼ÓÒ»¸öĞ¡ÉúÃüÇåÂ¶
    [2] = { name = "Tói quµ 10 ThiÖp mõng", Item = { 6, 1, 777, 0, 0, 0 } },
    [3] = { name = "ThiÖp mêi", Item = { 3, 1067, 0, 0, 0, 0 } }, --¼ÓÒ»¸öÖĞ¼¶¾«Ê¯
}

NpcName = { "Trô V­¬ng", "§¾c Kû", "NguyÖt L·o", "Vâ V­¬ng", "ThÓ V©n" }
--Add by guoqun 2009-11-20 end--

set_name = {
    { "Vò Khóc", "Tinh Cang", "Khai Thiªn", "ChÊn §¸n " },
    { "Xİch Tïng", "Th¸i Êt", "Th«ng Thiªn", "Hång Qu©n" },
    { "B¸o ThÇn", "Gi¸c thó", "Lam §iªu", "Kh¸ng Long" }
}
part_name = {
    { "Gi¸p", "ChiÕn Ngoa", "Yªu §¸i", "Kh«i", "Phi Phong" },
    { "§¹o Bµo", "Lı", "C©n", "Qu¸n", "LÖnh" },
    { "Hé Gi¸p", "Ngoa", "Yªu §¸i", "Trô", "KÕt" }
}
task_lvl_2_sel_lvl = { [3] = 5, [9] = 7 }
task_lvl_2_sel_idx = { [3] = 2, [9] = 3 }


-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä;
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ĞòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ğÍê£©; 4th byte µÚ¶ş¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈı¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ğÌâÊıÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ----------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼şÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØĞ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end------------------



--AS GaoJingwei 2009/08/02
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02

function main(sel)
    tasks = {
        { "PhongHáaL«i§µi", "processRingTask"; show = 0 },
        { "Hµnh thiÖn", "pk"; show = 1 },
        { "VŞ quèc L.c«ng", "renwu2"; show = 0 },
        { "T­¬ng quan", "battles"; show = 1 },
        { "Di b¸o", "dongyi"; show = 0 },
        { "Th­ Viªn Hång", "kouxin"; show = 0 },
        { "Ph¸t ThiÖp mêi", "shouxitie"; show = 0 }, --Modified By Guoqun for Bug:¸ÃĞĞ´úÂë±»×¢ÊÍµôÁË
        --{"ÇåÁ¹ÏÄ¼¾","Cool_Summer";show=0},
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    }
    if ((1 == GetTask(Task_shangzhou)) or (2 == GetTask(Task_shangzhou))) and (20 <= GetTask(420)) then
        tasks[3].show = 1;
    end ;
    if (25 == GetTask(597)) and (HaveEventItem(110) >= 1) and (GetTask(593) ~= 1) then
        tasks[5].show = 1;
    end ;
    -- Added by zhaoqingsong at 2008-11-25 Begin
    if (isViewRingTask() == 1) then
        tasks[1].show = 1;
    end ;
    -- Added by zhaoqingsong at 2008-11-25 End

    --Add by guoqun 2009-11-20 begin--
    if (GetTaskBit(Task_Xitie, 1) == 1 and GetTaskBit(Task_Xitie, 2) == 0 and GetSex() == 0) then
        tasks[7].show = 1
    end
    --Added by guoqun 2009-11-20 end --

    --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
    --local nYear, nMonth, nDay = GetYMD();
    --if nYear == 2010 and nMonth == 7 and nDay >= 20 and nDay <= 26 then
    --	tasks[8].show = 1;
    --end
    --Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 End

    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
    --~                     local year, month, day = GetYMD();
    --~                     local hour, min, second = GetHMS();
    --~                     local today = mod(floor(LocalSystemTime()/86400), 255) + 1;

    --~                     local TaskStep = GetTaskByte(TASK_ThreeYears_Fireworks, 1);
    --~                     local TaskTime = GetTaskByte(TASK_ThreeYears_Fireworks, 2);
    --~
    --~                     --Çå¿ÕÖ®Ç°µÄÈÎÎñ£¬ÒÔ·ÀbuffendÎ´Ö´ĞĞ
    --~                     if (TaskTime > 0 and TaskTime ~= today) then
    --~                         TaskStep = 0;
    --~                         TaskTime = 0;
    --~                         SetTask(TASK_ThreeYears_Fireworks, 0);
    --~                         SetTask(TASK_ThreeYears_Questions, 0);
    --~                     end
    --~
    --~                      if (year == 2010 and month == 8 and day == 29
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[7].show = 1;
    --~                     end
    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    SayTask(10121, tasks)
end;

--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
Task_State = 1710    -- ¼ÇÂ¼ÈÎÎñ×´Ì¬
-- 1Byte£ºÈÎÎñ±àºÅ (1-3)
-- 2Byte:  ÈÎÎñ²½Öè
-- 3Byte:  ½ÓÈÎÎñÊ±¼ä
gRewardValue = 374    --È«¾Ö±äÁ¿£¬¿ØÖÆ½±ÀøÎïÆ·²ú³ö

function Cool_Summer()
    no()
    local tasks = {
        { "Giíi thiÖu ho¹t ®éng", "Cool_SummerInfo"; show = 1 },
        { "Giao vËt phÈm", "Cool_SummerReward"; show = 0 },
    }
    if GetLevel() >= 50 then
        tasks[2].show = 1;
    end

    SayTask(" GÇn ®©y thêi tiÕt nãng bøc, §¾c Kû n­¬ng n­¬ng mÖt mái kh«ng vui! Nghe nãi binh t«m t­íng c¸ ë §«ng H¶i cã rÊt nhiÒu b¶o vËt cã thÓ gi¶i nhiÖt. Hy väng anh hïng cã thÓ ®Õn ®ã t×m gióp ta mét sè <c=yel>Tş Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn<c>.", tasks)
end

function Cool_SummerInfo()
    no()
    Talk(3, "no", " <c=yel>Tş Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn<c> mçi thø cã ph­¬ng ph¸p lÊy kh¸c nhau, <c=g>mçi ngµy ng­¬i chØ cã thÓ lÊy ®­îc mét thø<c>.", " Trong ®ã <c=yel>Tş Thö Ch©u<c> cÇn cã<c=g> 3 ng­êi hiÖp lùc hç trî<c>, <c=yel>Thanh L­¬ng T¸n<c> cÇn hµng phôc nhiÒu qu¸i vËt ë §«ng H¶i Thñy Vùc, t­¬ng ®èi dÔ dµng. Cßn <c=yel>TÈm ThÊp Hoµn<c> cã thÓ hµng phôc <c=fire>§«ng H¶i Thñ VÖ<c>. 3 lo¹i vËt phÈm nµy cã thÓ giao dŞch.", " Ho¹t ®éng lÇn nµy tõ 20-7 ®Õn 26-7, ng­êi ch¬i tõ <c=yel>cÊp 50<c> míi cã thÓ tham gia. Mêi c¸c anh hïng h·y mau chãng ®Õn gÆp Tinh Quan, Hoµng Phi Hæ, Thiªn Hïng ®Ó nhËn nhiÖm vô! Chó ı: nÕu hñy bá th× trong ngµy sÏ kh«ng thÓ nhËn l¹i nhiÖm vô!")
end

function Cool_SummerReward()
    no()
    local _, _, nDay = GetYMD()
    if nDay == GetTaskByte(Task_State, 2) then
        Talk(1, "no", " Mçi ngµy chØ cã thÓ nhËn 1 lÇn phÇn th­ëng! Ng­¬i h«m nay ®· nhËn th­ëng råi!")
    else
        Get_SummerReword()
    end
end

function Get_SummerReword()
    no()

    local nTimes = 0
    local szName = ""
    if HaveNormalItem(3, 1124, 0, 0) == 0 and HaveNormalItem(3, 1125, 0, 0) == 0 and HaveNormalItem(3, 1126, 0, 0) == 0 then
        Talk(1, "no", " Ng­¬i kh«ng cã mãn nµo trong Tş Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn c¶!")
    else
        if IsHaveSpaceForTreasure(1) == 0 then
            Talk(1, "no", " Hµnh trang kh«ng ®ñ trèng! Kh«ng thÓ nhËn th­ëng!");
            return
        end
        local nItem1, nItem2, nItem3 = 0, 0, 0;
        g_TaskValue = GetTask(140);
        SetTask(140, 0)
        if HaveNormalItem(3, 1124, 0, 0) > 0 then
            nTimes = nTimes + 1;
            --DelNormalItem(3,1124,0,0);
            --nItem1 = 1;
            SetTaskByte(140, 1, 1);
            if szName ~= "" then
                szName = szName .. ", Tş Thö Ch©u";
            else
                szName = "Tş Thö Ch©u";
            end
        end

        if HaveNormalItem(3, 1125, 0, 0) > 0 then
            nTimes = nTimes + 1;
            --DelNormalItem(3,1125,0,0);
            --nItem2 = 1;
            SetTaskByte(140, 2, 1);
            if szName ~= "" then
                szName = szName .. ", Thanh L­¬ng T¸n";
            else
                szName = "Thanh L­¬ng T¸n";
            end
        end

        if HaveNormalItem(3, 1126, 0, 0) > 0 then
            nTimes = nTimes + 1;
            --DelNormalItem(3,1126,0,0);
            --nItem3 = 1;
            SetTaskByte(140, 3, 1);
            if szName ~= "" then
                szName = szName .. ", TÈm ThÊp Hoµn";
            else
                szName = "TÈm ThÊp Hoµn";
            end
        end
        if nTimes == 3 then
            MsgBox(" Ng­¬i ®· thu thËp ®ñ nguyªn liÖu! Giao cho ta chø?", "Random_Reward", "no")
            --Random_Reward()
        else
            SetTaskByte(140, 4, nTimes)
            MsgBox(" Trong 3 mãn Tş Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn ng­¬i chØ cã <c=g>" .. szName .. "<c>. Cã thÓ giao dŞch víi ng­êi ch¬i kh¸c ®Ó cã ®ñ b¶o vËt. NÕu chØ nép bao nhiªu ®©y th«i sÏ kh«ng thÓ nhËn ®­îc phÇn th­ëng tÆng thªm! Giao chø?", "Get_Reward", "no")
        end

        --Talk(1, "no", "Ğ»Ğ»Äã´øÀ´µÄ<c=g>"..szName.."<c>£¬Ò»µãĞ¡ÒâË¼£¬ÇëÊÕÏÂ°É£¡");
    end
end

function Get_Reward()
    no()
    if GetTaskByte(140, 1) > 0 then
        if HaveNormalItem(3, 1124, 0, 0) == 0 then
            Talk(1, "no", "<c=yel>Tş Thö Ch©u<c> ®· mÊt, kh«ng thÓ nhËn th­ëng!")
            return
        else
            DelNormalItem(3, 1124, 0, 0);
        end
    end

    if GetTaskByte(140, 2) > 0 then
        if HaveNormalItem(3, 1125, 0, 0) == 0 then
            Talk(1, "no", "<c=yel>Thanh L­¬ng T¸n<c> ®· mÊt, kh«ng thÓ nhËn th­ëng!")
            return
        else
            DelNormalItem(3, 1125, 0, 0);
        end
    end

    if GetTaskByte(140, 3) > 0 then
        if HaveNormalItem(3, 1126, 0, 0) == 0 then
            Talk(1, "no", "<c=yel>TÈm ThÊp Hoµn<c> ®· mÊt, kh«ng thÓ nhËn th­ëng!")
            return
        else
            DelNormalItem(3, 1126, 0, 0);
        end
    end

    local nExp = 1000 * GetLevel() * GetTaskByte(140, 4);
    AddOwnExp(nExp)
    Msg2Player("B¹n nh©n ®­îc" .. nExp .. "kinh nghiÖm")
    TopMessage("B¹n nh©n ®­îc" .. nExp .. "kinh nghiÖm")
    local _, _, nDay = GetYMD()
    SetTaskByte(Task_State, 2, nDay)

    Talk(1, "no", " MÆc dï ng­¬i kh«ng cã ®ñ vËt phÈm ta cÇn, nh­ng ta vÉn ch©n thµnh c¶m t¹!")
    SetTask(140, g_TaskValue);
end

function Random_Reward()
    no()
    local i = random(1, 1000)
    local _, _, nDay = GetYMD()

    if HaveNormalItem(3, 1124, 0, 0) == 0 or HaveNormalItem(3, 1125, 0, 0) == 0 or HaveNormalItem(3, 1126, 0, 0) == 0 then
        Talk(1, "no", "VËt phÈm cã mãn ®· mÊt, kh«ng thÓ giao nhiÖm vô!");
        return
    end

    DelNormalItem(3, 1124, 0, 0);
    DelNormalItem(3, 1125, 0, 0);
    DelNormalItem(3, 1126, 0, 0);

    if GetGlobalValueByte(gRewardValue, 4) ~= nDay then
        SetGlobalValue(gRewardValue, 0);
        SetGlobalValueByte(gRewardValue, 4, nDay);
    end

    local _, _, nDay = GetYMD()
    SetTaskByte(Task_State, 2, nDay)

    local nExp = 1000 * GetLevel() * 3
    AddOwnExp(nExp)
    Msg2Player("B¹n nh©n ®­îc" .. nExp .. "kinh nghiÖm")

    local szExtraReward = "";
    if i <= 300 then
        Earn(100000)
        Msg2Player("B¹n may m¾n nhËn ®­îc 10 v¹n b¹c!")
        szExtraReward = "10 v¹n b¹c"
    elseif i > 300 and i <= 400 then
        --Ò°Íâ
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1) --¼ÓÒ»¸öÒ°Íâ´«ËÍ·û
        Msg2Player("B¹n may m¾n nhËn ®­îc 1 Di ngo¹i phï!")
        szExtraReward = "Di ngo¹i phï"
        AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 1)
    elseif i > 400 and i <= 500 then
        --¾­Ñé1.5±¶buff
        AddIBBuff(176, 60 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i t¨ng 1.5 lÇn kinh nghiÖm trong 1 giê")
        szExtraReward = " tr¹ng th¸i t¨ng 1.5 lÇn kinh nghiÖm trong 1 giê"
    elseif i > 500 and i <= 600 then
        --¼¼ÄÜ¾­Ñé2±¶ 60·ÖÖÓ
        AddIBBuff(330, 60 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i nh©n 2 kinh nghiÖm kü n¨ng trong 1 giê")
        szExtraReward = " tr¹ng th¸i nh©n 2 kinh nghiÖm kü n¨ng trong 1 giê"
    elseif i > 600 and i <= 650 then
        --100Íò·âÉñ±Ò
        Earn(1000000)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
        szExtraReward = " 100 v¹n b¹c"
        AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
    elseif i > 650 and i <= 700 then
        --Ìì½µ²ÆÉñbuff
        AddIBBuff(228, 30 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i ThÇn Tµi trong 30 phót.")
        szExtraReward = " tr¹ng th¸i ThÇn Tµi trong 30 phót."
    elseif i > 700 and i <= 750 then
        --ÈÕÔÂÕæÆø£¨°ó¶¨£©
        AddNormalItemBind(8, 163, 4, 0, 0, 0, 1) --¼ÓÒ»¸öÈÕÔÂÕæÆø
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 NhËt NguyÖt Ch©n Khİ!")
        szExtraReward = "Ch©n Khİ"
        AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
    elseif i > 750 and i <= 800 then
        --ÉúÃüÇåÂ¶£¨°ó¶¨£©
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1) --¼ÓÒ»¸öÉúÃüÇåÂ¶
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Sinh MÖnh Thanh Lé!")
        szExtraReward = " 1 Sinh MÖnh Thanh Lé"
        AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
    elseif i > 800 and i <= 850 then
        --ÈçÒâ¾í1¸ö
        if GetGlobalValueByte(gRewardValue, 1) < 30 then
            for i = 1, 2 do
                AddNormalItemPile(3, 138, 0, 0, 0, 0) --¼ÓÒ»¸öÈçÒâÈ¯
            end
            SetGlobalValueByte(gRewardValue, 1, GetGlobalValueByte(gRewardValue, 1) + 1)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 2 Nh­ ı Khuyªn!")
            szExtraReward = " 2 Nh­ ı Khuyªn"
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
        end
    elseif i > 850 and i <= 860 then
        --Áé±¦5¸ö
        if GetGlobalValueByte(gRewardValue, 2) < 10 then
            AddBindCoin(500)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 5 TiÒn ®ång!")
            szExtraReward = " 5 TiÒn ®ång"
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 10)
            SetGlobalValueByte(gRewardValue, 2, GetGlobalValueByte(gRewardValue, 2) + 1);
        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"
        end
    elseif i > 860 and i <= 999 then
        --³¬¼¶»Ø³Ç·û1¸ö
        AddNormalItemBind(8, 291, 2, 0, 0, 0, 1)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Siªu cÊp håi thµnh phï!")
        szExtraReward = " 1 Siªu cÊp håi thµnh phï"
        AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
    else
        --ÈçÒâ¾í100¸ö
        if GetGlobalValueByte(gRewardValue, 3) == 0 then
            for i = 1, 100 do
                AddNormalItemPile(3, 138, 0, 0, 0, 0)
            end ; --¼Ó100¸öÈçÒâÈ¯
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 Nh­ ı Khuyªn!")
            szExtraReward = " 100 Nh­ ı Khuyªn"
            SetGlobalValueByte(gRewardValue, 3, GetGlobalValueByte(gRewardValue, 3) + 1)
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 20)
        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 5)
        end
    end
    TopMessage("Chóc mõng b¹n nhËn ®­îc" .. szExtraReward);
    WriteLog(" ho¹t ®éng Thanh l­¬ng h¹ quı, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc " .. szExtraReward);
    Talk(1, "no", "Trô V­¬ng: §a t¹ anh hïng ®· t×m gióp ra c¸c vËt phÈm nµy. Xin tÆng anh hïng <c=yel>" .. szExtraReward .. "<c> vµ <c=yel>" .. nExp .. " kinh nghiÖm<c>!");
end
--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 End

--Add by guoqun 2009-11-20 begin--
function shouxitie()
    CloseDialog()
    if (GetTaskBit(Task_Xitie, 4) == 1) then
        Talk(1, "no", " Chóc hai ng­êi B¸ch niªn hßa hîp!")
        return
    end
    local b_pos = pos_ok(500)  -- NoticeHere Õâ¸öÖµÓ¦¸ÃµÃµ÷Õû
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>30£©
        Talk(1, "no", " T©n n­¬ng c¸ch ng­¬i qu¸ xa, xin l¹i gÇn nhau thªm chót n÷a!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", " T©n n­¬ng kh«ng trong khu vùc nµy, hai ng­êi ph¶i ë bªn c¹nh nhau míi ®­îc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "H«n lÔ lµ ngµy ®¹i sù cña 2 ng­êi!")
        return
    elseif (b_pos == 1) then
        local qingtie = JiehunItem[3].Item
        if (HaveNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4]) == 0) then
            Talk(1, "no", " B»ng h÷u kh«ng mang theo ThiÖp mêi, sao vµo ®­îc?")
            return
        end
        DelNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4])
        SetTaskBit(Task_Xitie, 4, 1)
        local str = ""

        if (GetTaskBit(Task_Xitie, 4) == 0) then
            if (str == "") then
                str = NpcName[1]
            else
                local tep = str
                str = tep .. "," .. NpcName[1]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 0) then
            if (str == "") then
                str = NpcName[2]
            else
                local tep = str
                str = tep .. "," .. NpcName[2]
            end
        end

        if (GetTaskBit(Task_Xitie, 5) == 0) then
            if (str == "") then
                str = NpcName[3]
            else
                local tep = str
                str = tep .. "," .. NpcName[3]
            end
        end

        if (GetTaskBit(Task_Xitie, 6) == 0 and GetTaskByte(Task_MarryState, 2) == 3) then
            if (str == "") then
                str = NpcName[5]
            else
                local tep = str
                str = tep .. "," .. NpcName[5]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskBit(Task_Xitie, 6) == 1 and GetTaskByte(Task_MarryState, 2) == 3) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        elseif (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskByte(Task_MarryState, 2) == 2) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        else
            TaskNote(1507, 0, str, "")
        end
        TeamAction("showtalk", 0, 0, 0)
    end
end

function showtalk()
    CloseDialog()
    SetTaskBit(Task_Xitie, 4, 1)
    Talk(2, "no", " Chóc mõng hai ng­êi! TrÉm cã cÊp sù kh«ng ®Õn kŞp tham dù! Xin tÆng T©n lang 1 con B¹ch m·, h·y c­ìi lªn nã ®i ®ãn T©n n­¬ng nhĞ!", " §óng råi! H«n lÔ sau khi kÕt thóc, sè ThiÖp mõng cßn d­ cã thÓ ®æi thµnh hång bao ph¸t cho quan kh¸ch!")
end

function teamTaskNote(taskid, index)
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    TaskNote(taskid, index)
    PlayerIndex = n
    TaskNote(taskid, index)
    PlayerIndex = i
end

function pos_ok(distance)
    -- ·µ»ØÖµ£º1 OK  2Á½ÈËÔÚÍ¬Ò»ÕÅµØÍ¼£¬µ«ÊÇ¾àÀëÌ«Ô¶ 3Á½ÈË²»ÔÚÍ¬Ò»ÕÅµØÍ¼ 4Á½ÈËµÄ×é¶Ô·½Ê½´íÎó
    if (GetMateTask(Task_Partner) ~= GetNameID() or GetMateNameID() ~= GetTask(Task_Partner)) then
        --×é¶Ó·½Ê½´íÎó
        return 4
    end

    local mapid_male, x_male, y_male = GetWorldPos()
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    PlayerIndex = n
    local mapid_female, x_female, y_female = GetWorldPos()
    local w = GetName()
    PlayerIndex = i                --»¹Ô­PlayerIndex

    if (mapid_female == mapid_male) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>distance£©
        if (((x_male * 32 - x_female * 32) ^ 2 + (y_male * 32 - y_female * 32) ^ 2) > distance * distance) then
            -- ¸Ã²»¸Ã³ËÒÔ32ÄØ£¿£¿£¿NoticeHere
            return 2
        end
    else
        -- °éÂÂ²»ÔÚµ±Ç°µØÍ¼
        return 3
    end
    return 1
end

function set_xitiebit(bit)
    SetTaskBit(Task_Xitie, bit, 1)
end
--Add by guoqun 2009-11-20 end--

function battles()
    battletasks = {
        { "§¼ng cÊp", "renwu3"; show = 1 },
        { "PhÇn th­ëng", "org_book"; show = 1 },
    }
    SayTask(10121, battletasks)
end;

function pk()
    MsgBox(14203, "yes_1", "no")
end;

function yes_1()
    MsgBox(14204, "no")
end

function renwu2()
    if (1 == GetTask(Task_shangzhou)) or (2 == GetTask(Task_shangzhou)) then
        --421=1Ê±Íê³ÉÈÎÎñ£¬=2Ê±Íê³ÉÈÎÎñÇÒ±¾³¡Ê¤Àû
        if ((23 == GetTask(420)) or (29 == GetTask(420))) and (GetTask(373) == 1) then
            reward_add()
        else
            Talk(1, "no", 14205)
            reward_normal()
        end
    else
        CloseDialog()
    end
end

function no()
    CloseDialog()
end;

function renwu3()
    local sz_level
    if (GetTask(420) >= 20) then
        sz_level = GetTask(420) - 20
    else
        sz_level = GetTask(420)
    end
    Talk(1, "no", "§¼ng cÊp chiÕn tr­êng hiÖn t¹i cña ng­¬i lµ <c=g>" .. sz_level .. "<c>.")
end

function reward_normal()
    local sz_level = GetTask(420) - 20
    TaskNote(85, -1)

    if (10 == sz_level) then
        AddOwnExp(GetLevel() * (1000 + GetTask(Task_shangzhou) * 1000) * 2);--½±Àø£¬°üÀ¨Ê¤Àû½±Àø£¨´º½Ú»î¶¯¾­ÑéË«±¶£©
    else
        AddOwnExp(GetLevel() * (sz_level * 100 + GetTask(Task_shangzhou) * 1000) * 2);--½±Àø£¬°üÀ¨Ê¤Àû½±Àø£¨´º½Ú»î¶¯¾­ÑéË«±¶£©
        if (4 == sz_level) and (60 > GetLevel()) then
            Msg2Player("§¼ng cÊp cña b¹n ch­a ®Õn 60, kh«ng thÓ vµo chiÕn tr­êng Th­¬ng Chu.")
        else
            if (1 == GetTask(373)) then
                --¾­ÑéÖµÒÑÂú£¬µÈ¼¶ÌáÉı
                SetTask(420, sz_level + 1)
                SetTask(373, 0)
                Msg2Player("§¼ng cÊp chiÕn tr­êng cña ng­¬i t¨ng" .. GetTask(420))
            elseif (GetTask(373) < 1) and (GetTask(373) >= 0) then
                --¾­ÑéÖµÎ´Âú£¬¾­ÑéÖµ+1
                SetTask(373, GetTask(373) + 1)
            else
                --¾­ÑéÖµÒç³ö»òÈ¡µÃ´íÎóÖµ£¬Ö±½ÓÖÃÎª1
                SetTask(373, 1)
            end
        end
    end
    SetTask(Task_shangzhou, 0)
end

function reward_add()
    local sz_level = GetTask(420) - 20
    local sel_idx = task_lvl_2_sel_idx[sz_level]
    if (sel_idx ~= nil) then
        local sel_type = GetPlayerType() + 1
        local item_list = {}
        if (sz_level == 9) then
            for i = 2, 4 do
                item_list[i - 1] = set_name[sel_type][sel_idx] .. part_name[sel_type][i] .. "/item_" .. i
            end ;
            Say(14206, 3, item_list)
        else
            for i = 1, 5 do
                item_list[i] = set_name[sel_type][sel_idx] .. part_name[sel_type][i] .. "/item_" .. i
            end
            Say(14206, 5, item_list)
        end
    end
end

function item_1()
    CloseDialog()
    local sz_level = GetTask(420) - 20
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> ®¼ng cÊp chiÕn tr­êng t¨ng" .. sz_level .. ", <c=g> ®­îc Trô V­¬ng<c> tÆng <c=g>" .. set_name[player_type][sel_idx] .. part_name[player_type][1] .. "<c>.", 20)
        AddNormalItem(0, 2, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end
end

function item_2()
    CloseDialog()
    local sz_level = GetTask(420) - 20
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> ®¼ng cÊp chiÕn tr­êng t¨ng" .. sz_level .. ", <c=g> ®­îc Trô V­¬ng<c> tÆng <c=g>" .. set_name[player_type][sel_idx] .. part_name[player_type][2] .. "<c>.", 20)
        AddNormalItem(0, 5, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end

end

function item_3()
    CloseDialog()
    local sz_level = GetTask(420) - 20
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> ®¼ng cÊp chiÕn tr­êng t¨ng" .. sz_level .. ", <c=g> ®­îc Trô V­¬ng<c> tÆng <c=g>" .. set_name[player_type][sel_idx] .. part_name[player_type][3] .. "<c>.", 20)
        AddNormalItem(0, 6, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end
end
function item_4()
    CloseDialog()
    local sz_level = GetTask(420) - 20
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> ®¼ng cÊp chiÕn tr­êng t¨ng" .. sz_level .. ", <c=g> ®­îc Trô V­¬ng<c> tÆng <c=g>" .. set_name[player_type][sel_idx] .. part_name[player_type][4] .. "<c>.", 20)
        AddNormalItem(0, 7, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end
end
function item_5()
    CloseDialog()
    local sz_level = GetTask(420) - 20
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> ®¼ng cÊp chiÕn tr­êng t¨ng" .. sz_level .. ", <c=g> ®­îc Trô V­¬ng<c> tÆng <c=g>" .. set_name[player_type][sel_idx] .. part_name[player_type][5] .. "<c>.", 20)
        AddNormalItem(0, 9, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end
end

function dongyi()
    if (HaveEventItem(110) >= 1) then
        if (GetTask(592) == 0) then
            Talk(1, "no", 14207)
            SetTask(593, 1)
            AddOwnExp(4000) --¾­Ñé½±Àø
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
            TopMessage(14208)
        elseif (GetTask(592) == 1) then
            DelEventItem(110)
            SetTask(593, 1)
            Talk(1, "no", 14207)
            SetTask(597, 26)
            TaskNote(35, 33)
            AddOwnExp(4000) --¾­Ñé½±Àø
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
            TopMessage(14208)
            Msg2Player("Håi b¸o §Æng Cöu C«ng!")
        end ;
    end ;
end;

book_part = { "Ph¸ Qu©n*Tr¶m Long", "Ph¸ Qu©n*Nguyªn Thñy", "Ph¸ Qu©n*ThÇn ¦ng" }
book_name = {
    { "Yªu §¸i", "ChiÕn Ngoa", "Gi¸p" },
    { "C©n", "Lı", "§¹o Bµo" },
    { "Yªu §¸i", "Ngoa", "Hé Gi¸p" },
}
tbDanhNgoc = {
    { Name = "Xİch Viªm Danh Ngäc (Ch­a mµi)", ID = 256, },
    { Name = "Thanh Minh Danh Ngäc (Ch­a mµi)", ID = 263, },
    { Name = "Tö Hµ Danh Ngäc (Ch­a mµi)", ID = 270, },
}

function org_book()
    local point = GetByte(GetTask(1268), 1) --µ±Ç°·ÖÊı
    if (point >= 4) then
        local item_list = {
            "Xİch Viªm Danh Ngäc (Ch­a mµi)/item_stone",
            "Thanh Minh Danh Ngäc (Ch­a mµi)/item_stone",
            "Tö Hµ Danh Ngäc (Ch­a mµi)/item_stone",
        }
        Say("Chóc mõng ng­¬i xuÊt s¾c tİch lòy ®­îc 4 ®iÓm chiÕn c«ng. Xin lùa chän mét phÇn th­ëng Danh Ngäc cho m×nh!", getn(item_list), item_list)
    else
        Talk(1, "no", "Ng­êi ch¬i ®¼ng cÊp tõ 90 vµ ®¹t ®Õn 9 cÊp chiÕn tr­êng, mçi lÇn th¾ng lîi sÏ ®­îc 1 ®iÓm chiÕn c«ng. Khi ®¹t 4 ®iÓm chiÕn c«ng sÏ nhËn ®­îc 1 §å phæ trang bŞ Cam. HiÖn ng­¬i ®· tİch lòy ®­îc <c=g>" .. point .. "<c>.")
    end
end

function item_stone(nIndex)
    CloseDialog()
    if (nIndex < 0 or nIndex >= 3) then
        Talk(1, "no", "Chän sai, h·y chän l¹i.")
        return
    end
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn 3 lÇn Danh ngäc. Giê ph¶i cã <c=g>2 viªn Thä S¬n Th¹ch<c> míi cã thÓ nhËn tiÕp!", "org_ngoc", "no")
        else
            AddNormalItemPile(3, tbDanhNgoc[nIndex + 1].ID, 0, 0, 0, 0)
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> tİch lòy ®iÓm chiÕn c«ng, ®­îc Trô V­¬ng ban th­ëng <c=g>" .. tbDanhNgoc[nIndex + 1].Name .. "<c>! Xin chóc mõng!", 3)
            TopMessage("B¹n nhËn ®­îc <c=g>" .. tbDanhNgoc[nIndex + 1].Name)
            Msg2Player("B¹n nhËn ®­îc <c=g>" .. tbDanhNgoc[nIndex + 1].Name)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function org_ngoc()
    if (HaveNormalItem(3, 135, 0, 0) > 1) then
        local item_list = {
            "Xİch Viªm Danh Ngäc (Ch­a mµi)/item_stone2",
            "Thanh Minh Danh Ngäc (Ch­a mµi)/item_stone2",
            "Tö Hµ Danh Ngäc (Ch­a mµi)/item_stone2",
        }
        Say("Giê ph¶i cã <c=g>2 viªn Thä S¬n Th¹ch<c> míi cã thÓ nhËn tiÕp. Xin lùa chän mét phÇn th­ëng Danh Ngäc cho m×nh!", getn(item_list), item_list)
    else
        Talk(1, "no", "Kh«ng ®ñ 2 viªn Thä S¬n Th¹ch!.")
    end
end

function item_stone2(nIndex)
    CloseDialog()
    if (nIndex < 0 or nIndex >= 3) then
        Talk(1, "no", "Chän sai, h·y chän l¹i.")
        return
    end
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            AddNormalItemPile(3, tbDanhNgoc[nIndex + 1].ID, 0, 0, 0, 0)
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> tİch lòy ®iÓm chiÕn c«ng, ®­îc Trô V­¬ng ban th­ëng <c=g>" .. tbDanhNgoc[nIndex + 1].Name .. "<c>! Xin chóc mõng!", 3)
            TopMessage("B¹n nhËn ®­îc <c=g>" .. tbDanhNgoc[nIndex + 1].Name)
            Msg2Player("B¹n nhËn ®­îc <c=g>" .. tbDanhNgoc[nIndex + 1].Name)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch. Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr×  cã b¶o vËt g× ®ã, ng­¬i h·y ®Õn ®ã xem thö!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book1()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn 3 lÇn §å phæ Ph¸ Qu©n. Giê ph¶i cã <c=g>2 viªn Thä S¬n Th¹ch<c> míi cã thÓ nhËn tiÕp!", "book12", "no")
        else
            fgetBook(1, 280)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book12()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(1, 280)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch. Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr×  cã b¶o vËt g× ®ã, ng­¬i h·y ®Õn ®ã xem thö!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book2()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn 3 lÇn §å phæ Ph¸ Qu©n. Giê ph¶i cã <c=g>2 viªn Thä S¬n Th¹ch<c> míi cã thÓ nhËn tiÕp!", "book22", "no")
        else
            fgetBook(2, 283)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book22()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(2, 283)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch. Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr×  cã b¶o vËt g× ®ã, ng­¬i h·y ®Õn ®ã xem thö!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book3()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn 3 lÇn §å phæ Ph¸ Qu©n. Giê ph¶i cã <c=g>2 viªn Thä S¬n Th¹ch<c> míi cã thÓ nhËn tiÕp!", "book32", "no")
        else
            fgetBook(3, 289)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function book32()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(3, 289)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch. Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr×  cã b¶o vËt g× ®ã, ng­¬i h·y ®Õn ®ã xem thö!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a tİch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhĞ!")
    end
end

function fgetBook(key, itemidx)
    --²¿¼şÀàĞÍ, itemÆğµã
    local tp = GetPlayerType() + 1
    local str = "§å phæ:" .. book_part[tp] .. book_name[tp][key]
    if (tp == 1) and (key == 3) then
        str = "§å phæ:Ph¸ Qu©n*Tr¶m Long Gi¸p"
    end
    AddGlobalCountNews("<c=g>" .. GetName() .. "<c> tİch lòy ®iÓm chiÕn c«ng, ®­îc Trô V­¬ng ban th­ëng <c=g>" .. str .. "<c>! Xin chóc mõng!", 3)
    TopMessage("B¹n nhËn ®­îc <c=g>" .. str)
    Msg2Player("B¹n nhËn ®­îc <c=g>" .. str)
    AddNormalItem(6, 1, itemidx + tp, 0, 0, 0)
end

-- Added by zhaoqingsong at 2008-11-24 Begin
-- ·ç»ğÂÖ´óÈü»î¶¯

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ
-- 2 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1 Î÷ÃÅæûÍõ£º2 ÄÏÃÅæûÍõ£º3 ¶«ÃÅæûÍõ£º4 æûÍõ
Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278    -- ±¨ÃûÊ±¼ä
Task_Ring_BindingIndex = 1279    -- °ó¶¨µÄNpcIndex
Task_Ring_BindingID = 1280    -- °ó¶¨µÄNpcID

Task_Ring_NPC_FreezeTime = 1    -- ÀäÈ´Ê±¼ä´Á
Task_Ring_NPC_BuffATime = 2    -- BuffAÊ±¼ä´Á
Task_Ring_NPC_BuffBTime = 3    -- BuffBÊ±¼ä´Á
Task_Ring_NPC_BuffCTime = 4    -- BuffCÊ±¼ä´Á
Task_Ring_NPC_BuffDTime = 5    -- BuffDÊ±¼ä´Á

Global_Ring_EntryCount = 164 -- È«¾Ö±äÁ¿£¬±¨ÃûÈËÊı

Buff_Ring_Going = 487   -- ½øĞĞBuff
Buff_Ring_BuffA = 488   -- ËÙ¶È¼õ°ëBuff
Buff_Ring_BuffB = 489   -- ·´ÏòÅÜ¶¯Buff
Buff_Ring_BuffC = 490   -- ËÙ¶È¼Ó±¶Buff
Buff_Ring_BuffD = 491   -- ¼õËÙ10%Buff

Task_Info_Ring = 1020   -- ·ç»ğÂÖ´óÈüF11

Task_Ring_Match_Second = 600 -- Ê®·ÖÖÓÒ»³¡±ÈÈü

Save_Section_Ring_Date = "RingDate"
Save_Section_Ring_Usetime = "RingUsetime"
Save_Section_Ring_Playername = "RingPlayername"

Save_Ring_Ranking_Usetime = "RingRankingUsetime"
Save_Ring_Ranking_Playername = "RingRankingPlayername"


-- ¸÷ÃÅ¿ÚµÄÒ½Éú×ø±ê
Doctor_XY = {
    { x = 203 * 8, y = 184 * 16, desc = "§¹i phu T©y m«n" },
    { x = 197 * 8, y = 200 * 16, desc = "§¹i phu Nam m«n" },
    { x = 227 * 8, y = 201 * 16, desc = "§¹i phu §«ng m«n" },
    { x = 0, y = 0, desc = "Trô V­¬ng" },
}

--Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
Noon_Active_Event = 7    --Îç¼ä»î¶¯ÊÀ½çÊÂ¼ş
Noon_Active_Event_Day = 1    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-Ê±¼ä±äÁ¿
Noon_Active_Event_Num = 2    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-»î¶¯ĞòºÅ

function Check_NoonActive_ON(nNum)
    if (IsWorldEventExist(Noon_Active_Event) == 0) then
        return 0
    end
    local nCurDay = floor(LocalSystemTime() / 86400);

    if GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Day) == nCurDay
            and GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Num) == nNum then
        return 1
    end

    return 0
end
--Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End

-- ÊÇ·ñÏÔÊ¾·ç»ğÂÖ´óÈü
function isViewRingTask()
    if (GetLevel() < 50) then
        return 0
    end
    ----Modify by gaojignwei at 2009/4/7 begin-----
    --	if (GetOnlineTime() < 3600) then
    --		return 0
    --	end
    ----Modify by gaojignwei at 2009/4/7 end-----
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()

    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if (H < 11 or H >= 14) then
            return 0
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            return 0
        end
    end
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin

    local taskStatus = GetTaskByte(Task_Ring_Status, 1)
    if (taskStatus == 1) then
        return 1
    end
    return 0
end

-- ´¦Àí·ç»ğÂÖ´óÈü°´Å¥ÏàÓ¦
function processRingTask()
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if (H < 11 or H >= 14) then
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "§· hÕt thêi gian tham gia thi ®Êu råi. TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhĞ!")
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "§· hÕt thêi gian tham gia thi ®Êu råi. TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhĞ!")
            return
        end
    end
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End
    local localTime = LocalSystemTime()

    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local nStartHour = 19
    if nNoonActiveOn > 0 then
        nStartHour = 11
    end
    local taskTime = mod(localTime, 86400) - 3600 * nStartHour
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End

    local taskNumber = floor(taskTime / Task_Ring_Match_Second) + 1
    local taskGotime = mod(taskTime, Task_Ring_Match_Second)
    local taskStep = GetTaskByte(Task_Ring_Status, 2)
    local lastEntryTime = GetTask(Task_Ring_Accept_Time)

    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local entryNumber = floor((mod(lastEntryTime, 86400) - 3600 * nStartHour) / Task_Ring_Match_Second) + 1
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    if (localTime > (lastEntryTime + 86400)) then
        -- Çå¿ÕÖ®Ç°ÎŞĞ§µÄÈÎÎñĞÅÏ¢
        SetTask(Task_Ring_Status, 0)
        TaskNote(Task_Info_Ring, -1)
        Talk(1, "no", "LÇn thi ®Êu tr­íc ng­¬i vÉn ch­a hoµn tÊt. Phong Háa L«i ®µi l¹i më råi, mau ®Õn LÔ quan b¸o danh ®i!")
        return
    elseif (entryNumber < taskNumber) then
        SetTask(Task_Ring_Status, 0)
        TaskNote(Task_Info_Ring, -1)
        Talk(1, "no", "§· hÕt thêi gian b¸o danh trËn nµy råi! TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhĞ!")
        return
    end
    local remainSecond = Task_Ring_Match_Second - taskGotime - 1
    local leaveTime = (remainSecond < 60) and "" or ("" .. floor(remainSecond / 60) .. "m")
    leaveTime = leaveTime .. mod(remainSecond, 60) .. "s"
    if (taskStep == 0) then
        Talk(1, "no", "Trô V­¬ng#ºNhÊp chuét ph¶i vµo Hçn Thiªn L¨ng sÏ kİch ®éng ®­îc Phong Háa lu©n. Thêi gian thi ®Êu cßn <c=g>" .. leaveTime .. "<c>.")
        return
    elseif (taskStep ~= 4) then
        Talk(1, "no", "H×nh nh­ ng­¬i ®i sai h­íng råi, ph¶i mang Phong Háa lu©n ®Õn <c=g>" .. Doctor_XY[taskStep].desc .. "<c>. Thêi gian thi ®Êu cßn <c=g>" .. leaveTime .. "<c>.")
        return
    else
        local npcMapid, npcx, npcy = GetNpcWorldPos(DialogNpcIdx)
        local ringIndex = GetTask(Task_Ring_BindingIndex)
        local ringID = GetTask(Task_Ring_BindingID)
        if (mod(ringID + 2 ^ 32, 2 ^ 31) ~= mod(GetNpcID(ringIndex), 2 ^ 31)) then
            --Òì³£Çé¿öÏÂÇ¿»¯³ÌĞò
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "TiÕc qu¸! TrËn ng­¬i muèn tham gia ®· qua råi! TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhĞ!")
            return
        end
        local ringMapid, ringx, ringy = GetNpcWorldPos(ringIndex)
        local distance = (ringx - npcx) ^ 2 + (ringy - npcy) ^ 2
        if (distance > 450) then
            Talk(1, "no", "Phong Háa lu©n c¸ch chç ta xa qu¸, nh×n kh«ng thÊy! Cã thÓ mang ®Õn gÇn h¬n chót kh«ng?")
            return
        end
        SetTaskByte(Task_Ring_Status, 1, 0)
        SetTask(Task_Ring_Status, 0)
        DelNpc(ringIndex)
        RemoveIBBuff(Buff_Ring_Going)
        RemoveIBBuff(Buff_Ring_BuffA)
        RemoveIBBuff(Buff_Ring_BuffB)
        RemoveIBBuff(Buff_Ring_BuffC)
        RemoveIBBuff(Buff_Ring_BuffD)
        SetTask(Task_Ring_BindingIndex, 0)
        SetTask(Task_Ring_BindingID, 0)
        TaskNote(Task_Info_Ring, -1)
        --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-27 Begin
        if nNoonActiveOn > 0 then
            SyncBibleState(1614, 3, 1)
            WriteLog("Hoµn thµnh <Phong Háa L«i ®µi> (Buæi tr­a)")
        else
            SyncBibleState(1020, 3, 1)
            WriteLog("Hoµn thµnh <Phong Háa L«i ®µi>")
        end
        --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-27 End
        local multiple = 5000
        if (GetLevel() >= 80) then
            multiple = 8000
        end
        local addExp = GetLevel() * multiple
        AddOwnExp(addExp)
        AddVigour(200)

        local useSecond = localTime - lastEntryTime
        local saveDate = LoadIniInteger(Save_Section_Ring_Date, 1)
        local top1Sec = LoadIniInteger(Save_Section_Ring_Usetime, 1)
        local top2Sec = LoadIniInteger(Save_Section_Ring_Usetime, 2)
        local top3Sec = LoadIniInteger(Save_Section_Ring_Usetime, 3)
        local top1Name = LoadIniString(Save_Section_Ring_Playername, 1)
        local top2Name = LoadIniString(Save_Section_Ring_Playername, 2)
        local top3Name = LoadIniString(Save_Section_Ring_Playername, 3)

        saveDate = (not saveDate) and 0 or saveDate
        top1Sec = (not top1Sec) and 0 or top1Sec
        top2Sec = (not top2Sec) and 0 or top2Sec
        top3Sec = (not top3Sec) and 0 or top3Sec

        local currentDay = floor(LocalSystemTime() / 86400)
        if (saveDate < currentDay) then
            top1Sec, top2Sec, top3Sec = 0, 0, 0
            SaveIniInteger(Save_Section_Ring_Date, 1, currentDay)
            SaveIniInteger(Save_Section_Ring_Usetime, 1, 0)
            SaveIniInteger(Save_Section_Ring_Usetime, 2, 0)
            SaveIniInteger(Save_Section_Ring_Usetime, 3, 0)
        end
        local topArr = {}
        if (top1Sec == 0) then
            topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
        elseif (useSecond < top1Sec) then
            topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
            topArr[getn(topArr) + 1] = { t = top1Sec, n = top1Name }
            if (top2Sec > 0) then
                topArr[getn(topArr) + 1] = { t = top2Sec, n = top2Name }
            end
        else
            topArr[getn(topArr) + 1] = { t = top1Sec, n = top1Name }
            if (top2Sec == 0) then
                topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
            elseif (useSecond < top2Sec) then
                topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
                topArr[getn(topArr) + 1] = { t = top2Sec, n = top2Name }
            else
                topArr[getn(topArr) + 1] = { t = top2Sec, n = top2Name }
                if (top3Sec == 0) then
                    topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
                elseif (useSecond < top3Sec) then
                    topArr[getn(topArr) + 1] = { t = useSecond, n = GetName() }
                else
                    topArr[getn(topArr) + 1] = { t = top3Sec, n = top3Name }
                end
            end
        end
        if (topArr[1]) then
            SaveIniInteger(Save_Section_Ring_Usetime, 1, topArr[1].t)
            SaveIniString(Save_Section_Ring_Playername, 1, topArr[1].n)
        end
        if (topArr[2]) then
            SaveIniInteger(Save_Section_Ring_Usetime, 2, topArr[2].t)
            SaveIniString(Save_Section_Ring_Playername, 2, topArr[2].n)
        end
        if (topArr[3]) then
            SaveIniInteger(Save_Section_Ring_Usetime, 3, topArr[3].t)
            SaveIniString(Save_Section_Ring_Playername, 3, topArr[3].n)
        end
        insertRanking(useSecond, GetName())

        local useSecondStr = (useSecond < 60) and "" or ("" .. floor(useSecond / 60) .. "m")
        useSecondStr = useSecondStr .. mod(useSecond, 60) .. "s"

        --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
        local nFinishTime = "22:00"
        if nNoonActiveOn > 0 then
            nFinishTime = "14:00"
        end
        Msg2Player("Chóc mõng b¹n hoµn thµnh Phong Háa lu©n L«i ®µi. NhËn ®­îc kinh nghiÖm" .. addExp .. " vµ nhËn ®­îc 200 ®iÓm Tinh Lùc, tæng thêi gian " .. useSecondStr .. ", h·y chó ı " .. nFinishTime .. " danh s¸ch Top3 cña trËn chiÕn")
        Talk(1, "no", "Chóc mõng ng­¬i hoµn thµnh Phong Háa lu©n L«i ®µi, xin nhËn phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc, thµnh tİch tæng thêi gian cña ng­¬i trËn nµy lµ <c=g>" .. useSecondStr .. "<c>. Mçi ngµy" .. nFinishTime .. " sau khi tÊt c¶ trËn chiÕn kÕt thóc, 3 ng­êi anh hïng cã thêi gian İt nhÊt sÏ nhËn ®­îc phÇn th­ëng th­ tİn ®Æc biÖt. H·y chó ı!")
        TopMessage("Hoµn thµnh thi ®Êu, nhËn ®­îc kinh nghiÖm" .. addExp .. "Tinh lùc 200")
        --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End
    end
end

function insertRanking(useSecond, playerName)
    local lastSec = LoadIniInteger(Save_Ring_Ranking_Usetime, 10)
    if (useSecond > lastSec and lastSec ~= 0) then
        return
    end
    local rankingArr = {}
    local rankSec = 0
    local rankName = ""
    local hasPlace = 0
    local hasIndex = 1
    for i = 1, 10 do
        rankSec = LoadIniInteger(Save_Ring_Ranking_Usetime, i)
        rankName = LoadIniString(Save_Ring_Ranking_Playername, i)
        rankName = rankName or ""
        rankingArr[i] = { sec = rankSec, name = rankName }
        if (rankName == playerName) then
            if (rankSec <= useSecond) then
                return
            end
            hasPlace = 1
            hasIndex = i
        end
    end
    if (hasPlace == 0) then
        rankingArr[0] = { sec = 0, name = "" }
        local insertIdx = 10
        for i = 10, 0, -1 do
            if (i ~= 0) and (rankingArr[i].sec > useSecond or rankingArr[i].sec == 0) then
                rankingArr[i + 1] = rankingArr[i]
            else
                insertIdx = i + 1
                break
            end
        end
        rankingArr[insertIdx] = { sec = useSecond, name = playerName }
    else
        rankingArr[0] = { sec = 0, name = "" }
        local insertIdx = 10
        for i = hasIndex - 1, 0, -1 do
            if (i ~= 0) and (rankingArr[i].sec > useSecond or rankingArr[i].sec == 0) then
                rankingArr[i + 1] = rankingArr[i]
            else
                insertIdx = i + 1
                break
            end
        end
        rankingArr[insertIdx] = { sec = useSecond, name = playerName }
    end
    for i = 1, 10 do
        SaveIniInteger(Save_Ring_Ranking_Usetime, i, rankingArr[i].sec)
        SaveIniString(Save_Ring_Ranking_Playername, i, rankingArr[i].name)
    end
end

-- Added by zhaoqingsong at 2008-11-25 End

--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ğÌâÊıÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "æûÍõ£ºÓ¢ĞÛ±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~
--~     if (idx == 6) then
--~         Talk(1, "no", "æûÍõ£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ıµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("æûÍõ£ºÇ¡·ê¹ú¼Ê°æÈıÖÜÄê£¬±¾ÍõÉõÊÇ¸ßĞË£¬±¾ÍõÒ²²»ÎªÄÑÄã£¬×¼±¸ÁË¼¸¸öÎÊÌâ£¬ÄãÈôÄÜ»Ø´ğÆäÖĞµÄÒ»¸ö£¬ÎÒ¿ÉÒÔËÍ¸øÄãÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~
--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~
--~     local TABLE_Ques = {
--~         [1] = { quest = "ºÏ³ÉÒÔÏÂÄÄÖÖ·¨±¦ĞèÒª½«¾üÁî£¿",
--~                     option = { [1]  = "ÓñÈçÒâ", [2] = "»ìÔªÖé", [3] = "Õò»êÊ¯", }, },
--~         [2] = { quest = "¶à´ÎÍê³ÉÒÔÏÂÄÄ¸öÈÎÎñ²»»á»ñµÃ40¼¶ÂÌÉ«×°±¸£¿",
--~                     option = { [1]  = "ÍòÏÉÕó", [2] = "»¤»¨Ê¹Õß", [3] = "ÉñÃØ»¨»Ü", }, },
--~         [3] = { quest = "ÒÔÏÂÄÄÖÖ²ÄÁÏ¿ÉÒÔÎ¹ÑøÁé³è£¿",
--~                     option = { [1]  = "ÄıËªÍè", [2] = "Àë»ğÍè", [3] = "ÈÚ±ùÍè", }, },
--~         [4] = { quest = "ÒÔÏÂÄÄÖÖÎïÆ·¿ÉÒÔÔÚÊ¦Í½ÉÌµê¹ºÂò£¿",
--~                     option = { [1]  = "Ö¸ÄÏÖé", [2] = "ÁÙÏÉÂ¶", [3] = "²»ËÀÒ©", }, },
--~         [5] = { quest = "¡¶·âÉñ°ñ¹ú¼Ê°æ¡·2009Äê11ÔÂ27ÈÕÉÏÏßµÄ×ÊÁÏÆ¬Ãû³ÆÊÇ£¿",
--~                     option = { [1]  = "ÌìÉÏÈË¼ä", [2] = "¶´Ìì¸£µØ", [3] = "ÌìÈôÓĞÇé", }, },
--~     }
--~
--~     local seq = {1,2,3};
--~     local i, j = 0, 0;
--~     local temp = 0;
--~     for i = 1, 2 do
--~         j = random(i, 3);
--~         temp = seq[i];
--~         seq[i] = seq[j];
--~         seq[j] = temp;
--~     end
--~
--~     local opt1 = TABLE_Ques[idx].option[seq[1]].."/ThreeYears_FireWorks_Option"..seq[1];
--~     local opt2 = TABLE_Ques[idx].option[seq[2]].."/ThreeYears_FireWorks_Option"..seq[2];
--~     local opt3 = TABLE_Ques[idx].option[seq[3]].."/ThreeYears_FireWorks_Option"..seq[3];
--~
--~     Say("æûÍõ£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

--~ end


--~ function ThreeYears_FireWorks_Option1()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(1);
--~ end


--~ function ThreeYears_FireWorks_Option2()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(2);
--~ end


--~ function ThreeYears_FireWorks_Option3()
--~     CloseDialog();
--~
--~     ThreeYears_FireWorks_Judge(3);
--~ end


--~ function ThreeYears_FireWorks_Judge(choice)
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 2, [2] = 3, [3] = 2, [4] = 3, [5] = 2,};
--~
--~     if (TABLE_Key[idx] == choice) then
--~
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "æûÍõ£ºÓ¢ĞÛËäÈ»´ğ¶ÔÁËÌâÄ¿£¬µ«±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "æûÍõ£ºÓ¢ĞÛ¹ûÈ»²ÅÖÇ¹ıÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ĞÛÁË¡£");
--~
--~         SetTaskByte(TASK_ThreeYears_Questions, 2, 6); --µ±Ç°NPCµÄÌâÄ¿
--~
--~         SetTaskByte(TASK_ThreeYears_Questions, 4, num + 1);

--~         DelNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0);
--~         AddNormalItem(8, G_ThreeYears_1stFireworksId + num + 1, 2, 0, 0, 0);

--~         if (num + 1 < 5) then
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË"..(num + 1).."·İ×£¸£");
--~         else
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË×ã¹»µÄ×£¸£");
--~             WriteLog("»ñµÃÒ»¸öÂúÔØ×£¸£µÄÀñ»¨¡£");
--~             TaskNote(1610, 1);
--~         end
--~
--~     else
--~         Talk(1, "no", "æûÍõ£ºÄãµÄ´ğ°¸²»¶Ô£¬ÇëÖØĞÂ×÷´ğ¡£");
--~     end

--~ end
--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end


