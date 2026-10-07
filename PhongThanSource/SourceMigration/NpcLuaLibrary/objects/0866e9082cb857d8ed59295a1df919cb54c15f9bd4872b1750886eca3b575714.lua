--description: æ§¼º-Ö÷Ïß?Îñ
--author: yaoxin
--date:2009/1/12

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
    local startLevel = 1

    --²»ÆÚ¶øÓö
    startLevel = 15
    if (GetPlayerExtLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskKnight == 131) or (taskWizard == 131) or (taskDruid == 131) then
                state = 3
                subState = 0
            elseif ((taskKnight == 136) or (taskWizard == 136) or (taskDruid == 136)) and (HaveEventItem(213) > 0) then
                state = 3
                subState = 0
            elseif ((taskKnight > 132) and (taskKnight < 136)) or ((taskWizard > 132) and (taskWizard < 136)) or ((taskDruid > 132) and (taskDruid < 136)) then
                state = 2
                subState = 0
            end
        else
            if (taskKnight == 131) or (taskWizard == 131) or (taskDruid == 131) then
                state = 3
                subState = 1
            elseif ((taskKnight == 136) or (taskWizard == 136) or (taskDruid == 136)) and (HaveEventItem(213) > 0) then
                state = 3
                subState = 1
            elseif ((taskKnight > 132) and (taskKnight < 136)) or ((taskWizard > 132) and (taskWizard < 136)) or ((taskDruid > 132) and (taskDruid < 136)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Á«»¨ÉñµÆ
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskKnight == 140) or (taskWizard == 140) or (taskDruid == 140) then
                state = 1
                subState = 0
            elseif ((taskKnight == 146) or (taskWizard == 146) or (taskDruid == 146)) then
                state = 3
                subState = 0
            elseif ((taskKnight > 140) and (taskKnight < 146)) or ((taskWizard > 140) and (taskWizard < 146)) or ((taskDruid > 140) and (taskDruid < 146)) then
                state = 2
                subState = 0
            end
        else
            if (taskKnight == 140) or (taskWizard == 140) or (taskDruid == 140) then
                state = 1
                subState = 1
            elseif ((taskKnight == 146) or (taskWizard == 146) or (taskDruid == 146)) then
                state = 3
                subState = 1
            elseif ((taskKnight > 140) and (taskKnight < 146)) or ((taskWizard > 140) and (taskWizard < 146)) or ((taskDruid > 140) and (taskDruid < 146)) then
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    local tasks = {
        { "BÊt Kú Nhi Ngé", "renwu15"; show = 0 },
        -- Added by Zhaoqingsong at 2009-2-10 Begin
        { "Liªn Hoa ThÇn §¨ng", "processLotusLamp"; show = 0 },
        -- Added by Zhaoqingsong at 2009-2-10 Edn

    }

    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (UTask_Knight == 131) or (UTask_Wizard == 131) or (UTask_Druid == 131) then
        if (GetPlayerExtLevel() >= 15) then
            tasks[1].show = 1
        end
    elseif (UTask_Knight == 136) or (UTask_Wizard == 136) or (UTask_Druid == 136) then
        if (HaveEventItem(213) > 0) then
            --ÉßÁÛ
            tasks[1].show = 1
        end
    end
    -- Added by Zhaoqingsong at 2009-2-10 Begin
    if (isViewLotusLamp() == 1) then
        tasks[2].show = 1
    end
    -- Added by Zhaoqingsong at 2009-2-10 Edn

    SayTask("Kh«ng t×m ®­îc Phong ThÇn b¶ng, ta quyÕt kh«ng vÒ nh©n gian", tasks)
end;

