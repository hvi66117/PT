Task_Buff_Time = 1518
Global_Random_Chaoge = 243
Global_Random_Muye = 244
Global_Random_Chentangguan = 247
Global_Random_Mengjin = 248

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (HaveIBBuff(756) == 0) then
        Msg2Player("B¹n kh«ng sö dông Cuèc, kh«ng thÓ ®µo vËt nµy!")
        return
    end

    local mapid, x, y = GetWorldPos()
    local npcMapid, npcx, npcy = GetNpcWorldPos(DialogNpcIdx)
    local distance = math.floor(((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32)
    if (distance > 300) then
        Msg2Player("B¹n c¸ch n¬i cÇn ®µo qu¸ xa, kh«ng thÓ tÇm b¶o")
        return
    end

    local preTime = GetTask(Task_Buff_Time)
    local buffTime = LocalSystemTime() - preTime
    if (GetNpcTask(DialogNpcIdx, 1) ~= 1) then
        Msg2Player("§µo tróng ®¸, ®é cøng Cuèc gi¶m 20 gi©y")
        TopMessage("§µo tróng ®¸")
        buffTime = 1800 - buffTime - 20
        SetTask(Task_Buff_Time, preTime - 20)
        RemoveIBBuff(756)
        if (buffTime > 0) then
            AddIBBuff(756, buffTime)
        end
        return
    end

    local rand = math.random(1, 100)
    local fragment_idx = 0

    if (npcMapid == 21) then
        if (GetGlobalValueWord(Global_Random_Chaoge, 1) == 0) then
            rand = 1
        elseif (GetGlobalValueWord(Global_Random_Chaoge, 2) == 0) then
            rand = 31
        end

        if (rand <= 30) then
            fragment_idx = AddNpc(1200, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn trung")
            SetNpcTask(fragment_idx, 1, 2)
            local remainZhong = GetGlobalValueWord(Global_Random_Chaoge, 2)
            remainZhong = remainZhong - 1
            SetGlobalValueWord(Global_Random_Chaoge, 2, remainZhong)
        else
            fragment_idx = AddNpc(1199, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn nhá")
            SetNpcTask(fragment_idx, 1, 1)
            local remainXiao = GetGlobalValueWord(Global_Random_Chaoge, 1)
            remainXiao = remainXiao - 1
            SetGlobalValueWord(Global_Random_Chaoge, 1, remainXiao)
        end
    elseif (npcMapid == 18) then


        local rand1 = math.random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn cùc lín")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" t¹i <c=g>Môc D· (" .. math.floor(npcx / 8) .. "," .. math.floor(npcy / 16) .. ")<c> ph¸t hiÖn ra To¸i phiÕn cùc lín, mäi ng­êi h·y mau ®Õn ®ã tranh ®o¹t.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn lín")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Muye, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Muye, 2, remainBig)

    elseif (npcMapid == 65) then


        local rand1 = math.random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn cùc lín")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" t¹i <c=g>TrÇn §­êng (" .. math.floor(npcx / 8) .. "," .. math.floor(npcy / 16) .. ")<c> ph¸t hiÖn ra To¸i phiÕn cùc lín, mäi ng­êi h·y mau ®Õn ®ã tranh ®o¹t.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn lín")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Chentangguan, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Chentangguan, 2, remainBig)

    elseif (npcMapid == 15) then


        local rand1 = math.random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn cùc lín")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" t¹i <c=g>M¹nh T©n (" .. math.floor(npcx / 8) .. "," .. math.floor(npcy / 16) .. ")<c> ph¸t hiÖn ra To¸i phiÕn cùc lín, mäi ng­êi h·y mau ®Õn ®ã tranh ®o¹t.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To¸i phiÕn lín")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Mengjin, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Mengjin, 2, remainBig)

    end

    SetNpcScript(fragment_idx, "\\script\\»î¶¯½Å±¾\\ËéÆ¬.lua")

    local exist_num = GetNpcTask(DialogNpcIdx, 2)
    exist_num = exist_num - 1
    SetNpcTask(fragment_idx, 2, exist_num)

    local H, M, S = GetHMS()
    local nowTime = 0
    if (H >= 21) then
        nowTime = math.mod(LocalSystemTime(), 86400) - (60 * 60 * 21)
    end
    local remainTime = 10740 - nowTime
    SetNpcTimer(fragment_idx, "\\script\\ontimer\\ËéÆ¬ÏûÍö.lua", remainTime)

    DelNpc(DialogNpcIdx)
end

function no()
    CloseDialog()
end
