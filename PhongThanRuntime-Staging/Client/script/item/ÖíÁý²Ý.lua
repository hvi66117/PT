grass_renwu = 1322
grass_item = {
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

function main()
    local state = GetTaskByte(grass_renwu, 1)
    if (state == 3) or (state == 4) then
        local TargetNpcIdx = GetPlayerTarget()
        if (GetFightState() == 0) then
            Msg2Player("N¬i ®©y kh«ng cho phÐp ®éng ®ao kiÕm!")
        elseif (TargetNpcIdx == 0) or (GetNpcTemplateID(TargetNpcIdx) ~= 820) then
            Msg2Player("ch­a chän muc tiªu HÊp hån!")
        elseif (GetTaskByte(grass_renwu, 2) <= 0) then
            if (GetJusticEvilCredit() > 0) then
                TaskNote(92, 2)
                SetTaskByte(grass_renwu, 1, 5)
                Msg2Player("Trïng hån ®· thu phôc hoµn tÊt, mau ®Õn <HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73,215,237]\"> t×m Lôc Gi¸p Ph­îc Hån trËn!")
            else
                TaskNote(92, 5)
                SetTaskByte(grass_renwu, 1, 6)
                Msg2Player("Trïng hån ®· thu phôc hoµn tÊt, mau ®Õn <HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73,242,201]\"> t×m Ngò Hµnh Thiªn Ngôc trËn")
            end
        else
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 0)
            nInterrupt = SetBit(nInterrupt, 4, 0)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)
            BeginMotion(grass_renwu, 0, 5, "\\script\\motion\\ÖíÁý²Ý½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
    else
        local nSubWorldId, px, py = GetWorldPos()
        if (nSubWorldId ~= 73) then
            Msg2Player("Tr­ Lung Th¶o chØ cã thÓ sö dông ë BÊt Chu Thiªn quan!")
        end

        local credit = GetJusticEvilCredit()
        if (state == 5) and (credit > 0) then
            checkArea(1, px, py)
        elseif (state == 6) and (credit < 0) then
            checkArea(2, px, py)
        else
            Msg2Player("HiÖn tthêi kh«ng thÓ sö dông Tr­ Lung Th¶o!")
        end
    end
end;

function no()
    CloseDialog()
end;

function checkArea(n, x, y)
    local temp = {}
    local j, k, x1, key = 0, 0, 0, 0

    if (n == 1) then
        temp = grass_item[1]
    else
        temp = grass_item[2]
    end

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
        TaskNote(92, 3)
        SetTaskByte(grass_renwu, 1, n + 6)
        ClearItem(6, 1, 438, 0)
        Talk(1, "no", GetName() .. "®· hoµn thµnh, vÒ phôc mÖnh §¹i phu!")
    else
        if (n == 1) then
            Msg2Player("Xin ®Õn Lôc Gi¸p Ph­îc Hån trËn (<c=g>215,237<c=r>) ®Ó sö dông!")
        else
            Msg2Player("Xin ®Õn Ngò Hµnh Thiªn Ngôc trËn (<c=g>242,201<c=r>) ®Ó sö dông!")
        end
    end
end
