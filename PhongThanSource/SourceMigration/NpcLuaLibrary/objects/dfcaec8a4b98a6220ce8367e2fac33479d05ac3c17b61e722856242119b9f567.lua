--description:ÄÏÚ¤×Ó
--author: Gaojingwei
--date:2009/1/12

Task_Process = 1345      --1byte: 1:ÒÑÓÚĞŞĞĞÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑıµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø
Task_Catch_Wolf = 1346  --1byte: 0:Ã»ÓĞÁìÈ¡ÈÎÎñ£»1:ÁìÈ¡ÁËÈÎÎñ£»2£ºÍê³É²½Öè1ÇÒÁìÈ¡ÁË½±Àø£»3£ºÁìÈ¡ÁË²½Öè2µÄÈÎÎñ£¬4£ºÍê³É²½Öè2
--2byte:Í³¼Æ²¶×½ÊÉÀÇµÄ¸öÊı£»3byte£º²¶×½ÊÉÀÇÊ×ÁìµÄ¸öÊı;4byte:ÁÔÉ±ÊÉÀÇµÄ¸öÊı

--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/28 begin
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

    --ÒõÑôÖ®µÀ µÚÒ»²½
    startLevel = 36
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local step = GetTaskByte(Task_Catch_Wolf, 1)
        local num = GetTaskByte(Task_Catch_Wolf, 2)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (step == 0) then
                state = 1
                subState = 0
            elseif (step == 1) and (num >= 30) then
                state = 3
                subState = 0
            elseif (step == 1) and (num < 30) then
                state = 2
                subState = 0
            end
        else
            if (step == 0) then
                state = 1
                subState = 1
            elseif (step == 1) and (num >= 30) then
                state = 3
                subState = 1
            elseif (step == 1) and (num < 30) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end
    --ÒõÑôÖ®µÀ µÚ¶ş²½
    startLevel = 37
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local step = GetTaskByte(Task_Catch_Wolf, 1)
        local num = GetTaskByte(Task_Catch_Wolf, 3)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (step == 2) then
                state = 1
                subState = 0
            elseif (step == 3) and (num >= 3) then
                state = 3
                subState = 0
            elseif (step == 3 and num < 3) then
                state = 2
                subState = 0
            end
        else
            if (step == 2) then
                state = 1
                subState = 1
            elseif (step == 3) and (num >= 3) then
                state = 3
                subState = 1
            elseif (step == 3) and (num < 3) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end
    --ÁìÃü¹éÕæ
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 4) then
                state = 3
                subState = 0
            end
        else
            if (process == 4) then
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
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/28 end 

