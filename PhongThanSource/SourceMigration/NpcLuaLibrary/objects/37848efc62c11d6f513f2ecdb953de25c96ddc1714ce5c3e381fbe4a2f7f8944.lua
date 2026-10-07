--³Ë»Æ´óÍõ.lua
--author:gaojingwei
--date:2009/5/18

Task_Process = 1458   --1byte:1½ÓÈÎÎñ£¬2µÃµ½ÙÈ²®ÒæµÄ½±Àø£¬3ÁìÈ¡ÁÔÉ±³Ë»ÆµÄÈÎÎñ£¬4ÊÍ·Å³Ë»ÆNpc£¬5ÊÍ·ÅÕ½¶·³Ë»Æ£¬ 6Õ½Ê¤³Ë»Æ´óÍõ
--2byte:µ±Ìì½ÓÈÎÎñ´ÎÊı£»3byte:1µ¥±¶£¬2Ë«±¶£»4byte:É±ËÀ³Ë»ÆµÄ¸öÊı
Task_Type = 1459      --1byte:1½ÓµÄÊÇÃîÊÖÉñÒ½µÄÈÎÎñ£¬2½ÓµÄÊÇÁ¶ÖÆÃÔÒ©µÄÈÎÎñ
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊı
Task_Accept_Day = 1461  --½ÓÈÎÎñµÄÈÕÆÚ
Task_Coordinate = 1462  --1word:ËøÑıÕòx×ø±ê£»2word£ºy×ø±ê
Task_MonsterID = 1463    --³Ë»Æ(ÀçÁéÊ¬µÄID)
Task_Free_Time = 1464    --³Ë»Æ´óÍõ(×çÖäÖ®ÀçÁéÊ¬)µÄindex

chenghuangNpcID = 1005    --³Ë»Æ´óÍõNpcµÄtemplateID
chenghuangID = 1003        --³Ë»Æ´óÍõµÄtemplateID
lilingNpcID = 1006        --ÏÄÁéÊ¬´óÍõNpcµÄtemplateID
lilingID = 1004            --ÏÄÁéÊ¬´óÍõµÄtemplateID
amberNum = 3            --ĞèÒª½ÉÄÉµÄçúçêÖ®ĞÄµÄ¸öÊı
blastID = 1007            --ËøÑıÕòµÄID
buffID = 682            --ËøÑıÕòbuffµÄID

questyKey = {
    [1] = { name = "Canh Håi Hån", key = 250 },
    [2] = { name = "Ng­ H×nh th¶o", key = 251 },
    [3] = { name = "Long Ng¹n th¶o", key = 252 }
}

taskItem = {
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

function OnDeath(npcindex)
    local mapid, x, y = GetNpcWorldPos(npcindex)
    if (GetTask(Task_MonsterID) == GetNpcID(npcindex) and GetTaskByte(Task_Process, 1) == 5) then
        local mapid, x, y = GetNpcWorldPos(npcindex)
        local blastX = GetTaskWord(Task_Coordinate, 1)
        local blastY = GetTaskWord(Task_Coordinate, 2)

        if (((blastX - x) ^ 2 + (blastY - y) ^ 2 < 500) and (HaveIBBuff(buffID) > 0)) then
            SetTaskByte(Task_Process, 1, 6)
            AddEventItem(questyKey[2].key)                --µÃµ½ÓãĞĞ²İ
            --		ScrollMessage("³É¹¦½µ·ü³Ë»Æ´óÍõ")
            Msg2Player("§· chÕ phôc ®­îc ThiÕt Tinh §¹i V­¬ng")
            TopMessage("NhËn ®­îc <c=yel>" .. questyKey[2].name)
            TaskNote(1077, 3)
        elseif (((blastX - x) ^ 2 + (blastY - y) ^ 2 >= 500) and (HaveIBBuff(buffID)) > 0) then
            TopMessage("Kh«ng cã Thiªn C­¬ng phï ph¸p trî gióp, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ ThiÕt Tinh ®¹i v­¬ng")
            SetTaskByte(Task_Process, 1, 7)
            Msg2Player("V× kh«ng kŞp thêi sö dông Khu Ma phï, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ chç ThiÕt Tinh ®¹i v­¬ng.")
            TaskNote(1077, 6)
        else
            SetTaskByte(Task_Process, 1, 7)
            Msg2Player("V× kh«ng kŞp thêi sö dông Khu Ma phï, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ chç ThiÕt Tinh ®¹i v­¬ng.")
            TaskNote(1077, 6)
        end
    end
    DelNpc(npcindex)
end
