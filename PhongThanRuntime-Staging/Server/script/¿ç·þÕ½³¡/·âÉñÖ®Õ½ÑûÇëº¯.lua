require("¿ç·şÕ½³¡.luax")

Invitation = 2099

InvitationFlag = 2168
function no()
    CloseDialog()
end

function main(nLevel, t, nNpcIdx, nItemId)

    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (GetWorldPos() ~= 21) then
        InfoBox("ÑûÇëº¯Ö»ÄÜÔÚTriÒu CaµØÍ¼´ò¿ª.")
        return
    end
    if (GetTaskByte(InvitationFlag, 1) ~= GetGlobalStoreValueByte(11, 3)) then
        local season = GetGlobalStoreValueByte(11, 3)
        SetTask(Invitation, 0)
        SetTaskByte(InvitationFlag, 1, season)
    end
    local LeftRewardTimes = 6 - (GetTaskByte(Invitation, 3))
    tasks = {
        { "ÎÒÀ´Áì½±ÁË", "LingJiang"; show = 1 },
        { "µÈÎÒºÃÏûÏ¢", "no"; show = 1 },
    }
    SetTask(140, nItemId)
    local tTimeTable = InterService.CompetitionDate1
    local sTimeInfo = tTimeTable[1][2] .. "Th¸ng" .. tTimeTable[1][3] .. "ÈÕ/" .. tTimeTable[2][2] .. "Th¸ng" .. tTimeTable[2][3] .. "ÈÕ/" .. tTimeTable[3][2] .. "Th¸ng" .. tTimeTable[3][3] .. "ÈÕ/" .. tTimeTable[4][2] .. "Th¸ng" .. tTimeTable[4][3] .. "ÈÕ/" .. tTimeTable[5][2] .. "Th¸ng" .. tTimeTable[5][3] .. "ÈÕ/" .. tTimeTable[6][2] .. "Th¸ng" .. tTimeTable[6][3] .. "Ngµy"
    SayTask("Thiªn C­¬ng ¶nh thø" .. InterService.g_TheWarSeason .. "½ì¡°Phong ThÇn Chi ChiÕn¡±ÒÑÀ­¿ªÕ½Ä», ³ÏÑûÄúÇ°À´²ÎÕ½.\n±ÈÈüÊ±¼äÎª<c=g>" .. sTimeInfo .. "Ã¿Íí21:00<c>.\nÄú½öĞè²ÎÓëÏÂÒ»³¡±ÈÈüÇÒ<c=g>±¾¶Ó»ñµÃ10´Î ®¸nh b¹i <c>, ¼´¿ÉÔÚ´Ë´¦ÁìÈ¡<c=y>1000¹¦Ñ«<c> phÇn th­ëng.\nÊ£Óà¿ÉÁì½±´ÎÊı: <c=y>" .. LeftRewardTimes .. "/6<c>", tasks)
end

