TASK_BANQUAN = 1502
TASK_BQ_X = 218
TASK_BQ_Y = 217
TASK_LIMIT_DIST = 100 * 100

function OnDeath(npcindex)

    if (GetTaskByte(TASK_BANQUAN, 1) == 5 and GetTaskByte(TASK_BANQUAN, 2) == 5) then
        if (GetNpcTask(npcindex, 1) == GetPlayerID()) then
            local mapgid, px, py = GetNpcWorldPos(npcindex)
            local px = math.floor(px / 8)
            local py = math.floor(py / 16)

            if (((px - 218) ^ 2 + (py - 217) ^ 2) <= 5) then
                SetTaskByte(TASK_BANQUAN, 2, 7)
                AddNormalItem(4, 264, 0, 1, 0, 0)
                TopMessage("NhËn ®­îc Minh Ph¸ch Linh Th¹ch")
                TaskNote(1088, 4)

            else
                Msg2Player("Thñ LÜnh Chu LÜnh ®· hãa thµnh mét lµm khãi biÕn mÊt. Cã thÓ t¹m thêi nghØ ng¬i råi!")

            end
        end
    end

    DelNpc(npcindex)
end
