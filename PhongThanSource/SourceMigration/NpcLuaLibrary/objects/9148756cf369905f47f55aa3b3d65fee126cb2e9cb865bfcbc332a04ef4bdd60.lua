--description:ÎòÕæÈË
--author: Zhaoqingsong
--date:2009-5-27

-- 50¼¶¶È½ÙÈÎÎñ À×öªÆğÀı

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0Î´½ÓÈÎÎñ£¬1»ñµÃµÀ¾ß£¬2Ê¹ÓÃµÀ¾ß£¬
--					3ÁìÈ¡ÈÎÎñ£¬4ÈÎÎñÊ§°Ü£¬10ÈÎÎñ½áÊø
-- 2 Byte ÈÎÎñÀàĞÍ£¬1 À×ÃÅ£¬2 Óê»§
Task_Thunder_Status = 1469
Task_Thunder_Time = 1470

Global_Thunder = 210    --1Byte À×ÃÅ£¬2Byte Óê»§
Buff_Thunder_A = 689
Buff_Thunder_B = 688
Task_Info_Thunder = 1079    -- F11

Tower_Camp = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177, camp = 9, flagid = 890 },
    { desc = "Ma ph¸i", name = "", gtask = 178, camp = 10, flagid = 889 },
}

--Modified By Guoqun for Bug£ºfsb00032224 at 2010-12-22 Begin
Thunder_Boss = {
    { desc = "Tr¸i trªn", name = "L«i M«n [214,217]", x = 1714, y = 3475, x2 = 1718, y2 = 3472, small = 1054 },
    { desc = "Ph¶i d­íi", name = "Vò Hé [238,226]", x = 1904, y = 3615, x2 = 1899, y2 = 3611, small = 1055 },
}
--Modified By Guoqun for Bug£ºfsb00032224 at 2010-12-22 End

--AS GaoJingwei 2009/08/02
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local tasks = {
        { "L«i §×nh Khëi LiÖt", "processThunder"; show = 0 },
    }
    if (isViewThunder() == 1) then
        tasks[1].show = 1
    end
    SayTask(" Gi¸c ngé, lµ b­íc ®Çu ®Ó tu ®¹o. Khi cÊp Tiªn Ma ®¹t 50 vµ danh väng ®¹t 45000 ®iÓm, anh hïng sÏ cã c¬ héi ®Õn BÊt Chu S¬n khiªu chiÕn <c=g>ThiÕt Cèt<c> ®Ó ®o¹t thiªn h¹ kú th­ <c>“V©n Trung Tông“<c>, s¸ch nµy rÊt cã İch cho viÖc tu ®¹o!", tasks)
end

function no()
    CloseDialog()
end

function isViewThunder()
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    if (taskStatus >= 1 and taskStatus < 10) then
        return 1
    else
        return 0
    end
end

function processThunder()
    local H, M, S = GetHMS()
    if (H < 18) then
        Talk(1, "no", "Thao t¸c cña ng­¬i chËm qu¸, l·o phu kh«ng ®îi ng­¬i n÷a.")
        return
    end
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    if (taskStatus == 1 or taskStatus == 2) then
        local existTicket = IsExistItem(6, 1, 520, 1)
        local haveTicket = HaveNormalItem(6, 1, 520, 1)
        if (existTicket == 1 and haveTicket == 0) then
            Talk(1, "no", "Ta cÇn cuèn kú th­ tªn lµ <V©n Trung Tông>.")
            return
        end
        MsgBox(" Muèn th«ng qua Thiªn KiÕp, cÇn chó nhËp [L«i §×nh Khëi LiÖt], nh­ng cÇn ph¶i cã <c=g>“V©n Trung Tông“<c> míi ®­îc. Ngoµi ra cßn ph¶i cã linh lùc nhËn ®­îc tõ 3 tßa K×nh Thiªn th¸p, vµ 500 v¹n b¹c tÕ thiªn ®Şa, nghi thøc míi cã thÓ tiÕn hµnh.", "acceptThunder", "no")
    elseif (taskStatus == 3) then
        local bossPos = GetTaskByte(Task_Thunder_Status, 2)
        local posName = Thunder_Boss[bossPos].name
        Talk(1, "no", "ThÊt Nguyªn Tinh qu©n ®ang ë" .. posName .. " §îi ng­¬i, ®õng sî kh¶o nghiÖm gian khæ, ®©y lµ con ®­êng mµ ng­íi ph¶i tr¶i qua.")
    elseif (taskStatus == 4) then
        MsgBox("NhiÖm vô cña ng­¬i thÊt b¹i råi, muèn thùc hiÖn l¹i cÇn n¹p 500 v¹n l­îng, ng­¬i ®ång ı kh«ng?", "acceptThunder", "no")
    end
end

