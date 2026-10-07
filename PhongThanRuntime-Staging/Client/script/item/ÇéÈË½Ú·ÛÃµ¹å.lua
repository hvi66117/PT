VALENTINE = 1682

function main()
    local name = GetName()
    local toname
    local gexp = 0
    local bm = 0
    local lv = GetLevel()
    local idx = GetPlayerTarget()
    local gidx = GetTaskByte(VALENTINE + 2, 1)
    if (IsPlayer(idx) == 1 and idx ~= PlayerIndex) then
        local oIdx = PlayerIndex
        local idx2 = NpcIdx2PIdx(idx)
        PlayerIndex = idx2
        toname = GetName()
        PlayerIndex = oIdx

        Msg2CurMapAnnounce(name .. " n鉯 v韎 " .. toname .. "说: 那些年, 只喜欢你灿烂的微笑.")
    else
        Msg2CurMapAnnounce(name .. "对全服玩家说: 那些年, 只喜欢你灿烂的微笑.")

    end
    DelNormalItem(6, 1, 812, 0)
end
