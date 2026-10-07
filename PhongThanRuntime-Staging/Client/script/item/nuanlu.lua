snow_renwu = 1385
snow_point = 1386
Global_snow_EntryCount = 183
Global_snow_index = 184

function main(sel)
    if (HaveIBBuff(639) == 0) and (HaveIBBuff(642) == 0) then
        Talk(1, "no", "Trong cuéc thi ®Êu ng­êi tuyÕt míi ®­îc sö dông !")
    elseif (GetTaskByte(snow_renwu, 3) <= 1) then
        Talk(1, "no", "Kh«ng cã G¨ng tay, cÇn mua ë T¹p hãa Th­¬ng")
    elseif (HaveIBBuff(637) > 0) then
        Talk(1, "no", "BiÕn thµnh ng­êi tuyÕt tª cãng råi, kh«ng thÓ tù m×nh sö dông lß s­ëi !")
    else
        if (DelNormalItem(6, 1, 477, 0) == 0) then
            DelNormalItemInQuick(6, 1, 477, 0)
        end
        Msg2Player("§· sö dông lß s­ëi !")

        local OldPlayerIndex = PlayerIndex
        local w1, x1, y1, rv, camp1 = 0, 0, 0, 0, 0
        local idx, pidx = 0, 0
        local mark = 0
        local camp = GetTaskByte(snow_renwu, 4)
        local w, x, y = GetWorldPos()
        local mtype = -1
        while 1 do
            idx, pidx = GetNextPlayer(11, idx, 0);
            if (idx == 0) then
                break ;
            end ;
            PlayerIndex = pidx
            w1, x1, y1 = GetWorldPos()
            camp1 = GetTaskByte(snow_renwu, 4)
            mtype = GetMorphType()

            if (IsPlayerInDeath() == 0) and (HaveIBBuff(639) > 0 or HaveIBBuff(642) > 0) and (w1 == 3) then
                if (mtype ~= 364) and (mtype ~= 420) and (mtype ~= 419) then
                    rv = (x - x1) ^ 2 + (y - y1) ^ 2
                    if (rv <= 200) and (HaveIBBuff(637) > 0) and (camp1 == camp) then
                        snow_poly = { 39, 28 }
                        ScrollMessage("B¹n ®· ®­îc ®ång ®éi gi¶i cøu")
                        mark = mark + 1
                        RemoveIBBuff(637)
                        SetCursorStyle(31)
                        AddSpecialSkill(222, 1, 2)
                        SetClientRightSkill(222)
                        AddEmoteBalloon(PlayerIndex, 24)
                        PolyMorph(snow_poly[camp1], 1, 0, -1, 600)
                    end
                end
            end
        end
        PlayerIndex = OldPlayerIndex
        AddEmoteBalloon(PlayerIndex, 24)
        if (mark > 0) then
            SetTaskWord(snow_point, 1, GetTaskWord(snow_point, 1) + mark)
            SetTaskByte(snow_point, 4, GetTaskByte(snow_point, 4) + mark)
            ScrollMessage("B¹n ®· gi¶i cøu <c=yel>" .. mark .. "<c>§ång ®éi")

            msg2cur_show(camp, GetName())
            if (GetMissionV(11, 3) > GetMissionV(11, 4)) then
                NewTaskNote(203, 6, 1, "<c=water>§éi xanh<c>", GetTaskByte(snow_point, 3), GetTaskByte(snow_point, 4))
            elseif (GetMissionV(11, 3) == GetMissionV(11, 4)) then
                NewTaskNote(203, 6, 1, "C«ng b»ng", GetTaskByte(snow_point, 3), GetTaskByte(snow_point, 4))
            else
                NewTaskNote(203, 6, 1, "<c=r>§éi ®á<c>", GetTaskByte(snow_point, 3), GetTaskByte(snow_point, 4))
            end
            upkill()
        end
    end ;
end

function no()
    CloseDialog()
end;

Noon_Active_Event = 7
Noon_Active_Event_Day = 1
Noon_Active_Event_Num = 2

function Check_NoonActive_ON(nNum)
    if (IsWorldEventExist(Noon_Active_Event) == 0) then
        return 0
    end

    local nCurDay = math.floor(LocalSystemTime() / 86400);
    if GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Day) == nCurDay
            and GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Num) == nNum then
        return 1
    end

    return 0
end

