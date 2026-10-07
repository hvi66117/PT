--description:·öåöµÀÈË
--author: Gaojignwei
--date:2009/3/12

Task_Process = 1345      --1byte: 1:ÒÑÓÚĞŞĞĞÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑıµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø

--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/30 begin
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

    --ÁìÃü¹éÕæ µÚÒ»²½
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 2) then
                state = 3
                subState = 0
            end
        else
            if (process == 2) then
                state = 3
                subState = 1
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
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/30 end

function main()
    local tasks = {
        { "VËt t­ chiÕn bŞ", "processTopTower"; show = 1 }, --songlei by 2009.9.22
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 },
        { "VÒ K×nh Thiªn th¸p", "aboutTopTower"; show = 1 }, --songlei by 2009.9.22
    }

    if (GetTaskByte(Task_Process, 1) == 2 and GetJusticEvilCredit() > 0) then
        tasks[2].show = 1
    end

    SayTask(" Con ®­êng Tiªn ®¹o rÊt cam khæ, cÇn ph¶i cã sù kiªn tr× míi mong ®¹t thµnh ch¸nh qu¶!", tasks)
end

function listenTask()
    CloseDialog()
    if (GetTaskByte(Task_Process, 1) == 2 and HaveIBBuff(548) > 0) then
        Talk(1, "no", "Phİa trªn BÊt Chu S¬n chİnh lµ Tiªn giíi, muèn lªn ®­îc trªn ®ã ph¶i qua ngh×n n¨m khæ luyÖn. Ng­¬i giê cã ®Ó ®i gÆp <c=g>V« ¦¬ng Tö<c>.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 7, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        TopMessage("Nghe Phï BËt §¹o Nh©n gi¶ng ph¸p.")
        BeginMotion(Task_Process, 0, 30, "\\script\\motion\\½²·¨½ø¶ÈÏìÓ¦.lua", nInterrupt)
    else
        Talk(1, "no", "Thêi gian ®· hÕt. TiÕc qu¸, ng­¬i thÊt b¹i råi! VÒ gÆp Tu Hµnh S­ ®i, cã thÓ vÉn cßn c¬ héi!")
    end
end

function no()
    CloseDialog()
end;

------------------------------------------------------

-- songlei by 2009.9.22

-- Ã¿ÈÕÑ­»·ÈÎÎñ£¬Õ½±¸Îï×ÊÒÆÖ²

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ£¬2 ÈÎÎñÍê³É
-- 2 Byte ÈÎÎñÀàĞÍ£¬1 Õ½±¸Îï×Ê£¬2 À©³ä¾ü±¸
-- 3 Byte ÁÔÉ±¹ÖÎï±àºÅ
-- 4 Byte »ñµÃ²»ÖÜÉ½Ê¯ÊıÁ¿
Task_Tower_Status = 1347
Task_Tower_Receive = 1348    -- ÁìÈ¡ÈÎÎñÈÕÆÚ¼°´ÎÊı
Task_DuJie = 1285 -- ¶È½ÙÈÎÎñ±äÁ¿£¬Ğè²Î¿¼¶È½ÙÈÎÎñ

Global_Tower = 176

Task_Info_Tower = 1032    -- F11

Tower_IBItem_Idx = 107

Tower_Type_Idx = 1

Tower_Rule = {
    { desc = "NhiÖm vô Tiªn giíi", name = "VËt t­ chiÕn bŞ", symbol = 1, gd = "Tiªn", npc = "Phï BËt §¹o Nh©n", camp = 3, award = "BÊt Chu HuyÒn ThiÕt", gen = { 3, 361 } },
    { desc = "NhiÖm vô Ma giíi", name = "T¨ng qu©n bŞ", symbol = -1, gd = "Ma", npc = "Lı H­ng B¸", camp = 4, award = "BÊt Chu Tinh Cang", gen = { 3, 362 } },
}

Tower_Boss = {
    { name = "Tiªn Phong Yªu" }, --1
    { name = "Ma Phong Yªu" }, --2
    { name = "Sãi" }, --3
    { name = "Tiªn Phong thó s¬n hån" }, --4
    { name = "Ma Phong thó s¬n hån" }, --5
    { name = "HuyÕt Yªu" }, --6
}

Tower_Boss_Rule = {
    {
        { --30¡ÜLV¡Ü35
            { name = "Ma Phong Yªu", idx = 2, ratio = 100 },
        },
        { --35£¼LV¡Ü40
            { name = "Ma Phong Yªu", idx = 2, ratio = 20 },
            { name = "Sãi", idx = 3, ratio = 100 },
        },
        { --40£¼LV¡Ü45
            { name = "Sãi", idx = 3, ratio = 20 },
            { name = "Ma Phong thó s¬n hån", idx = 5, ratio = 100 },
        },
        { --45£¼LV¡Ü50
            { name = "Ma Phong thó s¬n hån", idx = 5, ratio = 20 },
            { name = "HuyÕt Yªu", idx = 6, ratio = 100 },
        },
        { --50£¼LV
            { name = "Ma Phong Yªu", idx = 2, ratio = 10 },
            { name = "Sãi", idx = 3, ratio = 20 },
            { name = "Ma Phong thó s¬n hån", idx = 5, ratio = 50 },
            { name = "HuyÕt Yªu", idx = 6, ratio = 100 },
        },
    },
    {
        { --30¡ÜLV¡Ü35
            { name = "Tiªn Phong Yªu", idx = 1, ratio = 100 },
        },
        { --35£¼LV¡Ü40
            { name = "Tiªn Phong Yªu", idx = 1, ratio = 20 },
            { name = "Sãi", idx = 3, ratio = 100 },
        },
        { --40£¼LV¡Ü45
            { name = "Sãi", idx = 3, ratio = 20 },
            { name = "Tiªn Phong thó s¬n hån", idx = 4, ratio = 100 },
        },
        { --45£¼LV¡Ü50
            { name = "Tiªn Phong thó s¬n hån", idx = 4, ratio = 20 },
            { name = "HuyÕt Yªu", idx = 6, ratio = 100 },
        },
        { --50£¼LV
            { name = "Tiªn Phong Yªu", idx = 1, ratio = 10 },
            { name = "Sãi", idx = 3, ratio = 20 },
            { name = "Tiªn Phong thó s¬n hån", idx = 4, ratio = 50 },
            { name = "HuyÕt Yªu", idx = 6, ratio = 100 },
        },
    },
}

Tower_Buff = {
    { desc = "Tr©n träng cña Chóc Dung", buffid = 563 },
    { desc = "ChiÕu cè cña Chóc Dung", buffid = 564 },
    { desc = "Lêi khen cña Chóc Dung", buffid = 565 },
}

Tower_Top_Credit = 45000
Tower_Top_Credit_2 = 180000

function aboutTopTower()
    local tasks = {
        { "Ph©n bè K×nh Thiªn th¸p", "aboutTopTowerA"; show = 1 },
        { "X©y K×nh Thiªn th¸p", "aboutTopTowerB"; show = 1 },
        { "Ph¸ K×nh Thiªn th¸p", "aboutTopTowerC"; show = 1 },
        { "Tr©n träng cña Chóc Dung", "aboutTopTowerD"; show = 1 },
        { "ChiÕu cè cña Chóc Dung", "aboutTopTowerE"; show = 1 },
        { "Lêi khen cña Chóc Dung", "aboutTopTowerF"; show = 1 },
    }
    SayTask(14772, tasks)
end;

function aboutTopTowerA()
    CloseDialog()

    Talk(1, "no", " K×nh Thiªn th¸p n»m ë trung t©m <c=g>BÊt Chu S¬n<c>, xung quanh cßn cã <c=g>B¾c th¸p<c>(232,216), <c=g>§«ng th¸p<c>(239,223) vµ <c=g>T©y th¸p<c>(230,223), sau khi tõ BÊt Chu Thiªn Quan ®i vµo BÊt Chu S¬n, cø tiÕn th¼ng theo h­íng §«ng B¾c mµ ®i!")
end;

function aboutTopTowerB()
    CloseDialog()

    Talk(1, "no", " Khi K×nh Thiªn th¸p trong tr¹ng th¸i tù do hoÆc Tiªn giíi chiÕm cø, chØ cÇn trang bŞ <c=yel>Lç Ban phñ<c> vµ sö dông <c=yel>Ban M«n Léng Phñ<c>, cã thÓ trùc tiÕp vµo trung t©m x©y dùng, cho ®Õn khi th¸p nµy hoµn toµn thuéc vÒ Tiªn giíi.")
end;

function aboutTopTowerC()
    CloseDialog()

    Talk(1, "no", " Khi K×nh Thiªn th¸p bŞ Ma giíi chiÕm cø hoÆc bŞ khèng chÕ, cã <c=yel>Lç Ban phñ<c> vµ sö dông <c=yel>Ban M«n Léng Phñ<c>, sÏ tÊn c«ng ph¸ hñy, cho ®Õn khi th¸p trë l¹i tr¹ng th¸i tù do.")
end;

function aboutTopTowerD()
    CloseDialog()

    Talk(1, "no", " NÕu nh­ phe m×nh t¹i K×nh Thiªn th¸p ®· khèng chÕ ®­îc <c=g>1<c> th¸p, th× c¸c Tiªn giíi ®ang ë BÊt Chu S¬n ®Òu sÏ nhËn ®­îc <c=g>Tr©n träng cña Chóc Dung<c>, nÕu ai ®ang nhËn nhiÖm vô cña Ho¶ thÇn, sÏ cã <c=g>tû lÖ thÊp<c> nhËn ®­îc vËt phÈm nhiÖm vô.")
end;

function aboutTopTowerE()
    CloseDialog()

    Talk(1, "no", " NÕu nh­ phe m×nh t¹i K×nh Thiªn th¸p ®· khèng chÕ ®­îc <c=g>2<c> th¸p, th× c¸c Tiªn giíi ®ang ë BÊt Chu S¬n ®Òu sÏ nhËn ®­îc <c=g>ChiÕu cè cña Chóc Dung<c>, nÕu ai ®ang nhËn nhiÖm vô cña Ho¶ thÇn, sÏ cã <c=g>tû lÖ cao<c> nhËn ®­îc vËt phÈm nhiÖm vô.")
end;

function aboutTopTowerF()
    CloseDialog()

    Talk(1, "no", " NÕu nh­ phe m×nh ®· khèng chÕ ®­îc <c=g>toµn bé<c> K×nh Thiªn th¸p, th× c¸c Tiªn giíi ®ang ë BÊt Chu S¬n ®Òu sÏ nhËn ®­îc <c=g>Lêi khen cña Chóc Dung<c>, nÕu ai ®ang nhËn nhiÖm vô cña Ho¶ thÇn, sÏ cã <c=g>tû lÖ cùc cao<c> nhËn ®­îc vËt phÈm nhiÖm vô. §ång thêi nÕu lóc nµy phe Ma giíi ®ang cã ng­êi thùc hiÖn nhiÖm vô danh väng, sÏ kh«ng nhËn ®­îc bÊt cø vËt phÈm nµo!")
end;

function processTopTower()

    local crossDisaster = GetTaskByte(Task_DuJie, 1)
    if (crossDisaster < 1) then
        Talk(1, "no", " Ng­¬i ch­a th«ng qua <c=g>§é KiÕp<c>, träng tr¸ch nµy ta kh«ng thÓ giao cho ng­¬i, ®îi khi nµo hoµn thµnh kh¶o nghiÖm §é kiÕp råi h·y quay l¹i t×m ta!")
        return
    end

    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus == 0) then
        local credit = GetJusticEvilCredit()
        if (abs(credit) < 15000) then
            Talk(1, "no", " MÆc dï ng­¬i ®· cã chót danh väng Tiªn ma, nh­ng ch­a ®ñ ®Ó ta tİn nhiÖm. Bao giê danh väng ®¹t ®Õn 15000 h·y quay l¹i gÆp ta!")
            return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit and crossDisaster < 2) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½Àú¾­<c=g>À×öªÆğÀı<c>Ö®ÊÂºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit_2 and crossDisaster < 3) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½³¬ÍÑ¶É½Ùºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
        end
        local currentDay = floor(LocalSystemTime() / 86400)
        local receiveDay = GetTaskWord(Task_Tower_Receive, 1)
        local receiveTime = GetTaskByte(Task_Tower_Receive, 3)
        if (receiveDay < currentDay) then
            receiveTime = 0
            SetTaskWord(Task_Tower_Receive, 1, currentDay)
            SetTaskByte(Task_Tower_Receive, 3, receiveTime)
        end
        receiveTime = receiveTime + 1
        if (receiveTime > 3) then
            Talk(1, "no", " LuyÖn ho¸ BÊt Chu S¬n th¹ch kh«ng thÓ mét sím mét chiÒu cã thÓ ®¹t ®­îc. Ng­¬i còng ®· vÊt v¶ qu¸ råi, h·y t¹m thêi nghØ ng¬i! Bao giê tinh lùc sung m·n quay l¹i gÆp ta!")
            return
        elseif (receiveTime == 1) then
            MsgBox(14771, "receiveTopTower", "no")
        else
            local Name, Cv, Cfs = GetCostCoinInfoByIdx(Tower_IBItem_Idx)
            MsgBox(" MÆc dï cÇn BÊt Chu S¬n th¹ch ®Ó bæ sung VËt t­ chiÕn bŞ, nh­ng viÖc luyÖn hãa vÉn khiÕn ta ®au ®Çu! NÕu ng­¬i mang ®Õn cho ta 1 quyÓn <c=yel>" .. Name .. "<c> hoÆc <c=yel>" .. Cfs .. "<c> tiÒn §ång ®Ó luyÖn ho¸ binh khİ, ta sÏ cho ng­¬i nhiÒu c¬ héi ®i thu thËp Chu S¬n th¹ch. Sao h¶?", "receiveTopTowerIB", "no")
        end
    elseif (taskStatus < 3) then
        local taskType = GetTaskByte(Task_Tower_Status, 2)
        if (taskType ~= Tower_Type_Idx) then
            Talk(1, "no", " NÕu ng­¬i muèn gia nhËp Tiªn giíi, ta s½n sµng tiÕp nhËn. Cã ®iÒu hiÖn ng­¬i ®ang nhËn " .. Tower_Rule[taskType].name .. " gióp Ma giíi thu thËp BÊt Chu S¬n th¹ch, ng­¬i h·y mau quay vÒ" .. Tower_Rule[taskType].npc .. " huû sø mÖnh ®ã, ta sÏ tiÕp n¹p ng­¬i! Suy nghÜ cho kü nhĞ!")
            return
        end
        if (taskStatus == 1) then
            local bossIdx = GetTaskByte(Task_Tower_Status, 3)
            local getStore = GetTaskByte(Task_Tower_Status, 4)
            local tasks = {
                { "Hñy báVËt t­ chiÕn bŞ", "cancelTopTower"; show = 1 },
            }
            SayTask("BÊt Chu S¬n th¹ch cã xung quanh <c=g>" .. Tower_Boss[bossIdx].name .. "<c>. NÕu nh­ phe m×nh ®· khèng chÕ K×nh Thiªn th¸p ë BÊt Chu S¬n th× ng­¬i sÏ nhËn ®­îc tr¹ng th¸i <c=g>Chóc Dung<c>. §ång thêi trong lóc tiªu diÖt qu¸i thó phe PK l·nh ®Şa cña m×nh sÏ biÕn thµnh <c=cyan>mµu xanh<c>, nhiÒu kh¶ n¨ng sÏ nhËn ®­îc BÊt Chu S¬n th¹ch, sau khi thu ®ñ <c=g>10<c> miÕng cã thÓ vÒ phôc mÖnh. NÕu c¶m thÊy nhiÖm vô nµy qu¸ khã, cã thÓ huû bá!", tasks)
        else
            finishTopTower()
        end
    else
        CloseDialog()
    end
