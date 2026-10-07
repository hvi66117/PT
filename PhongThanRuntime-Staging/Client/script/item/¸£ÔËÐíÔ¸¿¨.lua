boxName = "ThÎ cÇu Phóc vËn"
boxID = { 6, 1, 1370, 1 }
spcae = 1

function no()
    CloseDialog()
end

function main()
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    AddItem()
end

function AddItem()

    if (IsHaveSpaceForTreasure(spcae + 1) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. spcae .. "¸ñ.")
        return
    end

    local nRandom = math.random(1, 100)
    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) > 0) then
        if (nRandom <= 35) then
            AddNormalItemBind(6, 1, 1373, 1, 0, 0, 1)
            InfoBox("Chóc mõng ngµi nhËn ®­îc <c=g>Ô¸Íû¿¨: T­íng Qu©n LÖnh<c>")
            Msg2Player("Chóc mõng ngµi nhËn ®­îc Ô¸Íû¿¨: T­íng Qu©n LÖnh.")
            WriteLog("[´ò¿ª " .. boxName .. "][NhËn ®­îcÔ¸Íû¿¨: T­íng Qu©n LÖnh]")

        elseif (nRandom >= 36 and nRandom <= 65) then
            AddNormalItemBind(6, 1, 1374, 1, 0, 0, 1)
            InfoBox("Chóc mõng ngµi nhËn ®­îc <c=g>Ô¸Íû¿¨: LÔ hép Phï Th¹ch<c>")
            Msg2Player("Chóc mõng ngµi nhËn ®­îc Ô¸Íû¿¨: LÔ hép Phï Th¹ch.")
            WriteLog("[´ò¿ª " .. boxName .. "][NhËn ®­îcÔ¸Íû¿¨: LÔ hép Phï Th¹ch]")

        elseif (nRandom >= 66 and nRandom <= 85) then
            AddNormalItemBind(6, 1, 1375, 1, 0, 0, 1)
            InfoBox("Chóc mõng ngµi nhËn ®­îc <c=g>Ô¸Íû¿¨: ÈÎÑ¡ÃûÓñ<c>")
            Msg2Player("Chóc mõng ngµi nhËn ®­îc Ô¸Íû¿¨: ÈÎÑ¡ÃûÓñ.")
            WriteLog("[´ò¿ª " .. boxName .. "][NhËn ®­îcÔ¸Íû¿¨: ÈÎÑ¡ÃûÓñ]")

        elseif (nRandom >= 86 and nRandom <= 95) then
            AddNormalItemBind(6, 1, 1376, 1, 0, 0, 1)
            InfoBox("Chóc mõng ngµi nhËn ®­îc <c=g>Ô¸Íû¿¨: Vi Quang Qu¸i Phï<c>")
            Msg2Player("Chóc mõng ngµi nhËn ®­îc Ô¸Íû¿¨: Vi Quang Qu¸i Phï.")
            WriteLog("[´ò¿ª " .. boxName .. "][NhËn ®­îcÔ¸Íû¿¨: Vi Quang Qu¸i Phï]")

        else
            AddNormalItemBind(6, 1, 1377, 1, 0, 0, 1)
            InfoBox("Chóc mõng ngµi nhËn ®­îc <c=g>Ô¸Íû¿¨: ÈÎÑ¡Hån Chó cÊp 2<c>")
            Msg2Player("Chóc mõng ngµi nhËn ®­îc Ô¸Íû¿¨: ÈÎÑ¡Hån Chó cÊp 2.")
            WriteLog("[´ò¿ª " .. boxName .. "][NhËn ®­îcÔ¸Íû¿¨: ÈÎÑ¡Hån Chó cÊp 2]")

        end
    else
        Msg2Player("KhÊu trõ ®¹o cô thÊt b¹i")
    end

end
