--description: Á¬ÀíÊ÷.lua ÓÃÓÚ¾ÙÐÐ½á»éÒÇÊ½
--author: guoqun
--date: 2009/11/20

Task_MarryState = 800   --1Byte¼ÇÂ¼Íæ¼Ò½á»é×´Ì¬ 0ÎÞ²Ù×÷,1½øÈëÇó»é×´Ì¬£¬2½øÈë¶©»é×´Ì¬
--2Byte¼ÇÂ¼»éÀñÀàÐÍ 1ÆÕÍ¨ÐÍ 2¾«Æ·ÐÍ(°ÙÄêºÃºÏ) 3ºÀ»ªÐÍ£¨Áú·ï³ÊÏé£©
--3Byte±ê¼ÇÍæ¼ÒÊÇ·ñ¾Ù°ìÁË»éÀñ,ÒÔ¼°»éÀñ½ø¶È 0Ã»ÓÐÁìÈ¡¾Ù°ì»éÀñÈÎÎñ 1´ÓÎ÷ÍõÄ¸´¦¿ªÆô¾Ù°ì»éÀñ(¿ªÊ¼ÓÎ½Ö) 2Íê³ÉÓÎ½Ö£¨¿ÉÒÔÖÖÊ÷ÁË£© 3ÒÑ¾­ÖÖÊ÷ 4ÄÐ·½Çìµä¿ªÊ¼ 5Å®·½Çìµä¿ªÊ¼(Ò»°ÝÌìµØ) 6¶þ°Ý¸ßÌÃ 7·òÆÞ¶Ô°Ý 8Íê³É»éÀñ

Task_Partner = 801      --°éÂÂÍæ¼ÒÃû×ÖID

Task_Xitie = 1628     --1Bit 0Ã»ÓÐ½ÓÏ²ÌûÈÎÎñ 1ÒÑ¾­½ÓÏ²ÌûÈÎÎñ
--2Bit 1·¢Ï²ÌûÈÎÎñÒÑ¾­Íê³É
--3Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæ§¼º£¬²¢ÇÒµÃµ½ÌØÐ§
--4Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæûÍõ£¬²¢ÇÒµÃµ½ÌØÐ§
--5Bit 1ÒÑ¾­ËÍÏ²Ìû¸øÔÂÀÏ£¬²¢ÇÒµÃµ½ÌØÐ§
--6Bit 1ÒÑ¾­ËÍÏ²Ìû¸øÎäÍõ£¬²¢ÇÒµÃµ½ÌØÐ§
--7Bit 1ÒÑ¾­ËÍÏ²Ìû¸øæûÍõ£¬²¢ÇÒµÃµ½ÌØÐ§
--8Bit 1ÒÑ¾­½ÓÁËËã°Ë×ÖÈÎÎñ
--9Bit 1Íê³É°Ë×ÖÈÎÎñ
Task_TreeIndex = 1629    --Á¬ÀíÊ÷ÉÏ¼ÇÂ¼µÄµÚÒ»¸öÇéÂÂÍæ¼ÒµÄÃû×ÖID
Task_TreeID = 1630   --¼ÇÂ¼Á¬ÀíÊ÷ID

HoldWed_Buff = 1147     -- 7ÌìBuff
Wedding_Buff = 1148     -- 6Ð¡Ê±Buff

--NPCÈÎÎñ±äÁ¿   1ÉèÖÃÎªµ±Ç°Íæ¼ÒµÄÃû×ÖID
--              2ÉèÖÃÎª°éÂÂÍæ¼ÒµÄÃû×ÖID
--              3£º¼ÇÂ¼»éÀñµÄ²½Öè 1ÒÑ¾­ÖÖÊ÷ 2Çìµä¿ªÊ¼£¨ÄÐ·½È·ÈÏºó£© 3Çìµä¿ªÊ¼£¨Å®·½È·ÈÏ£©Ò»°ÝÌìµØ  4¶þ°Ý¸ßÌÃ 5·òÆÞ¶Ô°Ý 6Íê³É»éÀñ£¨¿É³é½±ºÍÁìÈ¡ºì°ü£© 7ÒÑ³éÈ¡ÐÒÔËÍæ¼Ò
--            	4:¼ÇÂ¼»éÀñµÄµµ´Î
--              5:ÒÑËÍÀ´×£¸£µÄÈËÊý
--              6:»ñ½±Íæ¼ÒµÄÐòºÅ
--              7:°ÙÎ»Êý
--              8:Ê®Î»Êý
--				9:¼ÇÂ¼ÒÑ¾­³é³öÁËµÚ¼¸Î»Êý×Ö ÉÏÏß3
--              10:¼ÇÂ¼Áìºì°üµÄÇé¿ö 1¡¢ÒÑ¾­ÁìÈ¡ºì°ü
--              11:½±ÀøÀñ°üµÄ±àºÅ
--              12:1ÒÑ¶Ò»»ºì°ü
--              13:1ÐÂÈËÒÑ¾­ÁìÈ¡Àñ°ü£¬ÐÂÈËÁìÈ¡Àñ°üÒÔºó£¬²ÎÓë»éÀñµÄÆäËûÍæ¼Ò²ÅÄÜÁìÈ¡ 2ÒÑ¾­³éÈ¡ÐÒÔËÍæ¼Ò
--              14:1Íæ¼ÒÒÑ¾­±§ÐÂÄïÁË£¡

libao = {
    [1] = { name = "Tói quµ nhá", Item = { 6, 1, 771, 0, 0, 0 } },
    [2] = { name = "Tói quµ", Item = { 6, 1, 772, 0, 0, 0 } },
    [3] = { name = "Tói quµ lín", Item = { 6, 1, 773, 0, 0 } },
    [4] = { name = "Tói siªu cÊp", Item = { 6, 1, 774, 0, 0 } },
    [5] = { name = "Tói Hµo Hoa", Item = { 6, 1, 775, 0, 0, 0 } },
}

