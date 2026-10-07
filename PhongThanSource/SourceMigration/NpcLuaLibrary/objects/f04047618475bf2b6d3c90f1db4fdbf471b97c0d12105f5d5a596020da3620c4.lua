--description:ÑîÈÎ
--author: yaoxin
--date:2009/1/12

Task_Process = 1345      --1byte: 1:ÒÑÓÚĞŞĞĞÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑıµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø

Task_baichuan = 1364      --1byte: 1£º½ÓÁËÈÎÎñ£» 3:ÒÑ¾­Óë´óÍşÌìÁú¶Ô»°×´Ì¬£» 4:46¼¶Ö§ÏßÍê³É  5£ºÉ±ËÀÂŞºí  6£º47¼¶ÈÎÎñÍê³É

-- Added by luoyixuan at 0901228 begin
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

    --°Ù´¨»ã¾Û
    startLevel = 46
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                state = 1
                subState = 0
            end
        else
            --À¶É«
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÁìÃü¹éÕæ
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 7) then
                state = 3
                subState = 0
            end
        else
            if (process == 7) then
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
-- Added by luoyixuan 091228 end

function main()
    local tasks = {
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 },
        { "B¸ch Xuyªn Héi Tô", "baichuan"; show = 0 },
    }

    if (GetTaskByte(Task_Process, 1) == 7 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    -- Added by liuzhiqiang at 2009-3-25 Begin
    if (GetPlayerExtLevel() >= 46 and GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
        tasks[2].show = 1
    end
    -- Added by liuzhiqiang at 2009-3-25 end

    SayTask("Ta cã ®«i m¾t thÇn, cã thÓ nh×n xuyªn thiªn th­îng ©m cung. LÇn tr­íc Tr­¬ng Khuª c­íp tr¹i, còng mµ ta nh×n thÊy, nÕu kh«ng T©y Kú ch­a ch¾c cßn ®Õn ngµy nay!", tasks)
end;

function listenTask()
    CloseDialog()
    if (GetTaskByte(Task_Process, 1) == 7 and HaveIBBuff(548) > 0) then
        Talk(1, "no", " Tu ®¹o kh«ng ph¶i chØ cã thµnh t©m mµ ®­îc, ph¶i cã c¬ duyªn, b¶o khİ, tiªn d­îc, vµ cßn ph¶i xem t¹o ho¸ n÷a. Nh­ L«i ChÊn Tö ®ã, ch¼ng qua nhê v« t×nh ¨n tróng Tiªn qu¶ mµ ®­îc c«ng lùc nh­ thÕ...th«i ta nãi ®ñ råi, giê h·y ®i gÆp Tu Hµnh S­ ®i!")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 7, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        TopMessage("Nghe D­¬ng NhËm gi¶ng ph¸p")
        BeginMotion(Task_Process, 0, 30, "\\script\\motion\\½²·¨½ø¶ÈÏìÓ¦.lua", nInterrupt)
    else
        Talk(1, "no", " Thêi gian ®· hÕt. TiÕc qu¸, ng­¬i thÊt b¹i råi! VÒ gÆp Tu Hµnh S­ ®i, cã thÓ vÉn cßn c¬ héi!")
    end
end

-- Added by liuzhiqiang at 2009-3-25 Begin
function baichuan()
    CloseDialog()
    if (GetPlayerExtLevel() >= 46 and GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
        MsgBox("BÊt Chu S¬n x­a nay ®­îc 3 tßa ThÇn Th¸p trÊn gi÷, duy tr× s¬n thÕ ®Şa khİ, còng chİnh lµ Trô Cét ThÇn Ch©u. GÇn ®©y ta dïng thÇn nh·n quan s¸t tø ph­¬ng, ph¸t hiÖn côc thÕ BÊt Chu S¬n cã chót biÕn ®éng, d­êng nh­ s¾p x¶y ra chuyÖn lín, ng­¬i cã thÓ gióp ta ®iÒu tra kh«ng?", "accept", "no")  --que
    end
end

function accept()
    CloseDialog()
    if (GetPlayerExtLevel() >= 46 and GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
        Talk(3, "no", "ThÇn thñ hé BÊt Chu S¬n <c=g>[§¹i Uy Thiªn Long]<c> v× linh khİ trªn nói tiªu t¸n dÉn ®Õn thÇn thøc bŞ phong táa, nh­ng côc thÕ BÊt Chu S¬n chØ cã ng­êi míi biÕt râ, khëi ®éng thÇn th¸p trªn nói ¾t sÏ cã thÓ gióp ng­êi t¹m thêi kh«i phôc thÇn thøc.", "Ng­¬i chØ cÇn khèng chÕ tïy ı 1 tßa th¸p mµ ch­a bŞ phe ng­¬i chiÕm lÜnh lµ cã thÓ thøc tØnh Thiªn Long, nÕu nh­ c¶ 3 tßa th¸p ®Òu bŞ phe ng­¬i chiÕm lÜnh, khi <c=g>ch­a trang bŞ Lç Ban Phñ<c> sö dông kü n¨ng <c=g>Ban M«n Léng Phñ<c> 1 lÇn lµ ®­îc.", "Ch©n th©n cña Thiªn Long ®­îc giÊu trong nói, thÇn thøc kh«ng thÓ duy tr× qu¸ l©u, sau khi thøc tØnh Thiªn Long, ng­¬i ph¶i ®Õn vŞ trİ <c=g>(234,220)<c> gÆp hãa th©n cña ngµi, c¸c h¹ sÏ cho ng­¬i biÕt vÒ bİ mËt trªn nói. NÕu ®Ó lì Thiªn Long sÏ l¹i biÕn mÊt.")
        SetTaskByte(Task_baichuan, 1, 1) --que
        SetSubTask(1037, 1, 1)
        TaskNote(1037, 0)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
    end
end

-- Added by liuzhiqiang at 2009-3-25 end

function no()
    CloseDialog()
end;
