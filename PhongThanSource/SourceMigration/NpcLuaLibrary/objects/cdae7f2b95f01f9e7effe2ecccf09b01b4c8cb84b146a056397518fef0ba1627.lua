--À×µçÖ®Ëş.lua
--author Laiyongcong
--date 2009-04-20

-------------±³ºóÖ÷Ä±-------------------

PlayerLightIndex = 1403 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ¡¢»ğÀëĞ¡Ñı¡¢±³ºóÖ÷Ä±-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿
PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex
--

function no()
    CloseDialog()
end;

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (GetTaskByte(Task_Variety_Process, 1) ~= 19) then
        Talk(1, "no", "§©y lµ L«i §iÖn Th¸p, cã thÓ dÉn ®éng thiªn l«i!")
        return
    end

    local group = GetNpcTask(DialogNpcIdx, 1) --npcËùÊôµÄ·Ö×é£¬±»µãÁÁºó·Ö×é¼ÓÉÏ10
    local PID = GetPlayerID() --»ñµÃµ±Ç°Íæ¼ÒµÄÉí·İ±êÊ¶

    if (group > 10) then
        TopMessage("Th¸p nµy ®· th¾p s¸ng qua råi")
        return
    end

    if (HaveNormalItem(6, 1, 487, 1) == 0) then
        Talk(1, "no", "Ng­¬i kh«ng cã Bİch L«i Phï trªn ng­êi, kh«ng thÓ th¾p sang L«i §iÖn Th¸p.")
        return
    end

    --²éÑ¯Õâ×éËşÊÇ·ñ±»ÆäËûÍæ¼ÒÕ¼ÓÃ£¬npcÉíÉÏµÄµÚËÄ¸öÈÎÎñ±äÁ¿
    local BindPlayerID = GetNpcTask(DialogNpcIdx, 4)
    if (BindPlayerID ~= 0 and PID ~= BindPlayerID) then
        Talk(1, "no", "Tæ th¸p nµy ®· bŞ ng­êi ch¬i kh¸c th¾p s¸ng råi, xin h·y quay l¹i sau.")
        return
    end

    --²éÑ¯Íæ¼ÒÊÇ·ñÕ¼ÓÃÁËÆäËûµÄËş
    local next_npcidx1 = GetNpcTask(DialogNpcIdx, 3) --ÏÂÒ»×éµÄÖ÷Ëş
    local next_npcidx2 = GetNpcTask(next_npcidx1, 3) --ÏÂÏÂÒ»×éµÄÖ÷Ëş
    if (GetNpcTask(next_npcidx1, 4) == PID or GetNpcTask(next_npcidx2, 4) == PID) then
        Talk(1, "no", "Ng­¬i ®· th¾p s¸ng th¸p kh¸c råi, h·y nhanh chèng ®Õ tæ th¸p ®ã t×m kiÕm huyÒn c¬.")
        return
    end

    --¼ì²é±¾×éµÄ°ó¶¨Çé¿ö
    next_npcidx1 = GetNpcTask(DialogNpcIdx, 2) --±¾×éÄÚµÄÁ½¸öËş
    next_npcidx2 = GetNpcTask(next_npcidx1, 2)
    local group1 = GetNpcTask(next_npcidx1, 1)
    local group2 = GetNpcTask(next_npcidx2, 1)

    if (group1 < 10 and group2 < 10) then
        SetNpcTimer(DialogNpcIdx, "\\script\\ontimer\\À×µçÖ®Ëş¼ÆÊ±.lua", 180)
        SetNpcTask(DialogNpcIdx, 4, PID)
        ---ÇÀÕ¼Õâ×éËş
        SetNpcTask(next_npcidx1, 4, PID)
        SetNpcTask(next_npcidx2, 4, PID)
        SetTask(PlayerLightIndex, DialogNpcIdx) --°ÑÍæ¼ÒµãÁÁµÄËşid°ó¶¨µ½¸ÃÍæ¼ÒµÄÈÎÎñ±äÁ¿ÉÏ
        AddIBBuff(645)
    end
    ---------------------------------------------------------------------------------------------Ìí¼ÓµãÁÁÌØĞ§
    NpcAddIBBuff(DialogNpcIdx, 646)
    SetNpcTask(DialogNpcIdx, 1, group + 10)--±êÊ¶¸ÃËşÎªµãÁÁ×´Ì¬
    Msg2Player("§· th¾p s¸ng 1 tßa L«i §iÖn Th¸p")
    ScrollMessage("§· th¾p s¸ng 1 tßa L«i §iÖn Th¸p")
    DelNormalItem(6, 1, 487, 1) --É¾³ıÒ»¸ö±ÜÀ×·û
    Msg2Player("§· mÊt ®i 1 Bİch L«i Phï")
    ScrollMessage("§· mÊt ®i 1 Bİch L«i Phï")

    if (group1 > 10 and group2 > 10) then
        --Ô­À´ËùÓĞµÄËş¶¼ÒÑ¾­µãÁÁÁË
        ----------------------------------------------Ìí¼ÓÈı½ÇĞÎÌØĞ§

        local lineX, lineY = 0, 0
        if (group == 1) then
            lineX, lineY = 1801, 2922
        elseif group == 2 then
            lineX, lineY = 1826, 2974
        else
            lineX, lineY = 1851, 3057
        end

        local TriangleNpcidx = AddNpc(960, 1, SubWorld, lineX * 32, lineY * 32)
        if (TriangleNpcidx ~= 0) then
            --Èı½ÇĞÎNPCÓëÀ×µçÖ®Ëş¹ØÁª
            SetNpcTask(DialogNpcIdx, 5, TriangleNpcidx)
            SetNpcTask(TriangleNpcidx, 1, DialogNpcIdx)
            --local nextNpcidx = GetNpcTask(DialogNpcIdx,2) --ÏÂÒ»¸önpcµÄidx
            ---°ÑÈı½ÇĞÎnpc¼ÓÈëµ½Ñ­»·Á´±íÖĞ
            --SetNpcTask(DialogNpcIdx,2,TriangleNpcidx)
            --Msg2Player(TriangleNpcidx)	-----------------------------Êä³öÈı½ÇĞÎµÄindex
            --SetNpcTask(TriangleNpcidx,2,nextNpcidx)
            --Msg2Player(nextNpcidx)	-----------------------------Êä³öÏÂÒ»¸önpcµÄidx

            --SetNpcTask(TriangleNpcidx,3,GetNpcTask(DialogNpcIdx,3))
            --SetNpcTask(TriangleNpcidx,1,group+20)------------Ê±¼äµ½»òÕßÈÎÎñÌá½»½«±»É¾³ı
            --SetNpcTask(TriangleNpcidx,4,GetNpcTask(DialogNpcIdx,4))
            SetNpcName(TriangleNpcidx, "")
        else
            ScrollMessage("Gia t¨ng hiÖu øng h×nh tam gi¸c thÊt b¹i")
        end
        ClearItem(6, 1, 488, 1)
        AddNormalItem(6, 1, 488, 1, 0, 0) --¸øÍæ¼ÒÒ»¸öÒıÀ×·û
        Talk(1, "no", "L«i §iÖn Th¸p:Gi÷a 3 tßa L«i §iÖn Th¸p sö dông Bİch L«i Phï cã thÓ dÉn ®éng l«i ®iÖn trªn trêi!")
        --if (HaveNormalItem(6,1,488,1)>0) then
        --	Talk(1,"no","À×µçÖ®Ëş£ºÔÚÈı¸öÀ×µçÖ®ËşÖ®¼äÊ¹ÓÃÒıÀ×·û¿ÉÒÔÒı¶¯ÌìÉÏµÄÀ×µç£¡")
        --else
        --	AddNormalItem(6,1,488,1,0,0) --¸øÍæ¼ÒÒ»¸öÒıÀ×·û
        --	Talk(1,"no","À×µçÖ®Ëş£ºÕâÊÇÎÒÃÇ¸øÄãµÄÒ»¸öÒıÀ×·û£¬ÔÚÈı¸öÀ×µçÖ®ËşÖ®¼äÊ¹ÓÃÒıÀ×·û¿ÉÒÔÒı¶¯ÌìÉÏµÄÀ×µç£¡")
        --	Msg2Player("ÄãµÃµ½ÁËÒ»¸öÒıÀ×·û")
        --end
    end

end;
