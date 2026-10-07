function main()
    local nPlayerType = GetPlayerType()
    if (nPlayerType == 0) then
        Say(13533, 6, "Ch n ßan Kh´i/jiatou", "Ch n ßan Y™u ß∏i/jiabelt", "Ch n ßan Chi’n Ngoa/jiaboot", "Ch n ßan Phi Phong/jiapi", "Hoµng Kim Ch n ßan Gi∏p/jiacoat", "HÒy b·/no")
    elseif (nPlayerType == 1) then
        Say(13533, 6, "HÂng Qu©n Qu∏n/daotou", "HÂng Qu©n C©n/daobelt", "HÂng Qu©n L˝/daoboot", "HÂng Qu©n L÷nh/daopi", "HÂng Qu©n ßπo Bµo/daocoat", "HÒy b·/no")
    elseif (nPlayerType == 2) then
        Say(13533, 6, "Kh∏ng Long TrÙ/yitou", "Kh∏ng Long Y™u ß∏i/yibelt", "Kh∏ng Long Ngoa/yiboot", "Kh∏ng Long K’t/yipi", "Kh∏ng Long HÈ Gi∏p/yicoat", "HÒy b·/no")
    end
end;
function jiatou()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 7, 3, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Kh´i")
        TopMessage(13554)
    end
    CloseDialog()
end
function daotou()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 7, 4, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n Qu∏n")
        TopMessage(13555)
    end
    CloseDialog()
end

function yitou()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 7, 5, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long TrÙ")
        TopMessage(13556)
    end
    CloseDialog()
end

function jiacoat()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 2, 3, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Hoµng Kim Ch n Æ∏n gi∏p")
        TopMessage(13557)
    end
    CloseDialog()
end
function daocoat()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 2, 4, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n ßπo Bµo")
        TopMessage(13558)
    end
    CloseDialog()
end

function yicoat()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 2, 5, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long HÈ Gi∏p")
        TopMessage(13559)
    end
    CloseDialog()
end

function jiaboot()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 5, 3, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Chi’n Ngoa")
        TopMessage(13560)
    end
    CloseDialog()
end
function daoboot()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 5, 4, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n L˝")
        TopMessage(13561)
    end
    CloseDialog()
end
function yiboot()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 5, 5, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long Ngoa")
        TopMessage(13562)
    end
    CloseDialog()
end

function jiabelt()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 6, 3, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Y™u ß∏i")
        TopMessage(13563)
    end
    CloseDialog()
end

function daobelt()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 6, 4, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n C©n")
        TopMessage(13564)
    end
    CloseDialog()
end
function yibelt()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 6, 5, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long Y™u ß∏i")
        TopMessage(13565)
    end
    CloseDialog()
end
function jiapi()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 9, 3, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Ch n Æ∏n Phi phong")
        TopMessage(13566)
    end
    CloseDialog()
end
function daopi()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 9, 4, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n L÷nh")
        TopMessage(13567)
    end
    CloseDialog()
end
function yipi()
    if (HaveNormalItem(6, 1, 325, 0) >= 1) then
        DelNormalItem(6, 1, 325, 0)
        AddNormalItem(0, 9, 5, 10, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long k’t")
        TopMessage(13568)
    end
    CloseDialog()
end

function no()
    CloseDialog()
end;
