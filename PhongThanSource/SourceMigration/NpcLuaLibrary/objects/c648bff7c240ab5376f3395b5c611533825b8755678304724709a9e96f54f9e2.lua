MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

Task_CompassMagic = 1465

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 55
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) and ((GetTask(1) == 160) or (GetTask(2) == 160) or (GetTask(3) == 160)) then

        local taskProcess = GetTaskByte(Task_CompassMagic, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 65
    if (GetPlayerExtLevel() >= startLevel) and (GetTaskByte(Task_CompassMagic, 1) == 9) and (GetJusticEvilCredit() < 0) then
        local taskProcess = GetTaskByte(Task_YinGuoLunHui, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 8) then
                state = 3
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess < 8) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 8) then
                state = 3
                subState = 1
            elseif (taskProcess >= 1) and (taskProcess < 8) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    local tasks = {
        { "Mua b¸n vËt phÈm", "buy"; show = 0 },

        { "La Bµn trËn ph¸p", "CompassMagic"; show = 0 },

        { "MaGiíiKúTr©n", "opensale"; show = 1 },

        { "Nh©n qu¶ lu©n håi", "processYinGuoLunHui"; show = 0 },

    }

    if (IsVisableCompassMagic() == 1) then
        tasks[2].show = 1
    end

    if (isViewYinGuoLunHui() == 1) then
        tasks[4].show = 1
    end

    SayTask("§¼ng cÊp Nh©n giíi cña ng­¬i sÏ ¶nh h­ëng tíi viÖc tu luyÖn Tiªn Ma giíi, chØ khi ®¼ng cÊp Nh©n giíi cao h¬n Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi nhËn ®­îc hiÖu qu¶ tu luyÖn.", tasks)
end;

function opensale()
    CloseDialog()
    OpenMonsterSale(42)
end

function IsVisableCompassMagic()
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)

    if (GetPlayerExtLevel() >= 55 and TaskCompassMagic == 0 and GetTask(MainTask_GD_Conf[GetPlayerType()].task) == 160) then
        return 1
    else
        return 0
    end
end

function CompassMagic()
    CloseDialog()
    local mainTaskStatus = GetTask(MainTask_GD_Conf[GetPlayerType()].task)
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)
    local pt = GetPlayerType()

    if (GetPlayerExtLevel() >= 55 and mainTaskStatus == 160 and TaskCompassMagic == 0) then
        local credit = GetJusticEvilCredit()
        local gdFlag = (credit > 0 and 1 or 2)
        if (gdFlag ~= Conf_GD_Flag) then
            local thisCamp = (Conf_GD_Flag == 1 and "Tiªn" or "Ma")
            local yourCamp = (gdFlag == 1 and "Tiªn" or "Ma")
            Talk(1, "no", "Ng­¬i kh«ng ph¶i" .. thisCamp .. " ®Ö tö ph¸i ta, sau khi tu hµnh danh väng bæn ph¸i h·y ®Õn.")
            return
        end

        SetTaskByte(Task_CompassMagic, 1, 1)
        Talk(5, "no", "" .. GetName() .. "§Ö tö ®i thuyÒn tõ BÊt Chu S¬n ®Õn, trªn ®­êng yªu khÝ ngµy cµng nhiÒu, xin hái tiÒn bèi ®©y lµ ®©u?", "§©y lµ Ngôc Ph¸p S¬n, cßn gäi lµ vïng ®Êt l­u ®µy, ®a sè ng­êi ë ®©y do ph¶n gi¸o nªn bÞ Tiªn Ma Giíi trõng ph¹t, l­u ®µy suèt ®êi. Ng­¬i kh«ng nªn n¸n l¹i l©u!", "" .. GetName() .. ":§a t¹ tiÒn bèi chØ b¶o, nh­ng ®Ö tö ®Õn ®©y ®Ó t×m thÇn vËt Phong ThÇn B¶ng, ch¼ng hay tiÒn bèi cã biÕt manh mèi g× kh«ng?", " B¶ng Phong ThÇn? L·o phu ch­a tõng ®­îc nghe... §óng råi, trªn ®­êng ®Õn ®©y cã lÏ ng­¬i ®· gÆp mét sè Tø BÊt T­îng, chóng th­êng xuyªn lang thang n¬i nµy, v× thÕ v« cïng nguy hiÓm, mäi viÖc ®Òu ph¶i cÈn th©n, ®õng nªn dÔ dµng tin lêi ng­êi kh¸c!", "" .. GetName() .. ":§a t¹ tiÒn bèi chØ d¹y!")

        if (pt == 0) then
            TaskNote(86, 28)
        elseif (pt == 1) then
            TaskNote(87, 28)
        else
            TaskNote(88, 28)
        end
    end ;

    refreshNpcTaskState()


end

function buy()
    CloseDialog()
    Sale(37)
end

function no()
    CloseDialog()
end

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

Conf_GD_Flag = 2

