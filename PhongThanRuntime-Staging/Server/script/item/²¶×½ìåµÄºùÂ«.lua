gIn_TaskYangShou = 1308
gIn_YangShouCatchCount = 20
gIn_YangShouNpcTempID = 739
gIn_YangShouLifePercent = 20

function main()
    if (GetTaskBit(gIn_TaskYangShou, 2) == 1) then
        local TargetNpcIdx = GetPlayerTarget()
        if (GetFightState() == 0) then
            Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        elseif (TargetNpcIdx == 0) or (GetNpcTemplateID(TargetNpcIdx) ~= gIn_YangShouNpcTempID) then
            Msg2Player("B¹n ch­a chän Phi Thè.")
        elseif (GetTaskByte(gIn_TaskYangShou, 2) >= gIn_YangShouCatchCount) then
            Msg2Player("§· hoµn thµnh nhiÖm vô Phi Thè Cèt, vÒ gÆp HuyÒn §« §¹i Ph¸p s­ phôc mÖnh!")


        else
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 0)
            nInterrupt = SetBit(nInterrupt, 4, 0)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)
            BeginMotion(gIn_TaskYangShou, 0, 5, "\\script\\motion\\²¶×½½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
    end
end;

