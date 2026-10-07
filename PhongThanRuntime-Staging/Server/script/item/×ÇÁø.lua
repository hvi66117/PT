Task_flower = 1471

function main(l, t, npcindex)
    CloseDialog()
    if (npcindex == 0) then
        Msg2Player("ChØ chuét vµo qu¸i thó Ngôc Ph¸p s¬n míi x¸c ®Þnh ®­îc môc tiªu.")
        return
    end

    if (GetTaskByte(Task_flower, 1) < 5) then
        Msg2Player("§õng nªn l·ng phÝ vËt phÈm quý nµy.")
        return
    end
    if (GetTaskByte(Task_flower, 1) > 5) then
        ClearItem(6, 1, 522, 1)
        Msg2Player("C©y Träc LiÔu nµy kh«ng hiÓu sao bÞ hÐo…")
    end
    local m, x, y = GetWorldPos()
    local npcTemplateID = GetNpcTemplateID(npcindex)
    local _, npcx, npcy = GetNpcWorldPos(npcindex)

    if (m ~= 75) then
        Msg2Player("Träc LiÔu chØ hót ®­îc khÝ ®éc tõ c¬ thÓ qu¸i thó Ngôc Ph¸p s¬n.")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    local distance = ((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32
    distance = math.floor(distance)
    if distance > 500 then
        Msg2Player("B¹n c¸ch môc tiªu qu¸ xa, Träc LiÔu chØ t¸c dông trong ph¹m vi 500, giê kho¶ng c¸ch cña b¹n lµ:" .. distance)
        return
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and ((GetNpcTemplateID(TargetNpcIdx) == 930) or (GetNpcTemplateID(TargetNpcIdx) == 931) or (GetNpcTemplateID(TargetNpcIdx) == 932) or (GetNpcTemplateID(TargetNpcIdx) == 933)) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)
        SetPlayerTarget(npcindex)
        BeginMotion(Task_flower, 1, 3, "\\script\\motion\\×ÇÁø.lua", nInterrupt)
    else
        Msg2Player("B¹n ch­a chän môc tiªu.")
    end
end;

function no()
    CloseDialog()
end;
