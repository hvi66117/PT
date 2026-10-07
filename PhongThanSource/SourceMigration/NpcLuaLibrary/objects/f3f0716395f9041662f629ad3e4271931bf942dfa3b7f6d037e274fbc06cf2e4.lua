TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_NPCID = 1517
TASK_CRLH_G_COUNT = 241
TASK_CRLH_G_TOTAL = 242
TASK_NOTEID = 1091

function OnDeath(npcindex)


    local t_npcidx = GetNpcTask(npcindex, 2)
    local t_npcid = GetNpcTask(npcindex, 3)

    if (GetNpcID(t_npcidx) ~= t_npcid) then
        return

    end

    local num = GetNpcTask(t_npcidx, 8)
    num = num + 1

    SetNpcTask(t_npcidx, 8, num)

    local pid = GetNpcTask(npcindex, 1)

    if (GetPlayerID() == pid) then
        local killnum = GetTaskByte(TASK_CRLH_GROW, 3)

        killnum = killnum + 1

        if (killnum >= 7) then

            if (t_npcid == GetNpcID(t_npcidx)) then
                SetTaskByte(TASK_CRLH, 2, 3)
                DelNpc(GetTask(TASK_CRLH_ROUSHEN_IDX))

                local loca_x = GetTaskWord(TASK_CRLH_LOCATION, 1)
                local loca_y = GetTaskWord(TASK_CRLH_LOCATION, 2)

                local newnpcidx = AddNpc(1210, 85, SubWorld, loca_x * 32, loca_y * 32)
                SetNpcScript(newnpcidx, "\\script\\π÷ŒÔ\\æ¯Ï«»˝ªÍ∆ﬂ∆«.lua")
                SetTask(TASK_CRLH_ROUSHEN_IDX, newnpcidx)
                SetTask(TASK_CRLH_NPCID, GetNpcID(newnpcidx))
                SetNpcTask(newnpcidx, 1, GetPlayerID())
                SetNpcTask(newnpcidx, 2, 0)
                SetNpcTask(newnpcidx, 3, PlayerIndex)
                SetNpcTask(newnpcidx, 10, GetNpcID(newnpcidx))
                SetNpcTimer(newnpcidx, "\\script\\ontimer\\æ¯Ï«œ˚ ß.lua", 180)
                TaskNote(TASK_NOTEID, 9)

                Msg2Player("ß∑ thu thÀp ÆÒ hÂn ph∏ch.")
                TopMessage("HÂn Tuy÷t Di÷p xu t hi÷n")
                SetTaskByte(TASK_CRLH_GROW, 3, killnum)

            else
                Msg2Player("Tuy÷t Di÷p Æ∑ tˆ vong, nhi÷m vÙ th t bπi.")

            end

        else
            SetTaskByte(TASK_CRLH_GROW, 3, killnum)
            Msg2Player("ß∑ thµnh c´ng thu thÀp " .. killnum .. " ph∏ch.")


        end

    end

    if (num == 10) then
        local pid = GetNpcTask(t_npcidx, 1)
        local pidx = GetNpcTask(t_npcidx, 3)

        local tmp_pidx = PlayerIndex
        PlayerIndex = pidx

        if (GetPlayerID() == pid) then
            if (GetTaskByte(TASK_CRLH_GROW, 3) < 7) then
                Msg2Player("Nhi÷m vÙ th t bπi, ch≠a ti™u di÷t ÆÒ sË qu∏i vÀt!")
                SetTaskByte(TASK_CRLH, 2, 10)
                TaskNote(TASK_NOTEID, 11)
                DelNpc(t_npcidx)

            end

        end

        PlayerIndex = tmp_pidx

    end

    DelNpc(npcindex)
end
