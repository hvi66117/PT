Task_star = 1417

function main(l, t, npcindex)

    local ShahunNum = GetTaskByte(Task_star, 2)
    if (ShahunNum >= 1) then
        Msg2Player("§· luyÖn ®ñ sè Sa Hån cÇn thiÕt.")
        return
    end

    if (npcindex == 0) then
        Msg2Player("ChØ chuét vµo Sa Hån míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    if (GetTaskByte(Task_star, 1) ~= 5) then
        Mag2Player("LuyÖn Yªu Hå cña b¹n kh«ng phï hîp ®iÒu kiÖn sö dông")
        return
    end

    local mapid, x, y = GetWorldPos()
    local npcTemplateID = GetNpcTemplateID(npcindex)
    local mapid1, npcx, npcy = GetNpcWorldPos(npcindex)

    if (npcTemplateID ~= 17) then
        Msg2Player("ChØ chuét vµo Sa Hån.")
        return
    end

    local distance = math.floor(((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32)
    if (distance > 300) then
        Msg2Player("B¹n c¸ch Sa Hån qu¸ xa, LuyÖn Yªu Hå kh«ng t¸c dông!")
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
    BeginMotion(Task_star, 0, 5, "\\script\\motion\\Á¶»¯É³»ê.lua", nInterrupt)

end;

