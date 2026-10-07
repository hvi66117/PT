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
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

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
    MsgBox("Lª Linh Thi chó:TÊt c¶ Th¶o D­îc trªn Ngôc Ph¸p s¬n ®Òu lµ cña ta, liªn can g× ®Õn bän man di Êy, ta khuyªn ng­¬i tèt nhÊt ®õng ®èi ®Çu víi thÇn thó ë Ngôc Ph¸p s¬n! Ta cã thÓ gi¶i trõ Khu Ma phï cña YÓn V©n nªn ch¶ sî g× c¶.", "yes_Call", "no")
end

function yes_Call()
    CloseDialog()
    local npcindex = GetTask(142)
    if (GetNpcTemplateID(npcindex) ~= lilingNpcID) then
        return 0
    end

    local id, x, y = GetNpcWorldPos(npcindex)
    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 begin
    local monsterIndex = AddNpc(lilingID, 60, SubWorldID2Idx(id), x * 32, y * 32)
    if (monsterIndex > 0) then
        SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\×çÖäÖ®ÀçÁéÊ¬.lua")
        SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)

        SetTaskByte(Task_Process, 1, 5)
        SetTask(Task_MonsterID, GetNpcID(monsterIndex))
        SetTask(Task_Free_Time, monsterIndex)

        Msg2Player("Dô Lª Linh Thi chó ra, dïng Khu Ma phï hµng phôc h¾n")
        TopMessage("§· dô ra Lª Linh Thi")
        TaskNote(1078, 5)
    else
        InfoBox("Lª Linh Thi Phï Chó kh«ng thµnh c«ng! Anh hïng cã thÓ ®¸nh b¹i Lª Linh Thi lÇn n÷a, ®Ó dô Lª Linh Thi Phï Chó xuÊt hiÖn!")
        TaskNote(1078, 2)
    end
    DelNpc(npcindex)        --É¾µô¶Ô»°npc
    --modified by liujifang for Á¶ÖÆÃØÒ©ÓÅ»¯ at 2012-5-16 end
end

function no()
    CloseDialog()
end