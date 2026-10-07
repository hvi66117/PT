VALENTINE = 1682

function main()
    local name = GetName()
    local toname
    local lv = GetLevel()
    local idx = GetPlayerTarget()
    local gidx = GetTaskByte(VALENTINE + 2, 1)

    if (IsPlayer(idx) == 1 and idx ~= PlayerIndex) then
        local oIdx = PlayerIndex
        local idx2 = NpcIdx2PIdx(idx)
        PlayerIndex = idx2
        toname = GetName()
        PlayerIndex = oIdx

        Msg2CurMapAnnounce(name .. " n鉯 v韎 " .. toname .. "说: 我爱你!深爱着你!爱意正如玫瑰深红.")
    else
        Msg2CurMapAnnounce(name .. "对全服玩家说: 我爱你!深爱着你!爱意正如玫瑰深红.")

    end
    DelNormalItem(6, 1, 813, 0)
end
