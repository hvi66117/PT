-- yangyankun；2009-12-30；采矿宗师级任务
gMineTask = 1654    -- 1byte: 任务步骤
-- 2Byte: 杀死怪物守卫的个数
-- 3Byte: 杀死怪物冰灵的个数
-- 4Byte:
gMineNote = 1509

function OnDeath(npcIndex)

    if (PlayerIndex > 0) then
        -- 被人打死
        if (GetTaskByte(gMineTask, 1) == 3) then
            -- 如果当前任务为第三步
            local killMonsterCount = GetTaskByte(gMineTask, 2)
            local killMonsterCount2 = GetTaskByte(gMineTask, 3)
            if (killMonsterCount < 10) then
                SetTaskByte(gMineTask, 2, killMonsterCount + 1)
                TaskNote(gMineNote, 3, killMonsterCount + 1, killMonsterCount2)
                if ((killMonsterCount + 1) == 10) and (killMonsterCount2 == 10) then
                    TaskNote(gMineNote, 4)
                end
            else

            end
        else

        end
    else

    end
end