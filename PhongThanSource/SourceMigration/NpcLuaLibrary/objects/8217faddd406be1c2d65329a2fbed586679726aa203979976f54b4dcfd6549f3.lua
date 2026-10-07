--description: »Æ½ğÎäÂŞÉñ
--author: gongpeng
--date: 2009.05.07

-- 1Byte 0Î´½øĞĞ¾íÒ»£»1 ¾íÒ»Íê³É£»2 ¾í¶şÍê³É£»3 ¾íÈıÍê³É
-- 2Byte 0³õÊ¼£»1 »ÃÏó1Íê³É£»2 »ÃÏó2Íê³É£»...ÒÀ´ÎÀàÍÆ
TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433 -- 1Byte:¼ÆÊı; 2Byte:×´Ì¬; 3Byte: ÊÇ·ñÍê³Éµ±Ç°µÄ»ÃÏë; 4Byte: »ÃÏóÎ»ÖÃµÄË÷Òı

function OnDeath(npcindex)
    local idx = GetNpcTask(npcindex, 0)
    local npcid = GetNpcTask(npcindex, 1)

    if (npcid == GetNpcID(idx)) then
        Msg2Player("Hoµng Kim Th¹ch ThÇn bŞ b¹n tiªu diÖt, Lam B¸ ®· ch¹y tho¸t!")
        DelNpc(idx)
    end

    DelNpc(npcindex)
end
