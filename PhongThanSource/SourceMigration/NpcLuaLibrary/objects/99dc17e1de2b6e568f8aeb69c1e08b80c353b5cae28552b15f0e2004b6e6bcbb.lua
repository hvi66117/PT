Global_Door_Number = 202
Task_Accept_Times = 1444
Task_LastDay = 1445
Task_DoorID = 1446

DoorTemplateID = 999
DialogBossTemplateID = 1000
FightBossTemplateID = 1001
TranSport = {
    [1] = { DoorX = 1598, DoorY = 3822, DestX = 1670, DestY = 3332, OriginX = 1697, OriginY = 3327, Radii = 40, Global_Free_Boss = 201 },
    [2] = { DoorX = 1599, DoorY = 3818, DestX = 1830, DestY = 3288, OriginX = 1855, OriginY = 3277, Radii = 51, Global_Free_Boss = 204 }
}

NpcCoorDinate = {
    [1] = { NpcX = 1695, NpcY = 3326 },
    [2] = { NpcX = 1855, NpcY = 3277 }
}

OutCoorDinate = {
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

    if (doorIndex <= 0) or (GetNpcID(doorIndex) ~= doorID) then
        local nOldPlayer = PlayerIndex
        PlayerIndex = GetFirstPlayerInAll()
        WriteLog("[¼ÆÃÉ][¼ÆÃÉÖ±½ÓÉ¾³ý]µØµã: " .. doorCircle)
        PlayerIndex = nOldPlayer
        DelNpc(npcindex)
        return
    end

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

            TaskNote(213, -1)
        end
    end
    PlayerIndex = oldPlayerIndex

    local nNowTime = LocalSystemTime()

    local nLastTime = GetGlobalValue(TranSport[doorCircle].Global_Free_Boss)
    local tTime = nNowTime - nLastTime

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
    WriteLog("[¼ÆÃÉ][³ýµô][µØµã" .. doorCircle .. "][ÓÃÊ±" .. tTime .. "][¶ÓÓÑ: " .. nLogStr)

    local tSecond = math.mod(tTime, 60)
    local tMinite = math.mod(math.floor(tTime / 60), 60)
    local tHour = math.floor(tTime / 3600)
    local strTime = ""

    if (tHour > 0) then
        strTime = strTime .. tHour .. "Giê"
    end

    if (tMinite > 0) then
        strTime = strTime .. tMinite .. "m"
    end

    strTime = strTime .. tSecond .. "s"

    AddGlobalCountNews("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· tiªu diÖt <c=yel>KÕ M«ng<c>!", 5)
    Msg2CurMapAnnounce("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· tiªu diÖt <c=yel>KÕ M«ng<c>!")

    DelNpc(npcindex)
end



