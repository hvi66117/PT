task_gather = 1289
JECT_TASK_STATE = 1291
fssh_renwu = 1303

grass_renwu = 1322

gua8_renwu = 1340
gua8_task = 1341

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

function OnDeath(npcindex)
    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end ;
    end ;

    if (GetTask(fssh_renwu) == 1) then
        frenwu11()
    end

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 2) then
        jeCreditTask()
    end

    if (GetTaskByte(grass_renwu, 2) > 0) then
        frenwu18()
    end

    shuangsheng(npcindex)

    if (HaveIBBuff(542) > 0) and (GetTaskByte(gua8_renwu, 4) == 2) and (GetTaskByte(gua8_renwu, 3) == 2) then
        eightgua()
    end
end;

function shuangsheng(npcindex)

    if (GetTaskByte(task_gather, 1) == 1) then

        local npcLevel = GetNpcLevel(npcindex)
        local diffLevel = GetPlayerExtLevel() - npcLevel

        local r = math.random(1, 100)
        if (diffLevel <= 0) then
            if (r <= 15) then
                AddIBBuff(536)
            end
        elseif (diffLevel <= 5) then
            if (r <= 7) then
                AddIBBuff(536)
            end
        elseif (diffLevel <= 10) then
            if (r <= 3) then

                AddIBBuff(536)
            end
        end
    end
end

function frenwu11()
    local r = math.random(1, 100)
    if (r <= 5) then
        AddNormalItem(6, 1, 437, 1, 0, 0)
        ScrollMessage("NhËn ®­îc Táa Tinh bµn")
        SetTask(fssh_renwu, 2)
        TaskNote(89, 1)

        local credit = GetJusticEvilCredit()
        if (credit > 0) then
            Msg2Player("B¹n nhËn thµnh c«ng Táa Tinh bµn, quay vÒ thØnh gi¸o B¹ch H¹c ®¹o tr­ëng t×m ph­¬ng ph¸p")
        else
            Msg2Player("B¹n nhËn thµnh c«ng Táa Tinh bµn, quay vÒ thØnh gi¸o Linh Nha KiÕm Tiªn t×m ph­¬ng ph¸p")
        end
    else
        Msg2Player("B¹n vÉn ch­a nhËn ®­îc Táa Tinh bµn, xin tiÕp tôc!")
    end
end

function jeCreditTask()

    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    if (nType == 1) then

        local nRand = math.random(1, 100)
        if (nRand >= 50) then
            AddNormalItem(6, 1, 433, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 433, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1021, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (hoµn thµnh)")
            Msg2Player("m¶nh ChiÕn kú ®· tËp hîp ®ñ, ®· cã thÓ hîp thµnh chiÕn kú!")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (" .. nCount .. "/5)")

            if (nRand > 50) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Tiªn), cÇn cã 5 m¶nh míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")
            end

        end

    elseif (nType == 2) then

        local nRand = math.random(1, 100)
        if (nRand >= 50) then
            AddNormalItem(6, 1, 434, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 434, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1022, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (hoµn thµnh)")
            Msg2Player("m¶nh ChiÕn kú ®· tËp hîp ®ñ, ®· cã thÓ hîp thµnh chiÕn kú!")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/5)")

            if (nRand > 50) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end

        end

    end

end

function frenwu18()
    local state = GetTaskByte(grass_renwu, 1)
    if (state == 3) or (state == 4) then
        if (math.random(1, 2) == 1) then
            local w, x, y = GetWorldPos()
            AddNpc(820, 20, SubWorld, x * 32, y * 32)
            SetTaskByte(grass_renwu, 3, 3)
        end
    end
end

function eightgua()
    if (GetTaskByte(gua8_renwu, 3) ~= 2) then
        return 0
    end

    if (GetTaskByte(gua8_renwu, 4) == 2) then
        if (HaveIBBuff(542) > 0) then
            local nums = GetTaskByte(gua8_task, 2) + 1
            if (nums >= GetTaskByte(gua8_task, 1)) then
                TaskNote(97, 1)
                SetTaskByte(gua8_task, 2, GetTaskByte(gua8_task, 1))
                SetTaskByte(gua8_renwu, 3, 3)
                RemoveIBBuff(542)
                ScrollMessage("NhiÖm vô B¸t Qu¸i Lu©n Håi hoµn thµnh")
            else
                SetTaskByte(gua8_task, 2, nums)
                TaskNote(97, 3, nums)
                ScrollMessage("§· thu thËp" .. nums .. "/5 hån ph¸ch Tr¹nh Nanh")
            end
        end
    end
end