function renwu15()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (UTask_Knight == 131) or (UTask_Wizard == 131) or (UTask_Druid == 131) then
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 132)
            TaskNote(86, 2)
        elseif (pt == 1) then
            SetTask(1, 132)
            TaskNote(87, 2)
        else
            SetTask(2, 132)
            TaskNote(88, 2)
        end ;

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

        Talk(3, "no", "Ch¼ng ph¶i lµ §¾c Kû sao? Sao lµ tµn t¹ thÕ nµy?", "§¾c Kû: …", "H×nh nh­ lµ m¾c ph¶i ch­íng khİ råi…§Ó ta ®i hái Tu Hµnh S­ xem cã c¸ch g× cøu kh«ng?")
    elseif (UTask_Knight == 136) or (UTask_Wizard == 136) or (UTask_Druid == 136) then
        if (HaveEventItem(213) == 0) then
            --ÉßÁÛ
            Talk(1, "no", "Ta ®· thØnh gi¸o Tu Hµnh S­ råi, bÖnh cña §¾c Kû ph¶i dïng v¶y cña Linh Xµ míi cã thÓ cøu!")
            return 0
        end
        local pt = GetPlayerType()
        local rb = random(1, 100)
        if (pt == 0) then
            SetTask(3, 140)
            TaskNote(86, 7)
            if (rb == 100) then
                AddNormalItem(0, 10, 30, 1, 0, 0, 1)--À¶×øÆï
            else
                AddNormalItem(0, 10, 30, 1, 0, 0, 0)--°××øÆï
            end
        elseif (pt == 1) then
            SetTask(1, 140)
            TaskNote(87, 7)
            if (rb == 100) then
                AddNormalItem(0, 10, 31, 1, 0, 0, 1)--À¶×øÆï
            else
                AddNormalItem(0, 10, 31, 1, 0, 0, 0)--°××øÆï
            end
        else
            SetTask(2, 140)
            TaskNote(88, 7)
            if (rb == 100) then
                AddNormalItem(0, 10, 32, 1, 0, 0, 1)--À¶×øÆï
            else
                AddNormalItem(0, 10, 32, 1, 0, 0, 0)--°××øÆï
            end
        end ;

        DelEventItem(213)--ÉßÁÛ
        local nFactExp = AddOwnExtendExp(120000)--¾­Ñé

        Msg2Player("NhËn ®­îc thó c­ìi vµ ®iÓm tu luyÖn Tiªn Ma giíi" .. floor(nFactExp) .. "§iÓm")
        TopMessage("NhËn ®­îc thó c­ìi vµ ®iÓm tu luyÖn Tiªn Ma giíi" .. floor(nFactExp) .. "§iÓm")

        WriteLog("BÊt Kú Nhi Ngé")
        Talk(3, "shuoming", "Tiªn Ma giíi hung hiÓm kh«n l­êng…kh«ng ngê l¹i ®­îc chİnh cõu nh©n cøu m¹ng m×nh!", "§õng kh¸ch khİ! Mµ t¹i sao l¹i tróng ph¶i ch­íng khİ nh­ vÇy?!", " Ch­íng khİ ë Tiªn Ma giíi qu¸ m¹nh ch­íng khİ, c«ng lùc cña ta kh«ng ®ñ chèng l¹i…¤i! LÏ nµo ta vÜnh viÔn kh«ng thÓ t×m l¹i ®­îc Phong ThÇn b¶ng?..")

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end
end;
function shuoming ()
    Talk(2, "no", "C« ®ang cßn rÊt yÕu, h·y ë ®©y nghØ ng¬i. §Ó ta gióp c« ®i dß hái t«ng tİch Phong ThÇn b¶ng!", "NÕu ng­êi ®· thËt t©m gióp ®ì th× xin nhËn thó c­ìi Tiªn Ma giíi nµy, xem nh­ lêi c¶m t¹ cña tiÓu n÷!")
end
function no()
    CloseDialog()
end;

-- Added by Zhaoqingsong at 2009-2-10 Begin
-- ÏÉÄ§30¼¶Ö÷ÏßÈÎÎñ£¬Á«»¨ÉñµÆ

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

LotusLamp_Lamp_Conf = {
    { flag = 1, x = 1652 * 32, y = 3288 * 32 },
    { flag = 1, x = 1633 * 32, y = 3317 * 32 },
    { flag = 1, x = 1661 * 32, y = 3310 * 32 },
    { flag = 1, x = 1641 * 32, y = 3330 * 32 },
    { flag = 1, x = 1667 * 32, y = 3320 * 32 },
    { flag = 1, x = 1651 * 32, y = 3345 * 32 },
    { flag = 2, x = 1924 * 32, y = 3701 * 32 },
    { flag = 2, x = 1955 * 32, y = 3670 * 32 },
    { flag = 2, x = 1914 * 32, y = 3686 * 32 },
    { flag = 2, x = 1952 * 32, y = 3645 * 32 },
    { flag = 2, x = 1907 * 32, y = 3665 * 32 },
    { flag = 2, x = 1947 * 32, y = 3618 * 32 },
}

