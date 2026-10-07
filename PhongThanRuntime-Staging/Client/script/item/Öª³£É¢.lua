task_poluo_renwu = 1525

task_poluo_npcidx = 1526

function main()
    local mapid, x, y = GetWorldPos()
    if (mapid ~= 76) then
        Msg2Player("Ph¶i ®Õn B¶n TuyÒn Th¸nh §Þa sö dông ")
        return 0
    end

    local state = GetTaskByte(task_poluo_renwu, 1)
    if (state == 6) then
        local npcidx = GetTask(task_poluo_npcidx)
        if (npcidx > 0) and (HaveNormalItem(6, 1, 547, 0) > 0 or HaveNormalItemInQuick(6, 1, 547, 0)) and (GetNpcTemplateID(npcidx) == 1190) then
            local nowtime = math.mod(LocalSystemTime(), 2 ^ 16)
            local lasttime = GetTaskWord(task_poluo_renwu, 2)
            if (lasttime + 120 < nowtime) then
                SetTaskWord(task_poluo_renwu, 2, nowtime)
                NpcAddIBBuff(npcidx, 760)
            else
                Msg2Player("Sö dông víi ChuÈn ChÊp Th­êng Thô, sÏ tiªu trõ tr¹ng th¸i v« ®Þch cña c©y nµy trong 1 phót, thêi gian chê cña kü n¨ng (®¹o cô) lµ 2 phót.")
            end
        end
        return 0
    end

    if (state == 7) then
        local npcidx = GetTask(task_poluo_npcidx)
        if (npcidx > 0) and (HaveNormalItem(6, 1, 548, 0) > 0 or HaveNormalItemInQuick(6, 1, 548, 0)) and (GetNpcTemplateID(npcidx) == 1191) then
            local nowtime = math.mod(LocalSystemTime(), 2 ^ 16)
            local lasttime = GetTaskWord(task_poluo_renwu, 2)
            if (lasttime + 120 < nowtime) then
                SetTaskWord(task_poluo_renwu, 2, nowtime)
                AddIBBuff(761)
            else
                Msg2Player("Sö dông sÏ tiªu trõ c¸c tr¹ng th¸i kh«ng tèt cña b¶n th©n trong 1 phót, thêi gian chê cña kü n¨ng (®¹o cô) lµ 2 phót.")
            end
        end
        return 0
    end

    if (state == 8) then
        local npcidx = GetTask(task_poluo_npcidx)
        if (npcidx > 0) and (HaveNormalItem(6, 1, 549, 0) > 0 or HaveNormalItemInQuick(6, 1, 549, 0)) and (GetNpcTemplateID(npcidx) == 1192) then
            local nx = GetTaskByte(task_poluo_renwu, 3) * 8
            local ny = GetTaskByte(task_poluo_renwu, 4) * 16
            if (nx > 0) and (ny > 0) then
                local dirname = { "ChÝnh B¾c", "§«ng B¾c", "ChÝnh §«ng", "§«ng Nam", "ChÝnh Nam", "T©y Nam", "ChÝnh T©y", "T©y B¾c" }
                TopMessage("ChÊp Ng· Thô Hån ®ang ë phÝa <c=g>" .. dirname[GetDir(x, y, nx, ny)] .. "<c>.")
            end
        end
        return 0
    end

    if (state == 9) then
        local npcidx = GetTask(task_poluo_npcidx)
        local TargetNpcIdx = GetPlayerTarget()
        if (TargetNpcIdx == npcidx) then
            if (npcidx > 0) and (HaveNormalItem(6, 1, 550, 0) > 0 or HaveNormalItemInQuick(6, 1, 550, 0)) and (GetNpcTemplateID(npcidx) == 1193) then
                local tempidx = -1
                for i = 6, 13 do
                    tempidx = GetNpcTask(npcidx, i)
                    if (GetNpcTask(npcidx, i + 8) == GetNpcID(tempidx)) then
                        DelNpc(tempidx)
                    end
                end
                ClearItem(6, 1, 550, 0)
            else
                Msg2Player("Sö dông víi ch©n th©n cña ChuÈn ChÊp TÞnh Thô sÏ diÖt trõ c¸c ph©n th©n cña c©y nµy.")
            end
        else
            Msg2Player("Sö dông víi ch©n th©n cña ChuÈn ChÊp TÞnh Thô sÏ diÖt trõ c¸c ph©n th©n cña c©y nµy.")
        end
        return 0
    end
end;

function no()
    CloseDialog()
end;

function GetDir(x0, y0, x1, y1)
    local x = x1 - x0
    local y = y1 - y0

    if (x == 0 and y < 0) then
        return (1)
    elseif (x == 0 and y > 0) then
        return (5)
    end

    local tan = y / x
    if (tan >= -2 and tan <= -0.5 and x < 0 and y > 0) then
        return (6)
    elseif (tan >= -2 and tan <= -0.5 and x > 0 and y < 0) then
        return (2)
    elseif (tan >= 0.5 and tan <= 2 and x < 0 and y < 0) then
        return (8)
    elseif (tan >= 0.5 and tan <= 2 and x > 0 and y > 0) then
        return (4)
    elseif (tan > -0.5 and tan < 0.5 and x <= 0) then
        return (7)
    elseif (tan > -0.5 and tan < 0.5 and x >= 0) then
        return (3)
    elseif ((tan > 2 or tan < -2) and y < 0) then
        return (1)
    elseif ((tan > 2 or tan < -2) and y > 0) then
        return (5)
    end
    return (5)
end
