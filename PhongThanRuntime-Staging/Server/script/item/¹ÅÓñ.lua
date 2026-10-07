TASK_BANQUAN = 1502
TASK_DISTANCE = 1499
TASK_OLDMAN_CALLTIME = 1501
MAPID = 76
TASK_TIME_LIMIT = 180
TASK_BANQUAN_OLDMANIDX = 1500

lightname = {
    [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
    [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
    [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
    [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
}

function main()

    local isactive = GetTaskByte(TASK_BANQUAN, 1)
    local missionid = GetTaskByte(TASK_BANQUAN, 2)

    if (isactive == 5) then
        if ((SystemTime() - GetTask(TASK_OLDMAN_CALLTIME)) <= TASK_TIME_LIMIT) then
            Msg2Player("D­êng nh­ søc m¹nh cña ¤n Ngäc ®· c¹n kiÖt, kh«ng thÓ chØ thÞ chÝnh x¸c ph­¬ng h­íng.")
            return
        end

        local mapid, x, y = GetWorldPos()

        if (mapid ~= MAPID) then
            Talk(1, "no", "Kh«ng ë cïng mét b¶n ®å")

        else
            local x1 = GetTaskByte(TASK_BANQUAN, 3) * 8
            local y1 = GetTaskByte(TASK_BANQUAN, 4) * 16

            local distance = math.abs((x - x1) * (x - x1) + (y - y1) * (y - y1))
            local lastDist = GetTask(TASK_DISTANCE)
            SetTask(TASK_DISTANCE, distance)

            local light = 1

            if (distance <= 300) then
                light = 4
            elseif (distance <= 1000) then
                light = 3
            elseif (distance <= 2500) then
                light = 2
            end
            local msg = "Cæ Ngäc xuÊt hiÖn" .. lightname[light]

            if (lastDist == -1) then
                msg = msg .. "H×nh nh­ V« Danh L·o Nh©n ë khu vùc nµy!"
            else
                if (light == 4) then
                    msg = msg .. ", V« Danh L·o Nh©n ch¾c ®ang ë gÇn ®©y, b¹n cã muèn thö vËn may kh«ng?"
                    MsgBox(msg, "openmap", "no")
                    return
                else
                    if (lastDist < distance) then
                        msg = msg .. ", h×nh nh­ b¹n ®· <color=red>rêi xa<color> V« Danh L·o Nh©n."
                    else
                        msg = msg .. ", h×nh nh­ b¹n ®ang <color=green>®Õn gÇn<color> V« Danh L·o Nh©n."
                    end
                end
            end

            Talk(1, "no", msg)

        end

    end

end

function openmap()
    CloseDialog()

    if ((SystemTime() - GetTask(TASK_OLDMAN_CALLTIME)) > TASK_TIME_LIMIT) then
        local w, x, y = GetWorldPos()
        newnpcidx = AddNpc(1161, 1, SubWorld, (x - 1) * 32, (y + 1) * 32)

        SetTask(TASK_OLDMAN_CALLTIME, SystemTime())
        SetNpcScript(newnpcidx, "\\script\\ÚæÈªÊ¥µØ\\ÚæÈªÌ½ÃØ\\ÎÞÃûÀÏÈË.lua")
        local ret = SetNpcTimer(newnpcidx, "\\script\\ontimer\\ÎÞÃûÀÏÈËÏûÊ§.lua", TASK_TIME_LIMIT)
        SetNpcName(newnpcidx, "<c=g>V« Danh L·o Nh©n<c>")
        SetTask(TASK_BANQUAN_OLDMANIDX, newnpcidx)
        SetNpcTask(newnpcidx, 5, GetPlayerID())

        if (GetTaskByte(TASK_BANQUAN, 2) == 3) then
            SetTaskByte(TASK_BANQUAN, 2, 4)
            TaskNote(1086, 3)
        end

    else
        Msg2Player("D­êng nh­ søc m¹nh cña ¤n Ngäc ®· c¹n kiÖt, kh«ng thÓ chØ thÞ chÝnh x¸c ph­¬ng h­íng.")

    end
end

function no()
    CloseDialog()
end
