function main(itemID)

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 2 « trèng.")
        return
    end

    if (DelNormalItem(6, 1, 1442, 1) > 0) then
        AddNormalItemBind(8, 283, 2, 0, 0, 0, 1)
        AddNormalItemBind(8, 191, 2, 0, 0, 0, 1)
        Msg2Player("Ngµi më LÔ bao Vò khİ Tinh Nguyªn (cao), nhËn ®­îc Vò khİ Tinh Nguyªn (cao), TrÇm §iÖn.")
        WriteLog("[LÔ bao Vò khİ Tinh Nguyªn (cao)][¿ªÆôºó»ñµÃVò khİ Tinh Nguyªn (cao), TrÇm §iÖn.]")
    else
        Talk(1, "no", "Më lÔ bao thÊt b¹i.")
        WriteLog("[LÔ bao Vò khİ Tinh Nguyªn (cao)][´ò¿ªÊ§°Ü]")
    end


end
function no()
    CloseDialog()
end
