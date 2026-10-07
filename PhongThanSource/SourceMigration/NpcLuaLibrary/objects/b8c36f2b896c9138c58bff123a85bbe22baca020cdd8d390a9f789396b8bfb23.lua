require("¹ú¼ÒÈËÆø.luax")

require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx)

    WorldBossDeath(npcidx)

    SetGlobalValue(111, 0)
    local i = GetName()
    AddGlobalCountNews("LiÖt diÖm cña <c=g>CÇu Long<c> ®· bÞ dËp t¾t, trªn vò khÝ cña <c=g>" .. i .. "<c> cßn dÝnh ®Çy m¸u t­¬i nãng hæi cña ThÇn Long.", 20)

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 3)
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
    local mDeathday = GetWorldEventValue(1, 2)
    local today = math.floor(LocalSystemTime() / 86400)
    if (mDeathday == today) then
        local Proglvl = GetWorldEventProgress(1) + 1
        if (Proglvl <= 3) then
            local bDeathday = GetWorldEventValue(1, 3)
            SetWorldEventValue(1, 3, today)
            if (bDeathday == 0) or (bDeathday ~= today - 1) then
                SetWorldEventProgress(1, 1)
                WriteLog("Sù kiÖn thÕ giíi võa b¾t ®Çu §¹i Long ®· chÕt")
                AddGlobalCountNews("CÇu Long tõ tõ gôc xuèng, trËn ph¸p nhèt c¸c Tiªn nh©n h×nh nh­ ®· cã chót chuyÓn ®éng", 20)
            else
                SetWorldEventProgress(1, Proglvl)
                if (Proglvl == 2) then
                    WriteLog("Ba Ma Long mét lÇn n÷a l¹i bÞ ®¸nh b¹i")
                    AddGlobalCountNews("Ba Ma Long ®· lÇn l­ît bÞ ®¸nh b¹i. TrËn ph¸p nhèt c¸c Tiªn nh©n h×nh nh­ ®· cã chót chuyÓn ®éng", 20)
                end
            end
        elseif (Proglvl == 6) then
            SetWorldEventValue(1, 3, today)
            SetWorldEventProgress(1, Proglvl)
            AddGlobalCountNews("CÇu Long tõ tõ gôc xuèng, ®¹i m«n ë Diªu Tr× (200,196) ®ang tõ tõ më ra.", 20)
            if (IsWorldEventExist(2) == 0) then
                CreateWorldEvent(2, 1, 0, 1)
                WriteLog("S¸ng lËp 2 sù kiÖn thÕ giíi")
            end

            if (GetTeam() ~= 0) then
                local oldPlayer = PlayerIndex
                local membercount = GetTeamSize()

                for i = 1, membercount do
                    PlayerIndex = GetTeamMember(i)
                    if (GetTaskByte(1296, 1) >= 1) then
                        set_Qualify(1)
                    end
                end
                PlayerIndex = oldPlayer
            elseif (GetTaskByte(1296, 1) >= 1) then
                set_Qualify(1)
            end
        else
            WriteLog("Sai råi!" .. Proglvl)
        end
    else
        WriteLog("§¹i Long: ch­a theo thø tù ®¸nh b¹i ")
    end
end

function set_Qualify(id)
    if (GetCurTitle() == 0) then
        Msg2Player("Thu phôc CÇu Long, khai th«ng ®­êng ®Õn Tiªn Ma Giíi, nhËn ®­îc danh hiÖu: “Anh Hïng C¸i ThÕ”.")
    else
        Msg2Player("Thu phôc CÇu Long, khai th«ng ®­êng ®Õn Tiªn Ma Giíi, nhËn ®­îc danh hiÖu: “Anh Hïng C¸i ThÕ”. Danh hiÖu cò ®· bÞ thay thÕ! Cã thÓ ®Õn n¬i ®· nhËn tr­íc ®Ó phôc håi l¹i.")
    end

    AddEvent("%s nhËn ®­îc x­ng hiÖu [Anh hïng c¸i thÕ]!", 1)

    ActiveTitleQualify(id)
    SetCurTitle(id)
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
    WriteLog("Trang bÞ cam cao cÊp: rít trang bÞ tr¾ng" .. nFlag .. ",npcID:CÇu Long")
end
