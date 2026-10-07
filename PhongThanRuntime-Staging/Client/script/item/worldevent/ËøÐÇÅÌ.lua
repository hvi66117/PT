Task_renwu = 1303
Task_NpcIndex = 1312
Task_NpcId = 1313

function main()
    CloseDialog()

    local credit = GetJusticEvilCredit()

    local nSubWorldId, px, py = GetWorldPos()
    if (nSubWorldId ~= 73) then
        if (credit > 0) then
            Msg2Player("Lôc Gi¸p Ph­îc Hån trËn ë trong BÊt Chu Thiªn quan, xin h·y cÊp tèc ®i t×m!")
        else
            Msg2Player("Ngò Hµnh Thiªn Ngôc trËn ë trong BÊt Chu Thiªn quan, xin h·y cÊp tèc ®i t×m!")
        end
        return
    end

    local nTaskState = GetTaskByte(Task_renwu, 1)

    if (nTaskState == 3) or (nTaskState == 4) then

        if (checkAddCondition() == 1) then
            addOwnNpc()
        end

    elseif (nTaskState == 2) then

        if (credit > 0) then
            Msg2Player("Cã thÓ ®Õn gÆp B¹ch H¹c ®¹o tr­ëng hái c¸ch sö dông")
        else
            Msg2Player("Cã thÓ ®Õn gÆp Linh Nha KiÕm Tiªn hái c¸ch sö dông")
        end

    else

        Msg2Player("T¹m thêi kh«ng thÓ sö dông")

    end
end

item = {
    [1] = {
        { 1720, 3790 },
        { 1731, 3790 },
        { 1734, 3804 },
        { 1731, 3818 },
        { 1720, 3818 },
        { 1717, 3804 },
    },

    [2] = {
        { 1932, 3202 },
        { 1942, 3202 },
        { 1945, 3217 },
        { 1938, 3231 },
        { 1930, 3217 },
    },
}

function checkArea()

    local temp = {}
    local j, k, x1, key = 0, 0, 0, 0

    local credit = GetJusticEvilCredit()
    if (credit > 0) then
        temp = item[1]
    else
        temp = item[2]
    end

    local nSubWorldId, x, y = GetWorldPos()

    for j = 1, table.getn(temp) do

        k = math.mod(j + 1, table.getn(temp) + 1)
        if (k == 0) then
            k = 1
        end

        if (temp[j][2] ~= temp[k][2]) then
            if (y >= math.min(temp[j][2], temp[k][2])) then
                if (y < math.max(temp[j][2], temp[k][2])) then


                    if (temp[k][2] - temp[j][2] == 0) then
                        return 0
                    end

                    x1 = (y - temp[j][2]) * (temp[k][1] - temp[j][1]) / (temp[k][2] - temp[j][2]) + temp[j][1]

                    if (x1 > x) then
                        key = key + 1
                    end
                end
            end
        end

    end

    if (math.mod(key, 2) == 1) then
        return 1
    end

    if (credit > 0) then
        Msg2Player("Xin ®Õn Lôc Gi¸p Ph­îc Hån trËn ®Ó sö dông")
    else
        Msg2Player("Xin ®Õn Ngò Hµnh Thiªn Ngôc trËn ®Ó sö dông")
    end

    return 0

end

function checkAddCondition()

    local nTaskState = GetTaskByte(Task_renwu, 1)
    if (nTaskState == 4) then

        local npcindex = GetTask(Task_NpcIndex)
        if (GetNpcID(npcindex) == GetTask(Task_NpcId)) then
            Msg2Player("B¹n ®· th¶ ra Phong thó s¬n hån, kh«ng thÓ th¶ thªm n÷a! H·y mau ®i tiªu diÖt nã!")
            return 0
        end

    end

    local nRes = checkArea()
    return nRes

end

function addOwnNpc()

    local nSubWorldId, px, py = GetWorldPos()
    local credit = GetJusticEvilCredit()

    local a = AddNpc(464, 1, SubWorld, px * 32, py * 32)
    SetNpcTimer(a, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
    SetNpcTask(a, 1, GetPlayerID())

    if (credit > 0) then
        SetNpcTask(a, 2, 1)
    else
        SetNpcTask(a, 2, 2)
    end

    SetNpcScript(a, "\\script\\item\\worldevent\\·çÊÞÉ½çõ.lua")
    SetTask(Task_renwu, 4)
    SetTask(Task_NpcIndex, a)
    SetTask(Task_NpcId, GetNpcID(a))
    ScrollMessage("Th¶ thµnh c«ng Phong thó s¬n hån")
    Msg2Player("Th¶ thµnh c«ng Phong thó s¬n hån, mau tiªu diÖt nã!")

end

function no()
    CloseDialog()
end;
