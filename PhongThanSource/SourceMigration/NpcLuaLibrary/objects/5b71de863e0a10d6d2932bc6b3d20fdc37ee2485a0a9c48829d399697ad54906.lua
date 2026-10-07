g_SearchClansMan = 1483

g_Distance = 222

g_ClansMan = 223

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 57
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(g_SearchClansMan, 1) == 7) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(g_SearchClansMan, 1) == 7) then
                state = 3
                subState = 1
            end
        end
        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()

    if (GetNpcTask(DialogNpcIdx, 0) ~= GetPlayerID()) then

        InfoBox("«i, thËt ®¸ng sî, thÇn th­îng cæ khñng khiÕp ®· ®­îc gi¶i phong Ên råi …")
        return
    end

    if (GetTaskByte(g_SearchClansMan, 1) == 7) then
        Talk(2, "clansman1", "C¶m t¹ ®· cøu ta, ta cø t­ëng lµ chÕt ch¾c råi.", GetName() .. " kh«ng cã chi, n¬i ®©y vÉn cßn rÊt nguy hiÓm h·y mau rêi khái ®©y.")

    else
        InfoBox("«i, thËt ®¸ng sî, thÇn th­îng cæ khñng khiÕp ®· ®­îc gi¶i phong Ên råi …")
    end
end;

function no()
    CloseDialog()
end

function clansman1()
    MsgBox("§­îc, h·y ®Ó ta dÉn ®­êng.", "renwu", "no")
end

function renwu()

    CloseDialog()

    local npcindex = GetTask(g_ClansMan)
    local mapid, px, py = GetNpcWorldPos(npcindex)
    local w, x, y = GetWorldPos()
    if (mapid ~= 75) or (w ~= mapid) then
        return 0
    end

    local sgidx = AddNpc(1103, 57, SubWorld, px * 32, py * 32)
    if (sgidx > 0) then


        SetAIScript(sgidx, "\\script\\ai\\Ê§×ÙµÄ×åÈËai.lua")

        SetNpcTask(sgidx, 0, GetPlayerID())
        SetTask(g_ClansMan, sgidx)
        SetNpcCamp(sgidx, 0)
        SetNpcScript(sgidx, "\\script\\¹ÖÎï\\Ê§×ÙµÄ×åÈËËÀÍö.lua")

        SetNpcName(sgidx, GetName() .. "Téc nh©n ®­îc hé tèng")

        SetNpcTimer(sgidx, "\\script\\ontimer\\Ê§×ÙµÄ×åÈËÏûÊ§.lua", 60 * 10)
        TaskNote(109, 2)
        Msg2Player("Hé tèng Téc ng­êi mÊt tİch ®Õ YÓn B¸ İch.")

        DelNpc(npcindex)

    end
end

function OnDeath(npcindex)
end

function DoDeath(npcidx)
end
