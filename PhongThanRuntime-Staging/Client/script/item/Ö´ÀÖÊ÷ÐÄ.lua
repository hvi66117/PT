task_poluo_renwu = 1525

task_poluo_npcidx = 1526

item = {
    [1] = {
        { "(225,217)", 225, 217, },
        { "(228,204)", 228, 204, },
        { "(232,218)", 232, 218, },
        { "(243,224)", 243, 224, },
    },

    [2] = {
        { "(211,205)", 211, 205, },
        { "(212,223)", 212, 223, },
        { "(221,234)", 221, 234, },
        { "(207,224)", 207, 224, },
    },
    [3] = {
        { "C©y vinh dù", 1188, 2, 2 },
        { "C©y kh«", 1187, -2, -2 },
        { "Sa La Song Thô", 1189, 0, 0 },
    }
}

function main()
    local state = GetTaskByte(task_poluo_renwu, 1)
    if (state ~= 7) then
        DelNormalItem(6, 1, 544, 0)
        Msg2Player("ChÊp L¹c Thô ®· chÕt, kh«ng thÓ trång Sa La Song Thô")
        return
    end

    local treestate = GetTaskByte(task_poluo_renwu, 2)
    if (treestate > 0) then
        return
    end

    local H, _, _ = GetHMS()
    if (H < 18) then
        Talk(1, "no", "Theo truyÒn thuyÕt, sau khi mÆt trêi lÆn (18:00-24:00), Sa La Song Thô míi xuÊt hiÖn.")
        return
    end

    local mapid, px, py = GetWorldPos()
    local key = 1
    if (GetJusticEvilCredit() < 0) then
        key = 2
    end
    local str_pos = ""
    for i = 1, 4 do
        str_pos = str_pos .. item[key][i][1]
    end
    str_pos = str_pos .. "4 ®iÓm nµy "

    if (mapid ~= 76) then
        Msg2Player("Thô T©m cÇn ®Õn gÇn §Çm NguyÖt Nha ë B¶n TuyÒn Th¸nh §Þa" .. str_pos .. " ®Ó trång")
        return 0
    end

    local fx = math.floor(px / 8)
    local fy = math.floor(py / 16)
    local temp, tx, tp = 0, 0, 0
    for i = 1, 4 do
        temp = item[key][i]
        if (fx == temp[2]) and (fy == temp[3]) then
            tx = fx
            ty = fy
            break
        end
    end
    if (tx == 0) or (ty == 0) then
        Msg2Player("Thô T©m cÇn ®Õn gÇn §Çm NguyÖt Nha ë B¶n TuyÒn Th¸nh §Þa" .. str_pos .. " ®Ó trång")
        return 0
    end

    local nNpcIdx = -1
    for j = 1, 3 do
        temp = item[3][j]
        nNpcIdx = SearchNpcByNameAt(temp[1], SubWorld, (tx * 8 + temp[3]) * 32, (ty * 16 + temp[4]) * 32, 3)
        if (nNpcIdx > 0) then
            Talk(1, "no", "N¬i nµy ®· trång Sa La Song Thô, ph¶i ®îi nã mÊt ®i míi cã thÓ trång tiÕp Thô T©m.")
            return 0
        end
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(state, 1, 10, "\\script\\item\\Ö´ÀÖÊ÷ÐÄ.lua", nInterrupt)
end;

function no()
    CloseDialog()
end;

function EndMotion(MotionID)
    local state = GetTaskByte(task_poluo_renwu, 1)
    if (MotionID == state) then
        local nNpcIdx = -1
        local temp
        local mapid, px, py = GetWorldPos()
        for j = 1, 3 do
            temp = item[3][j]
            nNpcIdx = SearchNpcByNameAt(temp[1], SubWorld, (px + temp[3]) * 32, (py + temp[4]) * 32, 3)
            if (nNpcIdx > 0) then
                Talk(1, "no", "N¬i nµy ®· trång Sa La Song Thô, ph¶i ®îi nã mÊt ®i míi cã thÓ trång tiÕp Thô T©m.")
                return 0
            end
        end

        temp = item[3][1]
        local npcidx = AddNpc(temp[2], 1, SubWorld, (px + temp[3]) * 32, (py + temp[4]) * 32)
        if (npcidx > 0) then
            SetNpcScript(npcidx, "\\script\\ÚæÈªÊ¥µØ\\Ö´ÀÖÈÙÊ÷.lua")
            temp = item[3][2]
            local npcidx1 = AddNpc(temp[2], 1, SubWorld, (px + temp[3]) * 32, (py + temp[4]) * 32)
            if (npcidx1 > 0) then
                SetNpcScript(npcidx1, "\\script\\ÚæÈªÊ¥µØ\\Ö´ÀÖ¿ÝÊ÷.lua")
                SetNpcTask(npcidx, 1, GetPlayerID())
                SetNpcTask(npcidx1, 1, GetPlayerID())
                SetNpcTask(npcidx, 2, npcidx1)
                SetNpcTask(npcidx1, 2, npcidx)
                SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 3)
                SetNpcTimer(npcidx1, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 3)
                SetTaskBit(task_poluo_renwu, 9, 1)
                SetTask(task_poluo_npcidx, LocalSystemTime())
                DelNormalItem(6, 1, 544, 0)
                TopMessage("Trång ®­îc Sa La Song Thô")

                if (GetJusticEvilCredit() < 0) then
                    TaskNote(113, 6)
                else
                    TaskNote(112, 6)
                end
            else
                DelNpc(npcidx)
            end
        end
    end
end
