--description: ÖÐÇï»î¶¯Ã¿ÈÕÔËÐÐ
--author: yangtao
--date: 2009/9/14
--------------------------- ÖÐÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ýÏÚ 
--                    3:È¥ÈýÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ý´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊý
-- 3byte:Ê±¼ä´Á
-- 4byte:¼ÇÂ¼ÊÇ·ñÒÑ¾­ÔÚ³¬¼¶ÔÂ±ý´¦ÁìÈ¡¹ýÌØÊâ½±Àø
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·þÎñÆ÷ËùÓÐÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊý
TaskNote_zhongqiu = 1103
--------------------------- ÖÐÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------
function main(nSysTaskTime)
    local y1, m1, d1 = Time2LocalYMD(nSysTaskTime)
    if ((y1 == 2009) and (m1 == 10) and (d1 >= 3) and (d1 <= 8)) then
        id = SubWorldID2Idx(20)
        if (id ~= -1) then
            local npcidx = AddNpc(1356, 1, id, 1449 * 32, 3086 * 32)
            SetNpcName(npcidx, "B¸nh cung tr¨ng")
            SetNpcScript(npcidx, "\\script\\»î¶¯½Å±¾\\³¬¼¶ÔÂ±ý.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 86400)
        end

        local p = GetFirstPlayerInAll()
        while (p > 0) do
            PlayerIndex = p
            local PlayerLevel = GetLevel()
            local localday = mod(floor(LocalSystemTime() / 86400), 255) + 1
            SetTask(Task_zhongqiu, 0)
            SetTaskByte(Task_zhongqiu, 3, localday)
            TaskNote(TaskNote_zhongqiu, -1)
            if ((d1 == 3) and (PlayerLevel >= 50)) then
                SendTextMailToSelf(4, "Ho¹t ®éng trung thu-Ngäc thè b¹n phóc", "Th¸ng 10 ®Õn, ngäc thè gi¸ng l©m, mang ®Õn bao niÒm vui, h·y nhanh chãng tham gia! §Õn chç TriÒu Ca [LÔ Quan], b¸o danh nhiÖm vô Ngäc thè b¹n phóc. Thêi gian ho¹t ®éng mçi ngµy tõ 18:00-24:00 tõ 03-10 ®Õn 08-10, mçi ngµy nhËn nhiÖm vô ®Õn 23:00!")
            end
            p = GetNextPlayerInAll()
        end
    end
end