TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

JS_XY_Pos = {
    { name = "B¨ng Xuyªn Cùc", m = 36, x = 162 * 8, y = 212 * 16 },
    { name = "B¨ng Xuyªn Cùc", m = 36, x = 160 * 8, y = 226 * 16 },
    { name = "B¨ng Xuyªn Cùc", m = 36, x = 187 * 8, y = 207 * 16 },
    { name = "B¨ng Xuyªn Cùc", m = 36, x = 196 * 8, y = 221 * 16 },
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
        Talk(1, "no", "§µo Ngét Èn n¸u t¹i <c=g>" .. (JS_XY_Pos[mapidx].name) .. "<c>!\n§Õn <c=g>" .. (JS_XY_Pos[mapidx].name) .. ". H·y theo chØ dÉn cña B¶o §å, tõng b­íc tiÕp cËn n¬i Èn n¸u cña §µo Ngét.")
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
        local msg = "B¶n ®å §µo Ngét ¶o c¶nh ph¸t ra" .. lightname[light]

        if (lastDist == -1) then
            msg = msg .. "§µo Ngét ¶o c¶nh ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "§µo Ngét ¶o c¶nh ë gÇn ®©y, b¹n muèn thö vËn may chø?"
                MsgBox(msg, "openmap", "no")
                return
            else
                if (lastDist < distance) then
                    msg = msg .. ". B¹n cµng <color=red>c¸ch xa<color> §µo Ngét ¶o c¶nh."
                else
                    msg = msg .. ". B¹n cµng <color=green>tiÕp cËn<color> §µo Ngét ¶o c¶nh."
                end
            end
        end
        Talk(1, "no", msg)
    end
end

function openmap()
    CloseDialog()

    ClearItem(6, 1, 507, 1)
    SetTask(TASK_JS_DIST, -1)

    local w, x, y = GetWorldPos()
    local newnpcidx = 0

    local huanxiangidx = AddNpc(983, 80, SubWorld, (x + 1) * 32, (y - 1) * 32)
    SetNpcTask(huanxiangidx, 0, GetPlayerID())
    SetNpcName(huanxiangidx, "<c=g>§µo Ngét ¶o c¶nh <c>")
    SetNpcOwer(huanxiangidx, PlayerIndex)

    newnpcidx = AddNpc(986, 75, SubWorld, (x + 2) * 32, (y + 1) * 32)
    SetNpcTask(newnpcidx, 0, huanxiangidx)
    SetNpcTask(newnpcidx, 1, GetNpcID(huanxiangidx))
    SetNpcName(newnpcidx, "<c=g>Hoµng kim Th¹ch ThÇn<c>")
    newnpcidx = AddNpc(986, 75, SubWorld, (x + 1) * 32, (y + 2) * 32)
    SetNpcTask(newnpcidx, 0, huanxiangidx)
    SetNpcTask(newnpcidx, 1, GetNpcID(huanxiangidx))
    SetNpcName(newnpcidx, "<c=g>Hoµng kim Th¹ch ThÇn<c>")
    newnpcidx = AddNpc(986, 75, SubWorld, (x + 1) * 32, (y + 1) * 32)
    SetNpcTask(newnpcidx, 0, huanxiangidx)
    SetNpcTask(newnpcidx, 1, GetNpcID(huanxiangidx))
    SetNpcName(newnpcidx, "<c=g>Hoµng kim Th¹ch ThÇn<c>")
    newnpcidx = AddNpc(986, 75, SubWorld, (x - 1) * 32, (y + 1) * 32)
    SetNpcTask(newnpcidx, 0, huanxiangidx)
    SetNpcTask(newnpcidx, 1, GetNpcID(huanxiangidx))
    SetNpcName(newnpcidx, "<c=g>Hoµng kim Th¹ch ThÇn<c>")
    newnpcidx = AddNpc(986, 75, SubWorld, (x - 1) * 32, (y - 1) * 32)
    SetNpcTask(newnpcidx, 0, huanxiangidx)
    SetNpcTask(newnpcidx, 1, GetNpcID(huanxiangidx))
    SetNpcName(newnpcidx, "<c=g>Hoµng kim Th¹ch ThÇn<c>")
end

function no()
    CloseDialog()
end