end

function receiveTopTower()

    local crossDisaster = GetTaskByte(Task_DuJie, 1)
    if (crossDisaster < 1) then
        Talk(1, "no", " Ng­¬i ch­a th«ng qua <c=g>§é KiÕp<c>, träng tr¸ch nµy ta kh«ng thÓ giao cho ng­¬i, ®îi khi nµo hoµn thµnh kh¶o nghiÖm §é kiÕp råi h·y quay l¹i t×m ta!")
        return
    end
    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus == 0) then
        --Add By Guoqun for ¸Ä±äÕóÓªºó£¬¿ªºìÉ±ÈË at 2010-12-14 Begin
        if (7 ~= GetCamp()) or (GetPK() > 87) then
            Talk(1, "no", "Ng­¬i ®ang ë trang th¸i PK kh«ng thÓ nhËn nhiÖm vô nµy!")
            return
        end
        --Add By Guoqun for ¸Ä±äÕóÓªºó£¬¿ªºìÉ±ÈË at 2010-12-14 End

        local credit = GetJusticEvilCredit()
        if (abs(credit) < 15000) then
            Talk(1, "no", " MÆc dï ng­¬i ®· cã chót danh väng Tiªn ma, nh­ng ch­a ®ñ ®Ó ta tİn nhiÖm. Bao giê danh väng ®¹t ®Õn 15000 h·y quay l¹i gÆp ta!")
            return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit and crossDisaster < 2) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½Àú¾­<c=g>À×öªÆğÀı<c>Ö®ÊÂºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit_2 and crossDisaster < 3) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½³¬ÍÑ¶É½Ùºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
        end
        local currentDay = floor(LocalSystemTime() / 86400)
        local receiveDay = GetTaskWord(Task_Tower_Receive, 1)
        local receiveTime = GetTaskByte(Task_Tower_Receive, 3)
        if (receiveDay < currentDay) then
            receiveTime = 0
            SetTaskWord(Task_Tower_Receive, 1, currentDay)
            SetTaskByte(Task_Tower_Receive, 3, receiveTime)
        end
        receiveTime = receiveTime + 1
        if (receiveTime > 3) then
            Talk(1, "no", " LuyÖn ho¸ BÊt Chu S¬n th¹ch kh«ng thÓ mét sím mét chiÒu cã thÓ ®¹t ®­îc. Ng­¬i còng ®· vÊt v¶ qu¸ råi, h·y t¹m thêi nghØ ng¬i! Bao giê tinh lùc sung m·n quay l¹i gÆp ta!")
            return
        elseif (receiveTime > 1) then
            receiveTopTowerIB()
            return
        end
        local rand = random(1, 100)
        local gdLevel = GetPlayerExtLevel()
        gdLevel = (gdLevel == 30 and 31) or gdLevel
        local ruleLevel = floor((gdLevel - 31) / 5) + 1
        ruleLevel = (ruleLevel > 5 and 5) or ruleLevel
        local bossIdx = 0
        for k, v in Tower_Boss_Rule[Tower_Type_Idx][ruleLevel] do
            if (rand <= v.ratio) then
                bossIdx = v.idx
                break
            end
        end

        SetTaskByte(Task_Tower_Receive, 3, receiveTime)
        SetTaskByte(Task_Tower_Status, 1, 1)
        SetTaskByte(Task_Tower_Status, 2, Tower_Type_Idx)
        SetTaskByte(Task_Tower_Status, 3, bossIdx)
        SetTaskByte(Task_Tower_Status, 4, 0)

        SetCamp(Tower_Rule[Tower_Type_Idx].camp)

        TaskNote(Task_Info_Tower + Tower_Type_Idx, 0, Tower_Boss[bossIdx].name, 0)
        -- Added by Zhaoqingsong at 2009-4-20 begin
        syncTopTowerBible()
        -- Added by Zhaoqingsong at 2009-4-20 end
        Talk(1, "no", "H«m nay ng­¬i ®· nhËn " .. receiveTime .. ", BÊt Chu S¬n th¹ch cã xung quanh <c=g>" .. Tower_Boss[bossIdx].name .. "<c>. NÕu nh­ phe m×nh ®· khèng chÕ K×nh Thiªn th¸p ë BÊt Chu S¬n th× ng­¬i sÏ nhËn ®­îc tr¹ng th¸i <c=g>Chóc Dung<c>. §ång thêi trong lóc tiªu diÖt qu¸i thó phe PK l·nh ®Şa cña m×nh sÏ biÕn thµnh <c=cyan>mµu xanh<c>, nhiÒu kh¶ n¨ng sÏ nhËn ®­îc BÊt Chu S¬n th¹ch, sau khi thu ®ñ <c=g>10<c> miÕng cã thÓ vÒ phôc mÖnh.")
    else
        CloseDialog()
    end
