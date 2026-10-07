task_gather = 1289
beadCount_Must = 8
manFlowerID = 793
mozhuID = 795

function OnDeath(npcidx)


end

function OnTimer(npcidx)
    NpcPolyMorph(npcidx, -1)
    SetNpcName(npcidx, "M¹n Ch©u Sa hoa ch­a në")
    DelNpcTimer(npcidx)
end

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(task_gather, 1) == 1) then
        if (GetPlayerExtLevel() >= 3 and GetJusticEvilCredit() < 0) then
            local a = GetNpcPolyMorph(DialogNpcIdx)
            if (a ~= -1) then

                CaptureNpc(DialogNpcIdx)
                SetNpcTimer(DialogNpcIdx, "\\script\\²»ÖÜÌì¹Ø\\Î´¿ª»¨µÄÂüÖéÉ³»ª.lua", 1)

                local num = GetTaskByte(task_gather, 3)
                if (HaveIBBuff(536) > 0) then
                    for i = 1, 2 do
                        AddNormalItemPile(3, 312, 0, 0, 0, 0)
                        num = num + 1
                        if (HaveNormalItem(3, 312, 0, 0) == beadCount_Must) then
                            Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô, vÒ phôc mÖnh th«i!")
                            ScrollMessage("NhiÖm vô <c=g>Song Sinh BØ Ng¹n <c> ®· hoµn thµnh!")
                        end
                    end

                    if (HaveNormalItem(3, 312, 0, 0) > beadCount_Must) then
                        Msg2Player("NhËn ®­îc 2 M¹n Ch©u Sa hoa")
                    else
                        Msg2Player("NhËn ®­îc 2 M¹n Ch©u Sa hoa")
                        ScrollMessage("NhËn ®­îc 2 M¹n Ch©u Sa hoa")
                    end
                else
                    AddNormalItemPile(3, 312, 0, 0, 0, 0)
                    num = num + 1

                    if (HaveNormalItem(3, 312, 0, 0) == beadCount_Must) then
                        Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô, vÒ phôc mÖnh th«i!")
                        ScrollMessage("NhiÖm vô <c=g>Song Sinh BØ Ng¹n <c> ®· hoµn thµnh!")
                    elseif (HaveNormalItem(3, 312, 0, 0) > beadCount_Must) then
                        Msg2Player("NhËn ®­îc 1 M¹n Ch©u Sa hoa")
                    else
                        Msg2Player("NhËn ®­îc 1 M¹n Ch©u Sa hoa")
                        ScrollMessage("NhËn ®­îc 1 M¹n Ch©u Sa hoa")
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
                BeginMotion(task_gather, 0, 3, "\\script\\motion\\²É¼¯Ä§Öé½ø¶ÈÏìÓ¦.lua", nInterrupt)
            else
                Msg2Player("<c=g>M¹n Ch©u Sa hoa<c> lµ b¶o vËt cña Ma giíi ph¶i dïng <c=yel>Cam Lé ®Ó t­íi<c>")
            end

        end
    end
end 
