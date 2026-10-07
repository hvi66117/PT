require("¹ú¼ÒÈËÆø.luax")

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx, 1)

    SetGlobalValue(112, -1)
    local prop = {
        { 45, "<<M¶nh s¸ch ch­ hÇu>>", { 8, 193, 5, 0 } },
        { 25, "<<S¸ch ch­ hÇu (khëi)>>", { 3, 58, 0, 0 } },
        { 25, "<<S¸ch ch­ hÇu (thõa)>>", { 3, 59, 0, 0 } },
        { 5, "<<S¸ch ch­ hÇu (chuyÓn)>>", { 3, 60, 0, 0 } },
        { 0, "<<S¸ch ch­ hÇu (hîp)>>", { 3, 61, 0, 0 } }
    }
    local r = math.random(1, 100)
    for i = 1, table.getn(prop) do
        r = r - prop[i][1]
        if (r <= 0) then

            local itemid = prop[i][3]
            if (i == 1) then
                AddNormalItem(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0)
                AddGlobalCountNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<c> mét chiªu lÊy ®Çu BÊt NghÜa HÇu, nhËn ®­îc <c=g>" .. prop[i][2] .. "<c>.", 20)
                if (GetTeam() ~= 0) then
                    local oldPlayer = PlayerIndex
                    local membercount = GetTeamSize()

                    for j = 1, membercount do
                        PlayerIndex = GetTeamMember(j)
                        if (PlayerIndex ~= oldPlayer) and (math.random(1, 100) <= 25) then
                            AddNormalItem(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0)
                            Msg2Player("B¹n may m¾n nhËn ®­îc <c=g>" .. prop[j][2] .. "<color>")
                        end
                    end

                    PlayerIndex = oldPlayer
                end
            else
                local nServerStartTime = GetServerStartTime()
                local oldPlayer = PlayerIndex
                local nWorldId, nX, nY = GetNpcWorldPos(npcidx)

                if (nServerStartTime < 90) or (GetGameServerName() == "ChiÕn tr­êng" and nServerStartTime < 210) then

                    if (IsTongMember() > 0 and GetCityName() ~= "") then
                        local nRand = math.random(1, 100)
                        if (nRand <= 50) then
                            local seq = GetNpcEnmityCount(npcidx)
                            if (seq > 0) then
                                for i = 1, seq do
                                    local npcIndex = GetNpcEnmityItem(npcidx, seq)
                                    PlayerIndex = NpcIdx2PIdx(npcIndex)
                                    if (PlayerIndex > 0) then
                                        local mapid, x, y = GetWorldPos()
                                        if ((nX - x) ^ 2 + (nY - y) ^ 2) <= 300 then
                                            if (IsTongMember() > 0 and GetCityName() == "") then
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                AddNormalItem(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0)
                AddGlobalCountNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<c> mét chiªu lÊy ®Çu cña BÊt NghÜa HÇu, nhËn ®­îc <c=g>" .. prop[i][2] .. "<c>.", 20)
                PlayerIndex = oldPlayer
            end
            break

        end
    end
    DelNpc(npcidx)
end;
