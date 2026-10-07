--description:
--author: yaoxin
--date: 2007/8/6


------------°ïÖúºúîÚè°Ìí¼Ó  gongpeng @2009.05.18-------------
TASK_JIANGSHAN = 1426
TASK_JIANGSHAN_PAGE5_STATUS = 1438        --µÚ5Ò³×´Ì¬   µÚÈý¸ö×Ö½Ú ÈÎÎñ½á¹û±äÁ¿ µÚ¶þ¸ö×Ö½Ú µ±Ç°ÈÎÎñ×öµ½ÄÄ²½»òÕßÄÄ²½ÒÑ¾­Íê³É
TASK_INFO_JIANGSHAN_PAGE5 = 1058        --ÈÎÎñÌáÊ¾
Task_Info_JIANGSHAN_IDOLUM = 1055

Task_HelpScore = 1491
SCORE_LIMIT = 100 --Ã¿ÖÜ»ñµÃ»ý·ÖÉÏÏÞ

NpcId2Event = {
    [596] = 167, [597] = 168, [598] = 169, [599] = 166,
    [600] = 172, [601] = 170, [602] = 171, [603] = 173
}

--AS GaoJingwei 090813
Task_LongAgo = 1529        --1byte: 1ÕÒ³à¾«×Ó£¬2ÕÒ¸ßÃ÷   2byte 1ÁË½âÏÉÄ§½ç  2ÁìÈ¡É±ÁúÈÎÎñ 3³É¹¦É±Áú  4ÁìÈ¡½±Àø
--AE GaoJingwei 090813

