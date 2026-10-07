--description: ÉñÃØÂŞÅÌ
--author: yaoxin
--date: 2009/4/8

--ºìğ½ĞÇ¶¯
Task_renwu20 = 1377 --1bit ÊÇ·ñ¼¤»îÈÎÎñ 2bit ÊÇ·ñÍê³ÉÈÎÎñ 2byte ²½Öè×´Ì¬(1)£¬ 3byte É±ÖÑµñµÄ¸öÊı(ºóÆÚÊÇx×ø±ê),4byte y×ø±ê
Task_renwu20_distance = 1378 --ÉÏ´ÎÑ°µãÓëÏÖÔÚÑ°µãµÄ¾àÀë

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
        Talk(1, "no", "La Bµn thÇn bİ ®· biÕn mÊt!")
        return 0
    end

    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= 14) then
        Talk(1, "no", "D­êng nh­ Ng­u S¸t ma v­¬ng ®ang trèn ë <c=g>§ång Quan<c>!")
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
        local msg = "La Bµn thÇn bİ ph¸t ra" .. lightname[light]

        if (lastdist == -1) then
            msg = msg .. "D­êng nh­ Ng­u S¸t ma v­¬ng ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "Ng­u S¸t ma v­¬ng ®ang ë quanh ®©y, b¹n muèn thö vËn may kh«ng!"
                MsgBox(msg, "wabao", "no")
                return 0
            else
                if (lastdist < distance) then
                    msg = msg .. ", d­êng nh­ b¹n ngµy cµng <color=red>c¸ch xa<color> Ng­u S¸t ma v­¬ng."
                else
                    msg = msg .. ", d­êng nh­ b¹n ngµy cµng <color=green>tiÕn gÇn<color> Ng­u S¸t ma v­¬ng."
                end
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
            SetNpcName(npcidx, "<c=g>Ng­u S¸t ma v­¬ng<c>")
            NpcPolyMorph(npcidx, 12)

            if (DelNormalItem(6, 1, 475, 0) == 0) then
                DelNormalItemInQuick(6, 1, 475, 0)
            end
            SetTaskByte(Task_renwu20, 2, 5)
            SetTaskByte(Task_renwu20, 3, 0)
            SetTaskByte(Task_renwu20, 4, 0)
            SetTask(Task_renwu20_distance, 0)
            TaskNote(202, 6)
            Msg2Player("Trong tr¹ng th¸i Trõ ma t×m vµ thu phôc Ng­u S¸t ma v­¬ng")
        end
    end
end

function no()
    CloseDialog()
end	