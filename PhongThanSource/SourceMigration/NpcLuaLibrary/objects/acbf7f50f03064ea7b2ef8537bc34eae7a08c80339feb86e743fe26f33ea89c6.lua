star_dream2 = 1607

function no()
    CloseDialog()
end;

function OnDeath(npcindex)
    local NO = GetNpcTask(npcindex, 1)
    local PID = GetNpcTask(npcindex, 2)

    local _, x, y = GetNpcWorldPos(npcindex)

    if (PID == GetPlayerID()) then

        if (HaveIBBuff(660) == 0) then
            Msg2Player("Ph¸p lùc ®· biÕn mÊt, vÒ t×m TriÒu Ca Tinh Quan.")
            DelNpc(npcindex)
            return
        end

        if (NO < 4) then
            ScrollMessage("B¹n ®· tiªu diÖt (lÇn thø) " .. NO .. ".")
            NO = NO + 1
            local NpcNo = 990
            local NpcLevel = 40
            local msg = "Vâ Quy ®Çu lÜnh ch­a xuÊt hiÖn, h·y tiÕp tôc cè g¾ng!"
            if (NO == 4) then
                msg = "Vâ Quy ®Çu lÜnh xuÊt hiÖn, c¬ héi tr¶ thï ®· ®Õn."
                NpcNo = 991
                NpcLevel = 45
            end
            local idx = AddNpc(NpcNo, NpcLevel, SubWorld, x * 32, y * 32)
            if (idx ~= 0) then
                Msg2Player(msg)
                ScrollMessage(msg)
                SetNpcTask(idx, 1, NO)
                SetNpcTask(idx, 2, PID)
                local mtimes = 600
                if (mtimes > GetIBBuffLeftTimes(660)) then
                    mtimes = GetIBBuffLeftTimes(660)
                end
                SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", mtimes)
                SetTask(star_dream2, idx)
            else
                ScrollMessage("Thªm NPC thÊt b¹i")
            end

        elseif (NO == 4) then
            if (HaveItemInAllRoom(4, 246, 0, 1, 0, 0, 0) == 0) then
                ScrollMessage("B¹n ®· thu phôc Vâ Quy ®Çu lÜnh, cã thÓ vÒ b¸o c«ng råi!")
                ClearItem(4, 246, 0, 1)
                AddNormalItem(4, 246, 0, 1, 0, 0)
                Msg2Player("NhËn thµnh c«ng m¶nh vôn Quan Tinh gi¶n, cã thÓ vÒ phôc mÖnh.")
                TaskNote(1051, 7)
            else
                ScrollMessage("§· nhËn ®­îc m¶nh vôn Quan Tinh gi¶n, mau vÒ phôc mÖnh")
            end
        end
    else
        local pidx = SearchPlayerById(PID)
        if (pidx ~= 0) then

            local tempidx = PlayerIndex
            PlayerIndex = pidx
            Msg2Player("¶o C¶nh Vâ Quy vµ Vâ Quy ®Çu lÜnh b¹n t×m ®­îc ®Òu ®· biÕn mÊt, nh­ng b¹n vÉn cã thÓ gi¸o huÊn Vâ Quy ®Ó t×m l¹i!")
            TaskNote(1051, 5)

            PlayerIndex = tempidx
        end
    end
    DelNpc(npcindex)
end
