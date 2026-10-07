function main(leve, t, npcidx, id)
    no()
    if (IsHaveSpaceForTreasure(5) < 1) then
        Talk(1, "no", "ÄúÐèÒªÔ¤Áô 4 c¸i ¿ÕÓà±³°ü,¼´¿É¿ªÆôÀñ°ü")
        Msg2Player("ÄúÐèÒªÔ¤Áô 4 c¸i ¿ÕÓà±³°ü,¼´¿É¿ªÆôÀñ°ü")
        return 0
    end

    if (DelItemByID(id) == 0) then
        return 0
    end

    AddNormalItemBind(8, 1697, 2, 0, 0, 0, 1)
    AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
    AddNormalItemBind(8, 133, 2, 0, 0, 0, 1)

    Msg2Player("Më ¸Ð¶÷Ð¡Àñ°ü: ¿É»ñµÃ°ó¶¨µÄThu Cao KhÝ S¶ng-Thu ý ChÝnh Nïng Trang* 1 (7 ngµy), T­íng Qu©n LÖnh*1, Di Ngo¹i Phï*1, ThÇn C©u Phï*1.")
    WriteLog("[¸Ð¶÷Ð¡Àñ°ü]ÇïÒâÕýÅ¨×°°ó¶¨°æ")
end
function no()
    CloseDialog()
end
