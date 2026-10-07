--description:µ¤ÏöÏÉ×Ó
--author: yaoxin
--date:2009/1/12
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
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
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
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/30 end 

function main()
    local tasks = {
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 }
    }

    if (GetTaskByte(Task_Process, 1) == 4 and GetJusticEvilCredit() < 0) then
        tasks[1].show = 1
    end

    SayTask("Ta lµ §¬n Tiªu Tiªn tö. NÕu cã viÖc g× cÇn gióp ®ì, cø ®Õn t×m ta", tasks)
end;

function listenTask()
    CloseDialog()
    if (GetTaskByte(Task_Process, 1) == 4 and HaveIBBuff(548) > 0) then
        local nInterrupt = 0
        Talk(1, "no", " Cuéc chiÕn Tiªn Ma lan ®Õn BÊt Chu S¬n nµy sÏ biÕn thµnh cuéc chiÕn cña Thuû-Ho¶ thÇn, kh«ng biÕt lµm sao ®Ó ng¨n hä ®©y. Ng­¬i nghe ta gi¶ng ph¸p xong råi th× nhí ®i t×m <c=g>V­¬ng Ma<c> nhĞ!")
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 7, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        TopMessage("Nghe §¬n Tiªu Tiªn tö gi¶ng ph¸p")
        BeginMotion(Task_Process, 0, 30, "\\script\\motion\\½²·¨½ø¶ÈÏìÓ¦.lua", nInterrupt)
    else
        Talk(1, "no", " Thêi gian ®· hÕt. TiÕc qu¸, ng­¬i thÊt b¹i råi! VÒ gÆp Tu Hµnh S­ ®i, cã thÓ vÉn cßn c¬ héi!")
    end
end

function no()
    CloseDialog()
end;
