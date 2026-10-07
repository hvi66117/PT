--¹ùÈº£»2009-12-16£»ÒÂ²§Ïà´«£¬Npc Timer

Task_Partner = 1657
Task_YiboProcess = 1658 -- 1Byte:1Ñ°ÕÒÊ¦¾­ÉÏÏÂÆª 2ÕÒµ½Ê¦¾­ÉÏÏÂÆª 3ÒÑ°ÑÊé½»¸øÁË»ÆÌì»¯ 4½Óµ½ÁÔÉ±Êé»êÈÎÎñ 5Êé»êÒÑ¾­ÊÍ·Å 6ÁÔÉ±³É¹¦ 7ÈÎÎñÍê³É 8ÈÎÎñÊ§°Ü
-- 2Byte:Ê¦¾­ÀàÐÍ/°çÑÝ½ÇÉ« 1ÉÏÆª(Ê¦) 2ÏÂÆª(Í½)
-- 3Byte:1µ±Íæ¼Òµ½ÁË¿ªÆôËÄ¼¶Ê¦ÃÅÈÎÎñÌõ¼þÊ±£¬ÒÑ¾­¸øÍæ¼Ò·¢ÁËÌáÐÑÓÊ¼þ
Debuff_ID = 1244
Hunt_Buff = 1243      --´Ëbuff´æÔÚÊ±¼äÍ¬¹ÖÎï´æÔÚÊ±¼äÏàÍ¬ ,buffÏûÊ§ÒÔºó£¬ÔòÈÎÎñÊ§°Ü
KunXian = { name = "D©y Khæn Tiªn", Item = { 6, 1, 792, 0, 0, 0 } }

function OnTimer(npcidx)
    local id, x, y = GetNpcWorldPos(npcidx)
    local nTimes = GetNpcTask(npcidx, 5)

    if (nTimes == 2) then
        DelNpcTimer(npcidx)
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾³ýÊé»ê.lua", 60)
    end

    SetNpcTask(npcidx, 5, nTimes + 1)

    local PlayerIndex1 = SearchPlayerById(GetNpcTask(npcidx, 1))
    local PlayerIndex2 = SearchPlayerById(GetNpcTask(npcidx, 2))

    if (PlayerIndex1 > 0) then
        PlayerIndex = PlayerIndex1
        if (HaveIBBuff(Hunt_Buff) > 0) then
            RemoveIBBuff(Debuff_ID)
            AddIBBuff(Debuff_ID)  --Ìí¼Ó¼õËÙbuff
            Msg2Player("Th­ Hån ®· t¨ng Debuff lªn b¹n! Trong tr¹ng th¸i tæ ®éi, mét ng­êi ch¬i kh¸c cã thÓ dïng D©y Khæn Tiªn gióp b¹n gi¶i trõ tr¹ng th¸i Debuff hiÖn t¹i!")
        end
    end

    if (PlayerIndex2 > 0) then
        PlayerIndex = PlayerIndex2
        if (HaveIBBuff(Hunt_Buff) > 0) then
            RemoveIBBuff(Debuff_ID)
            AddIBBuff(Debuff_ID)  --Ìí¼Ó¼õËÙbuff
            Msg2Player("Th­ Hån l¹i t¨ng Debuff lªn b¹n! Trong tr¹ng th¸i tæ ®éi, b¹n cã thÓ dïng D©y Khæn Tiªn ®Ó gi¶i trõ tr¹ng th¸i Debuff hiÖn t¹i!")
        end
    end
end
