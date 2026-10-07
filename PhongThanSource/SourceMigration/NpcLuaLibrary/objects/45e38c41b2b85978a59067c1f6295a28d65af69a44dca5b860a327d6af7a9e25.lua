task_gather = 1289
beadCount_Must = 8
manFlowerID = 792
xianzhuID = 794

gua8_renwu = 1340
gua8_task = 1341

function OnDeath(npcidx)


end

function OnTimer(npcidx)
    NpcPolyMorph(npcidx, -1)
    SetNpcName(npcidx, "M¹n §µ la hoa ch­a në")
    DelNpcTimer(npcidx)
end

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(task_gather, 1) == 1) then
        if (GetPlayerExtLevel() >= 3 and GetJusticEvilCredit() > 0) then
            local a = GetNpcPolyMorph(DialogNpcIdx)
            if (a ~= -1) then

                CaptureNpc(DialogNpcIdx)
                SetNpcTimer(DialogNpcIdx, "\\script\\²»ÖÜÌì¹Ø\\Î´¿ª»¨µÄÂüÍÓÂÞ»ª.lua", 1)

                local num = GetTaskByte(task_gather, 3)
                if (HaveIBBuff(536) > 0) then
                    for i = 1, 2 do
                        AddNormalItemPile(3, 311, 0, 0, 0, 0)
                        num = num + 1
                        if (HaveNormalItem(3, 311, 0, 0) == beadCount_Must) then
                            Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô, vÒ phôc mÖnh th«i!")
                            ScrollMessage("NhiÖm vô <c=g>Song Sinh BØ Ng¹n <c> ®· hoµn thµnh!")
                        end
                    end

                    if (HaveNormalItem(3, 311, 0, 0) > beadCount_Must) then
                        Msg2Player("NhËn ®­îc 2 M¹n §µ la hoa")
                    else
                        Msg2Player("NhËn ®­îc 2 M¹n §µ la hoa")
                        ScrollMessage("NhËn ®­îc 2 M¹n §µ la hoa")
                    end
                else
                    AddNormalItemPile(3, 311, 0, 0, 0, 0)
                    num = num + 1

                    if (HaveNormalItem(3, 311, 0, 0) == beadCount_Must) then
                        Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô, vÒ phôc mÖnh th«i!")
                        ScrollMessage("NhiÖm vô <c=g>Song Sinh BØ Ng¹n <c> ®· hoµn thµnh!")
                    elseif (HaveNormalItem(3, 311, 0, 0) > beadCount_Must) then
                        Msg2Player("NhËn ®­îc 1 M¹n §µ la hoa")
                    else
                        Msg2Player("NhËn ®­îc 1 M¹n §µ la hoa")
                        ScrollMessage("NhËn ®­îc 1 M¹n §µ la hoa")
                    end
                end
            elseif (HaveIBBuff(500) > 0) then
                local nInterrupt = 0
                nInterrupt = SetBit(nInterrupt, 1, 1)
                nInterrupt = SetBit(nInterrupt, 2, 1)
                nInterrupt = SetBit(nInterrupt, 3, 1)
                nInterrupt = SetBit(nInterrupt, 4, 1)
                nInterrupt = SetBit(nInterrupt, 5, 1)
                nInterrupt = SetBit(nInterrupt, 6, 0)
                nInterrupt = SetBit(nInterrupt, 9, 1)

                BeginMotion(task_gather, 0, 3, "\\script\\motion\\²É¼¯ÏÉÖé½ø¶ÈÏìÓ¦.lua", nInterrupt)
                return
            else
                if ((GetTaskByte(gua8_renwu, 4) == 4) and (GetTaskByte(gua8_renwu, 3) == 2)) ~= 1 then
                    Msg2Player("<c=g>M¹n §µ la hoa<c> lµ b¶o vËt cña Tiªn giíi, ph¶i dïng <c=yel>Cam Lé ®Ó t­íi<c>")
                end
            end

        end
    end

    if (GetTaskByte(gua8_renwu, 4) == 4) and (GetTaskByte(gua8_renwu, 3) == 2) then
        if (GetNpcPolyMorph(DialogNpcIdx) == -1) then
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 1)
            nInterrupt = SetBit(nInterrupt, 4, 1)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)

            BeginMotion(gua8_task, 1, 3, "\\script\\motion\\²É¼¯ÏÉÖé½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
    end
end 
