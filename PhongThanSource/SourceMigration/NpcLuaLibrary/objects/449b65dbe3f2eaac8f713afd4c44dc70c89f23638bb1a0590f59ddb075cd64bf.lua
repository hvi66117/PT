--description:Ò½ÉúÏÉ
--author: lijing
--date:2009/3/26

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --???
    [1] = { task = 1, note = 87 }, --???
    [2] = { task = 2, note = 88 }, --???
}
------------------------ÂÞÅÌ·¨Õó by lisuhui 2009.05.24------------------------------
Task_CompassMagic = 1465    --1Byte:ÈÎÎñ×´Ì¬,2Byte:ÃÜÂë¸öÊý,2Word:ÃÜÂë
------------------------------------------------------------------------------------

-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÂÞÅÌ·¨Õó
    startLevel = 55
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) and (GetTask(1) == 160 or (GetTask(2) == 160) or (GetTask(3) == 160)) then

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

    --Òò¹ûÂÖ»Ø
    startLevel = 65
    if (GetPlayerExtLevel() >= startLevel) and (GetTaskByte(Task_CompassMagic, 1) == 9) and (GetJusticEvilCredit() > 0) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    local tasks = {
        { "Mua b¸n vËt phÈm", "buy"; show = 0 },
        -- Add by lisuhui  2009.05.24
        { "La Bµn trËn ph¸p", "CompassMagic"; show = 0 },
        -- end by lisuhui
        { "Tiªn Giíi Kh«i", "opensale"; show = 1 },
        -- Added by Zhaoqingsong at 2009-6-22 begin
        { "Nh©n qu¶ lu©n håi", "processYinGuoLunHui"; show = 0 },
        -- Added by Zhaoqingsong at 2009-6-22 end
    }
    ----------------ÂÞÅÌ·¨Õó------------
    -- Add by lisuhui  2009.05.24
    if (IsVisableCompassMagic() == 1) then
        tasks[2].show = 1
    end
    -- end by lisuhui
    ----------------ÂÞÅÌ·¨Õó------------
    -- Added by Zhaoqingsong at 2009-6-22 begin
    if (isViewYinGuoLunHui() == 1) then
        tasks[4].show = 1
    end
    -- Added by Zhaoqingsong at 2009-6-22 end
    SayTask("§¼ng cÊp Nh©n giíi cña ng­¬i sÏ ¶nh h­ëng tíi viÖc tu luyÖn Tiªn Ma giíi, chØ khi ®¼ng cÊp Nh©n giíi cao h¬n Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi nhËn ®­îc hiÖu qu¶ tu luyÖn.", tasks)
end;

function opensale()
    CloseDialog()
    OpenImmortalSale(41)
end
------------------------------------------------------ÂÞÅÌ·¨Õó-------------------------------------------------
-- Add by lisuhui  2009.05.24
function IsVisableCompassMagic()
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)
    --modified by liujifang for ÏÉÄ§½çÈÎÎñbug at 2012-11-16 begin
    if (GetPlayerExtLevel() >= 55 and TaskCompassMagic == 0 and (GetTask(MainTask_GD_Conf[GetPlayerType()].task) == 160 or GetTask(MainTask_GD_Conf[GetPlayerType()].task) == 161)) then
        --modified by liujifang for ÏÉÄ§½çÈÎÎñbug at 2012-11-16 end
        return 1
    else
        return 0
    end
end

function CompassMagic()
    CloseDialog()

    local mainTaskStatus = GetTask(MainTask_GD_Conf[GetPlayerType()].task) --by songlei 2009,11,11
    local TaskCompassMagic = GetTaskByte(Task_CompassMagic, 1)
    local pt = GetPlayerType()
    --modified by liujifang for ÏÉÄ§½çÈÎÎñbug at 2012-11-16 begin
    if (GetPlayerExtLevel() >= 55 and (mainTaskStatus == 160 or mainTaskStatus == 161) and TaskCompassMagic == 0) then
        --modified by liujifang for ÏÉÄ§½çÈÎÎñbug at 2012-11-16 end
        local credit = GetJusticEvilCredit()
        local gdFlag = (credit > 0 and 1 or 2)
        if (gdFlag ~= Conf_GD_Flag) then
            local thisCamp = (Conf_GD_Flag == 1 and "Tiªn" or "Ma")
            local yourCamp = (gdFlag == 1 and "Tiªn" or "Ma")
            Talk(1, "no", "Ng­¬i kh«ng ph¶i" .. thisCamp .. " ®Ö tö ph¸i ta, sau khi tu hµnh danh väng bæn ph¸i h·y ®Õn.")
            return
        end

        SetTaskByte(Task_CompassMagic, 1, 1)
        Talk(5, "no", "" .. GetName() .. "§Ö tö ®i thuyÒn tõ BÊt Chu S¬n ®Õn, trªn ®­êng yªu khÝ ngµy cµng nhiÒu, xin hái tiÒn bèi ®©y lµ ®©u?", "§©y lµ Ngôc Ph¸p S¬n, cßn gäi lµ vïng ®Êt l­u ®µy, ®a sè ng­êi ë ®©y do ph¶n gi¸o nªn bÞ Tiªn Ma Giíi trõng ph¹t, l­u ®µy suèt ®êi. Ng­¬i kh«ng nªn n¸n l¹i l©u!", "" .. GetName() .. ":§a t¹ tiÒn bèi chØ b¶o, nh­ng ®Ö tö ®Õn ®©y ®Ó t×m thÇn vËt Phong ThÇn B¶ng, ch¼ng hay tiÒn bèi cã biÕt manh mèi g× kh«ng?", "Phong ThÇn B¶ng? L·o phu ch­a nghe bao giê...§óng råi, trªn ®­êng ®Õn ®©y ch¾c ng­¬i cã gÆp vµi Tø BÊt T­îng, bän hä th­êng ®i kh¾p chèn nµy, cã lÏ biÕt ®«i chót! Nh­ng mµ, ng­êi trÎ tuæi, n¬i nµy rÊt nguy hiÓm, hµnh sù nªn cÈn thËn, ®õng qu¸ tin lêi ng­êi kh¸c!", "" .. GetName() .. ":§a t¹ tiÒn bèi chØ d¹y!") --by songlei 2009,11,6

        if (pt == 0) then
            TaskNote(86, 28)
        elseif (pt == 1) then
            TaskNote(87, 28)
        else
            TaskNote(88, 28)
        end
    end ;

    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

