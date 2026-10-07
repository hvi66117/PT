TASK_ID_LEAK = 1234
TASK_INFO_ID_LEAK = 1015
MONSTER_NAME = "Ma Sø"
BUFF_ID_LEAK = 460

function OnDeath(npcidx)
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    local playerType = GetPlayerType()
    if (taskStatus == 3) then
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 4))
        RemoveIBBuff(BUFF_ID_LEAK + playerType)
        TaskNote(TASK_INFO_ID_LEAK, 3)
        Msg2Player("hoµn thµnh nhiÖm vô <c=g>MËt LÖnh<c>!")
        TopMessage(MONSTER_NAME .. "hoµn thµnh nhiÖm vô <c=g>MËt LÖnh<c>")
    end
    DelNpc(npcidx)
end
