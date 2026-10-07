Task_xianmo_renwu = 1297
Task_xianmo_npc = 1298
Task_xianmo_npcIndex = 1299
Task_xianmo_npcID = 1300

mapname = {
    [47] = "Khæn Tiªn tÇng 1",
    [48] = "Khæn Tiªn tÇng 2",
    [49] = "Khæn Tiªn tÇng 3",
    [50] = "Khæn Tiªn tÇng 4",
    [51] = "Khæn Tiªn tÇng 5",
}
function main()
    local pm, x, y = GetWorldPos()
    local mapid = GetTaskByte(Task_xianmo_renwu, 3)
    if (mapid < 47) or (mapid > 51) then
        ClearItem(6, 1, 413, 0)
        Msg2Player("§©y lµ ®¹o vô phi ph¸p, bÞ hÖ thèng tÞch thu!")
        return 0
    end
    if (pm ~= mapid) then
        Talk(1, "no", "N¬i ®©y kh«ng thÓ Tô Hån §o¹t Ph¸ch, xin t×m khu vùc kh¸c!" .. mapname[mapid] .. "thi triÓn Gi¸ng Ma Kim T¸n, ®îi khi Ma ph¸ch tô hîp ®Çy ®ñ míi dïng b¶o ch©u nµy dÉn ®é chóng vÒ trêi!")
        return
    end

    local taskStatus = GetTaskByte(Task_xianmo_renwu, 4)
    if (taskStatus <= 2) then
        Talk(1, "no", "B¹n ch­a thi triÓn Gi¸ng Ma Kim T¸n, ®îi sau khi tô hîp ®ñ c¸c hån ph¸ch, sö dông b¶o ch©u nµy ®Ó dÉn ®é c¸c Ma ph¸ch vÒ trêi!")
        return
    elseif (taskStatus <= 4) then
        Talk(1, "no", "Gi¸ng Ma chó cña b¹n ch­a hµng phôc ®ñ hån ph¸ch, ®îi sau khi tô hîp ®ñ vµ biÕn thµnh Ma ph¸ch míi cã thÓ dÉn chóng vÒ trêi!")
        return
    elseif (taskStatus >= 7) then
        Talk(1, "no", "HiÖn ®ang sö dông b¶o ch©u nµy, kh«ng thÓ tiÕp tô sö dông!")
        return
    elseif (HaveIBBuff(494) == 0) then
        Talk(1, "no", "Toµn bé Ma ph¸ch ®· tan thµnh tro bôi, Ngù Ph¸ch ch©u ®· v« dông!")
        return
    else
        if (HaveNormalItemInQuick(6, 1, 413, 0) > 0) then
            SetTaskByte(Task_xianmo_renwu, 4, taskStatus + 2)
            DelNormalItemInQuick(6, 1, 413, 0)
            TaskNote(91, 2)
            Msg2Player("B¹n ®· sö dông Ngù Ph¸ch ch©u, tr­íc khi c¸c Ma ph¸ch nµy tan thµnh tro bôi, h·y mau dÉn chóng vÒ chç §¹i phu tÇng nµy!")
        elseif (HaveNormalItem(6, 1, 413, 0) > 0) then
            SetTaskByte(Task_xianmo_renwu, 4, taskStatus + 2)
            DelNormalItem(6, 1, 413, 0)
            TaskNote(91, 2)
            Msg2Player("B¹n ®· sö dông Ngù Ph¸ch ch©u, tr­íc khi c¸c Ma ph¸ch nµy tan thµnh tro bôi, h·y mau dÉn chóng vÒ chç §¹i phu tÇng nµy!")
        end
    end
end

function no()
    CloseDialog()
end
