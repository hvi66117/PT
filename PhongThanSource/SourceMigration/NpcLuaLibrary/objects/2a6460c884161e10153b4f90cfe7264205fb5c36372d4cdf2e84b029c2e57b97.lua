require("¼×¹ÇÎÄ»î¶¯.luax")

Task_shangzhou = 1276

Task_ChangeRoleName = 1457
IBBuff_ThreeDays = 293
IBBuff_TwoDays = 293

Task_Xitie = 1628

Task_MarryState = 800

Task_Partner = 801

JiehunItem = {
    [1] = { name = "ThiÖp mõng", Item = { 3, 1068, 0, 0, 0, 0 } },
    [2] = { name = "Tói quµ 10 ThiÖp mõng", Item = { 6, 1, 777, 0, 0, 0 } },
    [3] = { name = "ThiÖp mêi", Item = { 3, 1067, 0, 0, 0, 0 } },
}

NpcName = { "Trô V­¬ng", "§¾c Kû", "NguyÖt L·o", "Vâ V­¬ng", "ThÓ V©n" }

set_name = {
    { "Vò Khóc", "Tinh Cang", "Khai Thiªn", "ChÊn §¸n" },
    { "XÝch Tïng", "Th¸i Êt", "Th«ng Thiªn", "Hång Qu©n" },
    { "B¸o ThÇn", "Gi¸c thó", "Lam §iªu", "Kh¸ng Long" }
}
part_name = {
    { "Gi¸p", "ChiÕn Ngoa", "Yªu §¸i", "Kh«i", "Phi Phong" },
    { "§¹o Bµo", "Lý", "C©n", "Qu¸n", "LÖnh" },
    { "Hé Gi¸p", "Ngoa", "Yªu §¸i", "Trô", "KÕt" }
}
task_lvl_2_sel_lvl = { [3] = 5, [9] = 7 }
task_lvl_2_sel_idx = { [3] = 2, [9] = 3 }

function GetPlayerTaskState()
    return 0, 0
end

function main(sel)
    tasks = {
        { "Phong Háa L«i §µi", "processRingTask"; show = 0 },
        { "Hµnh thiÖn", "pk"; show = 1 },
        { "V× quèc lËp c«ng", "renwu2"; show = 0 },
        { "T­¬ng quan", "battles"; show = 1 },
        { "Di b¸o", "dongyi"; show = 0 },
        { "Th­ Viªn Hång", "kouxin"; show = 0 },
        { "Ph¸t ThiÖp mêi", "shouxitie"; show = 0 },
    }
    if ((1 == GetTask(Task_shangzhou)) or (2 == GetTask(Task_shangzhou))) and (20 <= GetTask(420)) then
        tasks[3].show = 1;
    end ;
    if (25 == GetTask(597)) and (HaveEventItem(110) >= 1) and (GetTask(593) ~= 1) then
        tasks[5].show = 1;
    end ;

    if (GetTaskBit(Task_Xitie, 1) == 1 and GetTaskBit(Task_Xitie, 2) == 0 and GetSex() == 0) then
        tasks[7].show = 1
    end

    SayTask(10121, tasks)
end;

Task_State = 1710

gRewardValue = 374

function Cool_Summer()
    no()
    local tasks = {
        { "Giíi thiÖu ho¹t ®éng", "Cool_SummerInfo"; show = 1 },
        { "Giao vËt phÈm", "Cool_SummerReward"; show = 0 },
    }
    if GetLevel() >= 50 then
        tasks[2].show = 1;
    end

    SayTask(" GÇn ®©y thêi tiÕt nãng bøc, §¾c Kû n­¬ng n­¬ng mÖt mái kh«ng vui! Nghe nãi binh t«m t­íng c¸ ë §«ng H¶i cã rÊt nhiÒu b¶o vËt cã thÓ gi¶i nhiÖt. Hy väng anh hïng cã thÓ ®Õn ®ã t×m gióp ta mét sè <c=yel>Tþ Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn<c>.", tasks)
end

