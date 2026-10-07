Task_flower = 1424

AI_STATE_NONE = 0
AI_STATE_FREE = 1
AI_STATE_ATTACK = 2
AI_STATE_FELLOW = 3
AI_STATE_ROUTE = 4
AI_STATE_DEFEND = 5

AI_CONDITION_TARGET = 1
AI_CONDITION_DAMAGE = 2
AI_CONDITION_ATTACK = 3
AI_CONDITION_TIME = 4
AI_CONDITION_ROUTE = 5

AI_TARGET_FIND_PLAYER = 0
AI_TARGET_LOSE_PLAYER = 1
AI_TARGET_NEAR_PLAYER = 2

AI_ACT_TIME_POINT = 0
AI_ACT_TIME_PERIOD = 1

AI_ACT_ATTACK_PLAYER = 0
AI_ACT_ATTACK_NPC = 1

AI_ACT_DAMAGE_VALUE_PLAYER = 0
AI_ACT_DAMAGE_LOW_BLOOD_PLAYER = 1

AI_ACT_ROUTE_DES = 0

g_PowerStar = 1480
g_AliveStar = 1481

g_Light1 = 218
g_Light2 = 219
g_Light3 = 220
g_Light4 = 221

g_BUFFSTARPOWER = 696
g_BUFFMOSTER = 698
g_BUFFDEFEND = 697
BUFF_STRAR = 695

NPC_ROUTE_POS = {

    {
        { x = 1873, y = 3433 },
        { x = 1854, y = 3414 },
        { x = 1837, y = 3429 },
        { x = 1781, y = 3429 },
        { x = 1757, y = 3407 },
        { x = 1645, y = 3528 },
    },

    {
        { x = 1873, y = 3433 },
        { x = 1848, y = 3411 },
        { x = 1865, y = 3398 },
        { x = 1859, y = 3256 },
        { x = 1840, y = 3230 },
    },

    {
        { x = 1873, y = 3433 },
        { x = 1904, y = 3425 },
        { x = 1930, y = 3450 },
        { x = 1909, y = 3432 },
        { x = 1937, y = 3445 },
        { x = 1945, y = 3431 },
        { x = 2010, y = 3476 },
        { x = 2057, y = 3519 },
        { x = 2070, y = 3521 },
    },

    {
        { x = 1873, y = 3433 },
        { x = 1912, y = 3423 },
        { x = 1943, y = 3475 },
        { x = 1908, y = 3535 },
        { x = 1918, y = 3598 },
        { x = 1909, y = 3624 },
        { x = 1917, y = 3659 },
        { x = 1897, y = 3690 },
        { x = 1886, y = 3734 },
        { x = 1843, y = 3778 },
    },

}

NPC_FREE_SAY = {
    "H·y theo s¸t ta, nÕu kh«ng ng­¬i sÏ kh«ng biÕt tiÕn hµnh nghi thøc t¹i ®©u.",
}

function checkGuardPlayer()


    PlayerIndex = SearchPlayerById(GetNpcTask(AiNpcIdx, 0))

    if (PlayerIndex > 0) then

        local nWorldId, nX, nY = GetNpcWorldPos(AiNpcIdx)
        local nPWorldId, nPX, nPY = GetWorldPos()

        if (nWorldId == nPWorldId) then

            return PlayerIndex

        end

    else

        Failed()
    end

    ClearAICondition(-1, -1)

    return 0

end

function eventResetNpc()

    DelNpc(AiNpcIdx)

end

function AIStart()

    ClearAICondition(-1, -1)

    SetGuardLevel(AiNpcIdx, 2)

    SetTimeCondition(AI_ACT_TIME_PERIOD, "eventBirthTalk", 1)

    SetAIState(AI_STATE_NONE)

end

function eventBirthTalk()

    ClearAICondition(-1, -1)

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then

        NpcSay(AiNpcIdx, GetName() .. "Ng­¬i chuÈn bÞ xong ch­a?")

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventBirthTalk1", 2)

    end

    SetAIState(AI_STATE_NONE)

end

