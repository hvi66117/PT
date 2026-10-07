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
        InfoBox("ChØ cã thÓ sö dông ®èi víi hoa ch­a në!")
        return
    end

    if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
        Talk(1, "no", "Hoa t­¬i ®· në, b¹n ®Õn chËm mét b­íc råi!")
        return
    end

    if GetNpcTask(TargetNpcIdx, 3) == 0 then
        Talk(1, "no", "Bôi hoa nµy kh«ng ph¶i lµ cá d¹i, h·y qua ch¨m sãc bôi kh¸c!")
        return
    end

    PlayerCastSkill(1, 800, 10)

    SetTask(142, GetNpcID(TargetNpcIdx))
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(TargetNpcIdx, 0, 3, "\\script\\item\\³ý²Ý¼Á.lua", nInterrupt)

end

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    if TargetNpcIdx == MotionID and GetNpcID(TargetNpcIdx) == GetTask(142) then
        if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
            Talk(1, "no", "Hoa t­¬i ®· në, b¹n ®Õn chËm mét b­íc råi!")
            return
        end

        local nTimes = GetNpcTask(TargetNpcIdx, 3)
        if nTimes > 0 then
            SetNpcTask(TargetNpcIdx, 3, nTimes - 1)

            TopMessage("Trõ cá thµnh c«ng!")

            if (nTimes - 1) == 0 then
                NpcRemoveIBBuff(TargetNpcIdx, Grass_Buff)
            end
        else
            InfoBox("Bôi hoa nµy kh«ng ph¶i lµ cá d¹i, h·y qua ch¨m sãc bôi kh¸c!")
        end
        SetTask(140, 0)
    else
        Msg2Player("B¹n ®· thay ®æi môc tiªu, phun thuèc diÖt cã thÊt b¹i!")
    end
end

function InteruptMotion(MotionID)

end

function no()
    CloseDialog()
end




