--description: ¹íĞ°ÑıÈËµÄÔªÉñ
--author: liuzhiqiang
--date: 2009/05/05

---------------------ĞÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ĞÇ¹Ù´¦½ÓĞÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìıµ½ËµÃ÷ 3£ºÓë¹íĞ°ÑıÈËµÚÒ»´Î¶Ô»° 4: ĞÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑıÂ¯
--6: »Ùµô¹íĞ°ÑıÈËµÄÁé»ê 7: ĞÇ¹â÷öµ­ÈÎÎñÍê³É 8:ĞÇ¹Ù´¦½Ó³ı¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ğ¾ 10: ĞÇ¹Ù´¦¸æÖª¹íĞ°ÑıÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ğ¾Ê¹¹íĞ°ÑıÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íĞ°ÑıÈËµÄÔªÉñ 13: Íê³É³ı¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊı
-- 3byte: 1£ºÊÕ¼¯µ½º£ĞÄ²İµÄÖÖ×Ó 2: ÖÖÖ²º£ĞÄ²İ 3£ºµÃµ½Ë®Ğ¾

Global_guixie = 199

---------------------ĞÇ¹â÷öµ­-----------------

function OnDeath(npcidx)

    if (GetTeam() == 0) then
        if (GetNpcTask(npcidx, 1) ~= GetPlayerID()) then
            kill_fail(npcidx)
        end

        if ((GetNpcTask(npcidx, 1) == GetPlayerID()) or (GetTaskByte(Task_star, 1) == 10 and IsExistItem(6, 1, 513, 0) == 1) or GetTaskByte(Task_star, 1) == 11) then
            kill_success()
        end
    else
        local oldPlayer = PlayerIndex
        local kill_mark = 0
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if ((GetNpcTask(npcidx, 1) == GetPlayerID()) or (GetTaskByte(Task_star, 1) == 10 and IsExistItem(6, 1, 513, 0) == 1) or GetTaskByte(Task_star, 1) == 11) then
                if (GetNpcTask(npcidx, 1) == GetPlayerID()) then
                    kill_mark = 1
                end
                kill_success()
            end
        end
        PlayerIndex = oldPlayer

        if (kill_mark == 0) then
            kill_fail(npcidx)
        end
    end

    SetGlobalValue(Global_guixie, 0)
    DelNpc(npcidx)
end

function kill_fail(npcidx)
    local bindPlayerID = GetNpcTask(npcidx, 1)
    local playerIdx = SearchPlayerById(bindPlayerID)
    if (playerIdx > 0) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = playerIdx
        Msg2Player("Ch­a thÓ tËn tay tiªu diÖt nguyªn thÇn Quû Tµ Yªu Nh©n, h·y mau ®i t×m Tinh Quan nghÜ c¸ch khiÕn nguyªn thÇn h¾n hiÖn th©n lÇn n÷a.")
        TopMessage("NhiÖm vô Trõ ¸c Vô TËn thÊt b¹i") --que
        PlayerIndex = playerIndexCache
    end
end

function kill_success()
    SetTaskByte(Task_star, 1, 12)
    TaskNote(1060, 3)
    Msg2Player("Nguyªn thÇn Quû Tµ Yªu Nh©n ®· bŞ tiªu diÖt, cã thÓ vÒ phôc mÖnh råi.")
    TopMessage("§· ®¸nh b¹i <c=g>Nguyªn ThÇn cña QuØ tµ yªu nh©n<c>")
end


