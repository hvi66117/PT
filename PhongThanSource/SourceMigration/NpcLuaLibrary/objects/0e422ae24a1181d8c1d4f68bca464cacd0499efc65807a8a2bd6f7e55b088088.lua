--hongliang ºìÉ°Õó 10/10/29


--------------------------------------
--¸±±¾ÁÙÊ±±äÁ¿
--1 ~ 4: TABLE_NpcÖĞNpcµÄIdx
--5 ~ 8: TABLE_NpcÖĞNpcµÄID

TASK_Instance_HSZ = 601 --1st byte: Òıµ¼ÈÎÎñ²½Öè 0-Î´½Ó;1-ÒÑ½Ó;2-ÒÑºÍµÀÈË¶Ô»°;3-ÒÑ´ğÓ¦ÎäÍõ;4-ÒÑÉ±ËÀboss;5-ÒÑÍê³ÉÈÎÎñ;

NPCTVID_InstanceIdx = 0;
NPCTVID_InstanceId = 1;

INSTANCE_TYPE_HSZ = 10

BUFF_InstanceTime = 1344
Timer_Check = 68
Timer_End = 69
--------------------------------------


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

    --×îºóÒ»»÷
    if (GetLevel() >= 131 and GetTaskByte(TASK_Instance_HSZ, 1) == 1) then

        if (GetLevel() - 131 <= 5) then
            state = 3
            subState = 0
        else
            state = 3
            subState = 1
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

function main()

    local tasks = {
        [1] = { "ChuyÓn ®Õn mét cöa kh¸c", "Choose_Transmit"; show = 1 },
        [2] = { "C«ng kİch lÇn cuèi", "Instance_HSZ_PreTask"; show = 0 },
        [3] = { "H­íng dÉn c¸ch ch¬i phã b¶n", "Instance_Info"; show = 1 },
    }

    local TaskStep = GetTaskByte(TASK_Instance_HSZ, 1)

    if (TaskStep == 1) then
        tasks[2].show = 1
    end

    SayTask("Tõ Hµng §¹o Nh©n: Hång Sa TrËn nguy hiÓm v¹n phÇn, Vò V­¬ng ®· bŞ nhèt l¹i gi÷a trËn chiÕn, t×nh h×nh v« cïng cÊp b¸ch, xin ®¹i hiÖp h·y mau mau ®i gi¶i cøu.", tasks)

end

function Choose_Transmit()
    CloseDialog()

    MsgBox("Tõ Hµng §¹o Nh©n: B¹n x¸c ®Şnh muèn ®Õn chç Nhiªn §¨ng ®¹o nh©n ë lèi kh¸c chø?", "Confirm_Transmit", "no")
end

function Confirm_Transmit()
    CloseDialog()

    local nInstanceID, nLastEnterDate, nTodayEnterCount, nTotalEnterCount, nEnterFlag = GetInstanceEnterInfo(INSTANCE_TYPE_HSZ)
    EnterInstance(nInstanceID, 1471, 3273)

end

function Instance_HSZ_PreTask()
    CloseDialog()

    local TaskStep = GetTaskByte(TASK_Instance_HSZ, 1)

    if (TaskStep == 1) then
        Talk(1, "no", "Tõ Hµng §¹o Nh©n: §¹i hiÖp ®Õn thËt ®óng lóc, Vò V­¬ng ®ang bŞ giam t¹i gi÷a Hång Sa TrËn, t×nh h×nh v« cïng nguy hiÓm, xin ®¹i hiÖp h·y gióp ®ì. Sau khi ®Õn hµnh lang cña Hång Sa, tiªu diÖt Minh Sa Tiªn v­ît qua ®¹i m«n ®Ó t×m Vò V­¬ng")

        SetTaskByte(TASK_Instance_HSZ, 1, 2)
        TaskNote(1623, 1)
        refreshNpcTaskState()
    end
end

function Instance_Info()
    no()

    Talk(2, "no", "Tõ Hµng §¹o Nh©n: Trong Hång Sa TrËn cã 2 lèi vµo: Mçi lèi vµo ®Òu th«ng qua mét hµnh lang Hång Sa, giÕt chÕt <c=fire>Hång Sa TrËn Hån<c> ë cæng vµo cña hµnh lang th× cã thÓ kİch ho¹t ®­îc hµnh lang, cuèi hµnh lang sÏ bŞ phong táa bëi trËn ph¸p, ®¹i hiÖp cÇn ph¶i tiªu diÖt 12 con <c=fire>Sa Hån khæng lå<c> cña trËn ph¸p trong vßng 8 phót th× míi th«ng qua hµnh lang.", "Tõ Hµng §¹o Nh©n: <c=fire>Sa Hån khæng lå<c> sau khi chÕt, nÕu trong vßng <c=g>8<c> phót vÉn cßn <c=fire>Sa Hån khæng lå<c> kh¸c sèng sãt, nh­ vËy b¶n n¨ng cña Sa Hån lµ tô tËp hån ph¸ch ®Ó håi sinh.")
end

function no()
    CloseDialog()
end