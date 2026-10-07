YIBO_80_DESASTER_STATE = 1661

SEVEN_DAY_BUFF = 1239

MonsterEgg = { name = "Trøng Th«ng Linh", Item = { 6, 1, 793, 1, 0, 0 } }

BossInfo = {
    [2] = { name = "Cïng Kú", mapid = 41, mapName = "Long Uyªn", bossID = 1752, Item = { 6, 1, 794, 1, 0, 0 } },
    [4] = { name = "§µo Ngét", mapid = 36, mapName = "B¨ng Xuyªn Cùc", bossID = 1754, Item = { 6, 1, 796, 1, 0, 0 } },
    [3] = { name = "Thao ThiÕt", mapid = 31, mapName = "Hiªn Viªn tÇng 5", bossID = 1753, Item = { 6, 1, 795, 1, 0, 0 } },
    [1] = { name = "Hçn §én", mapid = 26, mapName = "Sa M¹c chÕt", bossID = 1751, Item = { 6, 1, 793, 1, 0, 0 } },
}

function main()
    local item = MonsterEgg.Item
    local nType = GetTaskByte(YIBO_80_DESASTER_STATE, 2)
    if (HaveIBBuff(SEVEN_DAY_BUFF) > 0) then
        local mapid, x, y = GetWorldPos()
        if (mapid == BossInfo[nType].mapid) then
            local npcEggIdx = AddNpc(587, 0, SubWorld, x * 32, y * 32)
            SetNpcName(npcEggIdx, BossInfo[nType].name .. "Trøng")
            SetNpcScript(npcEggIdx, "\\script\\¹ÖÎï\\80½ÙÄÑ¹ÖÎï.lua")
            SetNpcTimer(npcEggIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 30)
            SetNpcTask(npcEggIdx, 1, GetPlayerID())
            ClearItem(item[1], item[2], item[3] + nType - 1, item[4])
        else
            Msg2Player("ChØ cã thÓ ch«n Trøng Th«ng Linh ë " .. BossInfo[nType].mapName)
        end
    else
        ClearItem(item[1], item[2] + nType - 1, item[3], item[4])
        Msg2Player("Trong thêi gian quy ®Þnh b¹n ch­a hoµn thµnh nhiÖm vô KiÕp N¹n, Trøng Th«ng Linh bÞ vì!")
    end
end

function no()
    CloseDialog()
end
