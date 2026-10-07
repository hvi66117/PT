require("newserver.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")
require("king.luax")

TASK_renwu = 1139
TASK_Npcindex = 1140
TASK_Lucky = 1141

Task_Yiqi = 1532

Task_lingchong = 1395

TASK_TIMES_Max = 9

TaskTimes = {
    [1] = { totalTimes = 630, awardsTimes = 5, },
    [2] = { totalTimes = 390, awardsTimes = 4, },
    [3] = { totalTimes = 270, awardsTimes = 3, },
    [4] = { totalTimes = 210, awardsTimes = 2, },
    [5] = { totalTimes = 180, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1699
G_Double = 370

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
    local startLevel = 95
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local guardindex = GetTGuardIndexByPlayerName(GetName())
    local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)
    local insideindex = IsPlayerInsideWeapon(PlayerIndex)
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then


            if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 3
                subState = 0
            elseif (GetTaskByte(TASK_renwu, 3) > 0 and GetTaskByte(TASK_renwu, 3) ~= 3 and GetTaskByte(TASK_renwu, 2) <= 1) then
                state = 2
                subState = 0
            end
        else


            if (insideindex == carriageindex) and (carriageindex ~= 0) and (GetTaskByte(TASK_renwu, 2) <= 1) then
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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    local tasks = {
        { "Tèng Töu", "renwu"; show = 0 },
        { "Phong Ma BÝch", "shuoming"; show = 1 }
    }
    local huanshu = GetByte(GetTask(TASK_renwu), 3)
    local lastday = GetByte(GetTask(TASK_renwu), 1)
    if (GetLevel() >= 95) then

        if (huanshu == 2) then
            tasks[1].show = 1
        end ;
    end
    SayTask("¸i chµ chµ! ThÌm r­îu qu¸! Anh hïng nµo gióp ta mang vµi b×nh r­îu quý ®Õn, ta nhÊt dÞnh sÏ t¹ ¬n!", tasks)
end;

function renwu()
    MsgBox("å! R­îu th¬m qu¸! Huynh ®Ö ta ë T©y Kú cã nhê ng­¬i mang r­îu ®Õn cho ta, ng­¬i ®· chuyÓn ®Õn ch­a?", "renwu1", "no")
end
function renwu1()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quý, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma BÝch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu BÝch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        local insideindex = IsPlayerInsideWeapon(PlayerIndex)

        if (insideindex == carriageindex) and (carriageindex ~= 0) then
            jiangli()
        else

            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quý ®Õn? Mau ®­a r­îu ®©y! Ta thµm r­îu qu¸!")
        end ;
    end ;
end;

function jiangli()
    local tasks2 = {
        { "NhËn ®iÓm kinh nghiÖm", "item1"; show = 1 },
        { "M¶nh Phong Ma BÝch", "item2"; show = 1 },
        { "Phong Ma BÝch", "shuoming"; show = 1 }
    }

    SayTask("BÝch Du Nh©n:C¶m t¹, l©u l¾m råi ta kh«ng ®­îc th­ëng thøc h­¬ng vÞ cña r­îu, ng­¬i ®óng lµ cøu tinh cña ta, ta sÏ b¸o ®¸p ng­¬i. Ta cã mét bÝ ph¸p cã thÓ gióp ng­¬i nhËn ®­îc thËt nhiÒu kinh nghiÖm, vµ 1 sè To¸i phiÕn cña ngäc th­îng ®¼ng chøa ma lùc, ng­¬i xem thÝch g× nµo?", tasks2)
end

function item1()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quý, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma BÝch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu BÝch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) then
            DeleteSiegeWeapon(carriageindex)

            local boxnums = GetIBBuffTimes(377)
            local exp1 = GetLevel() * 2000 * boxnums
            clear(boxnums)

            if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
                local pr = math.random(1, 5)
                if (pr == 5) then
                    AddIBBuff(418)
                    AddIBBuff(418)

                    if (GetIBBuffTimes(418) == 2) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc 2 <c=g>Linh Thó Chi NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)

                    Msg2Player("B¹n nhËn ®­îc 2 Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                else
                    AddIBBuff(418)

                    if (GetIBBuffTimes(418) == 1) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc <c=g>Linh Thó Chi NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)

                    Msg2Player("B¹n nhËn ®­îc Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")
                end
            end

            if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
                AddIBBuff(426)
                Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
            end

            local weekDay = GetWeekDay()
            if (GetTaskByte(Double_Optimization, 3) < 8) then
                local tempExp = exp1
                if (GetTaskByte(Double_Optimization, 3) > 0) then
                    exp1 = exp1 + tempExp
                end
                if (weekDay == 5) then

                    Msg2Player("H«m nµy chñ ®Ò nhiÖm vô Tèng Töu, chóc mõng b¹n, nhËn ®­îc phÇn th­ëng gÊp ®«i")
                    local nDoubel = 1
                    local nDoubleBuff = 1480

                    if (HaveIBBuff(1523) > 0) then
                        nDoubel = nDoubel + 1
                        CostIBBuff(1523, 1)
                        Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                    end

                    local bHaveBuff = HaveIBBuff(nDoubleBuff)
                    local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                    if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                        nDoubel = nDoubel + nBuffLevel
                        Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                    end
                    exp1 = exp1 + math.floor(tempExp * nDoubel)

                end


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
                    str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " ngµy, ngµy mai ®Õn nhËn nhÐ!"
                else
                    str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " phÇn th­ëng nh©n ®«i kinh nghiÖm trong ngµy, mêi tuÇn §ç Khang kÕ tiÕp h·y ®Õn nhËn!"
                end
            end

            AddOwnExp(exp1)
            Ksg:OnTaskFinish(TASK_renwu)
            ORACLEBONE.GetCardWayApply(15, 0)
            if (GetWeekDay() ~= 5) then
                ORACLEBONE.GetCardWayApply(16, 0)
            end
            TopMessage("NhËn ®­îc <c=g>" .. exp1 .. " ®iÓm kinh nghiÖm<c>")
            Msg2Player("B¹n nh©n ®­îc " .. exp1 .. " ®iÓm kinh nghiÖm.")

            WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng][Hoµn thµnh]boxnums: " .. boxnums .. " kinh nghiÖm" .. exp1)
            ShiJi_Skill(exp1)
            Talk(1, "no", "Mçi b×nh r­îu sÏ nhËn ®­îc ®¼ng cÊp*2000 ®iÓm kinh nghiÖm, lÇn nµy ng­¬i nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm!" .. str)
            refreshNpcTaskState()
        else
            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quý ®Õn? Mau ®­a r­îu ®©y! Ta thµm r­îu qu¸!")
        end ;
    end ;
    NewServerMonkeyActivity()
