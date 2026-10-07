gHideNpcID = 1693
gDistance = 400
gIceBuff = { 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209 }

gSkillID = {
    [1] = 749,
    [2] = 750,
}

gIceItem = { 3, 1070, 0, 0, 0, 0 }

function OnDeath(npcidx)

    local w, x, y = GetWorldPos()
    local hideNpcIndex = AddNpc(gHideNpcID, 1, SubWorld, (x + 1) * 32, (y + 1) * 32)
    if (hideNpcIndex > 0) then
        SetNpcName(hideNpcIndex, "")
        SetNpcTimer(hideNpcIndex, "\\script\\instance\\death\\±ùÈ¼¶ñ¹íËÀÍö.lua", 1)
    end

    ThrowItem(npcidx, PlayerIndex, gIceItem[1], gIceItem[2], gIceItem[3], gIceItem[4], gIceItem[5], gIceItem[6])


end

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
            for i = 1, table.getn(gIceBuff) do
                if (HaveIBBuff(gIceBuff[i]) > 0) then
                    RemoveIBBuff(gIceBuff[i])
                end
            end
        end
    end
    PlayerIndex = cachePlayerIndex
end

function IsIn_Distance(npcidx)
    local pw, px, py = GetWorldPos()
    local nw, nx, ny = GetNpcWorldPos(npcidx)

    local distance = math.floor(((px - nx) ^ 2 + (py - ny) ^ 2) ^ 0.5 * 32)
    if (distance <= gDistance) then
        return 1
    else
        return 0
    end
end

function OnTimer(npcidx)
    local nFlag = GetNpcTask(npcidx, 1)
    if (nFlag == 0) then
        NpcCastSkill(npcidx, 1, gSkillID[2], 1)
        SetNpcTask(npcidx, 1, 1)
        Remove_Buff(npcidx)
        SetNpcTimer(npcidx, "\\script\\instance\\death\\±ùÈ¼¶ñ¹íËÀÍö.lua", 2)
    else
        DelNpc(npcidx)
    end
end