-- ÁìÈ¡ÈÎÎñ
function acceptThunder()
    CloseDialog()
    local H, M, S = GetHMS()
    if (H < 18) then
        Talk(1, "no", "Thao t¸c cña ng­¬i chËm qu¸, l·o phu kh«ng ®îi ng­¬i n÷a.")
        return
    end
    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    if (abs(credit) < 45000) then
        Talk(1, "no", "Danh väng cña ng­¬i lµ" .. abs(credit) .. ",  muèn ®é kiÕp, ®¹t ®Õn <c=r>45000<c> råi h·y ®Õn.")
        return
    end
    local controlTower = GetGlobalValue(Tower_Camp[gdCamp].gtask)
    if (controlTower < 3) then
        Talk(1, "no", "khi phe ng­¬i khèng chÕ hÕt toµn bé 3 tßa Kinh Thiªn Th¸p míi cã thÓ nhËn nhiÖm vô nµy, hiÖn t¹i phe ng­¬i chØ khèng chÕ ®­îc <c=g>" .. controlTower .. "<c>.")
        return
    end
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    if (taskStatus == 1 or taskStatus == 2 or taskStatus == 4) then
        local existTicket = IsExistItem(6, 1, 520, 1)
        local haveTicket = HaveNormalItem(6, 1, 520, 1)
        if (existTicket == 1 and haveTicket == 0) then
            Talk(1, "no", "Ta cÇn cuèn kú th­ tªn lµ <V©n Trung Tông>.")
            return
        end
        if (GetCash() < 500 * 10000) then
            Talk(1, "no", "NhËn nhiÖm vô nµy cÇn <c=r>500 v¹n<c> l­îng, tiÒn cña ng­¬i kh«ng ®ñ, chuÈn bŞ ®ñ h·y ®Õn ®©y!")
            return
        end
        local controlThunder = GetGlobalValue(Global_Thunder)
        local controlLeft = GetByte(controlThunder, 1)
        local controlRight = GetByte(controlThunder, 2)
        if (controlLeft == 1 and controlRight == 1) then
            Talk(1, "no", "Ngoµi thiªn m«n cã linh lùc chÊn ®éng biÓu hiÖn ®ang cã chŞu nhËn kh¶o nghiÖm cña Tinh qu©n, ng­¬i h·y quay l¹i sau!")
            return
        end
        if (GetBoxSize(0, 2) <= 0) then
            Talk(1, "no", "Chç ta cã 20 h¹t V« ¦¬ng §Ëu, nh­ng hµnh trang cña ng­¬i ®· ®Çy, h·y ®Ó trèng 1 vŞ trİ råi h·y ®Õn nhËn.")
            return
        end
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "HiÖn giê tr¹ng th¸i cña ng­¬i qu¸ nhiÒu, h·y hñy bá mét sè tr¹ng th¸i míi cã thÓ nhËn nhiÖm vô!")
            return
        end

        local pos = random(1, 2)
        if (pos == 1 and controlLeft == 1) then
            pos = 2
        elseif (pos == 2 and controlRight == 1) then
            pos = 1
        end
        SetGlobalValue(Global_Thunder, SetByte(controlThunder, pos, 1))
        ClearItem(6, 1, 520, 1)
        ClearItem(6, 1, 521, 1)
        Pay(500 * 10000)
        local bossIdx = AddNpc(1052, 50, SubWorld, Thunder_Boss[pos].x2 * 32, Thunder_Boss[pos].y2 * 32) --¼ÓBoss
        if (bossIdx ~= 0) then
            SetNpcName(bossIdx, "<c=g>ThÊt nguyªn Tinh qu©n<c>")
            SetNpcTimer(bossIdx, "\\script\\ontimer\\ÆßÔªĞÇ¾ı.lua", 5)
            SetAIScript(bossIdx, "\\script\\ai\\ÆßÔªĞÇ¾ı.lua")
            SetNpcTask(bossIdx, 1, pos)
            SetNpcTask(bossIdx, 2, 0)
            SetNpcTask(bossIdx, 3, GetPlayerID())
            local localTime = LocalSystemTime()
            SetNpcTask(bossIdx, 4, localTime)
        end ;
        SetTaskByte(Task_Thunder_Status, 1, 3)
        SetTaskByte(Task_Thunder_Status, 2, pos)
        SetTaskByte(Task_Thunder_Status, 3, 0)
        SetTask(Task_Thunder_Time, 0)
        TaskNote(Task_Info_Thunder, 2, Thunder_Boss[pos].desc, Thunder_Boss[pos].name)
        for i = 1, 20 do
            AddNormalItemPile(6, 1, 521, 1, 0, 0)
        end
        AddIBBuff(Buff_Thunder_A, 20 * 60)
        WriteLog("NhËn <L«i §×nh Khëi LiÖt> ®é kiÕp cÊp 50")
        Msg2Player("§· nhËn nhiÖm vô [L«i §×nh Khëi LiÖt].")
        Talk(3, "no", "Muèn häc tËp l«i ph¸p, cÇn tiÕp nhËn thi luyÖn cña [ThÊt Nguyªn Tinh qu©n], Tinh qu©n lµ thÇn tiªn trªn trêi, ph¸p lùc v« biªn, phµm nh©n chí hy väng chiÕn th¾ng.", "Ta tÆng ng­¬i 20 h¹t [V« ­¬ng ®Ëu], sö dông vËt phÈm nµy cã thÓ x¶ ®Ëu thµnh binh. Tinh qu©n chØ tÊn c«ng nh÷ng binh lİnh do ®Ëu hãa thµnh, nh­ng binh tèt cã h¹n, cïng víi mçi c¸ch 22 gi©y míi cã thÓ hãa 1 ®ît, cÇn sö dông cÈn thËn.", "T¹i BÊt Chu S¬n cã 2 tßa Thiªn M«n, 1 lµ <c=g>L«i m«n<c>, 1 lµ <c=g>Vò hé<c>, ThÊt Nguyªn Tinh qu©n xuÊt hiÖn t¹i <c=g>" .. Thunder_Boss[pos].name .. "<c>, chİnh t¹i trung bé cña b¶n ®å <c=g>" .. Thunder_Boss[pos].desc .. "<c>. Ng­¬i h·y nhanh chèng t×m ®Õn ®ã, chØ cÇn khiÕn sinh lùc cña «ng h¹ d­íi 50% lµ xem nh­ th«ng qua kh¶o nghiÖm.")
    end
end