end

function receiveTopTowerIB()

    local crossDisaster = GetTaskByte(Task_DuJie, 1)
    if (crossDisaster < 1) then
        Talk(1, "no", " Ng­¬i ch­a th«ng qua <c=g>§é KiÕp<c>, träng tr¸ch nµy ta kh«ng thÓ giao cho ng­¬i, ®îi khi nµo hoµn thµnh kh¶o nghiÖm §é kiÕp råi h·y quay l¹i t×m ta!")
        return
    end
    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus == 0) then
        --Add By Guoqun for ¸Ä±äÕóÓªºó£¬¿ªºìÉ±ÈË at 2010-12-14 Begin
        if (7 ~= GetCamp()) or (GetPK() > 87) then
            Talk(1, "no", "Ng­¬i ®ang ë trang th¸i PK kh«ng thÓ nhËn nhiÖm vô nµy!")
            return
        end
        --Add By Guoqun for ¸Ä±äÕóÓªºó£¬¿ªºìÉ±ÈË at 2010-12-14 End

        local credit = GetJusticEvilCredit()
        if (abs(credit) < 15000) then
            Talk(1, "no", " MÆc dï ng­¬i ®· cã chót danh väng Tiªn ma, nh­ng ch­a ®ñ ®Ó ta tİn nhiÖm. Bao giê danh väng ®¹t ®Õn 15000 h·y quay l¹i gÆp ta!")
            return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit and crossDisaster < 2) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½Àú¾­<c=g>À×öªÆğÀı<c>Ö®ÊÂºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
            --		elseif (credit*Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit_2 and crossDisaster < 3) then  --songlei by 2009.9.23 ÉùÍûÏŞÖÆÅĞ¶ÏºóÖÃÓÚÁìÈ¡ÉùÍû½±Àø
            --			Talk(1,"no","·öåöµÀÈË£ºËäÈ»Õ½±¸Ö®ÊÂ²»¿ÉÍÏÑÓ£¬µ«ÄãÏÖÔÚÒµÒÑÃæÁÙĞÂµÄ¶É½Ù¿¼Ñé£¬ÎÒµÈ·Ç×ÔË½Ö®±²£¬Äã´ó¿É×¨ĞÄÓ­½ÓÌôÕ½£¬´ıµ½³¬ÍÑ¶É½Ùºó£¬ÔÙ·µ»ØÖúÎÒ£¡")
            --			return
        end
        local currentDay = floor(LocalSystemTime() / 86400)
        local receiveDay = GetTaskWord(Task_Tower_Receive, 1)
        local receiveTime = GetTaskByte(Task_Tower_Receive, 3)
        if (receiveDay < currentDay) then
            receiveTime = 0
            SetTaskWord(Task_Tower_Receive, 1, currentDay)
            SetTaskByte(Task_Tower_Receive, 3, receiveTime)
        end
        receiveTime = receiveTime + 1
        if (receiveTime > 3) then
            Talk(1, "no", " LuyÖn ho¸ BÊt Chu S¬n th¹ch kh«ng thÓ mét sím mét chiÒu cã thÓ ®¹t ®­îc. Ng­¬i còng ®· vÊt v¶ qu¸ råi, h·y t¹m thêi nghØ ng¬i! Bao giê tinh lùc sung m·n quay l¹i gÆp ta!")
            return
        elseif (receiveTime == 1) then
            receiveTopTower()
            return
        end

        local Name, Cv, Cfs = GetCostCoinInfoByIdx(Tower_IBItem_Idx)
        if (HaveNormalItem(8, 562, 2, 0) >= 1) then
            CostIBItem(FindAValidIBItem(8, 562, 2, 0))
        elseif (GetCoin() >= Cv) then
            if (CostCoinByIdx(Tower_IBItem_Idx) == 0) then
                Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ tiÒn ®ång, kh«ng thÓ tiÕp tôc luyÖn ho¸ BÊt Chu S¬n th¹ch. Ta còng rÊt mÖt råi! §îi ta håi phôc l¹i nguyªn khİ råi sÏ bµn tiÕp nhĞ! ")
                return
            end
        else
            Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>H·n T­íng T©m §¾c<c> hoÆc <c=yel>" .. Cfs .. "<c> tiÒn §ång, kh«ng thÓ tiÕp tôc luyÖn ho¸ BÊt Chu S¬n th¹ch. Ta còng rÊt mÖt råi! §îi ta håi phôc l¹i nguyªn khİ råi sÏ bµn tiÕp nhĞ!")
            return
        end

        local rand = random(1, 100)
        local gdLevel = GetPlayerExtLevel()
        gdLevel = (gdLevel == 30 and 31) or gdLevel
        local ruleLevel = floor((gdLevel - 31) / 5) + 1
        ruleLevel = (ruleLevel > 5 and 5) or ruleLevel
        local bossIdx = 0
        for k, v in Tower_Boss_Rule[Tower_Type_Idx][ruleLevel] do
            if (rand <= v.ratio) then
                bossIdx = v.idx
                break
            end
        end

        SetTaskByte(Task_Tower_Receive, 3, receiveTime)
        SetTaskByte(Task_Tower_Status, 1, 1)
        SetTaskByte(Task_Tower_Status, 2, Tower_Type_Idx)
        SetTaskByte(Task_Tower_Status, 3, bossIdx)
        SetTaskByte(Task_Tower_Status, 4, 0)

        SetCamp(Tower_Rule[Tower_Type_Idx].camp)

        TaskNote(Task_Info_Tower + Tower_Type_Idx, 0, Tower_Boss[bossIdx].name, 0)
        -- Added by Zhaoqingsong at 2009-4-20 begin
        syncTopTowerBible()
        -- Added by Zhaoqingsong at 2009-4-20 end
        Talk(1, "no", "H«m nay ng­¬i ®· nhËn " .. receiveTime .. ", BÊt Chu S¬n th¹ch cã xung quanh <c=g>" .. Tower_Boss[bossIdx].name .. "<c>. NÕu nh­ phe m×nh ®· khèng chÕ K×nh Thiªn th¸p ë BÊt Chu S¬n th× ng­¬i sÏ nhËn ®­îc tr¹ng th¸i <c=g>Chóc Dung<c>. §ång thêi trong lóc tiªu diÖt qu¸i thó phe PK l·nh ®Şa cña m×nh sÏ biÕn thµnh <c=cyan>mµu xanh<c>, nhiÒu kh¶ n¨ng sÏ nhËn ®­îc BÊt Chu S¬n th¹ch, sau khi thu ®ñ <c=g>10<c> miÕng cã thÓ vÒ phôc mÖnh.")
    else
        CloseDialog()
    end
