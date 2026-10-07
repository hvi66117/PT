--description: ÆßÔªÐÇ¾ý¶¨Ê±
--author: Zhaoqingsong
--date: 2009-5-27

-- 50¼¶¶È½ÙÈÎÎñ À×öªÆðÀý

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0Î´½ÓÈÎÎñ£¬1»ñµÃµÀ¾ß£¬2Ê¹ÓÃµÀ¾ß£¬
--					3ÁìÈ¡ÈÎÎñ£¬4ÈÎÎñÊ§°Ü£¬10ÈÎÎñ½áÊø
-- 2 Byte ÈÎÎñÀàÐÍ£¬1 À×ÃÅ£¬2 Óê»§
Task_Thunder_Status = 1469
Task_Thunder_Time = 1470

Global_Thunder = 210    --1Byte À×ÃÅ£¬2Byte Óê»§
Buff_Thunder_A = 689
Buff_Thunder_B = 688
Task_Info_Thunder = 1079    -- F11

Tower_Camp = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177, camp = 9, flagid = 890 },
    { desc = "Ma ph¸i", name = "", gtask = 178, camp = 10, flagid = 889 },
}

Thunder_Boss = {
    { desc = "Tr¸i trªn", name = "L«i M«n", x = 1714, y = 3475, x2 = 1718, y2 = 3472, small = 1054 },
    { desc = "Ph¶i d­íi", name = "Vò Hé", x = 1904, y = 3615, x2 = 1899, y2 = 3611, small = 1055 },
}

function OnTimer(npcidx)
    local pos = GetNpcTask(npcidx, 1)
    local bindPlayerID = GetNpcTask(npcidx, 3)
    local playerIdx = SearchPlayerById(bindPlayerID)
    if (playerIdx > 0) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = playerIdx
        local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
        if (taskStatus == 3) then
            SetTaskByte(Task_Thunder_Status, 1, 4)
            TaskNote(Task_Info_Thunder, 3)
            RemoveIBBuff(Buff_Thunder_A)
            ClearItem(6, 1, 521, 1)
            Msg2Player("Chinh phôc ThÊt Nguyªn Tinh qu©n thÊt b¹i!")
            TopMessage("Chinh phôc ThÊt Nguyªn Tinh qu©n thÊt b¹i")
        end
        PlayerIndex = playerIndexCache
    end
    DelNpc(npcidx)
    local controlThunder = GetGlobalValue(Global_Thunder)
    SetGlobalValue(Global_Thunder, SetByte(controlThunder, pos, 0))
end;

