MAX_KILL_COUNT = 1000
KillTaskID = 1971

function main()
    no()
    if (HaveNormalItem(6, 1, 1188, 1) <= 0) then
        return
    end
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nTaskDay = GetTaskByte(KillTaskID, 4)
    local nTaskStep = GetTaskByte(KillTaskID, 3)
    local nKillCount = GetTaskWord(KillTaskID, 1)
    if (nTaskStep == 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÈÎÎñÉÐÎ´Íê³É, ÇëÔÙÏûÃð" .. (MAX_KILL_COUNT - nKillCount) .. "Ö»¹Ö²ÅÄÜÁìÈ¡½±Àø.")
        return
    elseif (nTaskStep == 2) then
        MsgBox("ÊÇ·ñÏÖÔÚHoµn thµnh nhiÖm vô ?", "YesFinishTask", "no")
        return
    else
        if (nTaskDay ~= nToday) then
            MsgBox("¾ÅÀèÁ¶Ñýºø¿É¼ÓËÙÌáÉýTiªn Ma GiíiÐÞÎª, sö dông Ö®ºó¿É»ñµÃTu luyÖn Tiªn Ma×´Ì¬, ÔÚTiªn Ma Giíi½µ·þ1000 qu¸i vËtlµ cã thÓ nhËn ´óÁ¿ÐÞÎª, ÊÇ·ñÂíÉÏB¾t ®Çu nhiÖm vô?", "YesAcceptKillTask", "no")
            return
        else
            Talk(1, "no", "Ã¿ÌìÖ»ÄÜHoµn thµnh nhiÖm vô Ò»´Î, ÇëÃ÷ÌìÔÙÀ´")
            return
        end
    end

end
function YesAcceptKillTask()
    no()
    local nLevel = GetPlayerExtLevel()
    if (GetWorldType() ~= 1) then
        Talk(1, "no", "ThËt xin lçi, ´ËµÀ¾ßÖ»ÄÜÔÚTiªn Ma Giíi²ÅÄÜÊ¹ÓÃ.")
        return
    end
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nTaskDay = GetTaskByte(KillTaskID, 4)
    if (nTaskDay == nToday) then
        Talk(1, "no", "Ã¿ÌìÖ»ÄÜHoµn thµnh nhiÖm vô Ò»´Î, ÇëÃ÷ÌìÔÙÀ´.")
        return
    end
    SetTaskByte(KillTaskID, 4, nToday)
    SetTaskByte(KillTaskID, 3, 1)
    SetTaskWord(KillTaskID, 1, 0)
    Talk(1, "no", "Äú nhËn ÈÎÎñ, ÏÖÔÚÈ¥Tiªn Ma GiíiÏûÃð¹ÖÎï°É.")
end
function YesFinishTask()
    no()
    local nLevel = GetPlayerExtLevel()
    if (GetWorldType() ~= 1) then
        Talk(1, "no", "ThËt xin lçi, ´ËµÀ¾ßÖ»ÄÜÔÚTiªn Ma Giíi²ÅÄÜÊ¹ÓÃ.")
        return
    end
    local AddExpValue = nLevel * 3000
    AddOwnExtendExp(AddExpValue)
    SetTaskByte(KillTaskID, 3, 0)
    SetTaskWord(KillTaskID, 1, 0)
    TopMessage("NhËn ®­îc " .. AddExpValue .. " ®iÓm tu luyÖn")
    Msg2Player("Chóc mõng anh hïng Hoµn thµnh nhiÖm vô ! NhËn ®­îc " .. AddExpValue .. "µãÐÞÎª!")
    Talk(1, "no", "Chóc mõng anh hïng Hoµn thµnh nhiÖm vô ! NhËn ®­îc " .. AddExpValue .. "µãÐÞÎª!")
end
function no()
    CloseDialog()
end
