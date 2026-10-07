Global_BlueValue = 371

Flower_TreeID = 1818
Flower_Blue = 1817
Flower_Bird = 1816

Caizhai_Buff = 1303
Bug_Buff = 1304
Grass_Buff = 1305

Total_BlueCount = 2000

function main(nLevel, nTime, nTNpcIdx, itemID)
    local nYear, nMonth, nDay = GetYMD()
    local saveDay = GetGlobalValueWord(Global_BlueValue, 2)

    if saveDay ~= nDay then
        SetGlobalValueWord(Global_BlueValue, 2, nDay)
        SetGlobalValueWord(Global_BlueValue, 1, 0)
    end

    local TargetNpcIdx = GetPlayerTarget()
    local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
    local mapid, x, y = GetWorldPos()

    if (npcTemplateID ~= Flower_TreeID) or TargetNpcIdx == 0 then
        Msg2Player("Ph¶i chän ®óng hoa ch­a në ®Ó sö dông. ")
        return
    end

    if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
        Talk(1, "no", "Hoa t­¬i ®· në råi, kh«ng cÇn ch¨m bãn n÷a!")
        return
    end

    local nPlyID = GetPlayerID()
    if nPlyID == GetNpcTask(TargetNpcIdx, 4) or nPlyID == GetNpcTask(TargetNpcIdx, 5) or nPlyID == GetNpcTask(TargetNpcIdx, 6) then
        Talk(1, "no", "B¹n ®· ch¨m bãn cho bôi hoa nµy råi! Xin h·y ch¨m sãc cho bôi kh¸c!")
        return
    end

    PlayerCastSkill(1, 801, 10)

    SetTask(140, DialogNpcIdx)
    SetTask(142, GetNpcID(DialogNpcIdx))
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(TargetNpcIdx, 0, 3, "\\script\\item\\åÐÒ;¨·Ê.lua", nInterrupt)

end

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    if TargetNpcIdx == MotionID and GetNpcID(TargetNpcIdx) == GetTask(142) then
        if GetNpcPolyMorph(TargetNpcIdx) ~= -1 then
            Talk(1, "no", "Hoa t­¬i ®· në råi, kh«ng cÇn ch¨m bãn n÷a!")
            return
        end

        local nTimes = GetNpcTask(TargetNpcIdx, 1)
        SetNpcTask(TargetNpcIdx, 1, nTimes + 1)

        for i = 4, 6 do
            if GetNpcTask(TargetNpcIdx, i) == 0 then
                SetNpcTask(TargetNpcIdx, i, GetPlayerID())
                break
            end
        end

        if (nTimes + 1) >= 3 then
            NpcAddIBBuff(TargetNpcIdx, Caizhai_Buff)
            Npc_PolyMorph(TargetNpcIdx)
            Msg2CurMapAnnounce("Hoa ®· b¾t ®Çu në!")
            TopMessage("Ch¨m bãn thµnh c«ng! Hoa ®· b¾t ®Çu në!")
        else
            TopMessage("Ch¨m bãn thµnh c«ng!")
        end
    else
        Msg2Player("B¹n ®· thay ®æi môc tiªu, ch¨m bãn thÊt b¹i!")
    end
end

function Npc_PolyMorph(TargetNpcIdx)
    local i = math.random(1, 100)
    local item = 0
    local nRate = 0
    if GetNpcTask(TargetNpcIdx, 2) > 0 or GetNpcTask(TargetNpcIdx, 3) > 0 then
        nRate = 5
    else
        if GetNpcTask(TargetNpcIdx, 7) > 0 or GetNpcTask(TargetNpcIdx, 8) > 0 then
            nRate = 10
        else
            nRate = 20
        end
    end

    if i <= nRate then
        if GetGlobalValueWord(Global_BlueValue, 1) < Total_BlueCount then
            SetGlobalValueWord(Global_BlueValue, 1, GetGlobalValueWord(Global_BlueValue, 1) + 1)
            NpcPolyMorph(TargetNpcIdx, Flower_Blue)
            TopMessage("MÇm hoa ®· lín thµnh <c=yel>Hoa Hång xanh<c>")
        else
            NpcPolyMorph(TargetNpcIdx, Flower_Bird)
            TopMessage("MÇm hoa ®· lín thµnh <c=yel>Hoa Thiªn §iÓu<c>")
        end
    else
        NpcPolyMorph(TargetNpcIdx, Flower_Bird)
        TopMessage("MÇm hoa ®· lín thµnh <c=yel>Hoa Thiªn §iÓu<c>")
    end
    NpcRemoveIBBuff(TargetNpcIdx, Bug_Buff)
    NpcRemoveIBBuff(TargetNpcIdx, Grass_Buff)
end

function no()
    CloseDialog()
end

function InteruptMotion(MotionID)

end

