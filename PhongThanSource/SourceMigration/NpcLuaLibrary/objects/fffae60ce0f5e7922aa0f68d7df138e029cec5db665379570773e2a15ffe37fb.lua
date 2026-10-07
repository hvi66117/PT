NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

Task_Process = 1458

Task_Type = 1459
Task_Total_Times = 1460
Task_Accept_Day = 1461
Task_Coordinate = 1462
Task_MonsterID = 1463
Task_Free_Time = 1464

chenghuangNpcID = 1005
chenghuangID = 1003
lilingNpcID = 1006
lilingID = 1004
amberNum = 3
blastID = 1007
buffID = 682

Task_TwelveIdol = 1484

Task_FightStarManNpcID = 1487
Task_FightStarManNpcIdx = 1488

Task_Outoftree = 1478

ID_SoulofDevil = 1113

g_SearchClansMan = 1483

g_Distance = 222

g_ClansMan = 223

questyKey = {
    [1] = { name = "Canh Håi Hån", key = 250 },
    [2] = { name = "Ng­ H×nh th¶o", key = 251 },
    [3] = { name = "Long Ng¹n th¶o", key = 252 }
}

taskItem = {
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

Global_War_Event_State = 212

TASK_SOUL = 1476

SOUL_NPC_TEMPLETE = 47
SOUL_MAX_ACC_TIMES = 3
SOUL_TASK_CAMP_JUSTICE = 1
SOUL_TASK_CAMP_EVIL = 2
SOUL_TASK_BUFF = 702
SOUL_TASK_ITEM_1 = 708
SOUL_TASK_ITEM_2 = 707
CREDIT_LIMIT_MAX = 180000
CREDIT_LIMIT_MIN = 45000
SOUL_ACC_ITEM_J = 428
SOUL_ACC_ITEM_E = 427
ACC_ITEM_COUNT = 5
SOUL_TASK_IB_ITEM = 706
SOUL_TASK_IB_INDEX = 116

PLAYER_RELEASE_SOUL_BUFF = 704
NPC_RELEASE_SOUL_BUFF = 703
PLAYER_CONFUSE_BUFF = 705

aryMonsterType = {
    { name = "Thõa Hoµng", id = 930 },
    { name = "KhØ nói", id = 933 },
    { name = "Tiªn-Lª Linh Thi", id = 931 },
    { name = "Ma-Lª Linh Thi", id = 932 },
}

Task_epistle = 1651

function OnDeath(npcindex)
    if (PlayerIndex <= 0) then
        return
    end

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    if (GetTaskByte(g_SearchClansMan, 1) == 1 and IsExistItem(6, 1, 526, 0) == 0) then
        local growth = GetTaskByte(g_SearchClansMan, 3)
        if math.random(1, 100) <= growth then
            ClearItem(6, 1, 526, 0)

            AddNormalItem(6, 1, 526, 0, 0, 0)
            TopMessage("NhËn 1 <c=yel>L¨ng Nguyªn Ch©u<c>")
            Msg2Player("B¹n nhËn ®­îc 1 L¨ng Nguyªn Ch©u")
            SetTaskByte(g_SearchClansMan, 3, 3)

            TaskNote(109, 1)
        else
            growth = growth + 3
            SetTaskByte(g_SearchClansMan, 3, growth)
        end
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end
    end

    if GetTaskByte(Task_Type, 1) == 1 then
        local nStep = GetTaskByte(Task_Process, 1)
        if nStep == 3 then
            superDoctor(npcindex)
        elseif nStep == 4 or nStep == 5 then
            if GetTask(Task_MonsterID) == GetNpcID(GetTask(Task_Free_Time)) and GetTask(Task_Free_Time) > 0 then

            else
                superDoctor(npcindex)
            end
        end
    end

    soulBackhome(npcindex)

    TwelveIdol(npcindex)

    if (GetTaskByte(Task_Outoftree, 1) == 3) then
        local RandofSoul = math.random(1, 5)

        if (GetTaskByte(Task_Outoftree, 2) == 0) then
            if RandofSoul == 1 then
                AddSoulofDevil(npcindex)
            end
        else
            Msg2Player("Hån Thõa Hoµng ®· bÞ khèng chÕ, xin tranh thñ thêi gian khèng chÕ c¸c hån ph¸ch Ma vËt kh¸c")
            TopMessage("Hån Thõa Hoµng ®· bÞ b¾t")
        end
    end

    processYinGuoLunHui(npcindex)

    if (GetPlayerExtLevel() > 50) and (GetTaskByte(Task_epistle, 1) < 100) then
        yufashan_renwu()
    end

end;

function TwelveIdol(npcindex)
    local nTask = GetTaskByte(Task_TwelveIdol, 1)
    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    if (nGrowth >= 100) then
        SetTaskByte(Task_TwelveIdol, 3, 100)
        return
    end

    if (nTask == 3 and HaveIBBuff(713) > 0 and IsExistItem(6, 1, 528, 0) > 0 and IsInScope(npcindex) == 1) then
        AddGrowth()
    end
end

function IsInScope(npcindex)
    local NpcIdx = 0
    if (GetJusticEvilCredit() > 0) then
        NpcIdx = 1127
    else
        NpcIdx = 1128
    end

    local oldnpcidx = GetTask(Task_FightStarManNpcIdx)
    if (oldnpcidx ~= 0) then
        local oldnpcid = GetTask(Task_FightStarManNpcID)
        if (GetNpcID(oldnpcidx) == oldnpcid and GetNpcTemplateID(oldnpcidx) == NpcIdx) then

            local mapid, x, y = GetNpcWorldPos(npcindex)
            local mapidnpc, xnpc, ynpc = GetNpcWorldPos(oldnpcidx)

            if (mapid == mapidnpc) then
                local nDis = math.sqrt((x * 32 - xnpc * 32) ^ 2 + (y * 32 - ynpc * 32) ^ 2)
                if (nDis <= 600) then
                    return 1
                end

            end

        end
    end

    return 0
end

function AddGrowth()
    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    local nAddPoint = math.random(1, 20)

    if (nAddPoint < 4) then
        nAddPoint = 2
    elseif (nAddPoint < 13) then
        nAddPoint = 5
    elseif (nAddPoint > 6) then
        nAddPoint = 10
    end

    SetTaskByte(Task_TwelveIdol, 3, nGrowth + nAddPoint)
    TopMessage("KÝnh Bå §Ò ®· tr­ëng thµnh" .. nAddPoint .. "%")

    local nTwelveStar = GetTaskByte(Task_TwelveIdol, 4)
    if (nTwelveStar == 10) then
        TaskNote(1084, 4, (nGrowth + nAddPoint))
    else
        TaskNote(1085, 7, (nGrowth + nAddPoint))
    end

    if (nGrowth + nAddPoint >= 100) then
        Talk(1, "no", "KÝnh Bå §Ò cho biÕt, Tinh qu©n ®· håi phôc ph¸p lùc, tØnh l¹i hoµn toµn, mau ®Õn b¸o cho YÓn Thóc Di.")
        SetTaskByte(Task_TwelveIdol, 3, 100)

        if (nTwelveStar == 10) then
            TaskNote(1084, 3)
        else
            if (nTwelveStar == 7) then
                TaskNote(1085, 6)
            else
                TaskNote(1085, 5)
            end
        end
    end

    local nDragonHorn = math.random(1, 1000)
    if (nDragonHorn == 1) then
        AddNormalItem(3, 448, 0, 0, 0, 0)
        TopMessage("NhËn 1 <c=yel>Th­¬ng Long Gi¸c")
    end
end

function no()
    CloseDialog()
end

function soulBackhome(npcindex)

    local nState = GetTaskByte(TASK_SOUL, 1)
    if (nState == 0) then
        return
    end

    local nType = GetTaskByte(TASK_SOUL, 4)
    if (npcindex <= 0) or (GetNpcTemplateID(npcindex) ~= aryMonsterType[nType].id) then
        Msg2Player("Ma vËt b¹n thu phôc kh«ng ph¶i do téc nh©n Di Ph­¬ng mª muéi hãa thµnh, kh«ng cÇn gi¶i cøu hån ph¸ch.")
        return
    end

    local nCurCamp = GetCurCamp()
    if ((nState == SOUL_TASK_CAMP_JUSTICE) and (nCurCamp ~= 3)) or ((nState == SOUL_TASK_CAMP_EVIL) and (nCurCamp ~= 4)) then
        Msg2Player("Phe PK hiÖn t¹i kh«ng phï hîp víi yªu cÇu nhiÖm vô, kh«ng thÓ gióp hån ph¸ch téc nh©n ®­îc siªu tho¸t.")
        return
    end

    local nSoulCount = HaveEffectNpc(SOUL_NPC_TEMPLETE)
    if (nSoulCount >= 5) then
        Msg2Player("Sè hån ph¸ch téc nh©n ®­îc gi¶i cøu ®· ®¹t tèi ®a, kh«ng thÓ gi¶i cøu thªm.")
        return
    end

    if (HaveIBBuff(PLAYER_RELEASE_SOUL_BUFF) <= 0) then
        Msg2Player("B¹n ch­a dïng TØnh ThÇn §¬n víi ma vËt ®­îc thu phôc, nªn ch­a thÓ siªu tho¸t hån ph¸ch téc nh©n.")
        return
    end

    if (NpcHaveIBBuff(npcindex, NPC_RELEASE_SOUL_BUFF) <= 0) then
        Msg2Player("Ma vËt b¹n thu phôc ch­a ®­îc TÞnh Hãa, nªn kh«ng thÓ gi¶i tho¸t cho hån ph¸ch téc nh©n.")
        return
    end

    local nRank = math.random(1, 100)
    if (nRank <= 60) then
        if (nSoulCount <= 0) then
            if (nState == SOUL_TASK_CAMP_JUSTICE) then
                SetEffectNpc("<c=water>Hån ph¸ch téc nh©n<c>", SOUL_NPC_TEMPLETE, 0)
            else
                SetEffectNpc("<c=yel>Hån ph¸ch téc nh©n<c>", SOUL_NPC_TEMPLETE, 0)
            end
        else
            SetEffectNpcCount(nSoulCount + 1)
        end

        Msg2Player("B¹n ®· gi¶i cøu thµnh c«ng hån ph¸ch 1 téc nh©n Di Ph­¬ng, h¾n sÏ theo b¹n ®Õn khi vÒ ®­îc bé téc.")
        ScrollMessage("NhËn 1 Hån ph¸ch téc nh©n")
    else
        if (HaveIBBuff(PLAYER_CONFUSE_BUFF) > 0) then
            RemoveIBBuff(PLAYER_CONFUSE_BUFF)
        end

        if (GetMorphType() == aryMonsterType[nType].id) then
            PolyMorph(-1, 0, 0, 0, 0)
        end

        if (GetMorphType() <= 0) then
            PolyMorph(aryMonsterType[nType].id, 1, 0, -1, 10)
        end

        AddIBBuff(PLAYER_CONFUSE_BUFF)

        Msg2Player("Ma vËt kh«ng ph¶i do téc nh©n mÊt trÝ hãa thµnh, TØnh ThÇn §¬n v« hiÖu, nh­ng t©m trÝ cña b¹n bÞ ¶nh h­ëng bëi Tµ Ma Cæ cña chóng, c¬ thÓ t¹m thêi mÊt kiÓm so¸t.")
        TopMessage("BÞ ¶nh h­ëng bëi Tµ Ma Cæ, t©m trÝ bÞ mª muéi")
    end

    NpcRemoveIBBuff(npcindex, NPC_RELEASE_SOUL_BUFF)

end

function superDoctor(npcindex)
    local monsterNum = GetTaskByte(Task_Process, 4)
    local totalTimes = GetTask(Task_Total_Times)
    local pro = 3 + math.floor(totalTimes / 100)
    local rand = math.random(1, 100)
    local amberItem = taskItem[2].Item

    if (pro > 100) then
        pro = 100
    end

    if (rand < pro) then
        AddNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4], 0, 0)
        ScrollMessage("§­îc 1 tim Hæ Ph¸ch")
    end

    monsterNum = monsterNum + 1
    if (monsterNum >= 255) then
        monsterNum = 16
    end
    SetTaskByte(Task_Process, 4, monsterNum)

    local r = math.random(1, 100)
    if (monsterNum <= 7) then
        if (r < 0) then
            callBoss(npcindex)
        end
    elseif (monsterNum <= 15) then
        if (r < 5) then
            callBoss(npcindex)
        end
    else
        if (r < 10) then
            callBoss(npcindex)
        end
    end
