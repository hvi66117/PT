--description: npc
--author: huyuzhang
--date: 2009/07/15

TASK_BQJJ = 1502        --1byte:ÈÎÎñÊÇ·ñ¿ªÆô 2byte:ÈÎÎñ²½Öè
TASK_BQJJ_LOCK = 240

function OnDeath(npcindex)
    --AS by hyz 090723 for °æÈªÊ¥µØÖ§Ïß
    local pid = GetPlayerID()
    local bpid = GetNpcTask(npcindex, 2)

    if (pid ~= bpid) then
        if (GetNpcID(GetNpcTask(npcindex, 4)) == GetNpcTask(npcindex, 5)) then
            DelNpc(GetNpcTask(npcindex, 4))        --É¾µôÁíÒ»¸öNPC
        end

        local oldplayeridx = GetNpcTask(npcindex, 1)
        local tmp_pidx = PlayerIndex
        PlayerIndex = oldplayeridx
        local oldplayerid = GetPlayerID()

        if (oldplayerid == bpid) then
            Msg2Player("NhiÖm vô thÊt b¹i.")
            SetTaskByte(TASK_BQJJ, 4, 0)            --ÖØÖÃ»÷É±ÊıÁ¿

        end

        --Msg2Player("ÈÎÎñÊ§°Ü¡£")

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
            Msg2Player("Thµnh c«ng ®¸nh b¹i hån Kh­¬ng Giai Minh.")

        else
            TopMessage("Th«ng qua kh¶o nghiÖm")
            Msg2Player("Thµnh c«ng v­ît qua kh¶o nghiÖm cña Kh­¬ng Giai Minh vµ C¬ Th­¬ng HuyÒn.")
            SetTaskByte(TASK_BQJJ, 2, 4)
            TaskNote(1089, 3)
            SetGlobalValue(TASK_BQJJ_LOCK, 0)
            --Add by luoyixuan 2009/12/30 begin
            RefreshAllNpcTask()
            --Add by luoyixuan 2009/12/30 end
        end

    end
    --AE by hyz 090723 for °æÈªÊ¥µØÖ§Ïß

    DelNpc(npcindex)
end