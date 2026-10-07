--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin
YIBO_TIME = 1659 -- 1Word:´´½¨ÒÂ²§¹ØÏµÊ±µÄÊ±¼ä£¨ÌìÊý£©
-- 2Word:ÅÑÀëÊ¦ÃÅµÄÊ±¼ä£¨ÌìÊý£©
YIBO_80_DESASTER_STATE = 1661  -- 1Byte:ÈÎÎñÇé¿ö 1¡¢ÒÑ¾­½ÓÈÎÎñ  2¡¢Íê³É  3¡¢Ê§°Ü
-- 2Byte:ÁÔÉ±¶ÔÏó 1ÇîÆæ 2—ƒè» 3÷Ò÷Ñ 4»ìãç
-- 3Byte:½ÇÉ« 1Ê¦¸¸ 2Í½µÜ£¨×ö´Ë±ê¼ÇµÄÔ­ÒòÊÇ£¬ÔÚÍê³ÉÈÎÎñÒÔºó£¬Èç¹û½Ó´¥Ê¦Í½¹ØÏµ£¬¿ÉÒÔÒÀÈ»ÁìÈ¡½±Àø£©
-- 4Byte:ÒÑÊÕµ½ÓÊ¼þÌáÐÑ
SEVEN_DAY_BUFF = 1239
--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 End

function OnDeath(npcidx)
    if (GetGlobalValue(152) > 0) then
        DelNpc(GetGlobalValue(152))
        SetGlobalValue(152, 0)
    end

    --Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin
    Check_ShituExist(npcidx)
    --Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 End

    SetGlobalValue(102, -1)
    DelNpc(npcidx)
    AddNormalItem(3, 120, 0, 0, 0, 1)
    Msg2Player("B¹n nhËn ®­îc Hçn §én!")
    local i = GetName()
    local j = GetLevel()
    if (j <= 90) then
        AddGlobalCountNews("Dòng sÜ <c=g>" .. i .. "<c>1 kiÕm h¹ gôc <c=g>ThiÕt Bè<c>, nh©n gian l¹i ®­îc h­ëng sù thanh b×nh.", 20)
    else
    end ;
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    if (GetTeam() ~= 0) then
        -- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- ¹M¾ú¶¤¤¤¶¤­û
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            city_shouji(w)
        end
        PlayerIndex = oldPlayer
    else
        -- µL¶¤¥î
        city_shouji(w)
    end ;
end;

TASK_today = 886
task_id = 864
item_id = 167
type_id = 12
item_name = "§Çu ThiÕt Bè"

