--¹ùÈº£»2009/12/01£»À¦ÏÉÉş event item for ÒÂ²§Ïà´«

Task_Partner = 1657 -- ÈÎÎñ´îµµNameID
Task_YiboProcess = 1658 -- 1Byte:1Ñ°ÕÒÊ¦¾­ÉÏÏÂÆª 2ÕÒµ½Ê¦¾­ÉÏÏÂÆª 3ÒÑ°ÑÊé½»¸øÁË»ÆÌì»¯ 4
-- 2Byte:Ê¦¾­ÀàĞÍ/°çÑİ½ÇÉ« 1ÉÏÆª(Ê¦) 2ÏÂÆª(Í½)
-- 3Byte:1µ±Íæ¼Òµ½ÁË¿ªÆôËÄ¼¶Ê¦ÃÅÈÎÎñÌõ¼şÊ±£¬ÒÑ¾­¸øÍæ¼Ò·¢ÁËÌáĞÑÓÊ¼ş
Debuff_ID = 1244  -- Debuff µÄ ID

function main()
    if (GetTaskByte(Task_YiboProcess, 1) == 5) then
        local teamState = Get_TeamState()
        if (teamState == 1) then
            TeamAction("Remove_Debuff_T", 0, 0, 0)
        else
            if (HaveIBBuff(Debuff_ID) > 0) then
                RemoveIBBuff(Debuff_ID)
                Msg2Player("D©y Khæn Tiªn ph¸t ra mét luång Kim quang, triÖt tiªu o¸n khİ Th­ Hån!")
            end
        end
    else
        Msg2Player("Tr¹ng th¸i hiÖn t¹i kh«ng thÓ dïng D©y Khæn Tiªn!")
    end

end

function Remove_Debuff_T()
    if (HaveIBBuff(Debuff_ID) > 0) then
        RemoveIBBuff(Debuff_ID)
        Msg2Player("D©y Khæn Tiªn ph¸t ra mét luång Kim quang, triÖt tiªu o¸n khİ Th­ Hån!")
    end
end

function Get_TeamState()
    --·µ»ØÖµ£º1OK 2×é¶ÓÈËÊı²»¶Ô 3¶ÓÓÑ·ÅÆúÁËÈÎÎñ 4Á½ÈË¶ÓÎéÈË²»¶Ô 5:Á½ÈË²»ÔÚÒ»ÕÅµØÍ¼
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

    local selfIdx = PlayerIndex
    local mateIdx = Get_MatePlayerIndex()
    local mapid1, x1, y1 = GetWorldPos()
    PlayerIndex = mateIdx
    local mapid2, x2, y2 = GetWorldPos()
    PlayerIndex = selfIdx

    if (mapid1 ~= mapid2) then
        return 5
    end

    return 1
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

function no()
    CloseDialog()
end