function eventBirthTalk1()

    ClearAICondition(-1, -1)

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then

        NpcSay(AiNpcIdx, GetName() .. "Chóng ta lªn ®­êng th«i.")

        local nWorldId, nX, nY = GetNpcWorldPos(AiNpcIdx)

        local nNpcType = GetTaskByte(g_PowerStar, 2)
        SetGuardLevel(AiNpcIdx, 2)
        SetNpcTask(AiNpcIdx, 1, 0)

        SetRouteCondition(AI_ACT_ROUTE_DES, "eventAckState1", nWorldId, NPC_ROUTE_POS[nNpcType][1].x * 32, NPC_ROUTE_POS[nNpcType][1].y * 32, 1)

        SetAIState(AI_STATE_ROUTE)
    else
        SetAIState(AI_STATE_NONE)
    end


end

function eventLostTarget()

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then

        ClearAICondition(AI_CONDITION_TARGET, -1)

        SetAIState(AI_STATE_NONE)

    else

        SetAIState(AI_STATE_NONE)

    end

end

function eventMonsterAttack()

    ClearAICondition(-1, -1)

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then


        NpcSay(AiNpcIdx, GetName() .. "KÎ l­u ®µy ë Ngôc Ph¸p s¬n xuÊt hiÖn råi! Mau b¶o vÖ ta!")
        Msg2Player(GetName() .. "KÎ l­u ®µy ë Ngôc Ph¸p s¬n xuÊt hiÖn råi! Mau b¶o vÖ ta!")

        SetGuardLevel(AiNpcIdx, 1)
        SetNpcCamp(AiNpcIdx, 0)

        local nWorldId, nX, nY = GetNpcWorldPos(AiNpcIdx)
        local nNpcType = GetTaskByte(g_PowerStar, 2)

        for i = 1, 4, 1 do

            local x = math.random(nX - 3, nX + 3)
            local y = math.random(nY - 3, nY + 3)
            local npcindex = AddNpc(1109, 65, SubWorldID2Idx(nWorldId), x * 32, y * 32, 0, 1)

            SetNpcTask(AiNpcIdx, i * 2, npcindex)
            SetNpcTask(AiNpcIdx, i * 2 + 1, GetNpcID(npcindex))

            SetNpcScript(npcindex, "\\script\\npcdeath\\É¾µô×Ô¼º.lua")
            SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 5)
            SetNpcTarget(npcindex, AiNpcIdx)

            SetNpcTask(npcindex, 0, GetPlayerID())

            SetNpcTask(npcindex, 1, GetNpcID(npcindex))

        end

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventCheckMonster", 3)

        SetNpcOriPos(AiNpcIdx, nX, nY)

        SetAIState(AI_STATE_NONE)

    else

        SetAIState(AI_STATE_NONE)

    end


end

function eventMonsterAttackFresh()


    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then


        NpcSay(AiNpcIdx, GetName() .. "KÎ l­u ®µy ë Ngôc Ph¸p s¬n xuÊt hiÖn råi! Mau b¶o vÖ ta!")

        SetNpcCurCamp(AiNpcIdx, 0)
        local nWorldId, nX, nY = GetNpcWorldPos(AiNpcIdx)
        local nNpcType = GetTaskByte(g_PowerStar, 2)

        for i = 1, 5, 1 do

            local x = math.random(nX - 3, nX + 3)
            local y = math.random(nY - 3, nY + 3)
            local npcindex = AddNpc(1109, 65, SubWorldID2Idx(nWorldId), x * 32, y * 32, 0, 1)

            SetNpcTarget(npcindex, AiNpcIdx)

            SetNpcScript(npcindex, "\\script\\npcdeath\\É¾µô×Ô¼º.lua")
            SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 5)

        end

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventMonsterAttackFresh", 30)

        SetNpcOriPos(AiNpcIdx, nX, nY)

        SetAIState(AI_STATE_NONE)
    else

        SetAIState(AI_STATE_NONE)

    end

end

