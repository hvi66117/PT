--description: ²ÉÒ©ÈËµÄÐÖµÜ
--author: liuzhiqiang
--date: 2009/04/15

--ºÓÍ¼»Ã¾³
Task_hetu = 1387 -- 1byte: 1:ÒÑ½ÓºÓÍ¼ÈÎÎñ; 2£ºÒÑÍê³ÉÁéÊ¯12µÄÈÎÎñ 3:ÒÑÍê³ÉÁéÊ¯34µÄÈÎÎñ 4£ºÒÑÍê³ÉÁéÊ¯67µÄÈÎÎñ 5£ºÒÑÍê³ÉÁéÊ¯89µÄÈÎÎñ 6£ºÍê³ÉºÓÍ¼»Ã¾³
-- 2byte: 1:¼ÇÂ¼½ÓÈÎÎñÊ±µÄ¶Ó³¤£»
-- 3byte: 1:ÒÑÉ±ËÀÁúÂí£¬³öÏÖ¹ýIBBuff
-- 4byte: 1:ÒÑºÍÁéÊ¯¶Ô¹ý»°£¬³öÏÖ¹ýIBBuff
Hetu_playerID = 1388
Global_longmashui = 185
Global_longmahuo = 186
Global_longmamu = 187
Global_longmajin = 188

-- AS yangshuang at 091229
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


    --ºÓÍ¼»Ã¾³
    startLevel = 28
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
                state = 3
                subState = 0
            end
        else
            if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE yangshuang at 091229 end

function main()
    local tasks = {
        { "Hµ §å HuyÒn C¶nh", "hetu"; show = 0 },
    }

    if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
        tasks[1].show = 1
    end

    SayTask(GetName() .. " …… h¾n 1 lêi còng kh«ng nãi.", tasks)
end

function hetu()

    CloseDialog()

    if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
        Talk(1, "no", "Lµ ng­êi anh em cña ta nhê ng­¬i ®Õn cøu ta? Ta t­ëng r»ng sÏ ph¶i chÕt tr«ng ®Êy råi, nay ®· ®­îc cøu thËt kh«ng biÕt c¶m t¹ thÕ nµo.")
        local addexp = AddOwnExtendExp(500000)
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh Hµ §å Hoang C¶nh, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")

        ClearItem(6, 1, 484, 0) --É¾³ýºÓÍ¼
        ClearItem(6, 1, 485, 0) --É¾³ýºÓÍ¼ÐÂ½â   
        TaskNote(1043, -1)
        SetTaskByte(Task_hetu, 1, 6)
        SetSubTask(1043, -1, 1)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
    end
end

function no()
    CloseDialog()
end;
