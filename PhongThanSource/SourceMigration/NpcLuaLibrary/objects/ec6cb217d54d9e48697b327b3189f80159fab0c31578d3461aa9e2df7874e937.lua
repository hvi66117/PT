BanQuan = 1498

Curr_HeroNPC_idx = 1499
Curr_HeroNPC_ID = 1500

function OnDeath(npcindex)
    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then
            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local str = GetName()
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("Dòng Gi¶ Trung Hån cña b¹n ®· bÞ " .. str .. " ®¸nh b¹i!")
                PlayerIndex = tempidx
            end
        else
            TopMessage("Siªu ®é thµnh c«ng 1 <c=g>Dòng Gi¶ Trung Hån <c>")
            Msg2Player("1 Dòng Gi¶ Trung Hån ®· hãa thµnh lµn khãi, tiªu diªu t¸n biÕn vµo kh«ng trung!")
            AddIBBuff(751)
            SetTask(Curr_HeroNPC_idx, 0)
            SetTask(Curr_HeroNPC_ID, 0)
            SetTaskBit(BanQuan, 8 + GetNpcTask(npcindex, 2), 1)

            local num = GetTaskByte(BanQuan, 4)
            num = num + 1
            if num < 5 then
                SetTaskByte(BanQuan, 4, num)
                TaskNote(1086, 1, num)
            else
                TaskNote(1086, 2)
            end
        end
    end
    DelNpc(npcindex)
end;
