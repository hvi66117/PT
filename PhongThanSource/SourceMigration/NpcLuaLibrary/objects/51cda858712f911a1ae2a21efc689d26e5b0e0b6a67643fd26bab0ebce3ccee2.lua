--Õ½¶·¼ÆÃÉBoss.lua
--author:gaojingwei
--date:2009/05/11

Global_Door_Number = 202        --1byte£º¼ÇÂ¼ÏÖ´æµÄ´«ËÍÃÅµÄ¸öÊı£»2byte£º´«ËÍÃÅµÄĞòºÅ
Task_Accept_Times = 1444        --1byte¼ÇÂ¼µ±Ìì½»¹ÒµÄ´ÎÊı
Task_LastDay = 1445                --¼ÇÂ¼½ÓÈÎÎñµÄÈÕÆÚ
Task_DoorID = 1446                --´«ËÍÃÅµÄID

DoorTemplateID = 999            --Õó·¨ÃÅµÄtemplateID
DialogBossTemplateID = 1000        --¶Ô»°bossµÄtemplateID
FightBossTemplateID = 1001        --Õ½¶·bossµÄtemplateID
TranSport = --´«ËÍÃÅµÄ×ø±ê£¬Íæ¼Ò±»´«ËÍµ½·â±ÕÇøÓòµÄ×ø±ê£¬·â±ÕÇøÓòµÄÔ²µã£¬°ë¾¶
{
    [1] = { DoorX = 1598, DoorY = 3822, DestX = 1670, DestY = 3332, OriginX = 1697, OriginY = 3327, Radii = 40, Global_Free_Boss = 201 },
    [2] = { DoorX = 1599, DoorY = 3818, DestX = 1830, DestY = 3288, OriginX = 1855, OriginY = 3277, Radii = 51, Global_Free_Boss = 204 }
}

NpcCoorDinate = --¼ÆÃÉË¢³öµÄÎ»ÖÃ
{
    [1] = { NpcX = 1695, NpcY = 3326 },
    [2] = { NpcX = 1855, NpcY = 3277 }
}

OutCoorDinate = --Íæ¼Ò±»´«ËÍ³öÀ´µÄÎ»ÖÃ
{
    [1] = { OutX = 1603, OutY = 3825 }
}

Gua = {
    [1] = { name = "Tr¹ch qu¸i quyÓn", item = { 3, 349, 0, 0 } },
    [2] = { name = "L«i qu¸i quyÓn", item = { 3, 351, 0, 0 } },
    [3] = { name = "Phong qu¸i quyÓn", item = { 3, 352, 0, 0 } },
    [4] = { name = "S¬n qu¸i quyÓn", item = { 3, 354, 0, 0 } }
}

function OnDeath(npcindex)
    local doorIndex = GetNpcTask(npcindex, 5)
    local doorID = GetNpcTask(npcindex, 6)
    local doorCircle = GetNpcTask(npcindex, 7)
    --modified by fangjie for ²»ÖÜÉ½¿ÉÄÜ³öÏÖÎŞÏŞË¢³ö¼ÆÃÉµÄÇé¿ö at 2012-5-21 begin
    if (doorIndex <= 0) or (GetNpcID(doorIndex) ~= doorID) then
        local nOldPlayer = PlayerIndex
        PlayerIndex = GetFirstPlayerInAll()
        WriteLog("[KÕ M«ng][Xãa trùc tiÕp KÕ M«ng]")
        PlayerIndex = nOldPlayer
        DelNpc(npcindex)
        return
    end
    --modified by fangjie for ²»ÖÜÉ½¿ÉÄÜ³öÏÖÎŞÏŞË¢³ö¼ÆÃÉµÄÇé¿ö at 2012-5-21 end
    SetNpcTimer(doorIndex, "\\script\\ontimer\\ÌßÈË.lua", 60)

    local oldPlayerIndex = PlayerIndex
    for i = 1, 4, 1 do
        local playerID = GetNpcTask(npcindex, i)
        PlayerIndex = SearchPlayerById(playerID)
        if (PlayerIndex > 0) then
            for j = 1, 3, 1 do
                ScrollMessage("1 phót sau ph¸p thuËt trªn ng­êi sÏ biÕn mÊt vµ ®­îc chuyÓn ra khái Ngäc Th¹ch Cèc")
            end
            Msg2Player("1 phót sau ph¸p thuËt trªn ng­êi sÏ biÕn mÊt vµ ®­îc chuyÓn ra khái Ngäc Th¹ch Cèc")
            ---- modified by yaoxin at 2009-08-13
            TaskNote(213, -1)
        end
    end
    PlayerIndex = oldPlayerIndex

    local nNowTime = LocalSystemTime()
    ---- modified by yaoxin at 2009-08-13
    local nLastTime = GetGlobalValue(TranSport[doorCircle].Global_Free_Boss)
    local tTime = nNowTime - nLastTime
    --modified by liujifang for log¼ÇÂ¼ at 2012-12-11 begin
    local nOldPlayer = PlayerIndex
    local nLogStr = ""
    local nSize = GetTeamSize()
    if (nSize >= 2 and nSize <= 12) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (PlayerIndex > 0) then
                nLogStr = nLogStr .. "," .. GetName()
            end
            PlayerIndex = nOldPlayer
        end
    end
    WriteLog(GetName() .. "DiÖt trõ KÕ M«ng dïng" .. tTime .. ", h¶o h÷u:" .. nLogStr)
    --modified by liujifang for log¼ÇÂ¼ at 2012-12-11 end

    local tSecond = mod(tTime, 60)
    local tMinite = mod(floor(tTime / 60), 60)
    local tHour = floor(tTime / 3600)
    local strTime = ""

    if (tHour > 0) then
        strTime = strTime .. tHour .. "giê"
    end

    if (tMinite > 0) then
        strTime = strTime .. tMinite .. "m"
    end

    strTime = strTime .. tSecond .. "s"

    AddNormalItemPile(3, 410, 0, 0, 0, 0)
    Msg2Player("B¹n ®· nhËn ®­îc 1 tranh qu¸i phï s¬ cÊp")
    AddGlobalCountNews("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· tiªu diÖt <c=yel>KÕ M«ng<c>!", 5)
    Msg2CurMapAnnounce("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· tiªu diÖt <c=yel>KÕ M«ng<c>!")

    DelNpc(npcindex)
end



