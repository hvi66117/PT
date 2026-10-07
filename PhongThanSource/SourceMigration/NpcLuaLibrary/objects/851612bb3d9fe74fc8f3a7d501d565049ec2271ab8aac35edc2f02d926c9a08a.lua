function main(skillLevel, mapX, mapY)

    if (PlayerIndex == nil or PlayerIndex <= 0) then
        return
    end
    local m, x, y = GetWorldPos()

    local NpcIdx = AddTotemNpc(2261, skillLevel, SubWorld, mapX, mapY)

    if NpcIdx ~= nil and NpcIdx > 0 then

        SetAIScript(NpcIdx, "\\script\\ai\\»ðÍ¼ÌÚ½ü³Ì.lua")
        SetNpcName(NpcIdx, "<color=yellow>VËt tè PhÇn Háa<color>")
    end
end
