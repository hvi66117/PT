--¹ùÈº£»2009/11/26£»Êé»ê : boss of ÒÂ²§Ïà´«
Task_Partner = 1657
Task_YiboProcess = 1658 -- 1Byte:1Ñ°ÕÒÊ¦¾­ÉÏÏÂÆª 2ÕÒµ½Ê¦¾­ÉÏÏÂÆª 3ÒÑ°ÑÊé½»¸øÁË»ÆÌì»¯ 4½Óµ½ÁÔÉ±Êé»êÈÎÎñ 5Êé»êÒÑ¾­ÊÍ·Å 6ÁÔÉ±³É¹¦ 7ÈÎÎñÍê³É 8ÈÎÎñÊ§°Ü
-- 2Byte:Ê¦¾­ÀàĞÍ/°çÑİ½ÇÉ« 1ÉÏÆª(Ê¦) 2ÏÂÆª(Í½)
-- 3Byte:1µ±Íæ¼Òµ½ÁË¿ªÆôËÄ¼¶Ê¦ÃÅÈÎÎñÌõ¼şÊ±£¬ÒÑ¾­¸øÍæ¼Ò·¢ÁËÌáĞÑÓÊ¼ş
Hunt_Buff = 1243      --´Ëbuff´æÔÚÊ±¼äÍ¬¹ÖÎï´æÔÚÊ±¼äÏàÍ¬ ,buffÏûÊ§ÒÔºó£¬ÔòÈÎÎñÊ§°Ü
Debuff_ID = 1244

ShiJing = { name = "D©y Khæn Tiªn", Item = { 6, 1, 792, 0, 0, 0 } }

function OnDeath(npcidx)
    local nameID = GetPlayerID()

    if (nameID == GetNpcTask(npcidx, 1) or nameID == GetNpcTask(npcidx, 2)) then
        --²é¿´¹ÖÎï°ó¶¨µÄÈËÎïÊÇ·ñÆ¥Åä
        --²é¿´¶ÓÓÑµÄÉíÉÏ°ó¶¨µÄ¹ÖÎïÊÇ·ñÊÇµ±Ç°ÕâÖ»£¬ÒÔ¼°¶ÓÎéµÄÇé¿ö
        local teamState = Get_TeamState(npcidx)
        if (teamState == 2) then
            Fail_Notice2Player(npcidx)
        elseif (teamState == 3) then
            Msg2Player("NhiÖm vô thÊt b¹i, lóc tiªu diÖt ®­îc qu¸i vËt ®éi ngò kh«ng ®óng yªu cÇu!")
            SetTaskByte(Task_YiboProcess, 1, 8)
            Talk(1, "no", "Th­ Hån: §ång ®éi cña ng­¬i ®· hñy nhiÖm vô, nÕu ng­¬i vÉn muèn tiÕp tôc thùc hiÖn, xin hñy ®i sau ®ã nhËn l¹i!")
        elseif (teamState == 4) then
            Msg2Player("Th­ Hån: Ph¶i cã ng­êi ®· cïng ng­¬i nhËn nhiÖm vô lÇn tr­íc ®Õn, míi cã thÓ tiÕp tôc tiÕn hµnh!")
            Fail_Notice2Player(npcidx)
            return
        elseif (teamState == 1) then
            Msg2Player("Chóc mõng b¹n tiªu diÖt thµnh c«ng Th­ Hån!")
            RemoveIBBuff(Debuff_ID)
            RemoveIBBuff(Hunt_Buff)
            SetTaskByte(Task_YiboProcess, 1, 6)
            local item = ShiJing.Item
            ClearItem(item[1], item[2], item[3], item[4])
            TaskNote(1515, 3)
            local n = Get_MatePlayerIndex()
            local self = PlayerIndex
            PlayerIndex = n
            item = ShiJing.Item
            ClearItem(item[1], item[2], item[3], item[4])

            Msg2Player("Chóc mõng b¹n tiªu diÖt thµnh c«ng Th­ Hån!")
            RemoveIBBuff(Debuff_ID)
            RemoveIBBuff(Hunt_Buff)
            SetTaskByte(Task_YiboProcess, 1, 6)
            TaskNote(1515, 3)
        end
    else
        local PlayerIndex1 = SearchPlayerById(GetNpcTask(npcidx, 1))
        local PlayerIndex2 = SearchPlayerById(GetNpcTask(npcidx, 2))

        if (PlayerIndex1 > 0) then
            PlayerIndex = PlayerIndex1
            Msg2Player("Th­ Hån ®· bŞ ng­êi kh¸c tiªu diÖt, nhiÖm vô thÊt b¹i, xin ®i gÆp Hoµng Thiªn Hãa hñy nhiÖm vô!")
            Task_Fail()
        end

        if (PlayerIndex2 > 0) then
            PlayerIndex = PlayerIndex2
            Msg2Player("Th­ Hån ®· bŞ ng­êi kh¸c tiªu diÖt, nhiÖm vô thÊt b¹i, xin ®i gÆp Hoµng Thiªn Hãa hñy nhiÖm vô!")
            Task_Fail()
        end

    end
    DelNpc(npcidx)