end

function item2()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (HaveIBBuff(376) == 0) or (GetIBBuffTimes(377) == 0) then
        Talk(1, "no", "ChØ cÇn mang ®Õn cho ta vµi b×nh r­îu quý, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma BÝch. Cí g× ®· l©u huynh ®Ö ë T©y Kú cña ta vÉn ch­a chuyÓn r­îu ®Õn, h·y gióp ta hái <c=g>Chñ töu qu¸n<c> xem cã chuyÖn g×? Cã lÏ h¾n ®ang ë gÇn §¹i Phu BÝch Du Cung tÇng 3!")
    elseif (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
        local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) then
            DeleteSiegeWeapon(carriageindex)

            local boxnums = GetIBBuffTimes(377)
            clear(boxnums)
            for i = 1, boxnums do
                AddNormalItemPile(3, 175, 0, 0, 0, 0)
            end

            if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
                local pr = math.random(1, 5)
                if (pr == 5) then
                    AddIBBuff(418)
                    AddIBBuff(418)

                    if (GetIBBuffTimes(418) == 2) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc 2 <c=g>Linh Thó Chi NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)

                    Msg2Player("B¹n nhËn ®­îc 2 Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")
                else
                    AddIBBuff(418)

                    if (GetIBBuffTimes(418) == 1) then
                        TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                    else
                        TopMessage("B¹n nhËn ®­îc <c=g>Linh Thó Chi NguyÖn<c>")
                    end

                    if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                        TaskNote(1048, 0, GetIBBuffTimes(418))
                    end

                    if (GetIBBuffTimes(418) >= 30) then
                        TaskNote(1048, 1)
                    end

                    SetTaskByte(Task_lingchong, 3, 1)

                    Msg2Player("B¹n nhËn ®­îc Linh Thó Chi NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                    Msg2Player("Khi ®iÓm Linh Thó Chi NguyÖn cña b¹n kh«ng d­íi 30 Linh Thó Chi NguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

                end
            end

            if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
                AddIBBuff(426)
                Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
            end

            TopMessage("NhËn ®­îc <c=g>" .. boxnums .. " m¶nh Phong Ma BÝch<c>")
            Msg2Player("B¹n nh©n ®­îc " .. boxnums .. " m¶nh Phong Ma BÝch.")
            Ksg:OnTaskFinish(TASK_renwu)
            WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng][Hoµn thµnh] M¶nh Phong Ma BÝch: " .. boxnums)
            refreshNpcTaskState()
            Talk(1, "no", "Mçi b×nh r­îu cã thÓ ®æi ®­îc 1 m¶nh Phong Ma BÝch, lÇn nµy ng­¬i nhËn ®­îc <c=g>" .. boxnums .. "<c> m¶nh Phong Ma BÝch!")
        else
            Talk(1, "no", "Cã ph¶i anh hïng thay huynh ®Ö ta chuyÓn r­îu quý ®Õn? Mau ®­a r­îu ®©y! Ta thµm r­îu qu¸!")
        end
    end
    ORACLEBONE.GetCardWayApply(15, 0)
    if (GetWeekDay() ~= 5) then
        ORACLEBONE.GetCardWayApply(16, 0)
    end
    NewServerMonkeyActivity()
