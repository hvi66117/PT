Include("\\script\\gvn\\lib.lua");
--description:95¼¶Ñ­»·ÈÎÎñ
--author: yaoxin
--date: 2007/11/06

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-21
TASK_renwu = 1139 --1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı, 3, µ±Ç°µÃ»·½Ú,(1½Ó,2Áì,3Íê³É),4,ÊÇ·ñÁì¹ı¶îÍâµÄ½õºÏ
TASK_Npcindex = 1140 --Í¬Ê±ÔÚ½ÓÇ°×öÊÇ·ñÌåËÙµÄ±êÊ¶(1=ÆÕÍ¨£¬2=¸ÄÁ¼)
TASK_Lucky = 1141 --É±¹ÖµÃ½õºÏµÄĞÒÔËÖµ
--1142 Ã¿ÈÕÈÎÎñ´ÎÊı¼ÇÂ¼
Task_Yiqi = 1532        --1byte:ÊÇ·ñÊ¹ÓÃÒåÆøÖµ 2byte:ÊÇ·ñÔÚÉñÃØµÀÈË´¦½»¹ı½ğÇ®

Task_lingchong = 1395 -- 1byte: 1:½ÓÁé³èÖ®Ô¸ÈÎÎñ£»2:³èÎïĞéÈõ×´Ì¬ 3£ºÍê³ÉÈÎÎñ
-- 2byte: 1£ºÁé³èÖ®Ô¸Ö®³èÎïĞéÈõ£»2£ºÁé³èÖ®Ô¸Ö®³èÎï»Ö¸´
-- 3byte: 1:½Ó¹ıÁé³èÖ®Ô¸ÈÎÎñ£»2£ºÂòÁËµ°£»3£º´øµ°Íæ¹»24Ğ¡Ê±£»


TASK_TIMES_Max = 9    --½ÓÈÎÎñµÄÉÏÏŞ£¬º¬Ãâ·ÑµÄ£¬

