module("NewServer", package.seeall)

function Pub_IsNewServerOpen()
    if not (GetGameServerName() == "Tø T­îng ThÇn Vùc") then
        return 0
    end
    local time1 = LocalYMD2Time(2015, 6, 26) - SystemTime()
    local time2 = LocalYMD2Time(2015, 7, 26 + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewPromotionOpen()
    if not (GetGameServerName() == "Tø T­îng ThÇn Vùc") then
        return 0
    end
    local time1 = LocalYMD2Time(2015, 6, 26) - SystemTime()
    local time2 = LocalYMD2Time(2015, 7, 3 + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function no()
    CloseDialog()
end