function Cool_SummerInfo()
    no()
    Talk(3, "no", " <c=yel>Tþ Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn<c> mçi thø cã ph­¬ng ph¸p lÊy kh¸c nhau, <c=g>mçi ngµy ng­¬i chØ cã thÓ lÊy ®­îc mét thø<c>.", " Trong ®ã <c=yel>Tþ Thö Ch©u<c> cÇn cã<c=g> 3 ng­êi hiÖp lùc hç trî<c>, <c=yel>Thanh L­¬ng T¸n<c> cÇn hµng phôc nhiÒu qu¸i vËt ë §«ng H¶i Thñy Vùc, t­¬ng ®èi dÔ dµng. Cßn <c=yel>TÈm ThÊp Hoµn<c> cã thÓ hµng phôc <c=fire>§«ng H¶i Thñ VÖ<c>. 3 lo¹i vËt phÈm nµy cã thÓ giao dÞch.", " Ho¹t ®éng lÇn nµy tõ 20-7 ®Õn 26-7, ng­êi ch¬i tõ <c=yel>cÊp 50<c> míi cã thÓ tham gia. Mêi c¸c anh hïng h·y mau chãng ®Õn gÆp Tinh Quan, Hoµng Phi Hæ, Thiªn Hïng ®Ó nhËn nhiÖm vô! Chó ý: nÕu hñy bá th× trong ngµy sÏ kh«ng thÓ nhËn l¹i nhiÖm vô!")
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
        Talk(1, "no", " Ng­¬i kh«ng cã mãn nµo trong Tþ Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn c¶!")
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

            SetTaskByte(140, 1, 1);
            if szName ~= "" then
                szName = szName .. ", Tþ Thö Ch©u";
            else
                szName = "Tþ Thö Ch©u";
            end
        end

        if HaveNormalItem(3, 1125, 0, 0) > 0 then
            nTimes = nTimes + 1;

            SetTaskByte(140, 2, 1);
            if szName ~= "" then
                szName = szName .. ", Thanh L­¬ng T¸n";
            else
                szName = "Thanh L­¬ng T¸n";
            end
        end

        if HaveNormalItem(3, 1126, 0, 0) > 0 then
            nTimes = nTimes + 1;

            SetTaskByte(140, 3, 1);
            if szName ~= "" then
                szName = szName .. ", TÈm ThÊp Hoµn";
            else
                szName = "TÈm ThÊp Hoµn";
            end
        end
        if nTimes == 3 then
            MsgBox(" Ng­¬i ®· thu thËp ®ñ nguyªn liÖu! Giao cho ta chø?", "Random_Reward", "no")

        else
            SetTaskByte(140, 4, nTimes)
            MsgBox(" Trong 3 mãn Tþ Thö Ch©u, Thanh L­¬ng T¸n, TÈm ThÊp Hoµn ng­¬i chØ cã <c=g>" .. szName .. "<c>. Cã thÓ giao dÞch víi ng­êi ch¬i kh¸c ®Ó cã ®ñ b¶o vËt. NÕu chØ nép bao nhiªu ®©y th«i sÏ kh«ng thÓ nhËn ®­îc phÇn th­ëng tÆng thªm! Giao chø?", "Get_Reward", "no")
        end


    end
end

