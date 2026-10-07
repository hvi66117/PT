festivalItem = {
    [1] = { id1 = 3, id2 = 1155, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [2] = { id1 = 3, id2 = 1156, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [3] = { id1 = 3, id2 = 1157, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [4] = { id1 = 3, id2 = 1158, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [5] = { id1 = 3, id2 = 1159, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [6] = { id1 = 3, id2 = 1160, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [7] = { id1 = 6, id2 = 1, id3 = 809, id4 = 0, id5 = 0, id6 = 0 },
    [8] = { id1 = 6, id2 = 0, id3 = 808, id4 = 1, id5 = 0, id6 = 0 }
}

Cracker_TemplateID = 1774
TASK_SPRING_FESTIVAL = 1679

function main()

    local Y, M, D = GetYMD()
    local H1, M1, S1 = GetHMS()
    local firecrackerNpcIdx = 0
    local mapid, x, y = GetWorldPos()
    local nInterrupt = 0

    if (GetLevel() < 20) then
        Talk(1, "no", "Ng­¬i tu luyÖn ch­a ®ñ, kh«ng thÓ sö dông Ph¸o ®èi phã [Niªn] Thó.")
        return 0
    elseif (mapid ~= 21) then
        Talk(1, "no", "[Niªn] Thó ®ang ë TriÒu Ca! H·y lËp tøc ®Õn TriÒu Ca sö dông Ph¸o, xua ®uæi [Niªn] Thó.")
        return 0
    end

    if (Y == 2012) and (M == 1) and ((D >= 18 and D <= 29 and ((H1 >= 16 and H1 <= 23) or H1 == 0)) or (D == 30 and H1 == 0)) then

        if (GetTaskByte(TASK_SPRING_FESTIVAL, 3) ~= 0) then
            Talk(1, "no", "Trong mét thêi ®iÓm chØ cã thÓ sö dông 1 Ph¸o!")
            return 0
        end

        SetTaskByte(TASK_SPRING_FESTIVAL, 3, 1)
        if (HaveNormalItem(festivalItem[7].id1, festivalItem[7].id2, festivalItem[7].id3, festivalItem[7].id4) > 0) then
            DelNormalItem(festivalItem[7].id1, festivalItem[7].id2, festivalItem[7].id3, festivalItem[7].id4)
        elseif (HaveNormalItemInQuick(festivalItem[7].id1, festivalItem[7].id2, festivalItem[7].id3, festivalItem[7].id4) > 0) then
            DelNormalItemInQuick(festivalItem[7].id1, festivalItem[7].id2, festivalItem[7].id3, festivalItem[7].id4)
        else
            return 0
        end

        firecrackerNpcIdx = AddNpc(Cracker_TemplateID, 1, SubWorld, x * 32, y * 32)
        SetNpcName(firecrackerNpcIdx, "Ph¸o")

        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 0)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 0)
        BeginMotion(firecrackerNpcIdx, 0, 2, "\\script\\»î¶¯½Å±¾\\±ÞÅÚ±¬Õ¨.lua", nInterrupt)
    else
        Talk(1, "no", "ÇëÔÚ<c=g>1ÔÂ18ÈÕ<c>µ½<c=g>1ÔÂ29ÈÕ<c>Ã¿Ìì<c=g>16:00<c>µ½µÚ¶þÌì<c=g>Áè³¿1:00<c>ÆÚ¼äÊ¹ÓÃ±¬Öñ!")
    end
end

function no()
    CloseDialog()
end

