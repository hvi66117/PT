--description:npc
--author: mayining
--date:2009/1/13

JECT_TASK_STATE = 1291 -- byte1:type byte2:state byte3:ib byte4:Monster
JECT_TASK_FLAG_IDX = 1292
JECT_TASK_FLAG_ID = 1293
JECT_TYPE = 1

Task_xianmo_renwu = 1302 --1byte Ê±¼ä 2Ã¿ÈÕ»ñÈ¡µÄÖµ
xianmo_UPtimes = 50--µ¥ÈÕ¿É»ñÈ¡µÄÉÏÏÞÎª50µã£»
xianmo_UPcredit = 5000 --ÏÉÉùÍûÉÏÏÞ
xianmo_UPcredit1 = 15000 --×ªÉúºóÏÉÉùÍûÉÏÏÞ
xianmo_UPcredit2 = 45000 --×ªÉúºóÏÉÉùÍûÉÏÏÞ

g_NpcName = {
    "Gß Hång Nª (Ma)",
    "Gß Viªm Sa (Ma)",
    "Gß XÝch Thæ (Ma)",
    "Gß Hång Nª (Tiªn)",
    "Gß Viªm Sa (Tiªn)",
    "Gß XÝch Thæ (Tiªn)",
}


function OnDeath(npcidx)

    local OldPlayerIndex = PlayerIndex

    if (GetNpcTask(npcidx, 3) ~= 1) then

        PlayerIndex = SearchPlayerById(GetNpcTask(npcidx, 0))

        if (PlayerIndex > 0) then

            if (GetTask(JECT_TASK_FLAG_IDX) == npcidx) and (GetTask(JECT_TASK_FLAG_ID) == GetNpcID(npcidx)) then

                local nType = GetTaskByte(JECT_TASK_STATE, 1)
                local nState = GetTaskByte(JECT_TASK_STATE, 2)
                if (nType == JECT_TYPE) and (nState == 3) then

                    SetTask(JECT_TASK_STATE, 0)
                    SetTask(JECT_TASK_FLAG_IDX, 0)
                    SetTask(JECT_TASK_FLAG_ID, 0)
                    ClearItem(6, 1, 433, 1)
                    ClearItem(3, 328, 0, 0)

                    TaskNote(1021, -1)

                    RemoveIBBuff(512)
                    Msg2Player("Do kh«ng tËn lùc b¶o vÖ, Tiªn giíi ChiÕn kú c¶u b¹n ®· bÞ ph¸ háng, hµnh ®éng Tiªn Phong ¦u Tån lÇn nµy thÊt b¹i, c¸o chung!")

                    local DeathName1 = GetName()
                    local DeathPlayerIndex = PlayerIndex
                    PlayerIndex = OldPlayerIndex

                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> h¹ <RoleName=\"" .. DeathName1 .. "\">_Tiªn giíi ChiÕn kú liªn tôc ®­îc dùng lªn, khiÕn phe Tiªn giíi ®Òu kinh h·i!")

                    if (GetJusticEvilCredit() < 0) then
                        awardPlayer()
                    end

                end

            end

        end

        PlayerIndex = OldPlayerIndex

    end

    local nNpcIdx = GetNpcTask(npcidx, 1)
    local nNpcType = GetNpcTask(npcidx, 2)
    SetNpcName(nNpcIdx, g_NpcName[nNpcType])
    SetNpcTask(nNpcIdx, 0, 0)

    DelNpc(npcidx)
end