end

function clear(n)
    SetTask(1142, GetTask(1142) + 1)
    RemoveIBBuff(376)
    CostIBBuff(377, n)
    TaskNote(55, -1)
    SetTaskWord(TASK_renwu, 2, 0)

    SetTaskByte(Task_Yiqi, 2, 0)
    SetTaskByte(Task_Yiqi, 3, 0)

    refreshNpcTaskState()
end

function no()
    CloseDialog()
end;

function shuoming()
    Talk(2, "no", "BÝch Du Nh©n:Ta th¸m hiÓm BÝch Du Cung m­êi mÊy n¨m, gÇn ®©y ph¸t hiÖn ra b¶o bèi, <c=yel>Phong Ma BÝch<c> thËt lµ thÇn kú, cã thÓ gióp trang bÞ th«ng th­êng chó nhËp linh khÝ, biÕn thµnh Trang bÞ lôc. Nh÷ng th«ng tin d­íi ®©y do XÝch Tïng Tö cho ta biÕt: ", "20 m¶nh Phong Ma BÝch+30v l­îng +5 Tha S¬n Th¹ch=1 Phong Ma BÝch, c¬ héi thµnh c«ng lín, thÊt b¹i vËt phÈm sÏ biÕn mÊt<enter>Trang bÞ tr¾ng TiÓu Tam cÊp 100+20 Phong Ma BÝch+1000v l­îng +30 Tha S¬n Th¹ch= Trang bÞ lôc TiÓu Tam cÊp 100 ®· khãa, 100% thµnh c«ng<enter><c=g>Gióp ta mang ®Õn vµi b×nh r­îu quý, ta sÏ tÆng ng­¬i vµi m¶nh Phong Ma BÝch.")
end

function NewServerMonkeyActivity()
    if (NewServerEx.g_ServerName ~= GetGameServerName()) then
        return
    end
    if (GetLevel() < 45) then
        return
    end

    if (NewServerEx.Pub_IsTongMonkeyTime() > 0) then
        SetTaskBit(2097, 12, 1)
        WriteLog("[Ho¹t ®éng m¸y chñ míi][Quèc VËn Th¹ch HÇu][Hoµn thµnh nhiÖm vô B¸ch Niªn TrÇn Nh­ìng]")
    end
end

function ShiJi_Skill(Exp1)
    local PetType = PetGetType()
    if (PetType == 65 or PetType == 86 or PetType == 105) then
        if (GetNewBirthTimes() == 1) then
            Exp1 = Exp1 * 1.2
            AddOwnExp(Exp1)
            Msg2Player("Th¹ch C¬ N­¬ng N­¬ngÊ¹ÓÃ¼¼ÄÜM¹o Mü Tuý Nh©n, ÎªÓ¢ÐÛ´øÀ´Ë«±¶µÄB¸ch Niªn TrÇn Nh­ìng¾­Ñé.")
            WriteLog("[B¸ch Niªn TrÇn Nh­ìng][Th¹ch C¬][×ªÉúºÅ, 2.2±¶¾­Ñé]")
        else
            AddOwnExp(Exp1)
            Msg2Player("Th¹ch C¬ N­¬ng N­¬ngÊ¹ÓÃ¼¼ÄÜM¹o Mü Tuý Nh©n, ÎªÓ¢ÐÛ´øÀ´Ë«±¶µÄB¸ch Niªn TrÇn Nh­ìng¾­Ñé.")
            WriteLog("[B¸ch Niªn TrÇn Nh­ìng][Th¹ch C¬][Ë«±¶¾­Ñé]")
        end
    end
end


