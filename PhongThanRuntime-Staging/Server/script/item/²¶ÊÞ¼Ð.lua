Task_Mischief = 1357

hanguiID = 24
tianwuID = 16

function main()
    if (GetTaskByte(Task_Mischief, 1) == 1) then
        local TargetNpcIdx = GetPlayerTarget()
        local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
        local hanguiNum = GetTaskByte(Task_Mischief, 2)
        local tianwuNum = GetTaskByte(Task_Mischief, 3)
        local m, x, y = GetWorldPos()

        if (GetFightState() == 0) then
            Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
            return
        end

        if (m ~= 18) then
            Msg2Player("§¹o cô nµy chØ cã thÓ sö dông trong Môc D·")
            return
        end

        if (TargetNpcIdx == 0 or (npcTemplateID ~= 16 and npcTemplateID ~= 24)) then
            Msg2Player("B¹n ch­a chän Thiªn Ng« hoÆc H¹n Quy")
            return
        end

        if (hanguiNum == 5 and tianwuNum == 5) then
            Msg2Player("§· hoµn thµnh nhiÖm vô b¾t, giao Thiªn Ng« vµ H¹n Quy b¾t ®­îc giao cho TriÒu Ca Hoµng Thiªn Hãa.")
            return
        end

        if (npcTemplateID == 24) then
            if (hanguiNum < 5) then
                local nInterrupt = 0
                nInterrupt = SetBit(nInterrupt, 1, 0)
                nInterrupt = SetBit(nInterrupt, 2, 1)
                nInterrupt = SetBit(nInterrupt, 3, 0)
                nInterrupt = SetBit(nInterrupt, 4, 0)
                nInterrupt = SetBit(nInterrupt, 5, 0)
                nInterrupt = SetBit(nInterrupt, 6, 0)
                nInterrupt = SetBit(nInterrupt, 9, 1)
                BeginMotion(Task_Mischief, 0, 5, "\\script\\motion\\²¶×½ºµ¹êÌìÎâ.lua", nInterrupt)
            else
                Msg2Player("B¹n ®· b¾t ®ñ <c=r>H¹n Quy.")
            end
        elseif (npcTemplateID == 16) then
            if (tianwuNum < 5) then
                local nInterrupt = 0
                nInterrupt = SetBit(nInterrupt, 1, 0)
                nInterrupt = SetBit(nInterrupt, 2, 1)
                nInterrupt = SetBit(nInterrupt, 3, 0)
                nInterrupt = SetBit(nInterrupt, 4, 0)
                nInterrupt = SetBit(nInterrupt, 5, 0)
                nInterrupt = SetBit(nInterrupt, 6, 0)
                nInterrupt = SetBit(nInterrupt, 9, 1)
                BeginMotion(Task_Mischief, 0, 5, "\\script\\motion\\²¶×½ºµ¹êÌìÎâ.lua", nInterrupt)
            else
                Msg2Player("B¹n ®· b¾t ®ñ<c=r>Thiªn Ng«<c>.")
            end
        end
    end
end
