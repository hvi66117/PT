gua8_renwu = 1340
gua8_task = 1341

function OnDeath(npcidx)

    local nTargetIndex = GetBossTargetPlayer(npcidx)

    if (nTargetIndex ~= 0) then
        PlayerIndex = NpcIdx2PIdx(nTargetIndex)
    end

    local tTime = LocalSystemTime() - GetNpcTask(npcidx, 0)

    WriteLog(GetName() .. "Tiªu diÖt XÝch Yªn Thó sö dông" .. tTime)

    local tSecond = math.mod(tTime, 60)
    local tMinite = math.mod(math.floor(tTime / 60), 60)
    local tHour = math.floor(tTime / 3600)
    local strTime = ""

    if (tHour > 0) then
        strTime = strTime .. tHour .. "Giê"
    end

    if (tMinite > 0) then
        strTime = strTime .. tMinite .. "m"
    end

    strTime = strTime .. tSecond .. "s"

    AddGlobalCountNews("ThËt kh©m phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>XÝch Yªn Thó<c>!", 5)
    Msg2CurMapAnnounce("ThËt kh©m phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>XÝch Yªn Thó<c>!")

    DelNpc(npcidx)
end;