end

function SetMateTaskByte(task, byte, value)
    local n = 0
    local self = PlayerIndex
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end
    PlayerIndex = n
    SetTaskByte(task, byte, value)
    PlayerIndex = self
end

function Get_TeamState(npcidx)
    --·µ»ØÖµ£º1OK 2×é¶ÓÈËÊı²»¶Ô 3¶ÓÓÑ·ÅÆúÁËÈÎÎñ 4Á½ÈË¶ÓÎéÈË²»¶Ô
    if (GetTeamSize() ~= 2) then
        return 2
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) == Get_MateUUID()) then
        -- ¶Ô·½ÒÑ¾­·ÅÆúÈÎÎñ
        return 3
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) ~= Get_MateUUID()) then
        -- ´íÎóµÄÁ½¸öÈË×é¶Ó
        return 4
    end
    return 1
end

function Fail_Notice2Player(npcIdx)
    local PlayerIndex1 = SearchPlayerById(GetNpcTask(npcIdx, 1))
    local PlayerIndex2 = SearchPlayerById(GetNpcTask(npcIdx, 2))

    if (PlayerIndex1 > 0) then
        PlayerIndex = PlayerIndex1
        Task_Fail()
        Msg2Player("NhiÖm vô thÊt b¹i, lóc tiªu diÖt ®­îc qu¸i vËt ®éi ngò kh«ng ®óng yªu cÇu!")
    end

    if (PlayerIndex2 > 0) then
        PlayerIndex = PlayerIndex2
        Task_Fail()
        Msg2Player("NhiÖm vô thÊt b¹i, lóc tiªu diÖt ®­îc qu¸i vËt ®éi ngò kh«ng ®óng yªu cÇu!")
    end
end

function Get_MateUUID()
    --»ñµÃ¶ÔÓĞµÄUUID¡£µ÷ÓÃÇ°±ØĞëÏÈÅĞ¶ÏÊÇ²»ÊÇÁ½ÈË¶ÓÎé
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    PlayerIndex = mateIdx
    local mateUUID = GetPlayerID()
    PlayerIndex = selfIdx
    return mateUUID
end

function Get_MatePlayerIndex()
    --»ñµÃ¶ÓÓÑµÄPlayerIndex£¬±ØĞëÊÇÁ½ÈË¶ÓÎé²Å¿ÉÒÔ
    local prindex = 0
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    return prindex
end

function Task_Fail()
    TaskNote(1515, 4)
    SetTaskByte(Task_YiboProcess, 1, 8)
    RemoveIBBuff(Hunt_Buff)
    local item = ShiJing.Item
    ClearItem(item[1], item[2], item[3], item[4])
end

function no()
    CloseDialog()
end

