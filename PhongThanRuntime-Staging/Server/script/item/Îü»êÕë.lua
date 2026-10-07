back_cele = 1379

back_numbers = 1381

function main()
    local status = GetTaskByte(back_cele, 1)
    if (status == 1) then
        local TargetNpcIdx = GetPlayerTarget()
        local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
        local m, x, y = GetWorldPos()

        if (m ~= 74) then
            Msg2Player("§¹o cô nµy chØ cã thÓ sö dông t¹i BÊt Chu s¬n!")
            return
        end

        if (TargetNpcIdx == 0 or npcTemplateID ~= 747) then
            Msg2Player("B¹n kh«ng chän HuyÕt Yªu!")
            return
        end

        if (GetFightState() == 0) then
            Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
            return
        end

        local lifeRate = GetNpcLife(TargetNpcIdx) / GetNpcLifeMax(TargetNpcIdx)
        if (lifeRate >= 0.5) then
            Msg2Player("M¸u HuyÕt Yªu ph¶i thÊp h¬n 50% míi cã thÓ thi triÓn hót hån cña nã!")
            return
        end
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 0)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 0)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)
        BeginMotion(back_cele, 0, 5, "\\script\\motion\\Îü»ê.lua", nInterrupt)
    elseif (status == 2) then
        local zhenying = GetJusticEvilCredit()
        local kind = GetTaskByte(back_numbers, 3)
        local name = { "Sãi", "Ma Phong thó s¬n hån", "Tiªn Phong thó s¬n hån" }
        local str = name[kind]
        Msg2Player("H·y ®Õn chç " .. str .. " t×m Ph¸ch thÊt l¹c")
    end
end