JiehunItem = {
    [1] = { name = "ThiÖp mõng", Item = { 3, 1068, 0, 0, 0, 0 } },
    [2] = { name = "Tói quµ 10 ThiÖp mõng", Item = { 6, 1, 777, 0, 0, 0 } },
    [3] = { name = "ThiÖp mêi", Item = { 3, 1067, 0, 0, 0, 0 } },
    [4] = { name = "Bao l× x×", Item = { 6, 1, 102, 1, 0, 0 } }, --ºì°ü
    [5] = { name = "H¹t C©y l­¬ng duyªn h«n lÔ", Item = { 6, 1, 776, 0, 0, 0 } },
    [6] = { name = "§¹i hång bao", Item = { 6, 1, 769, 0, 0, 0 } },
    [7] = { name = "Hång Bao Hµo Hoa", Item = { 6, 1, 770, 0, 0, 0 } },
}

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local tasks1 = {
        { "Mua ThiÖp mõng", "buycard"; show = 0 },
        { "Ph¸t th«ng b¸o", "broadcast"; show = 0 },
        { "Cö hµnh Kh¸nh lÔ", "startceremony"; show = 0 },
        { "Chóc phóc", "sendbless"; show = 0 },
        { "TÆng l¼ng hoa", "sendflower"; show = 0 },
        { "Rót th¨m kh¸ch may m¾n", "selectlucker"; show = 0 },
        { "L·nh Tói quµ", "getrewards"; show = 0 },
        { "L·nh Hång bao", "getredpacket"; show = 0 },
        { "§æi Hång bao", "exchangepacket"; show = 0 },
        { "L·nh Tói quµ", "getgift"; show = 0 },
        { "NhÊt b¸i thiªn ®Þa", "baitiandi1"; show = 0 },
        { "NhÞ b¸i cao ®­êng", "baigaotang1"; show = 0 },
        { "Phu thª giao b¸i", "fuqiduibai1"; show = 0 },
    }

    local npcidex = GetTask(DialogNpcIdx)
    local step = GetNpcTask(DialogNpcIdx, 3)  -- Á¬ÀíÊ÷Ëùµ½µÄ²½Öè
    local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
    local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
    local str = ""
    if (step <= 2) then
        if (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID()) then
            tasks1[1].show = 1
            if (GetTaskByte(Task_MarryState, 2) == 3) then
                tasks1[2].show = 1
            end
            if (GetSex() == 0) then
                tasks1[3].show = 1
            end
            if (GetSex() == 1 and (GetTaskByte(Task_MarryState, 3) == 3 or GetTaskByte(Task_MarryState, 3) == 4)) then
                local i = PlayerIndex
                local n = 0
                if (IsCaptain() == 0) then
                    n = GetTeamMember(1)
                else
                    n = GetTeamMember(2)
                end ;
                PlayerIndex = n
                if (GetTaskByte(Task_MarryState, 3) == 4) then
                    PlayerIndex = i
                    tasks1[3].show = 1
                end
                PlayerIndex = i
            end
            str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
        else
            tasks1[4].show = 1
            tasks1[5].show = 1
            str = "T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> ®ang tiÕn hµnh h«n lÔ! Mäi ng­êi h·y cïng ®Õn chóc mõng!"
        end
    elseif (step == 6 or step == 7) then
        if (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID()) then
            -- ÅÐ¶ÏÊÇ²»ÊÇ³ÉÇ×µÄÕâÁ©ÈË
            if (GetNpcTask(DialogNpcIdx, 13) == 0) then
                tasks1[7].show = 1
            end
            if (GetNpcTask(DialogNpcIdx, 9) < 3) then
                tasks1[6].show = 1
            end
            tasks1[9].show = 1
            if (GetNpcTask(DialogNpcIdx, 12) == 0) then
                tasks1[8].show = 1
            end
            str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
        elseif (GetTask(Task_TreeIndex) == DialogNpcIdx and GetNpcID(DialogNpcIdx) == GetTask(Task_TreeID)) then
            tasks1[10].show = 1
            str = "C©y l­¬ng duyªn: T©n lang<c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> h«n lÔ ®· kÕt thóc! H·y xem thö b¹n cã tróng th­ëng kh«ng! ChØ cÇn cã tham gia chóc phóc lµ cã th­ëng!"
        else
            str = "C©y l­¬ng duyªn: T©n lang<c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> ®· cña hµnh h«n lÔ ë ®©y!"
        end
    elseif (step == 3 and GetSex() == 0 and (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID())) then
        tasks1[11].show = 1
        str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
    elseif (step == 4 and GetSex() == 0 and (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID())) then
        tasks1[12].show = 1
        str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
    elseif (step == 5 and GetSex() == 0 and (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID())) then
        tasks1[13].show = 1
        str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
    elseif (GetNpcTask(DialogNpcIdx, 1) == GetNameID() or GetNpcTask(DialogNpcIdx, 2) == GetNameID()) then
        str = "C©y l­¬ng duyªn: Chóc mõng hai ng­êi ®· kÕt thµnh phu thª, h·y mêi thªm b»ng h÷u ®Õn chóc mõng h«n lÔ. Ng­êi ®«ng sÏ cµng vui!"
    else
        str = "C©y l­¬ng duyªn: T©n lang<c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> ®ang b¸i ®­êng! H·y ®Õn gãp thªm chót kh«ng khÝ t­¬i vui!"
    end
    SayTask(str, tasks1)
end

function baitiandi1()
    local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
    local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
    local b_pos = pos_ok(300) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: KÕt h«n lµ niÒm h¹nh phóc cña 2 ng­êi!")
        return
    elseif (b_pos == 1) then
        if (GetTaskByte(Task_MarryState, 2) == 3) then
            -- ºÀ»ªÐÍ½«ÓÐÌáÊ¾
            AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>NhÊt b¸i thiªn ®Þa", 10) --NoticeHere
        end
        NpcSay(DialogNpcIdx, "NhÊt b¸i thiªn ®Þa")
        TeamAction("baitiandi", 0, 0, 0)
    end
end

function baitiandi()
    CloseDialog()
    -- Ìí¼Ó±íÇéÅÝÅÝ£¡£¡£¡
    PlayerCastSkill(1, 208, 1)
    ----Ãµ¹å»¨Óê ÔÝÊ±´úÌæ°Ý¸ßÌÃµÄ±íÇéÅÝÅÝ
    AddEmoteBalloon(PlayerIndex, 39)   --±íÇéÅÝÅÝ
    SetTaskByte(Task_MarryState, 3, 6)
    SetNpcTask(DialogNpcIdx, 3, 4)
end

function baigaotang1()
    local b_pos = pos_ok(300) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: H«n lÔ lµ ngµy ®¹i sù cña 2 ng­êi!")
        return
    elseif (b_pos == 1) then
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        if (GetTaskByte(Task_MarryState, 2) == 3) then
            -- ºÀ»ªÐÍ½«ÓÐÌáÊ¾
            AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>NhÞ b¸i cao ®­êng", 10) --NoticeHere
        end
        NpcSay(DialogNpcIdx, "NhÞ b¸i cao ®­êng")
        TeamAction("baigaotang", 0, 0, 0)
    end
end

function baigaotang()
    CloseDialog()
    PlayerCastSkill(1, 208, 1)
    ----Ãµ¹å»¨Óê ÔÝÊ±´úÌæ°Ý¸ßÌÃµÄ±íÇéÅÝÅÝ
    SetTaskByte(Task_MarryState, 3, 7)
    SetNpcTask(DialogNpcIdx, 3, 5)
    AddEmoteBalloon(PlayerIndex, 39)   --±íÇéÅÝÅÝ
end