end

function callBoss(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local monsterIndex = AddNpc(chenghuangNpcID, 55, SubWorldID2Idx(id), x * 32, y * 32)
    if monsterIndex > 0 then
        SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\npc³Ë»Æ´óÍõ.lua")
        SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        SetNpcName(monsterIndex, "Thõa Hoµng ®¹i v­¬ng")

        SetTaskByte(Task_Process, 1, 4)
        SetTask(Task_MonsterID, GetNpcID(monsterIndex))
        SetTask(Task_Free_Time, monsterIndex)
        Msg2Player("Dô thµnh c«ng Thõa Hoµng ®¹i v­¬ng")
        TopMessage("Dô thµnh c«ng Thõa Hoµng ®¹i v­¬ng")
        TaskNote(1077, 4)
    end
end

function AddSoulofDevil(npcindex)
    local id, x, y = GetNpcWorldPos(npcindex)
    local SoulofDevilIndex = AddNpc(ID_SoulofDevil, 55, SubWorld, x * 32, y * 32)
    SetGuardLevel(SoulofDevilIndex, 2)
    SetNpcTask(SoulofDevilIndex, 1, 1)
    SetNpcScript(SoulofDevilIndex, "\\script\\¹ÖÎï\\death.lua")
    SetNpcTimer(SoulofDevilIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 10)
    SetNpcName(SoulofDevilIndex, "Hån Thõa Hoµng")
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

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

function processYinGuoLunHui(npcindex)
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    if (taskYinGuoLunHui ~= 1 and taskYinGuoLunHui ~= 5) then
        return
    end
    if (GetFreeNpcCount() <= 200) then
        return
    end
    if (GetIBBuffCount() >= 31) then
        return
    end
    local id, x, y = GetNpcWorldPos(npcindex)
    if (id ~= 75) then
        return
    end

    local num = GetTaskByte(Task_YinGuoLunHui, 4)
    local rand = math.random(1, 100)
    if (rand <= num) then
        local w, x, y = GetWorldPos()
        local newidx = AddNpc(Conf_LH_Npc_Trap, 65, SubWorld, x * 32 + 32, y * 32 + 32)
        if (newidx > 0) then
            if (taskYinGuoLunHui == 1) then
                SetTaskByte(Task_YinGuoLunHui, 1, 2)
                TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 39)
            end
            AddIBBuff(Conf_LH_Buff_A, 60 * 1)
            SetNpcScript(newidx, "\\script\\Óü·¨É½\\Òò¹ûÂÖ»Ø´«ËÍÃÅ.lua")
            SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 1)
            SetNpcTask(newidx, 1, GetPlayerID())
            SetNpcName(newidx, "<c=g>Nh©n qu¶ lu©n håi truyÒn tèng m«n<c>")
            TopMessage("XuÊt hiÖn 1 Lu©n håi truyÒn tèng m«n")
            Msg2Player("XuÊt hiÖn 1 Lu©n håi truyÒn tèng m«n, cã thÓ truyÒn tèng ®Õn thÕ giíi kh¸c.")
            SetTaskByte(Task_YinGuoLunHui, 4, 0)
        end
    else
        num = num + 1
        SetTaskByte(Task_YinGuoLunHui, 4, num)
    end