function OnDeath(c)
    local npcchr = GetHardNpcAttrib(c)
    local mob_lvl = GetNpcLevel(c)
    local i, Lev_diff, j, PlayerID
    local npcIndexID = GetNpcTemplateID(c)
    local w, x, y = GetWorldPos()

    if (GetTeam() ~= 0) then
        --add by liuzhiqiang begin 2009/7/15
        local succeed = 0
        local addScore = 0
        local array = {}
        local help_num = 1
        local name = 0
        --add by liuzhiqiang end 2009/7/15

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            PlayerID = GetUUID()
            if (PlayerID == GetNpcOwer(c)) then
                if (npcchr >= 0) then
                    Lev_diff = GetLevel() - mob_lvl
                    ThrowGua(c, PlayerIndex, Lev_diff, w, npcchr)
                elseif (npcIndexID >= 596) and (npcIndexID <= 602) then
                    ThrowItem(c, -1, 4, NpcId2Event[npcIndexID], 0, 1, 0, 0)

                    -- add by mayining 2008.1.16
                    if (npcIndexID == 602) then
                        succeed = yangjian_100(w)
                        --add by liuzhiqiang begin 2009/7/15
                        if (succeed == 1) then
                            addScore = 3
                            name = GetName()
                        end
                        --add by liuzhiqiang end 2009/7/15
                    end
                    -- end add by mayining

                    for j = 1, membercount do

                        local nBackupPlayer = GetTeamMember(j)
                        PlayerIndex = GetTeamMember(j) --PlayerIndexÒÑ¾­±»ÐÞ¸Ä

                        if (npcIndexID == 600) then
                            succeed = pangu_85(w)
                            --add by liuzhiqiang begin 2009/7/15
                            if (succeed == 1) then
                                addScore = addScore + 3
                                array[help_num] = GetName()
                                help_num = help_num + 1
                            end
                            --add by liuzhiqiang end 2009/7/15
                        end
                        city_shouji(w, NpcId2Event[npcIndexID])

                        PlayerIndex = nBackupPlayer

                    end
                elseif (npcIndexID == 595) then
                    for j = 1, membercount do
                        local nBackupPlayer = GetTeamMember(j)
                        PlayerIndex = GetTeamMember(j)
                        liandan_open(w)
                        PlayerIndex = nBackupPlayer
                    end
                elseif (npcIndexID == 603) then
                    succeed = jiaolong_110(w)
                    --add by liuzhiqiang begin 2009/7/15
                    if (succeed == 1) then
                        addScore = 3
                        name = GetName()
                    end
                    --add by liuzhiqiang end 2009/7/15
                end ;
                --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
                Throw_Equip(c, PlayerIndex)
                --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end
                break ;
            end
        end
        PlayerIndex = oldPlayer

        -----------------Add by liuzhiqiang at 2009/7/2 start------------------°ïÖú»ý·Ö
        local scoreLimit = GetTaskByte(Task_HelpScore, 3)
        if (addScore > 0) then
            if (npcIndexID == 600 and (GetTask(3) >= 83 or GetTask(1) >= 83 or GetTask(2) >= 83)) then
                if (scoreLimit < SCORE_LIMIT) then
                    scoreLimit = scoreLimit + addScore
                    if (scoreLimit > SCORE_LIMIT) then
                        addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                    end
                    SetTaskByte(Task_HelpScore, 3, scoreLimit)
                    AddHelpScore(addScore)
                    local str = ""
                    for i = 1, help_num - 1 do
                        str = str .. "<c=g><RoleName=\"" .. array[i] .. "\"><c> "
                    end
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Bµn Cæ<c>, gióp ®ì " .. str .. "Khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 85, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. "§iÓm kinh nghiÖm.", 1)  --¶ÔºÃÓÑ·¢³öÏûÏ¢
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            elseif (npcIndexID == 602 and (GetTask(3) >= 110 or GetTask(1) >= 110 or GetTask(2) >= 110)) then
                if (scoreLimit < SCORE_LIMIT) then
                    scoreLimit = scoreLimit + addScore
                    if (scoreLimit > SCORE_LIMIT) then
                        addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                    end
                    SetTaskByte(Task_HelpScore, 3, scoreLimit)
                    AddHelpScore(addScore)
                    --modified by liujifang for Ô½ÄÏ°æÂÒÂë at 2012-5-25 begin
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>D­¬ng TiÔn<c>, gióp ®ì " .. name .. " ®· khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 100, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. "§iÓm kinh nghiÖm.", 1)  --¶ÔºÃÓÑ·¢³öÏûÏ¢
                    --modified by liujifang for Ô½ÄÏ°æÂÒÂë at 2012-5-25 end
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            elseif (npcIndexID == 603 and (GetTask(3) >= 123 or GetTask(1) >= 123 or GetTask(2) >= 123)) then
                if (scoreLimit < SCORE_LIMIT) then
                    scoreLimit = scoreLimit + addScore
                    if (scoreLimit > SCORE_LIMIT) then
                        addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                    end
                    SetTaskByte(Task_HelpScore, 3, scoreLimit)
                    AddHelpScore(addScore)
                    --modified by liujifang for Ô½ÄÏ°æÂÒÂë at 2012-5-25 begin
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Giao Long<c>, gióp ®ì " .. name .. "Khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 110, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. "§iÓm kinh nghiÖm.", 1)  --¶ÔºÃÓÑ·¢³öÏûÏ¢
                    --modified by liujifang for Ô½ÄÏ°æÂÒÂë at 2012-5-25 end
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            end
        end
        -----------------Add by liuzhiqiang at 2009/7/2 end  ------------------°ïÖú»ý·Ö
    elseif (GetUUID() == GetNpcOwer(c)) then
        if (npcchr >= 0) then
            Lev_diff = GetLevel() - mob_lvl
            ThrowGua(c, PlayerIndex, Lev_diff, w, npcchr)
        elseif (npcIndexID >= 596) and (npcIndexID <= 602) then
            city_shouji(w, NpcId2Event[npcIndexID])
            ThrowItem(c, -1, 4, NpcId2Event[npcIndexID], 0, 1, 0, 0)
            if (npcIndexID == 600) then
                pangu_85(w)
            elseif (npcIndexID == 602) then
                yangjian_100(w)
            end
        elseif (npcIndexID == 595) then
            liandan_open(w)
        elseif (npcIndexID == 603) then
            jiaolong_110(w)
        end ;
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
        Throw_Equip(c, PlayerIndex)
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end
    end ;

    --AS by hyz 090515 for ½­É½ÒÀ¾É
    if (npcIndexID == 601) then

        killdapeng()

    end
    --AE by hyz 090515 for ½­É½ÒÀ¾É

    DelNpc(c)
