sel = 0

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 21) or (taskProcess == 23) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 21) or (taskProcess == 23) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) or (taskProcess == 11) or (taskProcess == 14) or (taskProcess == 15) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 10) or (taskProcess == 11) or (taskProcess == 14) or (taskProcess == 15) then
                state = 3
                subState = 1
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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    strings = {
        "<color=green>" .. GetName() .. "<color>: Kh¶i bÈm ®¹i nh©n, Cöu C«ng lÖnh cho t¹i h¹ ®Õn BÊt Chu Thiªn quan dä th¸m t×nh h×nh. §©y lµ <color=yellow>Th«ng quan lÖnh bµi<color>",
        "Lı TŞnh: MÊy h«m tr­íc x¶y ra ®Şa chÊn, con ®­êng dÉn ®Õn <c=yel>BÊt Chu Thiªn quan<c> ®· bŞ bŞ kİn, hiÖn giê ch­a thÓ ®i ®­îc!",
        "<color=green>" .. GetName() .. "<color>VËy sao ®©y? T¹i h¹ ®ang cã qu©n t×nh khÈn cÊp cÇn ®Õn BÊt Chu Thiªn quan",
        "H·y ®Õn Phong ThÇn ®µi t×m <c=g>B¸ Gi¸m<c>, phĞp <c=g>Kh«ng Minh ChuyÓn<c> cña «ng ta cã thÓ gióp ®­îc ng­¬i.",
        "<color=green>" .. GetName() .. "<c>:§¹ t¹! T¹i h¹ lËp tøc ®i ngay."
    }
    if (GetTask(597) == 5) and (HaveEventItem(107) >= 1) then
        local sel = GetTask(596) + 1
        tasks = {
            { "Trang kÕ", "main"; show = 0 },
            { "Th«ng hµnh lÖnh", "zusai"; show = 0 }
        }
        if (sel <= 4) then
            tasks[1].show = 1;
        elseif (sel == 5) then
            tasks[2].show = 1;
        end ;
        SayTask(strings[sel], tasks)
        if (sel <= 4) then
            SetTask(596, sel)
        end ;
    else
        main1()
    end ;
end;

function zusai()
    if (GetTask(597) == 5) and (HaveEventItem(107) >= 1) then
        SetTask(597, 6)
        TaskNote(35, 6)
        DelEventItem(107)
        AddCredit(10)
        AddOwnExp(4000)
        Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
        TopMessage(13051)
        Msg2Player("§i Phong ThÇn ®µi t×m B¸ Gi¸m.")
        SetTask(596, 0)
    end ;
    CloseDialog()
end;

