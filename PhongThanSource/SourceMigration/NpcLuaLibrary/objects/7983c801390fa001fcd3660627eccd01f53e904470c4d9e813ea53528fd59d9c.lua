--description:ÆßÔªÐÇ¾ý
--author: Zhaoqingsong
--date:2009-5-27

-- 50¼¶¶È½ÙÈÎÎñ À×öªÆðÀý

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0Î´½ÓÈÎÎñ£¬1»ñµÃµÀ¾ß£¬2Ê¹ÓÃµÀ¾ß£¬
--					3ÁìÈ¡ÈÎÎñ£¬4ÈÎÎñÊ§°Ü£¬10ÈÎÎñ½áÊø
-- 2 Byte ÈÎÎñÀàÐÍ£¬1 À×ÃÅ£¬2 Óê»§
Task_Thunder_Status = 1469
Task_Thunder_Time = 1470
Task_Var_DuJie = 1285   -- ¶È½ÙÈÎÎñ±äÁ¿£¬Ðè²Î¿¼¶È½ÙÈÎÎñ

Global_Thunder = 210    --1Byte À×ÃÅ£¬2Byte Óê»§
Buff_Thunder_A = 689
Buff_Thunder_B = 688
Task_Info_Thunder = 1079    -- F11
Point_init = 20

Tower_Camp = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177, camp = 9, flagid = 890 },
    { desc = "Ma ph¸i", name = "", gtask = 178, camp = 10, flagid = 889 },
}

--Modified By Guoqun for Bug£ºfsb00032224 at 2010-12-22 Begin
Thunder_Boss = {
    { desc = "Tr¸i trªn", name = "L«i M«n [214,217]", x = 1714, y = 3475, x2 = 1718, y2 = 3472, small = 1054 },
    { desc = "Ph¶i d­íi", name = "Vò Hé [238,226]", x = 1904, y = 3615, x2 = 1899, y2 = 3611, small = 1055 },
}
--Modified By Guoqun for Bug£ºfsb00032224 at 2010-12-22 End

--AS GaoJingwei 2009/08/02
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02

function main()
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    local taskPos = GetTaskByte(Task_Thunder_Status, 2)
    local npcPos = GetNpcTask(DialogNpcIdx, 1)
    if (taskStatus ~= 3) then
        Talk(1, "no", "ThÊt Nguyªn Tinh qu©n:Ng­¬i kh«ng ph¶i lµ ng­êi ®­îc chän.")
        return
    elseif (taskPos ~= npcPos) then
        Talk(1, "no", "ThÊt Nguyªn Tinh qu©n:Ng­¬i cÇn chinh phôc lµ" .. Thunder_Boss[taskPos].name .. "N¬i cña Tinh qu©n, mau ®i ®i.")
        return
    else
        local credit = GetJusticEvilCredit()
        SetTaskByte(Task_Thunder_Status, 1, 10)
        TaskNote(Task_Info_Thunder, -1)
        ClearItem(6, 1, 521, 1)
        RemoveIBBuff(Buff_Thunder_A)
        -- ´ò¿ª50¼¶µÈ¼¶ÏÞÖÆ
        JEMainTaskComplete(2)
        SetTaskByte(Task_Var_DuJie, 1, 2)
        -- ´ò¿ª45000ÉùÍûÏÞÖÆ
        Msg2Player("Ng­¬i ®· cã thÓ th¨ng ®Õn ®¼ng cÊp cao h¬n vµ ®¹t nhiÒu danh väng h¬n.")
        -- ¿ªÆô£¨ÉùÍûÏà¹ØµÄ£©³ÆºÅ
        ActiveTitleFunc(1)
        initpoint()
        if (credit > 0) then
            ActiveTitleQualify(20)
            SetCurTitle(20)
            Msg2Player("NhËn ®­îc danh x­ng Linh §éng Tiªn.")
        else
            ActiveTitleQualify(21)
            SetCurTitle(21)
            Msg2Player("NhËn ®­îc danh x­ng HuyÒn Vùc Ma.")
        end
        Talk(1, "no", "ThÊt Nguyªn Tinh qu©n:L«i Ph¸p lµ s¬ bé v­ît qua Thiªn KiÕp, sau nµy cßn cã thÓ gióp ng­¬i hµng ma phôc yªu, vËn dông nh­ thÕ nµo th× xem b¶n th©n ng­¬i th«i.")
        DelNpc(DialogNpcIdx)
        WriteLog("Hoµn thµnh <L«i §×nh Khëi LiÖt> ®é kiÕp cÊp 50")
        local controlThunder = GetGlobalValue(Global_Thunder)
        SetGlobalValue(Global_Thunder, SetByte(controlThunder, npcPos, 0))
    end
end

function initpoint()
    --×ªÉúºó1¼¶»ñµÃ20µã
    -- ³õÊ¼»¯Ç±ÄÜµã
    for i = 0, 3 do
        AddAssignedAttrib(i, -GetAssignedAttrib(i))
    end

    local nums = floor(Point_init / 4)
    for j = 0, 3 do
        AddAssignedAttrib(j, nums)
    end
    Msg2Player("Sau khi ®é kiÕp sÏ nhËn ®­îc 10 ®iÓm tiÒm n¨ng")
    ApplyAssignedAttrib()
end

function no()
    CloseDialog()
end

