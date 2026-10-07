function GetPlayerTaskState()
    return 0, 0
end

function main()
    local t = GetPK()
    local str = "Ng­¬i cã thÓ lËp tøc rêi Khai Minh ®¶o, cã muèn t×m hiÓu Khai Minh ®¶o kh«ng?"
    local mt = 0
    if (t > 0) then
        str = "Ng­¬i hiÖn cÇn"
        if (t <= 33) then
            mt = t
        elseif (t <= 87) then
            mt = (t - 33) * 2 + 33
        elseif (t <= 517) then
            mt = (t - 87) * 4 + (87 - 33) * 2 + 33

        elseif (t <= 3000) then
            mt = (t - 517) * 8 + (517 - 87) * 4 + (87 - 33) * 2 + 33
        else
            mt = (t - 3000) * 10 + (3000 - 517) * 8 + (517 - 87) * 4 + (87 - 33) * 2 + 33

        end
        local h = math.floor(mt / 60)
        local m = mt - h * 60
        if (h > 0) then
            str = str .. h .. "Giê"
        end
        if (m == 0) then
            str = str .. "."
        else
            str = str .. m .. "m"
        end

        local nPKValue = math.floor(t / 2)
        str = str .. ", hoÆc tiªu diÖt" .. nPKValue .. "ChØ lµ Phi Thè, míi cã thÓ tÈy LÖ Khİ, cã muèn t×m hiÓu chÕ ®é Khai Minh §¶o kh«ng?"

    end

    local opra = {
        "ChÕ ®é trªn ®¹o/yes",
        "§æi Nh©n NghÜa Th¹ch/GetHelpStore",
    }
    Say(str, table.getn(opra), opra)

end;

function GetHelpStore()
    if (GetHelpScore() < 30) then
        local str = "Xin lçi, kh«ng ®ñ <c=g>30<c> ®iÓm Nh©n NghÜa, kh«ng thÓ ®æi Nh©n NghÜa Th¹ch. Nh©n NghÜa Th¹ch cã thÓ tÈy ®iÓm PK trªn 7 ®iÓm vÒ 7 ®iÓm. "
        str = str .. "<enter><enter>(hiÖn t¹i cã" .. GetHelpScore() .. " ®iÓm Nh©n NghÜa)"
        Talk(1, "no", str)
        return
    end
    local str = "Khi ®iÓm PK<c=g>trªn 7 ®iÓm<c>, sö dông Nh©n NghÜa Th¹ch gi¶m 7 ®iÓm PK, nh­ng tèi ®a chØ gi¶m vÒ 7 ®iÓm. <enter><enter>§ång ı  tiªu hao <c=g>30<c> ®iÓm Nh©n NghÜa ®èi 1 Nh©n NghÜa Th¹ch? "
    str = str .. "<enter><enter>(hiÖn t¹i cã" .. GetHelpScore() .. " ®iÓm Nh©n NghÜa)"
    MsgBox(str, "YesGetHelpStore", "no")
end
function YesGetHelpStore()
    if (GetHelpScore() < 30) then
        Talk(1, "no", "Xin lçi, kh«ng ®ñ <c=g>30<c> ®iÓm Nh©n NghÜa, kh«ng thÓ ®æi Nh©n NghÜa Th¹ch. Nh©n NghÜa Th¹ch cã thÓ tÈy ®iÓm PK trªn 7 ®iÓm vÒ 7 ®iÓm. ")
        return
    end
    PayHelpScore(30)
    AddNormalItemBind(8, 1629, 2, 1, 0, 0, 1)
    Talk(1, "main", "§æi thµnh c«ng! NhËn ®­îc 1 <c=g>Nh©n NghÜa Th¹ch<c>. ")
end

function yes()
    Talk(1, "yes1", "×¼ÌáµÀÈË: ÔÚ¿ªÃ÷µºÉÏPK²»»áÔö¼ÓPKÖµ, PK²»»áµôÂäÉíÉÏµÄ×°±¸, µ«ÈÔ¿ÉÄÜµôÂä±³°üÖĞµÄµÀ¾ß, Ö»ÓĞ½«<c=g>PKÖµÇåÎª0<c>²ÅÄÜÀë¿ªÕâÀï.<enter><enter>Ã¿¹ıÒ»¶ÎÊ±¼ä, PKÖµ»á×Ô¶¯ÏÂ½µ, Äã»¹ÄÜ¹»Í¨¹ı½µ·şµºÉÏµÄ<c=g>¹ÖÎï<c>»òÕßÊ¹ÓÃ<c=g>¹ÛÒôË®<c>À´¼õÉÙPKÖµ.")
end

function yes1()
    CloseDialog()
    Talk(1, "main", "ChuÈn §Ò §¹o Nh©n: Khi ®iÓm PK lín h¬n 7, sö dông Quan ¢m Thñy <c=r>hiÖu qu¶ gi¶m xuèng<c>. Khi ®ã h·y chän sö dông Nh©n NghÜa Th¹ch tÈy LÖ Khİ, mçi <c=r>Nh©n NghÜa Th¹ch<c> cã thÓ gi¶m 7 ®iÓm PK, tèi ®a chØ cã thÓ gi¶m ®iÓm PK xuèng cßn <c=g>7<c> ®iÓm. ")
end

function no()
    CloseDialog()
end;