end;

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function ThrowGua(npcIdx, playIdx, key, world, NpcChr)
    local w, x, y = GetWorldPos()
    if (w == world) then
        if (key <= 10) then
            ThrowItem(npcIdx, -1, 3, NpcChr_idx[NpcChr], 0, 1, 0, 0)
        end ;
    end
end

id2Name = {
    [166] = "§Çu Lam B¸", [167] = "§Çu ThiÕt Bè",
    [168] = "§Çu Kim Tr¹i", [169] = "§Çu C«n Bèi",
    [170] = "§Çu §¹i §iªu", [171] = "§Çu NhÞ Lang ThÇn",
    [172] = "§Çu Bµn Cæ", --[173] = "§Çu Giao long"
}

TASK_today = 886

function city_shouji(world, item_id)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_id = 864
        if (item_id >= 170) and (item_id <= 172) then
            task_id = task_id + 2
        end

        local type_id = item_id - 155
        local item_name = id2Name[item_id]
        local task_val = GetTask(task_id)
        local type1 = GetByte(task_val, 1)
        local count1 = GetByte(task_val, 2)
        local type2 = GetByte(task_val, 3)
        local count2 = GetByte(task_val, 4)

        local item_count = IsExistItem(4, item_id, 0, 1)

        if (type1 == type_id) then
            local today = floor(LocalSystemTime() / 86400)
            if (today == GetTask(TASK_today)) then
                if (GetTaskBit(1259, count2 + 27) == 1) then
                    Msg2Player("Ph¶i hoµn thµnh nhiÖm vô thu thËp ®· nhËn lÇn tr­íc th× míi cã thÓ nhËn n÷a!")
                    return 0
                end

                if (type2 == 0) and (count2 >= 3) then
                    --3==3¼¶,4==4¼¶
                    local nProb = random(1, 5)
                    if (nProb == 2) then
                        AddNormalItem(4, item_id, 0, 0, 0, 0)
                        item_count = item_count + 1
                        TopMessage("BÊt ngê nhËn ®­îc 1 <c=g>" .. item_name)
                    end
                    AddNormalItem(4, item_id, 0, 0, 0, 0)
                    item_count = item_count + 1

                    if (item_count < count1) then
                        Msg2Player("Cßn ph¶i thu thËp" .. item_name .. (count1 - item_count) .. ".")
                    else
                        Msg2Player("Thu thËp ®ñ" .. item_name .. ".")
                    end
                    SetTask(task_id, SetByte(task_val, 4, 0))
                    SetTaskBit(1259, count2 + 27, 1)
                else
                    Msg2Player("H«m nay ®· giao cho ng­¬i" .. item_name .. ", ng­¬i ph¶i tiÕp tôc giao nép råi nhËn l¹i míi cã thÓ nhËn ®­îc")
                end
            else
                Msg2Player("NhiÖm vô LÝnh ®¸nh thuª ®· hÕt h¹n")
            end
        end
    end
end

function liandan_open(world)
    local task_id = 908
    local w, x, y = GetWorldPos()
    if (w == world) then
        if (GetTask(task_id) == 1) then
            Msg2Player("Phßng luyÖn thuèc:Ng­¬i ®· diÖt trõ Cöu Linh")
            SetTask(task_id, 2)
            TaskNote(908, 2)
        end
    end
end

