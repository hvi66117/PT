--description: ÁúÂí£¨Ë®£©
--author: liuzhiqiang
--date: 2009/04/15

--ºÓÍ¼»Ã¾³
Task_hetu = 1387 -- 1byte: 1:ÒÑ½ÓºÓÍ¼ÈÎÎñ; 2£ºÒÑÍê³ÉÁéÊ¯12µÄÈÎÎñ 3:ÒÑÍê³ÉÁéÊ¯34µÄÈÎÎñ 4£ºÒÑÍê³ÉÁéÊ¯67µÄÈÎÎñ 5£ºÒÑÍê³ÉÁéÊ¯89µÄÈÎÎñ 6£ºÍê³ÉºÓÍ¼»Ã¾³
-- 2byte: 1:¼ÇÂ¼½ÓÈÎÎñÊ±µÄ¶Ó³¤£»
-- 3byte: 1:ÒÑÉ±ËÀÁúÂí£¬³öÏÖ¹ıIBBuff
-- 4byte: 1:ÒÑºÍÁéÊ¯¶Ô¹ı»°£¬³öÏÖ¹ıIBBuff
Hetu_playerID = 1388
Global_longmashui = 185
Global_longmahuo = 186
Global_longmamu = 187
Global_longmajin = 188

function OnDeath(npcidx)

    local tempID = GetNpcTemplateID(npcidx)

    if (tempID == 944) then
        --que
        SetGlobalValue(Global_longmashui, 0) -- ÁúÂí£¨Ë®£©´æÔÚÈ«¾Ö±äÁ¿
    elseif (tempID == 945) then
        --que
        SetGlobalValue(Global_longmahuo, 0) -- ÁúÂí£¨»ğ£©´æÔÚÈ«¾Ö±äÁ¿
    elseif (tempID == 943) then
        --que
        SetGlobalValue(Global_longmamu, 0) -- ÁúÂí£¨Ä¾£©´æÔÚÈ«¾Ö±äÁ¿
    elseif (tempID == 942) then
        --que
        SetGlobalValue(Global_longmajin, 0) -- ÁúÂí£¨½ğ£©´æÔÚÈ«¾Ö±äÁ¿
    end

    --ÁúÂíÎª±ğÈËËùÉ±
    if (GetNpcTask(npcidx, 1) ~= GetPlayerID()) then

        if (GetTaskByte(Task_hetu, 3) == 1) then
            --µÚÒ»Ö»ÁúÂí±»×Ô¼ºÉ±ËÀ²¢buff¹ıºó£¬»ò±»ËûÈËÉ±ËÀ£¬ÈÎÎñ¶¼Ê§°Ü£¬ÒÑ¸øÁ½ÈËÊ§°ÜÌáÊ¾£¬¼´Ê¹µÚ¶şÖ»±»ËûÈËÉ±ËÀÒ²²»¸øÊ§°ÜÌáÊ¾ÁË
            DelNpc(npcidx)
            return
        end

        local bindPlayerID = GetNpcTask(npcidx, 1)
        local playerIdx = SearchPlayerById(bindPlayerID)
        if (playerIdx > 0) then
            local playerIndexCache = PlayerIndex
            PlayerIndex = playerIdx

            if (tempID == 944) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (thñy), cã thÓ ®Õn Linh Th¹ch (thñy) triÖu gäi l¹i.")
            elseif (tempID == 945) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (háa), cã thÓ ®Õn Linh Th¹ch (háa) triÖu gäi l¹i.")
            elseif (tempID == 942) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (kim), cã thÓ ®Õn Linh Th¹ch (kim) triÖu gäi l¹i.")
            elseif (tempID == 943) then
                Msg2Player("VÉn ch­a tËn tay hµn phôc Long M· (méc), cã thÓ ®Õn Linh Th¹ch (méc) triÖu gäi l¹i.")
            end

            if (GetTeamSize() == 2 and checkRelation() == 1) then
                local oldPlayer = PlayerIndex
                for i = 1, GetTeamSize() do
                    PlayerIndex = GetTeamMember(i)
                    SetTaskByte(Task_hetu, 3, 1)
                    TopMessage("NhiÖm vô Hµn Phôc Long M· thÊt b¹i")
                end
                PlayerIndex = oldPlayer
            else
                SetTaskByte(Task_hetu, 3, 1)
                TopMessage("VÉn ch­a Hµn Phuc Long M·")
            end
            PlayerIndex = playerIndexCache
        end
        DelNpc(npcidx)
        return
    end

    if (GetTeamSize() ~= 2 or checkRelation() ~= 1) then
        --±ØĞëÊÇ½ÓÈÎÎñÊ±µÄÁ½¸öÈË
        Talk(1, "no", "ChØ cã 1 trong 2 ng­êi cïng nhËn nhiÖm vô cã thÓ hoµn thµnh.")
        SetTaskByte(Task_hetu, 3, 1)
        DelNpc(npcidx)
        return
    end

    if (HaveIBBuff(644) > 0) then
        if (GetNpcTask(npcidx, 1) == GetPlayerID()) then

            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                RemoveIBBuff(644)

                if (GetTaskByte(Task_hetu, 1) == 1) then
                    SetTaskByte(Task_hetu, 1, 2)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>3<c>")
                        Msg2Player("§· thu phôc Long M· 1 n¬i, ch÷ sè kÕ tiÕp lµ 3, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 2, "3")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>4<c>")
                        Msg2Player("§· thu phôc Long M· 2 n¬i, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 2, "4")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 2) then
                    SetTaskByte(Task_hetu, 1, 3)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>7<c>")
                        Msg2Player("§· thu phôc Long M· 3 n¬i, ch÷ sè kÕ tiÕp lµ 7, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 4, "7")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>6<c>")
                        Msg2Player("§· thu phôc Long M· 4 n¬i, ch÷ sè kÕ tiÕp lµ 6, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 4, "6")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 3) then
                    SetTaskByte(Task_hetu, 1, 4)
                    if (GetTaskByte(Task_hetu, 2) == 1) then
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>9<c>")
                        Msg2Player("§· thu phôc Long M· 7 n¬i, ch÷ sè kÕ tiÕp lµ 9, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 6, "9")
                    else
                        TopMessage("Ch÷ sè kÕ tiÕp lµ <c=g>8<c>")
                        Msg2Player("§· thu phôc Long M· 6 n¬i, ch÷ sè kÕ tiÕp lµ 8, c¨n cø theo chØ thŞ trªn [Hµ §å], thu phôc Linh M· ®èi øng trªn Linh Th¹ch.")
                        TaskNote(1043, 1, 6, "8")
                    end
                elseif (GetTaskByte(Task_hetu, 1) == 4) then
                    SetTaskByte(Task_hetu, 1, 5)
                    TopMessage("Hoµn thµnh <c=g>Hµ §å HuyÒn C¶nh<c>")
                    Msg2Player("NhiÖm vô ®· hoµn thµnh, ®Õn<HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73, 227, 216]\"> tim ng­êi huynh ®Ö cña ng­êi h¸i thuèc.")
                    TaskNote(1043, 2)
                end

            end
            PlayerIndex = oldPlayer
        end
    else
        if (GetTaskByte(Task_hetu, 3) == 0) then

            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                AddIBBuff(644)
                SetTaskByte(Task_hetu, 3, 1)
                TopMessage("Thu phôc 1 con Long M· kh¸c")
            end
            PlayerIndex = oldPlayer
        else
            --			TopMessage("½µ·üÁúÂíÊ§°Ü")
            --			Msg2Player("Î´ÄÜÍ¬Ê±½µ·üÁúÂí£¬¿ÉÈ¥ÁéÊ¯´¦ÖØĞÂÕÙ»½¡£")
            SetTaskByte(Task_hetu, 3, 0)
        end
    end

    DelNpc(npcidx)
end;

function checkRelation()
    --ÅĞ¶Ï¶ÓÓÑÊÇ·ñÊÇ½ÓÈÎÎñÊ±¶ÓÓÑ
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID() --»ñµÃ¶ÓÓÑID
    PlayerIndex = oldPlayer
    if (GetTask(Hetu_playerID) == playerID_temp) then
        --ÅĞ¶Ï¶ÓÓÑÊÇ·ñÊÇ½ÓÈÎÎñÊ±¶ÓÓÑ
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end;