function main1()
    tasks = {
        { "Khuyªn hµng", "renwu1"; show = 0 },

        { "ThÕ Së", "renwu2"; show = 0 },
        { "·ĞÑªÁ¢Æì", "protect_1"; show = 0 },
        { "Á¦Õ¶ÙÁ½«", "protect_2"; show = 0 },
        { "º£µº·éÑÌ", "protect_3"; show = 0 },
        { "²éÑ¯³É¼¨", "protect_info"; show = 0 },

    }
    UTask_Knight = GetTask(3);
    UTask_Wizard = GetTask(1);
    if (UTask_Knight == 21) or (UTask_Knight == 23) then
        tasks[1].show = 1;
    end ;
    if (UTask_Wizard == 10) or (UTask_Wizard == 11) or (UTask_Wizard == 14) or (UTask_Wizard == 15) then
        tasks[2].show = 1;
    end ;

    local nYear, nMon, nDay = GetYMD()
    local nThatDay = GetTaskByte(Task_Protect_2012, 1)
    local nThisDay = math.mod(math.floor(SystemTime() / 86400), 256)
    if (nThatDay ~= nThisDay) then
        SetTaskByte(Task_Protect_2012, 1, nThisDay)
        SetTaskByte(Task_Protect_2012, 2, 0)
        SetTaskByte(Task_Protect_2012, 3, 0)
        SetTaskByte(Task_Protect_2012, 4, 0)
        SetTaskWord(Task_Protect_KillNum, 1, 0)
        SetTaskWord(Task_Protect_KillNum, 2, 0)
        SetTaskByte(Task_Protect_2012_2, 1, 0)
        ClearItem(3, 1174, 0, 0)
        ClearItem(6, 1, 893, 1)
    end
    if (nYear == 2012 and ((nMon == 9 and nDay >= 25) or (nMon == 10 and nDay <= 3))) then
        tasks[3].show = 1;
        tasks[4].show = 1;
        tasks[5].show = 1;
        tasks[6].show = 1;
    else
        SetTask(Task_Protect_2012, 0)
        SetTask(Task_Protect_2012_2, 0)
        SetTask(Task_Protect_KillNum, 0)
        TaskNote(1627, -1)
        TaskNote(1628, -1)
        TaskNote(1629, -1)
        ClearItem(3, 1174, 0, 0)
        ClearItem(6, 1, 893, 1)
    end

    SayTask("¶«å­µºÒ»ÒÛÒÑ½áÊø, ÎÒ·½´óÊ¤!ÏÖÙÁ¿Ü´ó²¿ÒÑ¼ß, Ö»Óà²Ğ²¿¹¶´­, ºóĞøÖ®ÊÂÓÉÎÒ³ÂÌÁ¹ØÊØ½«´¦Àí¼´¿É.´ËÒÛÌìÏÂÓ¢ĞÛ¾¡ÏÔÖÒÓÂÖ®ĞÄ, ºÀÏÀÖ®Òå, ÎÒµÈÅå·ş!Ö»ÊÇÌıÎÅÓñĞéµÀÊ¿ËùÑÔ, ÎÒ»ªÏÄ°ÙÄêºóÈÔ»á±»ÙÁ¿ÜÇÖÈÅ, ÄËÖÁÉúÁéÍ¿Ì¿.²»ÖªÄÇÊ±»¹ÄÜ·ñÓĞÓ¢ĞÛÕâ°ãµÄÈËÎïÁ¦Íì¿ñÀ½, ĞËÎÒ»ªÏÄ.", tasks)

end;

function renwu1()
    UTask_Knight = GetTask(3);
    if (UTask_Knight == 21) then
        Talk(3, "no", 10126, 10127, 10128)
        Msg2Player("KŞp thêi th«ng b¸o tin tøc cho Lı TŞnh.")
        SetTask(3, UTask_Knight + 1)
        TaskNote(27, 6)

        refreshNpcTaskState()

    elseif (UTask_Knight == 23) then
        Talk(3, "no", 10126, 10127, 10128)
        Msg2Player("KŞp thêi th«ng b¸o tin tøc cho Lı TŞnh.")
        SetTask(3, UTask_Knight + 1)
        TaskNote(27, 8)

        refreshNpcTaskState()

    end ;
end;

function renwu2()
    UTask_Wizard = GetTask(1);
    if (UTask_Wizard == 10) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lı TŞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 3)
    elseif (UTask_Wizard == 11) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lı TŞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 6)
    elseif (UTask_Wizard == 14) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lı TŞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 7)
    elseif (UTask_Wizard == 15) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lı TŞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 9)
    end

    refreshNpcTaskState()

end;

function no()
    SetTask(596, 0)
    CloseDialog()
end;

Task_Protect_2012 = 1817

Task_Protect_2012_2 = 1818

Task_Protect_KillNum = 1819

G_Buff_Protect = 1406