function LingJiang()
    no()

    local y, m, d = GetYMD()
    if (GetTaskByte(Invitation, 4) == d) then
        Talk(1, "no", "ÉÏÒ»³¡±ÈÈüµÄ½±ÀøÄúÒÑ¾­Áì¹ıÁË, ÏÂ³¡±ÈÈü½áÊøºó²ÅÄÜÔÙ´ÎÁìÈ¡Å¶")
        return
    end

    local n = IsOpenMission(26)
    if (n > 0) then
        Talk(1, "no", "ÇëÓ¢ĞÛÔÚ±ÈÈü½áÊøºóÔÙÀ´Áì½±.")
        return
    end

    local Killnum1 = GetPlayerKillNum()
    if (Killnum1 == "³ö´í") then
        Talk(1, "no", "Î´²éÑ¯µ½Ó¢ĞÛµÄ±¨ÃûĞÅÏ¢, ÔİÊ±²»ÄÜÁìÈ¡½±Àø.")
        return
    end

    local Killnum0 = GetTaskWord(Invitation, 1)
    local RewardTimes = GetTaskByte(Invitation, 3)
    if ((Killnum1 - Killnum0) >= 10) then
        SetTaskWord(Invitation, 1, Killnum1)
        SetTaskByte(Invitation, 3, RewardTimes + 1)
        SetTaskByte(Invitation, 4, d)

        SetExploitV(GetExploitV() + 1000)
        Msg2Player("Ngµi nhËn ®­îc <c=g>1000µã¹¦Ñ«<c>, ÕâÊÇÄúµÚ<c=g>" .. GetTaskByte(Invitation, 3) .. "<c>´ÎÁì½±, »¹Cã thÓ nhËn<c=g>" .. (6 - GetTaskByte(Invitation, 3)) .. "<c> lÇn.")
        TopMessage("Ngµi nhËn ®­îc <c=g>1000µã¹¦Ñ«<c>")
        WriteLog("[ThiÖp mêi Phong ThÇn ChiÕn][ÁìÈ¡1000¹¦Ñ«½±Àø][LÇn " .. GetTaskByte(Invitation, 3) .. "lÇn]")
    else
        Talk(1, "no", "ĞèÒª±¾¶ÓÔÚÒ»³¡¡°Phong ThÇn Chi ChiÕn¡±±ÈÈüÖĞ<c=g>´ò°ÜÂú10ÈË, µ±³¡±ÈÈü½áÊøºó·½¿ÉÁì½±<c>.Äú»¹Î´´ïµ½¿ÉÁì½±µÄÄ¿±ê, ÇëÔÙ½ÓÔÙÀ÷.\n×¢: ÒòÎª±ÈÈü½áÊøºó²ÅÍ³¼ÆĞÅÏ¢, ËùÒÔÇë±ÈÈü½áÊøºóÔÙÀ´ÁìÈ¡.")
        return
    end

    local nItemId = GetTask(140)
    if (GetTaskByte(Invitation, 3) == 6) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡Íê±¾½ì¡°Phong ThÇn Chi ChiÕn¡±ÑûÇëº¯ÖĞµÄËùÓĞ½±Àø, ¹§Ï²¹§Ï².")
        DelItemByID(nItemId)
    end
end

g_bLoadIniFileData = 0

g_tTeamTable = {}

g_nPlayerTaskTeam = 1944

g_nPlayerTaskTimes = 1945

g_nPlayerID = 1946

g_nPlayerPower = 1947

g_nPlayerTeamID = 1950

g_nStoreTimes = 11

g_nStoreFirst = 12

g_nStoreTeamId = 13

function GetPlayerKillNum()
    if (g_bLoadIniFileData == 0) then
        g_tTeamTable = InterService.FuncLoadIniFileData()
        g_bLoadIniFileData = 1
    end

    local nPlayerTeamPos = 0

    nPlayerTeamPos = FindThePlayerInVTT(g_tTeamTable)
    if (nPlayerTeamPos <= 0) then
        return "³ö´í"
    end

    local killnum = g_tTeamTable[nPlayerTeamPos].nTeamKillSum
    return killnum
end

function FindThePlayerInVTT(tableTemp)


    local nPlayerServerID = GetTaskByte(g_nPlayerTaskTeam, 1)
    local nPlayerTeamID = GetTask(g_nPlayerTeamID)
    local bBaoMing = GetTaskByte(g_nPlayerTaskTeam, 2)
    local nPlayerTeamBatch = GetTaskByte(g_nPlayerTaskTeam, 3)
    local nPlayerTimes = GetTaskByte(g_nPlayerTaskTimes, 1)
    local nTimesTp = GetGlobalStoreValueByte(g_nStoreTimes, 3)

    if (nPlayerServerID > 0 or nPlayerTeamID > 0 or nPlayerTeamBatch > 0) then
        if (tableTemp == nil) then
            Talk(1, "no", "ÎŞĞ§Êı¾İ")
            return 0
        end

        local num = table.getn(tableTemp)
        if (num == nil) then
            return 0
        end

        for i = 1, num do

            if (nPlayerServerID == tableTemp[i].nServerID and
                    nPlayerTeamID == tableTemp[i].nTeamID and
                    nPlayerTeamBatch == tableTemp[i].nTeamBatch and
                    1 == tableTemp[i].bTeamValid and
                    nPlayerTimes == nTimesTp and
                    bBaoMing > 0
            ) then
                return i
            end
        end


    else
        return 0
    end
    return 0
end

function SetLoadSwitch()
    g_bLoadIniFileData = 0
end
