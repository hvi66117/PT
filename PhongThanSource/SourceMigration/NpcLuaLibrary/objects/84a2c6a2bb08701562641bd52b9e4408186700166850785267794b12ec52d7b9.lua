-- yangyankun£ª2009-12-14£ª∫Æ±˘’Û_timer_add.lua

gHideNpcID = 1693    -- “˛≤ÿNPC
gDistance = 400
gIceBuff = { 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209 }

gSkillID = {
    [1] = 749, -- ±˘∑‚
    [2] = 750, -- œ¨»º±¨’®
}

gIceItem = { 3, 1070, 0, 0, 0, 0 }    -- add by yangyankun for œ¨»ºµÙ¬‰ at 10-1-4

-- À¿Õˆ¥¶¿Ì
function OnDeath(npcidx)
    --	Msg2Player(" «ƒ„…±¡ÀŒ“£°")
    local w, x, y = GetWorldPos()
    local hideNpcIndex = AddNpc(gHideNpcID, 1, SubWorld, (x + 1) * 32, (y + 1) * 32)
    if (hideNpcIndex > 0) then
        SetNpcName(hideNpcIndex, "")    -- add by yangyankun for “˛≤ÿBossµƒ√˚◊÷ at 10-1-4
        SetNpcTimer(hideNpcIndex, "\\script\\instance\\death\\±˘»º∂ÒπÌÀ¿Õˆ.lua", 1)
    end

    ThrowItem(npcidx, PlayerIndex, gIceItem[1], gIceItem[2], gIceItem[3], gIceItem[4], gIceItem[5], gIceItem[6])

    --	DelNpc(npcidx)			-- modify by yangyankun for ≤ª…æ≥˝NPC at 10-1-5
end

-- “∆≥˝±˘∂≥–ßπ˚
function Remove_Buff(npcidx)
    local cachePlayerIndex = PlayerIndex
    local idx, nextPlayerIdx = 0, 0
    while 1 do
        idx, nextPlayerIdx = GetSessionNextPlayer(idx, 0)
        if (idx == 0) then
            break
        end
        PlayerIndex = nextPlayerIdx

        if (IsIn_Distance(npcidx) == 1) then
            for i = 1, getn(gIceBuff) do
                if (HaveIBBuff(gIceBuff[i]) > 0) then
                    RemoveIBBuff(gIceBuff[i])
                end
            end
        end
    end
    PlayerIndex = cachePlayerIndex
end

-- ≈–∂œæ‡¿Î
function IsIn_Distance(npcidx)
    local pw, px, py = GetWorldPos()
    local nw, nx, ny = GetNpcWorldPos(npcidx)
    --	local distance = (px-nx)*(px-nx) + (py-ny)*(py-ny)
    local distance = floor(((px - nx) ^ 2 + (py - ny) ^ 2) ^ 0.5 * 32)        -- modify by yangyankun for æ‡¿Î≈–∂œ at 10-1-4
    if (distance <= gDistance) then
        return 1
    else
        return 0
    end
end

-- ∂® ±¥¶¿Ì
function OnTimer(npcidx)
    local nFlag = GetNpcTask(npcidx, 1)
    if (nFlag == 0) then
        NpcCastSkill(npcidx, 1, gSkillID[2], 1)
        SetNpcTask(npcidx, 1, 1)
        Remove_Buff(npcidx)
        SetNpcTimer(npcidx, "\\script\\instance\\death\\±˘»º∂ÒπÌÀ¿Õˆ.lua", 2)
    else
        DelNpc(npcidx)
    end
end