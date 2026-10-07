star_dream = 1419

function main(l, t, npcindex)

    if (GetTaskByte(star_dream, 1) ~= 11) then
        return
    end

    if (npcindex == 0) then
        Msg2Player("ChØ chuét vµo B¨ng Háa Ma míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    local m, x, y = GetWorldPos()
    local npcTemplateID = GetNpcTemplateID(npcindex)
    local _, npcx, npcy = GetNpcWorldPos(npcindex)

    if (m ~= 32) then
        Msg2Player("Hån Ph¸ch Hå L« chØ ®­îc sö dông t¹i Ngäc TuyÒn B¨ng Xuyªn!")
        return
    end

    if (npcTemplateID ~= 995) then
        Msg2Player("ChØ chuét vµo B¨ng Háa Ma míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    if (GetNpcTask(npcindex, 1) ~= GetPlayerID()) then
        Msg2Player("B¨ng Háa Ma nµy kh«ng cã ma lùc, tiÕp tôc t×m kiÕm.")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    local distance = ((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32
    distance = math.floor(distance)
    if distance > 300 then
        Msg2Player("B¹n c¸ch B¨ng Háa Ma qu¸ xa, Hå L« Hån Ph¸ch kh«ng thÓ ph¸t huy t¸c dông!")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 1)
    SetPlayerTarget(npcindex)
    BeginMotion(star_dream, 0, 2, "\\script\\motion\\ÊÕ·þ±ù»ðÄ§.lua", nInterrupt)

end;
