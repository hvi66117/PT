function OnTimer(npcidx)
    local Con = GetNpcTask(npcidx, 1)
    local Life = GetNpcLife(npcidx)--当前血量
    if (Con >= 20) then
        local temp = GetNpcTask(npcidx, 3) --复活对话npc 
        DelNpc(npcidx)
        RevivalNpc(temp)
        return
    end

    local npclife = GetNpcTask(npcidx, 2)--记录血量
    if (Life >= npclife and (Life > 0 or npclife > 0)) then
        local temp = GetNpcTask(npcidx, 3) --复活对话npc 
        DelNpc(npcidx)
        RevivalNpc(temp)
        return
    end

    if (Con < 20 and Life < npclife) then
        Con = Con + 1
        SetNpcTask(npcidx, 2, Life)
        SetNpcTask(npcidx, 1, Con)
        SetNpcTimer(npcidx, "\\script\\ontimer\\战斗密探自检.lua", 60)--删除临时NPC
    end
end;