-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
TaskTimes = {
    [1] = { totalTimes = 630, awardsTimes = 5, },
    [2] = { totalTimes = 390, awardsTimes = 4, },
    [3] = { totalTimes = 270, awardsTimes = 3, },
    [4] = { totalTimes = 210, awardsTimes = 2, },
    [5] = { totalTimes = 180, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1699 -- Ë«±¶¾­ÑéÓÅ»¯ 1Byte£ºÒÑ¾­ÁìÈ¡µÄË«±¶¾­Ñé´ÎÊı 2Byte£º¿ÉÁìÈ¡µÄË«±¶¾­Ñé×Ü´ÎÊı
G_Double = 370 -- È«¾Ö±äÁ¿
-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 95
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local guardindex = GetTGuardIndexByPlayerName(GetName())
    local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)
    local insideindex = IsPlayerInsideWeapon(PlayerIndex)
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --if (GetTaskByte(TASK_renwu,3)==0 and thisday ~= lastday) then
            --state = 0
            --subState = 0
            if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTask(959) ~= 1) and (GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 3
                subState = 0
            elseif (GetTaskByte(TASK_renwu, 3) > 0 and GetTaskByte(TASK_renwu, 3) ~= 3 and GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 2
                subState = 0
            end
        else
            --if (GetTaskByte(TASK_renwu,3)==0 and GetTaskByte(TASK_renwu,2)<=1) then
            --state = 0
            --subState = 0
            if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTask(959) ~= 1) and (GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 3
                subState = 1
            elseif (GetTaskByte(TASK_renwu, 3) > 0 and GetTaskByte(TASK_renwu, 3) ~= 3 and GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 2
                subState = 0
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    local tasks = {
        { "Tèng Töu", "renwu"; show = 0 },
        { "Phong Ma Bİch", "shuoming"; show = 1 }
    }
    local huanshu = GetByte(GetTask(TASK_renwu), 3)
    local lastday = GetByte(GetTask(TASK_renwu), 1)
    if (GetLevel() >= 95) then
        --if(lastday>0)and(huanshu ==2)  then
        if (huanshu == 2) then
            -- modify by mayining 2008.7.20
            tasks[1].show = 1
        end ;
    end
    SayTask("¸i chµ chµ! ThÌm r­îu qu¸! Anh hïng nµo gióp ta mang vµi b×nh r­îu quı ®Õn, ta nhÊt dŞnh sÏ t¹ ¬n!", tasks)
end;

function renwu()
    MsgBox("å! R­îu th¬m qu¸! Huynh ®Ö ta ë T©y Kú cã nhê ng­¬i mang r­îu ®Õn cho ta, ng­¬i ®· chuyÓn ®Õn ch­a?", "renwu1", "no")
end
function renwu1()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quı, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma Bİch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu Bİch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        -- ÅĞ¶ÏÊÇ·ñÔÚ³µÀï
        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTask(959) ~= 1) then
            jiangli()
        elseif (GetTask(959) == 1) then
            Talk(1, "no", "Ta chØ cÇn r­îu quı, kh«ng cÇn l­¬ng thùc cña ng­¬i!")-- ÊÇÔËÁ¸³µµÄĞÎÌ¬À´½»ÈÎÎñ
        else
            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quı ®Õn? Mau ®­a r­îu ®©y! GhiÒn r­îu qu¸!")-- ²»ÊÇ³µµÄĞÎÌ¬À´½»ÈÎÎñ
        end ;
    end ;
end;

function jiangli()
    local tasks2 = {
        { "nhËn  ®iÓm kinh nghiÖm", "item1"; show = 1 },
        { "m¶nh Phong Ma Bİch", "item2"; show = 1 },
        { "Phong Ma Bİch", "shuoming"; show = 1 }
    }

    SayTask("Bİch Du Nh©n:C¶m t¹, l©u l¾m råi ta kh«ng ®­îc th­ëng thøc h­¬ng vŞ cña r­îu, ng­¬i ®óng lµ cøu tinh cña ta, ta sÏ b¸o ®¸p ng­¬i. Ta cã mét bİ ph¸p cã thÓ gióp ng­¬i nhËn ®­îc thËt nhiÒu kinh nghiÖm, vµ 1 sè To¸i phiÕn cña ngäc th­îng ®¼ng chøa ma lùc, ng­¬i xem thİch g× nµo?", tasks2)
end

function item1()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quı, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma Bİch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu Bİch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        -- ÅĞ¶ÏÊÇ·ñÔÚ³µÀï
        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTask(959) ~= 1) then
            DeleteSiegeWeapon(carriageindex)

            local boxnums = GetIBBuffTimes(377)
            local exp1 = GetLevel() * 2000 * boxnums
            clear(boxnums)

            -----------------------------------
            --³èÎï»î¶¯
            if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
                local pr = random(1, 5)
                if (pr == 5) then
                    AddIBBuff(418)
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 2) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc 2 <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc 2 Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                else
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 1) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")
                end
            end
            ------------------------------------

            ----------------------------
            --¹ú¼Ê°æÊ¥µ®¡¢Ôªµ©»î¶¯ 
            --			AddNormalItemPile(3,243,0,0,0,0)
            --		Msg2Player("Äã»ñµÃÁËÊ¥µ®Ã±Ò»¸ö£¡¹ØÓÚÊ¥µ®Ã±µÄÏêÇéÇëÑ¯ÎÊÎ÷áªµÄÀñ¹Ù£¡")
            --			ScrollMessage("Äã»ñµÃ<c=g>Ê¥µ®Ã±<c>Ò»¸ö")
            ---------------------------------
            ------------------------------------
            --100¼¶Îü»êÒõÉ·
            if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
                AddIBBuff(426)
                Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
            end
            ---------------------------------------
            -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
            ----------Modify by xiaojiaquan for ĞÂÖ÷ÌâÈÕÈÎÎñ at 2011-04-14 Begin--------------
            local weekDay = GetWeekDay()
            if (GetTaskByte(Double_Optimization, 3) < 8) then
                local tempExp = exp1
                if (GetTaskByte(Double_Optimization, 3) > 0) then
                    exp1 = exp1 + tempExp
                end
                if (weekDay == 5) then
                    exp1 = exp1 + tempExp
                    Msg2Player("H«m nµy chñ ®Ò nhiÖm vô Tèng Töu, chóc mõng b¹n, nhËn ®­îc phÇn th­ëng gÊp ®«i")
                end
                --exp1 = exp1 * 2
                ----------Modify by xiaojiaquan for ĞÂÖ÷ÌâÈÕÈÎÎñ at 2011-04-14 End--------------
            elseif (GetTaskByte(Double_Optimization, 3) >= 8) then
                local nTemp = GetTaskByte(Double_Optimization, 3)
                nTemp = SetBit(nTemp, 6, 0)
                SetTaskByte(Double_Optimization, 3, nTemp)
            end

            local str = ""
            local taskDay = GetWeekDay()
            local index = 6
            for i = 1, 6 do
                if (GetTask(1142) == TaskTimes[i].totalTimes) then
                    index = i
                    break
                end
            end

            if (GetGlobalValueByte(370, 4) == 1 and index < 6) then
                if (taskDay < 7) then
                    str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " ngµy, ngµy mai ®Õn nhËn nhĞ!"
                else
                    str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. "PhÇn th­ëng nh©n ®«i kinh nghiÖm trong ngµy, mêi tuÇn §ç Khang kÕ tiÕp h·y ®Õn nhËn!"
                end
            end
            -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

            AddOwnExp(exp1)
            TopMessage("nhËn ®­îc <c=g>" .. exp1 .. "§iÓm kinh nghiÖm<c>")
            Msg2Player("B¹n nh©n ®­îc" .. exp1 .. "§iÓm kinh nghiÖm.")
            KsgTask:OnFinish(1139);

            Talk(1, "no", "Mçi b×nh r­îu sÏ nhËn ®­îc ®¼ng cÊp*2000 ®iÓm kinh nghiÖm, lÇn nµy ng­¬i nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm!" .. str)
            refreshNpcTaskState()
        elseif (GetTask(959) == 1) then
            Talk(1, "no", "Ta chØ cÇn r­îu quı, kh«ng cÇn l­¬ng thùc cña ng­¬i!")-- ÊÇÔËÁ¸³µµÄĞÎÌ¬À´½»ÈÎÎñ
        else
            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quı ®Õn? Mau ®­a r­îu ®©y! GhiÒn r­îu qu¸!")-- ²»ÊÇ³µµÄĞÎÌ¬À´½»ÈÎÎñ
        end ;
    end ;

