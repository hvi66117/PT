boxName = "¹úÕ½ÌØ¹©ÎäÆ÷°ü"
boxID = { 6, 1, 1354, 1 }
spcae = 1
Times = 10

function no()
    CloseDialog()
end

function main()

    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local nTimes = GetTaskByte(2076, 1) + 1

    if (IsHaveSpaceForTreasure(spcae + 1) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. spcae .. "¸ñ.")
        return
    end

    if (nTimes <= 2) then
        local opra = {
            "<c=y>6¸Ä Õ¿½ð¸«*1<c>/GiveGift",
            "<c=y>6¸Ä Ñ×µÛ´ó½£*1<c>/GiveGift",
            "<c=y>6¸Ä Ì«¼«½£*1<c>/GiveGift",
            "<c=y>6¸Ä ÃðÉñîá*1<c>/GiveGift",
            SetTask(141, 1)
        }
        Say("¹úÕ½ÌØ¹©ÎäÆ÷°ü: Ç°2´Î¿ªÆô»ñµÃ×ÔÑ¡7ÈÕÓÐÐ§ÆÚ<c=g>6¸Ä100¼¶»ÆÎä<c>*1, ºóÐø8´Î¿ªÆô»ñµÃ×ÔÑ¡7ÈÕÓÐÐ§ÆÚ<c=g>6¸Ä90¼¶»ÆÎä<c>*1.", table.getn(opra), opra)
    else
        local opra = {
            "<c=y>6¸Ä ¿ªÌì¸«*1<c>/GiveGift",
            "<c=y>6¸Ä ÖðÈÕ´ó½£*1<c>/GiveGift",
            "<c=y>6¸Ä ½ð¹â½£*1<c>/GiveGift",
            "<c=y>6¸Ä »ìÌìîá*1<c>/GiveGift",
            SetTask(141, 5)
        }
        Say("¹úÕ½ÌØ¹©ÎäÆ÷°ü: Ç°2´Î¿ªÆô»ñµÃ×ÔÑ¡7ÈÕÓÐÐ§ÆÚ<c=g>6¸Ä100¼¶»ÆÎä<c>*1, ºóÐø8´Î¿ªÆô»ñµÃ×ÔÑ¡7ÈÕÓÐÐ§ÆÚ<c=g>6¸Ä90¼¶»ÆÎä<c>*1.", table.getn(opra), opra)
    end
end

function GiveGift(index)
    no()

    local opra = {
        "<c=y>6¸Ä Õ¿½ð¸«*1<c>",
        "<c=y>6¸Ä Ñ×µÛ´ó½£*1<c>",
        "<c=y>6¸Ä Ì«¼«½£*1<c>",
        "<c=y>6¸Ä ÃðÉñîá*1<c>",
        "<c=y>6¸Ä ¿ªÌì¸«*1<c>",
        "<c=y>6¸Ä ÖðÈÕ´ó½£*1<c>",
        "<c=y>6¸Ä ½ð¹â½£*1<c>",
        "<c=y>6¸Ä »ìÌìîá*1<c>",
    }

    local nIndex = index + GetTask(141)

    local nTimes = GetTaskByte(2076, 1) + 1
    SetTaskByte(2076, 1, nTimes)

    if (nIndex == 1) then
        AddNormalItem4(0, 0, 5, 10, 1, 1006, 6, 7, 0)
    elseif (nIndex == 2) then
        AddNormalItem4(0, 0, 4, 10, 1, 1006, 6, 7, 0)
    elseif (nIndex == 3) then
        AddNormalItem4(0, 0, 6, 10, 1, 1010, 6, 7, 0)
    elseif (nIndex == 4) then
        AddNormalItem4(0, 0, 7, 10, 1, 1006, 6, 7, 0)
    elseif (nIndex == 5) then
        AddNormalItem4(0, 0, 5, 9, 1, 1006, 6, 7, 0)
    elseif (nIndex == 6) then
        AddNormalItem4(0, 0, 4, 9, 1, 1006, 6, 7, 0)
    elseif (nIndex == 7) then
        AddNormalItem4(0, 0, 6, 9, 1, 1010, 6, 7, 0)
    else
        AddNormalItem4(0, 0, 7, 9, 1, 1006, 6, 7, 0)
    end

    InfoBox("§©y lµ ÄúµÚ" .. nTimes .. "´Î´ò¿ª" .. boxName .. ",Chóc mõng ngµi nhËn ®­îc nhËn ®­îc <c=g>" .. opra[nIndex] .. "<c>.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. opra[nIndex] .. ".")
    WriteLog("Më  " .. boxName .. " nhËn ®­îc " .. opra[nIndex])

    if (GetTaskByte(2076, 1) >= Times) then
        DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])
        WriteLog("´ÎÊýÓÃ¾¡ " .. boxName .. "×Ô¶¯É¾³ý")
    end

end
