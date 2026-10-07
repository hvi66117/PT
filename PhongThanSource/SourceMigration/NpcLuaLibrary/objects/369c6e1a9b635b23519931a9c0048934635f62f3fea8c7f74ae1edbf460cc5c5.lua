--description: ÁéÊ¯£¨4¡¢9·½Î»£©
--author: liuzhiqiang
--date: 2009/04/15

--ºÓÍ¼»Ã¾³
Task_hetu = 1387 -- 1byte: 1:ÒÑ½ÓºÓÍ¼ÈÎÎñ; 2£ºÒÑÍê³ÉÁéÊ¯12µÄÈÎÎñ 3:ÒÑÍê³ÉÁéÊ¯34µÄÈÎÎñ 4£ºÒÑÍê³ÉÁéÊ¯67µÄÈÎÎñ 5£ºÒÑÍê³ÉÁéÊ¯89µÄÈÎÎñ 6£ºÍê³ÉºÓÍ¼»Ã¾³
-- 2byte: 1:¼ÇÂ¼½ÓÈÎÎñÊ±µÄ¶Ó³¤£»
-- 3byte: 1:ÒÑÉ±ËÀÁúÂí£¬³öÏÖ¹ıIBBuff
-- 4byte: 1:ÒÑºÍÁéÊ¯¶Ô¹ı»°£¬³öÏÖ¹ıIBBuff
Hetu_playerID = 1388
Global_longmamu = 187
Global_longmajin = 188

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local tasks = {
        { "TriÖu gäi Long M·", "zhaohuan"; show = 0 },
    }

    if (GetTaskByte(Task_hetu, 1) == 2 and GetTeam() ~= 0 and GetTeamSize() == 2 and checkRelation() == 1 and GetTaskByte(Task_hetu, 2) ~= 1) then
        tasks[1].show = 1
    end

    if (GetTaskByte(Task_hetu, 1) == 4 and GetTeam() ~= 0 and GetTeamSize() == 2 and checkRelation() == 1 and GetTaskByte(Task_hetu, 2) == 1) then
        tasks[1].show = 1
    end

    SayTask("Linh Th¹c chíp nho¸ng hµo quang, bÒ mÆt nh­ cã nh÷ng v¨n tù bÊt minh.", tasks)
end

function checkRelation()
    --ÅĞ¶Ï¶ÓÓÑÊÇ·ñÊÇ½ÓÈÎÎñÊ±¶ÓÓÑ
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID() --»ñµÃ¶ÓÓÑID
    PlayerIndex = oldPlayer
    if (GetTask(Hetu_playerID) == playerID_temp) then
        --ÅĞ¶Ï¶ÓÓÑÊÇ·ñÊÇ½ÓÈÎÎñÊ±¶ÓÓÑ
        return 1
    end
    return 0
end

function getduiyouID()
    --»ñµÃ¶ÓÓÑµÄID
    local oldPlayer = PlayerIndex
    local playertmp = 0
    if (IsCaptain() == 0) then
        playertmp = GetTeamMember(1)
    else
        playertmp = GetTeamMember(2)
    end
    PlayerIndex = playertmp
    local playerID_temp = GetPlayerID() --»ñµÃ¶ÓÓÑID
    PlayerIndex = oldPlayer
    return playerID_temp
end

