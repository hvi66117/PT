--> ºÆÈ»ÕıÆø Add By yangtao Start 2009/10/29
Family_hrzq = 20    -- 1byte:ÈÎÎñÊ±¼ä´Á
-- 2byte:Êı×éattack_kindÖĞµÄË÷Òı¼õ1
Task_hrzq = 1610    -- 1byte:ÈÎÎñ½ø¶È 0ÎªÎ´½ÓÈÎÎñ 1ÎªÒÑ¾­ÁìÈ¡ÈÎÎñ 2ÎªÒÑ¾­Íê³ÉÈÎÎñ 3ÎªÒÑ¾­ÁìÈ¡½±Àø
-- 2byte:ÈÎÎñ¹ÖÔÚÊı×éattack_kindÖĞµÄË÷Òı
-- 3byte:ÒÑ¾­É±ËÀµÄ¹ÖÎïÊıÁ¿
Task_hrzq_ylt = 1611    -- è¬çóÊ±¼ä¼ÇÂ¼
Task_hrzq_yl = 1612    -- 1byre:Ê±¼ä´Á
-- 2byre:Ê¹ÓÃ´ÎÊı
Task_ibyq = 1613    -- ¼ÍÂ¼IBµÀ¾ß¹ºÂòµÄÔªÆøÖµ£¬²»ÄÜÖØÖÃ
Task_yq = 1614    -- 1byte:ÔªÆøÖµÊ±¼ä´Á
-- 2byte:Íæ¼Òµ±ÌìÒÑ¾­Ê¹ÓÃµÄÔªÆøÖµ
-- 3byte:ÏµÍ³Ã¿ÌìÖØÖÃµÄÔªÆøÖµ
--< ºÆÈ»ÕıÆø Add By yangtao End 2009/10/29

attack_kind = {
    [1] = { num = 80, name = "DŞ Vùc CÈu Mang", id = 1454 },
    [2] = { num = 100, name = "N÷ Xó", id = 1395 },
}

function OnDeath(npcidx)
    --DelNpc(npcidx)

    local progress = GetTaskByte(Task_hrzq, 1)
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (progress == 1) then
                local kindindex = GetTaskByte(Task_hrzq, 2)
                local nums = attack_kind[kindindex].num
                if ((HaveIBBuff(1093) > 0) and (attack_kind[kindindex].id == 1454)) then
                    local deathnums = GetTaskByte(Task_hrzq, 3)

                    if (deathnums < nums) then
                        deathnums = deathnums + 1
                        SetTaskByte(Task_hrzq, 3, deathnums)
                        if (deathnums == nums) then
                            ScrollMessage("H¹o Nhiªn Chİnh Khİ: <c=g>NhiÖm vô hoµn thµnh<c>")
                            SetTaskByte(Task_hrzq, 1, 2)
                            TaskNote(1502, 1)
                        else
                            ScrollMessage("H¹o Nhiªn Chİnh Khİ: Cßn ph¶i tiªu diÖt " .. (nums - deathnums) .. ".")
                            TaskNote(1502, 0, deathnums, nums, attack_kind[kindindex].name)
                        end
                    end
                end
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        if (progress == 1) then
            local kindindex = GetTaskByte(Task_hrzq, 2)
            local nums = attack_kind[kindindex].num
            if ((HaveIBBuff(1093) > 0) and (attack_kind[kindindex].id == 1454)) then
                local deathnums = GetTaskByte(Task_hrzq, 3)

                if (deathnums < nums) then
                    deathnums = deathnums + 1
                    SetTaskByte(Task_hrzq, 3, deathnums)
                    if (deathnums == nums) then
                        ScrollMessage("H¹o Nhiªn Chİnh Khİ: <c=g>NhiÖm vô hoµn thµnh<c>")
                        SetTaskByte(Task_hrzq, 1, 2)
                        TaskNote(1502, 1)
                    else
                        ScrollMessage("H¹o Nhiªn Chİnh Khİ: Cßn ph¶i tiªu diÖt " .. (nums - deathnums) .. ".")
                        TaskNote(1502, 0, deathnums, nums, attack_kind[kindindex].name)
                    end
                end
            end
        end
    end ;

    if (progress == 1) then
        if (IsHaveSpaceForTreasure(1) > 0) then
            -- »ñµÃÇé±¨µÀ¾ß
            local possibility = random(1, 1000)
            local level = GetExploitLevel()
            if (((level >= 4) and (possibility <= 15)) or (possibility <= 5)) then
                AddNormalItemPile(3, 1057, 0, 0, 0, 0)
            end
        end
    end
end;
