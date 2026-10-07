Task_newer13 = 1416

function main()
    CloseDialog()
    if (GetPlayerType() ~= 2) then
        ClearItem(6, 1, 497, 0)
        return 0
    end

    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 < 4) then
        Talk(1, "no", "Ph¸p lùc cña tr¸p Tô Hån cã h¹n, khi sö dông ph¶i cÈn thËn. ViÖc tr­íc m¾t lµ ®i t×m §¹i phu ë Miªu C­¬ng hái hµnh tung cña ph¶n ®å TriÖt gi¸o.")
        return 0
    elseif (state18 >= 5) or (GetTaskWord(Task_newer13, 2) ~= 0) then
        ClearItem(6, 1, 497, 0)
        Msg2Player("ChÕ phôc ph¶n ®å TriÖt gi¸o, ®o¹t l¹i B¶o T©n ®¬n ngµn n¨m thËt.")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and (GetNpcTemplateID(TargetNpcIdx) == 975) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 0)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\¾Û»êÏ».lua", nInterrupt)
    else
        Msg2Player("B¹n ch­a chän Th¶o Tiªn ®¸ng nghi")
    end
end;

function no()
    CloseDialog()
end;
