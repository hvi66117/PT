Task_Variety_Process = 1389

function main(l, t, npcindex)

    if (npcindex == 0) then
        Msg2Player("ChØ chuét vµo Ho¶ Ly TiÓu Yªu míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    if (GetTaskByte(Task_Variety_Process, 1) ~= 14) then
        Msg2Player("Hån B¹ch cña b¹n kh«ng phï hîp ®iÒu kiÖn sö dông, sau khi nhËn Háa Ly Tinh Ph¸ch, t×m ®¹i phu lÊy Hån B¹ch míi sö dông ®­îc vËt phÈm nµy.")
        return
    end

    local m, x, y = GetWorldPos()
    local npcTemplateID = GetNpcTemplateID(npcindex)
    local _, npcx, npcy = GetNpcWorldPos(npcindex)

    if (m ~= 27) then
        Msg2Player("Hån B¹ch chØ ®­îc sö dông t¹i Hiªn Viªn ®éng tÇng 1!")
        return
    end

    if (npcTemplateID ~= 22) then
        Msg2Player("ChØ chuét vµo Ho¶ Ly TiÓu Yªu míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    local distance = ((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32
    distance = math.floor(distance)
    if distance > 350 then
        Msg2Player("B¹n c¸ch Ho¶ Ly TiÓu Yªu qu¸ xa, Hån B¹ch kh«ng thÓ ph¸t huy t¸c dông!")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 1)
    SetPlayerTarget(npcindex)
    BeginMotion(Task_Variety_Process, 0, 4, "\\script\\motion\\ÍµÈ¡»ðÀë¾«ÆÇ.lua", nInterrupt)

end;
