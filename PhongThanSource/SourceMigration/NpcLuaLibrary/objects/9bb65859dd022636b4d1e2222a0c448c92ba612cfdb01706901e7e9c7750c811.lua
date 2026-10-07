--description: ·ç»ğÂÖ´óÈü»ìÌìÁèBuffµ½Ê±½Å±¾
--author: zhaoqingsong
--date: 2008-11-25

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ
-- 2 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1 Î÷ÃÅÒ½Éú£¬2 ÄÏÃÅÒ½Éú£¬3 ¶«ÃÅÒ½Éú£¬4 æûÍõ
Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278    -- ±¨ÃûÊ±¼ä
Task_Ring_BindingIndex = 1279    -- °ó¶¨µÄNpcIndex
Task_Ring_BindingID = 1280    -- °ó¶¨µÄNpcID

Task_Ring_NPC_FreezeTime = 1    -- ÀäÈ´Ê±¼ä´Á
Task_Ring_NPC_BuffATime = 2    -- BuffAÊ±¼ä´Á
Task_Ring_NPC_BuffBTime = 3    -- BuffBÊ±¼ä´Á
Task_Ring_NPC_BuffCTime = 4    -- BuffCÊ±¼ä´Á
Task_Ring_NPC_BuffDTime = 5    -- BuffDÊ±¼ä´Á

Buff_Ring_Going = 487   -- ½øĞĞBuff
Buff_Ring_BuffA = 488   -- ËÙ¶È¼õ°ëBuff
Buff_Ring_BuffB = 489   -- ·´ÏòÅÜ¶¯Buff
Buff_Ring_BuffC = 490   -- ËÙ¶È¼Ó±¶Buff
Buff_Ring_BuffD = 491   -- ¼õËÙ10%Buff

Task_Info_Ring = 1020   -- ·ç»ğÂÖ´óÈüF11

Task_Ring_Match_Second = 600 -- Ê®·ÖÖÓÒ»³¡±ÈÈü

--Add By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
Noon_Active_Event = 7    --Îç¼ä»î¶¯ÊÀ½çÊÂ¼ş
Noon_Active_Event_Day = 1    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-Ê±¼ä±äÁ¿
Noon_Active_Event_Num = 2    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-»î¶¯ĞòºÅ

function Check_NoonActive_ON(nNum)
    if (IsWorldEventExist(Noon_Active_Event) == 0) then
        return 0
    end
    local nCurDay = floor(LocalSystemTime() / 86400);

    if GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Day) == nCurDay
            and GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Num) == nNum then
        return 1
    end

    return 0
end
--Add By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End

Active_List = {--»î¶¯Ãû	¼¶±ğÏŞÖÆ taskinfoID ½áÊøÊ±¼ä
    [1] = { "PhongHáaL«i§µi", 40, 1614, 14 * 3600 },
    [2] = { "Khiªu chiÕn cùc h¹n", 40, 1615, 14 * 3600 },
    [3] = { "Thi nĞm TuyÕt", 40, 1617, 14 * 3600 },
    [4] = { "Tam NguyÖt Kú S¬n", 40, 1618, 14 * 3600 },
    [5] = { "T×m b¶o tµng", 40, 1619, 14 * 3600 },
    [6] = { "Cuéc thi ChØ Diªn", 40, 1620, 14 * 3600 },
    [7] = { "Trãc Quû ®èi kh¸ng", 40, 1621, 14 * 3600 },
}

function main()
    SetTask(Task_Ring_Status, 0)
    TaskNote(Task_Info_Ring, -1)

    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-27 Begin
    if Check_NoonActive_ON(1) > 0 then
        SyncBibleState(1614, 3, 1)
    else
        SyncBibleState(1020, 3, 1)
    end
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-27 End

    Msg2Player("TiÕc qu¸! B¹n ®· hoµn thµnh chËm thêi gian…Hoan nghªnh lÇn sau l¹i ®Õn tham gia!")
    TopMessage("Tham gia Phong Háa lu©n thÊt b¹i")
end
