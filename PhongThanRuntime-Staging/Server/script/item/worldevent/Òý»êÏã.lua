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
        ClearItem(6, 1, 412, 0)
        Msg2Player("§©y lµ ®¹o vô phi ph¸p, bÞ hÖ thèng tÞch thu!")
        return 0
    end
    if (pm ~= mapid) then
        Talk(1, "no", "N¬i ®©y kh«ng thÓ Tô Hån §o¹t Ph¸ch, xin t×m khu vùc kh¸c!" .. mapname[mapid] .. "Th¶ ra Tô Hån Linh ph­ín, ®îi ®Õn khi Tiªn hån tËp hîp ®Çy ®ñ sÏ dïng h­¬ng nµy dÉn ®é chóng vÒ trêi!")
        return
    end

    local taskStatus = GetTaskByte(Task_xianmo_renwu, 4)
    if (taskStatus <= 2) then
        Talk(1, "no", "B¹n ch­a th¶ ra Tô Hån Linh ph­ín, ®îi ®Õn khi Tiªn hån tËp hîp ®Çy ®ñ sÏ dïng h­¬ng nµy dÉn ®é c¸c Tiªn hån vÒ trêi!")
        return
    elseif (taskStatus <= 4) then
        Talk(1, "no", "Tô Hån trËn cña b¹n ch­a tô hîp ®ñ c¸c hån ph¸ch, ®îi sau khi chóng tô hîp ®ñ vµ biÕn thµnh Tiªn hån, míi dïng h­¬ng nµy dÉn ®é c¸c Tiªn hån vÒ trêi!")
        return
    elseif (taskStatus >= 7) then
        Talk(1, "no", "B¹n ®· th¾p 1 §é Hån h­¬ng, t¹m thêi kh«ng thÓ th¾p thªm n÷a!")
        return
    elseif (HaveIBBuff(494) == 0) then
        Talk(1, "no", "C¸c Tiªn hån ®· tan thµnh tro bôi, §é Hån h­¬ng ®· v« dông!")
        return
    else
        if (HaveNormalItemInQuick(6, 1, 412, 0) > 0) then
            SetTaskByte(Task_xianmo_renwu, 4, taskStatus + 2)
            DelNormalItemInQuick(6, 1, 412, 0)
            TaskNote(90, 2)
            Msg2Player("B¹n ®· th¾p 1 §é Hån h­¬ng, tr­íc khi c¸c Tiªn hån tan thµnh tro bôi ph¶i dÉn chóng ®Õn §¹i phu tÇng nµy")
        elseif (HaveNormalItem(6, 1, 412, 0) > 0) then
            SetTaskByte(Task_xianmo_renwu, 4, taskStatus + 2)
            DelNormalItem(6, 1, 412, 0)
            TaskNote(90, 2)
            Msg2Player("B¹n ®· th¾p 1 §é Hån h­¬ng, tr­íc khi c¸c Tiªn hån tan thµnh tro bôi ph¶i dÉn chóng ®Õn §¹i phu tÇng nµy")
        end
    end
end

function no()
    CloseDialog()
end