end

function finishTopTower()
    -- songlei by 2009.9.22 ½±ÀøĞŞ¸ÄÎª¿ÉÑ¡

    local tasks = {
        { "Danh väng Tiªn giíi", "xianjieshengwang"; show = 1 },
        { "BÊt Chu HuyÒn ThiÕt", "buzhouxuantie"; show = 1 },
    }

    SayTask(" Qu¶ nhiªn ta ®· kh«ng nh×n lÇm ng­êi! BÊt Chu S¬n Th¹ch ®· mang vÒ råi, ta nhÊt ®Şnh kh«ng ®Ó ng­¬i thiÖt thßi! B©y giê ng­¬i cã thÓ chän t¨ng danh väng tiªn giíi, hoÆc nhËn 2 BÊt Chu HuyÒn ThiÕt!", tasks)
end

function xianjieshengwang()
    --songlei by 2009.9.23 ÁìÈ¡ÉùÍû½±Àø

    local crossDisaster = GetTaskByte(Task_DuJie, 1)
    --	if (crossDisaster < 1) then
    --		Talk(1,"no","·öåöµÀÈË£ºÄã»¹Î´Ôø<c=g>Ó¦¶ÉÌì½Ù<c>,Ë¡ÎÒÎŞ·¨½«´ËÖØÈÎÍĞ¸¶ÓÚÄã,´ıÄãÍê³É¶É½ÙÊÔÁ¶Ö¤Ã÷×Ô¼ºÊµÁ¦ºóÔÙÀ´ÕÒÎÒ°É.")
    --		return
    --	end

    local credit = GetJusticEvilCredit()
    if (credit * Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit and crossDisaster < 2) then
        Talk(1, "no", "ViÖc chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, danh väng Tiªn giíi xøng ®¸ng t¨ng lªn! Nh­ng do hiÖn ng­¬i ch­a th«ng qua kh¶o nghiÖm <c=g>L«i §×nh Khëi LiÖt<c>, nªn danh väng ch­a thÓ t¨ng! H·y cè g¾ng thªm nhĞ!")
        return
    elseif (credit * Tower_Rule[Tower_Type_Idx].symbol >= Tower_Top_Credit_2 and crossDisaster < 3) then
        Talk(1, "no", "ViÖc chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, danh väng Tiªn giíi xøng ®¸ng t¨ng lªn! Nh­ng do hiÖn ng­¬i ch­a th«ng qua kh¶o nghiÖm <c=g>Sa La Song Thô<c>, nªn danh väng ch­a thÓ t¨ng! H·y cè g¾ng thªm nhĞ!")
        return
    end

    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus == 2) then
        local taskType = GetTaskByte(Task_Tower_Status, 2)
        if (taskType ~= Tower_Type_Idx) then
            Talk(1, "no", " NÕu ng­¬i muèn gia nhËp Tiªn giíi, ta s½n sµng tiÕp nhËn. Cã ®iÒu hiÖn ng­¬i ®ang nhËn " .. Tower_Rule[taskType].name .. " gióp Ma giíi thu thËp BÊt Chu S¬n th¹ch, ng­¬i h·y mau quay vÒ" .. Tower_Rule[taskType].npc .. " huû sø mÖnh ®ã, ta sÏ tiÕp n¹p ng­¬i! Suy nghÜ cho kü nhĞ!")
            return
        end
        local storeCount = HaveNormalItem(4, 218, 0, 1)
        if (storeCount >= 10) then
            ClearItem(4, 218, 0, 1)
            SetTaskByte(Task_Tower_Status, 1, 0)--log¼ÇÂ¼¸Ä°æ
            SetTask(Task_Tower_Status, 0)

            --			local controlTower = GetGlobalValue(Global_Tower+Tower_Type_Idx)  --songlei by 2009.9.23 µØÍ¼BUFFÎŞĞèÉ¾³ı
            --			if (controlTower > 0 and controlTower <= 3) then
            --				RemoveIBBuff(Tower_Buff[controlTower].buffid)
            --			end

            TaskNote(Task_Info_Tower + Tower_Type_Idx, -1)

            local class, detail = myunpack(Tower_Rule[Tower_Type_Idx].gen)
            --			AddNormalItem(class,detail,0,0,0,0) --Note ÏÉÎª²»ÖÜĞşÌú£¬Ä§Îª²»ÖÜ¾«¸Ö  --songlei by 2009.9.23 ´Ë´¦½ö½±ÀøÉùÍû
            local credit = GetJusticEvilCredit()
            local getCredit = 120
            if (credit * Tower_Rule[Tower_Type_Idx].symbol < 0) then
                getCredit = 480
            end
            local restricted = 0
            if (credit * Tower_Rule[Tower_Type_Idx].symbol > 0) then
                if (abs(credit + getCredit * Tower_Rule[Tower_Type_Idx].symbol) > Tower_Top_Credit and crossDisaster < 2) then
                    getCredit = Tower_Top_Credit - abs(credit)
                    getCredit = (getCredit < 0 and 0) or getCredit
                    restricted = 1
                elseif (abs(credit + getCredit * Tower_Rule[Tower_Type_Idx].symbol) > Tower_Top_Credit_2 and crossDisaster < 3) then
                    getCredit = Tower_Top_Credit_2 - abs(credit)
                    getCredit = (getCredit < 0 and 0) or getCredit
                    restricted = 1
                end
            end
            ChangeJusticEvilCredit(getCredit * Tower_Rule[Tower_Type_Idx].symbol)

            if (restricted == 1) then
                --ÊÜµ½Î´Íê³É50¼¶¶È½ÙµÄ45000µãÉÏÏß
                Msg2Player("Hoµn thµnh nhiÖm vô VËt t­ chiÕn bŞ, nhËn ®­îc " .. getCredit .. "§iÓm" .. Tower_Rule[Tower_Type_Idx].gd .. "Danh väng")
                Talk(1, "no", "ViÖc VËt t­ chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, danh väng Tiªn giíi ®· t¨ng thªm <c=g>" .. getCredit .. "<c> ®iÓm. ChØ cÇn kiªn tr× nh­ thÕ, danh chÊn Tiªn Ma l­ìng giíi chØ lµ vÊn ®Ò thêi gian mµ th«i!")
            elseif (credit * Tower_Rule[Tower_Type_Idx].symbol < 0) then
                --ÏÉ½ÓÄ§£¬Ä§½ÓÏÉ
                local otherType = (Tower_Type_Idx == 1 and 2) or 1
                Msg2Player("Hoµn thµnh nhiÖm vô VËt t­ chiÕn bŞ, nhËn ®­îc " .. getCredit .. "§iÓm" .. Tower_Rule[Tower_Type_Idx].gd .. "Danh väng")
                Talk(2, "no", "ViÖc VËt t­ chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, ®ång thêi ®Ó gióp ng­¬i sím tho¸t khái sù rµng buéc cña Ma giíi, ta ®Æc c¸ch tÆng ng­¬i thªm danh väng Tiªn giíi <c=g>" .. getCredit .. "<c> ®iÓm.", "Nh­ng v× danh väng Ma giíi cña ng­¬i vÉn ch­a tiªu trõ hÕt, nªn ta gióp ng­¬i t¨ng mÆt kh¸c. Hy väng ng­¬i sím tÈy röa c¸c tµn d­ cña Ma giíi!")
            else
                -- Õı³£Çé¿ö£¬ÏÉ½ÓÏÉ£¬Ä§½ÓÄ§
                Msg2Player("Hoµn thµnh nhiÖm vô VËt t­ chiÕn bŞ, " .. getCredit .. "§iÓm" .. Tower_Rule[Tower_Type_Idx].gd .. "Danh väng")
                Talk(1, "no", "ViÖc VËt t­ chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, danh väng Tiªn giíi ®· t¨ng thªm <c=g>" .. getCredit .. "<c> ®iÓm. ChØ cÇn kiªn tr× nh­ thÕ, danh chÊn Tiªn Ma l­ìng giíi chØ lµ vÊn ®Ò thêi gian mµ th«i!")
            end
        else
            local bossIdx = GetTaskByte(Task_Tower_Status, 3)
            local tasks = {
                { "Hñy báVËt t­ chiÕn bŞ", "cancelTopTower"; show = 1 },
            }
            SayTask("BÊt Chu S¬n th¹ch cã xung quanh <c=g>" .. Tower_Boss[bossIdx].name .. "<c>. NÕu nh­ phe m×nh ®· khèng chÕ K×nh Thiªn th¸p ë BÊt Chu S¬n th× ng­¬i sÏ nhËn ®­îc tr¹ng th¸i <c=g>Chóc Dung<c>. §ång thêi trong lóc tiªu diÖt qu¸i thó phe PK l·nh ®Şa cña m×nh sÏ biÕn thµnh <c=cyan>mµu xanh<c>, nhiÒu kh¶ n¨ng sÏ nhËn ®­îc BÊt Chu S¬n th¹ch, sau khi thu ®ñ <c=g>10<c> miÕng cã thÓ vÒ phôc mÖnh. NÕu c¶m thÊy nhiÖm vô nµy qu¸ khã, cã thÓ huû bá!", tasks)
        end
    else
        CloseDialog()
    end
