--description: 嗜沙兽死亡脚本
--author: yangtao
--date: 2009/12/28

function OnDeath(npcIdx)
    local npcMap, npcX, npcY = GetNpcWorldPos(npcIdx)

    -- 为1000像素内的玩家消除黑沙buff
    local mapidx = SubWorldID2Idx(npcMap)
    local nPlayerCount = GetSubWorldPlayerCount(mapidx)

    if (nPlayerCount > 0) then
        for i = 1, nPlayerCount do
            PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, i)
            local m, x, y = GetWorldPos()
            local nDis = (((npcX - x) ^ 2 + (npcY - y) ^ 2) ^ 0.5 * 32)
            if (nDis < 1000) then
                if (HaveIBBuff(1217) > 0) then
                    RemoveIBBuff(1217)
                end
            end
        end
    end

    -- 掉落物品冰心丹
    ThrowItem(npcIdx, PlayerIndex, 8, 988, 2, 0, 0, 0)
end