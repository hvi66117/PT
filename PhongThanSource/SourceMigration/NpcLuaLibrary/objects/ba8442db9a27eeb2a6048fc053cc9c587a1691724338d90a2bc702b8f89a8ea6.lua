--description: ÕøÂ\-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/8/2

JECT_TASK_STATE = 1291 -- byte1:type byte2:state
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý

--ÌìÔÀÑÖÂÞ
yanluo_renwu = 1333 --ÈÎÎñ²½Öè(1½Ó,2É±ËÀÇÕÔ­,3É±ËÀÀëÖì,»ØÈ¥ÁìÈÎÎñ,4ÕÒÆë5¸ö¿ªÆô·¨Õó,½øÈëÕó,100Íê³É)

function OnDeath(npcindex)

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 6) then
        jeCreditTask()--ÏÉÄ§ÉùÍûÈÎÎñ
    end

    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end ;

    local pextlvl = GetPlayerExtLevel()
    if (pextlvl >= 26) and (GetTask(yanluo_renwu) == 1) then
        renwu26(npcindex)--ÌìÔÀÑÖÂÞ
    end
end;

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

function renwu26(npcindex)
    --ÌìÔÀÑÖÂÞ
    if (GetJusticEvilCredit() >= 0) then
        Msg2Player("Theo lêi Hé Ph¸p nãi, Ph¸p b¶o bÞ Ma Kh©m Nguyªn c­íp ®i, ®¸nh b¹i Tiªn Kh©m Nguyªn còng v« dông!")
        return 0
    end

    local r = random(1, 100)
    if (r <= 3) then
        SetTask(yanluo_renwu, 2)
        Msg2Player("®Õn <HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73,254,211]\"> t×m Tiªn Ly Ch©u")
        TaskNote(95, 1)
        NpcSay(npcindex, "Anh hïng, xin tha m¹ng! Tö V©n Sa ®ã t«i ®· hiÕn cho Tiªn Ly Ch©u råi…")
    end
end