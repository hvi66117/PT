Task_xianmo_renwu = 1297
Task_xianmo_npc = 1298
Task_xianmo_npcIndex = 1299
Task_xianmo_npcID = 1300
Task_faery = 1301

function main()
    if (GetTaskByte(Task_xianmo_renwu, 4) >= 3) then
        ClearItem(6, 1, 411, 0)
        return 0
    elseif (GetTaskByte(Task_xianmo_renwu, 4) == 1) then
        ClearItem(6, 1, 411, 0)
        Msg2Player("§©y lµ ®¹o vô phi ph¸p, bÞ hÖ thèng tÞch thu!")
        return 0
    end

    if (GetFreeNpcCount() >= 100) then
        yes1()
    else
        Talk(1, "no", "N¬i ®©y ®· ®­îc lËp chó trËn, xin qu·y quay l¹i sau!")
    end
end;

function no()
    CloseDialog()
end;

function yes1()
    if (HaveNormalItem(6, 1, 411, 0) == 0) and (HaveNormalItemInQuick(6, 1, 411, 0) == 0) then
        return 0
    end
    mapname = {
        [47] = "Khæn Tiªn cung-tÇng 1-§¹i phu §«ng b¾c",
        [48] = "Khæn Tiªn cung-tÇng 2-§¹i phu chÝnh b¾c",
        [49] = "Khæn Tiªn cung-tÇng 3-§¹i phu chÝnh nam",
        [50] = "Khæn Tiªn cung-tÇng 4-§¹i phu T©y nam",
        [51] = "Khæn Tiªn cung-tÇng 5-§¹i phu chÝnh ®«ng",
    }

    local mapid = GetTaskByte(Task_xianmo_renwu, 3)
    if (mapid < 47) or (mapid > 51) then
        ClearItem(6, 1, 411, 0)
        Msg2Player("§©y lµ ®¹o vô phi ph¸p, bÞ hÖ thèng tÞch thu!")
        return 0
    end
    local pm, px, py = GetWorldPos()
    if (mapid ~= pm) then
        Talk(1, "no", "N¬i ®©y kh«ng thÓ Tô Hån §o¹t Ph¸ch, xin t×m khu vùc kh¸c!" .. mapname[mapid] .. "_khai triÓn Gi¸ng Ma chó trËn!")
        return 0
    end

    if (isinarea(pm, px, py) == 1) then
        SetTaskWord(Task_faery, 1, px)
        SetTaskWord(Task_faery, 2, py)
        SetTaskByte(Task_xianmo_renwu, 4, 4)
        if (HaveNormalItemInQuick(6, 1, 411, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 411, 0)
        else
            DelNormalItem(6, 1, 411, 0)
        end
        AddIBBuff(493)
        local a = AddNpc(755, 1, SubWorld, px * 32, py * 32)
        SetNpcTimer(a, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        SetNpcName(a, "Gi¸ng Ma chó")
        TopMessage("Gi¸ng Ma Kim T¸n ®· th¶ ra Gi¸ng Ma chó")
        Msg2Player("Gi¸ng Ma Kim T¸n ®· phãng Gi¸ng Ma Chó, tiªu diÖt Ma VËt xung quanh cã thÓ hµng phôc Ma Ph¸ch")
    end
end;

function isinarea(mapId, x, y)
    item = {
        [47] = { { 1718, 2997 }, { 1699, 2978 }, { 1719, 2952 }, { 1695, 2928 }, { 1627, 2994 }, { 1674, 3040 } },
        [48] = { { 1642, 3012 }, { 1606, 2974 }, { 1544, 3040 }, { 1580, 3075 } },
        [49] = { { 1570, 3382 }, { 1518, 3332 }, { 1494, 3357 }, { 1547, 3408 } },
        [50] = { { 1548, 3290 }, { 1458, 3203 }, { 1422, 3240 }, { 1510, 3328 } },
        [51] = { { 1818, 3138 }, { 1738, 3052 }, { 1714, 3081 }, { 1791, 3164 } },
    }
    local temp = {}
    local k, x1, key = 0, 0, 0

    temp = item[mapId]
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

    Talk(1, "no", "Khu vùc hiÖn t¹i kh«ng thÓ Tô Hån §o¹t Ph¸ch, kh«ng thÓ thi triÓn Gi¸ng Ma Kim T¸n. Xin t×m khu vùc kh¸c!" .. mapname[mapId] .. "-tiÕn hµnh bè trËn")
    return 0
end
