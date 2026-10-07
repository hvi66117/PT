function main()
    if (GetPlayerType() == 0) then
        Say(13513, 6, "Ch n ßan Kh´i/tou", "Ch n ßan Y™u ß∏i/yao", "Hoµng Kim Ch n ßan Gi∏p/yifu", "Ch n ßan Phi Phong/pijian", "Ch n ßan Chi’n Ngoa/xie", "HÒy b·/no")
    elseif (GetPlayerType() == 1) then
        Say(13513, 6, "HÂng Qu©n Qu∏n/tou", "HÂng Qu©n C©n/yao", "HÂng Qu©n ßπo Bµo/yifu", "HÂng Qu©n L÷nh/pijian", "HÂng Qu©n L˝/xie", "HÒy b·/no")
    else
        Say(13513, 6, "Kh∏ng Long TrÙ/tou", "Kh∏ng Long Y™u ß∏i/yao", "Kh∏ng Long HÈ Gi∏p/yifu", "Kh∏ng Long K’t/pijian", "Kh∏ng Long Hµi/xie", "HÒy b·/no")
    end
end;

function tou()
    if (HaveNormalItem(6, 1, 301, 0) >= 1) then
        DelNormalItem(6, 1, 301, 0)
        if (GetPlayerType() == 0) then
            AddNormalItem(0, 7, 9, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Kh´i")
            TopMessage(13516)
        elseif (GetPlayerType() == 1) then
            AddNormalItem(0, 7, 10, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n Qu∏n")
            TopMessage(13517)
        else
            AddNormalItem(0, 7, 11, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long TrÙ")
            TopMessage(13518)
        end
    end
    CloseDialog()
end

function yao()
    if (HaveNormalItem(6, 1, 301, 0) >= 1) then
        DelNormalItem(6, 1, 301, 0)
        if (GetPlayerType() == 0) then
            AddNormalItem(0, 6, 9, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Y™u ß∏i")
            TopMessage(13519)
        elseif (GetPlayerType() == 1) then
            AddNormalItem(0, 6, 10, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n C©n")
            TopMessage(13520)
        else
            AddNormalItem(0, 6, 11, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long Y™u ß∏i")
            TopMessage(13521)
        end
    end
    CloseDialog()
end

function xie()
    if (HaveNormalItem(6, 1, 301, 0) >= 1) then
        DelNormalItem(6, 1, 301, 0)
        if (GetPlayerType() == 0) then
            AddNormalItem(0, 5, 9, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Ch n ß∏n Chi’n Ngoa")
            TopMessage(13522)
        elseif (GetPlayerType() == 1) then
            AddNormalItem(0, 5, 10, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n L˝")
            TopMessage(13523)
        else
            AddNormalItem(0, 5, 11, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long Ngoa")
            TopMessage(13524)
        end
    end ;
    CloseDialog()
end

function pijian()
    if (HaveNormalItem(6, 1, 301, 0) >= 1) then
        DelNormalItem(6, 1, 301, 0)
        if (GetPlayerType() == 0) then
            AddNormalItem(0, 9, 9, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Ch n Æ∏n Phi phong")
            TopMessage(13525)
        elseif (GetPlayerType() == 1) then
            AddNormalItem(0, 9, 10, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n L÷nh")
            TopMessage(13526)
        else
            AddNormalItem(0, 9, 11, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long k’t")
            TopMessage(13527)
        end
    end ;
    CloseDialog()
end

function yifu()
    if (HaveNormalItem(6, 1, 301, 0) >= 1) then
        DelNormalItem(6, 1, 301, 0)
        if (GetPlayerType() == 0) then
            AddNormalItem(0, 2, 9, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Hoµng Kim Ch n Æ∏n gi∏p")
            TopMessage(13528)
        elseif (GetPlayerType() == 1) then
            AddNormalItem(0, 2, 10, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc HÂng Qu©n ßπo Bµo")
            TopMessage(13529)
        else
            AddNormalItem(0, 2, 11, 10, 0, 0)
            Msg2Player("Bπn nhÀn Æ≠Óc Kh∏ng Long HÈ Gi∏p")
            TopMessage(13530)
        end
    end ;
    CloseDialog()
end

function no()
    CloseDialog()
end;