function fuqiduibai1()
    local b_pos = pos_ok(300) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin kiÓm tra l¹i ph­¬ng thøc tæ ®éi cña 2 ng­êi! CÇn cã 2 ng­êi tæ ®éi míi cã thÓ hoµn thµnh h«n lÔ!")
        return
    elseif (b_pos == 1) then
        if Check_ReCount() > 0 then
            local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
            local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
            if (GetTaskByte(Task_MarryState, 2) == 3) then
                -- ºÀ»ªÐÍ½«ÓÐÌáÊ¾
                AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>Phu thª giao b¸i", 10) --NoticeHere
            end
            NpcSay(DialogNpcIdx, "Phu thª giao b¸i")
            DelNormalItem(6, 1, 568, 1)   --É¾³ýÁ¬ÀíÊ÷ÖÖ×Ó
            TeamAction("fuqiduibai", 0, 0, 0)
            --Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 Begin
        else
            TeamAction("fuqiduibai", 1, 0, 0)
        end
        --Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 End
    end
end

--Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 Begin
function fuqiduibai(nType)
    CloseDialog()
    if nType == 0 then
        PlayerCastSkill(1, 212, 1)
        ----Ãµ¹å»¨Óê ÔÝÊ±´úÌæ·òÆÞ¶Ô°ÝµÄ±íÇéÅÝÅÝ
        PlayerCastSkill(1, 208, 1)
        ----ÑÌ»ð
        SetTaskByte(Task_MarryState, 3, 8)
        SetNpcTask(DialogNpcIdx, 3, 6)
        RemoveIBBuff(HoldWed_Buff)
        RemoveIBBuff(Wedding_Buff)
        if (GetSex() == 0) then
            DoMarry()
            local item = JiehunItem[5].Item
            DelNormalItem(item[1], item[2], item[3], item[4])
        end

        AddEmoteBalloon(PlayerIndex, 40)   --±íÇéÅÝÅÝ
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> kÕt thµnh l­¬ng duyªn! Mêi c¸c b»ng h÷u cïng ®Õn chóc mõng hä bÒn duyªn t¬ tãc!", 20) --NoticeHere
        teamTaskNote(1507, 7)
    else
        Talk(1, "no", "C©y l­¬ng duyªn: Tõ giê hai ng­êi sÏ kÕt thµnh l­¬ng duyªn, nh­ng yªu cÇu quan hÖ h·o h÷u cña hai ng­êi ph¶i d­íi 120 giê míi cã thÓ thµnh c«ng! Quan hÖ h¶o h÷u cña hai ng­êi ®· ®¹t tèi ®a, t¹m thêi ta kh«ng thÓ chñ tr× h«n sù nµy!")
    end
end
--Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 End

--Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 Begin
function Check_ReCount()
    local selfPlayer = PlayerIndex
    local mateIdx = 0
    if (IsCaptain() == 0) then
        mateIdx = GetTeamMember(1)
    else
        mateIdx = GetTeamMember(2)
    end ;
    PlayerIndex = mateIdx
    local nCount1 = GetTotalFriendCount()
    PlayerIndex = selfPlayer
    local nCount2 = GetTotalFriendCount()
    if nCount1 >= 120 or nCount2 >= 120 then
        return 0
    else
        return 1
    end
end
--Add By Guoqun for Bug:ºÃÓÑÊýÁ¿ÂúÁËÒÔºóÎÞ·¨½á»é at 2010-03-08 End

function setmarrystate()
    SetTask(Task_MarryState, 0)
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

function buycard()
    local tasks = {
        { "1 ThiÖp mõng", "onexitie"; show = 1 },
        { "Tói quµ 10 ThiÖp mõng", "tenxitie"; show = 1 },
        { "Tói quµ 20 ThiÖp mõng", "twentyxitie"; show = 1 },
        { "Tói quµ 50 ThiÖp mõng", "fiftyxitie"; show = 1 },
    }
    SayTask("C©y l­¬ng duyªn: Ng­¬i cã thÓ ph¸t ThiÖp mõng cho c¸c b»ng h÷u, quan kh¸ch! Hä cã thÓ mang theo <c=yel>ThiÖp mõng<c> ®Õn gÆp ta giao <c=yel>Hång Thñy tinh<c> ®Ó göi chóc phóc. ThiÖp mõng <c=yel>10 v¹n l­îng<c> 1 tÊm.", tasks)

end

function onexitie()
    CloseDialog()
    if (GetCash() < 100000) then
        Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i kh«ng ®ñ b¹c!")
        return
    end
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: hµnh trang kh«ng ®ñ trèng, kh«ng thÓ nhËn ThiÖp mõng!")
        return
    end
    Pay(100000)
    local xitie = JiehunItem[1].Item
    AddNormalItem(xitie[1], xitie[2], xitie[3], xitie[4], xitie[5], xitie[6])
end

function tenxitie()
    CloseDialog()
    getxitielibao(1)
end

function twentyxitie()
    CloseDialog()
    getxitielibao(2)
end

function fiftyxitie()
    CloseDialog()
    getxitielibao(5)
end

