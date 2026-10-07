TASK_JIANGSHAN = 1426
TASK_JS_DIST = 1436
TASK_JIANGSHAN_ONE_COORD = 1430

JS_XY_Pos = {
    { name = "Khæn Tiªn tÇng 5", m = 51, x = 180 * 8, y = 199 * 16 },
    { name = "Khæn Tiªn tÇng 5", m = 51, x = 199 * 8, y = 195 * 16 },
    { name = "Khæn Tiªn tÇng 5", m = 51, x = 223 * 8, y = 195 * 16 },
}

lightname = {
    [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
    [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
    [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
    [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
}

function main()
    local mapid, x1, y1 = GetWorldPos()

    local mapIdx = GetTaskByte(TASK_JIANGSHAN_ONE_COORD, 1)
    if (mapid ~= JS_XY_Pos[mapIdx].m) then
        Talk(1, "no", "Bµn Cæ ®¹i thÇn ë t¹i <c=g>" .. (JS_XY_Pos[mapIdx].name) .. "<c>!\n§Õn <c=g>" .. (JS_XY_Pos[mapIdx].name) .. ". H·y theo chØ dÉn cña B¶o §å, t×m Bµn Cæ ®¹i thÇn th­¬ng l­îng ®èi s¸ch!")
    else
        local px = JS_XY_Pos[mapIdx].x
        local py = JS_XY_Pos[mapIdx].y
        local distance = (x1 - px) ^ 2 + (y1 - py) ^ 2
        local lastDist = GetTask(TASK_JS_DIST)
        SetTask(TASK_JS_DIST, distance)

        local light = 1
        if (distance <= 25) then
            light = 4
        elseif (distance <= 400) then
            light = 3
        elseif (distance <= 2500) then
            light = 2
        end
        local msg = "B¶n ®å Khæn Tiªn ph¸t ra" .. lightname[light]

        if (lastDist == -1) then
            msg = msg .. "Bµn Cæ ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "Bµn Cæ ë gÇn ®©y, b¹n muèn thö vËn may chø?"
                MsgBox(msg, "openmap", "no")
                return
            else
                if (lastDist < distance) then
                    msg = msg .. ". B¹n cµng <color=red>c¸ch xa<color> Bµn Cæ."
                else
                    msg = msg .. ". B¹n cµng <color=green>tiÕp cËn<color> Bµn Cæ."
                end
            end
        end
        Talk(1, "no", msg)
    end
end

function openmap()
    CloseDialog()

    ClearItem(6, 1, 508, 1)

    local w, x, y = GetWorldPos()
    newnpcidx = AddNpc(984, 1, SubWorld, (x - 1) * 32, (y + 1) * 32)
    SetNpcScript(newnpcidx, "\\script\\¹ÖÎï\\ÐéÈõµÄÅÌ¹Å.lua")
    SetNpcName(newnpcidx, "<c=g>Bµn Cæ yÕu ít<c>")
end

function no()
    CloseDialog()
end
























