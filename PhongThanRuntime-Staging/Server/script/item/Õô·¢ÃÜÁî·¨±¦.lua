TASK_ID_LEAK = 1234
MONSTER_NPCID = 689
MONSTER_LEVEL = 160
MONSTER_NAME = "Ma Sø"
MONSTER_LIFE_TIME = 300
BUFF_ID_LEAK = 460

function main()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    local useTime = GetByte(GetTask(TASK_ID_LEAK), 2)
    local playerType = GetPlayerType()
    if (taskStatus ~= 3) then
        return
    end
    useTime = useTime + 1
    if (useTime <= 20) then
        local mapid, x, y = GetWorldPos()

        if (mapid ~= 23) then
            Msg2Player("B¹n ®· ra khái ph¹m vi hiÖu lùc cña Ph¸p b¶o!")
            return
        end

        if (useTime == 1) then
            SetTask(1235, SetByte(GetTask(1235), 1, math.floor(x / 256)))
            SetTask(1235, SetByte(GetTask(1235), 2, math.mod(x, 256)))
            SetTask(1235, SetByte(GetTask(1235), 3, math.floor(y / 256)))
            SetTask(1235, SetByte(GetTask(1235), 4, math.mod(y, 256)))
            evocationBoss(x, y)
        else
            local centerX = GetByte(GetTask(1235), 1) * 256 + GetByte(GetTask(1235), 2)
            local centerY = GetByte(GetTask(1235), 3) * 256 + GetByte(GetTask(1235), 4)
            if (math.abs(x - centerX) > 12 or math.abs(y - centerY) > 24) then
                Msg2Player("B¹n ®· ra khái ph¹m vi hiÖu lùc cña Ph¸p b¶o!")
                TopMessage(14345)
                return
            end
        end
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 2, useTime))
        AddIBBuff(BUFF_ID_LEAK + playerType)
        Msg2Player("B¹n ®· sö dông Ph¸p b¶o" .. useTime .. "lÇn!")
        TopMessage(14346)
    else
        Msg2Player("Ph¸p b¶o nµy ®· sö dông qu¸ 20 lÇn, kh«ng thÓ dïng n÷a!")
        TopMessage(14347)
    end
end;

function evocationBoss(x, y)
    local npcIndex = AddNpc(MONSTER_NPCID, MONSTER_LEVEL, SubWorld, x * 32, y * 32)
    if (npcIndex > 0) then
        SetNpcName(npcIndex, MONSTER_NAME)
        SetNpcScript(npcIndex, "\\script\\¹ÖÎï\\Õô·¢ÃÜÁîÄ§Ê¹.lua")
        SetNpcTimer(npcIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", MONSTER_LIFE_TIME)
    end

end