end

function buzhouxuantie()
    --songlei by 2009.9.23 ÁìÈ¡ÎïÆ·½±Àø

    --	local crossDisaster = GetTaskByte(Task_DuJie,1)
    --	if (crossDisaster < 1) then
    --		Talk(1,"no","·öåöµÀÈË£ºÄã»¹Î´Ôø<c=g>Ó¦¶ÉÌì½Ù<c>,Ë¡ÎÒÎŞ·¨½«´ËÖØÈÎÍĞ¸¶ÓÚÄã,´ıÄãÍê³É¶É½ÙÊÔÁ¶Ö¤Ã÷×Ô¼ºÊµÁ¦ºóÔÙÀ´ÕÒÎÒ°É.")
    --		return
    --	end
    local credit = GetJusticEvilCredit()  --songei by 2009.9.25 ¶ÔÁ¢ÕóÓªÎŞ·¨»ñµÃÈÎÎñµÀ¾ß½±Àø
    if (credit * Tower_Rule[Tower_Type_Idx].symbol < 0) then
        Talk(1, "finishTopTower", "MÆc dï ng­¬i ®· quyÕt t©m gia nhËp Tiªn giíi, nh­ng tr­íc khi trë thµnh Tiªn chóng ch©n chİnh, ®Ó tr¸nh viÖc c¸c ®ång ®¹o dŞ nghŞ, nªn ta ch­a thÓ tÆng ng­¬i <c=g>" .. Tower_Rule[Tower_Type_Idx].award .. "<c>! H·y tiÕp tôc nç lùc! Ngµy thµnh ch¸nh qu¶ ®ang gÇn kÒ!")
        return
    end

    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus == 2) then
        local taskType = GetTaskByte(Task_Tower_Status, 2)
        if (taskType ~= Tower_Type_Idx) then
            Talk(1, "no", " NÕu ng­¬i muèn gia nhËp Tiªn giíi, ta s½n sµng tiÕp nhËn. Cã ®iÒu hiÖn ng­¬i ®ang nhËn " .. Tower_Rule[taskType].name .. " gióp Ma giíi thu thËp BÊt Chu S¬n th¹ch, ng­¬i h·y mau quay vÒ" .. Tower_Rule[taskType].npc .. " huû sø mÖnh ®ã, ta sÏ tiÕp n¹p ng­¬i! Suy nghÜ cho kü nhĞ!")
            return
        end
        local storeCount = HaveNormalItem(4, 218, 0, 1)
        if (storeCount >= 10) then
            ClearItem(4, 218, 0, 1)
            SetTaskByte(Task_Tower_Status, 1, 0)--log¼ÇÂ¼¸Ä°æ
            SetTask(Task_Tower_Status, 0)

            --			local controlTower = GetGlobalValue(Global_Tower+Tower_Type_Idx)  --songlei by 2009.9.23 µØÍ¼BUFFÎŞĞèÉ¾³ı
            --			if (controlTower > 0 and controlTower <= 3) then
            --				RemoveIBBuff(Tower_Buff[controlTower].buffid)
            --			end

            TaskNote(Task_Info_Tower + Tower_Type_Idx, -1)

            local class, detail = myunpack(Tower_Rule[Tower_Type_Idx].gen)
            AddNormalItemPile(class, detail, 0, 0, 0, 0) --Note ÏÉÎª²»ÖÜĞşÌú£¬Ä§Îª²»ÖÜ¾«¸Ö
            AddNormalItemPile(class, detail, 0, 0, 0, 0) -- songlei by 2009.9.23 ½±ÀøÊıÁ¿+1
            Msg2Player("Hoµn thµnh nhiÖm vô VËt t­ chiÕn bŞ, nhËn ®­îc 2 " .. Tower_Rule[Tower_Type_Idx].award .. "")
            Talk(2, "no", "ViÖc VËt t­ chiÕn bŞ c«ng lao cña ng­¬i kh«ng İt, 2 <c=g>" .. Tower_Rule[Tower_Type_Idx].award .. "<c> nµy tÆng cho ng­¬i ®Ó thay lêi c¶m t¹!", "VËt nµy ng­¬i h·y cÊt kü, sau nµy cã lóc dïng ®Õn. Giê ng­¬i h·y ®Õn <c=g>BÊt Chu Thiªn Quan<c> thØnh vÊn <c=g>Tµo B¶o<c>!")

            --			local credit = GetJusticEvilCredit()  --songlei by 2009.9.23 ´Ë´¦½ö½±ÀøÎïÆ·
            --			local getCredit = 60
            --			if (credit*Tower_Rule[Tower_Type_Idx].symbol < 0) then
            --				getCredit = 240
            --			end
            --			local restricted = 0
            --			if (credit*Tower_Rule[Tower_Type_Idx].symbol > 0) then
            --			        if (abs(credit + getCredit*Tower_Rule[Tower_Type_Idx].symbol) > Tower_Top_Credit and crossDisaster < 2) then
            --				        getCredit = Tower_Top_Credit - abs(credit)
            --				        getCredit = (getCredit < 0 and 0) or getCredit
            --				        restricted = 1
            --			        elseif (abs(credit + getCredit*Tower_Rule[Tower_Type_Idx].symbol) > Tower_Top_Credit_2 and crossDisaster < 3) then
            --				        getCredit = Tower_Top_Credit_2 - abs(credit)
            --				        getCredit = (getCredit < 0 and 0) or getCredit
            --				        restricted = 1
            --			        end
            --		        end
            --			ChangeJusticEvilCredit(getCredit*Tower_Rule[Tower_Type_Idx].symbol)
            --
            --			if (restricted == 1) then --ÊÜµ½Î´Íê³É50¼¶¶È½ÙµÄ45000µãÉÏÏß
            --				Msg2Player("Íê³ÉÕ½±¸Îï×ÊÈÎÎñ£¬»ñµÃÒ»¿é"..Tower_Rule[Tower_Type_Idx].award.."ºÍ"..getCredit.."µã"..Tower_Rule[Tower_Type_Idx].gd.."ÉùÍû")
            --				Talk(2,"no","·öåöµÀÈË£ºÆ¾ÎÒµÄÑÛ¹â£¬ÊÕ¼¯²»ÖÜÉ½Ê¯Ò»ÊÂÉáÄãÆäË­£¿£¡<c=g>"..Tower_Rule[Tower_Type_Idx].award.."<c>ÄËÎÒÈÛÁ¶Ö®Ê±ËùÑÜÉúÖ®Îï£¬¶ÔÎÒÀ´ËµÎŞÉõÓÃ´¦£¬µ«Äã	´ó¿É½«Æä±£Áô£¬ÆäÖĞºÃ´¦×Ô»áÖªÏş£¡ÁíÍâ£¬ÓÉÓÚÄãÎªÎÒ½çÕ½±¸Îï×ÊµÄ²¹¸ø×ö³ö¹±Ï×£¬","ÄãµÄÉùÍûÔÚÏÉ½çÖĞÒ²ÒÑÌáÉı"..getCredit.."µã"..Tower_Rule[Tower_Type_Idx].gd.."ÉùÍû£¬Ö»ĞèÈç´Ë¼á³Ö£¬ÃûÕğÏÉÄ§Á½½ç±ãÖ»ÊÇÊ±¼äÎÊÌâ¡£")
            --			elseif (credit*Tower_Rule[Tower_Type_Idx].symbol < 0) then --ÏÉ½ÓÄ§£¬Ä§½ÓÏÉ
            --				local otherType = (Tower_Type_Idx == 1 and 2) or 1
            --				Msg2Player("Íê³ÉÕ½±¸Îï×ÊÈÎÎñ£¬»ñµÃÒ»¿é"..Tower_Rule[Tower_Type_Idx].award.."ºÍ"..getCredit.."µã"..Tower_Rule[Tower_Type_Idx].gd.."ÉùÍû")
            --				Talk(2,"no","·öåöµÀÈË£ºÆ¾ÎÒµÄÑÛ¹â£¬ÊÕ¼¯²»ÖÜÉ½Ê¯Ò»ÊÂÉáÄãÆäË­£¿£¡<c=g>"..Tower_Rule[Tower_Type_Idx].award.."<c>ÄËÎÒÈÛÁ¶Ö®Ê±ËùÑÜÉúÖ®Îï£¬¶ÔÎÒÀ´ËµÎŞÉõÓÃ´¦£¬µ«Äã´ó¿É½«Æä±£Áô£¬ÆäÖĞºÃ´¦×Ô»áÖªÏş£¡ÁíÍâ£¬ÓÉÓÚÄãÎªÎÒ½çÕ½±¸Îï×ÊµÄ²¹¸ø×ö³ö¹±Ï×£¬"," Í¬Ê±Ò²ÎªÖúÄãÔçÈÕÍÑÀëÄ§½çõÒÉíÏÉ½ç,ÌØ½«ÄãÔÚÏÉ½çÖ®ÖĞµÄÉùÍûÌáÉı"..getCredit.."µã£¬µ«ÒòÄãµÄÄ§½çÉùÍûÉĞÎ´ÏûºÄ´ù¾¡£¬Òò´ËÎÒÖ»µÃ½«ÆäÏà»¥³åµÖ£¬»¹ÍûÓÉÄ§×ªÏÉÖ®ÈÕÔçĞ©µ½À´£¡")
            --			else -- Õı³£Çé¿ö£¬ÏÉ½ÓÏÉ£¬Ä§½ÓÄ§
            --				Msg2Player("Íê³ÉÕ½±¸Îï×ÊÈÎÎñ£¬»ñµÃÒ»¿é"..Tower_Rule[Tower_Type_Idx].award.."ºÍ"..getCredit.."µã"..Tower_Rule[Tower_Type_Idx].gd.."ÉùÍû")
            --				Talk(2,"no","·öåöµÀÈË£ºÆ¾ÎÒµÄÑÛ¹â£¬ÊÕ¼¯²»ÖÜÉ½Ê¯Ò»ÊÂÉáÄãÆäË­£¿£¡<c=g>"..Tower_Rule[Tower_Type_Idx].award.."<c>ÄËÎÒÈÛÁ¶Ö®Ê±ËùÑÜÉúÖ®Îï£¬¶ÔÎÒÀ´ËµÎŞÉõÓÃ´¦£¬µ«Äã´ó¿É½«Æä±£Áô£¬ÆäÖĞºÃ´¦×Ô»áÖªÏş£¡ÁíÍâ£¬ÓÉÓÚÄãÎªÎÒ½çÕ½±¸Îï×ÊµÄ²¹¸ø×ö³ö¹±Ï×£¬","ÄãµÄÉùÍûÔÚÏÉ½çÖĞÒ²ÒÑÌáÉı"..getCredit.."µã£¬Ö»ĞèÈç´Ë¼á³Ö£¬ÃûÕğÏÉÄ§Á½½ç±ãÖ»ÊÇÊ±¼äÎÊÌâ¡£")
            --			end
        else
            local bossIdx = GetTaskByte(Task_Tower_Status, 3)
            local tasks = {
                { "Hñy báVËt t­ chiÕn bŞ", "cancelTopTower"; show = 1 },
            }
            SayTask("BÊt Chu S¬n th¹ch cã xung quanh <c=g>" .. Tower_Boss[bossIdx].name .. "<c>. NÕu nh­ phe m×nh ®· khèng chÕ K×nh Thiªn th¸p ë BÊt Chu S¬n th× ng­¬i sÏ nhËn ®­îc tr¹ng th¸i <c=g>Chóc Dung<c>. §ång thêi trong lóc tiªu diÖt qu¸i thó phe PK l·nh ®Şa cña m×nh sÏ biÕn thµnh <c=cyan>mµu xanh<c>, nhiÒu kh¶ n¨ng sÏ nhËn ®­îc BÊt Chu S¬n th¹ch, sau khi thu ®ñ <c=g>10<c> miÕng cã thÓ vÒ phôc mÖnh. NÕu c¶m thÊy nhiÖm vô nµy qu¸ khã, cã thÓ huû bá!", tasks)
        end
    else
        CloseDialog()
    end
