TaskYouChong = 1288
task_gather = 1289

gua8_renwu = 1340
gua8_task = 1341

JECT_TASK_STATE = 1291
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 1) then
        jeCreditTask()
    end

    Kill()

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end
    end ;

    shuangsheng(npcindex)

    if (GetTaskByte(gua8_renwu, 4) <= 2 or GetTaskByte(gua8_renwu, 4) == 6) and (GetTaskByte(gua8_renwu, 3) == 2) then
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

function Kill()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    if (lTaskCtrl ~= 1) then
        return 0
    end

    local w, x, y = GetWorldPos()
    local newnpcidx = AddNpc(808, 10, SubWorld, x * 32, y * 32)
    SetTask(TaskYouChong, SetByte(GetTask(TaskYouChong), 4, 5))
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

function eightgua()
    if (GetTaskByte(gua8_renwu, 3) ~= 2) then
        return 0
    end

    if (GetTaskByte(gua8_renwu, 4) == 2) then
        local rn = math.random(1, 100)
        if (rn <= 20) then
            AddIBBuff(542)
            ScrollMessage("B¹n nhËn ®­îc <c=g>HÊp hån chó<c>")
        end
    elseif (GetTaskByte(gua8_renwu, 4) == 1) then
    elseif (GetTaskByte(gua8_renwu, 4) == 6) then
    end
end
