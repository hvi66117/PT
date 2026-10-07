Task_zhixian = 1471

Global_HanLongFan = 211

function OnTimer(npcidx)
    local playerIdx = GetNpcTask(npcidx, 2)
    PlayerIndex = playerIdx

    if (GetNpcTask(npcidx, 1) == GetPlayerID()) then
        if (GetTaskByte(Task_zhixian, 1) == 8) then
            Msg2Player("Hµm Long Ph≠Ìn bi’n m t, v…n ch≠a Æπt Æ≠Óc [CÊ ßÂ Tµn Phi’n], xin sˆ dÙng lπi Hµm Long Ph≠Ìn.")
            TopMessage("Hµm Long Ph≠Ìn bi’n m t.")
        end
    end

    SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), GetNpcTask(npcidx, 3), 0))
    DelNpc(npcidx)
end;
