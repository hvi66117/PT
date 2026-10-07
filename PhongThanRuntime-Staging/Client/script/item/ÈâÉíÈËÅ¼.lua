TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_NPCID = 1517

TASK_CRLH_STEPONE_CALLTIME = 1521

function main()

    local w, x, y = GetWorldPos()

    if (w ~= 55) then
        Msg2Player("Ph¶i ®Õn §«ng Doanh míi cã thÓ trång.")
        return

    end

    local newnpcidx = AddNpc(1207, 80, SubWorld, (x - 1) * 32, (y + 1) * 32)
    SetNpcTimer(newnpcidx, "\\script\\ontimer\\¾øìÇÏûÊ§.lua", 600)
    SetNpcTask(newnpcidx, 1, GetPlayerID())
    SetNpcTask(newnpcidx, 3, PlayerIndex)
    SetNpcTask(newnpcidx, 10, GetNpcID(newnpcidx))
    SetTaskWord(TASK_CRLH_LOCATION, 1, x - 1)
    SetTaskWord(TASK_CRLH_LOCATION, 2, y + 1)
    SetTask(TASK_CRLH_ROUSHEN_IDX, newnpcidx)
    SetTask(TASK_CRLH_NPCID, GetNpcID(newnpcidx))
    SetTaskByte(TASK_CRLH_GROW, 1, 0)

    SetTask(TASK_CRLH_STEPONE_CALLTIME, SystemTime())

    SetTaskByte(TASK_CRLH, 2, 11)

    ClearItem(6, 1, 562, 0)

end