function city_shouji(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(task_id)
        local type1 = GetByte(task_val, 1)
        local count1 = GetByte(task_val, 2)
        local type2 = GetByte(task_val, 3)
        local count2 = GetByte(task_val, 4)

        local item_count = IsExistItem(4, item_id, 0, 1)
        if (type1 == type_id) then
            local today = floor(LocalSystemTime() / 86400)
            if (today == GetTask(TASK_today)) then
                if (type2 == 0) and (count2 == 3) then
                    AddNormalItem(4, item_id, 0, 0, 0, 0)
                    item_count = item_count + 1

                    if (item_count < count1) then
                        Msg2Player("Cßn ph¶i thu thËp" .. item_name .. (count1 - item_count) .. ".")
                    else
                        Msg2Player("Thu thËp ®ñ" .. item_name .. ".")
                    end
                    SetTask(task_id, SetByte(task_val, 4, 0))
                else
                    Msg2Player("H«m nay ®· giao cho ng­¬i" .. item_name .. ", ng­¬i ph¶i tiÕp tôc giao nép råi nhËn l¹i míi cã thÓ nhËn ®­îc")
                end
            else
                Msg2Player("NhiÖm vô LÝnh ®¸nh thuª ®· hÕt h¹n")
            end
        end
    end
end

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin
function Check_ShituExist(npcidx)
    -- ±éÀúËùÔÚ¶ÓÎéµÄÍæ¼Ò£¬ÅÐ¶ÏÄ³Íæ¼ÒÊÇ·ñÔÚ¶ÓÎéÖÐ
    local nSize = GetTeamSize()
    if (nSize > 0) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(YIBO_80_DESASTER_STATE, 2) == 1) then
                if (IsMantlePrentice(PlayerIndex) > 0 and IsPlayerInDeath() == 0) then
                    --Èç¹ûÍæ¼ÒÊÇÒÂ²§µÜ×Ó£¬Ôò²éÕÒÊ¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖÐ
                    local masterIdx = Check_MasterIdx()
                    if (masterIdx > 0) then
                        local bDis = Check_Distance(PlayerIndex, masterIdx, npcidx)
                        if (bDis > 0) then
                            --Ê¦Í½¶¼ÔÚ¶ÓÎéÖÐ£¬²¢ÇÒ¾àÀë²»³¬¹ý2ÆÁ
                            if (HaveIBBuff(SEVEN_DAY_BUFF) == 0 and GetTaskByte(YIBO_80_DESASTER_STATE, 1) == 1) then
                                Msg2Player("B¹n kh«ng hoµn thµnh §é KiÕp trong thêi gian h¹n ®Þnh!")
                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 3)
                            else
                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 2)
                                SetTaskWord(YIBO_TIME, 1, 0)
                                RemoveIBBuff(SEVEN_DAY_BUFF)
                                Msg2Player("Chóc mõng b¹n ®· v­ît qua ®­îc kiÕp n¹n, h·y vÒ phôc mÖnh ThÇy t­íng sè!")
                                TaskNote(1516, 1)
                                PlayerIndex = masterIdx
                                SetTaskWord(YIBO_TIME, 1, 0)
                                SetTaskByte(YIBO_80_DESASTER_STATE, 1, 2)
                                Msg2Player("Chóc mõng b¹n ®· hç trî ®å ®Ö v­ît qua ®­îc kiÕp n¹n, h·y vÒ phôc mÖnh ThÇy t­íng sè!")
                            end
                        else
                            PlayerIndex = masterIdx
                            Msg2Player("B¹n vµ Y B¸t ®Ö tö cña b¹n c¸ch nhau qu¸ xa, kh«ng thÓ gióp ®Ö tö §é KiÕp!")
                            PlayerIndex = GetTeamMember(i)
                            Msg2Player("B¹n vµ Y B¸t S­ Phô cña m×nh c¸ch nhau qu¸ xa, kh«ng thÓ hoµn thµnh §é KiÕp!")
                        end
                    end
                end
            end
        end
    end
    return 0
end

function Check_MasterIdx()
    --±éÀú¶ÓÎé£¬Ñ°ÕÒÊ¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖÐ(ÕâÀïÐèÒª½Ó¿Ú) ÕâÀï²é¿´ Ê¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖÐ
    local nSize = GetTeamSize()
    local strMasterName = GetMantleMasterName()
    local selfIdx = PlayerIndex
    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if (strMasterName == GetName()) then
            PlayerIndex = selfIdx
            return GetTeamMember(i)
        end
    end
    return 0
end

function Check_Distance(playerIdx1, playerIdx2, npcidx)
    --·µ»ØÖµËµÃ÷£º1 ¾àÀëÕýÈ· 0¾àÀë´íÎó
    local nMapid, nX, nY = GetNpcWorldPos(npcidx)
    local selfIdx = PlayerIndex
    PlayerIndex = playerIdx1
    local pMapid1, pX1, pY1 = GetWorldPos()
    PlayerIndex = playerIdx2
    local pMapid2, pX2, pY2 = GetWorldPos()
    PlayerIndex = selfIdx
    if (pMapid1 == nMapid and pMapid2 == nMapid) then
        if (((nX - pX1) ^ 2 + (nY - pY1) ^ 2) < 500) and (((nX - pX2) ^ 2 + (nY - pY2) ^ 2) < 1000) then
            return 1
        end
    end
    return 0
end


--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 End
