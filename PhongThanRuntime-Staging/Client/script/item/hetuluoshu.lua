Task_YinGuoLunHui = 1489
Task_LunHui_Time = 1490

Conf_LH_Npc_Trap = 1146
Conf_LH_Npc_Soul = 468
Conf_LH_Npc_Penstock = 1144
Conf_LH_Npc_FXDialog = 1142
Conf_LH_Npc_FXFight = 1143

Conf_LH_Npc_Self = {
    [0] = { [0] = 1147, [1] = 1148 },
    [1] = { [0] = 1149, [1] = 1150 },
    [2] = { [0] = 1151, [1] = 1152 },
}

Conf_LH_Buff_A = 717
Conf_LH_Buff_B = 718
Conf_LH_Buff_C = 719
Conf_LH_Buff_D = 720
Conf_LH_Buff_E = 721

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

Conf_LH_Pillar = {
    { name = "Ph¸p trô (B¾c)", x = 2023, y = 3196, gtask = 229, x2 = 2022, y2 = 3195 },
    { name = "Ph¸p trô (§«ng)", x = 2105, y = 3813, gtask = 230, x2 = 2105, y2 = 3812 },
    { name = "Ph¸p trô (Nam)", x = 1604, y = 3773, gtask = 231, x2 = 1605, y2 = 3773 },
    { name = "Ph¸p trô (T©y)", x = 1629, y = 3206, gtask = 232, x2 = 1630, y2 = 3206 },
}

