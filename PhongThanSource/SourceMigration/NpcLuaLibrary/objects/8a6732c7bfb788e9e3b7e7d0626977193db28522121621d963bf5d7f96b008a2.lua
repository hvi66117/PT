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

function OnDeath(npcindex)
    local lLightList = { g_Light1, g_Light2, g_Light3, g_Light4 }

    PlayerIndex = SearchPlayerById(GetNpcTask(npcindex, 0))
    if (GetTaskByte(g_PowerStar, 1) == 1 or GetTaskByte(g_PowerStar, 1) == 2) then
        RemoveIBBuff(BUFF_STRAR)
        ScrollMessage("Nhi÷m vÙ th t bπi")
        Msg2Player("Nhi÷m vÙ th t bπi")
        TopMessage("Nhi÷m vÙ th t bπi")
        SetTaskByte(g_PowerStar, 1, 4)

        TaskNote(110, 5)

        local nLightindex

        local nStarIndex = GetTaskByte(g_PowerStar, 2)

        SetNpcTask(GetGlobalValue(lLightList[nStarIndex]), 0, 0)

        for n = 1, table.getn(lLightList) do
            for j = 1, 4 do
                nLightindex = GetNpcTask(GetGlobalValue(lLightList[n]), j)

                SetNpcTimer(nLightindex, "\\script\\ontimer\\µ∆onTimer.lua", 2)
            end
        end
    end
    DelNpc(npcindex)
end

