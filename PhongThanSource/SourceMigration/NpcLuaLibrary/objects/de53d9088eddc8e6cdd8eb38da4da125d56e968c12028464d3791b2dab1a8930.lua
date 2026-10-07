--hongliang ºìÉ°Õó 10/10/29


--------------------------------------
--¸±±¾ÁÙÊ±±äÁ¿
--1 ~ 4: TABLE_NpcÖÐNpcµÄIdx
--5 ~ 8: TABLE_NpcÖÐNpcµÄID

TASK_Instance_HSZ = 601 --1st byte: Òýµ¼ÈÎÎñ²½Öè 0-Î´½Ó;1-ÒÑ½Ó;2-ÒÑºÍµÀÈË¶Ô»°;3-ÒÑ´ðÓ¦ÎäÍõ;4-ÒÑÉ±ËÀboss;5-ÒÑÍê³ÉÈÎÎñ;

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --×îºóÒ»»÷
    if (GetLevel() >= 131 and GetTaskByte(TASK_Instance_HSZ, 1) == 4) then

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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()

    local tasks = {
        [1] = { "Tho¸t khái Hång Sa TrËn", "Choose_LeaveInstance"; show = 0 },
        [2] = { "C«ng kÝch lÇn cuèi", "Instance_HSZ_PreTask"; show = 0 },
    }

    local TaskStep = GetTaskByte(TASK_Instance_HSZ, 1)

    if (TaskStep == 4) then
        tasks[2].show = 1
    else
        tasks[1].show = 1
    end

    SayTask("May mµ cã ®¹i hiÖp ra tay gióp ®ì, ph¸ trËn ph¸p cña Tr­¬ng Thiªn Qu©n, ®Õn nay thËp tuyÖt trËn ®· ®­îc c«ng ph¸, ngµy diÖt vong cña triÒu ®¹i nhµ Th­¬ng ®· s¾p tíi.", tasks)

end

function Choose_LeaveInstance()
    CloseDialog()

    MsgBox("B¹n x¸c ®Þnh muèn tho¸t khái Hång Sa trËn chø?", "Confirm_LeaveInstance", "no")
end

function Confirm_LeaveInstance()
    CloseDialog()

    LeaveTeam()
    RemoveIBBuff(BUFF_InstanceTime)
    SetInstanceEnterFlag(INSTANCE_TYPE_HSZ, 3)
    NewWorld(20, 1448, 3086)
    SetFightState(0)

end

function Instance_HSZ_PreTask()
    CloseDialog()

    Talk(1, "no", "LÇn nµy bæn v­¬ng an toµn tho¸t hiÓm, v¹n sù lµ nhê vÞ anh hïng øng cøu, ta v« cïng c¶m kÝch, ®¸m m©y mï u tèi cña Th­¬ng triÒu ®· ®­îc xua tan, thËp tuyÖt trËn huyÒn c¬ tinh diÖu, ®· cã cèng hiÕn to lín cho Th­¬ng triÒu, mãn quµ nhá tá lßng biÕt ¬n cña bæn V­¬ng mong ®¹i hiÖp chí tõ chèi.")

    AddOwnExp(200000)
    ActiveTitleFunc(1)  --¼¤»îÈËÎï³ÆºÅ¹¦ÄÜ
    ActiveTitleQualify(65)  --¼¤»î³ÆºÅ
    SetCurTitle(65)
    Msg2Player("Chóc mõng b¹n ®· ®¹t ®­îc danh hiÖu §¹p B×nh ThËp TuyÖt")

    SetTaskByte(TASK_Instance_HSZ, 1, 5)
    TaskNote(1623, -1)
    SetSubTask(1623, -1, 1)
    refreshNpcTaskState()

    WriteLog(GetName() .. "§· hoµn thµnh nhiÖm vô h­íng dÉn Hång Sa TrËn")
end

function no()
    CloseDialog()
end