function awardPlayer(DeathPlayerIndex)

    local playercredit = GetJusticEvilCredit() --É±ÈËÕßÕóÓªÉùÍû
    local playerextlvl = GetPlayerExtLevel()--É±ÈËÕßÏÉÄ§½çµÈ¼¶
    local playerLevel = GetLevel()

    if (mapId ~= 72) and ((abs(playercredit) < xianmo_UPcredit) or (IsNewBirthComplete() == 1 and abs(playercredit) < xianmo_UPcredit1) or (IsJEMainTaskComplete(1) == 1 and abs(playercredit) < xianmo_UPcredit2)) then

        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(Task_xianmo_renwu, 1)
        if (today ~= lastday) then
            SetTask(Task_xianmo_renwu, today)
        end

        local upcredit = GetTaskByte(Task_xianmo_renwu, 2)
        if (upcredit < xianmo_UPtimes) then
            local val = 10
            if (playercredit < 0) then
                if (upcredit + val <= xianmo_UPtimes) then
                    ChangeJusticEvilCredit(-val)--¸Ä±äÏÉÉùÍû +¼ÓÏÉÉùÍû -¼ÓÄ§ÉùÍû
                    SetTaskByte(Task_xianmo_renwu, 2, upcredit + val)
                elseif (xianmo_UPtimes - upcredit >= 1) then
                    val = xianmo_UPtimes - upcredit
                    ChangeJusticEvilCredit(-val)
                    SetTaskByte(Task_xianmo_renwu, 2, xianmo_UPtimes)
                    Msg2Player("H«m nay ng­¬i ®· h¹ s¸t rÊt nhiÒu Ma t­íng råi, danh tiÕng ®· khiÕn nhiÒu ng­êi ph¶i ®è kþ! T¹m dõng l¹i th«i!")
                end
            elseif (playercredit > 0) then
                if (upcredit + val <= xianmo_UPtimes) then
                    ChangeJusticEvilCredit(val)--¸Ä±äÏÉÉùÍû +¼ÓÏÉÉùÍû -¼ÓÄ§ÉùÍû
                    SetTaskByte(Task_xianmo_renwu, 2, upcredit + val)
                elseif (xianmo_UPtimes - upcredit >= 1) then
                    val = xianmo_UPtimes - upcredit
                    ChangeJusticEvilCredit(val)
                    SetTaskByte(Task_xianmo_renwu, 2, xianmo_UPtimes)
                    Msg2Player("H«m nay ng­¬i ®· h¹ s¸t rÊt nhiÒu Tiªn t­íng råi, danh tiÕng ®· khiÕn nhiÒu ng­êi ph¶i ®è kþ! T¹m dõng l¹i th«i!")
                end
            end

            if (val > 0) then
                local newplayercredit = GetJusticEvilCredit()

                if (IsJEMainTaskComplete(1) == 1) then

                    if (abs(newplayercredit) > xianmo_UPcredit2) then

                        -- add by mayining 2009.2.2
                        -- Ä§ÉùÍûÓ¦¸ÃÖÃ¸º¼«ÏÞÖµ
                        if (playercredit < 0) then
                            ChangeJusticEvilCredit(-xianmo_UPcredit2 - newplayercredit)
                        else
                            ChangeJusticEvilCredit(xianmo_UPcredit2 - newplayercredit)
                        end
                        -- end by mayining

                    end

                else

                    if (IsNewBirthComplete() == 1) and (abs(newplayercredit) > xianmo_UPcredit1) then

                        -- add by mayining 2009.2.2
                        -- Ä§ÉùÍûÓ¦¸ÃÖÃ¸º¼«ÏÞÖµ
                        if (playercredit < 0) then
                            ChangeJusticEvilCredit(-xianmo_UPcredit1 - newplayercredit)
                        else
                            ChangeJusticEvilCredit(xianmo_UPcredit1 - newplayercredit)
                        end
                        -- end by mayining

                    end

                    if (IsNewBirthComplete() ~= 1) and (abs(newplayercredit) > xianmo_UPcredit) then

                        -- add by mayining 2009.2.2
                        -- Ä§ÉùÍûÓ¦¸ÃÖÃ¸º¼«ÏÞÖµ
                        if (playercredit < 0) then
                            ChangeJusticEvilCredit(-xianmo_UPcredit - newplayercredit)
                        else
                            ChangeJusticEvilCredit(xianmo_UPcredit - newplayercredit)
                        end
                        -- end by mayinin

                    end

                end

                local newplayercredit = GetJusticEvilCredit()

                if (playercredit > 0) then
                    ScrollMessage("ph¸ háng Ma giíi ChiÕn kú, nhËn ®­îc" .. abs(newplayercredit - playercredit) .. " ®iÓm Danh väng Tiªn Ma")
                elseif (playercredit < 0) then
                    ScrollMessage("ph¸ háng Tiªn giíi ChiÕn kú, nhËn ®­îc" .. abs(newplayercredit - playercredit) .. " ®iÓm Danh väng Ma giíi")
                end
            end
        end
    end

end