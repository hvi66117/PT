function main()
    CloseDialog()
    if (HaveIBBuff(678) <= 0) then
        Msg2Player("Thêi gian truy b¾t kÕt thóc!")
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w < 14) or (w > 16) then
        Msg2Player("Bæ Trãc KhÝ chØ cã thÓ sö dông ë M¹nh T©n, Tam S¬n, §ång Quan!")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    local tempid = GetNpcTemplateID(TargetNpcIdx)
    if (TargetNpcIdx > 0) and (tempid > 5) and (tempid <= 20) then
        local nums = FindAValidIBItem(8, 684, 2, 0)
        if (nums > 0) then
            CostIBItem(nums)
        else
            Msg2Player("Xin x¸c nhËn b¹n cã vËt phÈm nµy vµ vÉn cßn hiÖu lùc!")
            return 0
        end

        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)
        BeginMotion(w, 1, 3, "\\script\\motion\\×½Ë¿Æ÷.lua", nInterrupt)
    else
        Msg2Player("Môc tiªu truy b¾t v« hiÖu!")
    end
end;

function no()
    CloseDialog()
end;
