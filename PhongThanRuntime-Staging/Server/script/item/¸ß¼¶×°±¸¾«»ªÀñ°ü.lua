function main(itemID)

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("Hµnh trang kh´ng c„ ÆÒ 2 ´ trËng.")
        return
    end

    if (DelNormalItem(6, 1, 1443, 1) > 0) then
        AddNormalItemBind(8, 373, 2, 0, 0, 0, 1)
        AddNormalItemBind(8, 191, 2, 0, 0, 0, 1)
        Msg2Player("Ngµi mÎ L‘ bao Trang bﬁ Tinh Hoa (cao), nhÀn Æ≠Óc Trang bﬁ Tinh Hoa (cao), Tr«m ßi÷n.")
        WriteLog("[L‘ bao Trang bﬁ Tinh Hoa (cao)][ø™∆Ù∫ÛªÒµ√Trang bﬁ Tinh Hoa (cao), Tr«m ßi÷n.]")
    else
        Talk(1, "no", "MÎ l‘ bao th t bπi.")
        WriteLog("[L‘ bao Trang bﬁ Tinh Hoa (cao)][¥Úø™ ß∞‹]")
    end


end
function no()
    CloseDialog()
end
