TASK_JIANGSHAN = 1426
TASK_JIANGSHAN_PAGE5_STATUS = 1438        --µÚ5Ò³×´Ì¬   µÚÈı¸ö×Ö½Ú ÈÎÎñ½á¹û±äÁ¿ µÚ¶ş¸ö×Ö½Ú µ±Ç°ÈÎÎñ×öµ½ÄÄ²½»òÕßÄÄ²½ÒÑ¾­Íê³É
TASK_INFO_JIANGSHAN_PAGE5 = 1058        --ÈÎÎñÌáÊ¾
Task_Info_JIANGSHAN_IDOLUM = 1055

function OnDeath(npcidx)
    SetGlobalValue(107, -1)
    local i = GetName()
    AddGlobalCountNews("<color=green>" .. i .. "<c> mét ®ao kÕt liÔu <c=g>§¹i §iªu<c>, Bİch Du cung l¹i ®­îc h­ëng thanh b×nh.", 20)
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

    ---------------------------------------------------------------------------------
    --added by huyuzhang 090505
    if (GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4) == 101 and
            GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3) == 1 and
            --GetTeam() == 0 -- ) then
            --and
            HaveIBBuff(663) > 0) then
        -- »÷É±ÊÇ·ñÒÀÀµBUFF? ÏŞÖÆÖ»ÓĞµ¥ÈË²ÅÄÜÍê³ÉÈÎÎñ

        RemoveIBBuff(663)
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3, 2)                --ÉèÖÃ»÷É±±êÖ¾Î»
        SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4, 16)

        TopMessage("B¹n tiªu diÖt thµnh c«ng <c=g>§¹i §iªu<c>")
        Msg2Player("B¹n tiªu diÖt thµnh c«ng §¹i §iªu")
        FinishNpcCollection(30)
        TopMessage("<c=g>nhiÖm vô hoµn thµnh<c>")

        TaskNote(Task_Info_JIANGSHAN_IDOLUM, 15)

    end

    --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
    Throw_Equip(npcidx, PlayerIndex)
    --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end
    DelNpc(npcidx)
end;

TASK_today = 886
task_id = 866
item_id = 170
type_id = 15
item_name = "§Çu §¹i §iªu"

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
            ---- modified by yaoxin at 2009-08-13
            local today = floor(LocalSystemTime() / 86400)
            ---- modified by yaoxin at 2009-08-13
            if (today == GetTask(TASK_today)) then
                if (type2 == 0) and (count2 >= 3) then
                    --3==3¼¶,4==4¼¶
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
                Msg2Player("NhiÖm vô Lİnh ®¸nh thuª ®· hÕt h¹n")
            end
        end
    end
end

--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 2 --ÅÌ¹Å¡¢´óÅô¡¢Ñîê¯
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do
        --¹Ì¶¨ÂÖÑ¯
        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)

        --Ëæ»úÂÖÑ¯
        if (random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bŞ cam cao cÊp: rít trang bŞ tr¾ng" .. nFlag .. ",npcID: §¹i Bµng")
end
--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end