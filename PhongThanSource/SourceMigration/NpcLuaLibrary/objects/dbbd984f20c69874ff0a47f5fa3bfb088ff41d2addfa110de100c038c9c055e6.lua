Task_zhixian = 1471

function OnDeath(npcidx)

    if (GetTeam() == 0) then
        if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0) then
            AddNormalItem(4, 257, 0, 1, 0, 0)
            SetTaskByte(Task_zhixian, 1, 19)
            TaskNote(107, 4)
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0) then
                AddNormalItem(4, 257, 0, 1, 0, 0)
                SetTaskByte(Task_zhixian, 1, 19)
                TaskNote(107, 4)
            end
        end
        PlayerIndex = oldPlayer

    end
    Msg2CurMapAnnounce("MËt th¸m Tiªn Giíi ®· bÞ tiªu diÖt, nh©n sÜ Ma Giíi thu ®­îc 1 m¶nh Cæ §å Tµn PhiÕn trªn ng­êi anh ta!")
    SetNpcTimer(GetNpcTask(npcidx, 3), "\\script\\ontimer\\¹ÅÍ¼ÖØÉúÊ®·ÖÖÓ¶¨Ê±.lua", 60 * 10)
    DelNpc(npcidx)
end