function upkill()
    local h, m, s = GetHMS()

    local weekDay = GetWeekDay()
    local nNoonActiveOn = Check_NoonActive_ON(3);
    if nNoonActiveOn > 0 then
        if (h < 11 or h >= 14) then
            return 0
        end
    else
        if (weekDay ~= 3 or (h <= 18) or (h >= 22)) then
            return 0
        end
    end

    local rankSec = 0
    local rankKill = 0
    local rankLvl = 0
    local rankName = ""

    local mark = GetTaskWord(snow_point, 1)
    local nkill = GetTaskByte(snow_point, 3)
    local lvl = GetLevel()
    local name = GetName()
    local nowidx = 0
    for j = 1, 10 do
        rankName = LoadIniString("snow_match_name", j)
        if (rankName == nil) then
            rankName = ""
        end

        if (name == rankName) then
            if (j == 1) then
                if (LoadIniInteger("snow_match_point", 1) > mark) then
                    return 0
                end
                nowidx = j
                break
            end

            local flag1, flag2, flag3, flag4
            for m = j - 1, 1, -1 do
                flag1 = LoadIniInteger("snow_match_point", m)
                flag2 = LoadIniString("snow_match_name", m)
                flag3 = LoadIniInteger("snow_match_level", m)
                flag4 = LoadIniInteger("snow_match_kill", m)
                if (flag1 == 0) or (flag1 > mark) then
                    nowidx = m + 1
                    break
                elseif (flag1 == mark) then
                    if (flag4 > nkill) then
                        nowidx = m + 1
                        break
                    elseif (flag1 == nkill) then
                        if (flag3 > lvl) then
                            nowidx = m + 1
                            break
                        end
                    end
                end

                SaveIniInteger("snow_match_point", m + 1, flag1)
                SaveIniString("snow_match_name", m + 1, flag2)
                SaveIniInteger("snow_match_level", m + 1, flag3)
                SaveIniInteger("snow_match_kill", m + 1, flag4)
                nowidx = m
            end
            break
        end
    end
    if (nowidx == 0) then
        for j = 1, 10 do
            rankSec = LoadIniInteger("snow_match_point", j)
            rankName = LoadIniString("snow_match_name", j)
            rankLvl = LoadIniInteger("snow_match_level", j)
            rankKill = LoadIniInteger("snow_match_kill", j)
            if (rankSec == nil) or (rankName == nil) or (rankLvl == nil) or (rankKill == nil) then
                rankSec = 0
                rankName = ""
                rankLvl = 0
                rankKill = 0
            end

            if (rankSec == 0) then
                nowidx = j
                break
            elseif (rankSec < mark) or (rankSec == mark and rankKill < nkill) or (rankSec == mark and rankLvl < lvl) then
                if (j < 10) then
                    local flag1, flag2, flag3, flag4
                    for m = 9, j + 1, -1 do
                        flag1 = LoadIniInteger("snow_match_point", m)
                        flag2 = LoadIniString("snow_match_name", m)
                        flag3 = LoadIniInteger("snow_match_level", m)
                        flag4 = LoadIniInteger("snow_match_kill", m)
                        SaveIniInteger("snow_match_point", m + 1, flag1)
                        SaveIniString("snow_match_name", m + 1, flag2)
                        SaveIniInteger("snow_match_level", m + 1, flag3)
                        SaveIniInteger("snow_match_kill", m + 1, flag4)
                    end ;
                    SaveIniInteger("snow_match_point", j + 1, rankSec)
                    SaveIniString("snow_match_name", j + 1, rankName)
                    SaveIniInteger("snow_match_level", j + 1, rankLvl)
                    SaveIniInteger("snow_match_kill", j + 1, rankKill)
                end
                nowidx = j
                break ;
            end
        end
    end

    SaveIniInteger("snow_match_point", nowidx, mark)
    SaveIniString("snow_match_name", nowidx, name)
    SaveIniInteger("snow_match_level", nowidx, lvl)
    SaveIniInteger("snow_match_kill", nowidx, nkill)
end

function msg2cur_show(wincamp, winname)
    local str_list = {
        [1] = { "<c>", "§èt mÊy lß råi, mÊy ng­êi tuyÕt bÞ tª cãng cuèi cïng ®· Êm lªn råi." },
        [2] = { "<c>M¶nh tuyÕt nhèt ®éi ngò b¹n ®ang tan ch¶y trong lß löa", " Råi ." },
        [3] = { "<c>", "Trong tr¹ng th¸i Thiªn Qu©n ®· gi¶i cøu ®ång ®éi, lËp c«ng lín!" },
        [4] = { "<c>KÌm theo 1 tiÕng kªu la,", "N©ng lß lªn, xem ®ång ®éi nh¶y ra tõ chç ng­êi tuyÕt." },
    }
    local strw = ""
    if (wincamp == 1) then
        strw = "<c=water><RoleName=\"" .. winname .. "\"><c>"
    else
        strw = "<c=r><RoleName=\"" .. winname .. "\"><c>"
    end
    local r = math.random(1, 4)
    Msg2CurMapAnnounce(str_list[r][1] .. strw .. str_list[r][2])
end
