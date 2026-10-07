Task_GoAstray = 1541
WanZhaoShou_ID = 228
WanZhaoShou_Index = 253

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

function OnDeath(npcindex)
    local taskGoAstray = GetTaskByte(Task_GoAstray, 1)
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            local taskGoAstray1 = GetTaskByte(Task_GoAstray, 1)
            local mapid, x, y = GetWorldPos()
            if (taskGoAstray1 == 1 and mapid == 76) then
                GetAward()
            end
        end
        PlayerIndex = oldPlayer

        WriteLog("Sè thµnh viªn cña ®éi ®· hµng phôc ®­îc V¹n Tr¶o Thó lµ: " .. membercount)
    else
        if (taskGoAstray == 1) then
            GetAward()
        end
    end

    local NingZhiHunIndex = GetNpcTask(npcindex, 1)
    local ShiLangZhiHunIndex = GetNpcTask(npcindex, 2)
    DelNpc(NingZhiHunIndex)
    DelNpc(ShiLangZhiHunIndex)

    SetGlobalValue(WanZhaoShou_ID, 0)
    SetGlobalValue(WanZhaoShou_Index, 0)
    DelNpc(npcindex)
end

function GetAward()
    TopMessage("Thµnh c«ng hµng phôc V¹n Tr¶o Thó")

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®­îc vËt phÈm nhiÖm vô. TiÕp tôc hµng phôc V¹n Tr¶o Thó.")
        return
    end

    SetTaskByte(Task_GoAstray, 1, 2)
    AddEventItem(271)
    TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 48)
end
