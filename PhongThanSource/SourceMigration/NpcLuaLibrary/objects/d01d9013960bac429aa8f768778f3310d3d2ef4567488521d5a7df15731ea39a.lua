--description: Ò½Éú
--author: yichuan
--date: 2004/5/12
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-09-1
--973Ê±¼ä
--984´ÎÊı
--993ÈÎÎñÄ¿±êa¼°Ä¿±ê¸öÊıb(b*10+a)
Task_DeliverCarbon = 1045;
Task_xianguo = 1211;
--·ÃÇóÏÉ¹ûÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ,2Bit±íÊ¾ÈÎÎñ´ı½»,3Bit±íÊ¾ËÕæ§¼º´¦Íê³É,4Bit±íÊ¾ÄÏ¼«ÏÉÎÌ´¦Íê³É,5Bit±íÊ¾¿ä¸¸Í¼ÌÚ´¦Íê³É,6Bit±íÊ¾ÍÁĞĞËï´¦Íê³É,7Bit±íÊ¾²®ÒØ¿¼´¦Íê³É,8Bit±íÊ¾ÈÎÎñ½áÊø
Task_cold = 1212;
--º®ÊÒĞ§Ó¦ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ£¬3Bit±íÊ¾ÈÎÎñ´ı½»£¬4Bit±íÊ¾½«Æä½»¸øÆäËüNPC½áÊøÈÎÎñ

