function OnDeath(npcidx)
    if (PlayerIndex <= 0) then
        return
    end

    local mapid, x, y = GetNpcWorldPos(npcidx)
    local nNpcIdx = AddNpc(2115, 1, SubWorldID2Idx(mapid), x * 32, y * 32)
    if (nNpcIdx > 0) then
        SetNpcName(nNpcIdx, "r­¬ng")
        SetNpcScript(nNpcIdx, "\\script\\¼ÀÔ¨¹È\\±¦Ïä.lua")
        SetNpcTimer(nNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1 * 60)
        local str = "<bc=r><RoleName=\"" .. GetName() .. "\">®¸nh b¹i <c=g>§o¹t B¶o TiÓu Yªu<c>, r­¬ng biÕn mÊt nhanh chãng, h·y tranh thñ thêi gian c­íp l¹i!"
        Msg2CurMapAnnounce(str)
    end
    DelNpc(npcidx)
end

