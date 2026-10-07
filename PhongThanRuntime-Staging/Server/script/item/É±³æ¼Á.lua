Flower_TreeID = 1818
Flower_Blue = 1817
Flower_Bird = 1816
Caizhai_Buff = 1303
Bug_Buff = 1304
Grass_Buff = 1305

function main(nLevel, nTime, nTNpcIdx, itemID)
    local TargetNpcIdx = GetPlayerTarget()
    local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
    local mapid, x, y = GetWorldPos()

    if (npcTemplateID ~= Flower_TreeID) or TargetNpcIdx == 0 then
        Msg2Player("ChØ cã thÓ sö dông ®èi víi hoa ch­a në!")
        return
    end

    if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
        Talk(1, "no", "Hoa t­¬i ®· në, b¹n ®Õn chËm mét b­íc råi!")
        return
    end

    if GetNpcTask(TargetNpcIdx, 2) == 0 then
        Talk(1, "no", "Hoa nµy ch­a cã S©u, h·y t×m hoa kh¸c xem sao!")
        return
    end

    PlayerCastSkill(1, 799, 10)

    SetTask(142, GetNpcID(TargetNpcIdx))
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(TargetNpcIdx, 0, 3, "\\script\\item\\É±³æ¼Á.lua", nInterrupt)

end

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    if TargetNpcIdx == MotionID and GetNpcID(TargetNpcIdx) == GetTask(142) then

        if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
            Talk(1, "no", "Hoa nµy ®· në, b¹n ®Õn chËm mét b­íc råi!")
            return
        end

        local nTimes = GetNpcTask(TargetNpcIdx, 2)
        if nTimes > 0 then
            SetNpcTask(TargetNpcIdx, 2, nTimes - 1)

            TopMessage("DiÖt s©u thµnh c«ng!")

            if (nTimes - 1) == 0 then
                NpcRemoveIBBuff(TargetNpcIdx, Bug_Buff)
            end
        else
            InfoBox("Hoa nµy ch­a cã S©u, h·y t×m hoa kh¸c xem sao!")
        end

        SetTask(140, 0)
    else
        Msg2Player("B¹n ®· thay ®æi môc tiªu, Thuèc diÖt trïng v« hiÖu!")
    end
end

function InteruptMotion(MotionID)

end

function no()
    CloseDialog()
end