function pangu_85(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        if (taskval1 == 81 or taskval1 == 82) or (taskval2 == 81 or taskval2 == 82) or (taskval3 == 81 or taskval3 == 82) then
            local item_count = IsExistItem(4, 175, 0, 1)
            if (item_count < 1) then
                AddNormalItem(4, 175, 0, 0, 0, 0)
                Msg2Player("B¹n nhËn ®­îc Bµn Cæ thÇn khÝ")
                TopMessage(11595)
                return 1
            end
        end
    end
    return 0
end

function no()
    CloseDialog()
end;

function yangjian_100(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        if (taskval1 == 95) or (taskval2 == 95) or (taskval3 == 95) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng D­¬ng TiÔn!")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 96)
                TaskNote(27, 40)
            elseif (pt == 1) then
                SetTask(1, 96)
                TaskNote(28, 44)
            else
                SetTask(2, 96)
                TaskNote(29, 39)
            end ;
            return 1
        end
    end
    return 0
end

function jiaolong_110(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        local pt = GetPlayerType()
        if (taskval1 == 115) or (taskval2 == 115) or (taskval3 == 115) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 116)
                TaskNote(27, 45)
            elseif (pt == 1) then
                SetTask(1, 116)
                TaskNote(28, 49)
            else
                SetTask(2, 116)
                TaskNote(29, 44)
            end ;
            return 1  --Add by liuzhiqiang
        elseif (taskval1 == 117) or (taskval2 == 117) or (taskval3 == 117) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 118)
                TaskNote(27, 47)
            elseif (pt == 1) then
                SetTask(1, 118)
                TaskNote(28, 51)
            else
                SetTask(2, 118)
                TaskNote(29, 46)
            end ;
            return 1  --Add by liuzhiqiang
        elseif (GetTaskByte(Task_LongAgo, 2) == 2) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            SetTaskByte(Task_LongAgo, 2, 3)

            if (GetTaskByte(Task_LongAgo, 1) == 1) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 45)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 49)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 44)
                end
            elseif (GetTaskByte(Task_LongAgo, 1) == 2) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 47)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 51)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 46)
                end
            end

            return 1
        end
    end
    return 0  --Add by liuzhiqiang
end

--added by hyz 090515 for ½­É½ÒÀ¾É begin
--»÷°Ü´óÅôÍê³É½­É½ÒÀ¾É
function killdapeng()

    if (GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4) == 101 and
            GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3) == 1 and
            HaveIBBuff(663) > 0) then
        -- »÷É±ÊÇ·ñÒÀÀµBUFF? ÏÞÖÆÖ»ÓÐµ¥ÈË²ÅÄÜÍê³ÉÈÎÎñ

        RemoveIBBuff(663)
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3, 2)                --ÉèÖÃ»÷É±±êÖ¾Î»
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4, 16)

        TopMessage("Ng­¬i ®· diÖt trõ <c=g>§¹i §iªu<c>")
        Msg2Player("Ng­¬i ®· diÖt trõ §¹i §iªu")
        FinishNpcCollection(30)
        TopMessage("<c=g>nhiÖm vô hoµn thµnh<c>")

        TaskNote(Task_Info_JIANGSHAN_IDOLUM, 15)
    end

end
--added by hyz 090515 for ½­É½ÒÀ¾É end

--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
function Throw_Equip(nNpcIdx, nPlayerIdx)
    no()
    local nNpcID = GetNpcTemplateID(nNpcIdx)
    if (nNpcID < 600 or nNpcID > 605) then
        return
    end

    local nFlag = 1 --ÅÌ¹Å¡¢´óÅô¡¢Ñîê¯
    if (nNpcID >= 603 and nNpcID <= 605) then
        --òÔÁú¡¢ó¤Áú¡¢ò°Áú
        nFlag = 2
    end

    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do
        --¹Ì¶¨ÂÖÑ¯
        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)

        --Ëæ»úÂÖÑ¯
        if (random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID:" .. nNpcID)
end
--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end