function getxitielibao(n)
    if (GetCash() < n * 1000000) then
        Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i kh«ng ®ñ b¹c!")
        return
    end
    if (IsHaveSpaceForTreasure(n) == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: hµnh trang kh«ng ®ñ trèng, kh«ng thÓ nhËn ThiÖp mõng!")
        return
    end
    Pay(n * 1000000)
    local xitie = JiehunItem[2].Item
    for i = 1, n do
        AddNormalItem(xitie[1], xitie[2], xitie[3], xitie[4], xitie[5], xitie[6])
    end
end

function broadcast()
    MsgBox("C©y l­¬ng duyªn: Hai ng­êi cã thÓ bá ra <c=yel>10 v¹n l­îng<c> ®Ó ph¸t th«ng b¸o, c¸c b»ng h÷u hay tin sÏ ®Õn chóc mõng!", "yes_broadcast", "no")
end

function yes_broadcast()
    CloseDialog()
    local b_pos = pos_ok(500) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng ®øng qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: KÕt h«n lµ niÒm h¹nh phóc cña 2 ng­êi.")
        return
    elseif (b_pos == 1) then
        local cost = 100000
        if (GetCash() >= cost) then
            Pay(cost)
        else
            Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng cã ®ñ tiÒn!") --NoticeHere
            return
        end
        local i = PlayerIndex
        local n = 0
        if (IsCaptain() == 0) then
            n = GetTeamMember(1)
        else
            n = GetTeamMember(2)
        end ;
        PlayerIndex = n
        local duifang = GetName()
        PlayerIndex = i
        local ziji = GetName()
        if (GetSex() == 0) then
            local tep = duifang
            duifang = ziji
            ziji = tep
        end
        AddGlobalNews("T©n lang <c=g>" .. duifang .. "<c> vµ T©n n­¬ng <c=g>" .. ziji .. "<c> ®· trång 1 C©y l­¬ng duyªn ë <c=yel>TriÒu Ca<c>, mêi mäi ng­êi h·y cïng ®Õn chóc phóc, mäi ng­êi ®Òu sÏ cã quµ. Cuèi cïng t©n n­¬ng sÏ rót th¨m, quan kh¸ch nµo may m¾n sÏ nhËn ®­îc phÇn th­ëng phong phó!", 20)
    end--ÂÞôàÐù ÕâÀïµÄgolbalnewsÐèÒªÔÚºóÃæ¼ÓÒ»¸öÊ±¼äÏÞ¶¨£¬¶àÉÙÃëÃ»Ö´ÐÐ¾ÍÈ¡ÏûÖ´ÐÐÁË¡£
end

function startceremony()
    CloseDialog()
    local b_pos = pos_ok(500) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin kiÓm tra l¹i ph­¬ng thøc tæ ®éi cña 2 ng­êi! CÇn cã 2 ng­êi tæ ®éi míi cã thÓ hoµn thµnh h«n lÔ!")
        return
    elseif (b_pos == 1) then
        local i = PlayerIndex
        local n = 0
        if (IsCaptain() == 0) then
            n = GetTeamMember(1)
        else
            n = GetTeamMember(2)
        end ;
        if (GetSex() == 0) then
            if (GetTaskByte(Task_MarryState, 3) == 3) then
                local type = getlibaotype()

                MsgBox("C©y l­¬ng duyªn: ®· cã <c=red>" .. GetNpcTask(DialogNpcIdx, 5) .. "<c> quan kh¸ch göi chóc phóc. Lóc nµy b¸i ®­êng, sÏ nhËn ®­îc 3 <c=yel>" .. libao[type].name .. "<c>, hai ng­êi mçi ng­êi sÏ ®­îc 1 phÇn. PhÇn cßn l¹i th«ng qua rót th¨m sÏ tÆng cho quan kh¸ch nµo may m¾n! B¾t ®Çu Kh¸nh lÔ ®­îc ch­a?", "y_startceremony", "no")

                return
            else
                Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u! Xin ®îi c« n­¬ng thùc hiÖn phÇn cña m×nh ®·!") --Noticehere
            end
        end
        if (GetSex() == 1) then
            if (GetTaskByte(Task_MarryState, 3) == 3) then
                PlayerIndex = n
                if (GetTaskByte(Task_MarryState, 3) == 4) then
                    -- Á½ÈË×´Ì¬Í¬Îª¿ªÆôÇìµä£¬ÄÇÃ´Ôò¿ªÊ¼°ÝÌÃ
                    PlayerIndex = i
                    SetTaskByte(Task_MarryState, 3, 4)
                    Talk(1, "no", "C©y l­¬ng duyªn: TiÕp theo ®Õn phÇn T©n lang thÓ hiÖn t×nh yªu cña m×nh ®èi víi c« n­¬ng! Sau ®ã hai ng­êi sÏ tuyªn bè b¾t ®Çu b¸i ®­êng!")
                    NpcSay(DialogNpcIdx, "B©y giê h«n lÔ b¾t ®Çu cö hµnh, T©n lang cã muèn bµy tá g× víi T©n n­¬ng th× tranh thñ ®i nhÐ!")
                end
                PlayerIndex = i
            elseif (GetTaskByte(Task_MarryState, 3) == 4) then
                if (GetTaskByte(Task_MarryState, 2) == 3) then
                    -- ºÀ»ªÐÍ½«ÓÐÌáÊ¾
                    local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
                    local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
                    AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>-h«n lÔ b¾t ®Çu cö hµnh!", 20)
                    --AddGlobalNews("ÐÂÀÉÐÂÄïÒ»°ÝÌìµØ£¡")
                end
                ---- ÐÂÄï£¬ÐÂÀÉ±ä»ØÈËÐÎ£¡£¡£¡£¡£¡£¡
                SetNpcTask(DialogNpcIdx, 3, 3)
                SetTaskByte(Task_MarryState, 3, 5)
                PlayerIndex = n
                if (GetMorphType() ~= 364) and (GetMorphType() ~= 86) and (GetMorphType() ~= 420) and (GetMorphType() ~= 419) then
                    PolyMorph(1636, 0, 2, 10, 7200)
                end
                SetTaskByte(Task_MarryState, 3, 5)
                PlayerIndex = i
                if (GetMorphType() ~= 364) and (GetMorphType() ~= 86) and (GetMorphType() ~= 420) and (GetMorphType() ~= 419) then
                    PolyMorph(1637, 0, 2, 10, 7200)
                end
                teamTaskNote(1507, 6)
            end
        end
    end
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
    if (index == 7) then
        SetTask(Task_MarryState, 0)
    end
    PlayerIndex = i
end

function y_startceremony()
    CloseDialog()
    WriteLog("Sè ng­êi chóc phóc " .. GetNpcTask(DialogNpcIdx, 5) .. "T¹i" .. GetName() .. "!")
    TeamAction("yes_notice2all", 0, 0, 0)
end

function yes_notice2all()
    CloseDialog()
    if (GetSex() == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: T©n lang cã muèn bµy tá g× víi T©n n­¬ng th× tranh thñ ®i nhÐ!")
        SetTaskByte(Task_MarryState, 3, 4) -- ÄÐ·½Çìµä¿ªÊ¼×Ö½ÚÖÃ1
    elseif (GetSex() == 1) then
        Talk(1, "no", "C©y l­¬ng duyªn: T©n lang muèn bµy tá ch©n t×nh víi ng­¬i! NÕu ®ång ý, xin nhÊp C©y l­¬ng duyªn ®Ó tiÕn hµnh ®iÓn lÔ!")  --NoticeHere  ÕâÀï¿Ï¶¨µÃ¸Ä
    end
end

function sendbless()
    MsgBox("C©y l­¬ng duyªn: mang theo <c=yel>ThiÖp mõng<c> (hoÆc <c=yel>10 v¹n l­îng<c>) ®Õn chç ta, céng víi 1 <c=yel>Hång Thñy tinh<c> (hoÆc <c=yel>5 v¹n l­îng<c>), cã thÓ göi chóc phóc cho t©n nh©n. Sau khi kÕt thóc h«n lÔ, T©n n­¬ng sÏ rót th¨m, quan kh¸ch nµo may m¾n sÏ nhËn ®­îc 1 Tói quµ lín. quan kh¸ch tham gia cµng ®«ng, phÇn th­ëng sÏ cµng nhiÒu.", "yes_sendbless", "no")
end

function yes_sendbless()
    CloseDialog()
    if (GetTask(Task_TreeIndex) ~= DialogNpcIdx and GetTask(Task_TreeIndex) ~= 0 and GetNpcID(DialogNpcIdx) ~= GetTask(Task_TreeID)) then
        MsgBox("C©y l­¬ng duyªn: §©y kh«ng ph¶i lµ c©y ng­¬i chóc phóc lÇn tr­íc! Ph¶i hñy chóc phóc lÇn tr­íc míi cã thÓ chóc phóc lÇn nµy! Hñy chø?", "yes_send", "no") --NoticeHere
        return
    end

    if (GetTask(Task_TreeIndex) == DialogNpcIdx and GetNpcID(DialogNpcIdx) == GetTask(Task_TreeID)) then
        Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i ®· göi chóc phóc råi! §îi sau khi h«n lÔ kÕt thóc T©n n­¬ng sÏ rót th¨m, biÕt ®©u ng­¬i sÏ lµ ng­êi may m¾n!")
        return
    end

    if (GetNpcTask(DialogNpcIdx, 5) >= 999) then
        Talk(1, "no", "C©y l­¬ng duyªn: sè ng­êi chóc phóc ®· ®¹t 999, kh«ng thÓ tiÕp tôc chóc phóc n÷a!")
        return
    end

    local item = JiehunItem[1].Item
    if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
        -- ÕâÀïÓ¦¸Ã²é¿´ÊÇ·ñÓÐÏ²Ìû
        if (HaveNormalItem(3, 28, 0, 0) > 0) then
            -- ÕâÀïÓ¦¸Ã²é¿´ÊÇ·ñÓÐºìË®¾§
            DelNormalItem(3, 28, 0, 0)
            DelNormalItem(item[1], item[2], item[3], item[4])
            show_bless()
        else
            local tep = cost_sendbless(50000)
            if (tep == 1) then
                DelNormalItem(item[1], item[2], item[3], item[4])
            end
        end
    else
        if (HaveNormalItem(3, 28, 0, 0) > 0) then
            -- ÕâÀïÓ¦¸Ã²é¿´ÊÇ·ñÓÐºìË®¾§
            local tep = cost_sendbless(100000)
            if (tep == 1) then
                DelNormalItem(3, 28, 0, 0)
            end
        else
            cost_sendbless(150000)
        end
    end

end

function yes_send()
    CloseDialog()
    SetTask(Task_TreeIndex, 0) -- NoticeHere
    SetTask(Task_TreeID, 0)       -- NoticeHere
    TaskNote(1506, -1)           -- NoticeHere ²Î¼Ó»éÀñÈÎÎñÈ¡Ïû£¡
end

function cost_sendbless(cost)
    CloseDialog()
    if (GetCash() >= cost) then
        Pay(cost)
        show_bless()
        return 1
    else
        Talk(1, "no", "C©y l­¬ng duyªn: b»ng h÷u kh«ng mang ®ñ <c=yel>" .. cost .. "<c>, kh«ng thÓ göi chóc phóc cho T©n nh©n!")
        return 2
    end
end

function show_bless()
    local name = GetName()
    local str = {
        "B¸ch niªn hßa hîp, h¹nh phóc mü m·n!",
        "§ång vî ®ång chång, t¸t c¹n biÓn ®«ng!",
        "¢n ©n ¸i ¸i, t×nh ý t­¬ng liªn!",
        "VÜnh kÕt ®ång t©m, l­¬ng duyªn mü m·n!",
        "Thiªn sinh tµi tö, giai nh©n phèi kú!",
        "H¹nh phóc mü m·n, b¹ch ®Çu giai l·o!",
        "Chu liªn bÝch hîp, hoa m·n nguyÖt viªn!",
        "T­¬ng th©n t­¬ng ¸i, t©m ®ång ý hîp!",
        "May m¾n liªn miªn, t©m t­ëng sù thµnh",
        "B¹ch ®Çu giai l·o, vÜnh kÕt ®ång t©m!",
    }

    local i = random(1, 10)
    local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
    local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
    if (GetNpcTask(DialogNpcIdx, 4) == 3) then
        AddGlobalNews("<c=g>" .. name .. "<c> chóc T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>" .. str[i], 5)
    end
    Msg2CurMapAnnounce("<c=g>" .. name .. "<c> chóc T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>" .. str[i])
    -- ×£¸£µÄÈËÊý¼Ó1 --
    local count = GetNpcTask(DialogNpcIdx, 5)
    local type = GetNpcTask(DialogNpcIdx, 4)
    count = count + 1
    SetNpcTask(DialogNpcIdx, 5, count)    -- ÉèÖÃÒÑËÍÀ´×£¸£Íæ¼ÒµÄÈËÊý
    SetTask(Task_TreeIndex, DialogNpcIdx) -- ¼ÇÂ¼Ê÷µÄIndex
    SetTask(Task_TreeID, GetNpcID(DialogNpcIdx))
    TaskNote(1506, 0, "<c=g>" .. count .. "<c>")
    i = random(1, count)
    if (i == 1) then
        SetNpcTask(DialogNpcIdx, 6, count)    --ÉèÖÃ»ñ½±µÄÐòºÅ
        SaveIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "player", GetName()) -- ÔÚ·þÎñÆ÷ÉÏ¼ÇÂ¼»ñ½±Íæ¼ÒµÄÃû×Ö
    end
    if (type == 3) then
        PlayerCastSkill(1, 210, 1)       ----ÑÌ»ð
    end
    AddEmoteBalloon(PlayerIndex, 1)   --±íÇéÅÝÅÝ
    -- Á¬ÀíÊ÷±äÉí --
    if (type == 2) then
        --¾«Æ·ÐÍ
        if (count >= 200) then
            NpcRemoveIBBuff(DialogNpcIdx, 1151)
            NpcAddIBBuff(DialogNpcIdx, 1152)
        elseif (count >= 100) then
            NpcRemoveIBBuff(DialogNpcIdx, 1150)
            NpcAddIBBuff(DialogNpcIdx, 1151)
        elseif (count >= 50) then
            NpcRemoveIBBuff(DialogNpcIdx, 1149)
            NpcAddIBBuff(DialogNpcIdx, 1150)
        elseif (count >= 10) then
            NpcAddIBBuff(DialogNpcIdx, 1149)
        end
    elseif (type == 3) then
        if (count >= 200) then
            NpcRemoveIBBuff(DialogNpcIdx, 1155)
            NpcAddIBBuff(DialogNpcIdx, 1156)
        elseif (count >= 100) then
            NpcRemoveIBBuff(DialogNpcIdx, 1154)
            NpcAddIBBuff(DialogNpcIdx, 1155)
        elseif (count >= 50) then
            NpcRemoveIBBuff(DialogNpcIdx, 1153)
            NpcAddIBBuff(DialogNpcIdx, 1154)
        elseif (count >= 10) then
            NpcAddIBBuff(DialogNpcIdx, 1153)
        end
    end
end

function sendflower()
    Talk(1, "sendflower2", "C©y l­¬ng duyªn: ChØ cÇn <c=yel>6 Kim Nguyªn B¶o<c> cã thÓ tÆng cho T©n nh©n 1 l¼ng hoa, ®Æt xung quanh C©y l­¬ng duyªn!")
end

function sendflower2()
    CloseDialog()
    local style = GetNpcTask(DialogNpcIdx, 4)
    if (GetCoin() < 600) then
        Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng ®ñ Kim Nguyªn B¶o!")
        return
    else
        if (style == 2) then
            local flower = {
                { "B¸ch hîp Hoa", "baihe"; show = 1 },
            }
            SayTask("C©y l­¬ng duyªn: Xin h·y tÆng cho t©n nh©n B¸ch Hîp Hoa!", flower) --NoticeHere
        elseif (style == 3) then
            local flower = {
                { "B¸ch hîp Hoa", "baihe"; show = 1 },
                { "Ngäc Lan Hoa", "yulan"; show = 1 },
                { "Hoa lµi", "moli"; show = 1 },
                { "MÉu ®¬n", "mudan"; show = 1 },
            }
            SayTask("C©y l­¬ng duyªn: Xin h·y chän mét lo¹i hoa ®Ó tÆng cho t©n nh©n!", flower) --NoticeHere
        end
    end
end

function baihe()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(146)
    if (GetCoin() >= Cv) then
        CostCoinByIdx(146)
        local idx, x, y = GetWorldPos()
        local step = GetTaskByte(Task_MarryState, 3)
        local npcidx = AddNpc(1641, 1, SubWorld, x * 32, y * 32)
        local time = LocalSystemTime() - GetNpcTask(DialogNpcIdx, 15) * 60
        SetNpcScript(npcidx, "\\script\\item\\°ÙºÏ»¨.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 21600 - time) --6Ð¡Ê±ÒÔºóÉ¾³ý×Ô¼º
        SetNpcName(npcidx, "B¸ch hîp Hoa")  --
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        SetNpcTask(npcidx, 1, DialogNpcIdx)
        SaveIniString("Save_Host_Of_Lianlishu", npcidx .. "host", GetName())
        AddEmoteBalloon(PlayerIndex, 2)   --±íÇéÅÝÅÝ
        WriteLog("TÆng mét l¼ng B¸ch Hîp hoa cho " .. man)
        AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> cã vÞ h¶o höu <c=g>" .. GetName() .. "<c> tÆng cho t©n nh©n mét bã B¸ch Hîp hoa, chóc hai ng­êi B¸ch niªn hßa hîp!", 20)
    else
        Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng ®ñ Kim Nguyªn B¶o!")
    end
end

function yulan()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(146)
    if (GetCoin() >= Cv) then
        CostCoinByIdx(146)
        local idx, x, y = GetWorldPos()
        local step = GetTaskByte(Task_MarryState, 3)
        local npcidx = AddNpc(1643, 1, SubWorld, x * 32, y * 32)
        local time = LocalSystemTime() - GetNpcTask(DialogNpcIdx, 15) * 60
        SetNpcScript(npcidx, "\\script\\item\\ÓñÀ¼»¨.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 21600 - time) --6Ð¡Ê±ÒÔºóÉ¾³ý×Ô¼º
        SetNpcName(npcidx, "Ngäc Lan Hoa")  --
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        SetNpcTask(npcidx, 1, DialogNpcIdx)
        SaveIniString("Save_Host_Of_Lianlishu", npcidx .. "host", GetName())
        AddEmoteBalloon(PlayerIndex, 2)   --±íÇéÅÝÅÝ
        WriteLog("TÆng l¼ng hoa Ngäc Lan cho " .. man)
        AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> cã vÞ h¶o höu <c=g>" .. GetName() .. "<c> tÆng cho t©n nh©n mét l¼ng hoa Ngäc Lan, chóc hai ng­êi v¹n sù thµnh c«ng!", 20)
    else
        Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng ®ñ Kim Nguyªn B¶o!")
    end
end

function moli()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(146)
    if (GetCoin() >= Cv) then
        CostCoinByIdx(146)
        local idx, x, y = GetWorldPos()
        local step = GetTaskByte(Task_MarryState, 3)
        local npcidx = AddNpc(1642, 1, SubWorld, x * 32, y * 32)
        local time = LocalSystemTime() - GetNpcTask(DialogNpcIdx, 15) * 60
        SetNpcScript(npcidx, "\\script\\item\\ÜÔÀò»¨.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 21600 - time) --6Ð¡Ê±ÒÔºóÉ¾³ý×Ô¼º
        SetNpcName(npcidx, "Hoa lµi")  --
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        SetNpcTask(npcidx, 1, DialogNpcIdx)
        SaveIniString("Save_Host_Of_Lianlishu", npcidx .. "host", GetName())
        AddEmoteBalloon(PlayerIndex, 2)   --±íÇéÅÝÅÝ
        WriteLog("TÆng mét l¼ng Hoa lµi cho " .. man)
        AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> cã vÞ h¶o höu <c=g>" .. GetName() .. "<c> tÆng cho t©n nh©n mét l¼ng Hoa lµi, chóc hai ng­êi v¹n sù tèc thµnh!", 20)
    else
        Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng ®ñ Kim Nguyªn B¶o!")
    end
end

function mudan()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(146)
    if (GetCoin() >= Cv) then
        CostCoinByIdx(146)
        local idx, x, y = GetWorldPos()
        local step = GetTaskByte(Task_MarryState, 3)
        local npcidx = AddNpc(1640, 1, SubWorld, x * 32, y * 32)
        local time = LocalSystemTime() - GetNpcTask(DialogNpcIdx, 15) * 60
        SetNpcScript(npcidx, "\\script\\item\\Äµµ¤»¨.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 21600 - time) --6Ð¡Ê±ÒÔºóÉ¾³ý×Ô¼º
        SetNpcName(npcidx, "MÉu ®¬n")  --
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        SetNpcTask(npcidx, 1, DialogNpcIdx)
        SaveIniString("Save_Host_Of_Lianlishu", npcidx .. "host", GetName())
        AddEmoteBalloon(PlayerIndex, 2)   --±íÇéÅÝÅÝ
        WriteLog("TÆng mét l¼ng hoa MÉu ®¬n cho " .. man)
        AddGlobalNews("T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> cã vÞ h¶o höu <c=g>" .. GetName() .. "<c> tÆng cho t©n nh©n mét l¼ng MÉu ®¬n, chóc hai ng­êi vui vÎ h¹nh phóc!", 20)
    else
        Talk(1, "no", "C©y l­¬ng duyªn: B»ng h÷u kh«ng ®ñ Kim Nguyªn B¶o!")
    end
end

function selectlucker()
    CloseDialog()
    if (GetSex() == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin h·y th«ng b¸o cho T©n n­¬ng rót th¨m, xem vÞ quan kh¸ch nµo may m¾n!")
        return
    end
    if (GetNpcTask(DialogNpcIdx, 13) == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin h·y chän phÇn th­ëng, sau ®ã míi cã thÓ rót th¨m t×m ra quan kh¸ch may m¾n!")
        return
    end

    local b_pos = pos_ok(300) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin kiÓm tra l¹i ph­¬ng thøc tæ ®éi cña 2 ng­êi! CÇn cã 2 ng­êi tæ ®éi míi cã thÓ hoµn thµnh h«n lÔ!")
        return
    elseif (b_pos == 1) then
        local tep = GetNpcTask(DialogNpcIdx, 9)  -- ÒÑ¾­ÏÔÊ¾ÁË¼¸Î»£¬Ë³Ðò·Ö±ðÎª °ÙÎ» Ê®Î» ¸öÎ»
        local num = GetNpcTask(DialogNpcIdx, 5)  --  »ñ½±ËÍ×£¸£Íæ¼ÒµÄÊýÁ¿
        if (num == 0) then
            Talk(1, "no", "C©y l­¬ng duyªn: Kh«ng cã ai ®Õn chóc phóc cho hai vÞ! Ng¹i qu¸! Kh«ng thÓ rót th¨m ®­îc!")
            SetNpcTask(DialogNpcIdx, 13, 2)   -- ÒÑ¾­³éÈ¡ÐÒÔËÍæ¼Ò£¬ÕâÀïÖ¸³é½±»î¶¯ÒÑ¾­½áÊø
            SetNpcTask(DialogNpcIdx, 9, 3)
            SetNpcTask(DialogNpcIdx, 3, 7)
            PolyMorph(-1, 0, 0, 0, 0)
            local i = PlayerIndex
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end
            PlayerIndex = n
            PolyMorph(-1, 0, 0, 0, 0)
            PlayerIndex = i

            teamTaskNote(1507, -1)  -- »éÀñ½áÊø
            return
        else
            local player = GetNpcTask(DialogNpcIdx, 6)  --  »ñ½±Íæ¼Ò
            local wei = 0
            local bai = 0
            local shi = 0
            if (tep == 0) then
                wei = floor(player / 100) --È¡°ÙÎ»
                SetNpcTask(DialogNpcIdx, 7, wei) --¼ÇÂ¼°ÙÎ»Êý×Ö
                SetNpcTask(DialogNpcIdx, 9, 1)
                NpcSay(DialogNpcIdx, "T©n n­¬ng ®· b¾t ®Çu rót th¨m! Sè ng­êi may m¾n ®Çu tiªn lµ: " .. wei)
                local inix = 730 + wei
                if (wei == 0) then
                    inix = 740
                end
                PlayerCastSkill(1, 741, 1)
                PlayerCastSkill(1, inix, 1)
            elseif (tep == 1) then
                bai = GetNpcTask(DialogNpcIdx, 7)
                wei = floor((player - bai * 100) / 10)
                SetNpcTask(DialogNpcIdx, 8, wei)
                SetNpcTask(DialogNpcIdx, 9, 2)
                NpcSay(DialogNpcIdx, "Ng­êi may m¾n thø hai lµ: " .. wei)
                local inix = 730 + wei
                if (wei == 0) then
                    inix = 740
                end
                PlayerCastSkill(1, 741, 1)
                PlayerCastSkill(1, inix, 1)
            elseif (tep == 2) then
                bai = GetNpcTask(DialogNpcIdx, 7)
                shi = GetNpcTask(DialogNpcIdx, 8)
                SetNpcTask(DialogNpcIdx, 13, 2)   -- ÒÑ¾­³éÈ¡ÐÒÔËÍæ¼Ò£¬ÕâÀïÖ¸³é½±»î¶¯ÒÑ¾­½áÊø
                SetNpcTask(DialogNpcIdx, 9, 3)
                SetNpcTask(DialogNpcIdx, 3, 7)
                local tp = bai * 100 + shi * 10
                wei = player - tp --È¡¸öÎ»
                NpcSay(DialogNpcIdx, "Ng­êi may m¾n thø ba lµ: " .. wei)
                local inix = 730 + wei
                if (wei == 0) then
                    inix = 740
                end
                PlayerCastSkill(1, 741, 1)
                PlayerCastSkill(1, inix, 1)
                PolyMorph(-1, 0, 0, 0, 0)
                local i = PlayerIndex
                local n = 0
                if (IsCaptain() == 0) then
                    n = GetTeamMember(1)
                else
                    n = GetTeamMember(2)
                end
                PlayerIndex = n
                PolyMorph(-1, 0, 0, 0, 0)
                PlayerIndex = i
                local playername = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "player")
                local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")
                local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman")
                local libaoindex = GetNpcTask(DialogNpcIdx, 11)
                NpcSay(DialogNpcIdx, "Tham gia h«n lÔ cña T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>, vÞ quan kh¸ch thø <c=yel>" .. player .. "<c> ®· may m¾n tróng th­ëng! Xin ®Õn chç C©y l­¬ng duyªn ®Ó nhËn th­ëng! Tªn ng­êi may m¾n lµ: <c=g>" .. playername .. "<c>, sÏ nhËn ®­îc <c=yel>" .. libao[libaoindex].name .. "<c>")
                if (GetNpcTask(DialogNpcIdx, 4) == 3) then
                    AddGlobalNews("Tham gia h«n lÔ cña T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c>, vÞ quan kh¸ch thø <c=yel>" .. player .. "<c> ®· may m¾n tróng th­ëng! Xin ®Õn chç C©y l­¬ng duyªn ®Ó nhËn th­ëng! Tªn ng­êi may m¾n lµ: <c=g>" .. playername .. "<c>, sÏ nhËn ®­îc <c=yel>" .. libao[libaoindex].name .. "<c>", 20)
                end
                teamTaskNote(1507, -1)
            end
        end
    end
end

function twoMorph(taskid, index)
    CloseDialog()
    TaskNote(taskid, index)
    PolyMorph(419, 0, 2, 12, 0) -- ÕâÀïÓ¦¸Ã±äÉí³ÉÎªÐÂÀÉ±§ÐÂÄïµÄ×´Ì¬£¡
end

function getredpacket()
    CloseDialog()
    local b_pos = pos_ok(500) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: H«n lÔ lµ ngµy h¹nh phóc nhÊt cña hai ng­êi!")
        return
    elseif (b_pos == 1) then
        if (GetNpcTask(DialogNpcIdx, 12) == 0) then
            local num = GetNpcTask(DialogNpcIdx, 5)  --  »ñ½±ËÍ×£¸£Íæ¼ÒµÄÊýÁ¿
            local big = floor(num / 100)                  --°ÙÎ»Êý£¬´óºì°üµÄ¸öÊý
            local small = floor((num - 100 * big) / 10)  --Ê®Î»Êý £¬ÖÐºì°üµÄ¸öÊý
            if (big > 0) then
                Msg2Player("Chóc mõng nhËn ®­îc " .. big .. " Hång Bao Hµo Hoa")
                local item = JiehunItem[7].Item
                for i = 1, big do
                    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
                end
            end
            if (small > 0) then
                Msg2Player("Chóc mõng nhËn ®­îc " .. small .. " §¹i hång bao")
                local item = JiehunItem[6].Item
                for i = 1, small do
                    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
                end
            end
            if (small == 0 and big == 0) then
                Talk(1, "no", "C©y l­¬ng duyªn: H¬i buån chót! Sè kh¸ch ®Õn chóc mõng ch­a ®Õn 10 ng­êi!")
            else
                local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
                local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
                AddGlobalNews("T©n lang <c=g>" .. man .. "<c> T©n n­¬ng <c=g>" .. woman .. "<c> hÕt søc vui mõng! B¾t ®Çu ph¸t hång bao th«i!", 20)
                SetNpcTask(DialogNpcIdx, 12, 1) --ÒÑ¾­Áìµ½ºì°ü
            end
            SetNpcTask(DialogNpcIdx, 12, 1) --ÒÑ¾­Áìµ½ºì°ü
        else
            Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i ®· nhËn hång bao råi!")
        end
    end
end

function getgift()
    CloseDialog()
    local step = GetNpcTask(DialogNpcIdx, 3)  -- Á¬ÀíÊ÷Ëùµ½µÄ²½Öè
    if (step == 6) then
        Talk(1, "no", "C©y l­¬ng duyªn: §îi T©n n­¬ng rót th¨m th«i! Sau khi T©n n­¬ng rót th¨m míi cã thÓ ®Õn l·nh Tói quµ!")
        return
    end
    if (GetTask(Task_TreeIndex) == DialogNpcIdx and GetTask(Task_TreeID) == GetNpcID(DialogNpcIdx)) then
        local str = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "player")
        if (str == GetName()) then
            local tep = GetNpcTask(DialogNpcIdx, 11)
            NpcSay(DialogNpcIdx, "Chóc mõng <c=g>" .. GetName() .. "<c> nhËn ®­îc <c=yel>" .. libao[tep].name .. "<c>")
            Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. libao[tep].name)
            local item = libao[tep].Item
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
        else
            -- Ã»ÓÐ±»³éÖÐµÄÍæ¼Ò£¬Ö»ÄÜËÍÐ¡Àñ°ü
            local item = libao[1].Item
            Msg2Player("Chóc mõng b¹n nhËn ®­îc Tói quµ nhá!")
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
        end
        SetTask(Task_TreeIndex, 0)
        SetTask(Task_TreeID, 0)
        TaskNote(1506, -1) -- ²Î¼Ó»éÀñÈÎÎñÈ¡Ïû
    else
        local man = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "man")   --»ñµÃÐÂÀËµÄÃû×Ö
        local woman = LoadIniString("Save_Host_Of_Lianlishu", DialogNpcIdx .. "woman") -- »ñµÃÐÂÄïµÄÃû×Ö
        Talk(1, "no", "T©n lang <c=g>" .. man .. "<c> vµ T©n n­¬ng <c=g>" .. woman .. "<c> ®· long träng cö hµnh h«n lÔ ë ®©y!")--ÕâÀïÒª¼ÓÈëÁ½¸öÈËµÄÃû×Ö¡£ÂÞôàÐù
    end
end

function exchangepacket()
    local item = JiehunItem[1].Item
    local hongbao = JiehunItem[4].Item
    local num = HaveNormalItem(item[1], item[2], item[3], item[4])
    if (num == 0) then
        Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i kh«ng cã ThiÖp mõng, kh«ng thÓ tiÕp tôc ®æi hång bao!")
    else
        for i = 1, num do
            DelNormalItem(item[1], item[2], item[3], item[4])
            AddNormalItem(hongbao[1], hongbao[2], hongbao[3], hongbao[4], hongbao[5], hongbao[6])
        end
        Talk(1, "no", "C©y l­¬ng duyªn: Ng­¬i ®æi ®­îc tæng céng <c=yel>" .. num .. "<c> hång bao!")
    end
end

function getrewards()
    local b_pos = pos_ok(500) --NoticeHere Õâ¸ö¾àÀëÐèÒª¸Ä£¡Ã»ÓÐºÍ²ß»®ÉÌÁ¿
    if (b_pos == 2) then
        -- °éÂÂÔÚµ±Ç°µØÍ¼£¬µ«¾àÀëÌ«Ô¶£¨>500£©
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng c¸ch b¹n qu¸ xa!")
        return
    elseif (b_pos == 3) then
        -- ²»ÔÚÒ»ÕÅµØÍ¼ÉÏ
        Talk(1, "no", "C©y l­¬ng duyªn: §èi ph­¬ng kh«ng trong khu vùc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "C©y l­¬ng duyªn: Xin kiÓm tra l¹i ph­¬ng thøc tæ ®éi cña 2 ng­êi! CÇn cã 2 ng­êi tæ ®éi míi cã thÓ hoµn thµnh h«n lÔ!")
        return
    elseif (b_pos == 1) then
        if (GetNpcTask(DialogNpcIdx, 13) == 0) then
            local type = getlibaotype()
            SetNpcTask(DialogNpcIdx, 11, type)
            SetNpcTask(DialogNpcIdx, 13, 1)  --ÐÂÈËÒÑ¾­ÁìÈ¡Àñ°ü
            NpcSay(DialogNpcIdx, "Chóc mõng ng­êi thø hai nhËn ®­îc " .. libao[type].name)
            MsgBox("C©y l­¬ng duyªn: Chóc mõng ng­êi thø hai nhËn ®­îc " .. libao[type].name, "y_getrewards", "no")
        else
            Talk(1, "no", "C©y l­¬ng duyªn: Hai vÞ ®· nhËn phÇn th­ëng råi!")
        end
    end
end

function y_getrewards()
    local type = GetNpcTask(DialogNpcIdx, 11)
    TeamAction("getrewards2", type, 0, 0)
end

function getrewards2(type)
    CloseDialog()
    SetNpcTask(DialogNpcIdx, 13, 1)  -- Ò»¶ÔÐÂÈËÒÑ¾­ÁìÁËÀñ°ü£¬¿ÉÒÔ½øÐÐ³é½±ÁË£¡
    local item = libao[type].Item
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
end

-- Àñ°üÖÖÀà£º1¡¢Ð¡Àñ°ü  2¡¢ÖÐÐÍÀñ°ü  3¡¢´óÐÍÀñ°ü  4¡¢³¬´óÀñ°ü  5¡¢ºÀ»ªÀñ°ü
function getlibaotype()
    local count = GetNpcTask(DialogNpcIdx, 5)
    local weddingstyle = GetNpcTask(DialogNpcIdx, 4)
    local style = 1
    if (count >= 200) then
        if (weddingstyle == 3) then
            style = 5
        elseif (weddingstyle == 2) then
            style = 4
        end
    elseif (count >= 100) then
        if (weddingstyle == 3) then
            style = 4
        elseif (weddingstyle == 2) then
            style = 3
        end
    elseif (count >= 50) then
        if (weddingstyle == 3) then
            style = 3
        elseif (weddingstyle == 2) then
            style = 2
        end
    elseif (count >= 10) then
        if (weddingstyle == 3) then
            style = 2
        elseif (weddingstyle == 2) then
            style = 1
        end
    end
    return style
end

function no()
    CloseDialog()
end