end
-- end by lisuhui
---------------------------------------------------------------------------------------------------------------

function buy()
    CloseDialog()
    Sale(37)
end

function no()
    CloseDialog()
end

-- Added by Zhaoqingsong at 2009-6-22 begin

-- 1Byte£º0Î´½Ó¡¢1µÃµ½ÐÞÐÐÊ¦Ö¸Òý¡¢2´ò¿ª´«ËÍÃÅ¡¢3´«ËÍµ½½ª×ÓÑÀ´¦
--        4»ñµÃ½ª×ÓÑÀµÀ¾ßºÓÍ¼ÂåÊé¡¢5Ó¤Áé±äÉíÊ§Ð§¡¢6»Ö¸´±¾Éí¡¢7¼¤»îÁË·¨Öù¡¢8Õ÷·þ·üôË¡¢10Íê³É
Task_YinGuoLunHui = 1489
Task_LunHui_Time = 1490

Conf_LH_Npc_Trap = 1146
Conf_LH_Npc_Soul = 468
Conf_LH_Npc_Penstock = 1144
Conf_LH_Npc_FXDialog = 1142
Conf_LH_Npc_FXFight = 1143

Conf_LH_Npc_Self = {
    [0] = { [0] = 1147, [1] = 1148 }, --¼×Ê¿
    [1] = { [0] = 1149, [1] = 1150 }, --µÀÊ¿
    [2] = { [0] = 1151, [1] = 1152 }, --ÒìÈË
}

Conf_LH_Buff_A = 717    -- ´«ËÍ
Conf_LH_Buff_B = 718    -- ±äÉí
Conf_LH_Buff_C = 719    -- ·üôË¶Ô»°
Conf_LH_Buff_D = 720    -- ·üôËÕ½¶·
Conf_LH_Buff_E = 721    -- ·¨Öù

Conf_GD_Flag = 1

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
            Talk(1, "no", "Ng­¬i kh«ng ph¶i" .. thisCamp .. " ®Ö tö ph¸i ta, sau khi tu hµnh danh väng bæn ph¸i h·y ®Õn.")
            return
        end
        SetTaskByte(Task_YinGuoLunHui, 1, 1)
        SetTaskByte(Task_YinGuoLunHui, 2, Conf_GD_Flag)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 38)
        WriteLog("L·nh nhËn <Nh©n qu¶ lu©n håi Tiªn Ma cÊp 65>")
        Msg2Player("§· nhËn nhiÖm vô Nh©n qu¶ lu©n håi.")
        Talk(5, "no", "" .. GetName() .. ":Xin hái tiÒn bèi, Ngôc Ph¸p S¬n ®ét nhiªn ®Êt chuyÓn nói rung, m©y kÐo ïn ïn, lµ do nguyªn nh©n g×?", "Ng­¬i kh«ng biÕt ®©u, trËn ph¸p La Bµn cña Ngôc Ph¸p S¬n bÞ hñy, ph¸p trô mÊt ®i ph¸p lùc khèng chÕ bän ¸c linh trong Ngôc Ph¸p S¬n, dÉn ®Õn ¸c linh hoµnh hµnh, Ngôc Ph¸p S¬n s¾p bÞ sù h¾c ¸m bao trïm råi.", "" .. GetName() .. ":TiÒn bèi, ch¾c viÖc nµy cã liªn quan ®Õn t¹i h¹, xin ng­êi nghe t«i kÓ râ...", "Sao? Ng­êi trÎ tuæi, ng­¬i qu¸ lç m·ng råi! H·y lËp tøc ®i ®i, nhanh chãng rêi khái ®©y ®Ó toµn m¹ng...", "" .. GetName() .. ":V·n bèi s¬ ý, sa bÉy kÎ gian, ph¹m sai lÇm lín, sao cã thÓ bá ch¹y mét m×nh? §Ó v·n bèi ®i chÕ phôc ¸c linh, quyÕt mét trËn sèng m¸i víi chóng!")  --by songlei 2009,11,6

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
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
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

-- Added by Zhaoqingsong at 2009-6-22 end