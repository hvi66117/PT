TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433

function OnDeath(npcindex)
    local idx = GetNpcTask(npcindex, 0)
    local npcid = GetNpcTask(npcindex, 1)

    if (npcid == GetNpcID(idx)) then
        Msg2Player("Hoµng Kim Th¹ch ThÇn bÞ b¹n tiªu diÖt, §µo Ngét ®· ch¹y tho¸t!")
        DelNpc(idx)
    end

    DelNpc(npcindex)
end
