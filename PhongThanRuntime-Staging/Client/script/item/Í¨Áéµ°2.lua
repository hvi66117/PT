YIBO_90_DESASTER_STATE = 1662

ELEVEN_DAY_BUFF = 1240

MonsterEgg = { name = "Trøng Th«ng Linh", Item = { 6, 1, 797, 1, 0, 0 } }

BossInfo = { name = "Bµn Cæ", id = 82 }

function main()
    local item = MonsterEgg.Item
    if (HaveIBBuff(ELEVEN_DAY_BUFF) > 0) then
        local mapid, x, y = GetWorldPos()
        if (mapid == 51) then
            local npcEggIdx = AddNpc(587, 0, SubWorld, x * 32, y * 32)
            SetNpcName(npcEggIdx, BossInfo.name .. "Trøng")
            SetNpcScript(npcEggIdx, "\\script\\¹ÖÎï\\90½ÙÄÑ¹ÖÎï.lua")
            SetNpcTimer(npcEggIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 30 * 60)
            SetNpcTask(npcEggIdx, 1, GetPlayerID())
            ClearItem(item[1], item[2], item[3], item[4])
        else
            Msg2Player("ChØ cã thÓ ch«n Trøng Th«ng Linh ë Khæn Tiªn cung tÇng 5")
        end
    else
        ClearItem(item[1], item[2], item[3], item[4])
        Msg2Player("Trong thêi gian quy ®Þnh b¹n ch­a hoµn thµnh nhiÖm vô KiÕp N¹n, Trøng Th«ng Linh bÞ vì!")
    end
end

function no()
    CloseDialog()
end
