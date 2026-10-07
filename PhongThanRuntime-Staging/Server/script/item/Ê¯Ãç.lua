Task_renwu = 1263
Task_nidx = 1264
Task_nid = 1265
Task_tree_time = 1266
Task_extra = 1552
Task_exnidx = 1553
Task_exnid = 1554
Task_extree_time = 1555

function main()
    if (HaveIBBuff(477) == 0) then
        Talk(1, "no", GetName() .. ": Th¹ch Miªu ®· hÕt b¶o hé, hiÖn thêi kh«ng thÓ trång!")
        DelNormalItem(6, 1, 391, 0)
        return 0
    end

    if (HaveIBBuff(478) == 0) then
        Talk(1, "no", GetName() .. ": §Þa KhÝ ®· mÊt, hiÖn thêi kh«ng thÓ trång!")
        DelNormalItem(6, 1, 391, 0)
        return 0
    end

    if (GetFreeNpcCount() >= 200) then
        if (GetTask(Task_nidx) == 0) and (GetByte(GetTask(Task_renwu), 3) == 1) then
            MsgBox(GetName() .. "Th¹ch Miªu ph¶i trång ë chç §Þa KhÝ sung m·n, trång kh«ng?", "SetTree", "no")
        elseif (GetTask(Task_exnidx) == 0) and (GetByte(GetTask(Task_renwu), 3) == 1) then
            MsgBox(GetName() .. "Th¹ch Miªu ph¶i trång ë chç §Þa KhÝ sung m·n, trång kh«ng?", "SetTree", "no")


        end
    else
        Talk(1, "no", GetName() .. ":N¬i ®©y ®Êt chËt ng­êi ®«ng!")
    end
end;

function no()
    CloseDialog()
end;

function SetTree()
    CloseDialog()
    local w, x, y = GetWorldPos()
    if (w ~= 14) then
        Msg2Player("N¬i nµy kh«ng ph¶i lµ n¬i tô héi §Þa KhÝ")
        TopMessage(14337)
        return 0
    end

    if (x < 1604) or (x > 1800) or (y < 3079) or (y > 3900) then
        Msg2Player("N¬i nµy kh«ng ph¶i lµ n¬i tô héi §Þa KhÝ")
        TopMessage(14337)
        return 0
    end

    if (GetCamp() ~= 3) then
        Msg2Player("CÇn ph¶i lµ phe xanh")
        TopMessage(14338)
        return 0
    end

    local npcTreeIdx = AddNpc(733, GetLevel(), SubWorld, x * 32, y * 32)
    if (npcTreeIdx > 0) then
        if (HaveNormalItem(6, 1, 391, 0) > 0) then
            SetNpcScript(npcTreeIdx, "\\script\\äü¹Ø\\Ê¯Ãç.lua")
            SetNpcTimer(npcTreeIdx, "\\script\\ontimer\\ÁéÊ¯.lua", 180)
            SetNpcName(npcTreeIdx, GetName())
            local mark = GetTask(Task_extra)
            if (mark == 1) then
                SetTask(Task_exnidx, npcTreeIdx)
                SetTask(Task_exnid, GetNpcID(npcTreeIdx))
                SetTask(Task_extree_time, SystemTime())
                DelNormalItem(6, 1, 391, 0)
                RemoveIBBuff(477)
            else
                SetTask(Task_nidx, npcTreeIdx)
                SetTask(Task_nid, GetNpcID(npcTreeIdx))
                SetTask(Task_tree_time, SystemTime())
                SetTask(Task_extra, 1)
            end
            SetCamp(3)
            SetNpcCurCamp(npcTreeIdx, 3)
            TaskNote(84, 2)
            TopMessage(14339)
            Msg2Player("Trång h¹t thµnh c«ng, ph¶i b¶o vÖ 3 phót sau ®Ó Th¹ch Miªu trë thµnh Linh Th¹ch")
        else
            DelNpc(npcTreeIdx)
            Talk(1, "no", 14340)
        end
    else
        Talk(1, "no", GetName() .. " VÉn ch­a trång thµnh c«ng, xin chó ý xem l¹i!")
    end
end
