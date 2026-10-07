Task_UseTimes = 1903

function main()
    local nLevel = GetPlayerExtLevel()
    if (nLevel < 10) then
        Talk(1, "no", "ThËt xin lçi, Phi Th¨ng §¬nµÄÊ¹ÓÃµÈ¼¶×îµÍÎª<c=g>cÊp 10<c>.")
        return
    end

    local nToday = math.mod(math.floor(SystemTime() / 86400), 255) + 1
    if (nToday ~= GetTaskByte(Task_UseTimes, 3)) then
        SetTaskByte(Task_UseTimes, 3, nToday)
        SetTaskByte(Task_UseTimes, 4, 0)
    end

    local nUseTimes = GetTaskByte(Task_UseTimes, 4)
    if (nUseTimes >= 10) then
        Talk(1, "no", "ThËt xin lçi, Phi Th¨ng §¬nÃ¿ÌìÖ»ÄÜÊ¹ÓÃ<c=g>10´Î<c>.")
        return
    end

    if (nLevel >= 80) then
        MsgBox("Äúµ±Ç°ÒÑ¾­Âú¼¶, sö dông 1 c¸i Phi Th¨ng §¬n, ½«»ñµÃ<c=g>2<c> giêµÄÌì½µ²ÆÉñ×´Ì¬, ÊÇ·ñÈ·¶¨Ê¹ÓÃ?", "SureGetBuff", "no")
    else
        if (isDelitem() == 1) then
            local nExp = nLevel * 500
            local nFactExp = AddOwnExtendExp(nExp)
            SetTaskByte(Task_UseTimes, 4, nUseTimes + 1)

            if (nFactExp < nExp) then
                TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
                Msg2Player("Ng­¬i ch­a hoµn thµnh §é KiÕp hoÆc cÊp ®é Nh©n gian qu¸ thÊp, kh«ng thÓ lÜnh héi ®ñ tu vi Tiªn Ma, chØ t¨ng lªn " .. nFactExp .. " ®iÓm")
            else
                TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
                Msg2Player("Ê¹ÓÃPhi Th¨ng §¬nÏÉÄ§ĞŞÎªÌáÉı" .. nFactExp .. " ®iÓm")
            end
            WriteLog("[Phi Th¨ng §¬n][Kinh nghiÖm: " .. nFactExp .. "/" .. nExp)
        end
    end
end

function isDelitem()
    if (DelNormalItem(6, 1, 1771, 1) > 0) then
        return 1
    elseif (DelNormalItem(6, 1, 1771, 0) > 0) then
        return 1
    end
    return 0
end

function SureGetBuff()
    no()
    local nUseTimes = GetTaskByte(Task_UseTimes, 4)
    if (nUseTimes >= 10) then
        Talk(1, "no", "ThËt xin lçi, Phi Th¨ng §¬nÃ¿ÌìÖ»ÄÜÊ¹ÓÃ<c=g>10´Î<c>.")
        return
    end

    if (isDelitem() == 1) then
        AddIBBuff(228, 7200)
        SetTaskByte(Task_UseTimes, 4, nUseTimes + 1)
        Msg2Player("Ê¹ÓÃPhi Th¨ng §¬n nhËn ®­îc 2 giêÌì½µ²ÆÉñ×´Ì¬.")
        WriteLog("Ê¹ÓÃÁËPhi Th¨ng §¬n nhËn ®­îc 2 giêÌì½µ²ÆÉñ×´Ì¬.")
    end
end

function no()
    CloseDialog()
end
