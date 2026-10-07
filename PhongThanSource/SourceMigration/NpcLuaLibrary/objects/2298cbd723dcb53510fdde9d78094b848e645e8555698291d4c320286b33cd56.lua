function OnDeath(nNpcIdx)

    local nMap, nX, nY = GetNpcWorldPos(nNpcIdx)
    local oldPlayer = PlayerIndex
    local nNum = GetNpcEnmityCount(nNpcIdx)
    local nPlayerCount = 0
    local nStr = { "1", "2", "3" }
    local str = ""
    local nItemID = {}
    local tblItem = {
        { name = "¹´³ÂÕä±¦", ID = { 6, 1, 1536, 1 } },
        { name = "¹´³Â±¦²Ø", ID = { 6, 1, 1537, 1 } },
        { name = "¹´³Â±¦Îï", ID = { 6, 1, 1538, 1 } },
    }
    if (nNum >= 1) then
        for i = 1, nNum do
            local npcIdx, npcID, nValue = GetNpcEnmityItem(nNpcIdx, i)
            PlayerIndex = NpcIdx2PIdx(npcIdx)
            if (PlayerIndex > 0) then
                local m, x, y = GetWorldPos()
                if (m == nMap) then
                    nPlayerCount = nPlayerCount + 1
                    if (nPlayerCount >= 1 and nPlayerCount <= 3) then
                        nItemID = tblItem[nPlayerCount].ID
                        AddNormalItem(nItemID[1], nItemID[2], nItemID[3], nItemID[4], 0, 0)
                        Msg2Player("B¹n nh©n ®­îc " .. tblItem[nPlayerCount].name .. ".")
                        WriteLog("[Ho¹t ®éng vËn hµnh][¹´³ÂËÀÍö][NhËn ®­îc " .. tblItem[nPlayerCount].name .. "]")
                        str = str .. nStr[nPlayerCount] .. ":" .. GetName() .. ";"
                    end
                end
            end
        end
        Msg2CurMapAnnounce("Ä¿Ç°¶Ô¹´³ÂÔì³ÉÉËº¦ÅÅÃûÎª: " .. str)
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Ò»ÆðÅ¬Á¦ÓÂ¸ÒµØ´ò°ÜÁË¹´³Â, nhËn ®­îc ¹´³Â±¦²Ø!¹§Ï²ËûÃÇ!")
        PlayerIndex = oldPlayer
    else
        WriteLog("¹´³ÂÃ»ÓÐ³ðºÞÁÐ±í.")
    end
    PlayerIndex = oldPlayer

    local nGetPlayer = 0
    local mapid, xpos, ypos = GetNpcWorldPos(nNpcIdx)
    local mapidx = SubWorldID2Idx(mapid)
    local nPlayerCount = GetSubWorldPlayerCount(mapidx)
    local oldPlayerIndex = PlayerIndex
    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, i)
        if (PlayerIndex > 0) then
            if (GetLevel() < 60) or (GetMorphType() == 364) or (GetMorphType() == 366) or (IsPlayerInsideWeapon(PlayerIndex) > 0 or (GetCamp() == 0 or GetCamp() == 7) or (GetGuardLevel() == 2)) then

            else
                local nWordID, nX, nY = GetWorldPos()
                if (nWordID == mapid) and (math.sqrt((nX - xpos) ^ 2 + (nY - ypos) ^ 2) * 32 <= 500) then
                    nGetPlayer = nGetPlayer + 1
                    AddNormalItem(6, 1, 1539, 1, 0, 0)
                    Msg2Player("Ngµi nhËn ®­îc ¹´³ÂÀñ°ü.")
                end
            end
        end
        PlayerIndex = oldPlayerIndex
    end

    DelNpc(nNpcIdx)
    WriteLog("[Ho¹t ®éng vËn hµnh][¹´³ÂËÀÍö][NhËn ®­îc¹´³ÂÀñ°ü" .. nGetPlayer .. "]")
end;
