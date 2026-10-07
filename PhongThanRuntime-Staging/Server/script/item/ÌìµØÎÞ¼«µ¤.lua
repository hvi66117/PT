function main()
    if (HaveNormalItem(6, 1, 1357, 1) <= 0) then
        return
    end

    local nLevel = GetLevel()
    if (nLevel < 40) then
        Talk(1, "no", "Xin lçi, sö dông Kinh NghiÖm §¬n ph¶i ®¹t <c=g>cÊp 40<c>. ")
        return
    end

    local nToday = math.mod(math.floor(SystemTime() / 86400), 256)

    if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
        MsgBox("HiÖn t¹i ®· ®ñ cÊp, sö dông 1 Kinh NghiÖm §¬n, nhËn <c=g>2<c> giê tr¹ng th¸i Thiªn Gi¸ng ThÇn Tµi, ®ång ý sö dông kh«ng?", "SureGetBuff", "no")
    else
        if (DelNormalItem(6, 1, 1357, 1) > 0) then
            local nExp = math.floor((7.51 * nLevel * nLevel + 1829.65 * nLevel - 66382) * 10)
            AddOwnExp(nExp)
            Msg2Player("Sö dông Kinh NghiÖm §¬n nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
            WriteLog("Sö dông Kinh NghiÖm §¬n nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
        end
    end
end

function SureGetBuff()
    no()
    if (HaveNormalItem(6, 1, 1357, 1) <= 0) then
        return
    end

    local nLevel = GetLevel()
    if (nLevel < 40) then
        Talk(1, "no", "Xin lçi, sö dông Kinh NghiÖm §¬n ph¶i ®¹t <c=g>cÊp 40<c>. ")
        return
    end

    if (DelNormalItem(6, 1, 1357, 1) > 0) then
        AddIBBuff(228, 7200)
        Msg2Player("Sö dông Kinh NghiÖm §¬n nhËn ®­îc 2 giê tr¹ng th¸i Thiªn Gi¸ng ThÇn Tµi.")
        WriteLog("Sö dông Kinh NghiÖm §¬n nhËn ®­îc 2 giê tr¹ng th¸i Thiªn Gi¸ng ThÇn Tµi.")
    end
end

function no()
    CloseDialog()
end
