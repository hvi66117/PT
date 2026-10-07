function main(itemID)

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("ƒ˙–Ë“™‘§¡Ù2∏Ò“‘…œ±≥∞¸.")
        return
    end
    if (DelNormalItem(6, 1, 1441, 1) > 0) then
        AddNormalItemBind(8, 372, 2, 0, 0, 0, 1)
        AddNormalItemBind(8, 191, 2, 0, 0, 0, 1)
        Msg2Player("Ngµi mÎ L‘ bao VÚ kh› Tinh Hoa (cao), nhÀn Æ≠Óc VÚ kh› Tinh Hoa (cao), Tr«m ßi÷n.")
        WriteLog("[L‘ bao VÚ kh› Tinh Hoa (cao)][ø™∆Ù∫ÛªÒµ√VÚ kh› Tinh Hoa (cao), Tr«m ßi÷n.]")
    else
        Talk(1, "no", "MÎ l‘ bao th t bπi.")
        WriteLog("[L‘ bao VÚ kh› Tinh Hoa (cao)][¥Úø™ ß∞‹]")
    end

end
function no()
    CloseDialog()
end
