--description: ÕøÂ\-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/8/2

task_gather = 1289   --Ë«Éú±Ë°¶µÄÈÎÎñ±äÁ¿,1byte:ÊÇ·ñ½ÓÊÜÈÎÎñ£»2byte£ºÒÑÁìÈ¡µÄÈÎÎñ´ÎÊı£»3byte£ºÒÑ²É¼¯µ½µÄÂüÍÓÂŞ»ªµÄ¸öÊı
JECT_TASK_STATE = 1291 -- byte1:type byte2:state
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı
function OnDeath(npcindex)

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 3) then
        jeCreditTask()--ÏÉÄ§ÉùÍûÈÎÎñ
    end

    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end ;
    ----------Add by Gaojingwei at 2009/3/3  Ë«Éú±Ë°¶ begin-------------
    shuangsheng(npcindex)
    ----------Add by Gaojingwei at 2009/3/3  Ë«Éú±Ë°¶ end---------------

    -- Added by Zhaoqingsong at 2009-3-11 Begin
    processSpiritRay(npcindex)
    -- Added by Zhaoqingsong at 2009-3-11 End
end;

----------Add by Gaojingwei at 2009/3/3  Ë«Éú±Ë°¶ begin-------------
function shuangsheng(npcindex)
    if (GetTaskByte(task_gather, 1) == 1) then
        local npcLevel = GetNpcLevel(npcindex)
        local diffLevel = GetPlayerExtLevel() - npcLevel
        local r = random(1, 100)
        if (diffLevel <= 0) then
            if (r <= 15) then
                AddIBBuff(536)                --???
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
----------Add by Gaojingwei at 2009/3/3  Ë«Éú±Ë°¶ end---------------

--ÏÉÄ§ÉùÍûÈÎÎñ
function jeCreditTask()
    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    if (nType == 1) then

        local nRand = random(1, 100)
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
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (" .. nCount .. "/ 5 )")

            if (nRand > 50) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Tiªn), cÇn cã 5 m¶nh míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")
            end

        end

    elseif (nType == 2) then

        local nRand = random(1, 100)
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
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/ 5 )")

            if (nRand > 50) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end

        end

    end

end

-- Added by zhaoqingsong at 2009-3-11 Begin
-- ·¨Æ÷¿ª¹â£¬Áé¹âÕ§ÏÖ

Task_SpiritRay = 1338 -- Áé¹âÕ§ÏÖ 1byte ÈÎÎñ×´Ì¬£»2byte ÌìµØÈËÈı»êÖé»ñµÃ±êÖ¾
F11_SpiritRay = 1030   -- Áé¹âÕ§ÏÖF11

Bead_Obtain_Idx = 1

Bead_Obtain = {
    { name = "Ninh Miªu", obtainBit = 8 + 1, total = 40, ratio = 1, gen = { 4, 215, 0, 0, 0, 0 }, item = "<c=yel>Nh©n Hån Ch©u<c>" },
    { name = "Phong Yªu", obtainBit = 8 + 2, total = 20, ratio = 1, gen = { 4, 216, 0, 0, 0, 0 }, item = "<c=yel>§Şa Hån Ch©u<c>" },
    { name = "Sãi", obtainBit = 8 + 3, total = 8, ratio = 1, gen = { 4, 217, 0, 0, 0, 0 }, item = "<c=yel>Thiªn Hån Ch©u<c>" },
}

function processSpiritRay(npcindex)
    local taskStatus = GetTaskByte(Task_SpiritRay, 1)
    local obtainFlag = GetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit)
    if (taskStatus ~= 1 or obtainFlag == 1) then
        return
    end
    local rand = random(1, Bead_Obtain[Bead_Obtain_Idx].total)
    if (rand <= Bead_Obtain[Bead_Obtain_Idx].ratio) then
        SetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit, 1)
        local obtainTotal = GetTaskByte(Task_SpiritRay, 2)
        TaskNote(F11_SpiritRay, obtainTotal)
        local p1, p2, p3, p4, p5, p6 = myunpack(Bead_Obtain[Bead_Obtain_Idx].gen)
        AddNormalItem(p1, p2, p3, p4, p5, p6)
        TopMessage("NhËn ®­îc" .. Bead_Obtain[Bead_Obtain_Idx].item .. "!")
        Msg2Player("NhËn ®­îc 1 viªn" .. Bead_Obtain[Bead_Obtain_Idx].item .. ".")
    end
end

-- ·µ»ØÊı×éµÄËùÓĞÔªËØ,×Ô¶¨Òåº¯Êı
function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

-- Added by zhaoqingsong at 2009-3-11 end