function Get_Reward()
    no()
    if GetTaskByte(140, 1) > 0 then
        if HaveNormalItem(3, 1124, 0, 0) == 0 then
            Talk(1, "no", "<c=yel>Tþ Thö Ch©u<c> ®· mÊt, kh«ng thÓ nhËn th­ëng!")
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
    Msg2Player("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
    TopMessage("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
    local _, _, nDay = GetYMD()
    SetTaskByte(Task_State, 2, nDay)

    Talk(1, "no", " MÆc dï ng­¬i kh«ng cã ®ñ vËt phÈm ta cÇn, nh­ng ta vÉn ch©n thµnh c¶m t¹!")
    SetTask(140, g_TaskValue);
end

function Random_Reward()
    no()
    local i = math.random(1, 1000)
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
    Msg2Player("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")

    local szExtraReward = "";
    if i <= 300 then
        Earn(100000)
        Msg2Player("B¹n may m¾n nhËn ®­îc 10 v¹n b¹c!")
        szExtraReward = "10 v¹n b¹c"
    elseif i > 300 and i <= 400 then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        Msg2Player("B¹n may m¾n nhËn ®­îc 1 Di ngo¹i phï!")
        szExtraReward = "Di ngo¹i phï"

    elseif i > 400 and i <= 500 then
        AddIBBuff(176, 60 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i t¨ng 1.5 lÇn kinh nghiÖm trong 1 giê")
        szExtraReward = " tr¹ng th¸i t¨ng 1.5 lÇn kinh nghiÖm trong 1 giê"
    elseif i > 500 and i <= 600 then
        AddIBBuff(330, 60 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i nh©n 2 kinh nghiÖm kü n¨ng trong 1 giê")
        szExtraReward = " tr¹ng th¸i nh©n 2 kinh nghiÖm kü n¨ng trong 1 giê"
    elseif i > 600 and i <= 650 then
        Earn(1000000)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
        szExtraReward = " 100 v¹n b¹c"

    elseif i > 650 and i <= 700 then
        AddIBBuff(228, 30 * 60)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc thªm tr¹ng th¸i ThÇn Tµi trong 30 phót.")
        szExtraReward = " tr¹ng th¸i ThÇn Tµi trong 30 phót."
    elseif i > 700 and i <= 750 then
        AddNormalItemBind(8, 163, 4, 0, 0, 0, 1)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Ch©n KhÝ!")
        szExtraReward = "Ch©n KhÝ"

    elseif i > 750 and i <= 800 then
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Sinh MÖnh Thanh Lé!")
        szExtraReward = " 1 Sinh MÖnh Thanh Lé"

    elseif i > 800 and i <= 850 then
        if GetGlobalValueByte(gRewardValue, 1) < 30 then
            for i = 1, 2 do
                AddNormalItemPile(3, 138, 0, 0, 0, 0)
            end
            SetGlobalValueByte(gRewardValue, 1, GetGlobalValueByte(gRewardValue, 1) + 1)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 2 ThiÖp Nh­ ý!")
            szExtraReward = " 2 ThiÖp Nh­ ý"

        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"

        end
    elseif i > 850 and i <= 860 then
        if GetGlobalValueByte(gRewardValue, 2) < 10 then
            AddBindCoin(500)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 5 Ng©n B¶o!")
            szExtraReward = " 5 Ng©n B¶o"

            SetGlobalValueByte(gRewardValue, 2, GetGlobalValueByte(gRewardValue, 2) + 1);
        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"
        end
    elseif i > 860 and i <= 999 then
        AddNormalItemBind(8, 291, 2, 0, 0, 0, 1)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï!")
        szExtraReward = " 1 Siªu cÊp Håi Thµnh Phï"

    else
        if GetGlobalValueByte(gRewardValue, 3) == 0 then
            for i = 1, 100 do
                AddNormalItemPile(3, 138, 0, 0, 0, 0)
            end ;
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 ThiÖp Nh­ ý!")
            szExtraReward = " 100 ThiÖp Nh­ ý"
            SetGlobalValueByte(gRewardValue, 3, GetGlobalValueByte(gRewardValue, 3) + 1)
            AddGlobalCountNews("Chóc mõng <c=g>" .. GetName() .. "<c> trong ho¹t ®éng Thanh l­¬ng h¹ quý, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc <c=yel>" .. szExtraReward .. "<c>!", 20)
        else
            Earn(1000000)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 100 v¹n b¹c!")
            szExtraReward = " 100 v¹n b¹c"

        end
    end
    TopMessage("Chóc mõng b¹n nhËn ®­îc " .. szExtraReward);
    WriteLog(" ho¹t ®éng Thanh l­¬ng h¹ quý, giao ®ñ toµn bé nguyªn liÖu, nhËn ®­îc " .. szExtraReward);
    Talk(1, "no", "Trô V­¬ng: §a t¹ anh hïng ®· t×m gióp ra c¸c vËt phÈm nµy. Xin tÆng anh hïng <c=yel>" .. szExtraReward .. "<c> vµ <c=yel>" .. nExp .. " kinh nghiÖm<c>!");
end

function shouxitie()
    CloseDialog()
    if (GetTaskBit(Task_Xitie, 4) == 1) then
        Talk(1, "no", " Chóc hai ng­êi B¸ch niªn hßa hîp!")
        return
    end
    local b_pos = pos_ok(500)
    if (b_pos == 2) then
        Talk(1, "no", " T©n n­¬ng c¸ch ng­¬i qu¸ xa, xin l¹i gÇn nhau thªm chót n÷a!")
        return
    elseif (b_pos == 3) then
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
    Talk(2, "no", " Chóc mõng hai ng­êi! TrÉm cã cÊp sù kh«ng ®Õn kÞp tham dù! Xin tÆng T©n lang 1 con B¹ch m·, h·y c­ìi lªn nã ®i ®ãn T©n n­¬ng nhÐ!", " §óng råi! H«n lÔ sau khi kÕt thóc, sè ThiÖp mõng cßn d­ cã thÓ ®æi thµnh hång bao ph¸t cho quan kh¸ch!")
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
    if (GetMateTask(Task_Partner) ~= GetNameID() or GetMateNameID() ~= GetTask(Task_Partner)) then
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
    PlayerIndex = i

    if (mapid_female == mapid_male) then
        if (((x_male * 32 - x_female * 32) ^ 2 + (y_male * 32 - y_female * 32) ^ 2) > distance * distance) then
            return 2
        end
    else
        return 3
    end
    return 1
end

function set_xitiebit(bit)
    SetTaskBit(Task_Xitie, bit, 1)
end

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
        AddOwnExp(GetLevel() * (1000 + GetTask(Task_shangzhou) * 1000) * 2);
    else
        AddOwnExp(GetLevel() * (sz_level * 100 + GetTask(Task_shangzhou) * 1000) * 2);
        if (4 == sz_level) and (60 > GetLevel()) then
            Msg2Player("§¼ng cÊp cña b¹n ch­a ®Õn 60, kh«ng thÓ vµo chiÕn tr­êng Th­¬ng Chu.")
        else
            if (1 == GetTask(373)) then
                SetTask(420, sz_level + 1)
                SetTask(373, 0)
                Msg2Player("§¼ng cÊp chiÕn tr­êng cña ng­¬i t¨ng" .. GetTask(420))
            elseif (GetTask(373) < 1) and (GetTask(373) >= 0) then
                SetTask(373, GetTask(373) + 1)
            else
                SetTask(373, 1)
            end
        end
    end
    WriteLog("[ÉÌÖÜÕ½³¡][¾­Ñé½±Àø][µÈ¼¶" .. sz_level .. "][¾­ÑéÖµ" .. GetTask(373))
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

        AddNormalItem(0, 9, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end
end

function dongyi()
    if (HaveEventItem(110) >= 1) then
        if (GetTask(592) == 0) then
            Talk(1, "no", 14207)
            SetTask(593, 1)
            AddOwnExp(4000)
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
            TopMessage(14208)
        elseif (GetTask(592) == 1) then
            DelEventItem(110)
            SetTask(593, 1)
            Talk(1, "no", 14207)
            SetTask(597, 26)
            TaskNote(35, 33)
            AddOwnExp(4000)
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
            TopMessage(14208)
            Msg2Player("Håi b¸o §Æng Cöu C«ng!")
        end ;
    end ;
end;

book_part = { "Ph¸ Qu©n-Tr¶m Long", "Ph¸ Qu©n-Nguyªn Thñy", "Ph¸ Qu©n-ThÇn ¦ng" }
book_name = {
    { "Yªu §¸i", "ChiÕn Ngoa", "Gi¸p" },
    { "C©n", "Lý", "§¹o Bµo" },
    { "Yªu §¸i", "Ngoa", "Hé Gi¸p" },
}
function org_book()
    local point = GetByte(GetTask(1268), 1)
    if (point >= 4) then
        local sel_type = GetPlayerType() + 1
        local item_list = {}
        for i = 1, 3 do
            item_list[i] = book_part[sel_type] .. book_name[sel_type][i] .. "/book" .. i
        end
        if (sel_type == 1) then
            item_list[3] = "Ph¸ Qu©n-HuyÒn thiÕt Tr¶m Long gi¸p/book3"
        end
        Say("Chóc mõng ng­¬i xuÊt s¾c tÝch lòy ®­îc 4 ®iÓm chiÕn c«ng. Xin lùa chän mét phÇn th­ëng §å phæ cho m×nh!", 3, item_list)
    else
        Talk(1, "no", "Ng­êi ch¬i ®¼ng cÊp tõ 90 vµ ®¹t ®Õn 9 cÊp chiÕn tr­êng, mçi lÇn th¾ng lîi sÏ ®­îc 1 ®iÓm chiÕn c«ng. Khi ®¹t 4 ®iÓm chiÕn c«ng sÏ nhËn ®­îc 1 §å phæ trang bÞ Cam. HiÖn ng­¬i ®· tÝch lòy ®­îc <c=g>" .. point .. "<c>.")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
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
        Talk(1, "no", "Ng­¬i ch­a tÝch lòy ®iÓm chiÕn c«ng! H·y quay l¹i sau nhÐ!")
    end
end

function fgetBook(key, itemidx)
    local tp = GetPlayerType() + 1
    local str = "§å phæ:" .. book_part[tp] .. book_name[tp][key]
    if (tp == 1) and (key == 3) then
        str = "§å phæ:Ph¸ Qu©n-Tr¶m Long Gi¸p"
    end

    TopMessage("B¹n nhËn ®­îc <c=g>" .. str)
    Msg2Player("B¹n nhËn ®­îc <c=g>" .. str)
    AddNormalItem(6, 1, itemidx + tp, 0, 0, 0)
end

Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278
Task_Ring_BindingIndex = 1279
Task_Ring_BindingID = 1280

Task_Ring_NPC_FreezeTime = 1
Task_Ring_NPC_BuffATime = 2
Task_Ring_NPC_BuffBTime = 3
Task_Ring_NPC_BuffCTime = 4
Task_Ring_NPC_BuffDTime = 5

Global_Ring_EntryCount = 164

Buff_Ring_Going = 487
Buff_Ring_BuffA = 488
Buff_Ring_BuffB = 489
Buff_Ring_BuffC = 490
Buff_Ring_BuffD = 491

Task_Info_Ring = 1020

Task_Ring_Match_Second = 600

Save_Section_Ring_Date = "RingDate"
Save_Section_Ring_Usetime = "RingUsetime"
Save_Section_Ring_Playername = "RingPlayername"

Save_Ring_Ranking_Usetime = "RingRankingUsetime"
Save_Ring_Ranking_Playername = "RingRankingPlayername"

Doctor_XY = {
    { x = 203 * 8, y = 184 * 16, desc = "§¹i phu T©y m«n" },
    { x = 197 * 8, y = 200 * 16, desc = "§¹i phu Nam m«n" },
    { x = 227 * 8, y = 201 * 16, desc = "§¹i phu §«ng m«n" },
    { x = 0, y = 0, desc = "Trô V­¬ng" },
}

Noon_Active_Event = 7
Noon_Active_Event_Day = 1
Noon_Active_Event_Num = 2

function Check_NoonActive_ON(nNum)


    return 0
end

function isViewRingTask()
    if (GetLevel() < 50) then
        return 0
    end

    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()

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

    local taskStatus = GetTaskByte(Task_Ring_Status, 1)
    if (taskStatus == 1) then
        return 1
    end
    return 0
end

function processRingTask()
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()

    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if (H < 11 or H >= 14) then
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "§· hÕt thêi gian tham gia thi ®Êu råi. TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhÐ!")
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "§· hÕt thêi gian tham gia thi ®Êu råi. TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhÐ!")
            return
        end
    end

    local localTime = LocalSystemTime()

    local nStartHour = 19
    if nNoonActiveOn > 0 then
        nStartHour = 11
    end
    local taskTime = math.mod(localTime, 86400) - 3600 * nStartHour

    local taskNumber = math.floor(taskTime / Task_Ring_Match_Second) + 1
    local taskGotime = math.mod(taskTime, Task_Ring_Match_Second)
    local taskStep = GetTaskByte(Task_Ring_Status, 2)
    local lastEntryTime = GetTask(Task_Ring_Accept_Time)

    local entryNumber = math.floor((math.mod(lastEntryTime, 86400) - 3600 * nStartHour) / Task_Ring_Match_Second) + 1

    if (localTime > (lastEntryTime + 86400)) then

        SetTask(Task_Ring_Status, 0)
        TaskNote(Task_Info_Ring, -1)
        Talk(1, "no", "LÇn thi ®Êu tr­íc ng­¬i vÉn ch­a hoµn tÊt. Phong Háa L«i ®µi l¹i më råi, mau ®Õn LÔ quan b¸o danh ®i!")
        return
    elseif (entryNumber < taskNumber) then
        SetTask(Task_Ring_Status, 0)
        TaskNote(Task_Info_Ring, -1)
        Talk(1, "no", "§· hÕt thêi gian b¸o danh trËn nµy råi! TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhÐ!")
        return
    end
    local remainSecond = Task_Ring_Match_Second - taskGotime - 1
    local leaveTime = (remainSecond < 60) and "" or ("" .. math.floor(remainSecond / 60) .. "m")
    leaveTime = leaveTime .. math.mod(remainSecond, 60) .. "s"
    if (taskStep == 0) then
        Talk(1, "no", "Trô V­¬ng#ºNhÊp chuét ph¶i vµo Hçn Thiªn L¨ng sÏ kÝch ®éng ®­îc Phong Háa lu©n. Thêi gian thi ®Êu cßn <c=g>" .. leaveTime .. "<c>.")
        return
    elseif (taskStep ~= 4) then
        Talk(1, "no", "H×nh nh­ ng­¬i ®i sai h­íng råi, ph¶i mang Phong Háa lu©n ®Õn <c=g>" .. Doctor_XY[taskStep].desc .. "<c>. Thêi gian thi ®Êu cßn <c=g>" .. leaveTime .. "<c>.")
        return
    else
        local npcMapid, npcx, npcy = GetNpcWorldPos(DialogNpcIdx)
        local ringIndex = GetTask(Task_Ring_BindingIndex)
        local ringID = GetTask(Task_Ring_BindingID)
        if (math.mod(ringID + 2 ^ 32, 2 ^ 31) ~= math.mod(GetNpcID(ringIndex), 2 ^ 31)) then
            SetTask(Task_Ring_Status, 0)
            TaskNote(Task_Info_Ring, -1)
            Talk(1, "no", "TiÕc qu¸! TrËn ng­¬i muèn tham gia ®· qua råi! TuÇn sau nhí ®Õn chç LÔ quan b¸o danh nhÐ!")
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

        if nNoonActiveOn > 0 then
            SyncBibleState(1614, 3, 1)
            WriteLog("Hoµn thµnh <Phong Háa L«i ®µi> (Buæi tr­a)")
        else
            SyncBibleState(1020, 3, 1)
            WriteLog("Hoµn thµnh <Phong Háa L«i ®µi>")
        end

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

        local currentDay = math.floor(LocalSystemTime() / 86400)
        if (saveDate < currentDay) then
            top1Sec, top2Sec, top3Sec = 0, 0, 0
            SaveIniInteger(Save_Section_Ring_Date, 1, currentDay)
            SaveIniInteger(Save_Section_Ring_Usetime, 1, 0)
            SaveIniInteger(Save_Section_Ring_Usetime, 2, 0)
            SaveIniInteger(Save_Section_Ring_Usetime, 3, 0)
        end
        local topArr = {}
        if (top1Sec == 0) then
            topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
        elseif (useSecond < top1Sec) then
            topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
            topArr[table.getn(topArr) + 1] = { t = top1Sec, n = top1Name }
            if (top2Sec > 0) then
                topArr[table.getn(topArr) + 1] = { t = top2Sec, n = top2Name }
            end
        else
            topArr[table.getn(topArr) + 1] = { t = top1Sec, n = top1Name }
            if (top2Sec == 0) then
                topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
            elseif (useSecond < top2Sec) then
                topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
                topArr[table.getn(topArr) + 1] = { t = top2Sec, n = top2Name }
            else
                topArr[table.getn(topArr) + 1] = { t = top2Sec, n = top2Name }
                if (top3Sec == 0) then
                    topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
                elseif (useSecond < top3Sec) then
                    topArr[table.getn(topArr) + 1] = { t = useSecond, n = GetName() }
                else
                    topArr[table.getn(topArr) + 1] = { t = top3Sec, n = top3Name }
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

        local useSecondStr = (useSecond < 60) and "" or ("" .. math.floor(useSecond / 60) .. "m")
        useSecondStr = useSecondStr .. math.mod(useSecond, 60) .. "s"

        local nFinishTime = "22:00"
        if nNoonActiveOn > 0 then
            nFinishTime = "14:00"
        end
        Msg2Player("Chóc mõng b¹n hoµn thµnh Phong Háa lu©n L«i ®µi. NhËn ®­îc kinh nghiÖm" .. addExp .. " vµ nhËn ®­îc 200 ®iÓm Tinh Lùc, tæng thêi gian " .. useSecondStr .. ", h·y chó ý " .. nFinishTime .. " danh s¸ch Top3 cña trËn chiÕn")
        Talk(1, "no", "Chóc mõng ng­¬i hoµn thµnh Phong Háa lu©n L«i ®µi, xin nhËn phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc, thµnh tÝch tæng thêi gian cña ng­¬i trËn nµy lµ <c=g>" .. useSecondStr .. "<c>. Mçi ngµy" .. nFinishTime .. " sau khi tÊt c¶ trËn chiÕn kÕt thóc, 3 ng­êi anh hïng cã thêi gian Ýt nhÊt sÏ nhËn ®­îc phÇn th­ëng th­ tÝn ®Æc biÖt. H·y chó ý!")
        TopMessage("Hoµn thµnh thi ®Êu, nhËn ®­îc kinh nghiÖm" .. addExp .. "Tinh lùc 200")
        ORACLEBONE.GetCardWayApply(6, useSecond)


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


























































































































