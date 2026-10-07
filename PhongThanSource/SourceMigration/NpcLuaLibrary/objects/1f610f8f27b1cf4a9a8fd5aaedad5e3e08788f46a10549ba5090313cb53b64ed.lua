star_dream = 1419

ice_fireIdx = 1420
ice_fireID = 1423

function no()
    CloseDialog()
end;

function OnDeath(npcindex)
    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then

            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local str = GetName()
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("B¨ng Háa Ma b¹n t×m ®­îc ®· bÞ" .. str .. " tiªu diÖt, nh­ng b¹n cã thÓ quay l¹i n¬i cò ®Ó triÖu håi l¹i.")
                PlayerIndex = tempidx
            end
        else
            if (GetTaskByte(star_dream, 1) ~= 12) then
                Talk(1, "no", GetName() .. "Sao yÕu thÕ, liÖu cã ph¶i B¨ng Háa Ma thËt kh«ng? Ta t×m thö xem.")
                Msg2Player("B¨ng Háa Ma ®· bÞ b¹n tiªu diÖt, cã thÓ quay l¹i n¬i cò ®Ó triÖu håi l¹i.")
            end
        end
    end
    DelNpc(npcindex)
end;
