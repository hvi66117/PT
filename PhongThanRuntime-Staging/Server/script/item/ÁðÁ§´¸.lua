Task_Third_Trans = 639

Task_Egg = 638

Global_Task = 71

Egg_Temp_ID = {
    { 1878, "Æß²ÊÁğÁ§µ°.³à" },
    { 1879, "Æß²ÊÁğÁ§µ°.³È" },
    { 1880, "Æß²ÊÁğÁ§µ°.»Æ" },
    { 1881, "Æß²ÊÁğÁ§µ°.ÂÌ" },
    { 1882, "Æß²ÊÁğÁ§µ°.Çà" },
    { 1883, "Æß²ÊÁğÁ§µ°.À¶" },
    { 1884, "Æß²ÊÁğÁ§µ°.×Ï" },
}

function main(nLevel, t, nTNpcIdx, nItemId)
    if Check_Authority_Proc() <= 0 then
        return
    end

    SetTask(Task_HammerID, nItemId)

    Hammer_Mouse_Select()

end

function Hammer_Mouse_Select()
    CloseDialog()
    MouseSelect(1, 7, "Mouse_Select", "Mouse_Select")
end

function Mouse_Select(nItemID)
    no()

    local nTargetIdx = GetPlayerTarget()
    local nTargetTempId = GetNpcTemplateID(nTargetIdx)

    if Check_Target_Legal(nTargetTempId) == 0 then
        Msg2Player("ÁğÁ§´¸Ö»ÄÜÓÃÀ´»÷ËéÆß²ÊÁğÁ§µ°Å¶!")
        return
    end

    if IsHaveSpaceForTreasure(2) == 0 then
        Msg2Player("Ó¢ĞÛµÄ±³°ü¿Õ¼ä²»×ãÅ¶, ÇëÕûÀíÒ»ÏÂ±³°üÔÙÀ´ÔÒµ°°É!")
        TopMessage("ÇëÕûÀíÒ»ÏÂ±³°üÔÙÀ´ÔÒµ°°É")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 0)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(nTargetIdx, 0, 3, "\\script\\item\\ÁğÁ§´¸.lua", nInterrupt, 100, "ÔÒµ°ÖĞ")
end

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    local NpcTemplateID = GetNpcTemplateID(TargetNpcIdx)
    local nIdxInTable = Check_Target_Legal(NpcTemplateID)
    if TargetNpcIdx == MotionID and nIdxInTable > 0 then
        local nCount = 0
        for i = 1, 7 do
            if (NpcTemplateID == Egg_Temp_ID[i][1]) then
                nCount = nCount + 1
            end
        end
        if (nCount == 0) then
            InfoBox("Õæ¿ÉÏ§, Æß²ÊÁğÁ§µ°ÒÑ±»ÆäËûÈËÄÃ×ßÁË.")
            return
        end

        if (HaveNormalItem(6, 1, 878, 0) == 0) and (HaveNormalItemInQuick(6, 1, 878, 0) == 0) then
            InfoBox("ÄãµÄ±³°üÀïÃ»ÓĞÁğÁ§´¸!!")
            return
        end

        NpcCastSkill(TargetNpcIdx, 1, 815, 1)
        local nTimes = GetTaskByte(Task_Third_Trans, 3)
        SetTaskByte(Task_Third_Trans, 3, nTimes + 1)

        local name = GetNpcName(TargetNpcIdx)
        if (name == "" or name == nil) then
            name = "Æß²ÊÁğÁ§µ°"
        end
        SetTaskBit(Task_Third_Trans, 31, 1)
        GiveReward(name)

        if (DelNormalItem(6, 1, 878, 0) == 0) then
            DelNormalItemInQuick(6, 1, 878, 0)
        end
    else
        Msg2Player("Ngµi kh«ng cã ×¼È·µÄ»÷ËéÆß²ÊÁğÁ§µ°!")
    end
end

