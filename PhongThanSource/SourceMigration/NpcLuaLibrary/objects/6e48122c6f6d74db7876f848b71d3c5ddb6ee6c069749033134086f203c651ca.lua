--description: ÌìÔÀÓü×ä
--author: liuzhiqiang
--date: 2009/03/25

Task_baichuan = 1364      --1byte: 1£º½ÓÁËÈÎÎñ£» 3:ÒÑ¾­Óë´óÍþÌìÁú¶Ô»°×´Ì¬£» 4:46¼¶Ö§ÏßÍê³É  5£ºÉ±ËÀÂÞºí  6£º47¼¶ÈÎÎñÍê³É

Tower_Camp = {
    { desc = "Canh Th­¬ng" },
    { desc = "Quú Vò" },
}

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --°Ù´¨»ã¾Û
    startLevel = 46
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetTaskByte(Task_baichuan, 1) == 3) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_baichuan, 1) == 3) then
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
-- Added by luoyixuan 091228 end

function main()
    local tasks = {
        { "ChuyÓn tiÕp", "send"; show = 1 }
    }

    SayTask("Thiªn Nh¹c Ngôc Tèt: C¸c vÞ tr­ëng l·o Thiªn Nh¹c Ngò ¢m Täa ®ang vËn hµnh trËn ph¸p, kh«ng thÓ gÆp mÆt, nÕu nh­ ng­¬i muèn gÆp ng­êi cña Thiªn Nh¹c ta cã thÓ chuyÓn ng­¬i lªn trªn.", tasks)
end;

function send()
    CloseDialog()

    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    NewWorld(74, 1930, 3734)
    if (GetPlayerExtLevel() >= 46 and GetTaskByte(Task_baichuan, 1) == 3) then
        TaskNote(1037, 3, Tower_Camp[gdCamp].desc)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
    end
end

function no()
    CloseDialog()
end;

