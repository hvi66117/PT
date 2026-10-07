require("¹ú¼ÒÈËÆø.luax")

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx)

    WorldBossDeath(npcidx)

    SetGlobalValue(110, 0)
    local i = GetName()
    AddGlobalCountNews("H¬i thë cña <c=g>Ly Long<c> ®· t¾t, c¸nh cña nã treo trªn <c=g>" .. i .. "<c>.", 20)

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 2)
        WriteLog("S¸ng lËp mét sù kiÖn thÕ giíi")
    else
        local prog = GetWorldEventProgress(1)
        if (prog < 3) then
            beginWorldevent()
        elseif (prog == 5) then
            if (GetTaskByte(1296, 1) >= 1) then
                beginWorldevent()
            else
                WriteLog("Ng­¬i ch­a b¸o danh s¸t Rång")
            end
        end
    end

    Throw_Equip(npcidx, PlayerIndex)

    DelNpc(npcidx)
end;

function beginWorldevent()
    local sDeathday = GetWorldEventValue(1, 1)
    local today = math.floor(LocalSystemTime() / 86400)
    if (sDeathday == today) then
        SetWorldEventValue(1, 2, today)
    else
        WriteLog("Ly Long: ch­a theo thø tù ®¸nh b¹i ")
    end
end

function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 4
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do

        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)

        if (math.random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[math.random(1, table.getn(nDetailType))], nParticularType[math.random(1, table.getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID:Ly Long")
end