Task_yisheng = 1604 --²¢·ş»î¶¯ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ
Task_ysday = 1608 --²¢·ş»î¶¯ÈÎÎñ±äÁ¿£º1Bit±íÊ¾ÈÕÆÚ

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

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 19

    --·ÃÇóÏÉ¹û
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(Task_xianguo, 1) == 0) and (GetTaskBit(Task_xianguo, 2) == 0) then
                state = 1
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 8) ~= 1) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 8) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) then
                if (HaveNormalItem(3, 219, 0, 0) == 1 and HaveNormalItem(3, 220, 0, 0) == 1 and HaveNormalItem(3, 221, 0, 0) == 1 and HaveNormalItem(3, 222, 0, 0) == 1 and HaveNormalItem(3, 223, 0, 0) == 1) then
                    state = 3
                    subState = 0
                else
                    state = 2
                    subState = 0
                end
            elseif (GetTaskBit(Task_xianguo, 2) == 1) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(Task_xianguo, 1) == 0) and (GetTaskBit(Task_xianguo, 2) == 0) then
                state = 1
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 8) ~= 1) then
                state = 2
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 8) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) then
                if (HaveNormalItem(3, 219, 0, 0) == 1 and HaveNormalItem(3, 220, 0, 0) == 1 and HaveNormalItem(3, 221, 0, 0) == 1 and HaveNormalItem(3, 222, 0, 0) == 1 and HaveNormalItem(3, 223, 0, 0) == 1) then
                    state = 3
                    subState = 1
                else
                    state = 2
                    subState = 0
                end
            elseif (GetTaskBit(Task_xianguo, 2) == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ñ©ÖĞËÍÌ¿
    startLevel = 21
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(Task_DeliverCarbon)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (state == 1) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (state == 1) then
                state = 0
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    if (isViewHeartEvil() == 1) then
        processHeartEvil()
        return
    end
    if (songxin() == 0) then
        local tasks = {
            { "TrŞ th­¬ng", "yes_1"; show = 1 },
            { "<c=yel>Gi¶i nguy<c>", "Deliver_Carbon"; show = 0 },
            { "D­îc phÈm", "yes_2"; show = 1 },
            { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },
            --	    {"<c=yel>º®ÊÒĞ§Ó¦<c>","cold";show=0},
            { "<c=yel>chuyÓn ®Õn §¹i phu ë M¹nh T©n<c>", "gomengjing"; show = 0 },
            --			{"<c=yel>»¶ÌìÏ²µØ<c>","renwu14";show=1}, ----²¢·ş»î¶¯
        }
        if (GetPlayerType() == 0) then
            if (GetLevel() >= 21) then
                if (GetTask(Task_DeliverCarbon) == 0) then
                    tasks[2].show = 1
                elseif (GetTask(Task_DeliverCarbon) == 1) then
                    tasks[5].show = 1
                end
            end

            local lx = GetTask(Task_xianguo)

            if (GetLevel() >= 19 and GetBit(lx, 2) == 0) then
                tasks[4].show = 1
            end

            local lc = GetTask(Task_cold)

            --			if( GetBit(lc,4) == 0 and GetBit(lx,2) == 1)then
            --				tasks[5].show = 1
            --			end

            SayTask(12568, tasks)
        else
            MsgBox(10282, "yes_2", "no")
        end ;
    end
end;
function Deliver_Carbon()
    AddOwnExp(100)
    SetTask(Task_DeliverCarbon, 1)
    TaskNote(901, 0)
    --AS GaoJingwei 090730
    SetSubTask(901, 1, 1)
    --AE GaoJingwei 090730
    TopMessage(12130)
    Msg2Player("nhËn ®­îc 100 ®iÓm kinh nghiÖm.")
    MsgBox(12208, "gomengjing", "no")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
function gomengjing()
    CloseDialog()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        --Éæ¼°ÈÎÎñ£¬ÓĞµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿ÈÎÎñ½â³ı£¬¹ı³ÌÖĞ²»¿ÉÊ¹ÓÃ´«ËÍ
        Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
    else
        NewWorld(15, 1539, 3403)
        SetFightState(1)
    end ;
end;
function songxin()
    local task_id = 868
    local map_id = 1

    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local type2 = GetByte(task_val, 2)
    local finish = GetByte(task_val, 3)

    local setbit = 0
    if (type1 == map_id) then
        setbit = 7
    elseif (type2 == map_id) then
        setbit = 8
    end

    if (setbit ~= 0) then
        if (GetBit(finish, setbit) == 0) then
            Talk(1, "no", 12569)
            SetTask(task_id, SetByte(task_val, 3, SetBit(finish, setbit, 1)))
            return 1
        end
    end
    return 0
end

function yes_1()
    local life = GetLife(0)
    local mana = GetMana(0)
    local lifemax = GetLife(1)
    local manamax = GetMana(1)
    if (GetLevel() >= 10) then
        if (life ~= lifemax) or (mana ~= manamax) then
            local k = floor((1 - (life + mana) / (lifemax + manamax)) * GetLevel() * 10)
            MsgBox("VÕt th­¬ng kh«ng ®¸ng ng¹i, ta chØ lÊy" .. k .. "l­îng. TiÕn hµnh chø?", "yes_4", "no")
        else
            Talk(1, "no", 10188)
        end ;
    else
        Talk(1, "yes_3", 10189)
    end ;
end;

function yes_2()
    CloseDialog()
    Sale(11);            --µ¯³ö½»Ò×¿ò
end;

function yes_3()
    RestoreLife()
    RestoreMana()
    Msg2Player("Sinh lùc vµ néi lùc cña b¹n ®· hoµn toµn håi phôc.")
    CloseDialog()
end;

function yes_4()
    local life = GetLife(0)
    local mana = GetMana(0)
    local lifemax = GetLife(1)
    local manamax = GetMana(1)
    local k = floor((1 - (life + mana) / (lifemax + manamax)) * GetLevel() * 10)
    if (GetCash() >= k) then
        RestoreLife()
        RestoreMana()
        Pay(k)
        Msg2Player("Sinh lùc vµ néi lùc cña b¹n ®· hoµn toµn håi phôc.")
        CloseDialog()
    else
        Talk(1, "no", 10190)
    end ;
end;

function xianguo()
    local ll = GetTask(Task_xianguo)
    if (GetBit(ll, 1) == 0) then
        MsgBox(14430, "Acceptxianguo", "no")

    else
        if (GetBit(ll, 8) == 1) then
            if (HaveNormalItem(3, 219, 0, 0) == 1 and HaveNormalItem(3, 220, 0, 0) == 1 and HaveNormalItem(3, 221, 0, 0) == 1 and HaveNormalItem(3, 222, 0, 0) == 1 and HaveNormalItem(3, 223, 0, 0) == 1) then
                Talk(2, "jixu", 14431, GetName() .. "T×m ®­îc råi! Xin nhËn lÊy!")
                --É¾³ıµÀ¾ß
                -- modified by yaoxin for bug 2011-4 begin
                for i = 218, 223 do
                    ClearItem(3, i, 0, 0)
                end
                -- modified by yaoxin for bug 2011-4 end
                AddOwnExp(9000)
                TopMessage(14432)
                Msg2Player("B¹n nhËn ®­îc 9000 kinh nghiÖm")
                SetTaskBit(Task_xianguo, 2, 1)--log¸Ä°æ
                --AS GaoJingwei 090730
                SetSubTask(73, -1, 1)
                --AE GaoJingwei 090730
                TaskNote(73, -1)
                --AS GaoJingwei 090728
                refreshNpcTaskState()
                --AE GaoJingwei 090728
                return 0
            else
                --MsgBox(14433,"fangqi","no")	--ÌáÊ¾ĞÅÏ¢ĞèÒªĞŞ¸Ä
                Talk(1, "no", "Ch­a ®ñ vËt phÈm nhiÖm vô, h·y thu thËp ®ñ råi ®Õn gÆp ta.")
                fangqi()
                return 0
            end
        else
            if (GetBit(ll, 8) == 0) then
                fangqi()        --²¹µÆ
            end
            --MsgBox(14433,"fangqi","no")
        end
    end
end;

--AS by hyz 090713 for ĞÂÊÖÓÅ»¯µ÷Õû
--²¹¸øÒ¹Ã÷Öé
function AddLight()

    local numofxianguo = 0
    local numoflight = 0
    local templight = 0

    numoflight = numoflight + HaveItemInAllRoom(3, 218, 0, 0, 0, 0, 0)
    -- modified by yaoxin for bug 2011-4 begin
    for i = 219, 223 do
        numofxianguo = numofxianguo + IsExistItem(3, i, 0, 0)
    end
    -- modified by yaoxin for bug 2011-4 end

    templight = 5 - numoflight - numofxianguo

    if (templight <= 0) then
        --Msg2Player("²»ĞèÒª²¹¸ø¡£")

    else
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Kh«ng ®ñ chç trèng, kh«ng thÓ tiÕn hµnh trang bŞ.")
            return
        end

        AddItemPileNum(3, 218, 0, 0, templight)
        --Msg2Player("»ñµÃÁË"..templight.."¸öÒ¹Ã÷Öé¡£")

    end


end

--AE by hyz 090713 for ĞÂÊÖÓÅ»¯µ÷Õû

function fangqi()

    CloseDialog()
    --for i=2,8 do
    --SetTask(Task_xianguo,SetBit(GetTask(Task_xianguo),i,1))
    --end

    --TaskNote(73,-1)
    --Talk(1,"no",14434)

    --AS by hyz 090713 for ĞÂÊÖÓÅ»¯µ÷Õû
    if (HaveItemInAllRoom(3, 218, 0, 0, 0, 0, 0) < 5) then
        AddLight()

    end
    --AE by hyz 090713 for ĞÂÊÖÓÅ»¯µ÷Õû
end;

function jixu()
    Talk(3, "main", 14435, GetName() .. ":C¸i g×: Kh«ng thÓ thÕ ®­îc!", "Tiªn qu¶ nµy ch¾c ch¾n lµ gi¶ råi Dï sao ng­¬i còng ®· rÊt thµnh t©m! §©y xem nh­ lµ chót quµ män vËy!")
end;

function Acceptxianguo()
    CloseDialog()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("R­¬ng kh«ng ®ñ chç trèng, kh«ng thÓ nhËn nhiÖm vô.")
        return
    end

    Talk(1, "no", 14436)
    SetTaskBit(Task_xianguo, 1, 1)--log¸Ä°æ
    --AS GaoJingwei 090730
    SetSubTask(73, 1, 1)
    --AE GaoJingwei 090730
    --¸øµÀ¾ßºÍÇ®
    TaskNote(73, 0)
    --for i=1,5 do
    --AddNormalItemPile(3,218,0,0,0,0)
    --end
    AddItemPileNum(3, 218, 0, 0, 5)
    Earn(2000)
    TopMessage(14437)
    Msg2Player("B¹n nhËn ®­îc 2000 l­îng")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function cold()
    local lc = GetTask(Task_cold)
    if (GetBit(lc, 1) == 0) then
        MsgBox(14438, "AcceptCold", "no")
        return 0
    else
        if (HaveNormalItem(3, 217, 0, 0) >= 10 and HaveEventItemCount(193) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, 217, 0, 0)
                DelNormalItem(4, 193, 1, 1)
            end
            Talk(2, "no", 14439, "Thuèc ®· chÕ xong! Gióp ta mang ®Õn cho TrÇn Quı Trinh nhĞ!")
            AddNormalItem(3, 224, 0, 0, 0, 0)
            SetTask(Task_cold, SetBit(GetTask(Task_cold), 4, 1))
            TaskNote(74, 1)
            return 0
        else
            local scl = 10 - HaveNormalItem(3, 217, 0, 0)
            local hzl = 10 - HaveEventItemCount(193)

            if (scl < 0) then
                scl = 0
            end
            if (hzl < 0) then
                hzl = 0
            end

            Talk(1, "no", "Ng­¬i cßn thiÕu" .. scl .. " l¸ S¬n Xuyªn liÔu vµ" .. hzl .. " Lı" .. "T×m ®ñ råi ®Õn t×m ta nhĞ!")
            return 0
        end
    end
end;

function AcceptCold()
    Talk(1, "no", 14440)
    AddNormalItem(5, 0, 0, 1, 0, 0)
    SetTask(Task_cold, SetBit(GetTask(Task_cold), 1, 1))
    TaskNote(74, 0)
end;

function no()
    CloseDialog()
end;


-- Added by zhaoqingsong at 2008-8-15 begin
-- ĞÄÄ§ÄÑ³ıÈÎÎñ

-- ÈÎÎñ×´Ì¬±äÁ¿£¬
-- 1 Byte Ê¦¸µÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ£¬2 ÈÎÎñÍê³É£»
-- 2 Byte Í½µÜÈÎÎñ×´Ì¬£¬0 Î´×ö¹ı£¬1 ÒÑ×ö¹ı£»
-- 3 Byte Ê¦Í½±êÖ¾£¬1 Ê¦¸µ£¬2 Í½µÜ£»
-- 4 Byte ÏÂÒ»´ÎÈ¡Ò©µØÍ¼
Task_HeartEvil_Status = 1242
Task_HeartEvil_PrenticeID = 1243 -- Í½µÜID
Task_HeartEvil_SummonTime = 1244 -- ÕĞBossÊ±¼ä
Task_HeartEvil_BossID = 1245     -- BossID

-- Ëæ»úµØÍ¼
Random_Maps = {
    [0] = { mapid = 0, name = "Khu vùc v« hiÖu" },
    [1] = { mapid = 2, name = "Sïng Thµnh doanh" },
    [2] = { mapid = 3, name = "Ngäc H­ cung" },
    [3] = { mapid = 4, name = "Xi V­u Mé" },
    [4] = { mapid = 20, name = "T©y Kú" },
    [5] = { mapid = 21, name = "TriÒu Ca" },
}

-- ÊÇ·ñÏÔÊ¾ĞÄÄ§ÄÑ³ı°´Å¥
function isViewHeartEvil()
    local taskStatus = GetByte(GetTask(Task_HeartEvil_Status), 1)
    local masterFlag = GetByte(GetTask(Task_HeartEvil_Status), 3)
    local viewFlag = GetBit(GetTask(Task_HeartEvil_Status), 13)
    local taskMapID = Random_Maps[GetByte(GetTask(Task_HeartEvil_Status), 4)].mapid
    local mapid = GetWorldPos()
    local isHavePulseRed = HaveItemInAllRoom(6, 1, 382, 1, 0, 0, 0)

    if (taskStatus == 1 and masterFlag == 2 and taskMapID == mapid
            and (isHavePulseRed == 0 or (isHavePulseRed == 1 and viewFlag == 1))) then
        return 1
    else
        return 0
    end
end

-- ĞÄÄ§ÄÑ³ı´¦Àí²Ù×÷
function processHeartEvil()
    local taskStatus = GetByte(GetTask(Task_HeartEvil_Status), 1)
    local masterFlag = GetByte(GetTask(Task_HeartEvil_Status), 3)
    local taskMapID = Random_Maps[GetByte(GetTask(Task_HeartEvil_Status), 4)].mapid
    local mapid = GetWorldPos()
    local isHavePulseRed = HaveItemInAllRoom(6, 1, 382, 1, 0, 0, 0)

    if (taskStatus == 1 and masterFlag == 2 and taskMapID == mapid and isHavePulseRed > 0) then
        SetTask(Task_HeartEvil_Status, SetBit(GetTask(Task_HeartEvil_Status), 13, 0))
        Talk(1, "no", 14441)
    elseif (taskStatus == 1 and masterFlag == 2 and taskMapID == mapid) then
        AddNormalItem(6, 1, 382, 1, 0, 0)
        local randomMap = random(1, 5)
        SetTask(Task_HeartEvil_Status, SetBit(GetTask(Task_HeartEvil_Status), 13, 1))
        SetTask(Task_HeartEvil_Status, SetByte(GetTask(Task_HeartEvil_Status), 4, randomMap))
        Talk(1, "no", 14442)
    else
        CloseDialog()
    end
end

-- Added by zhaoqingsong at 2008-8-15 end

------------------²¢·ş»î¶¯------¿ªÊ¼
--function renwu14()
--	CloseDialog()
--
--	local  thisday=floor(LocalSystemTime()/86400)--ÖØÖÃ ½ñÌìÊÇÄÇÒ»Ìì
--	lastday = GetTask(Task_ysday) --»ñµÃ¼ÇÂ¼µÄÊÇÄÇÒ»Ìì
--	local n= GetTaskByte(Task_yisheng,1) ----È¡»î¶¯´ÎÊı
--	if ( thisday  ~= lastday ) then
--		SetTaskByte(Task_yisheng,1,0)
--		SetTask(Task_ysday,thisday)
--		MsgBox("½ñÌìÒª¿ªÊ¼ĞÂµÄÈÎÎñÂğ£¿","htxd","no")
--	elseif (n<3) then
--		MsgBox("ºÏ²¢·şÎñÆ÷Ç°ÆÚ»î¶¯£ºÈºĞÛÖğÂ¹Ö®»¶ÌìÏ²µØ»î¶¯ÆÚ¼ä£¬Ã¿Ìì¿ÉÔÚÊôÓÚÍ¬Ö°ÒµµÄĞÂÊÖ´å»ñµÃÈı´Î»÷É±¹ÖÎïË«±¶¾­ÑéµÄ×´Ì¬£¬ÇëÄúÕäÏ§Ê¹ÓÃ´ÎÊı£¬µã»÷È·¶¨ÁìÈ¡¡£","htxd","no")
--	else
--		Talk(1, "no", "Äú½ñÌìÒÑ¾­»ñµÃÁËÈı´Î»÷É±¹ÖÎïË«±¶¾­Ñé×´Ì¬µÄ»ú»á£¬²»ÄÜ¼ÌĞøÁìÈ¡¡£");
--	end
--end
--
--function htxd()
--	CloseDialog()
--	if (GetIBBuffCount() >= 32) then
--		Talk(1, "no", "Ò½Éú£ºÄãĞ¯´øµÄ¹¦ÄÜ×´Ì¬¹ı¶à£¬ÇëÇå³ıÒ»Ğ©ÔÙÀ´¡£")
--		return
--	end
--	local n= GetTaskByte(Task_yisheng,1) ----È¡»î¶¯´ÎÊı
--	if (n >= 3) then
--		Talk(1,"no","Ò½Éú£ºÄú½ñÌìÒÑ¾­ÁìÈ¡¹»Èı´ÎÁË£¬ÇëÃ÷ÌìÔÙÀ´ÁìÈ¡¡£")
--		return
--	elseif ( HaveIBBuff(1090) ~= 0) then
--		Talk(1,"no","Ò½Éú£ºÄúÒÑ¾­ÓĞË«±¶¾­Ñé×´Ì¬ÁË£¬ÇëÊ¹ÓÃÍêÒÑÓĞ×´Ì¬ºó£¬ÔÙÀ´ÕÒÎÒÁìÈ¡¡£")
--		return
--	else
--		n = n + 1
--		AddIBBuff(1090)
--		Talk(1,"no","Ò½Éú£ºÄúÁìÈ¡ÁË»¶ÌìÏ²µØÈÎÎñ£¬Çë×¢ÒâÊ¹ÓÃÊ±¼ä¡£")
--		SetTaskByte(Task_yisheng,1,n) ----ÖÃ¸øÍæ¼Òn´ÎÊı
--
--		local  thisday=floor(LocalSystemTime()/86400)--ÖØÖÃ ¼ÆËãÊÇÄÇÒ»Ìì
--		SetTask(Task_ysday,thisday) --¼ÇÂ¼ÁËµ±ÌìÁìÈ¡ÁËÈÎÎñ
--	end
--end
------------------²¢·ş»î¶¯------½áÊø
