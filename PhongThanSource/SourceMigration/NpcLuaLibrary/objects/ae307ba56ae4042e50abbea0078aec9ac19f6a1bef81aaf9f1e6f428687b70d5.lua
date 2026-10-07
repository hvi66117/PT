--×çÖäÖ®ÀçÁéÊ¬Npc.lua
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
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

function main()
    if (GetTaskByte(Task_Process, 1) ~= 4) then
        Talk(1, "no", "§Ìn nhµ ai nÊy s¸ng, ®õng lo chuyÖn cña ng­êi kh¸c!")
        return
    end

    if (GetTask(Task_MonsterID) ~= GetNpcID(DialogNpcIdx)) then
        Talk(1, "no", "§Ìn nhµ ai nÊy s¸ng, ®õng lo chuyÖn cña ng­êi kh¸c!")
        return
    end

    SetTask(142, DialogNpcIdx)
    MsgBox("TÊt c¶ d­îc th¶o trªn Ngôc Ph¸p S¬n nµy ®Òu lµ cña ta, kh«ng cã quan hÖ g× víi bän man di ®ã, ta khuyªn ng­¬i kh«ng nªn chèng ®èi víi tÊt c¶ thÇn thó trªn Ngôc Ph¸p S¬n nµy!", "yes_Call", "no")
end

function yes_Call()
    CloseDialog()
    local npcindex = GetTask(142)
    local id, x, y = GetNpcWorldPos(npcindex)

    local monsterIndex = AddNpc(lilingID, 60, SubWorldID2Idx(id), x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\×çÖäÖ®ÀçÁéÊ¬.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)

    SetTaskByte(Task_Process, 1, 5)
    SetTask(Task_MonsterID, GetNpcID(monsterIndex))
    SetTask(Task_Free_Time, monsterIndex)
    DelNpc(npcindex)        --É¾µô¶Ô»°npc

    Msg2Player("Gi¶i phãng ra Lª Linh Thi Phï Chó, dïng Khu Ma Phï cã thÓ hµn phôc h¾n.")
    TopMessage("Lª Linh Thi phãng thİch phï chó")
    --modified by liujifang for ÀçÁéÊ¬³öÏÖlog¼ÇÂ¼ at 2012-4-25 begin
    WriteLog(GetName() .. "Lª Linh Thi chó (Npc) xuÊt hiÖn t¹i b¶n ®å:" .. id .. ", täa ®é:" .. x .. "," .. y .. ".")
    --modified by liujifang for ÀçÁéÊ¬³öÏÖlog¼ÇÂ¼ at 2012-4-25 end
end

function no()
    CloseDialog()
end