function GiveReward(sName)
    if (GetTaskBit(Task_Third_Trans, 31) == 0) then
        return 0
    end
    SetTaskBit(Task_Third_Trans, 31, 0)

    local rand = 1
    rand = math.random(1, 100)

    if (GetTaskBit(Task_Third_Trans, 26) == 1) then
        rand = math.random(6, 100)
    elseif (GetTaskByte(Task_Egg, 3) >= 2) then
        rand = math.random(16, 100)
    end

    if (rand <= 5) then
        local index = GetTaskBit(Task_Third_Trans, 26)
        if (index == 0) then
            Earn(20000)
            Msg2Player("Äú»ñµÃ20000½ğÇ®.")
            ScrollMessage("Äú»ñµÃ20000 b¹c")
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc 20000½ğÇ®!")
            SetTaskBit(Task_Third_Trans, 26, 1)
            WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][2 v¹n½ğÇ®]")
        else
            SetTaskBit(Task_Third_Trans, 31, 1)
            GiveReward(sName)
        end
    elseif (rand <= 15) then
        local index = GetTaskByte(Task_Egg, 3) + 1
        if (index <= 2) then
            Earn(10000)
            Msg2Player("Äú»ñµÃ10000½ğÇ®.")
            ScrollMessage("Äú»ñµÃ10000 b¹c")
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc 10000½ğÇ®!")
            SetTaskByte(Task_Egg, 3, index)
            WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][1 v¹n½ğÇ®]")
        else
            SetTaskBit(Task_Third_Trans, 31, 1)
            GiveReward(sName)
        end
    elseif (rand <= 25) then
        AddNormalItemBind(6, 1, 879, 0, 0, 0, 1)
        Msg2Player("Ngµi nhËn ®­îc Àñ»¨.")
        ScrollMessage("Ngµi nhËn ®­îc Àñ»¨")
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc Àñ»¨!")
        WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][Àñ»¨]")
    elseif (rand <= 35) then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        Msg2Player("Ngµi nhËn ®­îc Di Ngo¹i Phï.")
        ScrollMessage("Ngµi nhËn ®­îc Di Ngo¹i Phï")
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc Di Ngo¹i Phï!")
        WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][Di Ngo¹i Phï]")
    elseif (rand <= 80) then
        local rand1 = math.random(1, 4)
        local changeTable = { [1] = { 8, 434, 2, "V« ¶nh Kh­¬ng Tö Nha" }, [2] = { 8, 76, 2, "Ngäc N÷" }, [3] = { 8, 161, 2, "ÎÒ°®Äã" }, [4] = { 8, 194, 2, "T©m T©m T­¬ng Ên" } }
        AddNormalItemBind(changeTable[rand1][1], changeTable[rand1][2], changeTable[rand1][3], 0, 0, 0, 1)
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. changeTable[rand1][4] .. "±äÉí·û.")
        ScrollMessage("Ng­¬i ®· nhËn ®­îc " .. changeTable[rand1][4] .. "BiÕn th©n phï")
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn" .. changeTable[rand1][4] .. "±äÉí·û!")
        WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][" .. changeTable[rand1][4] .. "±äÉí·û]")
    elseif (rand <= 94) then
        GetBuleEquip(sName)
    elseif (rand <= 95) then
        GetGreenEquip(sName)
    else
        AddNormalItemBind(8, 233, 0, 0, 0, 0, 1)
        Msg2Player("Ngµi nhËn ®­îc ÂŞºººÅ½Ç.")
        ScrollMessage("Ngµi nhËn ®­îc ÂŞºººÅ½Ç")
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc ÂŞºººÅ½Ç!")
        WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][ÂŞºººÅ½Ç]")
    end
end

CareerTable = {
    [1] = {
        [1] = { 0, 9, 0 }, [2] = { 0, 6, 0 }, [3] = { 0, 7, 0 }, [4] = { 0, 2, 0 }, [5] = { 0, 5, 0 },
    },
    [2] = {
        [1] = { 0, 9, 1 }, [2] = { 0, 6, 1 }, [3] = { 0, 7, 1 }, [4] = { 0, 2, 1 }, [5] = { 0, 5, 1 },
    },

    [3] = {
        [1] = { 0, 9, 2 }, [2] = { 0, 6, 2 }, [3] = { 0, 7, 2 }, [4] = { 0, 2, 2 }, [5] = { 0, 5, 2 },
    }
}
CareerGreenTable = {
    [1] = {
        [1] = { 0, 9, 6 }, [2] = { 0, 6, 6 }, [3] = { 0, 7, 6 }, [4] = { 0, 2, 6 }
    },
    [2] = {
        [1] = { 0, 9, 7 }, [2] = { 0, 6, 7 }, [3] = { 0, 7, 7 }, [4] = { 0, 2, 7 }
    },
    [3] = {
        [1] = { 0, 9, 8 }, [2] = { 0, 6, 8 }, [3] = { 0, 7, 8 }, [4] = { 0, 2, 8 }
    }
}

