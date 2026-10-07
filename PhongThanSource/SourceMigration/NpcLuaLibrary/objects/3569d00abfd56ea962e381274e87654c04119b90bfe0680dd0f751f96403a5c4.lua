--description: ÕøÂ\-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/8/2


--TaskYouChong	ÓÈ³æ¸½Ìå
TaskYouChong = 1288
task_gather = 1289   --Ë«Éú±Ë°¶µÄÈÎÎñ±äÁ¿,1byte:ÊÇ·ñ½ÓÊÜÈÎÎñ£»2byte£ºÒÑÁìÈ¡µÄÈÎÎñ´ÎÊı£»3byte£ºÒÑ²É¼¯µ½µÄÂüÍÓÂŞ»ªµÄ¸öÊı

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàĞÍ(Ç¬1,¶Ò2,Àë3,Õğ4,Ùã5,¿²6,ôŞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåĞÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ĞèÉ±(ÊÕ)¸öÊı 2byte Êµ¼Ê¸öÊı

JECT_TASK_STATE = 1291 -- byte1:type byte2:state
NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

function OnDeath(npcindex)

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 1) then
        jeCreditTask()--ÏÉÄ§ÉùÍûÈÎÎñ
    end

    Kill()
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

    if (GetTaskByte(gua8_renwu, 4) <= 2 or GetTaskByte(gua8_renwu, 4) == 6) and (GetTaskByte(gua8_renwu, 3) == 2) then
        eightgua()--°ËØÔÂÖ»Ø
    end
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
function Kill()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    if (lTaskCtrl ~= 1) then
        return 0
    end

    local w, x, y = GetWorldPos()
    local newnpcidx = AddNpc(808, 10, SubWorld, x * 32, y * 32)
    SetTask(TaskYouChong, SetByte(GetTask(TaskYouChong), 4, 5))
end

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

function eightgua()
    --°ËØÔÂÖ»Ø
    if (GetTaskByte(gua8_renwu, 3) ~= 2) then
        return 0
    end

    if (GetTaskByte(gua8_renwu, 4) == 2) then
        local rn = random(1, 100)
        if (rn <= 20) then
            AddIBBuff(542)
            ScrollMessage("B¹n nhËn ®­îc <c=g>HÊp hån chó<c>")
        end
    elseif (GetTaskByte(gua8_renwu, 4) == 1) then
    elseif (GetTaskByte(gua8_renwu, 4) == 6) then
    end
end