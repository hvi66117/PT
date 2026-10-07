Task_Variety_Process = 1389

PlayerLightIndex = 1393

function no()
    CloseDialog()
end;

function main()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step <= 17) then
        Talk(1, "no", "DÉn L«i phï cã thÓ kªu gäi Thiªn L«i trong trËn ph¸p L«i §iÖn Th¸p!")
        return
    end

    local m, x, y = GetWorldPos()
    if (m ~= 32) then
        Msg2Player("DÉn L«i phï chØ cã thÓ sö dông trong Ngäc TuyÒn B¨ng Xuyªn")
    end

    local npcidx = GetTask(PlayerLightIndex)
    if (npcidx == 0 or GetNpcTask(npcidx, 4) ~= GetPlayerID(PlayerIndex)) then
        Talk(1, "no", "Ph¶i gi¶i phãng ph¸p lùc cña DÉn L«i phï trong trËn ph¸p L«i §iÖn Th¸p. §Ó ®iÓm s¸ng Lé ®iÖn chi th¸p cÇn cã BÝch L«i phï cña Kh­¬ng Tö Nha.")
        return
    end

    local x1, y1, x2, y2, x3, y3 = 0, 0, 0, 0, 0, 0
    local group = GetNpcTask(npcidx, 1)

    if (group < 10) then
        Talk(1, "no", "L«i §iÖn Th¸p t¾t ®Ìn råi, cÇn sö dông BÝch L«i phï cña Kh­¬ng Tö Nha ®Ó ®iÓm s¸ng l¹i tõ ®Çu!")
        SetTask(PlayerLightIndex, 0)
        return
    end

    group = math.mod(group, 10)
    if (group == 1) then
        x1, y1, x2, y2, x3, y3 = 1800, 2922, 1815, 2922, 1808, 2908
    elseif (group == 2) then
        x1, y1, x2, y2, x3, y3 = 1825, 2974, 1840, 2974, 1833, 2960
    else
        x1, y1, x2, y2, x3, y3 = 1850, 3057, 1865, 3057, 1858, 3043
    end

    if ((IsInTheSameSize(x, y, x1, y1, x2, y2, x3, y3) == 0) or (IsInTheSameSize(x, y, x2, y2, x1, y1, x3, y3) == 0) or (IsInTheSameSize(x, y, x3, y3, x2, y2, x1, y1) == 0)) then
        Talk(1, "no", "Ph¶i gi¶i phãng ph¸p lùc cña DÉn L«i phï trong trËn ph¸p L«i §iÖn Th¸p.")
        return
    end

    PlayerCastSkill(1, 223, 1)

    local next_npcidx = GetNpcTask(npcidx, 2)

    if (GetNpcTask(next_npcidx, 5) ~= 0) then
        next_npcidx = GetNpcTask(next_npcidx, 2)
    end

    if (next_npcidx == npcidx or next_npcidx == 0) then
        Msg2Player("Khãa dông cô hÑn giê cã sai sãt")
        return
    end

    SetNpcTimer(next_npcidx, "\\script\\ontimer\\À×¶¯¾ÅÌì³ÖÐø¼ÆÊ±.lua", 5)

    ClearItem(6, 1, 488, 1)

end

function IsInTheSameSize(x0, y0, x1, y1, x2, y2, x3, y3)

    if (x2 == x3 and y2 == y3) then
        return 0
    end

    local a, b = (x2 - x3), (y2 - y3)
    local line_x0, line_y0 = (x0 - x3), (y0 - y3)
    local line_x1, line_y1 = (x1 - x3), (y1 - y3)

    local vector_x0 = line_x0 * b - line_y0 * a
    local vector_x1 = line_x1 * b - line_y1 * a

    if ((vector_x0 >= 0 and vector_x1 >= 0) or (vector_x0 <= 0 and vector_x1 <= 0)) then
        return 1
    else
        return 0
    end
end
