build_renwu = 1255
build_npcIdx = 1256
build_npcId = 1257
build_nums = 1258

function main()
    if (GetTask(build_npcIdx) > 0) and (SystemTime() <= (GetTask(build_nums) + 1800)) then
        Talk(1, "no", GetName() .. ": M×nh ®· nhËn lêi gióp Thæ Hµnh T«n x©y xong Hoa viªn nµy! Lµm xong råi h·y tÝnh tiÕp!")
        return 0
    end

    if (IsCaptain() ~= 1) then
        Talk(1, "no", GetName() .. "Thæ Hµnh T«n ®· nãi: ph¶i lµ ®éi tr­ëng míi cã thÓ ®èi tho¹i víi h¾n!")
        return 0
    end

    if (GetTask(build_npcIdx) > 0) and (GetByte(GetTask(build_renwu), 4) > 3) then
        MsgBox(14348, "building", "no")
    else
        building()
    end
end

function no()
    CloseDialog()
end

function building()
    CloseDialog()
    if (GetFreeNpcCount() < 200) then
        Talk(1, "no", 14349)
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w == 17) and (x >= 1590 and x <= 1935) and (y >= 3158 and y <= 3525) then
        local npcidx = AddNpc(728, 1, SubWorld, x * 32, y * 32)
        if (npcidx > 0) then
            if (HaveNormalItem(6, 1, 389, 0) > 0) then
                DelNormalItem(6, 1, 389, 0)
                SetNpcScript(npcidx, "\\script\\item\\´óÐËÍÁÄ¾.lua")
                SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1800)
                SetNpcName(npcidx, GetName())
                SetTask(build_npcIdx, npcidx)
                SetTask(build_npcId, GetNpcID(npcidx))
                SetTask(build_renwu, SetByte(GetTask(build_renwu), 4, 0))
                SetTask(build_nums, SystemTime())
                TaskNote(83, 1)
                Talk(1, "no", 14350)
            else
                DelNpc(npcidx)
                Talk(1, "no", 14351)
            end
        else
            Talk(1, "no", GetName() .. ":…Sao kh«ng cã t¸c dông g× thÕ!...Thö l¹i xem…!")
        end
    else
        Talk(1, "no", GetName() .. ": N¬i nµy h×nh nh­ kh«ng phï hîp. T×m n¬i kh¸c xem sao!")
    end
end
