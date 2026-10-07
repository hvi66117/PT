--description: ≤ª“Â∫Ó-Ω®≥«µ¿æﬂ≥ˆ¥¶
--author: yichuan
--date:2004/8/2

function OnDeath(npcidx)
    SetGlobalValue(112, -1)
    DelNpc(npcidx)

    local prop = {
        { 45, "<<M∂nh s∏ch ch≠ h«u>>", { 8, 193, 5, 0 } },
        { 25, "<<S∏ch ch≠ h«u (khÎi)>>", { 3, 58, 0, 0 } },
        { 25, "<<S∏ch ch≠ h«u (thıa)>>", { 3, 59, 0, 0 } },
        { 5, "<<S∏ch ch≠ h«u (chuy”n)>>", { 3, 60, 0, 0 } },
        { 0, "<<S∏ch ch≠ h«u (hÓp)>>", { 3, 61, 0, 0 } }
    }
    local r = random(1, 100)
    for i = 1, getn(prop) do
        r = r - prop[i][1]
        if (r <= 0) then
            local itemid = prop[i][3]
            AddNormalItem(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0)
            if (i == 1) then
                AddGlobalCountNews("Anh hÔng c∏i th’ <c=g>" .. GetName() .. "<c> mÈt chi™u l y Æ«u B t Ngh‹a H«u, nhÀn Æ≠Óc <c=g>" .. prop[i][2] .. "<c>.", 20)
                if (GetTeam() ~= 0) then
                    local oldPlayer = PlayerIndex
                    local membercount = GetTeamSize()

                    -- modified by yaoxin for ≤ª“Â∫ÓµÙ¬‰Ã· æbug 2011-7 begin
                    for j = 1, membercount do
                        PlayerIndex = GetTeamMember(j)
                        if (PlayerIndex ~= oldPlayer) and (random(1, 100) <= 25) then
                            local itemid1 = prop[j][3]
                            AddNormalItem(itemid1[1], itemid1[2], itemid1[3], itemid1[4], 0, 0)
                            Msg2Player("Bπn may mæn nhÀn Æ≠Óc <c=g>" .. prop[j][2] .. "<color>")
                        end
                    end
                    -- modified by yaoxin for ≤ª“Â∫ÓµÙ¬‰Ã· æbug 2011-7 end
                    PlayerIndex = oldPlayer
                end
            else
                AddGlobalCountNews("Anh hÔng c∏i th’ <c=g>" .. GetName() .. "<c> mÈt chi™u l y Æ«u cÒa B t Ngh‹a H«u, nhÀn Æ≠Óc <c=g>" .. prop[i][2] .. "<c>.", 20)
            end
            return
        end
    end
end;
