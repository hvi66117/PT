require("newserver.luax")
gPlayerBuffID = 1522
Task_FuTouBang_First = 1877

Task_FuTouBang_InstanceID = 1879

Task_FuTouBang_InstanceIndex = 1880
function OnDeath(npcIdx)
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcIdx, 8)

    local rank = math.random(1, 1000)
    local ThemeDayItem = GetTaskByte(Task_FuTouBang_First, 2)

    if (rank <= 80) then
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 12, 0, 0)
    elseif (rank <= 90) then
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 13, 0, 0)
    elseif (rank <= 97) then
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 15, 0, 1)
    elseif (rank <= 100) then
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 16, 0, 1)
    end

    if (ThemeDayItem == 0) then
        ThrowItem(npcIdx, PlayerIndex, 6, 1, 1005, 0, 0, 0)
        SetTaskByte(Task_FuTouBang_First, 2, 1)
        WriteLog("L«n Æ«u nhÀn nhi÷m vÙ phÔ chÒ Æ“ ngµy.")
    else
        if (rank <= 300) then
            ThrowItem(npcIdx, -1, 6, 1, 1005, 0, 0, 0)
            WriteLog("X∏c su t" .. rank .. "/1000 nhÀn Æ≠Óc nhi÷m vÙ phÔ chÒ Æ“ ngµy.")
        end
    end

    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcIdx, 9))
    local lefttime2 = 30 * 60

    if (math.abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime2 = math.abs(LocalSystemTime() - nFirstEnterTime)
    end

    if (IsNewServerActivityDay() > 0) then
        ThrowItem(npcIdx, -1, 6, 1, 1096, 1, 0, 0)
    end

    WriteLog("Tr≠ Lung Th«n tˆ vong, " .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcIdx, 9))

    SetInstanceTempValue(1, 3)
    InstanceMsg2All(InstanceIndex, "Th´ng b∏o", "<c=yel>Tr≠ Lung Th«n Æ∑ bﬁ Æ∏nh bπi, ttÊ ÆÈi c„ th” v≠Ót ∂i ti’p theo! H∑y t◊m Bao Bµ Bµ ÆËi thoπi!<c>")
    NpcSay(npcIdx, "Kh´ng th” nµo! Ng≠Íi phµm nh· b– nh≠ vÀy sao c„ th” Æ∏nh bπi ta? H·a Tµ Th«n, ta khi’n anh hÔng th t v‰ng rÂi!")

    NewServeEx(npcIdx)

    AddGiftItem2All(npcIdx)

    DelNpc(npcIdx)
    InstanceIndex = oldInstance
end

function IsNewServerActivityDay()
    local y, m, d = GetYMD()
    local h, Mi, s = GetHMS()
    if ((y == 2014) and (m == 8 and d >= 22) or (m == 9 and d <= 14) and (GetGameServerName() == "ßa T◊nh Nh©n Gian")) then
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end

function NewServeEx(npcIdx)
    if (NewServerEx.Pub_IsNewFuTouBang() > 0) then
        AddGiftForNewServer(npcIdx)
    end
end
function IsNewServeEx()
    local y, m, d = GetYMD()
    if (y == 2015 and m == 7 and d >= 7 and d <= 25 and GetGameServerName() == "T¯ T≠Óng Th«n V˘c") then
        return 1
    end
    return 0
end

function AddGiftForNewServer(npcIdx)
    local oldPlayer = PlayerIndex
    local w, x, y = GetNpcWorldPos(npcIdx)
    local mapIdx = SubWorldID2Idx(w)
    local nPlayerCount = GetSubWorldPlayerCount(mapIdx)
    local y, m, d = GetYMD()
    local str = GetNormalItemName(6, 1, 1292, 1)
    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapIdx, i)
        if (PlayerIndex > 0) then


            if (GetTaskByte(2030, 4) ~= d) then
                SetTaskByte(2030, 4, d)

                AddNormalItemBind(6, 1, 1292, 1, 0, 0, 1)
                Msg2Player("ChÛc mıng ngµi nhÀn Æ≠Óc 1 c∏i " .. str .. ".")
                WriteLog("[NhÀn Æ≠Óc " .. str .. "]")
            end
        end
    end
    PlayerIndex = oldPlayer

    local y, m, d = GetYMD()
    if (y == 2015 and ((m == 9 and d >= 18) or (m == 10 and d <= 18))) then
        local w, x, y = GetNpcWorldPos(npcIdx)
        local npc = AddNpc(2281, 60, SubWorldID2Idx(w), x * 32, y * 32)
        if (npc > 0) then
            SetNpcTimer(npc, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 600)
            SetNpcScript(npc, "\\script\\npcdeath\\Ÿ¡ø‹.lua")
            WriteLog("[Ÿ¡ø‹ÃÌº”≥…π¶]")
        else
            WriteLog("[Ÿ¡ø‹ÃÌ Th™m th t bπi]")
        end
    end
end

function AddGiftItem2All(npcIdx)


    local nYear, nMon, nDay = GetYMD()
    if not (nYear == 2015 and (nMon == 7 and nDay >= 26) or (nMon == 8 and nDay <= 26)) then
        return
    end

    if not (GetGameServerName() == "T¯ T≠Óng Th«n V˘c") then
        return
    end

    local oldPlayer = PlayerIndex
    local w, x, y = GetNpcWorldPos(npcIdx)
    local mapIdx = SubWorldID2Idx(w)
    local nPlayerCount = GetSubWorldPlayerCount(mapIdx)

    for i = 1, nPlayerCount do
        PlayerIndex = GetSubWorldPlayerIdxByNum(mapIdx, i)
        if (PlayerIndex > 0 and GetLevel() >= 60) then
            AddNormalItemBind(3, 1615, 0, 0, 0, 0, 1)
            Msg2Player("ChÛc mıng ngµi nhÀn Æ≠Óc ∑‚…Ò¡Ó.")
            WriteLog("NhÀn Æ≠Óc ∑‚…Ò¡Ó ÷Ì¡˝…Ò")
        end
    end
    PlayerIndex = oldPlayer
end



