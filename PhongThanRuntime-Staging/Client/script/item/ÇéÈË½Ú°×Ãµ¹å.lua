VALENTINE = 1682

function main()
    local name = GetName()
    local toname
    local lv = GetLevel()
    local idx = GetPlayerTarget()
    if (IsPlayer(idx) == 1 and idx ~= PlayerIndex) then
        local oIdx = PlayerIndex
        local idx2 = NpcIdx2PIdx(idx)
        PlayerIndex = idx2
        toname = GetName()
        PlayerIndex = oIdx

        Msg2CurMapAnnounce(name .. " n鉯 v韎 " .. toname .. "说: 任时光匆匆流逝, 我只钟情你一人.")
    else
        Msg2CurMapAnnounce(name .. "对全服玩家说: 任时光匆匆流逝, 我只钟情你一人.")

    end
    DelNormalItem(6, 1, 810, 0)
end
