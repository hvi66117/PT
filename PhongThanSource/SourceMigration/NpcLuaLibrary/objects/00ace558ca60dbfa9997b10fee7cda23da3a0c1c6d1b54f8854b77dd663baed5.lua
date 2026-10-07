--description: npc
--author: huyuzhang
--date: 2009/07/15

TASK_BQJJ = 1502        --1byte:»ŒŒÒ «∑Òø™∆Ù 2byte:»ŒŒÒ≤Ω÷Ë 4byte:…±À¿º∏÷ª
TASK_BQJJ_LOCK = 240

function OnDeath(npcindex)

    --AS by hyz 090723 for ∞Ê»™ •µÿ÷ßœﬂ
    local pid = GetPlayerID()
    local bpid = GetNpcTask(npcindex, 2)

    if (pid ~= bpid) then
        if (GetNpcID(GetNpcTask(npcindex, 4)) == GetNpcTask(npcindex, 5)) then
            DelNpc(GetNpcTask(npcindex, 4))        --…æµÙ¡Ì“ª∏ˆNPC
        end
        --DelNpc( GetNpcTask(npcindex, 4) )		--…æµÙ¡Ì“ª∏ˆNPC
        local oldplayeridx = GetNpcTask(npcindex, 1)
        local tmp_pidx = PlayerIndex
        PlayerIndex = oldplayeridx
        local oldplayerid = GetPlayerID()

        if (oldplayerid == bpid) then
            Msg2Player("Nhi÷m vÙ th t bπi.")
            SetTaskByte(TASK_BQJJ, 4, 0)            --÷ÿ÷√ª˜…± ˝¡ø

        end

        SetGlobalValue(TASK_BQJJ_LOCK, 0)
        PlayerIndex = tmp_pidx
        DelNpc(npcindex)
        return
    end

    if (GetTaskByte(TASK_BQJJ, 1) == 6 and GetTaskByte(TASK_BQJJ, 2) == 3) then
        local count = GetTaskByte(TASK_BQJJ, 4)
        count = count + 1

        if (count < 2) then
            SetTaskByte(TASK_BQJJ, 4, count)
            Msg2Player("Thµnh c´ng thu phÙc hÂn C¨ Th≠¨ng Huy“n.")

        else
            TopMessage("Th´ng qua kh∂o nghi÷m")
            Msg2Player("Thµnh c´ng v≠Ót qua kh∂o nghi÷m cÒa Kh≠¨ng Giai Minh vµ C¨ Th≠¨ng Huy“n.")
            SetTaskByte(TASK_BQJJ, 2, 4)
            TaskNote(1089, 3)
            SetGlobalValue(TASK_BQJJ_LOCK, 0)
            --Add by luoyixuan 2009/12/30 begin
            RefreshAllNpcTask()
            --Add by luoyixuan 2009/12/30 end
        end

    end
    --AE by hyz 090723 for ∞Ê»™ •µÿ÷ßœﬂ

    DelNpc(npcindex)
end