function GetBuleEquip(sName)
    local playerType = GetPlayerType() + 1
    local rand = math.random(1, 5)
    local level = GetLevel()
    local equipLevel = 0

    if (level < 30) then
        equipLevel = 2
    elseif (level < 40) then
        equipLevel = 3
    elseif (level < 50) then
        equipLevel = 4
    elseif (level < 60) then
        equipLevel = 5
    else
        equipLevel = 6
    end

    AddBlueEquip(CareerTable[playerType][rand][1], CareerTable[playerType][rand][2], CareerTable[playerType][rand][3], equipLevel, 0, 0, 1)

    Msg2Player("Ngµi nhËn ®­îc À¶É«×°±¸.")
    ScrollMessage("Ngµi nhËn ®­îc À¶É«×°±¸")
    local index = GetPlayerTarget()
    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc À¶É«×°±¸!")

    WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][À¶×°]")
end

function GetGreenEquip(sName)
    local mapId, _, _ = GetWorldPos()
    local nGreenEquipNum = GetGlobalValueByte(Global_Task, mapId)

    if (GetGlobalValueBit(Global_Task, mapId - 1) == 0 and nGreenEquipNum < 6) then
        local playerType = GetPlayerType() + 1
        local rand = math.random(1, 4)
        AddNormalItem2(CareerGreenTable[playerType][rand][1], CareerGreenTable[playerType][rand][2], CareerGreenTable[playerType][rand][3], 2, 0, 0)
        Msg2Player("Ngµi nhËn ®­îc ÂÌÉ«×°±¸.")
        ScrollMessage("Ngµi nhËn ®­îc ÂÌÉ«×°±¸")

        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">¾­¹ıÇ§ÌôÍòÑ¡ÔÒËéÁË" .. sName .. ", nhËn ®­îc ÂÌÉ«×°±¸!")
        AddGlobalNews("<c=g><RoleName=\"" .. GetName() .. "\"><c> hång vËn ®­¬ng ®Çu, ÔÒËéÁË" .. sName .. "ºóĞÒÔËµØ nhËn ®­îc ÂÌÉ«×°±¸!")

        SetGlobalValueBit(Global_Task, mapId - 1, 1)
        SetGlobalValueByte(Global_Task, mapId, nGreenEquipNum + 1)
        WriteLog("[ĞÂ·şÔÒµ°»î¶¯][»î¶¯][ÂÌ×°]")
    else
        SetTaskBit(Task_Third_Trans, 31, 1)
        GiveReward(sName)

    end
end

function Check_Target_Legal(nTargetTempId)
    local nFind = 0

    for i = 1, 7 do
        if nTargetTempId == Egg_Temp_ID[i][1] then
            nFind = i
            break
        end
    end

    return nFind
end

function Check_Authority_Proc()
    local nYear, nMonth, nDay = GetYMD()
    if (checkTime() == 1) then
        local nDay = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
        local nLogDay = GetTaskByte(Task_Third_Trans, 2)

        local per_PassDay = GetTaskByte(Task_Egg, 1)
        if (nDay ~= per_PassDay) then

            SetTaskByte(Task_Egg, 1, nDay)
            SetTaskBit(Task_Third_Trans, 26, 0)
            SetTaskByte(Task_Egg, 3, 0)
        end

        if nLogDay ~= nDay then
            SetTaskByte(Task_Third_Trans, 2, nDay)
            SetTaskByte(Task_Third_Trans, 3, 0)
            return 1
        end
        local nTimes = GetTaskByte(Task_Third_Trans, 3)
        if nTimes < 10 then
            return 1
        end

        Msg2Player("ÁğÁ§´¸µÄ·¨Á¦Ã¿Ìì×î¶àÖ»ÄÜÔÒ¿ª10´ÎÁğÁ§µ°, ÄúµÄÁğÁ§´¸·¨Á¦²»×ã, »¹ÊÇÃ÷ÌìÔÙÀ´ÊÔÊÔ°É!")

        TopMessage("ÁğÁ§´¸·¨Á¦²»×ã")

        return 0
    else
        Msg2Player("ÇëÔÚ2011Äê12ÔÂ16ÈÕÖÁ2012Äê1ÔÂ2ÈÕÊ©Õ¹ÔÒÁğÁ§µÄ·¨Á¦ÔÒÆß²ÊÁğÁ§µ°.")
        return 0
    end
end

function checkTime()
    local y, m, d = GetYMD()

    local nHour, nMin, nSec = GetHMS()
    if (y == 2012) and (m == 3) and ((d >= 10 and d <= 18) or (d == 9 and nHour >= 17)) then
        return 1
    end

    return 0
end

function no()
    CloseDialog()
end
