Task_eye_renwu = 1530
Task_eyelight_renwu = 1531

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local state = GetTaskByte(Task_eye_renwu, 3)
    if (state == 1) then
        local nGrouth = GetTaskByte(Task_eye_renwu, 4)
        TopMessage("Møc ch¨m sãc ®Õn <c=g>" .. nGrouth .. "%")
    elseif (state == 2) then
        local mapid, px, py = GetWorldPos()
        if (mapid ~= 76) then
            Talk(1, "no", " t¹i <c=g>B¶n TuyÒn Th¸nh §Þa<c> ch«n Long Hån!")
        else
            local pos = {
                [1] = {
                    { x = 224, y = 227 },
                    { x = 223, y = 222 },
                    { x = 209, y = 215 },
                    { x = 216, y = 208 },
                    { x = 216, y = 241 },
                },
                [2] = {
                    { x = 231, y = 221 },
                    { x = 243, y = 217 },
                    { x = 227, y = 218 },
                    { x = 225, y = 200 },
                    { x = 233, y = 207 },
                },
            }

            local creditkey = 1
            if (GetJusticEvilCredit() < 0) then
                creditkey = 2
            end

            local nkey = GetTaskByte(Task_eye_renwu, 4)
            if (nkey <= 0) or (nkey >= 5) then
                SetTaskByte(Task_eye_renwu, 4, math.random(1, 5))
                return
            end

            local x1 = pos[creditkey][nkey].x * 8
            local y1 = pos[creditkey][nkey].y * 16
            local distance = math.floor(math.sqrt((x1 - px) ^ 2 + (y1 - py) ^ 2))
            local lastdist = GetTaskWord(Task_eyelight_renwu, 2)
            if (distance <= 2 ^ 16 - 1) then
                SetTaskWord(Task_eyelight_renwu, 2, distance)
            end

            local lightname = {
                [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
                [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
                [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
                [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
            }

            local light = 1
            if (distance <= 5) then
                light = 4
            elseif (distance <= 20) then
                light = 3
            elseif (distance <= 50) then
                light = 2
            end
            local msg = "M¶nh M¾t Rång ph¸t ra " .. lightname[light]

            if (lastdist == -1) then
                msg = msg .. "Long Hån h×nh nh­ ë ngay trong khu vùc nµy!"
            else
                if (light == 4) then
                    msg = msg .. ". H·y triÖu håi Long Hån, tr­íc khi nã biÕn mÊt ph¶i thu phôc nã!"
                    MsgBox(msg, "wabao", "no")
                    return 0
                else
                    if (lastdist < distance) then
                        msg = msg .. ", H×nh nh­ b¹n ®· ®i <color=red>ra xa<color> Long Hån."
                    else
                        msg = msg .. ", H×nh nh­ b¹n ®ang <color=red>®Õn gÇn<color> Long Hån."
                    end
                end
            end
            Talk(1, "no", msg)
        end ;
    elseif (state == 3) then
        Msg2Player(" ®· hÕt thêi gian, nhiÖm vô thÊt b¹i")
    else
        Msg2Player("Chinh phôc Long Hån. Mau vÒ phôc mÖnh Tu Hµnh S­.")
    end
end

function wabao()
    CloseDialog()
    local state = GetTaskByte(Task_eye_renwu, 3)
    if (state == 2) then
        local mapid, px, py = GetWorldPos()
        local bossidx = AddNpc(1221, 70, SubWorld, px * 32, py * 32)

        if (bossidx > 0) then
            SetNpcScript(bossidx, "\\script\\¹ÖÎï\\Áú»ê.lua")
            SetNpcTimer(bossidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            SetNpcName(bossidx, GetName() .. "_Long Hån ")
            SetNpcOwer(bossidx, PlayerIndex)
            SetNpcTask(bossidx, 1, GetPlayerID())
            RemoveIBBuff(765)
            AddIBBuff(765)

            SetTaskByte(Task_eye_renwu, 3, 4)
            ScrollMessage("Long Hån ®· xuÊt hiÖn!")
            SetTaskWord(Task_eyelight_renwu, 2, 0)
            if (GetJusticEvilCredit() < 0) then
                TaskNote(116, 2)
            else
                TaskNote(115, 2)
            end

        end
    end
end

function no()
    CloseDialog()
end
