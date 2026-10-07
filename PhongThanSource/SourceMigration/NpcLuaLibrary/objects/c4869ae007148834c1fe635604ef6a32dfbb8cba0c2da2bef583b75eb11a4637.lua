function OnDeath(npcidx)
    local w, x, y = GetWorldPos()
    local newnpcidx = AddNpc(542, 100, SubWorld, x * 32, y * 32)
    for i = 131, 140 do
        if GetGlobalValue(i) == npcidx then
            SetGlobalValue(i, newnpcidx)
        end
    end

    DelNpc(npcidx)
end;