-- ÈÎÎñ×´Ì¬±äÁ¿
Task_Lamp_EnvoyID = 1319        -- °ó¶¨µÄÁ«»¨Ê¹ÕßID
Task_Lamp_SummonTime = 1320        -- ÕÙ»½Ê¹ÕßµÄÊ±¼ä
Task_Lamp_TaskStyle = 1321        -- ½ÓµÄÊÇÏÉÄ§±êÖ¾

Global_Lamp_LightCount = 167 -- 1byteÈ«¾Ö±äÁ¿£¬ÁÁµÆÊıÁ¿ 2byte ÉÏ´ÎÁÁµÆ·½,1ÏÉ,2Ä§
Global_Lamp_SummonCount = 168 -- È«¾Ö±äÁ¿£¬ÕÙ»½ÊıÁ¿
Global_FerryDirection_Index = 169 -- È«¾Ö±äÁ¿£¬30¶É½Ù½ÓÒıNpcIndex

NPC_Template_Lamp_Light = 804 -- µãÈ¼µÄÁ«µÆ Npc template
NPC_Template_Lamp_Bleak = 819  -- ÷öµ­µÄÁ«µÆ Npc template
NPC_Template_Lamp_Envoy = 821 -- Á«µÆÊ¹Õß Npc template
NPC_Template_Lamp_Watch = 822 -- ÉñµÆÊØ»¤Õß Npc template
NPC_Template_FerryDirection = 741 -- 30¶É½Ù½ÓÒı Npc template

-- ÊÇ·ñÏÔÊ¾30¼¶Ö÷ÏßÈÎÎñ£¬Á«»¨ÉñµÆ
function isViewLotusLamp()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()

    if (extLevel >= 30 and mainTaskValue >= 140 and mainTaskValue < 150) then
        if (mainTaskValue == 140 or mainTaskValue == 146) then
            return 1
        else
            return 0
        end
    else
        return 0
    end
end

-- ´¦Àí30¼¶Ö÷ÏßÈÎÎñ
function processLotusLamp()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (extLevel >= 30 and mainTaskValue >= 140 and mainTaskValue < 150) then
        local taskStyle = GetTask(Task_Lamp_TaskStyle)
        local xmName = "Tiªn"
        if (taskStyle == 2) then
            xmName = "Ma"
        end
        if (mainTaskValue == 140) then
            Talk(2, "acceptLotusLamp", "Ta ®· dß hái cña t«ng tİch Phong ThÇn b¶ng rÊt l©u råi, ®Õn nay vÉn ch­a ra manh mèi nµo…", "Nghe nãi Tiªn Ma l­ìng ph¸i mçi bªn ®Òu cã 6 ngän Liªn ®¨ng, nÕu th¾p s¸ng chóng lªn cã lÏ sÏ t×m ®­îc manh mèi!")
        elseif (mainTaskValue == 146) then
            finishLotusLamp()
        else
            CloseDialog()
        end
    else
        CloseDialog()
    end
end

-- ÁìÈ¡30¼¶Ö÷ÏßÈÎÎñ
function acceptLotusLamp()
    CloseDialog()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    local credit = GetJusticEvilCredit()
    if (extLevel >= 30 and credit ~= 0 and mainTaskValue == 140) then
        local xmFlag = 1
        local xmName = "Tiªn"
        if (credit < 0) then
            xmFlag = 2
            xmName = "Ma"
        end
        SetTask(MainTask_GD_Conf[playerType].task, 141)
        TaskNote(MainTask_GD_Conf[playerType].note, 8 + ((xmFlag - 1) * 7))
        SetTask(Task_Lamp_TaskStyle, xmFlag)
        Talk(1, "no", "Ng­êi h·y ®i gÆp <c=yel>" .. xmName .. "<c>_Liªn §¨ng Hé gi¶, dß hái bİ mËt cña Liªn Hoa ThÇn §¨ng")

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    else
        if (credit == 0) then
            Talk(1, "no", "Danh väng Tiªn Ma cña ng­¬i lµ 0, kh«ng thÓ nhËn nhiÖm vô!")
        end
        CloseDialog()
    end
end

