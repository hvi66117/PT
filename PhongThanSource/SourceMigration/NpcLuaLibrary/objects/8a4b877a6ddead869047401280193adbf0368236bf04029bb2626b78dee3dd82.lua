--³Ë»Æ´óÍõNpc.lua
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

function main()
    local mapid, px, py = GetWorldPos()
    local item = taskItem[1].Item

    if (mapid ~= 75) then
        Talk(1, "no", "Kh«ng thÓ sö dông Khu Ma phï t¹i ®©y.")
        return
    end

    if (GetTaskByte(Task_Type, 1) == 1) then
        if (GetTaskByte(Task_Process, 1) ~= 5) then
            Talk(1, "no", "Khu Ma phï dïng ®Ó hµng phôc ThiÕt Tinh ®¹i v­¬ng, ph¸ gi¶i Kim Cang BÊt Ho¹i cña chóng, hiÖn ThiÕt Tinh ®¹i v­¬ng ch­a xuÊt hiÖn, ch­a cÇn sö dông.")
            return
        end
        local npcindex = GetTask(Task_Free_Time)
        if (GetNpcID(npcindex) ~= GetTask(Task_MonsterID)) then
            Talk(1, "no", "ThiÕt Tinh ®¹i v­¬ng ®· biÕn mÊt, lµm l¹i cã thÓ dô ThiÕt Tinh ®¹i v­¬ng xuÊt hiÖn l¹i!")
            return
        end
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "B¹n ®ang cã qu¸ nhiÒu tr¹ng th¸i, l¸t sau thö l¹i.")
            return
        end

        ClearItem(item[1], item[2], item[3], item[4])
        AddIBBuff(buffID)
        AddNpc(blastID, 1, SubWorld, px * 32, py * 32)

        SetNpcTask(npcindex, 1, px)            --¼ÇÂ¼ÔÚNpcÉíÉÏ
        SetNpcTask(npcindex, 2, py)

        SetTaskWord(Task_Coordinate, 1, px)
        SetTaskWord(Task_Coordinate, 2, py)

        SetNpcTimer(npcindex, "\\script\\ontimer\\¸Ä±ä·ÀÓù.lua", 5)
        Msg2Player("Phãng thİch Táa Yªu trËn, hµng phôc ThiÕt Tinh ®¹i v­¬ng trong trËn nµy sÏ dÔ dµng h¬n!")
    elseif (GetTaskByte(Task_Type, 1) == 2) then
        if (GetTaskByte(Task_Process, 1) ~= 5) then
            Talk(1, "no", "Khu Ma phï dïng ®Ó hµng phôc Lª Linh Thi chó, ph¸ gi¶i Kim Cang BÊt Ho¹i cña chóng, hiÖn Lª Linh Thi chó ch­a xuÊt hiÖn, ch­a cÇn sö dông.")
            return
        end

        local npcindex = GetTask(Task_Free_Time)
        if (GetNpcID(npcindex) ~= GetTask(Task_MonsterID)) then
            Talk(1, "no", "ThiÕt Tinh ®¹i v­¬ng ®· biÕn mÊt")
            return
        end
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "B¹n ®ang cã qu¸ nhiÒu tr¹ng th¸i, l¸t sau thö l¹i.")
            return
        end

        ClearItem(item[1], item[2], item[3], item[4])
        AddIBBuff(buffID)
        AddNpc(blastID, 1, SubWorld, px * 32, py * 32)

        SetNpcTask(npcindex, 1, px)            --¼ÇÂ¼ÔÚNpcÉíÉÏ
        SetNpcTask(npcindex, 2, py)

        SetTaskWord(Task_Coordinate, 1, px)
        SetTaskWord(Task_Coordinate, 2, py)

        SetNpcTimer(npcindex, "\\script\\ontimer\\¸Ä±ä·ÀÓù.lua", 5)
        Msg2Player("Phãng thİch Táa Yªu trËn, hµng phôc Lª Linh Thi chó trong trËn nµy sÏ dÔ dµng h¬n!")
    end
end

function no()
    CloseDialog()
end