function main()
    local tasks = {
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 },
        { "¢m D­¬ng Chi §¹o", "catchWolf"; show = 0 },
        { "Hñy N.vô", "cancel"; show = 0 }
    }

    if (GetTaskByte(Task_Process, 1) == 4 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    local step = GetTaskByte(Task_Catch_Wolf, 1)
    local monsterNum = GetTaskByte(Task_Catch_Wolf, 2)
    local bossNum = GetTaskByte(Task_Catch_Wolf, 3)
    if (step >= 0 and step <= 3 and GetPlayerExtLevel() >= 36) then
        tasks[2].show = 1
        if ((step == 1 and monsterNum < 30) or (step == 3 and bossNum < 3)) then
            if (GetJusticEvilCredit() > 0) then
                tasks[3].show = 1
            end
        end
    end

    SayTask("Thiªn tr× d· giang h¶i biÕn thiªn, cao S¬n tung khëi thuú…Ta chİnh lµ Nam Minh Tö!", tasks)
end;

function listenTask()
    CloseDialog()
    if (GetTaskByte(Task_Process, 1) == 4 and HaveIBBuff(548) > 0) then
        Talk(1, "no", " Cuéc chiÕn Tiªn Ma lan ®Õn BÊt Chu S¬n nµy sÏ biÕn thµnh cuéc chiÕn cña Thuû-Ho¶ thÇn, kh«ng biÕt lµm sao ®Ó ng¨n hä ®©y. Ng­¬i nghe ta gi¶ng ph¸p xong råi th× nhí ®i t×m <c=g>V©n Trung Tö<c> nhĞ!")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 7, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        TopMessage("Nghe Nam Minh Tö gi¶ng ph¸p")
        BeginMotion(Task_Process, 0, 30, "\\script\\motion\\½²·¨½ø¶ÈÏìÓ¦.lua", nInterrupt)
    else
        Talk(1, "no", " Thêi gian ®· hÕt. TiÕc qu¸, ng­¬i thÊt b¹i råi! VÒ gÆp Tu Hµnh S­ ®i, cã thÓ vÉn cßn c¬ héi!")
    end
end

function catchWolf()
    CloseDialog()
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    local extCredit = GetJusticEvilCredit()

    if (extCredit <= 0) then
        Talk(1, "no", " ¢m D­¬ng kh«ng thÓ hçn ®én, Tiªn ma kh«ng thÓ mét nhµ, chóng ta kh«ng thÓ lµ ®ång ®¹o!")
        return
    end

    if (step == 0) then
        MsgBox("Sãi vèn lµ kh¾c tinh cña Phi Thè. Chóng th­ëng xuÊt hiÖn ë BÊt Chu S¬n. Ng­¬i cã thÓ gióp ta b¾t <c=g>30<c> con Sãi kh«ng?", "yes_accept", "no")
        return
    end

    if (step == 1) then
        local num = GetTaskByte(Task_Catch_Wolf, 2)                    --²¶×½ÊÉÀÇµÄ¸öÊı
        if (num < 30) then
            Talk(1, "no", " Sãi th­êng xuÊt hiÖn xung quanh ®©y, h·y mau ®i b¾t chóng!")
        else
            ClearItem(6, 1, 464, 0)
            local er = AddOwnExtendExp(1550000)
            SetTaskByte(Task_Catch_Wolf, 1, 2)                        --ÈÎÎñµÚÒ»²½½áÊø
            refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
            if (GetPlayerExtLevel() >= 36) then
                Talk(1, "catchWolf", " Anh hïng vÊt v¶ qu¸, ®©y lµ phÇn th­ëng! §îi khi ®¼ng cÊp Tiªn Ma ®¹t <c=g>37<c>, h·y quay l¹i t×m ta nhĞ!")
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. er .. "<c> tu luyÖn")
                Msg2Player("Hoµn thµnh nhiÖm vô ¢m D­¬ng Chi §¹o, nhËn ®­îc" .. er .. " ®iÓm tu luyÖn!")
                TaskNote(1032, 2, "Nam Minh Tö", er)
            end
        end
        return
    end

    if (step == 2) then
        if (GetPlayerExtLevel() >= 37) then
            MsgBox(" Ng­¬i tiÕn bé nhanh h¬n ta t­ëng nhiÒu, giê ®· ®ñ søc gióp ta mét tay råi!", "yes_Catch", "no")
        else
            Talk(1, "no", " §îi khi ®¼ng cÊp Tiªn Ma ®¹t <c=g>37<c>, h·y quay l¹i t×m ta nhĞ!")
        end
        return
    end

    if (step == 3) then
        local num = GetTaskByte(Task_Catch_Wolf, 3)                    --²¶×½ÊÉÀÇµÄ¸öÊı
        if (num < 3) then
            Talk(1, "no", " NÕu ch­a b¾t ®­îc <c=g>3<c> Sãi chóa, D­¬ng khİ sÏ kh«ng thÓ håi phôc")
        else
            MsgBox(" BÇn ®¹o qu¶ ®· kh«ng nh×n lÇm ng­êi, viªn Ngäc Th¹ch nµy tÆng cho anh hïng!", "yes_getBonus", "no")
        end
        return
    end
end

