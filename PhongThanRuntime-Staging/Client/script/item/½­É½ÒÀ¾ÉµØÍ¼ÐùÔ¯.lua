TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

JS_XY_Pos = {
    { name = "Hiªn Viªn tÇng 5", m = 31, x = 204 * 8, y = 184 * 16 },
    { name = "Hiªn Viªn tÇng 5", m = 31, x = 231 * 8, y = 192 * 16 },
    { name = "Hiªn Viªn tÇng 5", m = 31, x = 252 * 8, y = 174 * 16 },
    { name = "Hiªn Viªn tÇng 5", m = 31, x = 225 * 8, y = 165 * 16 },
}

lightname = {
    [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
    [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
    [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
    [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
}

function main()
    local mapid, x1, y1 = GetWorldPos()
    local mapidx = GetTaskByte(TASK_JS_BOOK2, 4)

    if (mapid ~= JS_XY_Pos[mapidx].m) then
        Talk(1, "no", "Thao ThiÕt Èn n¸u t¹i <c=g>" .. (JS_XY_Pos[mapidx].name) .. "<c>!\n§Õn <c=g>" .. (JS_XY_Pos[mapidx].name) .. ". H·y theo chØ dÉn cña B¶o §å, tõng b­íc tiÕp cËn n¬i Èn n¸u cña Thao ThiÕt.")
    else
        local px = JS_XY_Pos[mapidx].x
        local py = JS_XY_Pos[mapidx].y
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
        local msg = "B¶n ®å Thao ThiÕt ¶o c¶nh ph¸t ra" .. lightname[light]

        if (lastDist == -1) then
            msg = msg .. "Thao ThiÕt ¶o c¶nh  ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "Thao ThiÕt ¶o c¶nh  ë gÇn ®©y, b¹n muèn thö vËn may chø?"
                MsgBox(msg, "openmap", "no")
                return
            else
                if (lastDist < distance) then
                    msg = msg .. ". B¹n cµng <color=red>c¸ch xa<color> Thao ThiÕt ¶o c¶nh ."
                else
                    msg = msg .. ". B¹n cµng <color=green>tiÕp cËn<color> Thao ThiÕt ¶o c¶nh ."
                end
            end
        end
        Talk(1, "no", msg)
    end
end

function openmap()
    CloseDialog()

    ClearItem(6, 1, 506, 1)
    SetTask(TASK_JS_DIST, -1)

    local w, x, y = GetWorldPos()
    local newnpcidx = 0

    newnpcidx = AddNpc(985, 70, SubWorld, (x + 1) * 32, (y + 1) * 32)
    SetNpcName(newnpcidx, "<c=g>§Çu lÜnh L«i Tr¹ch thÇn<c>")
    newnpcidx = AddNpc(985, 70, SubWorld, (x - 1) * 32, (y + 1) * 32)
    SetNpcName(newnpcidx, "<c=g>§Çu lÜnh L«i Tr¹ch thÇn<c>")
    newnpcidx = AddNpc(985, 70, SubWorld, (x - 1) * 32, (y - 1) * 32)
    SetNpcName(newnpcidx, "<c=g>§Çu lÜnh L«i Tr¹ch thÇn<c>")

    newnpcidx = AddNpc(982, 70, SubWorld, (x + 1) * 32, (y - 1) * 32)
    SetNpcTask(newnpcidx, 0, GetPlayerID())
    SetNpcName(newnpcidx, "<c=g>Thao ThiÕt ¶o c¶nh <c>")
    SetNpcOwer(newnpcidx, PlayerIndex)
end

function no()
    CloseDialog()
end