function isViewYinGuoLunHui()
    local mainTaskStatus = GetTask(MainTask_GD_Conf[GetPlayerType()].task)
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)
    if (GetPlayerExtLevel() >= 65 and mainTaskStatus == 160 and TaskCompassMagic == 9 and taskYinGuoLunHui == 0) then
        return 1
    elseif (mainTaskStatus == 160 and taskYinGuoLunHui == 8) then
        return 1
    else
        return 0
    end
end

function processYinGuoLunHui()
    CloseDialog()
    local mainTaskStatus = GetTask(MainTask_GD_Conf[GetPlayerType()].task)
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)
    if (GetPlayerExtLevel() >= 65 and mainTaskStatus == 160 and TaskCompassMagic == 9 and taskYinGuoLunHui == 0) then
        local credit = GetJusticEvilCredit()
        local gdFlag = (credit > 0 and 1 or 2)
        if (gdFlag ~= Conf_GD_Flag) then
            local thisCamp = (Conf_GD_Flag == 1 and "Tiªn" or "Ma")
            local yourCamp = (gdFlag == 1 and "Tiªn" or "Ma")
            Talk(1, "no", "Ng­¬i kh«ng ph¶i" .. thisCamp .. " Ta, n©ng cao danh väng bæn ph¸i h·y ®Õn gÆp ta.")
            return
        end
        SetTaskByte(Task_YinGuoLunHui, 1, 1)
        SetTaskByte(Task_YinGuoLunHui, 2, Conf_GD_Flag)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 38)
        WriteLog("L·nh nhËn <Nh©n qu¶ lu©n håi Tiªn Ma cÊp 65>")
        Msg2Player("§· nhËn nhiÖm vô Nh©n qu¶ lu©n håi.")
        Talk(5, "no", "" .. GetName() .. ": Xin hái tiÒn bèi, Ngôc Ph¸p S¬n ®ét nhiªn ®Êt chuyÓn nói rung, m©y kÐo ïn ïn, lµ do nguyªn nh©n g×?", "Ng­¬i kh«ng biÕt ®©u, trËn ph¸p La Bµn cña Ngôc Ph¸p S¬n bÞ hñy, ph¸p trô mÊt ®i ph¸p lùc khèng chÕ bän ¸c linh trong Ngôc Ph¸p S¬n, dÉn ®Õn ¸c linh hoµnh hµnh, Ngôc Ph¸p S¬n s¾p bÞ sù h¾c ¸m bao trïm råi.", "" .. GetName() .. ":TiÒn bèi, ch¾c viÖc nµy cã liªn quan ®Õn t¹i h¹, xin ng­êi nghe t«i kÓ râ...", "Sao? Ng­êi trÎ tuæi, ng­¬i qu¸ lç m·ng råi! H·y lËp tøc ®i ®i, nhanh chãng rêi khái ®©y ®Ó toµn m¹ng...", "" .. GetName() .. ":V·n bèi s¬ ý, sa bÉy kÎ gian, ph¹m sai lÇm lín, sao cã thÓ bá ch¹y mét m×nh? §Ó v·n bèi ®i chÕ phôc ¸c linh, quyÕt mét trËn sèng m¸i víi chóng!")

        refreshNpcTaskState()

    elseif (mainTaskStatus == 160 and taskYinGuoLunHui == 8) then
        local taskGDFlag = GetTaskByte(Task_YinGuoLunHui, 2)
        if (taskGDFlag ~= Conf_GD_Flag) then
            local thisCamp = (Conf_GD_Flag == 1 and "Tiªn" or "Ma")
            local taskCamp = (taskGDFlag == 1 and "Tiªn" or "Ma")
            Talk(1, "no", "Cã ph¶i ng­¬i t×m nhÇm ng­êi kh«ng? Ta kh«ng ph¶i Tu Hµnh S­ (" .. taskCamp .. ") .")
            return
        end
        SetTask(MainTask_GD_Conf[GetPlayerType()].task, 165)
        SetTaskByte(Task_YinGuoLunHui, 1, 10)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 46)
        ClearItem(6, 1, 529, 1)
        local er = AddOwnExtendExp(10000 * 2900)
        AddNormalItem(3, 51, 0, 0, 0, 0)
        WriteLog("Hoµn thµnh <Nh©n qu¶ lu©n håi Tiªn Ma cÊp 65>")
        TopMessage("NhËn ®­îc <color=green>B¸ L¹c Nh·n cÊp 15<color>")
        Msg2Player("Ng­¬i nhËn ®­îc 1 B¸ L¹c Nh·n cÊp 15 vµ" .. er .. " §iÓm tu hµnh.")
        Talk(1, "no", "RÊt kh©m phôc nh÷ng ng­êi trÎ tuæi, hä kh«ng sî sèng chÕt, tuæi giµ, B¸ L¹c Nh·n nµy tÆng cho ng­¬i, ta nghÜ nã sÏ gióp ®­îc cho ng­¬i ®ã! H­íng B¾c hiÓm nguy mu«n trïng, nh­ng ch©n t­íng ng­¬i cÇn ®ang gÇn ngay tr­íc m¾t!")

        refreshNpcTaskState()

    end
end


