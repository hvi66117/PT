--ÖòÒõÉñµÄËÀÍö½Å±¾

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý


function OnDeath(npcidx)
    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end

end;