end

function cancelTopTower()
    CloseDialog()
    MsgBox("Thu thËp BÊt Chu S¬n Th¹ch lµ viÖc nguy hiÓm, nh­ng dï sao ng­¬i bá ®i ta còng c¶m thÊy tiÕc dïm ng­¬i! VÉn quyÕt ®Şnh hñy nhiÖm vô nµy ­?", "yes_cancelTopTower", "no")
end

function yes_cancelTopTower()
    CloseDialog()

    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    if (taskStatus ~= 0) then
        local taskType = GetTaskByte(Task_Tower_Status, 2)
        if (taskType ~= Tower_Type_Idx) then
            Talk(1, "no", " NÕu ng­¬i muèn gia nhËp Tiªn giíi, ta s½n sµng tiÕp nhËn. Cã ®iÒu hiÖn ng­¬i ®ang nhËn " .. Tower_Rule[taskType].name .. " gióp Ma giíi thu thËp BÊt Chu S¬n th¹ch, ng­¬i h·y mau quay vÒ" .. Tower_Rule[taskType].npc .. " huû bá sø mÖnh, ta sÏ tiÕp nhËn ng­¬i! H·y suy nghÜ cho kü nhĞ!")
            return
        end
        ClearItem(4, 218, 0, 1)
        SetTask(Task_Tower_Status, 0)
        --		local controlTower = GetGlobalValue(Global_Tower+Tower_Type_Idx) by songlei 2009,11,16
        --		if (controlTower > 0 and controlTower <= 3) then
        --			RemoveIBBuff(Tower_Buff[controlTower].buffid)
        --		end

        TaskNote(Task_Info_Tower + Tower_Type_Idx, -1)
        Msg2Player("B¹n ®· huû nhiÖm vô VËt t­ chiÕn bŞ lÇn nµy!")
        Talk(1, "no", "Ta hiÓu sù lo l¾ng cña ng­¬i hiÖn t¹i, BÊt Chu S¬n hung hiÓm khã l­êng. Hay lµ t¹m thêi vÒ nghØ ng¬i, ®îi ®Õn khi nguyªn khİ håi phôc råi h·y tiÕp tôc nhĞ!")
    else
        CloseDialog()
    end
end

-- ·µ»ØÊı×éµÄËùÓĞÔªËØ,×Ô¶¨Òåº¯Êı
function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end


-- Added by zhaoqingsong at 2009-3-17 End

-- Added by Zhaoqingsong at 2009-4-20 Begin
function syncTopTowerBible()
    local currentDay = floor(LocalSystemTime() / 86400)
    local receiveDay = GetTaskWord(1348, 1)
    local receiveTime = GetTaskByte(1348, 3)
    local credit = GetJusticEvilCredit()
    local bibleID = 1033
    if (credit < 0) then
        bibleID = 1034
    end
    local bibleState = 1
    if (receiveDay < currentDay) then
        bibleState = 1
    elseif (receiveTime > 0 and receiveTime < 3) then
        bibleState = 2
    elseif (receiveTime >= 3) then
        bibleState = 3
    end
    SyncBibleState(bibleID, bibleState, 1)
end
-- Added by Zhaoqingsong at 2009-4-20 End