function protect_1()
    CloseDialog()
    local nLevel = GetLevel()
    if (nLevel < 60) then
        Talk(1, "close", "ThËt xin lçi, ÄúµÄµÈ¼¶²»×ã cÊp 60, ÎŞ·¨ÁìÈ¡ÈÎÎñ.")
        return
    end

    local nStep = GetTaskByte(Task_Protect_2012, 2)
    if (nStep == 0) then
        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "close", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói. ")
            return
        end
        Talk(1, "close", "ÄÇÙÁ¿Ü´ËÇ°ÉõÎªÏù tÊm, ²»½öµÇµºÁ¢Æì, ¾ÓÈ»»¹ÔØ¸èÔØÎè, È«È»²»°ÑÎÒ·½ÊØ½«·ÅÔÚÑÛÀï!¿ÉÌìÏÂºÀ½ÜÄÄÀïÊÜµÃÁËÕâÆø, ½ñÈÕ¼È¾öÒâ·´»÷, »¹ÇëÓ¢ĞÛµÇÉÏ¶«å­µº, ÏÈ½«ÕâÃæ´óÆì²åÔÚµºÉÏ, ÒÔ´Ë¹ÄÎèÎÒ·½Ê¿Æø!")
        AddNormalItem(6, 1, 893, 1, 0, 0)
        Msg2Player("Ngµi nhËn ®­îc ¿¹ÙÁ´óÆì.")
        TaskNote(1627, 0)
        SetTaskByte(Task_Protect_2012, 2, 1)
    elseif (nStep == 1) then
        Talk(1, "close", "»¹ÇëÓ¢ĞÛËÙËÙµÇÉÏ¶«å­µº, ½«ÕâÃæ´óÆìÁ¢Æğ, ÒÔ¹ÄÎèÎÒ·½Ê¿Æø.")
    elseif (nStep == 2) then
        Talk(1, "close", "Ó¢ĞÛ¹ûÈ»ÍşÎäÖÒÓÂ, ÕâĞ©Ğí½±Àø»¹ÇëÓ¢ĞÛÊÕÏÂ.")
        SetTaskByte(Task_Protect_2012, 2, 3)
        TaskNote(1627, -1)
        if (nLevel <= 100) then
            AddOwnExp(nLevel * 500)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 500) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel <= 150) then
            AddOwnExp(nLevel * 1000)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 1000) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel < 200) then
            AddOwnExp(nLevel * 1500)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 1500) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel >= 200) then
            local nExtendLevel = GetPlayerExtLevel()
            local nExtendExp = 0
            if (nExtendLevel < 10) then
                nExtendExp = nExtendLevel * 300
            elseif (nExtendLevel < 20) then
                nExtendExp = nExtendLevel * 400
            elseif (nExtendLevel < 40) then
                nExtendExp = nExtendLevel * 500
            elseif (nExtendLevel < 50) then
                nExtendExp = nExtendLevel * 800
            else
                nExtendExp = nExtendLevel * 1000
            end
            AddOwnExtendExp(nExtendExp)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nExtendExp .. " §iÓm tu hµnh.")
        end
    elseif (nStep == 3) then
        Talk(1, "close", "Äã½ñÌìµÄÈÎÎñÒÑ¾­Íê³ÉÁË, mêi ngµy mai l¹i tíi ®i.")
    end
end