end

function item2()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quı, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma Bİch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu Bİch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        -- ÅĞ¶ÏÊÇ·ñÔÚ³µÀï
        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTask(959) ~= 1) then
            DeleteSiegeWeapon(carriageindex)

            local boxnums = GetIBBuffTimes(377)
            clear(boxnums)
            for i = 1, boxnums do
                AddNormalItemPile(3, 175, 0, 0, 0, 0)
            end

            -----------------------------------
            --³èÎï»î¶¯
            if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
                local pr = random(1, 5)
                if (pr == 5) then
                    AddIBBuff(418)
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 2) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc 2 <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc 2 Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")
                else
                    AddIBBuff(418)

                    -- Added by liuzhiqiang at 2009-4-21 Begin
                    if (GetIBBuffTimes(418) == 1) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc <c=g>Linh NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)
                    -- Added by liuzhiqiang at 2009-4-21 end

                    Msg2Player("B¹n nhËn ®­îc Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                end
            end
            ------------------------------------

            ----------------------------
            --¹ú¼Ê°æÊ¥µ®¡¢Ôªµ©»î¶¯ 
            --			AddNormalItemPile(3,243,0,0,0,0)
            --			Msg2Player("Äã»ñµÃÁËÊ¥µ®Ã±£¡¹ØÓÚÊ¥µ®Ã±µÄÏêÇéÇëÑ¯ÎÊÎ÷áªµÄÀñ¹Ù£¡")
            --			ScrollMessage("Äã»ñµÃ<c=g>Ê¥µ®Ã±<c>")
            ---------------------------------
            ------------------------------------
            --100¼¶Îü»êÒõÉ·
            if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
                AddIBBuff(426)
                Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
            end
            ---------------------------------------
            TopMessage("nhËn ®­îc <c=g> " .. boxnums .. " m¶nh Phong Ma Bİch<c>")
            Msg2Player("B¹n nh©n ®­îc " .. boxnums .. " m¶nh Phong Ma Bİch.")
            KsgTask:OnFinish(1139);
            refreshNpcTaskState()
            Talk(1, "no", "Mçi b×nh r­îu cã thÓ ®æi ®­îc 1 m¶nh Phong Ma Bİch, lÇn nµy ng­¬i nhËn ®­îc <c=g>" .. boxnums .. "<c> m¶nh Phong Ma Bİch!")
        elseif (GetTask(959) == 1) then
            Talk(1, "no", "Ta chØ cÇn r­îu quı, kh«ng cÇn l­¬ng thùc cña ng­¬i!")-- ÊÇÔËÁ¸³µµÄĞÎÌ¬À´½»ÈÎÎñ
        else
            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quı ®Õn? Mau ®­a r­îu ®©y! GhiÒn r­îu qu¸!")-- ²»ÊÇ³µµÄĞÎÌ¬À´½»ÈÎÎñ
        end ;
    end ;
end

function clear(n)
    SetTask(1142, GetTask(1142) + 1)
    RemoveIBBuff(376)
    CostIBBuff(377, n)
    TaskNote(55, -1)
    SetTaskWord(TASK_renwu, 2, 0)
    --AS GaoJingwei 091009
    SetTaskByte(Task_Yiqi, 2, 0)
    SetTaskByte(Task_Yiqi, 3, 0)
    --AE GaoJingwei 091010
    refreshNpcTaskState()
end

function no()
    CloseDialog()
end;

function shuoming()
    Talk(2, "no", "Bİch Du Nh©n:Ta th¸m hiÓm Bİch Du Cung m­êi mÊy n¨m, gÇn ®©y ph¸t hiÖn ra b¶o bèi, <c=yel>Phong Ma Bİch<c> thËt lµ thÇn kú, cã thÓ gióp trang bŞ th«ng th­êng chó nhËp linh khİ, biÕn thµnh Trang bŞ lôc. Nh÷ng th«ng tin d­íi ®©y do Xİch Tïng Tö cho ta biÕt: ", "20 m¶nh Phong Ma Bİch+30v l­îng +5 Tha S¬n Th¹ch=1 Phong Ma Bİch, c¬ héi thµnh c«ng lín, thÊt b¹i vËt phÈm sÏ biÕn mÊt<enter> Trang bŞ tr¾ng TiÓu Tam cÊp 100+20 Phong Ma Bİch+1000v l­îng +30 Tha S¬n Th¹ch= Trang bŞ lôc TiÓu Tam cÊp 100 ®· khãa, 100% thµnh c«ng<enter> <c=g>Gióp ta mang ®Õn vµi b×nh r­îu quı, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma Bİch.")
end
