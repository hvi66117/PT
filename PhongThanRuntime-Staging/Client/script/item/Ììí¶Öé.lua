Task_newer13 = 1416

function main()
    CloseDialog()
    if (GetPlayerType() ~= 1) then
        ClearItem(6, 1, 498, 0)
        return 0
    end

    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 < 4) then
        Talk(1, "no", "Ph¸p lùc cña Thiªn C¬ ch©u cã h¹n, h·y cÈn thËn. Khi cã viÖc gÊp h·y hái §¹i Phu tr­íc tung tÝch cña ph¶n ®å TriÖt gi¸o.")
        return 0
    elseif (state18 >= 5) or (GetTaskWord(Task_newer13, 2) ~= 0) then
        ClearItem(6, 1, 498, 0)
        Msg2Player("ChÕ ngù ph¶n ®å TriÖt gi¸o, ®o¹t vÒ Tiªn C¬ häa.")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and (GetNpcTemplateID(TargetNpcIdx) == 974) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 0)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\Ììí¶Öé.lua", nInterrupt)
    else
        Msg2Player("Môc tiªu v« hiÖu, Thiªn C¬ ch©u chØ  sö dông víi TuyÕt Nguyªn Cù Thó .")
    end
end;

function no()
    CloseDialog()
end;
