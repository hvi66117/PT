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

    SetTask(140, itemID)
    SetTask(142, GetNpcID(TargetNpcIdx))
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(TargetNpcIdx, 0, 3, "\\script\\item\\Çà³æ.lua", nInterrupt)

end

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    if TargetNpcIdx == MotionID and GetNpcID(TargetNpcIdx) == GetTask(142) then

        if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
            Talk(1, "no", "Hoa t­¬i ®· në, b¹n ®Õn chËm mét b­íc råi!")
            return
        end

        local nTimes = GetNpcTask(TargetNpcIdx, 2)
        SetNpcTask(TargetNpcIdx, 2, nTimes + 1)

        TopMessage("Th¶ s©u thµnh c«ng")

        DelItemByID(GetTask(140))
        SetTask(140, 0)

        NpcAddIBBuff(TargetNpcIdx, Bug_Buff)

        SetNpcTask(TargetNpcIdx, 7, 1)
    else
        Msg2Player("B¹n ®· thay ®æi môc tiªu, th¶ s©u thÊt b¹i!")
    end
end

function InteruptMotion(MotionID)

end

function no()
    CloseDialog()
end
