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

    WriteLog("Phñ ®Çu l·o ®¹i tö väng" .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcIdx, 9))

    SetInstanceTempValue(1, 2)
    InstanceMsg2All(InstanceIndex, "Th«ng b¸o", "<c=yel> Phñ ®Çu l·o ®¹i bÞ ®¸nh b¹i, tæ ®éi cã thÓ v­ît ¶i tiÕp theo! H·y t×m Bao Bµ Bµ ®èi tho¹i!<c>")
    NpcSay(npcIdx, "Cã thÓ ®¸nh b¹i ta thùc lùc qu¶ lµ kh«ng tÖ, nh­ng Tr­u Long ThÇn ¶i tiÕp theo sÏ ®¸nh b¹i c¸c ng­¬i!")

    DelNpc(npcIdx)
    InstanceIndex = oldInstance
end