end

function yufashan_renwu()
    local temp = GetTaskByte(Task_epistle, 1)
    local times = math.floor(temp / 10)
    local state = math.mod(temp, 10)

    if (times >= 10) then
        return 0
    end

    local rluck = math.random(1, 100)
    if (state == 0) then
        if (IsExistItem(6, 1, 790, 0) == 0) and (HaveNormalItemInQuick(6, 1, 790, 0) == 0) and (rluck <= 10) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                return 0
            end

            AddNormalItem(6, 1, 790, 0, 0, 0)
            ScrollMessage("NhÆt ®­îc 1 bøc <c=r>Th­ dÝnh m¸u")
            Msg2Player("Thõa Hoµng lµm r¬i ra 1 bøc Th­ dÝnh m¸u")
        end
        return 0
    elseif (state == 1) then
        if (rluck <= 15) then
            if (IsHaveSpaceForTreasure(1) == 1) then
                AddEventItem(300)
            end

            ScrollMessage("NhËn ®­îc 1 bã <c=g>Long Xµ Th¶o")
            Msg2Player("NhÆt ®­îc trªn m×nh cña Thõa Hoµng 1 bã Long Xµ Th¶o, mang vÒ cho Ph¸p S­ YÓn V©n cña bé l¹c.")
            TaskNote(118, 1)
            SetTaskByte(Task_epistle, 1, 2)
        end
    elseif (state == 3 or state == 4) then

        local luckyValue = 1
        if (times == 0) and (HaveEventItem(296) == 0) then
            luckyValue = 10
        end

        if (rluck <= luckyValue) and (HaveNormalItem(4, 296, 0, 1) < 4) then
            AddEventItem(296)
            ScrollMessage("NhËn ®­îc <c=r>Di Th­ dÝnh m¸u")

            if (IsHaveSpaceForTreasure(1) < 1) then
                Msg2Player("»÷°Ü³Ë»Æ, ÒâÍâµôÂä 1 c¸i È¾ÑªµÄÒÅÊé.¿ÉÏ§±³°üÒÑ¾­ÂúÁË, ÒÅÂäÔÚµØÉÏ")
            else
                Msg2Player("»÷°Ü³Ë»Æ, ÒâÍâµôÂä 1 c¸i È¾ÑªµÄÒÅÊé.¿ÉÒÔÈ¥½»¸øÙÈÔÆÁË.")
                TaskNote(118, 3)
            end
        end
    end

end

