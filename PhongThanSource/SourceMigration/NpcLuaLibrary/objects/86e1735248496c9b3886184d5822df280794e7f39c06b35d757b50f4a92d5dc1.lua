NPC_TIDE = { 1795, 60 }
function OnDeath(npcIndex)
    local nMapID, nX, nY = GetNpcWorldPos(npcIndex)

    local tideidx = -1
    for i = 1, 2 do
        tideidx = AddNpc(NPC_TIDE[1], NPC_TIDE[2], SubWorld, nX * 32, nY * 32)
        if (tideidx > 0) then
            SetGuardLevel(tideidx, 2)
            SetNpcScript(tideidx, "\\script\\npcdeath\\删掉自己.lua")
            SetNpcTimer(tideidx, "\\script\\ontimer\\删掉自己.lua", 15)
        end
    end
end
