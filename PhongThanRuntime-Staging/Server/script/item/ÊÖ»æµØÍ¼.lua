CITY_TASK_MIDAO = 62
Task_midao = 1858
Task_midao_tong = 1859
Task_Note_midao = 1630
tbl_MapID = {
    [0] = { { 1652, 3238 }, { 1732, 3181 }, { 1731, 3085 }, },
    [1] = { { 1751, 3183 }, { 1735, 3059 }, { 1667, 3279 }, },
    [2] = { { 1741, 3198 }, { 1724, 3083 }, { 1649, 3259 }, },
    [3] = { { 1641, 3235 }, { 1732, 3159 }, { 1734, 3069 }, },
    [4] = { { 1864, 2979 }, { 1874, 3076 }, { 1753, 3207 }, },
}
function Check_Condition()
    local nFlag = 0
    for i = 17, 19 do
        if (GetTaskBit(Task_midao, i) == 1) then
            nFlag = nFlag + 1
        end
    end
    return nFlag
end

function main()
    no()
    local nState = GetTaskByte(Task_midao, 1)
    local nFlag = Check_Condition()
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    local nTongID = GetTongIDByName(CityTongName)
    if (IsInCity() == 0) then
        Talk(1, "no", "H·y ®i thµnh thÞ bªn ®Þch sö dông b¶n vÏ.")
        return
    end

    if (nState == 1) then
        if (IsOwnerCity() == 1) then
            Talk(1, "no", "H·y ®i thµnh thÞ bªn ®Þch sö dông b¶n vÏ.")
            return
        else
            Talk(1, "no", "H·y ®Õn vÞ trÝ chØ ®Þnh vÏ l¹i ®Þa h×nh")
            TaskNote(Task_Note_midao, 3 + typeIdx, CityTongName)
            SetTaskByte(Task_midao, 1, 2)
            SetTask(Task_midao_tong, nTongID)
        end
    elseif (nState == 2) then
        if (GetTask(Task_midao_tong) ~= nTongID) then
            Talk(1, "no", "H·y ®i ®Õn n¬i chØ ®Þnh ®Ó dß th¸m ®Þa h×nh!")
            return
        end
        local nMap, nX, nY = GetWorldPos()
        local nBitFlag = 0
        for i = 1, 3 do
            if (math.floor(((tbl_MapID[typeIdx][i][1] - nX) ^ 2 + (tbl_MapID[typeIdx][i][2] - nY) ^ 2) ^ 0.5 * 32) <= 500) then
                nBitFlag = i
                break
            end
        end

        if (nBitFlag == 0) then
            Talk(1, "no", "H·y ®i ®Õn n¬i chØ ®Þnh ®Ó dß th¸m ®Þa h×nh!")
        else
            if (GetTaskBit(Task_midao, 16 + nBitFlag) == 1) then
                Talk(1, "no", " N¬i nµy ®· dß th¸m, h·y ®Õn n¬i kh¸c.")
                return
            end

            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 1)
            nInterrupt = SetBit(nInterrupt, 4, 1)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            BeginMotion(nBitFlag, 0, 3, "\\script\\item\\ÊÖ»æµØÍ¼.lua", nInterrupt)
        end
    elseif (nState == 3) then
        Talk(1, "no", "B¹n ®· dß th¸m ®Þa h×nh l·nh ®Þa hiÓn t¹i råi, h·y quay vÒ tr¶ nhiÖm vô.")
    else
        Talk(1, "no", "§©y lµ 1 tÊm b¶n vÏ ghi l¹i ®Þa h×nh l·nh ®Þa n­íc ®ã.")
    end
end

function EndMotion(nBitFlag)
    no()
    local nMap, nX, nY = GetWorldPos()
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    if (nBitFlag < 1 or nBitFlag > 3 or GetTaskBit(Task_midao, 16 + nBitFlag) ~= 0
            or math.floor(((tbl_MapID[typeIdx][nBitFlag][1] - nX) ^ 2 + (tbl_MapID[typeIdx][nBitFlag][2] - nY) ^ 2) ^ 0.5 * 32) > 500) then
        Talk(1, "no", "H·y ®i ®Õn n¬i chØ ®Þnh ®Ó dß th¸m ®Þa h×nh!")
        return
    end
    SetTaskBit(Task_midao, 16 + nBitFlag, 1)
    Talk(1, "no", "N¬i nµy ®· dß th¸m xong.")
    Msg2Player("N¬i nµy ®· dß th¸m xong.")
    if (Check_Condition() == 3) then
        SetTaskByte(Task_midao, 1, 3)
        TaskNote(Task_Note_midao, 2)
    end
end

function InteruptMotion(MotionID)
end

function no()
    CloseDialog()
end