function yes_Catch()
    --ÁìÈ¡µÚ¶ş²½µÄÈÎÎñ
    CloseDialog()
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    if (step == 2) then
        AddNormalItem(6, 1, 464, 0, 0, 0)
        SetTaskByte(Task_Catch_Wolf, 1, 3)
        SetTaskByte(Task_Catch_Wolf, 3, 0)
        SetTaskByte(Task_Catch_Wolf, 4, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        Talk(1, "no", "Sãi chóa lµ linh vËt gióp c­êng sinh D­¬ng khİ, anh hïng xin gióp ta ®i b¾t vµi con Sãi chóa. ChØ cÇn tiªu diÖt mét vµi Sãi con lµ Sãi chóa sÏ xuÊt hiÖn. B¾t <c=g>3<c> Sãi chóa lµ ®ñ råi!")
        TopMessage("NhËn ®­îc <c=g>NhŞ Khİ b×nh<c>")
        Msg2Player("NhËn ®­îc NhŞ Khİ b×nh, ®i b¾t 3 Sãi chóa.")
        TaskNote(1032, 3)
    end
end

function yes_accept()
    --ÁìÈ¡µÚÒ»²½µÄÈÎÎñ
    CloseDialog()
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    if (step == 0) then
        AddNormalItem(6, 1, 464, 0, 0, 0)
        SetTaskByte(Task_Catch_Wolf, 1, 1)
        SetTaskByte(Task_Catch_Wolf, 2, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
        SetSubTask(1032, 1, 1)
        Talk(1, "no", " Ta ë ®©y cã Ph¸p b¶o <c=g>NhŞ Khİ b×nh<c>, chuyªn dïng ®Ó b¾t sãi, Sãi th­êng xuÊt hiÖn xung quanh ®©y, b¾t ®ñ <c=g>30<c> lµ ®­îc råi!")
        ScrollMessage("NhËn ®­îc <c=g>NhŞ Khİ b×nh<c>")
        Msg2Player("NhËn ®­îc NhŞ Khİ b×nh, ®i b¾t 30 con Sãi")
        TaskNote(1032, 0)
    end

end

function yes_getBonus()
    CloseDialog()
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    local num = GetTaskByte(Task_Catch_Wolf, 3)
    if (step == 3 and num >= 3) then
        SetTaskByte(Task_Catch_Wolf, 1, 4)                --ÈÎÎñµÚ¶ş²½½áÊø
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
        local r = random(0, 2)
        r = r * 7 + 255
        AddNormalItem(3, r, 0, 0, 0, 0)
        local er = AddOwnExtendExp(2700000)                        --???
        Talk(1, "no", " BÊt Chu S¬n ®­îc yªn b×nh, c«ng lín lµ cña ng­¬i. Ngäc th¹ch cÊp 3 nµy xøng ®¸ng víi ng­¬i, xin nhËn lÊy!")
        ScrollMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. er .. "<c> tu luyÖn")
        ScrollMessage("NhËn ®­îc 1 Ngäc th¹ch cÊp 3")
        Msg2Player("Hoµn thµnh nhiÖm vô ¢m D­¬ng Chi §¹o, nhËn ®­îc" .. er .. " tu luyÖn vµ 1 Ngäc th¹ch cÊp 3")
        SetSubTask(1032, -1, 1)
        TaskNote(1032, -1)
    end
end

function cancel()
    CloseDialog()
    MsgBox(" ViÖc nµy còng kh«ng gÊp l¾m! Bao giê ng­¬i r¶nh quay l¹i còng ®­îc!", "yes_cancel", "no")
end

function yes_cancel()
    CloseDialog()
    local step = GetTaskByte(Task_Catch_Wolf, 1)
    local monsterNum = GetTaskByte(Task_Catch_Wolf, 2)
    local bossNum = GetTaskByte(Task_Catch_Wolf, 3)

    if (step == 1 and monsterNum < 30) then
        ClearItem(6, 1, 464, 0)
        SetTaskByte(Task_Catch_Wolf, 1, 0)
        SetTaskByte(Task_Catch_Wolf, 2, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
        Msg2Player("Hñy bá nhiÖm vô ¢m D­¬ng Chi §¹o")
        TaskNote(1032, -1)
    end

    if ((step == 3 and bossNum < 3)) then
        ClearItem(6, 1, 464, 0)
        SetTaskByte(Task_Catch_Wolf, 1, 2)
        SetTaskByte(Task_Catch_Wolf, 3, 0)
        SetTaskByte(Task_Catch_Wolf, 4, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
        Msg2Player("Hñy bá nhiÖm vô ¢m D­¬ng Chi §¹o")
        TaskNote(1032, -1)
    end
end

function no()
    CloseDialog()
end;