-- Íê³É30¼¶Ö÷ÏßÈÎÎñ
function finishLotusLamp()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (extLevel >= 30 and mainTaskValue == 146) then
        local itemSelect = {
            "§Çu Kh«i (trang bŞ cÇn ®¼ng cÊp Tiªn Ma: 24)/receiveLotusLampHelm",
            "Yªu ®¸i (trang bŞ cÇn ®¼ng cÊp Tiªn Ma: 28)/receiveLotusLampBelt",
            "Ngoa (trang bŞ cÇn ®¼ng cÊp Tiªn Ma: 32)/receiveLotusLampBoot",
        }
        Say("Th× ra lµ vËy!...Kh«ng biÕt bao giê ta míi cã thÓ lÊy l¹i ®­îc Phong ThÇn b¶ng ®©y!...Bé trang bŞ cÊp <c=yel>30<c> nµy xin tÆng anh hïng! HÑn ngµy t¸i ngé!", 3, itemSelect)

    else
        CloseDialog()
    end
end

-- ÁìÈ¡30¼¶Ö÷ÏßÈÎÎñ½±Àø£¬¿ø
function receiveLotusLampHelm()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (extLevel >= 30 and mainTaskValue == 146) then
        SetTask(MainTask_GD_Conf[playerType].task, 150)
        TaskNote(MainTask_GD_Conf[playerType].note, 14)
        if (playerType == 0) then
            AddNormalItem(0, 7, 27, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬¿ø£¬¼×Ê¿
        elseif (playerType == 1) then
            AddNormalItem(0, 7, 28, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬¿ø£¬µÀÊ¿
        else
            AddNormalItem(0, 7, 29, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬¿ø£¬ÒìÈË
        end ;
        local addExtExp = AddOwnExtendExp(2000000)

        Msg2Player("B¹n nhËn ®­îc ®Çu kh«i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        TopMessage("B¹n nhËn ®­îc ®Çu kh«i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        WriteLog("Liªn Hoa ThÇn §¨ng")
        Talk(1, "no", "B¹n nhËn ®­îc ®Çu kh«i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm kinh nghiÖm.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        CloseDialog()
    end
end

-- ÁìÈ¡30¼¶Ö÷ÏßÈÎÎñ½±Àø£¬Ñü´ø
function receiveLotusLampBelt()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (extLevel >= 30 and mainTaskValue == 146) then
        SetTask(MainTask_GD_Conf[playerType].task, 150)
        TaskNote(MainTask_GD_Conf[playerType].note, 14)
        if (playerType == 0) then
            AddNormalItem(0, 6, 27, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñü´ø£¬¼×Ê¿
        elseif (playerType == 1) then
            AddNormalItem(0, 6, 28, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñü´ø£¬µÀÊ¿
        else
            AddNormalItem(0, 6, 29, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñü´ø£¬ÒìÈË
        end ;
        local addExtExp = AddOwnExtendExp(2000000)

        Msg2Player("B¹n nhËn ®­îc Yªu ®¸i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        TopMessage("B¹n nhËn ®­îc Yªu ®¸i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        WriteLog("Liªn Hoa ThÇn §¨ng")
        Talk(1, "no", "B¹n nhËn ®­îc Yªu ®¸i cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm kinh nghiÖm.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        CloseDialog()
    end
end

-- ÁìÈ¡30¼¶Ö÷ÏßÈÎÎñ½±Àø£¬Ñ¥
function receiveLotusLampBoot()
    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (extLevel >= 30 and mainTaskValue == 146) then
        SetTask(MainTask_GD_Conf[playerType].task, 150)
        TaskNote(MainTask_GD_Conf[playerType].note, 14)
        if (playerType == 0) then
            AddNormalItem(0, 5, 27, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñ¥£¬¼×Ê¿
        elseif (playerType == 1) then
            AddNormalItem(0, 5, 28, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñ¥£¬µÀÊ¿
        else
            AddNormalItem(0, 5, 29, 1, 0, 0) --30¼¶ÂÌÉ«×°±¸£¬Ñ¥£¬ÒìÈË
        end ;
        local addExtExp = AddOwnExtendExp(2000000)

        Msg2Player("B¹n nhËn ®­îc Lam ngoa cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        TopMessage("B¹n nhËn ®­îc Lam ngoa cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm")
        WriteLog("Liªn Hoa ThÇn §¨ng")
        Talk(1, "no", "B¹n nhËn ®­îc Lam ngoa cÊp 30 vµ ®iÓm tu luyÖn Tiªn Ma" .. floor(addExtExp) .. "§iÓm kinh nghiÖm.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        CloseDialog()
    end
end


-- Added by Zhaoqingsong at 2009-2-10 End
