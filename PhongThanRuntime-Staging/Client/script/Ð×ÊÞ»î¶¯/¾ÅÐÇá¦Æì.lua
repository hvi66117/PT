require("common_beast.luax")

task_info = CommonBeast.task_info
task_pos = CommonBeast.task_pos
TaskList = CommonBeast.TaskList
task_starttime = CommonBeast.task_starttime
npcFlag = CommonBeast.npcFlag
flag_list = CommonBeast.flag_list

function main(level, time, npcIndex, itemId)

    SetTaskByte(task_info, 3, 0)
    local particular = GetItemPartByID(itemId)

    local task_index = flag_list[particular]
    local flag_id = TaskList[task_index].flagid
    local flag_buff = TaskList[task_index].flagbuff
    local tar_mapid = TaskList[task_index].mapid
    local npcFlag = TaskList[task_index].npcFlag

    local mapid, x, y = GetWorldPos()
    if (mapid ~= tar_mapid) then
        Talk(1, "no", "µ±«∞µÿÕº≤ªƒ‹∑≈÷√¥À·¶∆Ï, «Î«∞Õ˘÷∏∂®µÿÕº∑≈÷√!")
        return
    end

    local exist_starttiem = GetTask(task_starttime)
    if (SystemTime() < exist_starttiem + 3 * 60) then
        Talk(1, "no", "ƒ˙…œ 1 c∏i æ≈–«·¶∆ÏªπŒ¥œ˚ ß, Œﬁ∑®∑≈÷√–¬µƒæ≈–«·¶∆Ï!")
        return
    end

    if (DelItemByID(itemId) <= 0) then
        return
    end

    local posX = math.floor(x / 8)
    local posY = math.floor(y / 16)

    SetTaskWord(task_pos, 1, posX)
    SetTaskWord(task_pos, 2, posY)

    SetTask(task_starttime, SystemTime())

    Msg2Player("ƒ˙≤Â…œ¡À“ª∏Àæ≈–«·¶∆Ï,¥À∆ÏΩ´”⁄3∑÷÷”÷Æ∫Ûœ˚ ß£.°!")
    WriteLog("[Hoπt ÆÈng Hung ThÛ][≤Â∆Ï]‘⁄[" .. x .. "," .. y .. "]≤Â»Î¡Àæ≈–«·¶∆Ï" .. task_index .. ",µÿÕº: " .. mapid)

    local npc_index = AddNpc(npcFlag, 1, SubWorldID2Idx(mapid), x * 32, y * 32)
    SetNpcTimer(npc_index, "\\script\\ontimer\\æ≈–«·¶∆Ï…æµÙ◊‘º∫.lua", 60 * 3)
    AddIBBuff(flag_buff)
end

function no(...)

    CloseDialog()
end