function protect_2()
    CloseDialog()
    local nLevel = GetLevel()
    if (nLevel < 60) then
        Talk(1, "close", "ThËt xin lçi, ÄúµÄµÈ¼¶²»×ã cÊp 60, ÎŞ·¨ÁìÈ¡ÈÎÎñ.")
        return
    end

    local nStep = GetTaskByte(Task_Protect_2012, 3)
    if (nStep == 0) then
        Talk(1, "close", "ÎÒ¹ÛÕ¼µºÙÁ¿ÜËäÈ»ÁãÉ¢·Ö²¼, µ«Ã¿·ê½»·æ±ØÈ»ÑÚ»¤µÃµ±, ½øÍËÓĞ¶È, Ù²È»²ÙÑİ¹ıÒ»°ã, Ïë±Ø¶¨ÓĞÙÁÈË´ó½«¾ÓÆäºóÒÔÖ¸»Óµ÷¶È.ËùÎ½ÇÜµĞÇÜÊ×, »¹ÇëÓ¢ĞÛÇ±ÈëµºÉÏ, ÏÈ½«ÄÇÙÁÈË´ó½«³ıµô, ÆäÓàÙÁ¿Ü±ã¿ÉÒ»»÷¶øÀ£!ÄÇÙÁÈË´ó½«<c=g>Ã¿30·ÖÖÓ<c>²ÅÏÖÉíÒ»´Î, ÇëÓ¢ĞÛ×¥×¡Ê±»ú!")
        SetTaskByte(Task_Protect_2012, 3, 1)
        TaskNote(1628, 0)
    elseif (nStep == 1) then
        Talk(1, "close", "ÄÇÆÄÉÆÓÃ±øµÄÙÁÈË´ó½«²»³ı, ÎÒ·½ºÀ½ÜÒåÊ¿ÖÕÊÇÄÑÒ×¹¥ÏÂÕâ¶«å­µº.ÎÒµÈÔÚ´Ë¾²´ıÓ¢ĞÛ¼ÑÒôÁË.")
    elseif (nStep == 2) then
        Talk(1, "close", "Ó¢ĞÛÕæÄËÉñÈË, ³öÈëµĞÓªÈçÈëÎŞÈËÖ®¾³, Åå·ş!ÕâÊÇÓ¢ĞÛÓ¦µÃµÄ½±ÉÍ!")
        if (nLevel <= 100) then
            AddOwnExp(nLevel * 1000)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 1000) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel <= 150) then
            AddOwnExp(nLevel * 1500)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 1500) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel < 200) then
            AddOwnExp(nLevel * 2000)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. (nLevel * 2000) .. " ®iÓm kinh nghiÖm.")
        elseif (nLevel >= 200) then
            local nExtendLevel = GetPlayerExtLevel()
            local nExtendExp = 0
            if (nExtendLevel < 10) then
                nExtendExp = nExtendLevel * 400
            elseif (nExtendLevel < 20) then
                nExtendExp = nExtendLevel * 600
            elseif (nExtendLevel < 30) then
                nExtendExp = nExtendLevel * 700
            elseif (nExtendLevel < 40) then
                nExtendExp = nExtendLevel * 1000
            else
                nExtendExp = nExtendLevel * 1500
            end
            AddOwnExtendExp(nExtendExp)
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nExtendExp .. " §iÓm tu hµnh.")
        end
        ClearItem(3, 1174, 0, 0)
        SetTaskByte(Task_Protect_2012, 3, 3)
        TaskNote(1628, -1)
    elseif (nStep == 3) then
        Talk(1, "close", "Äã½ñÌìµÄÈÎÎñÒÑ¾­Íê³ÉÁË, Ã÷ÌìÔÙÀ´°É.")
    end
end

