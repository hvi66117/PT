require("¹ú¼ÒÈËÆø.luax")

gua8_renwu = 1340
gua8_task = 1341

boss_day = 176

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx, 3)

    Give_Horse_Item(npcidx, PlayerIndex)

    local nNowTime = LocalSystemTime()

    local nLastTime = GetGlobalValue(boss_day)
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
    WriteLog("[Ã÷ÒÄ][³ýµô][ÓÃÊ±" .. tTime .. "]¶ÓÓÑ: " .. nLogStr)

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

    AddGlobalCountNews("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>Minh Di<c>!", 5)

    Msg2CurMapAnnounce("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c>§· ®¸nh b¹i <c=yel> Minh Di <c>, Minh Di vÉn bá l¹i bÝ b¶o dïng ph¸p thuËt trèn tho¸t. Ch­ vÞ anh hïng mau ®i dß th¸m huyÒn c¬ cña bÝ b¶o, nÕu kh«ng 10 phót sau bÝ b¶o sÏ vÒ tay cña Minh Di.")

    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            AddIBBuff(543)
        end
        PlayerIndex = oldPlayer
    else
        AddIBBuff(543)
    end

    ThrowItem(npcidx, PlayerIndex, 3, 359, 0, 0, 0, 0)

    local nMap, nMapX, nMapY = GetNpcWorldPos(npcidx)
    local nIdx = AddNpc(1941, 1, SubWorld, nMapX * 32, nMapY * 32)
    if (nIdx > 0) then
        SetNpcScript(nIdx, "\\script\\¹ÖÎï\\Ã÷ÒÄÃØ±¦.lua")
        SetNpcTimer(nIdx, "\\script\\ontimer\\É¾³ý×Ô¼º.lua", 60 * 10)
    else
        WriteLog("[Ã÷ÒÄ][Î´Ë¢³öÃ÷ÒÄÃØ±¦]")
    end

    DelNpc(npcidx)
end;

function Give_Horse_Item(npcidx, nPlayer)
    local nOldPlayer = PlayerIndex
    PlayerIndex = nPlayer
    ThrowItem(npcidx, PlayerIndex, 3, 1186, 0, 0, 0, 0)
    WriteLog("§¸nh b¹i Minh Di, r¬i Thñ cÊp Minh Di")

    PlayerIndex = nOldPlayer
end

