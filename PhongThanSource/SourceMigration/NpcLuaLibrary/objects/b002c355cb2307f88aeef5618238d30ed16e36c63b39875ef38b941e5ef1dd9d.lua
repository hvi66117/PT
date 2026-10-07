--²É¼¯Öé×Ó.lua
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-17
task_gather = 1289          --Ë«Éú±Ë°¶µÄÈÎÎñ±äÁ¿,1byte:ÊÇ·ñ½ÓÊÜÈÎÎñ£»2byte£ºÒÑÁìÈ¡µÄÈÎÎñ´ÎÊı£»3byte£ºÒÑ²É¼¯µ½µÄÂüÍÓÂŞ»ªµÄ¸öÊı(ÒÑ¾­·ÏÆú£¬¸Ä×ö×´Ì¬±êÖ¾ £¬1Íê³É£¬2È¡Ïû£¬0ÊÇ½Ó)
beadCount_Must = 8         --ĞèÒª²É¼¯µÄÂüÍÓÂŞ»ªµÄ¸öÊı
manFlowerID = 792        --Î´¿ª»¨µÄÂüÍÓÂŞ»ª¶ÔÓ¦µÄµÀ¾ßID£¬¼´½½Ë®¶ÔÏóµÄTemplateID 
xianzhuID = 794

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàĞÍ(Ç¬1,¶Ò2,Àë3,Õğ4,Ùã5,¿²6,ôŞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåĞÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ĞèÉ±(ÊÕ)¸öÊı 2byte Êµ¼Ê¸öÊı


function OnDeath(npcidx)
    --	NpcPolyMorph(npcidx, -1)      --±ä»ØÔ­À´µÄ×´Ì¬
    --	SetNpcName(npcidx, "Î´¿ª»¨µÄÂüÍÓÂŞ»ª")
end

function OnTimer(npcidx)
    NpcPolyMorph(npcidx, -1)                                      --±ä»ØÔ­À´µÄ×´Ì¬
    SetNpcName(npcidx, "M¹n §µ la hoa ch­a në")
    DelNpcTimer(npcidx)
end

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (GetTaskByte(task_gather, 1) == 1) then
        if (GetPlayerExtLevel() >= 3 and GetJusticEvilCredit() > 0) then
            local a = GetNpcPolyMorph(DialogNpcIdx)
            if (a ~= -1) then
                --Èç¹ûÊÇ±äÉí×´Ì¬

                CaptureNpc(DialogNpcIdx)
                SetNpcTimer(DialogNpcIdx, "\\script\\²»ÖÜÌì¹Ø\\Î´¿ª»¨µÄÂüÍÓÂŞ»ª.lua", 1)

                local num = GetTaskByte(task_gather, 3)
                if (HaveIBBuff(536) > 0) then
                    --debug
                    for i = 1, 2 do
                        AddNormalItemPile(3, 311, 0, 0, 0, 0)
                        num = num + 1
                        if (HaveNormalItem(3, 311, 0, 0) == beadCount_Must) then
                            Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô, vÒ phôc mÖnh th«i!")
                            ScrollMessage("NhiÖm vô <c=g>Song Sinh BØ Ng¹n <c> ®· hoµn thµnh!")
                        end
                    end
                    --SetTaskByte(task_gather, 3, num)

                    if (HaveNormalItem(3, 311, 0, 0) > beadCount_Must) then
                        Msg2Player("NhËn ®­îc 2 M¹n §µ la hoa")
                    else
                        Msg2Player("NhËn ®­îc 2 M¹n §µ la hoa")
                        ScrollMessage("NhËn ®­îc 2 M¹n §µ la hoa")
                    end
                else
                    AddNormalItemPile(3, 311, 0, 0, 0, 0)
                    num = num + 1
                    --SetTaskByte(task_gather, 3, num)

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
                --·ñÔò¿ªÊ¼¼ÆÊ±½½»¨
                local nInterrupt = 0
                nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
                nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
                nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
                nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
                nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
                nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
                nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö

                BeginMotion(task_gather, 0, 3, "\\script\\motion\\²É¼¯ÏÉÖé½ø¶ÈÏìÓ¦.lua", nInterrupt)
                return
            else
                if ((GetTaskByte(gua8_renwu, 4) == 4) and (GetTaskByte(gua8_renwu, 3) == 2)) ~= 1 then
                    Msg2Player("<c=g>M¹n §µ la hoa<c> lµ b¶o vËt cña Tiªn giíi, ph¶i dïng <c=yel>Cam Lé ®Ó t­íi<c>")
                end
            end
            --		return                                --²»Âú×ã½½»¨Ìõ¼şÔò·µ»Ø
        end
    end

    if (GetTaskByte(gua8_renwu, 4) == 4) and (GetTaskByte(gua8_renwu, 3) == 2) then
        if (GetNpcPolyMorph(DialogNpcIdx) == -1) then
            --Î´¿ª»¨µÄ×´Ì¬
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
            nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
            nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
            nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
            nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
            nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
            nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö

            BeginMotion(gua8_task, 1, 3, "\\script\\motion\\²É¼¯ÏÉÖé½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
    end
end 