function protect_3()
    CloseDialog()
    local nLevel = GetLevel()
    if (nLevel < 60) then
        Talk(1, "close", "ThËt xin lçi, ÄúµÄµÈ¼¶²»×ã cÊp 60, ÎŞ·¨ÁìÈ¡ÈÎÎñ.")
        return
    end

    local nStep = GetTaskByte(Task_Protect_2012, 4)
    if (HaveIBBuff(G_Buff_Protect) > 0 or nStep == 1) then
        Talk(1, "close", "ÌìÏÂºÀ½ÜÒÑÔÚ¶«å­µºÉÏÓëÙÁ¿Ü»ìÕ½½»·æ, »¹ÇëÓ¢ĞÛËÙËÙÇ°ÍùÖ§Ô®!")
    elseif (nStep == 0 or nStep == 3) then
        local nHour, nMin, nSec = GetHMS()
        if (nHour < 19 or nHour >= 22) then
            Talk(1, "close", "ThËt xin lçi, Ö»ÓĞÔÚ19µãÖÁ22µãÖ®¼ä²ÅCã thÓ nhËn´ËÈÎÎñ.")
            return
        end
        MsgBox("Ó¢ĞÛÏÖ¿ÉÓëÎÒ·½ÖÒÓÂÖ®Ê¿½«ÙÁ¿ÜÉ¨µ´´ù¾.¡ÎÒ¿É½«10·ÖÖÓµÄ·¨Á¦×¢ÈëÓ¢ĞÛÌåÄÚ, ÇëÔÚ´ËÊ±¼äÄÚ´ò°Ü¹æ¶¨ÊıÁ¿µÄÙÁ¿Ü.´ËÍâ¼ßµĞ×î¶àµÄÓ¢ĞÛ»¹¿É»ñµÃ¶îÍâ½±Àø!Ã¿ÈÕ½±ÀøÖ»¸øÓè²»Í¬µÈ¼¶¶ÎÄÚ¼ßµĞ×î¶àµÄÒ»Î»Ó¢ĞÛ, Ó¢ĞÛÔÚ trong thêi gian ho¹t ®éng¿É²»¶Ï¸ÄĞ´¸ü¸ßµÄ¼ßµĞ¼ÇÂ¼ÒÔ»ñÈ¡×îÖÕµÄ¶îÍâ½±Àø!Í¬Ò»¹ú¼Ò³ÉÔ±×é¶Ó´ò°ÜÙÁ¿Ü½«ÓĞ¸ÅÂÊÊ¹¼ÆÊı¼Ó³É, ÄúÈ·¶¨ÏÖÔÚÁìÈ¡×´Ì¬ sao?", "Yes_protect_3", "close")
    elseif (nStep == 2 and HaveIBBuff(G_Buff_Protect) <= 0) then
        local nThisNum = GetTaskWord(Task_Protect_KillNum, 1)
        local nBestNum = GetTaskWord(Task_Protect_KillNum, 2)
        local nTimes = GetTaskByte(Task_Protect_2012_2, 1) + 1
        local gBestNum1 = LoadIniInteger("Save_Protect_Num", 1)
        local gBestNum2 = LoadIniInteger("Save_Protect_Num", 2)
        local gBestNum3 = LoadIniInteger("Save_Protect_Num", 3)
        if (nBestNum < nThisNum) then
            nBestNum = nThisNum
            SetTaskWord(Task_Protect_KillNum, 2, nBestNum)
        end

        if (nLevel <= 100 and (gBestNum1 == nil or gBestNum1 < nBestNum)) then
            SaveIniInteger("Save_Protect_Num", 1, nBestNum)
            SaveIniString("Save_Protect_Num", "name1", GetName())
        elseif (nLevel <= 150 and (gBestNum2 == nil or gBestNum2 < nBestNum)) then
            SaveIniInteger("Save_Protect_Num", 2, nBestNum)
            SaveIniString("Save_Protect_Num", "name2", GetName())
        elseif (nLevel > 150 and (gBestNum3 == nil or gBestNum3 < nBestNum)) then
            SaveIniInteger("Save_Protect_Num", 3, nBestNum)
            SaveIniString("Save_Protect_Num", "name3", GetName())
        end

        Talk(1, "close", "Äú±¾´Î¼ßµĞ¸öÊıÎª" .. nThisNum .. ",ÄúµÄ×îºÃ³É¼¨Îª" .. nBestNum .. ".")
        SetTaskByte(Task_Protect_2012, 4, 3)
        SetTaskByte(Task_Protect_2012_2, 2, 0)
        SetTaskWord(Task_Protect_KillNum, 1, 0)
        TaskNote(1629, -1)
        local nList = { 100, 200, 400 }
        local nIndex = 3
        if (nLevel <= 100) then
            nIndex = 1
        elseif (nLevel <= 150) then
            nIndex = 2
        end

        if (nThisNum >= nList[nIndex]) then
            SetTaskByte(Task_Protect_2012_2, 1, nTimes)
            if (nTimes == 1) then
                local nExp = nLevel * 2000
                if (nLevel >= 200) then
                    local nExtendLevel = GetPlayerExtLevel()
                    local nExtendExp = 0
                    if (nExtendLevel < 10) then
                        nExtendExp = nExtendLevel * 800
                    elseif (nExtendLevel < 20) then
                        nExtendExp = nExtendLevel * 1000
                    elseif (nExtendLevel < 30) then
                        nExtendExp = nExtendLevel * 1200
                    elseif (nExtendLevel < 40) then
                        nExtendExp = nExtendLevel * 1500
                    elseif (nExtendLevel < 50) then
                        nExtendExp = nExtendLevel * 2000
                    else
                        nExtendExp = nExtendLevel * 2500
                    end
                    AddOwnExtendExp(nExtendExp)
                    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nExtendExp .. " §iÓm tu hµnh.")
                else
                    AddOwnExp(nExp)
                    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
                end
                Msg2Player("Ó¢ĞÛÖÒ¸ÎÒåµ¨, ÕæÄËÎÒ³¯Ö®¸£Òô!ÕâĞ©½±ÉÍ»¹ÇëÓ¢ĞÛÊÕÏÂ.")
            end
        else
            Talk(1, "no", "Ó¢ĞÛÎ´ÄÜÔÚ¹æ¶¨Ê±¼äÄÚÇı³ı×ã¹»ÊıÁ¿µÄÙÁ¿Ü, ´ËÒÛÕ½¹û²»¼Ñ, ·³ÀÍÓ¢ĞÛÔÙ¸°¶«å­µºÒ»Õ½!")
        end
    end
