--description:item
--author: huyuzhang
--date:2009/7/30

TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_G_COUNT = 241
TASK_NOTEID = 1091

function OnDeath(npcindex)

    local t_pid = GetNpcTask(npcindex, 1)

    if (GetPlayerID() == t_pid) then
        SetTaskByte(TASK_CRLH, 2, 10)        --»ŒŒÒ ß∞‹
        Msg2Player(" th©n th” Æ∑ bﬁ ph∏ hÒy, nhi÷m vÙ th t bπi.")
        TaskNote(TASK_NOTEID, 11)

    else
        local t_pidx = GetNpcTask(npcindex, 3)

        local old_pidx = PlayerIndex
        PlayerIndex = t_pidx

        if (GetPlayerID() == t_pid) then
            --ÕÊº“‘⁄œﬂ
            SetTaskByte(TASK_CRLH, 2, 10)    --»ŒŒÒ ß∞‹
            Msg2Player(" th©n th” Æ∑ bﬁ ph∏ hÒy, nhi÷m vÙ th t bπi.")
            TaskNote(TASK_NOTEID, 11)

        end

        PlayerIndex = old_pidx

    end

    DelNpc(npcindex)
end