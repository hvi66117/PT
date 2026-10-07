JECT_TASK_STATE = 1291
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

southfire_renwu = 1329
southfire_npc = 1330
southfire_item = {
    [1] = { "Ma*Ly Ch©u", 1, { 2, 3, 4 }, 5, 8 },
    [2] = { "Tiªn*Ly Ch©u", 1, { 2, 3, 4 }, 5, 8 },
}

yanluo_renwu = 1333

function OnDeath(npcindex)

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 7) then
        jeCreditTask()
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end
    end ;

    local pextlvl = GetPlayerExtLevel()
    if (GetPlayerExtLevel() >= 24) and (GetTaskByte(southfire_renwu, 3) == 1) then
        renwu24_southfire()
    end

    if (pextlvl >= 26) and (GetTask(yanluo_renwu) == 2) then
        renwu26()
    end
end;

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
            TaskNote(1022, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (hoµn thµnh)")
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Tiªn giíi ChiÕn kú.")
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
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Ma giíi ChiÕn kú.")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/5)")

            if (nRand > 50) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end
        end

    end

end

function renwu24_southfire()
    if (GetTaskByte(southfire_renwu, 2) ~= 2) then
        Msg2Player("LÇn nµy ph¶i thu phôc Ma Ly Ch©u míi cã thÓ nhËn ®­îc Ly Háa néi ®¬n!")
        return 0
    end

    local r = math.random(1, 100)
    local lucky = 2 * GetTaskWord(southfire_npc, 1)

    if (r < lucky) then
        SetTaskByte(southfire_renwu, 3, 2)
        AddEventItem(214)
        Msg2Player("NhËn ®­îc Ly Háa néi ®¬n, vÒ giao nhiÖm vô")
        if (GetJusticEvilCredit() > 0) then
            TaskNote(93, 1)
            TaskNote(94, -1)
        else
            TaskNote(93, -1)
            TaskNote(94, 1)
        end

        ScrollMessage("NhËn ®­îc <c=yel>Ly Háa néi ®¬n<c>, vÒ giao nhiÖm vô!")
    else
        local key = GetTaskByte(southfire_renwu, 2)
        local temp = southfire_item[key]
        if (lucky >= temp[5]) then
            return 0
        end

        local nums = GetTaskWord(southfire_npc, 2) + 1
        if (math.mod(nums, temp[4]) == 0) then
            lucky = lucky + temp[3][math.floor(nums / temp[4])]
            if (lucky >= temp[5]) then
                lucky = temp[5]
            end

            SetTaskWord(southfire_npc, 1, lucky)
        end
        SetTaskWord(southfire_npc, 2, nums)
    end
end

function renwu26()
    if (GetJusticEvilCredit() >= 0) then
        Msg2Player("Kh©m Nguyªn ®· hiÕn Ph¸p b¶o cho Ma Ly Ch©u, xem ra kh«ng cã trong ng­êi Tiªn Ly Ch©u!")
        return 0
    end

    local r = math.random(1, 100)
    if (r <= 5) then
        SetTask(yanluo_renwu, 3)
        Msg2Player("LÊy thµnh c«ng NhÊt KhÝ Tö V©n Sa, lËp tøc vÒ giao cho Phong Tøc Sø")
        TaskNote(95, 2)
        AddNormalItem(6, 1, 444, 0, 0, 0)
        ScrollMessage("NhËn ®­îc <c=yel>NhÊt KhÝ Tö V©n Sa<c>")
    end
end