function main()
    local w, x, y = GetWorldPos()
    if (w ~= 75) then
        Talk(1, "no", "b¶o vËt Tiªn Ma , chØ cã thÓ sö dông trªn Ngôc Ph¸p S¬n.")
        return
    end
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    if (taskYinGuoLunHui == 4) then
        local localTime = LocalSystemTime()
        local lastConsume = GetTask(Task_LunHui_Time)
        if (lastConsume > (localTime - 60)) then
            Talk(1, "no", "Nhôc thÓ cña ng­¬i ®· ®­îc triÖu gäi.")
            return
        elseif (GetMorphType() ~= Conf_LH_Npc_Soul) then
            Talk(1, "no", "ChØ cã trong h×nh t­îng anh linh, míi cã thÓ triÖu ra nhôc thÓ.")
            return
        end
        if (isinarea(w, x, y) == 1) then
            local newidx = AddNpc(Conf_LH_Npc_Self[GetPlayerType()][GetSex()], 65, SubWorld, x * 32 + 32, y * 32 + 32)
            if (newidx > 0) then
                SetTask(Task_LunHui_Time, localTime)
                SetNpcScript(newidx, "\\script\\Óü·¨É½\\Òò¹ûÂÖ»Ø±¾Éí.lua")
                SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 1)
                SetNpcTask(newidx, 1, GetPlayerID())
                SetNpcName(newidx, "<c=g>" .. GetName() .. "_ChÝnh b¶n th©n<c>")
                TopMessage("Nhôc thÓ cña ng­¬i ®· ®­îc triÖu ra")
                Msg2Player("Nhôc thÓ cña ng­¬i ®· ®­îc triÖu ra.")
            end
        else
            Talk(1, "no", "xung quanh 4 täa La Bµn chÝnh lµ ph¹m vi la bµn, ta chØ cã thÓ sö dông trong ph¹m vi La Bµn.")
            return
        end
    elseif (taskYinGuoLunHui == 5) then
        Talk(1, "no", "Nhôc thÓ cña ng­¬i chØ cã thÓ gäi ra khi trong tr¹ng th¸i anh linh, tr¹ng th¸i anh linh cña ng­¬i ®· mÊt, h·y vÒ t×m Kh­¬ng Tö Nha lóc nhá gióp ®ì.")
    elseif (taskYinGuoLunHui == 6) then
        local taskFazhu = GetTaskByte(Task_YinGuoLunHui, 3)
        taskFazhu = taskFazhu + 1
        local pillar = Conf_LH_Pillar[taskFazhu]
        local distance = (pillar.x - x) ^ 2 + (pillar.y - y) ^ 2
        if (distance > 150 ^ 2) then
            Talk(1, "no", "HiÖn t¹i ng­¬i nªn" .. pillar.name .. "ChuyÓn vµo ph¸p lùc, hiÖn kho¶n c¸ch qu¸ xa")
            return
        else
            local pillarIdx = GetGlobalValue(pillar.gtask)
            local localTime = LocalSystemTime()
            local pillarTime = GetNpcTask(pillarIdx, 5)
            if (pillarTime > (localTime - 60 * 2)) then
                Talk(1, "no", "Ph¸p trô nµy ®ang thu ph¸p lùc vµo, l¸t n÷a míi cã thÓ dïng!")
                return
            end
            local newidx = AddNpc(Conf_LH_Npc_Penstock, 1, SubWorld, x * 32 + 32, y * 32 + 32)
            if (newidx > 0) then
                SetTaskByte(Task_YinGuoLunHui, 3, taskFazhu)
                SetNpcTask(pillarIdx, 5, localTime)
                NpcAddIBBuff(pillarIdx, Conf_LH_Buff_E, 30)
                SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 2)
                SetNpcName(newidx, "<c=g>Cèng n­íc Ph¸p trô<c>")
                TopMessage("LuyÖn thµnh" .. pillar.name .. "_Cèng n­íc Ph¸p trô")
                Msg2Player("LuyÖn thµnh" .. pillar.name .. "_Cèng n­íc Ph¸p trô , kÝch ho¹t råi" .. pillar.name .. "_Ph¸p lùc.")
                if (taskFazhu == 4) then
                    SetTaskByte(Task_YinGuoLunHui, 1, 7)
                    SetTask(Task_LunHui_Time, 0)
                    TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 44)
                    Msg2Player("LuyÖn thµnh 4 cèng n­íc cña Ph¸p trô, ph¸p lùc ph¸p trô ®· håi phôc, cã thÓ ®Õn n¬i Tø BÊt T­íng gäi hËu nh©n Phôc Hy")
                end
            end
        end
    elseif (taskYinGuoLunHui == 7) then
        if (HaveIBBuff(Conf_LH_Buff_C) > 0 or HaveIBBuff(Conf_LH_Buff_D) > 0) then
            Talk(1, "no", "Ng­¬i ®· triÖu ra hËu nh©n Phôc Hy.")
            return
        end
        local distance = (1722 - x) ^ 2 + (3644 - y) ^ 2
        if (distance > 300 ^ 2) then
            Talk(1, "no", "C¸ch Tø BÊt T­íng qu¸ xa, h·y ®Õn gÇn triÖu gäi.")
            return
        else
            local newidx = AddNpc(Conf_LH_Npc_FXDialog, 65, SubWorld, x * 32 + 32, y * 32 + 32)
            if (newidx > 0) then
                AddIBBuff(Conf_LH_Buff_C, 60 * 2)
                SetNpcScript(newidx, "\\script\\Óü·¨É½\\·üôËºóÈË.lua")
                SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 2)
                SetNpcTask(newidx, 1, GetPlayerID())
                SetNpcName(newidx, "<c=g>" .. GetName() .. "TriÖu håi hËu nh©n cña Phôc Hy <c>")
                TopMessage("TriÖu håi hËu nh©n cña Phôc Hy")
                Msg2Player("TriÖu håi hËu nh©n cña Phôc Hy")
            end
        end
    else
        Talk(1, "no", "HiÖn t¹i c¸c h¹ kh«ng thÓ sö dông Hµ ®å L¹c th­!")
    end
end

function no()
    CloseDialog()
end

function isinarea(mapId, x, y)
    item = {
        { 1814, 3524 }, { 1935, 3479 }, { 1940, 3372 }, { 1837, 3390 },
    }
    local k, x1, key = 0, 0, 0
    for j = 1, table.getn(item) do

        k = math.mod(j + 1, table.getn(item) + 1)
        if (k == 0) then
            k = 1
        end
        if (item[j][2] ~= item[k][2]) then
            if (y >= math.min(item[j][2], item[k][2])) then
                if (y < math.max(item[j][2], item[k][2])) then


                    if (item[k][2] - item[j][2] == 0) then
                        return 0
                    end

                    x1 = (y - item[j][2]) * (item[k][1] - item[j][1]) / (item[k][2] - item[j][2]) + item[j][1]

                    if (x1 > x) then
                        key = key + 1
                    end
                end
            end
        end
    end

    if (math.mod(key, 2) == 1) then
        return 1
    end
    return 0
end
