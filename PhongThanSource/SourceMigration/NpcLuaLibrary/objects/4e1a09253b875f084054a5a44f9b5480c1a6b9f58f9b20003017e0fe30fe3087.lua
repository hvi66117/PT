CityWarTask = 1939

CityWarMission = 669

CityWarMission1 = 670

TranseverState = 14

GateNpcTable = {
    [1] = { NpcId = 2161, Lvl = 80, Name = "³ÇÊÐÍ¼ÌÚ", Posx = 1728, Posy = 3335, NpcScript = " ", NpcType = 1, },
    [2] = { NpcId = 2162, Lvl = 100, Name = "³ÇÊÐÍ¼ÌÚ", Posx = 1728, Posy = 3335, NpcScript = " ", NpcType = 2, },
    [3] = { NpcId = 2163, Lvl = 120, Name = "³ÇÊÐÍ¼ÌÚ", Posx = 1728, Posy = 3335, NpcScript = " ", NpcType = 3, },
    [4] = { NpcId = 2164, Lvl = 140, Name = "³ÇÊÐÍ¼ÌÚ", Posx = 1728, Posy = 3335, NpcScript = " ", NpcType = 4, },
    [5] = { NpcId = 2165, Lvl = 160, Name = "³ÇÊÐÍ¼ÌÚ", Posx = 1728, Posy = 3335, NpcScript = " ", NpcType = 5, },
}

function OnDeath(npcindex)
    local MissionState = GetGlobalValueByte(CityWarMission, 1)
    local PlayerMissionState = GetTaskByte(CityWarTask, 2)
    local NpcType = GetNpcTask(npcindex, 1)
    local str = ""
    local nColor = ""
    if (NpcType <= 0 or NpcType > 5) then
        NpcType = 1
    end

    local NewNpcindex = AddNpc(GateNpcTable[NpcType].NpcId, GateNpcTable[NpcType].Lvl, SubWorldID2Idx(93), GateNpcTable[NpcType].Posx * 32, GateNpcTable[NpcType].Posy * 32)
    SetNpcTask(NewNpcindex, 1, NpcType)

    SetTaskWord(CityWarTask, 2, (GetTaskWord(CityWarTask, 2) + 30))
    TopMessage("¶áÈ¡Í¼ÌÚ, Õ½³¡·ÖÊý+30")

    SetNpcTimer(NewNpcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1800)
    SetNpcTask(NewNpcindex, NpcType)
    if (PlayerMissionState == 1) then
        SetNpcCamp(NewNpcindex, 3)
        SetGlobalValueByte(CityWarMission, 3, 1)
        str = "Hiªn Viªn ThÞ Téc"
        nColor = "water"
    elseif (PlayerMissionState == 2) then
        SetNpcCamp(NewNpcindex, 4)
        SetGlobalValueByte(CityWarMission, 3, 2)
        str = "Ñ×»ÆÊÏ×å"
        nColor = "y"
    end
    SetNpcName(NewNpcindex, "<c=" .. nColor .. ">" .. GateNpcTable[NpcType].Name .. "<c>")

    local mapIndex = SubWorldID2Idx(93)
    local OldPidx = PlayerIndex
    local nPlayerCount = GetSubWorldPlayerCount(mapIndex)

    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapIndex, i)
        if (PlayerIndex > 0) then
            local Soc = GetTaskWord(1939, 2)
            TaskNote(1939, 1, str, Soc)
            Msg2Player(str .. "È¡µÃÁË¶´ÌìÍ¼ÌÚµÄ¿ØÖÆÈ¨.")
            TopMessage(str .. "È¡µÃÁË¶´ÌìÍ¼ÌÚµÄ¿ØÖÆÈ¨.")
        end
    end
    PlayerIndex = OldPidx
    DelNpc(npcindex)
end

