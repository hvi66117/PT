TaskContinueGift = 1923

g_ActivityDay = 78
GiftTable = {
    [1] = { itemname = "T­íng Qu©n LÖnh", itemid = { 3, 100, 0, 0 }, count = 1, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [2] = { itemname = "Ph¸p B¶o Tinh Hoa", itemid = { 3, 1265, 0, 0 }, count = 2, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [3] = { itemname = "Di ngo¹i phï (Siªu cÊp)", itemid = { 8, 159, 2, 0 }, count = 1, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [4] = { itemname = "Ò»¼ûÇãÐÄ¡¤ÇéÇ£ÃÎÈÆ×°", itemid = {}, count = 1, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [5] = { itemname = "T­íng Qu©n LÖnh", itemid = { 3, 100, 0, 0 }, count = 2, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [6] = { itemname = "Ngäc Thanh ThÇn Tiªn T¸n", itemid = { 8, 375, 0, 0 }, count = 1, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
    [7] = { itemname = "ThÎ Kim DËt", itemid = { 8, 1316, 6, 0 }, count = 1, BuffID = 228, BuffID1 = 1480, BindMoney = 10000 },
}
BoxName = "LÔ bao Quý gi¸"
boxID = { 6, 1, 1358, 1 }
function no()
    CloseDialog()
end

function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end
    local nLevel = GetLevel()
    if (nLevel < 60) then
        InfoBox("Äú»¹Ã»ÓÐµ½´ï cÊp 60 , ÎÞ·¨¿ªÆôÀñ°ü.")
        return
    end

    if (GetTaskByte(TaskContinueGift, 4) ~= g_ActivityDay) then
        SetTask(TaskContinueGift, 0)
        SetTaskByte(TaskContinueGift, 4, g_ActivityDay)
    end

    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nTaskDay = GetTaskByte(TaskContinueGift, 1)
    if (nTaskDay == nToday) then
        InfoBox("H«m nay ®· nhËn th­ëng, ngµy mai h·y ®Õn më. ")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("tói kh«ng ®ñ 1 «, h·y s¾p xÕp tói l¹i. ")
        return
    end
    local nTimes = GetTaskByte(TaskContinueGift, 2) + 1
    if (nTimes < 1 or nTimes > 7) then
        Talk(1, "no", "Äú nhËn È«²¿½±Àø,ÎÞ·¨ÔÙ´ÎÁìÈ¡.")
        return
    end

    SetTaskByte(TaskContinueGift, 1, nToday)
    SetTaskByte(TaskContinueGift, 2, nTimes)
    local str = ""
    if (nTimes == 4) then
        if (GetSex() == 0) then
            AddNormalItemBind(8, 1664, 2, 0, 0, 0, 1)
            str = str .. "NhÊt KiÕn Khinh T©m*Méng NhiÔu Trang"
        else
            AddNormalItemBind(8, 1665, 2, 0, 0, 0, 1)
            str = str .. "NhÊt KiÕn Khinh T©m*T×nh Khiªn Trang"
        end

        local nBuffLeftTimes = GetIBBuffLeftTimes(GiftTable[nTimes].BuffID)
        if (nBuffLeftTimes > 0) then
            RemoveIBBuff(GiftTable[nTimes].BuffID)
            AddIBBuff(GiftTable[nTimes].BuffID, 86400 + nBuffLeftTimes)
        else
            AddIBBuff(GiftTable[nTimes].BuffID, 86400)
        end
        local nBuffLeftTimes1 = GetIBBuffLeftTimes(GiftTable[nTimes].BuffID1)
        if (nBuffLeftTimes1 > 0) then
            RemoveIBBuff(GiftTable[nTimes].BuffID1)
            if (nTimes == 7) then
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400 + nBuffLeftTimes1, 1)
            else
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400 + nBuffLeftTimes1, 1)
            end
        else
            if (nTimes == 7) then
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400, 1)
            else
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400, 1)
            end
        end
        local nBindMoney = nLevel * GiftTable[nTimes].BindMoney
        EarnBind(nBindMoney)
        if (nTimes == 7) then
            str = str .. "3 ngµy Ö÷ÌâÈÕ¿ñ»¶, 1 ngµy Ë«±¶µô±¦ vµ " .. nBindMoney .. " b¹c khãa."
        else
            str = str .. "1 ngµy Ö÷ÌâÈÕ¿ñ»¶, 1 ngµy Ë«±¶µô±¦ vµ " .. nBindMoney .. " b¹c khãa."
        end
    else
        if (GiftTable[nTimes].itemname ~= "") then
            for i = 1, GiftTable[nTimes].count do
                AddNormalItemBind(GiftTable[nTimes].itemid[1], GiftTable[nTimes].itemid[2], GiftTable[nTimes].itemid[3], GiftTable[nTimes].itemid[4], 0, 0, 1)
            end
            str = str .. GiftTable[nTimes].count .. "." .. GiftTable[nTimes].itemname .. ","
        end
        local nBuffLeftTimes = GetIBBuffLeftTimes(GiftTable[nTimes].BuffID)
        if (nBuffLeftTimes > 0) then
            RemoveIBBuff(GiftTable[nTimes].BuffID)
            AddIBBuff(GiftTable[nTimes].BuffID, 86400 + nBuffLeftTimes)
        else
            AddIBBuff(GiftTable[nTimes].BuffID, 86400)
        end

        local nBuffLeftTimes1 = GetIBBuffLeftTimes(GiftTable[nTimes].BuffID1)
        if (nBuffLeftTimes1 > 0) then
            RemoveIBBuff(GiftTable[nTimes].BuffID1)
            if (nTimes == 7) then
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400 + 86400 + nBuffLeftTimes1, 1)
            else
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400 + nBuffLeftTimes1, 1)
            end
        else
            if (nTimes == 7) then
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400 * 3, 1)
            else
                AddIBBuff(GiftTable[nTimes].BuffID1, 86400, 1)
            end
        end
        local nBindMoney = nLevel * GiftTable[nTimes].BindMoney
        EarnBind(nBindMoney)

        if (nTimes == 7) then
            str = str .. "3 ngµy Ö÷ÌâÈÕ¿ñ»¶, 1 ngµy Ë«±¶µô±¦ vµ " .. nBindMoney .. " b¹c khãa."
        else
            str = str .. "1 ngµy Ö÷ÌâÈÕ¿ñ»¶, 1 ngµy Ë«±¶µô±¦ vµ " .. nBindMoney .. " b¹c khãa."
        end
    end

    if (nTimes >= 7) then
        DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])
    end

    Talk(1, "no", "§©y lµ ÄúµÚ" .. nTimes .. "´Î¿ªÆôÀñ°ü, Chóc mõng ngµi nhËn ®­îc " .. str)
    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. str)
    WriteLog("[" .. BoxName .. "][" .. nTimes .. "lÇn]")
end
