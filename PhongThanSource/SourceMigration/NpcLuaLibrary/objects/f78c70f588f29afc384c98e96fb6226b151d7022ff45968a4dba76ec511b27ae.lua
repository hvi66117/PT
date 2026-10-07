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
        WriteLog("LÇn ®Çu nhËn nhiÖm vô phï chñ ®Ò ngµy.")
    else
        if (rank <= 300) then
            ThrowItem(npcIdx, -1, 6, 1, 1005, 0, 0, 0)
            WriteLog("X¸c suÊt" .. rank .. "/1000 nhËn ®­îc nhiÖm vô phï chñ ®Ò ngµy.")
        end
    end

    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcIdx, 9))
    local lefttime2 = 30 * 60

    if (math.abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime2 = math.abs(LocalSystemTime() - nFirstEnterTime)
    end

    WriteLog("Háa Tµ ThÇn  tö vong, " .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcIdx, 9))
    NpcSay(npcIdx, "Thùc lùc qu¶ kh«ng tÖ, sÏ cã 1 ngµy ta quay l¹i!")
    InstanceMsg2All(InstanceIndex, "Th«ng b¸o", "<c=yel>Háa Tµ ThÇn ®· bÞ ®¸nh b¹i, Tr­ Lung Thµnh Tr¹i t¹m thêi yªn b×nh råi!<c>")

    local sNames = "<RoleName=\"" .. GetName() .. "\">"
    local cachePlayerIndex = PlayerIndex
    local idx, nextPlayerIdx = 0, 0
    while 1 do
        idx, nextPlayerIdx = GetSessionNextPlayer(idx, 0)
        if (idx == 0) then
            break
        end
        if (cachePlayerIndex ~= nextPlayerIdx) then
            PlayerIndex = nextPlayerIdx
            sNames = sNames .. "," .. "<RoleName=\"" .. GetName() .. "\">"
        end
    end
    PlayerIndex = cachePlayerIndex
    AddGlobalCountNews("Ng­êi ch¬i <c=g>" .. sNames .. "<c>ÓÂÃÍÒì³£, ½µ·þÁË¸«Í·°ïÊÔÁ¶µÚÈý¹Ø×îÖÕBOSS»ðÐ°Éñ, ÖíÁý³ÇÕ¯ÔÝÊ±»Ö¸´Æ½¾²ÁË!", 1)
    NewServerMonkeyActivity()
    DelNpc(npcIdx)
    InstanceIndex = oldInstance
end

function NewServerMonkeyActivity()
    if (NewServerEx.g_ServerName ~= GetGameServerName()) then
        return
    end
    if (GetLevel() < 45) then
        return
    end
    if (NewServerEx.Pub_IsTongMonkeyTime() > 0) then
        SetTaskBit(2097, 11, 1)
        WriteLog("[Ho¹t ®éng m¸y chñ míi][Quèc VËn Th¹ch HÇu][Hoµn thµnh nhiÖm vô »÷É±»ðÐ°Éñ]")
    end
end

