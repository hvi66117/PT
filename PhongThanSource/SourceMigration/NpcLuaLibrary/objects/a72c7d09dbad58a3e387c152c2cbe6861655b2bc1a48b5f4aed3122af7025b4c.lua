Task_renwu20 = 1377
Task_renwu20_distance = 1378

function main()
    CloseDialog()
    if (HaveIBBuff(633) == 0) then
        Talk(1, "no", "Thêi gian ®· hÕt, mau t×m ¤ng l·o h¸i thuèc nghÜ c¸ch kh¸c!")
        return 0
    end

    if (GetLevel() < 20) or (GetTaskByte(Task_renwu20, 3) == 0 or GetTaskByte(Task_renwu20, 4) == 0) or (GetTaskByte(Task_renwu20, 3) == 4) then
        if (DelNormalItem(6, 1, 475, 0) == 0) then
            DelNormalItemInQuick(6, 1, 475, 0)
        end
        Talk(1, "no", "La Bµn thÇn bÝ ®· biÕn mÊt!")
        return 0
    end

    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= 14) then
        Talk(1, "no", "D­êng nh­ Hång S¸t ma v­¬ng ®ang trèn ë <c=g>§ång Quan<c>!")
    else
        local px = GetTaskByte(Task_renwu20, 3) * 8
        local py = GetTaskByte(Task_renwu20, 4) * 16
        local distance = (x1 - px) ^ 2 + (y1 - py) ^ 2
        local lastdist = GetTask(Task_renwu20_distance)
        SetTask(Task_renwu20_distance, distance)

        local lightname = {
            [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
            [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
            [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
            [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
        }

        local light = 1
        if (distance <= 25) then
            light = 4
        elseif (distance <= 400) then
            light = 3
        elseif (distance <= 2500) then
            light = 2
        end
        local msg = "La Bµn thÇn bÝ ph¸t ra" .. lightname[light]

        if (lastdist == -1) then
            msg = msg .. "D­êng nh­ Hång S¸t ma v­¬ng ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "Hång S¸t ma v­¬ng ®ang ë quanh ®©y, b¹n muèn thö vËn may kh«ng!"
                MsgBox(msg, "wabao", "no")
                return 0
            else

                local dirname = { "ChÝnh B¾c", "§«ng B¾c", "ChÝnh §«ng", "§«ng Nam", "ChÝnh Nam", "T©y Nam", "ChÝnh T©y", "T©y B¾c" }
                TopMessage("Hång S¸t Ma V­¬ng trong <color=green>" .. dirname[GetDir(x1, y1, px, py)] .. "<c> täa ®é cña Cöu Di")
                return 0


            end
        end
        Talk(1, "no", msg)
    end ;
end;

function wabao()
    CloseDialog()
    if (HaveIBBuff(633) == 0) then
        Talk(1, "no", "Thêi gian ®· hÕt, mau t×m ¤ng l·o h¸i thuèc nghÜ c¸ch kh¸c!")
        return 0
    end

    if ((HaveNormalItem(6, 1, 475, 0) >= 1) or (HaveNormalItemInQuick(6, 1, 475, 0) >= 1)) then
        local px = GetTaskByte(Task_renwu20, 3) * 8 * 32
        local py = GetTaskByte(Task_renwu20, 4) * 16 * 32
        local npcidx = AddNpc(16, 30, SubWorld, px, py)

        if (npcidx > 0) then
            SetNpcScript(npcidx, "\\script\\¹ÖÎï\\ºìÉ·Ä§Íõ.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", GetIBBuffLeftTimes(633))
            SetNpcTask(npcidx, 1, GetPlayerID())
            SetNpcName(npcidx, "<c=g>Hång S¸t ma v­¬ng<c>")
            NpcPolyMorph(npcidx, 12)

            if (DelNormalItem(6, 1, 475, 0) == 0) then
                DelNormalItemInQuick(6, 1, 475, 0)
            end
            SetTaskByte(Task_renwu20, 2, 5)
            SetTaskByte(Task_renwu20, 3, 0)
            SetTaskByte(Task_renwu20, 4, 0)
            SetTask(Task_renwu20_distance, 0)
            TaskNote(202, 6)
            Msg2Player("Trong tr¹ng th¸i Trõ ma t×m vµ thu phôc Hång S¸t ma v­¬ng")
        end
    end
end

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

function no()
    CloseDialog()
end	