end

function Yes_protect_3()
    close()
    local nLevel = GetLevel()
    local sKillName = "ÙÁÈË¶Ó³¤"
    local nKillType = 3
    local nKillNum = 400
    if (nLevel <= 100) then
        sKillName = "¶i Nh©n"
        nKillType = 1
        nKillNum = 100
    elseif (nLevel <= 150) then
        sKillName = "ÙÁÈËÎäÕß"
        nKillType = 2
        nKillNum = 200
    end
    TaskNote(1629, 0, nKillNum, sKillName)
    AddIBBuff(G_Buff_Protect)
    SetTaskByte(Task_Protect_2012, 4, 1)
    SetTaskByte(Task_Protect_2012_2, 2, nKillType)
    Talk(1, "close", "Ngµi nhËn ®­îc Å­½£ÍÀÙÁ×´Ì¬, ËÙÈ¥¶«å­µº´ò°ÜÙÁ¿Ü°É.")
end

function protect_info()
    CloseDialog()
    local gBestNum1 = LoadIniInteger("Save_Protect_Num", 1)
    local gBestNum2 = LoadIniInteger("Save_Protect_Num", 2)
    local gBestNum3 = LoadIniInteger("Save_Protect_Num", 3)
    local gBestName1 = LoadIniString("Save_Protect_Num", "name1")
    local gBestName2 = LoadIniString("Save_Protect_Num", "name2")
    local gBestName3 = LoadIniString("Save_Protect_Num", "name3")
    local nBestNum = GetTaskWord(Task_Protect_KillNum, 2)
    local str = ""
    local str1 = ""
    local nLevel = GetLevel()
    if (nLevel <= 100 and gBestNum1 ~= nil and gBestName1 ~= nil and gBestNum1 ~= 0 and gBestName1 ~= "") then
        str1 = ", Ä¿Ç°½µ·şÙÁÈËµÄ×îºÃ³É¼¨Îª: \n"
        str = str1 .. "ĞÕÃû: " .. gBestName1 .. "	 ³É¼¨: " .. gBestNum1 .. "\n"
    elseif (nLevel <= 150 and gBestNum2 ~= nil and gBestName2 ~= nil and gBestNum2 ~= 0 and gBestName2 ~= "") then
        str1 = ", Ä¿Ç°½µ·şÙÁÈËÎäÕßµÄ×îºÃ³É¼¨Îª: \n"
        str = str1 .. "ĞÕÃû: " .. gBestName2 .. "	 ³É¼¨: " .. gBestNum2 .. "\n"
    elseif (gBestNum3 ~= nil and gBestName3 ~= nil and gBestNum3 ~= 0 and gBestName3 ~= "") then
        str1 = ", Ä¿Ç°½µ·şÙÁÈË¶Ó³¤µÄ×îºÃ³É¼¨Îª: \n"
        str = str1 .. "ĞÕÃû: " .. gBestName3 .. "	 ³É¼¨: " .. gBestNum3 .. "\n"
    end

    Talk(1, "close", "Äúµ±Ç°×îºÃ³É¼¨Îª" .. nBestNum .. str)
end

function close()
    CloseDialog()
end