function zhaohuan()

    CloseDialog()

    if (GetTaskByte(Task_hetu, 1) == 2) then
        if (GetTaskByte(Task_hetu, 2) == 1) then
            --Óë´ËÁéÊ¯¶Ô»°Õß±ØĞëÊÇ½ÓÈÎÎñÊ±µÄ¶ÓÓÑ
            Talk(1, "no", "Mêi ®éi viªn lóc nhËn nhiÖm vô qua ®©y")
            return
        end
    elseif (GetTaskByte(Task_hetu, 1) == 4) then
        if (GetTaskByte(Task_hetu, 2) ~= 1) then
            --Óë´ËÁéÊ¯¶Ô»°Õß±ØĞëÊÇ½ÓÈÎÎñÊ±µÄ¶Ó³¤
            Talk(1, "no", "Mêi ®éi tr­ëng lóc nhËn nhiÖm vô qua ®©y")
            return
        end
    end

    if (GetTeamSize() ~= 2 or checkRelation() ~= 1) then
        --±ØĞëÊÇ×é¶ÓÇÒ½ÓÈÎÎñÊ±µÄÁ½¸öÈË
        Talk(1, "no", GetName() .. " kh«ng cã ph¶n øng, xem ra chØ cã thÓ lµ ®ång ®éi cïng nhËn nhiÖm vô ®­îc.")
        return
    end

    --ÅĞ¶Ïµ±Ç°ÊÇ·ñÒÑÓĞÁúÂí³öÏÖ£¬²¢·ÖÎöÊÇ·ñµ±Ç°Íæ¼ÒËùÕÙ»½µÄÁúÂí
    local nMapNpcIndex1 = GetGlobalValue(Global_longmamu)
    local nMapNpcIndex2 = GetGlobalValue(Global_longmajin)
    if (nMapNpcIndex1 ~= 0 or nMapNpcIndex2 ~= 0) then
        if (GetNpcTask(nMapNpcIndex1, 1) ~= getduiyouID() and GetNpcTask(nMapNpcIndex2, 1) ~= GetPlayerID()) then
            Talk(1, "no", GetName() .. "Long M· trong linh th¹ch ®· bŞ ng­êi kh¸c th¶ ra, t¹m thêi kh«ng thÓ triÖu gäi n÷a.")
        elseif (GetNpcTask(nMapNpcIndex1, 1) ~= getduiyouID() or GetNpcTask(nMapNpcIndex2, 1) ~= GetPlayerID()) then
            Talk(1, "no", GetName() .. "Long M· trong linh th¹ch chØ cã thÓ triÖu gäi thµnh ®«i, hiÖn cã 1 con cßn tån l¹i, t¹m thêi kh«ng thÓ triÖu gäi.")
        else
            TopMessage("<c=g>Long M·<c> ®· xuÊt hiÖn.")
        end
        return
    end

    if (HaveIBBuff(643) > 0) then
        --ÒÑÔÚ¼ÆÊ±Çé¿ö

        -- ¼ì²éÊÇ·ñµã»÷¹ı
        if (GetTaskByte(Task_hetu, 4) == 0) then
            --¶ÓÓÑÏÈºÍÁéÊ¯½øĞĞµÄ¶Ô»°
            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                RemoveIBBuff(643)
                TopMessage("<c=g>Long M·<c> ®· xuÊt hiÖn.")
                SetTaskByte(Task_hetu, 4, 0)
                SetTaskByte(Task_hetu, 3, 0)
                --				TaskNote(1037, 2)
            end
            PlayerIndex = oldPlayer
            longma()
        else
            --×Ô¼ºÏÈºÍÁéÊ¯½øĞĞµÄ¶Ô»°
            ScrollMessage("§îi ®éi viªn khëi ®éng")
        end

    elseif (HaveIBBuff(643) == 0) then
        --Ã»ÓĞ¼ÆÊ±Çé¿ö

        if (GetTaskByte(Task_hetu, 4) == 0) then
            --Ã»ÓĞÈÎºÎÈËºÍÁéÊ¯¶Ô¹ı»°
            SetTaskByte(Task_hetu, 4, 1)
            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                AddIBBuff(643)
                TopMessage("Nghi thøc triÖu gäi Long M· ®· khëi ®éng")
            end
            PlayerIndex = oldPlayer
        end
    end
end

function longma()

    CloseDialog()

    local nMapNpcIndex1 = GetGlobalValue(Global_longmamu)
    local nMapNpcIndex2 = GetGlobalValue(Global_longmajin)

    if (nMapNpcIndex1 == 0 and nMapNpcIndex2 == 0) then
        local mapid = SubWorldID2Idx(73)

        --²úÉú±±·½ÁúÂí£¨Ä¾£©²¢°ó¶¨Íæ¼Ò
        local longmamu = AddNpc(943, 30, mapid, 2019 * 32, 3525 * 32)
        SetGlobalValue(Global_longmamu, longmamu)
        SetNpcName(longmamu, "Long M· (Méc)")
        SetNpcTask(longmamu, 1, getduiyouID())
        --		SetNpcTask( longmamu, 2, PlayerIndex )
        SetNpcTimer(longmamu, "\\script\\ontimer\\ÁúÂíÉ¾³ı×Ô¼º.lua", 180)

        --²úÉúÄÏ·½ÁúÂí£¨½ğ£©²¢°ó¶¨Íæ¼Ò
        local longmajin = AddNpc(942, 30, mapid, 1618 * 32, 3481 * 32)
        SetGlobalValue(Global_longmajin, longmajin)
        SetNpcName(longmajin, "Long M· (Kim)")
        SetNpcTask(longmajin, 1, GetPlayerID())
        --		SetNpcTask( longmajin, 2, PlayerIndex )
        SetNpcTimer(longmajin, "\\script\\ontimer\\ÁúÂíÉ¾³ı×Ô¼º.lua", 180)
    end
end

function no()
    CloseDialog()
end;
