TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

CONST_JS_MAP_BOOK = {
    { name = "Sa M¹c chÕt", item = { 6, 1, 504, 0 }, boss1 = 30, boss2 = 33, boss3 = 980 },
    { name = "Long Uyªn", item = { 6, 1, 505, 0 }, boss1 = 34, boss2 = 38, boss3 = 981 },
}

CONST_JS_MAP_COORD = {
    { name = "B¶n ®å Hoang m¹c täa ®é 1", x = 185 * 8, y = 196 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 2", x = 184 * 8, y = 181 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 3", x = 225 * 8, y = 201 * 16 },
    { name = "B¶n ®å Hoang m¹c täa ®é 4", x = 226 * 8, y = 211 * 16 },
}

CONST_JS_MAP_ID = {
    name = "Sa M¹c chÕt", id = 26,
}

CONST_JS_LIGHT_NAME = {
    [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
    [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
    [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
    [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
}

function main()
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local ghostStatus = GetTaskByte(TASK_JIANGSHAN, 2)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page1Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 2)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    local idolStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4)

    local class, detail, particular, level = myunpack(CONST_JS_MAP_BOOK[1].item)
    if (ghostStatus > 0) then
        ClearItem(class, detail, particular, level)
        Talk(1, "no", "B¹n ®· hoµn thµnh Hçn §én ¶o c¶nh, kh«ng cßn cÇn ®¹o cô nµy, hÖ thèng sÏ thu håi nã!")
        return 0
    end
    if (page1Step ~= 10 or idolStep ~= 1) then
        ClearItem(class, detail, particular, level)
        Talk(1, "no", "B¹n b©y giê kh«ng cÇn ®¹o cô nµy, hÖ thèng sÏ thu håi nã!")
        return 0
    end

    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= CONST_JS_MAP_ID.id) then
        Talk(1, "no", "Hçn §én Èn n¸u t¹i <c=g>" .. CONST_JS_MAP_ID.name .. "<c>!\n§Õn <c=g>" .. CONST_JS_MAP_ID.name .. ". H·y theo chØ dÉn cña B¶o §å, tõng b­íc tiÕp cËn n¬i Èn n¸u cña Hçn §én.")
    else
        local mapIdx = GetTaskByte(TASK_JIANGSHAN_ONE_COORD, 1)
        local px = CONST_JS_MAP_COORD[mapIdx].x
        local py = CONST_JS_MAP_COORD[mapIdx].y
        local distance = (x1 - px) ^ 2 + (y1 - py) ^ 2
        local lastDist = GetTask(TASK_JIANGSHAN_ONE_DIST)
        SetTask(TASK_JIANGSHAN_ONE_DIST, distance)

        local light = 1
        if (distance <= 25) then
            light = 4
        elseif (distance <= 400) then
            light = 3
        elseif (distance <= 2500) then
            light = 2
        end
        local msg = "B¶n ®å ¶o c¶nh ph¸t ra" .. CONST_JS_LIGHT_NAME[light]

        if (lastDist == -1) then
            msg = msg .. "Hçn §én ¶o c¶nh ®ang ë quanh ®©y!"
        else
            if (light == 4) then
                msg = msg .. "Hçn §én ¶o c¶nh ë gÇn ®©y, b¹n muèn thö vËn may chø?"
                MsgBox(msg, "openMap", "no")
                return 0
            else
                if (lastDist < distance) then
                    msg = msg .. ". B¹n cµng <color=red>c¸ch xa<color> Hçn §én ¶o c¶nh ."
                else
                    msg = msg .. ". B¹n cµng <color=green>tiÕp cËn<color> Hçn §én ¶o c¶nh ."
                end
            end
        end
        Talk(1, "no", msg)
    end ;
end;

function openMap()
    CloseDialog()
    local mapid, x1, y1 = GetWorldPos()
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local ghostStatus = GetTaskByte(TASK_JIANGSHAN, 2)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page1Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 2)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    local idolStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4)

    local class, detail, particular, level = myunpack(CONST_JS_MAP_BOOK[1].item)
    local mapIdx = GetTaskByte(TASK_JIANGSHAN_ONE_COORD, 1)
    local px = CONST_JS_MAP_COORD[mapIdx].x * 32
    local py = CONST_JS_MAP_COORD[mapIdx].y * 32
    local npcidx = AddNpc(CONST_JS_MAP_BOOK[1].boss1, 40, SubWorld, x1 * 32, y1 * 32)

    if (npcidx > 0) then
        ClearItem(class, detail, particular, level)
        SetNpcScript(npcidx, "\\script\\¹ÖÎï\\½­É½ÒÀ¾É¾ÞÊ¯Éñ.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 5)
        SetNpcTask(npcidx, 1, GetPlayerID())
        SetNpcName(npcidx, "<c=g>Giang S¬n Y Cùu Cù Th¹ch<c>")

        SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 4, 2)
        TaskNote(Task_Info_JIANGSHAN_IDOLUM, 16)
        TopMessage("TriÖu ra Cù Th¹ch")
        Msg2Player("Thu phôc Cù Th¹ch cã thÓ lÇn l­ît triÖu håi ra Thi V­¬ng, Hçn §én ¶o C¶nh")
    end
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

function no()
    CloseDialog()
end	
