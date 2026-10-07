gMineTask = 1654

gMineNote = 1509

InstanceType = 1884

function OnDeath(npcIndex)

    if (PlayerIndex > 0) then

        if (GetTaskByte(gMineTask, 1) == 3) then
            local killMonsterCount = GetTaskByte(gMineTask, 2)
            local killMonsterCount2 = GetTaskByte(gMineTask, 3)
            if (killMonsterCount2 < 10) then
                SetTaskByte(gMineTask, 3, killMonsterCount2 + 1)
                TaskNote(gMineNote, 3, killMonsterCount, killMonsterCount2 + 1)
                if (killMonsterCount == 10) and ((killMonsterCount2 + 1) == 10) then
                    TaskNote(gMineNote, 4)
                end
            else

            end
        else

        end
    else

    end
end
