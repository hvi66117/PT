function OnTimer(npcidx)
    local Con = GetNpcTask(npcidx, 1)
    local Life = GetNpcLife(npcidx)
    if (Con >= 20) then
        local temp = GetNpcTask(npcidx, 3)
        DelNpc(npcidx)
        RevivalNpc(temp)
        return
    end

    local npclife = GetNpcTask(npcidx, 2)
    if (Life >= npclife and (Life > 0 or npclife > 0)) then
        local temp = GetNpcTask(npcidx, 3)
        DelNpc(npcidx)
        RevivalNpc(temp)
        return
    end

    if (Con < 20 and Life < npclife) then
        Con = Con + 1
        SetNpcTask(npcidx, 2, Life)
        SetNpcTask(npcidx, 1, Con)
        SetNpcTimer(npcidx, "\\script\\ontimer\\Õ½¶·ÃÜÌ½×Ô¼ì.lua", 60)
    end
end;
