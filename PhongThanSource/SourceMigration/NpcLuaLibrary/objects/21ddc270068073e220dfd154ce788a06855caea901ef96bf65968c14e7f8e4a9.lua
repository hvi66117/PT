function OnDeath(c)
    if (PlayerIndex > 0) then
        local circle1 = GetByte(GetTask(1013), 3)
        local npcTGIdx = GetTask(1017)
        if (npcTGIdx == c) then
            local logstr = ""
            if (circle1 > 1) and (circle1 <= 5) then
                logstr = "[LÇn " .. circle1 .. "]"
                local r = math.random(1, 100)
                SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
                Msg2Player("§¸nh b¹i Thiªn C­¬ng ¶nh.")

                if (r <= 12) then
                    AddNormalItemPile(3, 134, 0, 0, 0, 0)
                    TopMessage(13294)
                end

                r = math.random(1, 100)
                if (r == 21) or (r == 75) then
                    AddNormalItemPile(3, 133, 0, 0, 0, 0)
                    TopMessage(13296)
                    AddGlobalCountNews("<c=g>" .. GetName() .. "<c> ®¸nh b¹i Thiªn C­¬ng ¶nh, may m¾n nhËn ®­îc 1 <c=yel>hån<c>!", 20)
                end

                if (GetFightState() == 1) then
                    local w, x, y = GetWorldPos()
                    npcTGIdx = AddNpc(571, 60, SubWorld, x * 32, y * 32)
                    if (npcTGIdx > 0) then
                        SetTask(1017, npcTGIdx)
                        TaskNote(53, 1, circle1)
                        Msg2Player("Thiªn C­¬ng ¶nh thø" .. circle1 .. "§· xuÊt hiÖn!")
                    else
                        logstr = logstr .. "Ê§°Ü"
                    end
                end
            elseif (circle1 == 6) then
                local r = math.random(1, 100)
                SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
                Msg2Player("§¸nh b¹i Thiªn C­¬ng ¶nh.")

                if (r <= 12) then
                    AddNormalItemPile(3, 134, 0, 0, 0, 0)
                    TopMessage(13294)
                end

                r = math.random(1, 100)
                if (r == 21) or (r == 75) then
                    AddNormalItemPile(3, 133, 0, 0, 0, 0)
                    TopMessage(13296)
                    AddGlobalCountNews("<c=g>" .. GetName() .. "<c> ®¸nh b¹i Thiªn C­¬ng ¶nh, may m¾n nhËn ®­îc 1 <c=yel>hån<c>!", 20)
                end

                if (GetFightState() == 1) then
                    local w, x, y = GetWorldPos()
                    npcTGIdx = AddNpc(572, 80, SubWorld, x * 32, y * 32)
                    if (npcTGIdx > 0) then
                        SetTask(1017, npcTGIdx)

                        logstr = "[Ììî¸ÐÇ³öÏÖ]"
                        TaskNote(53, 2)
                        Msg2Player("Thiªn C­¬ng Tinh cuèi cïng ®· xuÊt hiÖn!")
                    else
                        logstr = "Ê§°Ü"
                    end
                end
            end
            WriteLog("[Ììî¸Ö®»ê][Ììî¸ÐÇÓ°×Ó]" .. logstr)
        else

            local h, m, s = GetHMS()
            local w, x, y = GetNpcWorldPos(c)
            WriteLog("[Ììî¸Ö®»ê][Ó°×Ó±»ÇÀ]Ê±¼ä: " .. h .. "/" .. m .. "/µØÍ¼ºÅ" .. w)
        end
    end
    DelNpc(c)
end;