function eventCheckMonster()

    ClearAICondition(-1, -1)

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then

        SetNpcCurCamp(AiNpcIdx, 0)
        local bAlive = 0

        for i = 1, 4, 1 do

            local npcindex = GetNpcTask(AiNpcIdx, i * 2)
            local npcid = GetNpcTask(AiNpcIdx, i * 2 + 1)

            if (npcindex ~= 0) and (GetNpcID(npcindex) ~= 0) and (GetNpcID(npcindex) == npcid) then
                bAlive = 1
                break
            end

        end

        if (bAlive == 1) then

            SetTimeCondition(AI_ACT_TIME_PERIOD, "eventCheckMonster", 5)

            SetAIState(AI_STATE_NONE)

        else

            if (GetNpcTask(AiNpcIdx, 0) == GetPlayerID()) then

                NpcSay(AiNpcIdx, "Nghi thøc b¾t ®Çu !!!!")

                TopMessage("Nghi thøc b¾t ®Çu !!!!")

                TaskNote(110, 2)

                SetTaskByte(g_PowerStar, 1, 2)

                AddIBBuff(BUFF_STRAR)

                if (GetTaskByte(g_PowerStar, 1) == 2 and HaveIBBuff(BUFF_STRAR) ~= 0) then

                    SetTimeCondition(AI_ACT_TIME_PERIOD, "eventMonsterAttackFresh", 30)

                    SetTimeCondition(AI_ACT_TIME_PERIOD, "FinishCere", 60 * 5 + 3)

                    local lightPosition = GetTaskByte(g_PowerStar, 2)
                    if (lightPosition == 1) then
                        eventLightenE()
                    elseif (lightPosition == 2) then
                        eventLightenS()
                    elseif (lightPosition == 3) then
                        eventLightenW()
                    elseif (lightPosition == 4) then
                        eventLightenN()
                    end


                end
            else
                Msg2Player("NPC cña m×nh")
                Failed()
            end


        end
    else

        SetAIState(AI_STATE_NONE)

    end
end

function eventSubLightenE1()

    local light1 = GetNpcTask(GetGlobalValue(g_Light1), 1);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenE2()

    local light1 = GetNpcTask(GetGlobalValue(g_Light1), 2);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenE3()

    local light1 = GetNpcTask(GetGlobalValue(g_Light1), 3);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenE4()

    local light1 = GetNpcTask(GetGlobalValue(g_Light1), 4);
    NpcPolyMorph(light1, 1145)
end

function eventLightenE()

    for i = 1, 4 do

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventSubLightenE" .. i, 15 * i * 5)
    end
end

function eventSubLightenS1()

    local light1 = GetNpcTask(GetGlobalValue(g_Light2), 1);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenS2()

    local light1 = GetNpcTask(GetGlobalValue(g_Light2), 2);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenS3()

    local light1 = GetNpcTask(GetGlobalValue(g_Light2), 3);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenS4()

    local light1 = GetNpcTask(GetGlobalValue(g_Light2), 4);
    NpcPolyMorph(light1, 1145)
end

function eventLightenS()
    for i = 1, 4 do

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventSubLightenS" .. i, 15 * i * 5)
    end
end

function eventSubLightenW1()

    local light1 = GetNpcTask(GetGlobalValue(g_Light3), 1);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenW2()

    local light1 = GetNpcTask(GetGlobalValue(g_Light3), 2);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenW3()

    local light1 = GetNpcTask(GetGlobalValue(g_Light3), 3);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenW4()

    local light1 = GetNpcTask(GetGlobalValue(g_Light3), 4);
    NpcPolyMorph(light1, 1145)
end
function eventLightenW()

    for i = 1, 4 do

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventSubLightenW" .. i, 15 * i * 5)
    end
end

function eventSubLightenN1()

    local light1 = GetNpcTask(GetGlobalValue(g_Light4), 1);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenN2()

    local light1 = GetNpcTask(GetGlobalValue(g_Light4), 2);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenN3()

    local light1 = GetNpcTask(GetGlobalValue(g_Light4), 3);
    NpcPolyMorph(light1, 1145)
end
function eventSubLightenN4()

    local light1 = GetNpcTask(GetGlobalValue(g_Light4), 4);
    NpcPolyMorph(light1, 1145)
end
function eventLightenN()

    for i = 1, 4 do

        SetTimeCondition(AI_ACT_TIME_PERIOD, "eventSubLightenN" .. i, 15 * i * 5)
    end
end

function eventLightdie()
    local LightList = { g_Light1, g_Light2, g_Light3, g_Light4 }
    local nLightindex
    for n = 1, 4 do
        for j = 1, 4 do
            nLightindex = GetNpcTask(GetGlobalValue(LightList[n]), j)

            SetNpcTimer(nLightindex, "\\script\\ontimer\\µÆontimer.lua", 2)
        end
    end
end

function Succed()

    local StarList = { g_Light1, g_Light2, g_Light3, g_Light4 }
    RemoveIBBuff(BUFF_STRAR)

    SetNpcTimer(AiNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60)

    SetTimeCondition(AI_ACT_TIME_PERIOD, "eventLightdie", 60)

    local nStarIndex = GetTaskByte(g_PowerStar, 2)

    SetNpcTask(GetGlobalValue(StarList[nStarIndex]), 0, 0)
end

function Failed()
    ClearAICondition(-1, -1)

    RemoveIBBuff(BUFF_STRAR)
    ScrollMessage("NhiÖm vô thÊt b¹i")
    Msg2Player("NhiÖm vô thÊt b¹i")
    TopMessage("NhiÖm vô thÊt b¹i")
    SetTaskbyte(g_PowerStar, 1, 4)
    SetGuardLevel(AiNpcIdx, 2)
    TaskNote(110, 5)
    local StarList = { g_Light1, g_Light2, g_Light3, g_Light4 }
    local nStarIndex = GetTaskByte(g_PowerStar, 2)

    SetNpcTask(GetGlobalValue(StarList[nStarIndex]), 0, 0)

    SetNpcTimer(AiNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60)

    eventLighdie()

end

function FinishCere()
    ClearAICondition(-1, -1)
    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then
        if (GetTaskByte(g_PowerStar, 1) == 2 and HaveIBBuff(BUFF_STRAR) == 0) then

            if (GetNpcTask(AiNpcIdx, 0) == GetPlayerID()) then
                SetGuardLevel(AiNpcIdx, 2)
                SetTaskByte(g_PowerStar, 1, 3)
                NpcSay(AiNpcIdx, "Hoµn thµnh nghi thøc!")
                TopMessage("Hoµn thµnh nghi thøc!")
                Msg2Player("Hoµn thµnh nghi thøc!")
                TaskNote(110, 3)
                SetGuardLevel(AiNpcIdx, 2)
                Succed()
            else
                Msg2Player("Kh«ng ph¶i NPC cña m×nh")
                return
            end
        end
    end
end

function eventAckState1(step)

    PlayerIndex = checkGuardPlayer()

    if (PlayerIndex > 0) then

        local nNpcType = GetTaskByte(g_PowerStar, 2)

        if (step < table.getn(NPC_ROUTE_POS[nNpcType])) then

            ClearAICondition(AI_CONDITION_ROUTE, -1)

            local nRank = math.random(1, 100)

            if (nRank <= 50) then
                nRank = math.random(1, table.getn(NPC_FREE_SAY))
                NpcSay(AiNpcIdx, NPC_FREE_SAY[nRank])
            end

            local nWorldId, nX, nY = GetNpcWorldPos(AiNpcIdx)
            SetNpcTask(AiNpcIdx, 1, step)

            SetRouteCondition(AI_ACT_ROUTE_DES, "eventAckState1", nWorldId, NPC_ROUTE_POS[nNpcType][step + 1].x * 32, NPC_ROUTE_POS[nNpcType][step + 1].y * 32, step + 1)

            SetAIState(AI_STATE_ROUTE)

        else
            ClearAICondition(-1, -1)

            SetTimeCondition(AI_ACT_TIME_PERIOD, "eventMonsterAttack", 5)

            NpcSay(AiNpcIdx, "§Õn n¬i Tinh qu©n")

            SetAIState(AI_STATE_NONE)

        end

    else

        SetAIState(AI_STATE_NONE)

    end

end

